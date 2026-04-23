#!/usr/bin/env python3
"""Replace literal '...' segment placeholder with Hxx in message-structure
StructureDefinitions.

The V2.9.1 source uses '...' as an "any segment / variable" placeholder in
several message structures (CH05 query patterns, CH08 site-defined master
file notifications, etc.). When this is encoded literally in FHIR
StructureDefinition element ids and paths, the IG Publisher's snapshot
generator splits the path on '.' and ends up with empty path segments,
producing errors like:

    Unable to find parent path X.Y.Z.. for element X.Y.Z...

The codebase already has an Hxx StructureDefinition (segment placeholder,
"any segment or segment group") used by 4 CH12 message structures. This
script unifies the '...' notation with Hxx wherever it appears in element
ids, paths, and type codes.

It does NOT change cardinality — descriptions vary per file and that is a
separate per-file decision.

Idempotent. Safe to re-run.

Usage:
    python3 tooling/scripts/fix_dots_placeholder.py [--dry-run]
"""

import argparse
import json
import os
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MSG_STRUCT_DIR = os.path.join(PROJECT_ROOT, 'input/sourceOfTruth/message-structure/message_structures')
CONTROL_MANIFEST = os.path.join(PROJECT_ROOT, 'input/sourceOfTruth/control-manifests/segments.json')

PLACEHOLDER_OLD = '...'
PLACEHOLDER_NEW = 'Hxx'
TYPE_CODE_OLD = 'http://hl7.org/v2/StructureDefinition/...'
TYPE_CODE_NEW = 'http://hl7.org/v2/StructureDefinition/Hxx'
REFERENCE_OLD = 'StructureDefinition/...'
REFERENCE_NEW = 'StructureDefinition/Hxx'


def fix_message_structure(path):
    """Apply the '...' -> Hxx substitution to a single StructureDefinition file.

    Returns a list of human-readable change descriptions (empty if no changes).
    """
    with open(path, 'r') as f:
        sd = json.load(f)

    changes = []
    elements = sd.get('differential', {}).get('element', [])
    for el in elements:
        el_id = el.get('id', '')
        el_path = el.get('path', '')

        if el_id.endswith('-' + PLACEHOLDER_OLD):
            new_id = el_id[: -len(PLACEHOLDER_OLD)] + PLACEHOLDER_NEW
            el['id'] = new_id
            changes.append(f"  id:   {el_id!r} -> {new_id!r}")

        if el_path.endswith('-' + PLACEHOLDER_OLD):
            new_path = el_path[: -len(PLACEHOLDER_OLD)] + PLACEHOLDER_NEW
            el['path'] = new_path
            changes.append(f"  path: {el_path!r} -> {new_path!r}")

        for type_entry in el.get('type', []):
            if type_entry.get('code') == TYPE_CODE_OLD:
                type_entry['code'] = TYPE_CODE_NEW
                changes.append(f"  type code: {TYPE_CODE_OLD!r} -> {TYPE_CODE_NEW!r}")

    return sd, changes


def fix_control_manifest(path):
    """Update the segments control manifest reference to Hxx (or remove if
    Hxx already present)."""
    with open(path, 'r') as f:
        manifest = json.load(f)

    changes = []
    entries = manifest.get('entry', [])
    has_hxx = any(
        entry.get('item', {}).get('reference') == REFERENCE_NEW for entry in entries
    )

    new_entries = []
    for entry in entries:
        ref = entry.get('item', {}).get('reference', '')
        if ref == REFERENCE_OLD:
            if has_hxx:
                changes.append(f"  removed dangling reference {REFERENCE_OLD!r} (Hxx already present)")
                continue
            entry['item']['reference'] = REFERENCE_NEW
            entry['item']['display'] = 'Any segment or segment group'
            changes.append(f"  reference: {REFERENCE_OLD!r} -> {REFERENCE_NEW!r}")
        new_entries.append(entry)

    manifest['entry'] = new_entries
    return manifest, changes


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dry-run', action='store_true', help='Show changes without writing')
    args = parser.parse_args()

    fixed_count = 0
    skipped_count = 0
    total_changes = 0

    for fname in sorted(os.listdir(MSG_STRUCT_DIR)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(MSG_STRUCT_DIR, fname)
        sd, changes = fix_message_structure(fpath)
        if not changes:
            skipped_count += 1
            continue
        print(f"{fname}:")
        for c in changes:
            print(c)
        total_changes += len(changes)
        if not args.dry_run:
            with open(fpath, 'w') as f:
                json.dump(sd, f, indent=2, ensure_ascii=False)
                f.write('\n')
        fixed_count += 1

    print(f"\nControl manifest: {os.path.relpath(CONTROL_MANIFEST, PROJECT_ROOT)}")
    manifest, mchanges = fix_control_manifest(CONTROL_MANIFEST)
    if mchanges:
        for c in mchanges:
            print(c)
        total_changes += len(mchanges)
        if not args.dry_run:
            with open(CONTROL_MANIFEST, 'w') as f:
                json.dump(manifest, f, indent=2, ensure_ascii=False)
                f.write('\n')
    else:
        print("  (no changes)")

    mode = 'DRY RUN' if args.dry_run else 'APPLIED'
    print(f"\n[{mode}] message structures fixed: {fixed_count}, skipped: {skipped_count}, total changes: {total_changes}")
    return 0


if __name__ == '__main__':
    sys.exit(main())
