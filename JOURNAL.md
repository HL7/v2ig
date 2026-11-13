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

## ACTIVE — 2026-11-12 (session 12: the container was too small to build, and now the build says so)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

**Everything through `e02d4091` is pushed.** The GitHub token works again
(`api.github.com/user` returned 200 on 2026-11-12), so session 11's
expired-token blocker is gone. **Not pushed:** `9aff1242` (the memory check
below) and the handoff commit after it. Ask the user, then push.

### First thing next session

**Confirm the container has the memory, then start a clean `--publish` run.**
The user is resizing the container between sessions because run 5 could not
run at all:

- **Run 5 (2026-11-12) was SIGKILLed by the OOM killer 1.2 minutes in,** while
  installing `hl7.fhir.r5.core#5.0.0`, long before the scan. The container had
  1,939 MB and no swap; the publisher runs with `-Xmx12g`. Evidence:
  `oom_kill 1` in `/sys/fs/cgroup/memory.events`. **The fix is still
  untested** — no run has reached "Checking Output HTML" since the
  suppression went in.
- **`build_vocab_ig.py --publish` now refuses to start below 12GB available**
  (`9aff1242`): exit 3, in under a second, before the chain. It reads the
  smaller of `MemAvailable` and the cgroup's remaining limit.
  `--skip-memory-check` overrides it — the heap peaked at ~7GB, so a machine
  between 7 and 12GB might finish. If the check still refuses after the
  resize, the resize did not take; check `free -m` and
  `/sys/fs/cgroup/memory.max`.

**The ground is still prepared.** `vocab-ig/temp/` and `vocab-ig/output/` do
not exist; `vocab-ig/output-snapshot/` is September's successful build, 6.9 MB
`qa.html`, the control case. Run 4's log (`/tmp/publish-run4-keep.log`) is
**gone** — `/tmp` did not survive the container being recreated.

```
python3 tooling/scripts/build_vocab_ig.py --publish > /tmp/publish-run6.log 2>&1
```

It should be *dramatically* faster than runs 1–4 — roughly 10,082 files to
scan instead of 29,024. If it still takes over an hour in "Checking Output
HTML", something is wrong that session 11 did not find.

**Two numbers to read off it, and one trap:**

- **The scan's real duration is on the `... N html files` line, NOT on the
  `Checking Output HTML` line.** That line is an announce line showing ~3.5s
  on every run including the ones that then scanned for 95 minutes.
- **Whether `qa.html` exists and what it weighs.** September's was 6.9 MB.
  If it writes, the int overflow is resolved in practice and
  `v291-extracted/upstream-reports/publisher-qa-int-overflow.md` can have
  its one blank filled and be filed. A **zero-byte** `qa.html` means the
  overflow struck again.

### Next, after the clean run: bring the remote `vocab` build up to date

**Decided by the user 2026-11-13: do this next, after the clean run.** It is
not contingent on local builds failing. The aim is that the publisher stops
depending on this container's size: postproc-g has 1TB, and a container
recreated at 1.9GB blocked every build in session 12.

`apptainer/remote-build.sh vocab` already exists (`330d7c34`, 2026-09-16,
`-Xmx16g`) but predates the build-order work and is unsafe as is:

1. **It runs only `stage_vocab_ig.py`, not the seven-step chain.** Run the
   chain locally (`build_vocab_ig.py`, no `--publish`, ~11s, little memory)
   and send only the publisher remote. Running the chain remotely fails:
   step 2 reads `utg/`, which rsync excludes as `/utg`.
2. **It would reintroduce stale `temp/`.** rsync excludes `temp`, and
   `--delete` never removes excluded paths, so the remote
   `vocab-ig/temp/` keeps September's comparison pages and Jekyll copies
   them into output, which is the run-4 trap. Add an explicit remote
   `rm -rf vocab-ig/temp` before the publisher.
3. **It fetches to `output-vocab/`, not `vocab-ig/output/`.** The four
   build-dependent tests and `snapshot_output()` read `vocab-ig/output/`.
   Fetch there, or point them at the fetched copy.
4. **Terminology access from NIST is unestablished.** This IG cannot use
   `-tx n/a` (NPE at "Generating Narratives"); the archive says
   `tx.fhir.org` is unreachable from NIST for the v2+ builds. No record was
   found of a remote vocab build completing. If tx is blocked, populate
   `input-cache/txcache` on a networked machine and sync it up.

