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

## ACTIVE — 2026-09-17 (the table index is built and published; the additive-stance question goes to Rockville next week)

**Branch: `dev/v291-vocabulary-ig`, at `7861ce8f`. 30 commits ahead of origin,
unpushed.** All vocabulary work is on this branch and nowhere else;
`dev/framework` carries only the structural-review workstream. **Do not commit
vocabulary work to `dev/framework`.**

**Phase:** the IG builds and now carries a table index. 290 tests pass. Last
build 14m54s, 5 GB peak, **errors 216, warnings 416, broken links 1** — all
unchanged from before this session's work except broken links, which went
1 → 39 → 1 (see below).

### First thing next session

**Nothing is blocked. Start on the agreed plan** (below). The one thing waiting
on someone else is the additive-stance ruling, and the user expects an answer
at the **HL7 work group meetings in Rockville, week of 2026-09-21**.

The V2 Management meeting of 2026-08-28 is *still* unrecorded — asked across
four sessions now, never answered. Lower priority than it was; ask once, do not
spend the session on it.

### The plan, agreed 2026-09-17

1. **Additive merge in the writer.** Where THO has a definition, display or
   concept and Chapter 2C does not, keep THO's. Emit a computable record
   (`v291-fhir/tho-fill-report.json`) of every fill, plus a human-readable page
   describing each *class* of fill with counts — **not** the individual
   instances; there are 4,855 and the user explicitly said a class-level
   description is enough.
2. **Version bumps computed from the policy element table**, re-derived on every
   run rather than hand-applied.
3. **0560 written as Chapter 2C publishes it** — see below.
4. **A per-table ledger in the IG** — one section per table (a single large page
   is fine) carrying: every change relative to THO beyond trivial whitespace,
   every outstanding issue, and an indicator when an issue is a *class* that
   affects other artifacts the same way. This rolls the change log and the issue
   ledger into the IG so everything is visible and workable in one place. It
   subsumes much of what currently lives in separate documents. **This is the
   biggest item.**
5. **Two separate ADRs** — one for the additive stance and versioning, one
   for 0560. The user chose separate over combined.

### The comparison against THO — the numbers that matter

Against the local snapshot `tho-r5/` (package `hl7.terminology.r5` **7.3.0**,
published 2026-07-27; `conceptdomains` **3.0.0**; `v2-tables` **7.0.0**):

| | Shared with THO | Byte-equivalent | Differ |
|---|---|---|---|
| CodeSystems | 396 | **13** | 383 |
| ValueSets | 413 | **388** | 25 |

**Why the asymmetry:** 408 of 422 value sets have a bare "all codes" include —
no enumerated concepts, no filters — so there is nothing to diverge on.

**The 13 byte-equivalent CodeSystems**, all at THO 3.0.0, all of which *keep*
that version: `v2-0103` `v2-0369` `v2-0370` `v2-0513` `v2-0516` `v2-0945`
`v2-0946` `v2-0948` `v2-0949` `v2-0950` `v2-0951` `v2-0970` `v2-0971`.

How the 383 differ (a code system can differ in more than one way):

| Differs by | Count |
|---|---|
| **Concept definitions dropped** — THO has one, we publish none | **382** |
| Concept set differs (mostly ours smaller) | 38 |
| Concept display differs | 15 |
| Resource description differs | 6 |
| Definition present in both but conflicting | 5 |

The 25 value sets: 14 `compose`, 10 `description`, 3 `name`, 3 `title`,
1 `status`.

**The dominant problem is not missing codes — it is 4,855 concept definitions
that exist in THO and are absent from our output.** That follows from the rule
that `definition` is never back-filled from `display`, which is right about
*inventing* definitions but strips text THO already wrote. Publishing that at
THO's canonical is the same destructive-redefinition hazard `conceptdomains` was
made a superset to avoid, at roughly forty times the scale. **This is what the
additive stance fixes, and it is why items 1 and 2 of the plan are coupled:**
most of the 383 version bumps disappear if we stop dropping.

### THO artifact versioning policy — settled

Source: `CS_versioning_policy.pdf` and `VS_versioning_policy.pdf` in the
workspace root (**untracked — ask before committing, they are HL7 Confluence
exports**). Read them with `pypdf`, now in `provision.sh`.

- **Version format is `n.0.0`. Minor and patch are always zero. There is no
  lesser increment — every qualifying change is a major bump.**
- **New artifacts start at `1.0.0`.** Our 12 new ones are correct.
- **Byte-equivalent artifacts keep THO's version.** No change, no increment.
- `CodeSystem.concept` *and all subelements* are in the increment column, so a
  dropped definition requires a bump.
- **Carve-out:** `CodeSystem.description` is *"Major unless only change is
  improved clarity or perform editorial corrections."* That is a human
  judgement on our 6 description diffs, not computable.
- **The ValueSet policy has no equivalent carve-out**, so our 10 VS description
  diffs would bump unconditionally. The user believes this is an accident,
  has messaged the policy's main editor, and expects it to be removed. **Do not
  build logic that depends on the asymmetry.**
