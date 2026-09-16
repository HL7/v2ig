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

## ACTIVE — 2026-09-16 (the vocabulary IG builds and is viewable; no canonical collisions; the 28 Aug meeting outcome is still unrecorded)

**Branch: `dev/v291-vocabulary-ig`, at `330d7c34`. 25 commits ahead of origin,
unpushed.** All vocabulary work is on this branch and nowhere else;
`dev/framework` carries only the structural-review workstream. **Do not commit
vocabulary work to `dev/framework`.**

**Phase:** the IG builds. 821 resources (398 CodeSystems, 422 ValueSets,
conceptdomains 4.0.0) publish in **31m19s** with **zero canonical collisions**
against `hl7.terminology.r5#7.3.0`. 243 tests pass; every document regenerates
clean.

### How to look at the IG

The build output is at **`vocab-ig/output/index.html`** — open the file
directly. `/workspace` is a virtiofs bind mount of the project directory, so
the files are already on the user's side, and the output is pre-rendered
static HTML with relative links: no XHR, no root-relative paths, no ES
modules. **A web server buys nothing here** and the container's ports are not
mapped. Keep the `output/` tree together — `qa.html`'s links are relative.

To rebuild:

```
python3 tooling/scripts/stage_vocab_ig.py
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx8g -jar input-cache/publisher.jar \
  -ig vocab-ig/ig.ini -no-sushi
```

Peak memory was 4 GB, so `-Xmx8g` is ample. **Local is fine for this IG** —
postproc-g is not needed at 31 minutes. `./apptainer/remote-build.sh vocab`
exists and is wired, but has never been run (see blockers).

### First thing to check next session

**The V2 Management meeting of 2026-08-28 happened and its outcome was never
recorded.** Asked at the start of the last two sessions; both went elsewhere.
**Ask again.** Three things were put to them:

1. **The reproduce-vs-correct ruling** (blocker 1), narrowly: *may we treat
   editing-process defects as technical corrections?* A yes releases the
   truncated descriptions, 0821's emptied grid, the page-URL defects and the
   missing spaces together.
2. **The five conflicting concept domain definitions** (blocker 2). Detail in
   `v291-fhir/conceptdomains-divergences.json`, kind
   `conflicting_descriptions_within_chapter`: DeviceStatus (0682/0962),
   DeviceType (0657/0961), Modality (0259/0604), QuantityUnits (0560/0602),
   VolumeUnits (0568/0777/0930). Four of five have a template stub as the
   second description; **the Device pair is the genuinely contested one** and
   needs OO.
3. **The information-preservation steer** — can a FHIR consumer recover what
   Chapter 2C says about a table, or only its codes? Decides whether to design
   extensions for the 24 unmapped fields or record the loss. Cheap now,
   unrecoverable after the load into THO.

Register items 18–23 postdate the meeting and have not been put to anyone.

### What the build found

216 errors, 416 warnings, 1 broken link — but they collapse to very little:

| Count | What | Verdict |
|---|---|---|
| 192 | `conceptdomains` narrative links to v3 pages not in this guide — ActClass 97, RoleClass 60, EntityClass 26, ActMood 4, ParticipationType 3, ActCode 1 | One root cause. Packaging, not content. Fix is a decision about declaring a v3 dependency |
| 5 | `[lb_av]`, `l` (UCUM), `76691-5` (LOINC) | **Not content defects** — `tx.fhir.org` `validate-code: timeout`. The text reads "not valid in the system"; the parenthetical is what matters |
| 1 | `L&I` unknown in THO's `v2-0203` v5.0.0, from ValueSet `v2-0338` | **Real.** Build evidence for the punctuation-code item already open for UTG. Also the single broken link (anchor `#v2-0203-L.38I`) |
| 1 | `EXP` unknown in THO's `v3-ActMood`, from ValueSet `v2-0725` | **Real, and may reopen a closed item** — see below |

**0725 needs a second look.** It was registered last session as *already
correct by OID resolution* (`2.16.840.1.113883.5.1001` → `v3-ActMood`),
changing no output. The build says one of its codes does not exist in the code
system it resolved to. The OID resolution may still be right and the chapter's
code list wrong — but "already correct" is no longer safe to assert.

### Next moves, in order of value

