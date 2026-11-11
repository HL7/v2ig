# Readiness action items

**What this is.** Everything standing between the current build and two
goals: submitting this IG for review, and using it as the repository of
candidate artifacts for updating THO. Written 2026-11-05, after the November
batch of V2 Management rulings.

**What it is not.** Not the register. `vocabulary-v2mgmt-items.md` is the
authoritative list of questions awaiting committee input, and this document
does not restate its 34 open items one by one — it says which of them block
the two goals and which do not. Where the two disagree, the register wins.

---

## Where the corpus stands

| | Count |
|---|---|
| Tables in the chapter | 798 (799 sections less `9999`) |
| CodeSystems published | 397 |
| ValueSets published | 424 |
| `conceptdomains` | 1, at 4.0.0, 1,522 concepts |
| Tables with nothing written | **2** (was 14 before this batch) |
| Register items | 57, of which **23 answered** |

The needs-decision list is the lowest it has been since the project started.
Two tables remain: `0956` and `0963`.

---

## A. Blocking submission for review

These must be closed, or consciously accepted, before the IG goes out.

### A1. The publisher cannot finish, and no QA page exists

**Two full `--publish` runs on 2026-11-05 both failed, for different reasons,
and neither produced `qa.html`.** The IG itself generates correctly — 22,560
files, every page present — but the publisher dies after writing it.

**Run 1 (18.5 min): `StackOverflowError`** in `XhtmlParser`, during "Checking
Output HTML". Cause found and fixed. Because this IG's canonical is under
`terminology.hl7.org`, the publisher fetches THO's `package-list.json` and
generates a comparison page per THO release. Those pages are the publisher's
own output and **all of them are malformed**: `comparison-v7.5.0/index.html`
carries **4,306 unclosed `<a>` tags** (6,748 opening against 2,442 closed),
so its parser nests ~4,300 levels deep and overflows the default 1 MB stack,
against **≤ 19 on every other file in the output**. Fixed with `-Xss16m` in
`build_vocab_ig.py`, which cleared the crash and has held on every run since.

**It is the number of those pages that pushed it over, not 7.5.0's
arrival.** This document twice claimed 7.3.0 and 7.4.0 were "well-formed —
10,213 and 10,225 anchors, every one closed"; **that is wrong**, and the
correction is recorded in full below. The September snapshot's
`comparison-v7.3.0/index.html` has 6,733 opening anchors against 2,439
closed — 4,294 unclosed, nesting 4,294 deep — and that is the page from the
build that *succeeded*. Every comparison page carries the same defect at
about the same depth, so the variable was never which release is bad; it was
three pages where September had one.

**Run 2 (112 min): `OutOfMemoryError: Java heap space`** in
`ValidationPresenter.genQAHtml` — building the QA page itself, after
everything else had finished. `-Xmx8g` was in effect. Raising the heap was
the obvious next move and it was tried; see Run 3.

**Run 3 (110 min, 2026-11-10, `-Xmx12g`):
`NegativeArraySizeException: -1360072342`, same method, and the heap was not
the problem.** This is the run that settles what is actually wrong, and the
answer is that **no amount of memory will fix it**.

```
java.lang.NegativeArraySizeException: -1360072342
  at java.lang.String.encodeUTF8_UTF16(String.java:1288)
  at java.lang.String.getBytes(String.java:1788)
  at org.hl7.fhir.utilities.FileUtilities.stringToFile(FileUtilities.java:86)
  at ...ValidationPresenter.genQAHtml(ValidationPresenter.java:916)
```

`genQAHtml` builds the entire QA page as **one Java `String`** and then calls
`getBytes(UTF-8)` to write it. The UTF-8 encoder sizes its destination array
at up to three bytes per char, and that multiplication **overflowed a signed
32-bit int**. Read as unsigned, `-1360072342` is **2,934,894,954 bytes —
2.73 GiB**, which is 787 MB past `Integer.MAX_VALUE`. So the page the
publisher is trying to serialise is on the order of a gigabyte of text.

**Why this is a hard ceiling, not a tuning problem.** A Java array cannot be
longer than `Integer.MAX_VALUE`. The publisher would have to stream the page
or split it for this to work at all, and that is upstream code. Giving the
JVM 32 GB would produce the identical exception.

