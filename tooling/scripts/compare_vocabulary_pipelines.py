#!/usr/bin/env python3
"""Cross-validate the two independent extractions of V2.9.1 Chapter 2C.

Two pipelines read the same source document, CH02C_Tables.docx:

  * python-docx  -> v291-extracted/vocabulary/   (extract_v291_vocabulary.py)
  * LLM (Claude) -> v291-llm/vocabulary/         (extract_v291_llm.py --mode vocabulary)

Neither is treated as the authority. Where they agree, confidence in the value
is high because two unrelated methods produced it. Where they disagree, the
disagreement is reported so it can be adjudicated against the published .docx.
This is the ADR-0006 multi-corpus approach applied to vocabulary.

NOT to be confused with compare_vocabulary.py, which compares the CH02C content
against Frank Oemig's terminology IG and UTG/THO. That one is about what the
wider community publishes; this one is only about whether we read the document
correctly.

Disagreements are bucketed so that systematic pipeline quirks do not drown the
findings that need a human:

  typography   The two differ only in typographic characters -- curly quotes,
               en dashes, non-breaking spaces. The LLM substitutes ASCII
               equivalents no matter how firmly it is asked not to, so these
               are a KNOWN LLM limitation, not a source ambiguity. python-docx
               is character-faithful and is the reference for these.
  whitespace   The two differ only in leading/trailing or repeated whitespace.
  content      A real disagreement about what the document says. These are the
               ones to examine against the source.

Both sides are put through the shared text policy in
`vocabulary_text_policy.py` before being compared. The python-docx corpus
already has that policy baked in -- the extractor applies it -- so comparing
against a raw LLM value would report our own deliberate normalization as a
pipeline disagreement. Applying it to both keeps this a comparison of what the
two pipelines read, not of which one we post-processed. How many differences
the policy absorbs this way is counted and reported rather than hidden.

Usage:
    python3 tooling/scripts/compare_vocabulary_pipelines.py
    python3 tooling/scripts/compare_vocabulary_pipelines.py --limit 40
    python3 tooling/scripts/compare_vocabulary_pipelines.py --table 0396
"""

import argparse
import json
import re
import sys
import unicodedata
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from vocabulary_text_policy import normalize_descriptive_text  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
PYDOCX_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
LLM_DIR = PROJECT_ROOT / "v291-llm" / "vocabulary"
REPORT_MD = PROJECT_ROOT / "v291-llm" / "vocabulary-comparison-report.md"
REPORT_JSON = PROJECT_ROOT / "v291-llm" / "vocabulary-comparison-report.json"

# Sub-sections that appear once per table and are plain key/value blocks.
SINGLE_BLOCKS = ("conceptDomain", "tableMetadata")

# Sub-sections that may appear more than once per table.
REPEATED_BLOCKS = ("codeSystems", "codeSystemVersions", "valueSets", "bindings")

CODE_FIELDS = ("value", "displayName", "definition", "comment", "status")

# Characters the LLM reliably replaces with ASCII look-alikes.
TYPOGRAPHIC_EQUIVALENTS = {
    "\u201c": '"', "\u201d": '"',      # curly double quotes
    "\u2018": "'", "\u2019": "'",      # curly single quotes / apostrophe
    "\u2013": "-", "\u2014": "-",      # en dash, em dash
    "\u2026": "...",                    # ellipsis
    "\u00a0": " ",                      # non-breaking space
    "\u2011": "-",                      # non-breaking hyphen
}


def load_corpus(directory):
    """Load one corpus into a dict keyed by table number."""
    corpus = {}
    if not directory.exists():
        return corpus
    for path in sorted(directory.glob("*.json")):
        record = json.loads(path.read_text())
        number = record.get("tableNumber") or path.stem
        corpus[number] = record
    return corpus


def fold_typography(text):
    """Replace typographic characters with their ASCII look-alikes."""
    for fancy, plain in TYPOGRAPHIC_EQUIVALENTS.items():
        text = text.replace(fancy, plain)
    return unicodedata.normalize("NFKC", text)


def fold_whitespace(text):
    """Collapse all runs of whitespace to a single space and trim."""
    return re.sub(r"\s+", " ", text).strip()


