#!/usr/bin/env python3
"""Fix segment FHIR StructureDefinition fields based on V2.9.1 extracted data.

Applies corrections identified by compare_segments.py:
1. Cardinality (max): active repeating fields from max=0 to max=*
2. Cardinality (min): required fields from min=0 to min=1
3. B fields: restore original cardinality, add standards-status "deprecated"
4. W fields: set max=0, elide data types from 6 that have them,
   add standards-status "withdrawn"
5. Length: correct min/max length extensions
6. Conformance length: correct length value and noTruncate flag

Usage:
    python3 tooling/scripts/fix_segment_fields.py --dry-run
    python3 tooling/scripts/fix_segment_fields.py
    python3 tooling/scripts/fix_segment_fields.py --subset OBX,PID
"""

import argparse
import json
import os
import re
import sys
from pathlib import Path

from v2_utils import load_json, PROJECT_ROOT, SEGMENTS_DIR
from compare_segments import (
    extract_fhir_fields, extract_v291_fields,
    parse_v291_repetition, parse_v291_length, parse_v291_conf_length,
    get_extension, get_sub_extension,
)

V291_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'segments')

STANDARDS_STATUS_URL = (
    'http://hl7.org/fhir/StructureDefinition/'
    'structuredefinition-standards-status'
)


def find_element_by_seq(elements, seq_str):
    """Find a FHIR element by its sequence number.

    Args:
        elements: List of FHIR element dicts (differential.element)
        seq_str: Sequence number as string (e.g. "5")

    Returns:
        The element dict, or None
    """
    for elem in elements[1:]:  # Skip root
        path = elem.get('path', '')
        suffix = path.rsplit('.', 1)[-1] if '.' in path else ''
        seq = suffix.split('-', 1)[0] if suffix else ''
        if seq == seq_str:
            return elem
    return None


def set_standards_status(elem, status_code):
    """Add or update the standards-status extension on an element.

    Args:
        elem: FHIR element dict
        status_code: "withdrawn" or "deprecated"
    """
    extensions = elem.setdefault('extension', [])
    # Check if already present
    for ext in extensions:
        if ext.get('url') == STANDARDS_STATUS_URL:
            ext['valueCode'] = status_code
            return
    # Add new
    extensions.append({
        'url': STANDARDS_STATUS_URL,
        'valueCode': status_code,
    })


def set_length_extension(elem, v291_min, v291_max):
    """Set or update the length extension on an element.

    Args:
        elem: FHIR element dict
        v291_min: Min length (int or None)
        v291_max: Max length (int or None)
    """
    if v291_min is None and v291_max is None:
        return

    extensions = elem.setdefault('extension', [])
    length_url = 'http://hl7.org/v2/StructureDefinition/length'

    # Find existing length extension
    existing = None
    for ext in extensions:
        url = ext.get('url', '')
        if url == length_url:
            existing = ext
            break

    sub_exts = []
    if v291_min is not None:
        sub_exts.append({'url': 'min', 'valueInteger': v291_min})
    if v291_max is not None:
        sub_exts.append({'url': 'max', 'valueInteger': v291_max})

    if existing:
        existing['extension'] = sub_exts
    else:
        extensions.append({
            'url': length_url,
            'extension': sub_exts,
        })


def set_conf_length_extension(elem, v291_len, v291_trunc):
    """Set or update the conformance-length extension on an element.

    Args:
        elem: FHIR element dict
        v291_len: Conformance length (int or None)
        v291_trunc: noTruncate flag (1=no truncate, 0=truncation ok, None)
    """
    if v291_len is None and v291_trunc is None:
        return

    extensions = elem.setdefault('extension', [])
    clen_url = 'http://hl7.org/v2/StructureDefinition/conformance-length'

    existing = None
    for ext in extensions:
        if ext.get('url') == clen_url:
            existing = ext
            break

    sub_exts = []
    if v291_len is not None:
        sub_exts.append({'url': 'length', 'valueInteger': v291_len})
    if v291_trunc is not None:
        sub_exts.append({'url': 'noTruncate', 'valueInteger': v291_trunc})

    if existing:
        existing['extension'] = sub_exts
    else:
        extensions.append({
            'url': clen_url,
            'extension': sub_exts,
        })


