Logical: EQU
Parent: $Segment
Id: EQU
Title: "HL7 v2 EQU Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Equipment Detail"
* 1 1..0 EI "EQU-1" "This field identifies the equipment. This is the identifier from an institution's master list of equipment. The <namespace ID> identifies the institution."
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1479
* 1 ^comment = "The Equipment Instance Identifier shall be unique, meaning that the “Entity Identifier” component shall be unique within the Namespace ID that should accommodate hierarchical representation of equipment (recursive hierarchy like in \"Russian dolls\", e.g., a sub-module embedded in a module assembled in a system being a member of a cluster).\n\nIf this attribute repeats, all instances must represent the same device."
* 2 1..1 DTM "EQU-2" "This field is the date/time that the event (e.g., state transition, issuing of command, finishing of command execution) occurred."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1322
* 3 0..1 CWE "EQU-3" "This field identifies the status that the equipment was in at the time that the transaction was initiated. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70365[_HL7 Table 0365 – Equipment State_] in Chapter 2C, Code Tables, for valid values. The Equipment State is required in the ESU message and is optional otherwise."
* 3 from http://terminology.hl7.org/ValueSet/v2-0365 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1323
* 4 0..1 CWE "EQU-4" "This field identifies the current state of control associated with the equipment. An equipment can either work autonomously ('Local' control state) or it can be controlled by another system, e.g., LAS computer ('Remote' control state). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70366[_HL7 Table 0366 – Local/Remote Control State_] in Chapter 2C, Code Tables, for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0366 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1324
* 5 0..1 CWE "EQU-5" "This field identifies the highest level of the alert state (e.g., highest alert severity) that is associated with the indicated equipment (e.g., processing event, inventory event, QC event). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70367[_HL7 Table 0367 – Alert Level_] in Chapter 2C, Code Tables, for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0367 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1325
* 6 0..1 DTM "EQU-6" "This field is the predicted date/time of the next equipment status change (e.g. from “maintenance” back to “normal operation”)."
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3487