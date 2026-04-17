#!/usr/bin/env python3
"""Apply canonical V291 fixes to FHIR message structure StructureDefinitions.

Re-runs the FHIR vs V291-canonical comparison in memory, then for each
applicable discrepancy patches the matching FHIR element:

  - description (cosmetic + structural) → element.short
  - optionality (R/O)                   → element.min
  - repetition (Y/N)                    → element.max

Group renames are intentionally NOT handled here — they require rewriting
element IDs and BackboneElement entries throughout the file. Run a separate
pass for those.

Dry-run by default; pass --write to modify FHIR JSON in place.

Usage:
    python3 tooling/scripts/apply_canonical_to_fhir.py
    python3 tooling/scripts/apply_canonical_to_fhir.py --write
    python3 tooling/scripts/apply_canonical_to_fhir.py --subset ACK-A,OML_O21
"""

import argparse
import json
import os
import sys
from collections import defaultdict
from datetime import datetime, timezone

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT
import compare_message_structures as cmp_ms


FHIR_DIR = cmp_ms.FHIR_DIR
REPORT_PATH = os.path.join(PROJECT_ROOT, 'v291-canonical',
                           'fhir-apply-report.html')

APPLICABLE_DIMENSIONS = {
    cmp_ms.DIM_DESCRIPTION,
    cmp_ms.DIM_OPTIONALITY,
    cmp_ms.DIM_REPETITION,
}


def _run_comparison(v291_dir, subset_filter):
    """Helper: run the comparison against a V291 source dir, return discs."""
    cmp_ms.V291_DIR = v291_dir
    fhir_structs = cmp_ms.load_fhir_structures()
    v291_structs = cmp_ms.load_v291_structures()
    if subset_filter:
        fhir_structs = {k: v for k, v in fhir_structs.items() if k in subset_filter}
        v291_structs = {k: v for k, v in v291_structs.items() if k in subset_filter}
    matches = cmp_ms.match_structures(fhir_structs, v291_structs)
    matched = [m for m in matches if m['v291_data'] is not None]
    truncated_ids = set()
    for m in matched:
        fhir_segs = cmp_ms.extract_fhir_segments(m['fhir_data'])
        v291_segs = cmp_ms.extract_v291_segments(m['v291_data'])
        if len(v291_segs) > 0 and len(fhir_segs) > len(v291_segs) * 2:
            truncated_ids.add(m['fhir_id'])
    discs = []
    for m in matched:
        if m['fhir_id'] in truncated_ids:
            continue
        fhir_segs = cmp_ms.extract_fhir_segments(m['fhir_data'])
        v291_segs = cmp_ms.extract_v291_segments(m['v291_data'])
        prov = m.get('v291_provenance', {})
        discs.extend(cmp_ms.compare_pair(fhir_segs, v291_segs, m['fhir_id'], prov))
    return discs


def _disc_key(d):
    """Identity key for a discrepancy.

    Includes v291_value so that 'we changed V291 from X to Y at this location'
    is treated as a NEW canonical disc (a fix to shuttle), even if raw V291
    also disagreed with FHIR at the same spot. If V291 didn't change between
    raw and canonical, the key matches and the disc is filtered out — it's an
    open FHIR/V291 disagreement, not a fix we made.
    """
    return (d['structure_id'], d['dimension'], d.get('segment_code', ''),
            d.get('position'), d.get('fhir_value', ''), d.get('v291_value', ''))


def collect_canonical_only_discrepancies(subset_filter=None):
    """Return discs that appear only when comparing against canonical V291.

    These represent fixes applied to V291 (via fixes.json) that have not yet
    been propagated to FHIR. Pre-existing FHIR↔raw differences are excluded —
    those are not 'fixes to shuttle', they are open FHIR/V291 disagreements.
    """
    raw_discs = _run_comparison(cmp_ms.V291_RAW_DIR, subset_filter)
    can_discs = _run_comparison(cmp_ms.V291_CANONICAL_DIR, subset_filter)
    raw_keys = {_disc_key(d) for d in raw_discs}
    return [d for d in can_discs if _disc_key(d) not in raw_keys], can_discs


def fhir_file_for(structure_id):
    """Map a structure ID to its FHIR JSON path."""
    return os.path.join(FHIR_DIR, f"{structure_id}.json")


