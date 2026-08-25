#!/usr/bin/env python3
"""Render the Chapter 2C field-mapping document.

What information does Chapter 2C publish about a code table, and how much of it
survives into the generated FHIR resources? This document answers that field by
field, so somebody can decide which of the gaps are worth closing.

It joins two things:

  * the authored mapping in `field_mapping_spec.py`, which says where each
    field is supposed to go, and
  * the corpus in `v291-extracted/vocabulary/` plus the writer's own report,
    which say how many tables carry each field and what was actually generated.

Keeping those apart matters. A mapping derived from the code could only ever
describe what the code does; an authored mapping can say that a field goes
nowhere and that this is a problem. The join is what makes the document
trustworthy: the renderer checks that every field present in the corpus appears
in the spec, and says so loudly when one does not.

Outputs an HTML document and a Markdown twin, following the same pattern as the
committee briefings.

Usage:
    python3 tooling/scripts/render_field_mapping.py
    python3 tooling/scripts/render_field_mapping.py -o /tmp/mapping.html
"""

import argparse
import html
import json
import re
from collections import Counter, defaultdict
from datetime import date
from pathlib import Path

import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from briefing_style import STYLE  # noqa: E402
from field_mapping_spec import (  # noqa: E402
    BLOCKS, CARRIED, EXTRACTION_ONLY, FIELDS, NOT_USED, STATUS_BLURB,
    STATUS_LABEL, STATUS_ORDER, TRANSFORMED, USED,
)

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
THO_DIR = PROJECT_ROOT / "tho-r5"
UTG_VALUE_SETS = (PROJECT_ROOT / "UTG" / "input" / "sourceOfTruth" / "v2"
                  / "valueSets")
WRITER_REPORT = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
DEFAULT_HTML = PROJECT_ROOT / "v291-extracted" / "vocabulary-field-mapping.html"
DEFAULT_MD = PROJECT_ROOT / "v291-extracted" / "vocabulary-field-mapping.md"

TITLE = "Chapter 2C field mapping"
SUBTITLE = ("What the chapter publishes about each table, and how much of it "
            "reaches the FHIR resources")

VS_CANONICAL = "http://terminology.hl7.org/ValueSet/v2-{table}"

# The three shapes a table's output can take. Which fields have a destination
# depends entirely on which of these a table falls into, so the mapping is
# incomplete without them.
CLASSES = [
    ("code-system-and-value-set", "Own code system",
     "The table owns its code system and publishes codes. A CodeSystem and a "
     "ValueSet are written, and the mapping below applies in full."),
    ("value-set-only", "External code system",
     "The codes belong to somebody else &mdash; UCUM, SNOMED, ISO 3166, a v3 "
     "code system, or another v2 table. Only a ValueSet is written. "
     "<b>Everything in the Code System Identification block except the OID "
     "therefore has no destination for these tables</b>, even the fields "
     "marked Carried above, because there is no CodeSystem to carry them."),
    ("concept-domain-only", "Concept domain only",
     "The table declares a domain and no code system. Nothing is written but "
     "a concept in the shared <code>conceptdomains</code> CodeSystem, so only "
     "the Concept Domain block has any destination at all."),
    ("nothing-to-write", "Nothing declared",
     "The chapter declares the table and no terminology of any kind."),
    ("needs-decision", "Blocked",
     "Something about the table could not be settled mechanically, so nothing "
     "is written yet and no field has a destination."),
]


def esc(text):
    return html.escape(str(text if text is not None else ""))


def load_records():
    """Load every extracted table, in table order."""
    return [json.loads(path.read_text()) for path in sorted(VOCAB_DIR.glob("*.json"))]


def load_actions():
    """Map table number to what the writer decided to do with it."""
    if not WRITER_REPORT.is_file():
        return {}
    report = json.loads(WRITER_REPORT.read_text())
    return {entry["table"]: entry["action"] for entry in report.get("tables", [])}


