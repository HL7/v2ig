#!/usr/bin/env python3
"""Generate comprehensive V2.9.1 message structure review report for V2 Management Group.

Combines:
  - Internal consistency analysis (multi-occurrence discrepancies)
  - Structural cardinality recommendations
  - PRT/OBX description audit findings
  - Applied fixes summary
  - Per-structure provenance with event/message mappings

Usage:
    python3 tooling/scripts/generate_v291_review_report.py
"""

import json
import os
import re
import sys
from collections import defaultdict
from datetime import datetime, timezone

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT

CANONICAL_DIR = os.path.join(PROJECT_ROOT, 'v291-canonical', 'message-structures')
FIXES_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'fixes.json')
PRT_AUDIT_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'prt-obx-description-audit.txt')
EVENTS_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'events')
REPORT_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'v291-review-report.html')


def esc(s):
    """HTML-escape a string."""
    return str(s).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


def load_canonical_structures():
    """Load canonical message structures grouped by structureId."""
    by_id = defaultdict(list)
    for fname in sorted(os.listdir(CANONICAL_DIR)):
        if not fname.endswith('.json'):
            continue
        with open(os.path.join(CANONICAL_DIR, fname)) as f:
            data = json.load(f)
        data['_filename'] = fname
        by_id[data['structureId']].append(data)
    # Sort each group by chapter/tableIndex
    for sid in by_id:
        by_id[sid].sort(key=lambda x: (
            x.get('provenance', {}).get('chapter', ''),
            x.get('provenance', {}).get('tableIndex', 0)
        ))
    return by_id


def load_events():
    """Load event→structure mappings from extracted events."""
    events = defaultdict(list)  # structureId → list of event info
    if not os.path.isdir(EVENTS_DIR):
        return events
    for fname in sorted(os.listdir(EVENTS_DIR)):
        if not fname.endswith('.json'):
            continue
        with open(os.path.join(EVENTS_DIR, fname)) as f:
            data = json.load(f)
        sid = data.get('structureId', '')
        if sid:
            events[sid].append({
                'eventCode': data.get('eventCode', ''),
                'messageType': data.get('messageType', ''),
                'name': data.get('name', ''),
            })
    return events


def load_fixes():
    """Load applied fixes."""
    with open(FIXES_FILE) as f:
        data = json.load(f)
    return data.get('fixes', [])


def extract_segment_code(seg_str):
    """Extract bare segment code from bracket notation."""
    return re.sub(r'[\[\]{}<>|\s]', '', seg_str).strip()


def compare_occurrences(occs):
    """Compare occurrences of a structure, returning structured differences."""
    if len(occs) < 2:
        return []

    ref = occs[0]
    ref_rows = ref['rawRows']
    diffs = []

    for occ in occs[1:]:
        occ_rows = occ['rawRows']
        clause = occ['provenance'].get('clause', '?')
        caption = occ['provenance'].get('captionText', '')

        if len(occ_rows) != len(ref_rows):
            diffs.append({
                'clause': clause,
                'caption': caption,
                'category': 'row_count',
                'row': 0,
                'segment': '',
                'ref_value': f'{len(ref_rows)} rows',
                'occ_value': f'{len(occ_rows)} rows',
            })
            continue

        for i in range(len(ref_rows)):
            r = ref_rows[i]
            o = occ_rows[i]

            if r['segments'] != o['segments']:
                seg_code = extract_segment_code(r['segments']) or extract_segment_code(o['segments'])
                cat = classify_segment_diff(r['segments'], o['segments'])
                diffs.append({
                    'clause': clause,
                    'caption': caption,
                    'category': cat,
                    'row': i + 1,
                    'segment': seg_code,
                    'ref_value': r['segments'],
                    'occ_value': o['segments'],
                })

            if r['description'] != o['description']:
                seg_code = extract_segment_code(r['segments'])
                cat = classify_desc_diff(r['description'], o['description'])
                diffs.append({
                    'clause': clause,
                    'caption': caption,
                    'category': cat,
                    'row': i + 1,
                    'segment': seg_code,
                    'ref_value': r['description'],
                    'occ_value': o['description'],
                })

    return diffs


def classify_segment_diff(a, b):
    """Classify a segments-column difference."""
    code_a = extract_segment_code(a)
    code_b = extract_segment_code(b)
    if code_a != code_b:
        return 'segment_code'

    opt_a = '[' in a
    opt_b = '[' in b
    rep_a = '{' in a
    rep_b = '{' in b

    if opt_a != opt_b or rep_a != rep_b:
        return 'cardinality'
    return 'bracket_whitespace'


