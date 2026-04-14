# Data Type Component Comparison: FHIR vs V2.9.1

Generated: 2026-04-14 14:12 UTC

**71** data types compared, **31** with discrepancies, **95** total discrepancies

## Discrepancies by Severity

| Severity | Count |
|----------|-------|
| error | 82 |
| warning | 1 |
| cosmetic | 12 |

## Discrepancies by Dimension

| Dimension | Count |
|-----------|-------|
| conf_length | 81 |
| component_name | 12 |
| length | 1 |
| data_type | 1 |

## Per-Data-Type Details

### AD

FHIR components: 8 | V291 components: 8

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Street Address | conf_length | error | 120# | 120= |
| 2 | Other Designation | conf_length | error | 120# | 120= |
| 3 | City | conf_length | error | 50# | 50= |
| 4 | State or Province | conf_length | error | 50# | 50= |
| 8 | Other Geographic Designation | conf_length | error | 50# | 50= |

### AUI

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Source | conf_length | error | 199# | 199= |

### CCP

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Channel Calibration Sensitivity Correction Factor | conf_length | error | 6# | 6= |
| 2 | Channel Calibration Baseline | conf_length | error | 6# | 6= |
| 3 | Channel Calibration Time Skew | conf_length | error | 6# | 6= |

### CD

FHIR components: 6 | V291 components: 6

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 5 | Channel Sampling Frequency | conf_length | error | 6# | 6= |

### CF

FHIR components: 22 | V291 components: 22

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 9 | Original Text | conf_length | error | 199# | 199= |

### CNE

FHIR components: 22 | V291 components: 22

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Text | conf_length | error | 199# | 199= |
| 5 | Alternate Text | conf_length | error | 199# | 199= |
| 9 | Original Text | conf_length | error | 199# | 199= |
| 11 | Second Alternate Text | conf_length | error | 199# | 199= |

### CNN

FHIR components: 11 | V291 components: 11

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Family Name | conf_length | error | 50# | 50= |
| 3 | Given Name | conf_length | error | 30# | 30= |
| 4 | Second and Further Given Names or Initials Thereof | conf_length | error | 30# | 30= |
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 5 | Suffix | conf_length | error | 20# | 20= |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 6 | Prefix | conf_length | error | 20# | 20= |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |

### CP

FHIR components: 6 | V291 components: 6

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | From Value | conf_length | error | = |  |
| 4 | To Value | conf_length | error | = |  |

### CSU

FHIR components: 23 | V291 components: 23

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Unit of Measure Description | conf_length | error | 199# | 199= |
| 6 | Alternate Unit of Measure Description | conf_length | error | 199# | 199= |
| 10 | Original Text | conf_length | error | 199# | 199= |
| 12 | Second Alternate Unit of Measure Text | conf_length | error | 199# | 199= |

### CWE

FHIR components: 22 | V291 components: 22

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Text | conf_length | error | 199# | 199= |
| 5 | Alternate Text | conf_length | error | 199# | 199= |
| 9 | Original Text | conf_length | error | 199# | 199= |
| 11 | Second Alternate Text | conf_length | error | 199# | 199= |

### DLT

FHIR components: 4 | V291 components: 4

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Numeric Threshold | conf_length | error | 4# | 4= |
| 4 | Days Retained | conf_length | error | 4# | 4= |

### DTN

FHIR components: 2 | V291 components: 2

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Number of Days | conf_length | error | 3# | 3= |

### ERL

FHIR components: 6 | V291 components: 6

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Segment ID | conf_length | error | = |  |
| 2 | Segment Sequence | conf_length | error | = |  |
| 3 | Field Position | conf_length | error | = |  |
| 4 | Field Repetition | conf_length | error | = |  |
| 5 | Component Number | conf_length | error | = |  |
| 6 | Sub-Component Number | conf_length | error | = |  |

### FN

FHIR components: 5 | V291 components: 5

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Surname | conf_length | error | 50# | 50= |
| 2 | Own Surname Prefix | conf_length | error | 20# | 20= |
| 3 | Own Surname | conf_length | error | 50# | 50= |
| 4 | Surname Prefix from Partner/Spouse | conf_length | error | 20# | 20= |
| 5 | Surname from Partner/Spouse | conf_length | error | 50# | 50= |

### MO

FHIR components: 2 | V291 components: 2

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Quantity | conf_length | error | = |  |