def count_fields(records):
    """Count how many tables carry each field with a non-empty value.

    Returns:
        A ``(counts, blocks_present, observed)`` triple. `counts` is keyed by
        ``(block, field)``; `blocks_present` says how many tables have at least
        one entry in each block; `observed` is every ``(block, field)`` pair
        seen, which the completeness check compares against the spec.
    """
    counts = Counter()
    blocks_present = Counter()
    observed = set()

    for record in records:
        for key, value in record.items():
            entries = value if isinstance(value, list) else [value]
            if not isinstance(value, (list, dict)):
                continue
            if not entries or not any(isinstance(e, dict) and e for e in entries):
                continue
            blocks_present[key] += 1
            # A field counts once per table, except in codedContent where the
            # unit of interest is the row rather than the table.
            per_table = set()
            for entry in entries:
                if not isinstance(entry, dict):
                    continue
                for field, field_value in entry.items():
                    observed.add((key, field))
                    if str(field_value).strip() == "":
                        continue
                    if key == "codedContent":
                        counts[(key, field)] += 1
                    else:
                        per_table.add(field)
            for field in per_table:
                counts[(key, field)] += 1

    return counts, blocks_present, observed


def divergent_value_set_urls(records, actions):
    """Tables whose printed Value Set canonical is not the one we generate.

    The writer builds `ValueSet.url` from the table number and never reads the
    URI the chapter prints. That is invisible for most of the corpus because
    the two agree; this finds the tables where they do not, and checks each
    against THO and UTG so the reader can tell a defect in the chapter from a
    defect in the writer.
    """
    tho_urls = _published_value_set_urls()
    rows = []

    for record in records:
        table = record["tableNumber"]
        value_sets = record.get("valueSets") or []
        if not value_sets:
            continue
        declared = (value_sets[0].get("URI") or "").strip()
        generated = VS_CANONICAL.format(table=table)
        if not declared or declared == generated:
            continue
        rows.append({
            "table": table,
            "name": record.get("tableName", ""),
            "declared": declared,
            "generated": generated,
            "action": actions.get(table, "?"),
            "declaredPublished": declared in tho_urls,
            "generatedPublished": generated in tho_urls,
        })
    return rows


def _published_value_set_urls():
    """Every ValueSet canonical THO and UTG actually publish.

    Read from the `url` element rather than from the file name. UTG's file for
    table 0834 is called `vs-v2-0834.xml` and declares the canonical
    `.../v2-notAllCodes-0834`, so a name-based check gets that one backwards.
    """
    urls = set()

    for path in THO_DIR.glob("ValueSet-*.json"):
        try:
            url = json.loads(path.read_text()).get("url")
        except (json.JSONDecodeError, OSError):
            continue
        if url:
            urls.add(url)

    if UTG_VALUE_SETS.is_dir():
        for path in UTG_VALUE_SETS.glob("vs-*.xml"):
            match = re.search(r'<url\s+value="([^"]+)"', path.read_text())
            if match:
                urls.add(match.group(1))

    return urls


def class_counts(actions):
    """How many tables fall into each output class."""
    return Counter(actions.values())


def concept_domain_only_leftovers(records, actions):
    """What a concept-domain-only table carries that has no destination.

    The concept-domain-only case is the one the mapping serves worst, because
    almost every block in the chapter is written for a table that has a code
    system. This measures how much those 360 tables actually lose, which turns
    out to be far less than the classification suggests.
    """
    counts = Counter()
    coded_rows = 0
    for record in records:
        if actions.get(record["tableNumber"]) not in (
                "concept-domain-only", "nothing-to-write"):
            continue
        counts["tables"] += 1
        if record.get("codeSystems"):
            counts["with a Code System block"] += 1
        if record.get("valueSets"):
            counts["with a Value Set block"] += 1
        if record.get("codeSystemVersions"):
            counts["with a Code System Version block"] += 1
        if record.get("bindings"):
            counts["with a Binding block"] += 1
        rows = record.get("codedContent") or []
        if rows:
            counts["with codes"] += 1
            coded_rows += len(rows)
    counts["coded rows"] = coded_rows
    return counts


def unmapped_fields(counts):
    """The loss list: every field nothing reads, biggest first."""
    rows = []
    for entry in FIELDS:
        if entry["status"] != NOT_USED:
            continue
        rows.append((counts[(entry["block"], entry["field"])], entry))
    return sorted(rows, key=lambda pair: -pair[0])


def completeness(observed):
    """Fields in the corpus that the spec does not account for, and vice versa.

    The point of the check is that this document cannot quietly go stale. If
    extraction starts producing a new field, it shows up here rather than being
    silently absent from the mapping.
    """
    specified = {(e["block"], e["field"]) for e in FIELDS}
    corpus = {pair for pair in observed if pair not in EXTRACTION_ONLY}
    return sorted(corpus - specified), sorted(specified - corpus)


