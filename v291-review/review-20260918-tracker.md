# Reviewer notes 2026-09-18 — disposition tracker

Source: `vocab-ig/michael_ig_review_202601918.md`. Working artifact; the
user-facing report is rendered to HTML at session end. One row per item,
numbered in source order. Status: `todo` / `wip` / `done` / `decided` /
`asked` (escalated to a committee) / `dropped`.

## Session 1 — mechanical fixes already decided

| ID | Item | Status | Where |
|---|---|---|---|
| S1-01 | Links from table index rows to ledger pages (only the 449 with anchors) | done | `generate_table_index.py` |
| S1-02 | NUL bytes in `ti-origin` CSS — Python octal-escape bug | done | `generate_table_index.py:600` |
| S1-03 | "this guide" / "in THO" markers confusing on domain column | done | `generate_table_index.py` |
| S1-04 | New column: Ch2c table type (User 399, undefined 193, HL7 176, HL7-EXT 15, External 14, Imported 2) | done | `generate_table_index.py` |
| S1-05 | "Also affects" sentence extended | done | `render_table_ledger.py` |
| S1-06 | Remove `vocabulary-v2mgmt-items.md` parenthetical + all internal paths | done | `render_table_ledger.py` |
| S1-07 | Shade ledger section titles needing a second look | done | `render_table_ledger.py` |
| S1-08 | Table 0821 stated clearly as needing special consideration | done | `render_table_ledger.py` |
| S1-09 | Drop "Inventing definitions…" sentence | done | `provenance.md` |
| S1-10 | Drop `v2plus_docx/` path from authority statement | done | `provenance.md` |
| S1-11 | Authority statement inaccurate — THO supplies content where chapter silent | done | `provenance.md` |
| S1-12 | "an earlier report claimed 18" — state current only | done | `provenance.md` |
| S1-13 | Voice rule swept across IG: no history, no internal paths, no tooling | done | all pages |
| S1-14 | Remove smoke-test reference | done | `known-issues.md` |
| S1-15 | Truncation bullet wrong noun: 16 **ValueSet** descriptions, not concept | done | `known-issues.md` |
| S1-16 | Navbar links only 4 of 7 pages | done | `menu.xml` |
| S1-17 | Section numbering: demote all headings one level, all 7 pages | done | orchestrator, post-agents |
| S1-18 | `table-index.html` missing `--heading-prefix` — was caused by the NUL bytes; now `"3"` | done | orchestrator |

**Session 1 closed at commit `49ecefc3`.** Build exit 0, 15m51s, errors 3478 /
warnings 135 / broken links 0 — baseline on all three. 439 tests pass. Ledger
sections 449 -> 473 after the missing-section fix; 455 index rows link to one.

## Session 2 — decided by reviewer, needs implementation

| ID | Item | Decision | Status |
|---|---|---|---|
| S2-01 | Versioning: editorial carve-out was left in the policy by error | All changes are major; re-increment | done |
| S2-02 | General questions #2, #3, #4 | Answered by S2-01; retire as questions, record as settled | done |
| S2-03 | General question #1 (concept reordering) | Still open — not ruled on | asked |
| S2-04 | Status `N` → `active` | Apply now; note the decision in the IG; it is a technical correction | done |
| S2-05 | Status `B` (5 concepts, 3 tables) | Defer pending V2MGMT | asked |
| S2-06 | THO/Ch2c status discrepancies remain recorded and surfaced | Keep surfacing | done |
| S2-07 | General question #7 (OID conflicts) | Likely technical corrections — reframe | done |
| S2-08 | General question #8 | Keep THO version; note 0719 may need retiring in THO | done |
| S2-09 | General question #9 (table OID) | Leave out of CS/VS; keep extension as a documented option | done |
| S2-10 | Table 0292 | Tentatively treat as a real table, NOT concept-domain-only; flag prominently; final call to TSMG/V2MGMT | done |
| S2-11 | 0567/0568 need real deprecated/retired CS+VS | New TSMG question | done |
| S2-12 | 0350/0351 — THO publishes VS with no matching CS | New item; likely THO's to fix | done |
| S2-13 | `v2-tables` CS retirement | V2MGMT/TSMG question + post-fidelity backlog | done |
| S2-14 | `v2-table-deprecated` vs status: 191 conflicts | Surface as a class, mark every occurrence, propose status=deprecated, do NOT apply | done |
| S2-15 | `CodeSystem.status` has no "deprecated" value | Post-fidelity backlog entry | todo |
| S2-16 | Property-instance suppression mechanism | Needed; means suppressing a value on a concept, not removing a declaration | todo |
| S2-17 | Migrate 7 absent register items into the IG | moved to S3 |  |
| S2-18 | Migrate 9 `vocabulary-future-corrections.md` items into the IG | moved to S3 |  |
| S2-19 | Six flagged tables 0005 0010 0078 0133 0188 0292 | Research out; decisions follow | done |
| S2-20 | Page-URL defects / missing spaces: classify against errata rubric | `technical_correction_guidance.txt` is the rubric | todo |


