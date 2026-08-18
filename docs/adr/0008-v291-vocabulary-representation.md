# ADR-0008: FHIR Representation of the V2.9.1 Chapter 2C Vocabulary

## Status

Proposed — decided in batches. Batch A is open; later batches are listed but
not yet decided. This ADR is updated as each batch is settled, and moves to
Accepted when all batches are closed.

## Date

2026-08-18 (opened)

## Context

Chapter 2C of HL7 V2.9.1 is the standard's code table chapter: 799 sections,
each with up to seven sub-tables (Concept Domain, Code System Identification,
Code System Version, Value Set, Binding, Table Metadata, Coded Content) and
5,540 codes in total. The goal is a FHIR IG that carries this content
faithfully — "exactly what is in the published Chapter 2C" — as CodeSystem and
ValueSet resources, plus a single CodeSystem covering the concept domains.

Two constraints shape everything here.

**Fidelity is the governing requirement.** The only automatic change permitted
is fixing very obvious typographic defects, principally leading and trailing
whitespace. Every divergence from the published value — whether a change that
was made or an irregularity that was deliberately left alone — must be recorded
for human review rather than resolved silently. This is the same principle
ADR-0006 established for the structural chapters, applied to vocabulary.

**Most of this content already exists in THO.** `hl7.terminology.r5` v7.3.0
publishes 418 v2 CodeSystems, 440 v2 ValueSets, and a concept domains
CodeSystem with 1,345 concepts. Re-minting canonical URLs for content THO
already owns would fragment the terminology ecosystem, so canonical URLs are
reused wherever THO has them.

### What is already established

Settled before this ADR was opened, and recorded here because later decisions
depend on them:

- The vocabulary IG is a **separate IG**, not additional resources inside the
  existing structural IG.
- Canonical URLs are **reused from THO** wherever THO publishes an equivalent
  resource. 397 of the 415 code-bearing tables are covered; 18 are not.
- Extraction fidelity is assured by **dual-pipeline cross-validation**
  (python-docx and LLM), per ADR-0006. 739 of 799 tables agree in every
  compared field; the LLM's only systematic infidelities are typographic
  substitution and intermittent truncation at a literal double quote, so
  **python-docx is the character-faithful source** and the LLM provides
  structural corroboration.
- Divergences are tracked through the existing **`review_registry.py`**
  machinery, with the same escalate-to-V2-management path.

## Decisions

### D1 — Concept domains extend THO's CodeSystem rather than replacing it

**Decided 2026-08-18.**

Chapter 2C declares 760 distinct concept domains. THO's
`CodeSystem/conceptdomains` already publishes 582 of them; 177 are absent, and
those are overwhelmingly from concept-domain-only tables.

The generated resource keeps THO's canonical URL
(`http://terminology.hl7.org/CodeSystem/conceptdomains`), carries every THO
concept through unchanged with its hierarchy and properties, and appends the
177 Chapter 2C additions as new top-level concepts marked `source: v2` —
THO's own convention for v2-derived domains. Output: 1,522 concepts.

**Why a superset and not just Chapter 2C's 760.** Publishing a *subset* at
another body's canonical URL would destructively redefine a code system this
project does not own: a server loading both packages would see concepts
disappear. A superset is the only shape that is safe at that URL.

**Why THO's definitions win on conflict.** For the 582 shared domains, 577
definitions match Chapter 2C exactly. Only 5 differ, so deferring to THO costs
almost nothing in fidelity while keeping one coherent code system. All 5 are
recorded for review and can be flipped individually.

**Versioning.** Adding concepts changes the code system, so the major version
increments and minor and patch reset: THO ships 3.0.0, this publishes **4.0.0**.
That is standard terminology versioning practice and needs no special handling.

**Authority.** This is not a coordination risk. The project lead is a UTG
maintainer and a member of the HL7 Terminology Services Management Group, and
has the authority to extend this code system.

