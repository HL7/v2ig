Logical: QBP_E22
Parent: V2MessageStructure
Id: QBP_E22
Title: "HL7 v2 QBP_E22 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_E22"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "QBP_E22"
* . ^definition = "QBP_E22 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-QUERY 1..1 BackboneElement "QUERY" "QUERY"
* 4-QUERY.choice-1-Group 0..1 BackboneElement "Choice 1 within QUERY" "Choice 1 within QUERY"
* 4-QUERY.choice-1-Group.1-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 4-QUERY.choice-1-Group.1-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-QUERY.choice-1-Group.1-QPD ^extension.valueCode = #A
* 4-QUERY.choice-1-Group.2-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 4-QUERY.choice-1-Group.2-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-QUERY.choice-1-Group.2-RCP ^extension.valueCode = #A