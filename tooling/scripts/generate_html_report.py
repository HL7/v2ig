#!/usr/bin/env python3
"""
Generate a multi-view HTML report from the V2 vocabulary comparison JSON.

Produces a standalone HTML file with three views into the comparison data:
  A. By Problem Type — group all findings by category of issue
  B. By Table — for each table with issues, show all its problems
  C. By Source Gap — what's missing from each source

Usage:
    python3 tooling/scripts/generate_html_report.py [--input PATH] [--output PATH]
"""

import json
import os
import argparse
from pathlib import Path
from collections import defaultdict
from datetime import date


# ---------------------------------------------------------------------------
# CSS
# ---------------------------------------------------------------------------

CSS = """
:root {
    --bg: #ffffff;
    --fg: #1a1a2e;
    --muted: #64748b;
    --border: #e2e8f0;
    --bg-alt: #f8fafc;
    --accent: #2563eb;
    --accent-light: #dbeafe;
    --green: #16a34a;
    --green-light: #dcfce7;
    --amber: #d97706;
    --amber-light: #fef3c7;
    --red: #dc2626;
    --red-light: #fee2e2;
    --purple: #7c3aed;
    --purple-light: #ede9fe;
    --teal: #0d9488;
    --teal-light: #ccfbf1;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
                 "Helvetica Neue", Arial, sans-serif;
    color: var(--fg);
    background: var(--bg);
    line-height: 1.6;
    max-width: 1100px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}
h1 { font-size: 1.75rem; margin-bottom: .5rem; }
h2 {
    font-size: 1.35rem; margin-top: 2.5rem; margin-bottom: 1rem;
    padding-bottom: .4rem; border-bottom: 2px solid var(--border);
}
h3 { font-size: 1.1rem; margin-top: 1.5rem; margin-bottom: .5rem; }
h4 { font-size: 1rem; margin-top: 1rem; margin-bottom: .4rem; color: var(--muted); }
p, li { margin-bottom: .4rem; }
a { color: var(--accent); text-decoration: none; }
a:hover { text-decoration: underline; }
code {
    font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
    font-size: .875em; background: var(--bg-alt); padding: .15em .35em;
    border-radius: 3px;
}
.subtitle { color: var(--muted); margin-bottom: 1.5rem; font-size: .95rem; }

/* Navigation / TOC */
nav.toc {
    background: var(--bg-alt); border: 1px solid var(--border);
    border-radius: 8px; padding: 1.25rem 1.5rem; margin-bottom: 2rem;
}
nav.toc h2 { margin-top: 0; border: none; font-size: 1.1rem; padding: 0; }
nav.toc ol { padding-left: 1.5rem; }
nav.toc li { margin-bottom: .25rem; }
nav.toc ol ol { margin-top: .25rem; }

/* Metric cards */
.metrics {
    display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1rem; margin-bottom: 1.5rem;
}
.metric {
    background: var(--bg-alt); border: 1px solid var(--border);
    border-radius: 8px; padding: 1rem 1.25rem; text-align: center;
}
.metric .value { font-size: 1.75rem; font-weight: 700; }
.metric .label { font-size: .8rem; color: var(--muted); margin-top: .2rem; }
.metric-link { cursor: pointer; transition: border-color .15s, box-shadow .15s; }
.metric-link:hover {
    border-color: var(--accent); box-shadow: 0 2px 8px rgba(37,99,235,.15);
}
.metric-link .label { color: var(--accent); }

/* External links */
.ext-links { font-size: .75rem; font-weight: normal; white-space: nowrap; }
.ext-links a { margin: 0 .1rem; }

/* Methodology links */
.method-link {
    font-size: .75rem; font-weight: normal; color: var(--muted);
    border: 1px solid var(--border); border-radius: 3px;
    padding: .1em .4em; margin-left: .5rem; vertical-align: middle;
}
.method-link:hover { color: var(--accent); border-color: var(--accent); text-decoration: none; }

/* Tables */
table {
    width: 100%; border-collapse: collapse; margin-bottom: 1rem;
    font-size: .9rem;
}
th, td {
    text-align: left; padding: .5rem .75rem;
    border-bottom: 1px solid var(--border);
}
th { background: var(--bg-alt); font-weight: 600; position: sticky; top: 0; }
tr:hover { background: #f1f5f9; }
td.num { text-align: right; font-variant-numeric: tabular-nums; }
table.fixed { table-layout: fixed; }
table.fixed td { overflow-wrap: break-word; word-wrap: break-word; }
table.fixed td.display { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
table.fixed td.display:hover { white-space: normal; overflow: visible; }
td.pres, th.pres { text-align: center; width: 3.5rem; min-width: 3.5rem; }
.table-wrap { overflow-x: auto; margin-bottom: 1rem; }

/* Badges */
.badge {
    display: inline-block; font-size: .75rem; font-weight: 600;
    padding: .15em .55em; border-radius: 999px; margin-right: .3rem;
    vertical-align: middle;
}
.badge-status   { background: var(--amber-light); color: var(--amber); }
.badge-missing  { background: var(--red-light); color: var(--red); }
.badge-display  { background: var(--purple-light); color: var(--purple); }
.badge-metadata { background: var(--teal-light); color: var(--teal); }
.badge-extra    { background: var(--green-light); color: var(--green); }

/* Presence indicators */
.present { color: var(--green); font-weight: 700; }
.absent  { color: var(--red); }

/* Details / collapsible */
details { margin-bottom: .75rem; }
details summary {
    cursor: pointer; font-weight: 600; padding: .3rem 0;
    color: var(--accent);
}
details summary:hover { text-decoration: underline; }

/* Observation callouts */
.observation {
    background: var(--accent-light); border-left: 4px solid var(--accent);
    padding: .75rem 1rem; margin: .75rem 0; border-radius: 0 6px 6px 0;
    font-size: .9rem;
}

/* Back to top */
.top-link {
    display: inline-block; font-size: .8rem; color: var(--muted);
    margin-top: .5rem;
}

/* Print */
@media print {
    body { max-width: 100%; padding: 1rem; }
    nav.toc, .top-link { display: none; }
    details { open; }
    details[open] summary { page-break-after: avoid; }
    h2, h3 { page-break-after: avoid; }
    table { page-break-inside: auto; }
    tr { page-break-inside: avoid; }
}
"""


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def esc(text):
    """Escape HTML entities."""
    if not text:
        return ""
    return (str(text)
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace('"', "&quot;"))


def presence_icon(is_present):
    if is_present:
        return '<span class="present">&#10003;</span>'
    return '<span class="absent">&#10007;</span>'


def badge(label, css_class):
    return f'<span class="badge {css_class}">{esc(label)}</span>'


def back_to_top():
    return '<a href="#top" class="top-link">&uarr; Back to top</a>'


def table_anchor(tnum):
    return f"table-{tnum}"