- Identifiers are the exception to all of it: changing or removing one requires
  a **new artifact**, not a new version.

### 0560 — decided, not yet implemented

Publish it **as Chapter 2C publishes it**: five codes (`FL` Units, `HS` Hours,
`DY` Days, `MN` Month, `YY` Years) and the value set OID
`2.16.840.1.113883.21.380` / `hl7VS-quantityUnits`. The pipeline currently
writes **nothing** for it.

The existing decision to treat it as concept-domain-only is in
`docs/adr/0008-v291-vocabulary-representation.md`, in the section headed *"The
seven tables with an empty grid, disposed of individually"*, whose table has a
row reading `0560 Quantity Units | Concept domain only`. It keyed off the code
system block being the `noObject` placeholder and dropped the codes and the
value set with it.

**The remarks about 0560 must stay visible in the IG itself**, not only in the
register — the user was explicit that the problem needs traceability available
to everyone, not just to us.

### Register — 29 items

Five added this session, all from the THO comparison:

- `esc-tho-dangling-value-sets` — 0350, 0351, 0456, 0895 compose from a v2 code
  system THO does not publish, so they cannot expand. 0005 and 0292 look
  identical but compose from CDC race codes and CVX and are **correct** —
  excluded explicitly so nobody sweeps them in.
- `esc-v2tables-domain-gaps` — `v2-tables` names 35 concept domains
  `conceptdomains` does not define. All 35 are among the 39 entries Chapter 2C
  no longer carries.
- `esc-v2tables-siteadministered` — table 0034's domain is `SiteAdminstered`
  while its display is `SITE ADMINISTERED`. **Framed as a technical
  correction**, because `v2-tables` is a metadata convenience nobody sends in a
  message. Contrasted with a typo in a real code, where the remedy is
  deprecate-and-replace.
- `esc-0133-contradictory` — 0133 says concept-domain-only, *and* "a set of
  codes known to be incomplete", *and* replaced by table 0443 in v2.6, while
  THO publishes nine active codes.
- `esc-oid-conflicts` — Chapter 2C and THO disagree on the OID for
  `CodeSystem/v2-0001` (`…18.458` vs `…18.2`) and `ValueSet/v2-0719`
  (`…20429` vs `…20428`).

### Rules settled that must not be re-derived

- **Artifact version and package version are different things.** `conceptdomains`
  correctly increments 3.0.0 → 4.0.0 because *that artifact* changes. That says
  nothing about which THO release carries it. Do not put artifact version
  numbers in reader-facing rows — convey that something is new and will carry an
  increment, not the number.
- **`AdministratableDrugForm` is not a finding.** It is a documented,
  deliberate CDA R2 backwards-compatibility synonym with `synonymCode` and
  `openIssue` properties, and it is `source: cda` — out of scope for v2 work.
- **A canonical URL is an identifier and nothing more.** Where THO already
  publishes one, that is the URL.
- **A brand-new CodeSystem or ValueSet starts at `1.0.0`.**
- **We do not tamper with existing external code system records in THO.**
- **The seven `apply-*` parameters stay false** in `vocab-ig/input/vocabulary.xml`.
- **Never add `-tx n/a` to the vocabulary build.**
- **Do not say "D11" or "a D11 reversal" to the user.** Describe the situation
  in words, and give the file and the section heading if a pointer helps.

### How to look at the IG

Build output at **`vocab-ig/output/index.html`**; the new page is
`table-index.html`. Two ways in, both fine:

- **As a file.** `/workspace` is a virtiofs bind mount, and the output is
  pre-rendered static HTML with relative links.
- **Over HTTP.** The container publishes ports. `$MOSH_PORTS` is
  `3000,4000,5173,8000,8080,8888,9000`, `$MOSH_PORT` is `3000`. **Bind
  `0.0.0.0`, never `127.0.0.1`.** Host port = `$MOSH_PORT_BASE` + the index of
  the container port within `$MOSH_PORTS`, so container 3000 → **host 20010**.

  ```
  cd /workspace && nohup python3 -m http.server "$MOSH_PORT" --bind 0.0.0.0 \
    >/tmp/s.log 2>&1 &
  # then: http://localhost:20010/vocab-ig/output/table-index.html
  ```

### Build

```
python3 tooling/scripts/stage_vocab_ig.py
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx8g -jar input-cache/publisher.jar \
  -ig vocab-ig/ig.ini -no-sushi
```

**Run it as one command, not chained with `&&` behind a trailing `&`** — that
backgrounds the whole chain, swallows the earlier steps' output, and starts the
log late enough that a watcher fails to open it. **The publisher wipes
`output/` on startup, so the IG is dark for the duration** and anything watching
a URL will 404. **`kill <pid>` on the shell wrapper does not stop the JVM**;
check with `ps -eo pid,cmd | grep '[j]dk/bin/java'` and kill the java process,
or two publishers will write the same directory at once.

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
python3 tooling/scripts/generate_table_index.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

