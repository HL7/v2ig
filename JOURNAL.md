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

## ACTIVE — 2026-08-18 (CH02C vocabulary IG: text-fidelity decisions D1–D6 applied; ADR-0008 Batch A still the gate)

**Phase:** Building a **separate FHIR IG carrying the V2.9.1 Chapter 2C vocabulary** as CodeSystems and ValueSets. The prior workstream (structural review registry, 222 findings) is **paused mid-flight and untouched** — see the 2026-06-12 entry; `v291-review/registry.json` is still 222/222 `needs-review`.

**Governing requirement (user):** the IG must carry *exactly* what Chapter 2C publishes. Corrections are made **only** when the user decides a specific group is safe, walking the review report group by group. **Every divergence is recorded** — nothing resolved silently.

**Branches:** `dev/framework` at `4dd40dbc`, **pushed to origin** (all 7 commits are safe; the user was restarting their machine for a macOS security update). `origin/main` and `origin/build` unchanged.

### Next session's first move

Ask the user which track to resume — they were mid-review and interrupted by a forced restart, not at a natural boundary.

**Track 1 — finish the review report's text groups.** Three remain, all small and all already grouped in `vocabulary-changelog.md` under "Still outstanding". The obvious next one, because it is the mirror image of the change just made:

- **Missing space after a comma — 10 places.** `Electroneuro (EEG, EMG,EP,PSG)` (0074), `Q23,Q24` (0354), `(e.g.,highest alert severity)` (0367, in all four Description fields), `provider,public health agency` (0396). Surfaced while doing change 004; not asked for, not changed.
- **Mid-sentence double spaces — 129 runs, 94 values.** Dominated by one boilerplate defect: `code system of concepts··which specify` recurring across Code System descriptions. One template, not 38 typos — so it is one decision, not 38.
- **Three dash defects the rule refused to repair** — 0357 `Message is not -conformant`, 0368 `Emergency -stop`, 0919 `Default -.will be assumed`. Each needs a human call; the rule deliberately left them rather than making them worse.

**Track 2 — ADR-0008 Batch A (Identity).** This is the actual gate on generating any resources; B, C and D all depend on it. Batch A decides: which tables get resources at all (the 384 concept-domain-only tables are covered by D1; 7 have empty grids in the source), canonical URLs for the 18 code-bearing tables THO does not publish, whether every CodeSystem gets a ValueSet or only the 438 tables declaring a Value Set block, and resource metadata defaults (version/status/publisher).

**Recommendation:** offer Track 1 first (three short decisions, finishes the text-fidelity pass cleanly), then Batch A. But say so and let the user choose — Batch A is what unblocks actual IG output, and the remaining text groups do not block it.

When Batch A does come up: bring it as a small set of concrete choices with counts and a recommendation, not an open list. That is the format that has worked for every decision so far.

### Pending user actions

1. **Continue through `v291-extracted/vocabulary-review-report.html`** — 76 sections now: 232 decide, 1,314 confirm, 484 informational. The "confirm" bulk is the 1,092 values already changed; the real remaining work is in "decide".
2. **Check #IG creation Zulip thread** — template trust submission, unchanged since June and unrelated to this workstream.

### Where things stand

**Text fidelity — six decisions applied, 1,092 values changed across 1,295 places.** All reproducible from the `.docx`; re-running the extractor gives identical numbers.

| Rule | ADR | Values | Places |
|---|---|---:|---:|
| Leading/trailing whitespace | D2 | 44 | 44 |
| Spaces after a period | D3 | 890 | 1,089 |
| Spaces after a sentence close (`."··`, `.)··`) | D4 | 6 | 6 |
| Repeated spaces in `displayName` | D4 | 66 | 66 |
| Spaces after a comma | D4 | 10 | 10 |
| Dash spacing | D5 | 16 | 18 |
| Comma after `e.g.` / `i.e.` | D6 | 60 | 62 |

**Outstanding: 374 values** — 143 double spaces (all in prose fields; `displayName` is clear), 223 embedded newlines, 8 non-breaking spaces.

**Cross-pipeline agreement held at 739/799 through every change**, with all other buckets unchanged (211 typography, 45 whitespace, 14 LLM truncations, 2 content).

### Non-obvious things the next session must not re-derive

- **The policy is a rule chain in `tooling/scripts/vocabulary_text_policy.py`, not inline in the extractor** — because three scripts must agree on it. Adding a rule means adding one entry to `RULES`; the extractor, the cross-pipeline comparison and the concept-domain generator all pick it up. **74 tests** in `test_vocabulary_text_policy.py`; every "leave it alone" case is a real published value. Run them before and after any rule change.
- **Any comparison must apply the policy to BOTH sides.** The python-docx corpus has the rules baked in and nothing else does. D6 proved the point: inserting a comma made 6 concept domains "differ from THO" by nothing but our own comma, inflating `definition_differs_from_tho` 5 → 11. Fixed by normalizing THO's text too. Whitespace rules were forgiving because most comparisons already fold whitespace; **character-level rules are not**. Ask this question of every new comparison.
- **The dash rule adjusts spacing, never inserts it.** 1,843 of the 2,516 dashes in Chapter 2C prose have no space on either side and are inside `HL7-defined`, `ICD-10`, `OBR-32`, URLs. Six further structural exclusions cover minus signs, `+/-`, German suspended hyphens (`Operationen- und`), line-initial/final dashes, dashes before punctuation, and `X -y` with a lowercase follower. **Do not "simplify" these away** — each one is a real value that would otherwise be corrupted.
- **python-docx is the character-faithful pipeline; the LLM is structural corroboration only.** The LLM has exactly two systematic infidelities, both one-directional and detectable: typographic substitution (211 values — curly quotes/dashes → ASCII, and *prompt instructions do not stop it*), and intermittent truncation at a literal `"` (14 values). Generation must read from `v291-extracted/vocabulary/`.
- **A defect in the published document.** Tables **0685** and **0767** have headings styled `Normal` instead of `Heading 3`, so they are missing from the document's own table of contents. Both were invisible to extraction and their content was being absorbed into 0684 and 0766. Both extractors special-case this. Worth reporting to V2 Management.
- **Do not re-run the LLM extraction casually** — ~$11.60. The corpus is on disk at `v291-llm/vocabulary/` (gitignored). Use `--resume`.
- **26 concept domains are declared by more than one table** (`VolumeUnits` by 0568/0777/0930), so table→domain is not 1:1.
- **55 CH02C symbolic names are not valid code tokens** (`Collector'sComment*`, `PrimaryKeyValue–STF`). Emitted verbatim; an open Batch A/B-adjacent decision.
- **`v291-extracted/vocabulary-changelog.md` is authored content and needed a `.gitignore` exception.** It is not regenerable. New decisions get a new numbered entry there plus a new `D`-numbered decision in ADR-0008.

### Regeneration sequence

After any policy change, run in this order — each step feeds the next:

```
python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/render_vocabulary_review_html.py
```

Then check `git diff --stat v291-fhir/` — unexpected drift there means a rule leaked into output that should only have affected comparison.

### Build verification status

Untouched. No IG content or FHIR StructureDefinitions have been modified in this workstream — it has produced tooling, extracted data and one generated CodeSystem, none of which is in a build yet. Nothing needs to reach `main` or `build`.

### Open blockers

None. Gated only on the user's decisions.

---

## Session History

## 2026-08-18 — CH02C text fidelity: six reviewer decisions applied as a shared rule chain

### Completed

**Walked the review report with the user and applied six text-correction decisions**, 1,092 values across 1,295 places. Each was the user's call on a specific group, not a rule the extractor invented; each is recorded per value and individually reversible.

- **D3, spaces after a period** (890 values, 1,089 places) in descriptive fields — the four `Description` fields plus `definition`, `comment` and `displayName`.
- **D4, three further collapses** — sentence ends where a closing quote or bracket sits between the period and the spaces (6), spaces after a comma (10), and every repeated-space run in `displayName` wherever it sits (66).
- **D5, dash spacing** (16 values) — a separator dash gets one space each side.
- **D6, the missing comma after `e.g.` and `i.e.`** (60 values), including the capitalised sentence-initial forms.

**Built `tooling/scripts/vocabulary_text_policy.py` as an ordered rule chain**, with 74 tests. Each rule reports its own count and its own before/after, so a change is attributed to the decision that authorized it rather than several rules landing in one undifferentiated bucket.

**Opened `v291-extracted/vocabulary-changelog.md`** as the durable ledger — one numbered entry per decision with its rule, scope, per-field counts, examples, downstream effects, and an appendix listing every affected table. Needed a `.gitignore` exception; it is authored content, not regenerable.

**Relabelled the review report's text groups** as "Text changed" versus "Text outstanding", so it answers what has been done and what is still open without the reader decoding rule names.

### Why the specific shapes

- **The policy is a shared module, not extractor code.** The python-docx-vs-LLM comparison has to apply the same rules to both corpuses; otherwise our own deliberate normalization is reported as a pipeline disagreement. Cross-pipeline agreement held at 739/799 through all six changes precisely because of this. The absorbed count (982 values equal only after the policy) is stated in the comparison report rather than dropped.

- **The dash rule adjusts spacing and never inserts it.** The user asked whether "a single space before and after every dash" was ever inadvisable. It is: 1,843 of the 2,516 dashes in Chapter 2C prose have no space on either side and are inside `HL7-defined` (387×), `ICD-10`, `UB-04`, `OBR-32` and URL path segments. Even the narrower "where a space already exists on one side" version breaks negative temperatures (`-16 to -20`), the German suspended hyphen `Operationen- und` (15×), `+/- 2 degrees`, and dashes dangling before a line break. The user chose the one-sided version with hand-built exclusions after seeing the evidence, and a seventh exclusion was added after the first run showed `not -conformant` and `Emergency -stop` becoming worse, not better. Every exclusion is structural rather than a list of table numbers, so it survives a source change.

- **`displayName` gets every run collapsed; descriptions do not.** A display name is a short label, so no run of repeated spaces in one can be meaningful. That argument does not extend to a multi-sentence description, where a double space between two words may be evidence of something a reviewer should see — which is why 143 values remain outstanding, all in prose fields.

- **Rule order encodes attribution.** The period, sentence-close and comma rules run before the display-name sweep, so a change lands under the most specific decision that authorized it. That is why the display-name rule reports 66 rather than 74.

### The finding worth carrying forward

**D6 is the first rule that edits prose rather than whitespace, and it immediately broke a comparison the whitespace rules never touched.** Inserting a comma made 6 concept domains differ from THO by nothing but that comma, inflating `definition_differs_from_tho` from 5 to 11. Fixed by applying the shared policy to THO's text before comparing — the same both-sides principle the cross-pipeline comparison already used. `CodeSystem-conceptdomains.json` came out byte-identical to before.

The general lesson, recorded in ADR-0008 D6: whitespace-only rules are forgiving because most comparisons already fold whitespace. Character-level rules are not. Every comparison in this project now has to be asked whether the other side is subject to the same policy.

### Corrections taken during the session

Two scope questions were resolved by asking rather than guessing, and both changed the work: "description elements" turned out to mean all prose fields including `definition`, and the dash rule needed narrowing from the literal instruction. A third judgement — including the 13 capitalised `E.g.`/`I.e.` sites — was made without asking, since leaving them would have produced an obvious inconsistency within the same sentences.

### Commits this session

On `dev/framework`, **pushed to origin** (`2b38100a..4dd40dbc`):
- `88933379` — Collapse spaces after a period in Chapter 2C descriptive text
- `4dd40dbc` — Add five more Chapter 2C text corrections; restructure policy as a rule chain

The five previously-unpushed commits from the prior session went up with them.

### Still uncommitted, untouched, and not mine

`tooling/scripts/render_message_structures_html.py`, `tooling/scripts/render_three_way_html.py`, `v291-extracted/message-structures-decision-report.html`, `v291-review/three-way-comparison-report.html`, `vocabulary-comparison-report.html` — all dated 2026-06-19, predating this workstream. Flagged to the user three times now; left alone.

---

## 2026-08-17 → 2026-08-18 — CH02C vocabulary: dual-pipeline extraction, concept domains, ADR-0008

### Completed

**Staged THO as the canonical-URL reference.** Downloaded `hl7.terminology.r5` v7.3.0. Confirmed the user's `terminology.hl7.org/hl7.terminology.r5.tgz` link and `packages.fhir.org` resolve to the same artifact. Coverage against CH02C: 397 of the 415 code-bearing tables can reuse a published THO canonical; 18 need minting; 19 THO v2 CodeSystems have no CH02C table.

**Hardened the python-docx vocabulary extractor.** Made the fidelity policy explicit and enforced: strip leading/trailing whitespace and record it, preserve everything else and report it. Recovered three classes of silently-dropped data — Code System Version blocks headed `Version` rather than `Effective Date` (10 tables), a Table Metadata block headed `Table OID` (0227), and table 0827 whose heading uses an en dash. Fixed three latent data-loss bugs that were not yet firing: coded content now appends instead of overwrites, duplicate metadata blocks merge and report the collision, and code rows with content but no value are reported rather than discarded. Added `prune_stale_outputs()` after finding the corpus held 800 files for 799 sections.

**Built LLM vocabulary extraction and cross-validated the whole chapter.** CH02C has no caption styles, so the unit of extraction is the section, not the table — 799 calls instead of 3,791. Metadata blocks are modelled as ordered key/value lists so one-off keys like `THO URL` survive. Ran all 799 concurrently behind a warmed prompt cache in ~20 minutes for ~$11.60. Result: 739 tables identical in every compared field, 5,540 codes on both sides.

**Found a defect in the published document.** Tables 0685 and 0767 carry `Normal`-styled headings, which also drops them from the document's own table of contents. Both were absent from the corpus entirely and their content was being merged into 0684 and 0766, so those two tables were silently publishing the wrong OID, symbolic name and `where used`. The cross-validation surfaced it: the two pipelines disagreed on 0684 because python-docx's merge let the later block win while the LLM kept the first.

**Characterized the LLM's fidelity limits precisely.** Two systematic infidelities, both one-directional: typographic substitution (211 values) and intermittent truncation at a literal double quote (14 values, 53 of 71 quote-bearing cells came through fine). Both are LLM-side; python-docx is correct in every case.

**Built the HTML review catalog.** The user asked for HTML over Markdown and for issues to be categorized. `render_vocabulary_review_html.py` pulls the deviation ledger, the cross-check and the per-table `sourceIssues` into one page, grouped by what is being asked of the reader.

**Generated the concept domains CodeSystem.** 1,522 concepts at THO's canonical URL, version 4.0.0.

**Opened ADR-0008** with D1 and D2 decided and the remaining questions split into four dependency-ordered batches.

### Why

- **Dual-pipeline over single-pipeline** (user choice): the governing requirement is fidelity, and a single extractor's blind spots are invisible from inside it. It paid for itself immediately by exposing the 0685/0767 defect.
- **Preserve internal double spaces, strip only surrounding whitespace**: "obvious typo" is a narrow licence. Stripping surrounding whitespace cannot change meaning; collapsing an internal double space in a display name changes a published value. The conservative default is reversible; silent normalization is not.
- **Group deviations by kind and field** (user request): 375 identical double spaces in one field is one decision, not 375. The report counts decision groups and affected values separately for the same reason.
- **Superset, never subset, at THO's canonical URL**: shipping fewer concepts than THO at THO's URL would make concepts vanish for anyone loading both packages.
- **THO's definitions win on conflict**: 577 of 582 shared definitions already match Chapter 2C exactly, so deferring to THO costs almost nothing and keeps one coherent code system. All 5 exceptions are recorded and individually reversible.
- **Sectioned the LLM calls rather than tabled them**: CH02C's 3,791 tables are small and clustered under 799 headings; per-section calls cut cost roughly fivefold and give the model the context to classify sub-tables.

### Corrections taken from the user

Two claims in an earlier summary were wrong and have been fixed in the artifacts: a CodeSystem **supplement cannot add concepts** (only properties and designations), and the version bump is **routine major-version practice**, not a coordination dependency. The user is a UTG maintainer and TSMG member with the authority to extend this code system.

### Commits this session

On `dev/framework`, not pushed: `42ba81fd` (dual-pipeline extraction + fidelity ledger), `05aa5b2e` (HTML review catalog), `8c686d5e` (concept domains CodeSystem + stale-output pruning), `cfd4a6af` (ADR-0008), plus the correction commit.

### Still uncommitted, untouched, and not mine

`tooling/scripts/render_message_structures_html.py`, `tooling/scripts/render_three_way_html.py`, `v291-extracted/message-structures-decision-report.html`, `v291-review/three-way-comparison-report.html` — all dated 2026-06-19, predating this session. Flagged to the user twice; left alone.

---

## 2026-06-11 → 2026-06-12 — Full V2.9.1 three-way extraction + FHIR-vs-docx review registry

### Completed

**Pushed the 3 pending commits** — the prior session's PAT-rejection blocker was resolved; `dev/framework` is back in sync with origin through `2cbff521`.

**Extracted CH04A_Orders, then batch-extracted the remaining 13 chapters via LLM.** CH04A first as a high-value single test (28 tables, $1.19) — came back clean, validating last session's harmony-row fix on the doubled `Chapter|Chapter` columns. Then batched CH04, CH05, CH06, CH08, CH09, CH10, CH11, CH12, CH13, CH14, CH15, CH16, CH17 (the structural chapters; skipped CH01 intro + CH02C vocabulary). All exit 0, zero errors, batch cost ~$8.31, cumulative full-corpus LLM cost ~$13. The LLM corpus now covers all 17 chapters: 424 msg structures, 191 segments, 83 data types — matching python-docx counts.

**Built `tooling/scripts/compare_three_way.py`** — neutral peer comparison of python-docx | LLM | FHIR StructureDefinitions. Reuses the existing FHIR extractors (`extract_fhir_fields`, `extract_fhir_components`). Per element/dimension it classifies the agreement *configuration* (agree / 2-vs-1 split / 3-way split / coverage gap) without declaring any source authoritative; a 2-vs-1 split names the outlier as the one to **examine against source `.docx`**, explicitly not "the wrong one." Uniform normalization across all three (notably binding zero-padding `00104`≡`104`, which initially produced 3109 false segment splits — fixed via `norm_binding`).

**Built `tooling/scripts/review_registry.py`** — the systematic FHIR-vs-docx delta tracker the user asked for. Subcommands: `build` (reconcile `registry.json` from the comparison, idempotent — preserves authored decisions, refreshes observed values, marks vanished deltas stale, keeps resolved), `worklist` (group findings into walkable decision blocks), `ingest` (parse user decisions back, expand group→per-field, require rationale), `apply [--write]` (auto-apply `fix-fhir`/`fix-both` resolutions to the SDs, stamp `implemented_in`), `changelog` (deviations-only ledger sectioned by direction). Registry has 222 findings → 37 worklist groups. Round-trip TESTED end-to-end: filled BPX group → ingest (22 resolved) → apply --write (placeholders `BPX-1`→`Set ID – BPX` etc.) → changelog → rebuild correctly recognized the fix and did not re-flag. Reverted the BPX test edit afterward (it was a smoke test, not a user-authorized decision).

**Dominant finding:** 18 segments (SAC, BPX, INV, BTX, TCC, BUI, TCD, CNS, EQU, ECD, EQP, NDS, SID, CNN, ECR, ISD, DST + QPD partial) have FHIR field `short` set to a positional placeholder (`BPX-1`) instead of the real field name. Both extraction pipelines independently carry the real names — strong corroboration this is a fix-fhir defect, not a source ambiguity. This collapses ~191 raw `name` splits into ~18 group decisions.

### Why

- **docx as source, not authority** (user's framing): a 2-vs-1 split where two pipelines agree could still be two pipelines sharing a blind spot; and FHIR-vs-docx differences can be the SD *correcting* a docx error, since the SDs are the next standard iteration. So the registry records direction + rationale per resolution rather than presupposing which side is right, and the change ledger doubles as a record of docx defects for the next iteration.
- **Group-level worklist over per-finding**: 222 individual decisions would be unusable; 37 groups (structure+dimension+outlier) make it walkable. The 18-segment placeholder issue is one pattern, not 191 judgments.
- **registry.json tracked, worklist/apply-report ignored**: registry.json is authored content (decisions + rationale) — must survive in git. The worklist and apply-report are regenerable views. The change ledger is durable output, tracked.
- **Auto-apply on resolve** (user choice): resolving a `fix-fhir` entry feeds straight into `apply --write`, which patches the SD and stamps provenance — fast throughput, with the dry-run default and the changelog as the audit trail.
- **Deferred normative-prose capture** (user choice): descriptive prose below tables doesn't affect structural identity, so it's pinned for after the structural review.

### Commits this session

On `dev/framework` (pushed): the 3 previously-pending commits (`a6ac6ebf`, `877b19e8`, `2cbff521`) — now on origin.
Uncommitted at handoff: `compare_three_way.py`, `review_registry.py`, `three-way-comparison-report.md`, `registry.json`, regenerated `comparison-report.md`, `.gitignore` update. See ACTIVE for the list. Tooling/data only — none needs to reach `main`/`build` until SD edits are applied.

### Relevant context for next session

- **The `v291-extracted/` and `v291-llm/` corpora on disk are the post-full-extraction versions** (gitignored). Re-running either extractor regenerates them; the comparison reads them directly.
- **`apply` only handles name / data_type / optionality** so far. length / conf_length live in nested FHIR extensions — `_apply_to_element` returns None for those (they'll show as `no_op` and need a manual pass or a future extension to the applier). Only a handful of findings are in those dimensions.
- **The registry reconciles by deterministic finding id** (`SEG-BPX-001-name`). Re-extracting a chapter and re-running `build` updates values without churning ids or losing decisions.
- **Two trackers, complementary**: `v291-review/registry.json` = element-level (segment fields, data-type components); `v291-extracted/v2mgmt-review-report.md` = message-structure-level + policy questions. Don't merge them.

---

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