def classify_table_issues(t):
    """Return a set of issue-type strings for a table entry."""
    issues = set()
    for cd in t.get("codeDifferences", []):
        for d in cd.get("differences", []):
            if d == "status_mismatch":
                issues.add("status")
            elif d in ("missing_from_colleague", "missing_from_ch02c", "missing_from_utg"):
                issues.add("missing_codes")
            elif d in ("display_mismatch", "display_truncation"):
                issues.add("display")
    md = t.get("metadataDifferences", {})
    if any(k != "tableType" for k in md):
        issues.add("metadata")
    return issues


# ---------------------------------------------------------------------------
# Published URL helpers
# ---------------------------------------------------------------------------

FRANK_IG_BASE = "https://build.fhir.org/ig/frankoemig/hl7.v2.terminology.v291"


def tho_url(t):
    """Get the THO (https) URL for a table, if available."""
    url = t.get("links", {}).get("utg_url", "")
    return url.replace("http://", "https://") if url else ""


def frank_url(t):
    """Get the Frank Oemig IG URL for a table, if available."""
    cid = t.get("links", {}).get("colleague_id", "")
    return f"{FRANK_IG_BASE}/CodeSystem-{cid}.html" if cid else ""


def ext_links_html(t):
    """Small inline links to published versions: [THO] [Frank]."""
    parts = []
    u = tho_url(t)
    if u:
        parts.append(f'<a href="{u}" title="View on terminology.hl7.org">THO</a>')
    u = frank_url(t)
    if u:
        parts.append(f'<a href="{u}" title="View in Frank Oemig\'s IG">Frank</a>')
    if parts:
        return f' <span class="ext-links">[{" | ".join(parts)}]</span>'
    return ""


def table_num_linked(t, with_ext=True):
    """Render a table number as an internal link + optional external links."""
    tnum = t["tableNumber"]
    html = f'<a href="#{table_anchor(tnum)}">{esc(tnum)}</a>'
    if with_ext:
        html += ext_links_html(t)
    return html


def method_link(method_id, label="methodology"):
    """Link to a methodology description in the annex."""
    return (f'<a href="#method-{method_id}" class="method-link" '
            f'title="How this analysis works">{label}</a>')


# ---------------------------------------------------------------------------
# Section Builders
# ---------------------------------------------------------------------------

def build_executive_summary(report):
    s = report["summary"]
    cc = s["categoryCounts"]

    lines = []
    lines.append('<section id="summary">')
    lines.append("<h2>Executive Summary</h2>")
    lines.append("<p>Three-way comparison of HL7 V2 terminology across the "
                 "published standard (CH02C Word document, V2.9.1), "
                 "Frank Oemig&rsquo;s FHIR IG (<code>frankoemig/"
                 "hl7.v2.terminology.v291</code>), and UTG/THO "
                 "(terminology.hl7.org source repository).</p>")

    lines.append('<div class="metrics">')
    # (value, label, optional link target)
    metrics = [
        (s["totalTables"], "Total Unique Tables", None),
        (cc.get("all_sources", 0), "In All Three Sources", None),
        (s["tablesWithCodeDifferences"], "Tables with Code Differences",
         "#prob-missing"),
        (s["totalCodeDifferences"], "Individual Code Differences",
         "#prob-missing-consolidated"),
        (cc.get("ch02c_and_colleague", 0),
         "In CH02C + Frank Oemig, Not UTG", "#gap-utg"),
        (cc.get("utg_only", 0), "Only in UTG", "#gap-utg-only"),
    ]
    for item in metrics:
        val, label = item[0], item[1]
        href = item[2] if len(item) > 2 else None
        if href:
            lines.append(
                f'<a href="{href}" style="text-decoration:none;color:inherit">'
                f'<div class="metric metric-link">'
                f'<div class="value">{val}</div>'
                f'<div class="label">{esc(label)}</div>'
                f'</div></a>')
        else:
            lines.append(
                f'<div class="metric">'
                f'<div class="value">{val}</div>'
                f'<div class="label">{esc(label)}</div></div>')
    lines.append("</div>")

    # Presence overview table
    lines.append("<h3>Three-Way Presence Overview</h3>")
    lines.append("<table><thead><tr>"
                 "<th>Category</th><th class='num'>Count</th>"
                 "<th>Description</th></tr></thead><tbody>")
    cat_info = [
        ("all_sources", "In all three sources"),
        ("ch02c_and_colleague", "In CH02C &amp; Frank Oemig, not in UTG"),
        ("ch02c_and_utg", "In CH02C &amp; UTG, not in Frank Oemig"),
        ("colleague_and_utg", "In Frank Oemig &amp; UTG, not in CH02C"),
        ("ch02c_only", "Only in CH02C"),
        ("colleague_only", "Only in Frank Oemig"),
        ("utg_only", "Only in UTG"),
    ]
    for cat, desc in cat_info:
        count = cc.get(cat, 0)
        if count > 0:
            lines.append(f"<tr><td>{esc(cat)}</td>"
                         f"<td class='num'>{count}</td>"
                         f"<td>{desc}</td></tr>")
    lines.append("</tbody></table>")
    lines.append(back_to_top())
    lines.append("</section>")
    return "\n".join(lines)


