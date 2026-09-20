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

## ACTIVE — 2026-09-20 (session 3: the fold is in, and nothing is built)

**Branch: `dev/v291-vocabulary-ig`. All vocabulary work is on this branch and
nowhere else;** `dev/framework` carries only the structural-review workstream.
**Do not commit vocabulary work to `dev/framework`.**

### Read this before anything else

**`vocab-ig/output/` is EMPTY and the IG is dark.** A build was started and
killed about a minute in, and the publisher wipes `output/` on startup. Nothing
is broken — but there is no IG to look at until someone rebuilds, and the last
build numbers quoted anywhere in this file describe a tree three commits old.

**Nothing from this session has been through the publisher.** Three commits
landed and 490 tests pass, but every claim below about how the guide *renders*
is unverified.

### First thing next session

**Build.** The command is at the foot of this section. Then check four things,
in this order, because this session changed the page set rather than the
content of a page:

1. **Broken links — the metric was 0 and this session moved a lot of links.**
   `general-questions.html` no longer exists. Its inbound links were retargeted
   at `open-items.html#<question-id>`, generated through `question_anchor()`,
   which raises on an unknown id — so a *dangling* link should be impossible,
   but a *wrong anchor* is not. Confirm the two cross-links land on the right
   question: the ledger's table-OID paragraph → question 6, the merge page's
   reordering paragraph → question 1.
2. **`evidence.md` is 1.79 MB**, against 484 KB for the previous largest page
   (`table-index.md`). That is 3.7x anything the publisher has been asked to do
   here. If it chokes, or the page is unusable in a browser, the split is
   Decided (1,534) / Informational (544) on two pages — the generator already
   groups by action class, so it is a small change to
   `build_evidence_page()`.
3. **Section numbering on the two new pages.** Both start at `###` and a test
   holds that, but the CSS-counter scheme has surprised us twice.
4. **Errors should fall by ~191** — 3479 → ~3288 — because the `conceptdomains`
   narrative links are fixed. If they do not, the fix is not reaching the
   published resource.

### What landed this session

- **`3a6b1acd` — the v3 narrative links now use the canonical.** The reviewer
  overruled the page-URL choice recorded in `935153b0`: the HL7 proxy redirects
  the canonical to the rendered page, so the redirect hop that argument turned
  on costs nothing. All 191 hrefs across six targets. Implemented as
  `absolutize_narrative_links()` in `generate_concept_domains.py`, which
  rewrites a link only when the THO snapshot carries that code system at that
  exact canonical and reports anything it declines to touch. Version unchanged
  at 4.0.0.
- **`70eac1e5` — the tracker's session-2 status column reconciled.** It still
  read `todo` for fourteen rows that landed in `6a896e44`. Reconciled against
  the commits and the register, evidence written under the table. This turned
  up **three genuinely open items that were in neither session 3 nor 4**:
  **S2-15** (no `deprecated` value for `CodeSystem.status` → backlog entry),
  **S2-16** (property-instance suppression — the one with teeth), and **S2-20**
  (classify the page-URL/missing-space defects against the errata rubric).
- **`9954d3c2` — the review report is folded into the guide.**

### The fold, and the one decision behind it

`open-items.html` — the 38-item register, the 7 authored general questions, the
19 decisions still to take. `evidence.html` — 1,534 settled findings and 544
disclosures, and it says outright that it asks for nothing.

The split is **by the ACTION class the report already assigns**, not by a
second judgement, so a group moves pages by being re-classed and cannot appear
on both. An unrouted class stops the run.

**`general-questions.md` is absorbed and deleted.** The reviewer chose this over
keeping it beside the generated pages: three review-facing pages was the
duplication the fold is meant to kill. Its prose moved **verbatim** into
`tooling/scripts/vocabulary_general_questions.py` — lifted programmatically,
not retyped, and git records it as a rename, which is the check. Question
numbers 1-7 and their ids are stable and are what cross-links use.

**The standalone `v291-extracted/vocabulary-review-report.html` stays**, as a
dev artifact. The reviewer's call. It shares `render_vocabulary_review_html`'s
section builders with the IG pages, so the two cannot disagree about *what* the
findings are — only about layout.

### Open questions for the reviewer

1. **Is `Evidence` the right name in the navbar?** It is currently
   "For review → What needs an answer / Evidence / Known issues". Cheap to
   change; nobody has seen it rendered.
2. **The evidence page may want splitting** — see item 2 above. Not a decision
   worth taking before seeing it.

### Still open on the review

- **S3-03 — the two "needs a second look" computations still disagree.** Table
  index says 21 rows; the ledger says 97 changed + 73 register-named. Different
  inputs, never reconciled, and a reader meets both. **This is the largest
  remaining session-3 item and it was not touched.**
- S3-04 is **partial**: the fourteen tables are now grouped by cause on
  `open-items`, and `known-issues.md` points at it, but the review-report
  evidence per table is not folded into the ledger sections.
- S2-15, S2-16, S2-20 as above.
- **Session 4** untouched: promote `render_field_mapping.py` into the IG; decide
  what maps to properties/extensions/nothing; Ch2c steward ↔ THO
  `structuredefinition-wg`; external code systems → ValueSet canonical gaps.

### Things that will bite

- **Build order has a new step.** `render_review_pages.py` must run after
  `generate_concept_domains.py` (it reads the divergences) and before
  `stage_vocab_ig.py`. Full sequence:
  `generate_concept_domains.py` → `write_utg_xml.py` →
  `render_tho_merge_page.py` → `render_table_ledger.py` →
  `generate_table_index.py` → `render_review_pages.py` → `stage_vocab_ig.py`.
  **There is still no orchestrator script** — this is the third ordering
  constraint held only by this note, and it is worth thirty lines to fix.
- **`ADR-0010` names `general-questions.html` and `general-questions.md`, and
  those are gone.** Left alone deliberately: an accepted ADR is immutable and
  records what was true when it was written. Do not "fix" it.
- **Every page starts at `###`.** The template emits the page title as `<h2>`
  and numbers with CSS counters; a `#` or `##` anywhere breaks numbering for
  the whole page. Tests hold this for the two new pages.
- **`grep` cannot search for a NUL byte** — `grep -c $'\x00'` is an *empty*
  pattern and matches every line, which reads as a catastrophic result. Check
  for NULs in Python. Tests now hold that both new pages have none.
- The publisher-already-running check: match on `comm`, not the command line.
- `stage_vocab_ig.py` self-checks the counts on `index.md`. Believe it.
  399 CodeSystems, 424 ValueSets, 824 total.

### Register — 38 items

Unchanged this session.

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
`ps -eo pid,etime,comm,args | awk '$3=="java"'`. **`kill` on the shell wrapper
does not stop the JVM**; kill the java pid, or two publishers write the same
directory.

### How to look at the IG

Build output at **`vocab-ig/output/index.html`** — empty right now. Over HTTP:
bind `0.0.0.0`, never `127.0.0.1`; container 3000 → host 20010.

```
cd /workspace && nohup python3 -m http.server "$MOSH_PORT" --bind 0.0.0.0 \
  >/tmp/s.log 2>&1 &
```

### Not ours — leave alone

Three untracked files belong to the **structural** workstream (`dev/framework`):
`tooling/scripts/render_message_structures_html.py`,
`tooling/scripts/render_three_way_html.py`,
`v291-extracted/message-structures-decision-report.html`,
`v291-review/three-way-comparison-report.html`,
`vocabulary-comparison-report.html`. **`git add tooling/scripts/` sweeps two of
them in — stage vocabulary files explicitly.**


## Session History

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