**`qa.html` exists at 0 bytes.** `stringToFile` created the file and then the
encode threw, so an empty `qa.html` is now in the output. That is worse than
none at all for anything that tests `exists()` — see the note in A5.

**What Run 3 did prove.** `-Xss16m` works: the run cleared "Checking Output
HTML", the step that killed Run 1, with the 7.5.0 comparison page present.
Validation passed (823 resources), **0 of 22,571 pages are invalid xhtml**,
the final .zip built, and the heap peaked at ~7 GB during the link check —
comfortably under 12 and, notably, *above* the old 8 GB ceiling, so Run 2's
OOM was a genuine shortage rather than a fluke. Everything except the QA
page now completes.

**The cause was found on 2026-11-10 and it is not the IG. It is the
publisher's own comparison pages, which can be switched off.**

### Why the build worked in September and not in November

The September build is still on disk at `vocab-ig/output-snapshot/`, kept by
the snapshot-after-success mechanism, and it is the control case this
diagnosis needed:

| | 21 Sep (worked) | 10 Nov (Run 3) |
|---|---|---|
| `qa.html` | **6.9 MB**, written without complaint | ~1 GB attempted, int overflow |
| Broken links | **0** | 56,515 of 677,466 |
| `comparison-*` directories | **1** (v7.3.0) | **3** (7.3.0, 7.4.0, 7.5.0) |
| Output files | 16,165 | 29,033 |

**Nothing in this repository caused the regression, and the publisher was
never upgraded** — `input-cache/publisher.jar` is core 2.1.1, built
2026-02-19, unchanged since February. What changed is that **THO released
7.4.0 and 7.5.0**, which arrived in `~/.fhir/packages` on 2026-11-05. The
publisher generates one comparison directory per THO release, so the count
went from one to three, and all three failures follow from that:

- the `StackOverflowError`, because 7.5.0's page is the malformed one and it
  did not exist in September;
