Logical: RPL_I02
Parent: V2MessageStructure
Id: RPL_I02
Title: "HL7 v2 RPL_I02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RPL_I02"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "RPL_I02"
* . ^definition = "RPL_I02 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software segment" "Software segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-PROVIDER 1..* BackboneElement "PROVIDER" "PROVIDER"
* 5-PROVIDER.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 5-PROVIDER.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER.1-PRD ^extension.valueCode = #A
* 5-PROVIDER.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-PROVIDER.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER.2-CTD ^extension.valueCode = #A
* 6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-NTE ^extension.valueCode = #A
* 7-DSP 0..* http://hl7.org/v2/StructureDefinition/DSP "Display Data" "Display Data"
* 7-DSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-DSP ^extension.valueCode = #A
* 8-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 8-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DSC ^extension.valueCode = #A