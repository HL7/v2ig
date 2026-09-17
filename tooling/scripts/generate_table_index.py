#!/usr/bin/env python3
"""Generate the Chapter 2C table index page for the vocabulary IG.

One row per V2 code table, keyed by table number, resolving each table to the
artifacts that represent it.

Link resolution follows one rule, in precedence order:

1. If this guide authors an artifact for the table, the link resolves **into
   this guide**, even though the text shown is the THO canonical URL. A
   reviewer clicking a canonical should land on the draft under review.
2. If this guide authors nothing, the link resolves to **THO**, provided the
   local THO snapshot says the artifact exists there.
3. If neither has it, the canonical is shown as plain text and is not a link.

The visible text is always the canonical URL; a short marker after each link
says where it actually goes, so the destination is never a surprise.

Shading marks the exceptions only. The norm -- an artifact in both this guide
and THO -- is the overwhelming majority and is left unshaded. Every shaded row
also carries the reason in its Notes column, so the page still reads correctly
if the stylesheet is stripped.

Sources joined, all on table number:

    v291-extracted/vocabulary-index.json   table name, type, steward, OIDs,
                                           concept domain name
    v291-fhir/utg-write-report.json        route, what was written, resolved
                                           system URL
    v291-fhir/utg/**/*.xml                 the authored canonical URLs and
                                           resource ids -- read from the
                                           resources themselves, never
                                           constructed from the table number
                                           (three value sets sit at
                                           `v2-notAllCodes-NNNN` canonicals)
    v291-fhir/CodeSystem-conceptdomains.json   which domain concepts exist
    tho-r5/                                a local THO R5 snapshot: whether THO
                                           already carries each canonical

Usage:
    python3 tooling/scripts/generate_table_index.py
    python3 tooling/scripts/generate_table_index.py --check   # report, write nothing
"""

import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_INDEX = PROJECT_ROOT / "v291-extracted" / "vocabulary-index.json"
WRITE_REPORT = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
AUTHORED_ROOT = PROJECT_ROOT / "v291-fhir" / "utg"
CONCEPT_DOMAINS = PROJECT_ROOT / "v291-fhir" / "CodeSystem-conceptdomains.json"
THO_SNAPSHOT = PROJECT_ROOT / "tho-r5"
OUTPUT_PAGE = PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent" / "table-index.md"

THO_SITE = "http://terminology.hl7.org"

# Every artifact link opens in a new tab: this page is a place you come back
# to, and following a link should not cost you your position in 799 rows.
# `rel="noopener"` because some of these leave for terminology.hl7.org.
NEW_TAB = 'target="_blank" rel="noopener"'

# Short label for each route the writer assigns.
ROUTE_LABEL = {
    "code-system-and-value-set": "CS + VS",
    "concept-domain-only": "Domain only",
    "value-set-only": "VS only",
    "needs-decision": "Needs decision",
    "nothing-to-write": "Nothing",
}

# What each route is expected to look like once loaded into THO. A row is an
# exception -- and gets shaded -- only when it departs from its own route's
# norm. `None` means "not constrained": a value-set-only table's code system
# belongs to another authority, so its presence in THO says nothing.
ROUTE_NORM = {
    "code-system-and-value-set": ("both", "both"),
    "concept-domain-only": ("neither", "neither"),
    "value-set-only": (None, "both"),
    "needs-decision": ("neither", "neither"),
    "nothing-to-write": ("neither", "neither"),
}

PRESENCE = {(1, 1): "both", (1, 0): "ig-only", (0, 1): "tho-only", (0, 0): "neither"}

# Concept domain codes that are misspellings rather than names. Listed by hand
# because a spell checker cannot tell a typo from a term of art. Kept to codes
# reached from a V2 table: a misspelling elsewhere in `conceptdomains` may be a
# deliberate, documented synonym from v3 or CDA and is not this project's to
# raise. `SiteAdminstered` is settled by its own entry -- v2-tables displays
# the same table as "SITE ADMINISTERED".
KNOWN_MISSPELLINGS = {"SiteAdminstered"}

# Inline background colours, applied per row. Kept light enough that the text
# contrast stays well above WCAG AA on both.
SHADE = {
    "new-to-tho": "#fff4e0",
    "tho-only": "#eaf1fb",
    "tho-dangling": "#fdecec",
    "unresolved": "#f1e9fa",
}
SHADE_LABEL = {
    "new-to-tho": "New to THO",
    "tho-only": "In THO, not here",
    "tho-dangling": "Dangling in THO",
    "unresolved": "Nothing anywhere — open question",
}

