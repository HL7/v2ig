#!/usr/bin/env python3
"""LLM-mediated V2.9.1 extraction (Phase 1 prototype, ADR-0006).

Walks an HL7 V2.9.1 source .docx chapter, identifies candidate tables (message
structures + segment field tables), and asks Claude Sonnet 4.6 to emit
JSON records matching the same schema as v291-extracted/.

The output corpus lives in v291-llm/ and is intended to be cross-validated
against the python-docx-derived v291-extracted/ corpus via
compare_python_vs_llm.py (Phase 1 stretch goal).

Cost-conscious design:
  * One LLM call per candidate table.
  * Static system prompt (schema + V2 notation rules + few-shot examples) is
    cached via prompt_caching, so the prefix amortizes across calls.
  * Per-call payload is small: the table as markdown plus a few lines of
    surrounding context.

Usage:
    export ANTHROPIC_API_KEY=...
    python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx

    # Dry-run: walk the doc and report what WOULD be sent to the LLM,
    # without making API calls
    python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx --dry-run

    # Limit to first N tables for a fast sanity check
    python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx --limit 3
"""

import argparse
import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import List, Literal, Optional

from docx import Document
from docx.table import Table
from docx.text.paragraph import Paragraph
from pydantic import BaseModel, Field


PROJECT_ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = PROJECT_ROOT / "v2plus_docx"
OUTPUT_DIR = PROJECT_ROOT / "v291-llm"
MSG_STRUCT_OUT = OUTPUT_DIR / "message-structures"
SEGMENTS_OUT = OUTPUT_DIR / "segments"

MODEL = "claude-sonnet-4-6"
MAX_TOKENS = 8000  # plenty for one table; far less than the 64K Sonnet ceiling


# ---------------------------------------------------------------------------
# Pydantic schema — mirrors v291-extracted/*.json shape
# ---------------------------------------------------------------------------


class Provenance(BaseModel):
    sourceFile: str
    chapter: str
    clause: str
    sectionHeading: str
    tableIndex: int
    captionText: str


class RawRow(BaseModel):
    segments: str
    description: str = ""
    status: str = ""
    chapter: str = ""


class ParsedElement(BaseModel):
    type: Literal["segment", "group_begin", "group_end"]
    code: str = ""
    description: str = ""
    optionality: str = ""  # "R" | "O" | "C" | "" (group markers)
    repetition: bool = False
    chapter: str = ""


class MessageStructureRecord(BaseModel):
    kind: Literal["message_structure"] = "message_structure"
    structureId: str
    caption: str
    provenance: Provenance
    rawRows: List[RawRow]
    parsedStructure: List[ParsedElement]


class SegmentField(BaseModel):
    sequence: str
    length: str = ""
    confLength: str = ""
    dataType: str = ""
    optionality: str = ""
    repetition: str = ""
    tableBinding: str = ""
    itemNumber: str = ""
    name: str = ""


class SegmentOccurrence(BaseModel):
    name: str
    provenance: Provenance
    fields: List[SegmentField]


class SegmentRecord(BaseModel):
    kind: Literal["segment"] = "segment"
    code: str
    occurrence: SegmentOccurrence


class NotExtractable(BaseModel):
    kind: Literal["not_extractable"] = "not_extractable"
    reason: str


class ExtractionResult(BaseModel):
    """Discriminated union: the LLM picks the right shape for each table."""

    classification: Literal["message_structure", "segment", "not_extractable"]
    message_structure: Optional[MessageStructureRecord] = None
    segment: Optional[SegmentRecord] = None
    not_extractable: Optional[NotExtractable] = None


# ---------------------------------------------------------------------------
# System prompt — static, cached
# ---------------------------------------------------------------------------