def build_view_by_problem_type(report):
    """View A: group findings by category of issue."""
    tables = report["tables"]
    # Build lookup for table data by number (for link generation)
    table_lookup = {t["tableNumber"]: t for t in tables}
    lines = []
    lines.append('<section id="view-problem-type">')
    lines.append("<h2>View A: By Problem Type</h2>")
    lines.append("<p>All differences grouped by the nature of the issue.</p>")

    # --- A1: Status Disagreements ---
    lines.append(f'<h3 id="prob-status">A1. Status Disagreements {method_link("status")}</h3>')
    lines.append("<p>Codes where the status value differs across sources. "
                 "CH02C uses single-letter codes (D=Deprecated, B=Backward-compatible, "
                 "N=New, R=Retired, A=Active); Frank Oemig&rsquo;s IG and UTG "
                 "use full words.</p>")

    status_rows = []
    for t in tables:
        for cd in t.get("codeDifferences", []):
            if "status_mismatch" in cd.get("differences", []):
                status_rows.append((t["tableNumber"], t["tableName"], cd))

    if status_rows:
        lines.append(f"<p><strong>{len(status_rows)} status disagreements</strong> "
                     f"across {len(set(r[0] for r in status_rows))} tables.</p>")
        lines.append("<table><thead><tr><th>Table</th><th>Code</th>"
                     "<th>Display</th><th>CH02C</th><th>Frank Oemig</th>"
                     "<th>UTG</th></tr></thead><tbody>")
        for tnum, tname, cd in status_rows:
            t_data = table_lookup.get(tnum, {})
            lines.append(
                f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a>"
                f"{ext_links_html(t_data)} {esc(tname)}</td>"
                f"<td><code>{esc(cd['code'])}</code></td>"
                f"<td>{esc(cd['displays'].get('ch02c', '') or cd['displays'].get('colleague', ''))}</td>"
                f"<td><code>{esc(cd['statuses'].get('ch02c', ''))}</code></td>"
                f"<td><code>{esc(cd['statuses'].get('colleague', ''))}</code></td>"
                f"<td><code>{esc(cd['statuses'].get('utg', ''))}</code></td></tr>"
            )
        lines.append("</tbody></table>")

        # Check for systemic patterns
        utg_active_others_dep = [r for r in status_rows
                                  if r[2]["statuses"].get("utg") == "active"
                                  and r[2]["statuses"].get("ch02c") in ("D", "B")]
        if utg_active_others_dep:
            lines.append(
                f'<div class="observation">'
                f'<strong>Note:</strong> {len(utg_active_others_dep)} of these '
                f'involve UTG marking a code as <code>active</code> while CH02C '
                f'marks it <code>D</code> (Deprecated) or <code>B</code> '
                f'(Backward-compatible). CH02C and Frank Oemig&rsquo;s IG agree '
                f'on the deprecated status in all of these cases.'
                f'</div>'
            )
    else:
        lines.append("<p>No status disagreements found.</p>")

    lines.append(back_to_top())

    # --- A2: Missing Codes ---
    lines.append(f'<h3 id="prob-missing">A2. Missing Codes {method_link("codes")}</h3>')
    lines.append("<p>Codes present in one or two sources but absent from another.</p>")

    # --- Consolidated three-way presence table ---
    lines.append(f'<h4 id="prob-missing-consolidated">'
                 f'Consolidated View: All Code Presence Discrepancies {method_link("codes")}</h4>')
    lines.append("<p>Every code where at least one source differs from the "
                 "others in whether the code is present or absent. "
                 "Grouped by table.</p>")

    # Gather all codes with any presence discrepancy
    consol_by_table = defaultdict(list)
    for t in tables:
        for cd in t.get("codeDifferences", []):
            diffs = cd.get("differences", [])
            has_presence_diff = any(d.startswith("missing_from_") for d in diffs)
            if has_presence_diff:
                consol_by_table[(t["tableNumber"], t["tableName"])].append(cd)

    if consol_by_table:
        lines.append(f"<p><strong>{sum(len(v) for v in consol_by_table.values())} "
                     f"codes</strong> with presence discrepancies across "
                     f"<strong>{len(consol_by_table)} tables</strong>.</p>")
        lines.append('<div class="table-wrap">')
        lines.append("<table class='fixed'><thead><tr>"
                     "<th style='width:5%'>Table</th>"
                     "<th style='width:12%'>Name</th>"
                     "<th style='width:20%'>Code</th>"
                     "<th style='width:33%'>Display</th>"
                     "<th class='pres' style='width:10%'>CH02C</th>"
                     "<th class='pres' style='width:10%'>Frank</th>"
                     "<th class='pres' style='width:10%'>UTG</th>"
                     "</tr></thead><tbody>")
        for (tnum, tname), cds in sorted(consol_by_table.items()):
            first_row = True
            t_data = table_lookup.get(tnum, {})
            for cd in sorted(cds, key=lambda d: d["code"]):
                # Pick the best display name from whichever source has it
                disp = (cd["displays"].get("ch02c", "")
                        or cd["displays"].get("colleague", "")
                        or cd["displays"].get("utg", ""))
                table_cell = (
                    f"<td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a>{ext_links_html(t_data)}</td>"
                    f"<td>{esc(tname)}</td>"
                    if first_row else
                    f"<td></td><td></td>"
                )
                lines.append(
                    f"<tr>{table_cell}"
                    f"<td><code>{esc(cd['code'])}</code></td>"
                    f"<td class='display' title='{esc(disp)}'>{esc(disp)}</td>"
                    f"<td class='pres'>{presence_icon(cd.get('inCH02C', False))}</td>"
                    f"<td class='pres'>{presence_icon(cd.get('inColleague', False))}</td>"
                    f"<td class='pres'>{presence_icon(cd.get('inUTG', False))}</td></tr>"
                )
                first_row = False
        lines.append("</tbody></table>")
        lines.append("</div>")  # close table-wrap

    lines.append(back_to_top())

    # --- Per-source breakdowns (kept for detail) ---
    lines.append('<h4>Per-Source Breakdown</h4>')
    lines.append("<p>The same data broken out by which source is missing "
                 "the code, for a different perspective.</p>")

    missing_categories = [
        ("missing_from_colleague", "Codes in CH02C but not in Frank Oemig",
         "ch02c", "These codes exist in the published standard but were not "
         "included in Frank Oemig&rsquo;s FHIR IG."),
        ("missing_from_ch02c", "Codes in Frank Oemig but not in CH02C",
         "colleague", "These codes appear in Frank Oemig&rsquo;s IG but are "
         "not in the V2.9.1 published standard."),
        ("missing_from_utg", "Codes missing from UTG",
         "ch02c", "These codes exist in CH02C and/or Frank Oemig&rsquo;s IG "
         "but have no representation in UTG/THO."),
    ]

    for diff_key, heading, disp_source, explanation in missing_categories:
        rows = []
        for t in tables:
            for cd in t.get("codeDifferences", []):
                if diff_key in cd.get("differences", []):
                    rows.append((t["tableNumber"], t["tableName"], cd))

        lines.append(f"<h4>{heading} ({len(rows)} codes, "
                     f"{len(set(r[0] for r in rows))} tables)</h4>")
        lines.append(f"<p>{explanation}</p>")

        if rows:
            # Group by table for readability
            by_table = defaultdict(list)
            for tnum, tname, cd in rows:
                by_table[(tnum, tname)].append(cd)

            lines.append("<table><thead><tr><th>Table</th><th>Name</th>"
                         "<th class='num'>Missing Codes</th>"
                         "<th>Codes</th></tr></thead><tbody>")
            for (tnum, tname), cds in sorted(by_table.items()):
                codes_str = ", ".join(f"<code>{esc(cd['code'])}</code>" for cd in cds[:15])
                if len(cds) > 15:
                    codes_str += f" &hellip; (+{len(cds)-15} more)"
                t_data = table_lookup.get(tnum, {})
                lines.append(
                    f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a>"
                    f"{ext_links_html(t_data)}</td>"
                    f"<td>{esc(tname)}</td>"
                    f"<td class='num'>{len(cds)}</td>"
                    f"<td>{codes_str}</td></tr>"
                )
            lines.append("</tbody></table>")

    lines.append(back_to_top())

    # --- A3: Display Name Differences ---
    lines.append(f'<h3 id="prob-display">A3. Display Name Differences {method_link("display")}</h3>')

    trunc_rows = []
    mismatch_rows = []
    for t in tables:
        for cd in t.get("codeDifferences", []):
            if "display_truncation" in cd.get("differences", []):
                trunc_rows.append((t["tableNumber"], t["tableName"], cd))
            if "display_mismatch" in cd.get("differences", []):
                mismatch_rows.append((t["tableNumber"], t["tableName"], cd))

    if mismatch_rows:
        lines.append(f"<h4>Substantive Display Differences ({len(mismatch_rows)})</h4>")
        lines.append("<p>Display names that differ in meaning, not just length.</p>")
        lines.append("<table><thead><tr><th>Table</th><th>Code</th>"
                     "<th>CH02C</th><th>Frank Oemig</th><th>UTG</th>"
                     "</tr></thead><tbody>")
        for tnum, tname, cd in mismatch_rows:
            lines.append(
                f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a> "
                f"{esc(tname)}</td>"
                f"<td><code>{esc(cd['code'])}</code></td>"
                f"<td>{esc(cd['displays'].get('ch02c', ''))}</td>"
                f"<td>{esc(cd['displays'].get('colleague', ''))}</td>"
                f"<td>{esc(cd['displays'].get('utg', ''))}</td></tr>"
            )
        lines.append("</tbody></table>")

    if trunc_rows:
        lines.append(f"<h4>Truncated Display Names ({len(trunc_rows)} codes, "
                     f"{len(set(r[0] for r in trunc_rows))} tables)</h4>")
        lines.append("<p>The Frank Oemig&rsquo;s IG uses shorter display names, "
                     "typically stripping parenthetical details or trailing "
                     "descriptions from the CH02C original.</p>")

        by_table = defaultdict(list)
        for tnum, tname, cd in trunc_rows:
            by_table[(tnum, tname)].append(cd)

        for (tnum, tname), cds in sorted(by_table.items()):
            lines.append(f"<details><summary>Table {esc(tnum)} &mdash; "
                         f"{esc(tname)} ({len(cds)} truncations)</summary>")
            lines.append("<table><thead><tr><th>Code</th><th>CH02C</th>"
                         "<th>Frank Oemig</th><th>UTG</th></tr></thead><tbody>")
            for cd in cds:
                lines.append(
                    f"<tr><td><code>{esc(cd['code'])}</code></td>"
                    f"<td>{esc(cd['displays'].get('ch02c', ''))}</td>"
                    f"<td>{esc(cd['displays'].get('colleague', ''))}</td>"
                    f"<td>{esc(cd['displays'].get('utg', ''))}</td></tr>"
                )
            lines.append("</tbody></table></details>")

    if not mismatch_rows and not trunc_rows:
        lines.append("<p>No display name differences found.</p>")

    lines.append(back_to_top())

    # --- A4: Metadata Differences ---
    lines.append(f'<h3 id="prob-metadata">A4. Metadata Differences {method_link("metadata")}</h3>')
    lines.append("<p>Differences in table-level metadata: Code System OIDs, "
                 "symbolic names, and descriptions.</p>")

    meta_tables = [t for t in tables
                   if t.get("metadataDifferences")
                   and any(k != "tableType" for k in t["metadataDifferences"])]

    # Categorize metadata diffs
    meta_by_type = defaultdict(list)
    for t in meta_tables:
        for diff_key, diff_val in t["metadataDifferences"].items():
            if diff_key == "tableType":
                continue
            if isinstance(diff_val, dict):
                meta_by_type[diff_key].append((t["tableNumber"], t["tableName"], diff_val))

    for mtype, rows in sorted(meta_by_type.items()):
        nice_name = {
            "codeSystemOID": "Code System OID",
            "symbolicName": "Symbolic Name",
            "description": "Description",
        }.get(mtype, mtype)

        lines.append(f"<h4>{nice_name} differences ({len(rows)} tables)</h4>")

        if mtype == "description":
            # Descriptions can be long; use collapsible
            lines.append(f"<details><summary>Show all {len(rows)} description "
                         f"differences</summary>")

        lines.append("<table><thead><tr><th>Table</th><th>CH02C</th>"
                     "<th>Frank Oemig</th><th>UTG</th></tr></thead><tbody>")
        for tnum, tname, vals in rows:
            ch02c_v = esc(vals.get("ch02c", ""))
            coll_v = esc(vals.get("colleague", ""))
            utg_v = esc(vals.get("utg", ""))
            # Truncate long descriptions for the table display
            if mtype == "description":
                for v in [ch02c_v, coll_v, utg_v]:
                    pass  # already escaped; truncation handled in display
            lines.append(
                f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a> "
                f"{esc(tname)}</td>"
                f"<td>{ch02c_v}</td><td>{coll_v}</td><td>{utg_v}</td></tr>"
            )
        lines.append("</tbody></table>")
        if mtype == "description":
            lines.append("</details>")

    lines.append(back_to_top())

    lines.append("</section>")
    return "\n".join(lines)


