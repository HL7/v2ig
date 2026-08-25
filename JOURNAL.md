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

## ACTIVE — 2026-08-25 (The XML writer is built and validating; a full IG build is the next move)

**Branch: `dev/v291-vocabulary-ig`, at `55a4b8fa`. 17 commits ahead of origin,
unpushed.** All vocabulary work is on this branch and nowhere else;
`dev/framework` carries only the structural-review workstream. **Do not commit
vocabulary work to `dev/framework`.**

**Phase:** the writer exists, produces 398 CodeSystems and 422 ValueSets, and
every generated resource validates with zero errors in a real IG Publisher
build. The UTG mount blocker from last session is gone.

### Next session's first move

**Run a full IG build over the whole generated corpus.** Everything so far is
verified on a seven-resource smoke test; the ~820-resource run is untested and
is where scale problems will show up. The working configuration is in
`smoke-test/` and is the thing to copy, not re-derive:

- IG `url` is `http://terminology.hl7.org/ImplementationGuide/...`, so
  resources at THO canonicals are native to the IG. **No `special-url`
  parameters anywhere** — that was a wrong turn, corrected.
- Seven `apply-*` parameters set false: `version`, `publisher`, `contact`,
  `copyright`, `wg`, `jurisdiction`, `license`. The base template defaults
  them all to **true** and silently overwrites resource metadata otherwise.
- Jekyll needs `GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems` on the
  environment or the publisher fails at the last step with a gem-not-found.
- An `input/includes/menu.xml` must exist or Jekyll dies on a missing include.

Build command shape:

```
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx4g -jar input-cache/publisher.jar -ig ig.ini -no-sushi
```

A 7-resource build took ~3.5 min; budget accordingly and expect the
`conceptdomains` narrative to dominate the error count (see below).

### What the writer is

Three new modules, 63 tests, all 204 tests in `tooling/scripts/` passing.

- **`tooling/scripts/utg_xml.py`** — the serializer. Reproduces UTG's house
  style exactly: declaration, blank line, root; 2-space indent; LF; self-closing
  empty elements; **no trailing newline**; `&#39;` for an apostrophe; no
  `<meta>` and no `<text>`.
- **`tooling/scripts/write_utg_xml.py`** — the generator.
- **`tooling/scripts/test_write_utg_xml.py`** — 63 tests.

Output goes to `v291-fhir/utg/{codeSystems,valueSets}/`, mirroring UTG's
`input/sourceOfTruth/v2/` so a copy is a straight `cp -r`. **Never write into
the `UTG/` clone directly.** The per-table decision record is
`v291-fhir/utg-write-report.json`.

**Two independent signals the classification is right:** the only two new
CodeSystems it produces are **0411 and 0460**, exactly what the 2026-08-20
recheck against `tho-r5/` predicted by a different route; and **328 of 406
ValueSets come out byte-identical to UTG's own** with no round-trip tuning.

### Current numbers

```
398  code-system-and-value-set     360  concept-domain-only
 24  value-set-only                 14  needs-decision
  3  nothing-to-write
→ 398 CodeSystems, 422 ValueSets
```

### The build questions that are now answered

- **The canonical collision is a non-issue.** With `hl7.terminology.r5#7.3.0`
  loaded, our resources win and render with our content. No duplicate-canonical
  error exists.
- **`special-url` is not needed and must not be used.** Give the IG THO's own
  canonical base instead.
- **Version propagation is `apply-version`**, and it is one of seven.
- **`<text>` omission is correct** — the publisher flagged THO's stored
  narrative on `conceptdomains` as something to remove.

### Deliberate divergences from UTG — do not "fix" these

- **`definition` is never back-filled from `display`.** UTG does it; the
  chapter has no definition for most codes, so we leave it out. The publisher
  warns `CODESYSTEM_CONCEPT_NO_DEFINITION` corpus-wide. **This is the user's
  explicit instruction** (2026-08-25): the display value stays in `display`,
  `definition` is optional, and the warning is accepted.
- **A concept property is declared only where a concept uses it.** UTG declares
  `v2-table-deprecated` even when unused.

### Pending user actions

1. **Batch A defaults** — now a decision table in the review report, "For the
   editor / Publication metadata Chapter 2C does not carry". Evidence for each
   is there; nothing blocks generation. The live one is what version a *new*
   resource should start at; 3.0.0 is a placeholder for the 16 that fall back.
   **The ValueSet-coverage question is moot** and recorded as such.
