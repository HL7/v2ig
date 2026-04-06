#!/usr/bin/env python3
"""
TASK-006: AsciiDoc-to-StructureDefinition Injection

Extracts [datatype-definition] blocks from AsciiDoc files and injects
them into the corresponding FHIR StructureDefinition JSON resources.

This ensures that when editors modify AsciiDoc content, the changes
flow through to the FHIR resources used by the IG Publisher.

Usage:
    python3 inject_definitions.py [--dry-run] [--verbose] [--code CODE]

Options:
    --dry-run   Show what would change without modifying files
    --verbose   Print detailed output
    --code CODE Process only the specified data type code (e.g., CWE, EI)
"""

import json
import os
import re
import sys
from pathlib import Path

# Paths relative to repo root
REPO_ROOT = Path(__file__).resolve().parent.parent.parent
ADOC_DIR = REPO_ROOT / "website" / "data_structures" / "data_types" / "complex"
JSON_DIR = REPO_ROOT / "input" / "sourceOfTruth" / "data-type" / "complex" / "complex-data-types"


def extract_datatype_definition(adoc_path):
    """Extract the [datatype-definition] block text from an AsciiDoc file.

    Returns the text following [datatype-definition] up to the next
    section heading (== ...), include:: directive, or end of file.
    """
    try:
        content = adoc_path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return None

    lines = content.split("\n")
    in_definition = False
    definition_lines = []

    for line in lines:
        if line.strip() == "[datatype-definition]":
            in_definition = True
            continue

        if in_definition:
            # Stop at next section heading or include directive
            if line.startswith("== ") or line.startswith("include::"):
                break
            definition_lines.append(line)

    if not definition_lines:
        return None

    # Trim leading/trailing blank lines, preserve internal structure
    text = "\n".join(definition_lines).strip()
    return text if text else None


def parse_adoc_front_matter(adoc_path):
    """Extract front matter attributes from an AsciiDoc file header."""
    attrs = {}
    try:
        content = adoc_path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return attrs

    for line in content.split("\n"):
        # Stop at first blank line after header or content line
        if line.strip() == "" and attrs:
            continue
        match = re.match(r"^:(\w+):\s*(.+)$", line)
        if match:
            key = match.group(1)
            value = match.group(2).strip().strip("'\"")
            attrs[key] = value
        elif line.startswith("= "):
            continue  # title line
        elif not line.startswith(":") and line.strip() and not line.startswith("="):
            break  # content started

    return attrs


def find_element_by_id(elements, element_id):
    """Find an element in the StructureDefinition's element array by id."""
    for elem in elements:
        if elem.get("id") == element_id:
            return elem
    return None


def inject_for_datatype(code, dry_run=False, verbose=False):
    """Process a single data type: extract definitions and inject into JSON.

    Returns (changes_made, errors) tuple.
    """
    code_upper = code.upper()
    code_lower = code.lower()
    adoc_file = ADOC_DIR / f"{code_upper}.adoc"
    json_file = JSON_DIR / f"{code_lower}.json"

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

    # 1. Extract and inject root definition
    root_def = extract_datatype_definition(adoc_file)
    if root_def:
        root_elem = find_element_by_id(elements, code_upper)
        if root_elem:
            # For root elements, the definition is the first paragraph
            # and description (top-level) gets the remaining paragraphs
            paragraphs = re.split(r"\n\n+", root_def)
            first_para = paragraphs[0].strip() if paragraphs else root_def.strip()

            # Compare with existing
            existing_def = root_elem.get("definition", "")
            # Strip any existing "Definition: " prefix for comparison
            existing_clean = re.sub(r"^\*?Definition:?\*?\s*", "", existing_def or "")

            if verbose:
                print(f"  Root definition extracted ({len(first_para)} chars)")

    # 2. Extract and inject component definitions
    components_dir = ADOC_DIR / f"{code_upper}-components"
    if components_dir.exists():
        for comp_file in sorted(components_dir.glob(f"{code_upper}-*.adoc")):
            # Extract component number from filename: CWE-1.adoc -> 1
            match = re.match(rf"{re.escape(code_upper)}-(\d+)\.adoc", comp_file.name)
            if not match:
                continue

            comp_num = match.group(1)
            element_id = f"{code_upper}.{comp_num}"

            comp_def = extract_datatype_definition(comp_file)
            if not comp_def:
                if verbose:
                    print(f"  {element_id}: No [datatype-definition] block found")
                continue

            comp_elem = find_element_by_id(elements, element_id)
            if not comp_elem:
                errors.append(f"Element {element_id} not found in JSON")
                continue

            # Components use "defintion" (typo) in the existing JSON
            # Check both spellings
            def_key = "defintion" if "defintion" in comp_elem else "definition"
            existing = comp_elem.get(def_key, "")

            # Strip "Definition: " prefix from existing for comparison
            existing_clean = re.sub(r"^\*?Definition:?\*?\s*", "", existing or "")
            existing_clean = existing_clean.strip()

            # Normalize whitespace for comparison
            comp_def_normalized = re.sub(r"\s+", " ", comp_def.strip())
            existing_normalized = re.sub(r"\s+", " ", existing_clean)

            if comp_def_normalized != existing_normalized:
                new_value = comp_def
                changes.append({
                    "element_id": element_id,
                    "field": def_key,
                    "old_length": len(existing or ""),
                    "new_length": len(new_value),
                    "file": comp_file.name,
                })

                if not dry_run:
                    comp_elem[def_key] = new_value

                if verbose:
                    print(f"  {element_id}: Definition updated ({len(existing or '')} -> {len(new_value)} chars)")
            else:
                if verbose:
                    print(f"  {element_id}: No changes needed")

    # Write updated JSON if changes were made
    if changes and not dry_run:
        json_file.write_text(
            json.dumps(sd, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )

    return changes, errors


def discover_data_types():
    """Find all complex data type codes from AsciiDoc files."""
    codes = []
    for f in sorted(ADOC_DIR.glob("*.adoc")):
        if f.name == "navigation.adoc":
            continue
        code = f.stem
        if code.isupper() or code.upper() == code:
            codes.append(code)
    return codes


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv

    # Optional: process only a specific code
    target_code = None
    for i, arg in enumerate(sys.argv):
        if arg == "--code" and i + 1 < len(sys.argv):
            target_code = sys.argv[i + 1].upper()

    if target_code:
        codes = [target_code]
    else:
        codes = discover_data_types()

    print(f"Processing {len(codes)} data type(s)...")
    if dry_run:
        print("(DRY RUN - no files will be modified)\n")

    total_changes = 0
    total_errors = 0
    files_changed = 0

    for code in codes:
        if verbose:
            print(f"\n{code}:")

        changes, errors = inject_for_datatype(code, dry_run, verbose)

        if changes:
            files_changed += 1
            total_changes += len(changes)
            if not verbose:
                print(f"  {code}: {len(changes)} definition(s) would be updated" if dry_run
                      else f"  {code}: {len(changes)} definition(s) updated")

        for err in errors:
            print(f"  ERROR [{code}]: {err}")
            total_errors += 1

    print(f"\nSummary:")
    action = "Would update" if dry_run else "Updated"
    print(f"  {action} {total_changes} definitions across {files_changed} data types")
    print(f"  {total_errors} errors")

    if dry_run and total_changes > 0:
        print("\nRun without --dry-run to apply changes.")


if __name__ == "__main__":
    main()