# THO's own table index. Its `vocab-domain` property is the authority on which
# concept domain a table names, and it is a useful second opinion on the
# chapter: 628 tables, 624 of them carrying a domain.
THO_V2_TABLES = THO_SNAPSHOT / "CodeSystem-v2-tables.json"
THO_CONCEPT_DOMAINS = THO_SNAPSHOT / "CodeSystem-conceptdomains.json"
THO_PACKAGE = THO_SNAPSHOT / "ImplementationGuide-hl7.terminology.json"


def _walk(concepts):
    """Yield every concept in a CodeSystem hierarchy, at any depth."""
    for concept in concepts or []:
        yield concept
        for nested in _walk(concept.get("concept")):
            yield nested


def load_tho_snapshot(root=THO_SNAPSHOT):
    """Return THO's CodeSystems and ValueSets from the local snapshot.

    Each is a dict of canonical URL -> the parsed resource. The snapshot is
    what makes "does THO already carry this?" an answerable question offline
    rather than a guess.
    """
    code_systems, value_sets = {}, {}
    for path in sorted(root.glob("*.json")):
        try:
            resource = json.loads(path.read_text(encoding="utf-8"))
        except (ValueError, UnicodeDecodeError):
            continue
        url = resource.get("url")
        if not url:
            continue
        if resource.get("resourceType") == "CodeSystem":
            code_systems[url] = resource
        elif resource.get("resourceType") == "ValueSet":
            value_sets[url] = resource
    return code_systems, value_sets


def load_authored(root=AUTHORED_ROOT):
    """Return the canonical URL and resource id of every resource we author.

    Keyed by the path the write report names (`codeSystems/cs-v2-0001.xml`), so
    the join runs off the report rather than off a guessed file name. The URL
    is read from the resource, never rebuilt from the table number -- three
    value sets are authored at `v2-notAllCodes-NNNN` canonicals and any
    constructed URL misses them.
    """
    authored = {}
    for path in sorted(root.rglob("*.xml")):
        head = path.read_text(encoding="utf-8")[:4000]
        url = re.search(r'<url value="([^"]+)"', head)
        ident = re.search(r'<id value="([^"]+)"', head)
        if not (url and ident):
            continue
        kind = "CodeSystem" if "<CodeSystem" in head else "ValueSet" if "<ValueSet" in head else None
        if not kind:
            continue
        key = f"{path.parent.name}/{path.name}"
        authored[key] = {"url": url.group(1), "id": ident.group(1), "kind": kind}
    return authored


def load_concept_domain_codes(path=CONCEPT_DOMAINS):
    """Return the set of concept codes in the guide's conceptdomains resource."""
    resource = json.loads(path.read_text(encoding="utf-8"))
    return {concept["code"] for concept in _walk(resource.get("concept"))}


def squish_spaces(name):
    """Remove internal whitespace, matching `generate_concept_domains.py`.

    The chapter writes four symbolic names with spaces; the concept codes do
    not carry them. Without this the index would look up `Masterfile Action
    Code`, find nothing, and render 0180's domain as dead text.
    """
    return re.sub(r"\s+", "", name or "")


def load_v2_tables(path=THO_V2_TABLES):
    """Return THO's v2-tables index as {table number: {property: value}}."""
    if not path.is_file():
        return {}
    resource = json.loads(path.read_text(encoding="utf-8"))
    tables = {}
    for concept in resource.get("concept", []):
        values = {}
        for prop in concept.get("property", []):
            values[prop["code"]] = prop.get("valueString") or prop.get("valueCode")
        values["_display"] = concept.get("display", "")
        tables[concept["code"]] = values
    return tables


def snapshot_provenance():
    """Describe the THO snapshot every "in THO" claim on this page is checked against.

    Stated once, in the page prose, rather than on each of 799 rows. Three
    different version numbers are in play and conflating them would mislead:
    the package `hl7.terminology.r5` is at 7.3.0, the `conceptdomains`
    resource inside it is at 3.0.0, and `v2-tables` is at 7.0.0. Resource
    versions move independently of the package.

    Artifact versions are not release versions: `conceptdomains` increments
    from THO's 3.0.0 to 4.0.0 because this guide changes that artifact, which
    is independent of which THO release would carry it. No row cites a version
    for an individual concept.
    """
    def version(path, default="?"):
        if not path.is_file():
            return default
        return json.loads(path.read_text(encoding="utf-8")).get("version", default)
    return {
        "package": version(THO_PACKAGE),
        "conceptdomains": version(THO_CONCEPT_DOMAINS),
        "v2tables": version(THO_V2_TABLES),
    }


