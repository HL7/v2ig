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

## ACTIVE — 2026-04-23

**Phase:** Setup for ADR-0006 multi-corpus V2.9.1 extraction. Reconciliation of FHIR vs python-docx-extracted V291 is largely complete; the remaining items need V2 Management input rather than more Claude work. Doc reorganization just landed.

**Branch:** `dev/framework` (5 commits ahead of `origin/main` at session-end; one of those commits is this reorg)
**Last commit (at handoff time):** the JOURNAL/SESSION-HANDOFF reorganization commit

### Pending user actions before next Claude session

1. **Merge `dev/framework` → `main`**: `git checkout main && git merge dev/framework && git push origin main`. Without this, the next `push-to-build.sh` will republish stale content (the very mistake the new safety guards in `push-to-build.sh` were added to catch).
2. **Run `./push-to-build.sh`**: the script's own fix from this session lets it correctly delete files removed on main, so the JS-inlining cleanup (ADR-0004) plus the ACK collapse will finally reach `origin/build`.
3. **Verify the build**: `https://build.fhir.org/ig/HL7/v2ig/branches/build/` — should now succeed (no more `.js` trust-policy rejection). Confirm that the published listing page shows just `ACK` and `ACK-Scheduling` rather than `ACK-A` … `ACK-DK`.

### Next Claude session's first move

Begin **ADR-0006 Phase 1**: prototype LLM-mediated V2.9.1 extraction on `CH02_Control.docx` (smallest chapter, most familiar content). Goal — emit JSON in the same schema as `v291-extracted/message-structures/*.json` so the existing comparison tooling (`compare_message_structures.py`, `compare_v291_occurrences.py`) applies unchanged. Once the CH02 prototype matches python-docx output to within tolerable noise, iterate on the prompt; then expand to all 17 chapters. After LLM is solid, do the pandoc-redo pass into the same schema. Final deliverable for the phase: a 4-way consensus report (FHIR ↔ python-docx ↔ LLM ↔ pandoc-redo).

Use the `claude-api` skill for the LLM extraction implementation (it triggers when adding/tuning Claude API features). Default to Sonnet 4.6 with prompt caching across the static schema instructions.

### Open blockers (V2 Management decisions, not Claude work)

These are documented in detail in `v291-extracted/v2mgmt-review-report.md` — the ACTIVE list here is just an index:

- **REVIEW-0001** — ACK clause 10.4 UAC repeating intentional or typo? (drives whether `ACK-Scheduling` stays separate from `ACK`)
- ACK caption description variants — 7 occurrences with non-standard descriptions (CH07 `"Acknowledgment"` / `"Observation Message"`, CH13 British spelling, CH17 anti-microbial responses)
- NTE description form in MDM_T01/T02 — long vs short form
- `GUARANTOR_INSURANCE` group name in RQI_I01 (typo `+` in clause 11.3.3?)
- "for Additional Demographics" in PATIENT group (5 instances)
- 358 bare "Participation" + 165 OBX mismatches — large-scale standardization
- RDE_O11 RXO "Prescription Order" variant
- 197 FHIR↔raw V291 diffs where FHIR has the better description (e.g. "Common Order" vs bare "ORC") — V291-side fixes needed in the canonical pipeline

---

## Session History

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

### Commits this session

- `76a75c5c` — Fix push-to-build.sh to delete files removed on main
- `418b6b19` — Collapse 115 ACK structures into ACK + ACK-Scheduling
- (current) — Reorganize JOURNAL.md, drop SESSION-HANDOFF.md, add ADR-0006

### Relevant context for next session

- The `_archive/` directory pattern is now a reusable convention: add to `.gitignore`, move stuff there for "in directory tree but not part of the IG and not committed". Useful for future similar collapses.
- `tag pre-ack-collapse` is on commit `f6b8c074` — fully recoverable if the collapse turns out to be wrong.
- `apply_canonical_to_fhir.py`'s position-based element matching (with segment-code sanity check) is the right pattern for any FHIR-side bulk-edit script — copy that approach for similar tooling.
- The `claude-api` skill should be triggered when implementing the LLM extraction (it provides current Anthropic SDK guidance and prompt-caching patterns).
- The 4-way consensus framework in ADR-0006 explicitly says LLM hallucinations are a real risk — never trust LLM output as a sole source; only as one of N for consensus.

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
