#!/usr/bin/env python3
"""Compare v291-llm/ (LLM-extracted) against v291-extracted/ (python-docx-extracted)
for the same source chapters.

Phase 1 stretch goal of ADR-0006. Both corpuses target the same JSON schema, so
the diff is row-for-row meaningful. The per-occurrence comparison classifies each
disagreement into a small set of buckets so we can see at a glance whether the
LLM corpus has a bias (e.g., always strips bracket whitespace, always preserves
description suffixes that python-docx drops, etc.).

Scope: message structures and segments. Both sections are produced in a single
report file with separate bucket counts.

Usage:
    python3 tooling/scripts/compare_python_vs_llm.py
    python3 tooling/scripts/compare_python_vs_llm.py --limit 10  # detailed diffs to show
    python3 tooling/scripts/compare_python_vs_llm.py --filter ADT  # only IDs starting with ADT
"""

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
LLM_MSG_DIR = PROJECT_ROOT / "v291-llm" / "message-structures"
LLM_SEG_DIR = PROJECT_ROOT / "v291-llm" / "segments"
PYDOCX_MSG_DIR = PROJECT_ROOT / "v291-extracted" / "message-structures"
PYDOCX_SEG_DIR = PROJECT_ROOT / "v291-extracted" / "segments"
REPORT_PATH = PROJECT_ROOT / "v291-llm" / "comparison-report.md"

SEGMENT_FIELD_ATTRS = (
    "sequence", "length", "confLength", "dataType",
    "optionality", "repetition", "tableBinding", "itemNumber", "name",
)


def load_json(path):
    return json.loads(path.read_text())


# ---------------------------------------------------------------------------
# Message structures
# ---------------------------------------------------------------------------


def is_pydocx_group_marker(elem):
    """python-docx misencodes group begin/end as type:'segment' with empty
    or '}]' code. Recognize so we can normalize for comparison.

    Group descriptions follow the '--- NAME begin'/'--- NAME end' convention.
    A substring match on 'begin'/'end' is unsafe — 'Gender' contains 'end'.
    """
    if elem.get("type") != "segment":
        return False
    code = elem.get("code", "")
    desc = elem.get("description", "")
    return code in ("", "}]") or desc.startswith("--- ")


def normalize_parsed(elements, source):
    """Return a list of comparable elements. Strip group markers (different
    encodings between corpuses) and lower-case-trim descriptions."""
    out = []
    for e in elements:
        if source == "pydocx" and is_pydocx_group_marker(e):
            continue
        if source == "llm" and e.get("type") in ("group_begin", "group_end"):
            continue
        out.append({
            "code": e.get("code", "").strip(),
            "description": e.get("description", "").strip(),
            "optionality": e.get("optionality", "").strip(),
            "repetition": bool(e.get("repetition", False)),
            "chapter": str(e.get("chapter", "")).strip(),
        })
    return out


def normalize_raw(rows):
    """Source-faithful row comparison — preserve everything except trailing whitespace."""
    return [
        {
            "segments": (r.get("segments") or "").strip(),
            "description": (r.get("description") or "").strip(),
            "status": (r.get("status") or "").strip(),
            "chapter": str(r.get("chapter") or "").strip(),
        }
        for r in rows
    ]


def diff_lists(a, b, key="row"):
    """Return list of (index, a_val, b_val) for differing positions; flag length mismatch."""
    diffs = []
    if len(a) != len(b):
        diffs.append({"kind": "length", "py_len": len(a), "llm_len": len(b)})
    for i in range(min(len(a), len(b))):
        if a[i] != b[i]:
            diffs.append({"kind": key, "index": i, "py": a[i], "llm": b[i]})
    return diffs


def compare_message_structure(py_path, llm_path):
    py = load_json(py_path)
    llm = load_json(llm_path)

    findings = {
        "filename": py_path.name,
        "structureId_match": py.get("structureId") == llm.get("structureId"),
        "caption_match": (py.get("caption") or "") == (llm.get("caption") or ""),
        "py_clause": py.get("provenance", {}).get("clause", ""),
        "llm_clause": llm.get("provenance", {}).get("clause", ""),
        "py_tableIndex": py.get("provenance", {}).get("tableIndex"),
        "llm_tableIndex": llm.get("provenance", {}).get("tableIndex"),
    }

    py_raw = normalize_raw(py.get("rawRows", []))
    llm_raw = normalize_raw(llm.get("rawRows", []))
    findings["raw_diffs"] = diff_lists(py_raw, llm_raw, key="raw_row")

    py_parsed = normalize_parsed(py.get("parsedStructure", []), "pydocx")
    llm_parsed = normalize_parsed(llm.get("parsedStructure", []), "llm")
    findings["parsed_diffs"] = diff_lists(py_parsed, llm_parsed, key="parsed_element")

    return findings


