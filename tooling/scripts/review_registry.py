#!/usr/bin/env python3
"""Persistent review registry + change ledger for FHIR-vs-docx structural deltas.

This is the systematic tracker for every structural difference between the FHIR
StructureDefinitions and the V2.9.1 source, through its whole lifecycle:

    discovered -> needs-review -> (you decide) -> resolved -> implemented

It is built on the NEUTRAL three-way comparison (compare_three_way.py): every
finding records all three peer values (python-docx | LLM | FHIR). The docx is the
source but NOT the authority -- when FHIR differs from docx it may be a defect to
fix OR the SD may already be correcting a known docx error. So each resolution
carries a DIRECTION and a RATIONALE, and the SDs are treated as the next
iteration of the standard.

Artifacts (all under v291-review/):
  registry.json                 -- canonical source of truth, one entry per delta
  review-worklist.md            -- the items needing your decision; YOU edit this
  fhir-vs-docx-changelog.md     -- the complete change ledger (deviations only)
  apply-report.md               -- what the last `apply` run did to the SDs

Subcommands:
  build      Reconcile registry.json from the current comparison. Re-runnable:
             keeps your authored decisions, refreshes values/corroboration,
             adds new deltas, marks vanished ones 'stale'.
  worklist   (Re)generate review-worklist.md from needs-review entries.
  ingest     Parse your decisions out of review-worklist.md back into registry.
  apply      Auto-apply resolved direction=fix-fhir entries to the FHIR SDs and
             append them to the changelog. Use --write to actually modify files.
  changelog  Regenerate fhir-vs-docx-changelog.md (deviations-only ledger).

Typical loop:
  1. python3 review_registry.py build
  2. python3 review_registry.py worklist
  3. <edit v291-review/review-worklist.md: fill DECISION/DIRECTION/RATIONALE>
  4. python3 review_registry.py ingest
  5. python3 review_registry.py apply --write
  6. python3 review_registry.py changelog
"""

import argparse
import json
import os
import re
import sys
from collections import defaultdict, Counter
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
import compare_three_way as c3

PROJECT_ROOT = c3.PROJECT_ROOT
REVIEW_DIR = PROJECT_ROOT / "v291-review"
REGISTRY_PATH = REVIEW_DIR / "registry.json"
WORKLIST_PATH = REVIEW_DIR / "review-worklist.md"
CHANGELOG_PATH = REVIEW_DIR / "fhir-vs-docx-changelog.md"
APPLY_REPORT_PATH = REVIEW_DIR / "apply-report.md"

FHIR_SEG_DIR = c3.FHIR_SEG_DIR
FHIR_DT_DIR = c3.FHIR_DT_DIR

# Lifecycle vocab -----------------------------------------------------------
STATUS_VALUES = {"needs-review", "resolved", "wont-fix", "deferred", "stale"}
DIRECTION_VALUES = {
    "fix-fhir",            # SD has a defect; edit SD to match docx
    "fhir-already-correct",  # SD intentionally corrects a docx error; no SD change
    "fix-both-docx-defect",  # both wrong; SD gets corrected value, docx defect logged
}

# Which dimensions the auto-applier knows how to write to an SD.
APPLIABLE_DIMENSIONS = {"name", "data_type", "optionality", "length", "conf_length", "binding"}


def _now():
    # Date.now() is unavailable in workflow scripts but fine here (plain CLI).
    return datetime.now(timezone.utc).strftime("%Y-%m-%d")


# ---------------------------------------------------------------------------
# Stable IDs
# ---------------------------------------------------------------------------

def finding_id(kind, code, seq, dimension):
    """Deterministic fingerprint so re-runs reconcile instead of duplicating."""
    k = {"segment-field": "SEG", "data-type-component": "DTC"}.get(kind, "X")
    return f"{k}-{code}-{int(seq):03d}-{dimension}"


