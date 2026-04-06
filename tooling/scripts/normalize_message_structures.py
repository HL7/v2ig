#!/usr/bin/env python3
"""
Normalize bracket notation in V2.9.1 message structure JSON files.

Rules:
- Optional only: [ CODE ] (one space inside each bracket)
- Repeating only: { CODE } (one space inside each brace)
- Optional + repeating: [{ CODE }] (no space between [ and {, no space between } and ], one space inside braces)
- Required (no brackets): just the code, trimmed
- Preserve leading indentation (for group nesting)
- Fix malformed brackets like [{ OH2 }} → [{ OH2 }]
"""

import json
import re
import os
from pathlib import Path
from collections import defaultdict


def normalize_segment_notation(segments_str):
    """
    Normalize bracket notation in a segment string.

    Returns: (normalized_string, was_modified)
    """
    if not segments_str:
        return segments_str, False

    original = segments_str

    # Preserve leading whitespace (indentation for group nesting)
    leading_spaces = len(segments_str) - len(segments_str.lstrip())
    indent = segments_str[:leading_spaces]
    content = segments_str[leading_spaces:]

    # Detect pattern and normalize
    # Pattern 1: Optional + Repeating: [{...}] or [{...}} (malformed) or [ {...} ]
    opt_rep_pattern = r'\[\s*\{\s*([A-Z0-9_]+)\s*\}\s*[\]\}]'
    if re.match(opt_rep_pattern, content):
        match = re.match(opt_rep_pattern, content)
        code = match.group(1).strip()
        normalized = f"[{{ {code} }}]"
        return indent + normalized, (indent + normalized != original)

    # Pattern 2: Optional only: [...]
    opt_pattern = r'\[\s*([A-Z0-9_]+)\s*\]'
    if re.match(opt_pattern, content):
        match = re.match(opt_pattern, content)
        code = match.group(1).strip()
        normalized = f"[ {code} ]"
        return indent + normalized, (indent + normalized != original)

    # Pattern 3: Repeating only: {...}
    rep_pattern = r'\{\s*([A-Z0-9_]+)\s*\}'
    if re.match(rep_pattern, content):
        match = re.match(rep_pattern, content)
        code = match.group(1).strip()
        normalized = f"{{ {code} }}"
        return indent + normalized, (indent + normalized != original)

    # Pattern 4: Required (no brackets) - just trim
    code_pattern = r'^([A-Z0-9_]+)$'
    if re.match(code_pattern, content.strip()):
        code = content.strip()
        normalized = code
        return indent + normalized, (indent + normalized != original)

    # If no pattern matched, return trimmed version
    return indent + content.strip(), (indent + content.strip() != original)


def parse_segment_notation(segments_str):
    """
    Parse normalized segment notation to determine optionality and repetition.
    Returns: (code, optionality, repetition)
    """
    if not segments_str:
        return None, None, None

    # Strip leading whitespace for parsing
    content = segments_str.lstrip()

    # Optional + Repeating: [{ CODE }]
    if content.startswith('[{') and content.endswith('}]'):
        code = content[2:-2].strip()
        return code, 'O', True

    # Optional only: [ CODE ]
    if content.startswith('[') and content.endswith(']'):
        code = content[1:-1].strip()
        return code, 'O', False

    # Repeating only: { CODE }
    if content.startswith('{') and content.endswith('}'):
        code = content[1:-1].strip()
        return code, 'R', True

    # Required (no brackets)
    code = content.strip()
    return code, 'R', False


