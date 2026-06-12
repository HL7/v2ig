# How to Walk the FHIR-vs-docx Review Worklist

## The one-paragraph reminder (read this first)

We extracted all 17 chapters of V2.9.1 three independent ways — python-docx,
LLM, and the existing FHIR StructureDefinitions — and compared them as equal
peers (no single source is treated as "correct"; the Word `.docx` is the thing
you check against when they disagree). That comparison produced **222 structural
differences** between the FHIR SDs and the V2.9.1 source, bundled into **37
decision groups**. Your job now is to walk those groups and decide, for each,
what should happen to the FHIR StructureDefinition. The biggest single pattern
(~18 segments) is just that the FHIR field names are placeholders like `BPX-1`
instead of real names — both extraction pipelines independently have the real
names, so those are easy "fix the SD" calls. The rest are smaller.

## What's done vs. what's next

- **Done:** full extraction, the neutral three-way comparison, and the registry
  tooling (build/worklist/ingest/apply/changelog/escalations). All committed and
  pushed on `dev/framework`. No FHIR SDs have been edited yet.
- **Next (this is the task):** make the decisions, apply the safe ones to the
  SDs, and route the committee-only ones to V2 management.

## The loop

You can do this two ways. **Easiest: just do it with Claude** — open a session,
say "let's walk the worklist," and answer Claude's questions group by group;
Claude records each decision and applies it. If you'd rather work solo in the
file, here's the manual loop:

1. **Regenerate the worklist** (only needed if it's stale):
   ```
   python3 tooling/scripts/review_registry.py worklist
   ```
   Opens/refreshes `v291-review/review-worklist.md`.

2. **Edit `review-worklist.md`.** Each `## [...]` block is one decision with
   three fields to fill:
   - `DIRECTION:` — pick one (see below)
   - `DECISION:` — the value to write into the SD (often blank; see below)
   - `RATIONALE:` — *why* (required). One sentence is fine.

   **Leave a block untouched to skip it for now** — nothing happens to skipped
   blocks, so you can do this in batches across multiple sittings.

3. **Ingest your decisions:**
   ```
   python3 tooling/scripts/review_registry.py ingest
   ```
   Parses the worklist, records decisions into `registry.json`. Tells you how
   many were resolved / escalated / skipped.

4. **Apply the SD fixes** (dry-run first, then for real):
   ```
   python3 tooling/scripts/review_registry.py apply           # dry-run
   python3 tooling/scripts/review_registry.py apply --write    # actually edit SDs
   ```

5. **Regenerate the records:**
   ```
   python3 tooling/scripts/review_registry.py changelog        # the change ledger
   python3 tooling/scripts/review_registry.py escalations      # committee hand-off list
   ```

## The four DIRECTION choices

| DIRECTION | Meaning | DECISION field |
|---|---|---|
| `fix-fhir` | The SD has a defect; edit it to match the source value. | Usually leave blank — it defaults to the value the two agreeing sources share. Fill it only to override. |
| `fhir-already-correct` | The SD is right; the **docx** has the error. No SD change, but it's logged as a docx defect for the next standard iteration. | Leave blank. |
| `fix-both-docx-defect` | Both are wrong. SD gets your corrected value; docx defect is logged. | **Put the corrected value here.** |
| `escalate-v2mgmt` | You can't decide this alone — it needs the V2 Management Group. No SD change. | Leave blank; **put the open question in RATIONALE.** |

## Where things land

- `registry.json` — the source of truth (your decisions live here; tracked in git).
- `fhir-vs-docx-changelog.md` — the complete ledger of every change between the
  FHIR SDs and the docx, split by direction. This is the "what we changed and
  why" record, including known docx errors for the next V2 iteration. (tracked)
- `v2mgmt-escalations.md` — the items you punted to the committee, ready to fold
  into `v291-extracted/v2mgmt-review-report.md`. (regenerable; gitignored)
- `apply-report.md` — what the last `apply` run touched. (regenerable; gitignored)

## Re-running is safe

`build` reconciles without losing your decisions — it refreshes the observed
values, keeps everything you've resolved/escalated, and only adds genuinely new
differences. Once an escalated item is answered by the committee, set a real
DIRECTION on its worklist group and re-run `ingest`.
