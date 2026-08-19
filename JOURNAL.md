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

## ACTIVE — 2026-08-19 (CH02C vocabulary IG: text fidelity CLOSED; own branch; Batch A is the gate)

**Branch: `dev/v291-vocabulary-ig`, at `34459a3d`, pushed.** As of 2026-08-19
every commit for the V2.9.1 terminology IG lives on this branch and nowhere
else. `dev/framework` was rewound to `2b38100a` and force-pushed; it now
carries only the structural-review workstream plus a branch-map pointer at the
top of its own copy of this file. None of the nine vocabulary commits was ever
on `main`, so nothing was lost. **Do not commit vocabulary work to
`dev/framework`.**

**Phase:** Building a **separate FHIR IG carrying the V2.9.1 Chapter 2C
vocabulary** as CodeSystems and ValueSets. The structural review registry
workstream is **paused mid-flight and untouched** on `dev/framework` —
`v291-review/registry.json` is still 222/222 `needs-review`.

**Governing requirement (user):** the IG must carry *exactly* what Chapter 2C
publishes. Corrections are made **only** when the user decides a specific group
is safe, walking the review report group by group. **Every divergence is
recorded** — nothing resolved silently.

### Next session's first move

**Answer the five open questions below**, then go to ADR-0008 Batch A. The user
worked the entire "decide" queue on 2026-08-18 and asked for these five back;
they are what is owed before the next decision round.

Batch A is the actual gate on generating any resources — B, C and D all depend
on it. Bring it as a small set of concrete choices with counts and a
recommendation, not an open list. That is the format that has worked for every
decision so far.

### The five open questions, in the order they matter

**1. The seven "empty tables" — the earlier discussion is gone, and one of them
is a real defect.** The user recalls a long discussion and asked for a note in
the report about it. It is **not recoverable**: not in the ADR, the change log,
this journal, the V2-management report, or any of the six retained session
transcripts under `~/.claude/projects/-workspace/*.jsonl`. No user turn in any
transcript mentions it. Only the bare count of 7 survived. **It has to be
restated.**

What was established this session, and is now recorded as an open note in the
review report under `src-empty_table_in_source`:

- **Six are harmless.** 0347, 0560, 0910, 0929, 0930 and 0932 each carry a
  stray 1×2 grid with nothing in it — a Word layout artifact sitting beside
  content that extracted fine. 0347 and 0910 have no codes because they are
  `Type: User`, which is expected, not loss.
- **0821 Gender Identity is a defect in the published document.** Its coded
  content grid is six rows by five columns with *every cell blank*, while the
  section declares three code systems (SNOMED CT, FHIR DataAbsentReason, V3
  NullFlavor) and a value set. Both pipelines independently find zero codes, so
  it is the document, not the tooling. Compare 0823 Sexual Orientation, built
  the same way, which does publish its codes. **This one should go to V2
  Management** — it is a bigger finding than the mis-styled headings.

**2. Table 0827 now reads `(M49) .` — a space before the period.** Caused by
this session's own rule: D7 turns a run of non-breaking spaces into one
ordinary space, and 0827 published `(M49)` + NBSP + `.` The value is 339
characters and the old report truncated at 300, so the user could not see it
when they gave the instruction. Deleting a non-breaking space that sits
immediately before sentence punctuation, rather than spacing it, would give
`(M49).` and is probably right — but it is a different decision from the one
taken, so it was asked rather than assumed. Now visible as a new **decide**
group, `space_before_punctuation`, 20 places; the other 19 are published as
printed (`Placer Applications .` in 0119, `...type of BC Component .` in 0577).

**3. The user's "double space after the word *or*" in 0827 does not exist.**
Searched the published raw and the emitted corpus: no `or` is followed by two
spaces anywhere. Most likely they were reading the `␣␣` marks rendered for the
double **non-breaking** space in `ISO 3166␣␣while`. Either way it is resolved —
every NBSP in 0827 is now a single ordinary space. Mentioned so nobody hunts
for it again.

**4. Two "decide" groups the user did not cover**, both now flagged "Still
open" in the report:
- **55 symbolic names that are not valid code tokens** —
  `Collector'sComment*`, `PrimaryKeyValue–STF`,
  `Diet,Supplement,orPreferenceCode`. Emitted verbatim. Note that **D9 already
  decided one case the other way**: concept domain `Masterfile Action Code`
  (0180) uses THO's `MasterfileActionCode`. That is the precedent to weigh in
  both directions.
