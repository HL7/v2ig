#!/usr/bin/env python3
"""Render a single browsable catalog of everything in Chapter 2C that needs review.

Audience: whoever is deciding what the V2.9.1 vocabulary IG should contain.
The report opens in a browser with no server and no dependencies.

Three separate machine outputs feed it, because "things needing review" arrive
from three different directions:

  1. v291-extracted/vocabulary-deviations.json
     Where the python-docx extraction's emitted text differs from the published
     text, or where the published text is irregular and was left alone.

  2. v291-llm/vocabulary-comparison-report.json
     Where the two independent extractions of the same document disagree.

  3. v291-extracted/vocabulary/*.json  (the `sourceIssues` key)
     Observations about the published document itself -- empty tables,
     mis-styled headings, duplicated blocks.

Plus a coverage check against the staged THO package (tho-r5/), which decides
which tables can reuse a published canonical URL and which need a new one.

Every entry is placed in one of three ACTION classes, so the reader can tell at
a glance what is being asked of them:

  decide    A judgement is needed before resources can be generated.
  confirm   Something was changed automatically; confirm it was right.
  informational
            Disclosed for completeness; no action expected.

Usage:
    python3 tooling/scripts/render_vocabulary_review_html.py
    python3 tooling/scripts/render_vocabulary_review_html.py -o /tmp/report.html
"""

import argparse
import datetime
import html
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
DEVIATIONS_PATH = PROJECT_ROOT / "v291-extracted" / "vocabulary-deviations.json"
COMPARISON_PATH = PROJECT_ROOT / "v291-llm" / "vocabulary-comparison-report.json"
THO_DIR = PROJECT_ROOT / "tho-r5"
DEFAULT_OUT = PROJECT_ROOT / "v291-extracted" / "vocabulary-review-report.html"

# How each deviation kind should be presented.
#   action   -> decide | confirm | informational
#   headline -> short description shown in the section header
DEVIATION_PRESENTATION = {
    "leading_trailing_whitespace": (
        "confirm",
        "Stripped automatically. Confirm each was a typo and not meaningful text.",
    ),
    "internal_double_space": (
        "decide",
        "Left exactly as published. Decide whether any should be collapsed.",
    ),
    "embedded_newline": (
        "informational",
        "Left as published. Usually genuine paragraph structure inside a cell.",
    ),
    "non_breaking_space": (
        "decide",
        "Left as published, except where leading or trailing. Note the ones inside URLs.",
    ),
}

COMPARISON_PRESENTATION = {
    "content": ("decide", "The two extractions genuinely disagree. Check the source document."),
    "pydocx_truncated": ("decide", "The python-docx value is a prefix of the LLM value. Investigate."),
    "block_count": ("decide", "The two extractions found a different number of metadata blocks."),
    "row_count": ("decide", "The two extractions found a different number of code rows."),
    "missing_in_llm": ("decide", "A key the python-docx extraction found and the LLM did not."),
    "missing_in_pydocx": ("decide", "A key the LLM found and the python-docx extraction did not."),
    "llm_truncated": ("informational", "Known LLM defect: the value was cut short at a literal double quote."),
    "typography": ("informational", "Known LLM defect: ASCII look-alikes for curly quotes and dashes."),
    "whitespace": ("confirm", "Differs only in spacing, normally the whitespace stripped by python-docx."),
}

SOURCE_ISSUE_PRESENTATION = {
    "heading_has_wrong_word_style": (
        "decide",
        "The published heading carries the wrong Word style. Both tables were "
        "invisible to extraction until this was special-cased, and they are "
        "missing from the document's own table of contents.",
    ),
    "empty_table_in_source": (
        "decide",
        "A table in the published document has no content at all.",
    ),
    "duplicate_table_metadata_block": (
        "decide", "Two Table Metadata blocks in one section; they were merged.",
    ),
    "unclassified_table": (
        "informational", "A table whose first cell matched no known block type.",
    ),
    "code_row_without_value": (
        "decide", "A code row with content but no code value.",
    ),
    "heading_has_no_table_name": (
        "informational", "The heading had no name after the table number.",
    ),
}