**Session 2 closed at commit `6a896e44`.** Build exit 0, errors 3479 / warnings
145 / broken links 0, 464 tests. The status column above was reconciled on
2026-09-20 against the commits and the register, not from memory: S2-01, S2-02,
S2-04, S2-08 and S2-10 are named in `6a896e44`'s own message; S2-09 landed in
`e5b31e9a`; S2-07, S2-11, S2-12, S2-13 and S2-14 each exist as a register item
in `vocabulary_escalations.py`; S2-06 is a standing behaviour now in place.
**S2-15, S2-16 and S2-20 are genuinely still open** — a sweep of the tooling and
of `vocabulary-future-corrections.md` finds no trace of any of the three.
S2-17 and S2-18 are the register/backlog items with no IG page, which the ACTIVE
handoff folds into session 3.


## Session 3 — one product

| ID | Item | Status |
|---|---|---|
| S3-00 | v3 narrative links: 191 hrefs rewritten to the THO canonical (reviewer overruled the page-URL choice — the HL7 proxy redirects) | done |
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

## Corrections to earlier briefs — 2026-09-19 (verified, do not re-derive)

- **The 241/36/191 deprecation-flag figures are THIS GUIDE'S OUTPUT, not THO's.** Measured
  against `tho-r5/` alone it is 37 code systems / 246 concepts / 191 `active` + 55 `deprecated`.
  The extra system is `v2-0005`, all 5 of whose concepts are flagged and all `deprecated`, and
  for which this guide writes no CodeSystem. **That exclusion is exactly what makes "none of the
  36 has all its concepts flagged" true** — state the basis whenever the claim is repeated. THO
  also carries the flag with values `2.2` (30 concepts) and `2.6` (14) that never reach our
  output; all 241 of ours are `2.9`.
- **Table 0227 is typed `Imported`, not `External`.** It is still the right sibling for 0292 on
  every other axis (CDO `no`, steward OO, PHIN VADS prose, `Full Name`+`URI` in a table grid,
  published value-set-only over `sid/mvx` via `NamingSystem/MVX`), but the Type differs and the
  register now carries that as a further inconsistency rather than eliding it.
- **The 0005 question was posed wrongly.** `ValueSet/v2-0005` does NOT draw on the retired
  `CodeSystem/v2-0005`; its single include is six CDC race codes from
  `urn:oid:2.16.840.1.113883.6.238`. So "does retiring a CS oblige retiring its VS" does not
  apply. The better question, now asked: is a value set named `v2-0005` that contains none of
  table 0005's codes correctly named?
- **Two more one-OID-two-artifacts cases**, beyond 0001/0078/0719: `2.16.840.1.113883.21.452` is
  the identifier on both `ValueSet/v2-0567` and `ValueSet/v2-0929`; `...21.453` on both
  `v2-0568` and `v2-0930`.
- **No ValueSet anywhere in the THO snapshot uses `relatedArtifact`.** The successor-pointer
  shape proposed for 0567/0568 is unprecedented for THO value sets generally, not only v2 ones.
- Five UTG change-history Bundles mention `CodeSystem/v2-tables` as provenance of past edits,
  on top of the three packaging entries. Still zero definitional dependents.

## Ruling: question 8 / `esc-tho-descriptions-say-more` — 2026-09-19

**Decision (a): carry THO's text for 0227 only; 0719 stays open.**

Implemented as a general condition, not a table number, so it satisfies ADR-0010's
objection. `tho_merge.is_truncated_prefix(ours, theirs)`: our text is a proper prefix of
THO's once whitespace is folded, AND ours does not end in terminal punctuation. Scoped to
`description` via `RECOVERABLE_FIELDS`, because the defect is a ~250-char length cap on
that field; a `name` or `title` that is a prefix of THO's is a genuine disagreement
("Vaccines Administered" vs "Vaccines Administered Code Set") and the chapter wins those.

Measured across every artifact where the chapter's description is a proper prefix of THO's
— **exactly two**, and the terminal-punctuation test separates them precisely as ruled:

| table | chapter | THO | ends mid-sentence | outcome |
|---|---:|---:|---|---|
| 0227 ValueSet | 252 | 423 | yes, at "may be acce" | THO's text recovered |
| 0719 ValueSet | 1,171 | 1,269 | no | chapter's text stands; THO appended its own error note |

Version consequence to check after regeneration: 0227's ValueSet description will now match
THO, so the description no longer counts as a change and it should fall back from **5.0.0 to
THO's 4.0.0** unless something else forces an increment. Confirm this in the run output.

0719 remains open on the real question, which is not its description: whether the artifact
should be **retired in THO**, settled together with its OID conflict (it shares
`2.16.840.1.113883.1.11.20428` with `v3-InformationSensitivityPolicy`).
