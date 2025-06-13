Logical: PR1
Parent: $Segment
Id: PR1
Title: "HL7 v2 PR1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Procedures"
* 1 1..1 SI "PR1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment the sequence number shall be 1, for the second occurrence it shall be 2, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #391
* 2 0..1 BackboneElement "PR1-2" "PR1-2"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #W
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #392
* 2 ^comment = "*Attention: _PR1-2 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 3 1..1 CNE "PR1-3" "This field contains a unique identifier assigned to the procedure. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70088[_Externally-defined Table 0088 - Procedure Code_] in Chapter 2C, Code Tables, for suggested values. This field is a CNE data type for compatibility with clinical and ancillary systems."
* 3 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #393
* 4 0..1 BackboneElement "PR1-4" "PR1-4"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #W
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #394
* 4 ^comment = "*Attention: _PR1-4 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 5 1..1 DTM "PR1-5" "This field contains the date/time that the procedure was performed."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #395
* 6 0..1 CWE "PR1-6" "This field contains the optional code that further defines the type of procedure. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70230[_User-defined Table 0230 - Procedure Functional Type_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0230 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #396
* 7 0..1 NM "PR1-7" "This field indicates the length of time in whole minutes that the procedure took to complete. The duration starts with the point in time in PR1-5."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "4"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #397
* 8 0..1 BackboneElement "PR1-8" "PR1-8"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #W
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #398
* 8 ^comment = "*Attention: _PR1-8 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 9 0..1 CWE "PR1-9" "This field contains a unique identifier of the anesthesia used during the procedure. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70019[_User-defined Table 0019 - Anesthesia Code_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0019 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #399
* 10 0..1 NM "PR1-10" "This field contains the length of time in minutes that the anesthesia was administered."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "4"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #400
* 11 0..1 BackboneElement "PR1-11" "PR1-11"
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #401
* 11 ^comment = "*Attention: _PR1-11 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 12 0..1 BackboneElement "PR1-12" "PR1-12"
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #W
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #402
* 12 ^comment = "*Attention: _PR1-12 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 13 0..1 CWE "PR1-13" "This field contains the type of consent that was obtained for permission to treat the patient. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70059[_User-defined Table 0059 - Consent Code_] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0059 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #403
* 14 0..1 NM "PR1-14" "This field contains a number that identifies the significance or priority of the procedure code. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70418[_HL7 Table 0418 - Procedure Priority_] in Chapter 2C, Code Tables, for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0418 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^extension[=].extension[+].url = "max"
* 14 ^extension[=].extension[=].valueInteger = 2
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #404
* 14 ^comment = "*Note*: As of v 2.7, the data type has been changed to numeric. The meaning of the values remain the same as those in file:///E:\\V2\\V29_CH02C_Tables.docx#HL70418[_HL7 Table 0418 – Procedure Priority_], The value 0 conveys that this procedure is not included in the ranking. The value 1 means that this is the primary procedure. Values 2-99 convey ranked secondary procedures."
* 15 0..1 CWE "PR1-15" "This field contains the diagnosis that is the primary reason this procedure was performed, e.g., in the US, Medicare wants to know for which diagnosis this procedure is submitted for inclusion on CMS 1500 form. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70051[_User-defined Table 0051 - Diagnosis Code_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0051 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #772
* 16 0..0 CNE "PR1-16" "This field contains the procedure code modifier to the procedure code reported in field 3, when applicable. Procedure code modifiers are defined by regulatory agencies such as CMS and the AMA. Multiple modifiers may be reported. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70340[_Externally-defined Table 0340 - Procedure Code Modifier_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0340 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1316
* 17 0..1 CWE "PR1-17" "This field indicates a procedure's priority ranking relative to its DRG. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70416[_User-defined Table 0416 - Procedure DRG Type_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0416 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1501
* 18 0..0 CWE "PR1-18" "Code representing type of tissue removed from a patient during this procedure. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70417[_User-defined Table 0417 - Tissue Type Code_] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0417 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1502
* 19 0..1 EI "PR1-19" "PR1-19"
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #C
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1848
* 19 ^comment = "This field contains a value that uniquely identifies a single procedure for an encounter. It is unique across all segments and messages for an encounter. This field is required in all implementations employing Update Diagnosis/Procedures (P12) messages."
* 20 0..1 ID "PR1-20" "PR1-20"
* 20 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #C
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1849
* 20 ^comment = "This field defines the action to be taken for this procedure. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70206[_H__L7 Table 0206 - Segment Actio__n Code_] in Chapter 2C, Code Tables, for valid values. This field is required for the Update Diagnosis/Procedures (P12) message. In all other events it is optional."
* 21 0..1 CWE "PR1-21" "This field contains the status of the use of this particular procedure for the DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70761[_User-defined Table 0761 – DRG Procedure Determination Status_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0761 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2177
* 22 0..1 CWE "PR1-22" "This field contains the relevance of this particular procedure for the DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70763[_User-defined Table 0763 – DRG Procedure Relevance_] in Chapter 2C, code Tables, for suggested values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0763 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2178
* 23 0..0 PL "PR1-23" "This field contains information about the organizational unit that has performed the procedure."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2371
* 24 0..1 ID "PR1-24" "This field indicates whether or not a respiratory procedure has occurred during a surgery. This field is optional and only needs to be valued for respiratory procedures. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code TableS, for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^extension[=].extension[+].url = "max"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2372
* 25 0..1 EI "PR1-25" "PR1-25"
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2373
* 25 ^comment = "Definitions: This field contains a procedure ID which points to the procedure group (e.g., complete surgery) in which this instance belongs."