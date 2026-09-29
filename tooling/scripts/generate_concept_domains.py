#!/usr/bin/env python3
"""Generate the concept domains CodeSystem for the V2.9.1 vocabulary IG.

Chapter 2C gives every code table a Concept Domain block. Most of those domains
are already published by THO in `CodeSystem/conceptdomains`; a substantial
minority are not. This script produces a single CodeSystem that carries both.

Approach (chosen 2026-08-18): EXTEND the THO CodeSystem rather than replace or
subset it. The output keeps THO's canonical URL, so it must be a superset of
THO's content -- shipping fewer concepts at the same canonical URL would
destructively redefine a code system we do not own. Concretely:

  * Every THO concept is carried through unchanged, with its hierarchy,
    definition and properties intact.
  * Concept domains that appear in Chapter 2C but not in THO are appended as
    new top-level concepts, marked `source: v2` -- which is THO's own
    convention for v2-derived domains, and accurate here.
  * Where Chapter 2C and THO describe the same domain differently, THO's
    definition is kept and the difference is RECORDED rather than silently
    resolved.
  * The major version is incremented (3.0.0 -> 4.0.0), because adding concepts
    changes the code system.

Nothing is normalized quietly. Every place the output differs from what
Chapter 2C literally says is written to the divergence report, because the
governing requirement for this IG is fidelity to the published chapter.

Outputs:
    v291-fhir/CodeSystem-conceptdomains.json     the resource
    v291-fhir/conceptdomains-divergences.json    everything to review

Usage:
    python3 tooling/scripts/generate_concept_domains.py
    python3 tooling/scripts/generate_concept_domains.py --dry-run
"""

import argparse
import copy
import datetime
import glob
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from vocabulary_text_policy import apply_text_policy  # noqa: E402
from tho_merge import is_editorial  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
THO_SNAPSHOT_DIR = PROJECT_ROOT / "tho-r5"
THO_CONCEPT_DOMAINS = THO_SNAPSHOT_DIR / "CodeSystem-conceptdomains.json"
OUTPUT_DIR = PROJECT_ROOT / "v291-fhir"
RESOURCE_PATH = OUTPUT_DIR / "CodeSystem-conceptdomains.json"
DIVERGENCES_PATH = OUTPUT_DIR / "conceptdomains-divergences.json"

# A concept code that a reader would consider a plain token. Codes outside this
# shape are still emitted verbatim -- fidelity wins -- but they are reported.
CLEAN_CODE_RE = re.compile(r"[A-Za-z0-9\-\.]+")


def load_tho():
    """Load THO's concept domains CodeSystem and index its concepts by code."""
    resource = json.loads(THO_CONCEPT_DOMAINS.read_text())
    index = {}

    def walk(concepts, parent=None):
        for concept in concepts:
            index[concept["code"]] = {"concept": concept, "parent": parent}
            walk(concept.get("concept", []), concept["code"])

    walk(resource.get("concept", []))
    return resource, index


def squish_spaces(symbolic_name):
    """Remove internal whitespace from a concept domain symbolic name.

    THO's own concept codes carry no spaces, and the IG Publisher drops spaces
    when it builds a page anchor, so a spaced code is unreachable by link and
    inconsistent with every neighbouring concept. Conforming is the right call
    for now.

    It is worth recording that THO's rendering of these codes elides the spaces
    rather than preserving them for display -- which it arguably did not need
    to do, and which makes the codes harder to read
    (`JobSupervisoryLevelorPayGrade`). Conforming to the pattern is a decision
    to match THO, not an endorsement of it. See
    `v291-extracted/vocabulary-future-corrections.md`.
    """
    return re.sub(r"\s+", "", symbolic_name)


