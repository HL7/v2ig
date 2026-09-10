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

## ACTIVE — 2026-09-10 (the 28 Aug meeting outcome was never captured; the full IG build is still the next build move)

**Branch: `dev/v291-vocabulary-ig`, at `6b01350c`. 23 commits ahead of origin,
unpushed.** All vocabulary work is on this branch and nowhere else;
`dev/framework` carries only the structural-review workstream. **Do not commit
vocabulary work to `dev/framework`.**

**Phase:** the writer produces 398 CodeSystems and 422 ValueSets, all
validating in a real IG Publisher smoke test. 329 of the value sets are
byte-identical to UTG's own. 243 tests pass; every document regenerates clean.

### First thing to check next session

**The V2 Management meeting of 2026-08-28 happened and its outcome was never
recorded.** It was asked at the start of the last session, the session went
elsewhere, and the answer never came back. **Ask again — this is the single
biggest gap in the project's state.** Three things were put to them:

1. **The reproduce-vs-correct ruling** (blocker 1), in its narrow form: *may we
   treat editing-process defects as technical corrections?* A yes releases the
   truncated descriptions, 0821's emptied grid, the page-URL defects and the
   missing spaces in one go.
2. **The five conflicting concept domain definitions** (blocker 2). Until
   answered we emit the first in document order, which is a coin toss. Detail
   in `v291-fhir/conceptdomains-divergences.json`, kind
   `conflicting_descriptions_within_chapter`: DeviceStatus (0682/0962),
   DeviceType (0657/0961), Modality (0259/0604), QuantityUnits (0560/0602),
   VolumeUnits (0568/0777/0930). **Four of the five have a template stub as
   the second description** — 0602, 0604 and 0777 all have no `Type`, no
   steward, and a segment reference in the table name, so they look like
   field-specific stubs rather than rival definitions. The Device pair is the
   one genuinely contested; that needs OO.
3. **The information-preservation steer** — *can a FHIR consumer recover what
   Chapter 2C says about a table, or only the codes it defines?* Decides
   whether to design extensions for the 24 unmapped fields or record the loss.
   Cheap now, unrecoverable after the load into THO.

**Six new register items (18–23) were added after the meeting** and have not
been put to anyone. If V2 Management meets again, they are the agenda.

### Next build move

**Run a full IG build over the whole generated corpus.** Unchanged from last
session and still untested at scale — everything is verified on a
seven-resource smoke test. The working configuration is in `smoke-test/` and is
the thing to copy, not re-derive:

- IG `url` is `http://terminology.hl7.org/ImplementationGuide/...`, so
  resources at THO canonicals are native to the IG. **No `special-url`
  parameters anywhere** — that was a wrong turn, corrected.
- Seven `apply-*` parameters set false: `version`, `publisher`, `contact`,
  `copyright`, `wg`, `jurisdiction`, `license`. The base template defaults
  them all to **true** and silently overwrites resource metadata otherwise.
- Jekyll needs `GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems` on the
  environment or the publisher fails at the last step with a gem-not-found.
- An `input/includes/menu.xml` must exist or Jekyll dies on a missing include.

```
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx4g -jar input-cache/publisher.jar -ig ig.ini -no-sushi
```

A 7-resource build took ~3.5 min; budget accordingly and expect the
`conceptdomains` narrative to dominate the error count.

### The documents, and who they are for

| Document | Audience | State |
|---|---|---|
| `v291-extracted/v2mgmt-briefing.html` + `.md` | V2 Management | Written for the 28 Aug meeting — **predates register items 18–23** |
| `v291-extracted/utg-briefing.html` + `.md` | UTG subcommittee of TSMG | Content last changed 2026-08-21 — **three weeks stale** |
| `v291-extracted/vocabulary-v2mgmt-items.md` | Both, as the detail | **24 items**, regenerated |
| `v291-extracted/vocabulary-field-mapping.html` + `.md` | Backs the preservation ask | Current |
| `v291-extracted/vocabulary-review-report.html` | The reviewer, day to day | Current; canonical section rewritten |