1. **Rewrite the UTG briefing.** Content unchanged since `a817a61c` on
   2026-08-21 — now nearly four weeks stale, and the **cheapest high-value task
   available**. Six things concern UTG/TSMG directly: the `notAllCodes`
   canonicals, the `CodeSystem.valueSet` omission, the punctuation codes in
   THO's own v2 code systems (**now with build evidence — `L&I`**), THO
   carrying the same truncated descriptions as the chapter, the 0567/0568
   deprecation question, and now `EXP`/`v3-ActMood`. Does not depend on the
   28 Aug outcome.
2. **Decide the conceptdomains v3 links.** 192 of 216 errors. Either declare a
   dependency on the v3 code systems or accept and document. Currently
   documented on the Known Issues page.
3. **Bring the V2 Management briefing current** — register items 18–23
   postdate it.

### Rules settled that must not be re-derived

- **A canonical URL is an identifier and nothing more.** Where THO already
  publishes one for a table, that is the URL, whatever it appears to mean. Do
  not construct an alternative; do not read meaning out of `notAllCodes`.
- **A brand-new CodeSystem or ValueSet starts at `1.0.0`.**
- **`definition` is never back-filled from `display`**, and the resulting
  `CODESYSTEM_CONCEPT_NO_DEFINITION` warning is accepted.
- **We do not tamper with existing external code system records in THO.**
- **An item is a briefing blocker only if generation cannot proceed without the
  answer AND the answer is not already determined** (D19).
- **The seven `apply-*` parameters stay false** in `vocab-ig/input/vocabulary.xml`.
  The base template defaults them to true and silently overwrites resource
  metadata. **No `special-url` parameters** — that was a wrong turn, corrected.
- **Never add `-tx n/a` to the vocabulary build.** See blockers.

### Regeneration sequence

```
python3 -m pytest tooling/scripts/
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/write_utg_xml.py
python3 tooling/scripts/stage_vocab_ig.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
python3 tooling/scripts/render_field_mapping.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

The first two are expensive and only needed if the text policy changed.
`render_field_mapping.py` and `render_vocabulary_review_html.py` must both run
after `write_utg_xml.py` — they read `utg-write-report.json` rather than
recomputing. **`stage_vocab_ig.py` must run after `write_utg_xml.py` and before
any build.** Four scripts self-check and warn rather than fail: the register's
stated-vs-computed table lists, the mapping's corpus-vs-spec completeness, the
writer's UTG file-name collisions, and the stager's index-page resource counts.
**A silent run is the expected outcome; read the output if it is not.**

### Open blockers

- **None on our side.** 243 tests pass, the IG builds, every document
  regenerates clean.
- **`./apptainer/remote-build.sh vocab` has never been executed.** It is
  written and shellcheck-clean, but **cannot be run from this container** —
  postproc-g uses Kerberos and is reachable only from the Mac. Two things about
  it are therefore unverified: whether postproc-g can fetch
  `fhir.base.template#current` (the v2+ builds use `#local-template` and have
  never pulled a template package — if the registry is blocked it fails at
  initialization, ~45s, and the fix is vendoring the template), and whether
  terminology is reachable there at all.
- Everything else outstanding is gated on committee or user decisions.
- The 14 writer blockers are recorded with evidence in the review report. The
  10 external value-set references remain open.

### Two items that are not ours and have no home yet

Found during an out-of-scope discussion; they belong to the **structural**
workstream (`dev/framework`, `v291-extracted/v2mgmt-review-report.md`) and were
deliberately not written to this branch. The reviewer was asked which document
should carry them and has not answered across three sessions:

1. CH02 systematically calls the segment **`FSH`** rather than `FHS` in the
   file-header section (the §2.13.3 field heading is literally "FSH-15").
2. The `BHS-15` and `FHS-15` conditionality predicates **invert the containment
   hierarchy** — a batch contains messages and a file contains batches, but
   `BHS-15` reaches for "any contained FSH-16/FSH-17" and `FHS-15` skips the
   BHS level entirely.

Both look like editing-process defects, so they fit the same technical-
correction test as blocker 1.

## Session History

## 2026-09-10 → 2026-09-16 — The vocabulary IG builds: 821 resources, no canonical collisions

### Completed

**The IG exists and can be looked at.** `vocab-ig/` is a build root for this
workstream, separate from the v2+ structural IG at the repository root. The two
share the repository, the Apptainer image and `input-cache/publisher.jar`, and
nothing else. First full build: **821 resources in 31m19s, exit 0**, 4,932 HTML
pages, peak 4 GB.