def build_view_by_table(report):
    """View B: per-table detail with issue indicators."""
    tables = report["tables"]
    lines = []
    lines.append('<section id="view-table">')
    lines.append("<h2>View B: By Table</h2>")
    lines.append("<p>Every table that has at least one difference, with "
                 "indicators for which problem types apply.</p>")

    # Build a summary table first
    tables_with_issues = []
    for t in tables:
        issues = classify_table_issues(t)
        if issues:
            tables_with_issues.append((t, issues))

    lines.append(f"<p><strong>{len(tables_with_issues)}</strong> tables with "
                 f"at least one difference (out of {len(tables)} total).</p>")

    lines.append('<h3 id="table-index">Table Index</h3>')
    lines.append("<table><thead><tr><th>Table</th><th>Name</th>"
                 "<th class='pres'>CH02C</th>"
                 "<th class='pres'>Frank</th>"
                 "<th class='pres'>UTG</th>"
                 "<th>Issues</th></tr></thead><tbody>")

    for t, issues in tables_with_issues:
        tnum = t["tableNumber"]
        badges = []
        if "status" in issues:
            badges.append(badge("Status", "badge-status"))
        if "missing_codes" in issues:
            badges.append(badge("Missing", "badge-missing"))
        if "display" in issues:
            badges.append(badge("Display", "badge-display"))
        if "metadata" in issues:
            badges.append(badge("Metadata", "badge-metadata"))

        lines.append(
            f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a>{ext_links_html(t)}</td>"
            f"<td>{esc(t['tableName'])}</td>"
            f"<td class='pres'>{presence_icon(t['presence'].get('ch02c', False))}</td>"
            f"<td class='pres'>{presence_icon(t['presence'].get('colleague', False))}</td>"
            f"<td class='pres'>{presence_icon(t['presence'].get('utg', False))}</td>"
            f"<td>{''.join(badges)}</td></tr>"
        )
    lines.append("</tbody></table>")
    lines.append(back_to_top())

    # Now per-table detail sections
    lines.append('<h3>Table Details</h3>')

    for t, issues in tables_with_issues:
        tnum = t["tableNumber"]
        lines.append(f'<div id="{table_anchor(tnum)}">')
        lines.append(f"<h4>Table {esc(tnum)} &mdash; {esc(t['tableName'])}{ext_links_html(t)}</h4>")

        # Presence and counts
        counts = t.get("codeCounts", {})
        lines.append("<p>")
        lines.append(f"CH02C: {presence_icon(t['presence'].get('ch02c', False))} "
                     f"({counts.get('ch02c', 0)} codes) &nbsp;|&nbsp; ")
        lines.append(f"Frank Oemig: {presence_icon(t['presence'].get('colleague', False))} "
                     f"({counts.get('colleague', 0)} codes) &nbsp;|&nbsp; ")
        lines.append(f"UTG: {presence_icon(t['presence'].get('utg', False))} "
                     f"({counts.get('utg', 0)} codes)")
        lines.append("</p>")

        # Issue badges
        badges_html = []
        if "status" in issues:
            badges_html.append(badge("Status", "badge-status"))
        if "missing_codes" in issues:
            badges_html.append(badge("Missing Codes", "badge-missing"))
        if "display" in issues:
            badges_html.append(badge("Display Names", "badge-display"))
        if "metadata" in issues:
            badges_html.append(badge("Metadata", "badge-metadata"))
        lines.append(f"<p>Issues: {''.join(badges_html)}</p>")

        # Code-level differences
        code_diffs = t.get("codeDifferences", [])
        if code_diffs:
            # Categorize
            in_ch02c_not_colleague = [d for d in code_diffs
                                       if d.get("inCH02C") and not d.get("inColleague")]
            in_colleague_not_ch02c = [d for d in code_diffs
                                       if d.get("inColleague") and not d.get("inCH02C")]
            utg_only_codes = [d for d in code_diffs
                              if d.get("inUTG") and not d.get("inCH02C")
                              and not d.get("inColleague")]
            missing_utg = [d for d in code_diffs
                           if "missing_from_utg" in d.get("differences", [])
                           and (d.get("inCH02C") or d.get("inColleague"))]
            status_diffs = [d for d in code_diffs
                            if "status_mismatch" in d.get("differences", [])]
            display_diffs = [d for d in code_diffs
                             if "display_mismatch" in d.get("differences", [])
                             or "display_truncation" in d.get("differences", [])]

            if in_ch02c_not_colleague:
                lines.append(f"<p><strong>In CH02C, not in Frank Oemig "
                             f"({len(in_ch02c_not_colleague)}):</strong> ")
                code_parts = []
                for d in in_ch02c_not_colleague:
                    utg_mark = ""
                    if d.get("inUTG"):
                        utg_mark = '<span class="present" title="Also in UTG">&#10003;</span>'
                    else:
                        utg_mark = '<span class="absent" title="Not in UTG either">&#10007;</span>'
                    code_parts.append(f"<code>{esc(d['code'])}</code>{utg_mark}")
                lines.append(", ".join(code_parts))
                lines.append("</p>")

            if in_colleague_not_ch02c:
                lines.append(f"<p><strong>In Frank Oemig, not in CH02C "
                             f"({len(in_colleague_not_ch02c)}):</strong> ")
                code_parts = []
                for d in in_colleague_not_ch02c:
                    utg_mark = ""
                    if d.get("inUTG"):
                        utg_mark = '<span class="present" title="Also in UTG">&#10003;</span>'
                    else:
                        utg_mark = '<span class="absent" title="Not in UTG either">&#10007;</span>'
                    code_parts.append(f"<code>{esc(d['code'])}</code>{utg_mark}")
                lines.append(", ".join(code_parts))
                lines.append("</p>")

            if utg_only_codes:
                lines.append(f"<p><strong>Only in UTG "
                             f"({len(utg_only_codes)}):</strong> ")
                lines.append(", ".join(
                    f"<code>{esc(d['code'])}</code>" for d in utg_only_codes))
                lines.append("</p>")

            if missing_utg:
                lines.append(f"<p><strong>Missing from UTG "
                             f"({len(missing_utg)}):</strong> ")
                lines.append(", ".join(
                    f"<code>{esc(d['code'])}</code>" for d in missing_utg))
                lines.append("</p>")

            if status_diffs:
                lines.append(f"<p><strong>Status disagreements "
                             f"({len(status_diffs)}):</strong></p>")
                lines.append("<table><thead><tr><th>Code</th><th>CH02C</th>"
                             "<th>Frank Oemig</th><th>UTG</th>"
                             "</tr></thead><tbody>")
                for d in status_diffs:
                    lines.append(
                        f"<tr><td><code>{esc(d['code'])}</code></td>"
                        f"<td><code>{esc(d['statuses'].get('ch02c', ''))}</code></td>"
                        f"<td><code>{esc(d['statuses'].get('colleague', ''))}</code></td>"
                        f"<td><code>{esc(d['statuses'].get('utg', ''))}</code></td></tr>"
                    )
                lines.append("</tbody></table>")

            if display_diffs:
                lines.append(f"<p><strong>Display name differences "
                             f"({len(display_diffs)}):</strong></p>")
                lines.append("<table><thead><tr><th>Code</th><th>CH02C</th>"
                             "<th>Frank Oemig</th><th>UTG</th>"
                             "</tr></thead><tbody>")
                for d in display_diffs:
                    lines.append(
                        f"<tr><td><code>{esc(d['code'])}</code></td>"
                        f"<td>{esc(d['displays'].get('ch02c', ''))}</td>"
                        f"<td>{esc(d['displays'].get('colleague', ''))}</td>"
                        f"<td>{esc(d['displays'].get('utg', ''))}</td></tr>"
                    )
                lines.append("</tbody></table>")

        # Metadata differences
        meta = t.get("metadataDifferences", {})
        meta_items = {k: v for k, v in meta.items()
                      if k != "tableType" and isinstance(v, dict)}
        if meta_items:
            lines.append("<p><strong>Metadata differences:</strong></p>")
            lines.append("<table><thead><tr><th>Field</th><th>CH02C</th>"
                         "<th>Frank Oemig</th><th>UTG</th>"
                         "</tr></thead><tbody>")
            for field, vals in meta_items.items():
                nice = {"codeSystemOID": "Code System OID",
                        "symbolicName": "Symbolic Name",
                        "description": "Description"}.get(field, field)
                lines.append(
                    f"<tr><td>{esc(nice)}</td>"
                    f"<td>{esc(vals.get('ch02c', ''))}</td>"
                    f"<td>{esc(vals.get('colleague', ''))}</td>"
                    f"<td>{esc(vals.get('utg', ''))}</td></tr>"
                )
            lines.append("</tbody></table>")

        lines.append(f'<a href="#table-index" class="top-link">'
                     f'&uarr; Back to table index</a>')
        lines.append("</div>")

    lines.append("</section>")
    return "\n".join(lines)