# ---------------------------------------------------------------------------
# Build / reconcile
# ---------------------------------------------------------------------------

def _run_comparison():
    """Return {kind: results} from the three-way comparison for both kinds."""
    seg_py = c3._load_v291_occurrence_corpus(c3.PYDOCX_SEG_DIR, c3._v291_fields_to_uniform)
    seg_llm = c3._load_v291_occurrence_corpus(c3.LLM_SEG_DIR, c3._v291_fields_to_uniform)
    seg_fhir = c3._load_fhir_corpus(c3.FHIR_SEG_DIR, c3._fhir_fields_to_uniform)
    seg = c3.compare_corpus(seg_py, seg_llm, seg_fhir)

    dt_py = c3._load_v291_occurrence_corpus(c3.PYDOCX_DT_DIR, c3._v291_components_to_uniform)
    dt_llm = c3._load_v291_occurrence_corpus(c3.LLM_DT_DIR, c3._v291_components_to_uniform)
    dt_fhir = c3._load_fhir_corpus(c3.FHIR_DT_DIR, c3._fhir_components_to_uniform)
    dt = c3.compare_corpus(dt_py, dt_llm, dt_fhir)
    return {"segment-field": seg, "data-type-component": dt}


def _splits_to_findings(kind, results):
    """Convert comparison splits into registry finding dicts (discovered state)."""
    findings = {}
    for sp in results["splits"]:
        code = sp["kind_code"]
        seq = sp["seq"]
        dim = sp["dimension"]
        fid = finding_id(kind, code, seq, dim)
        findings[fid] = {
            "id": fid,
            "kind": kind,
            "structure": code,
            "seq": str(seq),
            "dimension": dim,
            "values": sp["values"],            # {pydocx, llm, fhir}
            "split_state": sp["state"],         # split_2_1 / split_2 / split_3
            "outlier": sp["outlier"],           # source to examine first (or None)
            "corroboration": _corroboration(sp),
        }
    return findings


def _corroboration(sp):
    """Human phrase describing the agreement configuration, peer-neutrally."""
    vals = sp["values"]
    present = [s for s in c3.SOURCES if s in vals]
    if sp["state"] == "split_2_1":
        agree = [s for s in present if s != sp["outlier"]]
        return f"{'+'.join(agree)} agree; {sp['outlier']} differs"
    if sp["state"] == "split_3":
        return "all three differ"
    return "two sources present and differ"


def cmd_build(args):
    REVIEW_DIR.mkdir(exist_ok=True)
    existing = _load_registry()
    by_id = {e["id"]: e for e in existing.get("findings", [])}

    comparison = _run_comparison()
    discovered = {}
    for kind, results in comparison.items():
        discovered.update(_splits_to_findings(kind, results))

    today = _now()
    added = refreshed = stale = preserved = 0
    out = {}

    # Reconcile discovered against existing
    for fid, disc in discovered.items():
        if fid in by_id:
            prev = by_id[fid]
            # Refresh the observed facts; PRESERVE authored decision fields.
            prev["values"] = disc["values"]
            prev["split_state"] = disc["split_state"]
            prev["outlier"] = disc["outlier"]
            prev["corroboration"] = disc["corroboration"]
            prev["last_seen"] = today
            if prev.get("status") == "stale":
                prev["status"] = "needs-review"  # reappeared
            out[fid] = prev
            refreshed += 1
        else:
            disc.update({
                "status": "needs-review",
                "direction": None,
                "disposition": None,
                "rationale": None,
                "implemented_in": None,
                "first_seen": today,
                "last_seen": today,
            })
            out[fid] = disc
            added += 1

    # Existing entries no longer discovered -> mark stale (don't delete: keep
    # the authored history and the changelog intact).
    for fid, prev in by_id.items():
        if fid not in out:
            if prev.get("status") == "resolved":
                # Resolved + no longer a delta = the fix worked. Keep as-is.
                out[fid] = prev
                preserved += 1
            else:
                prev["status"] = "stale"
                prev["last_seen"] = prev.get("last_seen", today)
                out[fid] = prev
                stale += 1

    registry = {
        "schema": "v291-review-registry/1.0",
        "generated": today,
        "description": (
            "FHIR-vs-docx structural delta registry. Each finding records all "
            "three peer values (python-docx|LLM|FHIR). Decisions carry a "
            "direction + rationale because the docx is the source but not the "
            "authority; SDs are the next iteration of the standard."),
        "findings": sorted(out.values(), key=lambda e: e["id"]),
    }
    _write_registry(registry)

    print(f"Registry: {REGISTRY_PATH}")
    print(f"  added {added}, refreshed {refreshed}, newly-stale {stale}, "
          f"resolved-kept {preserved}, total {len(out)}")
    _status_summary(registry)


