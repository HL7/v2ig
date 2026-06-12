#!/usr/bin/env python3
"""Neutral three-way structural comparison of V2.9.1 segments and data types.

Compares the same structures as represented by THREE independent extraction /
encoding methodologies, treated as PEERS:

  1. python-docx  -- rule-based table parsing      (v291-extracted/)
  2. LLM          -- Claude-mediated extraction     (v291-llm/)
  3. FHIR         -- the published StructureDefinitions
                     (input/sourceOfTruth/)

Design principle (per project guidance, 2026-06-10):
  No methodology is treated as the authority over the others. The report does
  NOT say "source X is wrong"; it reports the agreement CONFIGURATION per
  element and flags disagreements for adjudication against the source .docx.
  Leaning on one methodology's expectation to "correct" another risks baking a
  second methodology's error into the first.

  When two sources agree and one differs, that is reported as a "2-vs-1 split"
  naming the outlier as the one to *examine against source* -- not as the one
  that is wrong. When all three differ, it is a "three-way split".

Scope: segment fields and complex data-type components -- the element-level
structural attributes that all three sources represent comparably. Message
structures are compared pydocx-vs-LLM by compare_python_vs_llm.py and
FHIR-vs-V291 by compare_message_structures.py; folding the FHIR message-tree
representation into this element-grain view is a separate follow-up.

Compared dimensions (per element):
  data_type, optionality, name, length, conf_length, item/table binding.

Usage:
    python3 tooling/scripts/compare_three_way.py
    python3 tooling/scripts/compare_three_way.py --subset PID,CWE,XPN
    python3 tooling/scripts/compare_three_way.py --kind segments
    python3 tooling/scripts/compare_three_way.py --kind data-types
"""

import argparse
import json
import os
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from compare_segments import (
    extract_fhir_fields,
    parse_v291_length,
    parse_v291_conf_length,
    extract_v291_table_number,
)
from compare_data_types import (
    extract_fhir_components,
)
from v2_utils import PROJECT_ROOT, SEGMENTS_DIR

PROJECT_ROOT = Path(PROJECT_ROOT)

# Corpus locations -----------------------------------------------------------
PYDOCX_SEG_DIR = PROJECT_ROOT / "v291-extracted" / "segments"
LLM_SEG_DIR = PROJECT_ROOT / "v291-llm" / "segments"
FHIR_SEG_DIR = Path(SEGMENTS_DIR)

PYDOCX_DT_DIR = PROJECT_ROOT / "v291-extracted" / "data-types" / "complex"
LLM_DT_DIR = PROJECT_ROOT / "v291-llm" / "data-types" / "complex"
FHIR_DT_DIR = (PROJECT_ROOT / "input" / "sourceOfTruth" / "data-type" /
               "complex" / "complex-data-types")

REPORT_PATH = PROJECT_ROOT / "v291-llm" / "three-way-comparison-report.md"

SOURCES = ("pydocx", "llm", "fhir")


# ---------------------------------------------------------------------------
# Normalization helpers
# ---------------------------------------------------------------------------
# Each dimension has a normalizer so that trivial formatting differences (case,
# whitespace, equivalent length encodings) don't masquerade as disagreements.
# The normalizers are applied UNIFORMLY to all three sources -- we are not
# privileging any one source's format.

def norm_text(s):
    """Lower-case, collapse internal whitespace, strip. For names/descriptions."""
    if s is None:
        return ""
    return re.sub(r"\s+", " ", str(s)).strip().lower()


def norm_code(s):
    """Upper-case, strip. For data-type codes (ST, CWE, ...)."""
    if s is None:
        return ""
    return str(s).strip().upper()


def norm_opt(s):
    """Optionality code, upper-cased and stripped (R/O/C/B/W/X/'')."""
    if s is None:
        return ""
    return str(s).strip().upper()


