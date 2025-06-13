Logical: ORG
Parent: $Segment
Id: ORG
Title: "HL7 v2 ORG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Practitioner Organization Unit"
* 1 1..1 SI "ORG-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1459
* 2 0..1 CWE "ORG-2" "This field contains the hierarchical components of the organization unit, as defined by the institution. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70405[_User-defined Table 0405 - Organization Unit_] for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0405 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1460
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL700405[_User-defined Table 0405 – Organization Unit_] in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 3 0..1 CWE "ORG-3" "This field contains a code indicating the classification of the organization unit. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70474[_User-defined Table 0474 - Organization Unit Type_]."
* 3 from http://terminology.hl7.org/ValueSet/v2-0474 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1625
* 3 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70474[_User-defined Table 0474 – Organization Unit Type_] in Chapter 2C, Code Tables, for valid values. This table contains values for department, facility etc."
* 4 0..1 ID "ORG-4" "This field contains an indicator for whether this organization unit is the primary organization unit for this practitioner. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1462
* 4 ^comment = "Y this is the primary organization unit\n\nN this is not the primary organization unit"
* 5 0..1 CX "ORG-5" "This field contains an identification code used by the institution to identify this person at this specific organization unit. If the person is identified with the same code at all organization units, then this data should be coded in _STF-2 Staff ID Codes_."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1463
* 6 0..1 CWE "ORG-6" "This field contains the major grouping of the service or occupation of the practitioner at a specific organization unit, for example, Behavioral Health & Social Service. HL7 suggests using values derived from the ANSI ASC X12 Health Care Provider Taxonomy, Level 1 - Type."
* 6 from http://terminology.hl7.org/ValueSet/v2-0452 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1464
* 6 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70452[_HL7 Table 0452 – Health Care Provider Type Code_] in Chapter 2C, Code Tables, for valid values."
* 7 0..1 CWE "ORG-7" "This field contains the more specific service or occupation within the health care provider type of the practitioner at a specific organization unit, for example, Counselor. HL7 suggests using values derived from the ANSI ASC X12 Health Care Provider Taxonomy, Level 2 – Classification."
* 7 from http://terminology.hl7.org/ValueSet/v2-0453 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1614
* 7 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70453[_HL7 Table 0453 – Health Care Provider Classification_] in Chapter 2C, Code Tables, for valid values."
* 8 0..1 CWE "ORG-8" "This field contains the segment of the population that a health care provider chooses to service, a specific medical service, a specialization in treating a specific disease, or any other descriptive characteristic about the provider's practice relating to the services rendered of the practitioner at a specific organization unit, for example, Mental Health. HL7 suggests using values derived from the ANSI ASC X12 Health Care Provider Taxonomy, Level 3 - specialization."
* 8 from http://terminology.hl7.org/ValueSet/v2-0454 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1615
* 8 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70454[_HL7 Table 0454 – Health Care Provider Area of Specialization_] in chapter 2C for valid values."
* 9 0..1 DR "ORG-9" "This field contains the date range in which the practitioner started and ended working at the specific organization unit in the specific practicing specialty category."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1465
* 10 0..1 CWE "ORG-10" "This field contains a code indicating the working relationship of the practitioner at this organization unit. It may be different than the work status specified in _STF-20_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70066[_User-defined Table 0066 - Employment Status_], in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0066 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1276
* 11 0..1 ID "ORG-11" "This field contains an indicator for whether this practice specialty requires board approval. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1467
* 11 ^comment = "Y this practice specialty requires board approval\n\nN this practice specialty does not require board approval"
* 12 0..1 ID "ORG-12" "This field contains an indicator for whether this practice specialty may act as a primary care physician (PCP). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1468
* 12 ^comment = "Y this practice specialty may act as a primary care physician\n\nN this practice specialty may not act as a primary care physician"
* 13 0..0 CWE "ORG-13" "This field contains the cost center name or code assigned to this organization unit. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70539[HL7 User-defined Table 0539 – Cost Center Code]_ for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0539 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1891