def index_message_corpus(directory):
    """Join by (structureId, clause, tableIndex) per file. python-docx names files
    by enumerate() index while LLM names by tableIndex — filenames diverge even
    when the underlying table is identical, so go by provenance."""
    idx = {}
    for p in directory.glob("*.json"):
        doc = load_json(p)
        key = (
            doc.get("structureId", ""),
            doc.get("provenance", {}).get("clause", ""),
            doc.get("provenance", {}).get("tableIndex"),
        )
        idx[key] = p
    return idx


def bucket_message_findings(findings_list):
    bucket = Counter()
    raw_kinds = Counter()
    parsed_kinds = Counter()
    for f in findings_list:
        if not f["raw_diffs"] and not f["parsed_diffs"] and f["structureId_match"] and f["caption_match"]:
            bucket["fully_agree"] += 1
        elif not f["raw_diffs"] and not f["parsed_diffs"]:
            bucket["agree_with_metadata_diff"] += 1
        elif not f["parsed_diffs"]:
            bucket["disagree_raw_only"] += 1
        elif not f["raw_diffs"]:
            bucket["disagree_parsed_only"] += 1
        else:
            bucket["disagree_both"] += 1
        for d in f["raw_diffs"]:
            raw_kinds[d["kind"]] += 1
        for d in f["parsed_diffs"]:
            parsed_kinds[d["kind"]] += 1
    return bucket, raw_kinds, parsed_kinds


# ---------------------------------------------------------------------------
# Segments
# ---------------------------------------------------------------------------


def normalize_segment_field(f):
    """All 9 schema attributes as stripped strings."""
    return {a: (f.get(a) or "").strip() for a in SEGMENT_FIELD_ATTRS}


def index_segment_corpus(directory):
    """Flatten per-file occurrences into a {(code, clause, tableIndex): [occurrences]} dict.

    Returns a value list (not a single occurrence) so duplicate provenance keys
    can be surfaced separately rather than silently overwriting each other.
    """
    idx = defaultdict(list)
    for p in directory.glob("*.json"):
        doc = load_json(p)
        code = doc.get("code", p.stem)
        for occ in doc.get("occurrences", []):
            prov = occ.get("provenance", {})
            key = (code, prov.get("clause", ""), prov.get("tableIndex"))
            idx[key].append(occ)
    return dict(idx)


def compare_segment_occurrence(code, py_occ, llm_occ):
    findings = {
        "code": code,
        "py_clause": py_occ.get("provenance", {}).get("clause", ""),
        "llm_clause": llm_occ.get("provenance", {}).get("clause", ""),
        "py_tableIndex": py_occ.get("provenance", {}).get("tableIndex"),
        "llm_tableIndex": llm_occ.get("provenance", {}).get("tableIndex"),
        "name_match": (py_occ.get("name") or "") == (llm_occ.get("name") or ""),
        "section_heading_match":
            (py_occ.get("provenance", {}).get("sectionHeading") or "") ==
            (llm_occ.get("provenance", {}).get("sectionHeading") or ""),
    }
    py_fields = [normalize_segment_field(f) for f in py_occ.get("fields", [])]
    llm_fields = [normalize_segment_field(f) for f in llm_occ.get("fields", [])]
    findings["field_diffs"] = diff_lists(py_fields, llm_fields, key="field")
    return findings


def bucket_segment_findings(findings_list):
    bucket = Counter()
    field_kinds = Counter()
    for f in findings_list:
        if not f["field_diffs"] and f["name_match"] and f["section_heading_match"]:
            bucket["fully_agree"] += 1
        elif not f["field_diffs"]:
            bucket["agree_with_metadata_diff"] += 1
        else:
            bucket["disagree_fields"] += 1
        for d in f["field_diffs"]:
            field_kinds[d["kind"]] += 1
    return bucket, field_kinds


# ---------------------------------------------------------------------------
# Report rendering
# ---------------------------------------------------------------------------


def fmt_msg_key(k):
    return f"{k[0]} clause={k[1]} tableIndex={k[2]}"


def fmt_seg_key(k):
    return f"{k[0]} clause={k[1]} tableIndex={k[2]}"


