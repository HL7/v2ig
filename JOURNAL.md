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

## ACTIVE — 2026-08-24 (Both committees briefed; the XML writer is next and is blocked on a mount)

**Branch: `dev/v291-vocabulary-ig`, at `87b4bf3f`. 11 commits ahead of origin,
unpushed.** All vocabulary work is on this branch and nowhere else;
`dev/framework` carries only the structural-review workstream. **Do not commit
vocabulary work to `dev/framework`.**

**Phase:** the fidelity load is finished and reviewed. Both governing
committees have now been briefed. The next real engineering is the **XML
writer** — and it is blocked on a filesystem mount, see below.

### Read this first if you have dumped context

Four things changed the shape of this project since Thursday, and none of them
is derivable from the code:

1. **The IG is a workspace, not a publication (D18).** Its only destination is
   integration into THO. That is why resources are authored at
   `http://terminology.hl7.org/` canonicals — it is not squatting, it is THO's
   content prepared in the open at the URLs it will live at.
2. **The output is not tied to V2.9.1 (D18).** V2.9.1 is the *source* used to
   establish a corrected **v2 baseline** in THO. No `2.9.1` in `version`;
   "HL7 Version Introduced" becomes a concept property.
3. **THO's existing v2 content is *worse* than what we are preparing** (user's
   own assessment). Never cite "THO already publishes it" as authority on its
   own again. Agreement with THO is corroboration, not deference.
4. **UTG does not need clean diffs.** Their curator said the repo is already
   messy when anyone submits, and clean diffs are not something they rely on.
   The byte-exact round-trip test dropped from a hard gate to a nice-to-have.
   **This took real work off the critical path.**

### Next session's first move

**Unblock the UTG repo, then start the XML writer.**

`/workspace/utg` and `/workspace/UTG` both exist as symlinks to
`/Users/mrf/repos/utg` — **a macOS host path that is not mounted into this
container, so both are dangling.** Nothing under them resolves. Two ways out,
user's call:

- bind-mount `/Users/mrf/repos/utg` into the container, or
- clone fresh inside the workspace: `git clone https://github.com/HL7/UTG.git
  /workspace/utg` (verified reachable anonymously on 2026-08-20; `/utg` is
  already gitignored).

Once it resolves, the writer work is: emit XML into
`input/sourceOfTruth/v2/{codeSystems,valueSets}/`, close enough to their
conventions to be idiomatic — but **no longer byte-exact**, per the UTG
outcome above.

### Pending user actions

1. **Close Batch A.** Mostly answered by D18 already. What is genuinely left
   is the user's, not a committee's:
   - ValueSets for every CodeSystem, or only where Chapter 2C declares a Value
     Set block (438 tables do)?
   - Does D11's rule generalise? **Evidence says yes** — THO independently
     models 10 of the 18 exactly that way.
   - `status`, `experimental`, publisher and contact defaults.
2. **Answers still owed by V2 Management** — the two blockers in the briefing
   (below). The meeting happened but was short.
3. **Check #IG creation Zulip thread** — template trust submission, unchanged
   since June, unrelated to this workstream.

### Where the two committee conversations landed

**UTG subcommittee of TSMG (2026-08-20)** — went well.
- Clean diffs not required (above).
- Canonical URLs and merge route agreed.
- Briefing: `v291-extracted/utg-briefing.html`.

**V2 Management (2026-08-21)** — short meeting; the user corrected the
briefing before it. **Three items came off the blocker list**, recorded as
**D19**:
- **"All codes" in a CLD is ordinary FHIR**, not an ambiguity. A CLD composing
  a whole code system is standard. What survives is a narrow wording defect:
  0931/0932 say "all codes" then enumerate 2–3 UCUM codes.
- **The duplicate table pairs** (0567/0929, 0568/0930) are a
  deprecated/current pair each. Publish both, older deprecated.
- **0093/0340/0451 are conforming, not self-contradictory.** The V3
  requirements for declaring a concept domain *call for example codes*. Likely
  representation is a property on the concept domain code system — Batch B,
  low priority.

