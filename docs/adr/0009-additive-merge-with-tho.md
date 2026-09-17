# ADR-0009: Additive Merge with THO, and Version Numbers Computed from the Policy

## Status

Accepted

## Date

2026-09-17

## Context

This guide publishes its CodeSystems and ValueSets at THO's own canonical
URLs — `http://terminology.hl7.org/CodeSystem/v2-0001` and its 800-odd
siblings. That was settled early and is not in question here: a canonical URL
is an identifier, THO already owns these, and inventing parallel ones would
create two artifacts claiming to be the same thing.

What had not been thought through is the consequence. Publishing at a
canonical says *this is that artifact*. It does not say *this is our version of
that artifact*. So anything THO carries that our output leaves out is not a gap
in a draft — it is content deleted from the artifact that URL names, and
deleted for everyone who resolves the canonical.

A full comparison against the local snapshot of `hl7.terminology.r5` 7.3.0 on
2026-09-17 found how much that was:

| Content in THO, absent from our output | Count |
|---|---|
| Concept definitions | 4,855 |
| Concept properties (`v2-concCommentAsPub`, `HL7usageNotes`, `v2-table-deprecated`) | 1,438 |
| Concept designations (translations) | 1,061 |
| Codes, across 37 tables | 211 |
| Resource descriptions, names, titles | 7 |
| Identifiers (OIDs) | 1 |

The definitions dominate, and their cause is worth stating precisely, because
it is a good rule producing a bad outcome. The text policy forbids inventing a
`definition` by copying a `display`. That is right — a definition asserted by
a pipeline is worse than no definition. But Chapter 2C has no definition column
at all, so "the chapter does not supply one" was being read as "there is none",
and text THO's editors had actually written was dropped on the way through.

This is the same hazard that made `conceptdomains` a superset rather than a
replacement, at roughly forty times the scale.

**The second half of the problem is versioning.** The TSMG artifact versioning
policy makes every qualifying change a major increment in `n.0.0` form. Before
this change, 383 of 396 shared code systems differed from THO and would each
have had to increment — overwhelmingly *because of the dropping*. Version
numbers were also being inherited from a UTG checkout and carried through
unexamined, so the number an artifact published bore no computed relationship
to whether it had changed.

The two problems are one problem. Most of the increments were the cost of the
deletions.

## Decision

### 1. The merge is additive

**Where THO has content and Chapter 2C has no opinion, THO's content
survives.** Where both carry a value and they differ, the chapter's is
published — this guide exists to publish the chapter — and the disagreement is
recorded rather than absorbed.

This applies to everything THO carries, not to a named list of elements. The
argument for keeping a definition is the argument for keeping a translation, a
usage note or an OID: all of them are content at a canonical we do not own.

Four kinds of observation are recorded, one record per instance:

| Kind | Meaning | Version effect |
|---|---|---|
| **fill** | THO had it, the chapter did not, THO's survives | none — the artifact now matches THO |
| **discrepancy** | Both had it and they differ; the chapter's is published | increments |
| **addition** | The chapter has it, THO does not | increments |
| **omission** | THO publishes an artifact this guide does not | none — nothing is destroyed |

**A "placeholder" on either side counts as no opinion.** Chapter 2C writes
`tbd`, `noObject`, `noDescription` and `-` where nothing has been written yet;
THO defines all five of table 0560's concepts as `"no definition"`. Neither is
content, and neither is published over the other. `None` is deliberately *not*
in that set: seven THO concepts have the display `None` and the definition
`None`, where None is the answer rather than the absence of one.

**The merge never creates an artifact.** Twenty-one tables have a THO
CodeSystem and nothing in this guide, because they are concept-domain-only or
awaiting a decision. Publishing nothing at a canonical destroys nothing —
THO's artifact stands untouched — so these are reported as omissions and left
alone.

**The merge never splices prose.** Where both descriptions exist and say
different things, the chapter's is published whole. Concatenating two
descriptions would publish text that neither source wrote.

**The merge never crosses a value set's compose shape.** Codes THO enumerates
are added to an include that also enumerates, over the same system. An "all
codes" include and an enumeration do not mean the same thing, and merging
across that difference would change what the value set says rather than
complete it.

### 2. Version numbers are computed from the policy, every run

The TSMG element tables for CodeSystem and ValueSet are transcribed into
`tooling/scripts/tho_versioning_policy.py`, and the version is derived on each
run by comparing the merged artifact against THO's:

- **No qualifying difference → THO's version, unchanged.**
- **Any qualifying difference → the major version, incremented, with minor and
  patch at zero.** The policy has no smaller step.
- **No THO artifact → `1.0.0`.**
- **A difference the policy places outside the version system** — a changed
  `url`, `id`, `content`, or a changed or removed `identifier` — is reported
  as needing a *new artifact*, not converted into an increment.

