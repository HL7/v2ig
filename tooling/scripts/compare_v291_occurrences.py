#!/usr/bin/env python3
"""Compare multiple occurrences of the same message structure within V2.9.1.

When the same structure ID (e.g., ADT_A01) appears in multiple places in the
Word docs (for different events sharing that structure), the tables should be
identical. This script finds and categorizes any differences.

Produces an HTML report with:
  - Summary table of structures with discrepancies
  - Per-structure detail showing each row-level difference
  - Provenance (chapter, section, table) for each occurrence

Usage:
    python3 tooling/scripts/compare_v291_occurrences.py
"""

import json
import os
import re
import sys
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT

V291_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'message-structures')
REPORT_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted')


def normalize_bracket_notation(s):
    """Normalize bracket/brace whitespace for comparison."""
    s = s.strip()
    # Collapse internal whitespace
    s = re.sub(r'\s+', ' ', s)
    # Normalize: [ { CODE } ] → [{ CODE }]
    s = s.replace('[ {', '[{').replace('} ]', '}]')
    s = s.replace('[ [', '[[').replace('] ]', ']]')
    # Normalize spaces inside brackets: [  CODE  ] → [ CODE ]
    s = re.sub(r'\[\s+', '[ ', s)
    s = re.sub(r'\s+\]', ' ]', s)
    s = re.sub(r'\{\s+', '{ ', s)
    s = re.sub(r'\s+\}', ' }', s)
    # Final trim
    return s.strip()


def extract_segment_code(seg_str):
    """Extract bare segment code from bracket notation."""
    return re.sub(r'[\[\]{}<>|]', '', seg_str).strip()


def classify_difference(seg_a, seg_b, desc_a, desc_b):
    """Classify a row difference.

    Returns (category, detail) where category is one of:
      'whitespace' - only bracket/space differences (cosmetic)
      'optionality' - different optionality/repetition
      'description' - different description text
      'chapter_ref' - different chapter reference
      'segment_diff' - different segment codes
      'row_count' - structure has different number of rows
    """
    norm_a = normalize_bracket_notation(seg_a)
    norm_b = normalize_bracket_notation(seg_b)
    code_a = extract_segment_code(seg_a)
    code_b = extract_segment_code(seg_b)

    if norm_a == norm_b and desc_a == desc_b:
        return None, None

    if norm_a == norm_b:
        # Same segment notation, different description
        if desc_a.lower().strip() == desc_b.lower().strip():
            return 'whitespace', f'Description case: "{desc_a}" vs "{desc_b}"'
        return 'description', f'"{desc_a}" vs "{desc_b}"'

    if code_a == code_b:
        # Same segment code, different brackets
        return 'optionality', f'`{seg_a.strip()}` vs `{seg_b.strip()}`'

    return 'segment_diff', f'`{seg_a.strip()}` vs `{seg_b.strip()}`'


