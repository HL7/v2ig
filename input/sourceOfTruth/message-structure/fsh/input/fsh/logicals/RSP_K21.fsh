Logical: RSP_K21
Parent: V2MessageStructure
Id: RSP_K21
Title: "HL7 v2 RSP_K21 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_K21"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "RSP_K21"
* . ^definition = "RSP_K21 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 5-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MSA ^extension.valueCode = #A
* 6-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 6-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ERR ^extension.valueCode = #A
* 7-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgment" "Query Acknowledgment"
* 7-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QAK ^extension.valueCode = #A
* 8-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition Segment" "Query Parameter Definition Segment"
* 8-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QPD ^extension.valueCode = #A
* 9-QUERY_RESPONSE 0..1 BackboneElement "QUERY_RESPONSE" "QUERY_RESPONSE"
* 9-QUERY_RESPONSE.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 9-QUERY_RESPONSE.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PID ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 9-QUERY_RESPONSE.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-PD1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-QUERY_RESPONSE.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.3-GSP ^extension.valueCode = #A
* 9-QUERY_RESPONSE.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-QUERY_RESPONSE.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.4-GSR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-QUERY_RESPONSE.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.5-GSC ^extension.valueCode = #A
* 9-QUERY_RESPONSE.6-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 9-QUERY_RESPONSE.6-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.6-ARV ^extension.valueCode = #B
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.7-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.8-QRI 1..1 http://hl7.org/v2/StructureDefinition/QRI "Query Response Instances" "Query Response Instances"
* 9-QUERY_RESPONSE.8-QRI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.8-QRI ^extension.valueCode = #A
* 10-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A