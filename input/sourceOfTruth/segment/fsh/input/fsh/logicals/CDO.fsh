Logical: CDO
Parent: $Segment
Id: CDO
Title: "HL7 v2 CDO Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Cumulative Dosage"
* 1 0..1 SI "CDO-1" "For the first cumulative dose specification transmitted, the sequence number shall be 1; for the second cumulative dose, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3430
* 2 0..1 ID "CDO-2" "The Action Code indicates whether the cumulative dosage segment is intended to be added, deleted, updated, or did not change. If the field is not valued in any CDO segments for the order, the segments are considered to have been sent in snapshot mode. If some but not all CDO segments for the order do not have the action code valued, the default value is Add. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #816
* 3 0..1 CQ "CDO-3" "The Cumulative Dosage indicates the total dosage that may be administered within the scope of this order or within the interval indicated in _CDO-4 Cumulative Dosage Time Interval_, if supplied"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3397
* 4 0..1 CQ "CDO-4" "The Cumulative Dosage Time Interval indicates the interval over which the cumulative dosage in _CDO-3 Cumulative Dosage Limit_ is measured. If this field is not valued, the Cumulative Dosage Limit applies to the scope of the order."
* 4 from http://terminology.hl7.org/ValueSet/v2-0924 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3398
* 4 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70924[_HL7 Table 924 – Cumulative Dosage Limit UoM_] in Chapter 2C, Code Tables, for a list of suggested values, including applicable values from UCUM."