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
from collections import defaultdict
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
THO_CONCEPT_DOMAINS = PROJECT_ROOT / "tho-r5" / "CodeSystem-conceptdomains.json"
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
        symbolic_name = (block.get("SymbolicName") or "").strip()
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
    """Collapse whitespace so prose can be compared without spacing noise."""
    return re.sub(r"\s+", " ", text or "").strip()


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
                record("definition_differs_from_tho", symbolic_name,
                       "Chapter 2C and THO describe the same domain differently. "
                       "THO's definition was kept.",
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