- **5 concept domains where Chapter 2C contradicts itself** — the first
  description was used. Decide which wins, or report as a source defect.

**5. 0078 was truncation, as the user guessed.** The double space sits at
character ~684 of an 864-character value: `interpretation concepts  (i.e.` It
was collapsed under their `valueSet.Description` instruction. No action; closed.

### Pending user actions

1. **Answer the five above**, then Batch A.
2. **Discuss the 5 THO definition differences with V2 Management and TSMG** —
   0952, 0967, 0675, 0066, 0626. The report now shows them untruncated, with
   word-level highlighting on 0952 (the only close one) and a note on the other
   four saying they are unrelated definitions rather than two versions of one.
3. **Check #IG creation Zulip thread** — template trust submission, unchanged
   since June and unrelated to this workstream.

### Where things stand

**Text fidelity is CLOSED.** Nine decisions (D1–D9), 1,240 values changed
across 1,459 places. **No run of two or more spaces survives anywhere in the
corpus** except table 0496's ditto mark, which is preserved deliberately.

| Rule | ADR | Values | Places |
|---|---|---:|---:|
| Leading/trailing whitespace | D2 | 44 | 44 |
| Spaces after a period | D3 | 891 | 1,090 |
| Spaces after a sentence close | D4 | 6 | 6 |
| Repeated spaces in `displayName` | D4 | 66 | 66 |
| Spaces after a comma | D4 | 10 | 10 |
| Dash spacing | D5 | 16 | 18 |
| Comma after `e.g.` / `i.e.` | D6 | 60 | 62 |
| Stray `Â` before a space | D7 | 1 | 1 |
| Private-use-area character | D7 | 1 | 3 |
| Non-breaking space in text | D7 | 2 | 5 |
| Line-initial indent → two spaces | D7 | 2 | 4 |
| Every remaining run of spaces | D7 | 141 | 150 |

**Still outstanding:** 223 embedded newlines (preserved — genuine paragraph
structure), 20 spaces before punctuation (new, question 2 above), 10 missing
spaces after a comma, 3 dash defects the rule refused to repair (0357, 0368,
0919), and 2 characters with no verdict — `Ø` (NCPDP's slashed zero, 8 places
in 0396) and `‑` non-breaking hyphen (4 places in 0945).

**Cross-pipeline agreement rose to 740/799** (was 739). Remaining: 210
typography, 45 whitespace, 14 LLM truncations, 1 content (0496, adjudicated), 3
structural (all table 0227, all parked behind D8).

**Review report: 8 decide, 8 decided, 55 confirm, 14 informational.**

### Non-obvious things the next session must not re-derive

- **The policy is a rule chain in `tooling/scripts/vocabulary_text_policy.py`,
  not inline in the extractor** — because three scripts must agree on it.
  Adding a rule means adding one entry to `RULES`; the extractor, the
  cross-pipeline comparison and the concept-domain generator all pick it up.
  **96 tests** in `test_vocabulary_text_policy.py`; every "leave it alone" case
  is a real published value. Run them before and after any rule change.
- **Any comparison must apply the policy to BOTH sides.** Bitten twice now. D6:
  inserting a comma made 6 concept domains "differ from THO" by nothing but our
  own comma. D7: the `Â` repair originally matched `Â` + non-breaking space,
  which is what python-docx sees, but the LLM substitutes an ASCII space there
  — so the rule fixed one corpus and not the other and the comparison reported
  our own rule as a pipeline disagreement. **Ask this question of every
  character-level rule.**
- **Rule order in `RULES` encodes attribution, and it is load-bearing.**
  Character repairs run first because each leaves work for the next (drop the
  `Â` → a non-breaking space remains → becomes an ordinary space → leaves a
  double space after a period → D3 collapses it: one defect, three rules, three
  log entries). Narrow space rules run before broad ones. **Dash spacing must
  stay ahead of the general collapse** — putting the collapse first silently
  absorbed five of D5's changes into D7's count. Caught only because each rule
  reports its own count and D5's fell 16 → 11.
- **The dash rule adjusts spacing, never inserts it.** 1,843 of the 2,516
  dashes in Chapter 2C prose have no space on either side and are inside
  `HL7-defined`, `ICD-10`, `OBR-32`, URLs. Six further structural exclusions
  cover minus signs, `+/-`, German suspended hyphens (`Operationen- und`),
  line-initial/final dashes, dashes before punctuation, and `X -y` with a
  lowercase follower. **Do not "simplify" these away.**
