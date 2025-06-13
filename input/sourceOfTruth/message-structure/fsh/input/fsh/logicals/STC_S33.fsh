Logical: STC_S33
Parent: V2MessageStructure
Id: STC_S33
Title: "HL7 v2 STC_S33 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "STC_S33"
* ^date = "2025-06-13T21:11:38Z"
* . ^short = "STC_S33"
* . ^definition = "STC_S33 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential Segment" "User Authentication Credential Segment"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-SCP 1..* http://hl7.org/v2/StructureDefinition/SCP "Sterilization Configuration" "Sterilization Configuration"
* 4-SCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-SCP ^extension.valueCode = #A