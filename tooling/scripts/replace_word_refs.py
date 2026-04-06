#!/usr/bin/env python3
"""
Replace file:/// Word document references in FHIR JSON files with
standardized {{v2-table:XXXX:Name}} placeholders.

Processes all JSON files under input/sourceOfTruth/ recursively.

Patterns handled:
  1. file:///E:\\V2\\...Tables.docx#HL70127[_User-defined Table 0127 - Allergen Type_]
  2. file:///D:\\Eigene%20Dateien\\...Table%200206[*_HL7 Table 0206 - Segment Action Code_*]
  3. file:///C:\\Users\\...CodeTables.doc#HL70270[_User-Defined Table 0832 - Document Class_]
  4. Variants with Imported/External/Externally-defined/HL7-defined prefixes
  5. Double-underscore artifacts (__) from Word conversion
  6. Edge case: brackets closing mid-word (e.g., "Administration M]ethod")
"""

import json
import re
import sys
from pathlib import Path


def clean_asciidoc_formatting(text):
    """
    Remove AsciiDoc formatting artifacts from display text.

    Handles double underscores (__), italic markers (_), bold markers (*),
    and collapses whitespace.
    """
    # Remove bold markers
    text = text.replace('*', '')
    # Remove double-underscore artifacts (Word conversion noise)
    text = text.replace('__', '')
    # Strip leading/trailing underscores and spaces
    text = text.strip('_ ')
    # Replace "_ _" patterns (italic break + restart) with space
    text = re.sub(r'_\s+_', ' ', text)
    # Remove remaining underscores at word boundaries (italic markers)
    text = re.sub(r'(?<=\s)_|_(?=\s)', '', text)
    text = text.strip('_ ')
    # Collapse multiple spaces
    text = re.sub(r'\s+', ' ', text).strip()
    # Normalize "User.defined" or "User–defined" or "User defined" to "User-defined"
    text = re.sub(r'User[.\s–-]\s*[Dd]efined', 'User-defined', text, flags=re.IGNORECASE)
    # Normalize "User Defined" (no hyphen) to "User-defined"
    text = re.sub(r'User\s+Defined', 'User-defined', text, flags=re.IGNORECASE)
    # Normalize "User defined" (no hyphen, lowercase) to "User-defined"
    text = re.sub(r'User\s+defined', 'User-defined', text, flags=re.IGNORECASE)
    # Normalize "Externally Defined" / "Externally- defined" variants
    text = re.sub(r'Externally[- ]\s*[Dd]efined', 'Externally-defined', text, flags=re.IGNORECASE)
    # Normalize "HL7 Defined Table" to "HL7-defined Table"
    text = re.sub(r'HL7\s+Defined\s+Table', 'HL7-defined Table', text, flags=re.IGNORECASE)
    # Remove "HL7" prefix from table numbers like "HL70964" -> "0964"
    text = re.sub(r'Table\s+HL7(\d{3,5})', r'Table \1', text)
    # Remove parenthetical qualifiers like "(CMS)" before "Table"
    text = re.sub(r'\(CMS\)\s*', '', text)
    # Handle leading dash before number: "–0289" -> "0289"
    text = re.sub(r'Table\s*[–-]\s*(\d{3,4})', r'Table \1', text)
    return text


def extract_table_info(display_text):
    """
    Extract table number and human-readable name from display text.

    Returns (table_number, table_name) or None if parsing fails.

    Handles these prefix patterns:
      - User-defined Table XXXX
      - User-Defined Table XXXX
      - HL7 Table XXXX
      - HL7-defined Table XXXX
      - Imported Table XXXX
      - External Table XXXX
      - Externally-defined Table XXXX
      - HL7 XXXX (missing "Table" keyword)
    """
    cleaned = clean_asciidoc_formatting(display_text)

    # Table type prefixes we recognize
    prefix = (
        r'(?:User-[Dd]efined\s+Table'
        r'|HL7-defined\s+Table'
        r'|HL7\s+Table'
        r'|Imported\s+Table'
        r'|Externally-defined\s+Table'
        r'|External\s+Table'
        r')'
    )

    # Pattern 1: prefix + number + dash + name
    match = re.search(
        prefix + r'\s*(\d{3,4})\s*[-–—]\s*(.+)',
        cleaned,
        re.IGNORECASE
    )

    # Pattern 2: prefix + number + name (no dash separator)
    if not match:
        match = re.search(
            prefix + r'\s*(\d{3,4})\s+([A-Z].+)',
            cleaned,
            re.IGNORECASE
        )

    # Pattern 3: "HL7 XXXX – Name" without the word "Table"
    if not match:
        match = re.search(
            r'HL7\s+(\d{3,4})\s*[-–—]\s*(.+)',
            cleaned,
            re.IGNORECASE
        )

    # Pattern 4: prefix + number only (no name)
    if not match:
        match_no_name = re.search(
            prefix + r'\s*(\d{3,4})\s*[-–—]?\s*$',
            cleaned,
            re.IGNORECASE
        )
        if match_no_name:
            table_number = match_no_name.group(1)
            return (table_number, '')

    if not match:
        return None

    table_number = match.group(1)
    table_name = match.group(2).strip('_ *')
    # Final cleanup of table name
    table_name = re.sub(r'\s+', ' ', table_name).strip()

    return (table_number, table_name)


