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

## ACTIVE — 2026-09-29 (session 7: the briefing's own claims checked, and two found wrong)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### First thing next session

**Capture what V2 Management said on 2026-09-23.** That meeting has now
happened and **nothing from it has been recorded** — session 7 did not attend
to it. The refreshed briefing was prepared for that meeting, so whatever was
said there is the most valuable un-captured thing in the project.

**There is now only one genuinely blocking ruling**, not two: *reproduce or
correct*, outstanding since August. The second item (concept domain
definitions) was downgraded to a confirmation in session 7 — see below.

**Use the `resolution` mechanism rather than editing prose.** It is described
below and it works; one item already uses it.

**There is now a mechanism for this, so use it rather than editing prose.** Add
a `resolution` to the item in `vocabulary_escalations.py` or
`vocabulary_general_questions.py` — five keys, all required:

```python
"resolution": {
    "who":    "V2 Management",       # the body with the authority
    "forum":  "V2 Management call",  # the room it was given in
    "date":   "2026-09-23",
    "ruling": "One sentence: what they actually decided.",
    "effect": "What changed here. 'Nothing' is a real answer and worth saying.",
}
```

That one key moves the item: it stops rendering on `open-items` and starts
rendering on `evidence` with its ruling attached, keeping its number and its
original text. Counts, the audience sentence and every cross-link follow
automatically. Then re-run the chain and rebuild.

`who` is the body with the authority, which is not always the room — the
reordering ruling is a **TSMG** ruling given in a **TI WG** meeting, and it is
recorded as exactly that.

### What landed in session 7

Session 7 was short and did two things: it answered a question about the OIDs,
and it committed the briefing work session 6 left uncommitted — **after
checking its claims, two of which were wrong.**

- **`4e81c91d` — the uncommitted briefing rework, corrected and committed.**
  Session 6 ended with a substantial uncommitted diff. Its central claim was
  verified and **holds**: the guide was never choosing between competing
  concept domain definitions by document order. All five multiply-declared
  domains publish THO's definition — checked against the published
  `conceptdomains` resource, not against the report about it. So the V2
  Management item really does drop from a ruling to a confirmation, and the
  blocking count from two to one.
- **Two claims in it were wrong, and both are the kind that would have been
  challenged in the room.**
  - It said there is *no case in the corpus* of a domain declared by several
    tables with no THO definition to fall back on. **There are 20** — `Units`,
    `GiveUnits`, `Indication` and others. The true claim is narrower and is
    the one the argument actually needs: every domain whose tables describe it
    *differently* has a THO definition, so document order never decides an
    outcome. In all 20 the tables agree with each other, so there is nothing
    to choose between. The page now states both numbers.
  - It listed **`Confidentiality`** as a substantive disagreement with THO. It
    is not one: the two texts are word-for-word identical and differ by THO's
    `*Usage Note:*` emphasis and a trailing full stop.
- **That second one was a pipeline defect, not a prose defect**, which is why
  it is worth remembering. `generate_concept_domains.py` compared definitions
  **without the punctuation carve-out the THO merge applies everywhere else**,
  so it classified a formatting difference as the two bodies describing a
  domain differently. It now uses `tho_merge.is_editorial` — the project's
  existing canonical test — and reports such cases as their own kind,
  `definition_differs_from_tho_editorially`. **Four** substantive
  disagreements, not five, computed correctly wherever the number appears.
- **`question_link()` is confirmed working.** Session 6 built it; session 7
  verified it does its job. The answered reordering question now resolves to
  `evidence.html` while the open ones stay on `open-items.html` — which is
  exactly the dead link it was written to prevent. **All 67 briefing→IG links
  resolve** against the built IG.

### The OID question, asked and answered this session

