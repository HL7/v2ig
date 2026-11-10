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
own output and they are malformed: `comparison-v7.5.0/index.html` carries
**3,491 unclosed `<a>` tags** against 814 closed, so its parser nests ~4,300
levels deep and overflows the default 1 MB stack. Measured depth is 4,300+ on
all three comparison pages and **≤ 19 on every other file in the output**.
Fixed with `-Xss16m` in `build_vocab_ig.py`, which cleared the crash.
**7.5.0's release is what pushed it over** — each THO release adds a page.

**Run 2 (112 min): `OutOfMemoryError: Java heap space`** in
`ValidationPresenter.genQAHtml` — building the QA page itself, after
everything else had finished. Not yet fixed. `-Xmx8g` was in effect; the box
has 15 GB. **The next thing to try is raising `-Xmx`**, and the run is slow
enough (the link check alone took 96 minutes) that it should be started early
in a session rather than at the end.

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

### B5. Chapter 2C's own defects are reproduced on purpose, and THO may not want them

The guide carries the chapter as published, including content known to be
wrong — `0931`'s invalid UCUM code, `0560`'s time units under *Quantity
Units*. `esc-retain-known-errors` is the policy question and it is **open and
blocking by its own description**. THO has already answered it differently
once: its `ValueSet/v2-0931` drops the bad code.

**This is the single most consequential open question for the THO goal.**
Submitting known-wrong content to a terminology authority that has already
chosen to correct it is a conflict that needs settling before, not during,
submission.

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
3. Get a ruling on `esc-retain-known-errors` (**B5**) — it is the longest
   pole for the THO goal and has been open since August.
4. Bump THO to 7.5.0 and rebuild (**B4**) — one focused change, one diff.
5. Close `esc-oid-conflicts` for `0001` (**B3**) — now the only
   submission-blocking identifier question left.
6. Decide the two blocked tables are acceptable as-is (**A2**), and chase
   the four THO external code system records (**A4**).