2. **The 14 writer blockers** — in the report under "Tables the XML writer will
   not guess at", grouped by obstacle so each group is one decision.
3. **Check #IG creation Zulip thread** — unchanged since June, unrelated.

### Things the user settled this session — do not re-derive

- **0010, 0188, 9999** should be concept domains, not tables. **THO and UTG
  have nothing for any of them**, so nothing needs unpicking. Writer emits
  nothing.
- **0093, 0340, 0451** get no ValueSet. Example codes will probably become a
  concept property on the concept domain code system; not yet decided, and now
  a register item.
- **0560 and 0910** are concept domains and get no ValueSet. **THO publishes a
  complete CodeSystem and ValueSet for 0560 and nothing for 0910**, from
  identical source. Register item written with the full contrast.
- **0962's `http://hl7.org/fhir/device-status`** is correct — a known outlier
  within THO that TSMG has already discussed. Not a finding.
- **0227 (MVX)**: THO has a NamingSystem and an HTML metadata record, and
  **should not** have a CodeSystem. Resolved and emitting.
- **The errata guidance authorises correcting the UCUM copy/paste errors.**
  `technical_correction_guidance.txt` in the repo root is the reference.
- **We do not tamper with existing external code system records in THO.** If a
  real need appears, raise it before acting.

### Findings from this session worth carrying

- **Sixteen ValueSet descriptions stop mid-word at 242–252 characters** — a
  length cap in the publication toolchain, not extraction loss. Code System
  descriptions in the same tables run to 500+ and end cleanly. **This one
  reaches the output**, unlike the Full Name defects.
- **The copy-pasted Full Name is not confined to UCUM.** 412 of 444 follow
  `<Table Name> Code System`; the exceptions include several names carried over
  from a different table. Someone who knows the tables must separate genuine
  exceptions from errors.
- **0954 is missing an exclude clause** its sibling 0957 has and THO's
  equivalent applies. The generated ValueSet currently differs from THO on
  exactly this point.
- **Every table that prints a page URL where a canonical belongs also prints a
  correct OID.** That one fallback resolved seven tables with no decisions.
- **579 of 589 concept domain definitions are byte-identical** between Chapter
  2C's Description and THO's definition. THO populated straight from that
  field; `generate_concept_domains.py` already does the same.
- **THO records most OIDs on the CodeSystem, not a NamingSystem.** The index
  reads both, plus the FHIR core package.

### Regeneration sequence

Unchanged from last session, with the writer added after
`generate_concept_domains.py`:

```
python3 -m pytest tooling/scripts/
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/write_utg_xml.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

The first two are expensive and only needed if the text policy changed.

### Open blockers

- None. The UTG mount is resolved: `/workspace/UTG` is a real clone at
  `a19c2636`. `utg` and `UTG` are **the same directory** — the mount is from a
  case-insensitive filesystem, so both spellings resolve to one inode. Both are
  gitignored.
- Everything else is gated on the user's decisions, none of which blocks a
  build.

## Session History

## 2026-08-25 — The XML writer, and the build questions answered

### Completed

**Built the XML writer**, which is what the whole workstream was for. A
serializer that reproduces UTG's house style and a generator that classifies
every table and emits only what the chapter clearly supports. 398 CodeSystems,
422 ValueSets, 63 new tests.

The classification came out right by two independent checks: the only new
CodeSystems are 0411 and 0460, matching a count reached a different way five
days earlier, and 328 of 406 ValueSets are byte-identical to UTG's own with no
tuning.

**Smoke-tested against a real IG Publisher build** and answered the question
open since D18. The canonical collision is a non-issue — with
`hl7.terminology.r5#7.3.0` loaded our resources win and render with our
content. What fired was `RESOURCE_CANONICAL_MISMATCH`, and my first fix was
`special-url`, which the user correctly rejected. **The right answer is to give
the IG THO's own canonical base**, exactly as `hl7.terminology` does; then the
resources are native to it and no special URLs are involved. Version
propagation is `apply-version`, and finding it surfaced that the base template
defaults **seven** `apply-*` parameters to true, silently overwriting
publisher, contact, copyright and work group as well.

**Took needs-decision from 21 to 14** across two rounds. The largest single
cause was tables printing a rendered page URL where a canonical belongs — and
every one of them also prints a correct OID, so one fallback resolved seven
tables. Filter-shaped logical definitions are now built rather than reported,
copying THO's pattern rather than inventing one: 1,423 of its 1,432 filtered
ValueSets use `concept is-a`, and all three subtrees Chapter 2C asks for
already exist there. 0227 resolved through `NamingSystem/MVX` once the user
confirmed THO has no CodeSystem for MVX and should not have one.

