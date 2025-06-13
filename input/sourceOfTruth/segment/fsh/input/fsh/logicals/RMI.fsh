Logical: RMI
Parent: $Segment
Id: RMI
Title: "HL7 v2 RMI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Risk Management Incident"
* 1 0..1 CWE "RMI-1" "A code depicting the incident that occurred during a patient's stay. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70427[_User-defined Table 0427 - Risk Management Incident Code_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0427 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1530
* 2 0..1 DTM "RMI-2" "This field contains the date and time the Risk Management Incident identified in link:#rmi-1-risk-management-incident-code-cwe-01530[_RMI-1 - Risk Management Incident Code_] occurred."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1531
* 3 0..1 CWE "RMI-3" "A code depicting a classification of the incident type. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70428[_User-defined Table 0428 - Incident Type Code_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0428 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1533