ACTION_ORDER = ["decide", "confirm", "informational"]
ACTION_LABEL = {
    "decide": "Decide",
    "confirm": "Confirm",
    "informational": "Informational",
}


def esc(text):
    """Escape text for HTML, rendering None and empty string visibly."""
    if text is None:
        return '<span class="absent">&mdash; absent &mdash;</span>'
    if text == "":
        return '<span class="empty">(empty)</span>'
    return html.escape(str(text))


def show_invisibles(text):
    """Make whitespace visible so a reader can actually see the difference.

    A report about stray whitespace is useless if the whitespace is invisible,
    so spaces at the ends of a value, tabs and newlines are shown as marks.
    """
    if text is None:
        return '<span class="absent">&mdash; absent &mdash;</span>'
    if text == "":
        return '<span class="empty">(empty)</span>'

    escaped = html.escape(str(text))
    escaped = escaped.replace(" ", '<span class="ws" title="non-breaking space">&#9251;</span>')
    escaped = escaped.replace("\t", '<span class="ws" title="tab">&#8677;</span>')
    escaped = escaped.replace("\n", '<span class="ws" title="line break">&#182;</span><br>')
    # Mark runs of two or more ordinary spaces.
    escaped = re.sub(r" {2,}",
                     lambda m: f'<span class="ws" title="{len(m.group(0))} spaces">'
                               + "&middot;" * len(m.group(0)) + "</span>",
                     escaped)
    # Mark a single leading or trailing space.
    if str(text).startswith(" "):
        escaped = '<span class="ws" title="leading space">&middot;</span>' + escaped[1:]
    if str(text).endswith(" ") and not escaped.endswith("</span>"):
        escaped = escaped[:-1] + '<span class="ws" title="trailing space">&middot;</span>'
    return escaped


def truncate(text, limit=300):
    """Shorten very long prose so one row does not swamp the table."""
    if text is None:
        return None
    text = str(text)
    return text if len(text) <= limit else text[:limit] + " …"


def load_json(path):
    return json.loads(path.read_text()) if path.exists() else None


def load_source_issues():
    """Collect the sourceIssues recorded against each extracted table."""
    issues = defaultdict(list)
    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        for issue in record.get("sourceIssues") or []:
            issues[issue["issue"]].append({
                "tableNumber": record.get("tableNumber", path.stem),
                "tableName": record.get("tableName", ""),
                **issue,
            })
    return issues


def load_tho_coverage():
    """Work out which CH02C tables can reuse a THO canonical URL.

    Returns None when the THO package has not been staged.
    """
    if not THO_DIR.exists():
        return None

    tho_codesystems, tho_valuesets = set(), set()
    for path in THO_DIR.glob("CodeSystem-v2-*.json"):
        tho_codesystems.add(path.stem.replace("CodeSystem-v2-", ""))
    for path in THO_DIR.glob("ValueSet-v2-*.json"):
        tho_valuesets.add(path.stem.replace("ValueSet-v2-", ""))

    with_codes, all_tables = set(), set()
    names = {}
    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        number = record.get("tableNumber", path.stem)
        all_tables.add(number)
        names[number] = record.get("tableName", "")
        if record.get("codedContent"):
            with_codes.add(number)

    return {
        "tho_codesystems": tho_codesystems,
        "tho_valuesets": tho_valuesets,
        "with_codes": with_codes,
        "all_tables": all_tables,
        "names": names,
        "needs_new_canonical": sorted(with_codes - tho_codesystems),
        "tho_without_table": sorted(tho_codesystems - all_tables),
    }


# ---------------------------------------------------------------------------
# Section building
# ---------------------------------------------------------------------------