**Consequences.**
- The output carries v3- and CDA-sourced concepts that are outside Chapter
  2C's scope. That is inherent to extending rather than forking, and is the
  correct trade against fragmenting the concept domain namespace.
- Downstream consumers resolving `CodeSystem/conceptdomains` will get 4.0.0
  from this IG and 3.0.0 from `hl7.terminology.r5`. Normal version resolution
  handles that; it is worth being deliberate about which the IG pins.
- A CodeSystem **supplement** is *not* an available alternative here.
  Supplements may add properties and designations to an existing code system;
  they may not add concepts. The real alternatives, should the extension ever
  be unwound, are folding the 177 into THO upstream, or a separate code system
  under this project's own canonical.

### D2 — Only obvious typographic defects are corrected automatically

**Decided 2026-08-17.**

Leading and trailing whitespace is stripped; everything else is preserved
exactly as published and merely reported. Internal double spaces (1,052),
embedded newlines (223) and non-breaking spaces (8) are left intact.

**Why.** "Obvious typo" is a narrow licence. Stripping surrounding whitespace
cannot change meaning; collapsing an internal double space inside a display
name changes a published value. The conservative default is reversible — a
reviewer can promote any recorded group to a correction later — whereas silent
normalization is not, because the evidence is gone.

Deviations are grouped by kind and by the field they occur in, so a group of
375 identical double spaces in one field is one decision rather than 375.

**Amended by D3, D4, D5 and D6**, which promote further groups to automatic
corrections. The principle is unchanged: each promotion was a reviewer's
decision, taken group by group from the review report, not a rule the extractor
applied on its own. D6 goes further than the others and edits prose rather than
whitespace; the reasoning for allowing that is set out there.

### D3 — Spaces after a period are collapsed, in descriptive text only

**Decided 2026-08-18.**

In fields carrying descriptive prose — `Description` in all four metadata
blocks, and `definition`, `comment` and `displayName` in coded content — a run
of two or more ordinary spaces immediately following a period is collapsed to a
single space. 890 values changed, 1,089 runs collapsed, across 537 of the 799
tables.

**Why this group and not the others.** D2 left every internal double space
alone because collapsing one inside a display name would change a published
value. The space *after a sentence-ending period* is the one case where that
risk does not arise: double-spacing after a full stop is a typesetting
convention of the era the document was written in, not content, and no reader
or consumer of the resource can distinguish the two renderings. The remaining
228 values are a different question — a double space between two words
mid-sentence, or after a hyphen used as a separator, may well be a defect but
it is not the same defect, and each group is decided on its own.

**Why scoped to descriptive fields.** In an identifier, a code, a URI or a
value set expression, a period is part of the value rather than punctuation.
Restricting the rule to prose keeps it to the case where the reasoning above
actually holds.

**Why only the ordinary space character.** A tab, a newline or a non-breaking
space after a period is a distinct irregularity with its own tracking group.
Folding them in would resolve three questions under the authority of one
decision.

**Consequences.**

- The rule lives in `tooling/scripts/vocabulary_text_policy.py`, not in the
  extractor, because the python-docx-vs-LLM comparison has to apply the same
  policy to both corpuses. Without that, our own deliberate normalization would
  be reported as a disagreement between the pipelines. Cross-pipeline agreement
  is unchanged at 739/799 tables; the 851 values the policy absorbs are counted
  and stated in the comparison report.
- One concept definition in `CodeSystem-conceptdomains.json` changed. The other
  129 changed concept domain descriptions had no effect, because under D1 THO's
  definitions win for the domains THO already publishes.
- Six sentence ends were **not** caught, because a closing quote or bracket sits
  between the period and the spaces (`."  `, `.)  `). **Superseded by D4**,
  which covers them.
- Every change is recorded per value in `vocabulary-deviations.json` under kind
  `double_space_after_period`, so the whole group is reversible.

### D4 — Three further collapses: sentence closers, commas, display names

**Decided 2026-08-18.**

Three groups from the review report were promoted to automatic corrections in
one sitting, because they are variations on the same judgement D3 made.

