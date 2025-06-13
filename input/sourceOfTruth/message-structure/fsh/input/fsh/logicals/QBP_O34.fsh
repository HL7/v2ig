Logical: QBP_O34
Parent: V2MessageStructure
Id: QBP_O34
Title: "HL7 v2 QBP_O34 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_O34"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "QBP_O34"
* . ^definition = "QBP_O34 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition Segment" "Query Parameter Definition Segment"
* 4-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-QPD ^extension.valueCode = #A
* 5-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameters" "Response Control Parameters"
* 5-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-RCP ^extension.valueCode = #A