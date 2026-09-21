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

## ACTIVE — 2026-09-20 (session 4: built, verified, and briefed for Rockville)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### Read this before anything else

**Session 5 (2026-09-21) was worked from the HL7 Plenary in Rockville**, around
the Terminology Infrastructure WG meeting. Three commits landed after the last
verified build, and a build covering them was started at the end of the
session.

**Check the build first:**

```
tail -20 /tmp/vocab-build.log
ps -eo pid,etime,comm | awk '$3=="java"'
```

Expect `Broken Links: 0` and errors at or very near **3288** (the figure from
the 2026-09-20 build, which was clean at 20.2 min). The changes below are
presentation and five display strings, so a materially different error count is
worth investigating rather than accepting. If the log stops with no java
running, the run was killed; re-run `build_vocab_ig.py --publish`, nothing is
damaged.

**`vocab-ig/output-snapshot/` is managed automatically** and holds the last
build that finished, so the IG is readable even mid-build. `--no-snapshot`
turns it off. It is a copy; the live build is `vocab-ig/output/`.

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

### First thing next session

**The user is at the HL7 Plenary in Rockville and meets the Terminology
Infrastructure WG on the morning of Monday 2026-09-21.** The briefing for that
meeting is written and committed. The first move next session is almost
certainly **whatever the room said** — capture it while it is fresh, because
several of the guide's open questions are addressed to exactly those people.

If the meeting has not happened yet, the useful work is **build `cac6c77e`** and
confirm broken links stay at 0.

### What landed this session

- **Built the vocabulary IG and verified all four checks** the previous handoff
  set. Every prediction held:
  1. **Broken links 0**, across 625,068 links. `general-questions.html` is gone
     and both retargeted cross-links resolve — the ledger's table-OID paragraph
     reaches question **6**, the merge page's reordering paragraph reaches
     question **1**, which is what was specified.
  2. **`evidence.md` did not choke.** 1.79 MB in, 1.81 MB HTML, 91 sections, no
     publisher complaint. Whether it is *pleasant* to read is still open.
  3. **Section numbering intact** — both new pages are h3/h4 under the
     template's single h2.
  4. **Errors fell 3479 → 3288**, a drop of exactly **191**, matching the
     narrative-link count. The fix reaches the published resource.
- **`cac6c77e` — S3-03 closed.** See the session entry for the reasoning; the
  short version is that both counts were right and only the shared title was
  wrong. **497 tests pass** (490 + 7 new).
- **`ec2df186` — the Terminology Infrastructure WG briefing**, authored in
  `tooling/scripts/render_ti_briefing.py`, rendered to
  `v291-extracted/ti-briefing.{html,md}`.

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
- **S3-03 is closed.**

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


## 2026-09-19 — The plane review: presentation, then the rulings

A 40-item review written while travelling, triaged into four sessions and
tracked item by item in `v291-review/review-20260918-tracker.md`. Two sessions
landed. What is worth knowing that the commits do not say:

### Three defects found by going after something else

**The ugly characters in the table index were NUL bytes.** `PAGE_STYLE` is a
non-raw Python string, so the middle-dot escape `"\00b7"` was read as octal and
two U+0000 went into the page. That also explains why `table-index.html` was
the one page the publisher gave no `--heading-prefix`: the NULs broke it. Both
fixed by one backslash.

**Section numbering was broken on every page, not the two where it was
noticed.** The template numbers with CSS counters and `h2:before` prints only
`var(--heading-prefix)` with no counter, so every `h2` on a page rendered the
same digit. `tho-merge` looked fine only because its single `h3` picked up
`counter(sub-section)`. The template already emits the page title as `h2`, so
each page's own sections were colliding with it. Every page now starts at `h3`.

**Table 0821 had no ledger section at all** — `needs-decision` with no merge
observations, so it fell to a bare list at the foot of the page, along with 24
others, and the "open register item" jump list was quietly showing 57 of 73.
Found by an agent asked to give 0821 stronger flagging, which is the sort of
thing that only surfaces when someone tries to do the small task.

### The carve-out was not where the policy was

Removing the description carve-out looked like a one-file change to
`tho_versioning_policy.py`. It was not: `tho_merge.py` enforced it and never
imported the policy module, so the obvious change would have moved zero version
numbers while looking correct. The agent that had the policy file said so and
stopped rather than reaching outside its brief.

Kept the punctuation-only *information* while removing its version consequence.
Eleven artifacts now increment for a comma; a reader who wants to know that can
see it on the ledger row.

### 0292, and an argument with an accepted ADR

The reviewer ruled 0292 should be treated tentatively as a real table. Nothing
in the pipeline could express that: the register changes no output, and
ADR-0010's evidence gate is permanent and explicitly forbids keying an override
by table number.

ADR-0011 (**Proposed**) argues the prohibition does not reach this case. What is
asserted for 0292 is not a rule but a provisional judgement about one table
awaiting a named committee's answer — the table number is the actual scope of
the claim, not an impoverished stand-in for a rule, and writing it as a general
condition would imply a generality nobody has established. The general form was
tried: it fits three tables, of which one is a placeholder section and one is
already routed correctly, which is a table number wearing a disguise.

Two things stop it rotting: every override must name a register item that
exists, enforced by a test, and the un-ruled count is computed every run.

The writer agent implemented the classification and then found the artifact
still was not written — the chapter prints no Value Set block for a table it
calls domain-only, so `process()` refused. It stopped rather than opening the
gate. Scoped the fix to the override itself: an override authorises its own
write and nothing else does. Honouring a classification while refusing to write
makes the override ceremonial.

### One ruling that covered two different cases