def build_sections(deviations, comparison, source_issues):
    """Assemble every reviewable item into an ordered list of section dicts.

    Each section is one homogeneous kind of issue, so the reader makes one kind
    of decision at a time rather than context-switching per row.
    """
    sections = []

    # --- Source document issues -------------------------------------------
    for issue_kind, entries in sorted(source_issues.items()):
        action, blurb = SOURCE_ISSUE_PRESENTATION.get(
            issue_kind, ("decide", "Observed in the published document."))
        sections.append({
            "id": f"src-{issue_kind}",
            "group": "Published document",
            "title": issue_kind.replace("_", " ").capitalize(),
            "action": action,
            "blurb": blurb,
            "count": len(entries),
            "columns": ["Table", "Name", "Detail"],
            "rows": [[e["tableNumber"], e.get("tableName", ""),
                      esc(e.get("detail") or json.dumps(
                          {k: v for k, v in e.items()
                           if k not in ("issue", "tableNumber", "tableName")}))]
                     for e in entries],
            "raw_html_columns": {2},
        })

    # --- Cross-pipeline disagreements -------------------------------------
    by_bucket = defaultdict(list)
    for table, findings in (comparison or {}).get("findings", {}).items():
        for finding in findings:
            by_bucket[finding["bucket"]].append((table, finding))

    for bucket in sorted(by_bucket, key=lambda b: (
            ACTION_ORDER.index(COMPARISON_PRESENTATION.get(b, ("decide", ""))[0]), b)):
        action, blurb = COMPARISON_PRESENTATION.get(
            bucket, ("decide", "Disagreement between the two extractions."))
        entries = by_bucket[bucket]
        rows = []
        for table, finding in entries:
            rows.append([
                table,
                f'<code>{html.escape(finding["location"])}</code>',
                show_invisibles(truncate(finding["pydocx"])),
                show_invisibles(truncate(finding["llm"])),
            ])
        sections.append({
            "id": f"cmp-{bucket}",
            "group": "Extraction cross-check",
            "title": bucket.replace("_", " ").capitalize(),
            "action": action,
            "blurb": blurb,
            "count": len(entries),
            "columns": ["Table", "Location", "python-docx", "LLM"],
            "rows": rows,
            "raw_html_columns": {1, 2, 3},
        })

    # --- Text deviations ---------------------------------------------------
    for group in (deviations or {}).get("groups", []):
        kind = group["kind"]
        action, blurb = DEVIATION_PRESENTATION.get(
            kind, ("decide", "Difference between published and emitted text."))
        where = f'{group["section"]}.{group["field"]}' if group["field"] else group["section"]
        rows = []
        for entry in group["deviations"]:
            rows.append([
                entry["tableNumber"],
                show_invisibles(truncate(entry["raw"])),
                show_invisibles(truncate(entry.get("normalized", entry["raw"]))),
            ])
        sections.append({
            "id": f"dev-{kind}-{where.replace('.', '-')}",
            "group": f"Text: {kind.replace('_', ' ')}",
            "title": where,
            "action": action,
            "blurb": blurb + (
                "  These were changed." if group["action"] == "normalized"
                else "  These were left as published."),
            "count": group["count"],
            "columns": ["Table", "As published", "As emitted"],
            "rows": rows,
            "raw_html_columns": {1, 2},
        })

    return sections


