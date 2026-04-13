# ADR-0005: Elide Data Types from Withdrawn (W) Segment Fields

## Status

Accepted

## Date

2026-04-13

## Context

V2.9.1 has two categories of deprecated fields:

- **W (Withdrawn)**: Removed from the standard, should not be used.
- **B (Backward Compatible)**: Deprecated but still usable for legacy compatibility.

Of 104 W fields across all segments, 98 have no data type in V2.9.1 (the type was removed when the field was withdrawn). However, 6 W fields still retain their data type:

| Segment | Seq | Field Name | Data Type | Source |
|---------|-----|------------|-----------|--------|
| NK1 | 5 | Phone Number | XTN | CH03_PatientAdmin.docx |
| NK1 | 6 | Business Phone Number | XTN | CH03_PatientAdmin.docx |
| NK1 | 31 | Contact Person's Telephone Number | XTN | CH03_PatientAdmin.docx |
| PID | 13 | Phone Number - Home | XTN | CH03_PatientAdmin.docx |
| PID | 14 | Phone Number - Business | XTN | CH03_PatientAdmin.docx |
| UB1 | 1 | Set ID - UB1 | SI | CH06_FinancialMngmt.docx |

All 36 B fields retain their data types (consistent with their "still usable" semantics).

## Decision

1. **Elide data types from the 6 W fields that have them**, removing the `type` array from their FHIR element definitions. This allows all W fields to be treated uniformly.

2. **B fields retain their data types** — they are deprecated, not removed, and must remain usable.

3. **Apply the `structuredefinition-standards-status` extension** to all W and B elements:
   - W fields: `"valueCode": "withdrawn"`
   - B fields: `"valueCode": "deprecated"`

4. **Cardinality treatment**:
   - W fields: `max: "0"` (prohibited, consistent with withdrawal)
   - B fields: preserve original cardinality from V2.9.1 (e.g., `max: "*"` if repeating)

5. **Rendering**:
   - W fields: strikethrough styling
   - B fields: no strikethrough (they are deprecated, not removed)

## Consequences

- Recovering the original data types for the 6 elided W fields would require consulting prior versions of the V2 standard. This is feasible but deferred.
- The `standards-status` extension enables future tooling to programmatically distinguish W from B fields.
- B fields will appear in the HL7 Attribute Table without strikethrough, visually indicating they are still available for backward compatibility.