**Zero canonical collisions.** The build loaded `hl7.terminology.r5#7.3.0` —
THO itself — alongside 821 resources authored at THO canonicals and produced no
duplicate-canonical errors at all. That was the premise the whole smoke test was
built to probe, and it now holds at full scale rather than across seven
resources. Commit `330d7c34`. 243 tests pass.

**The handoff understated what "run a full build" required.** It read as though
the config just needed copying from `smoke-test/`. There was no IG definition
covering the corpus at all: `smoke.xml` is named `hl7.v2plus.smoke`, marked
experimental, and points `path-resource` at a directory of seven hand-copied
files. Authoring the real definition was the task.

**Resources are staged, not authored.** `tooling/scripts/stage_vocab_ig.py`
copies the writer's output out of `v291-fhir/` into leaf directories under
`vocab-ig/input/resources/`. The copy is not incidental: `path-resource` is not
recursive *and* treats every file in a named directory as a resource, so
pointing it at `v291-fhir/` would feed the publisher `utg-write-report.json` and
`conceptdomains-divergences.json`. Staging does a full replace of each
directory, so a resource deleted upstream cannot survive and quietly reappear.

**Three pages were written, not just a stub**: Home (what the guide is, the
six-route table, the conceptdomains explanation), Provenance (what is
authoritative and what is deliberately not done), and Known Issues — which
exists so a reviewer can tell a pipeline defect from a defect we already know
about, including the ones reproduced from the chapter on purpose.

### Two defects fixed that would both have failed on postproc-g

**The rsync exclude `'utg'` was unanchored.** rsync matches a slashless pattern
against the basename at *any* depth, so it caught `v291-fhir/utg` — the entire
820-resource corpus. Verified with a dry run. The build would have **succeeded**
and published an IG containing only conceptdomains, with nothing anywhere
reporting a problem. That is the worst failure shape available. Now anchored to
`/utg`, with a comment at the array saying why.

**`-tx n/a` kills this build.** It is what the v2+ builds use, because
`tx.fhir.org` is unreachable from NIST, so it was the natural thing to carry
over — and it was carried over, and it broke the first attempt. This corpus is
value sets: `ValueSetRenderer.genInclude` dereferences the terminology client
while generating narratives, and with `-tx n/a` that client is null. NPE at
"Generating Narratives", ~57 seconds in. Removed from `vocab` mode. If NIST
blocks terminology, the fallback is to populate `input-cache/txcache` on a
networked machine and let rsync carry it up.

### The findings worth carrying

**Of 216 errors, 197 are not content.** 192 are one root cause — the
`conceptdomains` narrative linking to v3 code system pages this guide does not
contain (ActClass 97, RoleClass 60, EntityClass 26, ActMood 4, ParticipationType
3, ActCode 1) — and 5 are `tx.fhir.org` `validate-code: timeout` on UCUM and
LOINC codes. **The timeout messages read "The code 'x' is not valid in the
system"** and only the parenthetical distinguishes them from real defects; do
not report them as content without reading to the end of the line.

**`L&I` is unknown in THO's `v2-0203` v5.0.0**, referenced from ValueSet
`v2-0338`. This is the punctuation-code problem already open for UTG, now with
build evidence rather than inspection. It is also the single broken link in the
guide — the anchor `#v2-0203-L.38I` has nothing to point at.

**`EXP` is unknown in THO's `v3-ActMood`**, from ValueSet `v2-0725` — and this
may reopen a closed item. 0725 was registered last session as *already correct
by OID resolution*, changing no output. The build says one of its codes does not
exist in the code system that OID resolved to. The resolution may still be right
and the chapter's code list wrong, but "already correct" can no longer be
asserted without checking.

### Corrections taken during the session

- Added `-tx n/a` to the first build attempt on the assumption it matched
  postproc-g. The proven smoke-test command has no such flag; adding it
  introduced a variable the working configuration never had, and cost a build.
- Budgeted "an hour, and treat the real figure as unknown" for the build. It
  was 31 minutes at 4 GB peak, so **postproc-g is not needed for this IG** —
  which is the opposite of the conclusion the estimate was steering toward.
- Started an HTTP server to present the output without first checking that the
  container's ports are mapped (they are not) or that `/workspace` is a bind
  mount of the project directory (it is, via virtiofs). The file path was the
  right answer from the start. Verified afterwards that the output has no XHR,
  no root-relative links and no ES modules, so `file://` loses nothing.
- Wrote a `pgrep`-based wait loop whose own command line contained the pattern
  it searched for. It matched itself, could never exit, and reported a finished
  build as "still running".

### Not done