**Five new register items**, four of them found while answering the user's
questions rather than by looking for them.

### Corrections taken during the session

- Reported that a `special-url` parameter was the fix for the canonical
  mismatch. The user pushed back on using special URLs at all and was right;
  the IG's own canonical base was the real answer and is strictly better.
- My page-URL detector only matched `terminology.hl7.org`, so table 0962 was
  quietly composing over `http://hl7.org/fhir/codesystem-device-status.html`.
  Found only because the user asked whether the foreign systems had metadata
  records.
- Staged two files belonging to `dev/framework` while committing. Caught before
  the commit; they have now been left alone for six sessions.

### The findings worth remembering

**Sixteen ValueSet descriptions are truncated mid-word** between 242 and 252
characters. Found by reading one generated resource, not by a scan. It is a
length cap in the publication toolchain: Code System descriptions in the same
tables run past 500 characters and end in complete sentences, and the tables'
own metadata descriptions are complete. This is the only defect of the session
that reaches the emitted output.

**0560 and 0910 are the same case handled two opposite ways.** Identical in the
chapter — the `noObject` placeholder, no code system — and THO publishes a
complete five-concept CodeSystem plus ValueSet for one and nothing for the
other. So a code system was minted at an HL7 canonical for a table whose source
declares none, filled with content flagged as wrong elsewhere in the register.

**The errata guidance is a usable test**, and the user supplying it changed the
shape of the reproduce-vs-correct question. Its definition of a technical
correction — a change that makes the document say what the WG intended,
repairing content not made or inconsistently made during editing — separates
the editing-process defects from the substantive ones. The register now asks
the narrow question rather than the abstract one.

**A user instruction worth not losing:** do not back-fill `definition` from
`display`. The publisher warns about it corpus-wide; `definition` is optional
and the warning is accepted.

### Commits this session

`57e4ac47` the writer · `bf9f49a9` the smoke test · `50164f82` six tables
resolved, special-url and version propagation dropped · `55a4b8fa` 0227, five
register items, Batch A.

### Still uncommitted, untouched, and not mine

The same five files from the structural workstream, now dated across six
sessions. They belong to `dev/framework`.

---


## 2026-08-20 → 2026-08-24 — D17–D19; both committees briefed; the 18-canonical count corrected

### Completed

**D17 — the missing spaces after a period, ten of twelve restored.** D16 had
built the detector and repaired nothing, on the grounds that no authority in
the chapter licensed inserting a character. The user supplied that authority
directly. **The two dotted identifiers were deliberately not repaired** —
`Observation.Code` in 0396 and `…Reason.PurposeOfUse` in 0717, where a space
corrupts the name. They stay as published and the detector goes on reporting
them, because nothing in the text tells an identifier from a sentence boundary
and a detector that filtered would hide the next real one. Report went to **0
to decide, 0 to confirm**; tests 124 → 138; agreement held at 740/799.

One case worth remembering: **table 0719's site sits past one of the 14 known
LLM truncations**, so that correction fires in python-docx only. It created no
new pipeline disagreement because the value already disagreed. The other nine
fragments were verified in both corpuses first.

**D18 — what the IG actually is, which changed several answers.** The user
explained the framing: this is a *workspace* whose only destination is
integration into THO, establishing a corrected **v2 baseline** there because
THO's existing v2 content is more error-ridden than what we are preparing.

That reversed a recommendation made an hour earlier. I had argued against
authoring at `terminology.hl7.org` on namespace-squatting grounds; with the
destination known, that objection is void and authoring at the destination
canonical is strictly better — no interim URL, no migration, no mapping table.

