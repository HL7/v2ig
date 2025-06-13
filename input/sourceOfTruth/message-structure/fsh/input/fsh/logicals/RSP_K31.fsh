Logical: RSP_K31
Parent: V2MessageStructure
Id: RSP_K31
Title: "HL7 v2 RSP_K31 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_K31"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_K31"
* . ^definition = "RSP_K31 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 2-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-MSA ^extension.valueCode = #A
* 3-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 3-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-ERR ^extension.valueCode = #A
* 4-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 4-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-SFT ^extension.valueCode = #A
* 5-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 5-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-UAC ^extension.valueCode = #A
* 6-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QAK ^extension.valueCode = #A
* 7-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 7-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QPD ^extension.valueCode = #A
* 8-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 8-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RCP ^extension.valueCode = #A
* 9-RESPONSE 1..* BackboneElement "RESPONSE" "RESPONSE"
* 9-RESPONSE.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 9-RESPONSE.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 9-RESPONSE.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.1-PID ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 9-RESPONSE.1-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.2-PD1 ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-RESPONSE.1-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.3-GSP ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-RESPONSE.1-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.4-GSR ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-RESPONSE.1-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.5-GSC ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Additional Demographics)" "Participation (for Additional Demographics)"
* 9-RESPONSE.1-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.6-PRT ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 9-RESPONSE.1-PATIENT.7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.7-NTE ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.8-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 9-RESPONSE.1-PATIENT.8-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.8-ARV ^extension.valueCode = #B
* 9-RESPONSE.1-PATIENT.9-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 9-RESPONSE.1-PATIENT.9-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.9-AL1 ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.1-PATIENT.10-PATIENT_VISIT.4-ARV ^extension.valueCode = #B
* 9-RESPONSE.2-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 9-RESPONSE.2-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 9-RESPONSE.2-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.1-ORC ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for ORC)" "Participation (for ORC)"
* 9-RESPONSE.2-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.2-PRT ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 9-RESPONSE.2-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 9-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 9-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS 0..* BackboneElement "COMPONENTS" "COMPONENTS"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING 0..1 BackboneElement "ENCODING" "ENCODING"
* 9-RESPONSE.2-ORDER.5-ENCODING.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 9-RESPONSE.2-ORDER.5-ENCODING.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.1-RXE ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXE)" "Participation (for RXE)"
* 9-RESPONSE.2-ORDER.5-ENCODING.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.2-PRT ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXE)" "Notes and Comments (for RXE)"
* 9-RESPONSE.2-ORDER.5-ENCODING.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.3-NTE ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED 1..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.5-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-RESPONSE.2-ORDER.5-ENCODING.5-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.5-RXR ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.5-ENCODING.6-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-RESPONSE.2-ORDER.5-ENCODING.6-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.5-ENCODING.6-RXC ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.6-RXD 1..1 http://hl7.org/v2/StructureDefinition/RXD "Pharmacy/Treatment Dispense" "Pharmacy/Treatment Dispense"
* 9-RESPONSE.2-ORDER.6-RXD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.6-RXD ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.7-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXD)" "Participation (for RXD)"
* 9-RESPONSE.2-ORDER.7-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.7-PRT ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.8-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 9-RESPONSE.2-ORDER.8-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.8-RXR ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.9-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 9-RESPONSE.2-ORDER.9-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.9-RXC ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.10-CDO 0..* http://hl7.org/v2/StructureDefinition/CDO "Cumulative Dosage Segment" "Cumulative Dosage Segment"
* 9-RESPONSE.2-ORDER.10-CDO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.10-CDO ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.11-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.1-OBX ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.11-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for OBX)" "Participation (for OBX)"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.2-PRT ^extension.valueCode = #A
* 9-RESPONSE.2-ORDER.11-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-RESPONSE.2-ORDER.11-OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A