def norm_binding(s):
    """Normalize an item/table number for comparison.

    The 'binding' dimension holds a segment field's item number (e.g. "00104")
    or a data-type component's table number (e.g. "0125"). Sources differ only
    in zero-padding: FHIR strips leading zeros ("104"), the V2.9.1 corpuses keep
    them ("00104"). These are the SAME identifier. Compare by integer value when
    both are purely numeric; otherwise fall back to stripped text. Empty stays
    empty (distinct from "0").
    """
    if s is None:
        return ""
    t = str(s).strip()
    if t == "":
        return ""
    if t.isdigit():
        return str(int(t))
    return t


def norm_length(min_v, max_v):
    """Canonical 'min..max' length string from a (min, max) pair.

    Accepts None for an unbounded/absent end. Returns '' when both absent.
    """
    if min_v is None and max_v is None:
        return ""
    lo = "" if min_v is None else str(min_v)
    hi = "" if max_v is None else str(max_v)
    if lo and hi:
        return f"{lo}..{hi}"
    return hi or lo


# ---------------------------------------------------------------------------
# Per-source element extraction -> uniform shape
# ---------------------------------------------------------------------------
# Every extractor returns: dict keyed by sequence-number string, each value a
# dict with the SAME normalized keys:
#   name, data_type, optionality, length, conf_length, binding
# so the three are directly comparable. 'binding' is item_number for segment
# fields (the stable per-field identifier) and the table number for data-type
# components (their stable vocabulary anchor) -- whichever the source provides.

def _v291_fields_to_uniform(occurrence):
    """python-docx / LLM segment occurrence -> uniform field dict.

    pydocx and LLM share the identical occurrences[].fields[] schema, so one
    converter serves both.
    """
    out = {}
    for f in occurrence.get("fields", []):
        seq = str(f.get("sequence", "")).strip()
        if not seq.isdigit():
            continue
        lo, hi = parse_v291_length(f.get("length", ""))
        cl, _ = parse_v291_conf_length(f.get("confLength", ""))
        out[seq] = {
            "name": f.get("name", ""),
            "data_type": f.get("dataType", ""),
            "optionality": f.get("optionality", ""),
            "length": norm_length(lo, hi),
            "conf_length": "" if cl is None else str(cl),
            "binding": str(f.get("itemNumber", "")).strip(),
        }
    return out


def _fhir_fields_to_uniform(fhir_data):
    """FHIR segment SD -> uniform field dict (via existing extract_fhir_fields)."""
    out = {}
    for seq, fld in extract_fhir_fields(fhir_data).items():
        if not str(seq).isdigit():
            continue
        out[seq] = {
            "name": fld.get("name", ""),
            "data_type": fld.get("data_type", ""),
            "optionality": fld.get("optionality", ""),
            "length": norm_length(fld.get("length_min"), fld.get("length_max")),
            "conf_length": ("" if fld.get("conf_length") is None
                            else str(fld.get("conf_length"))),
            "binding": str(fld.get("item_num", "")).strip(),
        }
    return out


def _v291_components_to_uniform(occurrence):
    """python-docx / LLM data-type occurrence -> uniform component dict."""
    out = {}
    for c in occurrence.get("components", []):
        seq = str(c.get("sequence", "")).strip()
        if not seq.isdigit():
            continue
        lo, hi = parse_v291_length(c.get("length", ""))
        cl, _ = parse_v291_conf_length(c.get("confLength", ""))
        out[seq] = {
            "name": c.get("name", ""),
            "data_type": c.get("dataType", ""),
            "optionality": c.get("optionality", ""),
            "length": norm_length(lo, hi),
            "conf_length": "" if cl is None else str(cl),
            "binding": extract_v291_table_number(c.get("tableBinding", "")),
        }
    return out


def _fhir_components_to_uniform(fhir_data):
    """FHIR data-type SD -> uniform component dict (via extract_fhir_components)."""
    out = {}
    for seq, comp in extract_fhir_components(fhir_data).items():
        if not str(seq).isdigit():
            continue
        out[seq] = {
            "name": comp.get("name", ""),
            "data_type": comp.get("data_type", ""),
            "optionality": comp.get("optionality", ""),
            "length": norm_length(comp.get("length_min"), comp.get("length_max")),
            "conf_length": ("" if comp.get("conf_length") is None
                            else str(comp.get("conf_length"))),
            "binding": str(comp.get("vocabulary_table", "")).strip(),
        }
    return out