def _status_summary(registry):
    by_status = Counter(e["status"] for e in registry["findings"])
    print("  status:", dict(by_status))


# ---------------------------------------------------------------------------
# Registry IO
# ---------------------------------------------------------------------------

def _load_registry():
    if REGISTRY_PATH.is_file():
        return json.loads(REGISTRY_PATH.read_text())
    return {"findings": []}


def _write_registry(registry):
    REGISTRY_PATH.write_text(json.dumps(registry, indent=2) + "\n")


# ---------------------------------------------------------------------------
# Worklist generation
# ---------------------------------------------------------------------------
# The worklist GROUPS findings so you don't make 191 identical decisions. A group
# is (structure, dimension, outlier, agreeing-pair) -- e.g. "all BPX name fields:
# FHIR has placeholders, pydocx+llm agree on real names". You decide once per
# group; ingest expands the decision to every finding in it.

def _group_key(f):
    return (f["structure"], f["dimension"], f["outlier"], f["corroboration"])


def cmd_worklist(args):
    registry = _load_registry()
    pending = [f for f in registry["findings"] if f["status"] == "needs-review"]
    if not pending:
        print("No findings need review. Worklist not regenerated.")
        return

    groups = defaultdict(list)
    for f in pending:
        groups[_group_key(f)].append(f)

    lines = []
    lines.append("# FHIR-vs-docx Review Worklist\n")
    lines.append(f"_Generated {_now()} · {len(pending)} findings in {len(groups)} groups._\n")
    lines.append(
        "Each block is one decision. Fill the three `>` fields per block, then "
        "run `review_registry.py ingest`. **Leave a block untouched to defer it.**\n")
    lines.append("**DIRECTION** (pick one):")
    lines.append("- `fix-fhir` — the SD has a defect; edit the SD to match the source value")
    lines.append("- `fhir-already-correct` — the SD intentionally corrects a docx error; no SD change (logged as a docx defect)")
    lines.append("- `fix-both-docx-defect` — both are wrong; provide the corrected value in DECISION (logged as a docx defect)\n")
    lines.append(
        "**DECISION** = the value to write into the SD (for `fix-fhir`, usually "
        "the agreeing source value; for `fix-both`, the corrected value). For "
        "`fhir-already-correct`, leave DECISION blank.\n")
    lines.append("**RATIONALE** = why — especially the source-of-truth reasoning. Required.\n")
    lines.append("---\n")

    # Order: biggest groups first (most leverage), then by structure.
    ordered = sorted(groups.items(), key=lambda kv: (-len(kv[1]), kv[0][0]))
    for (structure, dimension, outlier, corrob), items in ordered:
        gid = _group_tag(structure, dimension, outlier)
        seqs = ", ".join(sorted((i["seq"] for i in items), key=lambda x: int(x)))
        # Show one exemplar's values and how many share the pattern.
        ex = items[0]
        lines.append(f"## [{gid}] {structure} · {dimension} · {len(items)} field(s)")
        lines.append(f"- Affected seqs: {seqs}")
        lines.append(f"- Configuration: {corrob}")
        lines.append(f"- Example (seq {ex['seq']}): {c3._fmt_values(ex['values'])}")
        if outlier:
            lines.append(f"- Outlier to examine vs source `.docx`: **{outlier}**")
        lines.append("")
        lines.append(f"> DIRECTION: ")
        lines.append(f"> DECISION: ")
        lines.append(f"> RATIONALE: ")
        lines.append("")
        lines.append("---\n")

    WORKLIST_PATH.write_text("\n".join(lines) + "\n")
    print(f"Worklist: {WORKLIST_PATH}  ({len(pending)} findings, {len(groups)} groups)")