Three comparison rules are judgement calls rather than readings of the policy,
and each is stated on the guide's **General questions** page with what rides on
it:

- **Whitespace is never a difference.** 358 of 396 descriptions differed from
  THO's only in line wrapping.
- **Concept order is never a difference.** Concepts are compared as a set keyed
  by code. 32 tables carry exactly THO's codes in a different order.
- **A punctuation-only difference in a `description` does not increment.** The
  policy's own carve-out is *"Major unless only change is improved clarity or
  perform editorial corrections"*; where two texts contain the same words in
  the same order, nothing but punctuation moved. This is applied to
  `ValueSet.description` as well, even though only the CodeSystem page carries
  the carve-out, because the omission is believed to be a drafting slip and
  encoding the asymmetry would bake in a mistake.

The waiver is **not** extended to concept definitions or displays, where the
policy offers no carve-out — an asymmetry that leaves 25 concept-level
punctuation differences incrementing, and which is question 3 on the General
questions page.

### 3. What this produced

| | Keeps THO's version | Increments | New at 1.0.0 |
|---|---:|---:|---:|
| CodeSystems | 344 | 53 | 2 |
| ValueSets | 398 | 16 | 9 |

Against 383 of 396 code systems that would have incremented before.

Two artifacts carry a change no version can express, both OID conflicts
between Chapter 2C and THO: `CodeSystem/v2-0001` and `ValueSet/v2-0719`.

### 4. Everything is recorded

`v291-fhir/tho-fill-report.json` carries every observation individually, with
table, code, element and the values on both sides. The IG page
**What this guide keeps from THO** (`tho-merge.html`) summarises it by class,
which is what a reviewer can actually read; the per-table ledger will carry the
per-table view.

## Alternatives considered

**Keep dropping, and accept the version increments.** Rejected. The increments
were the smaller half of the problem: the larger half is that 4,855 pieces of
text written by THO's editors would stop being published at the URLs that name
them. A version number at least announces a change; a silent deletion does not.

**Merge only definitions, displays and concepts** — the three elements named
when the stance was first agreed. Rejected on review: the argument does not
distinguish them from designations, properties or identifiers, and stopping at
three would have left 2,500 further deletions in place with no principle
separating them from the ones being fixed.

**Fork to our own canonicals and leave THO's artifacts alone.** Rejected.
It would make the deletion question disappear by creating a worse one — two
canonicals for each table, and no statement about which an implementer should
resolve.

**Take THO's value wherever the two differ.** Rejected. This guide's purpose is
to publish Chapter 2C. A pipeline that silently prefers THO would produce a
copy of THO, and the disagreements — which are the most interesting output of
the whole comparison — would vanish.

**Hand-apply version numbers.** Rejected. Hand-applied numbers are wrong the
first time the content changes and nobody re-checks them. Computing them from
a transcribed policy means the numbers are re-derived on every run and the
policy is visible in one file.

**Parse the policy PDFs at build time.** Rejected. They are Confluence exports
that are not checked in — a parser would produce a build that only works on one
machine. The transcription can be read and checked against the page by any
reviewer, which a column-position heuristic cannot.

## Consequences

**Good.**

- Nothing THO publishes is deleted by this guide any more.
- 742 of 822 artifacts now keep the version THO already published, so a
  reviewer's diff shows content changes rather than version churn.
- Version numbers are reproducible: delete them all and re-run, and the same
  numbers come back.
- The two OID conflicts surfaced as a computed result rather than as a
  hand-maintained note, and they are the only two of their kind in the corpus.
- Every judgement call is in one of two named functions, so reversing one after
  a TSMG ruling is a small, located change.

**Bad, or at least costly.**

- Our output is no longer a pure rendering of Chapter 2C. It is the chapter
  merged with THO, and a reader has to be told that — which is what the
  `tho-merge.html` page is for.
- The 1,061 inherited designations cannot be validated without a working
  terminology server, and `tx.fhir.org` currently fails on every request. That
  added 3,267 validation errors to the build, suppressed via
  `vocab-ig/input/ignoreWarnings.txt` with the reasoning recorded there.
- `tho-fill-report.json` is 1.8 MB and is rewritten on every run.
- The merge depends on a local snapshot of one THO release. When the snapshot
  is refreshed, versions and observations both move, and the move needs
  reviewing rather than accepting.

## Related

- **ADR-0008** — the FHIR representation of the Chapter 2C vocabulary, which
  this extends. The section on tables with an empty grid is amended by
  ADR-0010 for table 0560.
- **ADR-0010** — table 0560, decided alongside this and separately.
- `tooling/scripts/tho_merge.py`, `tooling/scripts/tho_versioning_policy.py`
- THO Artifact Versioning Policy: HL7 Code Systems —
  confluence.hl7.org/spaces/TSMG/pages/134947510
- THO Artifact Versioning Policy: HL7 Value Sets —
  confluence.hl7.org/spaces/TSMG/pages/139669900