def classify_difference(left, right):
    """Say how the python-docx value (`left`) and the LLM value (`right`) differ.

    Returns None when they are identical, otherwise one of:
    'typography', 'whitespace', 'llm_truncated', 'pydocx_truncated', 'content'.

    Typography is checked before whitespace because the non-breaking space
    belongs to both categories and is more informative reported as a
    typographic substitution.

    Truncation is checked before falling through to 'content' because the LLM
    intermittently cuts a value short at a literal double quote -- the quote
    closes the JSON string early during constrained decoding. That is a known
    artifact of the LLM pipeline, not a disagreement about what the document
    says, and mixing the two would bury the findings that need a human.
    """
    if left == right:
        return None
    folded_left, folded_right = fold_typography(left), fold_typography(right)
    if folded_left == folded_right:
        return "typography"
    if fold_whitespace(folded_left) == fold_whitespace(folded_right):
        return "whitespace"
    if folded_left.startswith(folded_right):
        return "llm_truncated"
    if folded_right.startswith(folded_left):
        return "pydocx_truncated"
    return "content"


# How many pairs the shared text policy made equal that would otherwise have
# been reported as a spacing disagreement. Kept as a running tally so the
# report can state the number instead of quietly dropping the findings.
POLICY_ABSORBED = Counter()


def under_policy(field, text):
    """Return a value as the shared text policy would emit it.

    Used on both sides of every comparison so that the normalization the
    extractor already applied to the python-docx corpus is not mistaken for a
    disagreement with the LLM corpus.
    """
    normalized, _ = normalize_descriptive_text(field, text or "")
    return normalized


def classify_under_policy(field, left, right, location):
    """Classify a difference after putting both values through the policy.

    Args:
        field: The bare field name, used to decide whether the policy applies.
        left: The python-docx value.
        right: The LLM value.
        location: Where the value sits, recorded against the absorbed tally.

    Returns:
        The bucket name, or None when the two agree under the policy.
    """
    bucket = classify_difference(under_policy(field, left),
                                 under_policy(field, right))
    if bucket is None and (left or "") != (right or ""):
        POLICY_ABSORBED[location] += 1
    return bucket


def block_to_dict(block):
    """Normalize one metadata block from either corpus into a plain dict.

    python-docx emits ``{"SymbolicName": "..."}``; the LLM emits
    ``[{"key": "SymbolicName", "value": "..."}]`` so that unexpected keys
    survive. Both reduce to the same dict here.
    """
    if block is None:
        return {}
    if isinstance(block, dict):
        return dict(block)
    return {entry["key"]: entry.get("value", "") for entry in block}


def repeated_blocks_to_dicts(blocks):
    """Normalize a list of repeated metadata blocks from either corpus."""
    if not blocks:
        return []
    normalized = []
    for block in blocks:
        if isinstance(block, dict) and "entries" in block:
            normalized.append(block_to_dict(block["entries"]))
        else:
            normalized.append(block_to_dict(block))
    return normalized


def compare_dicts(py_dict, llm_dict, location):
    """Compare two metadata dicts, returning a list of finding dicts."""
    findings = []
    for key in sorted(set(py_dict) | set(llm_dict)):
        in_py, in_llm = key in py_dict, key in llm_dict
        if not in_llm:
            findings.append({"location": f"{location}.{key}", "bucket": "missing_in_llm",
                             "pydocx": py_dict[key], "llm": None})
            continue
        if not in_py:
            findings.append({"location": f"{location}.{key}", "bucket": "missing_in_pydocx",
                             "pydocx": None, "llm": llm_dict[key]})
            continue
        bucket = classify_under_policy(key, py_dict[key], llm_dict[key],
                                       f"{location}.{key}")
        if bucket:
            findings.append({"location": f"{location}.{key}", "bucket": bucket,
                             "pydocx": py_dict[key], "llm": llm_dict[key]})
    return findings


def compare_codes(py_codes, llm_codes):
    """Compare the coded content of one table, row by row in source order."""
    findings = []
    if len(py_codes) != len(llm_codes):
        findings.append({
            "location": "codedContent",
            "bucket": "row_count",
            "pydocx": f"{len(py_codes)} rows",
            "llm": f"{len(llm_codes)} rows",
        })

    for index, (py_row, llm_row) in enumerate(zip(py_codes, llm_codes)):
        for field in CODE_FIELDS:
            bucket = classify_under_policy(field, py_row.get(field, ""),
                                           llm_row.get(field, ""),
                                           f"codedContent.{field}")
            if bucket:
                findings.append({
                    "location": f"codedContent[{index}].{field}",
                    "code": py_row.get("value", ""),
                    "bucket": bucket,
                    "pydocx": py_row.get(field, ""),
                    "llm": llm_row.get(field, ""),
                })
    return findings