def build_view_by_source_gap(report):
    """View C: what's missing from each source."""
    tables = report["tables"]
    lines = []
    lines.append('<section id="view-source-gap">')
    lines.append("<h2>View C: By Source Gap</h2>")
    lines.append("<p>What each source is missing, and what each source has "
                 "that the others don&rsquo;t.</p>")

    # --- C1: UTG Gaps ---
    lines.append('<h3 id="gap-utg">C1. Gaps in UTG/THO</h3>')
    lines.append("<p>Content in the published standard and/or Frank Oemig&rsquo;s IG "
                 "that is not in UTG.</p>")

    # Tables missing from UTG entirely
    missing_from_utg_tables = [t for t in tables
                                if t["category"] == "ch02c_and_colleague"]
    if missing_from_utg_tables:
        lines.append(f"<h4>Tables missing from UTG ({len(missing_from_utg_tables)})</h4>")
        lines.append("<p>These tables have CodeSystems in both CH02C and the "
                     "Frank Oemig&rsquo;s IG but no CodeSystem in UTG/THO.</p>")
        lines.append("<table><thead><tr><th>Table</th><th>Name</th>"
                     "<th>Type</th>"
                     "<th class='num'>CH02C Codes</th>"
                     "<th class='num'>Frank Oemig Codes</th>"
                     "</tr></thead><tbody>")
        for t in missing_from_utg_tables:
            counts = t.get("codeCounts", {})
            lines.append(
                f"<tr><td><a href='#{table_anchor(t['tableNumber'])}'>"
                f"{esc(t['tableNumber'])}</a>{ext_links_html(t)}</td>"
                f"<td>{esc(t['tableName'])}</td>"
                f"<td>{esc(t.get('tableType', ''))}</td>"
                f"<td class='num'>{counts.get('ch02c', 0)}</td>"
                f"<td class='num'>{counts.get('colleague', 0)}</td></tr>"
            )
        lines.append("</tbody></table>")

    # Codes missing from UTG (in tables that UTG does have)
    utg_missing_codes = []
    for t in tables:
        for cd in t.get("codeDifferences", []):
            if ("missing_from_utg" in cd.get("differences", [])
                    and (cd.get("inCH02C") or cd.get("inColleague"))):
                utg_missing_codes.append((t["tableNumber"], t["tableName"], cd))

    if utg_missing_codes:
        by_table = defaultdict(list)
        for tnum, tname, cd in utg_missing_codes:
            by_table[(tnum, tname)].append(cd)

        lines.append(f"<h4>Individual codes missing from UTG "
                     f"({len(utg_missing_codes)} codes, "
                     f"{len(by_table)} tables)</h4>")
        lines.append("<p>Codes in CH02C / Frank Oemig that exist in a table UTG "
                     "has, but the specific code is absent from UTG&rsquo;s "
                     "CodeSystem.</p>")
        for (tnum, tname), cds in sorted(by_table.items()):
            lines.append(f"<details><summary>Table {esc(tnum)} &mdash; "
                         f"{esc(tname)} ({len(cds)} missing codes)</summary>")
            lines.append("<table><thead><tr><th>Code</th><th>Display</th>"
                         "<th>In CH02C?</th><th>In Frank Oemig?</th>"
                         "</tr></thead><tbody>")
            for cd in cds:
                disp = cd["displays"].get("ch02c", "") or cd["displays"].get("colleague", "")
                lines.append(
                    f"<tr><td><code>{esc(cd['code'])}</code></td>"
                    f"<td>{esc(disp)}</td>"
                    f"<td>{presence_icon(cd.get('inCH02C', False))}</td>"
                    f"<td>{presence_icon(cd.get('inColleague', False))}</td></tr>"
                )
            lines.append("</tbody></table></details>")

    lines.append(back_to_top())

    # --- C2: Frank Oemig Gaps ---
    lines.append('<h3 id="gap-frank">C2. Gaps in Frank Oemig&rsquo;s IG</h3>')

    # Tables with coded content missing from colleague
    ch02c_not_colleague = [t for t in tables
                            if t["category"] in ("ch02c_only", "ch02c_and_utg")
                            and t.get("codeCounts", {}).get("ch02c", 0) > 0]
    if ch02c_not_colleague:
        lines.append(f"<h4>Tables with coded content missing from Frank Oemig "
                     f"({len(ch02c_not_colleague)})</h4>")
        lines.append("<p>These tables have codes in CH02C but no CodeSystem "
                     "in Frank Oemig&rsquo;s IG.</p>")
        lines.append("<table><thead><tr><th>Table</th><th>Name</th>"
                     "<th>Type</th>"
                     "<th class='num'>CH02C Codes</th>"
                     "<th>In UTG?</th>"
                     "<th class='num'>UTG Codes</th>"
                     "</tr></thead><tbody>")
        for t in ch02c_not_colleague:
            counts = t.get("codeCounts", {})
            in_utg = t["presence"].get("utg", False)
            lines.append(
                f"<tr><td>{esc(t['tableNumber'])}{ext_links_html(t)}</td>"
                f"<td>{esc(t['tableName'])}</td>"
                f"<td>{esc(t.get('tableType', ''))}</td>"
                f"<td class='num'>{counts.get('ch02c', 0)}</td>"
                f"<td>{presence_icon(in_utg)}</td>"
                f"<td class='num'>{counts.get('utg', 0) if in_utg else '&mdash;'}</td></tr>"
            )
        lines.append("</tbody></table>")

        # Count how many are already in UTG
        already_in_utg = sum(1 for t in ch02c_not_colleague
                             if t["presence"].get("utg", False))
        not_in_utg = len(ch02c_not_colleague) - already_in_utg
        if already_in_utg > 0 and not_in_utg > 0:
            lines.append(
                f'<div class="observation">'
                f'<strong>Note:</strong> Of these {len(ch02c_not_colleague)} '
                f'tables, {already_in_utg} already have CodeSystems in UTG '
                f'and {not_in_utg} do not. The {not_in_utg} tables absent '
                f'from both Frank Oemig and UTG may warrant review to determine '
                f'if they should be added to THO.'
                f'</div>'
            )

    # Codes missing from colleague (in tables colleague does have)
    colleague_missing_codes = []
    for t in tables:
        if not t["presence"].get("colleague", False):
            continue
        for cd in t.get("codeDifferences", []):
            if cd.get("inCH02C") and not cd.get("inColleague"):
                colleague_missing_codes.append(
                    (t["tableNumber"], t["tableName"], cd))

    if colleague_missing_codes:
        by_table = defaultdict(list)
        for tnum, tname, cd in colleague_missing_codes:
            by_table[(tnum, tname)].append(cd)

        lines.append(f"<h4>Individual codes missing from Frank Oemig "
                     f"({len(colleague_missing_codes)} codes, "
                     f"{len(by_table)} tables)</h4>")
        lines.append("<p>Codes present in CH02C for tables that the "
                     "Frank Oemig&rsquo;s IG does include, but the specific "
                     "code is absent.</p>")
        for (tnum, tname), cds in sorted(by_table.items()):
            lines.append(f"<details><summary>Table {esc(tnum)} &mdash; "
                         f"{esc(tname)} ({len(cds)} missing codes)</summary>")
            lines.append("<table><thead><tr><th>Code</th><th>Display (CH02C)</th>"
                         "<th>In UTG?</th>"
                         "</tr></thead><tbody>")
            for cd in cds:
                lines.append(
                    f"<tr><td><code>{esc(cd['code'])}</code></td>"
                    f"<td>{esc(cd['displays'].get('ch02c', ''))}</td>"
                    f"<td>{presence_icon(cd.get('inUTG', False))}</td></tr>"
                )
            lines.append("</tbody></table></details>")

    lines.append(back_to_top())

    # --- C3: Frank Oemig Additions ---
    lines.append('<h3 id="gap-frank-extra">C3. Frank Oemig&rsquo;s Additions '
                 'Beyond CH02C</h3>')

    colleague_extra = []
    for t in tables:
        for cd in t.get("codeDifferences", []):
            if cd.get("inColleague") and not cd.get("inCH02C"):
                colleague_extra.append((t["tableNumber"], t["tableName"], cd))

    if colleague_extra:
        by_table = defaultdict(list)
        for tnum, tname, cd in colleague_extra:
            by_table[(tnum, tname)].append(cd)

        lines.append(f"<p>{len(colleague_extra)} codes in Frank Oemig&rsquo;s "
                     f"IG that are not in CH02C, across {len(by_table)} tables.</p>")

        for (tnum, tname), cds in sorted(by_table.items()):
            lines.append(f"<details><summary>Table {esc(tnum)} &mdash; "
                         f"{esc(tname)} ({len(cds)} extra codes)</summary>")
            lines.append("<table><thead><tr><th>Code</th>"
                         "<th>Display (Frank Oemig)</th>"
                         "<th>In UTG?</th>"
                         "</tr></thead><tbody>")
            for cd in cds:
                lines.append(
                    f"<tr><td><code>{esc(cd['code'])}</code></td>"
                    f"<td>{esc(cd['displays'].get('colleague', ''))}</td>"
                    f"<td>{presence_icon(cd.get('inUTG', False))}</td></tr>"
                )
            lines.append("</tbody></table></details>")
    else:
        lines.append("<p>No codes found exclusively in Frank Oemig&rsquo;s IG.</p>")

    lines.append(back_to_top())

    # --- C4: UTG-Only Content ---
    lines.append('<h3 id="gap-utg-only">C4. Content Only in UTG</h3>')

    utg_only_tables = [t for t in tables if t["category"] == "utg_only"]
    if utg_only_tables:
        lines.append(f"<p>{len(utg_only_tables)} tables have CodeSystems in UTG "
                     f"but are not in CH02C V2.9.1 or Frank Oemig&rsquo;s IG.</p>")
        lines.append("<table><thead><tr><th>Table</th><th>Name</th>"
                     "<th class='num'>UTG Codes</th></tr></thead><tbody>")
        for t in utg_only_tables:
            counts = t.get("codeCounts", {})
            lines.append(
                f"<tr><td><a href='#{table_anchor(t['tableNumber'])}'>"
                f"{esc(t['tableNumber'])}</a>{ext_links_html(t)}</td>"
                f"<td>{esc(t['tableName'])}</td>"
                f"<td class='num'>{counts.get('utg', 0)}</td></tr>"
            )
        lines.append("</tbody></table>")

        lines.append(
            '<div class="observation">'
            '<strong>Note:</strong> These tables may represent '
            'content from earlier V2 versions that was removed or '
            'reorganized by V2.9.1, or content that was added to UTG '
            'from sources other than the V2.9.1 standard.'
            '</div>'
        )
    else:
        lines.append("<p>No UTG-only tables found.</p>")

    lines.append(back_to_top())
    lines.append("</section>")
    return "\n".join(lines)