# --------------------------------------------------------------------------
# HTML
# --------------------------------------------------------------------------

def render_html(data, generated):
    out = []
    add = out.append

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add(f"<title>{esc(TITLE)}</title>")
    add(f"<style>{STYLE}{EXTRA_STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<nav id='sidebar'>")
    add(f"<div class='brand'>{TITLE}</div>")
    add(f"<div class='brand-sub'>{SUBTITLE}</div>")
    add("<a class='top' href='#losses'>&uarr; What is not carried</a>")
    add("<h2>The mapping</h2>")
    for block in BLOCKS:
        add(f"<a href='#{block['key']}'><span class='n'>&bull;</span>"
            f"{block['title']}</a>")
    add("<h2>By output class</h2>")
    add("<a href='#classes'><span class='n'>&mdash;</span>How the mapping "
        "changes</a>")
    add("<a href='#domains'><span class='n'>&mdash;</span>Concept domain "
        "only</a>")
    add("<h2>Found while mapping</h2>")
    add("<a href='#findings'><span class='n'>!</span>The Value Set canonical "
        "nobody reads</a>")
    add("<h2>Housekeeping</h2>")
    add("<a href='#completeness'><span class='n'>&check;</span>Completeness "
        "check</a>")
    add("</nav>")

    # ---- main ----
    add("<main id='main'>")
    add(f"<h1>{TITLE}</h1>")
    add(f"<p class='sub'>{SUBTITLE} &middot; {esc(generated)}</p>")
    add(LEDE)

    add("<div class='metric-grid'>")
    for number, label, tone in data["metrics"]:
        add(f"<div class='metric-card mc-{tone}'>"
            f"<div class='number'>{number}</div>"
            f"<div class='label'>{label}</div></div>")
    add("</div>")

    # ---- the loss list ----
    add("<section id='losses' class='asks-card'>")
    add("<h2 class='plain'>What is not carried</h2>")
    add("<p class='asks-intro'>Every field below exists in Chapter 2C and in "
        "none of the generated resources. The count is how many tables carry "
        "the field with a value in it. This is the decision list: for each "
        "one, either a way of preserving it is worth devising, or the loss is "
        "worth accepting on the record.</p>")
    add("<table><tr><th>Field</th><th class='num'>Tables</th>"
        "<th>Block</th><th>Why it goes nowhere</th></tr>")
    for count, entry in data["unmapped"]:
        block = data["block_titles"][entry["block"]]
        add(f"<tr><td class='nowrap'><b>{esc(entry['field'])}</b></td>"
            f"<td class='num'>{count}</td><td class='nowrap'>{esc(block)}</td>"
            f"<td>{entry['note']}</td></tr>")
    add("</table>")
    add("<p class='asks-foot'>Fields marked <b>Used, not carried</b> in the "
        "tables below are a softer version of the same problem: they are read, "
        "they change what is generated, and the value itself is still absent "
        "from the output.</p>")
    add("</section>")

    # ---- status legend ----
    add("<h2>How to read the tables</h2>")
    add("<table class='narrow'><tr><th>Status</th><th>Meaning</th></tr>")
    for status in STATUS_ORDER:
        add(f"<tr><td class='nowrap'><span class='badge {BADGE[status]}'>"
            f"{STATUS_LABEL[status]}</span></td>"
            f"<td>{esc(STATUS_BLURB[status])}</td></tr>")
    add("</table>")

    # ---- per-block mapping ----
    for block in BLOCKS:
        entries = data["by_block"][block["key"]]
        present = data["blocks_present"][block["key"]]
        unit = "rows" if block["key"] == "codedContent" else "tables"
        add(f"<h2 id='{block['key']}'>{esc(block['title'])}"
            f"<span class='dim-tag'>{present} tables</span></h2>")
        add(f"<p class='sub'>Feeds <code>{esc(block['feeds'])}</code></p>")
        add(f"<p>{block['intro']}</p>")
        add(f"<table><tr><th>Field</th><th class='num'>{unit.title()}</th>"
            "<th>Status</th><th>Where it goes</th><th>Notes</th></tr>")
        for entry in entries:
            count = data["counts"][(block["key"], entry["field"])]
            target = entry["target"] or "<span class='faint-inline'>&mdash;</span>"
            add(f"<tr><td class='nowrap'><b>{esc(entry['field'])}</b></td>"
                f"<td class='num'>{count}</td>"
                f"<td class='nowrap'><span class='badge {BADGE[entry['status']]}'>"
                f"{STATUS_LABEL[entry['status']]}</span></td>"
                f"<td>{target}</td><td>{entry['note']}</td></tr>")
        add("</table>")

    # ---- output classes ----
    add("<h2 id='classes'>How the mapping changes with the output class</h2>")
    add(CLASSES_INTRO)
    add("<table><tr><th>Class</th><th class='num'>Tables</th>"
        "<th>What it means for the mapping</th></tr>")
    for key, name, description in CLASSES:
        count = data["class_counts"].get(key, 0)
        add(f"<tr><td class='nowrap'><b>{esc(name)}</b><br>"
            f"<code>{esc(key)}</code></td>"
            f"<td class='num'>{count}</td><td>{description}</td></tr>")
    add("</table>")
    add(EXTERNAL_NOTE)

    # ---- concept domain only ----
    add("<h2 id='domains'>The concept-domain-only tables</h2>")
    add(DOMAINS_INTRO)
    leftovers = data["domain_leftovers"]
    add("<table class='narrow'><tr><th>Of those tables&hellip;</th>"
        "<th class='num'>Count</th></tr>")
    for label in ("tables", "with a Code System block", "with a Value Set block",
                  "with a Code System Version block", "with a Binding block",
                  "with codes", "coded rows"):
        add(f"<tr><td>{esc(label)}</td>"
            f"<td class='num'>{leftovers.get(label, 0)}</td></tr>")
    add("</table>")
    add(DOMAINS_OUTRO)

    # ---- findings ----
    add("<h2 id='findings'>Found while writing this down</h2>")
    add(FINDINGS_INTRO)
    rows = data["divergent_urls"]
    add(f"<p><b>{len(rows)} tables print a Value Set canonical that is not the "
        "one we generate.</b> &ldquo;Published?&rdquo; means THO or UTG has a "
        "ValueSet at that exact URL.</p>")
    add("<table><tr><th>Table</th><th>Name</th><th>Chapter prints</th>"
        "<th>Published?</th><th>We generate</th><th>Published?</th>"
        "<th>Status</th></tr>")
    for row in rows:
        add(f"<tr><td class='nowrap'>{esc(row['table'])}</td>"
            f"<td>{esc(row['name'])}</td>"
            f"<td class='small'>{esc(row['declared'])}</td>"
            f"<td class='nowrap'>{yes_no(row['declaredPublished'])}</td>"
            f"<td class='small'>{esc(row['generated'])}</td>"
            f"<td class='nowrap'>{yes_no(row['generatedPublished'])}</td>"
            f"<td class='nowrap small'>{esc(row['action'])}</td></tr>")
    add("</table>")
    add(FINDINGS_OUTRO)

    # ---- completeness ----
    add("<h2 id='completeness'>Completeness check</h2>")
    add(COMPLETENESS_INTRO)
    missing, stale = data["completeness"]
    if not missing and not stale:
        add("<div class='settled'><b>Every field in the corpus is accounted "
            "for</b>, and every field in the mapping still exists in the "
            "corpus. Nothing to do.</div>")
    if missing:
        add("<div class='counter'><b>In the corpus and not in the mapping:</b> "
            + ", ".join(f"<code>{esc(b)}.{esc(f)}</code>" for b, f in missing)
            + ". Add these to <code>field_mapping_spec.py</code>.</div>")
    if stale:
        add("<div class='counter'><b>In the mapping and no longer in the "
            "corpus:</b> "
            + ", ".join(f"<code>{esc(b)}.{esc(f)}</code>" for b, f in stale)
            + ".</div>")

    add(f"<p class='faint'>Generated {esc(generated)} by "
        "<code>tooling/scripts/render_field_mapping.py</code> from "
        "<code>tooling/scripts/field_mapping_spec.py</code>. Edit the spec "
        "module, not this file.</p>")
    add("</main></body></html>")
    return "\n".join(out)