**The UTG briefing is the stale one, and getting staler.** Its content has not
been revisited since `a817a61c` on 2026-08-21. Five things found since concern
UTG and TSMG directly: the `notAllCodes` canonicals, the `CodeSystem.valueSet`
omission, the punctuation codes in THO's own v2 code systems, the fact that
THO carries the same truncated descriptions the chapter does, and now the
0567/0568 question of whether THO should deprecate alongside the chapter.
**If UTG meets before it is rewritten, that briefing badly understates what we
have for them.** This is the cheapest high-value task available and does not
depend on the 28 Aug outcome.

**The V2 Management briefing is also now behind** — it was current for the
28 Aug meeting, but register items 18–23 postdate it.

### Rules settled that must not be re-derived

- **A canonical URL is an identifier and nothing more.** Where THO already
  publishes one for a table, that is the URL, whatever it appears to mean. Do
  not construct an alternative and do not read meaning out of `notAllCodes`.
- **A brand-new CodeSystem or ValueSet starts at `1.0.0`.**
- **`definition` is never back-filled from `display`**, and the resulting
  `CODESYSTEM_CONCEPT_NO_DEFINITION` warning is accepted.
- **We do not tamper with existing external code system records in THO.**
- **An item is a briefing blocker only if generation cannot proceed without the
  answer AND the answer is not already determined** (D19). Findings go in the
  register; only tested blockers go in a briefing.

### Regeneration sequence

