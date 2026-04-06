#!/usr/bin/env python3
"""
TASK-011: Build V2 Construct Registry from FHIR Resources

Scans all FHIR StructureDefinition resources in input/sourceOfTruth/ and
builds a JSON registry mapping V2 construct codes to their published IG URLs.

The registry is used by the auto-linker (TASK-013) to convert plain-text
V2 references (like "PID-3", "CWE", "ADT^A01") into hyperlinks.

Output: tooling/registry.json

Usage:
    python3 build_registry.py [--verbose]
"""

import json
import os
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
SOURCE_DIR = REPO_ROOT / "input" / "sourceOfTruth"
OUTPUT_FILE = REPO_ROOT / "tooling" / "registry.json"

# IG base URL pattern: StructureDefinition-{ID}.html
IG_PAGE = "StructureDefinition-{id}.html"


def load_json(filepath):
    """Load a JSON file, returning None on error."""
    try:
        return json.loads(filepath.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, FileNotFoundError) as e:
        print(f"  WARNING: Could not read {filepath}: {e}", file=sys.stderr)
        return None


def build_primitive_types(verbose=False):
    """Build registry entries for primitive data types."""
    entries = {}
    prim_dir = SOURCE_DIR / "data-type" / "primitive" / "primitives"
    if not prim_dir.exists():
        return entries

    for json_file in sorted(prim_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        code = sd.get("id", json_file.stem.upper())
        entries[code] = {
            "type": "primitive-data-type",
            "code": code,
            "name": sd.get("name", code),
            "title": sd.get("title", ""),
            "url": IG_PAGE.format(id=code),
        }

    if verbose:
        print(f"  Primitive data types: {len(entries)}")
    return entries


def build_complex_types(verbose=False):
    """Build registry entries for complex data types and their components."""
    entries = {}
    complex_dir = SOURCE_DIR / "data-type" / "complex" / "complex-data-types"
    if not complex_dir.exists():
        return entries

    for json_file in sorted(complex_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        code = sd.get("id", json_file.stem.upper())
        page_url = IG_PAGE.format(id=code)

        entries[code] = {
            "type": "complex-data-type",
            "code": code,
            "name": sd.get("name", code),
            "title": sd.get("title", ""),
            "url": page_url,
        }

        # Register components (CWE.1, CWE.2, etc.)
        elements = sd.get("differential", {}).get("element", [])
        for elem in elements:
            elem_id = elem.get("id", "")
            if "." in elem_id:  # Component element
                short = elem.get("short", "")
                entries[elem_id] = {
                    "type": "data-type-component",
                    "code": elem_id,
                    "name": short,
                    "parent": code,
                    "url": f"{page_url}#{elem_id}",
                }

    if verbose:
        dt_count = sum(1 for v in entries.values() if v["type"] == "complex-data-type")
        comp_count = sum(1 for v in entries.values() if v["type"] == "data-type-component")
        print(f"  Complex data types: {dt_count} ({comp_count} components)")
    return entries


def build_segments(verbose=False):
    """Build registry entries for segments and their fields."""
    entries = {}
    seg_dir = SOURCE_DIR / "segment" / "segments"
    if not seg_dir.exists():
        return entries

    for json_file in sorted(seg_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        code = sd.get("id", json_file.stem.upper())
        page_url = IG_PAGE.format(id=code)

        entries[code] = {
            "type": "segment",
            "code": code,
            "name": sd.get("name", code),
            "title": sd.get("title", ""),
            "url": page_url,
        }

        # Register fields (PID.1 -> PID-1, etc.)
        elements = sd.get("differential", {}).get("element", [])
        for elem in elements:
            elem_id = elem.get("id", "")
            if "." in elem_id:
                short = elem.get("short", "")
                # Also register as SEG-N format (common V2 convention)
                seg_code, field_num = elem_id.split(".", 1)
                field_ref = f"{seg_code}-{field_num}"
                entries[elem_id] = {
                    "type": "segment-field",
                    "code": elem_id,
                    "field_ref": field_ref,
                    "name": short,
                    "parent": code,
                    "url": f"{page_url}#{elem_id}",
                }
                # Also register by SEG-N format
                entries[field_ref] = {
                    "type": "segment-field",
                    "code": field_ref,
                    "element_id": elem_id,
                    "name": short,
                    "parent": code,
                    "url": f"{page_url}#{elem_id}",
                }

    if verbose:
        seg_count = sum(1 for v in entries.values() if v["type"] == "segment")
        field_count = sum(1 for v in entries.values() if v["type"] == "segment-field")
        print(f"  Segments: {seg_count} ({field_count} field entries)")
    return entries


def build_messages(verbose=False):
    """Build registry entries for messages."""
    entries = {}
    msg_dir = SOURCE_DIR / "message" / "messages"
    if not msg_dir.exists():
        return entries

    for json_file in sorted(msg_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        msg_id = sd.get("id", json_file.stem)
        # Extract message type pattern: ADT-A01 -> ADT^A01
        msg_code = msg_id.replace("-", "^")

        entries[msg_code] = {
            "type": "message",
            "code": msg_code,
            "id": msg_id,
            "name": sd.get("name", msg_id),
            "title": sd.get("title", ""),
            "url": IG_PAGE.format(id=msg_id),
        }

    if verbose:
        print(f"  Messages: {len(entries)}")
    return entries


def build_message_structures(verbose=False):
    """Build registry entries for message structures."""
    entries = {}
    ms_dir = SOURCE_DIR / "message-structure" / "message_structures"
    if not ms_dir.exists():
        return entries

    for json_file in sorted(ms_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        ms_id = sd.get("id", json_file.stem)
        entries[ms_id] = {
            "type": "message-structure",
            "code": ms_id,
            "name": sd.get("name", ms_id),
            "title": sd.get("title", ""),
            "url": IG_PAGE.format(id=ms_id),
        }

    if verbose:
        print(f"  Message structures: {len(entries)}")
    return entries


def build_events(verbose=False):
    """Build registry entries for events."""
    entries = {}
    evt_dir = SOURCE_DIR / "event" / "events"
    if not evt_dir.exists():
        return entries

    for json_file in sorted(evt_dir.glob("*.json")):
        sd = load_json(json_file)
        if not sd:
            continue

        evt_id = sd.get("id", json_file.stem)
        entries[evt_id] = {
            "type": "event",
            "code": evt_id,
            "name": sd.get("name", evt_id),
            "title": sd.get("title", ""),
            "url": IG_PAGE.format(id=evt_id),
        }

    if verbose:
        print(f"  Events: {len(entries)}")
    return entries


def main():
    verbose = "--verbose" in sys.argv

    print("Building V2 construct registry...")

    registry = {}
    collisions = []

    def merge(entries):
        """Merge entries into registry, tracking collisions instead of overwriting."""
        for key, value in entries.items():
            if key in registry:
                collisions.append(
                    (key, registry[key]["type"], value["type"])
                )
            else:
                registry[key] = value

    # Build all construct types (order matters: earlier types win on collision)
    merge(build_primitive_types(verbose))
    merge(build_complex_types(verbose))
    merge(build_segments(verbose))
    merge(build_messages(verbose))
    merge(build_message_structures(verbose))
    merge(build_events(verbose))

    # Write registry
    output = {
        "version": "1.0",
        "description": "V2 construct registry mapping codes to published IG URLs",
        "generated_by": "tooling/scripts/build_registry.py",
        "construct_count": len(registry),
        "constructs": registry,
    }

    OUTPUT_FILE.write_text(
        json.dumps(output, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    if collisions:
        print(f"\nCollisions ({len(collisions)} keys shared across types, first type wins):")
        for key, kept_type, dropped_type in collisions:
            print(f"  {key}: kept {kept_type}, dropped {dropped_type}")

    print(f"\nRegistry built: {len(registry)} entries written to {OUTPUT_FILE.relative_to(REPO_ROOT)}")

    # Summary by type
    type_counts = {}
    for entry in registry.values():
        t = entry["type"]
        type_counts[t] = type_counts.get(t, 0) + 1

    print("\nBreakdown:")
    for t, count in sorted(type_counts.items()):
        print(f"  {t}: {count}")


if __name__ == "__main__":
    main()