def yes_no(flag):
    if flag:
        return "<span class='yes'>yes</span>"
    return "<span class='no'>no</span>"


BADGE = {
    NOT_USED: "b-decide",
    USED: "b-flag",
    TRANSFORMED: "b-info",
    CARRIED: "b-good",
}

EXTRA_STYLE = """
.b-good { background: #1a7f37; }
td.small { font-size: 11.5px; font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  word-break: break-all; }
span.yes { color: #1a7f37; font-weight: 700; }
span.no { color: #bc4c00; font-weight: 700; }
.faint-inline { color: #8b949e; }
"""

LEDE = """
<p class='lede'>Chapter 2C publishes far more about each code table than a
CodeSystem and a ValueSet have room for. This document sets out, field by
field, what reaches the generated resources and what does not &mdash; so that
the information being dropped is dropped on purpose.</p>

<p>The question that prompted it was a narrow one: the Code System
Identification block has a <b>Full Name</b> field, and nothing in the output
appears to carry it. That turned out to be true, and to be one of
<b>twenty-four</b> such fields. Two of them carry a value on all 799 tables.</p>

<p>This is the systematic version of what ADR-0008 calls <b>Batch C</b>
&mdash; container-level metadata &mdash; which has been open since the ADR was
written and lists four of these questions individually. Rather than answer them
one at a time, the whole surface is laid out here with counts attached, so the
ones worth spending effort on are visible next to the ones that are not.</p>

<p><b>Nothing here is a proposal.</b> A field recorded as not carried is a
question, not a defect: some of these have no sensible FHIR home, and some
describe the chapter rather than the terminology. The purpose is to make the
choice explicit.</p>
"""