# ---------------------------------------------------------------------------
# Corpus loading
# ---------------------------------------------------------------------------

def _load_v291_occurrence_corpus(directory, to_uniform):
    """Load a pydocx/LLM corpus dir -> {code: uniform_element_dict}.

    Uses the first occurrence of each structure (the corpuses index multiple
    occurrences; the first is representative for structural attributes).
    """
    corpus = {}
    if not directory.is_dir():
        return corpus
    for path in sorted(directory.glob("*.json")):
        data = json.loads(path.read_text())
        code = data.get("code", path.stem)
        occurrences = data.get("occurrences", [])
        if not occurrences:
            continue
        corpus[code] = to_uniform(occurrences[0])
    return corpus


def _load_fhir_corpus(directory, to_uniform):
    """Load a FHIR SD dir -> {code: uniform_element_dict}."""
    corpus = {}
    if not directory.is_dir():
        return corpus
    for path in sorted(directory.glob("*.json")):
        data = json.loads(path.read_text())
        # The structure's code. FHIR 'type' is the bare code for segments
        # (e.g. "PID") but a full URL for data types
        # (e.g. ".../StructureDefinition/AD"). 'id' is the bare code in both
        # cases, so prefer it; fall back to the URL's last path segment.
        code = data.get("id")
        if not code:
            type_val = data.get("type", "")
            code = type_val.rsplit("/", 1)[-1] if type_val else path.stem
        corpus[code] = to_uniform(data)
    return corpus


# ---------------------------------------------------------------------------
# Three-way classification
# ---------------------------------------------------------------------------

DIMENSIONS = ("name", "data_type", "optionality", "length", "conf_length", "binding")

# Per-dimension normalizer applied uniformly across all three sources.
NORMALIZERS = {
    "name": norm_text,
    "data_type": norm_code,
    "optionality": norm_opt,
    "length": lambda s: str(s).strip(),
    "conf_length": lambda s: str(s).strip(),
    "binding": norm_binding,
}


def classify_element(per_source_elem, dimension):
    """For a given dimension, classify across whichever sources have this element.

    per_source_elem: {source: uniform_elem_dict_or_None}
    Returns dict:
      {present: [sources], state, values: {source: raw}, norm: {source: norm},
       outlier: source_or_None, groups: {norm_value: [sources]}}
    """
    normf = NORMALIZERS[dimension]
    present = [s for s in SOURCES if per_source_elem.get(s) is not None]
    raw = {s: per_source_elem[s].get(dimension, "") for s in present}
    norm = {s: normf(raw[s]) for s in present}

    groups = defaultdict(list)
    for s in present:
        groups[norm[s]].append(s)

    if len(present) < 2:
        state = "n/a"
        outlier = None
    elif len(groups) == 1:
        state = "agree"
        outlier = None
    elif len(present) == 3 and len(groups) == 3:
        state = "split_3"
        outlier = None
    elif len(present) == 3 and len(groups) == 2:
        state = "split_2_1"
        # outlier = the source in the singleton group
        outlier = next(s for vals in groups.values() if len(vals) == 1 for s in vals)
    else:
        # exactly 2 present and they differ
        state = "split_2"
        outlier = None

    return {
        "present": present,
        "state": state,
        "values": raw,
        "norm": norm,
        "outlier": outlier,
        "groups": {k: v for k, v in groups.items()},
    }


# ---------------------------------------------------------------------------
# Comparison driver
# ---------------------------------------------------------------------------

