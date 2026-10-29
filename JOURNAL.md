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

## ACTIVE — 2026-10-15 (session 9: six rulings acted on, a fourth mechanism, and eleven more rulings waiting)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### First thing next session

**Eleven new rulings are sitting uncommitted in `docs/issue_resolutions.md`.**
They arrived *during* session 9, after its six were already implemented, and
nothing has been done with them. `git diff docs/issue_resolutions.md` shows
them — they are the block starting `399 is fine as is`. Read that diff first.

**They are worth more than their count suggests: they clear 12 of the 14
tables on the needs-decision list.** Only `0962` and `0963` would remain.
That list has been the guide's standing backlog of mechanically-unresolvable
tables since the beginning, and this batch very nearly empties it.

The tables, and what each ruling asks for:

| Tables | What the ruling says | Shape of the work |
|---|---|---|
| 0822, 0824, 0827, 0828, 0953 | Use the named existing value set | Likely `RULED_SUPPRESSIONS` — the same "a correct one already exists" pattern as 0954/0957/0960 |
| 0399 | "fine as is" | Check what that means against a table currently writing **nothing** |
| 0821, 0823 | CLD pulls from three code systems and is correct | Needs the 3-code-system gate taught to accept the shape |
| 0458, 0459, 0467 | Use the CMS HCPCS / OCE external code systems | New external URLs; 0458/0459 want a **filter that must not expand** |
| 0956 | A 2018May FHIR link; "keep trying to figure this out" | **Explicitly unresolved.** Do not implement |

**Four things in that batch need care.** (1) `0953`'s URL is mangled in the
source — `htp://` and `Observa︀onValue` with a ligature where `ti` belongs;
the artifact it means is `ValueSet/v3-SecurityControlObservationValue`, which
THO publishes active at 3.0.0. (2) `0822`'s link is to `build.fhir.org`, a
**CI build**, not a published location — THO publishes `ValueSet/pronouns` at
2.0.0 and that is the durable canonical. (3) `0458`/`0459` both carry OID
`2.16.840.1.113883.6.301.9` and **neither resolves** in the OID index;
`0467`'s `...6.301.10` does not either, so all three need their system URL
stated rather than derived. (4) `0458` says to check with **Mary Kay
McDaniels** — that is a question to a person, not a decision already taken.

Verified this session: the five named THO value sets all exist in the 7.3.0
snapshot and are active — `pronouns` 2.0.0, `recorded-sex-or-gender-type`
2.0.0, `jurisdiction` 1.0.0, `sex-parameter-for-clinical-use` 2.0.0,
`v3-SecurityControlObservationValue` 3.0.0.

**The IG has not been rebuilt since 2026-09-23 and is now five weeks stale.**
Still deliberate — the reviewer asked to batch — but **every number read off
`vocab-ig/output/` is wrong** and link checks against it cannot be trusted.
Given this batch nearly empties the needs-decision list, it is probably the
natural point to rebuild once it is in.

### How to record a ruling

**Four** mechanisms now, and picking the wrong one is still the main way to
get this wrong. All four are keyed by table number and all four are enforced.

| What happened | Mechanism | Invariant |
|---|---|---|
| Awaiting an answer | `TENTATIVE_OVERRIDES` (ADR-0011) | names an **open** register item |
| Told not to publish, and nothing exists yet | `RULED_SUPPRESSIONS` (ADR-0013) | names an **answered** item |
| Told the classification is wrong | `RULED_RECLASSIFICATIONS` | names an **answered** item |
| Told it is superseded, **and THO already publishes it** | `RULED_SUPERSESSIONS` (ADR-0014) | answered item; replacement URL **version-less** |

**Suppression versus supersession is the distinction to get right, and both
say "do not use this".** They act on opposite situations. Suppression is
available *only before first publication*: not writing the artifact leaves
nothing behind. Once THO publishes something, withholding it unpublishes
nothing — it only removes this guide's ability to say it is superseded,
leaving a live artifact in the field with nothing pointing at its
replacement. That is why 0954/0957/0960 are suppressions and 0719/0952/0959
are not.

Every ruling still needs a five-key `resolution` on its register item
(`who`, `forum`, `date`, `ruling`, `effect`), and **a ruling still rarely
covers a whole item** — split rather than close.

### What landed in session 9

One commit, `fb605979`. The register went from **44 items, 10 answered** to
**49 items, 16 answered**.

- **Suppressed: 0954, 0957, 0960.** All three were minting duplicates of
  value sets that already exist. 0954 and 0957 each carried the OID of the
  artifact they duplicated.
- **Superseded: 0719, 0952, 0959** — new mechanism, ADR-0014. Written
  `retired` with a version-less markdown pointer to the replacing v3 value
  set.
- **0895 reclassified and published**, composing over the CMS coding page.
- **9999 excluded from the IG entirely** — 798 tables now, not 799.

### Things that will bite

