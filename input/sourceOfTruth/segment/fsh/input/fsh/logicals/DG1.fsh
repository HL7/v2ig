Logical: DG1
Parent: $Segment
Id: DG1
Title: "HL7 v2 DG1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Diagnosis"
* 1 1..1 SI "DG1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment the sequence number shall be 1, for the second occurrence it shall be 2, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #375
* 2 0..1 BackboneElement "DG1-2" "DG1-2"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #W
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #376
* 2 ^comment = "*Attention: _DG1-2 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6 ._*"
* 3 1..1 CWE "DG1-3" "_link:++#dg1-3-diagnosis-code---dg1-cwe-00377++[DG1-3 - Diagnosis Code - DG1]_ contains the diagnosis code assigned to this diagnosis. Refer to E:\\\\V2\\\\V29_CH02C_Tables.docx#HL70051[_User-defined Table 0051 - Diagnosis Code_] in Chapter 2C, Code Tables, for suggested values. This field is a CWE data type for compatibility with clinical and ancillary systems. Either _DG1-3.1-Identifier_ or _DG1-3.2-Text_ is required. When a code is used in _DG1-3.1-Identifier_, a coding system is required in _DG1-3.3-Name of Coding System_."
* 3 from http://terminology.hl7.org/ValueSet/v2-0051 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #377
* 3 ^comment = "Names of various diagnosis coding systems are listed in Chapter 2, Section 2.16.4, \"Coding system table.\""
* 4 0..1 BackboneElement "DG1-4" "DG1-4"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #W
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #378
* 4 ^comment = "*Attention: _DG1-4 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 5 0..1 DTM "DG1-5" "This field contains the date/time that the diagnosis was determined."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #379
* 6 1..1 CWE "DG1-6" "This field contains a code that identifies the type of diagnosis being sent. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70052[_User-defined Table 0052 - Diagnosis Type_] in Chapter 2C, Code Tables, for suggested values. This field should no longer be used to indicate \"DRG\" because the DRG fields have moved to the new DRG segment."
* 6 from http://terminology.hl7.org/ValueSet/v2-0052 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #380
* 7 0..1 BackboneElement "DG1-7" "DG1-7"
* 7 from http://terminology.hl7.org/ValueSet/v2-0118 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #W
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #381
* 7 ^comment = "*Attention: _DG1-7 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6 ._*"
* 8 0..1 BackboneElement "DG1-8" "DG1-8"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #W
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #382
* 8 ^comment = "*Attention: _DG1-8 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6. _*"
* 9 0..1 BackboneElement "DG1-9" "DG1-9"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #W
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #383
* 9 ^comment = "*Attention: _DG1-9 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 10 0..1 BackboneElement "DG1-10" "DG1-10"
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #W
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #384
* 10 ^comment = "*Attention: _DG1-10 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 11 0..1 BackboneElement "DG1-11" "DG1-11"
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #385
* 11 ^comment = "*Attention: _DG1-11 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 12 0..1 BackboneElement "DG1-12" "DG1-12"
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #W
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #386
* 12 ^comment = "*Attention: _DG1-12 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 13 0..1 BackboneElement "DG1-13" "DG1-13"
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #W
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #387
* 13 ^comment = "*Attention: _DG1-13 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 14 0..1 BackboneElement "DG1-14" "DG1-14"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #W
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #388
* 14 ^comment = "*Attention: _DG1-14 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6_*"
* 15 0..1 NM "DG1-15" "This field contains the number that identifies the significance or priority of the diagnosis code. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70359[_HL7 Table 03__59 - Diagnosis Priorit__y_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0359 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "2"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #389
* 15 ^comment = "*Note*: As of v 2.7, the data type has been changed to numeric. The meaning of the values remains the same as those in file:///E:\\V2\\V29_CH02C_Tables.docx#HL70418[_HL7 Table 0418 – Procedure Priority_], The value 0 conveys that this procedure is not included in the ranking. The value 1 means that this is the primary procedure. Values 2-99 convey ranked secondary procedures."
* 16 0..0 XCN "DG1-16" "This field contains the individual responsible for generating the diagnosis information. As of v 2.7, if _XCN.1 - ID Number_ is populated, then the _XCN.13 - Identifier Type Code_ and the _XCN.9 - Assigning Authority_ or _XCN.22 - Assigning Jurisdiction_ or _XCN.23 - Assigning Agency or Department_ are required. If _XCN.2 - Family Name_ is populated, then the _XCN.10 - Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #390
* 17 0..1 CWE "DG1-17" "This field indicates if the patient information is for a diagnosis or a non-diagnosis code. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70228[_User-defined Table 0228 - Diagnosis Classification_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0228 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #766
* 18 0..1 ID "DG1-18" "This field indicates whether the diagnosis is confidential. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, \"Code Tables\", for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^extension[=].extension[+].url = "max"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #767
* 18 ^comment = "Y the diagnosis is a confidential diagnosis\n\nN the diagnosis does not contain a confidential diagnosis"
* 19 0..1 DTM "DG1-19" "This field contains the time stamp that indicates the date and time that the attestation was signed."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #768
* 20 0..1 EI "DG1-20" "This field contains a value that uniquely identifies a single diagnosis for an encounter. It is unique across all segments and messages for an encounter. This field is required in all implementations employing Update Diagnosis/Procedures (P12) messages."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #C
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1850
* 21 0..1 ID "DG1-21" "This field defines the action to be taken for this diagnosis. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0__206 - Segment Action Code_] in Chapter 2C, \"Code Tables\", for valid values. This field is required for the update diagnosis/procedures (P12) message. In all other events it is optional."
* 21 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #C
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1894
* 22 0..1 EI "DG1-22" "This field contains the entity identifier for the parent diagnosis. This field links the \"current\" manifestation diagnosis (\"*\") to the entity identifier of the \"parent\" etiological diagnosis (\"+\")."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2152
* 23 0..1 CWE "DG1-23" "This field indicates the CCL value for the determined DRG for this diagnosis. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70728[_Externally-defined Table 0728 - CCL Value_] in Chapter 2C, Code Tables, for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0728 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2153
* 24 0..1 ID "DG1-24" "This field identifies whether this particular diagnosis has been used for the DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator_] in Chapter 2C, Code Tables, for suggested values. The values have the following meaning for this field:"
* 24 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^extension[=].extension[+].url = "max"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2154
* 24 ^comment = "Y Yes - Indicates that the diagnosis has been used for the DRG determination\n\nN No – Indicates that the diagnosis has not been used for the DRG determination"
* 25 0..1 CWE "DG1-25" "This field contains the status of this particular diagnosis for the DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70731[_User-defined Table 0731 – DRG Diagnosis Determination Status_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0731 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2155
* 26 0..1 CWE "DG1-26" "This field contains the present on admission indicator for this particular diagnosis. US reimbursement formulas for some states and Medicare have mandated that each diagnosis code be flagged as to whether it was present on admission or not. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70895[_User-defined Table 0895 – Present On Admission (POA) Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0895 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2288