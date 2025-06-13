Logical: ESR_U02
Parent: V2MessageStructure
Id: ESR_U02
Title: "HL7 v2 ESR_U02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ESR_U02"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "ESR_U02"
* . ^definition = "ESR_U02 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EQU 1..1 http://hl7.org/v2/StructureDefinition/EQU "Equipment Detail" "Equipment Detail"
* 4-EQU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EQU ^extension.valueCode = #A
* 5-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "Role Detail" "Role Detail"
* 5-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ROL ^extension.valueCode = #B