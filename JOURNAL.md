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

## ACTIVE — 2026-08-20 (CH02C: text fidelity fully closed; Batch A is next and is the only thing left)

**Branch: `dev/v291-vocabulary-ig`, at `a20678fc`.** Three commits this session.
All vocabulary work is on this branch and nowhere else; `dev/framework` carries
only the structural-review workstream. **Do not commit vocabulary work to
`dev/framework`.**

**Phase:** Building a separate FHIR IG carrying the V2.9.1 Chapter 2C
vocabulary as CodeSystems and ValueSets. The structural review registry
workstream is paused and untouched on `dev/framework`.

**Governing requirement (user):** the IG must carry *exactly* what Chapter 2C
publishes. Corrections only where the user has decided a specific case is safe.
Every divergence recorded.

### Next session's first move

**Batch A.** It is the only thing left before resources can be generated, and
every question the user has been working through for three sessions is now
answered. Bring it as a small set of concrete choices with counts and a
recommendation — that format has worked for every decision so far.

The user said explicitly on 2026-08-19 that they had been knocking out the
accumulating small decisions before starting Batch A, and were not sure that
was the right order. It was: the queue is empty now, and D11 answered seven
tables' worth of Batch A in passing.

**What Batch A still needs from the user:**

1. Canonical URL and id scheme for the **18 code-bearing tables THO does not
   cover**.
2. Whether **ValueSets are generated for every CodeSystem**, or only where
   Chapter 2C declares a Value Set block (438 tables declare one).
3. Resource `version`, `status`, `experimental`, publisher and contact
   defaults.
4. Whether the rule D11 implies generalises: *a table whose code system is
   external gets no CodeSystem, only a ValueSet composing from THO's
   NamingSystem.*

**One piece of Batch A is blocked** on escalation 1 (below): what a table
produces when its published content is known to be wrong. Everything else can
proceed without it.

### Pending user actions

1. **Batch A** (above).
2. **Take the 12-item register to V2 Management and TSMG** —
   `v291-extracted/vocabulary-v2mgmt-items.md`, also the first section of the
   HTML review report. Item 1 is the policy question that governs the rest.
3. **Check #IG creation Zulip thread** — template trust submission, unchanged
   since June, unrelated to this workstream.

### Where things stand

**The review report is down to 12 escalated, 12 to decide, 0 to confirm**, from
8 decide / 55 confirm at the start of the session. The 12 to decide are all one
new group: the missing space after a period, found by a detector built at the
end of the session and not yet reviewed by anyone.

| | Count | What it is |
|---|---:|---|
| For V2 Management / TSMG | 12 | Defects in the source or in THO. Not ours to fix |
| Decide | 12 | All one group: missing space after a period, 7 tables |
| Decided | 1,523 | Every rule and correction, with its ADR reference |
| Confirm | 0 | Now means changed-but-unreviewed, and there is nothing |
| Informational | 543 | Disclosed for completeness |