def build_html(sections, deviations, comparison, coverage, generated):
    """Assemble the whole report as one self-contained HTML string."""
    out = []
    add = out.append

    # Two different numbers matter, and conflating them is misleading: a group
    # of 375 identical double spaces in one field is ONE decision, not 375.
    action_totals = Counter()      # individual affected values
    action_groups = Counter()      # decisions to actually make
    for section in sections:
        action_totals[section["action"]] += section["count"]
        action_groups[section["action"]] += 1

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add("<title>V2.9.1 Chapter 2C — review catalog</title>")
    add(f"<style>{STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<div id='sidebar'>")
    add("<h2>Overview</h2>")
    add("<a href='#summary'>Summary</a>")
    if coverage:
        add("<a href='#canonicals'>THO canonical coverage</a>")
    grouped = defaultdict(list)
    for section in sections:
        grouped[section["group"]].append(section)
    for action in ACTION_ORDER:
        wanted = [(g, s) for g, ss in grouped.items() for s in ss if s["action"] == action]
        if not wanted:
            continue
        add(f"<h2>{ACTION_LABEL[action]} &mdash; {action_groups[action]} groups</h2>")
        for group, section in wanted:
            add(f"<a href='#{section['id']}'>{html.escape(group)}: "
                f"{html.escape(section['title'])} "
                f"<span class='count'>({section['count']})</span></a>")
    add("</div>")

    # ---- main ----
    add("<div id='main'>")
    add("<h1>V2.9.1 Chapter 2C — review catalog</h1>")
    add(f"<p class='sub'>Generated {esc(generated)} from <code>CH02C_Tables.docx</code>. "
        "Every item that needs a human decision before FHIR CodeSystem and "
        "ValueSet resources can be generated.</p>")

    add("<div class='callout'>"
        "<b>How to read this.</b> Items are grouped by what is being asked of you. "
        f"<span class='badge b-decide'>Decide</span> means a judgement is needed. "
        f"<span class='badge b-confirm'>Confirm</span> means something was changed "
        "automatically and should be checked. "
        f"<span class='badge b-info'>Informational</span> means no action is expected. "
        "Whitespace is shown with visible marks: "
        "<span class='ws'>&middot;</span> a space, "
        "<span class='ws'>&#8677;</span> a tab, "
        "<span class='ws'>&#9251;</span> a non-breaking space, "
        "<span class='ws'>&#182;</span> a line break."
        "</div>")

    add("<h2 id='summary'>Summary</h2>")
    add("<div class='metric-grid'>")
    add(f"<div class='metric-card mc-flag'><div class='number'>{action_groups['decide']}</div>"
        f"<div class='label'>decisions to make<br><span class='faint'>"
        f"covering {action_totals['decide']:,} values</span></div></div>")
    add(f"<div class='metric-card'><div class='number'>{action_groups['confirm']}</div>"
        f"<div class='label'>groups to confirm<br><span class='faint'>"
        f"covering {action_totals['confirm']:,} values</span></div></div>")
    add(f"<div class='metric-card'><div class='number'>{action_groups['informational']}</div>"
        f"<div class='label'>informational groups<br><span class='faint'>"
        f"covering {action_totals['informational']:,} values</span></div></div>")
    if comparison:
        common = comparison.get("coverage", {}).get("common", 0)
        clean = common - len(comparison.get("findings", {}))
        add(f"<div class='metric-card mc-good'><div class='number'>{clean}/{common}</div>"
            "<div class='label'>tables both extractions agree on entirely</div></div>")
    if coverage:
        add(f"<div class='metric-card'><div class='number'>{len(coverage['needs_new_canonical'])}</div>"
            "<div class='label'>tables needing a new canonical URL</div></div>")
    add("</div>")

    add("<table><tr><th>Where it came from</th><th>What it is</th>"
        "<th class='num'>Items</th></tr>")
    provenance_rows = [
        ("Published document", "Irregularities in <code>CH02C_Tables.docx</code> itself",
         sum(s["count"] for s in sections if s["group"] == "Published document")),
        ("Extraction cross-check",
         "Where the python-docx and LLM extractions of the same document disagree",
         sum(s["count"] for s in sections if s["group"] == "Extraction cross-check")),
        ("Text deviations",
         "Where emitted text differs from published text, or published text is irregular",
         sum(s["count"] for s in sections if s["group"].startswith("Text:"))),
    ]
    for label, description, count in provenance_rows:
        add(f"<tr><td>{label}</td><td>{description}</td><td class='num'>{count}</td></tr>")
    add("</table>")

    # ---- canonical coverage ----
    if coverage:
        add("<h2 id='canonicals'>THO canonical URL coverage</h2>")
        add(f"<p class='sub'>Checked against the staged "
            f"<code>hl7.terminology.r5</code> package. "
            f"{len(coverage['tho_codesystems'])} v2 CodeSystems and "
            f"{len(coverage['tho_valuesets'])} v2 ValueSets are published there.</p>")
        reusable = len(coverage["with_codes"] & coverage["tho_codesystems"])
        add("<table><tr><th>Situation</th><th class='num'>Tables</th><th>Meaning</th></tr>")
        add(f"<tr><td>Code-bearing table with a THO CodeSystem</td>"
            f"<td class='num'>{reusable}</td>"
            "<td>Reuse the published canonical URL as-is</td></tr>")
        add(f"<tr><td>Code-bearing table with no THO CodeSystem</td>"
            f"<td class='num'>{len(coverage['needs_new_canonical'])}</td>"
            "<td>A canonical URL must be minted</td></tr>")
        add(f"<tr><td>THO CodeSystem with no CH02C table</td>"
            f"<td class='num'>{len(coverage['tho_without_table'])}</td>"
            "<td>Present in THO but not in this chapter; likely retired</td></tr>")
        add("</table>")

        add("<details><summary>Tables needing a new canonical URL "
            f"<span class='meta'>({len(coverage['needs_new_canonical'])})</span></summary>")
        add("<table><tr><th>Table</th><th>Name</th></tr>")
        for number in coverage["needs_new_canonical"]:
            add(f"<tr><td>{esc(number)}</td><td>{esc(coverage['names'].get(number, ''))}</td></tr>")
        add("</table></details>")

        add("<details><summary>THO CodeSystems with no matching CH02C table "
            f"<span class='meta'>({len(coverage['tho_without_table'])})</span></summary>")
        add("<p>" + ", ".join(f"<code>v2-{esc(n)}</code>"
                              for n in coverage["tho_without_table"]) + "</p>")
        add("</details>")

    # ---- the sections themselves ----
    for action in ACTION_ORDER:
        matching = [s for s in sections if s["action"] == action]
        if not matching:
            continue
        add(f"<h2>{ACTION_LABEL[action]} &mdash; {action_groups[action]} groups, "
            f"{action_totals[action]:,} values</h2>")
        for section in sorted(matching, key=lambda s: (-s["count"], s["group"])):
            add(f"<h3 id='{section['id']}'>"
                f"<span class='badge b-{action}'>{ACTION_LABEL[action]}</span> "
                f"{html.escape(section['group'])}: {html.escape(section['title'])} "
                f"<span class='dim-tag'>{section['count']}</span></h3>")
            add(f"<p class='legend'>{html.escape(section['blurb'])}</p>")
            add("<details><summary>Show the "
                f"{len(section['rows'])} entries</summary>")
            add("<table><tr>"
                + "".join(f"<th>{html.escape(c)}</th>" for c in section["columns"])
                + "</tr>")
            for row in section["rows"]:
                cells = []
                for index, cell in enumerate(row):
                    value = cell if index in section.get("raw_html_columns", set()) else esc(cell)
                    cells.append(f"<td>{value}</td>")
                add("<tr>" + "".join(cells) + "</tr>")
            add("</table></details>")

    add("</div></body></html>")
    return "\n".join(out)