**The user must start it.** postproc-g uses Kerberos, so remote builds run
from the user's Mac, not this container. The memory check in
`build_vocab_ig.py` should apply only to local publisher runs.

### What session 11 found, in one paragraph

The build had not produced a `qa.html` since 2026-09-23 and three runs failed
three different ways. **None of it was ours.** The publisher was never
upgraded — `input-cache/publisher.jar` is core 2.1.1, built 2026-02-19. THO
released 7.4.0 and 7.5.0, which arrived on 2026-11-05, and because this IG's
canonical is under `terminology.hl7.org` the publisher generates one
comparison directory per THO release. September had one; November had three.
Every one of those pages is malformed — ~4,300 unclosed `<a>` tags, from two
genuine bugs in `org.hl7.fhir.r5.comparison` — which makes them quadratic
work for anything walking their DOM and nearly overflows the stack. Fixed by
suppressing them: `version-comparison` = `n/a` in `vocab-ig/input/vocabulary.xml`.

### Things that will bite

- **`version-comparison` = `n/a` suppresses by being EMPTY, not absent.**
  Delete the parameter and the publisher inserts a `{last}` default and the
  whole problem returns. The reasoning is written beside it in
  `vocabulary.xml`; do not "tidy" it away.
- **`vocab-ig/temp/` is cumulative and Jekyll copies all of it into
  `output/`.** This is now cleared automatically before each `--publish`
  (`clear_stale_temp()`, three tests). It is the reason Run 4 looked like
  the fix had failed: 18,942 files of comparison directories reappeared in
  `output/` having been *copied* from September's `temp/`, not generated.
  **If output ever contains something no step produced, suspect `temp/`
  before suspecting the fix.**
- **Directory mtimes in `output/` are copy times, not generation times.**
  A conclusion was drawn from them this session and was wrong.
- **"Publisher exited -9" is a SIGKILL, and in this container that means the
  OOM killer.** It leaves no Java stack trace and no OutOfMemoryError. Check
  `grep oom /sys/fs/cgroup/memory.events` before suspecting anything else.
  The memory check should now prevent it; it cannot catch memory taken by
  something else after the publisher starts.
- **A background `cmd > log; echo exit=$? >> log` reports exit 0 to the
  harness regardless.** Read the `exit=` line in the log, not the
  notification.
- **`jstack` truncates at `MaxJavaStackTraceDepth` = 1024.** A depth reading
  of ~1,020 means "deeper than the tool reports", not "1,020 deep".
- **`git add -A tooling/scripts/` sweeps in three structural-workstream
  files.** Stage vocabulary files explicitly. Bit again, twice.
- Everything in the previous ACTIVE still applies: the enforced build order,
  `kill` on the shell wrapper not stopping the JVM, authored anchors over
  generated heading slugs, never interpolating a count into a heading, every
  page starting at `###`.

### Where the corpus is

| | |
|---|---|
| Tables | 798 |
| CodeSystems / ValueSets | 397 / 424 |
| Needs-decision | **2** — `0956`, `0963`, both waiting on other people |
| Register | 57 items, 23 answered |
| Tests | **612 pass**, 4 skip without a build (they need `vocab-ig/output/`, deleted in session 11) |

Unchanged in sessions 11 and 12. No ruling was implemented and no artifact
moved.

### Session 11: three records were wrong

Each was believed, written down, and acted on before being caught:

1. **`readiness-action-items.md` said only `comparison-v7.5.0` was
   malformed** and that 7.3.0 and 7.4.0 were well-formed with "10,213 and
   10,225 anchors, every one closed". Every comparison page is malformed;
   7.3.0 has 4,294 unclosed. The document had it *right* in an earlier
   entry and a later "correction" overturned it with bad figures.
2. **B5 was listed as blocking and "open since August".** V2 Management
   answered it on **2026-10-08**. The replacement artifact
   (`defect-review.md`, 33 findings in seven classes) already existed. The
   document whose job is to say what blocks submission overstated its
   third-ranked item for a month.
3. **"Checking Output HTML took 3.5 seconds"** — an announce line, not a
   duration. See above.