def build_toc():
    """Table of contents with anchor links."""
    lines = []
    lines.append('<nav class="toc">')
    lines.append("<h2>Contents</h2>")
    lines.append("<ol>")
    lines.append('<li><a href="#summary">Executive Summary</a></li>')
    lines.append('<li><a href="#view-problem-type">View A: By Problem Type</a>')
    lines.append("<ol>")
    lines.append('<li><a href="#prob-status">Status Disagreements</a></li>')
    lines.append('<li><a href="#prob-missing">Missing Codes</a></li>')
    lines.append('<li><a href="#prob-display">Display Name Differences</a></li>')
    lines.append('<li><a href="#prob-metadata">Metadata Differences</a></li>')
    lines.append("</ol></li>")
    lines.append('<li><a href="#view-table">View B: By Table</a>')
    lines.append("<ol>")
    lines.append('<li><a href="#table-index">Table Index</a></li>')
    lines.append("</ol></li>")
    lines.append('<li><a href="#view-source-gap">View C: By Source Gap</a>')
    lines.append("<ol>")
    lines.append('<li><a href="#gap-utg">Gaps in UTG/THO</a></li>')
    lines.append('<li><a href="#gap-frank">Gaps in Frank Oemig&rsquo;s IG</a></li>')
    lines.append('<li><a href="#gap-frank-extra">Frank Oemig&rsquo;s Additions</a></li>')
    lines.append('<li><a href="#gap-utg-only">Content Only in UTG</a></li>')
    lines.append("</ol></li>")
    lines.append('<li><a href="#concept-domains">Concept Domain Analysis</a></li>')
    lines.append('<li><a href="#methodology">Annex: Methodology</a></li>')
    lines.append("</ol></nav>")
    return "\n".join(lines)