**D19 also records the process fix**, because two of those reached a briefing
as blockers when they never were: *an item is a blocker only if generation
cannot proceed without the answer AND the answer is not already determined by
something we know.* The register is where a question waits; a briefing is
where a question has been checked.

### The two things V2 Management still owes us

1. **Reproduce-vs-correct.** When the chapter publishes something demonstrably
   wrong (0931's invalid UCUM code; 0560's time units under a quantity name),
   do we reproduce, deprecate, or correct? THO has answered it **both ways** —
   corrected 0931, reproduced 0560 — so it is a live inconsistency, not an
   abstract question.
2. **Five concept domains declared by more than one table with a different
   definition each time.** We currently emit first-in-document-order, which is
   a coin toss:

   | Domain | Tables |
   |---|---|
   | `DeviceStatus` | 0682, 0962 |
   | `DeviceType` | 0657, 0961 |
   | `Modality` | 0259, 0604 |
   | `QuantityUnits` | 0560, 0602 |
   | `VolumeUnits` | 0568, 0777, 0930 |

   **Two are entangled with other items.** `Modality`'s emitted definition is
   0259's, which says the table was *removed from the standard as of 2.7* — so
   we are publishing a withdrawn table's wording as the live definition. And
   `VolumeUnits` is declared by three tables, two of which are the
   deprecated/current pair.

### UTG's XML, characterised (2026-08-24)

Read from a throwaway clone; conventions are simpler than feared and answer
what had been ask 2 of the UTG briefing.

- `input/sourceOfTruth/v2/{codeSystems,valueSets}/`, named `cs-v2-0001.xml` /
  `vs-v2-0001.xml`. **416 CodeSystems, 439 ValueSets.**
- XML declaration, blank line, `<CodeSystem xmlns="http://hl7.org/fhir">`,
  **2-space indent, LF endings, self-closing value elements**, `&#39;` for an
  apostrophe in an attribute.
- **No `<text>` narrative in any of the 416** — narrative is generated
  downstream, not stored. That was the flagged source of diff noise and it
  simply is not there.
- **No `<meta>`**, so no `lastUpdated` churn.

### What was decided this session — ADR-0008 D17 to D20

- **D17** — ten of the twelve missing spaces after a period restored; the two
  dotted identifiers (`Observation.Code` 0396, `…Reason.PurposeOfUse` 0717)
  deliberately left, because a space would corrupt the name. The report is now
  **0 to decide, 0 to confirm**.
- **D18** — the IG is a THO staging workspace; canonicals, versioning and the
  standing of THO's existing content all follow from that. See "Read this
  first" above.
- **D19** — three register items closed without a committee, plus the blocker
  test.
- **D20** — the text policy applies to `sourceOfTruth/v2/` only; external code
  system records are reference-only and are never normalized, even where they
  carry the same defect. **THO's v2 content has doubled spaces in 452
  descriptions and 108 displays** — 361 of 416 files — and we elide ours
  anyway. Note `external/v2/namingSystems/` (4 records) is v2-related *and*
  external; external wins.

### The 18-table count was wrong, and the correction matters

The long-standing note "397 of 415 code-bearing tables can reuse a THO
canonical; **18 need minting**" is misleading. Checked against `tho-r5/` on
2026-08-20: THO has **no CodeSystem for any of the 18**, but **does have a
ValueSet for 10**, whose `compose` names the real system.

| What it needs | Count | Tables |
|---|---:|---|
| Nothing new — author at an existing THO canonical over an existing system | 10 | 0567, 0568, 0929–0932 (UCUM); 0725 (v3-ActMood); 0125 (v2-0440); 0136 (v2-0532); 0338 (v2-0203) |
| A ValueSet only, over an external system | 3 | 0820 (LOINC), 0823 (SNOMED + DAR + NullFlavor), 0459 |
| **A genuinely new CodeSystem** | **2** | 0411, 0460 |
| Escalation, not a resource | 3 | 0093, 0340, 0451 — now closed by D19 |