def normalize_message_structure(file_path):
    """
    Normalize bracket notation in a single message structure file.
    Returns: (was_modified, modification_count)
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    modifications = 0
    parsed_structure_modified = False

    # Normalize rawRows
    if 'rawRows' in data:
        for row in data['rawRows']:
            if 'segments' in row:
                normalized, was_modified = normalize_segment_notation(row['segments'])
                if was_modified:
                    modifications += 1
                row['segments'] = normalized

    # Update parsedStructure if it exists
    if 'parsedStructure' in data and 'rawRows' in data:
        # Re-parse from normalized rawRows
        for i, row in enumerate(data['rawRows']):
            if 'segments' in row and i < len(data['parsedStructure']):
                code, optionality, repetition = parse_segment_notation(row['segments'])

                if code and data['parsedStructure'][i].get('type') == 'segment':
                    old_code = data['parsedStructure'][i].get('code')
                    old_opt = data['parsedStructure'][i].get('optionality')
                    old_rep = data['parsedStructure'][i].get('repetition')

                    # Update if parsing changed
                    if (code != old_code or
                        optionality != old_opt or
                        repetition != old_rep):
                        data['parsedStructure'][i]['code'] = code
                        data['parsedStructure'][i]['optionality'] = optionality
                        data['parsedStructure'][i]['repetition'] = repetition
                        parsed_structure_modified = True

    # Write back if modified
    if modifications > 0 or parsed_structure_modified:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        return True, modifications

    return False, 0


def compare_message_structures(base_dir):
    """
    Compare all message structures, grouping by structureId.
    Returns comparison results.
    """
    # Load all message structures
    structures = {}
    structure_groups = defaultdict(list)

    for json_file in Path(base_dir).glob('*.json'):
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)

        structure_id = data.get('structureId', 'UNKNOWN')
        structures[json_file.name] = data
        structure_groups[structure_id].append(json_file.name)

    # Find duplicates and compare
    duplicates = {sid: files for sid, files in structure_groups.items() if len(files) > 1}

    comparison_results = {
        'total_structures': len(structures),
        'unique_structure_ids': len(structure_groups),
        'duplicated_structure_ids': len(duplicates),
        'duplicates': {}
    }

    for structure_id, files in sorted(duplicates.items()):
        # Compare all pairs
        comparison_results['duplicates'][structure_id] = {
            'files': files,
            'comparisons': []
        }

        # Compare first file with all others
        base_file = files[0]
        base_data = structures[base_file]

        for other_file in files[1:]:
            other_data = structures[other_file]
            differences = compare_two_structures(base_data, other_data, base_file, other_file)

            if differences:
                comparison_results['duplicates'][structure_id]['comparisons'].append({
                    'base_file': base_file,
                    'other_file': other_file,
                    'differences': differences
                })

    # Remove structure IDs with no real differences
    comparison_results['duplicates'] = {
        sid: data for sid, data in comparison_results['duplicates'].items()
        if data['comparisons']
    }
    comparison_results['duplicated_with_differences'] = len(comparison_results['duplicates'])

    return comparison_results


def compare_two_structures(base, other, base_file, other_file):
    """
    Compare two message structure definitions.
    Returns list of differences.
    """
    differences = []

    # Compare rawRows
    base_rows = base.get('rawRows', [])
    other_rows = other.get('rawRows', [])

    if len(base_rows) != len(other_rows):
        differences.append({
            'type': 'row_count_mismatch',
            'base_count': len(base_rows),
            'other_count': len(other_rows)
        })

    # Compare each row
    for i in range(min(len(base_rows), len(other_rows))):
        base_row = base_rows[i]
        other_row = other_rows[i]

        # Segment code (after normalization, should be identical if same)
        if base_row.get('segments') != other_row.get('segments'):
            differences.append({
                'type': 'segment_mismatch',
                'row_index': i,
                'base_segment': base_row.get('segments'),
                'other_segment': other_row.get('segments')
            })

        # Description
        if base_row.get('description', '').strip() != other_row.get('description', '').strip():
            differences.append({
                'type': 'description_mismatch',
                'row_index': i,
                'segment': base_row.get('segments'),
                'base_description': base_row.get('description'),
                'other_description': other_row.get('description')
            })

        # Chapter reference
        base_chapter = base_row.get('chapter', '').strip()
        other_chapter = other_row.get('chapter', '').strip()
        if base_chapter != other_chapter:
            differences.append({
                'type': 'chapter_mismatch',
                'row_index': i,
                'segment': base_row.get('segments'),
                'base_chapter': base_chapter,
                'other_chapter': other_chapter
            })

    # Check for extra rows
    if len(base_rows) > len(other_rows):
        for i in range(len(other_rows), len(base_rows)):
            differences.append({
                'type': 'extra_row_in_base',
                'row_index': i,
                'segment': base_rows[i].get('segments'),
                'description': base_rows[i].get('description')
            })
    elif len(other_rows) > len(base_rows):
        for i in range(len(base_rows), len(other_rows)):
            differences.append({
                'type': 'extra_row_in_other',
                'row_index': i,
                'segment': other_rows[i].get('segments'),
                'description': other_rows[i].get('description')
            })

    return differences


def generate_markdown_report(comparison_results):
    """
    Generate a human-readable markdown report.
    """
    lines = [
        "# Message Structure Comparison Report (Post-Normalization)",
        "",
        f"**Generated:** {Path(__file__).name}",
        "",
        "## Summary",
        "",
        f"- **Total message structure files:** {comparison_results['total_structures']}",
        f"- **Unique structure IDs:** {comparison_results['unique_structure_ids']}",
        f"- **Duplicated structure IDs:** {comparison_results['duplicated_structure_ids']}",
        f"- **Duplicated IDs with real differences:** {comparison_results['duplicated_with_differences']}",
        "",
    ]

    if comparison_results['duplicated_with_differences'] == 0:
        lines.extend([
            "## Result",
            "",
            "**All duplicated message structures are identical after normalization!**",
            "",
            "All previously detected differences were due to bracket notation whitespace variations.",
            ""
        ])
    else:
        lines.extend([
            "## Structures with Real Differences",
            "",
            f"After normalizing bracket notation, {comparison_results['duplicated_with_differences']} structure IDs still have real differences.",
            ""
        ])

        for structure_id, data in sorted(comparison_results['duplicates'].items()):
            lines.append(f"### {structure_id}")
            lines.append("")
            lines.append(f"**Files:** {', '.join(data['files'])}")
            lines.append("")

            for comparison in data['comparisons']:
                lines.append(f"#### {comparison['base_file']} vs {comparison['other_file']}")
                lines.append("")

                for diff in comparison['differences']:
                    diff_type = diff['type']

                    if diff_type == 'row_count_mismatch':
                        lines.append(f"- **Row count mismatch:** {diff['base_count']} vs {diff['other_count']}")

                    elif diff_type == 'segment_mismatch':
                        lines.append(f"- **Row {diff['row_index']}:** Segment mismatch")
                        lines.append(f"  - Base: `{diff['base_segment']}`")
                        lines.append(f"  - Other: `{diff['other_segment']}`")

                    elif diff_type == 'description_mismatch':
                        lines.append(f"- **Row {diff['row_index']}** ({diff['segment']}): Description mismatch")
                        lines.append(f"  - Base: {diff['base_description']}")
                        lines.append(f"  - Other: {diff['other_description']}")

                    elif diff_type == 'chapter_mismatch':
                        lines.append(f"- **Row {diff['row_index']}** ({diff['segment']}): Chapter mismatch")
                        lines.append(f"  - Base: {diff['base_chapter']}")
                        lines.append(f"  - Other: {diff['other_chapter']}")

                    elif diff_type == 'extra_row_in_base':
                        lines.append(f"- **Extra row in base** (row {diff['row_index']}): {diff['segment']} - {diff['description']}")

                    elif diff_type == 'extra_row_in_other':
                        lines.append(f"- **Extra row in other** (row {diff['row_index']}): {diff['segment']} - {diff['description']}")

                lines.append("")

    return "\n".join(lines)


def generate_quickref(comparison_results):
    """
    Generate a quick reference summary.
    """
    lines = [
        "# Message Structure Comparison Quick Reference",
        "",
        "## Statistics",
        "",
        f"- Total files: {comparison_results['total_structures']}",
        f"- Unique structure IDs: {comparison_results['unique_structure_ids']}",
        f"- Duplicated structure IDs: {comparison_results['duplicated_structure_ids']}",
        f"- Duplicated with differences: {comparison_results['duplicated_with_differences']}",
        "",
    ]

    if comparison_results['duplicated_with_differences'] > 0:
        lines.append("## Structure IDs with Differences")
        lines.append("")

        for structure_id in sorted(comparison_results['duplicates'].keys()):
            data = comparison_results['duplicates'][structure_id]
            diff_count = sum(len(c['differences']) for c in data['comparisons'])
            lines.append(f"- **{structure_id}** ({len(data['files'])} files, {diff_count} differences)")

    lines.append("")
    return "\n".join(lines)


def main():
    base_dir = Path('/workspace/v291-extracted/message-structures')

    print("=" * 80)
    print("STEP 1: Normalizing bracket notation in all message structure files")
    print("=" * 80)
    print()

    json_files = sorted(base_dir.glob('*.json'))
    total_files = len(json_files)
    modified_files = 0
    total_modifications = 0

    for i, json_file in enumerate(json_files, 1):
        was_modified, mod_count = normalize_message_structure(json_file)

        if was_modified:
            modified_files += 1
            total_modifications += mod_count
            print(f"[{i:3d}/{total_files}] ✓ {json_file.name} ({mod_count} changes)")
        elif i % 50 == 0:
            print(f"[{i:3d}/{total_files}] Processing...")

    print()
    print(f"Normalization complete:")
    print(f"  - Total files processed: {total_files}")
    print(f"  - Files modified: {modified_files}")
    print(f"  - Total modifications: {total_modifications}")
    print()

    print("=" * 80)
    print("STEP 2: Comparing message structures after normalization")
    print("=" * 80)
    print()

    comparison_results = compare_message_structures(base_dir)

    # Write JSON report
    json_report_path = Path('/workspace/v291-extracted/message-structure-comparison.json')
    with open(json_report_path, 'w', encoding='utf-8') as f:
        json.dump(comparison_results, f, indent=2, ensure_ascii=False)
    print(f"✓ Wrote JSON report: {json_report_path}")

    # Write markdown report
    md_report = generate_markdown_report(comparison_results)
    md_report_path = Path('/workspace/v291-extracted/message-structure-comparison-report.md')
    with open(md_report_path, 'w', encoding='utf-8') as f:
        f.write(md_report)
    print(f"✓ Wrote markdown report: {md_report_path}")

    # Write quick reference
    quickref = generate_quickref(comparison_results)
    quickref_path = Path('/workspace/v291-extracted/message-structure-comparison-quickref.md')
    with open(quickref_path, 'w', encoding='utf-8') as f:
        f.write(quickref)
    print(f"✓ Wrote quick reference: {quickref_path}")

    print()
    print("=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print()
    print(f"Total structures: {comparison_results['total_structures']}")
    print(f"Unique structure IDs: {comparison_results['unique_structure_ids']}")
    print(f"Duplicated structure IDs: {comparison_results['duplicated_structure_ids']}")
    print(f"Duplicated IDs with real differences: {comparison_results['duplicated_with_differences']}")
    print()

    eliminated = comparison_results['duplicated_structure_ids'] - comparison_results['duplicated_with_differences']
    print(f"Differences eliminated by normalization: {eliminated}")
    print(f"Real differences remaining: {comparison_results['duplicated_with_differences']}")
    print()


if __name__ == '__main__':
    main()