The first two are expensive and only needed if the text policy changed.
`generate_table_index.py` must run after `write_utg_xml.py` — it reads the
authored resources — and before `stage_vocab_ig.py` if the page changed.
**A silent run is the expected outcome; read the output if it is not.**

### Open blockers

- **None on our side.**
- The additive-stance ruling is the one external dependency, expected at
  Rockville the week of 2026-09-21. Until then, **take the additive stance.**
- `./apptainer/remote-build.sh vocab` has still never been executed and cannot
  be run from this container. At ~15 minutes locally it is not needed.

### Not ours — leave alone

Five untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. The reviewer has been asked four times
which document should carry the two CH02 findings (the `FSH`/`FHS` naming, and
the inverted `BHS-15`/`FHS-15` containment predicates) and has not answered.

## Session History

## 2026-09-16 → 2026-09-17 — A table index, and what comparing against THO actually found

### Completed

**The guide has a table index.** One row per Chapter 2C table, keyed by table
number, resolving each to the artifacts that represent it — in this guide, in
THO, or nowhere. Published as `table-index.html`, linked from the home page,
generated by `tooling/scripts/generate_table_index.py` with 40 tests.

The link rule the user specified: visible text is always the THO canonical
because that is the identifier, but the link resolves **into this guide** where
we author the artifact, falling through to THO only where we do not. A marker
says which. That is right for a review draft — a reviewer clicking a canonical
should land on the thing under review.

**The comparison against `tho-r5/` is the real output of the session.** 383 of
396 code systems differ from THO; only 13 are byte-equivalent. 388 of 413 value
sets *are* byte-equivalent, because 408 of 422 have a bare "all codes" include
and have nothing to diverge on. The user predicted that asymmetry before it was
measured.

**Five register items**, all found by putting the two corpora side by side
rather than by inspection: four THO value sets that cannot expand, 35
`vocab-domain` values that resolve to nothing, the `SiteAdminstered`
misspelling, 0133's three mutually contradictory self-descriptions, and two OID
conflicts. Register is at 29.

**Concept domain codes lost their spaces.** Four had them; squishing fixed 0180
for free, since `Masterfile Action Code` squishes to a code THO already
publishes.

### The finding that changes the plan

**4,855 concept definitions exist in THO and are absent from our output.** Not
missing codes — missing *definitions*, across 382 code systems. It follows from
the settled rule that `definition` is never back-filled from `display`, which is
correct about inventing definitions and has the unintended consequence of
stripping text THO already wrote, at THO's own canonical.

The user's response was to take an **additive stance** pending a definitive
answer at Rockville: the point of this work is to *add* Chapter 2C's information
to THO, and that does not require removing anything. A computable record of
every fill is wanted; a human-readable description of each *class* of fill is
enough, because enumerating 4,855 is not useful to anyone.

### Corrections taken during the session

Five, three of which would have shipped something wrong:

- **Reported that the corpus policy was "inherit THO's version unchanged" and
  argued `conceptdomains` should drop to 3.0.0 to match.** The facts were right
  and the conclusion inverted: under UTG policy those 383 artifacts are all
  *wrong* and `conceptdomains` is the only one right. Compounded by a script bug
  — an ElementTree element with no children is falsy, so `(elem or {}).get()`
  returned `None` for every version and reported "0 match THO".
- **Claimed `AdministratableDrugForm` was an undocumented duplicate.** It is a
  deliberate CDA R2 backwards-compatibility synonym, carries `synonymCode` and
  `openIssue` properties, and is `source: cda` — out of scope entirely. The
  error was truncating both definitions to 90 characters, seeing them match, and
  calling them identical; the misspelled one has an extra paragraph explaining
  itself.
- **Rendered invented canonicals as fact.** Constructed `CodeSystem/v2-0010` as
  a lookup key so the THO check had something to test, then printed it in the
  cell as though it described an artifact. The user caught it.
- **Killed a shell wrapper instead of a JVM**, so two publishers wrote the same
  output directory concurrently. Neither would have announced the collision.
- **Stamped `new in 4.0.0` on 204 rows**, asserting a version THO has never
  issued. Removed; rows now say only whether a concept is in THO.

Also reported "37 of 624 `vocab-domain` values are missing" as though those rows
were in the index. They are not — all 35 remaining are among 39 tables Chapter
2C no longer carries, so no row of the guide is affected.

### Not done

None of the agreed plan. The additive merge, the computed version bumps, 0560,
the per-table ledger and the two ADRs are all next session's work.


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
  container's ports are mapped or that `/workspace` is a bind mount of the
  project directory (it is, via virtiofs). Verified afterwards that the output
  has no XHR, no root-relative links and no ES modules, so `file://` loses
  nothing. *[Superseded 2026-09-16: the ports were unmapped then, but the
  meta-harness has since been changed to publish `$MOSH_PORTS`. Serving over
  HTTP now works — see the ACTIVE section. Do not re-derive "ports are not
  mapped" from this entry.]*
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
