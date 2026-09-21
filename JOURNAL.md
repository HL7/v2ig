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

## ACTIVE — 2026-09-21 (session 5: the ledger stops asking questions it already knows the answer to)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### Read this before anything else

**Session 5 (2026-09-21) was worked from the HL7 Plenary in Rockville**, around
the Terminology Infrastructure WG meeting, in short stretches between sessions.
The briefing written the day before was presented.

**Everything is built and verified. Nothing is outstanding.** The 2026-09-21
build covers every commit through `019244ff`:

```
Errors: 3288, Warnings: 145, Info: 92, Broken Links: 0     (20.6 min)
```

Identical on every number to the build before it, which is right for a change
that moved rows between tables and altered five display strings. Confirmed in
the published HTML: 45 tables carry the new *"Written differently"* table, 211
status rows are explained, 2 `tho-dropped` cases are surfaced, and
`Dentist Office Number` is published with the old lower-cased form gone.

**`vocab-ig/output-snapshot/` is managed automatically** and holds the last
build that finished, so the IG is readable even mid-build. `--no-snapshot`
turns it off. It is a copy; the live build is `vocab-ig/output/`.

### First thing next session

**Capture what the Terminology Infrastructure WG said.** The briefing was
presented on 2026-09-21 and the feedback has not been written down anywhere.
Five of the guide's open questions are addressed to exactly those people, and
this is the most perishable thing in the project — every other item below will
keep.

If that is already captured, the largest untouched work is **session 4**:
promote `render_field_mapping.py` into the IG; decide what maps to
properties / extensions / nothing; Ch2c steward against THO's
`structuredefinition-wg`; external code systems against ValueSet canonical gaps.

### What landed in session 5

- **`02b8b2ce` — presentation differences separated from disagreements.** The
  ledger listed 489 differences under one heading; **287 were never
  questions**. 211 were THO carrying the V2 status letter where this guide
  carries the FHIR status it maps to, and 76 were the same words styled
  differently (44 punctuation, 25 spacing, 7 capitalisation). **202 genuine
  disagreements remain.** They now render in their own table, *"Written
  differently, saying the same thing"*, which says nothing in it needs a
  decision.
- **ADR-0012 — five concept displays now publish THO's capitalisation**
  (0203 `GKV`/`KZVA`/`PKV`/`ZANR`, 0396 `DAR`). An exception to chapter-wins,
  justified because the words are identical. **No version moved.** The reverse
  direction is deliberately not symmetrical — see the ADR.
- **`48696948` — every briefing ask points at the evidence.** Affected tables
  as links into the ledger, plus named links to the page holding the detail.
  All 19 verified to resolve, fragments included.
- **`29230899` — the build keeps a snapshot** of the last run that finished.
- **`45f8c81e` — the build order is enforced, not remembered**
  (`build_vocab_ig.py`).

### Deliverable in use

`v291-extracted/ti-briefing.html` was presented to the Terminology
Infrastructure WG on 2026-09-21. Self-contained; open it off disk. **Capture
what the room said** — several of the guide's open questions are addressed to
exactly those people, and that feedback is the most perishable thing in this
project right now.

### Open questions for the reviewer

Both are now *answerable* — the IG is built and can be looked at.

1. **Is `Evidence` the right name in the navbar?** Currently "For review → What
   needs an answer / Evidence / Known issues".
2. **Does the evidence page want splitting?** It renders at 1.81 MB and 91
   sections. If it does, the split is Decided (74 groups, 1,534 values) /
   Informational (17 groups, 544 values) — the generator already groups by
   action class, so it is a small change to `build_evidence_page()`.

### Still open on the review

- **S3-04 is partial**: the fourteen tables are grouped by cause on
  `open-items`, and `known-issues.md` points at it, but the review-report
  evidence per table is not folded into the ledger sections.
- **S2-15** (no `deprecated` value for `CodeSystem.status` → backlog entry),
  **S2-16** (property-instance suppression — the one with teeth), **S2-20**
  (classify the page-URL/missing-space defects against the errata rubric).
- **Session 4 work untouched**: promote `render_field_mapping.py` into the IG;
  decide what maps to properties/extensions/nothing; Ch2c steward ↔ THO
  `structuredefinition-wg`; external code systems → ValueSet canonical gaps.
- **S3-03 is closed**, and so is the disagreement-classification work that
  came out of reading the ledger in session 5.