def _group_tag(structure, dimension, outlier):
    return f"{structure}:{dimension}:{outlier or 'multi'}"


def _parse_group_tag(tag):
    structure, dimension, outlier = tag.split(":", 2)
    return structure, dimension, (None if outlier == "multi" else outlier)


# ---------------------------------------------------------------------------
# Ingest decisions
# ---------------------------------------------------------------------------

def cmd_ingest(args):
    if not WORKLIST_PATH.is_file():
        print("No worklist to ingest. Run `worklist` first.")
        return
    text = WORKLIST_PATH.read_text()
    registry = _load_registry()
    by_group = defaultdict(list)
    for f in registry["findings"]:
        by_group[_group_key(f)].append(f)
    # also index by (structure, dimension, outlier) since the tag drops corrob
    by_tag = defaultdict(list)
    for f in registry["findings"]:
        if f["status"] in ("needs-review", "deferred"):
            by_tag[(f["structure"], f["dimension"], f["outlier"])].append(f)

    blocks = re.split(r"^## \[", text, flags=re.MULTILINE)[1:]
    applied = skipped = 0
    today = _now()
    for blk in blocks:
        m = re.match(r"([^\]]+)\]", blk)
        if not m:
            continue
        tag = m.group(1).strip()
        direction = _field(blk, "DIRECTION")
        decision = _field(blk, "DECISION")
        rationale = _field(blk, "RATIONALE")
        if not direction:
            skipped += 1
            continue
        if direction not in DIRECTION_VALUES:
            print(f"  ! [{tag}] invalid DIRECTION '{direction}' — skipped")
            skipped += 1
            continue
        if not rationale:
            print(f"  ! [{tag}] missing RATIONALE — skipped")
            skipped += 1
            continue
        structure, dimension, outlier = _parse_group_tag(tag)
        targets = by_tag.get((structure, dimension, outlier), [])
        if not targets:
            print(f"  ! [{tag}] no matching pending findings — skipped")
            skipped += 1
            continue
        for f in targets:
            f["status"] = "resolved"
            f["direction"] = direction
            f["rationale"] = rationale
            # Determine the value to write into the SD.
            if direction == "fhir-already-correct":
                f["disposition"] = None
            elif decision:
                f["disposition"] = decision
            else:
                # default: the agreeing source value (the non-outlier value)
                f["disposition"] = _default_decision(f)
            f["resolved_on"] = today
            applied += 1

    _write_registry(registry)
    print(f"Ingested decisions: {applied} findings resolved, {skipped} blocks skipped.")
    _status_summary(registry)


def _field(block, label):
    m = re.search(rf"^>[ \t]*{label}:[ \t]*(.*)$", block, flags=re.MULTILINE)
    return m.group(1).strip() if m else ""


def _default_decision(f):
    """For fix-fhir with no explicit DECISION, use the agreeing-source value."""
    vals = f["values"]
    outlier = f["outlier"]
    if outlier:
        for s in c3.SOURCES:
            if s != outlier and s in vals:
                return vals[s]
    # fallback: prefer pydocx then llm
    for s in ("pydocx", "llm", "fhir"):
        if s in vals:
            return vals[s]
    return None


