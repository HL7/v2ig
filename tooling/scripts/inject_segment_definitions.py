#!/usr/bin/env python3
"""Inject segment definitions from AsciiDoc into FHIR StructureDefinition JSON.

Reads [segment-definition] and [segment-comment] blocks from AsciiDoc files
in website/data_structures/segments/ and injects them into the corresponding
FHIR StructureDefinition JSON files in input/sourceOfTruth/segment/segments/.

This mirrors inject_definitions.py (for data types) but handles segments.

Usage:
    python3 inject_segment_definitions.py [--dry-run] [--verbose] [--segment SEG]

Options:
    --dry-run       Show what would change without modifying files
    --verbose       Print detailed output
    --segment SEG   Process only the specified segment (e.g., PID)
"""

import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
ADOC_DIR = REPO_ROOT / "website" / "data_structures" / "segments"
JSON_DIR = REPO_ROOT / "input" / "sourceOfTruth" / "segment" / "segments"


def extract_segment_definition(adoc_path):
    """Extract the [segment-definition] block text from an AsciiDoc file.

    Returns the text following [segment-definition] up to the next section
    heading (== ...), include:: directive, [segment-comment] block, or EOF.
    Strips AsciiDoc comment lines (// ...) that serve as placeholders.
    Returns None if no block found or block is empty after stripping.
    """
    try:
        content = adoc_path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return None

    lines = content.split("\n")
    in_definition = False
    definition_lines = []

    for line in lines:
        if line.strip() == "[segment-definition]":
            in_definition = True
            continue

        if in_definition:
            # Stop at next section heading, include directive, or comment block
            if (line.startswith("== ")
                    or line.startswith("include::")
                    or line.strip() == "[segment-comment]"):
                break
            # Skip AsciiDoc comment lines (placeholders like // TODO:)
            if line.strip().startswith("//"):
                continue
            definition_lines.append(line)

    if not definition_lines:
        return None

    text = "\n".join(definition_lines).strip()
    return text if text else None


def extract_segment_comment(adoc_path):
    """Extract the [segment-comment] block text from an AsciiDoc file.

    Returns the text following [segment-comment] up to the next section
    heading (== ...), include:: directive, or EOF.
    Returns None if no block found or block is empty.
    """
    try:
        content = adoc_path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return None

    lines = content.split("\n")
    in_comment = False
    comment_lines = []

    for line in lines:
        if line.strip() == "[segment-comment]":
            in_comment = True
            continue

        if in_comment:
            if line.startswith("== ") or line.startswith("include::"):
                break
            comment_lines.append(line)

    if not comment_lines:
        return None

    text = "\n".join(comment_lines).strip()
    return text if text else None


def find_element_by_id(elements, element_id):
    """Find an element in the StructureDefinition's element array by id."""
    for elem in elements:
        if elem.get("id") == element_id:
            return elem
    return None


def normalize_for_comparison(text):
    """Normalize whitespace for comparing AsciiDoc and JSON content."""
    if not text:
        return ""
    return re.sub(r"\s+", " ", text.strip())


