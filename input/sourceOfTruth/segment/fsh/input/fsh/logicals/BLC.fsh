Logical: BLC
Parent: $Segment
Id: BLC
Title: "HL7 v2 BLC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Blood Code"
* 1 0..1 CWE "BLC-1" "This field reports the blood product code. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70426[_User-defined Table 0426 - Blood Product Code_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0426 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1528
* 2 0..1 CQ "BLC-2" "This field indicates the quantity and units administered for the blood code identified in field 1, for example, 2^pt. Standard ISO or ANSI units, as defined in Chapter 7 are recommended."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1529