CLASSES_INTRO = """
<p>The mapping above assumes the ordinary case: a table that owns its code
system. Most tables do not. Which fields have a destination at all depends on
which of these classes a table falls into, and the counts are lopsided &mdash;
the largest class writes almost nothing.</p>
"""

EXTERNAL_NOTE = """
<p>The <b>external code system</b> class is the one the original question
pointed at. For those 24 tables Chapter 2C still publishes a complete Code
System Identification block &mdash; OID, symbolic name, description, full name
&mdash; describing a code system somebody else owns. We write no CodeSystem for
them, correctly, so <b>none of that block is carried</b>, not just the Full
Name.</p>

<p>The natural FHIR home for &ldquo;here is what we know about a code system we
do not own&rdquo; is a <code>NamingSystem</code>, and THO already publishes
those &mdash; that is how tables like 0227 were resolved in the first place.
<b>This project reads THO's NamingSystems and writes none of its own.</b> So
where Chapter 2C's description of an external code system differs from THO's,
or adds something THO lacks, that difference is currently invisible. Whether it
should be reconciled, and whether any NamingSystem should be authored here, is
an open question this document does not answer.</p>
"""

DOMAINS_INTRO = """
<p>360 tables declare a concept domain and no code system, and 3 declare
nothing at all. The mapping treats them almost entirely as a lost cause,
because every block except Concept Domain is written for a table that has
terminology. In practice the loss is much smaller than that suggests.</p>
"""

DOMAINS_OUTRO = """
<p>So the picture for concept-domain-only tables is <b>not</b> that 360 tables
lose six blocks of content each. Nearly all of them carry the Concept Domain
block and the table metadata block and nothing else, and the Concept Domain
block is carried in full. What they lose is what every table loses: the table
metadata. That matters more here than elsewhere, because for these tables the
table-level <b>Description</b> is the only prose the chapter offers apart from
the domain definition itself, and it reaches nothing.</p>

<p>The handful of exceptions are already known and already escalated. The two
carrying a Code System block are 0560 and 0910, whose block is the
<code>noObject</code> placeholder. The four carrying codes are the tables that
publish example codes for a domain &mdash; conforming behaviour under the V3
requirements, and the subject of an open register item about where those
examples should live.</p>
"""

FINDINGS_INTRO = """
<p>Writing the mapping out surfaced something the pipeline had not reported,
which is the usual argument for doing this kind of exercise. It concerns the
Value Set <code>URI</code> field.</p>

<p>The writer never reads it. <code>ValueSet.url</code> is constructed from the
table number as <code>&hellip;/ValueSet/v2-NNNN</code>. For 412 of the 429
tables that print a URI, the constructed string and the printed string are
identical, which is why nobody noticed.</p>
"""

