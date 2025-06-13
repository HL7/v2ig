Logical: QBP_Qnn
Parent: V2MessageStructure
Id: QBP_Qnn
Title: "HL7 v2 QBP_Qnn Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_Qnn"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "QBP_Qnn"
* . ^definition = "QBP_Qnn Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header Segment" "Message Header Segment"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 4-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-QPD ^extension.valueCode = #A
* 5-RDF 0..1 http://hl7.org/v2/StructureDefinition/RDF "Table Row Definition Segment" "Table Row Definition Segment"
* 5-RDF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-RDF ^extension.valueCode = #A
* 6-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 6-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RCP ^extension.valueCode = #A
* 7-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 7-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-DSC ^extension.valueCode = #A