def compare_occurrences(occurrences):
    """Compare all occurrences of a structure ID.

    Uses the first occurrence as the reference and compares all others against it.

    Returns list of discrepancy dicts.
    """
    if len(occurrences) < 2:
        return []

    ref = occurrences[0]
    ref_rows = ref['rawRows']
    ref_prov = ref.get('provenance', {})
    discrepancies = []

    for occ in occurrences[1:]:
        occ_rows = occ['rawRows']
        occ_prov = occ.get('provenance', {})

        # Compare row counts
        if len(ref_rows) != len(occ_rows):
            discrepancies.append({
                'type': 'row_count',
                'detail': f'{len(ref_rows)} rows vs {len(occ_rows)} rows',
                'ref_prov': ref_prov,
                'occ_prov': occ_prov,
                'position': 0,
            })

        # Compare row by row (up to the shorter one)
        max_rows = max(len(ref_rows), len(occ_rows))
        for i in range(max_rows):
            if i >= len(ref_rows):
                discrepancies.append({
                    'type': 'extra_row',
                    'detail': f'Extra row in occurrence: `{occ_rows[i]["segments"]}` ({occ_rows[i]["description"]})',
                    'ref_prov': ref_prov,
                    'occ_prov': occ_prov,
                    'position': i + 1,
                })
                continue
            if i >= len(occ_rows):
                discrepancies.append({
                    'type': 'missing_row',
                    'detail': f'Missing row from occurrence: `{ref_rows[i]["segments"]}` ({ref_rows[i]["description"]})',
                    'ref_prov': ref_prov,
                    'occ_prov': occ_prov,
                    'position': i + 1,
                })
                continue

            r_seg = ref_rows[i]['segments']
            o_seg = occ_rows[i]['segments']
            r_desc = ref_rows[i]['description']
            o_desc = occ_rows[i]['description']

            cat, detail = classify_difference(r_seg, o_seg, r_desc, o_desc)
            if cat:
                # Also check chapter reference
                r_ch = ref_rows[i].get('chapter', '')
                o_ch = occ_rows[i].get('chapter', '')
                ch_note = ''
                if r_ch != o_ch:
                    ch_note = f' (chapter ref: "{r_ch}" vs "{o_ch}")'

                discrepancies.append({
                    'type': cat,
                    'detail': detail + ch_note,
                    'ref_prov': ref_prov,
                    'occ_prov': occ_prov,
                    'position': i + 1,
                    'segment': extract_segment_code(r_seg) or extract_segment_code(o_seg),
                })

    return discrepancies