def load_chapter_domains():
    """Collect the concept domains declared in Chapter 2C.

    Returns a dict keyed by symbolic name. A domain can be declared by more
    than one table -- `VolumeUnits` is used by 0568, 0777 and 0930 -- so every
    declaring table is kept, in table order.
    """
    domains = defaultdict(lambda: {"tables": [], "descriptions": []})
    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        block = record.get("conceptDomain") or {}
        symbolic_name = squish_spaces((block.get("SymbolicName") or "").strip())
        if not symbolic_name:
            continue
        entry = domains[symbolic_name]
        entry["tables"].append({
            "tableNumber": record.get("tableNumber", path.stem),
            "tableName": record.get("tableName", ""),
            "conceptDomainOnly": block.get("Concept Domain Only", ""),
            "domainName": block.get("Concept Domain Name", ""),
            "hasCodes": bool(record.get("codedContent")),
        })
        description = (block.get("Description") or "").strip()
        if description not in entry["descriptions"]:
            entry["descriptions"].append(description)
    return dict(domains)


def next_major_version(version):
    """Increment the major version, resetting minor and patch to zero.

    Adding concepts is a change to the code system, so "3.0.0" becomes "4.0.0".
    A version that is not in major.minor.patch form is returned unchanged --
    guessing at an unfamiliar scheme would be worse than leaving it alone.
    """
    match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", version or "")
    if not match:
        return version
    return f"{int(match.group(1)) + 1}.0.0"


def normalize_for_match(text):
    """Reduce a symbolic name to letters and digits, for near-match detection."""
    return re.sub(r"[^a-z0-9]", "", text.lower())


def normalize_prose(text):
    """Reduce prose to a form in which two descriptions can be compared fairly.

    Two adjustments, both applied to BOTH sides of any comparison:

    Whitespace is folded, so spacing differences are not reported as editorial
    differences.

    The shared text policy is applied. The Chapter 2C corpus already has it
    baked in -- the extractor applies it -- and THO's text does not, so
    comparing raw would report our own normalization as a disagreement between
    the two bodies. Six concept domains differed from THO by nothing but a
    comma this rule had inserted on our side.

    This affects comparison only. Whatever text is emitted is emitted
    unchanged.
    """
    normalized, _ = apply_text_policy("Description", text or "")
    return re.sub(r"\s+", " ", normalized).strip()


# THO's narrative links to sibling code systems as bare page filenames, which
# only resolve inside THO's own published site. Read anywhere else -- and this
# IG is anywhere else -- they dangle. Rewrite them to the canonical URL, which
# the HL7 proxy redirects to the rendered page.
NARRATIVE_PAGE_HREF_RE = re.compile(r'href="(CodeSystem-([A-Za-z0-9\-\.]+)\.html)"')
THO_CODE_SYSTEM_CANONICAL = "http://terminology.hl7.org/CodeSystem/"


def absolutize_narrative_links(resource):
    """Rewrite THO's site-relative narrative hrefs to canonical URLs.

    Each ``CodeSystem-<id>.html`` href becomes
    ``http://terminology.hl7.org/CodeSystem/<id>``. A target is only rewritten
    when the THO snapshot actually carries a code system with that id and that
    canonical, so the rewrite never invents a URL.

    Narrative is not compared by the merge and takes no part in versioning, so
    this changes no artifact version.

    Returns:
        A ``(rewritten, skipped)`` pair. ``rewritten`` maps each href that was
        replaced to its count; ``skipped`` maps each href left alone to its
        count, for reporting.
    """
    div = resource.get("text", {}).get("div", "")
    if not div:
        return {}, {}

    rewritten = {}
    skipped = {}

    def canonical_for(code_system_id):
        """The canonical of a THO code system, or None if the snapshot lacks it."""
        snapshot = THO_SNAPSHOT_DIR / f"CodeSystem-{code_system_id}.json"
        if not snapshot.is_file():
            return None
        url = json.loads(snapshot.read_text()).get("url", "")
        expected = THO_CODE_SYSTEM_CANONICAL + code_system_id
        return url if url == expected else None

    def replace(match):
        href, code_system_id = match.group(1), match.group(2)
        canonical = canonical_for(code_system_id)
        if canonical is None:
            skipped[href] = skipped.get(href, 0) + 1
            return match.group(0)
        rewritten[href] = rewritten.get(href, 0) + 1
        return f'href="{canonical}"'

    resource["text"]["div"] = NARRATIVE_PAGE_HREF_RE.sub(replace, div)
    return rewritten, skipped