def compare_corpus(pydocx, llm, fhir, subset=None):
    """Compare three {code: {seq: uniform_elem}} corpuses.

    Returns a results structure with per-structure, per-element, per-dimension
    classification plus aggregate counters.
    """
    all_codes = set(pydocx) | set(llm) | set(fhir)
    if subset:
        subset_up = {c.upper() for c in subset}
        all_codes = {c for c in all_codes if c.upper() in subset_up}

    results = {
        "structures": {},
        "structure_coverage": Counter(),   # how many sources have each structure
        "dimension_states": defaultdict(Counter),  # dim -> state -> count
        "element_coverage": Counter(),     # how many sources have each element
        "splits": [],                      # list of split findings for the report
    }

    for code in sorted(all_codes):
        src_structs = {
            "pydocx": pydocx.get(code),
            "llm": llm.get(code),
            "fhir": fhir.get(code),
        }
        present_sources = [s for s in SOURCES if src_structs[s] is not None]
        results["structure_coverage"][len(present_sources)] += 1

        all_seqs = set()
        for s in present_sources:
            all_seqs |= set(src_structs[s].keys())

        struct_record = {
            "present_sources": present_sources,
            "elements": {},
        }

        for seq in sorted(all_seqs, key=lambda x: int(x)):
            per_source_elem = {
                s: (src_structs[s].get(seq) if src_structs[s] else None)
                for s in SOURCES
            }
            elem_present = [s for s in SOURCES if per_source_elem[s] is not None]
            results["element_coverage"][len(elem_present)] += 1

            elem_record = {"present": elem_present, "dims": {}}
            for dim in DIMENSIONS:
                cls = classify_element(per_source_elem, dim)
                elem_record["dims"][dim] = cls
                results["dimension_states"][dim][cls["state"]] += 1
                if cls["state"] in ("split_2_1", "split_2", "split_3"):
                    results["splits"].append({
                        "kind_code": code,
                        "seq": seq,
                        "dimension": dim,
                        "state": cls["state"],
                        "outlier": cls["outlier"],
                        "values": cls["values"],
                    })
            struct_record["elements"][seq] = elem_record

        results["structures"][code] = struct_record

    return results


# ---------------------------------------------------------------------------
# Report rendering
# ---------------------------------------------------------------------------

def _fmt_values(values):
    """Render {source: raw} as a compact peer-neutral string."""
    parts = []
    for s in SOURCES:
        if s in values:
            v = values[s]
            parts.append(f"{s}={v!r}" if v != "" else f"{s}=∅")
        else:
            parts.append(f"{s}=—")
    return ", ".join(parts)


def render_report(seg_results, dt_results):
    lines = []
    lines.append("# V2.9.1 Three-Way Structural Comparison\n")
    lines.append(
        "Neutral peer comparison of three independent methodologies: "
        "**python-docx** (rule-based table parsing), **LLM** (Claude-mediated "
        "extraction), and **FHIR** (the published StructureDefinitions).\n")
    lines.append(
        "> **Reading guide.** No methodology is treated as authoritative. "
        "Agreement is corroborating evidence; disagreement is a flag to check "
        "the source `.docx`. A *2-vs-1 split* names the outlier as the value to "
        "**examine against source**, not as the value that is wrong — the "
        "two-agreeing sources could share a blind spot. A *three-way split* "
        "means all three differ. Element coverage gaps (a structure or element "
        "present in some sources but not others) are reported separately from "
        "value disagreements.\n")

    for title, res in (("Segments (fields)", seg_results),
                       ("Complex data types (components)", dt_results)):
        if res is None:
            continue
        lines.append(f"\n## {title}\n")
        _render_section(lines, res)

    return "\n".join(lines) + "\n"


