Logical: QBP_Q11-C
Parent: V2MessageStructure
Id: QBP_Q11-C
Title: "HL7 v2 QBP_Q11-C Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_Q11-C"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "QBP_Q11-C"
* . ^definition = "QBP_Q11-C Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restriction" "Access Restriction"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition Segment" "Query Parameter Definition Segment"
* 5-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-QPD ^extension.valueCode = #A
* 6-QBP 0..1 BackboneElement "QBP" "QBP"
* 6-QBP.1-... 0..1 http://hl7.org/v2/StructureDefinition/... "Optional query by example segments" "Optional query by example segments"
* 6-QBP.1-... ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QBP.1-... ^extension.valueCode = #A
* 7-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameters" "Response Control Parameters"
* 7-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RCP ^extension.valueCode = #A
* 8-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 8-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DSC ^extension.valueCode = #A