**Spaces after a sentence that ends in a closing quote or bracket.** D3's rule
required the period to sit immediately before the spaces, so `"levels."  Level
I` and `(e.g., cannulas.)  Dispose` were missed. The closers `"` `'` `’` `”`
`)` `]` are now allowed between the period and the spaces. 6 values. The two
bracket cases are genuine sentence boundaries — the period closes a
parenthetical and the next sentence begins — which is why brackets are included
and not only quote marks.

**Spaces after a comma.** The same reasoning as after a period: the space
following a comma is presentation. 10 values.

**Every repeated space in a code display name.** In `displayName` only, any run
of two or more spaces collapses, wherever it sits. 66 values across 12 tables.

*Why display names and nothing else.* A display name is a short label rather
than prose, so no run of repeated spaces in one can be carrying meaning. That
argument does not extend to a multi-sentence description, where a double space
between two words might be evidence of something a reviewer should see — which
is why the equivalent runs in `Description`, `definition` and `comment` remain
outstanding.

**Consequences.**

- `codedContent.displayName` no longer appears in the outstanding double-space
  group at all. The remaining 143 values are all prose fields.
- Rules run in order, and each change is attributed to the most specific rule
  that fired. Eight display-name values were already resolved by the period,
  sentence-close or comma rules, which is why the display-name sweep reports 66
  rather than 74.

### D5 — A separator dash gets one space on each side; spacing is adjusted, never inserted

**Decided 2026-08-18.**

Where a dash is used as a separator it gets exactly one space on each side. 16
values, 18 places.

The rule **adjusts** the spacing around a dash and never **inserts** space
around a dash that has none on either side.

**Why that constraint is the whole decision.** 1,843 of the 2,516 dashes in
Chapter 2C prose have no space on either side, and essentially all of them are
part of a value rather than punctuation: `HL7-defined` (387 times), `ICD-10`,
`UB-04`, `de-identified`, V2's own field references `OBR-32`, and URL path
segments such as `CFR-2017-title45-vol1`. A rule that put a space around every
dash would corrupt all of them. Restricting the rule to dashes that already
have whitespace on at least one side means it can only ever tidy something that
is already being used as a separator.

Even so, five further exclusions were needed, each drawn from a real pattern in
the chapter, and each expressed structurally rather than as a list of table
numbers:

| Excluded | Example |
|---|---|
| Followed by a digit | `Deep frozen: -16 to -20( C.` — a minus sign |
| Preceded by `+` or `/` | `approximately 22 +/- 2 degrees C` |
| Followed by a conjunction | `OPS Operationen- und Prozedurenschlussel` — a suspended hyphen |
| At the start or end of a line | `Share To Be Determined -⏎Category to be determined` |
| Followed by punctuation | `Default -.will be assumed` |
| `X -y` with a lowercase follower | `Message is not -conformant`, `Emergency -stop` |

The last of these was added after the rule was first run: every genuine
separator in Chapter 2C introduces a capitalised phrase or a digit
(`RSP -Dispense`, `4 -Deprecated`), so a lowercase follower joined to the dash
means the hyphen belongs to that word. Spacing those two out would have made
the published defect worse rather than better.

**Consequences.**

- The dash characters themselves are never changed. An en dash stays an en
  dash, and the four values reading `Results entered -- not verified` keep both
  hyphens; only the surrounding spaces move. Changing a dash run's length or
  character would be a typographic decision, not a whitespace one.
- Three published defects survive into the output unchanged and are recorded in
  the outstanding section of the change log: tables 0357, 0368 and 0919.

### D6 — The missing comma after "e.g." and "i.e." is inserted

**Decided 2026-08-18.**

60 values, 62 places, across 27 tables.

This is the **first rule that adds a character** rather than adjusting
whitespace, which puts it in a different class from D2–D5: those cannot change
what a value says, and this one edits the published prose. It is admitted
because the omission is unambiguous — 172 sites in the same chapter already
carry the comma, so the chapter's own convention decides the question — and it
is kept deliberately narrow to match.