- the broken-link count, because each directory contributes ~2,440
  references to a `fhir.css` the publisher never copies there (2,440 + 2,440
  + 2,443 = **7,323**, measured directly on Run 3's output);
- the int overflow, because the QA page is essentially a table of broken
  links. Zero of them gave a 6.9 MB page in September.

**A correction to a figure this document carried for one session.** It said
the three directories "were written sequentially at 17:43, 18:32 and 19:18 —
roughly 45 minutes each, which is most of Run 3's 110-minute runtime". Those
are **copy** times, not generation times, and the inference from them was
wrong. See A6: the directories are copied into `output/` from a cumulative
`temp/` on every run, so their mtimes say when the copy happened and nothing
about what generating them cost. The real generation cost is unmeasured.
What *is* measured is that suppression took the publisher's own comparison
step to one millisecond and its "Checking Output HTML" step to 3.5 seconds,
where Run 1 crashed outright.

### The switch, and why `n/a` rather than deleting something

Traced through the jar with `javap`. `PublisherIGLoader.makePreviousVersion\
Comparator` checks `comparisonVersions`: when it is **null** it inserts the
default `{last}` and the feature runs. An IG that declares no parameter
therefore gets comparison pages, which is why ours did. The parameter handler
for `version-comparison` special-cases the literal value **`n/a`**: it
creates the list and adds nothing, leaving it **empty but non-null**, and
`processVersions` iterates that list — an empty list means the loop body
never executes and `fetchVersionHistory` is never called.

So the suppression is **empty, not absent**, and the two are opposites.
Removing the parameter restores the broken behaviour; it cannot be replaced
by deleting anything. Applied to `vocab-ig/input/vocabulary.xml` with that
reasoning written beside it.

**The feature was never doing anything useful here.** It compares an IG
against *its own* previous releases, read from the package-list of its
canonical. This IG has never been published, so there is no previous version
of it to compare against; because its canonical is under
`terminology.hl7.org`, the publisher found *THO's* package-list and diffed us
against a different package. ~280 MB of output and ~2¼ hours of build time
for a comparison nobody asked for and nobody would read.

**Confirmed by Run 4's log at 38 seconds in:**

```
Previous Version Comparison        (00:00.001 / 00:37.779, 2Gb)
```

The step ran and did nothing — **one millisecond**, against roughly two and
a quarter hours and 280 MB in Run 3. That is the empty-list path executing
exactly as the bytecode said it would, and it settles the mechanism beyond
inference.

**Independently confirmed by the official parameter registry.** The
`version-comparison` entry in `CodeSystem-ig-parameters` (build.fhir.org/ig/
FHIR/fhir-tools-ig) documents the same four values and the same default:
"`{last}` — compare with the last published version — **this is the default
if the parameter doesn't appear**; `{current}`; `n/a` — don't do any
comparison; `[v]` — a previous version". Two independent sources, the jar
and the registry, agree. Sibling parameters `ipa-comparison` and
`ips-comparison` take `n/a` the same way; neither applies here.

**Remaining effect, still to be confirmed by Run 4** (started 2026-11-10, with the
parameter in place and the three stale directories deleted): no
`comparison-*` directories, ~7,323 fewer broken links, output down ~280 MB,
runtime down by most of two hours, and a `qa.html` near September's 6.9 MB
rather than a gigabyte.

**Two things this does not settle.** The `qa.html`-targeted links (4,936) are
a crash artifact and should disappear once a QA page exists, but that is a
prediction, not a measurement. And 56,515 total broken links is far more than
the 12,284 missing *local* targets decomposed below — the remainder is
presumably external, and has not been accounted for. If Run 4 still produces
a QA page too large to serialise, that unexplained remainder is where to look
next.

**Still worth reporting upstream**, because the int overflow is a real defect
whatever we do locally: `genQAHtml` builds the whole page as one Java
`String`, so any IG with enough findings hits `Integer.MAX_VALUE` and dies
after a complete build. The report is precise — method, line, the exact
negative value and what it decodes to.

**Neither defect appears to be filed.** A search of HL7/fhir-ig-publisher
issues and PRs on 2026-11-10 for `NegativeArraySizeException`, `encodeUTF8`,
`genQAHtml`, `ValidationPresenter` and `Integer.MAX_VALUE` returned nothing,
and nothing was found for the malformed comparison pages either. Note the
limit of that: chat.fhir.org is Zulip and could not be searched, so "not
found" here means not found on GitHub, not established as unreported.

**Correction, 2026-11-10: every comparison page is malformed, and this
document twice said otherwise.** The claim that 7.3.0 and 7.4.0 were
"well-formed — 10,213 and 10,225 anchors, every one closed" is **wrong**.
Re-measured on the September snapshot, `comparison-v7.3.0/index.html` has
**6,733 opening anchors against 2,439 closed — 4,294 unclosed**, a peak
nesting depth of 4,294, and it is the page from the build that *succeeded*.
The earlier figures appear to have counted anchors without separating
opening tags from closing ones; whatever produced them, they did not survive
re-measurement.

**Two conclusions change.** 7.5.0 is not special — it is one more instance
of a defect every comparison page has, and the "7.5.0's release is what
pushed it over" framing is wrong about *why*. What pushed the stack over was
**three** malformed pages where September had **one**: the depth per page is
essentially constant at ~4,300, so the trigger was count, not a newly bad
page. And the September build survived the same ~4,294-deep page, which
means the default stack was marginal all along rather than adequate until
7.5.0 arrived.

**The cause is in the core library, not the publisher,** and it is two
distinct bugs in `org.hl7.fhir.r5.comparison`, both verified by disassembly
of our own jar rather than taken from a source read of a newer master:

- `ResourceComparer$ResourceComparison.refCell` — the common path, called
  once per resource row. Its `hasWebPath()` branch concatenates
  `<td><a href="…">` + text and returns, emitting **no `</a>`**. Confirmed
  at bytecode offsets 24–60: the `makeConcatWithConstants` that builds the
  anchor cell has no closing tag in its recipe.
- `ResourceComparer$PlaceHolderComparison` — a straight typo, present
  verbatim in the constant pool as `.html">Failed<a></td>`, opening a second
  anchor where it meant to close the first. This fires only when a
  comparison fails.

`refCell` being the per-row common path is what matches the arithmetic: ~4,300
unclosed anchors against 2,439 properly-closed ones from
`CanonicalResourceComparison`, which *does* close its tags.

**Both reports are drafted** in `v291-extracted/upstream-reports/`:
`core-unclosed-anchors.md` is ready to file, and
`publisher-qa-int-overflow.md` has one blank that Run 4's outcome fills —
whether suppression alone resolved the overflow, which changes the framing
from "latent scaling defect" to "something else is large". Neither has been
filed.

**Neither is reported.** Neither appears in the issues of
`HL7/fhir-ig-publisher` or `hapifhir/org.hl7.fhir.core`, and the file's
commit history to 2020 shows no message describing either fix. A report
belongs against **`hapifhir/org.hl7.fhir.core`**, not the publisher, because
that is where the comparison renderer lives — and it should cite both
methods, since fixing only the typo would leave the systemic one.

**This does not change what we did.** The pages are suppressed, so none of
these bugs can reach our output. It changes what a report should say, and it
retires the idea that a future THO release might be "the one that breaks it
again" — they are all like this, and the only variable is how many.

**A correction that was itself wrong, kept here because the record should
show it.** This paragraph previously said that only `comparison-v7.5.0` was
malformed and that 7.3.0 and 7.4.0 were well-formed with "10,213 and 10,225
anchors, all closed". Re-measurement on 2026-11-10 shows the opposite: 7.3.0
has 4,294 unclosed anchors. The original claim it was "correcting" — that
depth was 4,300+ on all three comparison pages — **was right**, and this
paragraph wrongly overturned it. The full correction, with the two
underlying bugs in `org.hl7.fhir.r5.comparison`, is below.

**What the failed runs did tell us.** Validation ran and passed — 822
resources in 30 seconds. The link check completed and reported **56,515
broken links of 677,466 (8%)**, which sounds alarming and is not: a full scan
of the output attributes **12,284 missing local targets** to just three
causes, all artifacts of the crash or of the publisher's own pages —

| Cause | Count |
|---|---|
| Links to `qa.html`, which the crash prevented writing | 4,936 |
| `fhir.css` inside the three `comparison-*` directories, which the publisher never copies there | 7,323 |
| References inside those comparison pages to artifacts this guide suppressed or renamed — correct reporting, not defects | 25 |

**Zero broken links originate in this guide's own pages.** Fragment links on
`table-index.html` (2,075 of them) all resolve. So the content is in good
shape and the *tooling* is what is blocking a clean QA result.

**Until a run completes, the "zero broken links across 625,068 checked" claim
in both briefings is unverified** — it was read off a build in September. A
test now fails if a briefing claims zero while a `qa.html` reports otherwise,
but it skips while no `qa.html` exists, which is the current state.

### A2. Two tables publish nothing, and both wait on other people

| Table | Waiting on | Can we unblock it? |
|---|---|---|
| `0956` | A decision about where the supervisory level / pay grade codes live once PHIN VADS is decommissioned | No. Both candidate value sets are dead ends — a withdrawn FHIR 3.3 ballot draft and a PHIN VADS entry. |
| `0963` | A system URL of "Not yet approved by HTA" | No — HTA approval is a precondition. |

`0458`, `0459` and `0467` left this list on 2026-11-06 when their CMS I/OCE
external code system records were requested; they now publish value sets over
those canonicals. See **A4**.

**The decision to make before submission** is not how to fix these two. It is
whether an IG with two tables publishing nothing is submittable. It probably
is, provided each absence is explained on the page a reader lands on, which
`known-issues.html` now does. **Confirm that is acceptable rather than
assuming it.**

### A3. ~~The generated corpus depends on what is cached on the build machine~~ — DONE 2026-11-10

**This replaces an earlier entry about `vs-v2-0962.xml` being an orphan. The
orphan is gone, and how it went is the finding.**

Table 0962 spent this session on the needs-decision list because its code
system OID `2.16.840.1.113883.4.642.1.200` resolved to nothing. Between two
builds on the same day it began routing normally and publishing
`ValueSet/v2-0962` — correctly, identical to THO's: same compose over
`http://hl7.org/fhir/device-status`, same value set OID, same version 3.0.0.
Nothing in this repository changed to cause it, and nobody ruled on it.

**What changed was the machine.** `load_oid_index` reads the FHIR R5 core
package from `~/.fhir/packages` in addition to the pinned `tho-r5/` snapshot.
That package was absent, so the OID was unresolvable. The IG Publisher
downloaded it during the first build of the day, and the next run of the
writer resolved the OID through `CodeSystem-device-status.json` — on an
identifier FHIR itself marks `use: "old"`.

**Why this matters more than the table does.** Every other input to the
writer is pinned and recorded: the THO snapshot is vendored with its version
in `tho-fill-report.json`, the UTG checkout is a path. This one is neither.
A fresh checkout on a clean machine produces a *different IG* — a different
table count, a different route distribution, and a `needs-decision` entry
nobody could account for. The output was correct both times, which is what
makes it dangerous: there was no error to notice.

**Done 2026-11-10, and `esc-0962-already-in-tho` is closed against it.** The
448 `CodeSystem-*.json` files of `hl7.fhir.r5.core#5.0.0` are vendored in
`fhir-r5-core/` (3.8MB, tracked) with the package manifest beside them, and
`code_system_directories` reads that copy. `~/.fhir/packages` is **no longer
read at all**: a fallback to it would restore exactly this failure the first
time the vendored copy went missing, and would do it silently, so a missing
vendored copy now resolves fewer OIDs and sends those tables to the report
— the same way a missing THO snapshot already behaves.

The package name, version and date are recorded as `fhirCore` in
`tho-fill-report.json`, which was the other half of this item: pinned *and*
recorded. Five tests hold it, including one asserting that no directory read
by the writer lives under the publisher's cache.

**Verified neutral rather than assumed:** all 821 XML files are byte-identical
across the change and the fill report is unchanged apart from the new
`fhirCore` block, so the corpus is the same one — it is now the same one on a
fresh checkout too.

**What this does not fix.** 576 OIDs resolve only through this package, and
176 of those resolve through an identifier FHIR marks `use: "old"` — 0962's
among them. That is now a pinned, documented weakness rather than a moving
one, but it is still weaker evidence than a THO match, and `fhir-r5-core/
README.md` says so.

### A4. Four value sets compose over canonicals that do not resolve yet

`0458`, `0459`, `0460` and `0467` all publish over CMS I/OCE external code
system canonicals that THO has been asked to create and has not yet created:

| Table | Canonical awaited |
|---|---|
| `0458` | `CodeSystem/oce-edit-codes` |
| `0459` | `CodeSystem/oce-reimbursement-action-codes` |
| `0460` | `CodeSystem/oce-denial-or-rejection-flag` |
| `0467` | the URL Chapter 2C already prints for `v2-0467` |

Published deliberately, on the ruling, each flagged `unresolved` with the
reason recorded on its entry and a test waiver in
`EXPECTED_UNRESOLVED_SYSTEMS`. **A second test fails if a waived table ever
becomes resolvable**, so the list has to shrink as the records land rather
than quietly outliving them.

Harmless in a review draft; it would be a defect in a publication. **Decide
whether to hold these four back if the THO records have not landed by
submission.**

### A5. Authored prose drifts every session

Four sessions running, counts on authored pages have been wrong. Two pages
are now tested — `index.md`'s route table and `known-issues.md`'s blocked
list, both verified to fail on drift in both directions. **Other authored
pages are still unguarded.** Before submission, every page carrying a number
should either derive it or have a test.

### A6. `temp/` is cumulative, so a build inherits earlier builds' pages — FIXED 2026-11-10

**Found because it made a working fix look broken.** With the comparison
pages suppressed, the publisher's own `Previous Version Comparison` step
dropped to **one millisecond** — and three `comparison-v*` directories
appeared in `output/` regardless, 18,942 files of them.

They were not generated. They were **copied**. The directories were created
at 22:37 while their contents were dated 2026-09-21, 2026-09-22 and
2026-11-10 17:31, and each was byte-identical to a copy sitting in
`vocab-ig/temp/pages/`. The publisher stages every page into `temp/pages/`
and Jekyll copies that whole directory into `output/`; **nothing ever
removes an entry the current run did not produce.** Files from 2026-09-14
were still being copied into `output/` on 2026-11-10.

**This is the same class of defect as A3** — build output determined by what
a previous run left on the machine rather than by the inputs — and it is
worse in one respect: A3 changed which artifacts were generated, where this
silently reintroduces artifacts a parameter was set specifically to prevent.
Anyone checking whether the suppression worked by looking at `output/` would
conclude it does nothing.

**Fixed.** `clear_stale_temp()` deletes `vocab-ig/temp/` immediately before
the publisher runs, on the `--publish` path only. The directory is wholly
derived, so there is nothing to preserve. Three tests cover it, including
one that asserts the clear happens *before* `run_publisher()` and was
verified to fail when that ordering is broken.

**Not yet confirmed on a clean run.** Run 4 was already in flight when this
was found, so its `output/` still contains the 18,942 inherited files.

**And they did not merely inflate a count — they are what makes the link
check take hours.** A thread dump of Run 4's JVM at 47 minutes, taken while
the log had been frozen for eight, shows the main thread **RUNNABLE** and
burning CPU one-for-one with wall clock in:

```
org.hl7.fhir.utilities.xhtml.XhtmlNode.allText(XhtmlNode.java:399)
  ... 983 frames of the same line ...
org.hl7.fhir.igtools.publisher.ConformanceStatementHandler
    .processMarkdownConformanceClauses(ConformanceStatementHandler.java:883)
```

`allText` recurses once per nesting level, and the stale comparison pages
nest ~4,300 deep because of the unclosed anchors — 4,294, 4,300 and 4,306 on
the three. The thread sat at a depth of ~1,020 frames and oscillated rather
than climbing, which is `allText` being re-entered per node across a tree
that huge. **So the ~4,300-deep pages are not just a stack-overflow risk;
they are quadratic work for every pass that walks the DOM.** That is where
Run 3's 96-minute link check went, and it is why `-Xss16m` made the build
*finish* that step rather than making it cheap.

**A claim made earlier today and committed was wrong, and this is the
correction.** `Checking Output HTML` was reported as completing in "3.5
seconds". It does not. That line is the step's **announce** line, and the
number on it is the time to *emit* it; the scan's real duration appears much
later on the `... N html files` line. Run 3 announced the step in 3.466s and
then scanned for **1h34m55s**. Run 4 announced it in 3.497s — the same
number, for the same reason — and is still scanning. The two runs are
behaving almost identically here, which is precisely what the earlier claim
denied.

**The three findings still form one chain.** The unclosed anchors
(`refCell`, upstream) make the pages pathologically deep; the depth makes
every DOM walk enormously expensive and nearly overflows the stack; the
resulting broken links make the QA page too large to serialise. What is
*measured* about the suppression is the `Previous Version Comparison` step
at one millisecond. Its effect on the scan is **not yet measured at all**,
because Run 4 inherited the deep pages from `temp/` and is paying the same
cost as Run 3.

**What the scan is spending its time on, however, now is measured.** Fifty
stack samples of Run 4's main thread during "Checking Output HTML", taken
one to two seconds apart over roughly two minutes:

| | |
|---|---|
| Samples inside `XhtmlNode.allText` recursion | **50 of 50** |
| Samples anywhere else | 0 |

The innermost frames are all string copying — `Arrays.copyOf`,
`StringUTF16.newString`, `AbstractStringBuilder.append` — which is `allText`
concatenating the text of every descendant at every level as it unwinds.
That is the quadratic behaviour, caught in the act rather than reasoned
about: each of the ~4,300 levels re-copies the accumulated string beneath
it.

**A caveat on the depth figure.** Sampled depths cluster at ~1,020 frames,
and that is **`MaxJavaStackTraceDepth`, which defaults to 1024** — a limit
of the tool, not a property of the stack. The true depth is some number
above 1,024 and these samples cannot say what. Shallower readings do appear
(26, 341, 718), which are genuine moments on smaller subtrees. So the
correct statement is that the thread is *always* in this recursion and
usually deeper than the tool can report.

**Run 4 was killed at 1h38m on 2026-11-10**, deliberately. It had been in
"Checking Output HTML" for 1h24m of solid CPU, scanning 29,024 files of
which 18,942 were comparison pages inherited from `temp/` before
`clear_stale_temp()` existed. It was measuring a configuration that no
longer exists, and every sample of it landed in `allText` recursion over
pages the current build does not produce. Its log is kept at
`/tmp/publish-run4-keep.log`; it never wrote a `qa.html`.

For the record, since it is the closest thing to a controlled comparison:
Run 3 scanned 22,571 files in 1h34m55s and finished the step. Run 4 had
29,024 and had not finished at 1h24m. Both were dominated by three deep
pages.

**The first run that demonstrates this end to end is the next one.** The
expectation is that it is dramatically faster — ~10,082 files instead of
29,024, none of them deep — but that is a prediction and the evidence for
it is indirect: **no run has yet scanned an output without these pages in
it.** Read the `... N html files` line for the real duration, not the
announce line.

---

## B. Blocking use as a THO candidate repository

The second goal is different from the first: not "is this readable" but "can
somebody take these artifacts and update THO with them".

### B1. What would actually be submitted

| Kind | Count | Notes |
|---|---|---|
| CodeSystems THO does not have | **0** | `0460` was the last one, withdrawn 2026-11-06 |
| ValueSets THO does not have | 8 | `0458`, `0459`, `0460`, `0467`, `0820`, `0823`, `0955`, `0958` |
| CodeSystems with a version increment | 58 | Changed against THO on an element the TSMG policy counts |
| ValueSets with a version increment | 21 | Same |
| `conceptdomains` | 1 | 4.0.0: THO's 3.0.0 plus 177 concepts, none removed |

**Roughly 87 artifacts carry a change.** That is the submission.

### B2. The minted canonicals are gone, and the question behind them is not

**This guide now mints no CodeSystem canonical anywhere in the corpus.** 0411
was ruled concept-domain-only in October; 0460, the last one, was withdrawn
on 2026-11-06 when its codes were identified as CMS I/OCE content
(`esc-0460-oce-realignment`). Nothing in the submission asks THO to adopt a
name this project invented, which removes what was the sharpest objection to
submitting.

**The principle is still unsettled**, and `esc-0460-user-defined-mint` has
been narrowed to it. Both minted canonicals went away for reasons specific to
their own tables rather than because anybody decided what a `Type: User`
table should produce. `0093` *Release Information* is where it still bites: a
user table, declared concept-domain-only, listing `Y` and `N` in a grid that
reaches no artifact.

Not submission-blocking any more — it changes no published artifact — but it
should be answered before the next user-defined table arrives and gets
handled case by case.

### B3. One OID conflict is unresolved and two are closed

`esc-oid-conflicts` still needs rulings for `0001` and for 0719's live
siblings. The 0719 conflict itself is moot — the identifier sits on a
published, retired artifact and cannot be changed. The 0929/0930 collision is
THO's own and dissolves when the Jira ticket retiring 0567/0568 lands.

**An OID conflict in a submission is worse than one in a draft**, because
THO adopting the artifact makes the conflict permanent. Close `0001` first.

### B4. The THO snapshot is two releases behind

Pinned at 7.3.0 (2026-07-27); 7.5.0 is out. Every version number in the
corpus is computed against 7.3.0, so **every increment in B1 is relative to a
baseline that is no longer current**. Artifacts named in the November rulings
were all verified present and active in 7.3.0, so nothing in this batch is
wrong — but a submission should be computed against the release it is
submitted into.

**Recommended sequence:** bump to 7.5.0 as its own piece of work, rebuild,
and read the diff. Doing it in the same pass as a ruling batch makes it
impossible to tell which caused what, which is why it was deliberately
deferred this session.

**Scoped read-only on 2026-11-10, against `hl7.terminology.r5#7.5.0` in the
package cache. The delta is far smaller than "two releases behind" suggests,
and this is the number that should set expectations for the bump:**

| Between 7.3.0 and 7.5.0 | |
|---|---|
| `CodeSystem/v2-*` added / removed / re-versioned | **0 / 0 / 0** (418 both) |
| `ValueSet/v2-*` added / removed / re-versioned | **0 / 0 / 0** (440 both) |
| v2 artifacts whose content changed at all | **0** (hashed ignoring narrative and `meta`) |
| NamingSystems added | 30, carrying **19 newly resolvable OIDs** |
| OIDs whose target *changed* | **0** |

**So the v2 corpus THO publishes did not move at all between these two
releases.** Every version this guide computes against 7.3.0 would compute
identically against 7.5.0, which means B4 is a provenance correction rather
than a content risk — worth doing, but it is not holding numbers hostage the
way this item previously implied.

Of the 19 newly resolvable OIDs, 17 are `terminology.hl7.org.au` and the
other two are IHE formatcode and an eatrightpro nutrition terminology; none
is referenced by this chapter. **Neither remaining needs-decision table can
be unblocked by the bump** — `0956` and `0963` are both blocked on Content
Logical Definition *shape*, not on OID resolution, so no amount of new
NamingSystems reaches them.

**What still has to be done by hand, and why the bump is not a one-liner:**
the vendored `tho-r5/` is gitignored, so bumping it changes an input that
leaves no trace in a diff — the same class of problem as A3, which is why the
version must be re-read into `tho-fill-report.json` and the rebuild diffed
rather than trusted. Expect the diff to be empty; **investigate it if it is
not**, because on this evidence it should be.

### B5. Chapter 2C's own defects are reproduced on purpose, and THO may not want them

**Corrected 2026-11-10: the blanket policy question was answered a month ago,
and this entry had not caught up.** It described `esc-retain-known-errors` as
"open and blocking by its own description" and called it the longest pole for
the THO goal. It is neither.

**V2 Management ruled on 2026-10-08:** there is *no* one-size-fits-all answer
to reproduce-or-correct. It has to be decided per class of defect and
sometimes case by case, with individual issues reviewed for decision. The
ruling is recorded in `render_defect_review.py` as `SUPERSEDED` and printed at
the head of the review list, deliberately, so a reader who remembers the
policy ask can find out what happened to it.

**That answer dissolved the blocker rather than removing the work.** There is
no rule to obtain and then apply, so nothing is waiting on a committee
decision before other work can start. What the project owes instead is a list
that can be walked, and it exists: `v291-extracted/defect-review.md`, **33
open findings in seven classes**, each stating what the chapter publishes,
what THO publishes where it differs, what this guide publishes today read
from the build report, and the single decision needed.

| Class | Findings |
|---|---|
| Content lost in publication | 2 |
| Presentation and wording | 6 |
| Wrong or missing identifiers | 6 |
| The chapter contradicting itself | 6 |
| Open representation questions | 4 |
| Published content that is wrong | 3 |
| Where this guide and THO disagree | 6 |

**What is actually left of B5** is the three findings under *Published
content that is wrong* — `0931`'s invalid UCUM code and `0560`'s time units
under *Quantity Units* among them — because those change what the standard
*means*, and HL7's errata guidance requires a substantive change to normative
content to be balloted. The rest of the list does not need a ballot and does
not need this question settled first.

**The real conflict with the THO goal is narrower than stated**, and still
real: THO has already corrected `0931` where this guide reproduces it, so the
two bodies have answered the same question differently at least once. That
needs settling before submission — but it is three findings with a route,
not an unanswered policy question blocking everything behind it.

---

## C. Not blocking either goal

Recorded so they are not rediscovered as surprises.

- **32 of the 35 open register items** are chapter defects, presentation
  questions and policy questions that do not stop an artifact being written.
  They belong in the review, not before it.
- **`render_metrics_summary.py` is still untracked and undecided**, six
  sessions on. Either adopt it or delete it.
- **Session 4 work is untouched:** promote `render_field_mapping.py` into the
  IG; decide what maps to properties / extensions / nothing; steward Ch2c
  against THO's `structuredefinition-wg`. S3-04 is partial; S2-15, S2-16
  (property-instance suppression) and S2-20 are open.
- **The ledger makes adjacent rulings easy to misattribute.** Recorded in
  `vocabulary-future-corrections.md` after it caused a real misattribution
  this session. A presentation fix, but it affects the document committees
  read when deciding what to rule on.

---

## Suggested order

1. Get the publisher to finish (**A1**) — raise `-Xmx` past 8g and start
   the run early; it takes ~2 hours. Nothing else is fully trustworthy
   until a `qa.html` exists.
2. Pin the FHIR core package (**A3**) — ours to fix, and until it is done
   no build is reproducible on a different machine.
3. Walk the defect review list (**B5**) — `defect-review.md`, 33 findings
   in seven classes. The blanket policy question this used to name was
   answered on 2026-10-08 and is not a blocker; the three findings under
   *Published content that is wrong* are what still bear on the THO goal.
4. Bump THO to 7.5.0 and rebuild (**B4**) — one focused change, one diff.
5. Close `esc-oid-conflicts` for `0001` (**B3**) — now the only
   submission-blocking identifier question left.
6. Decide the two blocked tables are acceptable as-is (**A2**), and chase
   the four THO external code system records (**A4**).
