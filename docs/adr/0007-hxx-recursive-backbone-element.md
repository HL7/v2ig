# ADR-0007: Recursive BackboneElement Representation for Hxx Open-Ended Placeholder

## Status

Accepted

## Date

2026-04-24

## Context

V2.9.1 §1.12 (Errata) defines the convention for "etc." in segment choices:

> The "etc." is used as a placeholder for various choice alternatives that may
> be represented in the abstract message syntax (AMS). "Etc." should be
> interpreted as meaning any segment can be used in this location; that is,
> "etc." does not limit your choice of segment **or segment groups**, except
> for MSH and other transmission control segments. In the future, explanation
> will be added to Chapter 2, section 12 proposing the use of "Hxx" as a
> formal representation in circumstance where a choice of any segment or
> segment group is allowed.

The standard's three forms of this placeholder — `etc.`, the literal `...`, and
the explicit `Hxx` token — are intended to be equivalent (see Section 9 of the
V2 Management review report). Accordingly, all 11 message structures in CH05
and CH08 that used the literal `...` placeholder were renamed to `Hxx` in a
prior session, joining the 4 CH12 message structures (`PGL_PC6`, `PPG_PCG`,
`PPP_PCB`, `PPR_PC1`) that already used `Hxx`.

The remaining question is *how* to represent `Hxx` in FHIR so that an instance
of a message structure containing this placeholder is meaningful and
validatable — particularly given the §1.12 requirement that the placeholder
permit not only segments but also **segment groups**, and that those groups
may themselves contain mixed sequences of segments and further nested groups.

The previous representation typed `Hxx` as a logical model derived from the
abstract `Segment` base, with no children and no constraints. It served only
as a stand-in label; it carried no structural information about what an `Hxx`
slot may actually contain.

## Decision

Redefine `Hxx` as a **recursive `BackboneElement`-shaped logical model** with
the following structure:

```
Hxx (BackboneElement, 0..*)        ← repeats; each occurrence is one thing
├── segment (0..1, type=Segment)   ← a single segment
├── group   (0..1, contentReference=#Hxx)  ← a recursive nested Hxx
├── inv: exactly one of segment / group is set per occurrence
└── inv: segment is not MSH, BHS, BTS, FHS, FTS, or DSC
```

The `contentReference: "#Hxx"` is FHIR's standard mechanism for recursive
logical-model structures (used by `Questionnaire.item.item`,
`ImplementationGuide.definition.page.page`, `CodeSystem.concept.concept`).
Each `Hxx` occurrence is XOR'd between a single segment slot and a recursive
group slot. The repetition (`max: *`) of `Hxx` itself preserves
**ordering of mixed segment-or-group sequences** — the V2 wire format
requirement.