**Scope.** Fires only where the abbreviation is followed by a space. That
excludes the sites that are already correct and the five where a colon
introduces a bullet list (`e.g.:` in tables 0965–0969), where a comma would
produce `e.g.,:`. The capitalised sentence-initial forms `E.g.` and `I.e.` are
included — the same defect — and the replacement keeps whichever case was
published.

**Consequences.**

- Because this rule changes characters rather than spacing, it broke the
  concept domain comparison against THO: 6 domains suddenly differed from THO
  by nothing but a comma we had inserted, inflating
  `definition_differs_from_tho` from 5 to 11. `generate_concept_domains.py` now
  applies the shared policy to THO's text before comparing, the same both-sides
  principle the cross-pipeline comparison uses. Back to 5 genuine differences.
- Every comparison in this project now has to be asked the same question: is
  the other side of the comparison subject to the same policy? Whitespace-only
  rules were forgiving because most comparisons already fold whitespace; a
  character-level rule is not.
- The rule is the natural precedent for any future prose correction, and the
  bar it sets is the one to hold: an unambiguous omission, with the chapter's
  own overwhelming majority usage as the authority.

## Open batches

Worked in dependency order; each is a short session, and each records its
outcome above as a new decision.

### Batch A — Identity: which resources exist, and what are they called

- Which tables get a CodeSystem and/or ValueSet at all. Candidates for
  exclusion: the 384 concept-domain-only tables (covered by D1 instead), and
  the 7 tables whose content is an empty grid in the published document.
- Canonical URL and id scheme for the 18 code-bearing tables THO does not
  cover, and whether ValueSets follow the same rule as CodeSystems.
- Whether ValueSets are generated for every CodeSystem or only where Chapter
  2C declares a Value Set block (438 tables declare one).
- Resource `version`, `status`, `experimental`, publisher and contact defaults.

### Batch B — Concept level: what each code carries

- Mapping of the status column (`D` 222, `N` 70, `B` 5, `R` 3) onto FHIR —
  `inactive`, the standards-status extension, and/or a property preserving the
  published letter verbatim.
- Whether Definition maps to `concept.definition` and Comment to a property,
  and what to do where the published Definition is not a definition (table
  0496 code `028` contains ditto marks).
- Handling of private-use-area symbol characters in published prose (table
  0964 uses `U+F06C` bullets).

### Batch C — Container level: code system and value set metadata

- Code System Version block → `CodeSystem.version` / `.date`, and where "HL7
  Version Introduced" goes.
- The 5 tables declaring more than one Code System block.
- Whether Binding Information (realm) is represented at all.
- Value Set "Content Logical Definition" → `ValueSet.compose`.

### Batch D — The 26 external-content tables

Tables with a real code system identity in Chapter 2C but no printed codes,
because content lives in LOINC, SNOMED, CDC or THO. Options include a
CodeSystem with `content: not-present` plus a ValueSet referencing the external
system, an identity-only stub, or exclusion.

## Consequences

- Decisions accumulate in one ADR rather than four, so the rationale for the
  vocabulary representation is readable in one place.
- Because batches are decided in dependency order, later batches can assume
  earlier ones; but a reversal in Batch A would invalidate work in B–D.
- Every batch's outcome is expressed in generator code plus a divergence log,
  so the ADR and the artifacts stay in step.

## Related

- ADR-0005 — W vs B field policy (precedent for status-code handling in Batch B)
- ADR-0006 — Multi-corpus V2.9.1 extraction (the fidelity method reused here)
- `v291-extracted/vocabulary-review-report.html` — the review catalog
- `v291-extracted/vocabulary-changelog.md` — every change made to the published
  text, with its scope and where it took effect, plus what is still outstanding
- `tooling/scripts/vocabulary_text_policy.py` — D2 and D3 as code
- `v291-fhir/conceptdomains-divergences.json` — D1's divergence log
