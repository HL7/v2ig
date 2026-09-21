# ADR-0012: Presentation Differences, and Publishing THO's Capitalisation

## Status

Accepted

## Date

2026-09-21

## Context

The per-table ledger listed **489 differences from THO** under one heading,
"Differences from THO", each row reading as something a committee might need to
adjudicate. A reviewer working through the page reported the problem plainly:
rows that "amount only to capitalization changes in the display value" were
presented identically to rows where the two sides genuinely say different
things.

Counting them bore that out. Of the 489:

| Count | What it actually is |
|---|---|
| 211 | THO carries the V2 status letter (`N`, `B`) where this guide carries the FHIR status it maps to |
| 76 | The same words styled differently — 44 punctuation, 25 spacing, 7 capitalisation |
| 202 | Genuine disagreements about content |

So **287 of 489 rows were not disagreements at all**, and they were crowding out
the 202 that are.

Two things made this worse than a presentation problem.

**The status ruling already existed and was being applied unevenly.**
`INHERITED_STATUS_CORRECTIONS = {"N": "active"}` has been in `tho_merge.py`
since the merge was written, with a docstring explaining that publishing
`active` for the chapter's `N` and `N` for THO's "would put two readings of the
same letter in one file". But it is reached only by `correct_inherited_status`,
which handles concepts taken *wholesale from THO* — one record in the whole
corpus. The 209 concepts carried by both sides went through generic property
comparison and were reported as unexplained differences. The same fact got two
treatments depending on which code path found it.

**The existing editorial flag did not reach concept level.** `is_editorial()`
detects "same words, different punctuation" and is recorded on resource-level
fields (description, purpose, name) — 14 records. Concept `display`, `definition`
and properties never got it. Since `words()` lowercases, capitalisation
differences would also have been swallowed into "punctuation" had the flag
reached them, losing the distinction that matters most.

## Decision

**1. Classify differences that are not disagreements, at every level.**

`presentation_difference(ours, theirs)` returns `None` for a genuine difference,
or a kind — `case`, `spacing`, `punctuation` — checked most-specific first so a
case-only pair is never reported as punctuation. For `case` it also returns a
`direction`: `tho-added` or `tho-dropped`.

`is_status_letter_reading(ours, theirs)` recognises THO's V2 letter against this
guide's FHIR reading of it, using `STATUS_LETTER_READINGS = {"N": "active",
"B": "deprecated"}`.

These are applied wherever a discrepancy is observed. The ledger lists them in a
separate table, **"Written differently, saying the same thing"**, which states
that nothing in it needs a decision.

**2. Where a concept display differs from THO only in capitalisation, and THO
is the more capitalised side, publish THO's.**

This is an exception to the standing rule that the chapter wins a disagreement
(ADR-0009). It is justified because the words are identical — nothing of the
chapter's content is lost — and because capitalisation is squarely within what
the errata rules permit to change. THO adding capitals to a lower-cased display
is THO having tidied it, and re-lower-casing it on the way through would be this
guide making the artifact worse for no reason.

**3. Where THO is the *less* capitalised side, keep the chapter's and surface
it.**

Not symmetrical, deliberately. `tho-dropped` is ambiguous in a way `tho-added`
is not: the one real instance is THO correctly lower-casing "for" in
*Sex Parameter For Clinical Use*, which is an improvement — but the same
signature would be produced by THO losing a proper noun. Only a person can tell
those apart, so these are shown for review rather than absorbed either way.

## Scope of the carve-out

Narrow on purpose. It applies to `concept.display` only, to `case` only, and to
`tho-added` only. It does **not** apply to:

- **`concept.definition`** — a case difference in a definition is likelier to
  carry meaning, and nothing has ruled on it.
- **Resource `name`** — the one case-only difference here is
  `Hl7VSStateProvince` (ours) against `Hl7VsStateProvince` (THO), where ours is
  arguably the more correct since `VS` abbreviates ValueSet. `name` is
  identity-adjacent and must not be swept along by a rule about display text.
- **Punctuation and spacing** — these are classified as presentation, so they
  stop being presented as questions, but the chapter still wins them. THO is not
  reliably the better side on punctuation the way it is on capitalisation.

## Consequences

**Five concept displays now publish THO's capitalisation** — table 0203 `GKV`,
`KZVA`, `PKV`, `ZANR` and table 0396 `DAR`.

**No version moved.** Counts before and after are identical: 2 first
publications / 58 incremented / 339 unchanged for CodeSystems, 9 / 22 / 393 for
ValueSets. Those two artifacts already differed from THO on other grounds, so
they were already incrementing.

**The ledger's disagreement count falls from 489 to 202** — the other 287 are
still listed, still count as changes for versioning, and still appear on the
page. Only their framing changed.

**Two reporting keys changed.** Discrepancy records gained `presentation`,
`statusLetterReading` and `publishedValue`. The last is *not* called `published`
because identifier records already use that key to name a side (`"tho"`), and
one key with two meanings is unreadable downstream. `Observations._add` now
drops `None` fields rather than storing them, so a classifier that does not
apply leaves no key.

## Alternatives considered

**Leave the classification out and just re-sort the table.** Rejected. Sorting
changes what a reader sees first but not what they conclude; the row still says
"Disagreement" and still looks like a question.

**Treat capitalisation as an ordinary disagreement and escalate the five.**
Rejected as disproportionate. Asking a committee to rule on
`dentist office number` versus `Dentist Office Number` spends the committee's
attention on the thing least worth it, and the errata rules already cover it.

**Apply the carve-out to punctuation and spacing too.** Rejected for now. It
would mean THO wins on any difference we classify as cosmetic, and unlike
capitalisation there is no argument that THO's punctuation is systematically
better. Classification alone gets the reviewer the relief they asked for.

**Widen `INHERITED_STATUS_CORRECTIONS` to include `B`.** Rejected. That table
*rewrites* values; widening it would change published output for concepts taken
wholesale from THO. Recognising `B → deprecated` for classification needs a
separate table, and `STATUS_LETTER_READINGS` is it. A test holds that `B` is in
one and not the other.