STYLE = """
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
  margin: 0; display: flex; color: #1f2328; line-height: 1.5; }
#sidebar { position: fixed; top: 0; left: 0; width: 280px; height: 100vh; overflow-y: auto;
  background: #f6f8fa; border-right: 1px solid #d0d7de; padding: 16px; box-sizing: border-box; font-size: 13px; }
#sidebar h2 { font-size: 14px; margin: 16px 0 8px; text-transform: uppercase; letter-spacing: .03em; color: #57606a; }
#sidebar h2:first-child { margin-top: 0; }
#sidebar a { display: block; padding: 3px 0; color: #0969da; text-decoration: none; }
#sidebar a:hover { text-decoration: underline; }
#sidebar .count { color: #57606a; font-size: 11px; }
#main { margin-left: 280px; padding: 24px 40px; max-width: 1180px; }
h1 { font-size: 24px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 19px; margin-top: 40px; border-bottom: 1px solid #d0d7de; padding-bottom: 4px; }
h3 { font-size: 15px; margin-top: 28px; }
p.sub { color: #57606a; margin-top: 2px; }
table { border-collapse: collapse; width: 100%; font-size: 13px; margin: 8px 0 16px; }
th, td { border: 1px solid #d0d7de; padding: 5px 9px; text-align: left; vertical-align: top; }
th { background: #f6f8fa; }
td.num, th.num { text-align: right; }
tr:nth-child(even) td { background: #fbfcfd; }
.callout { background: #ddf4ff; border: 1px solid #54aeff; border-radius: 6px; padding: 12px 16px; margin: 16px 0; font-size: 14px; }
.callout.warn { background: #fff8c5; border-color: #d4a72c; }
.metric-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 12px; margin: 16px 0; }
.metric-card { border: 1px solid #d0d7de; border-radius: 6px; padding: 14px; text-align: center; background: #fff; }
.metric-card .number { font-size: 26px; font-weight: 700; }
.metric-card .label { font-size: 12px; color: #57606a; margin-top: 4px; }
.mc-good .number { color: #1a7f37; } .mc-flag .number { color: #bc4c00; }
span.absent { color: #afb8c1; } span.empty { color: #afb8c1; font-style: italic; }
.badge { display: inline-block; padding: 1px 8px; border-radius: 10px; font-size: 11px; font-weight: 600; color: #fff; white-space: nowrap; }
.b-decide { background: #bc4c00; } .b-confirm { background: #0969da; } .b-info { background: #6e7781; }
details { margin: 6px 0; border: 1px solid #d0d7de; border-radius: 6px; padding: 0 12px; }
details[open] { padding-bottom: 8px; }
summary { cursor: pointer; padding: 10px 0; font-weight: 600; }
summary .meta { font-weight: 400; color: #57606a; font-size: 13px; }
code { background: #eff1f3; padding: 1px 5px; border-radius: 4px; font-size: 90%; }
.legend { font-size: 13px; color: #57606a; }
.dim-tag { display:inline-block; background:#eaeef2; border-radius:4px; padding:0 6px; font-size:11px; color:#424a53; margin-left:6px; }
.faint { color: #8b949e; font-size: 11px; }
.ws { background: #ffe0b2; color: #8a4b00; border-radius: 2px; font-weight: 700; }
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("-o", "--output", default=str(DEFAULT_OUT),
                        help=f"Where to write the HTML (default {DEFAULT_OUT})")
    args = parser.parse_args()

    deviations = load_json(DEVIATIONS_PATH)
    comparison = load_json(COMPARISON_PATH)
    source_issues = load_source_issues()
    coverage = load_tho_coverage()

    if deviations is None:
        print(f"WARNING: no deviation log at {DEVIATIONS_PATH}")
    if comparison is None:
        print(f"WARNING: no comparison report at {COMPARISON_PATH}")

    sections = build_sections(deviations, comparison, source_issues)
    generated = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    html_text = build_html(sections, deviations, comparison, coverage, generated)

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(html_text)

    totals = Counter()
    for section in sections:
        totals[section["action"]] += section["count"]
    print(f"Sections: {len(sections)}")
    for action in ACTION_ORDER:
        print(f"  {ACTION_LABEL[action]}: {totals[action]} items")
    print(f"\nReport: {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
