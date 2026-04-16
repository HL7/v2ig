#!/usr/bin/env python3
"""Apply curated fixes to V291 extracted message structures.

Reads raw extraction from v291-extracted/message-structures/,
applies fixes from v291-canonical/fixes.json,
writes corrected files to v291-canonical/message-structures/.
Generates an HTML traceability report.

Usage:
    python3 tooling/scripts/apply_v291_fixes.py
    python3 tooling/scripts/apply_v291_fixes.py --dry-run
"""

import argparse
import copy
import json
import os
import re
import shutil
import sys
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT

RAW_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'message-structures')
CANONICAL_DIR = os.path.join(PROJECT_ROOT, 'v291-canonical', 'message-structures')
FIXES_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'fixes.json')
REPORT_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'fixes-report.html')


# ---------------------------------------------------------------------------
# Fix application
# ---------------------------------------------------------------------------

def load_fixes():
    """Load the fixes manifest."""
    with open(FIXES_FILE) as f:
        data = json.load(f)
    return data.get('fixes', [])


def load_raw_structures():
    """Load all raw V291 message structures, keyed by filename."""
    structures = {}
    for fname in sorted(os.listdir(RAW_DIR)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(RAW_DIR, fname)
        structures[fname] = json.load(open(fpath))
    return structures


def find_target_files(fix, all_structures):
    """Find which file(s) a fix applies to.

    A fix targets by structure ID + occurrence specifier:
      - "all": apply to all occurrences of this structure ID
      - "CH03, table 14": apply to the specific occurrence
      - index (int): apply to the Nth occurrence (0-based)
      - applies_to_file: direct filename match (overrides other logic)
    """
    # Direct filename match takes precedence
    direct_file = fix.get('applies_to_file')
    if direct_file and direct_file in all_structures:
        return [direct_file]

    sid = fix['structure']
    scope = fix.get('occurrence', 'all')
    matches = []

    for fname, data in all_structures.items():
        if data.get('structureId') != sid:
            continue

        if scope == 'all':
            matches.append(fname)
        elif isinstance(scope, int):
            matches.append(fname)  # will filter after sorting
        elif isinstance(scope, str):
            prov = data.get('provenance', {})
            clause = prov.get('clause', '')
            table_idx = prov.get('tableIndex', '')
            section = prov.get('sectionHeading', '')

            # Match against clause number (e.g., "3.3.8")
            if clause and scope == clause:
                matches.append(fname)
            # Match against "CH03, table 30" legacy format
            elif f"table {table_idx}" in scope:
                matches.append(fname)
            # Match against section heading
            elif scope in section:
                matches.append(fname)

    if isinstance(scope, int):
        # Sort by chapter/table and pick the Nth
        matches.sort(key=lambda f: (
            all_structures[f].get('provenance', {}).get('chapter', ''),
            all_structures[f].get('provenance', {}).get('tableIndex', 0)
        ))
        if scope < len(matches):
            return [matches[scope]]
        return []

    return matches


def apply_fix(fix, data):
    """Apply a single fix to a structure's data. Returns (modified_data, applied_details)."""
    data = copy.deepcopy(data)
    field = fix['field']
    row_idx = fix.get('row')  # 1-based row number, or None for structure-level
    from_val = fix.get('from')
    to_val = fix['to']
    applied = []

    if field == 'segments' and row_idx is not None:
        # Fix a specific rawRow's segments field
        idx = row_idx - 1  # convert to 0-based
        if idx < len(data['rawRows']):
            actual = data['rawRows'][idx]['segments']
            if from_val is None or actual.strip() == from_val.strip():
                data['rawRows'][idx]['segments'] = to_val
                applied.append(f'Row {row_idx} segments: "{actual}" → "{to_val}"')
            else:
                applied.append(f'Row {row_idx} SKIPPED: expected "{from_val}", found "{actual}"')

    elif field == 'description' and row_idx is not None:
        idx = row_idx - 1
        if idx < len(data['rawRows']):
            actual = data['rawRows'][idx]['description']
            if from_val is None or actual.strip() == from_val.strip():
                data['rawRows'][idx]['description'] = to_val
                applied.append(f'Row {row_idx} description: "{actual}" → "{to_val}"')
            else:
                applied.append(f'Row {row_idx} SKIPPED: expected "{from_val}", found "{actual}"')

    elif field == 'segments_all':
        # Apply bracket normalization to all rows
        for i, row in enumerate(data['rawRows']):
            old_seg = row['segments']
            new_seg = to_val if callable(to_val) else _normalize_brackets(old_seg)
            if old_seg != new_seg:
                row['segments'] = new_seg
                applied.append(f'Row {i+1} segments: "{old_seg}" → "{new_seg}"')

    elif field == 'description_titleize':
        # Titleize all descriptions in this structure
        for i, row in enumerate(data['rawRows']):
            old_desc = row['description']
            new_desc = old_desc.title() if old_desc else old_desc
            # Preserve specific patterns that title() mangles
            # e.g., "OBR" should stay "OBR", not "Obr"
            # Only apply if it's a real description, not a group marker
            if old_desc and not old_desc.startswith('---') and old_desc != new_desc:
                row['description'] = new_desc
                applied.append(f'Row {i+1} description: "{old_desc}" → "{new_desc}"')

    elif field == 'description_replace':
        # Replace a specific description value wherever it appears in this structure
        # Optional segment_filter restricts to rows with a specific segment code
        # Optional group_filter restricts to rows inside a specific group
        seg_filter = fix.get('segment_filter')
        group_filter = fix.get('group_filter')
        for i, row in enumerate(data['rawRows']):
            if row['description'].strip() == from_val.strip():
                if seg_filter:
                    row_code = re.sub(r'[\[\]{}\s]', '', row['segments'])
                    if row_code != seg_filter:
                        continue
                if group_filter:
                    # Find the innermost group containing this row
                    current_group = ''
                    for j in range(i - 1, -1, -1):
                        d_desc = data['rawRows'][j]['description']
                        if d_desc.startswith('---') and 'begin' in d_desc:
                            current_group = d_desc.replace('---', '').replace('begin', '').strip()
                            break
                    if current_group != group_filter:
                        continue
                row['description'] = to_val
                applied.append(f'Row {i+1} description: "{from_val}" → "{to_val}"')

    elif field == 'description_strip_segment_suffix':
        # Remove trailing ' Segment' from descriptions (not group markers)
        for i, row in enumerate(data['rawRows']):
            desc = row['description']
            if desc and not desc.startswith('---') and desc.endswith(' Segment'):
                new_desc = desc[:-len(' Segment')]
                if new_desc:  # don't strip if it would leave empty
                    row['description'] = new_desc
                    applied.append(f'Row {i+1} description: "{desc}" → "{new_desc}"')

    elif field == 'description_normalize_dash':
        # Replace en-dash (U+2013) and em-dash (U+2014) with regular hyphen
        for i, row in enumerate(data['rawRows']):
            desc = row['description']
            new_desc = desc.replace('\u2013', '-').replace('\u2014', '-')
            if new_desc != desc:
                row['description'] = new_desc
                applied.append(f'Row {i+1} description: "{desc}" → "{new_desc}"')

    elif field == 'clause':
        # Fix clause number in provenance
        old_clause = data.get('provenance', {}).get('clause', '')
        if from_val is None or old_clause == from_val:
            data['provenance']['clause'] = to_val
            applied.append(f'Clause: "{old_clause}" → "{to_val}"')

    elif field == 'structureId':
        # Reclassify structure ID
        old_id = data.get('structureId', '')
        if from_val is None or old_id == from_val:
            data['structureId'] = to_val
            applied.append(f'StructureId: "{old_id}" → "{to_val}"')
            # Also update caption if provided
            new_caption = fix.get('new_caption')
            if new_caption:
                old_caption = data.get('provenance', {}).get('captionText', '')
                data['provenance']['captionText'] = new_caption
                data['provenance']['sectionHeading'] = new_caption
                if 'caption' in data:
                    data['caption'] = new_caption
                applied.append(f'Caption: "{old_caption}" → "{new_caption}"')

    return data, applied


def _normalize_brackets(seg_str):
    """Normalize bracket notation to standard form.

    Standard forms:
        SEG             (required, non-repeating)
        [ SEG ]         (optional, non-repeating)
        { SEG }         (required, repeating)
        [{ SEG }]       (optional, repeating)
        [{              (group begin, optional repeating)
        }]              (group end)
        [               (group begin, optional)
        ]               (group end)
        {               (group begin, repeating)
        }               (group end)
        <               (choice begin)
        |               (choice alternative)
        >               (choice end)
    """
    s = seg_str.strip()
    if not s:
        return s

    # Choice markers — leave as-is
    if s in ('<', '>', '|'):
        return s

    # Group boundary markers — normalize whitespace only
    stripped = re.sub(r'\s+', '', s)
    if stripped in ('[{', '}]', '[', ']', '{', '}', '[ {', '} ]'):
        # Normalize to canonical form
        canonical_map = {
            '[{': '[{', '[ {': '[{',
            '}]': '}]', '} ]': '}]',
            '[': '[', ']': ']',
            '{': '{', '}': '}',
        }
        return canonical_map.get(stripped, s)

    # Extract the segment code
    code = re.sub(r'[\[\]{}\s]', '', s)
    if not code:
        return s

    # Determine optionality and repetition
    has_bracket = '[' in s or ']' in s
    has_brace = '{' in s or '}' in s

    # Fix malformed brackets: detect mismatches
    open_sq = s.count('[')
    close_sq = s.count(']')
    open_br = s.count('{')
    close_br = s.count('}')

    if open_sq != close_sq or open_br != close_br:
        # Malformed — reconstruct from intent
        optional = has_bracket
        repeating = has_brace
        if optional and repeating:
            return f'[{{ {code} }}]'
        elif optional:
            return f'[ {code} ]'
        elif repeating:
            return f'{{ {code} }}'
        else:
            return code

    # Well-formed — normalize whitespace
    optional = has_bracket
    repeating = has_brace

    if optional and repeating:
        return f'[{{ {code} }}]'
    elif optional:
        return f'[ {code} ]'
    elif repeating:
        return f'{{ {code} }}'
    else:
        return code


def apply_all_fixes(dry_run=False):
    """Load fixes, apply to raw structures, write canonical output."""
    fixes = load_fixes()
    structures = load_raw_structures()

    print(f"Loaded {len(fixes)} fixes, {len(structures)} raw structures")

    # Track what was applied
    fix_log = []

    # Clone all structures (even unfixed ones go to canonical)
    canonical = {fname: copy.deepcopy(data) for fname, data in structures.items()}

    # Sort fixes: individual fixes first, bulk operations last
    individual_fixes = [f for f in fixes if f.get('structure') != '*']
    bulk_fixes = [f for f in fixes if f.get('structure') == '*']

    for fix in individual_fixes + bulk_fixes:
        fix_id = fix.get('id', '?')

        # Handle bulk operations (apply to all files, or all files for a given structure)
        is_bulk = fix.get('field') in ('segments_all', 'description_titleize', 'description_replace',
                                       'description_strip_segment_suffix', 'description_normalize_dash')
        is_wildcard = fix.get('structure') in ('*', None)
        if is_bulk and fix.get('occurrence') == 'all':
            total_changes = 0
            target_sid = fix.get('structure', '*')
            files_affected = 0
            for fname in sorted(canonical.keys()):
                data = canonical[fname]
                if target_sid != '*' and data.get('structureId') != target_sid:
                    continue
                new_data, details = apply_fix(fix, data)
                canonical[fname] = new_data
                n = len(details)
                total_changes += n
                if n > 0:
                    files_affected += 1
            scope_desc = 'all structures' if is_wildcard else target_sid
            fix_log.append({
                'fix': fix,
                'files': [scope_desc],
                'details': [f'{total_changes} changes across {files_affected} files ({scope_desc})'],
                'status': 'applied',
            })
            print(f"  {fix_id}: {total_changes} changes across {files_affected} files ({scope_desc})")
            continue

        # Pending review items are logged but not applied
        if fix.get('category') == 'pending_review':
            fix_log.append({
                'fix': fix,
                'files': [],
                'details': ['Pending V2 Management review — not applied'],
                'status': 'pending_review',
            })
            print(f"  {fix_id}: PENDING REVIEW — {fix.get('reasoning', '')[:60]}")
            continue

        target_files = find_target_files(fix, canonical)

        if not target_files:
            fix_log.append({
                'fix': fix,
                'files': [],
                'details': ['No matching files found'],
                'status': 'no_match',
            })
            print(f"  {fix_id}: NO MATCH for {fix['structure']}/{fix.get('occurrence','all')}")
            continue

        for fname in target_files:
            data = canonical[fname]
            new_data, details = apply_fix(fix, data)
            canonical[fname] = new_data

            skipped = any('SKIPPED' in d for d in details)
            fix_log.append({
                'fix': fix,
                'files': [fname],
                'details': details,
                'status': 'skipped' if skipped else 'applied',
            })

            status = 'SKIP' if skipped else 'OK'
            n_changes = len([d for d in details if 'SKIPPED' not in d])
            print(f"  {fix_id}: {status} on {fname} ({n_changes} changes)")

    if not dry_run:
        # Write canonical files
        os.makedirs(CANONICAL_DIR, exist_ok=True)
        for fname, data in canonical.items():
            fpath = os.path.join(CANONICAL_DIR, fname)
            with open(fpath, 'w') as f:
                json.dump(data, f, indent=2, ensure_ascii=False)

        print(f"\nWrote {len(canonical)} canonical files to {CANONICAL_DIR}")

        # Generate HTML report
        generate_fix_report(fixes, fix_log, structures, canonical)
    else:
        print(f"\nDry run — no files written")

    return fix_log


# ---------------------------------------------------------------------------
# HTML Report
# ---------------------------------------------------------------------------

def generate_fix_report(fixes, fix_log, raw_structures, canonical_structures):
    """Generate an HTML traceability report for all fixes."""
    timestamp = datetime.now(timezone.utc).isoformat()

    # Summarize
    applied = [l for l in fix_log if l['status'] == 'applied']
    skipped = [l for l in fix_log if l['status'] == 'skipped']
    no_match = [l for l in fix_log if l['status'] == 'no_match']
    pending = [l for l in fix_log if l['status'] == 'pending_review']
    total_changes = sum(len([d for d in l['details'] if 'SKIPPED' not in d]) for l in applied)

    # Group by category
    by_category = defaultdict(list)
    for fix in fixes:
        by_category[fix.get('category', 'uncategorized')].append(fix)

    # Group by structure
    by_structure = defaultdict(list)
    for entry in fix_log:
        by_structure[entry['fix']['structure']].append(entry)

    cat_labels = {
        'bracket_malformed': ('Malformed Brackets', 'Typos in bracket notation (mismatched/swapped brackets)'),
        'bracket_whitespace': ('Bracket Whitespace', 'Normalization of whitespace inside bracket notation'),
        'desc_typo': ('Description Typos', 'Misspellings in segment descriptions'),
        'desc_cosmetic': ('Description Cosmetic', 'Trailing "Segment", case, abbreviation, dash differences'),
        'cardinality': ('Cardinality', 'Optionality or repetition differences between occurrences'),
        'desc_meaningful': ('Description Meaningful', 'Genuinely different descriptions requiring expert judgment'),
        'structural': ('Structural', 'Row count mismatches, missing/extra segments'),
        'extraction_artifact': ('Extraction Artifacts', 'Word document parsing issues — clause numbering, caption detection, hidden formatting'),
    }

    html = []
    html.append('<!DOCTYPE html>')
    html.append('<html lang="en"><head><meta charset="utf-8">')
    html.append('<title>V2.9.1 Canonical Fixes Traceability Report</title>')
    html.append('<style>')
    html.append('''
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 0; display: flex; }
#sidebar { width: 280px; min-width: 280px; height: 100vh; overflow-y: auto; background: #f6f8fa;
           border-right: 1px solid #d0d7de; padding: 12px; position: sticky; top: 0; font-size: 13px; }
#content { flex: 1; padding: 24px 32px; max-width: 1100px; }
h1 { font-size: 24px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 20px; margin-top: 32px; border-bottom: 1px solid #d0d7de; padding-bottom: 6px; }
h3 { font-size: 16px; margin-top: 24px; }
table { border-collapse: collapse; width: 100%; margin: 8px 0; }
th, td { border: 1px solid #d0d7de; padding: 6px 10px; text-align: left; font-size: 14px; }
th { background: #f6f8fa; font-weight: 600; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; margin-right: 4px; }
.badge-applied { background: #e8f4e8; color: #070; }
.badge-skipped { background: #fff3cd; color: #856404; }
.badge-nomatch { background: #fdd; color: #b00; }
.badge-pending { background: #e3f2fd; color: #1565c0; }
.sidebar-section { margin-bottom: 16px; }
.sidebar-section h3 { font-size: 13px; margin: 8px 0 4px 0; color: #57606a; text-transform: uppercase; }
.sidebar-section a { display: block; padding: 2px 4px; color: #0969da; text-decoration: none; font-size: 13px; }
.sidebar-section a:hover { background: #ddf4ff; border-radius: 4px; }
.fix-card { margin: 12px 0; padding: 12px; border: 1px solid #d0d7de; border-radius: 8px; background: #fff; }
.fix-card.applied { border-left: 4px solid #2da44e; }
.fix-card.skipped { border-left: 4px solid #bf8700; }
.fix-card h4 { margin: 0 0 6px 0; font-size: 15px; }
.fix-meta { font-size: 12px; color: #57606a; margin: 2px 0; }
.fix-detail { font-size: 13px; margin: 4px 0; }
.fix-reasoning { font-size: 13px; color: #333; background: #f6f8fa; padding: 6px 10px; border-radius: 4px; margin: 6px 0; }
code { background: #f6f8fa; padding: 2px 6px; border-radius: 4px; font-size: 13px; }
.del { background: #fdd; text-decoration: line-through; padding: 1px 4px; }
.ins { background: #dfd; padding: 1px 4px; }
.filter-input { width: 100%; padding: 4px 8px; border: 1px solid #d0d7de; border-radius: 4px; margin-bottom: 8px; font-size: 13px; }
    ''')
    html.append('</style></head><body>')

    # Sidebar
    html.append('<div id="sidebar">')
    html.append('<h2 style="margin-top:0; font-size:16px">Fix Index</h2>')
    html.append(f'<p style="font-size:12px; color:#57606a">{len(fixes)} fixes, '
                f'{total_changes} changes applied</p>')
    html.append('<input class="filter-input" placeholder="Filter..." '
                'oninput="filterSidebar(this.value)">')

    for cat, cat_fixes in sorted(by_category.items()):
        label = cat_labels.get(cat, (cat, ''))[0]
        html.append(f'<div class="sidebar-section"><h3>{_esc(label)} ({len(cat_fixes)})</h3>')
        for fix in cat_fixes:
            fid = fix.get('id', '?')
            html.append(f'<a href="#{fid}" class="sidebar-item">{fid}: {fix["structure"]}</a>')
        html.append('</div>')
    html.append('</div>')

    # Content
    html.append('<div id="content">')
    html.append('<h1>V2.9.1 Canonical Fixes — Traceability Report</h1>')
    html.append(f'<p class="fix-meta">Generated: {timestamp}</p>')
    html.append('<p>This report documents every fix applied to produce the canonical '
                'V2.9.1 message structure data from the raw Word document extraction. '
                'Each fix includes the original value, corrected value, which artifact '
                'it alters, and the reasoning behind the change.</p>')

    # Summary
    html.append('<h2>Summary</h2>')
    html.append('<table>')
    html.append(f'<tr><th>Total fixes defined</th><td>{len(fixes)}</td></tr>')
    html.append(f'<tr><th>Successfully applied</th><td><span class="badge badge-applied">{len(applied)}</span></td></tr>')
    html.append(f'<tr><th>Skipped (value mismatch)</th><td><span class="badge badge-skipped">{len(skipped)}</span></td></tr>')
    html.append(f'<tr><th>No match found</th><td><span class="badge badge-nomatch">{len(no_match)}</span></td></tr>')
    html.append(f'<tr><th>Pending V2 Mgmt review</th><td><span class="badge badge-pending">{len(pending)}</span></td></tr>')
    html.append(f'<tr><th>Total row-level changes</th><td>{total_changes}</td></tr>')
    html.append('</table>')

    # By category
    html.append('<h2>Fixes by Category</h2>')
    for cat in sorted(by_category.keys()):
        cat_fixes = by_category[cat]
        label, desc = cat_labels.get(cat, (cat, ''))
        html.append(f'<h3>{_esc(label)} ({len(cat_fixes)})</h3>')
        if desc:
            html.append(f'<p class="fix-meta">{_esc(desc)}</p>')

        for fix in cat_fixes:
            fid = fix.get('id', '?')
            # Find the log entries for this fix
            entries = [l for l in fix_log if l['fix']['id'] == fid]
            status = entries[0]['status'] if entries else 'no_match'
            status_badge = {'applied': 'badge-applied', 'skipped': 'badge-skipped',
                            'no_match': 'badge-nomatch',
                            'pending_review': 'badge-pending'}.get(status, 'badge-nomatch')

            html.append(f'<div class="fix-card {status}" id="{fid}">')
            html.append(f'<h4>{fid}: {fix["structure"]} '
                        f'<span class="badge {status_badge}">{status}</span></h4>')

            # Metadata
            occ = fix.get('occurrence', 'all')
            html.append(f'<div class="fix-meta">Occurrence: {_esc(str(occ))} | '
                        f'Row: {fix.get("row", "—")} | Field: {fix.get("field", "—")}</div>')

            # From → To
            from_val = fix.get('from', '')
            to_val = fix.get('to', '')
            if from_val:
                html.append(f'<div class="fix-detail">'
                            f'<span class="del">{_esc(str(from_val))}</span> → '
                            f'<span class="ins">{_esc(str(to_val))}</span></div>')
            else:
                html.append(f'<div class="fix-detail">→ <span class="ins">{_esc(str(to_val))}</span></div>')

            # Reasoning
            reasoning = fix.get('reasoning', '')
            if reasoning:
                html.append(f'<div class="fix-reasoning">{_esc(reasoning)}</div>')

            # Applied details
            for entry in entries:
                for detail in entry['details']:
                    html.append(f'<div class="fix-meta">  {_esc(detail)}</div>')

            html.append('</div>')

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

    with open(REPORT_FILE, 'w') as f:
        f.write('\n'.join(html))
    print(f"HTML report: {REPORT_FILE}")


def _esc(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description='Apply V291 canonical fixes')
    parser.add_argument('--dry-run', action='store_true', help='Show what would change without writing')
    args = parser.parse_args()

    apply_all_fixes(dry_run=args.dry_run)


if __name__ == '__main__':
    main()