- **Two smaller things noticed in session 5 and not acted on.** Table 0347's
  `title` is `hl7VS-stateProvince` against THO's
  `HL7 Value Set for State/Province` — ours reads like an id in a title field.
  Only two title differences exist in the corpus, so it is not systematic, but
  it is the sort of thing the TI WG would spot. And
  `v291-fhir/conceptdomains-divergences.json` carries a `generated` date, so
  the pipeline churns one line across a day boundary; harmless, but it is the
  one thing stopping the chain being byte-reproducible over time, and that
  reproducibility is what makes `build_vocab_ig.py --from` safe to trust.

### Things that will bite

- **A snapshot is kept of the last build that finished.** It is a copy, not
  a second source of truth, and it is 406 MB. Do not diff against it, cite it,
  or serve it; if a page looks wrong, check which directory it came from.
- **The build order is now enforced, not remembered.**
  `tooling/scripts/build_vocab_ig.py` runs the seven preprocessing steps in
  order; each declares what it produces and consumes, and `check_order()`
  refuses to run if any step's inputs are not produced by an earlier one.
  `--list` shows the chain, `--from` resumes after a failure, `--publish` also
  runs the IG Publisher. **The whole chain takes 11 seconds** — the expensive
  part was only ever the publisher. Do not hand-run the seven scripts.
- **`pgrep -f` matches the Bash tool's own wrapper.** MEMORY documents this for
  the java build check; it bit again this session on `pgrep -f "http.server"`,
  which reported a server running when nothing was listening. **The trap is the
  pattern, not the process** — match on `comm` for anything.
- **Cross-page links must target an authored anchor**, never a heading slug the
  publisher generates. `<a id="x"></a>` survives the publisher verbatim
  (verified against `tbl-0001` in this build). Note that the *question* anchors
  come out as `<a name="...">` — the older form — which is why they still pass
  the link checker.
- **Never interpolate a count into a heading.** It lands in the generated
  anchor and breaks inbound links the first time the number moves. This was a
  live bug in `generate_table_index.py`, caught before it shipped.
- **`ADR-0010` names `general-questions.html`**, which is gone. Left alone
  deliberately — an accepted ADR records what was true when written.
- **Every page starts at `###`.** A `#` or `##` anywhere breaks CSS-counter
  numbering for the whole page.
- **`grep` cannot search for a NUL byte** — check in Python.
- `stage_vocab_ig.py` self-checks the counts on `index.md`. Believe it.
  399 CodeSystems, 424 ValueSets, 824 total.

### Register — 38 items

Unchanged this session. 57 open items total (39 escalations, 14 decisions) plus
7 general questions.

### Build

```
python3 tooling/scripts/build_vocab_ig.py --publish
```

That is the whole thing: the seven preprocessing steps (11 s) and then the
publisher. `--list` shows the chain and runs nothing. The equivalent by hand,
if the orchestrator is ever unavailable:

```
python3 tooling/scripts/build_vocab_ig.py       # or the seven scripts in order
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx8g -jar input-cache/publisher.jar \
  -ig vocab-ig/ig.ini -no-sushi
```

~17 min, **silent for ~13 of them** during "Run Template" — check the process is
alive rather than assuming it hung, with
`ps -eo pid,etime,comm,args | awk '$3=="java"'`. **`kill` on the shell wrapper
does not stop the JVM**; kill the java pid, or two publishers write the same
directory.

### How to look at the IG

**No web server needed** — verified this session. The IG's own JS does no
runtime data loading, so `file://` works: open `vocab-ig/output/index.html`
directly. Only `searchform.html` pulls external CSS, and it needs a live search
service anyway. External links out to hl7.org will not resolve offline, which is
inherent to being offline.

The briefing is self-contained (inline CSS, no scripts):
`v291-extracted/ti-briefing.html`.

If a server is genuinely wanted: bind `0.0.0.0`, never `127.0.0.1`; container
3000 → host 20010.

### Not ours — leave alone

Five untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`git add tooling/scripts/` sweeps two of
them in — stage vocabulary files explicitly.**


## Session History

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


## 2026-09-20 — Built, verified, and briefed for Rockville

Three commits. The IG went from dark to built-and-checked, the last big
session-3 item closed, and the Terminology Infrastructure WG briefing is
written. Session ran against an airport clock throughout.

### The build answered every question the last handoff asked

Four checks were set, and the reason they were set is that the previous session
changed the *page set* rather than the content of a page. All four passed, and
two of them passed in a way worth recording.

**The error count fell by exactly 191** — 3479 → 3288 — against a prediction of
"~191" derived from the number of `conceptdomains` narrative links rewritten in
`3a6b1acd`. An exact match on a number derived independently is the strongest
evidence available that the fix reaches the published resource and is not
merely present in the source.

