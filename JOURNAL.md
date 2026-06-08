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

## ACTIVE — 2026-06-08 (three known pydocx/LLM bugs fixed; cross-validation cleaned up)

**Phase:** ADR-0006 Phase 1 cross-validation now cleaner. The three follow-up paths from the prior handoff (chapter-column drop, primitive-type filter, ACK structureId prompt) are all addressed. Cumulative agreement across CH02/CH02A/CH03/CH07: **124/125 msg structures (99%), 51/52 segments (98%), 82/83 data types (98%)** fully agree. All three remaining diffs are minor known quirks, not bugs.

Template trust submission still in flight on Zulip (#IG creation) — unchanged.

**Branches:**
- `dev/framework` at `877b19e8` (**2 commits ahead of origin** — push blocked, see Pending user actions)
- `origin/main` at `1f8bf2d5` (unchanged)
- `origin/build` at `865ecd74` (unchanged) — still rejected by template-trust until the trust PR lands

### Next session's first move

**Scale to more chapters.** With the cleanup landed, the comparison report will surface only genuine new findings on the next chapter run. CH04A_Orders is the natural next high-stakes target (orders are the largest single domain; any new pydocx parsing gaps would matter most there). Then CH04B, CH11_Patient_Admin, CH08, CH09, CH10. Each chapter is ~$0.5–2 in Sonnet 4.6 cost; full V2.9.1 should land under $15 total. Command: `python3 tooling/scripts/extract_v291_llm.py CHXX_*.docx && python3 tooling/scripts/compare_python_vs_llm.py`.

The ACK structureId prompt tweak is committed but **not yet validated** — the 5 existing `ACK_xxx` LLM-only entries are stale from before the tweak. They'll either drop off naturally when CH03/CH07 are re-extracted (e.g. as part of a broader re-run after another fix) or could be force-cleaned by deleting the 5 stale files and re-running CH03 alone (~$2.30). Not urgent; the cross-validation isn't blocked on it.

### Pending user actions before next Claude session

1. **Refresh the GitHub PAT.** Push failed this session — `GITHUB_PERSONAL_ACCESS_TOKEN` from zshenv is being rejected by GitHub as "Invalid username or token". Credential helper is wired up correctly (it gets invoked; the password it returns just isn't accepted by GitHub). Most likely cause: the PAT generated 2026-06-08 has expired or was revoked. Generate a new fine-grained PAT with `contents: write` on `HL7/v2ig`, update `GITHUB_PERSONAL_ACCESS_TOKEN` in zshenv (and `GH_TOKEN`/`GITHUB_TOKEN` aliases), re-source, and push the two pending commits (`a6ac6ebf`, `877b19e8`).
2. **Check #IG creation Zulip thread** — reply may have landed re: template trust submission. If "send the PR", next concrete step is the one-line PR to `TemplateManager.java` in HL7/fhir-ig-publisher. If feedback to fix something first, do that.

### Cumulative cross-validation results (CH02 + CH02A + CH03 + CH07)

| Section | Common | Fully agree | Remaining (all minor known quirks) |
|---------|--------|-------------|--------|
| Message structures | 125 | 124 (99%) | 1 = ADT_A01 "Usual Work /" Word-paragraph-join (LLM joins with " / ", pydocx strips); 5 LLM-only = stale ACK_xxx pre-tweak |
| Segments | 52 | 51 (98%) | 1 = GSR extra empty row (LLM artifact, prior session); 2 LLM duplicate provenance keys |
| Complex data types | 83 | 82 (98%) | 1 = curly-vs-straight apostrophe (DLN); **0 coverage gaps** (primitives now cross-validated) |

Report: `v291-llm/comparison-report.md` (committed). Cumulative LLM cost across all 4 chapters: ~$4.60 (no new LLM calls this session).

### Build verification status

Unchanged from prior handoff.

- ✅ **Hxx recursive BackboneElement works.** Auto-IG built past validation on the 2026-04-29 19:56 UTC run.
- ✅ **postproc-g full build passes** end-to-end (with `-tx n/a`).
- ❌ **Auto-IG output check rejects** the inline `<script>` tags AND the `.js` files. See ADR-0004 (reversed 2026-04-29). Resolution path: HL7 template trust submission (in flight on Zulip).

### Hot spots if the next auto-IG attempt fails after HL7 trust PR lands

1. **R5 IG parameter format.** Our `v2plus.xml` may still use R4-style `code: "string"` parameters. R5 expects Coding `{system, code}`. Auto-IG warning seen on MVP: "property code is a class JsonPrimitive looking for an object". Not yet investigated for `v2plus.xml`.
2. **Jekyll `menu.xml`.** Templates expect `input/includes/menu.xml`. v2plus.xml-based build is presumably fine here (existed before), but verify if the build chokes on missing includes.
3. **Per-branch backoff.** Even after a successful build, if a subsequent push fails immediately the backoff window may re-engage. Build cycle planning should assume one shot per ~70 min on retries.

### Open blockers (V2 Management decisions, not Claude work)

Unchanged from prior handoff. Documented in `v291-extracted/v2mgmt-review-report.md` Sections 1–16. The Section 9 + 16 Hxx-equivalence question was answered last session by §1.12 errata; the rest stands:

- **REVIEW-0001** — ACK clause 10.4 UAC repeating intentional or typo?
- ACK caption description variants (7 non-standard occurrences)
- NTE description form in MDM_T01/T02 — long vs short form
- `GUARANTOR_INSURANCE` group name in RQI_I01 (typo `+` in clause 11.3.3?)
- "for Additional Demographics" in PATIENT group (5 instances)
- 358 bare "Participation" + 165 OBX mismatches — large-scale standardization
- RDE_O11 RXO "Prescription Order" variant
- 197 FHIR↔raw V291 diffs where FHIR has the better description
- **Section 9 + 16 (refined)**: confirm `Hxx` ≡ `...` ≡ `etc.` per §1.12; confirm MSH/transmission-control exclusion as enforceable invariant; resolve cardinality on the 10 non-MFN placeholder slots; fill `RSP_K11.8-SEGMENT_PATTERN.1` null short/definition; recover `RTB_Knn.8` description; decide whether the §12.3 CH12 order-detail-family narrowing should be encoded as an additional invariant.

---

## Session History

## 2026-06-08 (later) — Three known bugs fixed before scaling LLM extraction further

### Completed

**Fixed the python-docx chapter-column drop on harmony-inserted rows.** Inspected `parse_message_structure_table` in `extract_v291.py` and confirmed it reads `chapter_col = row[3].strip()` unconditionally. Then traced the actual Word cell shape for CH07's ORU_R30 table (`python3 -c "from docx import Document; ..."`): standard rows are 5-cell `['MSH', 'Message Header', '', '2', '2']` with chapter at index 3; harmony rows are 6-cell `['[{GSP}]', 'Person Gender and Sex', '', '', '3', '3']` with an extra empty cell at index 3 and chapter shifted to index 4. Factored out a new `_extract_msg_struct_cols` helper that detects the 6-cell variant — if `row[3]` is empty AND there's a non-empty cell at index 4+, walk forward to find the real chapter. Both `parse_message_structure_table` and `_parse_table_no_header_skip` (the continuation-table variant) now route through this helper, so the fix covers split tables too. Eliminates all 16 false `disagree_both` entries on CH07 from the comparison report.

**Fixed the python-docx primitive-type column filter.** The handoff's framing was "9-column requirement excludes primitives" — that turned out to be wrong. Primitive tables ARE 9-column; the actual bug was the `if not row[0].strip(): continue` filter in `parse_data_type_components_table`. Primitives have empty `SEQ` cells (they're not subdivided into components) but carry real data in length/conf_length/name columns, so the row was being thrown away. Fix: change the empty-row filter to `if not any(cell.strip() for cell in row): continue` — only skip rows where every cell is empty. After re-running extraction, pydocx data type count went from 71 → 83 (added all 12 primitives: DT, DTM, FT, GTS, ID, IS, NM, SI, SNM, ST, TM, TX). All 12 cross-validate cleanly against the LLM extractions that already had them.

**Tightened the LLM structureId prompt rule.** Changed the in-prompt comment from "from the section heading 'ADT^A01^ADT_A01: ...'" (ambiguous; LLM had been synthesizing per-event IDs like `ACK_A03` for legacy ACK captions) to "third caret-separated token of the caption, verbatim". Added an explicit follow-up paragraph with the ACK example: `ACK^R30^ACK` yields `ACK`, NOT `ACK_R30`. The 5 existing stale `ACK_xxx` LLM-only entries remain in place — would need a re-run to validate the prompt fix in practice. Not done this session (cost ~$2.30 for CH03 alone, not worth burning until there's another reason to re-run).

**Re-ran pydocx extraction on the full corpus to verify the two pydocx fixes.** Took ~1 minute. Output counts: 191 segments (unchanged), 427 message structures (unchanged), 83 data types (+12 primitives), 517 events. No warnings, no errors. Spot-checked DT.json (new file, matches the LLM extraction exactly) and ORU_R30_07_233.json (harmony rows now have `chapter: '3'`).

**Regenerated `v291-llm/comparison-report.md`.** New totals: 124/125 msg structures (99%), 51/52 segments (98%), 82/83 data types (98%). All remaining diffs are minor known quirks (1 paragraph-join, 1 GSR row, 1 DLN apostrophe) plus 5 stale ACK_xxx entries from before the prompt tweak.

### Why fix before scaling

The choice was: extract more chapters (potentially uncover more bugs) vs fix the known bugs first. Fixed first because:
- The two known pydocx bugs would have polluted every future comparison report with the same false positives. Distinguishing new genuine findings from known noise on each new chapter is more expensive than fixing the bugs once.
- The 12 primitive types were single-source (LLM-only). Fixing pydocx promoted them to cross-validated — confidence gain on data we already paid for.
- Re-validating the fix on the existing 4 chapters cost $0 (LLM corpus on disk, only re-run pydocx + comparison). Cheaper than any new chapter run.
- Bugs aren't self-correcting; discovering them on more chapters doesn't solve them, just produces more reports with the same noise.

### Why the specific code shapes

- **`_extract_msg_struct_cols` helper over inline branching**: the same row-shape logic is needed in two call sites (`parse_message_structure_table` and `_parse_table_no_header_skip`). Pulling it out avoids drift and gives the bug + fix a clear, named home.
- **Forward-walk for chapter cell over special-casing harmony segments**: the original instinct was to hardcode `GSP/GSR/GSC → chapter '3'`, but that's a maintenance trap — every new harmony segment would need an addition. The structural rule (the 6-cell variant always has the real chapter at index 4 or 5 with empty index 3) generalizes to any future harmony insertions without code changes.
- **`not any(cell.strip() for cell in row)` over a primitive-detection branch**: the alternative was adding a parallel "primitive table" code path. But primitive tables and complex-type tables have the *same shape* (9 columns, same headers) — they only differ in which cells happen to be empty. The right fix is to be less aggressive about row filtering, not to add a parallel branch.
- **Prompt tweak + paragraph over schema change**: could have added a Pydantic validator that rejects synthesized IDs, but that would push the failure to API-call time (rejection + retry burn). Clarifying the prompt prevents the failure upstream and is cheaper.

### Why NOT re-running LLM to validate the ACK prompt tweak

Cost is the issue. Re-extracting CH03 alone (the chapter with multiple ACK captions) is ~$2.30. The tweak is small, the model is being asked to do something simpler than before (verbatim copy vs synthesize), and the existing pattern for non-ACK structures (verbatim copy of the third token) is already what the LLM does correctly. High confidence the tweak works; the only thing we lose by deferring is the empirical confirmation. Will pick up naturally on the next CH03/CH07 re-run.

### Commits this session

On `dev/framework` (NOT pushed — auth blocked, see ACTIVE pending user actions):
- `877b19e8` — Fix pydocx harmony chapter-column drop and primitive-type filter; tweak LLM ACK structureId rule

Branch is now 2 commits ahead of origin (this session's commit + last session's `a6ac6ebf` JOURNAL update).

### Relevant context for next session

- **The `v291-extracted/` corpus on disk is now the post-fix version.** It's gitignored, so the commit doesn't capture it — but any tooling that re-reads it will pick up the fixed data. If a future session inadvertently re-runs `extract_v291.py` against an older version of the script, the fixed data would regress.
- **The 6-cell harmony row pattern is documented in `_extract_msg_struct_cols`'s docstring.** If a future chapter run surfaces a 7-cell or 8-cell variant (more extra empty cells from a different Word artifact), the forward-walk logic handles it automatically — only the docstring needs updating.
- **Comparison report header counts: msg structures common is still 125** — the LLM corpus's 5 stale `ACK_xxx` entries remain as "LLM-only" rather than rejoining "common". The 5 will disappear if/when CH03 + CH07 are re-extracted with the new prompt.
- **The remaining ADT_A01 "Usual Work /" diff is a `render_table_as_markdown` quirk in the LLM script, NOT a pydocx bug**: the Word cell has two paragraphs, the LLM script joins with " / ", pydocx walks raw cell text and gets just "Usual Work". Could be fixed by changing the markdown renderer to use `"\n"` instead of `" / "`, but that'd ripple through cached prompt tokens. Low priority.
- **Push auth root cause**: the credential helper is being invoked correctly (verified via `GIT_TRACE=1`) — it just receives a PAT value that GitHub rejects. Either the value in `$GITHUB_PERSONAL_ACCESS_TOKEN` is expired/revoked, or the env var was unset when the bash session started. Worth checking `echo "$GITHUB_PERSONAL_ACCESS_TOKEN" | head -c 10` after the user refreshes the PAT to confirm the value is what they expect.

---

## 2026-06-08 — LLM extraction extended to data types; CH02 + CH02A + CH07 cross-validated

### Completed

**Added a `data_type` extraction mode to `extract_v291_llm.py`.** Third Pydantic schema alongside `MessageStructureRecord` and `SegmentRecord`: `DataTypeRecord` with a `DataTypeOccurrence` carrying a list of `DataTypeComponent` (9 attrs — sequence, length, confLength, dataType, optionality, tableBinding, name, comments, sectionRef — distinct from segment's 9 by swapping repetition+itemNumber for comments+sectionRef). New caption-style constant `COMPONENT_CAPTION_STYLE = "Component Table Caption"` extends the `likely_extractable` heuristic. System prompt gained a new "# Mode: data_type" section with the column shape and an explicit `comments`/`sectionRef` rules subsection. Also factored out `_flush_registry` as a shared helper between segments and data types, deduping appended occurrences by `(clause, tableIndex)` so re-runs of the same chapter are idempotent (closes the duplicate-provenance follow-up surfaced in the 2026-06-04 segment work).

**Fixed a chapter-suffix regex bug in `extract_v291_llm.py`.** `re.match(r"CH(\d+)", ...)` was dropping the letter suffix on `CH02A_DataTypes.docx` → chapter `"02"` / clause prefix `"2."`, but python-docx uses `"02A"` / `"2A."`. The comparison join would have silently failed for every data type. Changed to `r"CH(\d+[A-Z]?)"`. Same fix prepares the ground for CH04A, CH04B.

**Added a parallel data-type section to `compare_python_vs_llm.py`.** Indexes by `(code, clause, tableIndex)`, compares the 9 component attributes, buckets as `fully_agree` / `agree_with_metadata_diff` / `disagree_components`, surfaces duplicate provenance keys. Mirrors the segment section's shape (one report file, three sections now).

**Fixed `is_pydocx_group_marker` to recognize bracket-only code variants.** CH07's CSU_C09 had two undescribed group markers (`{code: ']', desc: ''}` and `{code: '}', desc: ''}`) that the explicit allowlist `code in ("", "}]")` missed. Slipped markers caused cascading false diffs after position 20. Replaced with a structural check: any code with no alphanumeric chars is bracket-only and therefore a marker. Real segment codes always have alphanums; `ROL|` and similar choice-suffix segments have alphanums in the prefix. ADT_A44_03_80 now correctly buckets as `fully_agree` (was the second residual diff from the 2026-06-04 CH03 work).

**Extracted CH02A_DataTypes (83 tables, $0.74), CH07_Observations (37 tables, $1.38), CH02_Control (16 tables, $0.18).** Total $2.30 for this session, ~$4.60 cumulative across all 4 chapters. Cache reads dominate at scale — CH02A landed at ~$0.009/table (cheaper than CH03's $0.018/table because more table-level homogeneity).

**Restored push capability.** The 2026-04-30 PAT had lapsed (7-day expiry on the `gh` install token); user generated a new PAT and added it to zshenv as `GITHUB_PERSONAL_ACCESS_TOKEN` plus a `GH_TOKEN` alias for `gh`. The initial push attempt failed because the git remote URL had the OLD token baked in (`https://x-access-token:ghp_OLD@github.com/...`) — `git push` uses the URL-embedded credentials, bypassing both env vars and the credential helper. Fix: `git remote set-url origin https://github.com/HL7/v2ig.git` to strip the embedded token, after which `/home/claude/.git-credential-helper` reads `GITHUB_PERSONAL_ACCESS_TOKEN` at each invocation. All 7 commits pushed; branch in sync with origin.

### Results (cumulative across CH02 + CH02A + CH03 + CH07)

| Section | Common | Fully agree | Disagreements |
|---------|--------|-------------|---------------|
| Message structures | 125 | 109 (87%) | 16 = CH07 chapter-column-only (pydocx bug) |
| Segments | 52 | 51 (98%) | 1 = CH03 GSR extra row (LLM, prior session) |
| Complex data types | 71 | 70 (99%) | 1 = curly-vs-straight apostrophe (DLN) |

Plus three "LLM-only" findings worth carrying forward:
- **12 primitive data types** (DT, DTM, FT, GTS, ID, IS, NM, SI, SNM, ST, TM, TX) — python-docx's 9-column filter rejects them entirely; LLM captures them naturally
- **5 ACK structure variants** (ACK_A03, ACK_A33, ACK_R01, ACK_R30, ACK_R31) — LLM picks per-event structureIds while pydocx uses the third caption token (`ACK`) consistently
- **0 false coverage gaps from pydocx** — every pydocx-only entry is accounted for

### Why

- **Per-chapter data_type schema over a generic component schema**: data types and segments have overlapping but distinct 9-attribute shapes. Folding both into one schema (with all 11 attributes as optional) would have produced messier validation and likely confused the LLM about which fields apply. Three flat schemas (one per heuristic hint) keeps each one tight and compiles cleanly through Vertex `structured_outputs` (no repeat of the "schema too complex" failure from 2026-06-04).
- **Idempotent `_flush_registry` over write-each-call**: the segment-side flush was append-only, and the 2026-06-04 handoff flagged that re-running CH03 would have duplicated every segment occurrence. Adding dedupe by `(clause, tableIndex)` while extracting `_flush_registry` for the new data-types code path was the right time to make it idempotent. Cost: ~15 LOC.
- **Group-marker heuristic: structural over allowlist**: maintaining a growing list of bracket variants (`""`, `"}]"`, `"]"`, `"}"`, possibly `">"`, ...) is brittle. The structural rule "no alphanumerics = bracket-only = marker" generalizes cleanly and won't need updating when a new variant appears.
- **Stop signal triggered + investigated, not blindly proceeded**: when CH07 dropped to 17% agreement vs CH03's 98%, the user's "stop if any of them have significant issues" criterion fired. Investigation found the disagreements were all caused by python-docx bugs, not LLM regressions, so proceeding to CH02 was the right call. The handoff documents both findings so the next session knows the LLM corpus is the more reliable source on these points.

### Commits this session

On `dev/framework` (all pushed to origin):
- `27b4f71d` — Add data_type mode to LLM extraction and comparison scripts
- `4a3a76ae` — Extend pydocx group-marker heuristic, add CH02/CH02A/CH07 results

Plus 5 commits inherited from the 2026-06-04 session that were finally pushed this session (`3e3317f7`, `12e31fd7`, `bfb565b2`, `8c1c7a9b`, `f08f9356`).

On `main` / pushed to `build`: none (tooling-only).

### Relevant context for next session

- **Git remote URL no longer carries an embedded token.** Future PAT rotations only need updating `GITHUB_PERSONAL_ACCESS_TOKEN` in zshenv — the credential helper picks up the new value automatically. The lesson: don't bake tokens into remote URLs (they bypass the credential helper and silently expire). If a fresh container re-bakes the URL via some provisioning script, the same `git remote set-url origin https://github.com/HL7/v2ig.git` strips it again.
- **`gh` needs `GH_TOKEN` or `GITHUB_TOKEN`, not `GITHUB_PERSONAL_ACCESS_TOKEN`.** User's zshenv now exports both. If `gh auth status` reports "not logged into any GitHub hosts" in a future session, that's the cause — either re-source the env or re-run `gh auth login --with-token` against `$GITHUB_TOKEN`.
- **The python-docx chapter-column bug is reproducible.** Any chapter that imports GSP/GSR/GSC (or other harmony segments) will show "disagree_both" in the comparison report, all chapter-only. Future-chapter false alarms aside, the fix is in `extract_v291.py` — same Word table-continuation logic that needed CCM_I21/CCR_I16/CCU_I20 splitting on 2026-04-15.
- **CH02A primitives are real data, not LLM hallucination.** Spot-checked DT (`{length: "4..8", confLength: "8", name: "Date"}`) and SI (`{length: "1..4", confLength: "4=", name: "Sequence ID"}`) — both extract correctly from the narrow source tables. The empty `dataType`/`optionality`/`sectionRef` fields aren't missing — primitives genuinely don't have those attributes in the source.
- **Cost calibration update.** Per-chapter LLM cost was: CH02A $0.74 (83 tables), CH07 $1.38 (37 tables but more output tokens — message structures are bigger), CH02 $0.18 (16 tables, mostly small segments). The output-token cost dominates on segment/message work; cache-reads dominate on data types (more schema reuse). Full V2.9.1 should still land under $15 total.
- **`v291-llm/` directory is large now**: 197 message-structure files, 52 segment files, 83 data-type files. All gitignored except `comparison-report.md`. Re-runs locally regenerate; only the report is tracked.

---

## 2026-06-02 → 2026-06-04 — LLM extraction end-to-end on CH03, 98% cross-corpus agreement

### Completed

**Hit a new Vertex `structured_outputs` failure mode and fixed it by splitting the schema by hint.** The 3-table sanity check the prior handoff prescribed failed with `Schema is too complex.` (1 call) and `Grammar compilation timed out.` (2 calls) — different from the org-policy block, this time the structured-decoding grammar compiler rejecting our Pydantic schema. Root cause: `ExtractionResult` was a discriminated union with three `Optional[NestedModel]` fields, which Pydantic generates as `oneOf: [null, $ref]` per optional. The grammar compiler has to enumerate all combinations of which optionals are present × all nested shapes; with three independent optionals + several nested types it timed out. Refactored `extract_v291_llm.py` to drop the discriminated union: the `likely_extractable` heuristic already classifies CH03 tables with 100% coverage (108 msg_structure + 21 segment, 0 unknown), so the client picks the schema (`MessageStructureRecord` or `SegmentRecord`) per call. Each schema is now flat with required fields and small defaults; both compile cleanly. System prompt rewritten from "classify into one of three categories" to "extract per the mode the client picked" while preserving the cached prefix. Added `--offset N` flag to allow targeted segment-table validation (CH03's first segment is candidate 109, so without `--offset` we'd burn 108 message-structure calls to reach it).

**Full CH03 extraction succeeded.** 129/129 tables, 0 errors, $2.31, ~30 minutes. Cache reads dominated after warmup (260k cache_read vs 36k cache_creation). Effective per-table cost dropped from the sanity check's ~$0.04/table to ~$0.018/table on the full run.

**Found and fixed two bugs in `compare_python_vs_llm.py`.**
1. The initial run reported 50/106 disagree_parsed_only and only 55/106 fully_agree. Investigation showed `is_pydocx_group_marker` used substring matching: `"end" in elem.get("description", "")`. "Person Gender and Sex" contains "end" because "Gender" contains "end" as a substring (G-E-N-D-E-R). The heuristic stripped 20 legitimate segments from python-docx and 12 from the LLM corpus, manufacturing fake disagreements at every position after the GSP/GSR row block. Replaced with `desc.startswith("--- ")` — the actual python-docx convention for group markers.
2. The script joined corpuses by filename, but python-docx names files by `enumerate()` index while the LLM names by `tableIndex` — the filenames diverge even when the underlying data is identical. Joined 0 files by filename. Replaced with `(structureId, clause, tableIndex)` from provenance as the join key.

After both fixes: **104/106 fully agreeing (98%)**. The 2 remaining diffs are minor (whitespace + 1-element length).

### Why

- **Per-hint schemas over manual JSON parsing**: the alternative was dropping `messages.parse()` and parsing JSON on our side with client-side Pydantic validation (the workaround weighed back in the 2026-05-01 session). Splitting schemas was both cheaper to implement (~15 lines changed) AND preserves wire-level schema enforcement, which is the whole point of using `structured_outputs` in the first place. The cost paid is that the LLM can no longer override the heuristic to bail out as "not_extractable" — but the heuristic was already 100% on CH03, so this is paying nothing in practice. The "not_extractable" escape hatch can be added back in a future schema-extension if we hit a chapter where it matters.
- **`startswith("--- ")` over substring match**: the python-docx convention is precise — group markers always start with `--- ` (three dashes + space) and have either empty code or `}]`. The substring match was lazy; `startswith` is what the code should have been all along.
- **Provenance-based join over filename-based**: filename should be considered a presentation concern, not the canonical identifier. The provenance triple `(structureId, clause, tableIndex)` is what makes a table-occurrence unique in the source document and is what both extractors agree on.

### Commits this session

On `dev/framework` (local — gh auth lapsed, 3 ahead of origin):
- `3e3317f7` — Split LLM extraction schema by heuristic hint, add --offset flag
- `12e31fd7` — Fix compare_python_vs_llm.py false positives and join key
- `bfb565b2` — Add CH03 cross-validation report, gitignore v291-llm/

On `main` / pushed to `build`:
- None (no IG content changed; tooling-only).

### Relevant context for next session

- **Auth is the immediate blocker on push.** `gh auth status` reports "not logged into any GitHub hosts" — the 7-day PAT from the 2026-04-30 `gh` install lapsed. User refreshes auth → next session pushes. No commits will be lost in the meantime.
- **The "Schema is too complex" failure mode is a Vertex `structured_outputs` constraint, not a Claude limit.** If we add more deeply-nested Pydantic schemas in future tooling, hit it again, the same split-by-classification pattern applies. Worth remembering that complex discriminated unions are the killer; flat schemas with small defaults compile fine.
- **Cache warmup pays off.** First few calls in a run pay full `cache_creation_input_tokens` cost; thereafter `cache_read_input_tokens` dominates. Don't size cost estimates from a `--limit 3` sanity check — it overstates by ~2× compared to a full chapter run.
- **The 2 remaining CH03 diffs are worth glancing at before broader rollout but neither is a script bug.** ADT_A01_03_4 row 12: LLM has "Usual Work /" (the Word cell has two paragraphs; `render_table_as_markdown` joins them with `" / "`), python-docx strips the trailing slash. ADT_A44_03_80: 1-element parsed length difference; not investigated in detail. Both are noise relative to the 98% agreement signal, but they are real signals about edge cases in Word cell handling.
- **The comparison script is now message-structure-only.** CH03 produced 21 LLM-extracted segments at `v291-llm/segments/` (EVN, PID, PV1, ..., GSC) that have no diff counterpart. Adding the segment-side comparison is the natural next tooling extension.
- **Cost calibration for future chapters.** CH03 at $2.31 for 129 tables. CH02_Control is probably similar (control-field tables + vocabulary). The full V2.9.1 corpus has ~696 messages + ~192 segments across 17 chapters; ballpark a $15-25 total LLM cost to extract everything once.
- **`v291-llm/` is gitignored except `comparison-report.md`.** Parallel to how `v291-extracted/*` works. Re-runs locally regenerate the corpus; only the report is the trackable artifact.

---

## 2026-05-07 → 2026-05-15 — Both blockers moved: Vertex unblocked, HL7 template trust path identified + submission in flight

### Completed

**Researched and documented the HL7 IG template trust submission process.** Prior memory framed it as "request inclusion at fhir.org/templates" — that turned out to be a *catalog*, not the trust gate. The actual gate is hardcoded in `HL7/fhir-ig-publisher` → `org.hl7.fhir.publisher.core/src/main/java/org/hl7/fhir/igtools/templates/TemplateManager.java` → `checkTemplateId()` method (~lines 355-373). The PR shape (per merged PRs #889, #1001, #1265) is a one-line addition to the trusted-package-ID array, and the code comment states "changes to this list require discussion with the FHIR Product Director first" — that's Grahame Grieve (`@grahamegrieve`), who has merged every recent template-trust PR. Discussion happens on **#IG creation** stream on chat.fhir.org. Not FHIR-I work group, not Lloyd McKenzie — this is tooling, not spec governance. Memory file `project_template_whitelisting.md` rewritten with the now-known process.

**User extracted the v2plus template into its own GitHub repo and posted in Zulip.** The `local-template/` directory was copied out into `ig-template-v2plus/` (gitignored in this repo via `.gitignore` addition), then pushed to its own GitHub repo. User posted in #IG creation on FHIR Zulip asking how to proceed before opening the PR — the Zulip-first move is the cheapest first step (introduces the template, lets reviewers flag anything to fix before the PR).

**Built `tooling/scripts/probe_structured_outputs.py` (multi-model + raw-error-body version).** Tests `messages.parse()` across Sonnet 4.6, Sonnet 4.5, Haiku 4.5, Opus 4.7, Opus 4.1 (with and without `@default` suffix). Dumps full HTTP status, request_id, and response body for every call so the output can be shown verbatim to GCP/IaaS administrators. Initial uncommitted version of the script (from a prior session) summarized errors as `BLOCKED by org policy` / `NOT FOUND` / `OTHER ERROR`; rewrote to expose the raw error envelope after the user's IaaS team gave a "curious response" suggesting they wanted hard evidence.

**Confirmed Vertex `structured_outputs` policy expansion landed.** User reported on 2026-05-14 that the org policy had been updated; re-ran the probe and confirmed both `claude-sonnet-4-6@default` and `claude-opus-4-7@default` now return `Result: SUCCESS` with valid Pydantic-validated output. Sonnet 4.6 returned `color='ocean blue', reason='...'` (207 input / 34 output tokens); Opus 4.7 returned `color='teal', reason='...'` (265 input / 53 output tokens). The fix the IaaS team applied was adding two values to `constraints/vertexai.allowedPartnerModelFeatures`: `publishers/anthropic/models/claude-sonnet-4-6:structured_outputs` and `publishers/anthropic/models/claude-opus-4-7:structured_outputs` — exactly what the original error message had named.

**Updated memory.** `project_vertex_structured_outputs_block.md` rewritten — was framed as an active blocker, now framed as historical context + a "what to do if it returns" guide pointing at the probe. `project_template_whitelisting.md` rewritten with the concrete TemplateManager.java + Grahame + #IG creation Zulip path. `MEMORY.md` "External Blockers" section renamed to "External State" since neither item is a blocker any more — Vertex is done, HL7 trust is in process.

### Why

- **Probe rewrite over relying on the existing summarizer**: the prior probe printed `BLOCKED by org policy` for the org-policy errors, which is informative for us but not enough to satisfy a skeptical IaaS team. The full GCP error envelope (`{"error":{"code":400,"status":"FAILED_PRECONDITION","message":"Organization Policy constraint constraints/vertexai.allowedPartnerModelFeatures violated for projects/370789798156 attempting to use a disallowed feature structured_outputs..."}}`) is unmistakable — it's GCP's standard error format (not Anthropic's), names the constraint by ID, names the project by number, and even tells the admin exactly what value to add. Letting the IaaS team see that verbatim removed the question of "is this really a GCP-side issue."
- **Zulip-first over PR-first for template trust**: the trust-list change is a one-line PR, but the criteria for what gets accepted are not fully written down — the code comment says "discussion with the FHIR Product Director first." Posting in #IG creation up front is the lowest-cost way to discover whether the template is in shape to be PR'd, or whether something needs to be fixed first. PR feedback would surface the same info but with more wasted work.
- **Memory framing shift "blockers → state"**: the prior framing locked us into thinking of these as walls. With both moving forward — one resolved, one in flight — the right framing is "state to track" so future sessions don't treat them as still-blocking.

### Commits this session

On `dev/framework`:
- (probe + JOURNAL + .gitignore commits below — see "Final state" in handoff)

On `main` / pushed to `build`:
- None (no IG content changed; tooling-only)

### Relevant context for next session

- **Probe script (`tooling/scripts/probe_structured_outputs.py`) is now committed** as a permanent verification tool. Re-run it any time `messages.parse()` starts failing on Vertex — the GCP error envelope is unmistakable and immediately tells you which feature/model needs to be added to the allow list.
- **The current probe still has a couple of cosmetic warts**: (1) older models without the `@default` suffix return Anthropic-format errors saying "output_config: Extra inputs are not permitted" — that's the older models not supporting structured_outputs at all, unrelated to org policy and won't change; (2) older models *with* `@default` return 404 — that's just Vertex not accepting the alias, also unrelated. These aren't bugs in the probe; they're legitimate state of those models on Vertex. If we add a future model (e.g. Sonnet 4.7), add it to the `MODELS` list.
- **The template trust submission has not been opened yet** — waiting on Zulip reply. If the reply lands as "go ahead and PR it", the next concrete step is adding the v2plus template's package ID to the array in `org.hl7.fhir.publisher.core/src/main/java/org/hl7/fhir/igtools/templates/TemplateManager.java` (HL7/fhir-ig-publisher repo) and opening a PR with Grahame as reviewer.
- **The Vertex switch in `extract_v291_llm.py` is from 2026-05-01** — that work is unchanged. With the policy now expanded, the script should run end-to-end. The 3-table sanity check is the natural next-session first move.
- **No build was attempted this session** — auto-IG is still rejected by template-trust on the build branch. That branch's state is unchanged (`origin/build` at `865ecd74`). Don't try push-to-build until the template trust PR lands; it'll just fail in the same way.

---

## 2026-05-01 — LLM extraction switched to Vertex AI, blocked on GCP org policy

### Completed

**Switched `tooling/scripts/extract_v291_llm.py` from direct Anthropic API to Vertex AI** (commit `a0b4b04b`). Replaced `anthropic.Anthropic()` with `AnthropicVertex()` (constructor reads `ANTHROPIC_VERTEX_PROJECT_ID` + `CLOUD_ML_REGION` from env automatically). Removed the `ANTHROPIC_API_KEY` check. Updated model ID to `claude-sonnet-4-6@default` to match the user's convention from `ANTHROPIC_DEFAULT_SONNET_MODEL`. Updated `.claude-dev/provision.sh` to install `anthropic[vertex]` (which pulls `google-auth`) instead of bare `anthropic`. Verified `~/.config/gcloud/application_default_credentials.json` is in place from the user's Claude Code Vertex auth.

**Discovered GCP org policy gate on `structured_outputs` feature.** The 3-table sanity check (`--limit 3` on CH03_PatientAdmin.docx) fails at the first call with `Organization Policy constraint constraints/vertexai.allowedPartnerModelFeatures violated for projects/370789798156 attempting to use a disallowed feature structured_outputs for Partner model claude-sonnet-4-6`. The remaining two calls fail at the schema layer with `output_config.format: Extra inputs are not permitted` — same root cause: the SDK's `messages.parse()` helper sends `output_config.format` to enforce structured output, which is exactly what the org policy gates. Three workarounds documented in JOURNAL ACTIVE; user to choose between requesting org policy expansion (zero code change) and refactoring to manual JSON parsing with client-side Pydantic validation (~30 min).

### Why

- **Vertex over direct API**: user has no Anthropic API key but already authenticates to Anthropic via Vertex (it's how Claude Code itself reaches the model). All the env vars (`ANTHROPIC_VERTEX_PROJECT_ID=nist-gcp-itl-hit`, `CLOUD_ML_REGION=global`) and ADC were already in place — switching the SDK class was the only real change. Pricing on global endpoints matches direct API rates ($3/$15 per M tokens for Sonnet 4.6, no Vertex premium), so the cost-estimate math in the script stays correct.
- **`@default` suffix on model ID**: matches the user's existing convention (`ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6@default`); Anthropic Vertex docs confirm bare `claude-sonnet-4-6` would also work but `@default` is more explicit about routing intent.
- **Stop and hand off rather than refactor**: the manual-JSON-parsing refactor is ~30 min of work plus a second sanity check, and the user signaled an imminent context clear. Better to commit the partial progress (Vertex switch is genuinely useful regardless of which workaround we pick) and let the next session decide between the two paths fresh.

### Commits this session

On `dev/framework`:
- `a0b4b04b` — Switch LLM extraction to Vertex AI client (1 ahead of origin; not pushed)

### Relevant context for next session

- **`messages.parse()` is the gated call**, not `messages.create()`. If we go the manual-JSON-parsing route, the script structure stays the same except the LLM call wraps `client.messages.create()` and we parse `response.content[0].text` ourselves. The `SYSTEM_PROMPT` constant already contains the JSON shape examples — would need to add a "respond with JSON only, no preamble" instruction at the end and swap the Pydantic schema-injection for a textual schema description.
- **Prompt caching still works on Vertex** for plain `messages.create()` — `cache_control: {"type": "ephemeral"}` is wire-compatible. The system-prompt cache savings the script was designed around survive the refactor.
- **Org policy URL**: `https://docs.cloud.google.com/vertex-ai/generative-ai/docs/control-model-access` (from the error message). The specific allowlist entry to request: `publishers/anthropic/models/claude-sonnet-4-6:structured_outputs`. If pursued, may also need entries for other models we plan to use later (Opus 4.7, Haiku 4.5).
- **GCP project number** in the error message is `370789798156`, which corresponds to `ANTHROPIC_VERTEX_PROJECT_ID=nist-gcp-itl-hit`. Useful for the org policy ask if the admin needs the numeric project ID.
- **Both blockers are independent.** The HL7 template-trust whitelist (auto-IG publication) and the GCP `structured_outputs` policy (LLM extraction) can be pursued in parallel — they touch different systems and different stakeholders.

---

## 2026-04-27 → 2026-04-30 — Hxx invariants dropped, tx.fhir.org chase, ADR-0004 reversal blocked on template trust

### Completed

**Dropped both Hxx FHIRPath invariants.** postproc-g full build (kicked off after the previous session) failed at
`StructureDefinitionValidator.validateElementDefinitionInvariant` →
`Unable to find http://hl7.org/v2/StructureDefinition/MFN_Znn#MFN_Znn.5-MF_SITE_DEFINED.2-Hxx`. Two compounding root causes diagnosed: (a) the FHIRPath type-checker can't walk a recursive `contentReference` at validation time (snapshot doesn't yet exist when invariants are checked), and (b) the MSH-exclusion expression `segment.type.first().code.endsWith('/MSH')` cannot be type-checked against the abstract `Segment` base, which is `kind: logical` with **zero differential elements** — there is no `.type` field to walk. Severity (`error` vs `warning`) is irrelevant: the type-check is unconditional and the failure is `java.lang.Error`, not a validation outcome. Stripped `v2-hxx-xor` and `v2-hxx-no-control` from `Hxx.json` and the 15 inlined message-structure sites. Updated `tooling/scripts/inline_hxx_pattern.py` to be self-healing — detect already-inlined parents, strip leftover constraints, refresh stale "slot-level invariant" wording in child definitions. Per-site `definition` now appended with "Per Hxx semantics (StructureDefinition/Hxx, ADR-0007): each occurrence carries exactly one segment OR one nested group, not both; MSH and transmission-control segments (BHS, BTS, FHS, FTS, DSC) are excluded." Added ADR-0007 follow-up listing four candidate paths to re-introduce machine-checkable enforcement (slicing, profile-level Constraint, custom validator, value-set binding on `.segment`). Commit `46ddaf80`.

**Confirmed Hxx recursive BackboneElement pattern works.** After the constraint-drop push (commit `865ecd74` to build), auto-IG ran for 67 minutes and got past TX init, snapshot generation, validation, output generation — no Hxx-related errors anywhere. The recursive `contentReference: #<parent-id>` in the `.group` child resolves correctly when the parent is the same SD. Pattern is validated end-to-end.

**tx.fhir.org outage chased and ruled out.** Two consecutive auto-IG runs on 2026-04-28 (17:19 UTC, 19:31 UTC) failed at TX init with `SocketTimeoutException` reading `https://tx.fhir.org/r5/metadata` (TLS handshake succeeded, then hung). Initial diagnosis was widespread tx.fhir.org outage, then revised when user found a Zulip thread confirming only-yesterday outage. Web research confirmed no IG-side parameter overrides the auto-IG-hardcoded `-tx http://tx.fhir.org` flag (verified against `Publisher.java#setTxServerValue`). By 2026-04-29 morning, tx.fhir.org was healthy — an MVP IG (orphan branch `mvp-test`) built within 2 minutes of push and got past TX init cleanly.

**Reversed ADR-0004 (extracted JS back to .js files), blocked by trust catch-22.** With Hxx working and tx healthy, the next failure surfaced: auto-IG's HTML scanner rejected the inline `<script>` blocks in 15,033 generated `*-testing.html` files with "put the script in a `.js` file in a trusted template (if it is justified and needed)." Source: `local-template/includes/_append.fragment-css.html` injects the `v2-table-filter` IIFE into every page's CSS fragment, and `local-template/includes/fragment-pageend.html` injects `v2-classic-tabs` (under `{% if v2classictabs %}`). Both extracted to standalone files at `local-template/content/assets/js/v2-table-filter.js` and `v2-classic-tabs.js`; replaced the inline blocks with `<script src="assets/js/...">`. Pushed to build (commit `865ecd74`); auto-IG rejected within **5 seconds** with the exact original ADR-0004 error: `Unable to execute 'onLoad' in script 'scripts/ant.xml' as the template '#local-template' is not trusted (reason: Template has file extensions: [.js])`. **Catch-22 confirmed and unresolvable from our side.** ADR-0004 marked "Reversed 2026-04-29" with the new failure quoted; the reversal stays in place because inline is no longer fallback-able (the HTML scanner check would fire again). User to file template-whitelist request to HL7 — only real fix.

**Created `mvp-test` orphan branch as auto-IG probe.** Bare-minimum IG (1 ImplementationGuide, 1 trivial CodeSystem with two concepts, 1 page, default `fhir.base.template`). Pushed at 2026-04-29 20:37 UTC; auto-IG picked it up in <2 min. Failed for two unrelated reasons: missing `input/includes/menu.xml` (template default expects it; Jekyll Liquid Exception during HTML generation), and R5 parameter-format warning ("property code is a class JsonPrimitive looking for an object" — R5 IG `parameter.code` is Coding `{system, code}`, not the R4-style string). Branch left in place as a known-good test article for future "is auto-IG infrastructure working?" probes — fix the two issues next time it's needed.

**Installed `gh` CLI to /home/claude/gh/** (no sudo, no write perm to `/home/claude/bin`). Added to `.claude-dev/provision.sh` so fresh containers restore it. User authenticated as `mfaughn`; confirmed `write` perm on HL7/v2ig but not `admin`, so webhook-listing endpoints return 404. Cannot diagnose webhook delivery from this side. The token in chat scrollback (`ghp_rDDr...`) is 7-day; revoke at session-end if not already done.

### Why

- **Drop invariants over fix invariants**: the FHIRPath engine genuinely cannot type-check recursive contentReferences before snapshot generation. Even rewriting the expressions wouldn't help; the engine throws `java.lang.Error` from the path-walking code, not from semantic validation. Narrative documentation in `definition` text + the structural shape (BackboneElement with segment/group children) preserves what the invariants encoded; machine-checkable re-introduction is now an ADR-0007 follow-up.
- **mvp-test branch over content bisection**: when auto-IG was silent on the build branch, the question was "is auto-IG broken, or is our IG broken?" Bisecting our IG content can't help (the failure mode in question is at TX init, before any content matters). A fresh orphan branch was the cleanest test: if it builds, auto-IG is fine and our build branch is being throttled. It built (got past TX init), proving auto-IG is alive — the build branch was on per-branch backoff.
- **Reverse ADR-0004 over leave-it-inline**: the new HTML-scanner check made inline non-viable. We were going to be blocked either way; the `.js` form at least leaves a clean state for the moment whitelisting happens.

### Commits this session

On `dev/framework` (with origin):
- `46ddaf80` — Drop Hxx FHIRPath invariants, document semantics narratively
- `0cd8fd83` — Add gh CLI to provision.sh for fresh container restore
- `7a7de99a` — Reverse ADR-0004: extract inline scripts back to .js files

On `main` / pushed to `build`:
- `1f8bf2d5` — Merge dev/framework: reverse ADR-0004 (re-externalize JS) (origin/main)
- `865ecd74` — Update from main (origin/build) — currently rejected by auto-IG trust check

On `mvp-test` (orphan, single commit):
- MVP IG pushed at 2026-04-29 20:37 UTC; broken on Jekyll/menu.xml (low priority follow-up)

### Relevant context for next session

- **Whitelisting is the gating action.** The `local-template/content/assets/js/{v2-table-filter,v2-classic-tabs}.js` files are the artifacts the whitelist would cover. Both are <100 lines, minimally adapted from THO's `table.js` pattern, and have no external dependencies beyond jQuery (which is already loaded by the base template via `tabs.js` infrastructure).
- **The base template (`fhir.base.template`) carries a security warning** in the build log: "This content depends on fhir.base.template which is no longer considered secure to use" (link: `https://www.fhir.org/guides/security-notices/2026-03-npm-dependencies.html`). Not blocking yet but worth following up on after whitelist; we may need to migrate to a different base template.
- **Auto-IG output URL** when whitelisting lands: `https://build.fhir.org/ig/HL7/v2ig/branches/build/`. Expected runtime ~70 min for our full IG (the 2026-04-29 19:56 UTC run was 67 min). Per-branch backoff means the first attempt after whitelisting may take 1–2 hours to start.
- **The `mvp-test` branch is left as-is** — orphan, broken on Jekyll/R5-parameter format. If we need the probe again, fix `input/includes/menu.xml` (stub will do) and convert IG `definition.parameter[].code` from string to `{system, code}` Coding form.
- **Per-branch backoff observed**: 18:48 UTC push → auto-IG processed at 19:56 UTC (~70 min delay). New branches process fast (~2 min). Empty commits don't reset the backoff window.
- **The 2026-04-29 19:56 UTC build log is the most informative artifact from this session.** It contains the proof that Hxx works structurally (it built past validation), the snapshot-generation timing (~5 min for the full IG), and the exact form of the HTML-scanner rejection. If diagnosing future builds, that log is worth pulling.
- **postproc-g full build remains the reliable structural verifier** when auto-IG is unavailable — runs in <1 hour with `-tx n/a`. Use `./apptainer/remote-build.sh full` (per MEMORY.md Build Rules).

---

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
