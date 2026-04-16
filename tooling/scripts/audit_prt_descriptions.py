#!/usr/bin/env python3
"""Audit PRT and OBX descriptions across all V291 canonical message structures.

Checks whether the parenthetical qualifier in PRT/OBX descriptions matches
the containing group name. Produces a text report with clause references.

Usage:
    python3 tooling/scripts/audit_prt_descriptions.py
"""

import json
import os
import re
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT

CANONICAL_DIR = os.path.join(PROJECT_ROOT, 'v291-canonical', 'message-structures')
REPORT_FILE = os.path.join(PROJECT_ROOT, 'v291-canonical', 'prt-obx-description-audit.txt')


def extract_segment_code(seg_str):
    return re.sub(r'[\[\]{}<>|\s]', '', seg_str).strip()


def find_group(rows, idx):
    """Find the innermost group containing row idx."""
    for j in range(idx - 1, -1, -1):
        desc = rows[j]['description']
        if desc.startswith('---') and 'begin' in desc:
            return desc.replace('---', '').replace('begin', '').strip()
    return ''


def titleize_group(group_name):
    """Convert GROUP_NAME to Title Case Words."""
    return ' '.join(w.capitalize() for w in group_name.split('_'))


def audit_structures():
    """Audit all canonical structures for PRT/OBX description issues."""
    findings = []

    for fname in sorted(os.listdir(CANONICAL_DIR)):
        if not fname.endswith('.json'):
            continue
        with open(os.path.join(CANONICAL_DIR, fname)) as f:
            data = json.load(f)

        sid = data['structureId']
        clause = data['provenance'].get('clause', '?')
        chapter = data['provenance'].get('chapter', '?')
        rows = data['rawRows']

        for i, row in enumerate(rows):
            code = extract_segment_code(row['segments'])
            desc = row['description']

            if code not in ('PRT', 'OBX'):
                continue

            group = find_group(rows, i)
            if not group:
                continue  # base-level, skip

            # Find preceding segment
            prev_code = ''
            prev_desc = ''
            for j in range(i - 1, -1, -1):
                pc = extract_segment_code(rows[j]['segments'])
                if pc and not rows[j]['description'].startswith('---'):
                    prev_code = pc
                    prev_desc = rows[j]['description']
                    break

            finding = {
                'segment': code,
                'sid': sid,
                'clause': clause,
                'chapter': chapter,
                'row': i + 1,
                'description': desc,
                'group': group,
                'prev_code': prev_code,
                'prev_desc': prev_desc,
                'category': '',
                'suggested': '',
            }

            if code == 'PRT':
                categorize_prt(finding)
            else:
                categorize_obx(finding)

            if finding['category']:
                findings.append(finding)

    return findings


def categorize_prt(f):
    """Categorize a PRT description issue."""
    desc = f['description']
    group = f['group']
    expected_group_title = titleize_group(group)

    # Check for typos
    if 'Participaton' in desc:
        f['category'] = 'typo'
        f['suggested'] = desc.replace('Participaton', 'Participation')
        return
    for typo, fix in [('Containter', 'Container'), ('Oservation', 'Observation'),
                      ('Speciment', 'Specimen')]:
        if typo in desc:
            f['category'] = 'typo'
            f['suggested'] = desc.replace(typo, fix)
            return

    # Unclosed parenthetical
    if '(' in desc and ')' not in desc:
        f['category'] = 'unclosed_paren'
        f['suggested'] = desc + ')'
        return

    # Extract qualifier
    m = re.match(r'Participation \(for (.+)\)', desc)
    if not m:
        if desc == 'Participation':
            f['category'] = 'bare'
            f['suggested'] = f'Participation (for {expected_group_title})'
        return

    qualifier = m.group(1)

    # Check titleization
    if qualifier != qualifier[0].upper() + qualifier[1:]:
        # lowercase start
        f['category'] = 'titleization'
        words = qualifier.split()
        fixed = ' '.join(w.capitalize() if w.lower() not in ('for', 'of', 'the', 'and', 'or', 'on') else w
                         for w in words)
        fixed = fixed[0].upper() + fixed[1:]
        f['suggested'] = f'Participation (for {fixed})'

    # Check if qualifier matches group
    if qualifier.lower().replace(' ', '_') == group.lower():
        return  # matches perfectly

    # Segment code as qualifier
    if re.match(r'^[A-Z]{2,4}$', qualifier):
        f['category'] = 'segment_code'
        f['suggested'] = f'Participation (for {f["prev_desc"]})'
        return

    # Qualifier mismatch
    if qualifier.lower().replace(' ', '_') != group.lower():
        if not f['category']:  # don't overwrite titleization
            f['category'] = 'qualifier_mismatch'
            f['suggested'] = f'Participation (for {expected_group_title})'