def remove_length_extension(elem):
    """Remove the length extension from an element if present."""
    extensions = elem.get('extension', [])
    length_url = 'http://hl7.org/v2/StructureDefinition/length'
    elem['extension'] = [e for e in extensions if e.get('url') != length_url]
    if not elem['extension']:
        del elem['extension']


def fix_segment(segment_id, fhir_data, v291_data, dry_run=False):
    """Apply all fixes to a single segment.

    Returns:
        List of change descriptions, and whether fhir_data was modified
    """
    changes = []
    elements = fhir_data.get('differential', {}).get('element', [])
    v291_fields, _, _ = extract_v291_fields(v291_data)

    modified = False

    for seq_str, v291 in v291_fields.items():
        elem = find_element_by_seq(elements, seq_str)
        if elem is None:
            continue

        v291_opt = v291['optionality']
        v291_rep = v291['repetition']
        v291_dt = v291['data_type']
        is_w = v291_opt == 'W'
        is_b = v291_opt == 'B'

        # --- Standards-status extension ---
        if is_w:
            set_standards_status(elem, 'withdrawn')
            changes.append(f'{segment_id}.{seq_str}: add standards-status=withdrawn')
            modified = True
        elif is_b:
            set_standards_status(elem, 'deprecated')
            changes.append(f'{segment_id}.{seq_str}: add standards-status=deprecated')
            modified = True

        # --- W fields: elide data types if present, set max=0 ---
        if is_w:
            if elem.get('type'):
                changes.append(f'{segment_id}.{seq_str}: elide type '
                             f'{elem["type"][0].get("code", "?")} (W field, ADR-0005)')
                del elem['type']
                modified = True
            if str(elem.get('max', '*')) != '0':
                old_max = elem.get('max', '*')
                elem['max'] = '0'
                changes.append(f'{segment_id}.{seq_str}: max {old_max} -> 0 (W field)')
                modified = True
            continue  # Skip other fixes for W fields

        # --- B fields: restore original cardinality ---
        if is_b:
            expected_max = parse_v291_repetition(v291_rep)
            actual_max = str(elem.get('max', '*'))
            if actual_max != expected_max:
                elem['max'] = expected_max if expected_max != '*' else '*'
                # max in JSON: "*" is string, numbers should be string too for consistency
                # But looking at the existing data, max is stored as int for numbers
                if expected_max.isdigit():
                    elem['max'] = int(expected_max)
                changes.append(f'{segment_id}.{seq_str}: max {actual_max} -> {expected_max} (B field, restore original)')
                modified = True

        # --- Active fields: fix cardinality ---
        if not is_w and not is_b:
            # Fix max
            expected_max = parse_v291_repetition(v291_rep)
            actual_max = str(elem.get('max', '*'))
            if actual_max != expected_max:
                if expected_max == '*':
                    elem['max'] = '*'
                elif expected_max.isdigit():
                    elem['max'] = int(expected_max)
                else:
                    elem['max'] = expected_max
                changes.append(f'{segment_id}.{seq_str}: max {actual_max} -> {expected_max}')
                modified = True

            # Fix min
            expected_min = 1 if v291_opt == 'R' else 0
            actual_min = elem.get('min', 0)
            if actual_min != expected_min:
                elem['min'] = expected_min
                changes.append(f'{segment_id}.{seq_str}: min {actual_min} -> {expected_min}')
                modified = True

        # --- Length fixes (all non-W fields) ---
        if not is_w:
            v291_len_min, v291_len_max = parse_v291_length(v291['length'])
            fhir_exts = elem.get('extension', [])
            len_ext = get_extension(fhir_exts, '/length')
            fhir_len_min = None
            fhir_len_max = None
            if len_ext and 'conformance' not in len_ext.get('url', ''):
                min_sub = get_sub_extension(len_ext, 'min')
                max_sub = get_sub_extension(len_ext, 'max')
                if min_sub:
                    fhir_len_min = int(min_sub.get('valueInteger')) if min_sub.get('valueInteger') is not None else None
                if max_sub:
                    fhir_len_max = int(max_sub.get('valueInteger')) if max_sub.get('valueInteger') is not None else None

            if v291_len_min is not None or v291_len_max is not None:
                if v291_len_min != fhir_len_min or v291_len_max != fhir_len_max:
                    set_length_extension(elem, v291_len_min, v291_len_max)
                    changes.append(f'{segment_id}.{seq_str}: length '
                                 f'{fhir_len_min}..{fhir_len_max} -> {v291_len_min}..{v291_len_max}')
                    modified = True
            elif fhir_len_min is not None or fhir_len_max is not None:
                # V291 has no length but FHIR does — leave FHIR as-is
                pass

        # --- Conformance length fixes (all non-W fields) ---
        if not is_w:
            v291_clen, v291_trunc = parse_v291_conf_length(v291['conf_length'])
            fhir_exts = elem.get('extension', [])
            clen_ext = get_extension(fhir_exts, 'conformance-length')
            fhir_clen = None
            fhir_trunc = None
            if clen_ext:
                len_sub = get_sub_extension(clen_ext, 'length')
                trunc_sub = get_sub_extension(clen_ext, 'noTruncate')
                if len_sub:
                    fhir_clen = int(len_sub.get('valueInteger')) if len_sub.get('valueInteger') is not None else None
                if trunc_sub:
                    fhir_trunc = int(trunc_sub.get('valueInteger')) if trunc_sub.get('valueInteger') is not None else None

            if v291_clen is not None or v291_trunc is not None:
                if v291_clen != fhir_clen or v291_trunc != fhir_trunc:
                    set_conf_length_extension(elem, v291_clen, v291_trunc)
                    old = f'{fhir_clen}{"=" if fhir_trunc == 1 else "#" if fhir_trunc == 0 else "?"}' if fhir_clen is not None else 'none'
                    new = f'{v291_clen}{"=" if v291_trunc == 1 else "#" if v291_trunc == 0 else "?"}' if v291_clen is not None else 'none'
                    changes.append(f'{segment_id}.{seq_str}: conf_length {old} -> {new}')
                    modified = True

    return changes, modified