SYSTEM_PROMPT = """\
You extract structured records from HL7 V2.9.1 specification tables.

# Your task

You are given:
  * The chapter heading hierarchy (clause number + section heading)
  * Two or three paragraphs of surrounding context from the source document
  * One table rendered as a Markdown table

Determine which of three categories the table falls into, then emit JSON
in the matching schema. If the table is something else (an introductory
matrix, a vocabulary listing, a usage example, etc.), classify it as
"not_extractable" with a one-line reason.

# Categories

## 1. Message structure table

Lists the segments that make up an HL7 V2 message. The leftmost column shows
segment codes wrapped in V2 cardinality notation. The other columns are
typically Description, Status, and Chapter.

V2 cardinality notation:
  * `XYZ`         — required, single (R)
  * `[ XYZ ]`     — optional, single (O)
  * `{ XYZ }`     — required, repeating (R, repetition: true)
  * `[{ XYZ }]`   — optional, repeating (O, repetition: true)
  * `[{`          — start of an optional repeating group (group_begin)
  * `}]`          — end of a group (group_end)
  * `<` `>` `|`   — choice-group markers (rare; classify as group_begin/end with code preserved)

Output schema:
{
  "classification": "message_structure",
  "message_structure": {
    "structureId": "ADT_A01",   // from the section heading "ADT^A01^ADT_A01: ..."
    "caption": "ADT^A01^ADT_A01: ADT Message",   // section heading verbatim
    "provenance": { ... fields the user provides verbatim ... },
    "rawRows": [
      // EXACT rows from the table — preserve brackets, braces, whitespace,
      // chapter numbers, status flags. This is the source-faithful view.
      { "segments": "MSH",          "description": "Message Header",   "status": "", "chapter": "2" },
      { "segments": "[{ SFT }]",    "description": "Software Segment", "status": "", "chapter": "2" }
    ],
    "parsedStructure": [
      // Interpreted view: one element per logical row.
      // Use type "segment" for actual segments, with the bare code (no brackets/braces).
      // Use type "group_begin" for "[{" rows, type "group_end" for "}]" rows.
      // For group_begin/group_end, leave `code` empty unless the source shows a name.
      { "type": "segment",     "code": "MSH", "description": "Message Header", "optionality": "R", "repetition": false, "chapter": "2" },
      { "type": "segment",     "code": "SFT", "description": "Software Segment", "optionality": "O", "repetition": true, "chapter": "2" }
    ]
  }
}

## 2. Segment field table (a.k.a. "HL7 Attribute Table")

Lists the fields of a segment. The section heading is typically of the form
"HL7 Attribute Table - PID - Patient Identification". Columns are usually:
SEQ | LEN | C.LEN | DT | Optionality | RP/# | TBL# | ITEM# | ELEMENT NAME.

Output schema:
{
  "classification": "segment",
  "segment": {
    "code": "PID",
    "occurrence": {
      "name": "Patient Identification",
      "provenance": { ... },
      "fields": [
        { "sequence": "1", "length": "1..4", "confLength": "", "dataType": "SI",
          "optionality": "O", "repetition": "", "tableBinding": "",
          "itemNumber": "00104", "name": "Set ID - PID" },
        ...
      ]
    }
  }
}

Rules for the fields array:
  * Preserve cells verbatim. If a cell is blank, emit "".
  * `repetition` is "Y" / "" / a number, copied from the source.
  * Don't normalize, don't fix typos. Source-faithful capture is the goal.

## 3. Not extractable

Anything else. Emit:
{
  "classification": "not_extractable",
  "not_extractable": { "reason": "introductory matrix" }
}

# Universal rules

  * COPY the `provenance` object verbatim from the user's input — do not
    invent or modify any field.
  * Never invent rows. If a row in the source has missing cells, emit
    empty strings for those cells.
  * Never reorder rows.
  * Never collapse or expand cardinality. `[{ X }]` stays as one row in
    rawRows; in parsedStructure the X segment is one element with optionality:O
    and repetition:true.
  * If the table is malformed or the columns don't make sense, prefer
    "not_extractable" over guessing.
"""


# ---------------------------------------------------------------------------
# Walking the docx
# ---------------------------------------------------------------------------


HEADING_STYLE_RE = re.compile(r"^Heading\s*(\d+)$", re.IGNORECASE)
MSG_CAPTION_STYLE = "Msg Table Caption"
ATTR_CAPTION_STYLE = "Attribute Table Caption"


