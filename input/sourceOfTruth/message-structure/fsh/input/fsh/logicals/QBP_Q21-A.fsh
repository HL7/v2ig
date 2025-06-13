Logical: QBP_Q21-A
Parent: V2MessageStructure
Id: QBP_Q21-A
Title: "HL7 v2 QBP_Q21-A Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "QBP_Q21-A"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "QBP_Q21-A"
* . ^definition = "QBP_Q21-A Message Structure"
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
* 6-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 6-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DSC ^extension.valueCode = #A