def inject_for_segment(seg_id, dry_run=False, verbose=False):
    """Process a single segment: extract definitions/comments from AsciiDoc, inject into JSON.

    Returns (changes, errors) tuple.
    """
    adoc_file = ADOC_DIR / f"{seg_id}.adoc"
    json_file = JSON_DIR / f"{seg_id}.json"

    changes = []
    errors = []

    if not adoc_file.exists():
        errors.append(f"AsciiDoc file not found: {adoc_file.name}")
        return changes, errors

    if not json_file.exists():
        errors.append(f"JSON file not found: {json_file.name}")
        return changes, errors

    # Read JSON
    try:
        sd = json.loads(json_file.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        errors.append(f"JSON parse error in {json_file.name}: {e}")
        return changes, errors

    elements = sd.get("differential", {}).get("element", [])

    # 1. Root definition
    root_def = extract_segment_definition(adoc_file)
    if root_def:
        root_elem = find_element_by_id(elements, seg_id)
        if root_elem:
            existing = root_elem.get("definition")
            if normalize_for_comparison(root_def) != normalize_for_comparison(existing or ""):
                changes.append({
                    "element_id": seg_id,
                    "field": "definition",
                    "old_length": len(existing or ""),
                    "new_length": len(root_def),
                    "file": adoc_file.name,
                })
                if not dry_run:
                    root_elem["definition"] = root_def
                if verbose:
                    print(f"  {seg_id}: Root definition updated ({len(existing or '')} -> {len(root_def)} chars)")
        else:
            errors.append(f"Root element {seg_id} not found in JSON")
    elif verbose:
        print(f"  {seg_id}: No root definition in AsciiDoc (placeholder only)")

    # 2. Field definitions and comments
    fields_dir = ADOC_DIR / f"{seg_id}-fields"
    if fields_dir.exists():
        for field_file in sorted(fields_dir.glob(f"{seg_id}-*.adoc")):
            match = re.match(rf"{re.escape(seg_id)}-(\d+)\.adoc", field_file.name)
            if not match:
                continue

            field_num = match.group(1)
            element_id = f"{seg_id}.{field_num}"

            field_elem = find_element_by_id(elements, element_id)
            if not field_elem:
                errors.append(f"Element {element_id} not found in JSON")
                continue

            # Extract and inject definition
            field_def = extract_segment_definition(field_file)
            if field_def:
                existing_def = field_elem.get("definition")
                if normalize_for_comparison(field_def) != normalize_for_comparison(existing_def or ""):
                    changes.append({
                        "element_id": element_id,
                        "field": "definition",
                        "old_length": len(existing_def or ""),
                        "new_length": len(field_def),
                        "file": field_file.name,
                    })
                    if not dry_run:
                        field_elem["definition"] = field_def
                    if verbose:
                        print(f"  {element_id}: Definition updated ({len(existing_def or '')} -> {len(field_def)} chars)")
            elif verbose:
                print(f"  {element_id}: No definition in AsciiDoc")

            # Extract and inject comment
            field_comment = extract_segment_comment(field_file)
            if field_comment:
                existing_comment = field_elem.get("comment")
                if normalize_for_comparison(field_comment) != normalize_for_comparison(existing_comment or ""):
                    changes.append({
                        "element_id": element_id,
                        "field": "comment",
                        "old_length": len(existing_comment or ""),
                        "new_length": len(field_comment),
                        "file": field_file.name,
                    })
                    if not dry_run:
                        field_elem["comment"] = field_comment
                    if verbose:
                        print(f"  {element_id}: Comment updated ({len(existing_comment or '')} -> {len(field_comment)} chars)")

    # Write updated JSON if changes were made
    if changes and not dry_run:
        json_file.write_text(
            json.dumps(sd, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )

    return changes, errors


def discover_segments():
    """Find all segment codes from AsciiDoc root files."""
    codes = []
    for f in sorted(ADOC_DIR.glob("*.adoc")):
        codes.append(f.stem)
    return codes


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv

    target_seg = None
    for i, arg in enumerate(sys.argv):
        if arg == "--segment" and i + 1 < len(sys.argv):
            target_seg = sys.argv[i + 1]

    if target_seg:
        segments = [target_seg]
    else:
        segments = discover_segments()

    print(f"Processing {len(segments)} segment(s)...")
    if dry_run:
        print("(DRY RUN - no files will be modified)\n")

    total_changes = 0
    total_errors = 0
    files_changed = 0

    for seg_id in segments:
        if verbose:
            print(f"\n{seg_id}:")

        changes, errs = inject_for_segment(seg_id, dry_run, verbose)

        if changes:
            files_changed += 1
            total_changes += len(changes)
            if not verbose:
                action = "would be updated" if dry_run else "updated"
                print(f"  {seg_id}: {len(changes)} field(s) {action}")

        for err in errs:
            print(f"  ERROR [{seg_id}]: {err}")
            total_errors += 1

    print(f"\nSummary:")
    action = "Would update" if dry_run else "Updated"
    print(f"  {action} {total_changes} fields across {files_changed} segments")
    print(f"  {total_errors} errors")

    if dry_run and total_changes > 0:
        print("\nRun without --dry-run to apply changes.")


if __name__ == "__main__":
    main()