def iter_body(doc):
    """Yield (kind, obj) pairs in document order."""
    body = doc.element.body
    for child in body.iterchildren():
        tag = child.tag.split("}")[-1]
        if tag == "p":
            yield "para", Paragraph(child, doc)
        elif tag == "tbl":
            yield "table", Table(child, doc)


def heading_level(p):
    style = (p.style.name or "") if p.style else ""
    m = HEADING_STYLE_RE.match(style)
    return int(m.group(1)) if m else None


def render_table_as_markdown(tbl):
    """Render a docx Table to a Markdown table. Cells with newlines are joined with ' / '."""
    rows = []
    for row in tbl.rows:
        cells = [" / ".join(p.text.strip() for p in cell.paragraphs).strip() for cell in row.cells]
        rows.append(cells)
    if not rows:
        return ""
    width = max(len(r) for r in rows)
    rows = [r + [""] * (width - len(r)) for r in rows]

    def esc(s):
        return s.replace("|", "\\|").replace("\n", " ")

    out = []
    out.append("| " + " | ".join(esc(c) for c in rows[0]) + " |")
    out.append("|" + "|".join(["---"] * width) + "|")
    for r in rows[1:]:
        out.append("| " + " | ".join(esc(c) for c in r) + " |")
    return "\n".join(out)


def walk_chapter(docx_path, chapter_num):
    """Walk a chapter docx and yield one tuple per table in document order.

    Tracks two parallel things alongside the body iteration:
      * Heading 1/2/3/... → numeric clause counters (mirrors the python-docx
        extractor's logic so clause numbers match across both corpuses).
      * Most recent caption-style paragraph (Msg Table Caption /
        Attribute Table Caption) → the table's logical caption.

    Yields: dict with table_idx, clause, section_heading (deepest Heading text),
    caption (caption-style text or ""), caption_style (style name or ""),
    paragraphs (last 5 body paragraphs after most recent reset), table.
    """
    doc = Document(str(docx_path))

    heading_counters = {}  # level -> counter
    deepest_heading_text = ""
    current_caption = ""
    current_caption_style = ""
    recent_paras = []
    table_index = 0

    for kind, obj in iter_body(doc):
        if kind == "para":
            style = (obj.style.name or "") if obj.style else ""
            text = obj.text.strip()
            if not text:
                continue

            level = heading_level(obj)
            if level is not None:
                if level == 1:
                    heading_counters = {}
                elif level >= 2:
                    heading_counters[level] = heading_counters.get(level, 0) + 1
                    for l in list(heading_counters):
                        if l > level:
                            del heading_counters[l]
                deepest_heading_text = text
                # Heading resets the caption + paragraph context
                current_caption = ""
                current_caption_style = ""
                recent_paras = []
            elif style in (MSG_CAPTION_STYLE, ATTR_CAPTION_STYLE):
                current_caption = text
                current_caption_style = style
                recent_paras = []
            else:
                recent_paras.append(text)
                if len(recent_paras) > 5:
                    recent_paras = recent_paras[-5:]
        elif kind == "table":
            # Compute clause number from active heading counters.
            parts = [chapter_num]
            if heading_counters:
                for l in range(2, max(heading_counters) + 1):
                    if l in heading_counters:
                        parts.append(str(heading_counters[l]))
            clause = ".".join(parts)
            yield {
                "table_idx": table_index,
                "clause": clause,
                "section_heading": deepest_heading_text,
                "caption": current_caption,
                "caption_style": current_caption_style,
                "paragraphs": list(recent_paras),
                "table": obj,
            }
            table_index += 1
            # Caption is consumed by the table it precedes — clear so we
            # don't re-attribute it to the next table.
            current_caption = ""
            current_caption_style = ""


def likely_extractable(caption_style):
    """Pre-filter using the caption style. Cheap and reliable for V2.9.1 docs.

    Returns 'message_structure' | 'segment' | 'unknown'.
    """
    if caption_style == MSG_CAPTION_STYLE:
        return "message_structure"
    if caption_style == ATTR_CAPTION_STYLE:
        return "segment"
    return "unknown"


# ---------------------------------------------------------------------------
# LLM call
# ---------------------------------------------------------------------------