def generate_html_report(all_results):
    """Generate navigable HTML report."""
    timestamp = datetime.now(timezone.utc).isoformat()

    # Compute summaries
    structures_with_diffs = {sid: res for sid, res in all_results.items() if res['discrepancies']}
    total_discs = sum(len(r['discrepancies']) for r in structures_with_diffs.values())

    # Categorize
    cat_counts = defaultdict(int)
    for sid, res in structures_with_diffs.items():
        for d in res['discrepancies']:
            cat_counts[d['type']] += 1

    html = []
    html.append('<!DOCTYPE html>')
    html.append('<html lang="en"><head><meta charset="utf-8">')
    html.append('<title>V2.9.1 Message Structure Internal Consistency Report</title>')
    html.append('<style>')
    html.append('''
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 0; display: flex; }
#sidebar { width: 260px; min-width: 260px; height: 100vh; overflow-y: auto; background: #f6f8fa;
           border-right: 1px solid #d0d7de; padding: 12px; position: sticky; top: 0; font-size: 13px; }
#content { flex: 1; padding: 24px 32px; max-width: 1100px; }
h1 { font-size: 24px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 20px; margin-top: 32px; border-bottom: 1px solid #d0d7de; padding-bottom: 6px; }
h3 { font-size: 16px; margin-top: 24px; }
table { border-collapse: collapse; width: 100%; margin: 8px 0; }
th, td { border: 1px solid #d0d7de; padding: 6px 10px; text-align: left; font-size: 14px; }
th { background: #f6f8fa; font-weight: 600; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; margin-right: 4px; }
.badge-optionality { background: #fdd; color: #b00; }
.badge-description { background: #fff3cd; color: #856404; }
.badge-whitespace { background: #e8f4e8; color: #070; }
.badge-row-count { background: #e3f2fd; color: #1565c0; }
.badge-segment { background: #f3e5f5; color: #6a1b9a; }
.badge-chapter { background: #e0f2f1; color: #004d40; }
.sidebar-section { margin-bottom: 12px; }
.sidebar-section h3 { font-size: 13px; margin: 8px 0 4px 0; color: #57606a; text-transform: uppercase; letter-spacing: 0.5px; }
.sidebar-section a { display: block; padding: 2px 4px; color: #0969da; text-decoration: none; font-size: 13px; }
.sidebar-section a:hover { background: #ddf4ff; border-radius: 4px; }
.provenance { font-size: 12px; color: #57606a; margin: 2px 0; }
code { background: #f6f8fa; padding: 2px 6px; border-radius: 4px; font-size: 13px; }
.structure-section { margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #eee; }
.disc-item { margin: 6px 0; padding: 4px 0 4px 12px; border-left: 3px solid #d0d7de; }
.disc-item.optionality { border-left-color: #cf222e; }
.disc-item.description { border-left-color: #bf8700; }
.disc-item.whitespace { border-left-color: #2da44e; }
.disc-item.row_count, .disc-item.extra_row, .disc-item.missing_row { border-left-color: #0969da; }
.disc-item.segment_diff { border-left-color: #8250df; }
.filter-input { width: 100%; padding: 4px 8px; border: 1px solid #d0d7de; border-radius: 4px; margin-bottom: 8px; font-size: 13px; }
.occ-table { font-size: 13px; margin: 8px 0; }
.occ-table td { padding: 3px 8px; }
    ''')
    html.append('</style></head><body>')

    # Sidebar
    html.append('<div id="sidebar">')
    html.append('<h2 style="margin-top:0; font-size: 16px;">Structure Index</h2>')
    html.append(f'<p style="font-size: 12px; color: #57606a;">{len(structures_with_diffs)} structures with differences</p>')
    html.append('<input class="filter-input" id="sidebar-filter" placeholder="Filter..." '
                'oninput="filterSidebar(this.value)">')
    html.append('<div class="sidebar-section">')
    for sid in sorted(structures_with_diffs.keys()):
        n = len(structures_with_diffs[sid]['discrepancies'])
        n_occ = len(structures_with_diffs[sid]['occurrences'])
        html.append(f'<a href="#{sid}" class="sidebar-item">{sid} '
                     f'<span class="badge badge-optionality">{n}</span> '
                     f'<span style="color:#888">({n_occ} occ)</span></a>')
    html.append('</div></div>')

    # Content
    html.append('<div id="content">')
    html.append('<h1>V2.9.1 Message Structure Internal Consistency Report</h1>')
    html.append(f'<p class="provenance">Generated: {timestamp}</p>')
    html.append('<p>Compares multiple occurrences of the same message structure ID within '
                'V2.9.1 Word documents. When a structure like ADT_A01 appears in multiple '
                'tables (for different events), the content should be identical. This report '
                'flags differences.</p>')

    # Summary
    html.append('<h2>Summary</h2>')
    html.append('<table>')
    html.append(f'<tr><th>Total structure IDs with multiple occurrences</th>'
                f'<td>{sum(1 for r in all_results.values() if len(r["occurrences"]) > 1)}</td></tr>')
    html.append(f'<tr><th>Structure IDs with discrepancies</th>'
                f'<td><strong>{len(structures_with_diffs)}</strong></td></tr>')
    html.append(f'<tr><th>Total discrepancies</th><td>{total_discs}</td></tr>')
    html.append('</table>')

    html.append('<h3>By Category</h3>')
    html.append('<table>')
    cat_labels = {
        'optionality': ('Optionality/repetition', 'badge-optionality'),
        'description': ('Description text', 'badge-description'),
        'whitespace': ('Whitespace/case', 'badge-whitespace'),
        'row_count': ('Row count mismatch', 'badge-row-count'),
        'extra_row': ('Extra row in occurrence', 'badge-row-count'),
        'missing_row': ('Missing row in occurrence', 'badge-row-count'),
        'segment_diff': ('Different segment codes', 'badge-segment'),
    }
    for cat, (label, badge_cls) in cat_labels.items():
        if cat_counts.get(cat, 0) > 0:
            html.append(f'<tr><td><span class="badge {badge_cls}">{label}</span></td>'
                         f'<td>{cat_counts[cat]}</td></tr>')
    html.append('</table>')

    # Per-structure detail
    html.append('<h2>Discrepancies by Structure</h2>')
    for sid in sorted(structures_with_diffs.keys()):
        res = structures_with_diffs[sid]
        discs = res['discrepancies']
        occs = res['occurrences']

        html.append(f'<div class="structure-section" id="{sid}">')
        html.append(f'<h3>{sid} <span class="badge badge-optionality">{len(discs)} differences</span></h3>')

        # Show all occurrences with provenance
        html.append('<table class="occ-table"><tr><th>#</th><th>Chapter</th>'
                     '<th>Section</th><th>Table</th><th>Rows</th></tr>')
        for oi, occ in enumerate(occs):
            prov = occ.get('provenance', {})
            is_ref = ' (reference)' if oi == 0 else ''
            html.append(f'<tr><td>{oi+1}{is_ref}</td>'
                         f'<td>CH{prov.get("chapter","?")}</td>'
                         f'<td>{_html_esc(prov.get("sectionHeading","")[:60])}</td>'
                         f'<td>{prov.get("tableIndex","?")}</td>'
                         f'<td>{len(occ["rawRows"])}</td></tr>')
        html.append('</table>')

        # Show discrepancies
        for d in discs:
            cat = d['type']
            label, badge_cls = cat_labels.get(cat, (cat, 'badge-optionality'))
            occ_prov = d.get('occ_prov', {})
            pos = d.get('position', '?')
            seg = d.get('segment', '')

            html.append(f'<div class="disc-item {cat}">')
            html.append(f'<span class="badge {badge_cls}">{label}</span>')
            if seg:
                html.append(f' <strong>{seg}</strong>')
            if pos:
                html.append(f' (row {pos})')
            html.append(f'<br>{_html_esc(d["detail"])}')
            html.append(f'<br><span class="provenance">vs CH{occ_prov.get("chapter","?")}, '
                         f'"{_html_esc(occ_prov.get("sectionHeading","")[:50])}"</span>')
            html.append('</div>')

        html.append('</div>')

    # Consistent structures section
    consistent = {sid: r for sid, r in all_results.items()
                  if len(r['occurrences']) > 1 and not r['discrepancies']}
    if consistent:
        html.append('<h2>Consistent Structures (No Differences)</h2>')
        html.append(f'<p>{len(consistent)} structures have multiple identical occurrences:</p>')
        html.append('<table><tr><th>Structure</th><th>Occurrences</th></tr>')
        for sid in sorted(consistent.keys()):
            html.append(f'<tr><td>{sid}</td><td>{len(consistent[sid]["occurrences"])}</td></tr>')
        html.append('</table>')

    html.append('</div>')

    # JS
    html.append('<script>')
    html.append('''
function filterSidebar(q) {
    q = q.toLowerCase();
    document.querySelectorAll('.sidebar-item').forEach(function(a) {
        a.style.display = a.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
    ''')
    html.append('</script></body></html>')

    path = os.path.join(REPORT_DIR, 'v291-internal-consistency-report.html')
    with open(path, 'w') as f:
        f.write('\n'.join(html))
    print(f"HTML report: {path}")
    return path