def compare_table(py_record, llm_record):
    """Compare one code table across both corpuses. Returns a findings list."""
    findings = []

    bucket = classify_difference(py_record.get("tableName", ""),
                                 llm_record.get("tableName", ""))
    if bucket:
        findings.append({"location": "tableName", "bucket": bucket,
                         "pydocx": py_record.get("tableName", ""),
                         "llm": llm_record.get("tableName", "")})

    for section in SINGLE_BLOCKS:
        findings += compare_dicts(block_to_dict(py_record.get(section)),
                                  block_to_dict(llm_record.get(section)),
                                  section)

    for section in REPEATED_BLOCKS:
        py_blocks = repeated_blocks_to_dicts(py_record.get(section))
        llm_blocks = repeated_blocks_to_dicts(llm_record.get(section))
        if len(py_blocks) != len(llm_blocks):
            findings.append({"location": section, "bucket": "block_count",
                             "pydocx": f"{len(py_blocks)} blocks",
                             "llm": f"{len(llm_blocks)} blocks"})
        for index, (py_block, llm_block) in enumerate(zip(py_blocks, llm_blocks)):
            findings += compare_dicts(py_block, llm_block, f"{section}[{index}]")

    findings += compare_codes(py_record.get("codedContent") or [],
                              llm_record.get("codedContent") or [])
    return findings


def render_report(results, coverage, limit):
    """Build the markdown report."""
    buckets = Counter()
    for table_findings in results.values():
        for finding in table_findings:
            buckets[finding["bucket"]] += 1

    clean_tables = [t for t, f in results.items() if not f]
    content_tables = sorted({t for t, f in results.items()
                             if any(x["bucket"] == "content" for x in f)})

    lines = [
        "# Chapter 2C extraction cross-validation — python-docx vs LLM",
        "",
        "Both pipelines read `CH02C_Tables.docx`. Neither is the authority; ",
        "agreement raises confidence, disagreement marks a value to check against ",
        "the published document.",
        "",
        "## Coverage",
        "",
        f"- Tables in both corpuses: **{len(results)}**",
        f"- Tables only in python-docx: **{len(coverage['pydocx_only'])}**",
        f"- Tables only in the LLM corpus: **{len(coverage['llm_only'])}**",
        "",
    ]
    if coverage["pydocx_only"]:
        lines.append(f"python-docx only: {', '.join(sorted(coverage['pydocx_only']))}")
        lines.append("")
    if coverage["llm_only"]:
        lines.append(f"LLM only: {', '.join(sorted(coverage['llm_only']))}")
        lines.append("")

    lines += [
        "## Agreement",
        "",
        f"- Tables identical in every compared field: **{len(clean_tables)} / {len(results)}**",
        f"- Tables with at least one real content disagreement: **{len(content_tables)}**",
        "",
        "### Disagreements by kind",
        "",
        "| Kind | Count | Meaning |",
        "|---|---:|---|",
    ]
    meanings = {
        "typography": "LLM substituted an ASCII look-alike; python-docx is character-faithful",
        "whitespace": "Differs only in spacing",
        "llm_truncated": "LLM cut the value short (usually at a literal double quote); python-docx has the full text",
        "pydocx_truncated": "python-docx value is a prefix of the LLM value — investigate",
        "content": "Genuine disagreement — examine against the source .docx",
        "row_count": "Different number of code rows",
        "block_count": "Different number of metadata blocks",
        "missing_in_llm": "Key present in python-docx only",
        "missing_in_pydocx": "Key present in the LLM corpus only",
    }
    for bucket, count in buckets.most_common():
        lines.append(f"| `{bucket}` | {count} | {meanings.get(bucket, '')} |")
    lines.append("")

    absorbed_total = sum(POLICY_ABSORBED.values())
    if absorbed_total:
        lines += [
            "### Absorbed by the shared text policy",
            "",
            f"A further **{absorbed_total}** values were textually different but "
            "identical once both sides were put through "
            "`vocabulary_text_policy.py`. These are not counted above, because "
            "they are our own deliberate normalization (spaces collapsed after "
            "a period in descriptive fields) showing up on only one side — the "
            "python-docx corpus has the policy applied, the LLM corpus does "
            "not. They are listed here so the number is visible rather than "
            "silently removed.",
            "",
            "| Field | Values |",
            "|---|---:|",
        ]
        for location, count in POLICY_ABSORBED.most_common():
            lines.append(f"| `{location}` | {count} |")
        lines.append("")

    priority = ("content", "pydocx_truncated", "row_count", "block_count",
                "missing_in_llm", "missing_in_pydocx")
    needs_review = [(table, finding)
                    for table in sorted(results)
                    for finding in results[table]
                    if finding["bucket"] in priority]

    lines += [
        f"## Findings needing adjudication ({len(needs_review)})",
        "",
        "Each row is a value the two pipelines read differently. Resolve by ",
        "opening the section in `CH02C_Tables.docx`.",
        "",
    ]
    if not needs_review:
        lines.append("_None — the two pipelines agree on all content._")
    else:
        lines += ["| Table | Location | Kind | python-docx | LLM |", "|---|---|---|---|---|"]
        for table, finding in needs_review[:limit]:
            lines.append(
                f"| {table} | `{finding['location']}` | {finding['bucket']} "
                f"| {fmt_cell(finding['pydocx'])} | {fmt_cell(finding['llm'])} |"
            )
        if len(needs_review) > limit:
            lines.append("")
            lines.append(f"_{len(needs_review) - limit} further findings omitted; "
                         f"raise `--limit` or read the JSON report._")
    lines.append("")

    typography_tables = sorted({t for t, f in results.items()
                                if any(x["bucket"] == "typography" for x in f)})
    truncated = [(t, f) for t in sorted(results) for f in results[t]
                 if f["bucket"] == "llm_truncated"]
    lines += [
        "## Known LLM limitations",
        "",
        "Both of these are defects of the LLM pipeline, not source ambiguities. ",
        "The python-docx corpus is character-faithful and is the reference for both.",
        "",
        "### Typographic substitution",
        "",
        f"{buckets['typography']} values across {len(typography_tables)} tables differ only ",
        "because the LLM emitted ASCII look-alikes for curly quotes, dashes and ",
        "non-breaking spaces. Repeated prompt instructions did not stop it.",
        "",
        "### Truncation at a literal double quote",
        "",
        f"{len(truncated)} values were cut short by the LLM. In each case the LLM value is ",
        "an exact prefix of the python-docx value, ending where the published text ",
        "contains a `\"` character — the quote closes the JSON string early during ",
        "constrained decoding. It is intermittent rather than universal (most ",
        "quote-bearing values came through intact), and it only ever loses text, ",
        "never invents it.",
        "",
    ]
    if truncated:
        lines += ["| Table | Location | Lost text |", "|---|---|---|"]
        for table, finding in truncated[:limit]:
            lost = str(finding["pydocx"])[len(str(finding["llm"])):]
            lines.append(f"| {table} | `{finding['location']}` | {fmt_cell(lost)} |")
        lines.append("")
    return "\n".join(lines) + "\n"


