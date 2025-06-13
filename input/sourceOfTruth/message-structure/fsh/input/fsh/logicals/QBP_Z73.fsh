Logical: QBP_Z73
Parent: V2MessageStructure
Id: QBP_Z73
Title: "HL7 v2 QBP_Z73 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_Z73"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "QBP_Z73"
* . ^definition = "QBP_Z73 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header Segment" "Message Header Segment"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 4-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-QPD ^extension.valueCode = #A
* 5-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 5-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-RCP ^extension.valueCode = #A