def find_element_by_position(fhir_data, position):
    """Return (index, element) for the element matching the 1-indexed FHIR
    segment position (as produced by extract_fhir_segments)."""
    elements = fhir_data.get('differential', {}).get('element', [])
    seg_idx = 0
    for i, elem in enumerate(elements):
        types = elem.get('type', [])
        if not types:
            continue
        type_code = types[0].get('code', '')
        if type_code == 'BackboneElement':
            continue
        seg_idx += 1
        if seg_idx == position:
            return i, elem
    return None, None


def apply_patch(elem, dim, new_value):
    """Apply a single fix to a FHIR element. Returns (old_value, new_value)
    actually written, or None if a no-op."""
    if dim == cmp_ms.DIM_DESCRIPTION:
        old = elem.get('short', '')
        if old == new_value:
            return None
        elem['short'] = new_value
        return (old, new_value)

    if dim == cmp_ms.DIM_OPTIONALITY:
        # new_value is 'R' or 'O' from V291
        old_min = elem.get('min', 0)
        new_min = 1 if new_value == 'R' else 0
        if old_min == new_min:
            return None
        elem['min'] = new_min
        return (f"min={old_min}", f"min={new_min}")

    if dim == cmp_ms.DIM_REPETITION:
        # new_value is 'Y' or 'N' from V291
        old_max = str(elem.get('max', '1'))
        new_max = '*' if new_value == 'Y' else '1'
        if old_max == new_max:
            return None
        elem['max'] = new_max
        return (f"max={old_max}", f"max={new_max}")

    return None


def apply_all(discs, write):
    """Apply all applicable discrepancies to FHIR. Returns list of change records."""
    by_struct = defaultdict(list)
    for d in discs:
        if d['dimension'] not in APPLICABLE_DIMENSIONS:
            continue
        by_struct[d['structure_id']].append(d)

    changes = []
    for struct_id, struct_discs in sorted(by_struct.items()):
        path = fhir_file_for(struct_id)
        if not os.path.isfile(path):
            for d in struct_discs:
                changes.append({**d, '_status': 'fhir_file_missing'})
            continue

        with open(path) as f:
            fhir_data = json.load(f)

        modified = False
        for d in struct_discs:
            pos = d.get('position')
            idx, elem = find_element_by_position(fhir_data, pos)
            if elem is None:
                changes.append({**d, '_status': 'element_not_found'})
                continue
            # Sanity check: segment code matches
            type_code = elem.get('type', [{}])[0].get('code', '')
            seg_code = type_code.rsplit('/', 1)[-1] if '/' in type_code else type_code
            if seg_code != d.get('segment_code'):
                changes.append({**d, '_status': 'segment_code_mismatch',
                                '_actual_code': seg_code})
                continue

            result = apply_patch(elem, d['dimension'], d['v291_value'])
            if result is None:
                changes.append({**d, '_status': 'no_op'})
            else:
                old, new = result
                changes.append({**d, '_status': 'applied',
                                '_old': old, '_new': new,
                                '_element_id': elem.get('id')})
                modified = True

        if modified and write:
            with open(path, 'w') as f:
                json.dump(fhir_data, f, indent=2)
                f.write('\n')

    return changes


def summarize(changes):
    """Print per-category counts."""
    by_status = defaultdict(int)
    by_dim = defaultdict(lambda: defaultdict(int))
    for c in changes:
        by_status[c['_status']] += 1
        by_dim[c['dimension']][c['_status']] += 1

    print()
    print('=' * 60)
    print('Apply Summary')
    print('=' * 60)
    for status, n in sorted(by_status.items(), key=lambda x: -x[1]):
        print(f'  {status:25} {n}')
    print()
    print('By dimension:')
    for dim, statuses in sorted(by_dim.items()):
        parts = ', '.join(f'{s}={n}' for s, n in sorted(statuses.items()))
        print(f'  {dim:20} {parts}')
    print('=' * 60)


