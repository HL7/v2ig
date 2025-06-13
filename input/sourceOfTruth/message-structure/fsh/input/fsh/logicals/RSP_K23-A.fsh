Logical: RSP_K23-A
Parent: V2MessageStructure
Id: RSP_K23-A
Title: "HL7 v2 RSP_K23-A Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_K23-A"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "RSP_K23-A"
* . ^definition = "RSP_K23-A Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgment" "Query Acknowledgment"
* 6-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QAK ^extension.valueCode = #A
* 7-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition Segment" "Query Parameter Definition Segment"
* 7-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QPD ^extension.valueCode = #A
* 8-QUERY_RESPONSE 0..1 BackboneElement "QUERY_RESPONSE" "QUERY_RESPONSE"
* 8-QUERY_RESPONSE.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-QUERY_RESPONSE.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.1-PID ^extension.valueCode = #A
* 9-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 9-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DSC ^extension.valueCode = #A