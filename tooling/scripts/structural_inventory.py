#!/usr/bin/env python3
"""Comprehensive structural inventory comparing FHIR resources vs V291 extractions.

Compares all artifact types: segments, complex data types, message structures,
events. Produces a JSON report and a human-readable Markdown report with gap
analysis (what's in FHIR but not V291, and vice versa).
"""

import json
import glob
import os
import sys
from collections import defaultdict
from pathlib import Path

# ── Paths ──────────────────────────────────────────────────────────────────

FHIR_PATHS = {
    "segments": "input/sourceOfTruth/segment/segments",
    "complex_data_types": "input/sourceOfTruth/data-type/complex/complex-data-types",
    "primitive_data_types": "input/sourceOfTruth/data-type/primitive/primitives",
    "messages": "input/sourceOfTruth/message/messages",
    "message_structures": "input/sourceOfTruth/message-structure/message_structures",
    "events": "input/sourceOfTruth/event/events",
}

V291_PATHS = {
    "segments": "v291-extracted/segments",
    "complex_data_types": "v291-extracted/data-types/complex",
    "events": "v291-extracted/events",
    "message_structures": "v291-extracted/message-structures",
    "vocabulary": "v291-extracted/vocabulary",
    "query_parameters": "v291-extracted/query-parameters",
}


def load_json(path):
    """Load a JSON file, returning None on error."""
    try:
        with open(path) as f:
            return json.load(f)
    except (json.JSONDecodeError, OSError) as e:
        print(f"  WARNING: Failed to load {path}: {e}", file=sys.stderr)
        return None


# ── Key extraction functions ───────────────────────────────────────────────

def fhir_key_from_filename(filepath):
    """Extract artifact key from FHIR filename (stem, uppercase)."""
    return Path(filepath).stem.upper()


def fhir_segment_key(filepath):
    return Path(filepath).stem.upper()


def fhir_complex_dt_key(filepath):
    return Path(filepath).stem.upper()


def fhir_message_structure_key(filepath):
    """FHIR message structure files: ACK-A.json → ACK_A"""
    stem = Path(filepath).stem
    return stem.replace("-", "_").upper()


def fhir_event_key(filepath):
    return Path(filepath).stem.upper()


def fhir_message_key(filepath):
    return Path(filepath).stem.upper()


def v291_segment_key(filepath):
    return Path(filepath).stem.upper()


def v291_complex_dt_key(filepath):
    return Path(filepath).stem.upper()


def v291_message_structure_key(filepath):
    """V291 message structures use structureId field as canonical key."""
    data = load_json(filepath)
    if data and "structureId" in data:
        return data["structureId"].upper()
    return Path(filepath).stem.upper()


def v291_event_key(filepath):
    """V291 events: extract eventCode field."""
    data = load_json(filepath)
    if data and "eventCode" in data:
        return data["eventCode"].upper()
    return Path(filepath).stem.split("_")[0].upper()


# ── Inventory collection ──────────────────────────────────────────────────

def collect_files(directory, pattern="*.json"):
    """Collect all JSON files from a directory."""
    dirpath = os.path.join(os.getcwd(), directory)
    if not os.path.isdir(dirpath):
        return []
    return sorted(glob.glob(os.path.join(dirpath, pattern)))


def build_keyed_inventory(files, key_fn):
    """Build a dict mapping key → list of files (handles duplicates)."""
    inventory = defaultdict(list)
    for f in files:
        key = key_fn(f)
        inventory[key].append(f)
    return dict(inventory)


# ── Comparison logic ──────────────────────────────────────────────────────

