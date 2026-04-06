#!/usr/bin/env python3
"""Backfill segment AsciiDoc files from FHIR StructureDefinition JSON.

One-time script to create the AsciiDoc source-of-truth layer for segment
definitions, mirroring the existing data type pattern. Reads segment JSON
from input/sourceOfTruth/segment/segments/ and generates:

  website/data_structures/segments/{SEG}.adoc          (root, 192 files)
  website/data_structures/segments/{SEG}-fields/
    {SEG}-{N}.adoc                                     (per field, ~2912 files)

Usage:
    python3 backfill_segment_adoc.py [--dry-run] [--verbose] [--segment SEG] [--force]

Options:
    --dry-run       Show what would be created without writing files
    --verbose       Print detailed output per file
    --segment SEG   Process only the specified segment (e.g., PID)
    --force         Overwrite existing AsciiDoc files (default: skip existing)
"""

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
JSON_DIR = REPO_ROOT / "input" / "sourceOfTruth" / "segment" / "segments"
ADOC_DIR = REPO_ROOT / "website" / "data_structures" / "segments"


def get_extension_value(element, url_fragment):
    """Extract a simple extension value from an element by URL fragment."""
    for ext in element.get("extension", []):
        if url_fragment in ext.get("url", ""):
            return ext.get("valueCode") or ext.get("valueString")
    return None


def get_data_type(element):
    """Extract data type code from element type[0].code, or '' if none."""
    types = element.get("type", [])
    if not types:
        return ""
    code = types[0].get("code", "")
    # Strip URL prefix if present (e.g., http://hl7.org/v2/StructureDefinition/ST -> ST)
    if "/" in code:
        code = code.rsplit("/", 1)[-1]
    return code


def format_field_heading(seg_id, field_num, short_name, data_type):
    """Format the AsciiDoc heading for a field file.

    Returns '== {SEG}.{N} - {name} ({type})' or '== {SEG}.{N} - {name}' if no type.
    """
    heading = f"== {seg_id}.{field_num} - {short_name}"
    if data_type:
        heading += f" ({data_type})"
    return heading


def generate_root_adoc(seg_id, short_name, definition, field_count):
    """Generate the root .adoc content string for a segment."""
    timestamp = datetime.now(timezone.utc).strftime("%a, %d %b %Y %H:%M:%S %z")
    lines = [
        f"= ({seg_id}) Segment - {short_name}",
        f":v2type: 'Segment'",
        f":code: {seg_id}",
        f":name: {short_name}",
        f":generated: {timestamp}",
        "",
        "[segment-definition]",
    ]
    if definition:
        lines.append(definition)
    else:
        lines.append("// TODO: Add segment definition")
    lines.append("")

    for n in range(1, field_count + 1):
        lines.append(f"include::{seg_id}-fields/{seg_id}-{n}.adoc[]")
        lines.append("")

    return "\n".join(lines)


def generate_field_adoc(seg_id, field_num, short_name, data_type, definition, comment):
    """Generate the field .adoc content string for a segment field."""
    heading = format_field_heading(seg_id, field_num, short_name, data_type)
    lines = [heading, "", "[segment-definition]"]

    if definition:
        lines.append(definition)
    else:
        lines.append("// TODO: Add field definition")
    lines.append("")

    if comment:
        lines.append("[segment-comment]")
        lines.append(comment)
        lines.append("")

    return "\n".join(lines)


def backfill_segment(seg_id, json_path, dry_run=False, verbose=False, force=False):
    """Process one segment: read JSON, write AsciiDoc files.

    Returns (files_created, files_skipped) tuple.
    """
    with open(json_path, encoding="utf-8") as f:
        sd = json.load(f)

    elements = sd.get("differential", {}).get("element", [])
    if not elements:
        return 0, 0

    # Separate root element from field elements
    root_elem = None
    field_elems = []
    for elem in elements:
        eid = elem.get("id", "")
        if "." not in eid:
            root_elem = elem
        else:
            field_elems.append(elem)

    if not root_elem:
        return 0, 0

    short_name = root_elem.get("short", seg_id)
    root_definition = root_elem.get("definition")

    files_created = 0
    files_skipped = 0

    # Generate root AsciiDoc file
    root_path = ADOC_DIR / f"{seg_id}.adoc"
    if root_path.exists() and not force:
        files_skipped += 1
        if verbose:
            print(f"  SKIP {root_path.name} (exists)")
    else:
        content = generate_root_adoc(seg_id, short_name, root_definition, len(field_elems))
        if not dry_run:
            root_path.parent.mkdir(parents=True, exist_ok=True)
            root_path.write_text(content, encoding="utf-8")
        files_created += 1
        if verbose:
            print(f"  CREATE {root_path.name}")

    # Generate field AsciiDoc files
    fields_dir = ADOC_DIR / f"{seg_id}-fields"
    for elem in field_elems:
        eid = elem.get("id", "")
        field_num = eid.split(".")[-1]
        short = elem.get("short", "")
        data_type = get_data_type(elem)
        definition = elem.get("definition")
        comment = elem.get("comment")

        field_path = fields_dir / f"{seg_id}-{field_num}.adoc"
        if field_path.exists() and not force:
            files_skipped += 1
            if verbose:
                print(f"  SKIP {field_path.relative_to(ADOC_DIR)}")
            continue

        content = generate_field_adoc(seg_id, field_num, short, data_type, definition, comment)
        if not dry_run:
            field_path.parent.mkdir(parents=True, exist_ok=True)
            field_path.write_text(content, encoding="utf-8")
        files_created += 1
        if verbose:
            print(f"  CREATE {field_path.relative_to(ADOC_DIR)}")

    return files_created, files_skipped


def discover_segments():
    """Find all segment codes from JSON files. Returns sorted list."""
    codes = []
    for f in sorted(JSON_DIR.glob("*.json")):
        codes.append(f.stem)
    return codes


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv
    force = "--force" in sys.argv

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
        print("(DRY RUN - no files will be written)\n")

    total_created = 0
    total_skipped = 0

    for seg_id in segments:
        json_path = JSON_DIR / f"{seg_id}.json"
        if not json_path.exists():
            print(f"  ERROR: {json_path.name} not found")
            continue

        if verbose:
            print(f"\n{seg_id}:")

        created, skipped = backfill_segment(seg_id, json_path, dry_run, verbose, force)
        total_created += created
        total_skipped += skipped

        if not verbose and created > 0:
            action = "Would create" if dry_run else "Created"
            print(f"  {seg_id}: {action} {created} file(s)")

    print(f"\nSummary:")
    action = "Would create" if dry_run else "Created"
    print(f"  {action} {total_created} files")
    print(f"  Skipped {total_skipped} existing files")


if __name__ == "__main__":
    main()
