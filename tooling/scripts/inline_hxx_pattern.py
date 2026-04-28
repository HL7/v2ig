#!/usr/bin/env python3
"""Inline the Hxx recursive BackboneElement pattern at each Hxx slot.

Per ADR-0007, the Hxx placeholder is a recursive BackboneElement with a
.segment child and a .group child (contentReference back to the parent Hxx
slot). The XOR (segment-or-group) and MSH-exclusion semantics are documented
narratively in element definition text rather than as FHIRPath invariants —
the IG Publisher's FHIRPath type-checker cannot walk a recursive
contentReference at validation time, and the MSH-exclusion expression cannot
be expressed against the abstract Segment base (which has no fields). See
ADR-0007 follow-up for plans to re-introduce machine-checkable enforcement.

Because FHIR's contentReference is StructureDefinition-scoped, the pattern
cannot be centralized in Hxx.json and resolved through a `type` reference;
it must be duplicated inline at each consuming site, with the contentReference
on the .group element pointing to the LOCAL Hxx slot in the same SD.

This script walks all message structure JSON files and:
  - finds elements typed as http://hl7.org/v2/StructureDefinition/Hxx and
    rewrites each into three elements (parent BackboneElement + .segment
    child + .group child);
  - finds already-inlined Hxx parents and strips any leftover constraints
    or stale "slot-level invariant" references in child definitions.

Idempotent: re-running on a fully-inlined, constraint-free tree is a no-op.

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

SEMANTICS_SUFFIX = (
    " Per Hxx semantics (StructureDefinition/Hxx, ADR-0007): each occurrence "
    "carries exactly one segment OR one nested group, not both; MSH and "
    "transmission-control segments (BHS, BTS, FHS, FTS, DSC) are excluded."
)

SEGMENT_DEFINITION = (
    "When this Hxx occurrence is a single segment (not a nested group), the "
    "segment is provided here. Type is the abstract Segment base; any concrete "
    "V2 segment may appear, except MSH and the transmission-control segments "
    "(BHS, BTS, FHS, FTS, DSC) per Hxx semantics."
)

GROUP_DEFINITION = (
    "When this Hxx occurrence is a nested group rather than a single segment, "
    "the group's contents are themselves a sequence of Hxx slots. The "
    "contentReference points to this Hxx slot in the same StructureDefinition, "
    "enabling arbitrary nesting depth."
)


def is_hxx_typed(elem):
    """True if the element's type references the Hxx StructureDefinition."""
    return any(t.get("code") == HXX_TYPE_URL for t in elem.get("type", []))


def is_already_inlined(elements, parent_id):
    """True if .segment / .group children with the expected ids are already present."""
    expected_segment = f"{parent_id}.segment"
    expected_group = f"{parent_id}.group"
    seen = {e.get("id") for e in elements}
    return expected_segment in seen and expected_group in seen


def with_semantics_suffix(definition):
    """Append the Hxx semantics suffix to a definition if not already present."""
    if SEMANTICS_SUFFIX.strip() in (definition or ""):
        return definition
    return (definition or "").rstrip() + SEMANTICS_SUFFIX


def make_inline_replacement(parent):
    """Return [new_parent, segment_child, group_child] for a found Hxx slot."""
    parent_id = parent["id"]
    parent_path = parent["path"]
    base_definition = parent.get(
        "definition",
        "Open-ended placeholder per V2.9.1 §1.12 errata: any segment or "
        "segment group."
    )
    new_parent = {
        "id": parent_id,
        "path": parent_path,
        "short": parent.get("short", "Open-ended segment-or-group placeholder"),
        "definition": with_semantics_suffix(base_definition),
        "min": parent.get("min", 0),
        "max": parent.get("max", "*"),
        "type": [{"code": "BackboneElement"}],
    }
    segment_child = {
        "id": f"{parent_id}.segment",
        "path": f"{parent_path}.segment",
        "short": "A single segment instance occupying this Hxx slot",
        "definition": SEGMENT_DEFINITION,
        "min": 0,
        "max": "1",
        "type": [{"code": SEGMENT_TYPE_URL}],
    }
    group_child = {
        "id": f"{parent_id}.group",
        "path": f"{parent_path}.group",
        "short": "A nested group of Hxx slots (recursive)",
        "definition": GROUP_DEFINITION,
        "min": 0,
        "max": "1",
        "contentReference": f"#{parent_id}",
    }
    return [new_parent, segment_child, group_child]


