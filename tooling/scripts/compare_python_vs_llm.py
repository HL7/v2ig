#!/usr/bin/env python3
"""Compare v291-llm/ (LLM-extracted) against v291-extracted/ (python-docx-extracted)
for the same source chapters.

Phase 1 stretch goal of ADR-0006. Both corpuses target the same JSON schema, so
the diff is row-for-row meaningful. The per-file comparison classifies each
disagreement into a small set of buckets so we can see at a glance whether the
LLM corpus has a bias (e.g., always strips bracket whitespace, always preserves
description suffixes that python-docx drops, etc.).

Scope: message structures only. Segments will be added in Phase 2.

Usage:
    python3 tooling/scripts/compare_python_vs_llm.py
    python3 tooling/scripts/compare_python_vs_llm.py --limit 10  # show first 10 detailed diffs
    python3 tooling/scripts/compare_python_vs_llm.py --filter ADT  # only ADT_*
"""

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
LLM_DIR = PROJECT_ROOT / "v291-llm" / "message-structures"
PYDOCX_DIR = PROJECT_ROOT / "v291-extracted" / "message-structures"
REPORT_PATH = PROJECT_ROOT / "v291-llm" / "comparison-report.md"


def load_json(path):
    return json.loads(path.read_text())


def is_pydocx_group_marker(elem):
    """python-docx misencodes group begin/end as type:'segment' with empty
    or '}]' code. Recognize so we can normalize for comparison."""
    return elem.get("type") == "segment" and (
        elem.get("code", "") in ("", "}]")
        or "begin" in elem.get("description", "")
        or "end" in elem.get("description", "")
    )


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


def compare_one(py_path, llm_path):
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


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--limit", type=int, default=20, help="Max detailed diffs to show in report")
    parser.add_argument("--filter", default=None, help="Only consider files starting with this prefix")
    args = parser.parse_args()

    if not LLM_DIR.exists():
        print(f"ERROR: {LLM_DIR} does not exist — run extract_v291_llm.py first", file=sys.stderr)
        return 2

    llm_files = {p.name: p for p in LLM_DIR.glob("*.json")}
    py_files = {p.name: p for p in PYDOCX_DIR.glob("*.json")}

    if args.filter:
        llm_files = {n: p for n, p in llm_files.items() if n.startswith(args.filter)}
        py_files = {n: p for n, p in py_files.items() if n.startswith(args.filter)}

    common = set(llm_files) & set(py_files)
    llm_only = set(llm_files) - set(py_files)
    py_only = set(py_files) - set(llm_files)

    findings_list = []
    for name in sorted(common):
        findings_list.append(compare_one(py_files[name], llm_files[name]))

    bucket = Counter()
    raw_disagreement_kinds = Counter()
    parsed_disagreement_kinds = Counter()
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
            raw_disagreement_kinds[d["kind"]] += 1
        for d in f["parsed_diffs"]:
            parsed_disagreement_kinds[d["kind"]] += 1

    lines = []
    lines.append("# python-docx vs LLM extraction — comparison report")
    lines.append("")
    lines.append(f"- Common files (extracted in both corpuses): {len(common)}")
    lines.append(f"- LLM-only (the LLM extracted; python-docx didn't): {len(llm_only)}")
    lines.append(f"- python-docx-only (python-docx extracted; LLM didn't): {len(py_only)}")
    lines.append("")
    lines.append("## Bucket counts")
    lines.append("")
    lines.append("| Bucket | Count |")
    lines.append("|--------|------:|")
    for k in ("fully_agree", "agree_with_metadata_diff", "disagree_raw_only", "disagree_parsed_only", "disagree_both"):
        lines.append(f"| {k} | {bucket.get(k, 0)} |")
    lines.append("")
    lines.append(f"## Raw-row disagreement kinds: {dict(raw_disagreement_kinds)}")
    lines.append(f"## Parsed-element disagreement kinds: {dict(parsed_disagreement_kinds)}")

    if llm_only:
        lines.append("")
        lines.append(f"## LLM-only files (first 30)")
        for n in sorted(llm_only)[:30]:
            lines.append(f"- {n}")

    if py_only:
        lines.append("")
        lines.append(f"## python-docx-only files (first 30)")
        for n in sorted(py_only)[:30]:
            lines.append(f"- {n}")

    # Detailed diffs for first N disagreeing files
    detailed = [f for f in findings_list if f["raw_diffs"] or f["parsed_diffs"]][: args.limit]
    if detailed:
        lines.append("")
        lines.append(f"## Detailed disagreements (first {len(detailed)})")
        for f in detailed:
            lines.append("")
            lines.append(f"### {f['filename']}")
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

    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text("\n".join(lines) + "\n")

    print(f"Report: {REPORT_PATH}")
    print(f"Common: {len(common)}, LLM-only: {len(llm_only)}, pydocx-only: {len(py_only)}")
    for k, v in sorted(bucket.items()):
        print(f"  {k}: {v}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
