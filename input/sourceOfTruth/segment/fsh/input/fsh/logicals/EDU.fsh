Logical: EDU
Parent: $Segment
Id: EDU
Title: "HL7 v2 EDU Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Educational Detail"
* 1 1..1 SI "EDU-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1448
* 2 0..1 CWE "EDU-2" "This field contains the standard classification awarded upon completion of a unified program of study. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70360[_User-defined Table 0360 - Degree/License/Certificate_]."
* 2 from http://terminology.hl7.org/ValueSet/v2-0360 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1449
* 3 0..1 DR "EDU-3" "This field contains the date range when the academic degree program took place."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1597
* 4 0..1 DR "EDU-4" "This field contains the date range during which the staff member participated in the academic degree program."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1450
* 5 0..1 DT "EDU-5" "This field contains the date the academic degree was granted to the staff member."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1451
* 6 0..1 XON "EDU-6" "This field contains the official name of the academic institution that granted the degree to the Staff Member."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1452
* 7 0..1 CWE "EDU-7" "This field contains the categorization of the academic institution that granted the degree to the Staff Member. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70402[_User-defined Table 0402 – School Type_]."
* 7 from http://terminology.hl7.org/ValueSet/v2-0402 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1453
* 7 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70402[_User-defined Table 0402 – School Type_] in Chapter 2C, Code Tables, for valid values. This table contains values for graduate, medical etc."
* 8 0..1 XAD "EDU-8" "This field contains the postal address of the academic institution that granted the degree to the Staff Member."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1454
* 9 0..0 CWE "EDU-9" "This field contains the subject of academic study associated with the specific academic degree program pursued by the staff member as his/her area of specialization."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1885