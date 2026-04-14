#!/usr/bin/env python3
"""Fix data type component conformance length flags based on V291 comparison.

Corrects noTruncate boolean values in FHIR complex data type JSON files
where V291 says '#' (truncation allowed, noTruncate=false) but FHIR has
noTruncate=true.

Usage:
    python3 tooling/scripts/fix_data_type_fields.py              # dry run
    python3 tooling/scripts/fix_data_type_fields.py --apply       # apply fixes
    python3 tooling/scripts/fix_data_type_fields.py --subset CWE  # specific types
"""

import argparse
import json
import os
import sys
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from compare_data_types import (
    extract_fhir_components,
    extract_v291_components,
    FHIR_DT_DIR,
    V291_DT_DIR,
)
from compare_segments import (
    parse_v291_conf_length,
    get_extension,
    get_sub_extension,
)
from v2_utils import load_json


def find_component_element(fhir_data, seq):
    """Find the element dict for a specific component sequence number."""
    elements = fhir_data.get('differential', {}).get('element', [])
    for elem in elements[1:]:  # skip root
        path = elem.get('path', '')
        suffix = path.rsplit('.', 1)[-1] if '.' in path else ''
        elem_seq = suffix.split('-', 1)[0] if suffix else ''
        if elem_seq == seq:
            return elem
    return None


def fix_conf_length(elem, expected_no_truncate):
    """Fix the noTruncate value in a conformance-length extension.

    Returns True if a change was made.
    """
    extensions = elem.get('extension', [])
    clen_ext = get_extension(extensions, 'conformance-length')
    if not clen_ext:
        return False

    trunc_sub = get_sub_extension(clen_ext, 'noTruncate')
    if not trunc_sub:
        return False

    # Check both valueBoolean and valueInteger formats
    current = trunc_sub.get('valueBoolean')
    if current is None:
        current_int = trunc_sub.get('valueInteger')
        if current_int is not None:
            current = bool(current_int)

    if current is None:
        return False

    expected_bool = bool(expected_no_truncate)
    if current == expected_bool:
        return False

    # Apply fix — use whichever format the file currently uses
    if 'valueBoolean' in trunc_sub:
        trunc_sub['valueBoolean'] = expected_bool
    elif 'valueInteger' in trunc_sub:
        trunc_sub['valueInteger'] = 1 if expected_bool else 0

    return True


def main():
    parser = argparse.ArgumentParser(description='Fix data type conformance length flags')
    parser.add_argument('--apply', action='store_true', help='Apply fixes (default is dry run)')
    parser.add_argument('--subset', help='Comma-separated list of data type codes')
    args = parser.parse_args()

    # Load comparison report for the list of fixes needed
    report_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                '..', 'v291-extracted', 'data-type-comparison-report.json')
    report_path = os.path.normpath(report_path)
    report = load_json(report_path)
    if not report:
        print("ERROR: Could not load comparison report")
        sys.exit(1)

    subset = None
    if args.subset:
        subset = [s.strip().upper() for s in args.subset.split(',')]

    total_fixes = 0
    files_modified = 0

    for dt_result in report['data_types']:
        dt_code = dt_result['data_type']
        if subset and dt_code not in subset:
            continue

        # Collect conf_length fixes for this data type
        fixes = []
        for disc in dt_result['discrepancies']:
            if disc['dimension'] != 'conf_length':
                continue
            seq = disc['seq']
            v291_expected = disc['expected']  # e.g., "120#"

            # Parse V291 value to get expected noTruncate
            _, expected_no_truncate = parse_v291_conf_length(v291_expected)
            if expected_no_truncate is not None:
                fixes.append((seq, expected_no_truncate, v291_expected))

        if not fixes:
            continue

        # Load FHIR file
        fhir_file = os.path.join(FHIR_DT_DIR, f'{dt_code.lower()}.json')
        if not os.path.exists(fhir_file):
            print(f"  WARNING: {fhir_file} not found")
            continue

        fhir_data = load_json(fhir_file)
        if not fhir_data:
            continue

        applied = 0
        for seq, expected_no_truncate, v291_val in fixes:
            elem = find_component_element(fhir_data, seq)
            if not elem:
                print(f"  WARNING: {dt_code}.{seq} element not found")
                continue

            if fix_conf_length(elem, expected_no_truncate):
                flag = '=' if expected_no_truncate else '#'
                print(f"  {dt_code}.{seq}: noTruncate → {bool(expected_no_truncate)} ({flag})")
                applied += 1

        if applied > 0:
            total_fixes += applied
            files_modified += 1

            if args.apply:
                with open(fhir_file, 'w') as f:
                    json.dump(fhir_data, f, indent=2)
                    f.write('\n')
                print(f"  → Wrote {fhir_file} ({applied} fixes)")
            else:
                print(f"  → Would fix {fhir_file} ({applied} fixes) [DRY RUN]")

    print(f"\n{'='*60}")
    print(f"{'APPLIED' if args.apply else 'DRY RUN'}: {total_fixes} fixes across {files_modified} files")
    if not args.apply and total_fixes > 0:
        print("Run with --apply to write changes")


if __name__ == '__main__':
    main()