- **`status` was unreachable, and that is how 0719 got un-retired.** THO has
  `ValueSet/v2-0719` **retired**; this guide was writing it back out
  **active** — the only artifact in the corpus whose status disagreed with
  THO's, in the worst available direction. Two causes compounded: `status`
  is in `COMPARED_VALUE_SET_FIELDS` and not `FILLABLE_VALUE_SET_FIELDS`, so
  a difference was *reported* and *bumped the version* but never *filled*;
  and `add_common_metadata` hard-coded `DEFAULT_STATUS`, so even a status
  settled in the plan could not reach the XML. It is now a parameter, and a
  test asserts every non-superseded artifact is still `active`. **Treat that
  test as load-bearing** — it is what stops a newly-writable field drifting.
- **Two NamingSystems can register the same OID, and filename order decides
  which wins.** This is why 0895 needed a ruling rather than being derived.
  `NamingSystem/presentOnAdmission` maps `...6.301.11` to the CMS coding page
  (preferred, with the v2 canonical as a secondary identifier);
  `NamingSystem/v2-0895` maps the same OID to the empty v2 canonical.
  `load_oid_index` loads NamingSystems in sorted filename order and lets the
  last overwrite, so `v2-0895` won. **The evidence was in THO and not in the
  field the resolver reads** — the same shape of trap as the dangling-value-
  sets mistake in session 8.
- **A new `action` must be registered in four places or the chain dies.**
  `superseded-by-ruling` broke `generate_table_index.py` with a bare
  `KeyError` because `ROUTE_NORM` is a dict lookup with no default. The four:
  `ROUTE_LABEL` and `ROUTE_NORM` in `generate_table_index.py`, plus the route
  maps in `render_table_ledger.py` and `render_defect_review.py`.
- **Excluding a table from the corpus is not one filter.** 9999 reached the
  published IG by **three** separate routes: the write report, the ledger's
  own join against the register (its *resolution* put it back), and the
  ledger's chapter index from `vocabulary-index.json`. `EXCLUDED_SECTIONS`
  lives in `write_utg_xml.py` and the other modules import it. A test now
  checks no page carries an excluded section.
- **Numbers drifted again — four this time**, all on authored prose:
  `artifacts generated` (820 → 818), the kept-version count (819 → 817), and
  two on `index.md`. Two were caught by tests; the index ones were not,
  because the route table there was authored with five routes and there are
  now seven. **The pattern repeats every session.**
- **`--table` runs leave a one-table write report on disk**, which fails
  ~14 tests that read it as the whole corpus. Harmless, and alarming if you
  do not know: re-run the full chain.
- Everything in the previous ACTIVE still applies: the enforced build order,
  `pgrep -f` matching the Bash tool's own wrapper, authored anchors over
  generated heading slugs, never interpolating a count into a heading, every
  page starting at `###`, and `grep` being unable to search for a NUL byte.

### Open, and worth knowing

- **A ruling's premise is sometimes wrong — and so is a report of mine.** I
  told the reviewer on 2026-10-14 that 0895 was blocked on an unsupported
  CLD shape. It was not: the CLD is *all codes*, which the guide builds
  routinely, and the real obstacle was the system URL. The correction is
  recorded in `esc-0895-wrong-system-url`. **The reviewer was right and I
  was wrong, on a table I had already reported on.**
- **`vs-v2-0962.xml` is still an orphan** — tracked, staged, published, for
  a table that became `needs-decision` and that nothing prunes. Pre-existing.
  It and `0963` are the only two tables the new rulings do not reach.
- **0820 remains explicitly tentative** — "NOT SURE - DO NOT IMPLEMENT".
  Nothing has been done with it and nothing should be. The guide already
  publishes `vs-v2-0820.xml` over the three LOINC codes, which happens to
  match what the tentative ruling describes. The Full Name defect the
  reviewer noted is real and already in `esc-full-name-copy-paste`.
- **0929/0930's OID collision is THO's, not ours**, and dissolves only when
  the Jira ticket retiring 0567/0568 lands. Until then the guide publishes
  `v2-0929` at 4.0.0 against a live duplicate OID. Nothing to do here.
- **The 0719 OID collision is closed as moot** — the identifier sits on a
  published, retired artifact and cannot be changed. `esc-oid-conflicts`
  still needs rulings for **0001** and **0719's live siblings**.
- **0460 is the only minted CodeSystem canonical left**, with 0093 open
  alongside it.
- **`render_metrics_summary.py` is still untracked and undecided**, five
  sessions on.
- Session 4 work is untouched: promote `render_field_mapping.py` into the
  IG; decide what maps to properties / extensions / nothing; Ch2c steward
  against THO's `structuredefinition-wg`. **S3-04 is partial**; **S2-15**,
  **S2-16** (property-instance suppression — the one with teeth), **S2-20**.

### THO version

**Staying on 7.3.0** (snapshot dated 2026-07-27). Note the reviewer is now
citing 7.4.0 URLs in rulings; the artifacts named have all been verified
present in the 7.3.0 snapshot, so no bump is needed on their account. If the
snapshot is ever bumped, `tho-fill-report.json` and
`conceptdomains-divergences.json` both record the version.

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

Current preprocessing state: **398 CodeSystems, 420 ValueSets staged**
(down from 422 — three suppressed, 0895 added). One expected warning, the
0962 orphan; the 0350/0351 "cannot expand" warning is gone. **592 tests
pass.**

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
