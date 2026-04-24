#!/usr/bin/env python3
"""Inline the Hxx recursive BackboneElement pattern at each Hxx slot.

Per ADR-0007, the Hxx placeholder is a recursive BackboneElement with a
.segment child, a .group child (contentReference back to the parent Hxx
slot), an XOR invariant (segment XOR group), and a transmission-control
exclusion invariant (no MSH/BHS/BTS/FHS/FTS/DSC).

Because FHIR's contentReference is StructureDefinition-scoped, the pattern
cannot be centralized in Hxx.json and resolved through a `type` reference;
it must be duplicated inline at each consuming site, with the contentReference
on the .group element pointing to the LOCAL Hxx slot in the same SD.

This script walks all message structure JSON files, finds elements typed as
http://hl7.org/v2/StructureDefinition/Hxx, and rewrites each into three
elements (parent BackboneElement + .segment child + .group child).

Idempotent: re-running on already-inlined files is a no-op.

Usage:
    python3 tooling/scripts/inline_hxx_pattern.py [--dry-run]
"""

import argparse
import json
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
MS_DIR = PROJECT_ROOT / "input" / "sourceOfTruth" / "message-structure" / "message_structures"

HXX_TYPE_URL = "http://hl7.org/v2/StructureDefinition/Hxx"
SEGMENT_TYPE_URL = "http://hl7.org/v2/StructureDefinition/Segment"
SEGMENT_STATUS_EXT_URL = "http://hl7.org/v2/StructureDefinition/v2-segment-status"

XOR_CONSTRAINT = {
    "key": "v2-hxx-xor",
    "severity": "error",
    "human": "Each Hxx occurrence must contain exactly one of: a single segment (.segment) or a nested group (.group).",
    "expression": "(segment.exists() and group.empty()) or (segment.empty() and group.exists())"
}

NO_CONTROL_CONSTRAINT = {
    "key": "v2-hxx-no-control",
    "severity": "error",
    "human": "MSH and transmission-control segments (BHS, BTS, FHS, FTS, DSC) are not permitted in an Hxx placeholder slot (V2.9.1 §1.12).",
    "expression": "segment.empty() or not(segment.type.first().code.endsWith('/MSH') or segment.type.first().code.endsWith('/BHS') or segment.type.first().code.endsWith('/BTS') or segment.type.first().code.endsWith('/FHS') or segment.type.first().code.endsWith('/FTS') or segment.type.first().code.endsWith('/DSC'))"
}


def is_hxx_typed(elem):
    """True if the element's type references the Hxx StructureDefinition."""
    return any(t.get("code") == HXX_TYPE_URL for t in elem.get("type", []))


def is_already_inlined(elements, parent_id):
    """True if .segment / .group children with the expected ids are already present."""
    expected_segment = f"{parent_id}.segment"
    expected_group = f"{parent_id}.group"
    seen = {e.get("id") for e in elements}
    return expected_segment in seen and expected_group in seen


def make_inline_replacement(parent):
    """Return [new_parent, segment_child, group_child] for a found Hxx slot."""
    parent_id = parent["id"]
    parent_path = parent["path"]
    new_parent = {
        "id": parent_id,
        "path": parent_path,
        "short": parent.get("short", "Open-ended segment-or-group placeholder"),
        "definition": parent.get(
            "definition",
            "Open-ended placeholder per V2.9.1 §1.12 errata: any segment or "
            "segment group, except MSH and other transmission-control segments. "
            "See ADR-0007."
        ),
        "min": parent.get("min", 0),
        "max": parent.get("max", "*"),
        "type": [{"code": "BackboneElement"}],
        "constraint": [XOR_CONSTRAINT, NO_CONTROL_CONSTRAINT],
    }
    segment_child = {
        "id": f"{parent_id}.segment",
        "path": f"{parent_path}.segment",
        "short": "A single segment instance occupying this Hxx slot",
        "definition": "When this Hxx occurrence is a single segment (not a nested group), the segment is provided here. Type is the abstract Segment base; any concrete V2 segment may appear, except those excluded by the slot-level invariant.",
        "min": 0,
        "max": "1",
        "type": [{"code": SEGMENT_TYPE_URL}],
    }
    group_child = {
        "id": f"{parent_id}.group",
        "path": f"{parent_path}.group",
        "short": "A nested group of Hxx slots (recursive)",
        "definition": "When this Hxx occurrence is a nested group rather than a single segment, the group's contents are themselves a sequence of Hxx slots. The contentReference points to this Hxx slot in the same StructureDefinition, enabling arbitrary nesting depth.",
        "min": 0,
        "max": "1",
        "contentReference": f"#{parent_id}",
    }
    return [new_parent, segment_child, group_child]


def process_file(path, dry_run):
    """Returns list of inlined parent ids (empty if no changes)."""
    data = json.loads(path.read_text())
    elements = data.get("differential", {}).get("element", [])
    new_elements = []
    inlined = []
    skipped_already_inlined = []
    for elem in elements:
        if is_hxx_typed(elem):
            if is_already_inlined(elements, elem["id"]):
                # The Hxx-typed parent is being kept (probably from a prior partial run);
                # skip but warn.
                skipped_already_inlined.append(elem["id"])
                new_elements.append(elem)
                continue
            new_elements.extend(make_inline_replacement(elem))
            inlined.append(elem["id"])
        else:
            new_elements.append(elem)
    if not inlined and not skipped_already_inlined:
        return [], []
    if inlined:
        data["differential"]["element"] = new_elements
        if not dry_run:
            path.write_text(json.dumps(data, indent=2) + "\n")
    return inlined, skipped_already_inlined


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true",
                        help="Report what would change without writing files.")
    args = parser.parse_args()

    if not MS_DIR.exists():
        print(f"ERROR: message-structures directory not found: {MS_DIR}", file=sys.stderr)
        sys.exit(1)

    total_files = 0
    total_slots = 0
    total_skipped = 0

    for path in sorted(MS_DIR.glob("*.json")):
        inlined, skipped = process_file(path, args.dry_run)
        if not inlined and not skipped:
            continue
        action = "would inline" if args.dry_run else "inlined"
        if inlined:
            total_files += 1
            total_slots += len(inlined)
            print(f"{path.name}:")
            for sid in inlined:
                print(f"  {action}: {sid}")
        if skipped:
            total_skipped += len(skipped)
            for sid in skipped:
                print(f"  WARN already-inlined siblings present, kept Hxx-typed parent: {sid}")

    print()
    prefix = "(dry-run) " if args.dry_run else ""
    print(f"{prefix}Total: {total_slots} Hxx slot(s) inlined across {total_files} file(s)")
    if total_skipped:
        print(f"WARN: {total_skipped} slot(s) had pre-existing .segment/.group siblings; left unchanged")


if __name__ == "__main__":
    main()