The UTG briefing was not rewritten — it is the top of the next session's list
and now has one more piece of evidence behind it. The five structural-workstream
files remain uncommitted, untouched, and not ours.

---

## 2026-08-27 → 2026-09-10 — The canonical section was wrong; six findings registered

### Completed

**The reviewer walked the "tables needing a new canonical URL" list and
rejected almost all of it — correctly.** The section was computed by one crude
subtraction in `render_vocabulary_review_html.py`: a table that listed codes
and had no `CodeSystem-v2-<its own number>` in THO was declared to need a
canonical minted. That test only ever looks for a code system filed under the
table's *own* number, so **every table whose codes live in another authority's
code system tripped it**. It reported 18; the true figure is **2** (0411 and
0460), which matches the independent count reached on 2026-08-20.

**The writer already had this right for 16 of the 18.** The section no longer
recomputes anything — it reads `v291-fhir/utg-write-report.json`, so the report
and the generated resources cannot disagree. It now shows six routes with
counts (396 reuse their own THO canonical, 24 defer to another authority, 2
mint, 14 unsettled, 360 concept-domain-only, 19 THO code systems with no
chapter table) plus two detail tables giving, for each table, which code system
it resolved to and how.

**Six items added to the V2 Management register**, five previously unrecorded.
Register is now 24 items. Commit `6b01350c`. 243 tests pass.

### The findings worth carrying

**0567/0568 is a deprecation question, not a canonical question.** The
reviewer's framing, and it replaced mine: Chapter 2C deprecates both tables in
prose, but THO publishes `ValueSet/v2-0567` and `v2-0568` as live resources
with no deprecation marker, so **a consumer cannot tell that two of the four
are superseded**. The ask is whether a concomitant deprecation belongs in THO.
Secondary: both tables print the *replacement's* canonical as their own URI
(0567→`v2-0929`, 0568→`v2-0930`), and only the "THO's existing canonical wins"
rule stopped two pairs of resources claiming the same URL.

**0725 was already correct, by OID resolution.** The chapter omits the URI
entirely and gives only OID `2.16.840.1.113883.5.1001`, which THO resolves to
`CodeSystem/v3-ActMood` — the same URL the reviewer found independently in
THO's CLD. Registered as a technical correction that changes no output.

**0460/0411/0093 is the sharpest management item.** All three are `Type: User`
and the chapter treats them three different ways: 0411 and 0460 get minted
resources, 0093 is declared concept-domain-only and gets nothing. Nothing in
the chapter explains the difference. That contrast is the frame for the
user-defined-table question the reviewer did not know how to answer.

**0340's code grid holds code system identifiers, not concepts** — `CPTM` and
`HPC`, with citations to AMA and CMS. The table is concept-domain-only so
nothing is written, but the chapter is using the code grid for two
incompatible purposes.

**0459 is a hard stop**: code system given only as OID
`2.16.840.1.113883.6.301.9`, which nothing in THO or FHIR core resolves.

### Corrections taken during the session

- Claimed the 24 deferring tables were "each previously reported as needing a
  new canonical". Only 11 were — the old test also required enumerated codes,
  so it never saw the 13 that reference their codes intensionally. Caught and
  fixed before the final render.
- Asserted the reason for that as "THO publishes no same-numbered code system
  for them". Wrong reason for a right number.

### Out-of-scope discussion worth not losing

A long thread on V2 delimiter/escape corner cases (whether `MSH-2` may declare
`F`, `S`, `T`… as separators). Two **CH02 document defects** surfaced that are
recorded nowhere and belong to the structural workstream, not this one:

1. **The chapter calls the segment `FSH` in places** — not a typo but
   systematic: the field heading at §2.13.3 is literally "FSH-15 Security
   Classification Tag", and `BHS-15`'s conditionality predicate reads "any
   contained FSH-16 or FSH-17".
2. **Those same predicates invert the containment hierarchy.** A batch contains
   messages; a *file* contains batches. `BHS-15` referring to "any contained
   FSH/FHS" is backwards; `FHS-15` reaches for "any contained MSH-26" and skips
   the BHS level.

Also established, if it recurs: **no rule anywhere in CH02 requires the six
delimiters to be distinct from one another**, so `MSHFzzzzzF` is not
prohibited by any text — searched and confirmed.

## 2026-08-25 → 2026-08-27 — The field mapping, THO's canonicals, and the briefing brought current

### Completed

