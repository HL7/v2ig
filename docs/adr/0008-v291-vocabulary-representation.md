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
- `v291-fhir/conceptdomains-divergences.json` — D1's divergence log