**0411 is a dangling canonical in the published chapter**: Chapter 2C prints
`http://terminology.hl7.org/CodeSystem/v2-0411` and THO has no such resource.

### Non-obvious things the next session must not re-derive

- **The briefings are generated, not hand-written.**
  `tooling/scripts/render_utg_briefing.py` and `render_v2mgmt_briefing.py`,
  sharing `briefing_style.py`. Each emits HTML *and* a Markdown twin. **Edit
  the module, never the output.** The user reads HTML and shares it — do not
  hand them Markdown for anything committee-facing.
- **Four correction mechanisms now exist and they are not interchangeable:**
  the rule chain in `RULES` (generalises), `MANUAL_CORRECTIONS` (D14, does
  not), `MISSING_SPACE_CORRECTIONS` (D17, does not), and detectors that report
  without changing. A new correction table needs a new kind in
  `CORRECTION_TABLES`, or its changes get attributed to the wrong decision.
- **138 tests** in `test_vocabulary_text_policy.py`; run before and after any
  policy change.
- **Every character-level change must be checked against BOTH corpuses** —
  except where the LLM truncated the value. D17's table 0719 correction sits
  past one of the 14 known truncations, so it fires in python-docx only and
  creates no new disagreement.
- **`MANUAL_CORRECTIONS` matches a text fragment within a named table, never a
  location path.** The two pipelines index coded content differently.
- **Rule order in `RULES` is load-bearing.**
- **python-docx is the character-faithful pipeline; the LLM is structural
  corroboration only.** Generation reads `v291-extracted/vocabulary/`.
- **Do not re-run the LLM extraction casually** — ~$11.60. Use `--resume`.
- **Four authored files need `.gitignore` exceptions** and vanish silently
  without one. The briefings needed them too; they are in place.

### Loose ends nobody has decided about

- **The changelog's "missing space after a comma" list does not match the
  corpus.** It documents 0074/0354/0367/0396; a scan finds 0074 (×2), 0354,
  0396, 0399, 0550, 0953 — and misses 0367 because that one is `e.g.,highest`,
  where a period precedes the comma. The two scans used different patterns and
  disagree in both directions. **Nothing is wrong in the output**, but "Still
  outstanding" is a record we rely on and needs one reconciliation pass.
- **Three dashes the rule refused to repair** — 0357 `Message is not
  -conformant`, 0368 `Emergency -stop`, 0919 `Default -.will be assumed`.
- **Table 0440 sibling defects** — `OBX-5Observation`, `OM2-6.3and`,
  `and8.8.4.8`. A different shape from the sentence-boundary detector.
- **Table 0440's `CNN` row contradicts the D14 correction to its `NDL` row**
  on one point. One line to reverse if the user prefers the sibling.

### Regeneration sequence

After any policy change, in this order:

```
python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

Then check `git diff --stat v291-fhir/`. D17 produced **no drift there at all**
— the corrections touched comments and descriptions, not concept domains.

### Build verification status

Untouched. This workstream has produced tooling, extracted data, one generated
CodeSystem and two briefings, none of which is in a build. Nothing needs to
reach `main` or `build`. **A smoke-test IG build was proposed and not yet
run** — worth doing before generating ~800 resources, because D1 redefines
`CodeSystem/conceptdomains` at THO's own canonical while `hl7.terminology`
supplies 3.0.0 of it, and whether the publisher tolerates that is untested.

### Open blockers

- **The UTG repo needs to be inside `/workspace`.** Only `/workspace` is
  mounted (virtiofs); `/Users` does not exist in the container, so a symlink
  to a host path can never resolve. The user is removing the symlink and
  cloning directly. Full `--depth 1` is **187 MB**; the part that matters,
  `input/sourceOfTruth/v2/`, is **6.8 MB**, so a sparse checkout is an
  option.
- Everything else is gated only on the user's decisions.

## Session History

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
