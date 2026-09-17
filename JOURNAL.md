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

## ACTIVE — 2026-09-17 (the merge with THO is in; next session builds the per-table ledger)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

**Phase:** items 1, 2 and 3 of the 2026-09-17 plan are done — the additive
merge with THO, version numbers computed from the TSMG policy, and table 0560.
ADR-0009 and ADR-0010 are written and Accepted. 386 tests pass (up from 290).
The IG builds clean (exit 0, 18m34s, **0 broken links**). The QA report says
3,478 errors; **211 of those are ours** and 3,267 are a terminology server
being unreachable — settled, nothing to do, see below.

### First thing next session

**Build the per-table ledger — item 4, and the biggest remaining item.** One
section per table carrying every change relative to THO beyond trivial
whitespace, every outstanding issue, and an indicator when an issue is a
*class* affecting other artifacts the same way.

Most of the input already exists and is computable:
`v291-fhir/tho-fill-report.json` has every observation individually, keyed by
table, with `kind` (fill / discrepancy / addition / omission), element, code
and both values. `tho_merge.Observations.for_table()` is there for exactly this.
The class-level view is already rendered at `tho-merge.html`; the ledger is the
per-table view of the same data, and it should absorb the two per-item lists
currently on that page.

### What is left of the plan agreed 2026-09-17

| Item | State |
|---|---|
| 1. Additive merge with THO | **Done** |
| 2. Version bumps computed from the policy | **Done** |
| 3. Table 0560 as the chapter publishes it | **Done** |
| 4. Per-table ledger in the IG | **Next** |
| 5. Two ADRs | **Done** — ADR-0009, ADR-0010 |

### What the merge did

Measured against `tho-r5/` (`hl7.terminology.r5` **7.3.0**). 8,272
observations: **7,575 fills**, 492 discrepancies, 159 additions, 46 omissions.

The fills are content THO publishes that we were deleting at THO's own
canonical: 4,855 concept definitions, 1,276 comments-as-published, 1,061
translations, 211 codes, 122 usage notes, 40 deprecation markers.

| | Keeps THO's version | Increments | New at 1.0.0 |
|---|---:|---:|---:|
| CodeSystems | 344 | 53 | 2 |
| ValueSets | 398 | 16 | 9 |

**742 of 822 artifacts now keep the version THO already published**, against
383 of 396 code systems that would have had to increment before. That is the
point of the coupling: most of the bumps were the cost of the deletions.

### Rules settled this session that must not be re-derived

- **Where THO has content and Chapter 2C has no opinion, THO's survives. Where
  both have something and they differ, the chapter wins and it is recorded.**
  This applies to *everything* THO carries, not a named list of elements.
