Logical: ADT_A20
Parent: V2MessageStructure
Id: ADT_A20
Title: "HL7 v2 ADT_A20 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A20"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "ADT_A20"
* . ^definition = "ADT_A20 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-NPU 1..1 http://hl7.org/v2/StructureDefinition/NPU "Non-Patient Update" "Non-Patient Update"
* 5-NPU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-NPU ^extension.valueCode = #A