def call_claude(client, payload, model=MODEL, max_tokens=MAX_TOKENS):
    """One LLM extraction call. Returns parsed ExtractionResult."""
    user_message = (
        "Source file: {sourceFile}\n"
        "Chapter: {chapter}\n"
        "Clause: {clause}\n"
        "Section heading: {sectionHeading}\n"
        "Table index in chapter: {tableIndex}\n"
        "Caption text: {captionText}\n"
        "Hint from heuristic pre-filter: {hint}\n\n"
        "Surrounding paragraphs (most recent first):\n{paragraphs}\n\n"
        "Table:\n{table}\n\n"
        "Use this exact provenance object verbatim in your output:\n{provenance_json}"
    ).format(
        sourceFile=payload["provenance"]["sourceFile"],
        chapter=payload["provenance"]["chapter"],
        clause=payload["provenance"]["clause"],
        sectionHeading=payload["provenance"]["sectionHeading"],
        tableIndex=payload["provenance"]["tableIndex"],
        captionText=payload["provenance"]["captionText"],
        hint=payload["hint"],
        paragraphs="\n".join(f"  - {p}" for p in payload["paragraphs"]) or "  (none)",
        table=payload["table_md"],
        provenance_json=json.dumps(payload["provenance"], indent=2),
    )

    response = client.messages.parse(
        model=model,
        max_tokens=max_tokens,
        system=[
            {
                "type": "text",
                "text": SYSTEM_PROMPT,
                "cache_control": {"type": "ephemeral"},
            }
        ],
        messages=[{"role": "user", "content": user_message}],
        output_format=ExtractionResult,
    )
    return response


# ---------------------------------------------------------------------------
# Output writing
# ---------------------------------------------------------------------------


def safe_filename(*parts):
    """Build a filename from parts, replacing chars that don't play well in paths."""
    raw = "_".join(str(p) for p in parts if p)
    return re.sub(r"[^A-Za-z0-9_.-]", "_", raw) + ".json"


def write_message_structure(record):
    MSG_STRUCT_OUT.mkdir(parents=True, exist_ok=True)
    chapter = record.provenance.chapter
    fname = safe_filename(record.structureId, chapter, record.provenance.tableIndex)
    path = MSG_STRUCT_OUT / fname
    payload = record.model_dump(exclude={"kind"})
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    return path


def write_segment_occurrence(record, registry):
    """Append occurrence to the per-code registry; flushed at end of run."""
    registry[record.code].append(record.occurrence.model_dump())


