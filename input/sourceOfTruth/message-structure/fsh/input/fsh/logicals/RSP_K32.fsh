Logical: RSP_K32
Parent: V2MessageStructure
Id: RSP_K32
Title: "HL7 v2 RSP_K32 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_K32"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "RSP_K32"
* . ^definition = "RSP_K32 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 3-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-MSA ^extension.valueCode = #A
* 4-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 4-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-ERR ^extension.valueCode = #A
* 5-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgment" "Query Acknowledgment"
* 5-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-QAK ^extension.valueCode = #A
* 6-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition Segment" "Query Parameter Definition Segment"
* 6-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QPD ^extension.valueCode = #A
* 7-QUERY_RESPONSE 0..* BackboneElement "QUERY_RESPONSE" "QUERY_RESPONSE"
* 7-QUERY_RESPONSE.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 7-QUERY_RESPONSE.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.1-PID ^extension.valueCode = #A
* 7-QUERY_RESPONSE.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 7-QUERY_RESPONSE.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.2-PD1 ^extension.valueCode = #A
* 7-QUERY_RESPONSE.3-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 7-QUERY_RESPONSE.3-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.3-NK1 ^extension.valueCode = #A
* 7-QUERY_RESPONSE.4-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-QUERY_RESPONSE.4-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.4-GSP ^extension.valueCode = #A
* 7-QUERY_RESPONSE.5-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-QUERY_RESPONSE.5-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.5-GSR ^extension.valueCode = #A
* 7-QUERY_RESPONSE.6-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 7-QUERY_RESPONSE.6-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.6-PV1 ^extension.valueCode = #A
* 7-QUERY_RESPONSE.7-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info." "Patient Visit – Additional Info."
* 7-QUERY_RESPONSE.7-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.7-PV2 ^extension.valueCode = #A
* 7-QUERY_RESPONSE.8-QRI 0..1 http://hl7.org/v2/StructureDefinition/QRI "Query Response Instance" "Query Response Instance"
* 7-QUERY_RESPONSE.8-QRI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QUERY_RESPONSE.8-QRI ^extension.valueCode = #A
* 8-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "DESCRIPTION NEEDED" "DESCRIPTION NEEDED"
* 8-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DSC ^extension.valueCode = #A