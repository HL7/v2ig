Logical: SLR_S28-E
Parent: V2MessageStructure
Id: SLR_S28-E
Title: "HL7 v2 SLR_S28-E Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "SLR_S28-E"
* ^date = "2025-06-13T21:11:38Z"
* . ^short = "SLR_S28-E"
* . ^definition = "SLR_S28-E Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential Segment" "User Authentication Credential Segment"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-SLT 1..* http://hl7.org/v2/StructureDefinition/SLT "Sterilization Lot" "Sterilization Lot"
* 4-SLT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-SLT ^extension.valueCode = #A