def compare_inventories(fhir_inv, v291_inv, artifact_type):
    """Compare FHIR and V291 inventories, producing a gap analysis."""
    fhir_keys = set(fhir_inv.keys())
    v291_keys = set(v291_inv.keys())

    both = sorted(fhir_keys & v291_keys)
    fhir_only = sorted(fhir_keys - v291_keys)
    v291_only = sorted(v291_keys - fhir_keys)

    # Check for V291 duplicates (multiple files mapping to same key)
    v291_duplicates = {k: v for k, v in v291_inv.items() if len(v) > 1}

    return {
        "artifact_type": artifact_type,
        "fhir_count": len(fhir_keys),
        "v291_count": len(v291_keys),
        "matched": len(both),
        "fhir_only_count": len(fhir_only),
        "v291_only_count": len(v291_only),
        "fhir_only": fhir_only,
        "v291_only": v291_only,
        "matched_keys": both,
        "v291_duplicate_keys": {
            k: [os.path.basename(f) for f in v]
            for k, v in v291_duplicates.items()
        },
    }


# ── Data type component comparison ────────────────────────────────────────

def compare_data_type_components(fhir_file, v291_file):
    """Compare individual components of a complex data type."""
    fhir_data = load_json(fhir_file)
    v291_data = load_json(v291_file)
    if not fhir_data or not v291_data:
        return None

    # Extract FHIR components from differential elements
    fhir_components = []
    elements = fhir_data.get("differential", {}).get("element", [])
    for elem in elements:
        eid = elem.get("id", "")
        if "." in eid:  # Skip root element
            fhir_components.append({
                "id": eid,
                "short": elem.get("short", ""),
                "definition": elem.get("definition", ""),
                "min": elem.get("min"),
                "max": elem.get("max"),
            })

    # Extract V291 components — nested inside occurrences[].components
    v291_components = []
    occurrences = v291_data.get("occurrences", [])
    if occurrences:
        # Use the first occurrence's components as canonical
        v291_components = occurrences[0].get("components", [])

    return {
        "fhir_component_count": len(fhir_components),
        "v291_component_count": len(v291_components),
        "count_match": len(fhir_components) == len(v291_components),
        "v291_occurrences": len(occurrences),
    }


# ── Message structure comparison ──────────────────────────────────────────

def compare_message_structure_groups(fhir_file, v291_file):
    """Compare message structure segments/groups."""
    fhir_data = load_json(fhir_file)
    v291_data = load_json(v291_file)
    if not fhir_data or not v291_data:
        return None

    fhir_elements = fhir_data.get("differential", {}).get("element", [])
    v291_rows = v291_data.get("parsedStructure", [])

    return {
        "fhir_element_count": len(fhir_elements),
        "v291_row_count": len(v291_rows),
    }


# ── Event comparison ──────────────────────────────────────────────────────

def build_v291_event_details(v291_inv):
    """Build enriched event info from V291 data (message type, structure)."""
    details = {}
    for key, files in v291_inv.items():
        entries = []
        for f in files:
            data = load_json(f)
            if data:
                entries.append({
                    "file": os.path.basename(f),
                    "messageType": data.get("messageType", ""),
                    "structureId": data.get("structureId", ""),
                    "name": data.get("name", ""),
                })
        details[key] = entries
    return details


# ── Main ──────────────────────────────────────────────────────────────────