The reviewer asked whether the conflicting OIDs were for the *tables* or for
the code systems and value sets. **It is both, and the distinction matters.**
Chapter 2C carries **three** OIDs per table: a Table OID in the `.12` arc (798
of 799 tables), a Code System OID in `.18` (435), a Value Set OID in `.21`
(438). The comparison is sound — THO uses the same two latter arcs for the
same two resource types — and the two known conflicts are the only two. **The
table OID is published nowhere**, which is a default rather than a decision,
and is registered as `esc-table-oid-unpublished`. This is all already on the
ledger's OID overview and in the register; it is repeated here only because it
was asked again.

### What landed in session 6

- **`70f062c1` — the reordering question is answered and closed.** TSMG ruled
  on 2026-09-21, via TSMG members at the TI WG meeting, that **reordering a
  code system's concepts is not a change and does not increment the version.**
  It confirmed what the build already did — `concepts_changed` has compared
  concepts as a map keyed by code since the merge was written, and
  `_canonical_compose` sorts both sides — so **no artifact moved and no version
  number changed.** What moved is the standing of the rule: the 32 tables
  carrying exactly THO's codes in a different order now keep THO's version on
  the policy owner's authority rather than on our reading of the policy.
- **The same commit built the mechanism**, because nothing had ever been
  answered before and there was nowhere to put an answer. Two things it
  exposed: `question_anchor()` hard-coded `open-items.html`, so the first
  ruling would have turned every cross-link in the guide into a link to a page
  the question was no longer on; and the intro hard-coded "one is for TSMG, the
  rest for V2 Management", which is wrong the morning after any meeting. Both
  are computed now.
- **`00cce13f` — the V2 Management briefing is current.** Re-dated to
  2026-09-23, summary rewritten around the guide existing, and **every ask now
  points at its evidence** — the September lesson, applied to the other room.
  Link helpers moved down into `render_v2mgmt_briefing` (which
  `render_ti_briefing` already imports from); the TI briefing's rendered output
  is **byte-identical**, checked before and after.

### Three numbers were wrong. They are fixed, and now tested.

This is the part worth remembering, because it will recur. The briefings and
the authored prose carry numbers that are **transcribed** from the build, and
transcriptions rot.

- The guide's own TSMG preamble said **23 value sets increment, 392 hold**. It
  is **22 and 393** — a concept display stopped triggering an increment in
  September and the sentence did not follow. It no longer restates them; it
  points at the version table on `tho-merge`, which is computed.
- **"355 tables with no code system block" is 362.**
- `5,540` codes and the eleven description-only increments were checked and
  **are** exact.

`test_render_v2mgmt_briefing.py` now compares the briefing's headline numbers
against `tho-fill-report.json` and the extraction on every run. **If you author
a number into a briefing, add it to that test.**

**Session 7 found two more of exactly this kind**, which puts the count at five
across two sessions. Both were in authored prose that no test covered, and one
of them traced back to a pipeline classifier rather than the prose. The
standing lesson: **a claim in a briefing is a claim about the build, and the
build can be asked.** Before presenting a number or a "there is no case
where…", compute it. The absolute claims are the dangerous ones — "no case in
the corpus" was false the moment it was written.

### Things that will bite

- **A chip only links when the ledger has a section for that table.** Four of
  the eleven tables behind the concept-domain blocker have none — the merge
  found nothing to report against them. The first draft linked all eleven; the
  link test caught it. A link into a section that does not exist drops the
  reader at the top of a very long page, which is **worse** than no link.
- **The register's Markdown numbering is positional**, so answering an item
  renumbers the ones after it. That is fine there — the file is regenerated and
  never hand-edited — but **general question numbers are stable identifiers and
  are never reused**, because people cite them in minutes.
- Everything in the previous ACTIVE section still applies: the build snapshot,
  the enforced build order, `pgrep -f` matching the Bash tool's own wrapper,
  authored anchors over generated heading slugs, never interpolating a count
  into a heading, every page starting at `###`, and `grep` being unable to
  search for a NUL byte.

### Register — 38 items, 37 of them open

One answered. Plus **7 general questions, 1 answered and 6 open** — verified
against the modules this session, not transcribed.

### Still open on the review