def classify_desc_diff(a, b):
    """Classify a description difference."""
    # Extraction artifact (bracket notation as description)
    if re.match(r'^[\[\]{}\s.]*[A-Z]{2,4}[\[\]{}\s.]*$', b.strip()):
        return 'extraction_artifact'
    if re.match(r'^[\[\]{}\s.]*[A-Z]{2,4}[\[\]{}\s.]*$', a.strip()):
        return 'extraction_artifact'

    # Group markers
    if a.startswith('---') or b.startswith('---'):
        return 'group_name'
    if a.strip() in ('[', ']', '{', '}', '[{', '}]', '[...]'):
        return 'extraction_artifact'
    if b.strip() in ('[', ']', '{', '}', '[{', '}]', '[...]'):
        return 'extraction_artifact'

    # PRT descriptions with parenthetical qualifiers
    if 'Participation' in a or 'Participation' in b:
        return 'prt_qualifier'

    # NTE descriptions
    if 'Notes and comments' in a.lower() or 'Notes and comments' in b.lower():
        return 'nte_description'

    # Singular/plural
    al = a.lower().strip()
    bl = b.lower().strip()
    if al.rstrip('s') == bl.rstrip('s'):
        return 'desc_cosmetic'

    # Other
    return 'desc_other'


def cardinality_recommendation(ref_val, occ_val, segment, consensus_count, minority_count):
    """Generate a recommendation for a cardinality difference."""
    ref_opt = '[' in ref_val
    ref_rep = '{' in ref_val
    occ_opt = '[' in occ_val
    occ_rep = '{' in occ_val

    # Determine which is the majority (consensus) value
    if consensus_count > minority_count:
        consensus_val = ref_val
        minority_val = occ_val
        min_opt, min_rep = occ_opt, occ_rep
        con_opt, con_rep = ref_opt, ref_rep
    else:
        consensus_val = occ_val
        minority_val = ref_val
        min_opt, min_rep = ref_opt, ref_rep
        con_opt, con_rep = occ_opt, occ_rep

    parts = []
    parts.append(f'<strong>Consensus ({consensus_count}:{minority_count}):</strong> '
                 f'<code>{esc(consensus_val.strip())}</code>')

    # Adding repeatability (curly braces in minority)
    if min_rep and not con_rep:
        parts.append('<br><em>The minority instance adds repeatability (curly braces). '
                     'Adopting repeatability may not break existing implementations, '
                     'since implementations that only send one repetition would still be conformant.</em>')
    elif con_rep and not min_rep:
        parts.append('<br><em>The minority instance removes repeatability. '
                     'Removing repeatability could break implementations that send '
                     'multiple repetitions of this segment.</em>')

    # Required vs optional (brackets in minority but not consensus, or vice versa)
    if not min_opt and con_opt:
        parts.append('<br><em>The minority instance makes the segment required (no brackets). '
                     'Making a segment required could break implementations that omit it. '
                     'This needs V2 Management Group review.</em>')
    elif min_opt and not con_opt:
        parts.append('<br><em>The minority instance makes the segment optional (brackets). '
                     'Making a required segment optional is generally safe but changes '
                     'conformance expectations. Needs V2 Management Group review.</em>')

    return '\n'.join(parts)