```
python3 -m pytest tooling/scripts/
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/write_utg_xml.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
python3 tooling/scripts/render_field_mapping.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

The first two are expensive and only needed if the text policy changed.
`render_field_mapping.py` must run after `write_utg_xml.py`, since it reads the
write report — and as of this session **so must
`render_vocabulary_review_html.py`**, whose canonical section now reads
`utg-write-report.json` rather than recomputing coverage. Three scripts
self-check and print a warning rather than failing: the register's
stated-vs-computed table lists, the mapping's corpus-vs-spec completeness, and
the writer's UTG file-name collisions. **A silent run is the expected outcome;
read the output if it is not.**

### Open blockers

- **None on our side.** 243 tests pass, every document regenerates clean.
- Everything outstanding is gated on committee or user decisions, and none of
  it blocks the full build.
- The 14 writer blockers are recorded with evidence in the review report. The
  0567/0568 question is no longer "which canonical" — it is resolved and
  registered as item 18, a deprecation question for THO. The 10 external
  value-set references remain open.

### Two items that are not ours and have no home yet

Found during an out-of-scope discussion; they belong to the **structural**
workstream (`dev/framework`, `v291-extracted/v2mgmt-review-report.md`) and were
deliberately not written to this branch. The reviewer was asked which document
should carry them and had not answered when the session ended:

1. CH02 systematically calls the segment **`FSH`** rather than `FHS` in the
   file-header section (the §2.13.3 field heading is literally "FSH-15").
2. The `BHS-15` and `FHS-15` conditionality predicates **invert the containment
   hierarchy** — a batch contains messages and a file contains batches, but
   `BHS-15` reaches for "any contained FSH-16/FSH-17" and `FHS-15` skips the
   BHS level entirely.

Both look like editing-process defects, so they fit the same technical-
correction test as blocker 1.

## Session History

## 2026-08-27 → 2026-09-10 — The canonical section was wrong; six findings registered

### Completed

**The reviewer walked the "tables needing a new canonical URL" list and
rejected almost all of it — correctly.** The section was computed by one crude
subtraction in `render_vocabulary_review_html.py`: a table that listed codes
and had no `CodeSystem-v2-<its own number>` in THO was declared to need a
canonical minted. That test only ever looks for a code system filed under the
table's *own* number, so **every table whose codes live in another authority's
code system tripped it**. It reported 18; the true figure is **2** (0411 and
0460), which matches the independent count reached on 2026-08-20.

**The writer already had this right for 16 of the 18.** The section no longer
recomputes anything — it reads `v291-fhir/utg-write-report.json`, so the report
and the generated resources cannot disagree. It now shows six routes with
counts (396 reuse their own THO canonical, 24 defer to another authority, 2
mint, 14 unsettled, 360 concept-domain-only, 19 THO code systems with no
chapter table) plus two detail tables giving, for each table, which code system
it resolved to and how.

**Six items added to the V2 Management register**, five previously unrecorded.
Register is now 24 items. Commit `6b01350c`. 243 tests pass.

### The findings worth carrying

**0567/0568 is a deprecation question, not a canonical question.** The
reviewer's framing, and it replaced mine: Chapter 2C deprecates both tables in
prose, but THO publishes `ValueSet/v2-0567` and `v2-0568` as live resources
with no deprecation marker, so **a consumer cannot tell that two of the four
are superseded**. The ask is whether a concomitant deprecation belongs in THO.
Secondary: both tables print the *replacement's* canonical as their own URI
(0567→`v2-0929`, 0568→`v2-0930`), and only the "THO's existing canonical wins"
rule stopped two pairs of resources claiming the same URL.

**0725 was already correct, by OID resolution.** The chapter omits the URI
entirely and gives only OID `2.16.840.1.113883.5.1001`, which THO resolves to
`CodeSystem/v3-ActMood` — the same URL the reviewer found independently in
THO's CLD. Registered as a technical correction that changes no output.

**0460/0411/0093 is the sharpest management item.** All three are `Type: User`
and the chapter treats them three different ways: 0411 and 0460 get minted
resources, 0093 is declared concept-domain-only and gets nothing. Nothing in
the chapter explains the difference. That contrast is the frame for the
user-defined-table question the reviewer did not know how to answer.

**0340's code grid holds code system identifiers, not concepts** — `CPTM` and
`HPC`, with citations to AMA and CMS. The table is concept-domain-only so
nothing is written, but the chapter is using the code grid for two
incompatible purposes.

**0459 is a hard stop**: code system given only as OID
`2.16.840.1.113883.6.301.9`, which nothing in THO or FHIR core resolves.

### Corrections taken during the session

- Claimed the 24 deferring tables were "each previously reported as needing a
  new canonical". Only 11 were — the old test also required enumerated codes,
  so it never saw the 13 that reference their codes intensionally. Caught and
  fixed before the final render.
- Asserted the reason for that as "THO publishes no same-numbered code system
  for them". Wrong reason for a right number.

### Out-of-scope discussion worth not losing

A long thread on V2 delimiter/escape corner cases (whether `MSH-2` may declare
`F`, `S`, `T`… as separators). Two **CH02 document defects** surfaced that are
recorded nowhere and belong to the structural workstream, not this one:

1. **The chapter calls the segment `FSH` in places** — not a typo but
   systematic: the field heading at §2.13.3 is literally "FSH-15 Security
   Classification Tag", and `BHS-15`'s conditionality predicate reads "any
   contained FSH-16 or FSH-17".
2. **Those same predicates invert the containment hierarchy.** A batch contains
   messages; a *file* contains batches. `BHS-15` referring to "any contained
   FSH/FHS" is backwards; `FHS-15` reaches for "any contained MSH-26" and skips
   the BHS level.

Also established, if it recurs: **no rule anywhere in CH02 requires the six
delimiters to be distinct from one another**, so `MSHFzzzzzF` is not
prohibited by any text — searched and confirmed.

## 2026-08-25 → 2026-08-27 — The field mapping, THO's canonicals, and the briefing brought current

### Completed

**Built the field-mapping document**, which the reviewer commissioned after
noticing that the Code System *Full Name* appears nowhere in the output. It
does not, and it is one of **24 fields out of 43 that reach no resource at
all**. Two of them carry a value on all 799 tables: the table-level
`Description` and `Type`. The largest single hole is the whole **Code System
Version block** — version, effective date, HL7 version introduced — none of
which is read. For `Effective Date` the chapter has *better* information than
what we publish, since `CodeSystem.date` comes from UTG where 414 of 416
resources carry the same bulk-load date.

The document is `v291-extracted/vocabulary-field-mapping.html` plus a Markdown
twin, authored in `field_mapping_spec.py` and joined to the corpus by
`render_field_mapping.py`. **The split is the point**: the mapping is authored
so a field can be recorded as *unmapped* — a question — rather than merely
described as unmapped, which is all a derived mapping could ever say. A
completeness check fails if extraction produces a field the spec does not
cover, so the document cannot quietly go stale.

**Writing it out found a real defect.** The writer never read `valueSets.URI`
and constructed `ValueSet.url` from the table number. That agreed with THO for
412 of 429 tables and put **0291, 0347, 0399 and 0834** at canonicals neither
THO nor UTG publishes. The user's ruling settled it: *a canonical URL is an
identifier; where one already exists it is the one to use, and any meaning it
appears to carry is coincidental.* The writer now takes THO's canonical where
there is one.

**Flagged every punctuation-only code**, 23 across 17 tables, scanning both the
chapter and THO's v2 code systems. Three groups: four genuine symbol codes
(`*`, `#`, `%`) with real definitions; eighteen ellipsis placeholders minted as
concepts; and one `??`. **Five tables carry the placeholder twice**, as `...`
and as `…`, with identical display text.