Unchanged from session 5, and none of it was touched:

- **Session 4 work**: promote `render_field_mapping.py` into the IG; decide
  what maps to properties / extensions / nothing; Ch2c steward against THO's
  `structuredefinition-wg`; external code systems against ValueSet canonical
  gaps.
- **S3-04 is partial**; **S2-15**, **S2-16** (property-instance suppression —
  the one with teeth), **S2-20**.
- **Two reviewer questions from session 5 are still unanswered**: is `Evidence`
  the right navbar name, and does the evidence page want splitting? It is now
  **1.79 MB** and carries one more section than it did. Three sessions old now
  — worth either asking directly or dropping.
- **Table 0347's `title`** is `hl7VS-stateProvince` against THO's
  `HL7 Value Set for State/Province` — ours reads like an id in a title field.
- **`v291-fhir/conceptdomains-divergences.json` carries a `generated` date**, so
  the pipeline churns one line across a day boundary. It is the one thing
  stopping the chain being byte-reproducible, and that reproducibility is what
  makes `build_vocab_ig.py --from` safe to trust. **Still not fixed** — it has
  now survived three sessions. It was at least committed this time rather than
  left dangling, so the tree is clean, but the churn remains.

### A defect in a document that has already been presented

`render_ti_briefing.py`'s reordering ask says *"If the answer is **no**, a
meaningful number of artifacts move from unchanged to incremented"*. That is
inverted — answering *no* is what the build already does and changes nothing;
it is *yes* that moves them. The general-questions module has it the right way
round. **Left unfixed deliberately**: the briefing is dated 2026-09-21 and was
presented, and editing it rewrites the record of what the room was shown. The
room gave the right answer regardless. Fix it only if the file is ever reused
for a different meeting.

### Build

```
python3 tooling/scripts/build_vocab_ig.py --publish
```

Seven preprocessing steps (11 s), then the publisher (~17 min, silent for ~13
of them during "Run Template"). Check it is alive with
`ps -eo pid,etime,comm,args | awk '$3=="java"'` rather than assuming it hung.
**`kill` on the shell wrapper does not stop the JVM**; kill the java pid, or two
publishers write the same directory.

### How to look at the IG

**No web server needed.** Open `vocab-ig/output/index.html` off disk. Both
briefings are self-contained and sit in `v291-extracted/`; their links into the
IG are relative, so they resolve from there with a build present.

### Not ours — leave alone

Five untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`git add tooling/scripts/` sweeps two of
them in — stage vocabulary files explicitly.**


## Session History

## 2026-09-29 — Session 7: the briefing's own claims, checked

### Completed

**Committed session 6's uncommitted briefing work as `4e81c91d` — after
checking it.** An interrupted session left a substantial diff in the tree. The
reviewer asked for it to be reviewed and committed; reviewing it turned out to
be the point.

**Its central claim holds, and was verified rather than trusted.** The guide
was never choosing between competing concept domain definitions by document
order — all five multiply-declared domains publish THO's definition, checked
against the published `conceptdomains` resource rather than the report about
it. The V2 Management item genuinely drops from a ruling to a confirmation,
and the blocking count from two to one.

**Two claims in it were wrong.**

The first was an overstatement: *"there is no case anywhere in the corpus of a
domain declared by several tables with no THO definition to fall back on"*.
There are 20. The claim the argument needs is narrower — every domain whose
tables describe it **differently** has a THO definition — and that one is
true. In all 20 the tables agree with each other, so nothing is being chosen.
The page now gives both numbers, because the absolute version invites an
objection it cannot survive, in front of a committee.

The second was a misclassification, and it was a **pipeline defect rather
than a prose defect**. `Confidentiality` was listed as a substantive
disagreement with THO; the two texts are word-for-word identical and differ by
THO's `*Usage Note:*` emphasis and a trailing full stop.
`generate_concept_domains.py` was comparing definitions without the
punctuation carve-out the THO merge applies everywhere else, so a formatting
difference read as the two bodies disagreeing about what a domain means. It
now uses `tho_merge.is_editorial`, the project's existing canonical test, and
reports such cases as `definition_differs_from_tho_editorially`. Four
substantive disagreements, not five — and now computed correctly wherever the
number appears, rather than corrected in one document.