**Text fidelity is now completely closed.** No run of two or more spaces
anywhere (except 0496's deliberate ditto mark), and **no space before closing
punctuation anywhere** — that group went 20 → 0 across D10 and D14.

**Cross-pipeline agreement: 740/799**, unchanged all session. 210 typography,
45 whitespace, 14 LLM truncations, 1 content (0496, adjudicated), 3 structural
(all 0227, parked behind D8).

### What was decided this session — ADR-0008 D10 to D16

- **D10** — a non-breaking space against closing punctuation is *deleted*, not
  spaced out. Cleared the `(M49) .` that D7 had introduced in 0827.
- **D11** — the seven empty-grid tables, disposed of individually. Four are
  external code systems reusing a THO NamingSystem (0347 → ISO3166Part2;
  0929/0930/0932 → v3-ucum); two are concept domain only (0560, 0910); one is a
  ValueSet over three external systems reusing THO's `ValueSet/gender-identity`
  (0821).
- **D12** — the 55 "invalid" symbolic names are valid FHIR codes. No change to
  output; the flag was wrong.
- **D13** — source defects are escalated, not adjudicated. Created the register.
- **D14** — 18 individual corrections, where the defect does not generalise.
- **D15** — a non-ASCII character is judged against THO, not against taste.
- **D16** — the missing space after a period is detected and reported, never
  inserted.

### Non-obvious things the next session must not re-derive

- **The policy is a rule chain in `tooling/scripts/vocabulary_text_policy.py`**,
  plus `MANUAL_CORRECTIONS` for what does not generalise, plus detectors that
  report without changing. **124 tests** in `test_vocabulary_text_policy.py`;
  run them before and after any change.
- **Every character-level change must be checked against BOTH corpuses.** Four
  occurrences now: D6's comma, D7's `Â`, D10's non-breaking space, D14's
  fragments. D10 taught the newest variant — when the two corpuses cannot be
  made to agree, **widen the comparison's notion of "same", not the rule**.
  `fold_whitespace` now drops a space against closing punctuation.
- **A correction fragment must be checked against the corpus AFTER the rule
  chain, not the raw extraction.** The LLM's raw 0440 value has two spaces
  where python-docx has one; the fragment matches neither raw corpus and both
  corrected ones.
- **`MANUAL_CORRECTIONS` matches a text fragment within a named table, never a
  location path.** The two pipelines index coded content differently — the
  corrected value in 0003 is row 348 to python-docx and 347 to the LLM. A
  location key would silently correct one corpus and miss the other.
- **Rule order in `RULES` is load-bearing.** Character repairs first, narrow
  space rules before broad ones, dash spacing ahead of the general collapse.
  Each rule reports its own count, which is how a mis-ordering gets caught.
- **The report's action classes mean specific things now.** `Confirm` is
  changed-but-unreviewed and is empty; anything changed under a recorded
  decision renders as `Decided` via the `DEVIATION_DECISION` table. Add a line
  there when a rule is approved.
- **Outstanding groups highlight the site still in question.** Without it a
  reader scans the *As published* column, finds a defect a rule fixed three
  changes ago, and decides about that instead — which happened twice, on 0440
  and 0952, and cost a round trip.
- **The escalation register is authored in
  `tooling/scripts/vocabulary_escalations.py`** and rendered twice, into the
  HTML report and into `vocabulary-v2mgmt-items.md`. Edit the module.
- **python-docx is the character-faithful pipeline; the LLM is structural
  corroboration only** — two exceptions on record where the LLM was right,
  tables 0964 and 0227. Generation reads from `v291-extracted/vocabulary/`.
- **Do not re-run the LLM extraction casually** — ~$11.60. Corpus is on disk at
  `v291-llm/vocabulary/` (gitignored). Use `--resume`.
- **26 concept domains are declared by more than one table**, so table→domain
  is not 1:1.
- **Four authored files need `.gitignore` exceptions** and vanish silently
  without one: `vocabulary-changelog.md`, `vocabulary-future-corrections.md`,
  `vocabulary-review-report.html`, `vocabulary-v2mgmt-items.md`.

### Loose ends nobody has decided about

Found while working, not raised as questions, and not in the report:

- **Table 0440 has missing-space defects in sibling values** the corrections
  did not touch: `OBX-5Observation`, `OM2-6.3and`, `and8.8.4.8`. A different
  shape from the missing-space-after-period detector, which only looks at
  sentence boundaries.
- **Table 0440's `CNN` row contradicts the D14 correction to its `NDL` row**
  on one point — it keeps `7.4.1.32-(OBR-32)` tight. Recorded in the ADR; one
  line to reverse if the user prefers the sibling.

### Regeneration sequence

After any policy change, in this order:

```
python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
```

Then check `git diff --stat v291-fhir/`. Drift there should only ever be the
generation date plus concept domains Chapter 2C owns — under D1, THO's wording
wins for the 582 domains THO already publishes, so a corrected Chapter 2C
description only reaches the output for the 177 additions.

### Build verification status

Untouched. This workstream has produced tooling, extracted data and one
generated CodeSystem, none of which is in a build. Nothing needs to reach
`main` or `build`.

### Open blockers

None. Gated only on the user's decisions.

## Session History

## 2026-08-19 → 2026-08-20 — CH02C decision queue emptied (D10–D16); V2 Management register opened

### Completed

**Worked the reviewer's entire remaining queue over three rounds**, as ADR-0008
D10 through D16, and emptied it. The session began with 8 decide groups and 55
confirm groups; it ends with one new group nobody has seen yet and nothing else
outstanding.

**D11 — the seven empty-grid tables.** The user had analysed these in a lost
session and re-supplied their conclusions. Checking each against the source and
against THO turned up more than the grids: four tables need no CodeSystem at
all because their code system is external and Chapter 2C's own OID and URI
match a THO `NamingSystem` exactly (0347 → `ISO3166Part2`; 0929/0930/0932 →
`v3-ucum`), which is D8's MVX shape again and resolves five of Batch D's 26
tables. Two are concept domain only (0560, 0910). One, 0821, is a ValueSet over
three external systems where THO's `ValueSet/gender-identity` carries the exact
OID Chapter 2C prints.

**Three of the user's observations came out larger than stated, and the
evidence is worth keeping:**

- The wrong UCUM code system Full Name is not just 0930 — **all six**
  UCUM-backed tables carry `Donation Duration Units Code System`, and it is
  wrong in kind even on 0932, since the code system is UCUM.
- The `noObject`/`noDescription` placeholder is in **0560 as well as 0910**,
  and in **no other section of Chapter 2C**. Both are tables with no real code
  system, so the placeholder is a reliable marker of the condition — which is
  most of the argument for treating both as concept domain only.
- **Table 0821's blank grid is 6 rows × 5 columns, and THO's value set holds
  exactly five concepts.** A header plus five code rows. The grid was meant to
  carry those five and lost them in publication. That is a much stronger
  finding for V2 Management than "it is empty".

**D13 — the escalation register**, 12 items, five of them out of D11. Item 1 is
the one that matters: does publishing V2.9.1 "as published" extend to
publishing known errors? Table 0560 publishes time units under the name
Quantity Units and THO carries the same error; table 0931 publishes an invalid
UCUM code beside the valid one. **THO has already answered this question once,
by correcting rather than reproducing** — its `ValueSet/v2-0931` drops the bad
code and puts the history in the display text. So the two bodies have diverged
on the principle at least once, which is the concrete hook for the discussion.

**D12 — the 55 "invalid" symbolic names were never invalid.** The user was
right: the FHIR `code` type admits every character in them. Recorded with no
change to output, precisely because nothing changed and the false alarm would
otherwise be raised again.

**D15 — the non-ASCII character question, closed with evidence.** The user
asked what made me think German umlauts, `®` and `©` were problems. Fair: they
were already marked informational, but the section rendered under *Decide*
because two rows were unresolved, so the whole inventory read as a complaint.
Their test — do these appear in THO? — closed the two unresolved ones as well.
**All 14 characters in the corpus appear in THO**, and for `Ø` and the
non-breaking hyphen THO carries the identical text, not just the character.
The check is now automatic and only flags a character THO lacks.

**D10 and D14 — the text corrections.** D10 deletes a non-breaking space
against closing punctuation rather than spacing it out, clearing the `(M49) .`
D7 had introduced. D14 adds `MANUAL_CORRECTIONS` for 18 values the reviewer
decided one at a time, because the 14-change/5-leave split they drew is not a
pattern. Space before closing punctuation is now **20 → 0**.

**D16 — a detector for the missing space after a period**, the mirror image.
12 places, 7 tables, reported and never repaired.

**Two report fixes, both caused by the review itself:**

- **A change made under a recorded decision now renders as Decided.** The user
  pointed out that the report was asking for the same judgement twice — 1,469
  values' worth. `Confirm` now means changed-but-unreviewed and is empty.
- **Outstanding groups mark the site still in question.** The user twice
  decided about a defect visible in the *As published* column that a rule had
  already fixed — 0440's double space before a hyphen and 0952's double space
  between `elements` and `in`. Both cost a round trip. The mark makes the
  question unambiguous.

### Why it was done this way

**The register is authored once and rendered twice.** A committee will not open
a 1.6 MB HTML file, and a second hand-written copy would drift within a month.
`vocabulary_escalations.py` holds the data; the HTML report and
`vocabulary-v2mgmt-items.md` both come from it.

**Corrections match a text fragment inside a named table, never a location
path.** The two pipelines index coded content differently — the corrected value
in 0003 is row 348 to python-docx and 347 to the LLM — so a location key would
have corrected one corpus and silently missed the other. That is the same
failure D6, D7 and D10 each produced from a different direction.

**D10's failure was fixed in the comparison, not the rule**, and that is the
new part of the lesson. Deleting the non-breaking space on the python-docx side
moved table 0827 into the `content` bucket, which means "the two extractions
genuinely disagree". Widening the rule to ordinary spaces would have swept in
19 places nobody had decided about. The right answer was that the comparison's
notion of "same" was too narrow: whether a space sits against closing
punctuation is a spacing question by definition.

### Non-obvious context

- **Table 0440's `CNN` row publishes the same passage as its `NDL` row, in
  corrected form, but keeps `7.4.1.32-(OBR-32)` tight.** The user asked for
  spaces around that hyphen. Applied as instructed and recorded in the ADR,
  because it makes NDL internally consistent while diverging from its sibling —
  one line to reverse.
- **Table 0440 has other missing-space defects the corrections did not touch**:
  `OBX-5Observation`, `OM2-6.3and`, `and8.8.4.8`. Nobody has raised them.
- **0717's two entries are two different codes**, HIPAANOPP and HIPAAPsyNotes,
  each carrying the defect once — the user asked whether they were missing
  something, and they were not.
- **A correction fragment must be verified against the post-policy corpus.**
  Checking against the raw extraction says the 0440 fragment matches
  python-docx and not the LLM, which is wrong: D5 and D7 make them identical
  before corrections run.


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
