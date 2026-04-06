#!/usr/bin/env python3
"""
Fix extension URL namespace references in FHIR StructureDefinition JSON files.

Replaces incorrect http://hl7.org/fhir/StructureDefinition/ URLs with the correct
http://hl7.org/v2/StructureDefinition/ namespace for V2-specific extensions.
"""

import json
import os
from pathlib import Path
from typing import Dict, Tuple

# Define the URL replacements
REPLACEMENTS = {
    "http://hl7.org/fhir/StructureDefinition/optionality":
        "http://hl7.org/v2/StructureDefinition/optionality",
    "http://hl7.org/fhir/StructureDefinition/v2-length":
        "http://hl7.org/v2/StructureDefinition/v2-length",
    "http://hl7.org/fhir/StructureDefinition/v2-conformance-length":
        "http://hl7.org/v2/StructureDefinition/v2-conformance-length",
    "http://hl7.org/fhir/StructureDefinition/v2-segment-status":
        "http://hl7.org/v2/StructureDefinition/v2-segment-status",
}


def fix_file(file_path: Path) -> Tuple[bool, Dict[str, int]]:
    """
    Fix extension URLs in a single JSON file.

    Args:
        file_path: Path to the JSON file

    Returns:
        Tuple of (file_was_modified, replacement_counts)
    """
    try:
        # Read the file content as text
        with open(file_path, 'r', encoding='utf-8') as f:
            original_content = f.read()

        modified_content = original_content
        replacement_counts = {old_url: 0 for old_url in REPLACEMENTS.keys()}

        # Perform string replacements
        for old_url, new_url in REPLACEMENTS.items():
            count = modified_content.count(old_url)
            if count > 0:
                modified_content = modified_content.replace(old_url, new_url)
                replacement_counts[old_url] = count

        # Only write if content changed
        if modified_content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(modified_content)
            return True, replacement_counts

        return False, replacement_counts

    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False, {old_url: 0 for old_url in REPLACEMENTS.keys()}


def main():
    """Main function to process all JSON files."""
    # Get the sourceOfTruth directory
    script_dir = Path(__file__).parent
    project_root = script_dir.parent.parent
    source_of_truth_dir = project_root / "input" / "sourceOfTruth"

    if not source_of_truth_dir.exists():
        print(f"Error: Directory not found: {source_of_truth_dir}")
        return

    print(f"Scanning JSON files in: {source_of_truth_dir}")
    print("=" * 80)

    # Collect statistics
    total_files_scanned = 0
    total_files_modified = 0
    total_replacements = {old_url: 0 for old_url in REPLACEMENTS.keys()}

    # Walk through all JSON files
    for json_file in source_of_truth_dir.rglob("*.json"):
        total_files_scanned += 1

        file_modified, replacement_counts = fix_file(json_file)

        if file_modified:
            total_files_modified += 1
            rel_path = json_file.relative_to(project_root)
            print(f"\nModified: {rel_path}")
            for old_url, count in replacement_counts.items():
                if count > 0:
                    total_replacements[old_url] += count
                    # Show shortened URL for readability
                    short_name = old_url.split('/')[-1]
                    print(f"  - {short_name}: {count} replacement(s)")

    # Print summary
    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total files scanned: {total_files_scanned}")
    print(f"Total files modified: {total_files_modified}")
    print(f"Total files unchanged: {total_files_scanned - total_files_modified}")
    print()
    print("Replacements by extension URL:")

    for old_url, count in total_replacements.items():
        short_name = old_url.split('/')[-1]
        print(f"  - {short_name}: {count} replacement(s)")

    total_count = sum(total_replacements.values())
    print(f"\nTotal replacements made: {total_count}")

    if total_files_modified == 0:
        print("\nNo files needed modification. All extension URLs are already correct!")
    else:
        print(f"\nSuccessfully updated {total_files_modified} file(s).")


if __name__ == "__main__":
    main()