**The cross-links land on the right questions.** Broken links stayed at 0 across
625,068, but 0 broken links only proves the anchors *exist* — `question_anchor()`
raises on an unknown id, so a dangling link was already near-impossible. The
open risk was a link that resolves to the *wrong* question. Checked
positionally: the table-OID paragraph reaches question 6 and the reordering
paragraph reaches question 1, as specified.

Incidentally established: the question anchors render as `<a name="...">`, the
older form, which is why the link checker accepts them.

### S3-03: both numbers were right, which is why it survived three sessions

The item read "the two 'needs a second look' computations still disagree — table
index says 21 rows; the ledger says 97 changed + 73 register-named". The first
finding was that **those numbers were stale**; the tree said 20 and
96 / 101 / 14. The second finding was that the framing was wrong. They are not
two computations of one quantity that disagree. They are two different
quantities:

- the **index** counts *coverage* — does the right KIND of artifact exist at
  all (4 kinds: new to THO, in THO not here, dangling in THO, nothing anywhere);
- the **ledger** counts *content and governance* — does it differ from THO, does
  a register item name it, is someone still deciding.

Neither is a subset of the other: 15 of the 20 are in the ledger's union, 5 are
not, and 150 ledger tables are not in the 20. So there was nothing to
reconcile and no recompute to do. The defect was that both sections were titled
"tables that need a second look", so a reader met 20 and 165 and concluded a
page was broken.

Retitled both, each stating its own count, each pointing at the other's
*question*. Two details are worth more than the fix:

- **The index heading interpolated its count** (`The 20 rows...`). That number
  would have landed in the generated anchor, so the ledger's new inbound link
  would have broken the first time the count moved. Caught before shipping; the
  heading is now static and the count sits below it. Generalised into the ACTIVE
  section: never interpolate a count into a heading.
- **The cross-links deliberately do not quote each other's number.**
  `generate_table_index.py` cannot see the register or difference data, so
  quoting the ledger's total would have meant a new cross-script dependency and
  a figure maintained in two places — which is precisely the failure being
  repaired. Each page owns its own count.

Both links use authored anchors rather than publisher-generated heading slugs,
matching every other cross-page link in the guide. That pattern was chosen
before the build and confirmed by it: `<a id="tbl-0001">` survives verbatim.

### The briefing, and what was left out of it

`ec2df186` writes the Terminology Infrastructure WG briefing for the Monday
morning meeting, following the established pattern — authored in
`render_ti_briefing.py`, rendered to HTML with a Markdown twin, sharing
`briefing_style`.

The room already knows what a FHIR IG is and why this one exists, so there is no
background section. It makes three claims and shows where each is backed:
THO-additive, issues surfaced as classes, and an auditable record of both kinds
of imperfection.

**The walkthrough order is the one editorial argument worth defending.** The
merge page comes second, immediately after Home, because the per-table pages
only make sense once the reader accepts that we write into THO's *canonicals*.
Until then "96 tables differ from THO" reads as a fork rather than a merge.

**The asks are filtered rather than reprinted.** The guide carries 57 open items
and 7 general questions; the briefing argues five, plus one item that is not in
the register at all — **four THO value sets that compose from a code system THO
does not publish and therefore cannot expand**. That is a live defect in THO,
found by this work, not ours to fix, and this is the only room where raising it
is useful. Tables 0560 and 0292 are named but not argued: they are about what
Chapter 2C says and belong to V2 Management.

**Every figure is transcribed, not computed**, and the briefing says so in its
footer and states that the guide wins any disagreement. Authored prose goes
stale, and a committee document that quietly contradicts the IG three weeks
later is worse than no document.

### Two traps, one old and one new

`pgrep -f "http.server"` reported a server running when nothing was listening —
it matched the Bash tool's own wrapper. MEMORY documents this trap for the java
build check; the lesson generalises to any `-f`/command-line match, and the
ACTIVE section now says so rather than naming one command.

The second is the heading-interpolation bug above. It is recorded because it was
caught by reasoning about the anchor rather than by a test, and there is still
no test that would catch the next instance of it.

### The orchestrator, finally, and what it turned up

`build_vocab_ig.py` runs the seven preprocessing steps. The part worth keeping
is that the order is **data, not a comment**: each step declares what it
`produces` and what it `consumes`, and `check_order()` verifies every step's
inputs come from an earlier step. Get the order wrong and it refuses to start,
naming the input that would not exist yet — rather than failing seventeen
minutes into a publisher run, or, worse, succeeding by silently reading last
run's file.