def generate_report(structures, events, fixes):
    """Generate the comprehensive HTML review report."""
    timestamp = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')

    # Find multi-occurrence structures
    multi = {sid: occs for sid, occs in structures.items() if len(occs) > 1}

    # Compute differences
    all_diffs = {}
    for sid, occs in multi.items():
        diffs = compare_occurrences(occs)
        all_diffs[sid] = diffs

    # Separate structures with diffs vs clean
    with_diffs = {sid: d for sid, d in all_diffs.items() if d}
    clean = {sid: d for sid, d in all_diffs.items() if not d}

    # Count fixes by category
    fix_counts = defaultdict(int)
    for fix in fixes:
        fix_counts[fix.get('category', 'other')] += 1

    # Load PRT audit data
    prt_audit_text = ''
    if os.path.exists(PRT_AUDIT_FILE):
        with open(PRT_AUDIT_FILE) as f:
            prt_audit_text = f.read()

    # Categorize remaining differences
    cat_totals = defaultdict(int)
    for sid, diffs in with_diffs.items():
        for d in diffs:
            cat_totals[d['category']] += 1

    # --- Build HTML ---
    h = []
    h.append('<!DOCTYPE html>')
    h.append('<html lang="en"><head><meta charset="utf-8">')
    h.append('<title>V2.9.1 Message Structure Review Report</title>')
    h.append('<style>')
    h.append(CSS)
    h.append('</style></head><body>')

    # Sidebar
    h.append('<div id="sidebar">')
    h.append('<h2>Report Contents</h2>')
    h.append('<a href="#summary">Summary</a>')
    h.append('<a href="#fixes-applied">Fixes Applied</a>')
    h.append('<a href="#remaining">Remaining Differences</a>')
    h.append('<div class="sidebar-group">')
    h.append('<h3>Structures with Differences</h3>')
    h.append('<input class="filter-input" placeholder="Filter..." '
             'oninput="filterSidebar(this.value)">')
    for sid in sorted(with_diffs.keys()):
        n = len(with_diffs[sid])
        badge = 'structural' if any(d['category'] == 'cardinality' for d in with_diffs[sid]) else 'cosmetic'
        h.append(f'<a href="#{esc(sid)}" class="sidebar-item">{esc(sid)} '
                 f'<span class="badge {badge}">{n}</span></a>')
    h.append('</div>')
    h.append('<a href="#prt-audit">PRT Description Audit</a>')
    h.append('<a href="#consistent">Consistent Structures</a>')
    h.append('</div>')

    # Content
    h.append('<div id="content">')
    h.append(f'<h1>V2.9.1 Message Structure Review Report</h1>')
    h.append(f'<p class="meta">Generated: {timestamp} | For V2 Management Group review</p>')
    h.append('<p>This report analyzes internal consistency of message structure definitions '
             'across V2.9.1 Word documents. When the same structure (e.g., ADT_A01) appears '
             'in multiple clauses for different events, the tables should be identical. '
             'Differences are categorized and recommendations provided.</p>')

    # === Summary ===
    h.append('<h2 id="summary">Summary</h2>')
    h.append('<div class="card">')
    h.append('<table class="summary-table">')
    h.append(f'<tr><td>Total structures extracted</td><td>{len(structures)}</td></tr>')
    h.append(f'<tr><td>Structures with multiple occurrences</td><td>{len(multi)}</td></tr>')
    h.append(f'<tr><td>Structures with remaining differences</td>'
             f'<td><strong>{len(with_diffs)}</strong></td></tr>')
    h.append(f'<tr><td>Total remaining differences</td>'
             f'<td><strong>{sum(len(d) for d in with_diffs.values())}</strong></td></tr>')
    h.append(f'<tr><td>Fixes applied (fixes.json)</td>'
             f'<td>{len(fixes)} fixes</td></tr>')
    h.append('</table>')
    h.append('</div>')

    h.append('<h3>Remaining Differences by Category</h3>')
    h.append('<div class="card">')
    h.append('<table>')
    h.append('<tr><th>Category</th><th>Count</th><th>Action</th></tr>')
    cat_info = {
        'cardinality': ('Cardinality (structural)', 'V2 Management review required'),
        'extraction_artifact': ('Extraction artifact', 'Word parsing issue — noted, no action'),
        'prt_qualifier': ('PRT description qualifier', 'V2 Management review — see PRT audit'),
        'nte_description': ('NTE description variant', 'Pending decision on long vs short form'),
        'group_name': ('Group name variant', 'Pending decision'),
        'desc_cosmetic': ('Description cosmetic', 'Pending decision on form'),
        'desc_other': ('Description other', 'Pending decision'),
        'row_count': ('Row count mismatch', 'Structural — V2 Management review'),
    }
    for cat, (label, action) in cat_info.items():
        if cat_totals.get(cat, 0) > 0:
            h.append(f'<tr><td>{esc(label)}</td><td>{cat_totals[cat]}</td>'
                     f'<td>{esc(action)}</td></tr>')
    h.append('</table>')
    h.append('</div>')

    # === Fixes Applied ===
    h.append('<h2 id="fixes-applied">Fixes Applied</h2>')
    h.append('<p>The following fix categories have been applied to produce the canonical data. '
             'See <code>v291-canonical/fixes.json</code> for full traceability.</p>')
    h.append('<div class="card">')
    h.append('<table>')
    h.append('<tr><th>Category</th><th>Count</th><th>Description</th></tr>')
    fix_cat_info = {
        'bracket_malformed': 'Mismatched/swapped bracket notation',
        'bracket_whitespace': 'Whitespace normalization in bracket notation',
        'desc_typo': 'Misspellings in segment descriptions',
        'desc_cosmetic': 'Trailing "Segment" suffix, dashes, abbreviations',
        'desc_meaningful': 'Substantive description corrections',
        'cardinality': 'ERR repeatability standardization in ACK structures',
        'extraction_artifact': 'Word document parsing issues (clause, caption)',
        'pending_review': 'Pending V2 Management review',
    }
    for cat, desc in fix_cat_info.items():
        if fix_counts.get(cat, 0) > 0:
            h.append(f'<tr><td>{esc(cat)}</td><td>{fix_counts[cat]}</td>'
                     f'<td>{esc(desc)}</td></tr>')
    h.append('</table>')
    h.append('</div>')

    # === Remaining Differences ===
    h.append('<h2 id="remaining">Remaining Differences by Structure</h2>')
    h.append('<p>Each structure section shows all locations where it appears in the V2.9.1 '
             'Word documents, the events that use it, and a detailed analysis of each difference.</p>')

    for sid in sorted(with_diffs.keys()):
        diffs = with_diffs[sid]
        occs = multi[sid]

        h.append(f'<div class="structure-section" id="{esc(sid)}">')
        h.append(f'<h3>{esc(sid)} '
                 f'<span class="badge structural">{len(diffs)} difference{"s" if len(diffs) != 1 else ""}</span>'
                 f'</h3>')

        # Provenance table: where this structure appears
        h.append('<h4>Occurrences in V2.9.1</h4>')
        h.append('<table>')
        h.append('<tr><th>#</th><th>Clause</th><th>Caption</th><th>Chapter</th><th>Rows</th></tr>')
        ref_clause = occs[0]['provenance'].get('clause', '?')
        for oi, occ in enumerate(occs):
            prov = occ.get('provenance', {})
            ref_marker = ' <em>(reference)</em>' if oi == 0 else ''
            h.append(f'<tr><td>{oi + 1}{ref_marker}</td>'
                     f'<td>{esc(prov.get("clause", "?"))}</td>'
                     f'<td>{esc(prov.get("captionText", "")[:80])}</td>'
                     f'<td>CH{esc(prov.get("chapter", "?"))}</td>'
                     f'<td>{len(occ["rawRows"])}</td></tr>')
        h.append('</table>')

        # Events that use this structure
        sid_events = events.get(sid, [])
        if sid_events:
            event_strs = sorted(set(f'{e["messageType"]}^{e["eventCode"]}' for e in sid_events))
            if len(event_strs) <= 10:
                h.append(f'<p class="meta"><strong>Events:</strong> {", ".join(esc(e) for e in event_strs)}</p>')
            else:
                h.append(f'<p class="meta"><strong>Events:</strong> {", ".join(esc(e) for e in event_strs[:10])} '
                         f'... and {len(event_strs) - 10} more</p>')

        # Differences with analysis
        h.append('<h4>Differences</h4>')
        for d in diffs:
            cat = d['category']
            css_class = 'structural' if cat in ('cardinality', 'row_count') else 'cosmetic'
            h.append(f'<div class="diff-item {css_class}">')

            # Header
            cat_label = cat_info.get(cat, (cat, ''))[0]
            seg_label = f' <strong>{esc(d["segment"])}</strong>' if d['segment'] else ''
            row_label = f' (row {d["row"]})' if d['row'] else ''
            h.append(f'<div class="diff-header">'
                     f'<span class="badge {css_class}">{esc(cat_label)}</span>'
                     f'{seg_label}{row_label}'
                     f'<span class="clause-ref">clause {esc(d["clause"])}</span>'
                     f'</div>')

            # Values
            h.append(f'<div class="diff-values">'
                     f'<span class="ref-val">ref ({esc(ref_clause)}): '
                     f'<code>{esc(d["ref_value"])}</code></span>'
                     f'<span class="occ-val">vs ({esc(d["clause"])}): '
                     f'<code>{esc(d["occ_value"])}</code></span>'
                     f'</div>')

            # Recommendation for cardinality
            if cat == 'cardinality':
                total_occs = len(occs)
                # Count how many match ref vs how many match this variant
                ref_seg = d['ref_value']
                match_ref = sum(1 for o in occs
                                if d['row'] - 1 < len(o['rawRows'])
                                and o['rawRows'][d['row'] - 1]['segments'] == ref_seg)
                match_occ = total_occs - match_ref
                rec = cardinality_recommendation(
                    ref_seg, d['occ_value'], d['segment'],
                    match_ref, match_occ)
                h.append(f'<div class="recommendation">{rec}</div>')

            # Notes for extraction artifacts
            if cat == 'extraction_artifact':
                h.append('<div class="recommendation">'
                         '<em>This is a Word document parsing artifact. The description column '
                         'contains bracket notation instead of real descriptions, likely due to '
                         'hidden columns or XML formatting in the Word document. '
                         'No action required.</em></div>')

            h.append('</div>')

        h.append('</div>')

    # === PRT Audit ===
    h.append('<h2 id="prt-audit">PRT/OBX Description Audit</h2>')
    h.append('<p>This audit examines all PRT (Participation) and OBX segment descriptions '
             'across <strong>all 427 message structures</strong> (not just multi-occurrence ones). '
             'It identifies cases where the parenthetical qualifier in the description '
             'does not match the group the segment is in.</p>')

    h.append('<div class="card">')
    h.append('<table>')
    h.append('<tr><th>Category</th><th>Count</th><th>Description</th></tr>')
    prt_cats = [
        ('Typos', 7, 'Misspellings in "Participation" or qualifier text, unclosed parentheses'),
        ('Wrong titleization', 4, '"for common order" should be "for Common Order"'),
        ('Segment code as qualifier', 28, '"for ORC" instead of "for Order" — uses segment code, not group name'),
        ('Qualifier mismatch', 90, 'Parenthetical does not match the containing group name'),
        ('Bare "Participation"', 272, 'PRT has no parenthetical qualifier — ambiguous in multi-PRT structures'),
        ('OBX issues', 16, 'OBX descriptions inconsistent with group name'),
    ]
    for label, count, desc in prt_cats:
        h.append(f'<tr><td>{esc(label)}</td><td>{count}</td><td>{esc(desc)}</td></tr>')
    h.append(f'<tr><td><strong>Total</strong></td><td><strong>417</strong></td>'
             f'<td>across 115 structures</td></tr>')
    h.append('</table>')
    h.append('</div>')

    h.append('<h3>Key Patterns for V2 Management Review</h3>')
    h.append('<div class="card">')
    h.append('<ol>')
    h.append('<li><strong>272 bare "Participation" instances</strong> across 98 structures '
             'have no parenthetical qualifier, making them ambiguous when a structure has '
             'multiple PRT segments in different groups.</li>')
    h.append('<li><strong>"for Patient Visit" in VISIT group</strong> (12 instances) — '
             'the group is "VISIT" but the qualifier says "Patient Visit".</li>')
    h.append('<li><strong>"for Common Order" in ORDER group</strong> (7 instances) — '
             'the PRT is in the ORDER group but references the COMMON_ORDER sub-group.</li>')
    h.append('<li><strong>"for Additional Demographics" in PATIENT group</strong> '
             '(5 instances) — references a segment (PD1) instead of the group.</li>')
    h.append('<li><strong>Segment code qualifiers</strong> (28 instances) use "for ORC", '
             '"for RXO", "for OBX", etc. instead of the group name. Most prevalent in '
             'pharmacy messages.</li>')
    h.append('<li><strong>"for Observation" in various qualified groups</strong> — '
             'PATIENT_OBSERVATION, SPECIMEN_OBSERVATION, etc. The qualifier "for Observation" '
             'is too generic for qualified observation groups.</li>')
    h.append('</ol>')
    h.append('<p>Typos and titleization issues have been fixed. All other findings '
             'require V2 Management Group decisions on standardization of PRT description '
             'conventions.</p>')
    h.append('<p><em>Full audit detail: <code>v291-canonical/prt-obx-description-audit.txt</code></em></p>')
    h.append('</div>')

    # === Consistent Structures ===
    h.append('<h2 id="consistent">Consistent Structures</h2>')
    h.append(f'<p>{len(clean)} multi-occurrence structures have identical content '
             f'across all occurrences (no differences after applying fixes).</p>')
    if clean:
        h.append('<div class="card"><table>')
        h.append('<tr><th>Structure</th><th>Occurrences</th></tr>')
        for sid in sorted(clean.keys()):
            h.append(f'<tr><td>{esc(sid)}</td><td>{len(multi[sid])}</td></tr>')
        h.append('</table></div>')

    h.append('</div>')  # content

    # JS
    h.append('<script>')
    h.append('''
function filterSidebar(q) {
    q = q.toLowerCase();
    document.querySelectorAll('.sidebar-item').forEach(function(a) {
        a.style.display = a.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
    ''')
    h.append('</script></body></html>')

    with open(REPORT_FILE, 'w') as f:
        f.write('\n'.join(h))
    print(f"Report: {REPORT_FILE}")
    return REPORT_FILE


