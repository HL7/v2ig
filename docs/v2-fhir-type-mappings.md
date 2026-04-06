# V2-to-FHIR Data Type Mappings

All V2 data types are represented as FHIR R5 StructureDefinitions.

## Mapping Strategy

- **Primitive types** → FHIR `primitive-type` kind (string-based)
- **Complex types** → FHIR `logical` kind with component elements
- Base definition: `http://hl7.org/v2/StructureDefinition/ComplexDataType`
- Components use dot notation: `CWE.1`, `CWE.2`, etc.
- Component types reference other V2 types via full URL

## Primitive Types (12)

| V2 Code | Title |
|---------|-------|
| DT | HL7 v2 DT Data Type |
| DTM | HL7 v2 DTM Data Type |
| FT | HL7 v2 FT Data Type |
| GTS | HL7 v2 GTS Data Type |
| ID | HL7 v2 ID Data Type |
| IS | HL7 v2 IS Data Type |
| NM | HL7 v2 Numeric Primitive Type |
| SI | HL7 v2 SI Primtive Type |
| SNM | HL7 v2 SNM Data Type |
| ST | HL7 v2 String Primitive Type |
| TM | HL7 v2 TM Data Type |
| TX | HL7 v2 TX Data Type |

## Complex Types (71)

| V2 Code | Components | Title |
|---------|------------|-------|
| AD | 8 | HL7 v2 AD Data Type |
| AUI | 3 | HL7 v2 AUI Data Type |
| CCD | 2 | HL7 v2 CCD Data Type |
| CCP | 3 | HL7 v2 CCP Data Type |
| CD | 6 | HL7 v2 CD Data Type |
| CF | 22 | HL7 v2 CF Data Type |
| CNE | 22 | HL7 v2 CNE Data Type |
| CNN | 11 | HL7 v2 CNN Data Type |
| CP | 6 | HL7 v2 CP Data Type |
| CQ | 2 | HL7 v2 CQ Data Type |
| CSU | 23 | HL7 v2 CSU Data Type |
| CWE | 22 | HL7 v2 CWE Data Type |
| CX | 12 | HL7 v2 CX Data Type |
| DDI | 3 | HL7 v2 DDI Data Type |
| DIN | 2 | HL7 v2 DIN Data Type |
| DLD | 2 | HL7 v2 DLD Data Type |
| DLN | 3 | HL7 v2 DLN Data Type |
| DLT | 4 | HL7 v2 DLT Data Type |
| DR | 2 | HL7 v2 DR Data Type |
| DTN | 2 | HL7 v2 DTN Data Type |
| ED | 5 | HL7 v2 ED Data Type |
| EI | 4 | HL7 v2 EI Data Type |
| EIP | 2 | HL7 v2 EIP Data Type |
| ERL | 6 | HL7 v2 ERL Data Type |
| FC | 2 | HL7 v2 FC Data Type |
| FN | 5 | HL7 v2 FN Data Type |
| HD | 3 | HL7 v2 HD Data Type |
| ICD | 3 | HL7 v2 ICD Data Type |
| JCC | 3 | HL7 v2 JCC Data Type |
| MA | 4 | HL7 v2 MA Data Type |
| MO | 2 | HL7 v2 MO Data Type |
| MOC | 2 | HL7 v2 MOC Data Type |
| MOP | 3 | HL7 v2 MOP Data Type |
| MSG | 3 | HL7 v2 MSG Data Type |
| NA | 4 | HL7 v2 NA Data Type |
| NDL | 11 | HL7 v2 NDL Data Type |
| NR | 2 | HL7 v2 NR Data Type |
| OCD | 2 | HL7 v2 OCD Data Type |
| OG | 4 | HL7 v2 OG Data Type |
| OSP | 3 | HL7 v2 OSP Data Type |
| PIP | 5 | HL7 v2 PIP Data Type |
| PL | 11 | HL7 v2 PL Data Type |
| PLN | 4 | HL7 v2 PLN Data Type |
| PPN | 26 | HL7 v2 PPN Data Type |
| PRL | 3 | HL7 v2 PRL Data Type |
| PT | 2 | HL7 v2 PT Data Type |
| PTA | 4 | HL7 v2 PTA Data Type |
| QIP | 2 | HL7 v2 QIP Data Type |
| QSC | 4 | HL7 v2 QSC Data Type |
| RCD | 3 | HL7 v2 RCD Data Type |
| RFR | 7 | HL7 v2 RFR Data Type |
| RI | 2 | HL7 v2 RI Data Type |
| RMC | 4 | HL7 v2 RMC Data Type |
| RP | 4 | HL7 v2 RP Data Type |
| RPT | 11 | HL7 v2 RPT Data Type |
| SAD | 3 | HL7 v2 SAD Data Type |
| SCV | 2 | HL7 v2 SCV Data Type |
| SN | 4 | HL7 v2 SN Data Type |
| SPD | 4 | HL7 v2 SPD Data Type |
| SRT | 2 | HL7 v2 SRT Data Type |
| UVC | 4 | HL7 v2 UVC Data Type |
| VH | 4 | HL7 v2 VH Data Type |
| VID | 3 | HL7 v2 VID Data Type |
| VR | 2 | HL7 v2 VR Data Type |
| WVI | 2 | HL7 v2 WVI Data Type |
| WVS | 2 | HL7 v2 WVS Data Type |
| XAD | 23 | HL7 v2 XAD Data Type |
| XCN | 25 | HL7 v2 XCN Data Type |
| XON | 10 | HL7 v2 XON Data Type |
| XPN | 15 | HL7 v2 XPN Data Type |
| XTN | 18 | HL7 v2 XTN Data Type |

## Key Design Decisions

- No non-obvious mapping decisions — V2 types map 1:1 to FHIR logical models
- The `"defintion"` typo in component elements is preserved for compatibility (see JOURNAL.md Session 2)
- All 83 types (12 primitive + 71 complex) have corresponding FHIR StructureDefinitions
- All type references from segment fields and data type components resolve correctly