def run_inventory(output_dir="v291-extracted"):
    """Run the full structural inventory and produce reports."""
    results = {}

    # ── 1. Segments ───────────────────────────────────────────────────────
    print("Analyzing segments...")
    fhir_segs = build_keyed_inventory(
        collect_files(FHIR_PATHS["segments"]), fhir_segment_key
    )
    v291_segs = build_keyed_inventory(
        collect_files(V291_PATHS["segments"]), v291_segment_key
    )
    results["segments"] = compare_inventories(fhir_segs, v291_segs, "Segments")

    # ── 2. Complex Data Types ─────────────────────────────────────────────
    print("Analyzing complex data types...")
    fhir_cdt = build_keyed_inventory(
        collect_files(FHIR_PATHS["complex_data_types"]), fhir_complex_dt_key
    )
    v291_cdt = build_keyed_inventory(
        collect_files(V291_PATHS["complex_data_types"]), v291_complex_dt_key
    )
    results["complex_data_types"] = compare_inventories(
        fhir_cdt, v291_cdt, "Complex Data Types"
    )

    # Component-level comparison for matched data types
    dt_component_diffs = {}
    for key in results["complex_data_types"]["matched_keys"]:
        fhir_file = fhir_cdt[key][0]
        v291_file = v291_cdt[key][0]
        comp = compare_data_type_components(fhir_file, v291_file)
        if comp and not comp["count_match"]:
            dt_component_diffs[key] = comp
    results["complex_data_types"]["component_count_mismatches"] = dt_component_diffs

    # ── 3. Primitive Data Types ───────────────────────────────────────────
    print("Analyzing primitive data types...")
    fhir_pdt = build_keyed_inventory(
        collect_files(FHIR_PATHS["primitive_data_types"]), fhir_key_from_filename
    )
    results["primitive_data_types"] = {
        "artifact_type": "Primitive Data Types",
        "fhir_count": len(fhir_pdt),
        "v291_count": 0,
        "note": "Primitive data types not extracted from V291 Word docs",
        "fhir_keys": sorted(fhir_pdt.keys()),
    }

    # ── 4. Message Structures ─────────────────────────────────────────────
    print("Analyzing message structures...")
    fhir_ms = build_keyed_inventory(
        collect_files(FHIR_PATHS["message_structures"]), fhir_message_structure_key
    )
    v291_ms = build_keyed_inventory(
        collect_files(V291_PATHS["message_structures"]), v291_message_structure_key
    )
    results["message_structures"] = compare_inventories(
        fhir_ms, v291_ms, "Message Structures"
    )

    # Categorize FHIR-only message structures
    fhir_only_ms = results["message_structures"]["fhir_only"]
    ack_variants = [k for k in fhir_only_ms if k.startswith("ACK_")]
    sub_variants = []
    genuinely_missing_ms = []
    for k in fhir_only_ms:
        if k.startswith("ACK_"):
            continue
        parts = k.split("_")
        if len(parts) == 3 and len(parts[2]) <= 2 and parts[2].isalpha():
            sub_variants.append(k)
        else:
            genuinely_missing_ms.append(k)

    # Categorize V291-only: base structures with FHIR sub-variants vs genuinely new
    v291_only_ms = results["message_structures"]["v291_only"]
    base_with_fhir_subvariants = []
    genuinely_v291_only_ms = []
    for k in v291_only_ms:
        if k == "UNKNOWN":
            continue
        # Check if FHIR has sub-variants of this base
        has_subvariants = any(
            fk.startswith(k + "_") and len(fk.split("_")) == len(k.split("_")) + 1
            for fk in fhir_ms.keys()
        )
        if has_subvariants:
            base_with_fhir_subvariants.append(k)
        else:
            genuinely_v291_only_ms.append(k)

    results["message_structures"]["categorization"] = {
        "ack_variants": ack_variants,
        "ack_variant_count": len(ack_variants),
        "sub_variants": sub_variants,
        "sub_variant_count": len(sub_variants),
        "genuinely_missing_from_v291": genuinely_missing_ms,
        "genuinely_missing_count": len(genuinely_missing_ms),
        "base_with_fhir_subvariants": base_with_fhir_subvariants,
        "genuinely_v291_only": genuinely_v291_only_ms,
    }

    # ── 5. Events ─────────────────────────────────────────────────────────
    print("Analyzing events...")
    fhir_ev = build_keyed_inventory(
        collect_files(FHIR_PATHS["events"]), fhir_event_key
    )
    v291_ev = build_keyed_inventory(
        collect_files(V291_PATHS["events"]), v291_event_key
    )
    results["events"] = compare_inventories(fhir_ev, v291_ev, "Events")

    # Enrich V291 events with message type / structure info
    v291_event_details = build_v291_event_details(v291_ev)
    results["events"]["v291_event_details"] = v291_event_details

    # Categorize FHIR-only events by chapter/domain
    fhir_only_ev = results["events"]["fhir_only"]
    event_domains = defaultdict(list)
    domain_map = {
        "A": "CH03-ADT", "B": "CH15-Personnel", "C": "CH07-Observation",
        "E": "CH13-Automation", "I": "CH11-Referral", "J": "CH05-Query",
        "K": "CH05-Query", "M": "CH08-MasterFiles", "N": "CH14-AppMgmt",
        "O": "CH04-OrderEntry", "P": "CH06-Financial",
        "PC": "CH12-PatientCare", "Q": "CH05-Query", "R": "CH07-Observation",
        "S": "CH10-Scheduling", "T": "CH09-DocMgmt", "U": "CH13-Automation",
        "V": "CH04-Pharmacy", "Z": "CH05-Query",
    }
    for ev in fhir_only_ev:
        # Try PC prefix first, then single letter
        prefix = ev[:2] if ev[:2] in domain_map else ev[0]
        domain = domain_map.get(prefix, f"Unknown-{prefix}")
        event_domains[domain].append(ev)

    results["events"]["fhir_only_by_domain"] = {
        k: {"count": len(v), "events": v}
        for k, v in sorted(event_domains.items())
    }

    # ── 6. Messages ───────────────────────────────────────────────────────
    print("Analyzing messages...")
    fhir_msg = build_keyed_inventory(
        collect_files(FHIR_PATHS["messages"]), fhir_message_key
    )
    results["messages"] = {
        "artifact_type": "Messages",
        "fhir_count": len(fhir_msg),
        "v291_count": 0,
        "note": "Messages not extracted from V291 Word docs",
    }

    # ── 7. Vocabulary (V291 only) ─────────────────────────────────────────
    print("Analyzing vocabulary...")
    v291_vocab = collect_files(V291_PATHS["vocabulary"])
    results["vocabulary"] = {
        "artifact_type": "Vocabulary / Value Sets",
        "fhir_count": "N/A (separate comparison)",
        "v291_count": len(v291_vocab),
        "note": "Vocabulary comparison handled separately — see vocabulary-comparison-report",
    }

    # ── Summary ───────────────────────────────────────────────────────────
    summary = {
        "total_fhir_artifacts": sum(
            results[k].get("fhir_count", 0)
            for k in ["segments", "complex_data_types", "primitive_data_types",
                       "message_structures", "events", "messages"]
            if isinstance(results[k].get("fhir_count"), int)
        ),
        "total_v291_artifacts": sum(
            results[k].get("v291_count", 0)
            for k in ["segments", "complex_data_types", "message_structures",
                       "events"]
            if isinstance(results[k].get("v291_count"), int)
        ),
        "comparable_types": ["segments", "complex_data_types",
                             "message_structures", "events"],
        "fhir_only_types": ["primitive_data_types", "messages"],
        "v291_only_types": ["vocabulary", "query_parameters"],
    }
    results["summary"] = summary

    # ── Write reports ─────────────────────────────────────────────────────
    json_path = os.path.join(output_dir, "structural-inventory.json")
    with open(json_path, "w") as f:
        json.dump(results, f, indent=2)
    print(f"\nJSON report: {json_path}")

    md_path = os.path.join(output_dir, "structural-inventory.md")
    write_markdown_report(results, md_path)
    print(f"Markdown report: {md_path}")

    return results


