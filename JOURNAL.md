# Project Journal — v2ig

This file is the **session-bridge**: the very top says *where the project is now*; the rest is an append-only log of recent sessions (what was done and why). Entries older than the most-recent few are moved to `JOURNAL-archive.md`.

**How to read this file at session start:**

1. Read the **ACTIVE** section below — that is the next-session bootstrap (current state, pending user actions, the first move, blockers).
2. Skim the most recent session entry under **Session History** for the *why* behind whatever the ACTIVE section refers to.
3. Older entries are useful only when investigating the history of a specific decision; otherwise skip them.

**How to update this file at session end (`/uadf-handoff`):**

1. Append a new entry at the **top** of *Session History* describing what was done, why, and any non-obvious context.
2. Rewrite the **ACTIVE** section so it reflects the new state (overwrite, don't append).
3. If the file is getting long, move the oldest entries to `JOURNAL-archive.md` (target: keep `JOURNAL.md` under ~600 lines so it loads cheaply at session start).

Everything else relevant to picking up work — paths, build commands, architectural rules, environment quirks — lives in `MEMORY.md` (auto-loaded) and `CLAUDE.md` (project conventions). Do not duplicate that content here.

---

## ACTIVE — 2026-04-24 (end of session)

**Phase:** ADR-0006 Phase 1 prototype is **scaffolded but not yet executed end-to-end** — needs ANTHROPIC_API_KEY. Two more `...` placeholder bugs of the same class as MFN_Znn surfaced + got fixed during the session. Auto-IG build still failing as of session end; new build from our 22:49 UTC push had not yet been picked up by the auto-IG builder.

**Branch:** `dev/framework` at `e003713e` (1 commit ahead of `origin/main` — tooling-only, doesn't need to be merged immediately)
**`origin/main`** at `fd4693e2`, **`origin/build`** at `e62ee15c`. All `...` placeholder fixes are on main + build.

### Build state

- All known instances of the literal `...` placeholder bug are fixed (MFN_Znn + 10 query/response patterns: QBP_Q11-A/B/C/D/E, QBP_Q15, QVR_Q17, RSP_K11, RSP_Znn, RTB_Knn). Same root cause as the previously-resolved Varies data type — IG Publisher splits paths on `.`, the literal `...` produced empty path segments.
- Push to build went out at **22:49:43 UTC**, but the auto-IG listing was still showing the previous failure (build start 20:09:43 UTC, QBP_Q11-A error) at session end. **Background poller** still running (`/tmp/build-poller.sh`, bash id `bk1o7t4t3`, logs to `/tmp/build-status.log`, polls every 3 min). Next session: tail that log first, *then* hit the URL directly to confirm.
- If the next failure is **another `...` instance**, re-run `python3 tooling/scripts/fix_dots_placeholder.py --dry-run` first to confirm the script still finds nothing — we may have missed a non-message-structure occurrence (e.g. inside an event or choreography file). If it's a **different bug class**, treat it as the next data-quality issue to chase.

### Pending user actions before next Claude session

1. **Set `ANTHROPIC_API_KEY`** in this shell so the LLM extraction can run. Use the `! export ANTHROPIC_API_KEY=sk-ant-...` form in the prompt (the `!` runs the command in the live session so the env var lands in the assistant's environment).
2. **Verify auto-IG status** — visit `https://build.fhir.org/ig/HL7/v2ig/branches/build/`. If a new `failure/` directory has appeared with a build-start timestamp **after 22:49 UTC**, fetch `failure/build.log` and report the new error. If the build succeeded, you'll see `qa.html`, `index.html`, etc. instead of `failure/`.
3. **Optional**: file a GitHub feature request at `https://github.com/anthropics/claude-code/issues` for per-message timestamps in Claude Code (user said they would).

### Next Claude session's first move

Once API key is set, do a **3-table sanity run** to validate the LLM round-trip end-to-end before spending real money:

```bash
python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx --limit 3
```

Expected cost: ~$0.01. Should produce 3 files in `v291-llm/message-structures/` (the first 3 candidates are all message structures). Verify they parse, look schema-correct, and match the python-docx baseline visually.

Then run the **full chapter** (estimated cost: $0.50–1.00 for all 129 candidate tables — 108 message structures + 21 segments):

```bash
python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx
python3 tooling/scripts/compare_python_vs_llm.py
```

Read the resulting `v291-llm/comparison-report.md`. If `fully_agree` count is high (>80% of common files), the prototype is validated — proceed to CH02A (data types) by extending the schema in the script. If lots of disagreement, the disagreement *kinds* tell you what to iterate on (likely: prompt tweaks for V2 cardinality notation, or the `parsedStructure` group-marker handling).

### Open blockers (V2 Management decisions, not Claude work)

Same list as the prior handoff — none have moved. All documented in `v291-extracted/v2mgmt-review-report.md` (Sections 1–16):

- **REVIEW-0001** — ACK clause 10.4 UAC repeating intentional or typo? (drives whether `ACK-Scheduling` stays separate from `ACK`)
- ACK caption description variants — 7 occurrences with non-standard descriptions
- NTE description form in MDM_T01/T02 — long vs short form
- `GUARANTOR_INSURANCE` group name in RQI_I01 (typo `+` in clause 11.3.3?)
- "for Additional Demographics" in PATIENT group (5 instances)
- 358 bare "Participation" + 165 OBX mismatches — large-scale standardization
- RDE_O11 RXO "Prescription Order" variant
- 197 FHIR↔raw V291 diffs where FHIR has the better description
- **NEW (Section 16)**: 6 questions about the `...` → `Hxx` unification — is `Hxx` semantically equivalent across all 11 message structures? Should `...` remain in any V2.9.1-faithful representation? Was `MFN_Znn.5-MF_SITE_DEFINED.2` `max:1` a typo? What cardinality should the other 10 placeholders have? `RSP_K11.8-SEGMENT_PATTERN.1` has `null` short/definition — fill in or keep faithful? `RTB_Knn.8` description was `"DESCRIPTION NEEDED"` — gap in extraction.

---

## Session History

## 2026-04-24 — `...` placeholder cleanup + LLM extraction prototype scaffolded

### Completed

**Auto-IG build chase, second pass.** Yesterday's session ended with one `...`-placeholder bug fixed (MFN_Znn) and a push to build. That build failed with the **same class of bug** in `QBP_Q11-A`. A grep across `input/sourceOfTruth/message-structure/message_structures/` found 10 more instances of the same pattern (CH05 query patterns). Wrote `tooling/scripts/fix_dots_placeholder.py` — idempotent with `--dry-run` — to do the substitution across all of them in one batch, plus remove a dangling `StructureDefinition/...` reference in `control-manifests/segments.json`. Cardinality was deliberately **not** changed on these 10 (descriptions are weaker than MFN_Znn's "one or more" rationale; per-file review needed). Section 16 of the V2 mgmt review report rewritten to cover the full set of 11 structures + 6 specific questions for the WG. Commits: `5c4d6d82` (MFN_Znn solo) → `02049383` (10 more + script) → merged to main as `fd4693e2` → pushed to build as `e62ee15c`.

**ADR-0006 Phase 1 prototype scaffolded.** Two new scripts on `dev/framework` (commit `e003713e`, tooling-only — not on main yet, doesn't need to go to build):
- `tooling/scripts/extract_v291_llm.py` — walks a chapter docx via python-docx, identifies candidate tables by **caption-style detection** (`Msg Table Caption` / `Attribute Table Caption`), computes clause numbers from Heading 2/3+ counters (mirrors python-docx extractor logic), renders tables as Markdown, calls Claude Sonnet 4.6 with prompt caching on the static system prompt, validates output with Pydantic models (`MessageStructureRecord`, `SegmentRecord`, `NotExtractable` discriminated union), writes one file per occurrence to `v291-llm/{message-structures,segments}/`. Has `--dry-run`, `--limit N`, `--include-unknown` flags. Reports token usage + cost estimate at end.
- `tooling/scripts/compare_python_vs_llm.py` — Phase 1 stretch goal. Per-occurrence diff between `v291-llm/message-structures/` and `v291-extracted/message-structures/`. Normalizes group-marker quirks (python-docx encodes `[{` and `}]` as `type:"segment"` with empty/`}]` codes — different from how the LLM emits them, so we strip both for fair comparison). Bucket classification: fully_agree / agree_with_metadata_diff / disagree_raw_only / disagree_parsed_only / disagree_both. Writes `v291-llm/comparison-report.md`.

**Dry-run validated the doc-walker.** CH03_PatientAdmin.docx gives 129 candidate tables (108 message_structure, 21 segment). Captions correctly attributed (ADT_A01 → caption "ADT^A01^ADT_A01: ADT Message" at clause 3.3.1, table_idx 2 — matches python-docx output exactly). Filename naming convention also matches (`<structureId>_<chapter>_<tableIndex>.json`).

**Memory + workflow updates.**
- `MEMORY.md` Build Rules updated: "**DEFAULT VERIFICATION PATH IS PUSH-TO-BUILD, not local builds.**" User explicitly retired routine subset builds 2026-04-23 — postproc-g full builds run in <1hr, that's the local fallback when push-to-build can't tell us what we need. Don't propose subset builds as routine.
- New feedback memory `feedback_merge_push_authority.md` — Claude is authorized to do `git checkout main && git merge dev/framework && git push origin main && ./push-to-build.sh` after committing build-relevant work, without asking each time. Still confirm before force-push, before bypassing main, or before merging multi-session work the user hasn't seen.

### Why

- **`...` cleanup**: same bug class kept biting us because the python-docx extractor faithfully copied the literal `...` from V2.9.1, but FHIR element-id semantics use `.` as a path separator. One unified script + a single review-report section is cheaper to maintain than chasing each instance separately.
- **Caption-style detection over heading-text matching**: the V2.9.1 docs put the actual table captions (`ADT^A01^ADT_A01: ADT Message`) in dedicated styles (`Msg Table Caption`, `Attribute Table Caption`), separate from numbered headings (`Heading 3` says "ADT/ACK - Admit/Visit Notification (Event A01)"). Detecting on style is far more reliable than regex-matching the heading text.
- **Per-table LLM call vs per-chapter**: per-table makes each extraction independently auditable + lets us iterate on prompts cheaply. Loses some cross-table context but for the V2 schema that doesn't matter much.
- **Sonnet 4.6 + prompt caching, no thinking**: extraction is a structured table-parsing task — adaptive thinking would be overkill and expensive. Strict JSON via Pydantic gives us schema enforcement without prompt-engineering work.

### Commits this session

On `dev/framework` (with origin):
- `5c4d6d82` — Replace literal '...' segment placeholder with Hxx in MFN_Znn
- `02049383` — Replace literal '...' segment placeholder with Hxx in 10 more message structures
- `e003713e` — Add LLM-mediated V2.9.1 extraction scripts (ADR-0006 Phase 1 prototype)

On `main` / pushed to `build`:
- `fd4693e2` — Merge dev/framework: '...' placeholder fix in 10 more message structures (origin/main)
- `e62ee15c` — Update from main (origin/build)

### Relevant context for next session

- **Background process still running**: `bash_id: bk1o7t4t3` runs `/tmp/build-poller.sh` (3-min poll interval, logs `/tmp/build-status.log`). Either kill it (`kill $(pgrep -f build-poller)`) or just leave it — it's lightweight. The script is at `/tmp/build-poller.sh` (also lightweight, regenerated next session if needed).
- **Pip packages installed this session**: `anthropic==0.97.0`, `pydantic==2.13.3`, plus their deps (httpx, anyio, etc.). Already added to `.claude-dev/provision.sh` so fresh containers will pick them up automatically.
- **Sonnet 4.6 model ID**: `claude-sonnet-4-6` — explicit per the user's request (the `claude-api` skill defaults to Opus 4.7 unless the user names a different model; user named Sonnet 4.6 in CLAUDE.md / JOURNAL hint).
- **The `extract_v291_llm.py` heuristic pre-filter** uses caption styles (`Msg Table Caption` / `Attribute Table Caption`). For chapters where these don't apply (e.g. CH02C vocabulary, CH02A data types may have a different style), pass `--include-unknown` to send all tables to the LLM and let it classify. More expensive but more thorough.
- **The Pydantic discriminated union** in the script (`ExtractionResult` with `classification` field) lets the LLM choose between three shapes per table: `message_structure`, `segment`, or `not_extractable`. The "not_extractable" branch with a one-line reason is intentional — it lets us audit *why* the LLM skipped a table (e.g. "introductory matrix", "vocabulary listing") without pretending we extracted nothing.
- **Lesson on the build-failure pattern**: when an IG Publisher snapshot-gen error mentions `"Unable to find parent path X.Y.Z..."` with double-dot at the end, that's almost certainly the literal-`...` bug. Grep for `StructureDefinition/...` first; that finds it instantly.
- **Lesson on the "set env var across messages" pattern**: a regular `Bash` tool call to `export VAR=value` only sets it in that subshell — it doesn't persist. The user-side `! export VAR=value` form works because the runtime treats it as a session-level command. Tell the user to use the `!` prefix when they need to set an env var that I'll consume later.

---

## 2026-04-23 — ACK collapse, V2 mgmt report sections, push-to-build CI fix, ADR-0006

### Completed

**CI build failure diagnosed and fixed.** Auto-ig-builder rejected the `build` branch with `Template has file extensions: [.js]` — the JS-inlining cleanup from ADR-0004 had landed on `main` but never propagated to `build`. Root cause: `git checkout <ref> -- <path>` only adds/updates files; it does not delete files that exist on the destination but no longer exist on the source. Fix in commit `76a75c5c` — `push-to-build.sh` now `git rm -rf` the synced trees before the cross-branch checkout, producing a faithful mirror of main.

**ACK collapse (commit `418b6b19`).** 115 enumerated `ACK-*` StructureDefinitions reduced to 2: `ACK` (canonical, used by 279 messages) and `ACK-Scheduling` (provisional name for the UAC-repeating outlier covering `ACK^S12-S24, S26, S27`, used by 15 messages). Touchpoints updated: 294 message-file `targetProfile` refs, listing page (`input/pagecontent/message-structures.xml`), CodeSystem (`input/sourceOfTruth/meta-resources/message-structure--v2-cs-message-structures.json`), control manifest. The 113 unreferenced ACK files were moved to `_archive/unreferenced-ack-structures/` (gitignored — present locally, never published, never propagated to main/build). Reusable script: `tooling/scripts/collapse_ack_structures.py` (idempotent, has `--dry-run`). Tag `pre-ack-collapse` marks the pre-state.

**V2 management report grew sections 13–15.** `v291-extracted/v2mgmt-review-report.md` now covers ACK collapse with caption-variant exemplars, NTE description form in MDM_T01/T02, and `GUARANTOR_INSURANCE` group name. The renderer (`render_review_report.py`) was fixed so code spans are extracted to placeholders before the underscore-italic substitution — `` `GUARANTOR_INSURANCE` `` was rendering as `GUARANTOR<em>INSURANCE</em>`.

**V291 review report trimmed.** `v291-canonical/v291-review-report.html` no longer dumps the per-ACK-message table (was 115 rows). Replaced with a "Caption-Description Variants" summary that lists only the non-canonical phrasings with exemplar clauses. The per-structure "Occurrences in V2.9.1" table now collapses to count + first/last clause when there are >20 occurrences (ACK was the trigger; other future high-occurrence structures get the same treatment automatically).

**ADR-0006 written: multi-corpus V2.9.1 extraction.** Captures the rationale for adding two new extraction corpuses (LLM-mediated + pandoc-redo) targeting the same JSON schema as `v291-extracted/`, with a 4-way consensus diagram and a bucket-classification framework for the resulting comparison report. Explicitly notes the LLM corpus is a *validator*, not a *generator* — FHIR resources remain the published artifact.

**Project doc reorganization.** Dropped `SESSION-HANDOFF.md` (had drifted out of sync — its "overwritten each session" header was no longer true). Restructured `JOURNAL.md` with an ACTIVE header at the top (current state, overwritten each handoff) plus a Session History below; older entries (everything before 2026-04-15) moved to `JOURNAL-archive.md`. Updated `MEMORY.md` and `CLAUDE.md` to describe the new file layout.

### Why

- **CI**: a silent staleness was hiding from us that build had never received the JS cleanup. Without the `git rm -rf`, we'd keep republishing yesterday's content even after merging to main.
- **ACK**: 115 near-duplicates were noise in the source-of-truth tree. Collapsing them lets us be *precise* about the one real distinction (UAC repetition in scheduling) and surface it for V2 Management review.
- **Reports**: the V2 mgmt discussion document is for humans to reason over, not for machines to consume. Exhaustive 115-row tables push the actual decisions off-screen.
- **ADR-0006**: two corpuses share parsing blind spots. The only way to establish fidelity at the level this project requires is independent multi-pipeline consensus.
- **Doc reorg**: 1,291-line `JOURNAL.md` was being read at every `/uadf-start` for the marginal value of ~150 lines of recent context. Plus `SESSION-HANDOFF.md` had drifted into a misleading state.

### Commits this session (all on `dev/framework`)

- `76a75c5c` — Fix push-to-build.sh to delete files removed on main
- `418b6b19` — Collapse 115 ACK structures into ACK + ACK-Scheduling
- `0f2c2644` — Reorganize JOURNAL.md, drop SESSION-HANDOFF.md, add ADR-0006
- `3a4eae4b` — Fix collapse_ack_structures.py to rewrite name/title/type fields (caught by post-merge build failure)

The `0f2c2644` commit was originally made on `main` by mistake (the user had merged `dev/framework` → `main` mid-session, leaving HEAD on `main` after the next `git checkout`). It was cherry-picked to `dev/framework` and `main` was reset back to `origin/main` — no force-push occurred and main never had the wrong commit pushed.

### Relevant context for next session

- The `_archive/` directory pattern is now a reusable convention: add to `.gitignore`, move stuff there for "in directory tree but not part of the IG and not committed". Useful for future similar collapses.
- Tag `pre-ack-collapse` is on commit `f6b8c074` — fully recoverable if the collapse turns out to be wrong.
- `apply_canonical_to_fhir.py`'s position-based element matching (with segment-code sanity check) is the right pattern for any FHIR-side bulk-edit script — copy that approach for similar tooling.
- The `claude-api` skill should be triggered when implementing the LLM extraction (it provides current Anthropic SDK guidance and prompt-caching patterns).
- The 4-way consensus framework in ADR-0006 explicitly says LLM hallucinations are a real risk — never trust LLM output as a sole source; only as one of N for consensus.
- **Lesson from the ACK-Scheduling build failure**: when renaming a FHIR StructureDefinition, the IG Publisher validates that differential paths start with the value of `type` (or the structure's logical name). Always rewrite all of: `id`, `url`, `name`, `title`, `type`, plus differential `id`/`path` fields. Missing any of these will fail validation at IG Publisher time, not at file-write time. Run a build (or at least a `validator.jar` pass) after any FHIR resource rename.
- **Lesson from accidentally committing to `main`**: `push-to-build.sh` and similar cross-branch operations leave HEAD wherever they finished. Always `git rev-parse --abbrev-ref HEAD` before committing in a session that has touched multiple branches.

---

## Session Handoff - 2026-04-22

### Completed This Session

**FHIR vs V291 canonical comparison + apply pipeline:**
- Added `--canonical` flag to `compare_message_structures.py` (writes suffixed reports). Confirmed FHIR vs raw = 916 diffs, FHIR vs canonical = 1316 — the +400 represents V291 fixes not yet propagated to FHIR.
- Built `tooling/scripts/apply_canonical_to_fhir.py` to shuttle canonical V291 fixes into FHIR message structure JSON. Filters to canonical-only diffs (raw vs canonical key includes v291_value) so we only propagate fixes we actually made, not pre-existing FHIR/V291 disagreements.
- Applied 581 fixes across 320 message structure files: 538 description (e.g. "Software Segment"→"Software", PRT/OBX qualifier names), 40 optionality (R→O on NTE/PRT/ROL), 3 repetition. Group renames intentionally deferred — they require rewriting element IDs and BackboneElements.
- Post-apply: FHIR vs canonical drops from 1316 → 735 discrepancies (cosmetic 619→140, structural 697→595).
- HTML traceability report at `v291-canonical/fhir-apply-report.html`.

**Build infrastructure:**
- Fixed malformed XML in `input/v2plus.xml` line 244 — the `data-type/` `path-resource` block was missing its `<code>` wrapper and `<system>` element, leaving an orphan `</code>`. IG Publisher rejected the file before it could try R4 vs R5 parsing.
- Full build on postproc-g succeeded (~54 min). qa.html: errors=63189, warn=34776, broken-links=16573 — proportional to subset (8446 errors), all known content gaps (FIXME placeholders, missing value sets, `{{v2-table:XXXX}}` placeholders).
- Added safety guards to `push-to-build.sh`: warns if local main is behind origin/main, and warns if the current branch has IG-relevant commits not yet in main. Triggered today by a push-to-build that succeeded against stale main and silently republished prior content.

**SSH/rsync transient failure investigation:**
- Initial postproc-g connection failed with rsync code 255. Diagnosis sequence: interactive ssh worked but `ssh -t` and rsync both hung. After session was killed via `~.`, retries succeeded. `.bashrc`/`.bash_profile` clean. Concluded transient server-side issue, no fix needed.

**Commits on dev/framework:**
- `20d7802f` — Apply V291 canonical fixes to FHIR message structures (319 files, +7188/-660)
- `f100e596` — Fix malformed path-resource parameter in v2plus.xml
- `6e3fd599` — Add safety guards to push-to-build.sh

**Cross-branch:**
- Merged dev/framework → main (user did this manually). origin/main now at `f100e596`.
- Ran push-to-build.sh after the merge. origin/build at `34bc7ca5` ("Update from main") with latest content.
- Auto-ig-builder kicked off — should be building at `https://build.fhir.org/ig/HL7/v2ig/branches/build/`.

### Current State (at end of 2026-04-22)
- Branch: `dev/framework` (1 commit ahead of origin — the push-to-build.sh guards)
- Last checkpoint: `6e3fd599` — Add safety guards to push-to-build.sh
- Tests: 84 message-structure comparison tests pass; 3 pre-existing failures unchanged (registry drift × 2, ER7 leak)
- Working tree: clean (2 untracked .tiff files still hanging around)

### Relevant Context (carried into 2026-04-23)
- **Canonical-only filter**: `apply_canonical_to_fhir.py`'s `_disc_key()` includes `v291_value` so that "we changed V291 from X to Y here" is treated as a fix-to-shuttle even if raw V291 also disagreed with FHIR. If V291 didn't change between raw and canonical, the disc is filtered out — it's an open FHIR/V291 disagreement, not a fix we made.
- **Position-based element matching**: The apply script finds FHIR elements by 1-indexed position from `extract_fhir_segments()`, then sanity-checks that the segment code matches before patching. This avoids brittleness from element-ID assumptions.
- **Why XML fix happened**: The malformed `path-resource` block on line 244 was a hand-edit error — only one block in the file was bad, all others were well-formed. v2plus-subset.xml unaffected. Not a generator bug.
- **push-to-build.sh stale-main bug**: The script's docstring is explicit ("Always pulls from main"), but the user's mental model was "the script handles everything". The new guards prompt for confirmation if main is behind or if the current branch has unmerged IG content.
- **Auto-ig-builder branch naming**: Still constrained to `[A-Za-z0-9_-]`. We're on `build` (flat name), so this is fine.

---

## Session Handoff - 2026-04-16

### Completed This Session
- **V291 reconciliation**: reduced 94 multi-occurrence differences to 35 (83 fixes in fixes.json)
- **Broken extraction investigation**: QBP_Q11 clause 5.3.3.3 is Word parsing artifact (hidden columns); NMD_N02 second table is ACK^N02^ACK mislabeled by caption reuse
- **Cosmetic fixes**: "Segment" suffix removal (313 changes), dash normalization (81), group names (COMPONENT→COMPONENTS), singular/plural alignment
- **PRT/OBX description audit**: 7 typos, 33 segment-code replacements (ORC→Common Order, RXO→Pharmacy/Treatment Order, etc.), 21 qualified observation group fixes (Patient Observation, Specimen Observation, etc.)
- **Review report**: `v291-canonical/v291-review-report.html` — ACK section with 116 messages, yellow-highlighted non-standard captions, per-structure provenance with events, cardinality recommendations
- **New scripts**: `audit_prt_descriptions.py` (clause refs on every finding), `generate_v291_review_report.py`
- Commits: `148c826a`, `7b982c1a`, `285950ba` (3 ahead of origin)

### Current State (at end of 2026-04-16)
- Branch: `dev/framework` (3 commits ahead of origin)
- Last checkpoint: `285950ba` — Fix qualified observation group PRT descriptions
- 83 fixes total, 35 remaining multi-occurrence differences

---

## Session Handoff - 2026-04-15 20:30 UTC

### Completed This Session

**Message Structure Comparison (FHIR vs V291):**
- Built `tooling/scripts/compare_message_structures.py` — compares 418 FHIR structures against V291, categorizes diffs as structural vs cosmetic, generates JSON/Markdown/HTML reports
- 84 tests in `test/test_compare_message_structures.py`, all passing
- Commit: `c2757bd1`

**V291 Extraction Fixes:**
- Split table continuation: CCM_I21 (5→152 rows), CCR_I16 (35→185), CCU_I20 (11→162) — gender harmony insertions split Word tables
- Choice group markers (`<`, `>`, `|`) now parsed in 22+ structures across CH11/12/16/17
- Clause numbers computed from Word heading hierarchy, replacing internal table indices in all provenance
- Commits: `92bd8482`, `385d0074`

**V291 Internal Consistency Report:**
- Built `tooling/scripts/compare_v291_occurrences.py` — compares multiple occurrences of the same structure ID within V291
- Fine-grained classification: bracket_malformed, cardinality, desc_typo, desc_cosmetic, desc_meaningful, etc.
- `--canonical` flag runs against fixed data so resolved issues drop off
- Commit: `898a88c9`, `15fd3232`

**V291 Canonical Pipeline:**
- `v291-canonical/fixes.json` — declarative manifest of all fixes with traceability (35 entries)
- `tooling/scripts/apply_v291_fixes.py` — clones raw → applies fixes → writes canonical + HTML report
- Supports: bulk bracket normalization, description_titleize, description_replace (with segment_filter), pending_review items
- Commits: `f7ddc5f7`, `01e6b391`, `ad83e520`

**ACK Structure Reconciliation (foundational for the 2026-04-23 collapse):**
- Fixed all ACK descriptions: MSH→"Message Header", MSA→"Message Acknowledgment", SFT→"Software", UAC→"User Authentication Credential", ERR→"Error"
- Fixed ERR cardinality in clauses 5.4.4-5.4.7: `[ ERR ]` → `[{ ERR }]`
- **114 of 115 ACK structures now identical** — ready to collapse into single canonical structure
- 1 outlier (clause 10.4, UAC repeating) flagged as REVIEW-0001 for V2 Management

**FHIR Resource Fixes:**
- Varies: moved from segment/segments/ to data-type/ as abstract data type derived from Base
- Hxx: updated description as "any segment or segment group" placeholder
- I12-I15: created 4 event StructureDefinitions (Patient Referral, CH11)
- V2 mgmt review report expanded to 12 sections (Varies, Hxx, QPD, choice groups, O59, message structure findings)
- Commits: `8d7a54fe`, `69f2024c`

**Remaining V291 consistency (after fixes):** 16 structures, 94 differences (down from 24/311)

### Current State (at end of 2026-04-15)
- Branch: `dev/framework` (up to date with origin, 14 commits this session)
- Last checkpoint: `ad83e520` — Fix ACK descriptions, ERR cardinality, add pending review support
- Tests: 84 message structure comparison tests passing; other test suites not re-run
- Working tree: clean (2 untracked .tiff files)