def _html_esc(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


def main():
    print("Loading V291 message structures...")
    structures = defaultdict(list)
    for fname in sorted(os.listdir(V291_DIR)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(V291_DIR, fname)
        data = json.load(open(fpath))
        sid = data.get('structureId', '')
        if sid:
            structures[sid].append(data)

    print(f"  {sum(len(v) for v in structures.values())} occurrences, "
          f"{len(structures)} unique IDs")

    multi = {sid: occs for sid, occs in structures.items() if len(occs) > 1}
    print(f"  {len(multi)} IDs with multiple occurrences")

    print("\nComparing occurrences...")
    all_results = {}
    total_discs = 0
    for sid in sorted(structures.keys()):
        occs = structures[sid]
        # Sort occurrences by chapter/table for stable ordering
        occs.sort(key=lambda x: (x.get('provenance', {}).get('chapter', ''),
                                  x.get('provenance', {}).get('tableIndex', 0)))
        discs = compare_occurrences(occs)
        all_results[sid] = {
            'occurrences': occs,
            'discrepancies': discs,
        }
        if discs:
            total_discs += len(discs)

    structures_with_diffs = sum(1 for r in all_results.values() if r['discrepancies'])
    print(f"  {structures_with_diffs} structures with discrepancies, {total_discs} total differences")

    print("\nGenerating report...")
    generate_html_report(all_results)

    print(f"\n{'='*60}")
    print(f"V291 Internal Consistency Report Complete")
    print(f"{'='*60}")
    print(f"Multi-occurrence structures: {len(multi)}")
    print(f"With discrepancies: {structures_with_diffs}")
    print(f"Total differences: {total_discs}")
    print(f"{'='*60}")


if __name__ == '__main__':
    main()
