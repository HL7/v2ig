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

## ACTIVE — 2026-10-14 (session 8: ten rulings captured, three mechanisms to carry them, and one of my own findings withdrawn)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### First thing next session

**Ask whether more rulings have landed in `docs/issue_resolutions.md`.** That
file is where the reviewer writes them, in prose, as they come out of V2
Management calls. All eight currently in it have been acted on. The reviewer
said at the end of session 8 that more were expected before the next rebuild,
so **read that file before anything else** — and `git log -p` it, because it
is edited in place and a new paragraph is easy to miss.

**The IG has not been rebuilt since 2026-09-23 and is now badly stale.** That
is deliberate — the reviewer asked to batch the rebuild until the rulings stop
arriving — but it means **every number read off `vocab-ig/output/` is wrong**,
and the link checks that run against a build cannot be trusted. Rebuild before
presenting anything.

### How to record a ruling

Three mechanisms, and picking the wrong one is the main way to get this wrong.
All three are keyed by table number and all three are enforced by tests.

| What happened | Mechanism | Invariant |
|---|---|---|
| Awaiting an answer | `TENTATIVE_OVERRIDES` (ADR-0011) | names an **open** register item |
| Told not to publish | `RULED_SUPPRESSIONS` (ADR-0013) | names an **answered** register item |
| Told the chapter's classification is wrong | `RULED_RECLASSIFICATIONS` | names an **answered** register item |

A suppression removes output and needs only a table number. A
**reclassification adds output**, so it must say what to publish and over
which code system — that cannot come from the chapter, because the chapter
being wrong is the premise. The three are checked disjoint: a table cannot be
awaiting a ruling, withheld by one, and republished by one at once.

Every ruling also needs a `resolution` on its register item —
five keys, all required:

```python
"resolution": {
    "who":    "V2 Management",       # the body with the authority
    "forum":  "V2 Management call",  # the room it was given in
    "date":   "2026-10-14",
    "ruling": "One sentence: what they actually decided.",
    "effect": "What changed here. 'Nothing' is a real answer and worth saying.",
}
```

**A ruling almost never covers a whole register item.** Seven of the ten
answered items were *split out* of a larger finding, because the committee
named two tables of a four-table item. **Split rather than close**, narrow the
parent's `tables` and `ask`, and say in both directions what is still open.
The suppression and reclassification invariants will catch you if you do not:
they refuse an item that has no `resolution`, which is exactly what a
part-answered parent still looks like.

### What landed in session 8

Ten rulings across four commits. The register went from **38 items, 1
answered** to **44 items, 10 answered** — it grew because splitting adds
items, and one of the answers withdrew a finding of ours rather than
settling a question of the chapter's.

- **`b058aabe`** — reproduce-or-correct has no single answer; 0567/0568
  withheld; 0010 withdrawn; 0005 settled.
- **`5cd77e11`** — 0078 withheld as a duplicate; 0411 to concept-domain-only;
  0188 withdrawn; 0133's description emphasised.
- **`ae167fa8`** — 0350/0351 reclassified and published.
- **the correction** — `esc-tho-dangling-value-sets` withdrawn as a mistaken
  finding, and the false "cannot expand" warning removed from the build.

**The blanket reproduce-or-correct ask is gone and `render_defect_review.py`
replaces it.** The ruling was that no single rule applies — it goes per class
and sometimes per instance. So `esc-retain-known-errors` stays **open and
unresolved** (a `resolution` would claim an answer nobody gave) and the 34
open findings are now grouped into **6 classes, ordered cheapest-answer-
first**, each entry carrying what the chapter says, what THO says, **what the
guide publishes today read from the build report**, and the decision needed.
`v291-extracted/defect-review.md` is the thing to walk with the reviewer.
It now carries **34 findings in 6 classes**; the THO-divergence class lost
one when the dangling-value-sets finding was withdrawn.

**`CLASSIFICATION` in that module is the only authored part**, and a test
requires it to cover every open item. Add a finding to the register without
classifying it and the suite fails — which is the point.

### Things that will bite