def load_tho_concept_domain_codes(path=THO_CONCEPT_DOMAINS):
    """Return the concept codes THO's published conceptdomains already carries.

    Used to tell a domain this guide adds from one THO has had all along --
    both resolve into this guide, because this guide republishes the whole
    code system, but only one of them is new.
    """
    if not path.is_file():
        return set()
    resource = json.loads(path.read_text(encoding="utf-8"))
    return {concept["code"] for concept in _walk(resource.get("concept"))}


def dangling_systems(value_set, tho_code_systems):
    """Return the THO-canonical systems a ValueSet composes from that THO lacks.

    A ValueSet published at terminology.hl7.org that draws from a
    terminology.hl7.org CodeSystem which does not exist there cannot expand.
    That is a defect in THO today, independent of this project, and it is worth
    surfacing because the table index is the first place the two corpora are
    put side by side.
    """
    missing = []
    for include in (value_set.get("compose") or {}).get("include", []):
        system = include.get("system")
        if not system or not system.startswith(THO_SITE):
            continue
        if system not in tho_code_systems:
            missing.append(system)
    return missing


def build_rows():
    """Join the five sources into one record per table, in table-number order."""
    index = {t["tableNumber"]: t for t in json.loads(VOCAB_INDEX.read_text(encoding="utf-8"))["tables"]}
    report = json.loads(WRITE_REPORT.read_text(encoding="utf-8"))["tables"]
    authored = load_authored()
    domain_codes = load_concept_domain_codes()
    tho_code_systems, tho_value_sets = load_tho_snapshot()
    v2_tables = load_v2_tables()
    tho_domain_codes = load_tho_concept_domain_codes()

    rows = []
    for record in report:
        number = record["table"]
        meta = index.get(number, {})
        route = record["action"]

        ours = {"CodeSystem": None, "ValueSet": None}
        for written in record.get("written", []):
            resource = authored.get(written)
            if resource:
                ours[resource["kind"]] = resource

        # A canonical is needed even where nothing is authored, so that rule 2
        # has something to look up in THO. Where we had to invent it, that is
        # recorded: an invented canonical that turns out to exist nowhere is
        # not a fact about the table and must not be shown as one.
        cs_given = (ours["CodeSystem"] or {}).get("url") or record.get("systemUrl")
        cs_canonical = cs_given or f"{THO_SITE}/CodeSystem/v2-{number}"
        vs_given = (ours["ValueSet"] or {}).get("url")
        vs_canonical = vs_given or f"{THO_SITE}/ValueSet/v2-{number}"

        cs_state = PRESENCE[(int(bool(ours["CodeSystem"])), int(cs_canonical in tho_code_systems))]
        vs_state = PRESENCE[(int(bool(ours["ValueSet"])), int(vs_canonical in tho_value_sets))]

        domain = squish_spaces(meta.get("conceptDomainName") or "")
        thos_row = v2_tables.get(number, {})
        rows.append({
            "table": number,
            "name": meta.get("tableName", ""),
            "route": route,
            "tableType": meta.get("tableType", ""),
            "steward": meta.get("steward", ""),
            "codeSystem": {
                "canonical": cs_canonical,
                "constructed": cs_given is None,
                "igId": (ours["CodeSystem"] or {}).get("id"),
                "inTho": cs_canonical in tho_code_systems,
                "state": cs_state,
            },
            "valueSet": {
                "canonical": vs_canonical,
                "constructed": vs_given is None,
                "igId": (ours["ValueSet"] or {}).get("id"),
                "inTho": vs_canonical in tho_value_sets,
                "state": vs_state,
            },
            "conceptDomain": domain if domain in domain_codes else "",
            "conceptDomainDeclared": domain,
            "conceptDomainInTho": domain in tho_domain_codes,
            "thoVocabDomain": thos_row.get("vocab-domain"),
            "inV2Tables": number in v2_tables,
            "reason": record.get("reason", ""),
            "_thoValueSet": tho_value_sets.get(vs_canonical),
            "_thoCodeSystem": tho_code_systems.get(cs_canonical),
            "_thoCodeSystems": tho_code_systems,
        })

    for row in rows:
        classify(row)   # also removes the two private lookup keys
    return rows