**The pattern worth carrying forward:** all three survived because a number
was read off a document rather than re-measured, and in two of the three the
*correct* value had been recorded earlier and was overwritten. When a figure
matters, re-measure it; `vocab-ig/output-snapshot/` holds September's
successful build and is the control case that settled the first one.

### Waiting on other people — unchanged

Four THO external code system records (`0458`, `0459`, `0460`, `0467`),
waived by table in `EXPECTED_UNRESOLVED_SYSTEMS`. The Financial Management
WG on `0466`, `0468`, `0469`, `0470`. `0956` needs somewhere durable for its
codes post-PHIN VADS; `0963` needs HTA approval.

### Ready to file, not filed

`v291-extracted/upstream-reports/` — tracked via a `.gitignore` allowlist
entry, since the evidence was measured against `org.hl7.fhir.r5-6.8.1` inside
publisher 2.1.1 and will not be reproducible once either moves.

- **`core-unclosed-anchors.md`** → `hapifhir/org.hl7.fhir.core`. **Ready to
  file as is.** Cites both bugs, with a 50-of-50 stack-sample profile
  showing where the hours go.
- **`publisher-qa-int-overflow.md`** → `HL7/fhir-ig-publisher`. **Has one
  blank**, filled by the clean run's outcome. Its "Before filing" section
  says what each outcome means. Do not file it unresolved.

Neither was found in either tracker, but chat.fhir.org is Zulip and could not
be searched, so "unreported" is not established.

### THO version

**Staying on 7.3.0.** 7.5.0 is released and the pinned snapshot is two
behind. **B4** in the readiness list; still its own piece of work with its
own rebuild and diff.

### Build

```
python3 tooling/scripts/build_vocab_ig.py            # preprocessing, ~11 s
python3 tooling/scripts/build_vocab_ig.py --publish  # + publisher
```

Seven preprocessing steps, then `clear_stale_temp()`, then the publisher.
Four `unresolved code system` warnings are expected — the OCE four. Check
liveness with `ps -eo pid,etime,comm | awk '$3=="java"'`, and if the log
looks frozen check CPU time is climbing before assuming a hang — the scan
emits progress dots without newlines and can be silent for an hour while
working.

### Not ours — leave alone