- **A placeholder on either side is not content.** `tbd`, `noObject`,
  `noDescription`, `-` on the chapter's side; `"no definition"` on THO's (all
  five of table 0560's concepts). **`None` is not a placeholder** — seven THO
  concepts have the display `None` and the definition `None`, and that is the
  answer rather than the absence of one.
- **Whitespace is never a difference.** 358 of 396 descriptions differed from
  THO only in line wrapping.
- **Concept order is never a difference.** Compared as a set keyed by code; 32
  tables carry exactly THO's codes in a different order.
- **A punctuation-only difference in a `description` does not increment** — 12
  across 7 tables, all of them our `e.g.,` against THO's `e.g.`. Applied to
  `ValueSet.description` too, deliberately not encoding the policy asymmetry.
  **Not** extended to concept definitions or displays, where the policy grants
  no carve-out: 4 definitions and 21 displays increment for punctuation alone.
- **The merge never creates an artifact, never splices two pieces of prose, and
  never merges codes across a compose-shape difference.**
- **Version and identifier are different problems, and the identifier is the
  one element where the chapter does NOT win a disagreement.** An identifier is
  identity, not content: the canonical is THO's, and the policy forbids
  changing a published identifier, so writing the chapter's OID there would
  assert this is a different artifact rather than publish the chapter
  faithfully. Where the two conflict — `CodeSystem/v2-0001` and
  `ValueSet/v2-0719` — **THO's OID is published** and the conflict is
  registered. This follows the reasoning already recorded in
  `esc-oid-conflicts`; the first implementation contradicted it and was
  corrected.

### Where `N` comes from — asked and answered this session

Chapter 2C's own "Status Codes" legend, in `CH02C_Tables.docx`: *empty* = active
code, `B` = backwards-compatible use only, `D` = deprecated or inactive,
`R` = retired, **`N` = new in this release**.

The property is `status`, defined by FHIR at
`http://hl7.org/fhir/concept-properties#status`, whose definition says *"Typical
values are active, experimental, deprecated, and retired"*. **`N` and `B` are
defined nowhere else** — not in `utg-concept-properties`, not in any value set,
and across the whole of THO they appear only in v2 code systems (210 `N`, 6 `B`).
`N` also decays: "new in this release" is never updated, which is why THO still
marks 210 concepts `N` while the 2.9.1 chapter marks 70, and why **205 of the
261 status disagreements** are THO's `N` against our `active`.

This is question 5 on the new **General questions** page.

### New in the IG

- **`general-questions.html`** — the judgement calls, what this build does about
  each, what rides on it, and who should confirm. Four questions for TSMG
  (concept ordering, the description carve-out, why it does not reach concept
  definitions, the ValueSet policy's missing carve-out) and four for V2
  Management (`N`/`B`, table 0560, the two OID conflicts, the two descriptions
  where THO says more than the chapter). **Hand-written** — edit it as answers
  arrive.
- **`tho-merge.html`** — what the merge kept, class by class, with counts.
  Generated by `render_tho_merge_page.py` from the fill report.

### Two things needing a person, both surfaced computably

- **`CodeSystem/v2-0001` and `ValueSet/v2-0719` carry OID conflicts** between
  Chapter 2C and THO. THO's OID is published pending adjudication, so neither
  is a version question. These are the only two in the corpus, and they are
  what the register's `esc-oid-conflicts` describes.
- **`ValueSet/v2-0227` and `ValueSet/v2-0719` descriptions differ in words, not
  punctuation.** THO's 0227 carries a PHIN VADS source URL ours drops; THO's
  0719 ends *"this resource was created in THO in error due to an oversight in
  the import processing."*

### Open blockers

- **None on our side.**
- The additive-stance ruling was expected at Rockville, week of **2026-09-21**.
  The stance is implemented and documented in ADR-0009; a ruling the other way
  is a located change, not a rewrite.
- The V2 Management meeting of 2026-08-28 is still unrecorded — asked across
  five sessions. Ask once, do not spend the session on it.

### Register — 33 items, four added and three corrected

Added: `esc-status-n-b-undefined`, `esc-concept-ordering`,
`esc-description-editorial-carveout`, `esc-tho-descriptions-say-more`. Each
mirrors a question on the General questions page — the page is what a reader of
the guide meets, the register is what goes to the committees, and they must not
drift apart.

Corrected, because this session changed what the pipeline does and the register
still described the old behaviour:

- **`esc-0560-content`** said the working decision was concept domain only. It
  now records the reversal (ADR-0010) and keeps the escalation live, because
  the naming problem — four of five codes are units of *time* under a table
  called Quantity Units — is untouched by publishing the artifacts.
- **`esc-placeholder-metadata`** said both 0560 and 0910 were treated as
  concept domain only. It now explains the evidence-based split.
- **`esc-oid-conflicts`** recommended publishing THO's identifier rather than
  the chapter's. That recommendation is now **enforced in the pipeline** rather
  than sitting in a document — see the rule below.

### How to look at the IG

Build output at **`vocab-ig/output/index.html`**; the new pages are
`tho-merge.html` and `general-questions.html`. Two ways in:

- **As a file.** `/workspace` is a virtiofs bind mount and the output is
  pre-rendered static HTML with relative links.
- **Over HTTP.** `$MOSH_PORTS` is `3000,4000,5173,8000,8080,8888,9000`,
  `$MOSH_PORT` is `3000`. **Bind `0.0.0.0`, never `127.0.0.1`.** Host port =
  `$MOSH_PORT_BASE` + the index of the container port within `$MOSH_PORTS`, so
  container 3000 → **host 20010**.

  ```
  cd /workspace && nohup python3 -m http.server "$MOSH_PORT" --bind 0.0.0.0 \
    >/tmp/s.log 2>&1 &
  # then: http://localhost:20010/vocab-ig/output/tho-merge.html
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

### The designation errors — settled, and the answer is "nothing to do"

**The build is `errors 3478, warnings 136, broken links 0`. Read that as 211
errors that are ours and 3,267 that are a terminology server being down.**
191 of the 211 are the unresolved `conceptdomains` hyperlinks already on the
Known issues page. The baseline before this session was 216 / 416 / 1.

The 3,267 are `designation.language`. The 1,061 designations inherited from THO
each need their language validated against
`http://hl7.org/fhir/ValueSet/all-languages`, which includes `urn:ietf:bcp:47`,
which no package defines — so the validator asks `tx.fhir.org/r5`, and that
answers with a cache error every time. Three errors per designation. The
content is correct: `de` is a valid BCP 47 tag and THO publishes exactly these
values. Dropping the designations is not an option; they are what the merge
exists to keep.

**`vocab-ig/input/ignoreWarnings.txt` cannot fix this, and now says so.** Two
wrong turns went into learning that, both worth not repeating:

1. The first version used a `%regex%` prefix. There is no such syntax. The
   publisher read **every line including the `#` comments** as a pattern and
   reported 35 entries at "(0 uses)".
2. The rewrite uses the real format, found in `PublisherIGLoader` and
   `SuppressedMessageInformation` inside `input-cache/publisher.jar`: a
   `== Suppressed Messages ==` header, `#` lines as reasons, `%` as the
   wildcard (`%text%` contains, `text%` startsWith, `%text` endsWith). **It
   matches — qa.html reports 3,267 uses — and the error count did not move.**
   The publisher only suppresses **warnings, hints and broken links, never
   errors**, which qa.html states in the heading of that very section.

So there is no suppression route while these are errors. **The remedy is a
reachable terminology server**, and `-tx n/a` is not an option for this build.
The entry is kept because it is precisely scoped and starts working by itself
if these are ever downgraded to warnings. **Do not spend another build on it.**

The fastest diagnostic if this ever needs revisiting: qa.html prints every
pattern with a use count, next to the heading that says which severities it
can touch.

### Regeneration sequence

```
python3 -m pytest tooling/scripts/
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/write_utg_xml.py
python3 tooling/scripts/render_tho_merge_page.py
python3 tooling/scripts/generate_table_index.py
python3 tooling/scripts/stage_vocab_ig.py
python3 tooling/scripts/vocabulary_escalations.py
python3 tooling/scripts/render_vocabulary_review_html.py
python3 tooling/scripts/render_field_mapping.py
python3 tooling/scripts/render_utg_briefing.py
python3 tooling/scripts/render_v2mgmt_briefing.py
```

The first two are expensive and only needed if the text policy changed.
`render_tho_merge_page.py` reads `tho-fill-report.json`, so it must run after
`write_utg_xml.py`. `generate_table_index.py` reads the authored resources, so
it must also run after the writer and before `stage_vocab_ig.py`.
**`stage_vocab_ig.py` self-checks the counts quoted on `index.md` and warns when
they drift — believe it and fix the page.** A silent run is otherwise the
expected outcome; read the output if it is not.

### Not ours — leave alone

Five untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. The reviewer has been asked five times
which document should carry the two CH02 findings (the `FSH`/`FHS` naming, and
the inverted `BHS-15`/`FHS-15` containment predicates) and has not answered.

`CS_versioning_policy.pdf` and `VS_versioning_policy.pdf` are also still
untracked — HL7 Confluence exports, and nobody has said whether to commit them.
They no longer need to be read to run the pipeline: both element tables are
transcribed into `tooling/scripts/tho_versioning_policy.py`.

## Session History

## 2026-09-17 — The merge with THO, versions computed from the policy, and table 0560

### Completed

**This guide no longer deletes THO's content.** Publishing at THO's canonicals
means publishing *that artifact*, so everything our output left out was being
removed from the thing the URL names. The merge is now additive: where THO has
content and Chapter 2C has no opinion, THO's survives; where both have
something and they differ, the chapter wins and the disagreement is recorded.
7,575 fills — 4,855 concept definitions, 1,276 comments-as-published, 1,061
translations, 211 codes, 122 usage notes, 40 deprecation markers.

The user's ruling widened the original plan: *"We should retain everything that
THO carries. If both carry something and there is a discrepancy, we need to
call that out. We also need to call out situations where there are either codes
that THO has but Ch2C doesn't or vice versa."* So the stance is not a list of
three elements — it is every kind of content THO holds, with four kinds of
observation recorded per instance (fill, discrepancy, addition, omission).

**Version numbers are computed, not inherited.** The TSMG element tables are
transcribed into `tho_versioning_policy.py` and the version is re-derived every
run by comparing the merged artifact against THO's. **742 of 822 artifacts now
keep the version THO already published**, against 383 of 396 code systems that
would have had to increment before. The two problems were one problem: most of
the bumps were the cost of the deletions.

Transcribed rather than parsed because the PDFs are Confluence exports that are
not checked in — a parser would only work on one machine. Reading them needs
`pypdf`'s `extraction_mode="layout"`, or the four columns collapse and there is
no telling which one each `x` sits in.

**Table 0560 is published as the chapter publishes it** (ADR-0010). The chapter
gives it a `noObject` code system block — and underneath it, five codes, the
value set's OID, and a `all codes` definition; and THO already publishes both
artifacts with those same five codes at an OID in the v2 arc. Four signals
agree and only the marker disagrees. The rule is written on that evidence
rather than on the table number: the placeholder is overridden only when the
chapter lists codes, THO publishes a code system at the table's own canonical,
and the chapter declares a value set. 0560 is the only table that qualifies;
0910 has the same marker, no codes and no THO code system, and is untouched.

**Two ADRs**, kept separate at the user's earlier choice: **ADR-0009** for the
additive stance and the computed versions, **ADR-0010** for 0560.

**A General questions page** (`general-questions.html`), hand-written, carrying
the judgement calls with what rides on each. Four for TSMG, four for V2
Management. This is where the user asked concept ordering and the punctuation
question to live.

### Three judgement calls, and what the user decided

- **Whitespace is not a difference** — confirmed. 358 of 396 descriptions
  differed from THO only in line wrapping.
- **Concept order is not a change** — the user agreed, and asked that it be
  noted and asked about rather than assumed. It is question 1 on the new page;
  32 tables ride on it.
- **A punctuation-only description difference does not increment, but stays
  traceable, and the grammar gets fixed.** Implemented as `is_editorial()`:
  same words in the same order means only punctuation moved. Chapter 2C's text
  is the better one in all 12 cases (ours has the comma in `e.g.,`; ours has
  `code system.` against THO's `code system .`), so publishing the chapter's is
  the grammar fix.

That last one needed splitting, which the original 14 "waivable" items hid: 12
are punctuation and 2 are not. `ValueSet/v2-0227`'s THO description carries a
PHIN VADS source URL ours drops, and `ValueSet/v2-0719`'s ends *"this resource
was created in THO in error due to an oversight in the import processing."*
Those two still increment and are listed for a decision.

### Where `N` comes from

Asked directly, and worth recording because the answer is "nowhere useful".
Chapter 2C's own Status Codes legend defines `N` as **"new in this release"**
and `B` as "backwards-compatible use only". The property is FHIR's `status`
(`http://hl7.org/fhir/concept-properties#status`), whose definition names
active, experimental, deprecated and retired as the typical values. `N` and `B`
are in no code system, no value set and no property definition; across all of
THO they appear only in v2 tables (210 `N`, 6 `B`).

`N` is worse than undefined because it decays — nothing updates "this release"
afterwards — which is exactly why **205 of the 261 status disagreements** are
THO still saying `N` where the 2.9.1 chapter says nothing and we write `active`.

### Two bugs found by looking at the output rather than the tests

- **266 phantom additions.** The merge guarded on `ours is not None` where a
  chapter row carries `""` for an unfilled column, so 266 empty strings were
  reported as content this guide contributes. Both sides now test with
  `is_absent`. No version numbers were affected — those are computed from
  values, which never changed — but the report and the page were wrong.
- **THO placeholders were being copied in.** All five of table 0560's concepts
  are defined in THO as the literal string `"no definition"`, and the merge was
  publishing it as a definition. A fill now requires THO's value to be real
  content. `None` was briefly caught by the same net and had to be taken back
  out: seven THO concepts have the display `None` and the definition `None`,
  where None is the answer.

### The build

The first verification build came back with **3,479 errors against the previous
216**, which needed running down rather than shipping. Every one of the new
ones is `designation.language`: FHIR binds it to `all-languages`, which includes
`urn:ietf:bcp:47`, which no package defines, so the validator asks
`tx.fhir.org/r5` — and that answers with a cache error on every request. Three
errors per designation, 1,061 designations.

The suppression file did not work on the first try, and that is worth
recording: the publisher read **every line of it, comments included**, as a
pattern, and `%regex%` — which I had assumed was the syntax — is not supported
at all. qa.html prints each pattern with a use count, which is how the failure
became visible: 35 entries, every one at "(0 uses)". Nothing unintended was
suppressed, but nothing intended was either. The real format is in
`PublisherIGLoader` and `SuppressedMessageInformation` inside the publisher
jar: a `== Suppressed Messages ==` header, `#` lines as reasons, and `%` as the
wildcard. The file now matches that and **is still unverified** — the next
build settles it.

Dropping the designations instead would have meant deleting the content the
merge exists to keep, so suppression is the only route while the terminology
server is down.

### Non-obvious context for next time

- **`stage_vocab_ig.py` self-checks the resource counts quoted on `index.md`.**
  It caught 398/422 going stale at 399/423 when 0560 arrived. Believe it.
- **`build_code_system` and `build_value_set` are now thin wrappers.** The work
  is in `plan_*` (settle every value, merge, compute the version) and
  `render_*` (build the XML once). Merging on a node tree would have been
  unreadable, and the split is what let the existing 290 tests keep passing
  untouched — the builders still work with no THO snapshot on disk, which is
  the path every one of those tests takes.
- **`--no-tho-merge`** writes what Chapter 2C says and nothing else, if the
  chapter-only output is ever needed for comparison.
- The fill report is 1.8 MB and rewritten every run. That is in line with what
  `v291-extracted/` already carries, and it is the thing the per-table ledger
  will read.

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