def replace_file_refs(text):
    """
    Replace all file:/// references in a string with {{v2-table:XXXX:Name}}.

    Returns (new_text, replacements_made, unparsed_refs).
    """
    replacements = 0
    unparsed = []

    result_parts = []
    last_end = 0

    for m in re.finditer(r'file:///', text):
        start = m.start()
        # Find the opening bracket
        bracket_start = text.find('[', start)
        if bracket_start == -1:
            continue

        # Find the closing bracket.
        # Some refs have a ] mid-word due to formatting artifacts, e.g.:
        #   [User-defined Table 0165 – Administration M]ethod_
        # In these cases the ] splits a word, and there are 1-5 trailing
        # chars (the rest of the word + optional _*) before the "real" end.
        # Strategy: try each ] we find. If the content inside parses as a
        # table ref, use it. If not, also try extending past that ] to
        # include trailing word chars + formatting markers.
        pos = bracket_start + 1
        bracket_end = -1
        extended_display = None

        while pos < len(text):
            if text[pos] == ']':
                bracket_end = pos
                break
            pos += 1

        if bracket_end == -1:
            continue

        display_text = text[bracket_start + 1:bracket_end]
        actual_end = bracket_end  # end position to consume in source text

        # First, check if ] appears mid-word. If there's trailing text
        # like "ethod_" after the ] that completes a word, try the
        # extended version first to get the full table name.
        info = None
        trailing_match = re.match(r'([a-zA-Z]+[_*]*)', text[bracket_end + 1:])
        if trailing_match:
            extended = display_text + trailing_match.group(0)
            info = extract_table_info(extended)
            if info:
                actual_end = bracket_end + len(trailing_match.group(0))

        # If extended didn't work (or no trailing text), try the original
        if info is None:
            info = extract_table_info(display_text)

        if info is None:
            full_ref = text[start:bracket_end + 1]
            unparsed.append(full_ref)
            continue

        table_number, table_name = info
        replacement = "{{" + f"v2-table:{table_number}:{table_name}" + "}}"

        # Also consume any leading italic/bold marker before "file:///"
        # e.g., "_file:///..." -> the _ is AsciiDoc formatting around the ref
        ref_start = start
        if ref_start > 0 and text[ref_start - 1] == '_':
            ref_start -= 1

        result_parts.append(text[last_end:ref_start])
        result_parts.append(replacement)
        last_end = actual_end + 1
        replacements += 1

    if replacements == 0 and not unparsed:
        return text, 0, unparsed

    result_parts.append(text[last_end:])
    new_text = ''.join(result_parts)

    return new_text, replacements, unparsed


def process_json_file(filepath):
    """
    Process a single JSON file, replacing file:/// refs in string values.

    Returns (replacements_made, unparsed_refs).
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Quick check: skip files without file:///
    if 'file:///' not in content:
        return 0, []

    try:
        data = json.loads(content)
    except json.JSONDecodeError as e:
        print(f"  WARNING: Could not parse JSON in {filepath}: {e}")
        return 0, []

    total_replacements = 0
    all_unparsed = []

    def walk_and_replace(obj):
        """Recursively walk JSON and replace file:/// refs in strings."""
        nonlocal total_replacements, all_unparsed

        if isinstance(obj, str):
            if 'file:///' in obj:
                new_val, count, unparsed_list = replace_file_refs(obj)
                total_replacements += count
                all_unparsed.extend(unparsed_list)
                return new_val
            return obj
        elif isinstance(obj, list):
            return [walk_and_replace(item) for item in obj]
        elif isinstance(obj, dict):
            return {key: walk_and_replace(val) for key, val in obj.items()}
        else:
            return obj

    new_data = walk_and_replace(data)

    if total_replacements > 0:
        new_content = json.dumps(new_data, indent=2, ensure_ascii=False)
        if content.endswith('\n'):
            new_content += '\n'
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)

    return total_replacements, all_unparsed


def main():
    source_dir = Path('/workspace/input/sourceOfTruth')
    if not source_dir.exists():
        print(f"ERROR: Source directory not found: {source_dir}")
        sys.exit(1)

    json_files = sorted(source_dir.rglob('*.json'))
    print(f"Found {len(json_files)} JSON files to process.\n")

    total_replacements = 0
    files_modified = 0
    all_unparsed = []

    for filepath in json_files:
        count, unparsed = process_json_file(filepath)
        if count > 0:
            files_modified += 1
            print(f"  {filepath.relative_to(Path('/workspace'))}: {count} replacement(s)")
        if unparsed:
            for ref in unparsed:
                truncated = ref[:120] + '...' if len(ref) > 120 else ref
                print(f"  WARNING: Could not parse ref in {filepath.relative_to(Path('/workspace'))}: {truncated}")
        total_replacements += count
        all_unparsed.extend(unparsed)

    print(f"\n{'='*60}")
    print(f"SUMMARY")
    print(f"{'='*60}")
    print(f"Files scanned:     {len(json_files)}")
    print(f"Files modified:    {files_modified}")
    print(f"Total replacements: {total_replacements}")
    print(f"Unparsed refs:     {len(all_unparsed)}")

    if all_unparsed:
        print(f"\nUnparsed references:")
        for ref in all_unparsed:
            truncated = ref[:150] + '...' if len(ref) > 150 else ref
            print(f"  - {truncated}")

    return 0 if not all_unparsed else 1


if __name__ == '__main__':
    sys.exit(main())