def build_orphan_rows():
    """Return the v2-tables entries that Chapter 2C 2.9.1 no longer carries.

    These have no row in the main index because they are not tables of this
    standard any more. They matter anyway: most of them name a concept domain
    that `conceptdomains` does not define, which is a dangling reference inside
    THO and is invisible from either corpus alone.
    """
    in_chapter = {record["table"] for record
                  in json.loads(WRITE_REPORT.read_text(encoding="utf-8"))["tables"]}
    defined = load_concept_domain_codes()
    orphans = []
    for number, values in sorted(load_v2_tables().items()):
        if number in in_chapter:
            continue
        domain = values.get("vocab-domain")
        orphans.append({
            "table": number,
            "display": values.get("_display", ""),
            "type": values.get("v2-table-type", ""),
            "domain": domain,
            "resolves": bool(domain) and domain in defined,
            "misspelled": domain in KNOWN_MISSPELLINGS,
        })
    return orphans


def render_orphans(orphans):
    """Render the orphan table as its own section, shading the unresolved rows."""
    unresolved = [o for o in orphans if o["domain"] and not o["resolves"]]
    parts = [
        "## Tables THO still indexes that Chapter 2C no longer carries",
        "",
        f"THO's `v2-tables` holds **{len(orphans)} entries that are not tables of "
        "V2.9.1 Chapter 2C** and so have no row above. They are listed because of "
        f"what their `vocab-domain` property points at: **{len(unresolved)} of them "
        "name a concept domain that `conceptdomains` does not define.** A reader "
        "following that property finds nothing.",
        "",
        "Only three are typed *no longer used*, so the index does not otherwise "
        "mark them as retired. Registered for TSMG as "
        "`esc-v2tables-domain-gaps`.",
        "",
        '<table class="ti-table">',
        "<thead><tr><th>Table</th><th>Display in v2-tables</th><th>Type</th>"
        "<th>vocab-domain</th><th>Resolves?</th></tr></thead>",
        "<tbody>",
    ]
    for o in orphans:
        style = flag = ""
        if o["misspelled"]:
            style = f' style="background:{SHADE["tho-dangling"]}"'
            flag = ("<strong>Misspelled.</strong> The display is spelled correctly; "
                    "the code is not. Needs deprecation and a corrected replacement "
                    "— see <code>esc-v2tables-siteadministered</code>.")
        elif o["domain"] and not o["resolves"]:
            style = f' style="background:{SHADE["unresolved"]}"'
            flag = "Not a concept in <code>conceptdomains</code>."
        elif not o["domain"]:
            flag = "No concept domain named."
        else:
            flag = "Yes."
        parts.append(
            f'<tr{style}><td><strong>{escape(o["table"])}</strong></td>'
            f'<td>{escape(o["display"])}</td><td>{escape(o["type"])}</td>'
            f'<td>{escape(o["domain"] or "—")}</td><td>{flag}</td></tr>'
        )
    parts += ["</tbody>", "</table>", ""]
    return "\n".join(parts)


