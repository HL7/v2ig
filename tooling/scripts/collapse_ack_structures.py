#!/usr/bin/env python3
"""Collapse the 115 enumerated ACK message structures into 2 canonical ones.

Background: each event using a standard acknowledgment response had its own
ACK-X.json (where X = A through DK), but only 2 of the 115 are actually
referenced by message files: ACK-A (279 messages) and ACK-BY (15 messages,
the scheduling-acknowledgment outlier with UAC marked as repeating). The
other 113 ACK-* structure files are orphans.

This script:

  1. Renames ACK-A.json -> ACK.json (rewrites id, url, element ids).
  2. Renames ACK-BY.json -> ACK-Scheduling.json (same rewrites). The
     "Scheduling" name is provisional pending V2 Management review of
     REVIEW-0001 (whether the UAC repetition in clause 10.4 is intentional).
  3. Updates 279 message files to reference ACK in place of ACK-A.
  4. Updates 15 message files to reference ACK-Scheduling in place of ACK-BY.
  5. Moves the 113 unreferenced ACK-* structure files to
     _archive/unreferenced-ack-structures/ (gitignored).
  6. Rewrites the listing page (input/pagecontent/message-structures.xml),
     the CodeSystem (input/sourceOfTruth/meta-resources/message-structure--v2-cs-message-structures.json),
     and the control manifest (input/sourceOfTruth/control-manifests/message_structures.json)
     to enumerate ACK and ACK-Scheduling instead of ACK-A..ACK-DK.

Run with --dry-run to print the planned changes without touching the tree.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import sys
from glob import glob

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
STRUCT_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'message-structure', 'message_structures')
MSG_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'message', 'messages')
LISTING_PAGE = os.path.join(PROJECT_ROOT, 'input', 'pagecontent', 'message-structures.xml')
CODESYSTEM = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'meta-resources',
                          'message-structure--v2-cs-message-structures.json')
CONTROL_MANIFEST = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'control-manifests',
                                'message_structures.json')
ARCHIVE_DIR = os.path.join(PROJECT_ROOT, '_archive', 'unreferenced-ack-structures')


def rewrite_structure(path: str, old_name: str, new_name: str) -> dict:
    """Load a StructureDefinition and rewrite all old_name occurrences to new_name.

    StructureDefinition has multiple top-level fields that carry the structure
    name: id, url, name, title, type. All must agree, because the IG Publisher
    validates that differential element paths start with the value of `type`
    (or with the structure's logical name for logical-model resources).
    """
    with open(path) as f:
        d = json.load(f)
    d['id'] = new_name
    d['url'] = f'http://hl7.org/v2/StructureDefinition/{new_name}'
    if 'name' in d:
        d['name'] = new_name
    if 'type' in d:
        d['type'] = new_name
    if 'title' in d and isinstance(d['title'], str) and old_name in d['title']:
        d['title'] = d['title'].replace(old_name, new_name)
    for elem in d.get('differential', {}).get('element', []):
        if elem.get('id') == old_name:
            elem['id'] = new_name
            elem['path'] = new_name
            elem['short'] = new_name
            elem['definition'] = f'{new_name} Message Structure'
        else:
            for key in ('id', 'path'):
                if key in elem and elem[key].startswith(old_name + '.'):
                    elem[key] = new_name + elem[key][len(old_name):]
    return d


def update_message_file(path: str, old_name: str, new_name: str) -> bool:
    """Rewrite a message file's structure reference. Returns True if changed.

    The URL form in messages is
    `http://hl7.org/fhir/StructureDefinition/MessageStructure/<NAME>`,
    so we match by trailing `/<old_name>` and swap just the last path
    component.
    """
    with open(path) as f:
        d = json.load(f)
    changed = False
    suffix = '/' + old_name
    for elem in d.get('differential', {}).get('element', []):
        if elem.get('path') != 'Message.structure':
            continue
        for tref in elem.get('type', []):
            new_profiles = []
            for tp in tref.get('targetProfile', []):
                if tp.endswith(suffix):
                    new_profiles.append(tp[:-len(old_name)] + new_name)
                    changed = True
                else:
                    new_profiles.append(tp)
            tref['targetProfile'] = new_profiles
    if changed:
        with open(path, 'w') as f:
            json.dump(d, f, indent=4)
            f.write('\n')
    return changed


def find_message_refs() -> dict[str, list[str]]:
    """Return {structure_id: [message_file_basenames]}."""
    refs: dict[str, list[str]] = {}
    for f in sorted(glob(os.path.join(MSG_DIR, 'ACK-*.json'))):
        d = json.load(open(f))
        for elem in d.get('differential', {}).get('element', []):
            if elem.get('path') != 'Message.structure':
                continue
            for tref in elem.get('type', []):
                for tp in tref.get('targetProfile', []):
                    sid = tp.split('/')[-1]
                    refs.setdefault(sid, []).append(os.path.basename(f))
    return refs


def rewrite_listing_page(dry_run: bool) -> int:
    """Rewrite input/pagecontent/message-structures.xml.

    Replaces the 115 ACK-* rows with 2 rows: ACK and ACK-Scheduling.
    """
    with open(LISTING_PAGE) as f:
        text = f.read()

    row_pattern = re.compile(
        r'\s*<tr class="data-row"><td><a href="StructureDefinition-ACK-[A-Z]+\.html">'
        r'ACK-[A-Z]+</a></td></tr>'
    )
    matches = list(row_pattern.finditer(text))
    if not matches:
        print(f'  [listing] no ACK-* rows found in {LISTING_PAGE}', file=sys.stderr)
        return 0
    first, last = matches[0], matches[-1]
    indent = '      '  # 6-space indent matches the surrounding rows
    replacement = (
        f'{indent}<tr class="data-row"><td>'
        f'<a href="StructureDefinition-ACK.html">ACK</a></td></tr>\n'
        f'{indent}<tr class="data-row"><td>'
        f'<a href="StructureDefinition-ACK-Scheduling.html">ACK-Scheduling</a></td></tr>'
    )
    new_text = text[:first.start()] + '\n' + replacement + text[last.end():]
    print(f'  [listing] replaced {len(matches)} rows with 2 (ACK, ACK-Scheduling)')
    if not dry_run:
        with open(LISTING_PAGE, 'w') as f:
            f.write(new_text)
    return len(matches)


def rewrite_json_concept_list(path: str, dry_run: bool) -> int:
    """Replace ACK-* concepts in a CodeSystem.

    Looks for entries whose `code` matches ^ACK-[A-Z]+$ and replaces the
    whole run with two concepts: ACK and ACK-Scheduling.
    """
    with open(path) as f:
        d = json.load(f)
    concepts = d.get('concept', [])
    if not concepts:
        print(f'  [{os.path.basename(path)}] no concept list found', file=sys.stderr)
        return 0

    ack_indices = [i for i, c in enumerate(concepts)
                   if isinstance(c.get('code'), str) and re.fullmatch(r'ACK-[A-Z]+', c['code'])]
    if not ack_indices:
        return 0

    first, last = ack_indices[0], ack_indices[-1]
    new_concepts = (
        concepts[:first]
        + [
            {'code': 'ACK', 'display': 'ACK'},
            {'code': 'ACK-Scheduling', 'display': 'ACK-Scheduling'},
        ]
        + concepts[last + 1:]
    )
    d['concept'] = new_concepts
    print(f'  [{os.path.basename(path)}] replaced {len(ack_indices)} concepts with 2 '
          f'(ACK, ACK-Scheduling)')
    if not dry_run:
        with open(path, 'w') as f:
            json.dump(d, f, indent=2)
            f.write('\n')
    return len(ack_indices)


def rewrite_control_manifest(dry_run: bool) -> int:
    """Replace ACK-* references in the control manifest.

    The manifest is a FHIR List with `entry: [{item: {reference, display}}, ...]`.
    """
    with open(CONTROL_MANIFEST) as f:
        d = json.load(f)

    entries = d.get('entry', [])
    if not entries:
        print(f'  [control_manifest] no entry list found', file=sys.stderr)
        return 0

    def is_ack(e):
        ref = e.get('item', {}).get('reference', '')
        return bool(re.fullmatch(r'StructureDefinition/ACK-[A-Z]+', ref))

    ack_indices = [i for i, e in enumerate(entries) if is_ack(e)]
    if not ack_indices:
        return 0

    first, last = ack_indices[0], ack_indices[-1]
    new_entries = (
        entries[:first]
        + [
            {'item': {'reference': 'StructureDefinition/ACK', 'display': 'ACK'}},
            {'item': {'reference': 'StructureDefinition/ACK-Scheduling',
                      'display': 'ACK-Scheduling'}},
        ]
        + entries[last + 1:]
    )
    d['entry'] = new_entries
    print(f'  [control_manifest] replaced {len(ack_indices)} entries with 2 '
          f'(ACK, ACK-Scheduling)')
    if not dry_run:
        with open(CONTROL_MANIFEST, 'w') as f:
            json.dump(d, f, indent=2)
            f.write('\n')
    return len(ack_indices)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--dry-run', action='store_true',
                    help='Print planned changes without touching the tree.')
    args = ap.parse_args()

    print(f'=== ACK Structure Collapse {"(DRY RUN)" if args.dry_run else ""} ===')

    # Step 0: enumerate the current state.
    struct_files = sorted(glob(os.path.join(STRUCT_DIR, 'ACK-*.json')))
    print(f'Found {len(struct_files)} ACK-* structure files')

    refs = find_message_refs()
    referenced = set(refs.keys())
    canonical_referrers = refs.get('ACK-A', [])
    scheduling_referrers = refs.get('ACK-BY', [])
    print(f'Referenced by message files:')
    print(f'  ACK-A: {len(canonical_referrers)} messages')
    print(f'  ACK-BY: {len(scheduling_referrers)} messages')
    other_referenced = referenced - {'ACK-A', 'ACK-BY'}
    if other_referenced:
        print(f'  WARNING: other referenced ACK structures present: {sorted(other_referenced)}',
              file=sys.stderr)
        print(f'  Refusing to proceed; this script only knows how to collapse ACK-A and ACK-BY.',
              file=sys.stderr)
        return 1

    if not os.path.exists(os.path.join(STRUCT_DIR, 'ACK-A.json')):
        print(f'ACK-A.json not found in {STRUCT_DIR}; nothing to do.')
        return 1

    # Step 1: rewrite ACK-A -> ACK.
    print('--- Step 1: rewrite ACK-A -> ACK ---')
    ack_path = os.path.join(STRUCT_DIR, 'ACK.json')
    new_d = rewrite_structure(os.path.join(STRUCT_DIR, 'ACK-A.json'), 'ACK-A', 'ACK')
    print(f'  Will write {ack_path}')
    if not args.dry_run:
        with open(ack_path, 'w') as f:
            json.dump(new_d, f, indent=4)
            f.write('\n')
        os.remove(os.path.join(STRUCT_DIR, 'ACK-A.json'))

    # Step 2: rewrite ACK-BY -> ACK-Scheduling.
    print('--- Step 2: rewrite ACK-BY -> ACK-Scheduling ---')
    sched_path = os.path.join(STRUCT_DIR, 'ACK-Scheduling.json')
    by_src = os.path.join(STRUCT_DIR, 'ACK-BY.json')
    if os.path.exists(by_src):
        new_d = rewrite_structure(by_src, 'ACK-BY', 'ACK-Scheduling')
        # Document why this variant exists separately.
        new_d.setdefault('description',
                         'Acknowledgment variant for scheduling messages '
                         '(ACK^S12-S24, S26, S27). UAC is encoded as repeating in V2.9.1 '
                         'clause 10.4 — REVIEW-0001 pending V2 Management review of '
                         'whether this is intentional or a typo. If a typo, this '
                         'structure can be merged into the canonical ACK.')
        print(f'  Will write {sched_path}')
        if not args.dry_run:
            with open(sched_path, 'w') as f:
                json.dump(new_d, f, indent=4)
                f.write('\n')
            os.remove(by_src)

    # Step 3 + 4: rewrite message refs.
    print('--- Step 3: update 279 message files ACK-A -> ACK ---')
    n = 0
    for basename in canonical_referrers:
        path = os.path.join(MSG_DIR, basename)
        if args.dry_run:
            n += 1
        elif update_message_file(path, 'ACK-A', 'ACK'):
            n += 1
    print(f'  Updated {n} message files')

    print('--- Step 4: update 15 message files ACK-BY -> ACK-Scheduling ---')
    n = 0
    for basename in scheduling_referrers:
        path = os.path.join(MSG_DIR, basename)
        if args.dry_run:
            n += 1
        elif update_message_file(path, 'ACK-BY', 'ACK-Scheduling'):
            n += 1
    print(f'  Updated {n} message files')

    # Step 5: archive the 113 unreferenced ACK-* structure files.
    orphan_files = [
        f for f in struct_files
        if os.path.basename(f).replace('.json', '') not in {'ACK-A', 'ACK-BY'}
    ]
    print(f'--- Step 5: archive {len(orphan_files)} unreferenced ACK-* files ---')
    print(f'  Destination: {ARCHIVE_DIR}')
    if not args.dry_run:
        os.makedirs(ARCHIVE_DIR, exist_ok=True)
        for path in orphan_files:
            shutil.move(path, os.path.join(ARCHIVE_DIR, os.path.basename(path)))

    # Step 6: rewrite the listing/CodeSystem/manifest.
    print('--- Step 6: rewrite listing page, CodeSystem, control manifest ---')
    rewrite_listing_page(args.dry_run)
    rewrite_json_concept_list(CODESYSTEM, args.dry_run)
    rewrite_control_manifest(args.dry_run)

    print('=== Done ===')
    return 0


if __name__ == '__main__':
    sys.exit(main())
