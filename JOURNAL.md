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

## ACTIVE — 2026-04-24 (end of session, builds in flight)

**Phase:** Hxx redefined as a recursive BackboneElement structure (ADR-0007). Pattern inlined at all 15 consuming sites. Pushed to build and (separately) postproc-g full build kicked off; **awaiting both build results**. ADR-0006 Phase 1 LLM extraction prototype still scaffolded, still awaiting `ANTHROPIC_API_KEY`.

**Branches:**
- `dev/framework` at `6a7e44da` (in sync with origin)
- `origin/main` at `a61efd82` (Hxx changes merged)
- `origin/build` at `35228d93` (pushed via `--no-preprocess` since FHIR-only change)

### Next session's first move

**Read both build outputs and report.** Then act on what they tell us — either move forward (to LLM extraction once API key is set) or address whatever the build surfaced.

- **Auto-IG**: `https://build.fhir.org/ig/HL7/v2ig/branches/build/` — if `failure/` directory has appeared with build-start timestamp after this push (commit `35228d93`), fetch `failure/build.log`. Otherwise success means `qa.html`/`index.html` etc.
- **postproc-g full build**: user kicked off via `./apptainer/remote-build.sh full` after this session ended. Check the script's output / logs for completion status.

### Build state context

Pushed to build with commit `35228d93`. Auto-IG expected runtime ~1 hr; postproc-g full build similar. The auto-IG push produced a much larger diff than expected (795 files at the build-branch level) — that's the cumulative carryover of files deleted on main (e.g., `StructureDefinition-ACK-Scheduling-intro.xml`, `StructureDefinition-ACK-intro.xml`) finally propagating to build now that `push-to-build.sh` properly `git rm -rf` the synced trees before re-checkout. Future pushes should be small again.

### Hot spots if a build fails

1. **Snapshot generation for the 15 Hxx-containing SDs.** The recursive BackboneElement pattern was inlined at each site with `contentReference` pointing to the local Hxx slot. If the IG Publisher chokes on the recursion, the failure will likely be in one of: `MFN_Znn`, `QBP_Q11-A` through `-E`, `QBP_Q15`, `QVR_Q17`, `RSP_K11`, `RSP_Znn`, `RTB_Knn`, `PGL_PC6`, `PPG_PCG`, `PPP_PCB`, `PPR_PC1`. The `Hxx.json` SD itself uses the same pattern via internal contentReference — if its snapshot fails, we'll see it directly.
2. **The two new FHIRPath invariants** are `severity: error` (not warning). If the IG Publisher's FHIRPath engine can't parse the expressions, the build will fail with an invariant-related error.
   - `v2-hxx-xor` — exactly one of `.segment` / `.group`
   - `v2-hxx-no-control` — `.segment.type.first().code.endsWith('/MSH')` etc.
   - **Rollback if invariants are the failure**: drop both to `severity: warning` in `Hxx.json` AND in all 15 inlined sites (edit `inline_hxx_pattern.py` constants and re-run, or sed across the message-structure files), push again.
3. **`Hxx.json` itself**: `baseDefinition` changed from `Segment` to `Base`, has its own internal `contentReference: "#Hxx"` (in-SD scope, should work). If it fails, the standalone Hxx SD page in the IG is the canary.

### If the build succeeds

- The recursive BackboneElement pattern is validated. Outstanding follow-ups from ADR-0007 ("Open follow-ups" section): (a) decide whether to keep the `Hxx` entry in the segments CodeSystem, (b) decide whether to move `Hxx.json` out of the `segments/` directory, (c) decide whether to add the §12.3 order-detail-family narrowing as an additional invariant on the four CH12 sites. None are urgent.
- Move on to: (1) ANTHROPIC_API_KEY → run LLM extraction sanity on CH03; (2) any of the V2 mgmt questions that have answers in hand (e.g., REVIEW-0001 ACK clause 10.4).

### If the build fails

- Tail the auto-IG log (the `failure/build.log` URL pattern is `https://build.fhir.org/ig/HL7/v2ig/branches/build/failure/build.log` if a failure dir appears).
- If the failure is in the Hxx recursion (most likely): try inlining the `.group` element with a `type: BackboneElement` whose subelements re-enumerate the segment slot once at depth 1, accepting that depth-2+ nesting is unrepresented (unlikely to occur in practice in V2.9.1).
- If the failure is in the invariant FHIRPath: drop both to `severity: warning` in `Hxx.json` and in all 15 inlined sites (the `inline_hxx_pattern.py` script can be re-run to re-emit, but it would also need editing first to drop severity).

### Pending user actions before next Claude session

1. **Set `ANTHROPIC_API_KEY`** in the shell (`! export ANTHROPIC_API_KEY=sk-ant-...`) so the LLM extraction can run if you want to advance ADR-0006 Phase 1.
2. **Confirm auto-IG status** before doing anything else — the result of this push is the most important new input.

