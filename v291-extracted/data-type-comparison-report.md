# Data Type Component Comparison: FHIR vs V2.9.1

Generated: 2026-04-14 15:54 UTC

**71** data types compared, **5** with discrepancies, **14** total discrepancies

## Discrepancies by Severity

| Severity | Count |
|----------|-------|
| error | 1 |
| warning | 1 |
| cosmetic | 12 |

## Discrepancies by Dimension

| Dimension | Count |
|-----------|-------|
| component_name | 12 |
| length | 1 |
| data_type | 1 |

## Per-Data-Type Details

### CNN

FHIR components: 11 | V291 components: 11

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |

### MSG

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Message Structure | length | error |  | 3..7 |

### PPN

FHIR components: 26 | V291 components: 26

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |
| 8 | Source Table | data_type | warning | CWE |  |

### XCN

FHIR components: 25 | V291 components: 25

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |

### XPN

FHIR components: 15 | V291 components: 15

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 4 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 5 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 6 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |

## Clean Data Types (66)

`AD`, `AUI`, `CCD`, `CCP`, `CD`, `CF`, `CNE`, `CP`, `CQ`, `CSU`, `CWE`, `CX`, `DDI`, `DIN`, `DLD`
`DLN`, `DLT`, `DR`, `DTN`, `ED`, `EI`, `EIP`, `ERL`, `FC`, `FN`, `HD`, `ICD`, `JCC`, `MA`, `MO`
`MOC`, `MOP`, `NA`, `NDL`, `NR`, `OCD`, `OG`, `OSP`, `PIP`, `PL`, `PLN`, `PRL`, `PT`, `PTA`, `QIP`
`QSC`, `RCD`, `RFR`, `RI`, `RMC`, `RP`, `RPT`, `SAD`, `SCV`, `SN`, `SPD`, `SRT`, `UVC`, `VH`, `VID`
`VR`, `WVI`, `WVS`, `XAD`, `XON`, `XTN`
