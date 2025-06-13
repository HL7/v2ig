Logical: ECR
Parent: $Segment
Id: ECR
Title: "HL7 v2 ECR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Equipment Command Response"
* 1 1..1 CWE "ECR-1" "This field identifies the response of the previously issued command. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70387[_User-defined Table 0387 – Command Response_] in Chapter 2C, Code Tables, for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0387 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1395
* 2 1..1 DTM "ECR-2" "This field contains the date and time that the receiving component completed the requested command."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1396
* 3 0..0 TX "ECR-3" "This field identifies any associated parameters that relate to the returned response command message."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1397