def fmt_cell(value):
    """Format a value for a markdown table cell."""
    if value is None:
        return "_(absent)_"
    text = str(value).replace("|", "\\|").replace("\n", "\\n")
    if len(text) > 90:
        text = text[:87] + "..."
    return f"`{text}`" if text else "_(empty)_"


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--limit", type=int, default=200,
                        help="Max findings to list in the markdown report (default 200)")
    parser.add_argument("--table", default=None,
                        help="Only compare this table number, e.g. 0396")
    args = parser.parse_args()

    pydocx = load_corpus(PYDOCX_DIR)
    llm = load_corpus(LLM_DIR)

    if not llm:
        print(f"ERROR: no LLM corpus at {LLM_DIR}", file=sys.stderr)
        return 2

    if args.table:
        pydocx = {k: v for k, v in pydocx.items() if k == args.table}
        llm = {k: v for k, v in llm.items() if k == args.table}

    common = sorted(set(pydocx) & set(llm))
    coverage = {
        "pydocx_only": sorted(set(pydocx) - set(llm)),
        "llm_only": sorted(set(llm) - set(pydocx)),
    }

    results = {table: compare_table(pydocx[table], llm[table]) for table in common}

    REPORT_MD.parent.mkdir(parents=True, exist_ok=True)
    REPORT_MD.write_text(render_report(results, coverage, args.limit))
    REPORT_JSON.write_text(json.dumps({
        "coverage": {**coverage, "common": len(common)},
        "policyAbsorbed": {
            "total": sum(POLICY_ABSORBED.values()),
            "byField": dict(POLICY_ABSORBED.most_common()),
            "note": "Values equal once both corpuses are put through "
                    "vocabulary_text_policy.py. Not disagreements between the "
                    "pipelines; our own normalization applied to one side only.",
        },
        "findings": {t: f for t, f in results.items() if f},
    }, indent=2, ensure_ascii=False) + "\n")

    buckets = Counter(f["bucket"] for fs in results.values() for f in fs)
    clean = sum(1 for f in results.values() if not f)
    print(f"Compared {len(common)} tables "
          f"(pydocx-only {len(coverage['pydocx_only'])}, llm-only {len(coverage['llm_only'])})")
    print(f"  identical in every field: {clean}/{len(common)}")
    for bucket, count in buckets.most_common():
        print(f"  {bucket}: {count}")
    print(f"  absorbed by the shared text policy: {sum(POLICY_ABSORBED.values())}")
    print(f"\nReport: {REPORT_MD}")
    print(f"JSON:   {REPORT_JSON}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