def render_message_section(common, llm_only, py_only, findings_list, limit, lines):
    bucket, raw_kinds, parsed_kinds = bucket_message_findings(findings_list)

    lines.append("## Message structures")
    lines.append("")
    lines.append(f"- Common (extracted in both corpuses): {len(common)}")
    lines.append(f"- LLM-only: {len(llm_only)}")
    lines.append(f"- python-docx-only: {len(py_only)}")
    lines.append("")
    lines.append("| Bucket | Count |")
    lines.append("|--------|------:|")
    for k in ("fully_agree", "agree_with_metadata_diff", "disagree_raw_only", "disagree_parsed_only", "disagree_both"):
        lines.append(f"| {k} | {bucket.get(k, 0)} |")
    lines.append("")
    lines.append(f"Raw-row disagreement kinds: {dict(raw_kinds)}")
    lines.append(f"Parsed-element disagreement kinds: {dict(parsed_kinds)}")

    if llm_only:
        lines.append("")
        lines.append("### LLM-only message structures (first 30)")
        for k in sorted(llm_only)[:30]:
            lines.append(f"- {fmt_msg_key(k)}")
    if py_only:
        lines.append("")
        lines.append("### python-docx-only message structures (first 30)")
        for k in sorted(py_only)[:30]:
            lines.append(f"- {fmt_msg_key(k)}")

    detailed = [f for f in findings_list if f["raw_diffs"] or f["parsed_diffs"]][:limit]
    if detailed:
        lines.append("")
        lines.append(f"### Detailed disagreements (first {len(detailed)})")
        for f in detailed:
            lines.append("")
            lines.append(f"#### {f['filename']}")
            lines.append(f"- structureId match: {f['structureId_match']}")
            lines.append(f"- caption match: {f['caption_match']}")
            lines.append(f"- clause: pydocx={f['py_clause']!r}, llm={f['llm_clause']!r}")
            lines.append(f"- tableIndex: pydocx={f['py_tableIndex']}, llm={f['llm_tableIndex']}")
            if f["raw_diffs"]:
                lines.append(f"- Raw-row diffs ({len(f['raw_diffs'])}):")
                for d in f["raw_diffs"][:6]:
                    if d["kind"] == "length":
                        lines.append(f"  - LENGTH: pydocx={d['py_len']}, llm={d['llm_len']}")
                    else:
                        lines.append(f"  - row {d['index']}: pydocx={d['py']} → llm={d['llm']}")
            if f["parsed_diffs"]:
                lines.append(f"- Parsed-element diffs ({len(f['parsed_diffs'])}):")
                for d in f["parsed_diffs"][:6]:
                    if d["kind"] == "length":
                        lines.append(f"  - LENGTH: pydocx={d['py_len']}, llm={d['llm_len']}")
                    else:
                        lines.append(f"  - elem {d['index']}: pydocx={d['py']} → llm={d['llm']}")

    return bucket


def render_segment_section(
    common_keys, llm_only_keys, py_only_keys,
    findings_list, llm_duplicates, py_duplicates, limit, lines,
):
    bucket, field_kinds = bucket_segment_findings(findings_list)

    lines.append("")
    lines.append("## Segments")
    lines.append("")
    lines.append(f"- Common occurrence keys: {len(common_keys)}")
    lines.append(f"- LLM-only: {len(llm_only_keys)}")
    lines.append(f"- python-docx-only: {len(py_only_keys)}")
    lines.append("")
    lines.append("| Bucket | Count |")
    lines.append("|--------|------:|")
    for k in ("fully_agree", "agree_with_metadata_diff", "disagree_fields"):
        lines.append(f"| {k} | {bucket.get(k, 0)} |")
    lines.append("")
    lines.append(f"Field disagreement kinds: {dict(field_kinds)}")

    if llm_duplicates or py_duplicates:
        lines.append("")
        lines.append("### Duplicate provenance keys")
        lines.append("")
        lines.append(
            "More than one occurrence in the same corpus shares the same "
            "(code, clause, tableIndex). The comparison uses the first occurrence "
            "for each key; the extras are not compared. Most likely cause on the "
            "LLM side: extract_v291_llm.py's flush_segment_registry appends to "
            "existing files on each run."
        )
        if llm_duplicates:
            lines.append("")
            lines.append(f"LLM duplicates ({len(llm_duplicates)}):")
            for k, n in sorted(llm_duplicates.items()):
                lines.append(f"- {fmt_seg_key(k)}: {n} occurrences")
        if py_duplicates:
            lines.append("")
            lines.append(f"python-docx duplicates ({len(py_duplicates)}):")
            for k, n in sorted(py_duplicates.items()):
                lines.append(f"- {fmt_seg_key(k)}: {n} occurrences")

    if llm_only_keys:
        lines.append("")
        lines.append("### LLM-only segment occurrences (first 30)")
        for k in sorted(llm_only_keys)[:30]:
            lines.append(f"- {fmt_seg_key(k)}")
    if py_only_keys:
        lines.append("")
        lines.append("### python-docx-only segment occurrences (first 30)")
        for k in sorted(py_only_keys)[:30]:
            lines.append(f"- {fmt_seg_key(k)}")

    detailed = [f for f in findings_list if f["field_diffs"]][:limit]
    if detailed:
        lines.append("")
        lines.append(f"### Detailed segment disagreements (first {len(detailed)})")
        for f in detailed:
            lines.append("")
            lines.append(f"#### {f['code']} clause={f['py_clause']} tableIndex={f['py_tableIndex']}")
            lines.append(f"- name match: {f['name_match']}")
            lines.append(f"- section heading match: {f['section_heading_match']}")
            lines.append(f"- Field diffs ({len(f['field_diffs'])}):")
            for d in f["field_diffs"][:6]:
                if d["kind"] == "length":
                    lines.append(f"  - LENGTH: pydocx={d['py_len']}, llm={d['llm_len']}")
                else:
                    lines.append(f"  - field {d['index']}: pydocx={d['py']} → llm={d['llm']}")

    return bucket


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def run_message_comparison(filter_prefix):
    if not LLM_MSG_DIR.exists():
        return None
    llm_index = index_message_corpus(LLM_MSG_DIR)
    py_index = index_message_corpus(PYDOCX_MSG_DIR)

    if filter_prefix:
        llm_index = {k: p for k, p in llm_index.items() if k[0].startswith(filter_prefix)}
        py_index = {k: p for k, p in py_index.items() if k[0].startswith(filter_prefix)}

    common = set(llm_index) & set(py_index)
    llm_only = set(llm_index) - set(py_index)
    py_only = set(py_index) - set(llm_index)

    findings_list = [
        compare_message_structure(py_index[key], llm_index[key])
        for key in sorted(common)
    ]
    return common, llm_only, py_only, findings_list