- **Exclusions are structural, never table numbers.** The ditto guard is "a run
  of spaces with a quote mark immediately on both sides", which fires exactly
  once corpus-wide (0496). Expressing it as a table number would not survive a
  change to the source. Same principle throughout the dash rule.
- **python-docx is the character-faithful pipeline; the LLM is structural
  corroboration only** — with two exceptions now on record where the LLM was
  right: table 0964 (python-docx carried Symbol-font glyphs) and table 0227
  (python-docx merged two metadata blocks). Generation must still read from
  `v291-extracted/vocabulary/`.
- **Table 0227's three findings are one defect.** The section has two grids
  that both begin `Table OID`; python-docx classifies by first cell, so it read
  both as Table Metadata and merged them. That produces the duplicate-block
  source issue, `codeSystems: 0 blocks`, and `Version Info` on the wrong block.
  The LLM split them correctly. 0227 is the **only** section in Chapter 2C with
  a duplicate metadata block, so a fix would be a single-table special case.
  All parked behind D8.
- **Defects in the published document.** Tables **0685** and **0767** have
  headings styled `Normal` instead of `Heading 3`, so they are missing from the
  document's own table of contents; both extractors special-case them and the
  user has decided there is nothing further to do. **Table 0821's blank code
  grid** (question 1) is the newer and larger finding.
- **Do not re-run the LLM extraction casually** — ~$11.60. The corpus is on
  disk at `v291-llm/vocabulary/` (gitignored). Use `--resume`.
- **26 concept domains are declared by more than one table** (`VolumeUnits` by
  0568/0777/0930), so table→domain is not 1:1.
- **Three authored files need `.gitignore` exceptions** and are not
  regenerable: `vocabulary-changelog.md`, `vocabulary-future-corrections.md`,
  and `vocabulary-review-report.html`. A new authored artifact under
  `v291-extracted/` needs a new exception or it silently vanishes.

### Regeneration sequence

After any policy change, run in this order — each step feeds the next:

```
python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/render_vocabulary_review_html.py
```

Then check `git diff --stat v291-fhir/` — unexpected drift there means a rule
leaked into output that should only have affected comparison. It has been
byte-identical through D6 and D7.

### Build verification status

Untouched. No IG content or FHIR StructureDefinitions have been modified in
this workstream — it has produced tooling, extracted data and one generated
CodeSystem, none of which is in a build yet. Nothing needs to reach `main` or
`build`.

### Open blockers

None. Gated only on the user's decisions.


## Session History

## 2026-08-18 → 2026-08-19 — CH02C text fidelity closed (D7–D9); vocabulary work moved to its own branch

### Completed

**Applied the reviewer's whole remaining "decide" queue in one pass**, as
ADR-0008 D7, D8 and D9. The user went through the report field by field and
gave per-field instructions; those became six new rules plus two
representation decisions.

**D7 — six rules.** Three repair characters that should not be in the document
at all: a stray `Â` left by a doubly-encoded non-breaking space (0301),
Symbol-font glyphs from the Unicode private use area (0964), and runs of
non-breaking spaces in prose (0301, 0827). Three deal with the space runs D3–D6
did not claim: an indent at the start of a line is *kept* at two spaces, every
other run collapses, and a run held between two quote marks is preserved
because there the spaces are the value. 148 values changed. The outstanding
double-space group went from 143 values to **zero**.

**D8 — table 0227 (MVX) maps to an external metadata record.** The user was
right that THO already has one: `NamingSystem/MVX` plus `ValueSet/v2-0227`,
which composes from `http://hl7.org/fhir/sid/mvx`. The published URI is
retained. Three separate open findings about 0227 collapse into this one
decision.

**D9 — THO's `MasterfileActionCode` wins** over Chapter 2C's spaced spelling
for table 0180.

**Rebuilt how the review report presents itself**, because three of the user's
observations were really complaints about the report rather than the data:

- **Truncation removed.** Values were cut at 300 characters, which hid the very
  thing being reviewed — table 0952's difference from THO is ~900 characters
  in, and 0078's double space is at ~684. Cells now scroll instead.
- **Word-level diff highlighting**, with a similarity floor. 0952 shows its
  three real differences; the other four THO disagreements say "these are two
  unrelated definitions rather than two versions of one" and highlight nothing,
  which is what the user asked for.
- **A "Decided" class.** A settled group moves out of *Decide* and carries the
  reasoning with it, so the report answers both "what is left" and "what did we
  conclude". Eight groups are now decided; eight remain.