def write_markdown_report(results, output_path):
    """Write a human-readable Markdown gap analysis report."""
    lines = []
    lines.append("# Structural Inventory: FHIR vs V2.9.1")
    lines.append("")
    lines.append("Comprehensive comparison of all artifact types between FHIR "
                 "StructureDefinitions and V2.9.1 Word document extractions.")
    lines.append("")

    # ── Overview table ────────────────────────────────────────────────────
    lines.append("## Overview")
    lines.append("")
    lines.append("| Artifact Type | FHIR | V291 | Matched | FHIR Only | V291 Only |")
    lines.append("|---------------|------|------|---------|-----------|-----------|")

    for key in ["segments", "complex_data_types", "message_structures", "events"]:
        r = results[key]
        lines.append(
            f"| {r['artifact_type']} | {r['fhir_count']} | {r['v291_count']} "
            f"| {r['matched']} | {r['fhir_only_count']} | {r['v291_only_count']} |"
        )

    # Non-comparable types
    for key in ["primitive_data_types", "messages"]:
        r = results[key]
        lines.append(
            f"| {r['artifact_type']} | {r['fhir_count']} | {r['v291_count']} "
            f"| — | — | — |"
        )
    r = results["vocabulary"]
    lines.append(
        f"| {r['artifact_type']} | — | {r['v291_count']} | — | — | — |"
    )
    lines.append("")

    # ── Per-type detail sections ──────────────────────────────────────────
    for key in ["segments", "complex_data_types", "message_structures", "events"]:
        r = results[key]
        lines.append(f"## {r['artifact_type']}")
        lines.append("")
        lines.append(f"**FHIR:** {r['fhir_count']} | **V291:** {r['v291_count']} "
                     f"| **Matched:** {r['matched']}")
        lines.append("")

        if r["fhir_only"]:
            lines.append(f"### In FHIR but not V291 ({r['fhir_only_count']})")
            lines.append("")
            # Group into columns for readability
            items = r["fhir_only"]
            for i in range(0, len(items), 10):
                chunk = items[i:i+10]
                lines.append("`" + "`, `".join(chunk) + "`")
            lines.append("")

        if r["v291_only"]:
            lines.append(f"### In V291 but not FHIR ({r['v291_only_count']})")
            lines.append("")
            items = r["v291_only"]
            for i in range(0, len(items), 10):
                chunk = items[i:i+10]
                lines.append("`" + "`, `".join(chunk) + "`")
            lines.append("")

        if r.get("v291_duplicate_keys"):
            lines.append(f"### V291 duplicates (same key, multiple files)")
            lines.append("")
            for dk, dfiles in sorted(r["v291_duplicate_keys"].items()):
                lines.append(f"- **{dk}**: {', '.join(dfiles)}")
            lines.append("")

        # Data type component mismatches
        if key == "complex_data_types" and r.get("component_count_mismatches"):
            lines.append("### Component count mismatches")
            lines.append("")
            lines.append("| Data Type | FHIR Components | V291 Components |")
            lines.append("|-----------|-----------------|-----------------|")
            for dt, comp in sorted(r["component_count_mismatches"].items()):
                lines.append(
                    f"| {dt} | {comp['fhir_component_count']} "
                    f"| {comp['v291_component_count']} |"
                )
            lines.append("")

        # Message structure categorization
        if key == "message_structures" and r.get("categorization"):
            cat = r["categorization"]
            lines.append("### FHIR-only breakdown")
            lines.append("")
            lines.append(f"The {r['fhir_only_count']} FHIR-only structures "
                        f"break down as:")
            lines.append("")
            lines.append(f"| Category | Count | Explanation |")
            lines.append(f"|----------|-------|-------------|")
            lines.append(f"| ACK variants | {cat['ack_variant_count']} | "
                        f"FHIR creates one ACK structure per event; "
                        f"V291 has a single ACK |")
            lines.append(f"| Sub-variants | {cat['sub_variant_count']} | "
                        f"FHIR splits base structures into lettered "
                        f"sub-variants (e.g. ADT_A01_A/B/C/D) |")
            lines.append(f"| Genuinely missing | {cat['genuinely_missing_count']} | "
                        f"Structures not extracted from V291 Word docs |")
            lines.append("")

            if cat["genuinely_missing_from_v291"]:
                lines.append("**Genuinely missing from V291 extraction:**")
                lines.append("")
                items = cat["genuinely_missing_from_v291"]
                for i in range(0, len(items), 10):
                    chunk = items[i:i+10]
                    lines.append("`" + "`, `".join(chunk) + "`")
                lines.append("")

            if cat.get("genuinely_v291_only"):
                lines.append("**Genuinely in V291 only (not in FHIR at all):**")
                lines.append("")
                for k in cat["genuinely_v291_only"]:
                    lines.append(f"- `{k}`")
                lines.append("")

        lines.append("---")
        lines.append("")

    # ── Event domain breakdown ──────────────────────────────────────────
    if results["events"].get("fhir_only_by_domain"):
        lines.append("## Missing Events by Chapter/Domain")
        lines.append("")
        lines.append("V291 extraction only captured events from chapters 02, "
                     "03, 04A, 06, 11. Events from all other chapters are "
                     "missing. Root cause: extraction regex only matches "
                     "simple event codes, fails on hyphens/commas/ranges.")
        lines.append("")
        lines.append("| Chapter/Domain | Missing Events |")
        lines.append("|----------------|----------------|")
        domains = results["events"]["fhir_only_by_domain"]
        for domain, info in sorted(domains.items()):
            lines.append(f"| {domain} | {info['count']} |")
        lines.append("")

    # ── Event detail (V291 has richer event info) ─────────────────────────
    if results["events"].get("v291_event_details"):
        lines.append("## Event Details (V291)")
        lines.append("")
        lines.append("V291 events include message type and structure mappings. "
                     "Multiple entries per event code indicate different "
                     "message type / structure combinations.")
        lines.append("")
        details = results["events"]["v291_event_details"]
        multi_entry = {k: v for k, v in details.items() if len(v) > 1}
        if multi_entry:
            lines.append(f"### Events with multiple message type mappings "
                        f"({len(multi_entry)})")
            lines.append("")
            for ek in sorted(multi_entry.keys()):
                entries = multi_entry[ek]
                lines.append(f"- **{ek}**: " + ", ".join(
                    f"{e['messageType']}^{ek}^{e['structureId']}"
                    for e in entries
                ))
            lines.append("")

    # ── Notes ─────────────────────────────────────────────────────────────
    lines.append("## Notes")
    lines.append("")
    lines.append("- **Primitive data types** (12) exist only in FHIR — "
                 "not extracted from V291 Word docs")
    lines.append("- **Messages** (696) exist only in FHIR — "
                 "not extracted from V291 Word docs")
    lines.append("- **Vocabulary** (797 tables) extracted from V291 — "
                 "compared separately in vocabulary-comparison-report")
    lines.append("- **Query parameters** (24 files) extracted from V291 — "
                 "no FHIR equivalent yet")
    lines.append("- Matching logic: segments by filename, data types by "
                 "case-insensitive filename, message structures by "
                 "structureId/filename, events by eventCode")
    lines.append("")

    with open(output_path, "w") as f:
        f.write("\n".join(lines))


if __name__ == "__main__":
    output_dir = sys.argv[1] if len(sys.argv) > 1 else "v291-extracted"
    results = run_inventory(output_dir)

    # Print summary to stdout
    print("\n" + "=" * 60)
    print("STRUCTURAL INVENTORY SUMMARY")
    print("=" * 60)
    for key in ["segments", "complex_data_types", "message_structures", "events"]:
        r = results[key]
        print(f"\n{r['artifact_type']}:")
        print(f"  FHIR: {r['fhir_count']}  V291: {r['v291_count']}  "
              f"Matched: {r['matched']}  "
              f"FHIR-only: {r['fhir_only_count']}  "
              f"V291-only: {r['v291_only_count']}")
    print(f"\nPrimitive Data Types: {results['primitive_data_types']['fhir_count']} "
          f"(FHIR only)")
    print(f"Messages: {results['messages']['fhir_count']} (FHIR only)")
    print(f"Vocabulary tables: {results['vocabulary']['v291_count']} (V291 only)")