### LLM extraction prototype (no change since prior session)

3-table sanity run command (~$0.01):
```bash
python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx --limit 3
```
Then full chapter (~$0.50–1.00):
```bash
python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx
python3 tooling/scripts/compare_python_vs_llm.py
```
Read `v291-llm/comparison-report.md`. >80% `fully_agree` → prototype validated, extend to CH02A.

### Open blockers (V2 Management decisions, not Claude work)

Documented in `v291-extracted/v2mgmt-review-report.md` (Sections 1–16). Section 16's Q1 (`...` ≡ `Hxx` equivalence) is **now answered** by the V2.9.1 §1.12 errata clauses the user provided this session — Section 9 has been rewritten to reflect that. Remaining open items unchanged from prior handoff:

- **REVIEW-0001** — ACK clause 10.4 UAC repeating intentional or typo?
- ACK caption description variants (7 non-standard occurrences)
- NTE description form in MDM_T01/T02 — long vs short form
- `GUARANTOR_INSURANCE` group name in RQI_I01 (typo `+` in clause 11.3.3?)
- "for Additional Demographics" in PATIENT group (5 instances)
- 358 bare "Participation" + 165 OBX mismatches — large-scale standardization
- RDE_O11 RXO "Prescription Order" variant
- 197 FHIR↔raw V291 diffs where FHIR has the better description
- **Section 9 + 16 (refined)**: confirm `Hxx` ≡ `...` ≡ `etc.` per §1.12 (was Q1, now framed as endorsement); confirm MSH/transmission-control exclusion as enforceable invariant; resolve cardinality on the 10 non-MFN placeholder slots; fill `RSP_K11.8-SEGMENT_PATTERN.1` null short/definition; recover `RTB_Knn.8` description in next extraction pass; decide whether the §12.3 CH12 order-detail-family narrowing should be encoded as an additional invariant.

---

## Session History

## 2026-04-24 (PM) — Hxx redefined as recursive BackboneElement (ADR-0007), 15 sites inlined, pushed to build

### Completed

**V2 management report Sections 9 + 16 rewritten.** User pasted three V2.9.1 source clauses (CH01 §1.12 errata, CH04 §4.2.2.4 "Order detail segment", CH12 §12.3 "Note"). The §1.12 errata is the smoking gun: it explicitly states the future-direction intent that `Hxx` is the formal representation for the open-ended `etc.` / `...` placeholder. Folded the verbatim clauses into Section 9 as a "Source clauses from V2.9.1" subsection; Section 16 (the unification action log) updated with a "Note on equivalence" that defers to Section 9 and adds a new question about whether the MSH/transmission-control exclusion should be encoded as an enforceable invariant. The "is `...` ≡ `Hxx`?" question (was Section 16 Q1) is now answered "yes" per the standard's own stated direction.

**ADR-0007 written and revised mid-session.** Initial draft proposed centralized `Hxx.json` as a recursive logical model with `contentReference: "#Hxx"` referenced via `type` from each consuming SD. User correctly flagged that contentReference is StructureDefinition-scoped — when `Hxx` is composed into a consuming SD via type reference, the `#Hxx` fragment doesn't get rewritten to point to the local Hxx slot. Decision revised to **inline duplication at each of the 15 consuming sites**, with the `.group` element's `contentReference` pointing to the local Hxx slot (always same-SD, always unambiguous). The ADR now documents inline as the decision and centralized-via-type as the rejected alternative, with the contentReference scoping rationale explained.

**`Hxx.json` rewritten** as a recursive BackboneElement-shaped logical model (segment + group children, XOR + transmission-control invariants). `baseDefinition` shifted from `Segment` to `Base`, `meta.profile` reference to `Segment-Profile` removed — Hxx is no longer a segment; it is a sibling structural pattern. Kept in place at `input/sourceOfTruth/segment/segments/Hxx.json` even though it no longer belongs in `segments/` semantically — moving it deferred to ADR-0007's open follow-ups.

**`tooling/scripts/inline_hxx_pattern.py` written + applied to 15 sites.** Idempotent, has `--dry-run`. Walks all message-structure JSON files, finds elements typed as `http://hl7.org/v2/StructureDefinition/Hxx`, replaces each with three elements: the parent BackboneElement (preserving the original `short`/`definition` so per-site semantics stay tailored, dropping the `v2-segment-status: A` extension since the slot is no longer typed as a segment), the `.segment` child (typed as Segment), and the `.group` child (contentReference to the local parent Hxx slot id). Both invariants set to `severity: error` per user direction (the §1.12 wording "*does not limit your choice...except for MSH and other transmission control segments*" is normative, not advisory). The 15 sites cover the 11 from Section 16 (CH05 query patterns + CH08 MFN_Znn) plus the 4 CH12 ORDER_DETAIL CHOICE sites (PGL_PC6, PPG_PCG, PPP_PCB, PPR_PC1).