- **A THO canonical with no CodeSystem behind it is usually not a defect.**
  This cost the session its biggest wrong turn, and it is the single most
  useful thing on this page. THO mints endorsed URIs under
  `http://terminology.hl7.org/CodeSystem/` for code systems whose *content*
  belongs to somebody else, registers them as NamingSystems with a
  `responsible` party, and publishes no content at all. Its
  [external code systems page](https://terminology.hl7.org/en/external_code_systems.html)
  lists them. **The right test for a compose target is "THO publishes a
  CodeSystem at it OR registers it as an external code system."** Testing
  only the first produced a four-table "dangling value sets" finding that
  was entirely wrong; under the correct test, exactly **one** unresolvable
  target exists in every v2 value set THO publishes, and it is the already
  known `v2-0962` → `http://hl7.org/fhir/device-status`. Nothing in a value
  set distinguishes the two cases — the distinction lives in the
  NamingSystem, in a `responsible` field that is easy to read past.
- **A ruling's stated premise is sometimes wrong, and checking is the job —
  but check your own premises with the same force.** The 0567/0568 ruling
  said "the CS in THO have already been retired"; there are no CodeSystems
  for those tables at all, and the reviewer confirmed the slip. The
  0350/0351 ruling said the CLDs needed repointing; **they did not, and the
  reason I believed they did was my own bad finding, which the reviewer had
  taken on trust from the register.** The register fed the reviewer a wrong
  premise, and the reviewer fed it back. That loop is the failure mode to
  watch: a finding in the register is evidence to whoever reads it, so a
  wrong one does not stay contained.
- **Numbers in authored prose rot, and the tests only cover what somebody
  added.** Six drifted this session. Two were caught by existing tests; the
  other four — `824 artifacts generated`, `8 classes of chapter defect`, and
  two index.md counts — were found by reading the metrics strip *after* the
  covered ones failed. **Every number on the V2 Management briefing's metrics
  strip is now under a test**, including the blocking-question count, which
  the page had already contradicted: the strip said one while two blockers
  were listed, the second downgraded in its own prose without the number
  following.
- **The ledger listed answered items as "Open issues"** until session 8. It
  was latent because the only previously answered item was scoped to "32
  tables", which matches no table number and so never reached a table
  section. Answered items now render under their own heading with the ruling.
- **Suppressing a table shifts concept element ids.** They come from one
  counter allocated in table order, so withholding 0411's two concepts moved
  every id allocated after it; `cs-v2-0460.xml` was the only file affected.
  Benign, but it looks alarming in a diff.
- Everything in the previous ACTIVE still applies: the enforced build order,
  `pgrep -f` matching the Bash tool's own wrapper, authored anchors over
  generated heading slugs, never interpolating a count into a heading, every
  page starting at `###`, and `grep` being unable to search for a NUL byte.

### Open, and worth knowing

- **0350/0351 are published and complete.** Both halves of the ruling are
  done, and the CLD half turned out to need nothing. See the correction
  below — this entry said the opposite for most of the session.
- **`vs-v2-0962.xml` is an orphan** — tracked, staged, published, for a table
  that became `needs-decision` and whose file nothing prunes. **Pre-existing,
  not from any ruling.** The writer reports any file a full run did not write
  rather than deleting it, because `--table` runs cannot know what is stale.
  It wants a decision, not a sweep.
- **0460 is now the only minted CodeSystem canonical in the corpus.** 0411
  leaving made `esc-0460-user-defined-mint` a sharper question, not a smaller
  one. 0093 is open alongside it.
- **0895 is still on the needs-decision list**, for a reason unrelated to
  anything ruled this session: its Content Logical Definition is not one of
  the shapes this guide builds. **0456 needs nothing** — it was only ever on
  the withdrawn dangling-value-sets finding.
- **`render_metrics_summary.py` is still untracked and undecided**, four
  sessions on. Written 2026-09-29 for an annual-accomplishments report; reads
  vocabulary build artifacts, so it is probably this branch's.
- Session 4 work is untouched: promote `render_field_mapping.py` into the IG;
  decide what maps to properties / extensions / nothing; Ch2c steward against
  THO's `structuredefinition-wg`. **S3-04 is partial**; **S2-15**, **S2-16**
  (property-instance suppression — the one with teeth), **S2-20**.

### Answered this session, so stop asking

- **Is `Evidence` the right navbar name, and does the evidence page want
  splitting?** This was **invented by an agent** and copied forward through
  three handoffs as a "reviewer question from session 5". There is no session
  5 entry containing it and no tracker row. The reviewer's response was that
  nobody human ever raised it. **Struck.**
- **`conceptdomains-divergences.json`'s `generated` date** — removed. Nothing
  read it; it made the file differ across a day boundary with no content
  change. Verified byte-identical across two runs, so `--from` is now
  trustworthy and a clean diff means something.
- **Does IG Publisher make a retired CS or VS visually obvious?** No. The
  publisher has `CODESYSTEM_DEPRECATED = Deprecated` for individual concepts
  and `RES_REND_RET = retired` for a resource, but no banner — status renders
  as one metadata row among many. This is why 0133's warning went into the
  description as markdown. **Possibly worth raising with TSMG as a tooling
  gap**, since it affects every retired THO artifact.

### THO version

**Staying on 7.3.0** (snapshot dated 2026-07-27). 7.4.0 was released during
session 8; the reviewer is confident no v2 content changed in it. The version
is recorded in both `tho-fill-report.json` and
`conceptdomains-divergences.json`, so every comparison stays attributable —
if the snapshot is ever bumped, those two files say what changed under it.

### Build

```
python3 tooling/scripts/build_vocab_ig.py            # preprocessing only, ~11 s
python3 tooling/scripts/build_vocab_ig.py --publish  # + the publisher, ~17 min
```

Seven preprocessing steps, then the publisher (silent for ~13 of its 17
minutes during "Run Template"). Check it is alive with
`ps -eo pid,etime,comm,args | awk '$3=="java"'` rather than assuming it hung.
**`kill` on the shell wrapper does not stop the JVM**; kill the java pid, or
two publishers write the same directory.

Current preprocessing state: **398 CodeSystems, 422 ValueSets staged**, two
expected warnings on every run (the 0350/0351 unresolved code system, and the
0962 orphan) and no others. **587 tests pass.**

### How to look at the IG

**No web server needed.** Open `vocab-ig/output/index.html` off disk. Both
briefings are self-contained and sit in `v291-extracted/`; their links into
the IG are relative, so they resolve from there with a build present.

### Not ours — leave alone

Six untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html` — plus the undecided
`tooling/scripts/render_metrics_summary.py`. **`git add tooling/scripts/`
sweeps three of them in — stage vocabulary files explicitly.**


## Session History

## 2026-10-14 — Session 8: ten rulings, and a finding of ours that was wrong

Four commits, no build. The reviewer answered ten questions across two V2
Management calls, writing them into `docs/issue_resolutions.md` as prose, and
asked to batch the rebuild until the rulings stop arriving. The last of the
ten withdrew a finding of ours rather than settling anything in the chapter.

### What the rulings changed

Five tables stopped being published as they were. **0567, 0568 and 0078 are
withheld**; **0411** dropped to concept-domain-only, taking its CodeSystem and
ValueSet with it; **0350 and 0351** went the other way and are now published
where the guide previously wrote nothing. **0010 and 0188** were withdrawn
outright, which changed nothing here — both already routed `nothing-to-write`
— but creates binding-removal work in the structural workstream. **0133** got
a bolded discontinuation warning. **0005** was settled as needing nothing.

The 0567/0568 one is the pattern worth remembering: *"this IG will simply not
do anything with these VS"* sounded like a no-op and was not. The guide was
publishing both at 4.0.0 against THO's 3.0.0 — an increment earned honestly,
by adding display text to codes THO leaves bare — so it was minting new
versions of two artifacts a committee had just said to leave alone, and would
have gone on doing it every run.

### Three mechanisms, and why not two

ADR-0013 added `RULED_SUPPRESSIONS` and this session added
`RULED_RECLASSIFICATIONS`, neither of which could fold into ADR-0011's
tentative overrides. That table is for deviations *awaiting* a ruling; its
entries must name an **open** register item and their count is published as
the guide's un-ruled-deviation debt. Filing a settled ruling there would break
the invariant and inflate a debt figure with something that is not debt. So
the two new tables carry the mirror invariant — their items must be
**answered** — and a test checks all three are disjoint.

Suppression and reclassification then split from each other for a different
reason: **a suppression removes output and needs only a table number, while a
reclassification adds output** and so must say what to publish and over which
code system. That cannot be read from the chapter, because the chapter being
wrong is the premise.

### One ruling's premise did not hold, and one of mine did not either

**0567/0568** said *"the CS in THO have already been retired."* There are no
CodeSystems for 0567, 0568, 0929 or 0930 at all — only four ValueSets, all
active, all composing from UCUM directly. Shown this, the reviewer confirmed
the slip. The ruling's substance was unaffected.

**0350/0351 is the one worth reading.** The ruling said the value set CLDs
needed repointing at the appropriate external code system. I reported back
that there was no such code system to point at: THO publishes no
`CodeSystem/v2-0350` or `v2-0351`, yet its NamingSystems map the NUBC OIDs to
exactly those canonicals. I published the tables composing over what I
believed was a dangling pointer, flagged them as unable to expand, and wired
a warning into every run.

**That was wrong.** The reviewer pointed at THO's
[external code systems page](https://terminology.hl7.org/en/external_code_systems.html):
`http://terminology.hl7.org/CodeSystem/v2-0350` and `.../v2-0351` are the
**HL7-endorsed URIs for the two NUBC code systems**, listed there with dashes
in both the Fragment and Complete Code System columns. THO mints a canonical
under its own hostname for a code system whose content belongs elsewhere,
registers it as a NamingSystem with `responsible: NUBC`, and publishes no
content. The CLDs were already correct. The classification half of the ruling
stands on its own evidence — `v2-tables` types both tables `Externally
defined` — so the tables are published, unchanged from THO, and complete.

**And the error was older than this session.** `esc-tho-dangling-value-sets`
had claimed four unexpandable THO value sets since the merge was first run.
All four are NUBC systems of exactly this kind. The finding is now withdrawn
rather than deleted, carrying why it was wrong, because it was circulated and
because anybody re-deriving it would make the same mistake: the comparison
asked whether a `CodeSystem-*.json` existed at the compose target, which is
the right test for an HL7-owned code system and the wrong one for an
externally-owned system under an HL7-endorsed URI. Re-tested correctly,
**one** unresolvable target exists across every v2 value set THO publishes —
the already-known `v2-0962` → `http://hl7.org/fhir/device-status`.

The loop is the part to remember. A wrong finding in the register became the
premise of a ruling, which came back as an instruction to fix something that
was not broken. **The register is evidence to whoever reads it**, so a bad
finding does not stay contained.

### The blanket ask is gone

`esc-retain-known-errors` asked V2 Management for one rule covering every
defect in the chapter. The answer was that no single rule applies — per class,
sometimes per instance, with individual issues reviewed. That makes the ask
unusable and the defects no less real, so `render_defect_review.py` replaces
it: 34 open findings in 6 classes, ordered cheapest-answer-first, each
carrying what the chapter says, what THO says, **what the guide publishes
today read from the build report**, and the decision needed.

The item stays **open and unresolved**. A `resolution` would claim an answer
nobody gave, and the mechanism should not be used to record "they declined to
generalise."

### Splitting, not closing

Seven of the ten answered items were split out of a larger finding, because a
committee names two tables of a four-table item. The invariants force this:
both new mechanisms refuse a register item with no `resolution`, which is what
a part-answered parent still looks like. The register grew from 38 items to 44
while going from 1 answered to 10 — growth is the expected shape here.

Where a ruling bears on its former siblings, that is said in both directions.
0411 leaving `esc-0460-user-defined-mint` makes **0460 the only minted
canonical in the corpus** — a sharper question, not a smaller one.

### Six drifted numbers, four of them uncovered

`7,580` THO-only values is 7,588 and `731 of 817` is 733 of 819, both caught
by existing tests. `824 artifacts generated` and `8 classes of chapter defect`
were found by reading the metrics strip *after* the covered ones failed, and
two index.md counts by the staging self-check. **Every number on that strip is
now under a test**, including the blocking-question count — which the page had
already contradicted, saying one while listing two blockers, the second
downgraded in its own prose without the number following.

### Two latent bugs that only surfaced now

**The ledger listed answered items as "Open issues."** Latent because the only
previously answered item was scoped to "32 tables", which matches no table
number and so never reached a table section. This session's rulings were the
first with real numbers. Answered items now render under their own heading
with the ruling attached.

**`vs-v2-0962.xml` is an orphan** — tracked, staged and published, for a table
that became `needs-decision` and whose file nothing prunes. Pre-existing and
unrelated to any ruling; confirmed by re-running the writer on a clean tree.
Left in place: the writer now reports any file a full run did not write rather
than deleting it, because `--table` runs cannot know what is stale.

### An invented question, struck

The handoff had carried "is `Evidence` the right navbar name, and does the
evidence page want splitting?" as a reviewer question from session 5 for three
sessions. `git log -S` puts its first appearance in session 6's handoff. There
is no session 5 entry containing it and no tracker row. An agent invented it,
labelled it a reviewer question, and three handoffs copied it forward. The
reviewer's response: nobody human ever raised it.

Same failure as session 7's "no case in the corpus" — a confident unverifiable
claim propagating. The difference is that one was about the build and could be
computed; this one was about a person, and the check was `git log -S`.

### Also

- `conceptdomains-divergences.json`'s `generated` date is gone. Nothing read
  it; it made the file differ across a day boundary with no content change.
  Verified byte-identical across two runs, so `--from` is trustworthy now.
- Answered the reviewer's question about IG Publisher and retired resources by
  searching the publisher's rendering phrases: there is
  `CODESYSTEM_DEPRECATED` for concepts and `RES_REND_RET` for a resource, but
  no banner. Status renders as one metadata row. Hence the markdown approach
  for 0133.
- Suppressing 0411 shifted concept element ids in `cs-v2-0460.xml` by two.
  Ids come from one counter allocated in table order. Benign, verified, and
  alarming in a diff.
- THO 7.4.0 was released; staying on 7.3.0 on the reviewer's judgement that no
  v2 content changed.

### Not done

No build. 587 tests pass and the preprocessing chain runs clean apart from the
two expected warnings, but **the IG on disk is from 2026-09-23** and predates
every ruling in this session.

---

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