def build(tho_resource, tho_index, chapter_domains):
    """Build the extended CodeSystem and the list of divergences.

    Returns:
        A ``(resource, divergences)`` pair.
    """
    divergences = []

    def record(kind, symbolic_name, detail, chapter_value=None, tho_value=None, tables=None):
        entry = {"kind": kind, "conceptDomain": symbolic_name, "detail": detail}
        if chapter_value is not None:
            entry["chapter2C"] = chapter_value
        if tho_value is not None:
            entry["tho"] = tho_value
        if tables:
            entry["tables"] = tables
        divergences.append(entry)

    # Near-match index, so a Chapter 2C name that differs from THO's only by
    # punctuation or spacing is recognised as the same domain rather than
    # added a second time under a slightly different code.
    tho_by_normalized = defaultdict(list)
    for code in tho_index:
        tho_by_normalized[normalize_for_match(code)].append(code)

    resource = copy.deepcopy(tho_resource)

    rewritten_links, skipped_links = absolutize_narrative_links(resource)
    for href, count in sorted(rewritten_links.items()):
        record("inherited_narrative_link_absolutized", href,
               f"THO's narrative linked to the page {href}, which resolves only "
               f"inside THO's own site. Rewritten to the canonical URL in "
               f"{count} place(s). Narrative takes no part in versioning.")
    for href, count in sorted(skipped_links.items()):
        record("inherited_narrative_link_unresolved", href,
               f"THO's narrative links to the page {href} in {count} place(s), "
               f"and the THO snapshot carries no code system with that id. Left "
               f"as published; it will not resolve outside THO's site.")

    # Adding concepts changes the code system, so the major version increments
    # and minor and patch reset -- standard terminology versioning practice.
    inherited_version = resource.get("version", "")
    resource["version"] = next_major_version(inherited_version)

    additions = []

    for symbolic_name in sorted(chapter_domains):
        entry = chapter_domains[symbolic_name]
        tables = [t["tableNumber"] for t in entry["tables"]]
        description = entry["descriptions"][0] if entry["descriptions"] else ""

        if len(entry["tables"]) > 1:
            record("domain_declared_by_multiple_tables", symbolic_name,
                   "One concept domain is declared by several code tables, so the "
                   "table-to-domain relationship is not one to one.",
                   tables=tables)
        if len(entry["descriptions"]) > 1:
            record("conflicting_descriptions_within_chapter", symbolic_name,
                   "The tables declaring this domain describe it differently. "
                   "The first was used.",
                   chapter_value=entry["descriptions"], tables=tables)
        if not CLEAN_CODE_RE.fullmatch(symbolic_name):
            record("symbolic_name_is_not_a_plain_token", symbolic_name,
                   "Used verbatim as the concept code. Contains characters "
                   "unusual in a code, such as spaces, slashes or punctuation.",
                   chapter_value=symbolic_name, tables=tables)

        if symbolic_name in tho_index:
            tho_concept = tho_index[symbolic_name]["concept"]
            tho_definition = tho_concept.get("definition", "")
            if normalize_prose(description) != normalize_prose(tho_definition):
                # Same words in the same order means only punctuation or
                # markup moved, and no reader learns anything different from
                # one than from the other. Reporting that as the two bodies
                # describing the domain differently sends a committee to
                # adjudicate a full stop: THO's `Confidentiality` differs from
                # the chapter's by nothing but `*Usage Note:*` emphasis and a
                # trailing period. `is_editorial` is the same test the THO
                # merge applies, so the two agree on what counts as a real
                # difference.
                kind = ("definition_differs_from_tho_editorially"
                        if is_editorial(description, tho_definition)
                        else "definition_differs_from_tho")
                detail = ("Chapter 2C and THO describe the same domain "
                          "differently. THO's definition was kept.")
                if kind.endswith("_editorially"):
                    detail = ("Chapter 2C and THO use the same words in the "
                              "same order; only punctuation or markup "
                              "differs. THO's definition was kept. Not a "
                              "disagreement about what the domain means.")
                record(kind, symbolic_name, detail,
                       chapter_value=description, tho_value=tho_definition,
                       tables=tables)
            continue

        near = [c for c in tho_by_normalized.get(normalize_for_match(symbolic_name), [])]
        if near:
            record("symbolic_name_near_match_in_tho", symbolic_name,
                   f"Treated as the existing THO concept {near[0]!r}; the Chapter 2C "
                   "spelling looks like a typo. No new concept was added.",
                   chapter_value=symbolic_name, tho_value=near[0], tables=tables)
            continue

        concept = {
            "code": symbolic_name,
            "display": symbolic_name,
            "property": [{"code": "source", "valueCode": "v2"}],
        }
        if description:
            concept["definition"] = description
        additions.append(concept)
        record("added_from_chapter_2c", symbolic_name,
               "Declared in Chapter 2C, absent from THO. Added as a new concept.",
               chapter_value=description, tables=tables)

    resource.setdefault("concept", []).extend(additions)

    # THO v2-sourced domains that Chapter 2C does not declare. Not a defect --
    # THO covers more than one chapter's worth of history -- but worth seeing.
    chapter_names = set(chapter_domains)
    for code, info in sorted(tho_index.items()):
        sources = [p.get("valueCode") for p in info["concept"].get("property", [])
                   if p.get("code") == "source"]
        if "v2" in sources and code not in chapter_names:
            record("tho_v2_domain_absent_from_chapter_2c", code,
                   "THO marks this domain as v2-sourced but no Chapter 2C table "
                   "declares it. Retained unchanged.")

    # Things inherited from the THO resource that will matter when this is
    # published. Recorded rather than quietly patched -- editing content we did
    # not author is exactly the kind of silent change this project avoids.
    declared_properties = {p["code"] for p in resource.get("property", [])}
    used_properties = set()

    def collect_properties(concepts):
        for concept in concepts:
            for prop in concept.get("property", []):
                used_properties.add(prop["code"])
            collect_properties(concept.get("concept", []))

    collect_properties(resource.get("concept", []))
    for undeclared in sorted(used_properties - declared_properties):
        record("inherited_undeclared_property", undeclared,
               "A concept property used by THO's own content but not declared in "
               "its CodeSystem.property list. Left as-is; may draw a validator "
               "warning when published.")

    return resource, divergences, additions


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--dry-run", action="store_true",
                        help="Report what would be produced without writing files")
    args = parser.parse_args()

    tho_resource, tho_index = load_tho()
    chapter_domains = load_chapter_domains()
    resource, divergences, additions = build(tho_resource, tho_index, chapter_domains)

    def total(concepts):
        return sum(1 + total(c.get("concept", [])) for c in concepts)

    by_kind = defaultdict(int)
    for entry in divergences:
        by_kind[entry["kind"]] += 1

    print(f"THO concept domains in            : {total(tho_resource.get('concept', []))}")
    print(f"Chapter 2C distinct domains       : {len(chapter_domains)}")
    print(f"Added from Chapter 2C             : {len(additions)}")
    print(f"Concept domains out               : {total(resource.get('concept', []))}")
    print("\nDivergences to review:")
    for kind, count in sorted(by_kind.items(), key=lambda kv: -kv[1]):
        print(f"  {count:5d}  {kind}")

    if args.dry_run:
        print("\n(dry run — nothing written)")
        return 0

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    RESOURCE_PATH.write_text(json.dumps(resource, indent=2, ensure_ascii=False) + "\n")
    DIVERGENCES_PATH.write_text(json.dumps({
        "generated": datetime.date.today().isoformat(),
        "basedOn": {
            "package": "hl7.terminology.r5",
            "resource": "CodeSystem/conceptdomains",
            "version": tho_resource.get("version"),
        },
        "published": {
            "version": resource.get("version"),
        },
        "counts": dict(by_kind),
        "divergences": divergences,
    }, indent=2, ensure_ascii=False) + "\n")

    print(f"\nResource:    {RESOURCE_PATH}")
    print(f"Divergences: {DIVERGENCES_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