FINDINGS_OUTRO = """
<p>Most of the seventeen are already-known defect classes appearing in a field
nobody had checked &mdash; links to rendered pages where a canonical belongs,
<code>hl7.org/permalink</code> addresses, and references to genuinely external
value sets at FHIR or PHIN VADS canonicals. Those tables are mostly blocked
already for other reasons.</p>

<div class='counter'>
<p><b>Four of them are a real divergence, and they point the same way.</b>
Tables <b>0291, 0347, 0399 and 0834</b> print a canonical of the form
<code>&hellip;/ValueSet/v2-notAllCodes-NNNN</code> &mdash; THO's convention for
a value set that enumerates a subset of its code system rather than including
all of it. <b>THO and UTG both publish exactly that canonical, and neither
publishes the <code>v2-NNNN</code> form we generate.</b> So for these four,
the chapter, THO and UTG agree with each other and this project agrees with
none of them: it mints a fifth canonical that has never existed.</p>

<p>There is a second-order effect worth knowing about. The writer inherits
version and date from the existing UTG file by matching on the table number in
the file name, and UTG's files for three of these are named
<code>vs-v2-notAllCodes-NNNN.xml</code>. The match fails, so those three
inherit nothing and fall back to the default version &mdash; which means three
of the &ldquo;16 resources UTG does not have&rdquo; are resources UTG has all
along, under a name the parser did not recognise. Table 0347 is currently
emitted at version 1.0.0 where UTG publishes 2.0.0.</p>
</div>

<p>A separate pair, <b>0567 and 0568</b>, print another table's value set
canonical &mdash; <code>v2-0929</code> and <code>v2-0930</code> respectively.
Both the printed and the generated canonical exist in THO, so this is not a
dangling reference; it is the value-set counterpart of the pattern ADR-0008 D11
found for code systems, where one table borrows another's terminology. It needs
the same treatment and has not had it.</p>

<p><b>None of this has been changed.</b> Honouring the printed URI is not a
blanket rule &mdash; a page URL and a permalink are not canonicals, and
adopting them would be worse than ignoring them. It needs the same
classify-then-resolve treatment the Code System URI already has, and that is a
decision rather than a fix.</p>
"""

COMPLETENESS_INTRO = """
<p>The mapping is authored by hand and the corpus is regenerated by machine, so
they can drift. This check compares them on every run: any field that appears
in an extracted table and not in the mapping is reported here, and so is any
field in the mapping that no longer appears in the corpus.</p>
"""


# --------------------------------------------------------------------------
# Markdown
# --------------------------------------------------------------------------

def _text(fragment):
    """Crude HTML-to-text, for the Markdown twin."""
    return html.unescape(re.sub(r"<[^>]+>", "", fragment)).strip()


def _md_table(columns, rows):
    lines = ["| " + " | ".join(columns) + " |",
             "|" + "|".join(["---"] * len(columns)) + "|"]
    for row in rows:
        lines.append("| " + " | ".join(str(c).replace("|", "\\|") for c in row) + " |")
    return lines


