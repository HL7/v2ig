Logical: NPU
Parent: $Segment
Id: NPU
Title: "HL7 v2 NPU Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Bed Status Update"
* 1 1..1 PL "NPU-1" "This field contains the bed location that is a valid bed location."
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #209
* 2 0..1 CWE "NPU-2" "This field contains the bed status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70116[_User-defined Table 0116 - Bed Status_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0116 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #170