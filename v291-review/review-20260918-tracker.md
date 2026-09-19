# Reviewer notes 2026-09-18 — disposition tracker

Source: `vocab-ig/michael_ig_review_202601918.md`. Working artifact; the
user-facing report is rendered to HTML at session end. One row per item,
numbered in source order. Status: `todo` / `wip` / `done` / `decided` /
`asked` (escalated to a committee) / `dropped`.

## Session 1 — mechanical fixes already decided

| ID | Item | Status | Where |
|---|---|---|---|
| S1-01 | Links from table index rows to ledger pages (only the 449 with anchors) | wip | `generate_table_index.py` |
| S1-02 | NUL bytes in `ti-origin` CSS — Python octal-escape bug | wip | `generate_table_index.py:600` |
| S1-03 | "this guide" / "in THO" markers confusing on domain column | wip | `generate_table_index.py` |
| S1-04 | New column: Ch2c table type (User 399, undefined 193, HL7 176, HL7-EXT 15, External 14, Imported 2) | wip | `generate_table_index.py` |
| S1-05 | "Also affects" sentence extended | wip | `render_table_ledger.py` |
| S1-06 | Remove `vocabulary-v2mgmt-items.md` parenthetical + all internal paths | wip | `render_table_ledger.py` |
| S1-07 | Shade ledger section titles needing a second look | wip | `render_table_ledger.py` |
| S1-08 | Table 0821 stated clearly as needing special consideration | wip | `render_table_ledger.py` |
| S1-09 | Drop "Inventing definitions…" sentence | wip | `provenance.md` |
| S1-10 | Drop `v2plus_docx/` path from authority statement | wip | `provenance.md` |
| S1-11 | Authority statement inaccurate — THO supplies content where chapter silent | wip | `provenance.md` |
| S1-12 | "an earlier report claimed 18" — state current only | wip | `provenance.md` |
| S1-13 | Voice rule swept across IG: no history, no internal paths, no tooling | wip | all pages |
| S1-14 | Remove smoke-test reference | wip | `known-issues.md` |
| S1-15 | Truncation bullet wrong noun: 16 **ValueSet** descriptions, not concept | wip | `known-issues.md` |
| S1-16 | Navbar links only 4 of 7 pages | wip | `menu.xml` |
| S1-17 | Section numbering: demote all headings one level, all 7 pages | todo | orchestrator, post-agents |
| S1-18 | `table-index.html` missing `--heading-prefix` — recheck after S1-02 | todo | orchestrator |

## Session 2 — decided by reviewer, needs implementation

| ID | Item | Decision | Status |
|---|---|---|---|
| S2-01 | Versioning: editorial carve-out was left in the policy by error | All changes are major; re-increment | todo |
| S2-02 | General questions #2, #3, #4 | Answered by S2-01; retire as questions, record as settled | todo |
| S2-03 | General question #1 (concept reordering) | Still open — not ruled on | asked |
| S2-04 | Status `N` → `active` | Apply now; note the decision in the IG; it is a technical correction | todo |
| S2-05 | Status `B` (5 concepts, 3 tables) | Defer pending V2MGMT | asked |
| S2-06 | THO/Ch2c status discrepancies remain recorded and surfaced | Keep surfacing | todo |
| S2-07 | General question #7 (OID conflicts) | Likely technical corrections — reframe | todo |
| S2-08 | General question #8 | Keep THO version; note 0719 may need retiring in THO | todo |
| S2-09 | General question #9 (table OID) | Leave out of CS/VS; keep extension as a documented option | todo |
| S2-10 | Table 0292 | Tentatively treat as a real table, NOT concept-domain-only; flag prominently; final call to TSMG/V2MGMT | todo |
| S2-11 | 0567/0568 need real deprecated/retired CS+VS | New TSMG question | todo |
| S2-12 | 0350/0351 — THO publishes VS with no matching CS | New item; likely THO's to fix | todo |
| S2-13 | `v2-tables` CS retirement | V2MGMT/TSMG question + post-fidelity backlog | todo |
| S2-14 | `v2-table-deprecated` vs status: 191 conflicts | Surface as a class, mark every occurrence, propose status=deprecated, do NOT apply | todo |
| S2-15 | `CodeSystem.status` has no "deprecated" value | Post-fidelity backlog entry | todo |
| S2-16 | Property-instance suppression mechanism | Needed; means suppressing a value on a concept, not removing a declaration | todo |
| S2-17 | Migrate 7 absent register items into the IG | todo | |
| S2-18 | Migrate 9 `vocabulary-future-corrections.md` items into the IG | todo | |
| S2-19 | Six flagged tables 0005 0010 0078 0133 0188 0292 | Research out; decisions follow | wip |
| S2-20 | Page-URL defects / missing spaces: classify against errata rubric | `technical_correction_guidance.txt` is the rubric | todo |

## Session 3 — one product

| ID | Item | Status |
|---|---|---|
| S3-01 | Fold `vocabulary-review-report.html` into the IG (93 groups, ~2,125 values) | todo |
| S3-02 | Decided (1,528) + Informational (544) become an auxiliary evidence page, not a review ask | decided |
| S3-03 | Reconcile the two disagreeing "needs a second look" computations (index 21 rows vs ledger 97+57) | todo |
| S3-04 | Fourteen tables with nothing written — fold review-report evidence in | todo |

## Session 4 — field mapping and audits

| ID | Item | Status |
|---|---|---|
| S4-01 | Promote `render_field_mapping.py` output into the IG as a page | todo |
| S4-02 | Decide what maps to properties, extensions, or nothing | todo |
| S4-03 | Ch2c steward ↔ THO `structuredefinition-wg` comparison (no steward extension exists in THO) | todo |
| S4-04 | External code systems: verify each has a VS using the v2 table number in its canonical; list gaps | todo |

## Research outcomes — 2026-09-19 (do not re-derive)

**0292 — route is `value-set-only`, not CS+VS.** Five agreeing signals: the chapter's own
tableMetadata grid names the code system (`Full Name: "Vaccines Administered Code System"`,
`URI: http://hl7.org/fhir/sid/cvx`) while the same section says `Concept Domain Only: yes`;
THO publishes a live `ValueSet/v2-0292` composing from that URI; `NamingSystem/CVX` registers
table 0292's own OID (`2.16.840.1.113883.12.292`) against it; sibling table 0227 (MVX) is the
identical CDC shape, flagged `no`, and we already publish it value-set-only; and none of the 14
`External` tables routes to CS+VS. Mechanically free: `classify()` returns at the
`Concept Domain Only == yes` gate (`write_utg_xml.py:574`) before the NamingSystem lookup at
:615 that would resolve it correctly. Minting a CodeSystem would be wrong — zero codes, THO
deliberately publishes no CVX CodeSystem, and it would collide with NamingSystem/CVX's OID claim.

**No tentative-override mechanism exists anywhere.** Searched specifically. Nearest hooks:
ADR-0010's three-part evidence gate (`write_utg_xml.py:580-599`) — but permanent, with no
awaiting-ruling state; the escalation register — prose only, zero coupling to the pipeline;
`MANUAL_CORRECTIONS` in `vocabulary_text_policy.py:515` — right shape (keyed, rationale-bearing)
but scoped to typography; and the `needs-decision` action — means "cannot proceed", not
"proceeded against the chapter deliberately". ADR-0010 explicitly argues against keying overrides
by table number. **Tension is real -> write an ADR before building.**

**0078 — an OID collision WE create.** Chapter claims canonical `ValueSet/v2-0078`, absent from
THO. `ValueSet/v3-ObservationInterpretation` carries the exact OID the chapter prints
(`2.16.840.1.113883.1.11.78`) with a byte-identical CLD; verified as the only ValueSet in the
snapshot with either. We mint `vs-v2-0078.xml` at the chapter's canonical carrying the same OID
-> one OID, two artifacts, the same breach `esc-oid-conflicts` flags for 0719. 0078 is not in
that item. Add it. Do NOT silently drop the identifier.

**0005 —** THO's CodeSystem is already `retired`, concepts already `deprecated`. The ValueSet is
a different artifact (CDC race codes) and is explicitly excluded from the dangling-VS class. Only
live question — does retiring a CS oblige retiring its VS — is THO/TSMG's, and
`esc-0567-0568-deprecation` already asks it in reusable form. Reviewer's guess confirmed: later
ticket, outside this IG.

**0010 / 0188 —** same defect: no concept-domain block. Only 3 of 799 sections have
`conceptDomain: null` (0010, 0188, 9999); of the 149 tables whose description says "No suggested
values", 147 have a domain block and only these two do not. Covered by
`esc-tables-that-should-be-domains`; add the 147-vs-2 count.

**0133 —** THO having CS+VS is THO's *standard* pair shape for a v2 table that owns its codes; we
generate the same pair for 399 tables. Not an anomaly, needs no new item. The anomaly, already in
`esc-0133-contradictory`, is that THO has anything at all for a table the chapter flags CDO and
says 0443 replaced in v2.6, and that both are `active` / `content: complete`.

**0350 / 0351 —** already 2 of the 4 in `esc-tho-dangling-value-sets` (with 0456, 0895), verified
by recomputing the set. No new item.

**0567 / 0568 —** no CodeSystems exist for 0567/0568/0929/0930; all four are ValueSet-only over
UCUM. So `ValueSet.status` is the only lever. THO's one artifact-level mechanism is
`structuredefinition-standards-status`, used 53 times, **every one `trial-use`**; the `deprecated`
code is defined and bindable but has NEVER been used. Correct representation would be
`standards-status = deprecated` with `.status` left `active`, plus `relatedArtifact type=successor`
(R5 ValueSet has no `replacedBy`). **Precedent-setting — tell TSMG so explicitly.** Also: THO's own
`v2-tables` maps 0567 -> `ValueSet/v2-0929` and 0568 -> `v2-0930`, so the canonical collapse is
inside THO too, not only the chapter.

**`v2-tables` can be retired with zero technical breakage.** Across all 4,177 snapshot files: no
ValueSet composes from it, no CodeSystem supplements it, nothing binds to it. Only 3 packaging refs
(IG manifest, two publishing lists) + 1 documentation-only coupling (14 `utg-concept-properties`
entries documented "used only in v2-tables.xml" — they become orphans, an argument FOR retirement).
Our sole consumer is `generate_table_index.py`, read-only, degrades gracefully when absent.

**The 36 deprecation-flagged code systems —** all have `CodeSystem.status = active`, and **0 of 36
have all concepts flagged**. 241 of 2,230 concepts, 10.8%; worst is 0272 at 6/9, mildest 0487 at
2/315. So `v2-table-deprecated` is a concept-level claim; leaving `CodeSystem.status = active` is
correct. Does NOT generalize to 0567/0568, where the whole table is deprecated.

**Concept-status conflict count: 191.** Of 241 concepts carrying `v2-table-deprecated`, status is
`active` 169 / `deprecated` 50 / `N` 22, across 26 of the 36 files. Verified twice by independent
methods after a subagent wrongly reported the two properties always travel together (it
generalized from `cs-v2-0003.xml`, one of the 10 files where they do agree).

**Section numbering root cause.** Template CSS: `h2:before{content: var(--heading-prefix) " ";}`
prints only the page number with no counter, so every `h2` on a page renders the same digit;
`h3:before` adds `counter(sub-section)` and numbers correctly. The template already emits the page
title as `<h2>`. Fix: drop the redundant `# Title` from each page and demote `##`->`###`,
`###`->`####`. Affects all 7 pages. `--heading-prefix` values are 1,2,(missing),4,5,6,7 —
table-index has none, and is also the page that contained NUL bytes; recheck after that fix.

**BUILD ORDER CHANGED:** `generate_table_index.py` now reads the generated `table-ledger.md` to
learn which tables have a ledger section, so it must run **after** `render_table_ledger.py`.
431 of 799 index rows get a ledger link (the ledger emits 449 anchors, but 18 are
"Canonicals with no Chapter 2C table" sections that have no index row).

## Closed during triage

| ID | Item | Outcome |
|---|---|---|
| C-01 | "~21 CS descriptions truncated mid-sentence" | **No such cohort.** Swept all 444: zero in-band without terminal punctuation; 25 run past 400 chars, max 2064, so no ~250 cap operates on that field. Concept definitions and purpose also clean. The defect is 16 **ValueSet** descriptions only, already registered. |
| C-02 | HL7 technical-correction criteria needed from Confluence | Already in repo: `technical_correction_guidance.txt` |
| C-03 | "Do we have the Ch2c field → FHIR mapping?" | Yes — `render_field_mapping.py` → `v291-extracted/vocabulary-field-mapping.{md,html}`. Never wired into the IG. See S4-01. |
| C-04 | Same property code under two URIs in one CodeSystem | Does not occur: 0 instances across all generated resources |
| C-05 | `conceptdomains` binding `v2-table-deprecated` to `#deprecationDate` | THO's, not ours — present verbatim in the `tho-r5` snapshot |
| C-06 | Policy PDFs | Reviewer: fine untracked forever; orphan branch offered as alternative, awaiting confirmation |