Fixing it in the pipeline rather than the prose was the whole point: the same
number appears in the briefing, the review report and the divergences JSON,
and patching the sentence would have left the other two wrong.

### Also

- **`question_link()` verified.** Session 6 built it to stop briefing links
  dying when a question moves page on being answered. It works: the answered
  reordering question resolves to `evidence.html`, the open ones to
  `open-items.html`. All 67 briefing→IG links resolve against the built IG.
- One incidental catch: the new review-page entry first got the action value
  `"note"`, which is not in `ACTION_ORDER` and would have raised `KeyError` at
  render time. It is `"informational"`.
- **Two stale items were cleared from the handoff, both my error.** It was
  still asking what to do with the versioning-policy PDFs — already decided and
  already executed, on the orphan branch `reference/policy-snapshots`
  (`bd2f96b7`, 20 September), which shares no history with anything and cannot
  be merged by accident. And it carried "the V2 Management meeting of
  2026-08-28 is still unrecorded" across six handoffs; searching both JOURNAL
  files found **no record of what those minutes were ever wanted for** — no
  register item cites them and no decision waits on them. It was surviving on
  momentum. Dropped.

**The general lesson, now five instances across two sessions:** a number in a
briefing is a claim about the build, and the build can be asked. Absolute
claims — "there is no case where…" — are the dangerous ones.

### State

Branch `dev/v291-vocabulary-ig`, commit `4e81c91d`. **562 tests pass.** Working
tree clean apart from the five `dev/framework` files. No build was run this
session — nothing touched the resources, only the reports and briefings that
describe them.

### Next

**Capture the 2026-09-23 V2 Management meeting.** It has happened, the briefing
was prepared for it, and nothing from it is recorded. That is the largest
un-captured thing in the project.

## 2026-09-22 — The first ruling, and somewhere to put the next one

Two commits. The session had one piece of new information in it and spent the
rest of its time on what that information exposed.

### The ruling confirmed the code and changed the argument

The reviewer came back from the Rockville plenary with one decision: **TSMG,
via its members at the Terminology Infrastructure WG meeting, ruled that
reordering a code system's concepts is not a change and does not increment the
version.**

Checking before writing anything was the right order. `concepts_changed` has
compared concepts as a map keyed by code since the merge was written, with a
docstring saying why, and `_canonical_compose` sorts both sides; two tests
already locked both in. **So the ruling moved nothing.** No artifact changed,
no version number changed, and the 32 affected tables were already keeping
THO's version.

What it changed is the standing of the rule. The guide had been saying this was
"the one rule behind the version numbers that rests on a judgement rather than
a fact". It is now a fact, and the 32 tables keep THO's version on the policy
owner's authority rather than on our reading of the policy. That is worth more
than a code change would have been.

**The authority and the room are different things, and the record has to say
both.** The question was tagged TSMG in both registers; the briefing was
presented to the TI WG. Asking the reviewer which to record produced the
detail that settles it — TSMG members were in the room — and that distinction
is now a field rather than a footnote: `who` is the body with the authority,
`forum` is where it was given.

### There was nowhere to put an answer

Nothing had ever been answered, so nothing in the pipeline could represent an
answer. The question was being asked in four places and the merge report in a
fifth, all of them phrased as open.

The fix used a split the review pages already have. `render_review_pages` asks
one question of every section — *is this asking me for something, or showing me
what was decided?* — and routes on it. An answered question asks for nothing,
so it crosses that line on the strength of one key. `resolution` carries who,
forum, date, ruling and effect; all five are required, because an answer with
no attribution is not usable six months later, and `effect` is required
separately because "the committee agreed with what we were already doing" is a
different and more reassuring fact than "the committee has not been asked".