def flush_segment_registry(registry):
    SEGMENTS_OUT.mkdir(parents=True, exist_ok=True)
    written = []
    for code, occurrences in registry.items():
        path = SEGMENTS_OUT / f"{code}.json"
        if path.exists():
            existing = json.loads(path.read_text())
            existing_occurrences = existing.get("occurrences", [])
        else:
            existing_occurrences = []
        merged = existing_occurrences + occurrences
        path.write_text(
            json.dumps({"code": code, "occurrences": merged}, indent=2, ensure_ascii=False) + "\n"
        )
        written.append(path)
    return written


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("docx", help="Filename inside v2plus_docx/, e.g. CH03_PatientAdmin.docx")
    parser.add_argument("--dry-run", action="store_true", help="Walk the doc and report candidates; no LLM calls")
    parser.add_argument("--limit", type=int, default=None, help="Limit to first N candidate tables")
    parser.add_argument("--include-unknown", action="store_true",
                        help="Also send tables that the heuristic doesn't classify (more thorough, more expensive)")
    args = parser.parse_args()

    docx_path = SOURCE_DIR / args.docx
    if not docx_path.exists():
        print(f"ERROR: {docx_path} does not exist", file=sys.stderr)
        return 2

    chapter_match = re.match(r"CH(\d+)", args.docx)
    chapter_raw = chapter_match.group(1) if chapter_match else ""
    chapter = chapter_raw  # used for provenance.chapter (zero-padded form e.g. "03")
    chapter_num = chapter_raw.lstrip("0") or "0"  # used for clause prefix e.g. "3"

    candidates = []
    for entry in walk_chapter(docx_path, chapter_num):
        hint = likely_extractable(entry["caption_style"])
        if hint == "unknown" and not args.include_unknown:
            continue
        candidates.append({**entry, "hint": hint})

    print(f"Found {len(candidates)} candidate tables in {args.docx}")
    by_hint = defaultdict(int)
    for c in candidates:
        by_hint[c["hint"]] += 1
    for k, v in sorted(by_hint.items()):
        print(f"  {k}: {v}")

    if args.limit:
        candidates = candidates[: args.limit]
        print(f"Limited to first {len(candidates)} candidates")

    if args.dry_run:
        print("\n--- DRY RUN: showing first 3 candidates ---")
        for c in candidates[:3]:
            print(f"\nTable #{c['table_idx']} (clause {c['clause']}, hint={c['hint']})")
            print(f"  Section heading: {c['section_heading']}")
            print(f"  Caption: {c['caption']!r}")
            print(f"  Paragraphs preceding: {len(c['paragraphs'])}")
            md = render_table_as_markdown(c["table"])
            preview = "\n".join(md.splitlines()[:5])
            print(f"  Table preview:\n{preview}")
        return 0

    # Real extraction
    if not os.environ.get("ANTHROPIC_API_KEY"):
        print("ERROR: ANTHROPIC_API_KEY not set", file=sys.stderr)
        return 2

    import anthropic
    client = anthropic.Anthropic()

    seg_registry = defaultdict(list)
    counts = defaultdict(int)
    total_usage = defaultdict(int)

    for i, c in enumerate(candidates, 1):
        # Use the caption (Msg Table Caption / Attribute Table Caption) as the
        # logical sectionHeading + captionText when available; fall back to the
        # numbered Heading text otherwise. Matches what python-docx extraction does.
        section_label = c["caption"] or c["section_heading"]
        provenance = {
            "sourceFile": args.docx,
            "chapter": chapter,
            "clause": c["clause"],
            "sectionHeading": section_label,
            "tableIndex": c["table_idx"],
            "captionText": section_label,
        }
        payload = {
            "provenance": provenance,
            "hint": c["hint"],
            "paragraphs": c["paragraphs"],
            "table_md": render_table_as_markdown(c["table"]),
        }
        print(f"[{i}/{len(candidates)}] table#{c['table_idx']} clause={c['clause']} hint={c['hint']} ... ", end="", flush=True)

        try:
            resp = call_claude(client, payload)
            result = resp.parsed_output
        except Exception as e:
            print(f"FAILED: {type(e).__name__}: {e}")
            counts["error"] += 1
            continue

        u = resp.usage
        for field in ("input_tokens", "output_tokens", "cache_creation_input_tokens", "cache_read_input_tokens"):
            total_usage[field] += getattr(u, field, 0) or 0

        if result.classification == "message_structure" and result.message_structure:
            path = write_message_structure(result.message_structure)
            print(f"msg_structure -> {path.name}")
            counts["msg_structure"] += 1
        elif result.classification == "segment" and result.segment:
            write_segment_occurrence(result.segment, seg_registry)
            print(f"segment {result.segment.code} (queued)")
            counts["segment_occurrence"] += 1
        elif result.classification == "not_extractable" and result.not_extractable:
            print(f"skip: {result.not_extractable.reason}")
            counts["not_extractable"] += 1
        else:
            print(f"BAD RESPONSE: classification={result.classification} but matching field empty")
            counts["bad_response"] += 1

    seg_paths = flush_segment_registry(seg_registry)

    print("\n=== Summary ===")
    for k, v in sorted(counts.items()):
        print(f"  {k}: {v}")
    print(f"  segment files written: {len(seg_paths)}")
    print(f"\n=== Token usage ===")
    for k, v in total_usage.items():
        print(f"  {k}: {v}")
    # rough cost estimate at Sonnet 4.6 pricing
    in_cost = (total_usage["input_tokens"] * 3.0 + total_usage["cache_creation_input_tokens"] * 3.75 + total_usage["cache_read_input_tokens"] * 0.30) / 1_000_000
    out_cost = total_usage["output_tokens"] * 15.0 / 1_000_000
    print(f"  estimated cost: ${in_cost + out_cost:.4f} (input ${in_cost:.4f}, output ${out_cost:.4f})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