def write_html_report(changes, write_mode):
    """Generate an HTML traceability report grouped by structure."""
    timestamp = datetime.now(timezone.utc).isoformat()
    by_struct = defaultdict(list)
    for c in changes:
        by_struct[c['structure_id']].append(c)

    applied = sum(1 for c in changes if c['_status'] == 'applied')
    skipped = len(changes) - applied
    mode_label = 'WRITE' if write_mode else 'DRY-RUN'

    h = []
    h.append('<!DOCTYPE html><html><head><meta charset="utf-8">')
    h.append(f'<title>FHIR Apply Report ({mode_label})</title>')
    h.append('<style>')
    h.append('body{font-family:-apple-system,Segoe UI,sans-serif;margin:20px;}')
    h.append('h1,h2{border-bottom:1px solid #ccc;padding-bottom:4px;}')
    h.append('table{border-collapse:collapse;width:100%;font-size:13px;margin:8px 0;}')
    h.append('th,td{border:1px solid #ddd;padding:4px 8px;text-align:left;vertical-align:top;}')
    h.append('th{background:#f4f4f4;}')
    h.append('.applied{background:#e7f5e7;}')
    h.append('.no_op{background:#f9f9f9;color:#888;}')
    h.append('.element_not_found,.segment_code_mismatch,.fhir_file_missing{background:#fde7e7;}')
    h.append('.summary{background:#eef2f7;padding:8px;border-radius:4px;margin:12px 0;}')
    h.append('code{background:#f4f4f4;padding:1px 4px;border-radius:3px;}')
    h.append('</style></head><body>')
    h.append(f'<h1>FHIR Apply Report ({mode_label})</h1>')
    h.append(f'<p>Generated {timestamp}</p>')
    h.append(f'<div class="summary"><strong>{applied}</strong> applied, '
             f'<strong>{skipped}</strong> skipped/no-op, '
             f'across <strong>{len(by_struct)}</strong> structures.</div>')

    for sid in sorted(by_struct):
        rows = by_struct[sid]
        h.append(f'<h2>{sid} ({len(rows)} entries)</h2>')
        h.append('<table><tr><th>Dim</th><th>Pos</th><th>Seg</th>'
                 '<th>FHIR (was)</th><th>V291 (will be)</th>'
                 '<th>Status</th><th>Element ID</th></tr>')
        for c in rows:
            cls = c['_status']
            h.append(f'<tr class="{cls}">')
            h.append(f'<td>{c["dimension"]}</td>')
            h.append(f'<td>{c.get("position","")}</td>')
            h.append(f'<td>{c.get("segment_code","")}</td>')
            h.append(f'<td><code>{(c.get("fhir_value") or "")[:80]}</code></td>')
            h.append(f'<td><code>{(c.get("v291_value") or "")[:80]}</code></td>')
            h.append(f'<td>{c["_status"]}</td>')
            h.append(f'<td><code>{c.get("_element_id","")}</code></td>')
            h.append('</tr>')
        h.append('</table>')

    h.append('</body></html>')

    os.makedirs(os.path.dirname(REPORT_PATH), exist_ok=True)
    with open(REPORT_PATH, 'w') as f:
        f.write('\n'.join(h))
    print(f'HTML report: {REPORT_PATH}')


def main():
    parser = argparse.ArgumentParser(
        description='Apply canonical V291 fixes to FHIR message structures')
    parser.add_argument('--write', action='store_true',
                        help='Actually modify FHIR JSON files (default: dry-run)')
    parser.add_argument('--subset', help='Comma-separated structure IDs to process')
    args = parser.parse_args()

    subset = set(args.subset.split(',')) if args.subset else None

    print('Comparing FHIR vs V291 (raw and canonical)...')
    discs, all_can_discs = collect_canonical_only_discrepancies(subset)
    applicable = [d for d in discs if d['dimension'] in APPLICABLE_DIMENSIONS]
    print(f'  {len(all_can_discs)} canonical discs total, '
          f'{len(discs)} canonical-only (V291 fixes not yet in FHIR), '
          f'{len(applicable)} applicable to FHIR patching')

    mode = 'WRITE' if args.write else 'DRY-RUN'
    print(f'\nMode: {mode}')

    changes = apply_all(discs, write=args.write)
    summarize(changes)
    write_html_report(changes, write_mode=args.write)

    if not args.write:
        print('\nDry-run complete. Re-run with --write to apply changes.')


if __name__ == '__main__':
    main()