Items keep their number and their original text. The register is circulated,
and an item that vanished between two circulations reads as dropped rather
than settled.

**Two latent bugs surfaced, both of the kind that only fire once.**
`question_anchor()` returned `open-items.html#<id>` unconditionally — correct
while nothing had ever been answered, and wrong for every cross-link in the
guide the moment something was. And the page intro hard-coded "one is for TSMG,
the rest for V2 Management", which is wrong the morning after any meeting.
Both are computed now, and an audience with nothing open says so and links to
the answer rather than leaving a heading that reads as a dropped question.

### The briefing refresh turned into a numbers audit

With the V2 Management meeting the next day, the briefing was still dated
28 August and still described the resources as newly generated.

Re-dating it was the small part. The useful part was checking its numbers
against the build instead of carrying them forward, which found three wrong —
and one of them was not in the briefing at all but in the guide:

- **The guide's TSMG preamble said 23 value sets increment and 392 hold. It is
  22 and 393.** ADR-0012 removed an increment trigger in September and the
  authored sentence did not follow. It now points at the computed version table
  on `tho-merge` rather than restating it, which removes the drift permanently.
  The eleven description-only increments the same paragraph names were checked
  against the write report and are exact, each with `triggers: ['description']`
  and nothing else.
- **"355 tables with no code system block" is 362.**
- `5,540` codes is exactly right.

Those now have tests that read `tho-fill-report.json` and the extraction, so
the next drift fails a test instead of reaching a committee.

### Applying September's lesson to the other room

The TI meeting's lesson was that an ask with no route to the evidence fails on
a projector. The V2 Management briefing had the same gap, so both blockers and
the design question now carry their affected tables as chips and named links
into the pages holding the detail — in the HTML and in the Markdown twin, which
is what gets pasted into an agenda.

The link helpers moved down into `render_v2mgmt_briefing`, which
`render_ti_briefing` already imports from, rather than being copied. The TI
briefing's output was hashed before and after and is byte-identical, which
matters because it is a document that has already been presented.

**The link test earned itself immediately.** Four of the eleven tables behind
the concept-domain blocker have no ledger section — the merge found nothing to
report against them — and the first draft linked all eleven. Chips now resolve
against the ledger and render plain, with a note, when there is no section to
reach. A link into a section that does not exist drops the reader at the top of
a very long page, which is worse than no link at all.

### Noticed and deliberately not fixed

`render_ti_briefing.py`'s reordering ask has its conditional inverted — it says
answering *no* moves artifacts to "incremented", when *no* is what the build
does and changes nothing. The general-questions module has it the right way
round, and the room answered correctly regardless. It is left alone because the
briefing is dated and was presented, and editing it rewrites the record of what
was shown.

## 2026-09-21 — The ledger stops asking questions it already knows the answer to

Worked from the HL7 Plenary in Rockville in short stretches around the
Terminology Infrastructure WG meeting. Six commits, two builds, both clean.

### The reviewer read the ledger and found it was shouting

The report said 489 "Differences from THO", each row framed as something a
committee might have to adjudicate. Reading it in anger, the reviewer noticed
rows that "amount only to capitalization changes in the display value", and
then that the same applied to status `N` becoming `active`.

Counting bore it out, and the numbers were worse than the complaint: **287 of
489 were never questions.** 211 were THO carrying the V2 status letter where
this guide carries the FHIR status it maps to; 76 were the same words styled
differently. Only 202 were real, and they were being crowded out.

**Two things were wrong underneath the presentation, and neither was visible
from the page.**

The status ruling *already existed*. `INHERITED_STATUS_CORRECTIONS` has said
`N` reads as `active` since the merge was written, with a docstring explaining
why. But it is reached only by `correct_inherited_status`, which handles
concepts taken wholesale from THO — **one record in the corpus**. The 209
concepts both sides carry went through generic property comparison and came out
as unexplained differences. The same fact got two treatments depending on which
code path found it, and nothing anywhere said so.