def render_markdown(data, generated):
    out = [f"# {TITLE} — {SUBTITLE}", "", _text(LEDE), "",
           "## What is not carried", ""]
    out += _md_table(
        ["Field", "Tables", "Block", "Why it goes nowhere"],
        [[e["field"], c, data["block_titles"][e["block"]], _text(e["note"])]
         for c, e in data["unmapped"]])

    for block in BLOCKS:
        unit = "Rows" if block["key"] == "codedContent" else "Tables"
        out += ["", f"## {block['title']}", "",
                f"_Feeds `{block['feeds']}` · "
                f"{data['blocks_present'][block['key']]} tables_", "",
                _text(block["intro"]), ""]
        out += _md_table(
            ["Field", unit, "Status", "Where it goes", "Notes"],
            [[e["field"], data["counts"][(block["key"], e["field"])],
              STATUS_LABEL[e["status"]], _text(e["target"]) or "—",
              _text(e["note"])]
             for e in data["by_block"][block["key"]]])

    out += ["", "## How the mapping changes with the output class", "",
            _text(CLASSES_INTRO), ""]
    out += _md_table(
        ["Class", "Tables", "What it means"],
        [[name, data["class_counts"].get(key, 0), _text(description)]
         for key, name, description in CLASSES])
    out += ["", _text(EXTERNAL_NOTE), "",
            "## The concept-domain-only tables", "", _text(DOMAINS_INTRO), ""]
    out += _md_table(
        ["Of those tables…", "Count"],
        [[label, data["domain_leftovers"].get(label, 0)]
         for label in ("tables", "with a Code System block",
                       "with a Value Set block",
                       "with a Code System Version block",
                       "with a Binding block", "with codes", "coded rows")])
    out += ["", _text(DOMAINS_OUTRO), "",
            "## Found while writing this down", "", _text(FINDINGS_INTRO), ""]
    out += _md_table(
        ["Table", "Name", "Chapter prints", "Published?", "We generate",
         "Published?", "Status"],
        [[r["table"], r["name"], r["declared"],
          "yes" if r["declaredPublished"] else "no", r["generated"],
          "yes" if r["generatedPublished"] else "no", r["action"]]
         for r in data["divergent_urls"]])
    out += ["", _text(FINDINGS_OUTRO), "",
            "## Completeness check", "", _text(COMPLETENESS_INTRO), ""]

    missing, stale = data["completeness"]
    if not missing and not stale:
        out.append("Every field in the corpus is accounted for.")
    if missing:
        out.append("**In the corpus and not in the mapping:** "
                   + ", ".join(f"`{b}.{f}`" for b, f in missing))
    if stale:
        out.append("**In the mapping and no longer in the corpus:** "
                   + ", ".join(f"`{b}.{f}`" for b, f in stale))

    out += ["", f"_Generated {generated} by "
                f"`tooling/scripts/render_field_mapping.py` from "
                f"`tooling/scripts/field_mapping_spec.py`. Edit the spec "
                f"module, not this file._"]
    return "\n".join(out) + "\n"


# --------------------------------------------------------------------------

def gather():
    """Load everything the document needs and compute the derived numbers."""
    records = load_records()
    actions = load_actions()
    counts, blocks_present, observed = count_fields(records)

    by_block = defaultdict(list)
    for entry in FIELDS:
        by_block[entry["block"]].append(entry)

    status_totals = Counter(entry["status"] for entry in FIELDS)
    metrics = [
        (len(FIELDS), "fields Chapter 2C publishes", "good"),
        (status_totals[NOT_USED], "read by nothing", "escalate"),
        (status_totals[USED], "used but not carried", "flag"),
        (status_totals[CARRIED] + status_totals[TRANSFORMED],
         "reach a FHIR element", "good"),
    ]

    return {
        "counts": counts,
        "blocks_present": blocks_present,
        "by_block": by_block,
        "block_titles": {b["key"]: b["title"] for b in BLOCKS},
        "metrics": metrics,
        "unmapped": unmapped_fields(counts),
        "class_counts": class_counts(actions),
        "domain_leftovers": concept_domain_only_leftovers(records, actions),
        "divergent_urls": divergent_value_set_urls(records, actions),
        "completeness": completeness(observed),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("-o", "--output", default=str(DEFAULT_HTML))
    parser.add_argument("--markdown", default=str(DEFAULT_MD))
    args = parser.parse_args()

    data = gather()
    generated = date.today().isoformat()

    Path(args.output).write_text(render_html(data, generated), encoding="utf-8")
    Path(args.markdown).write_text(render_markdown(data, generated),
                                   encoding="utf-8")

    status_totals = Counter(entry["status"] for entry in FIELDS)
    print(f"{len(FIELDS)} fields mapped across {len(BLOCKS)} blocks")
    for status in STATUS_ORDER:
        print(f"  {status_totals[status]:3d}  {STATUS_LABEL[status]}")
    print(f"\n{len(data['divergent_urls'])} tables print a Value Set canonical "
          f"we do not generate")

    missing, stale = data["completeness"]
    if missing:
        print("\nWARNING: fields in the corpus with no mapping entry:")
        for block, field in missing:
            print(f"  {block}.{field}")
    if stale:
        print("\nWARNING: mapping entries with no field in the corpus:")
        for block, field in stale:
            print(f"  {block}.{field}")

    print(f"\nHTML:     {args.output}")
    print(f"Markdown: {args.markdown}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