**Built the field-mapping document**, which the reviewer commissioned after
noticing that the Code System *Full Name* appears nowhere in the output. It
does not, and it is one of **24 fields out of 43 that reach no resource at
all**. Two of them carry a value on all 799 tables: the table-level
`Description` and `Type`. The largest single hole is the whole **Code System
Version block** — version, effective date, HL7 version introduced — none of
which is read. For `Effective Date` the chapter has *better* information than
what we publish, since `CodeSystem.date` comes from UTG where 414 of 416
resources carry the same bulk-load date.

The document is `v291-extracted/vocabulary-field-mapping.html` plus a Markdown
twin, authored in `field_mapping_spec.py` and joined to the corpus by
`render_field_mapping.py`. **The split is the point**: the mapping is authored
so a field can be recorded as *unmapped* — a question — rather than merely
described as unmapped, which is all a derived mapping could ever say. A
completeness check fails if extraction produces a field the spec does not
cover, so the document cannot quietly go stale.

**Writing it out found a real defect.** The writer never read `valueSets.URI`
and constructed `ValueSet.url` from the table number. That agreed with THO for
412 of 429 tables and put **0291, 0347, 0399 and 0834** at canonicals neither
THO nor UTG publishes. The user's ruling settled it: *a canonical URL is an
identifier; where one already exists it is the one to use, and any meaning it
appears to carry is coincidental.* The writer now takes THO's canonical where
there is one.

**Flagged every punctuation-only code**, 23 across 17 tables, scanning both the
chapter and THO's v2 code systems. Three groups: four genuine symbol codes
(`*`, `#`, `%`) with real definitions; eighteen ellipsis placeholders minted as
concepts; and one `??`. **Five tables carry the placeholder twice**, as `...`
and as `…`, with identical display text.

**Brought the V2 Management briefing current** for the 28 August meeting. It
still described the 21 August state.

### The findings worth carrying

**THO is not a recovery source for the truncated descriptions.** All 16 tables
have a ValueSet in THO, all 16 carry a description, and **15 are truncated at
exactly the same character** once whitespace and our own text policy are
normalised on both sides. The same clipped field fed both documents. **0227 is
the exception and the proof**: THO's continues 171 characters past the cut,
completing the very word the chapter breaks in the middle of — `may be acce`
becomes `may be accessed via` plus the PHIN VADS link.

**The punctuation codes are overwhelmingly THO's, not the chapter's.** Sixteen
of the 23 exist only in THO, and *every* duplicate `...`/`…` pair is THO-only.
The chapter has largely stopped publishing them and THO has gone on carrying
them — the exact drift this baseline exercise exists to correct.

**`CodeSystem.valueSet` means the value set containing the *entire* code
system**, so it must be absent where the value set leaves a code out. UTG omits
it on exactly two of its 416 code systems — 0291 and 0834 — and we were
emitting it on both. Now mirrored.

**Getting a canonical right has three consequences, not one.** The resource
`id` is the canonical's last segment; the output file must keep UTG's own name,
which is *not* derivable (three of the four are filed under the canonical and
0834 under its table number); and version inheritance keys off the file name,
so the parser reading `notAllCodes-0291` as a table number had been silently
defaulting those tables. 0347 was emitting 1.0.0 where UTG publishes 2.0.0.

### Why the specific shapes

**The mapping spec is authored and the counts are computed.** Either half alone
is useless: a hand-written document drifts, and a generated one cannot say that
something *should* be carried and is not.

**`usedDefaultVersion` is now reported per resource, not per table.** A table
can inherit a version for its CodeSystem and not for its ValueSet, and three
do — which is precisely how the `notAllCodes` cluster stayed hidden. The
per-table flag was reporting 16 tables including five where nothing was
written, and missing 0291 entirely. It is now 12 tables / 14 resources, and
after the canonical fix, 10 tables / 12 resources.

**Blockers stayed at two in the briefing**, per the D19 rule. Nothing found
this week meets the bar — generation proceeds without any of it. Padding the
blocker list is how a short meeting produces nothing.

**Blocker 1 now carries the errata-guidance test**, so V2 Management can give
the narrow answer (*may we treat editing-process defects as technical
corrections?*) instead of ruling on the whole reproduce-vs-correct principle in
the time available.

### Corrections taken during the session

- Framed the canonical question as "should we honour the URI the chapter
  prints". Wrong question — the chapter's copy of the identifier is wrong for
  14 tables. The user's rule needs nothing from the chapter at all.
- Stated the punctuation groups as "six genuine codes" and "eleven
  placeholders" from a source count rather than a code count. Four and
  eighteen.