CSS = '''
:root {
    --border: #d0d7de;
    --bg-subtle: #f6f8fa;
    --text-muted: #57606a;
    --red: #cf222e;
    --yellow: #bf8700;
    --green: #2da44e;
    --blue: #0969da;
}
* { box-sizing: border-box; }
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
       margin: 0; display: flex; color: #1f2328; line-height: 1.5; }

/* Sidebar */
#sidebar { width: 280px; min-width: 280px; height: 100vh; overflow-y: auto;
           background: var(--bg-subtle); border-right: 1px solid var(--border);
           padding: 16px; position: sticky; top: 0; font-size: 13px; }
#sidebar h2 { font-size: 15px; margin: 0 0 12px 0; }
#sidebar h3 { font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px;
              color: var(--text-muted); margin: 12px 0 4px 0; }
#sidebar a { display: block; padding: 3px 6px; color: var(--blue); text-decoration: none;
             border-radius: 4px; margin: 1px 0; }
#sidebar a:hover { background: #ddf4ff; }
.sidebar-group { margin-top: 8px; }
.filter-input { width: 100%; padding: 4px 8px; border: 1px solid var(--border);
                border-radius: 6px; font-size: 13px; margin-bottom: 6px; }

/* Content */
#content { flex: 1; padding: 32px 40px; max-width: 1100px; }
h1 { font-size: 24px; border-bottom: 1px solid var(--border); padding-bottom: 10px; margin-bottom: 8px; }
h2 { font-size: 20px; margin-top: 40px; border-bottom: 1px solid var(--border); padding-bottom: 6px; }
h3 { font-size: 17px; margin-top: 28px; }
h4 { font-size: 14px; margin: 12px 0 6px 0; color: var(--text-muted); }
.meta { font-size: 13px; color: var(--text-muted); }

/* Cards */
.card { border: 1px solid var(--border); border-radius: 8px; padding: 16px; margin: 12px 0; }

/* Tables */
table { border-collapse: collapse; width: 100%; margin: 8px 0; }
th, td { border: 1px solid var(--border); padding: 6px 10px; text-align: left; font-size: 14px; }
th { background: var(--bg-subtle); font-weight: 600; }
.summary-table td:first-child { width: 60%; }
.summary-table td:last-child { font-weight: 600; }

/* Badges */
.badge { display: inline-block; padding: 2px 8px; border-radius: 12px;
         font-size: 11px; font-weight: 600; margin-right: 6px; }
.badge.structural { background: #fdd; color: var(--red); }
.badge.cosmetic { background: #fff3cd; color: var(--yellow); }

/* Structure sections */
.structure-section { margin: 24px 0; padding: 20px; border: 1px solid var(--border);
                     border-radius: 8px; background: #fff; }

/* Diff items */
.diff-item { margin: 10px 0; padding: 10px 14px; border-radius: 6px;
             border: 1px solid var(--border); }
.diff-item.structural { border-left: 4px solid var(--red); background: #fff5f5; }
.diff-item.cosmetic { border-left: 4px solid var(--yellow); background: #fffbeb; }
.diff-header { margin-bottom: 6px; }
.clause-ref { float: right; font-size: 12px; color: var(--text-muted); }
.diff-values { font-size: 13px; }
.ref-val, .occ-val { display: block; margin: 2px 0; }
code { background: var(--bg-subtle); padding: 2px 6px; border-radius: 4px; font-size: 13px; }
.recommendation { margin-top: 8px; padding: 8px 12px; background: #f0f7ff;
                   border-radius: 4px; font-size: 13px; border-left: 3px solid var(--blue); }
'''


def main():
    print("Loading canonical structures...")
    structures = load_canonical_structures()
    print(f"  {sum(len(v) for v in structures.values())} occurrences, {len(structures)} unique IDs")

    print("Loading events...")
    events = load_events()
    print(f"  {sum(len(v) for v in events.values())} event-structure mappings")

    print("Loading fixes...")
    fixes = load_fixes()
    print(f"  {len(fixes)} fixes")

    print("Generating report...")
    path = generate_report(structures, events, fixes)
    print(f"\nReport written to: {path}")


if __name__ == '__main__':
    main()