# ---------------------------------------------------------------------------
# Apply to FHIR SDs
# ---------------------------------------------------------------------------

def _fhir_path(f):
    if f["kind"] == "segment-field":
        return FHIR_SEG_DIR / f"{f['structure']}.json"
    return FHIR_DT_DIR / f"{f['structure']}.json"


def _find_element(fhir_data, structure, seq):
    """Locate the differential element for a given 1-based sequence.

    Segment paths look like 'BPX.1-bpx1'; data-type paths like 'AD.1'. Match on
    the 'CODE.seq' prefix bounded by end-of-string or a '-'.
    """
    want = f"{structure}.{seq}"
    for elem in fhir_data.get("differential", {}).get("element", []):
        path = elem.get("path", "")
        if path == want or path.startswith(want + "-"):
            return elem
    return None


def _apply_to_element(elem, dimension, value):
    """Write one resolved value into a FHIR element. Returns (old, new) or None."""
    if dimension == "name":
        old = elem.get("short", "")
        if old == value:
            return None
        elem["short"] = value
        return (old, value)
    if dimension == "data_type":
        types = elem.get("type", [])
        old = types[0].get("code", "") if types else ""
        if old == value:
            return None
        if types:
            types[0]["code"] = value
        else:
            elem["type"] = [{"code": value}]
        return (old, value)
    if dimension == "optionality":
        # value is R/O/C; min reflects R
        old_min = elem.get("min", 0)
        new_min = 1 if value.upper() == "R" else 0
        if old_min == new_min:
            return None
        elem["min"] = new_min
        return (f"min={old_min}", f"min={new_min}")
    # length / conf_length involve nested extensions — defer to a manual pass.
    return None


def cmd_apply(args):
    registry = _load_registry()
    todo = [f for f in registry["findings"]
            if f["status"] == "resolved"
            and f["direction"] in ("fix-fhir", "fix-both-docx-defect")
            and not f.get("implemented_in")
            and f["dimension"] in APPLIABLE_DIMENSIONS]

    if not todo:
        print("Nothing to apply (no unimplemented fix-fhir/fix-both resolutions "
              "in appliable dimensions).")
        return

    # Group by file to write once per SD.
    by_file = defaultdict(list)
    for f in todo:
        by_file[_fhir_path(f)].append(f)

    results = []
    write = args.write
    for path, items in sorted(by_file.items()):
        if not path.is_file():
            for f in items:
                results.append({**f, "_status": "fhir_file_missing"})
            continue
        data = json.loads(path.read_text())
        modified = False
        for f in items:
            elem = _find_element(data, f["structure"], f["seq"])
            if elem is None:
                results.append({**f, "_status": "element_not_found"})
                continue
            val = f.get("disposition")
            if val is None:
                results.append({**f, "_status": "no_decision_value"})
                continue
            res = _apply_to_element(elem, f["dimension"], val)
            if res is None:
                results.append({**f, "_status": "no_op"})
                continue
            old, new = res
            results.append({**f, "_status": "applied", "_old": old, "_new": new})
            modified = True
        if modified and write:
            path.write_text(json.dumps(data, indent=2) + "\n")

    # Stamp implemented_in for applied items (only when actually writing).
    if write:
        applied_ids = {r["id"] for r in results if r["_status"] == "applied"}
        stamp = f"apply:{_now()}"
        for f in registry["findings"]:
            if f["id"] in applied_ids:
                f["implemented_in"] = stamp
        _write_registry(registry)

    _write_apply_report(results, write)
    counts = Counter(r["_status"] for r in results)
    mode = "WROTE" if write else "DRY-RUN (use --write to apply)"
    print(f"Apply [{mode}]: {dict(counts)}")
    print(f"Report: {APPLY_REPORT_PATH}")