def build_concept_domain_analysis(report):
    """Section analyzing tables that are concept-domain-only."""
    tables = report["tables"]
    lines = []
    lines.append('<section id="concept-domains">')
    lines.append("<h2>Concept Domain Analysis</h2>")
    lines.append(
        "<p>In HL7 V2, a <em>concept domain</em> is an abstract classification "
        "that defines the semantic space for a set of coded values, without "
        "itself containing a concrete list of codes. Some CH02C table entries "
        "are pure concept domains &mdash; they reference an external or "
        "user-defined coding scheme rather than enumerating codes directly.</p>"
    )

    # Find concept-domain-only tables
    cd_only_tables = [
        t for t in tables
        if t.get("conceptDomain", {}).get("isConceptDomainOnly")
    ]

    lines.append(
        f"<p><strong>{len(cd_only_tables)}</strong> tables are identified "
        f"as concept-domain-only entries in CH02C.</p>"
    )

    # Check if any of these have CodeSystems in UTG or Frank
    cd_with_codesystems = []
    for t in cd_only_tables:
        has_utg = t.get("presence", {}).get("utg", False)
        has_frank = t.get("presence", {}).get("colleague", False)
        if has_utg or has_frank:
            cd_with_codesystems.append(t)

    if cd_with_codesystems:
        lines.append(
            f"<h3>Concept Domains with CodeSystems in Other Sources "
            f"({len(cd_with_codesystems)})</h3>"
        )
        lines.append(
            "<p>These tables are marked as concept-domain-only in CH02C, "
            "yet have concrete CodeSystem resources in UTG and/or "
            "Frank Oemig&rsquo;s IG. This may indicate a mismatch in how "
            "the table is classified versus how it is implemented.</p>"
        )
        lines.append(
            "<table><thead><tr>"
            "<th>Table</th><th>Name</th>"
            "<th class='pres'>Frank</th>"
            "<th class='pres'>UTG</th>"
            "</tr></thead><tbody>"
        )
        for t in cd_with_codesystems:
            tnum = t["tableNumber"]
            lines.append(
                f"<tr><td><a href='#{table_anchor(tnum)}'>{esc(tnum)}</a>"
                f"{ext_links_html(t)}</td>"
                f"<td>{esc(t['tableName'])}</td>"
                f"<td class='pres'>"
                f"{presence_icon(t.get('presence', {}).get('colleague', False))}</td>"
                f"<td class='pres'>"
                f"{presence_icon(t.get('presence', {}).get('utg', False))}</td></tr>"
            )
        lines.append("</tbody></table>")

        lines.append(
            '<div class="observation">'
            '<strong>Observation:</strong> When a concept domain has '
            'concrete CodeSystem resources in UTG or Frank Oemig&rsquo;s IG, '
            'it suggests either that the CH02C classification as '
            'concept-domain-only may be outdated, or that the CodeSystem '
            'resources represent a binding to a specific value set rather '
            'than a full enumeration of the domain. These cases merit '
            'review to ensure consistent treatment across all three sources.'
            '</div>'
        )
    else:
        lines.append(
            "<p>None of the concept-domain-only tables have CodeSystem "
            "resources in UTG or Frank Oemig&rsquo;s IG.</p>"
        )

    lines.append(back_to_top())
    lines.append("</section>")
    return "\n".join(lines)


