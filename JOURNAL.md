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

## ACTIVE — 2026-09-19 (the plane review: two of four sessions done)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

**Phase:** working through a 40-item review the reviewer wrote while travelling
(`vocab-ig/michael_ig_review_202601918.md`). The plan splits it into four
sessions; **sessions 1 and 2 are committed and built clean.** Disposition of
every item, and every research finding behind it, is in
**`v291-review/review-20260918-tracker.md`** — read that before anything else,
it is the working state and none of it needs re-deriving.

Commits: `49ecefc3` (presentation, numbering), `6a896e44` (versioning carve-out,
status letters, 0292, 0227). Build: exit 0, **errors 3479, warnings 145, broken
links 0**, 464 tests.

### First thing next session

**Session 3 — fold the review report into the IG.** The reviewer's words: *"we
need to nicely fold the vocabulary review report into the reporting that this
IG contains. We want one product that has everything — issues, changes, and the
publication itself."* This is the largest remaining item and wants a fresh
context.

`v291-extracted/vocabulary-review-report.html` is 1.76 MB: 93 groups, ~2,125
values, bucketed For-V2-Mgmt (34) / Decide (19) / Decided (1,528) /
Informational (544). **Decided and Informational go on an auxiliary evidence
page** — the reviewer agreed it exists as proof rather than as a review ask.
Also in session 3:

- **Reconcile the two "needs a second look" computations, which disagree.** The
  table index says 21 rows (THO presence/absence); the ledger says 97 changed +
  73 register-named (merge observations + the register). Different inputs,
  never reconciled, and a reader meets both.
- The 7 register items and all 9 `vocabulary-future-corrections.md` items that
  reach no IG page. They have nowhere to land because they name no table; the
  register page is that home.

**Session 4** is the field mapping: promote `render_field_mapping.py` into the
IG as a page, then the Ch2c-steward ↔ THO `structuredefinition-wg` comparison
(there is no steward extension in THO — that is the real comparison target),
and the external-code-system → ValueSet-canonical gap analysis.

### Open questions for the reviewer

1. **ADR-0011 is `Proposed`, not `Accepted`** — it partly pushes back on
   ADR-0010's rule against keying an override by table number, arguing the rule
   does not reach a *provisional* deviation whose scope genuinely is one table.
   It needs a yes or a redirect. The mechanism is built and 0292 rides on it.
2. **Eleven artifacts took a major version bump for a comma.** That follows
   from the ruling and is implemented; flagged because a committee member will
   notice and the reviewer may want to see the list first.
3. **The v3 link fix is far cheaper than the page implies** and is not yet
   done. The 191 dangling hrefs live in `CodeSystem.text.div`, inherited
   verbatim from THO, and each anchor already carries the canonical in its
   `title`. **No version cost** (narrative is not compared by the merge and not
   in the versioning element tables) and **no human ever sees them** — the
   rendered HTML has none; they exist only in the distributed `.json`/`.xml`/
   `.ttl` and QA. Only open choice: link the canonical or THO's page URL.

### Settled 2026-09-20

- **ADR-0011 accepted in substance.** The reviewer read both ADRs and is content
  with the plan for 0560 and 0292, and independently made ADR-0011's own
  argument: a general rule that catches one exception table is not worth
  finding. 0292 is keyed by table number, which is what ADR-0011 already does.
  The one general rule that stands is 0227's truncated-prefix condition, kept
  because it has **15 latent members** — the other truncated descriptions become
  recoverable the moment THO gains their text, which the register is asking for.
- **The policy PDFs are on the orphan branch `reference/policy-snapshots`**
  (`bd2f96b7`), which shares no history with anything and is never merged. They
  are off the working tree entirely and gitignored so a re-export does not look
  like new work. `tho_versioning_policy.py`'s docstring says how to get them
  back. **Note the hazard if you ever do this again: from an orphan branch the
  whole repo looks untracked, so switching away needs `git checkout -f` — take
  checksums of untracked files first.**

### What the build numbers mean now

**Errors 3479, warnings 145, broken links 0**, and every number is accounted
for. 3,267 errors are `designation.language` against an unreachable
`tx.fhir.org`; ~191 are the `conceptdomains` hyperlinks above; one is a
terminology-server cache error on the new 0292 resource. Of the warnings, a
large block is **"multiple different potential matches for the url"** — one per
artifact whose version differs from the loaded THO package. Verified: every
warned table is an incremented one, and no un-incremented table is warned. It
grows with every future increment and is now documented on the Known issues
page. **It is not a defect.**

### Things that will bite the next session

- **Build order changed.** `generate_table_index.py` now reads the generated
  `table-ledger.md` to learn which tables have a section, so it must run
  **after** `render_table_ledger.py`. Sequence: `write_utg_xml.py` →
  `render_tho_merge_page.py` → `render_table_ledger.py` →
  `generate_table_index.py` → `stage_vocab_ig.py`.
- **Every page starts at `###`.** The template emits the page title as `<h2>`
  and numbers with CSS counters where `h2:before` prints only the page number
  with no counter of its own. A markdown `#` or `##` anywhere on a page breaks
  the numbering for the whole page. Generators emit `###`/`####`; keep it that
  way.
- **The publisher-already-running check in `MEMORY.md` used to be wrong** and
  is now fixed. Match on `comm`, not the command line: the Bash tool wraps
  commands in `bash -c '<the command>'`, so grepping for the publisher path
  matches the wrapper and always reports a false positive.
- `stage_vocab_ig.py` self-checks the counts quoted on `index.md`. Believe it.
  ValueSets are now **424**, not 423 — 0292 added one.

### Register — 38 items

Added: `esc-0292-cdo-contradiction`, `esc-0567-0568-representation`,
`esc-v2tables-retirement`, `esc-deprecation-flag-contradicts-status`.
Amended: `esc-oid-conflicts` (0078 added as a third instance, one we create
rather than inherit), `esc-tables-that-should-be-domains`,
`esc-0133-contradictory`, `esc-status-n-b-undefined`.

### How to look at the IG

Build output at **`vocab-ig/output/index.html`**. `/workspace` is a virtiofs
bind mount and the output is static HTML with relative links, so opening the
file works. Over HTTP: bind `0.0.0.0`, never `127.0.0.1`; container 3000 →
host 20010.

```
cd /workspace && nohup python3 -m http.server "$MOSH_PORT" --bind 0.0.0.0 \
  >/tmp/s.log 2>&1 &
```

### Build

```
python3 tooling/scripts/stage_vocab_ig.py
GEM_HOME=/home/claude/.gems GEM_PATH=/home/claude/.gems \
PATH="/home/claude/.gems/bin:/home/claude/ruby/arm64/bin:$PATH" \
/home/claude/jdk/bin/java -Xmx8g -jar input-cache/publisher.jar \
  -ig vocab-ig/ig.ini -no-sushi
```

~16 min, **silent for ~13 of them** during "Run Template" — check the process
is alive rather than assuming it hung, with
`ps -eo pid,etime,comm,args | awk '$3=="java"'`. The publisher wipes `output/`
on startup, so the IG is dark for the duration.

### Not ours — leave alone

Five untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`git add tooling/scripts/` sweeps two of
them in — stage vocabulary files explicitly.**


## Session History

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