def main():
    parser = argparse.ArgumentParser(
        description='Fix segment FHIR JSON fields based on V2.9.1 extracted data')
    parser.add_argument('--dry-run', action='store_true',
                        help='Report changes without modifying files')
    parser.add_argument('--subset', type=str, default=None,
                        help='Comma-separated segment IDs (e.g. OBX,PID)')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = [s.strip() for s in args.subset.split(',')]

    if not os.path.isdir(SEGMENTS_DIR):
        print(f"Error: FHIR segments dir not found: {SEGMENTS_DIR}")
        sys.exit(1)
    if not os.path.isdir(V291_DIR):
        print(f"Error: V291 segments dir not found: {V291_DIR}")
        sys.exit(1)

    mode = "DRY RUN" if args.dry_run else "APPLYING FIXES"
    print(f"Fixing segment fields ({mode})...")

    total_changes = 0
    files_modified = 0

    fhir_files = sorted(Path(SEGMENTS_DIR).glob('*.json'))
    for fhir_path in fhir_files:
        seg_id = fhir_path.stem
        if subset and seg_id not in subset:
            continue

        v291_path = Path(V291_DIR) / f'{seg_id}.json'
        if not v291_path.exists():
            continue

        fhir_data = load_json(str(fhir_path))
        v291_data = load_json(str(v291_path))

        changes, modified = fix_segment(seg_id, fhir_data, v291_data, dry_run=args.dry_run)

        if changes:
            total_changes += len(changes)
            if modified:
                files_modified += 1
                if not args.dry_run:
                    with open(fhir_path, 'w', encoding='utf-8') as f:
                        json.dump(fhir_data, f, indent=2, ensure_ascii=False)
                        f.write('\n')

    print(f"\n  {total_changes} changes across {files_modified} files")
    if args.dry_run:
        print("  (dry run — no files modified)")


if __name__ == '__main__':
    main()
