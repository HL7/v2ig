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

## ACTIVE — 2026-11-10 (session 10: the needs-decision list all but emptied, and a publisher that cannot finish)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### First thing next session

**Get the publisher to finish.** It has not produced a `qa.html` since
2026-09-23, and two full runs on 2026-11-05 failed for different reasons.

1. **Raise `-Xmx` past `8g`** in `tooling/scripts/build_vocab_ig.py` (the box
   has 15 GB). Run 2 died with `OutOfMemoryError` in
   `ValidationPresenter.genQAHtml` — building the QA page itself, *after*
   everything else had finished, 112 minutes in.
2. **Start it early.** The link check alone took 96 minutes. Do not begin it
   at the end of a session, which is the mistake made twice now.

`-Xss16m` is already in and fixed the *first* failure; do not remove it.
Section **A1** of `v291-extracted/readiness-action-items.md` has the full
diagnosis of both crashes, and is the one document to read before starting.

### Where the corpus is

| | |
|---|---|
| Tables | 798 |
| CodeSystems | **397** |
| ValueSets | **424** |
| Needs-decision | **2** — `0956`, `0963` |
| Register | **57 items, 22 answered** |
| Tests | **598 pass**, 1 skips without a build |

The needs-decision list was 14 at the start of this session. It is the
lowest it has ever been, and **both survivors are waiting on other people**
— 0956 for somewhere durable to put its codes once PHIN VADS is gone, 0963
for HTA approval. Neither is ours to fix.

### What is waiting on other people

**Four THO external code system records**, requested and not yet created.
`0458` → `CodeSystem/oce-edit-codes`, `0459` →
`oce-reimbursement-action-codes`, `0460` → `oce-denial-or-rejection-flag`,
`0467` → the URL Chapter 2C prints. All four value sets publish *now*, over
canonicals that do not resolve yet. Each is waived by table in
`EXPECTED_UNRESOLVED_SYSTEMS` in `test_write_utg_xml.py`, and **a second
test fails if a waived table ever becomes resolvable** — so the waiver list
shrinks as records land rather than quietly outliving them. Deleting an
entry when its record appears is the whole maintenance task.

**The Financial Management WG** is being consulted about `0466`, `0468`,
`0469` and `0470` (`esc-gp2-oce-siblings`). They steward both the vocabulary
and the GP1/GP2 segments that use it. **Nothing changes for those four
meanwhile** — they keep publishing a CodeSystem and ValueSet exactly as
before, so no artifact is at risk while the question is open.

### Things that will bite

- **The corpus depends on what is cached on the build machine.** Table 0962
  went from `needs-decision` to published between two builds on the same day
  with nothing in the repo changing. `load_oid_index` reads the FHIR R5 core
  package from `~/.fhir/packages` as well as the pinned `tho-r5/`; the
  publisher downloaded it mid-session, and the OID then resolved — through
  an identifier FHIR marks `use: "old"`. **A fresh checkout produces a
  different IG.** The output was correct both times, which is what makes it
  dangerous: there was no error to notice. `esc-0962-already-in-tho`; **A3**
  in the readiness list. Pin and vendor that package.
- **The publisher's own comparison pages are malformed**, and that is a
  permanent hazard rather than a one-off. Each THO release adds a
  `comparison-vN/index.html` with thousands of unclosed `<a>` tags — 3,491
  in the 7.5.0 page — nesting its parser 4,300 levels deep where every other
  output file is under 20. If `-Xss16m` ever stops being enough, **the fix
  is not a bigger number**: check whether those pages are still malformed
  and report it upstream.
- **A reported "8% broken links" is mostly an artifact of the crash.** Of
  12,284 missing local targets, 4,936 are links to the `qa.html` the crash
  prevented writing and 7,323 are `fhir.css` inside the publisher's own
  comparison directories. **None originate in this guide's pages.** Do not
  panic at that number before reading A1.
- **Authored prose drifted four sessions running, and now two pages are
  tested.** `index.md`'s route table and `known-issues.md`'s blocked list
  both have tests, verified to fail on drift in both directions — they
  caught the 0962 change nobody made. **Other authored pages are still
  unguarded**, including the "zero broken links across 625,068 checked"
  claim in two briefings, which has a test that only runs once a `qa.html`
  exists.
- **`git add -A tooling/scripts/` sweeps in three structural-workstream
  files.** Stage vocabulary files explicitly. This bit again this session.
- Everything in the previous ACTIVE still applies: the enforced build order,
  `kill` on the shell wrapper not stopping the JVM, authored anchors over
  generated heading slugs, never interpolating a count into a heading, every
  page starting at `###`.

### How to record a ruling

**Six** mechanisms now. All keyed by table number, all enforced by tests.

| What happened | Mechanism | Invariant |
|---|---|---|
| Awaiting an answer | `TENTATIVE_OVERRIDES` (ADR-0011) | names an **open** register item |
| Told not to publish, nothing exists yet | `RULED_SUPPRESSIONS` (ADR-0013) | names an **answered** item |
| Told the classification is wrong | `RULED_RECLASSIFICATIONS` | names an **answered** item |
| Told it is superseded, **and THO already publishes it** | `RULED_SUPERSESSIONS` (ADR-0014) | replacement URL **version-less** |
| Told to publish at a different canonical | `RULED_CANONICALS` (ADR-0015) | only where **THO publishes nothing** |
| Not a table at all | `EXCLUDED_SECTIONS` | — |

Suppression versus supersession still turns on whether THO has published.
`RULED_CANONICALS` partitions against supersession the same way: moving a
canonical THO already publishes is not a naming decision, it is a
supersession. A `description` field on `Reclassification` now allows a ruled
replacement for the chapter's value set description — used only by the four
I/OCE tables, and a stated deviation from fidelity.

**A ruling still rarely covers a whole item — split rather than close.**
`esc-0460-user-defined-mint` was split this session: the ruling answered
0460, and the principle it asks about still bites on 0093.

### THO version

**Staying on 7.3.0** (snapshot dated 2026-07-27). **7.5.0 is released** and
the pinned snapshot is now two behind, so every version increment in the
corpus is computed against a stale baseline. Deliberately deferred: bumping
in the same pass as a ruling batch makes it impossible to tell which caused
what. **B4** in the readiness list; do it as its own piece of work with its
own rebuild and diff.

### Build

```
python3 tooling/scripts/build_vocab_ig.py            # preprocessing, ~11 s
python3 tooling/scripts/build_vocab_ig.py --publish  # + publisher, ~2 h
```

Seven preprocessing steps, then the publisher. Four `unresolved code system`
warnings are expected — the OCE four. Check liveness with
`ps -eo pid,etime,comm | awk '$3=="java"'` rather than assuming it hung.

### Not ours — leave alone

Six untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`render_three_way_html.py`, `render_metrics_summary.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`render_metrics_summary.py` is still
undecided, seven sessions on** — adopt it or delete it.

## Session History

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
