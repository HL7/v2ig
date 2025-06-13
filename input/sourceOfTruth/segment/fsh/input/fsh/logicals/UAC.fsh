Logical: UAC
Parent: $Segment
Id: UAC
Title: "HL7 v2 UAC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "User Authentication Credential"
* 1 1..1 CWE "UAC-1" "This an identifier code for the type of user authentication credential. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70615[_HL7 Table 0615 – User Authentication Credential Type Code_] in Chapter 2C, Code Tables, for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0615 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2267
* 2 1..1 ED "UAC-2" "This is user credential data as supplied by the sender's operating platform. The content and structure of this is defined by other standards and contain no HL7-relevant data."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2268