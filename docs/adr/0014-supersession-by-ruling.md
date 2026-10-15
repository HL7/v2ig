# ADR-0014: Supersession by Ruling — Retiring a Published Artifact and Pointing at Its Replacement

## Status

Accepted

## Date

2026-10-15

## Context

On 2026-10-15 V2 Management ruled on four tables whose value sets duplicate
value sets that already exist. Two different situations came out of one
ruling, and the difference between them is what this ADR is about.

For **0954**, **0957** and **0960** the guide was about to create a duplicate
and had not yet done so. Those are suppressions under ADR-0013: not writing
the artifact leaves nothing behind, and the question is closed.

For **0719**, **0952** and **0959** the duplicate **already exists in THO**.
Withholding them achieves nothing of what the ruling wants. THO would go on
publishing `ValueSet/v2-0952` and `ValueSet/v2-0959` as active 3.0.0
artifacts; all that would change is that this guide would stop saying
anything about them. An implementer who found one would have no way to learn
it was superseded. **Suppression is a mechanism available only before first
publication.**

The ruling was explicit about the alternative: keep the v2 value set, retire
it, and put a note at the top of its description naming the correct value set
with a link that will keep resolving in future versions of THO.

### What this uncovered about 0719

`ValueSet/v2-0719` is **already retired in THO**, and this guide was writing
it back out as `active`. It was the only artifact in the corpus where our
status disagreed with THO's, and the disagreement ran in the most damaging
direction available: un-retiring something a terminology authority had
retired.

The cause is structural rather than specific to 0719. `status` sits in
`COMPARED_VALUE_SET_FIELDS` and not in `FILLABLE_VALUE_SET_FIELDS`, so a
difference against THO is *reported* and *bumps the version* — the 4.0.0
increment on this artifact names `status` among its triggers — but never
*fills*. Everywhere else that is correct: the chapter is the authority on
content, and THO should not overwrite it. For a retirement it is wrong,
because retirement is a statement about the artifact's standing rather than
about its content, and the chapter has no view on standing at all.

`add_common_metadata` compounded it by hard-coding `DEFAULT_STATUS`, so even
a status settled in the plan could not reach the XML. The field was
unreachable by any route.

## Decision

Add a fourth ruling-driven mechanism, `RULED_SUPERSESSIONS`, in
`write_utg_xml.py`. An entry names a table and carries the canonical of the
value set that replaces it, the name to use in prose, the ruling, the
register item carrying the resolution, and the evidence.

A superseded table is still published. Two things change:

* `status` is set to `retired`
* the description is prefixed with a markdown note naming the replacement and
  linking to it

The note is markdown because the IG Publisher renders descriptions as
markdown — the same mechanism the 0133 emphasis ruling uses.

`add_common_metadata` takes `status` as a parameter defaulting to
`DEFAULT_STATUS`. Nothing but a supersession passes it.

### Invariants, all enforced by tests

1. **Every entry names a register item with a `resolution`.** The same
   invariant as suppression and reclassification, for a stronger reason:
   retiring a published artifact is the heaviest act this guide takes.
2. **Every `replacement_url` is version-less.** A pointer that names the
   right value set through `terminology.hl7.org/7.4.0/en/...` rots at the
   next release, which is the exact failure the note exists to prevent. The
   test refuses a URL containing a version segment and refuses a rendered
   `.html` page URL.
3. **The four mechanisms are disjoint.** A table cannot be awaiting a ruling,
   withheld by one, republished by one and retired by one at once.
4. **An ordinary value set is still `active`.** The complement of the
   mechanism: making status settable must not let it drift.

## Why not the existing three

| Mechanism | Why not |
|---|---|
| `TENTATIVE_OVERRIDES` (ADR-0011) | Deviates *while awaiting* a ruling; its entries must name an **open** item and their count is published as un-ruled deviation debt. These are answered. |
| `RULED_SUPPRESSIONS` (ADR-0013) | Removes output. Here the output must stay — it is the only surface on which the supersession can be announced. |
| `RULED_RECLASSIFICATIONS` | Changes *what* is published by restating the classification. Here the classification is right; what changes is the artifact's standing. |

The distinction between suppression and supersession is the one most likely
to be got wrong later, because both say "do not use this". They act on
opposite situations: suppression prevents a first publication, supersession
responds to one that already happened.

## Consequences

**Three artifacts change.** `v2-0719` is corrected from `active` to
`retired`, which fixes a live defect. `v2-0952` and `v2-0959` move from
`active` to `retired`, which is a heavier act — these are live THO artifacts
and the ruling retires them.

**`status` is now writable, and that is a risk worth naming.** The field was
previously constant. A test asserts every non-superseded artifact is still
`active`, which is what keeps a parameter from becoming a drift surface.

**The version-less invariant will be inconvenient at some point.** A reviewer
citing a value set will naturally paste the versioned URL from their browser,
as happened in the ruling this ADR implements. The test will refuse it, and
the right response is to convert it to the canonical rather than relax the
test.

**A superseded value set still counts as published.** It appears in the
artifact count and in the ledger, routed `superseded-by-ruling`. A reader
counting live value sets must read the route, which is why the route exists
rather than reusing `value-set-only`.

## Alternatives considered

**Set `status` from THO by moving it to `FILLABLE_VALUE_SET_FIELDS`.** This
would have fixed 0719 and nothing else — THO has 0952 and 0959 active, so
filling from THO would keep them active. It also makes THO the authority on
every artifact's standing, which is a much larger change than any ruling
asked for, taken on one table's evidence.

**Use `relatedArtifact` with `type = successor` instead of description
prose.** Structurally the right FHIR shape, and rejected for now because
`esc-0567-0568-representation` records that nothing in THO has ever done this
for a v2 value set, and the representation question is itself unresolved. The
ruling asked for description text and a link; doing more would be inventing a
convention mid-ruling. Worth revisiting when that representation question is
settled.

**Leave the v2 artifacts alone and record the supersession only in the
register.** This is what the guide did before, and it is what the ruling
rejected: the register is not read by anyone consuming the terminology.
ADR-0011 already establishes that recording a resolution in the register
changes no output.