### MOP

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Money or Percentage Quantity | conf_length | error | = |  |

### MSG

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Message Structure | length | error |  | 3..7 |

### PL

FHIR components: 11 | V291 components: 11

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 9 | Location Description | conf_length | error | 199# | 199= |

### PLN

FHIR components: 4 | V291 components: 4

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | State/other Qualifying Information | conf_length | error | 62# | 62= |

### PPN

FHIR components: 26 | V291 components: 26

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Given Name | conf_length | error | 30# | 30= |
| 4 | Second and Further Given Names or Initials Thereof | conf_length | error | 30# | 30= |
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 5 | Suffix | conf_length | error | 20# | 20= |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 6 | Prefix | conf_length | error | 20# | 20= |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |
| 8 | Source Table | data_type | warning | CWE |  |
| 22 | Professional Suffix | conf_length | error | 199# | 199= |

### QIP

FHIR components: 2 | V291 components: 2

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Values | conf_length | error | 199# | 199= |

### QSC

FHIR components: 4 | V291 components: 4

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Value | conf_length | error | 199# | 199= |

### RI

FHIR components: 2 | V291 components: 2

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Explicit Time Interval | conf_length | error | 199# | 199= |

### RP

FHIR components: 4 | V291 components: 4

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Pointer | conf_length | error | 999# | 999= |

### SAD

FHIR components: 3 | V291 components: 3

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Street or Mailing Address | conf_length | error | 120# | 120= |
| 2 | Street Name | conf_length | error | 50# | 50= |
| 3 | Dwelling Number | conf_length | error | 12# | 12= |

### WVI

FHIR components: 2 | V291 components: 2

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Channel Name | conf_length | error | 17# | 17= |

### XAD

FHIR components: 23 | V291 components: 23

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Other Designation | conf_length | error | 120# | 120= |
| 3 | City | conf_length | error | 50# | 50= |
| 4 | State or Province | conf_length | error | 50# | 50= |
| 8 | Other Geographic Designation | conf_length | error | 50# | 50= |
| 19 | Addressee | conf_length | error | 199# | 199= |
| 20 | Comment | conf_length | error | 199# | 199= |

### XCN

FHIR components: 25 | V291 components: 25

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 3 | Given Name | conf_length | error | 30# | 30= |
| 4 | Second and Further Given Names or Initials Thereof | conf_length | error | 30# | 30= |
| 5 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 5 | Suffix | conf_length | error | 20# | 20= |
| 6 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 6 | Prefix | conf_length | error | 20# | 20= |
| 7 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |
| 21 | Professional Suffix | conf_length | error | 199# | 199= |

### XON

FHIR components: 10 | V291 components: 10

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 1 | Organization Name | conf_length | error | 50# | 50= |

### XPN

FHIR components: 15 | V291 components: 15

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 2 | Given Name | conf_length | error | 30# | 30= |
| 3 | Second and Further Given Names or Initials Thereof | conf_length | error | 30# | 30= |
| 4 | Suffix | component_name | cosmetic | Suffix (e.g., JR or III) | Suffix |
| 4 | Suffix | conf_length | error | 20# | 20= |
| 5 | Prefix | component_name | cosmetic | Prefix (e.g., DR) | Prefix |
| 5 | Prefix | conf_length | error | 20# | 20= |
| 6 | Degree | component_name | cosmetic | Degree (e.g., MD) | Degree |
| 14 | Professional Suffix | conf_length | error | 199# | 199= |
| 15 | Called By | conf_length | error | 30# | 30= |

### XTN

FHIR components: 18 | V291 components: 18

| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |
|-----|-----------|-----------|----------|-----------------|---------------|
| 9 | Any Text | conf_length | error | 199# | 199= |
| 12 | Unformatted Telephone Number | conf_length | error | 199# | 199= |

## Clean Data Types (40)

`CCD`, `CQ`, `CX`, `DDI`, `DIN`, `DLD`, `DLN`, `DR`, `ED`, `EI`, `EIP`, `FC`, `HD`, `ICD`, `JCC`
`MA`, `MOC`, `NA`, `NDL`, `NR`, `OCD`, `OG`, `OSP`, `PIP`, `PRL`, `PT`, `PTA`, `RCD`, `RFR`, `RMC`
`RPT`, `SCV`, `SN`, `SPD`, `SRT`, `UVC`, `VH`, `VID`, `VR`, `WVS`