Consuming message-structure SDs (the 15 sites) continue to reference `Hxx` by
type (`"code": "http://hl7.org/v2/StructureDefinition/Hxx"`) and contribute
their own tailored `short` and `definition` text describing what the slot
means in that particular structure (e.g., "Optional query by example
segments", "One or more HL7 and/or Z-segments carrying the data for the entry
identified in the MFE segment", "etc."). The structural pattern is centralized
in `Hxx.json`; per-site semantics remain at the use site.

`Hxx`'s `baseDefinition` changes from `http://hl7.org/v2/StructureDefinition/Segment`
to `http://hl7.org/fhir/StructureDefinition/Base`, matching `Segment`'s own
parent. `Hxx` is no longer claimed to *be* a segment — it is a sibling
structural pattern. The `meta.profile` reference to `Segment-Profile` is
removed for the same reason.

## Alternatives considered

**Flat `Reference(Segment)` typing.** Type the `Hxx` slot as `Segment`
directly with `max: *`, add an MSH-exclusion invariant. Maps 1:1 to V2 wire
format with no wrapper layer. **Rejected** because it cannot represent the
"or segment groups" half of the §1.12 semantics — there is nowhere in the
structure to hold a nested group.

**Parallel typed slots.** Define two sibling elements at the slot location:
`Hxx-segments (0..*, type=Segment)` and `Hxx-groups (0..*, type=BackboneElement)`,
with an XOR invariant. Avoids the wrapper layer at instance time.
**Rejected** because the parallel-array shape **silently loses the ordering
between segments and groups**. For an interleaved sequence
`[PID, NK1, GroupA, DG1, GroupB]`, the segment array would be `[PID, NK1, DG1]`
and the group array `[GroupA, GroupB]` — there is no way to recover whether
`DG1` came before or after `GroupA`. V2 message order is significant; this
representation cannot faithfully encode it.

**Inline pattern duplicated at each site.** Define the recursive
`BackboneElement` structure inline in each of the 15 consuming SDs rather
than centralizing in `Hxx.json`. Avoids cross-SD `contentReference`
resolution. **Rejected** because it duplicates the same structure 15× and
introduces drift risk; the invariants would have to be repeated in each file.

## Consequences

**Positive.**
- Faithful to V2.9.1 §1.12 semantics, including the segment-group case.
- Preserves ordered mixed sequences via the repeated-`BackboneElement` shape.
- Captures the MSH/transmission-control exclusion as an enforceable
  invariant, not a documentation-only note.
- Centralizes the pattern in one SD; consuming sites change zero lines.
- `contentReference` is FHIR's standard recursion mechanic — well-trodden,
  IG-Publisher-supported.

**Negative.**
- **Wrapper layer at instance time.** A single segment in an `Hxx` slot
  serializes as `{"segment": {...}}`, not as the bare segment object. V2
  ER7-to-FHIR converters must add this wrapper; FHIR-to-ER7 converters must
  flatten it. The wrapper does not exist in the V2 wire format. This is the
  price paid for the segment-or-group distinction; no FHIR mechanism
  represents an order-preserving heterogeneous sequence without it.
- **Hxx is no longer a segment.** Tooling that enumerates "segments" by
  walking the `segments/` directory or filtering on `Segment-Profile`
  conformance will need to either (a) tolerate the renamed Hxx baseDefinition,
  or (b) explicitly skip Hxx. The `v2-segment-status: A` extension still
  appears on consuming SDs' Hxx slot elements; this inconsistency is left in
  place pending a downstream-tooling audit.
- **Invariant FHIRPath expressions are best-effort.** The XOR and
  transmission-control-exclusion invariants are written in FHIRPath but their
  exact form when traversing logical-model abstract types
  (e.g., `segment is MSH`) has not been verified against the IG Publisher
  snapshot generator and validators. Initial expressions are pragmatic
  best-guesses; they will be iterated against build feedback.
- **`contentReference` resolution across SD boundaries** is the standard
  FHIR mechanic but is exercised less often when the referenced SD is
  itself referenced by `type` from another SD. If the IG Publisher fails to
  resolve `#Hxx` correctly when expanding a consuming SD's snapshot, fall
  back to inline duplication (the rejected "inline" alternative above).

**Open follow-ups.**
- Decide whether the existing `{"code": "Hxx"}` entry in the segments
  CodeSystem (`meta-resources/segment--v2-cs-segments.json`) should remain.
  Hxx is no longer a segment by this ADR; the CodeSystem entry is
  arguably stale.
- Decide whether the file path `input/sourceOfTruth/segment/segments/Hxx.json`
  should move out of the `segments/` directory now that Hxx is not a segment.
  Left in place for this ADR to minimize cross-cutting changes; reconsider
  in a follow-up.
- The CH12 `Hxx` uses (in `PGL_PC6`, `PPG_PCG`, `PPP_PCB`, `PPR_PC1`) are
  contextually narrower per V2.9.1 §12.3 ("OBR etc." restricted to the
  "order detail segment" family per §4.2.2.4). This narrowing is not
  enforced by the centralized `Hxx` SD; if needed, it can be added as an
  additional invariant on the consuming SD's Hxx slot, or by introducing a
  per-CH12 narrower placeholder. Deferred — the four CH12 sites currently
  share the same general `Hxx` semantics as the other 11 sites for
  uniformity.

## References

- V2.9.1 §1.12 Errata (the source-of-truth clauses are quoted in
  `v291-extracted/v2mgmt-review-report.md` Section 9).
- V2.9.1 §4.2.2.4 "Order detail segment" — basis for the CH12 contextual
  narrowing.
- V2.9.1 §12.3 — Note binding "OBR etc." to the §4.2.2.4 family in CH12.
- ADR-0006 — Multi-corpus V2.9.1 extraction (the corpus that surfaced the
  literal-`...` placeholder problem).
- Section 16 of `v291-extracted/v2mgmt-review-report.md` — the action log
  for the `...` → `Hxx` unification.
- Section 9 of `v291-extracted/v2mgmt-review-report.md` — the semantic
  discussion that established `etc.` ≡ `...` ≡ `Hxx`.