def _write_apply_report(results, write):
    lines = [f"# FHIR Apply Report ({'WRITE' if write else 'DRY-RUN'})\n",
             f"_Generated {_now()}_\n"]
    by_status = defaultdict(list)
    for r in results:
        by_status[r["_status"]].append(r)
    for status in sorted(by_status):
        rs = by_status[status]
        lines.append(f"## {status} ({len(rs)})\n")
        for r in sorted(rs, key=lambda x: x["id"]):
            extra = ""
            if status == "applied":
                extra = f": `{r.get('_old')}` → `{r.get('_new')}`"
            lines.append(f"- {r['id']} ({r['structure']}.{r['seq']} {r['dimension']}){extra}")
        lines.append("")
    APPLY_REPORT_PATH.write_text("\n".join(lines) + "\n")


# ---------------------------------------------------------------------------
# Change ledger (deviations only)
# ---------------------------------------------------------------------------

def cmd_changelog(args):
    registry = _load_registry()
    resolved = [f for f in registry["findings"]
                if f["status"] in ("resolved",) and f.get("direction")]
    lines = ["# FHIR-vs-docx Change Ledger\n",
             f"_Generated {_now()}_\n",
             "Every resolved structural deviation between the FHIR "
             "StructureDefinitions and the V2.9.1 source `.docx`, with its "
             "direction and rationale. This is the cumulative record of what the "
             "SDs (the next iteration of the standard) change relative to the "
             "published docx — including cases where the docx itself is in "
             "error.\n"]

    # Section the ledger by direction so docx-defects are easy to extract.
    by_dir = defaultdict(list)
    for f in resolved:
        by_dir[f["direction"]].append(f)

    headers = {
        "fix-fhir": "SD defects corrected to match source",
        "fhir-already-correct": "SD already correct — docx defects (for next standard iteration)",
        "fix-both-docx-defect": "Both wrong — SD corrected, docx defect logged (for next standard iteration)",
    }
    for direction in ("fix-fhir", "fix-both-docx-defect", "fhir-already-correct"):
        items = by_dir.get(direction, [])
        if not items:
            continue
        lines.append(f"\n## {headers[direction]} ({len(items)})\n")
        lines.append("| ID | Structure | Seq | Dimension | docx (pydocx/llm) | FHIR (was) | Resolution | Rationale |")
        lines.append("|---|---|---|---|---|---|---|---|")
        for f in sorted(items, key=lambda x: x["id"]):
            v = f["values"]
            docx_val = v.get("pydocx", v.get("llm", ""))
            fhir_was = v.get("fhir", "")
            res = f.get("disposition") or "(no SD change)"
            impl = " ✓" if f.get("implemented_in") else ""
            lines.append(
                f"| {f['id']}{impl} | {f['structure']} | {f['seq']} | "
                f"{f['dimension']} | {docx_val!r} | {fhir_was!r} | {res!r} | "
                f"{(f.get('rationale') or '').replace('|','/')} |")
        lines.append("")

    pending = sum(1 for f in registry["findings"] if f["status"] == "needs-review")
    lines.append(f"\n_{len(resolved)} resolved deviations · {pending} still awaiting review._\n")
    CHANGELOG_PATH.write_text("\n".join(lines) + "\n")
    print(f"Changelog: {CHANGELOG_PATH}  ({len(resolved)} resolved deviations)")


# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("build", help="Reconcile registry.json from the comparison")
    sub.add_parser("worklist", help="Generate review-worklist.md")
    sub.add_parser("ingest", help="Parse decisions from review-worklist.md")
    ap_apply = sub.add_parser("apply", help="Apply resolved fix-fhir entries to SDs")
    ap_apply.add_argument("--write", action="store_true", help="Actually modify SD files")
    sub.add_parser("changelog", help="Regenerate the change ledger")
    args = ap.parse_args()

    {"build": cmd_build, "worklist": cmd_worklist, "ingest": cmd_ingest,
     "apply": cmd_apply, "changelog": cmd_changelog}[args.cmd](args)


if __name__ == "__main__":
    main()
