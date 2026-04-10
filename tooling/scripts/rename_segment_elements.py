#!/usr/bin/env python3
"""Rename segment element IDs to include camelCase short names.

Changes element id and path from "OBX.1" to "OBX.1-setId" format so that
the IG Publisher's differential/snapshot tables show meaningful names.

Usage:
    python3 tooling/scripts/rename_segment_elements.py           # dry run
    python3 tooling/scripts/rename_segment_elements.py --apply   # apply changes
    python3 tooling/scripts/rename_segment_elements.py --subset OBX,PID  # specific segments
"""

import argparse
import glob
import json
import os
import re
import sys

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
SEGMENTS_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth',
                            'segment', 'segments')


def short_to_camel(short_name, segment_id=None):
    """Convert a V2 field short name to FHIR-style lowerCamelCase.

    Args:
        short_name: The element's short description (e.g., "Set ID – OBX")
        segment_id: Segment ID to strip as suffix (e.g., "OBX")

    Returns:
        lowerCamelCase string (e.g., "setId")
    """
    name = short_name
    # Strip segment suffix (e.g., " – OBX", " - PID")
    if segment_id:
        name = re.sub(rf'\s*[–\-]\s*{re.escape(segment_id)}\s*$', '', name)
    # Drop apostrophes
    name = name.replace("'", "")
    # Split on non-alphanumeric characters
    words = re.split(r'[^a-zA-Z0-9]+', name)
    words = [w for w in words if w]
    if not words:
        return ''
    # lowerCamelCase: first word lowercase, rest title-cased
    result = words[0].lower()
    for w in words[1:]:
        result += w[0].upper() + w[1:].lower() if len(w) > 1 else w.upper()
    return result


def rename_elements(filepath, apply=False):
    """Rename element IDs in a segment JSON file.

    Args:
        filepath: Path to the segment JSON file
        apply: If True, write changes. If False, dry run.

    Returns:
        List of (old_id, new_id) tuples for reporting
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)

    segment_id = data.get('id', '')
    elements = data.get('differential', {}).get('element', [])
    changes = []

    for elem in elements:
        old_id = elem.get('id', '')
        old_path = elem.get('path', '')

        # Skip root element
        if '.' not in old_id:
            continue

        short = elem.get('short', '')
        if not short:
            continue

        seq = old_id.split('.', 1)[1]
        # If already renamed (contains a hyphen after the seq number), skip
        if '-' in seq:
            continue

        camel = short_to_camel(short, segment_id)
        if not camel:
            continue

        new_suffix = f'{seq}-{camel}'
        # IG Publisher enforces 64-char max on the name portion (after the dot)
        if len(new_suffix) > 64:
            max_camel = 64 - len(seq) - 1  # -1 for the hyphen
            # Truncate at a camelCase word boundary (uppercase letter)
            truncated = camel[:max_camel]
            # Find the last uppercase letter and cut just before it
            for i in range(len(truncated) - 1, 0, -1):
                if truncated[i].isupper():
                    truncated = truncated[:i]
                    break
            camel = truncated
            new_suffix = f'{seq}-{camel}'
        new_id = f'{segment_id}.{new_suffix}'
        new_path = new_id  # path mirrors id in logical models

        elem['id'] = new_id
        elem['path'] = new_path
        changes.append((old_id, new_id))

    if apply and changes:
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
            f.write('\n')

    return changes


def main():
    parser = argparse.ArgumentParser(
        description='Rename segment element IDs to include camelCase short names')
    parser.add_argument('--apply', action='store_true',
                        help='Apply changes (default is dry run)')
    parser.add_argument('--subset', type=str, default=None,
                        help='Comma-separated list of segment IDs')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = set(args.subset.split(','))

    segment_files = sorted(glob.glob(os.path.join(SEGMENTS_DIR, '*.json')))
    total_changes = 0
    files_changed = 0

    for filepath in segment_files:
        seg_id = os.path.basename(filepath).replace('.json', '')
        if subset and seg_id not in subset:
            continue

        changes = rename_elements(filepath, apply=args.apply)
        if changes:
            files_changed += 1
            total_changes += len(changes)
            if args.subset or len(segment_files) <= 5:
                for old, new in changes:
                    print(f'  {old:<20} → {new}')

    mode = "Applied" if args.apply else "Would rename"
    print(f'\n{mode} {total_changes} element IDs across {files_changed} files')
    if not args.apply:
        print('Run with --apply to write changes')


if __name__ == '__main__':
    main()
