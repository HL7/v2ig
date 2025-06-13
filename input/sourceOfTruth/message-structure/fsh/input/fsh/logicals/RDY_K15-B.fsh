Logical: RDY_K15-B
Parent: V2MessageStructure
Id: RDY_K15-B
Title: "HL7 v2 RDY_K15-B Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RDY_K15-B"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RDY_K15-B"
* . ^definition = "RDY_K15-B Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header Segment" "Message Header Segment"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 3-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-MSA ^extension.valueCode = #A
* 4-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 4-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-ERR ^extension.valueCode = #A
* 5-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 5-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-QAK ^extension.valueCode = #A
* 6-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 6-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QPD ^extension.valueCode = #A
* 7-DSP 0..* http://hl7.org/v2/StructureDefinition/DSP "Display Data" "Display Data"
* 7-DSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-DSP ^extension.valueCode = #A
* 8-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 8-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DSC ^extension.valueCode = #A
* 9-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 9-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-UAC ^extension.valueCode = #A