Six untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`render_three_way_html.py`, `render_metrics_summary.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`render_metrics_summary.py` is still
undecided, eight sessions on** — adopt it or delete it.

## Session History

## 2026-11-12 — Session 12: the container was too small to build, and now the build says so

Short session. Pushed session 11's two stranded commits (`954eb934`,
`e02d4091`): the token that had returned 401 returned 200 again, so nothing
was needed but the push. The handoff's "`470b7b38` is unpushed" named a hash
that does not exist; the handoff was actually `954eb934`, with `e02d4091`
committed after it.

Started run 5, the clean `--publish` session 11 prepared for. It died
1.2 minutes in, `Publisher exited -9`, during package install — nowhere near
the scan it was meant to measure. Cause: the container had been recreated
with 1,939 MB RAM and no swap, against `-Xmx12g`; `memory.events` showed
`oom_kill 1`. Earlier runs had evidently had far more. Lowering `-Xmx` was
rejected — 8g already ran out in September.

**Why the check exists:** a SIGKILL gives no Java error, so the only trace
of the real cause was a counter in the cgroup. The build now compares
available memory to the heap before the chain runs (`check_publisher_memory`,
`read_available_memory_bytes`, constant `PUBLISHER_HEAP_GB` shared with
`-Xmx`), refuses with exit 3 and a message naming the cause, and takes
`--skip-memory-check` for deliberate attempts on 7–12GB machines. An
unreadable figure lets the build through rather than blocking on a guess.
9 tests; suite 612 pass, 4 skip. Commit `9aff1242`.

The user is resizing the container; the clean run is the next session's
first move.

**Remote builds discussed, and scheduled.** Running the publisher on
postproc-g would remove the local RAM requirement, and
`remote-build.sh vocab` already exists. But it is two months behind the
local build: it runs one step of seven, would inherit stale `temp/` past
rsync's excludes, fetches to the wrong place, and has never been shown to
reach a terminology server. The clean run stays local, so that it tests one
change with no new unknowns. The user decided to update the remote mode
**next, after the clean run**, not only if local builds fail. Details are in
ACTIVE.

## 2026-11-10 — Session 11: the regression was never ours, and three records were wrong

Nine commits, `b5e56206` through `8d53b78f`, all pushed along with the
76-commit backlog that had accumulated unpushed. No ruling implemented, no
artifact moved: a tooling session and a record-correction session.

### The regression

The build had not finished since 2026-09-23. **Nothing in this repository
caused it and the publisher was never upgraded** — the jar is core 2.1.1,
built 2026-02-19, unchanged since February. THO released 7.4.0 and 7.5.0,
they landed in `~/.fhir/packages` on 2026-11-05, and because this IG's
canonical is under `terminology.hl7.org` the publisher generates one
comparison directory per THO release. One became three.

September's build survived on disk in `vocab-ig/output-snapshot/`, which made
it the control case: 6.9 MB `qa.html`, zero broken links, one comparison
directory, against a gigabyte-scale page and 56,515 broken links in November.

Suppressed with `version-comparison` = `n/a`, found by disassembling the jar
and independently confirmed against the official parameter registry. The
semantics are a trap worth remembering: **an empty list suppresses, a null
list triggers a `{last}` default**, so deleting the parameter restores the
breakage.

### What the pages actually cost

Two real bugs in `org.hl7.fhir.r5.comparison`, verified in our own jar:
`refCell` emits `<td><a href="…">` with no `</a>` on the per-row common path,
and `PlaceHolderComparison` carries a literal `Failed<a></td>` typo. ~4,300
unclosed anchors per page.

The stack overflow was the loud symptom; the expensive one is that
`XhtmlNode.allText` recurses per nesting level and re-concatenates every
descendant's text as it unwinds. **Fifty stack samples during Run 4's scan
were in that recursion fifty times out of fifty**, innermost frames all
string copying. That is where Run 3's 95-minute scan went, and `-Xss16m`
never made it cheap — only survivable.

### `temp/` is cumulative

Run 4 ran with the fix and three comparison directories appeared in
`output/` anyway. They were not generated — the publisher's own comparison
step took **one millisecond** — they were *copied* from `vocab-ig/temp/pages/`,
where September's run had left them. Nothing ever removed them; files dated
2026-09-14 were still being copied into `output/` on 2026-11-10.

Same class of defect as the `~/.fhir/packages` finding (A3), and worse in one
way: it silently reintroduces artifacts a parameter was set specifically to
prevent, so checking `output/` to see whether the fix worked gives the wrong
answer. Fixed with `clear_stale_temp()` and three tests, one of which asserts
the clear happens *before* the publisher runs and was verified to fail when
that ordering is broken.

### Three wrong records, and the pattern behind them

**Every comparison page is malformed**, not just 7.5.0's. The readiness
document said 7.3.0 and 7.4.0 were well-formed with precise-sounding counts;
7.3.0 has 4,294 unclosed anchors and is from the build that *succeeded*. The
document had been right earlier and a later "correction" overturned it.

**B5 was answered on 2026-10-08** and the readiness list still called it
blocking and "open since August" — for a month, in the document whose only
job is to say what blocks submission. V2 Management ruled there is no
one-size-fits-all reproduce-or-correct rule; `defect-review.md` already
existed as the replacement. What survives is three findings needing a ballot.

**"Checking Output HTML took 3.5 seconds"** was an announce line, not a
duration. Run 3 announced it in 3.466s and then scanned for 1h34m55s. It was
reported as the headline evidence the fix worked, and retracted.

All three survived because a number was read off a document instead of
re-measured, and in two the correct value had been recorded earlier and was
overwritten. Also corrected: `output/` directory mtimes are copy times, not
generation times, and `jstack` truncates at 1,024 frames so a "~1,020 deep"
reading means "deeper than the tool reports".

### Left open deliberately

Run 4 was still scanning at 1h31m when the session ended, measuring a
configuration already superseded — it inherited the deep pages from `temp/`
before the fix existed. Killing and restarting clean was recommended and not
actioned without a decision. **The clean run is the next session's first
move**, and it is the only thing standing between here and two filed bug
reports.


## 2026-11-05/10 — Session 10: eleven rulings, four OCE realignments, and a publisher that will not finish

Three commits: `f22cc08f`, `8e97e72f`, `767dc963`. The needs-decision list
went from **14 tables to 2**, the lowest since the project began, and both
survivors wait on people outside the project.

### What the rulings did

**Seven tables are served by a value set THO already publishes** and now
write nothing: 0399, 0821, 0822, 0824, 0827, 0828, 0953. In six of the seven
the chapter's own value set OID *is* the identifier on the THO artifact, so
identity was proved rather than asserted. Nothing is retired — nothing
existed at a v2 canonical to retire, which is the distinction the reviewer
made sharply: *"there's nothing we're using it instead of."*

**0820 moved** to `ValueSet/gender-harmony-attributes`, keeping Chapter 2C's
OID, which needed a fifth mechanism (`RULED_CANONICALS`, ADR-0015) and a
prune for the file left at the old canonical. **0823 publishes over three
code systems.** **0458, 0459, 0460 and 0467 were realigned as CMS I/OCE
content**, which withdrew `CodeSystem/v2-0460` — the last canonical this
guide minted anywhere.

### Two findings of mine that were wrong

**0823.** I had reported it blocked because "which code system the value set
draws from is not stated". A value set may draw on as many code systems as
it likes, and the chapter *does* state it — in each concept's own comment
(`SCT`, `DAR`, `NULLFL`). The information I called absent was in the grid the
writer had already read. The reviewer's correction was blunt and correct.

**0953.** The ruling as written named `v3-WorkScheduleODH`, which is table
0954's value set. The OIDs caught it before implementation. **The cause is
our own ledger**: the 0953 entry sits between the 0952/0959 supersession note
and the 0954 ruling, with `v3-WorkScheduleODH` about fifteen lines from the
0953 anchor, every entry styled identically. Recorded in
`vocabulary-future-corrections.md`, because a ruling misattributed in the
ledger is a ruling nothing downstream would catch — a ruling is authority,
not evidence.

### The finding that outlives the session

**Table 0962 unblocked itself between two builds, and nobody decided that.**
It published correctly — identical to THO's — because `load_oid_index` reads
the FHIR R5 core package from `~/.fhir/packages`, the publisher downloaded
that package mid-session, and the OID then resolved through an identifier
FHIR marks `use: "old"`.

Every other input is pinned and recorded; this one is neither. **A fresh
checkout produces a different IG** — different table count, different route
distribution, a `needs-decision` entry nobody could account for. The output
was correct both times, which is exactly what makes it dangerous: there was
no error to notice. Raised as `esc-0962-already-in-tho`, about the
dependency rather than the table.

### The publisher

Two full runs, two different failures, no `qa.html` either time.

**Run 1, 18.5 min: `StackOverflowError`.** Traced to the publisher's *own*
comparison pages — generated because this IG's canonical is under
`terminology.hl7.org`, so it finds THO's package-list. `comparison-v7.5.0/
index.html` carries **3,491 unclosed `<a>` tags** against 814 closed; its
parser nests ~4,300 deep where every other output file is under 20. **7.5.0's
release is what pushed it over** — each THO release adds a page. Fixed with
`-Xss16m`.

**Run 2, 112 min: `OutOfMemoryError`** in `genQAHtml`, building the QA page
after everything else finished. Not fixed; next step is raising `-Xmx`.

Both crashes happen *after* a complete IG is written. Validation itself ran
and passed, 822 resources in 30 seconds. The reported "56,515 broken links
(8%)" decomposes into 4,936 links to the `qa.html` the crash prevented
writing, 7,323 stylesheet references the publisher never copies into its own
comparison directories, and 25 correct references to artifacts we suppressed.
**None originate in this guide's pages.**

### Guards added, because authored prose drifted a fourth time

`known-issues.md` still claimed fourteen blocked tables including one
published a session earlier. Both it and `index.md`'s route table now have
tests covering the numbers *and* the shape, verified to fail on drift in both
directions — and they immediately earned it by catching the 0962 change
nobody made.

## 2026-10-15 — Session 9: six rulings, a fourth mechanism, and a status field nothing could write

One commit, `fb605979`, no build. Six new entries in
`docs/issue_resolutions.md` at session start; eleven more arrived while the
first six were being implemented and are **still uncommitted and unactioned**
— they are the next session's first job.

### What the rulings changed

Three tables stopped being published and three changed standing. **0954,
0957 and 0960 are suppressed** — all three were about to mint duplicates of
value sets that already exist, and 0954 and 0957 each carried the OID of the
artifact they duplicated. **0719, 0952 and 0959 are retired and point at
their replacements**, which needed a mechanism that did not exist. **0895 is
published** against the chapter, composing over the CMS coding page.
**9999 is excluded from the IG entirely**, taking the table count from 799
to 798.

### Why a fourth mechanism, and the distinction it turns on

The ruling covering 0954/0957/0960 and the one covering 0719/0952/0959 read
almost identically — *a correct value set already exists, use that* — and
they need opposite machinery.

For the first three the guide had not yet published anything, so not writing
the artifact closes the question. For the second three **THO already
publishes the value set**. Suppressing those would unpublish nothing; it
would only stop this guide saying anything about them, leaving three live
artifacts in the field with nothing pointing at their replacements. So
`RULED_SUPERSESSIONS` (ADR-0014) keeps the artifact, sets it `retired`, and
prefixes a version-less markdown pointer to its description.

**Version-less is an invariant with a test, not a style note.** The reviewer
cited `terminology.hl7.org/7.4.0/en/ValueSet-...` — the natural thing to
paste from a browser, and a link that rots at the next THO release, which is
exactly the failure the pointer exists to prevent. The test refuses a URL
with a version segment and refuses a rendered `.html` page.

### The defect found on the way, and why it was invisible

**THO has `ValueSet/v2-0719` retired, and this guide was writing it back out
as active.** The only artifact in the corpus whose status disagreed with
THO's, and the disagreement ran in the most damaging direction available:
un-retiring something a terminology authority had retired.

Two causes compounded. `status` sits in `COMPARED_VALUE_SET_FIELDS` and not
in `FILLABLE_VALUE_SET_FIELDS`, so a difference against THO was reported and
bumped the version — **the 4.0.0 increment on that artifact names `status`
among its triggers** — but never filled. And `add_common_metadata`
hard-coded `DEFAULT_STATUS`, so even a status settled in the plan could not
reach the XML. The pipeline noticed the problem every single run and had
nowhere to put the answer.

That is the part worth remembering: *the detection worked and the correction
was unreachable.* A reported difference that cannot be acted on looks
identical to one nobody has looked at.

### 0895, and being wrong in the record

I reported to the reviewer on 2026-10-14 that 0895 was blocked for a CLD
shape the guide does not build. **That was wrong.** The CLD is *all codes*,
which the guide builds routinely; the obstacle was the system URL all along.
The reviewer corrected it, and was right in more detail than I had found.

THO's `NamingSystem/presentOnAdmission` carries the CMS coding page as its
**preferred** URI and lists `CodeSystem/v2-0895` as a secondary identifier,
on the same OID Chapter 2C gives, with `CodeSystem/presentOnAdmission`
published complete with five concepts at the CMS URL — and THO's own
`ValueSet/POAIndicators` composing over it. Only `ValueSet/v2-0895` points
at the empty v2 canonical.

**Why this could not be derived:** two NamingSystems register that OID, and
`load_oid_index` loads them in sorted filename order letting the last win.
`NamingSystem-v2-0895.json` sorts after `NamingSystem-presentOnAdmission.json`
and overwrote it. The evidence was in THO and not in the field the resolver
reads — the same shape of trap as session 8's dangling-value-sets mistake,
where the distinction lived in a NamingSystem nobody was reading.

### 9999, and how a table reaches a page three ways

The ruling was "do not put 9999 in this IG at all", conditional on nothing
binding to it. Checked first: **1,187 bound fields across 731 distinct
tables** in the extracted segments and data types, no reference to 9999. The
same scan finds 7 bindings to withdrawn 0010 and 1 to 0188, so it does
detect bindings to dead tables where they exist.

Excluding it took three filters, which is the finding. It reached the
published IG through the write report, through the ledger's **own join
against the register** — its new resolution put it straight back — and
through the ledger's chapter index read from `vocabulary-index.json`.
`EXCLUDED_SECTIONS` now lives in `write_utg_xml.py` with the other modules
importing it, and a test checks no page carries an excluded section.

### Drift, again

Four authored numbers were wrong: `artifacts generated` (820 against a real
818), the kept-version count (819 → 817), and two on `index.md`. Two were
caught by the tests added in session 8. **The `index.md` ones were not** —
its route table had been authored with five routes and there are now seven,
so a new route adds a row no test knows to expect. That is the fourth
consecutive session in which authored numbers have rotted.