def classify(row):
    """Decide whether a row departs from its route's norm, and why.

    Sets `exception` (a shading key, or None) and `notes` (a list of strings).
    The notes carry the same information as the shading, so a reader who never
    sees the colour loses nothing.
    """
    expected_cs, expected_vs = ROUTE_NORM[row["route"]]
    cs, vs = row["codeSystem"]["state"], row["valueSet"]["state"]
    notes, exception = [], None

    departs_on_cs = expected_cs is not None and cs != expected_cs
    departs_on_vs = expected_vs is not None and vs != expected_vs
    # Only the dimension that actually departed from the norm is reported. A
    # value-set-only table's code system belongs to another authority, so THO
    # holding it is expected and must not be flagged.
    departures = []
    if departs_on_cs:
        departures.append(("code system", cs))
    if departs_on_vs:
        departures.append(("value set", vs))

    new_here = [label for label, state in departures if state == "ig-only"]
    only_tho = [label for label, state in departures if state == "tho-only"]
    if new_here:
        exception = "new-to-tho"
        notes.append(f"New to THO — the load would create the {' and '.join(new_here)}.")
    if only_tho:
        exception = exception or "tho-only"
        notes.append(
            f"THO publishes a {' and '.join(only_tho)} at this canonical that this "
            "guide does not author."
        )

    tho_vs = row.pop("_thoValueSet", None)
    tho_cs_one = row.pop("_thoCodeSystem", None)
    tho_cs = row.pop("_thoCodeSystems", {})

    # A THO artifact we are not redrafting may be retired or deprecated, which
    # changes what "THO already has this" means. Say so rather than leaving the
    # reader to open it.
    if only_tho:
        for label, resource in (("code system", tho_cs_one), ("value set", tho_vs)):
            status = (resource or {}).get("status")
            if status and status != "active":
                notes.append(f"THO's {label} is {status}.")
    if tho_vs is not None and not row["valueSet"]["igId"]:
        missing = dangling_systems(tho_vs, tho_cs)
        if missing:
            exception = "tho-dangling"
            notes.append(
                "THO's value set composes from "
                + ", ".join(m.rsplit("/", 1)[-1] for m in missing)
                + ", which THO does not publish — it cannot expand."
            )

    # A table with no concept domain, no artifact here and none in THO has
    # nowhere to land. These are not defects we can name -- they are the rows
    # nobody has decided about, and they should be visible as such.
    nothing_authored = not (row["codeSystem"]["igId"] or row["valueSet"]["igId"])
    nothing_in_tho = not (row["codeSystem"]["inTho"] or row["valueSet"]["inTho"])
    if nothing_authored and nothing_in_tho and not row["conceptDomainDeclared"]:
        exception = "unresolved"
        notes.append(
            "No concept domain, no code system and no value set — here or in "
            "THO. Whether this table should become a concept domain is an open "
            "question."
        )

    theirs = row.get("thoVocabDomain")
    if theirs and row["conceptDomainDeclared"] and theirs != row["conceptDomainDeclared"]:
        notes.append(
            f"THO's v2-tables names the domain {theirs!r} where the chapter "
            f"says {row['conceptDomainDeclared']!r}."
        )

    declared = row["conceptDomainDeclared"]
    if declared and not row["conceptDomain"]:
        notes.append(
            f"The chapter declares concept domain '{declared}', which is not a "
            "concept in this guide's conceptdomains code system."
        )
    elif not declared and row["route"] == "concept-domain-only":
        notes.append("Routed as concept-domain-only, but the chapter names no domain.")

    row["exception"] = exception
    row["notes"] = notes
    return row


def escape(text):
    """Escape the four characters that matter inside HTML table cells."""
    return (str(text).replace("&", "&amp;").replace("<", "&lt;")
            .replace(">", "&gt;").replace('"', "&quot;"))


def render_link(artifact, resource_type):
    """Render one canonical as a cell, following the link precedence rule.

    The text is always the canonical URL. Where it points depends on who has
    the artifact: this guide first, THO second, nowhere third.
    """
    canonical = artifact["canonical"]
    shown = escape(canonical)
    if artifact["igId"]:
        href = f"{resource_type}-{escape(artifact['igId'])}.html"
        return f'<a {NEW_TAB} href="{href}">{shown}</a> <span class="ti-dest">this guide</span>'
    if artifact["inTho"]:
        return f'<a {NEW_TAB} href="{shown}">{shown}</a> <span class="ti-dest ti-tho">THO</span>'
    if artifact.get("constructed"):
        # Nothing authored, nothing in THO, and this URL is one we invented
        # so the THO lookup had a key. It describes no artifact; showing it
        # would invent one.
        return "—"
    return f'<span class="ti-none">{shown}</span> <span class="ti-dest">not published</span>'


def concept_anchor(code):
    """Return the anchor the IG Publisher generates for a concept code.

    The publisher does not use the code verbatim. It drops spaces, keeps
    ASCII alphanumerics along with `-` and `_`, and replaces every other
    character with a dot and the character's decimal code point -- so
    `Active/Inactive` becomes `Active.47Inactive` and `L&I` becomes `L.38I`.

    Derived from the built `CodeSystem-conceptdomains.html` and pinned by a
    test against the real page: 37 of the 759 domains this index links to
    contain `/`, `(`, `)` or an apostrophe, and a verbatim code sends every
    one of them to the top of the page instead of the concept.
    """
    out = []
    for character in code:
        if character == " ":
            continue
        if (character.isalnum() and character.isascii()) or character in "-_":
            out.append(character)
        else:
            out.append(f".{ord(character)}")
    return "".join(out)


