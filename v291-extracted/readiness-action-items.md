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
| CodeSystems published | 398 |
| ValueSets published | 422 |
| `conceptdomains` | 1, at 4.0.0, 1,522 concepts |
| Tables with nothing written | **5** (was 14 before this batch) |
| Register items | 55, of which **20 answered** |

The needs-decision list is the lowest it has been since the project started.
Five tables remain: `0458`, `0459`, `0956`, `0962`, `0963`.

---

## A. Blocking submission for review

These must be closed, or consciously accepted, before the IG goes out.

### A1. The IG has not been validated since 2026-09-23

Everything in section B and C assumes the current build is clean. Until the
publisher run completes and its QA output is read, **every count in this
document is from the preprocessing chain rather than from a built IG**, and
no link check has been run against the current content. This is the first
thing to confirm, and it is in progress as this is written.

### A2. Five tables publish nothing, and three are waiting on other people

| Table | Waiting on | Can we unblock it? |
|---|---|---|
| `0458`, `0459` | THO creating the external code system record for the CMS I/OCE codes (OID `2.16.840.1.113883.6.301.9`) | No. The canonical the record carries is the only missing input. |
| `0956` | A decision about where the supervisory level / pay grade codes live once PHIN VADS is decommissioned | No. Both candidate value sets are dead ends — a withdrawn FHIR 3.3 ballot draft and a PHIN VADS entry. |
| `0962` | Nothing, arguably — see A3 | **Probably yes.** THO already publishes `ValueSet/v2-0962`, active at 3.0.0, identical to what this guide had been writing. |
| `0963` | A CLD reading "See content logical definition of the referenced value set", and a system URL of "Not yet approved by HTA" | No — HTA approval is a precondition. |

**The decision to make before submission** is not how to fix these. It is
whether an IG with five tables publishing nothing is submittable. It probably
is, provided each absence is explained on the page a reader lands on, which
`known-issues.html` now does. **Confirm that is acceptable rather than
assuming it.**

### A3. `vs-v2-0962.xml` is a tracked orphan, and the fix is probably a ruling

The file is staged and published for a table that routes to `needs-decision`.
Nothing prunes it, because the prune is deliberately narrow — it removes only
the exact paths for suppressed tables, since a broader sweep would be wrong
under `--table`. The writer warns about it on every run. It is the only
artifact in the IG that no route accounts for.

**Investigated 2026-11-05, and it is less awkward than it looks.** The table
routes to `needs-decision` because its code system is given as a FHIR core
*page* URL, `http://hl7.org/fhir/codesystem-device-status.html`, with an OID
that resolves to nothing. But **THO already publishes
`ValueSet/v2-0962`**, active at 3.0.0, carrying the same OID
(`2.16.840.1.113883.4.642.3.209`) and the same compose over
`http://hl7.org/fhir/device-status` that this guide's stale file holds. The
orphan is not wrong; it is simply unexplained, because no route produces it.

So there are two defensible outcomes and they need a decision rather than a
code change:

- **Nothing is wrong with the artifact** — in which case 0962 is the same
  shape as the seven tables suppressed this session: a correct value set
  already exists, and the guide should stop writing one and say so. That
  takes 0962 off the needs-decision list and deletes the orphan in one move.
- **The guide should publish it** — in which case the page-URL fallback that
  already rescues seven other tables should be extended to reach the FHIR
  core code system, and 0962 routes normally.

**Recommended: ask for the ruling.** The first option is almost certainly
right, and it is the same question V2 Management answered seven times this
month. Raised as `esc-0962-already-in-tho`.

### A4. 0467 composes over a canonical that does not resolve yet

Published deliberately, on the ruling, with a test waiver recording why.
Harmless in a review draft; it would be a defect in a publication. **Decide
whether to hold 0467 back if the THO record has not landed by submission.**

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
| CodeSystems THO does not have | 1 | `0460` — the only minted CodeSystem canonical left |
| ValueSets THO does not have | 6 | `0460`, `0467`, `0820`, `0823`, `0955`, `0958` |
| CodeSystems with a version increment | 58 | Changed against THO on an element the TSMG policy counts |
| ValueSets with a version increment | 21 | Same |
| `conceptdomains` | 1 | 4.0.0: THO's 3.0.0 plus 177 concepts, none removed |

**Roughly 87 artifacts carry a change.** That is the submission.

### B2. The minted canonicals need ruling before they are submitted

`0460` is the only table for which this guide still mints a CodeSystem
canonical, with `0093` open alongside it (`esc-0460-user-defined-mint`).
Submitting a minted canonical to THO asks THO to adopt a name this project
invented. **That is a decision for V2 Management, not a side effect of the
pipeline**, and it is open.

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

1. Finish and read the publisher QA output (**A1**) — nothing else is
   trustworthy until this is done.
2. Put `0962` to V2 Management (**A3**) — almost certainly an eighth
   "a correct one already exists" suppression, which also deletes the
   orphan.
3. Get a ruling on `esc-retain-known-errors` (**B5**) — it is the longest
   pole for the THO goal and has been open since August.
4. Bump THO to 7.5.0 and rebuild (**B4**) — one focused change, one diff.
5. Close `esc-oid-conflicts` for `0001` (**B3**) and
   `esc-0460-user-defined-mint` (**B2**) — both are submission-blocking in a
   way they are not review-blocking.
6. Decide the five blocked tables are acceptable as-is (**A2**), or chase the
   THO record for `0458`/`0459`.
