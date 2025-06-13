Logical: RSP_Z82
Parent: V2MessageStructure
Id: RSP_Z82
Title: "HL7 v2 RSP_Z82 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_Z82"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_Z82"
* . ^definition = "RSP_Z82 Message Structure"
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
* 9-QUERY_RESPONSE.1-PATIENT.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 9-QUERY_RESPONSE.1-PATIENT.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.3-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.1-AL1 1..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.1-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.1-AL1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.2-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.2-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.2-PV1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.3-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.3-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.1-PATIENT.4-VISIT.3-PV2 ^extension.valueCode = #A
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
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT 0..1 BackboneElement "TREATMENT" "TREATMENT"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.1-RXC 1..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.1-RXC ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXC)" "Notes and Comments (for RXC)"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.4-TREATMENT.2-NTE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER 0..1 BackboneElement "ENCODED_ORDER" "ENCODED_ORDER"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED 0..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-RXD 1..1 http://hl7.org/v2/StructureDefinition/RXD "Pharmacy/Treatment Dispense" "Pharmacy/Treatment Dispense"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-RXD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.5-RXD ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.6-RXR ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.7-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.7-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.7-RXC ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION 1..* BackboneElement "OBSERVATION" "OBSERVATION"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX 0..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX ^extension.valueCode = #A
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE ^extension.valueCode = #A
* 10-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A