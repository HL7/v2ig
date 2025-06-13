Logical: CTI
Parent: $Segment
Id: CTI
Title: "HL7 v2 CTI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Clinical Trial Identification"
* 1 1..1 EI "CTI-1" "This field contains the universal identifier for the clinical trial. The coding system is as described in _CSR-1 Sponsor Study ID_."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1011
* 2 0..1 CWE "CTI-2" "This field identifies the phase of the study that a patient has entered. See _CSP-1 Study Phase Identifier_ for details of coding systems. Refer to Table 0597 - Study Phase Identifier in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0597 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1022
* 3 0..1 CWE "CTI-3" "This field identifies a time point in the clinical trial phase. _CTI-2 Study Phase Identifier_ must be valued if _CTI-3 Study Scheduled Time Point_ is valued. Should correspond to _CSS-1 Study Scheduled Time Point_. Refer to Table 0598 - Study Scheduled Time Point in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0598 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1055
* 4 0..1 ID "CTI-4" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #816
* 4 ^comment = "The action code can only be used when CTI-1 is valued in accordance with the guidance in Chapter 2, Section 2.10.4.2."