def render_domain(row):
    """Render the concept domain cell.

    Every domain link resolves into this guide, and that is correct rather
    than redundant: this guide republishes the whole `conceptdomains` code
    system at THO's canonical, so it holds THO's 1,345 concepts as well as
    the 177 the chapter adds. "This guide" says where the link goes, which
    on its own tells a reader nothing about whether the concept is new.
    The second marker says that: `in THO` for a concept THO already
    publishes, `new in 4.0.0` for one this work adds.
    """
    code = row["conceptDomain"]
    if not code:
        declared = row["conceptDomainDeclared"]
        return f'<span class="ti-none">{escape(declared)}</span>' if declared else "—"
    href = f"CodeSystem-conceptdomains.html#conceptdomains-{escape(concept_anchor(code))}"
    origin = "in THO" if row.get("conceptDomainInTho") else "not in THO"
    return (f'<a {NEW_TAB} href="{href}">{escape(code)}</a> '
            f'<span class="ti-dest">this guide</span> '
            f'<span class="ti-origin">{origin}</span>')


def render_row(row):
    number = escape(row["table"])
    style = ""
    flag = ""
    if row["exception"]:
        style = f' style="background:{SHADE[row["exception"]]}"'
        flag = f'<strong>{escape(SHADE_LABEL[row["exception"]])}.</strong> '
    notes = flag + " ".join(escape(n) for n in row["notes"])
    return (
        f'<tr id="tbl-{number}"{style}>'
        f'<td><a href="#tbl-{number}"><strong>{number}</strong></a></td>'
        f'<td>{escape(row["name"])}</td>'
        f'<td>{escape(ROUTE_LABEL[row["route"]])}</td>'
        f'<td>{render_link(row["codeSystem"], "CodeSystem")}</td>'
        f'<td>{render_link(row["valueSet"], "ValueSet")}</td>'
        f'<td>{render_domain(row)}</td>'
        f'<td>{notes}</td>'
        "</tr>"
    )


PAGE_STYLE = """<style>
.ti-table { width: 100%; border-collapse: collapse; font-size: 0.85em; }
.ti-table th, .ti-table td { border: 1px solid #ddd; padding: 4px 6px; vertical-align: top; }
.ti-table th { background: #f5f5f5; text-align: left; position: sticky; top: 0; }
.ti-table td:nth-child(4), .ti-table td:nth-child(5) { word-break: break-all; }
.ti-dest { color: #555; font-size: 0.85em; white-space: nowrap; }
.ti-dest::before { content: "\\2192\\00a0"; }
.ti-none { color: #777; }
.ti-origin { color: #555; font-size: 0.85em; white-space: nowrap; }
.ti-origin::before { content: "\00b7\00a0"; }
.ti-key { display: inline-block; width: 1.1em; height: 1.1em; border: 1px solid #bbb;
          vertical-align: -0.15em; margin-right: 0.3em; }
.ti-jump { line-height: 2; }
.ti-jump a { display: inline-block; padding: 0 0.5em; }
</style>"""


def render_legend(counts):
    """The shading key. Every colour also appears as words in the Notes column."""
    lines = ["<p>"]
    for key in ("new-to-tho", "tho-only", "tho-dangling"):
        swatch = f'<span class="ti-key" style="background:{SHADE[key]}"></span>'
        lines.append(f'{swatch}<strong>{SHADE_LABEL[key]}</strong> ({counts.get(key, 0)}) &nbsp;&nbsp;')
    lines.append("</p>")
    return "\n".join(lines)


def render_jump_links(rows):
    seen = sorted({row["table"][:2] + "XX" for row in rows})
    first = {}
    for row in rows:
        first.setdefault(row["table"][:2] + "XX", row["table"])
    links = " ".join(f'<a href="#tbl-{first[b]}">{b}</a>' for b in seen)
    return f'<p class="ti-jump">Jump to: {links}</p>'