**Brought the V2 Management briefing current** for the 28 August meeting. It
still described the 21 August state.

### The findings worth carrying

**THO is not a recovery source for the truncated descriptions.** All 16 tables
have a ValueSet in THO, all 16 carry a description, and **15 are truncated at
exactly the same character** once whitespace and our own text policy are
normalised on both sides. The same clipped field fed both documents. **0227 is
the exception and the proof**: THO's continues 171 characters past the cut,
completing the very word the chapter breaks in the middle of — `may be acce`
becomes `may be accessed via` plus the PHIN VADS link.

**The punctuation codes are overwhelmingly THO's, not the chapter's.** Sixteen
of the 23 exist only in THO, and *every* duplicate `...`/`…` pair is THO-only.
The chapter has largely stopped publishing them and THO has gone on carrying
them — the exact drift this baseline exercise exists to correct.

**`CodeSystem.valueSet` means the value set containing the *entire* code
system**, so it must be absent where the value set leaves a code out. UTG omits
it on exactly two of its 416 code systems — 0291 and 0834 — and we were
emitting it on both. Now mirrored.

**Getting a canonical right has three consequences, not one.** The resource
`id` is the canonical's last segment; the output file must keep UTG's own name,
which is *not* derivable (three of the four are filed under the canonical and
0834 under its table number); and version inheritance keys off the file name,
so the parser reading `notAllCodes-0291` as a table number had been silently
defaulting those tables. 0347 was emitting 1.0.0 where UTG publishes 2.0.0.

### Why the specific shapes

**The mapping spec is authored and the counts are computed.** Either half alone
is useless: a hand-written document drifts, and a generated one cannot say that
something *should* be carried and is not.

**`usedDefaultVersion` is now reported per resource, not per table.** A table
can inherit a version for its CodeSystem and not for its ValueSet, and three
do — which is precisely how the `notAllCodes` cluster stayed hidden. The
per-table flag was reporting 16 tables including five where nothing was
written, and missing 0291 entirely. It is now 12 tables / 14 resources, and
after the canonical fix, 10 tables / 12 resources.

**Blockers stayed at two in the briefing**, per the D19 rule. Nothing found
this week meets the bar — generation proceeds without any of it. Padding the
blocker list is how a short meeting produces nothing.

**Blocker 1 now carries the errata-guidance test**, so V2 Management can give
the narrow answer (*may we treat editing-process defects as technical
corrections?*) instead of ruling on the whole reproduce-vs-correct principle in
the time available.

### Corrections taken during the session

- Framed the canonical question as "should we honour the URI the chapter
  prints". Wrong question — the chapter's copy of the identifier is wrong for
  14 tables. The user's rule needs nothing from the chapter at all.
- Stated the punctuation groups as "six genuine codes" and "eleven
  placeholders" from a source count rather than a code count. Four and
  eighteen.
- Claimed 25 unmapped fields in the document lede when the computed figure was
  24, and carried three other counts from a presence scan instead of a
  non-empty scan.
- `git add -A tooling/scripts` staged the two `dev/framework` scripts. Caught
  before committing, twice.

### Commits this session

`ea7da354` the field mapping, the truncation cross-check, 0954's
`notSelectable` note and version 1.0.0 · `e1bf2046` THO's canonicals and the
punctuation codes · `9b77181d` the briefing.

### Still uncommitted, untouched, and not mine

The same five files from the structural workstream. They belong to
`dev/framework`. Untouched across seven sessions now.

---

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