- Claimed 25 unmapped fields in the document lede when the computed figure was
  24, and carried three other counts from a presence scan instead of a
  non-empty scan.
- `git add -A tooling/scripts` staged the two `dev/framework` scripts. Caught
  before committing, twice.

### Commits this session

`ea7da354` the field mapping, the truncation cross-check, 0954's
`notSelectable` note and version 1.0.0 · `e1bf2046` THO's canonicals and the
punctuation codes · `9b77181d` the briefing.

### Still uncommitted, untouched, and not mine

The same five files from the structural workstream. They belong to
`dev/framework`. Untouched across seven sessions now.

---

## 2026-08-25 — The XML writer, and the build questions answered

### Completed

**Built the XML writer**, which is what the whole workstream was for. A
serializer that reproduces UTG's house style and a generator that classifies
every table and emits only what the chapter clearly supports. 398 CodeSystems,
422 ValueSets, 63 new tests.

The classification came out right by two independent checks: the only new
CodeSystems are 0411 and 0460, matching a count reached a different way five
days earlier, and 328 of 406 ValueSets are byte-identical to UTG's own with no
tuning.

**Smoke-tested against a real IG Publisher build** and answered the question
open since D18. The canonical collision is a non-issue — with
`hl7.terminology.r5#7.3.0` loaded our resources win and render with our
content. What fired was `RESOURCE_CANONICAL_MISMATCH`, and my first fix was
`special-url`, which the user correctly rejected. **The right answer is to give
the IG THO's own canonical base**, exactly as `hl7.terminology` does; then the
resources are native to it and no special URLs are involved. Version
propagation is `apply-version`, and finding it surfaced that the base template
defaults **seven** `apply-*` parameters to true, silently overwriting
publisher, contact, copyright and work group as well.

**Took needs-decision from 21 to 14** across two rounds. The largest single
cause was tables printing a rendered page URL where a canonical belongs — and
every one of them also prints a correct OID, so one fallback resolved seven
tables. Filter-shaped logical definitions are now built rather than reported,
copying THO's pattern rather than inventing one: 1,423 of its 1,432 filtered
ValueSets use `concept is-a`, and all three subtrees Chapter 2C asks for
already exist there. 0227 resolved through `NamingSystem/MVX` once the user
confirmed THO has no CodeSystem for MVX and should not have one.

**Five new register items**, four of them found while answering the user's
questions rather than by looking for them.

### Corrections taken during the session

- Reported that a `special-url` parameter was the fix for the canonical
  mismatch. The user pushed back on using special URLs at all and was right;
  the IG's own canonical base was the real answer and is strictly better.
- My page-URL detector only matched `terminology.hl7.org`, so table 0962 was
  quietly composing over `http://hl7.org/fhir/codesystem-device-status.html`.
  Found only because the user asked whether the foreign systems had metadata
  records.
- Staged two files belonging to `dev/framework` while committing. Caught before
  the commit; they have now been left alone for six sessions.

### The findings worth remembering

**Sixteen ValueSet descriptions are truncated mid-word** between 242 and 252
characters. Found by reading one generated resource, not by a scan. It is a
length cap in the publication toolchain: Code System descriptions in the same
tables run past 500 characters and end in complete sentences, and the tables'
own metadata descriptions are complete. This is the only defect of the session
that reaches the emitted output.

**0560 and 0910 are the same case handled two opposite ways.** Identical in the
chapter — the `noObject` placeholder, no code system — and THO publishes a
complete five-concept CodeSystem plus ValueSet for one and nothing for the
other. So a code system was minted at an HL7 canonical for a table whose source
declares none, filled with content flagged as wrong elsewhere in the register.

**The errata guidance is a usable test**, and the user supplying it changed the
shape of the reproduce-vs-correct question. Its definition of a technical
correction — a change that makes the document say what the WG intended,
repairing content not made or inconsistently made during editing — separates
the editing-process defects from the substantive ones. The register now asks
the narrow question rather than the abstract one.

**A user instruction worth not losing:** do not back-fill `definition` from
`display`. The publisher warns about it corpus-wide; `definition` is optional
and the warning is accepted.

### Commits this session

`57e4ac47` the writer · `bf9f49a9` the smoke test · `50164f82` six tables
resolved, special-url and version propagation dropped · `55a4b8fa` 0227, five
register items, Batch A.

### Still uncommitted, untouched, and not mine

The same five files from the structural workstream, now dated across six
sessions. They belong to `dev/framework`.

---