- **A character inventory.** Every non-ASCII character in the emitted corpus,
  counted, with a verdict — the user asked for a scan for more oddities like
  the `Â`, and making it permanent means the next one is found by the report
  rather than by eye.

**Opened `v291-extracted/vocabulary-future-corrections.md`**, the backlog for
the pass *after* the fidelity load. Seeded with eight entries; the user's own
was 001, cross-references into V2 with no version attached.

**Split the workstream onto its own branch** at the user's request (2026-08-19).

### Why the specific shapes

- **Two non-prose fields joined the collapse rule and nothing else.**
  `tableMetadata.where used` and `valueSet.Content Logical Definition` each
  have exactly one run in the whole chapter and the user decided both. They are
  deliberately *not* added to `DESCRIPTIVE_FIELDS`, because the prose rules —
  the comma after `e.g.`, dash spacing — must not reach a reference list or a
  value set expression. The rule chain already supported per-rule field sets,
  so this cost one line.
- **An indent is kept, not collapsed.** A run of spaces at the start of a line
  is doing something: 0396 uses it to indent a list of NCPDP code sets. Two
  spaces is the same judgement D3 made about the space after a period — the
  shape is meaningful, the exact width is not. Only two values in the corpus
  have one, both in 0396, both published at three spaces.
- **A no-op is not a change.** `re.subn` counts a replacement even when the
  result is identical, so an indent already two spaces wide would have been
  logged as changed. The indent rule counts real changes only; a change log
  full of no-op entries makes the real ones harder to find.
- **The report distinguishes three ways a non-breaking space can leave.** Six
  of the eight were leading or trailing and had been removed by D2's strip all
  along — the report was showing them as `preserved` with a note that the four
  in `codeSystem.URL` were "the ones that matter". They were the ones that did
  not. Only two needed a new rule.

### The findings worth carrying forward

**D6's lesson bit a second time, in a new way.** The `Â` rule originally
matched `Â` followed by a non-breaking space — correct for python-docx. The LLM
substitutes an ASCII space there, so the rule repaired one corpus and not the
other, and the comparison reported our own rule as a pipeline disagreement. Now
matches either. **Any rule that edits characters has to be checked against both
corpuses**, not just the one it was written from.

**Rule order silently moved five changes between decisions.** Placing the
general collapse before dash spacing absorbed five of D5's changes into D7's
count. Nothing was wrong in the output; the attribution was wrong. It was
caught only because every rule reports its own count and D5's fell from 16 to
11. This is the argument for per-rule counts, restated: they are not
bookkeeping, they are the regression test on the chain's order.

**Table 0821 looks like a hole in the published standard.** Its coded content
grid is six rows by five columns, entirely blank, in a section that declares
three code systems and a value set. Both pipelines agree. This was found while
answering the user's question about the empty tables and is the most
substantive thing to come out of it.

**A discussion the user remembered is not in the record.** They asked for a
note in the report about the empty tables, recalling a long conversation. It is
in no artifact and no retained transcript. The lesson is narrow and practical:
**a decision that only exists in chat does not exist.** The report now has a
"Still open" note class for exactly this — context recorded against a section
that has not been settled, so the next round starts from what is known rather
than from nothing.

### Branch split

The user asked that every commit for the terminology IG live on its own branch.
Nine commits, contiguous at the tip of `dev/framework` and none on `main`, so
they split cleanly:

- `dev/v291-vocabulary-ig` created at `34459a3d` and pushed. Holds all nine.
- `dev/framework` reset to `2b38100a` and **force-pushed** (with the user's
  explicit approval — eight of the nine were already on origin). It now carries
  only the structural-review workstream.
- One follow-up commit on `dev/framework` adds a **branch map** to the top of
  its copy of `JOURNAL.md`. This file is per-branch, so without it a session
  starting on `dev/framework` would read a June ACTIVE section and never learn
  the vocabulary workstream exists.

### Commits this session

On `dev/v291-vocabulary-ig` (pushed): `34459a3d` — Clear the remaining Chapter
2C space runs and repair corrupt characters.
On `dev/framework` (pushed): `a2419452` — Add a branch map to JOURNAL.

### Still uncommitted, untouched, and not mine

`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html` — all dated 2026-06-19, predating this
workstream. Flagged to the user four times now; left alone. They belong to the
structural workstream, so they will follow `dev/framework` rather than this
branch.

---


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
