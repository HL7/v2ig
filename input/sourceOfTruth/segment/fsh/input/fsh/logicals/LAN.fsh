Logical: LAN
Parent: $Segment
Id: LAN
Title: "HL7 v2 LAN Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Language Detail"
* 1 1..1 SI "LAN-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1455
* 2 1..1 CWE "LAN-2" "This field contains the language about which the Staff Member's has some knowledge. HL7 recommends using ISO table 639 as the suggested values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70296[_User-defined Table 0296 – Primary Language_]."
* 2 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1456
* 3 0..0 CWE "LAN-3" "This field contains the ability the Staff Member possesses with respect to the language. HL7 recommends using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70403[_HL7 Table 0403 - Language Ability_]."
* 3 from http://terminology.hl7.org/ValueSet/v2-0403 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1457
* 3 ^comment = "[#_Hlt489245616 .anchor]####Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70403[_HL7 Table 0403 – Language Ability_] in Chapter 2C, Code Tables, for valid values. This table contains values for the Staff Member's ability to read, write, understand, etc."
* 4 0..1 CWE "LAN-4" "This field contains the level of knowledge the Staff Member possesses with respect to the language ability. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70404[_HL7 Table 0404 - Language Proficiency_]."
* 4 from http://terminology.hl7.org/ValueSet/v2-0404 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1458
* 4 ^comment = "[#_Hlt489245619 .anchor]####Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70404[_HL7 Table 0404 – Language Proficiency_] in Chapter 2C, Code Tables, for valid values. This table contains values for excellent, poor, fair etc."