def run_segment_comparison(filter_prefix):
    if not LLM_SEG_DIR.exists():
        return None
    llm_index = index_segment_corpus(LLM_SEG_DIR)
    py_index = index_segment_corpus(PYDOCX_SEG_DIR)

    if filter_prefix:
        llm_index = {k: v for k, v in llm_index.items() if k[0].startswith(filter_prefix)}
        py_index = {k: v for k, v in py_index.items() if k[0].startswith(filter_prefix)}

    llm_duplicates = {k: len(v) for k, v in llm_index.items() if len(v) > 1}
    py_duplicates = {k: len(v) for k, v in py_index.items() if len(v) > 1}

    common = set(llm_index) & set(py_index)
    llm_only = set(llm_index) - set(py_index)
    py_only = set(py_index) - set(llm_index)

    # Compare the first occurrence on each side; extras are surfaced via the
    # duplicates section so silent loss doesn't happen.
    findings_list = [
        compare_segment_occurrence(key[0], py_index[key][0], llm_index[key][0])
        for key in sorted(common)
    ]
    return common, llm_only, py_only, findings_list, llm_duplicates, py_duplicates


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--limit", type=int, default=20, help="Max detailed diffs to show per section")
    parser.add_argument("--filter", default=None,
                        help="Only consider IDs starting with this prefix "
                             "(matches structureId for message structures, code for segments)")
    args = parser.parse_args()

    lines = ["# python-docx vs LLM extraction — comparison report", ""]

    msg_summary = None
    seg_summary = None

    msg_result = run_message_comparison(args.filter)
    if msg_result is None:
        lines.append("_(message-structure LLM corpus not present — skipping)_\n")
    else:
        common, llm_only, py_only, findings_list = msg_result
        msg_summary = render_message_section(common, llm_only, py_only, findings_list, args.limit, lines)

    seg_result = run_segment_comparison(args.filter)
    if seg_result is None:
        lines.append("\n_(segment LLM corpus not present — skipping)_\n")
    else:
        common, llm_only, py_only, findings_list, llm_dups, py_dups = seg_result
        seg_summary = render_segment_section(
            common, llm_only, py_only, findings_list, llm_dups, py_dups, args.limit, lines,
        )

    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text("\n".join(lines) + "\n")

    print(f"Report: {REPORT_PATH}")
    if msg_result is not None:
        common, llm_only, py_only, _ = msg_result
        print(f"Message structures — common: {len(common)}, LLM-only: {len(llm_only)}, pydocx-only: {len(py_only)}")
        for k, v in sorted((msg_summary or {}).items()):
            print(f"  {k}: {v}")
    if seg_result is not None:
        common, llm_only, py_only, _, llm_dups, py_dups = seg_result
        print(f"Segments — common: {len(common)}, LLM-only: {len(llm_only)}, pydocx-only: {len(py_only)}")
        for k, v in sorted((seg_summary or {}).items()):
            print(f"  {k}: {v}")
        if llm_dups or py_dups:
            print(f"  duplicate provenance keys — LLM: {len(llm_dups)}, pydocx: {len(py_dups)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