**Pushed to build.** `dev/framework` (`6040b245`) → `main` (`a61efd82`) → `build` (`35228d93`) via `./push-to-build.sh --no-preprocess` (FHIR-only change, no asciidoc to re-process). The build branch diff was unexpectedly large (795 files) — that's the cumulative carryover of files deleted on main (e.g., the unreferenced `StructureDefinition-ACK-*-intro.xml` files from the 2026-04-23 ACK collapse) finally reaching the build branch now that `push-to-build.sh` properly wipes synced trees before re-checkout. Auto-IG result pending at session-end.

### Why

- **Inline over centralized**: `contentReference` is SD-scoped. When the IG Publisher composes a logical model (Hxx) into a consuming SD via the `type` mechanism, it does not perform the fragment rewrite that would be needed to retarget `#Hxx` from the source SD to the consuming SD's local Hxx slot. The duplication cost (15 sites × ~30 lines of JSON each) is mitigated by an idempotent script and by retaining `Hxx.json` as the canonical reference definition. Centralized would have been cleaner architecturally; inline is the only thing that actually works.
- **Recursive BackboneElement over flat or parallel-array alternatives**: V2.9.1 §1.12 admits both segments AND segment groups in the placeholder, and V2 message order is significant. A flat `Reference(Segment)` cannot represent groups. Parallel typed arrays (`segments[]` + `groups[]`) silently lose the interleaving order between segments and groups in mixed sequences. The single repeating BackboneElement with XOR-per-occurrence (each occurrence is one segment OR one group, the slot itself repeats to express ordered sequences) is the only shape that captures both semantics.
- **Wrapper layer accepted as price of admission**: the BackboneElement adds a structural layer at FHIR-instance time (`{"segment": {...PID...}}`) that doesn't exist in V2 ER7 wire format (just `PID|...`). The wrapper does real work — it's the unit at which "segment XOR group" is decided per occurrence. ADR-0007 documents this explicitly.
- **Severity = error, not warning**: V2.9.1 §1.12 wording "*does not limit your choice of segment or segment groups, except for MSH and other transmission control segments*" is normative — putting MSH in an Hxx slot is forbidden by the standard, not merely discouraged. If the IG Publisher's FHIRPath engine can't validate the expression as written, fall back to warning (documented in JOURNAL ACTIVE as the rollback plan).

### Commits this session

On `dev/framework` (and pushed to origin):
- `43261b5c` — Redefine Hxx as recursive BackboneElement placeholder (ADR-0007) [first version, centralized design]
- `6040b245` — Inline Hxx recursive BackboneElement pattern at 15 sites (ADR-0007 revised) [revised to inline after user feedback]

On `main` / pushed to `build`:
- `a61efd82` — Merge dev/framework: Hxx recursive BackboneElement (ADR-0007)
- `35228d93` — Update from main (origin/build, pushed via `--no-preprocess`)

### Relevant context for next session

- **Auto-IG pending**: result drives next steps. The `.group`-element `contentReference` to local parent Hxx slot is the most novel structural feature in this push — never exercised before in this project. If IG Publisher snapshot generation handles it cleanly, the pattern is validated. If not, fall back is documented in ACTIVE.
- **Why the build-branch diff was 795 files**: not a problem with this push, just a one-time catch-up of file deletions on main (mostly the 113 unreferenced `ACK-*` files from the 2026-04-23 collapse, plus other earlier deletions) finally propagating because `push-to-build.sh` now properly `git rm -rf` synced trees before re-checkout. Future pushes should be small again.
- **The `v2-segment-status` extension on Hxx slots was removed by the inline script** — no consumers in the project enumerate elements by this extension that I'm aware of, but worth keeping in mind if downstream tooling complains.
- **Hxx is no longer a segment by ADR-0007**: it remains in `input/sourceOfTruth/segment/segments/Hxx.json` for now (moving deferred). Tooling that walks `segments/segments/` and assumes segment conformance should either tolerate Hxx's new baseDefinition or filter it out explicitly. The `Hxx` entry in the segments CodeSystem (`meta-resources/segment--v2-cs-segments.json`) is now arguably stale per ADR-0007's open follow-ups; not removed in this session.
- **`fix_dots_placeholder.py` from yesterday is still useful** — it remains the canonical fix for any future literal-`...` instances that surface (e.g., in event or choreography files we haven't grepped yet). `inline_hxx_pattern.py` only handles message-structure files and only converts existing Hxx-typed elements; it does not fix raw `...` literals.

---

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