def categorize_obx(f):
    """Categorize an OBX description issue."""
    desc = f['description']
    group = f['group']
    expected = titleize_group(group)

    # Check for group-name mismatch
    # OBX descriptions often have parenthetical qualifiers too
    if 'Observation' in desc or 'Result' in desc:
        # Normalize for comparison
        desc_norm = desc.lower().replace(' ', '_').replace('/', '_')
        group_norm = group.lower()
        if desc_norm != group_norm and group_norm not in desc_norm:
            f['category'] = 'obx_mismatch'
            f['suggested'] = expected


def generate_report(findings):
    """Generate the audit report with clause references."""
    lines = []
    w = 120
    lines.append('=' * w)
    lines.append('PRT & OBX DESCRIPTION AUDIT REPORT')
    lines.append(f'Scanned {count_files()} files | '
                 f'{sum(1 for f in findings if f["segment"] == "PRT")} PRT findings | '
                 f'{sum(1 for f in findings if f["segment"] == "OBX")} OBX findings')
    lines.append('=' * w)

    # Group PRT findings by category
    prt = [f for f in findings if f['segment'] == 'PRT']
    obx = [f for f in findings if f['segment'] == 'OBX']

    prt_cats = defaultdict(list)
    for f in prt:
        prt_cats[f['category']].append(f)

    cat_labels = {
        'typo': 'Typos in description',
        'unclosed_paren': 'Unclosed parenthetical',
        'segment_code': 'Segment code used instead of group/segment name',
        'titleization': 'Wrong titleization',
        'qualifier_mismatch': 'Qualifier does not match group name',
        'bare': 'Bare "Participation" with no qualifier',
    }

    cat_order = ['typo', 'unclosed_paren', 'segment_code', 'titleization',
                 'qualifier_mismatch', 'bare']

    lines.append('')
    lines.append('=' * w)
    lines.append('PRT FINDINGS BY CATEGORY')
    lines.append('=' * w)

    for cat in cat_order:
        items = prt_cats.get(cat, [])
        if not items:
            continue

        lines.append('')
        lines.append('-' * w)
        lines.append(f'  {cat_labels.get(cat, cat)} ({len(items)} instances)')
        lines.append('-' * w)

        # Deduplicate by grouping identical patterns
        patterns = defaultdict(list)
        for f in items:
            key = (f['description'], f['group'], f['suggested'])
            patterns[key].append(f)

        for (desc, group, suggested), instances in sorted(patterns.items()):
            lines.append(f'')
            lines.append(f'  Current:   {desc}')
            lines.append(f'  Group:     {group}')
            if suggested:
                lines.append(f'  Suggested: {suggested}')
            lines.append(f'  Instances ({len(instances)}):')
            for inst in sorted(instances, key=lambda x: (x['sid'], x['clause'])):
                lines.append(f'    {inst["sid"]:20s} CH{inst["chapter"]:3s} '
                             f'clause {inst["clause"]:12s} row {inst["row"]:3d}')

    # OBX findings
    if obx:
        lines.append('')
        lines.append('=' * w)
        lines.append('OBX FINDINGS')
        lines.append('=' * w)
        for f in sorted(obx, key=lambda x: (x['sid'], x['clause'])):
            lines.append(f'')
            lines.append(f'  {f["sid"]:20s} CH{f["chapter"]:3s} clause {f["clause"]:12s} row {f["row"]:3d}')
            lines.append(f'    Current:   {f["description"]}')
            lines.append(f'    Group:     {f["group"]}')
            if f['suggested']:
                lines.append(f'    Suggested: {f["suggested"]}')

    # Summary
    lines.append('')
    lines.append('=' * w)
    lines.append('SUMMARY')
    lines.append('=' * w)
    for cat in cat_order:
        items = prt_cats.get(cat, [])
        if items:
            lines.append(f'  PRT {cat_labels.get(cat, cat):50s} {len(items):5d}')
    lines.append(f'  OBX issues                                                {len(obx):5d}')
    lines.append(f'  {"TOTAL":54s} {len(findings):5d}')

    report = '\n'.join(lines)
    with open(REPORT_FILE, 'w') as f:
        f.write(report)
    print(f"Report: {REPORT_FILE}")
    return report


def count_files():
    return len([f for f in os.listdir(CANONICAL_DIR) if f.endswith('.json')])


def main():
    print("Auditing PRT/OBX descriptions...")
    findings = audit_structures()
    print(f"  {len(findings)} findings")
    generate_report(findings)
    print("Done.")


if __name__ == '__main__':
    main()