"Keep the THO version" for the two descriptions where THO says more read as one
decision and was two. 0227's chapter text stops mid-word and THO's continues —
the chapter is incomplete. 0719's is a complete sentence to which THO *appended*
a note recording its own error — something the register itself says Chapter 2C
should not inherit. The reviewer confirmed: 0227 only.

Written as a condition rather than a table number — a prefix that stops
mid-sentence — which reaches exactly 0227 and deliberately not 0719. Measured:
exactly two descriptions in the chapter are a prefix of THO's, and the terminal
-punctuation test separates them. Recovering the words removes the difference,
so 0227 falls back to THO's 4.0.0.

### Agents correcting the brief

Worth recording as a pattern, because it happened five times and every
correction was right. The register agent found the deprecation-flag counts were
our output and not THO's (37/246 against the snapshot, and the exclusion of
`v2-0005` is exactly what makes "none of the 36" true); that 0227 is typed
`Imported`, not `External`; and that the 0005 question was posed wrongly, since
`ValueSet/v2-0005` does not draw on the retired code system at all. The
truncation sweep came back a clean negative — no cohort of truncated CodeSystem
descriptions exists, so the reviewer's "~21" was a misremembering of the 16
ValueSet ones. **Brief an agent with the evidence and ask it to spot-check, not
to trust.**


## 2026-09-18 — The per-table ledger, and what the OID question actually was

### Completed

**The per-table ledger** — item 4 and the last of the 2026-09-17 plan.
`tooling/scripts/render_table_ledger.py` → `table-ledger.md`, 449 sections,
registered in `vocabulary.xml` and linked from `index.md`. 16 tests.

The design question was what to list and what to count. Differences from THO
(~700) are listed individually because each is a decision somebody may want to
challenge; fills (7,575) are counted, because every one of them is the
*absence* of a change and nobody will read seven thousand rows. The column that
makes the page worth having is **Also affects**: each difference says how many
other tables the same class reaches, so a reader can tell "this table has a
typo" from "this is a policy nobody has ruled on yet".

`tho-merge.html` keeps the class view and the two pages now link to each other
rather than duplicating. Its per-item lists stayed — they are the consolidated
"needs a person" view, which the ledger scatters across 449 sections — but
every table number in them now links into the ledger.

### The OID question, which was asked as one question and was three

The reviewer asked whether the conflicting OIDs were for the *tables* or for
the code systems and value sets, and suspected a nuance. There was one.

**Chapter 2C carries three OIDs per table**, in three separate metadata blocks:
a Table OID in the `.12` arc (798 of 799 tables), a Code System OID in `.18`
(435), a Value Set OID in `.21` (438). Only the last two were known about.

1. **The comparison was sound.** THO uses the same two latter arcs for the same
   two resource types, so it is like for like. Recomputed independently of the
   merge code as a check: 395 of 396 code systems and 411 of 412 value sets
   agree, and the two known conflicts are the only two.
2. **The table OID is published nowhere** — verified directly, no authored
   resource contains a `.12.` OID. Not a decision: a V2 table becomes a code
   system *and* a value set, and neither of them *is* the table, so a
   one-to-one identifier meeting a one-to-two split lands nowhere by default.
   Registered as `esc-table-oid-unpublished`, question 9 on General questions.
   The argument that it matters is THO's own: its description of table 0227
   resolves the code system by the `.12.227` table OID.
3. **Neither conflict is a transcription error**, which the register implied.
   0001's chapter block is titled *Jurisdiction Gender Code System* and its OID
   resolves to nothing in THO. 0719's two OIDs are both live **v3** value set
   OIDs for *different* value sets, and THO's `v2-0719` shares one of them with
   THO's own `v3-InformationSensitivityPolicy` — which is exactly the error THO
   documents in that artifact's own description.

The reviewer's suggestion of **carrying both OIDs as identifiers** is recorded
as a third option rather than applied. It is mechanically available
(`identifier` is `0..*`) and defensible for 0001, where the two may be one code
system under two registrations. It is misleading for 0719, where the second OID
names a different artifact THO also publishes. **The ask went out per artifact
rather than as a blanket policy.**

### Three things found while checking, worth not rediscovering

- **The page's own arithmetic was wrong** — 449 sections against 799 tables and
  368 remaining, which sums to 817. 18 of the sections are `v2-NNNN` canonicals
  THO publishes that Chapter 2C has **no section for at all**. They belong on
  the page but not in the 799. They now have their own section and the counts
  read 431 + 368 = 799, with a test that holds the arithmetic.
- **`<small>` is rejected by the IG Publisher's HTML checker** and warns on
  every use. It was already doing this on `tho-merge.html` before this session.
  Both pages now use `<span class="tl-note">` with the class in the page's own
  `<style>` — the vocabulary IG uses the stock base template, so there is no
  shared stylesheet. Warnings 137 → 135.
- **Two factual errors in hand-written text.** `general-questions.md` gave
  0719's OIDs in the `.21` arc when they are `.1.11`; the register claimed 412
  of 413 value sets agree when it is 411 of 412. Both are the hazard of
  hand-authored numbers next to computed ones — the register text now states
  its basis so the figure can be rechecked.

### State

Branch `dev/v291-vocabulary-ig`, commit `e5b31e9a`. 403 tests pass. Build is
exit 0, 17m53s, **0 broken links**, 449 sections rendered; errors 3,478 (the
settled terminology-server baseline, unchanged), warnings 135.

### Next

The 2026-09-17 plan is complete, so nothing is half-finished. Rockville is the
week of 2026-09-21 — reading the 34-item register and the 9 General questions
end to end, as a committee member would, is probably what is worth doing next.