The dependencies were re-derived from the scripts rather than copied from the
note, which was the right call: the note said `render_review_pages.py` needs
`generate_concept_domains.py`, and it does, but it also needs
`write_utg_xml.py`'s writer report, which the note never said. The hardest edge
is that `generate_table_index.py` reads `table-ledger.md` through
`load_ledger_anchors()`, so the ledger must precede the index. That specific
swap has its own test.

**Two things fell out of building it.**

The chain takes **11 seconds**. It had been treated as part of an expensive
build for four sessions; the expense was always the publisher alone. Nothing
was ever gained by hand-running a subset.

Running it end to end regenerated the committed tree with **zero diff**, which
makes the whole pipeline byte-for-byte reproducible from the corpus. That was
not previously known — it is a stronger property than the orchestrator was
written to deliver, and it is the thing that makes `--from` safe to trust.

A sizing note that briefly looked like a discrepancy: the generators report
**characters** and `ls` reports **bytes**. For `evidence.md` that is 1,787,012
against 1,790,805 — 3,793 bytes of multibyte UTF-8, not a change.

### Not done

The **orchestrator script** was deferred for three sessions and then written
at the end of this one — see the entry above it.

`cac6c77e` has not been through the publisher.


## 2026-09-20 — One product: the report becomes two pages of the guide

Short session, ended for a flight. Three commits, no build.

### The reviewer overruled yesterday's URL decision, and was right

`935153b0` had reasoned carefully to the wrong answer: THO's page URL returns
200 directly while the canonical 302s to a version-pinned page, so the page URL
avoided a redirect hop. The reviewer's answer — the HL7 proxy redirects the
canonical to the rendered page, so the hop is free — makes the hop a
non-argument, and what is left is that the canonical is the identifier we
actually mean. Worth recording because the earlier reasoning was sound and
still reached the wrong place: it optimised the mechanism and never asked what
the link was *for*.

The rewrite proves each target against the THO snapshot before writing it,
rather than pattern-matching `CodeSystem-X.html` into a canonical. That is not
defensive dressing: the pattern would happily mint a plausible URL for a code
system THO does not publish, and nothing downstream would catch it.

### Asking a question turned up work nobody had counted

The reviewer asked what else was left. Answering it honestly meant checking the
tracker rather than quoting it — and the session-2 status column had never been
updated, so fourteen rows read `todo` for work that shipped in `6a896e44`.
Reconciling it surfaced **three items that were in no session's plan**: S2-15,
S2-16 and S2-20. S2-16, property-instance suppression, is real work.

The general lesson is the boring one: a status column that is written once and
never reconciled is worse than no status column, because it reads as current.

### The fold, and the choice not to keep three pages

Offered three shapes for `general-questions.md`; the reviewer took the most
invasive one — absorb it. That is the right call for "one product" and it is
also the one that risks mangling 371 lines of their own prose, so the lift was
done **programmatically**, splitting the file on its own headings and writing
the parts out as literals. Git reports the result as a rename of the page into
the module, which is the evidence that nothing was retyped.

One structural thing worth keeping: **the split between the two pages is by the
ACTION class the report already assigns.** The alternative — deciding
page-by-page what counts as an ask — would have been a second classification
that could drift from the first. As built, re-classing a group moves it, and an
action class with no page assignment stops the run rather than dropping the
group quietly. That last case is the one that would never have been noticed.

Rows became blocks rather than table rows, because the findings carry
paragraphs and nested evidence tables that a Markdown table cannot hold. The
standalone report gets away with a grid because it is a catalog; an agenda of
sixty items is a list.

### Two things that cost time and should not cost it again

**`grep -c $'\x00'` reports every line as a hit.** Bash cannot put a NUL in a
string, so the pattern is empty. It looked exactly like having reintroduced the
NUL-byte bug from session 1 — 653 and 11,490 of them. There were zero. Check
binary content in Python.

**`git add` of a path list is not the same as staging a directory.** Kept to
explicit paths throughout, per the standing note, and the three
structural-workstream files stayed untracked.

### Left dark

A build was started and killed a minute in at the reviewer's request, and the
publisher wipes `output/` on startup. The IG does not exist on disk right now.
Everything this session did to the page set — a deleted page, two new ones, a
changed navbar and a changed page registration — is therefore unverified, and
the first job next session is to build and check the four things the ACTIVE
section lists.