def render_page(rows):
    prov = snapshot_provenance()
    prov["date"] = "2026-07-27"
    counts = Counter(row["exception"] for row in rows if row["exception"])
    exceptions = [row for row in rows if row["exception"]]

    parts = [
        "# Table index",
        "",
        "Every code table in Chapter 2C, and the artifacts that represent it.",
        f"**{len(rows)} tables.**",
        "",
        "## How the links work",
        "",
        "The text of every link is the artifact's **canonical URL on THO** — that "
        "is its identifier, and it does not change. Where the link *goes* depends "
        "on who holds the artifact:",
        "",
        "- If **this guide** authors it, the link opens the draft in this guide. "
        "That is the copy under review, so it is the one you want.",
        "- If this guide authors nothing, the link opens the **artifact on THO**.",
        "- If neither holds it, the canonical is shown as plain text.",
        "",
        "The marker after each link says which of the three applies, so clicking "
        "never surprises you.",
        "",
        "## What \"in THO\" means here",
        "",
        (
            "Every claim on this page about what THO holds is checked against a "
            "local snapshot of the **`hl7.terminology.r5` package, version "
            "{package}** (published {date}), not against a live server. Inside "
            "that package the `conceptdomains` code system is at "
            "**{conceptdomains}** and `v2-tables` is at **{v2tables}** — "
            "resource versions move independently of the package version."
        ).format(**prov),
        "",
        "Those are **artifact** versions, which move per resource and are not "
        "the version of the THO release that carries them. `conceptdomains` is "
        "at 3.0.0 in THO; this guide changes it, so its artifact version "
        "increments to **4.0.0**. That says nothing about which THO release "
        "would publish it, and no row on this page names a version for an "
        "individual concept.",
        "",
        "## What the shading means",
        "",
        "For most tables the artifact exists **both here and in THO** — this guide "
        "is a redraft of something THO already carries. That is the norm and it is "
        "left unshaded. Shading marks only the rows that depart from what their "
        "route would predict:",
        "",
        render_legend(counts),
        "",
        "Every shaded row repeats its reason in the Notes column, so the page reads "
        "correctly without the colours.",
        "",
        f"### The {len(exceptions)} rows that need a second look",
        "",
        "| Table | Name | Why |",
        "|---|---|---|",
    ]
    for row in exceptions:
        why = " ".join(row["notes"]).replace("|", "\\|")
        parts.append(f'| [{row["table"]}](#tbl-{row["table"]}) | {row["name"]} | {why} |')

    parts += [
        "",
        "## All tables",
        "",
        PAGE_STYLE,
        render_legend(counts),
        render_jump_links(rows),
        '<table class="ti-table">',
        "<thead><tr><th>Table</th><th>Name</th><th>Route</th><th>Code system</th>"
        "<th>Value set</th><th>Concept domain</th><th>Notes</th></tr></thead>",
        "<tbody>",
    ]
    parts.extend(render_row(row) for row in rows)
    parts += ["</tbody>", "</table>", ""]
    parts.append(render_orphans(build_orphan_rows()))
    return "\n".join(parts)


def self_check(rows):
    """Warn about anything that would make the page quietly wrong.

    Follows the house convention for these generators: a silent run is the
    expected outcome, so any output here is worth reading.
    """
    warnings = []
    if len(rows) != len({row["table"] for row in rows}):
        warnings.append("duplicate table numbers in the joined rows")

    missing_name = [r["table"] for r in rows if not r["name"]]
    if missing_name:
        warnings.append(f"{len(missing_name)} tables have no name: {missing_name[:8]}")

    # A link that claims to go to this guide must name a resource the build
    # will actually publish.
    authored_ids = {a["id"] for a in load_authored().values()}
    for row in rows:
        for key in ("codeSystem", "valueSet"):
            ident = row[key]["igId"]
            if ident and ident not in authored_ids:
                warnings.append(f"table {row['table']}: {key} links to unpublished id {ident}")

    routes = set(r["route"] for r in rows) - set(ROUTE_LABEL)
    if routes:
        warnings.append(f"unlabelled routes: {sorted(routes)}")
    return warnings


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--check", action="store_true",
                        help="report what would be written, change nothing")
    args = parser.parse_args(argv)

    rows = build_rows()
    for warning in self_check(rows):
        print(f"WARNING: {warning}", file=sys.stderr)

    counts = Counter(row["exception"] for row in rows if row["exception"])
    summary = ", ".join(f"{SHADE_LABEL[k]} {v}" for k, v in sorted(counts.items()))
    print(f"{len(rows)} tables; {sum(counts.values())} shaded ({summary})")

    page = render_page(rows)
    if args.check:
        print(f"--check: would write {len(page):,} bytes to {OUTPUT_PAGE.relative_to(PROJECT_ROOT)}")
        return 0
    OUTPUT_PAGE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PAGE.write_text(page, encoding="utf-8")
    print(f"wrote {OUTPUT_PAGE.relative_to(PROJECT_ROOT)} ({len(page):,} bytes)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