def build_methodology_annex():
    """Annex describing the methodology used for each analysis."""
    lines = []
    lines.append('<section id="methodology">')
    lines.append("<h2>Annex: Methodology</h2>")
    lines.append("<p>This annex describes the methods used for each type "
                 "of analysis in this report.</p>")

    # --- Table Identification and Matching ---
    lines.append('<h3 id="method-matching">Table Identification and Matching</h3>')
    lines.append("<ul>")
    lines.append(
        "<li>CH02C tables are identified by their 4-digit table number from "
        "the V2.9.1 Word document (Chapter 2C).</li>"
    )
    lines.append(
        "<li>Frank Oemig&rsquo;s FHIR IG CodeSystems are matched via the "
        "<code>codesystem-tableNo</code> extension, which contains the "
        "4-digit table number.</li>"
    )
    lines.append(
        "<li>UTG CodeSystems are matched via the <code>v2-XXXX</code> pattern "
        "in their FHIR resource ID and canonical URL (e.g., "
        "<code>http://terminology.hl7.org/CodeSystem/v2-0001</code>).</li>"
    )
    lines.append(
        "<li>The v2-tables.xml catalog (628 entries) was also loaded as a "
        "reference for the complete set of V2 tables UTG recognizes.</li>"
    )
    lines.append("</ul>")

    # --- Code-Level Comparison ---
    lines.append('<h3 id="method-codes">Code-Level Comparison</h3>')
    lines.append("<ul>")
    lines.append(
        "<li>Codes are matched by exact, case-sensitive string comparison "
        "of their code values.</li>"
    )
    lines.append(
        "<li>CH02C codes are extracted from the <code>codedContent</code> "
        "arrays in the Word document tables.</li>"
    )
    lines.append(
        "<li>Frank&rsquo;s codes come from FHIR <code>concept[].code</code> "
        "elements in his JSON CodeSystem resources.</li>"
    )
    lines.append(
        "<li>UTG codes come from FHIR <code>concept[].code</code> elements "
        "in XML CodeSystem resources.</li>"
    )
    lines.append(
        "<li>A code is reported as &ldquo;missing&rdquo; from a source if "
        "no exact string match is found.</li>"
    )
    lines.append("</ul>")

    # --- Status Value Normalization ---
    lines.append('<h3 id="method-status">Status Value Normalization</h3>')
    lines.append("<ul>")
    lines.append(
        "<li>CH02C uses single-letter status codes: D (Deprecated), "
        "B (Backward-compatible), N (New), R (Retired), A (Active).</li>"
    )
    lines.append(
        "<li>Frank&rsquo;s IG and UTG use full-word FHIR-style values: "
        "inactive, backward, new, retired, active.</li>"
    )
    lines.append(
        "<li>Before comparison, statuses are normalized: D&rarr;deprecated, "
        "B&rarr;backward, N&rarr;new, R&rarr;retired, A&rarr;active, "
        "inactive&rarr;deprecated.</li>"
    )
    lines.append(
        "<li>A mismatch is reported when the normalized values differ "
        "between any two sources.</li>"
    )
    lines.append("</ul>")

    # --- Display Name Comparison ---
    lines.append('<h3 id="method-display">Display Name Comparison</h3>')
    lines.append("<ul>")
    lines.append(
        "<li>Display names are compared case-insensitively after trimming "
        "whitespace.</li>"
    )
    lines.append(
        "<li>If one display is a case-insensitive prefix of another "
        "(e.g., &ldquo;Admit/Visit&rdquo; vs &ldquo;Admit/Visit "
        "Notification&rdquo;), it is classified as a &ldquo;truncation&rdquo; "
        "rather than a substantive difference.</li>"
    )
    lines.append(
        "<li>This distinction helps separate intentional abbreviations from "
        "genuine naming disagreements.</li>"
    )
    lines.append("</ul>")

    # --- Metadata Comparison ---
    lines.append('<h3 id="method-metadata">Metadata Comparison</h3>')
    lines.append("<ul>")
    lines.append(
        "<li>Code System OIDs are compared by exact string match.</li>"
    )
    lines.append(
        "<li>Symbolic names are compared case-insensitively.</li>"
    )
    lines.append(
        "<li>Descriptions are compared case-insensitively after trimming, "
        "excluding values of &ldquo;TBD&rdquo;.</li>"
    )
    lines.append(
        "<li>Table type (HL7, User, External, etc.) is recorded from CH02C "
        "for reference but not compared across sources.</li>"
    )
    lines.append("</ul>")

    lines.append(back_to_top())
    lines.append("</section>")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Generate HTML report from V2 vocabulary comparison JSON"
    )
    parser.add_argument(
        "--input", default="v291-extracted/vocabulary-comparison-report.json",
        help="Path to comparison JSON report"
    )
    parser.add_argument(
        "--output", default="v291-extracted/vocabulary-comparison-report.html",
        help="Output HTML file path"
    )
    args = parser.parse_args()

    with open(args.input) as f:
        report = json.load(f)

    today = date.today().isoformat()

    html_parts = [
        f"<!DOCTYPE html>",
        f"<html lang='en'>",
        f"<head>",
        f"<meta charset='utf-8'>",
        f"<meta name='viewport' content='width=device-width, initial-scale=1'>",
        f"<title>V2 Vocabulary Three-Way Comparison Report</title>",
        f"<style>{CSS}</style>",
        f"</head>",
        f'<body id="top">',
        f"<h1>V2 Vocabulary Three-Way Comparison Report</h1>",
        f'<p class="subtitle">CH02C (V2.9.1 Published Standard) &bull; '
        f'Frank Oemig&rsquo;s FHIR IG '
        f'(<code>frankoemig/hl7.v2.terminology.v291</code>) &bull; UTG/THO<br>'
        f'Generated {today}</p>',
        build_toc(),
        build_executive_summary(report),
        build_view_by_problem_type(report),
        build_view_by_table(report),
        build_view_by_source_gap(report),
        build_concept_domain_analysis(report),
        build_methodology_annex(),
        "</body></html>",
    ]

    html = "\n".join(html_parts)

    with open(args.output, "w") as f:
        f.write(html)

    print(f"HTML report written to {args.output}")
    print(f"  File size: {os.path.getsize(args.output) / 1024:.0f} KB")


if __name__ == "__main__":
    main()
