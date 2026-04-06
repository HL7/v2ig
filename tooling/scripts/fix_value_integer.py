#!/usr/bin/env python3
"""
Fix invalid boolean values in valueInteger fields across FHIR JSON files.

This script finds any occurrence of "valueInteger": true or "valueInteger": false
in FHIR StructureDefinition JSON files and replaces them with valid integer values:
- false -> 0
- true -> 1

The script properly parses JSON to avoid corrupting other boolean values.
"""

import json
import os
from pathlib import Path
from typing import Any, Tuple


def fix_value_integer_bools(obj: Any) -> Tuple[Any, int]:
    """
    Recursively traverse a JSON object and fix boolean valueInteger values.

    Args:
        obj: The JSON object (dict, list, or primitive) to traverse

    Returns:
        Tuple of (modified object, count of replacements made)
    """
    replacements = 0

    if isinstance(obj, dict):
        modified_obj = {}
        for key, value in obj.items():
            if key == 'valueInteger' and isinstance(value, bool):
                # Replace boolean with integer
                modified_obj[key] = 1 if value else 0
                replacements += 1
            else:
                # Recursively process the value
                modified_value, sub_replacements = fix_value_integer_bools(value)
                modified_obj[key] = modified_value
                replacements += sub_replacements
        return modified_obj, replacements

    elif isinstance(obj, list):
        modified_list = []
        for item in obj:
            modified_item, sub_replacements = fix_value_integer_bools(item)
            modified_list.append(modified_item)
            replacements += sub_replacements
        return modified_list, replacements

    else:
        # Primitive value - return as-is
        return obj, 0


def process_json_file(file_path: Path) -> Tuple[bool, int]:
    """
    Process a single JSON file, fixing any boolean valueInteger values.

    Args:
        file_path: Path to the JSON file

    Returns:
        Tuple of (file was modified, number of replacements made)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        modified_data, replacements = fix_value_integer_bools(data)

        if replacements > 0:
            # Write the file back with consistent formatting
            with open(file_path, 'w', encoding='utf-8') as f:
                json.dump(modified_data, f, indent=2, ensure_ascii=False)
                f.write('\n')  # Add trailing newline
            return True, replacements

        return False, 0

    except json.JSONDecodeError as e:
        print(f"  ⚠ JSON decode error in {file_path}: {e}")
        return False, 0
    except Exception as e:
        print(f"  ⚠ Error processing {file_path}: {e}")
        return False, 0


def main():
    """Main function to process all target directories."""
    # Define directories to scan
    target_dirs = [
        'input/sourceOfTruth/segment/segments',
        'input/sourceOfTruth/message-structure/message_structures',
        'input/sourceOfTruth/data-type/complex/complex-data-types',
        'input/sourceOfTruth/data-type/primitive/primitives',
    ]

    # Get workspace root (script is in tooling/scripts/)
    script_dir = Path(__file__).parent
    workspace_root = script_dir.parent.parent

    total_files = 0
    modified_files = 0
    total_replacements = 0

    print("Scanning for boolean valueInteger values in JSON files...\n")

    for target_dir in target_dirs:
        dir_path = workspace_root / target_dir

        if not dir_path.exists():
            print(f"⚠ Directory not found: {dir_path}")
            continue

        print(f"Processing: {target_dir}")
        dir_files = 0
        dir_modified = 0
        dir_replacements = 0

        # Process all JSON files in the directory
        for json_file in sorted(dir_path.glob('*.json')):
            total_files += 1
            dir_files += 1

            was_modified, replacements = process_json_file(json_file)

            if was_modified:
                modified_files += 1
                dir_modified += 1
                dir_replacements += replacements
                total_replacements += replacements
                print(f"  ✓ Fixed {json_file.name}: {replacements} replacement(s)")

        print(f"  Files in directory: {dir_files}, Modified: {dir_modified}, Replacements: {dir_replacements}\n")

    # Print summary
    print("=" * 70)
    print("SUMMARY")
    print("=" * 70)
    print(f"Total files scanned:     {total_files}")
    print(f"Files modified:          {modified_files}")
    print(f"Total replacements:      {total_replacements}")

    if modified_files > 0:
        print(f"\n✓ Successfully fixed {modified_files} file(s)!")
    else:
        print("\n✓ No issues found - all files are valid!")


if __name__ == '__main__':
    main()
