Logical: RSP_Z86
Parent: V2MessageStructure
Id: RSP_Z86
Title: "HL7 v2 RSP_Z86 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_Z86"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_Z86"
* . ^definition = "RSP_Z86 Message Structure"
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
* 8-QUERY_RESPONSE 1..* BackboneElement "QUERY_RESPONSE" "QUERY_RESPONSE"
* 8-QUERY_RESPONSE.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 8-QUERY_RESPONSE.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-QUERY_RESPONSE.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.1-PATIENT.1-PID ^extension.valueCode = #A
* 8-QUERY_RESPONSE.1-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 8-QUERY_RESPONSE.1-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.1-PATIENT.2-PD1 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.1-PATIENT.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 8-QUERY_RESPONSE.1-PATIENT.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.1-PATIENT.3-NTE ^extension.valueCode = #A
* 8-QUERY_RESPONSE.1-PATIENT.4-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 8-QUERY_RESPONSE.1-PATIENT.4-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.1-PATIENT.4-AL1 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER 1..* BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.1-TQ1 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.2-TIMING.2-TQ2 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.2-RXR ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.3-ORDER_DETAIL.3-RXC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER 0..1 BackboneElement "ENCODED_ORDER" "ENCODED_ORDER"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.1-RXE ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED 0..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.2-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.3-RXR ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.4-ENCODED_ORDER.4-RXC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE 0..1 BackboneElement "DISPENSE" "DISPENSE"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.1-RXD 1..1 http://hl7.org/v2/StructureDefinition/RXD "Pharmacy/Treatment Dispense" "Pharmacy/Treatment Dispense"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.1-RXD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.1-RXD ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.2-RXR ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.5-DISPENSE.3-RXC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE 0..1 BackboneElement "GIVE" "GIVE"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.1-RXG 1..1 http://hl7.org/v2/StructureDefinition/RXG "Pharmacy/Treatment Give" "Pharmacy/Treatment Give"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.1-RXG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.1-RXG ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.2-RXR ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.6-GIVE.3-RXC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION 0..1 BackboneElement "ADMINISTRATION" "ADMINISTRATION"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.1-RXA ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.2-RXR ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.7-ADMINISTRATION.3-RXC ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION 1..* BackboneElement "OBSERVATION" "OBSERVATION"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX 0..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QUERY_RESPONSE.2-COMMON_ORDER.8-OBSERVATION.2-NTE ^extension.valueCode = #A
* 9-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 9-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DSC ^extension.valueCode = #A