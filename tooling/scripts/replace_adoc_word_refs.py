#!/usr/bin/env python3
"""
Replace file:/// Word document references and bare Windows paths in AsciiDoc files
with {{v2-table:XXXX:Name}} placeholders (matching ADR-0003 convention used for JSON).

Handles patterns:
  1. file:///E:\V2\...\V29_CH02C_Tables.docx#HL70XXX[_Table Type XXXX - Name_]
  2. E:\\V2\\...\V29_CH02C_Tables.docx#HL70XXX[_Table Type XXXX - Name_]

Strips italic underscores, stray formatting artifacts (__), and normalizes table names.
"""

import os
import re
import sys

# Pattern matches both file:/// and bare Windows path variants
# Group 1: table number from #HL7XXXX anchor
# Group 2: display text inside [...]
PATTERN = re.compile(
    r'(?:file:///[^\[]*?|'           # file:/// variant (greedy up to [)
    r'(?:E:\\\\V2\\\\[^\[]*?))'      # bare Windows path variant
    r'#HL7(\d+)'                     # capture table number from anchor
    r'\[([^\]]+)\]'                  # capture display text in brackets
)


def clean_table_name(display_text):
    """Extract clean table name from display text like '_HL7 Table 0523 - Computation Type_'."""
    text = display_text.strip()
    # Remove surrounding underscores (italic markers)
    text = text.strip('_').strip()
    # Remove stray double underscores from Word formatting artifacts
    text = re.sub(r'__+', '', text)
    # Remove extra spaces
    text = re.sub(r'\s+', ' ', text).strip()

    # Extract name after "XXXX - " or "XXXX – " (em dash variant)
    name_match = re.search(r'\d{4}\s*[-–]\s*(.+)', text)
    if name_match:
        return name_match.group(1).strip()

    # Fallback: return cleaned text
    return text


def replace_refs_in_file(filepath, dry_run=False):
    """Replace Word document references in a single file. Returns count of replacements."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    count = 0

    def replacer(match):
        nonlocal count
        table_num = match.group(1)
        display_text = match.group(2)
        name = clean_table_name(display_text)
        count += 1
        return '{{v2-table:' + table_num.zfill(4) + ':' + name + '}}'

    new_content = PATTERN.sub(replacer, content)

    if count > 0 and not dry_run:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)

    return count


def main():
    dry_run = '--dry-run' in sys.argv
    website_dir = os.path.join(os.path.dirname(__file__), '..', '..', 'website')
    website_dir = os.path.abspath(website_dir)

    total_replacements = 0
    files_modified = 0

    for root, dirs, files in os.walk(website_dir):
        for fname in files:
            if not fname.endswith('.adoc'):
                continue
            filepath = os.path.join(root, fname)
            count = replace_refs_in_file(filepath, dry_run)
            if count > 0:
                files_modified += 1
                total_replacements += count
                if dry_run:
                    print(f"  Would replace {count} reference(s) in {os.path.relpath(filepath, website_dir)}")

    action = "Would replace" if dry_run else "Replaced"
    print(f"\n{action} {total_replacements} references across {files_modified} files.")

    if dry_run:
        print("\nRun without --dry-run to apply changes.")


if __name__ == '__main__':
    main()
