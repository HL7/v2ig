#!/usr/bin/env python3
"""
Fix List resources in control-manifests to use valid FHIR R5 List.entry structure.

The existing files use non-standard {"code": "XX", "display": "Name"} entries.
FHIR R5 List.entry requires {"item": {"display": "Name", "reference": "StructureDefinition/XX"}}.

This script transforms all control manifest List resources to valid FHIR format.

Usage:
    python3 fix_list_resources.py [--dry-run]
"""

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
MANIFESTS_DIR = REPO_ROOT / "input" / "sourceOfTruth" / "control-manifests"

# Map manifest file to the FHIR resource type its entries reference
MANIFEST_FILES = [
    "primitive-data-types.json",
    "segments.json",
    "events.json",
    "messages.json",
    "message_structures.json",
]


def fix_list_resource(filepath: Path, dry_run: bool = False) -> int:
    """Transform List.entry[] from code/display to item references.

    Returns the number of entries transformed.
    """
    data = json.loads(filepath.read_text(encoding="utf-8"))

    if data.get("resourceType") != "List":
        print(f"  SKIP: {filepath.name} is not a List resource")
        return 0

    entries = data.get("entry", [])
    if not entries:
        print(f"  SKIP: {filepath.name} has no entries")
        return 0

    # Check if already fixed (first entry has "item")
    if "item" in entries[0]:
        print(f"  SKIP: {filepath.name} already has valid entry.item structure")
        return 0

    # Transform entries
    new_entries = []
    for entry in entries:
        code = entry.get("code", "")
        display = entry.get("display", "")

        new_entry = {
            "item": {
                "reference": f"StructureDefinition/{code}",
                "display": display
            }
        }
        new_entries.append(new_entry)

    data["entry"] = new_entries

    if not dry_run:
        filepath.write_text(
            json.dumps(data, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8"
        )

    return len(new_entries)


def main():
    dry_run = "--dry-run" in sys.argv

    if dry_run:
        print("DRY RUN — no files will be modified\n")

    total_entries = 0
    files_fixed = 0

    for filename in MANIFEST_FILES:
        filepath = MANIFESTS_DIR / filename
        if not filepath.exists():
            print(f"  WARNING: {filename} not found")
            continue

        count = fix_list_resource(filepath, dry_run)
        if count > 0:
            print(f"  FIXED: {filename} — {count} entries transformed")
            total_entries += count
            files_fixed += 1

    print(f"\nTotal: {files_fixed} files, {total_entries} entries transformed")
    if dry_run:
        print("(dry run — no files were modified)")


if __name__ == "__main__":
    main()