Three consequences went into the ADR, two of which nothing in the code implies:
the output is **not** scoped to V2.9.1 (so no `2.9.1` in `version`, and "HL7
Version Introduced" becomes a property), and **"THO already publishes it" is no
longer an argument by itself**. That last one has teeth — it is the stated or
implied rationale in D1's tie-break and in D8 and D11's reuse decisions. Those
hold on their own evidence, but the reasoning does not generalise, and D18 says
so explicitly so a later decision cannot lean on it.

**The 18-canonical count was wrong and is now corrected.** The long-carried
note said 18 tables "need minting". Checked against `tho-r5/`: THO has no
CodeSystem for any of the 18 but **does have a ValueSet for 10**, and each
one's `compose` names the real system. So the real scope is **2 new
CodeSystems** (0411, 0460), 3 ValueSet-only, 10 authored at an existing THO
canonical, 3 escalations. This also confirmed D11's rule generalises further
than expected — it covers not just external systems but tables borrowing
another v2 table's code system (0125→v2-0440, 0136→v2-0532, 0338→v2-0203).

Along the way: **0411 is a dangling canonical in a published HL7 standard** —
Chapter 2C prints `http://terminology.hl7.org/CodeSystem/v2-0411`, THO has no
such resource.

**Two committee briefings, both generated rather than hand-written.** The user
asked for HTML over Markdown for anything they read or share, and to be able to
find the important parts without digging. Both are authored in Python modules
sharing `briefing_style.py`, each emitting HTML plus a Markdown twin.

- **UTG** (`render_utg_briefing.py`) — item-by-item, four asks, an "if you read
  one thing" card at the top carrying every ask as a one-liner with jump links.
- **V2 Management** (`render_v2mgmt_briefing.py`) — a different shape for a
  different audience: minutes rather than an hour, and they own the *chapter*,
  so it is organised by **class of defect with counts**.

**D19 — three register items closed, and a process fix.** The user pushed back
on the V2 Management draft, correctly. Two of its three blockers were not
blockers: "all codes" in a CLD is ordinary FHIR, and the duplicate table pairs
are a deprecated/current pair each. A third item was wrong in the other
direction — 0093/0340/0451 are **conforming**, because the V3 requirements for
declaring a concept domain call for example codes.

Both of the false blockers were genuine register items carried from earlier
sessions; the error was *promoting* them without re-testing them. D19 records
the test: **an item is a blocker only if generation cannot proceed without the
answer AND the answer is not already determined by something we know.** The
register is where a question waits; a briefing is where a question has been
checked.

In their place, the briefing now carries the **five concept domains declared by
more than one table with a different definition each time**, with table numbers
and competing wordings inline rather than by reference. Pulling that data
surfaced two things nobody had noticed: **`Modality`'s emitted definition is
0259's, which says the table was removed from the standard as of 2.7** — we are
publishing a withdrawn table's wording as the live definition — and
**`VolumeUnits` is declared by three tables**, two of which are the
deprecated/current pair.

### Meeting outcomes

**UTG subcommittee (2026-08-20).** Receptive. Canonicals and merge route
agreed. **Their curator said clean diffs are not something they rely on** —
the repo is already messy when anyone submits. That drops the byte-exact
round-trip test from a hard gate to optional and takes real work off the
critical path.

**V2 Management (2026-08-21).** Short. The briefing was corrected before it
went in; the two surviving blockers are still owed.

### Why the specific shapes

**Items that came off the blocker list stay visible for one meeting.** A
question that silently disappears between drafts reads as a question that was
dropped, and anyone who saw the earlier version will look for it.

**The briefings are two documents, not one with two views.** UTG owns
resources and had an hour; V2 Management owns the chapter and had minutes. The
same material genuinely needs different organisation, and trying to
parameterise one document would have served neither.

**`MISSING_SPACE_CORRECTIONS` is a separate table from `MANUAL_CORRECTIONS`**
rather than more entries in it, so each change reports under the decision that
authorised it instead of inheriting D14's. Table 0396 now carries corrections
from both and demonstrates it.

### Corrections taken during the session

- Argued against THO canonicals on squatting grounds before knowing the IG's
  destination; reversed once the user explained it.
- Promoted two non-blockers into a committee briefing. "All codes" should not
  have survived my own review — composing a whole code system in a CLD is
  bread-and-butter FHIR, and I carried the register's phrasing forward instead
  of checking it.
- Had the concept-domain-only tables backwards: treated example codes as a
  contradiction when the V3 requirements call for them.

### Commits this session

`4b9d22e1` D17 · `a3a003f8` D18 · `d8fb247d` `a618538d` UTG briefing (Markdown,
then superseded) · `1fb0be47` UTG briefing as HTML · `a817a61c` V2 Management
briefing + shared stylesheet · `87b4bf3f` D19 and the blocker cut.

### Still uncommitted, untouched, and not mine

Five files from the structural workstream — two renderers and three HTML
reports. They belong to `dev/framework`, not this branch. Left alone across
five sessions now.

---

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
