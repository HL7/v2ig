Logical: RSP_Z90
Parent: V2MessageStructure
Id: RSP_Z90
Title: "HL7 v2 RSP_Z90 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_Z90"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_Z90"
* . ^definition = "RSP_Z90 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QAK ^extension.valueCode = #A
* 7-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 7-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QPD ^extension.valueCode = #A
* 8-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 8-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RCP ^extension.valueCode = #A
* 9-QUERY_RESPONSE 1..* BackboneElement "QUERY_RESPONSE" "QUERY_RESPONSE"
* 9-QUERY_RESPONSE.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 9-QUERY_RESPONSE.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 9-QUERY_RESPONSE.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.1-PID ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 9-QUERY_RESPONSE.1-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.2-PD1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.3-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 9-QUERY_RESPONSE.1-PATIENT.3-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.3-NK1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 9-QUERY_RESPONSE.1-PATIENT.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.4-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.1-PV1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.5-VISIT.2-PV2 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER 1..* BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observations Report ID" "Observations Report ID"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-OBR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for ORC/OBR)" "Notes and Comments (for ORC/OBR)"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-CTD ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION 1..* BackboneElement "OBSERVATION" "OBSERVATION"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.1-OBX 0..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.1-OBX ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-OBSERVATION.2-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.3-SPECIMEN 0..* BackboneElement "SPECIMEN" "SPECIMEN"
* 9-QUERY_RESPONSE.3-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 9-QUERY_RESPONSE.3-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.3-SPECIMEN.1-SPM ^extension.valueCode = #A
* 9-QUERY_RESPONSE.3-SPECIMEN.2-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation Related to Specimen" "Observation Related to Specimen"
* 9-QUERY_RESPONSE.3-SPECIMEN.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.3-SPECIMEN.2-OBX ^extension.valueCode = #A
* 10-DSC 1..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A