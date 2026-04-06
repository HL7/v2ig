#!/usr/bin/env python3
"""
TASK-015: Generate Unresolved Reference Report

Scans AsciiDoc files for patterns that look like V2 construct references
but could not be matched to the construct registry. These are candidates
for manual review by editors.

The report identifies:
1. Segment-field patterns (e.g., FOO-3) not in registry
2. Component patterns (e.g., FOO.1) not in registry
3. Message type patterns (e.g., FOO^B01) not in registry
4. {{v2-table:XXXX:Name}} placeholders (for tracking)

Output: tooling/unresolved_references.md

Usage:
    python3 unresolved_report.py [--verbose]
"""

import json
import re
import sys
from collections import defaultdict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
REGISTRY_FILE = REPO_ROOT / "tooling" / "registry.json"
WEBSITE_DIR = REPO_ROOT / "website"
OUTPUT_FILE = REPO_ROOT / "tooling" / "unresolved_references.md"

# Patterns that look like V2 references but may not be in registry
FIELD_REF = re.compile(r"\b([A-Z][A-Z0-9]{1,2})-(\d{1,3})\b")
COMPONENT_REF = re.compile(r"\b([A-Z]{2,3})\.(\d{1,2})\b")
MESSAGE_REF = re.compile(r"\b([A-Z]{3})\^([A-Z]\d{2})\b")
TABLE_PLACEHOLDER = re.compile(r"\{\{v2-table:(\d+):([^}]+)\}\}")


def main():
    verbose = "--verbose" in sys.argv

    data = json.loads(REGISTRY_FILE.read_text(encoding="utf-8"))
    constructs = data["constructs"]

    # Track unresolved references
    unresolved_fields = defaultdict(list)  # code -> [(file, line)]
    unresolved_components = defaultdict(list)
    unresolved_messages = defaultdict(list)
    table_placeholders = defaultdict(list)

    files_scanned = 0

    for adoc_file in sorted(WEBSITE_DIR.rglob("*.adoc")):
        files_scanned += 1
        content = adoc_file.read_text(encoding="utf-8")
        rel_path = str(adoc_file.relative_to(REPO_ROOT))
        lines = content.split("\n")

        in_block = False
        block_delim = None

        for line_num, line in enumerate(lines, 1):
            stripped = line.strip()

            # Track blocks
            if stripped in ("----", "...."):
                if in_block and stripped == block_delim:
                    in_block = False
                    block_delim = None
                elif not in_block:
                    in_block = True
                    block_delim = stripped
                continue

            if in_block:
                continue

            # Skip non-prose
            if stripped.startswith((":", "//", "[", "include::", "image::", "=")):
                continue
            if re.match(r"^[A-Z]{2,3}\|", stripped):
                continue

            # Check for unresolved field refs
            for m in FIELD_REF.finditer(line):
                code = m.group(0)
                if code not in constructs:
                    unresolved_fields[code].append((rel_path, line_num))

            # Check for unresolved component refs
            for m in COMPONENT_REF.finditer(line):
                code = m.group(0)
                if code not in constructs:
                    unresolved_components[code].append((rel_path, line_num))

            # Check for unresolved message refs
            for m in MESSAGE_REF.finditer(line):
                code = m.group(0)
                if code not in constructs:
                    unresolved_messages[code].append((rel_path, line_num))

            # Track table placeholders
            for m in TABLE_PLACEHOLDER.finditer(line):
                table_num = m.group(1)
                table_name = m.group(2)
                key = f"{table_num}:{table_name}"
                table_placeholders[key].append((rel_path, line_num))

    # Generate report
    report_lines = [
        "# Unresolved V2 Reference Report",
        "",
        f"Scanned {files_scanned} AsciiDoc files in `website/`.",
        f"Registry contains {len(constructs)} constructs.",
        "",
        "## Summary",
        "",
        f"- Unresolved field references: {len(unresolved_fields)} unique codes, "
        f"{sum(len(v) for v in unresolved_fields.values())} occurrences",
        f"- Unresolved component references: {len(unresolved_components)} unique codes, "
        f"{sum(len(v) for v in unresolved_components.values())} occurrences",
        f"- Unresolved message references: {len(unresolved_messages)} unique codes, "
        f"{sum(len(v) for v in unresolved_messages.values())} occurrences",
        f"- V2 table placeholders: {len(table_placeholders)} unique tables, "
        f"{sum(len(v) for v in table_placeholders.values())} occurrences",
        "",
    ]

    if unresolved_fields:
        report_lines.append("## Unresolved Field References")
        report_lines.append("")
        report_lines.append("Patterns matching `SEG-N` format but not found in registry.")
        report_lines.append("")
        report_lines.append("| Code | Occurrences | Sample Location |")
        report_lines.append("|------|-------------|-----------------|")
        for code in sorted(unresolved_fields):
            locs = unresolved_fields[code]
            sample = f"`{locs[0][0]}:{locs[0][1]}`"
            report_lines.append(f"| `{code}` | {len(locs)} | {sample} |")
        report_lines.append("")

    if unresolved_components:
        report_lines.append("## Unresolved Component References")
        report_lines.append("")
        report_lines.append("Patterns matching `TYPE.N` format but not found in registry.")
        report_lines.append("")
        report_lines.append("| Code | Occurrences | Sample Location |")
        report_lines.append("|------|-------------|-----------------|")
        for code in sorted(unresolved_components):
            locs = unresolved_components[code]
            sample = f"`{locs[0][0]}:{locs[0][1]}`"
            report_lines.append(f"| `{code}` | {len(locs)} | {sample} |")
        report_lines.append("")

    if unresolved_messages:
        report_lines.append("## Unresolved Message References")
        report_lines.append("")
        report_lines.append("Patterns matching `XXX^YNN` format but not found in registry.")
        report_lines.append("")
        report_lines.append("| Code | Occurrences | Sample Location |")
        report_lines.append("|------|-------------|-----------------|")
        for code in sorted(unresolved_messages):
            locs = unresolved_messages[code]
            sample = f"`{locs[0][0]}:{locs[0][1]}`"
            report_lines.append(f"| `{code}` | {len(locs)} | {sample} |")
        report_lines.append("")

    if table_placeholders:
        report_lines.append("## V2 Table Placeholders")
        report_lines.append("")
        report_lines.append("These `{{v2-table:XXXX:Name}}` placeholders need resolution to actual URLs.")
        report_lines.append("")
        report_lines.append("| Table | Occurrences | Sample Location |")
        report_lines.append("|-------|-------------|-----------------|")
        for key in sorted(table_placeholders):
            locs = table_placeholders[key]
            sample = f"`{locs[0][0]}:{locs[0][1]}`"
            report_lines.append(f"| `{key}` | {len(locs)} | {sample} |")
        report_lines.append("")

    report = "\n".join(report_lines)
    OUTPUT_FILE.write_text(report, encoding="utf-8")

    print(f"Report written to {OUTPUT_FILE.relative_to(REPO_ROOT)}")
    print(f"\nFiles scanned: {files_scanned}")
    print(f"Unresolved field refs: {len(unresolved_fields)} unique ({sum(len(v) for v in unresolved_fields.values())} total)")
    print(f"Unresolved component refs: {len(unresolved_components)} unique ({sum(len(v) for v in unresolved_components.values())} total)")
    print(f"Unresolved message refs: {len(unresolved_messages)} unique ({sum(len(v) for v in unresolved_messages.values())} total)")
    print(f"V2 table placeholders: {len(table_placeholders)} unique ({sum(len(v) for v in table_placeholders.values())} total)")


if __name__ == "__main__":
    main()