def _render_section(lines, res):
    # Structure coverage
    cov = res["structure_coverage"]
    lines.append("### Structure coverage\n")
    lines.append("| Sources containing the structure | Count |")
    lines.append("|---|---:|")
    for n in (3, 2, 1):
        lines.append(f"| {n} of 3 | {cov.get(n, 0)} |")
    lines.append("")

    # Element coverage
    ecov = res["element_coverage"]
    lines.append("### Element coverage (across structures present in ≥1 source)\n")
    lines.append("| Sources containing the element | Count |")
    lines.append("|---|---:|")
    for n in (3, 2, 1):
        lines.append(f"| {n} of 3 | {ecov.get(n, 0)} |")
    lines.append("")

    # Per-dimension agreement
    lines.append("### Per-dimension agreement (elements present in ≥2 sources)\n")
    lines.append("| Dimension | agree | 2-vs-1 split | 2-only split | 3-way split |")
    lines.append("|---|---:|---:|---:|---:|")
    for dim in DIMENSIONS:
        st = res["dimension_states"][dim]
        lines.append(
            f"| {dim} | {st.get('agree', 0)} | {st.get('split_2_1', 0)} "
            f"| {st.get('split_2', 0)} | {st.get('split_3', 0)} |")
    lines.append("")

    # Outlier tally (for 2-vs-1 splits only -- the unambiguous "examine this one" case)
    outlier_counts = Counter()
    for sp in res["splits"]:
        if sp["state"] == "split_2_1" and sp["outlier"]:
            outlier_counts[sp["outlier"]] += 1
    if outlier_counts:
        lines.append("### 2-vs-1 splits: which source to examine against source `.docx`\n")
        lines.append(
            "_When two sources agree and one differs, the differing source is "
            "listed here as the one to check first — NOT as confirmed wrong._\n")
        lines.append("| Outlier source | 2-vs-1 splits |")
        lines.append("|---|---:|")
        for s in SOURCES:
            if outlier_counts.get(s):
                lines.append(f"| {s} | {outlier_counts[s]} |")
        lines.append("")

    # Detailed splits, grouped by structure
    splits_by_code = defaultdict(list)
    for sp in res["splits"]:
        splits_by_code[sp["kind_code"]].append(sp)
    if splits_by_code:
        lines.append("### Detailed disagreements\n")
        for code in sorted(splits_by_code):
            lines.append(f"#### {code}")
            for sp in sorted(splits_by_code[code], key=lambda x: (int(x["seq"]), x["dimension"])):
                tag = {
                    "split_2_1": f"2-vs-1 (examine **{sp['outlier']}** vs source)",
                    "split_2": "2-only split",
                    "split_3": "3-way split",
                }[sp["state"]]
                lines.append(f"- seq {sp['seq']} · {sp['dimension']} · {tag}: {_fmt_values(sp['values'])}")
            lines.append("")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--subset", help="Comma-separated structure codes to limit to")
    ap.add_argument("--kind", choices=["segments", "data-types", "both"],
                    default="both", help="Which element kind to compare")
    args = ap.parse_args()
    subset = [s.strip() for s in args.subset.split(",")] if args.subset else None

    seg_results = dt_results = None

    if args.kind in ("segments", "both"):
        pydocx = _load_v291_occurrence_corpus(PYDOCX_SEG_DIR, _v291_fields_to_uniform)
        llm = _load_v291_occurrence_corpus(LLM_SEG_DIR, _v291_fields_to_uniform)
        fhir = _load_fhir_corpus(FHIR_SEG_DIR, _fhir_fields_to_uniform)
        print(f"Segments — pydocx:{len(pydocx)} llm:{len(llm)} fhir:{len(fhir)}")
        seg_results = compare_corpus(pydocx, llm, fhir, subset=subset)

    if args.kind in ("data-types", "both"):
        pydocx = _load_v291_occurrence_corpus(PYDOCX_DT_DIR, _v291_components_to_uniform)
        llm = _load_v291_occurrence_corpus(LLM_DT_DIR, _v291_components_to_uniform)
        fhir = _load_fhir_corpus(FHIR_DT_DIR, _fhir_components_to_uniform)
        print(f"Data types — pydocx:{len(pydocx)} llm:{len(llm)} fhir:{len(fhir)}")
        dt_results = compare_corpus(pydocx, llm, fhir, subset=subset)

    report = render_report(seg_results, dt_results)
    REPORT_PATH.write_text(report)
    print(f"Report: {REPORT_PATH}")

    # Console summary
    for title, res in (("Segments", seg_results), ("Data types", dt_results)):
        if res is None:
            continue
        total_splits = len(res["splits"])
        print(f"  {title}: {res['structure_coverage'].get(3,0)} structures in all 3 sources, "
              f"{total_splits} dimension-level splits")


if __name__ == "__main__":
    main()