def fix_already_inlined_parent(elem, segment_child, group_child):
    """Strip leftover constraints + refresh stale wording on already-inlined Hxx parents.

    Returns True if any change was applied.
    """
    changed = False
    if "constraint" in elem:
        del elem["constraint"]
        changed = True
    new_def = with_semantics_suffix(elem.get("definition", ""))
    if new_def != elem.get("definition"):
        elem["definition"] = new_def
        changed = True
    if segment_child is not None and segment_child.get("definition") != SEGMENT_DEFINITION:
        segment_child["definition"] = SEGMENT_DEFINITION
        changed = True
    if group_child is not None and group_child.get("definition") != GROUP_DEFINITION:
        group_child["definition"] = GROUP_DEFINITION
        changed = True
    return changed


def is_inlined_hxx_parent(elem):
    """True if the element is the parent BackboneElement of an inlined Hxx slot."""
    eid = elem.get("id", "")
    if not eid.endswith("-Hxx") and not eid.endswith(".Hxx"):
        return False
    return any(t.get("code") == "BackboneElement" for t in elem.get("type", []))


def process_file(path, dry_run):
    """Returns (inlined_ids, skipped_ids, fixed_ids).

    - inlined_ids: Hxx-typed parents converted to the three-element pattern.
    - skipped_ids: Hxx-typed parents that already had inlined siblings (unusual).
    - fixed_ids: already-inlined Hxx parents whose constraints / wording were updated.
    """
    data = json.loads(path.read_text())
    elements = data.get("differential", {}).get("element", [])
    elems_by_id = {e.get("id"): e for e in elements}
    new_elements = []
    inlined = []
    skipped_already_inlined = []
    fixed = []
    for elem in elements:
        if is_hxx_typed(elem):
            if is_already_inlined(elements, elem["id"]):
                skipped_already_inlined.append(elem["id"])
                new_elements.append(elem)
                continue
            new_elements.extend(make_inline_replacement(elem))
            inlined.append(elem["id"])
        else:
            if is_inlined_hxx_parent(elem):
                seg = elems_by_id.get(f"{elem['id']}.segment")
                grp = elems_by_id.get(f"{elem['id']}.group")
                if fix_already_inlined_parent(elem, seg, grp):
                    fixed.append(elem["id"])
            new_elements.append(elem)
    if not inlined and not skipped_already_inlined and not fixed:
        return [], [], []
    if inlined or fixed:
        data["differential"]["element"] = new_elements
        if not dry_run:
            path.write_text(json.dumps(data, indent=2) + "\n")
    return inlined, skipped_already_inlined, fixed


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
    total_fixed = 0
    total_fixed_files = 0

    for path in sorted(MS_DIR.glob("*.json")):
        inlined, skipped, fixed = process_file(path, args.dry_run)
        if not inlined and not skipped and not fixed:
            continue
        action = "would inline" if args.dry_run else "inlined"
        fix_action = "would fix" if args.dry_run else "fixed"
        header_printed = False
        if inlined:
            total_files += 1
            total_slots += len(inlined)
            print(f"{path.name}:")
            header_printed = True
            for sid in inlined:
                print(f"  {action}: {sid}")
        if skipped:
            if not header_printed:
                print(f"{path.name}:")
                header_printed = True
            total_skipped += len(skipped)
            for sid in skipped:
                print(f"  WARN already-inlined siblings present, kept Hxx-typed parent: {sid}")
        if fixed:
            if not header_printed:
                print(f"{path.name}:")
            total_fixed += len(fixed)
            total_fixed_files += 1
            for sid in fixed:
                print(f"  {fix_action} (constraints/wording): {sid}")

    print()
    prefix = "(dry-run) " if args.dry_run else ""
    print(f"{prefix}Total: {total_slots} Hxx slot(s) inlined across {total_files} file(s)")
    if total_fixed:
        print(f"{prefix}Total: {total_fixed} already-inlined Hxx parent(s) updated across {total_fixed_files} file(s)")
    if total_skipped:
        print(f"WARN: {total_skipped} slot(s) had pre-existing .segment/.group siblings; left unchanged")


if __name__ == "__main__":
    main()