And `is_editorial()` never reached concept level. It was recorded on
description, purpose and name — 14 records — while concept display and
properties got nothing. Worse, because `words()` lowercases, capitalisation
*would* have been swallowed into "punctuation" had the flag reached them,
losing the one distinction that turned out to matter.

So the fix was not a new idea, it was applying two existing ones consistently
and giving case a direction.

### The carve-out, and why it is not symmetrical

The reviewer chose to **publish THO's capitalisation** where THO is the more
capitalised side, rather than only reclassifying. That is a genuine exception
to chapter-wins and is recorded as **ADR-0012**. It is defensible because the
words are identical — the chapter loses nothing — and re-lower-casing a display
THO had tidied would make the artifact worse for no reason. Five displays,
tables 0203 and 0396. **No version moved**; both were already incrementing.

The reverse is deliberately *not* symmetrical, and this is the part worth
remembering. `tho-dropped` is ambiguous in a way `tho-added` is not: the one
real instance is THO correctly lower-casing "for" in *Sex Parameter For
Clinical Use*, which is an improvement — but the identical signature would be
produced by THO losing a proper noun. Only a person can tell those apart, so
they are surfaced rather than absorbed in either direction.

**Looking at the data kept the carve-out honest twice.** The seven case-only
differences were not all displays: one is a resource `name`,
`Hl7VSStateProvince` against `Hl7VsStateProvince`, where *ours* is arguably
right because VS abbreviates ValueSet. `name` is identity-adjacent and had to
be excluded. The reviewer then asked a sharper question — whether the casing
was the *only* thing driving that artifact's version — and the write report
answered it outright: table 0347 increments on `compose.include`, `name` **and**
`title`. Three triggers, so the condition did not bind and nothing changed.

### Then the briefing failed in the way documents do

The reviewer, holding the briefing in a meeting: the asks name a problem but
give no way to get to the evidence. That gap is invisible while writing and
expensive in the room — you read the question out, somebody asks "which
tables?", and you are hunting through 799 sections on a projector.

Every ask now carries its affected tables as links straight into the ledger.
The numbers are derived from the merge report rather than the prose:
0350/0351/0456/0895 for the value sets THO cannot expand, 0001 and 0719 for the
only two OID disagreements in the corpus, 0227 and 0719 for the descriptions,
0440 for the one concept carrying status `B`. A test resolves every link
against the built IG, fragment included.

### The orchestrator, and the snapshot it grew

`build_vocab_ig.py` replaced the build-order note that had been accumulating
constraints in this file for four sessions. The order is data — each step
declares what it produces and consumes, and `check_order()` refuses to run if
a step's inputs come from later. Re-deriving those dependencies from the
scripts rather than the note found the note incomplete: `render_review_pages.py`
needs the writer report as well as the divergences.

Two things fell out of it. **The chain takes 11 seconds** — the expense of a
build was always the publisher alone, and four sessions of caution about
running generators were misplaced. And running it end to end **reproduced the
committed tree with zero diff**, which is a stronger property than it was
written for.

That led to the snapshot. The publisher wipes `output/` on startup, so for
twenty minutes there is no readable IG, and after an interrupted run there is
none at all — the state this session opened in. `--publish` now refreshes
`output-snapshot/` **after a run that exits 0**, never before: snapshot-before
would happily preserve a half-finished build. It ran for real during the second
build, kept the IG readable throughout, and refreshed in 27.7 s.

### Two traps

`pgrep -f "http.server"` reported a server running when nothing was listening —
it matched the Bash tool's own wrapper. MEMORY documents this for the java build
check; the lesson is the pattern, not the command, and ACTIVE now says so.

And a near miss: the first cut of the ledger fix interpolated the count into a
heading. That number would have landed in the generated anchor and broken the
inbound link the first time it moved. Caught by reasoning about the anchor, not
by a test — and there is still no test that would catch the next one.

### Not done

The TI WG's actual feedback is not written down anywhere. That is the first job
next session and the only perishable one.
