# Segment Field Name Population — Discrepancy Report

Generated: 2026-02-26 23:15:56 UTC

## Summary

- **Segments updated**: 172 of 174 matched segments
- **Total fields updated**: 2718
- **Segments with discrepancies**: 6
- **Segments only in FHIR** (no extracted data): 18
- **Segments only in extracted** (no FHIR resource): 1

## Coverage Gaps

### Segments in FHIR but not in extracted data (18)

These segments have FHIR StructureDefinitions but were not found in the V2.9.1 Word document extraction:

- `BPX`
- `BTX`
- `BUI`
- `CNS`
- `DST`
- `ECD`
- `ECR`
- `EQP`
- `EQU`
- `Hxx`
- `INV`
- `ISD`
- `NDS`
- `SAC`
- `SID`
- `TCC`
- `TCD`
- `Varies`

### Segments in extracted data but not in FHIR (1)

- `ZL7`

## Discrepancies by Segment

### Discrepancy Type Summary

| Type | Segments Affected |
|------|-------------------|
| Field count mismatch | 3 |
| Data type mismatch | 1 |
| Optionality mismatch | 0 |
| Multiple extracted occurrences | 2 |
| Fields in extracted but not FHIR | 0 |
| Fields in FHIR but not extracted | 3 |

### ADD — Addendum

- Field count mismatch: FHIR has 1 fields, extracted has 0 concrete fields + 1 variable-length fields (1-n)
- `ADD.1`: exists in FHIR but NOT in extracted data (field #1)

### OBR — Observation Request

- Multiple occurrences in extracted data (2), all with 55 fields (sources: ['CH04_Orders.docx', 'CH07_Observations.docx'])

### OBX — Observation/Result

- `OBX.5` (Observation Value): data type mismatch — FHIR=`Varies`, extracted=`varies`

### QPD — Query Parameter Definition

- Field count mismatch: FHIR has 3 fields, extracted has 2 concrete fields + 1 variable-length fields (3-n)
- `QPD.3`: exists in FHIR but NOT in extracted data (field #3)

### RDT — Table Row Data

- Field count mismatch: FHIR has 1 fields, extracted has 0 concrete fields + 1 variable-length fields (1-n)
- `RDT.1`: exists in FHIR but NOT in extracted data (field #1)

### RXA — Pharmacy/Treatment Administration

- Multiple occurrences with DIFFERENT field counts: [29, 28] (sources: ['CH04A_Orders.docx', 'CH04A_Orders.docx'])
