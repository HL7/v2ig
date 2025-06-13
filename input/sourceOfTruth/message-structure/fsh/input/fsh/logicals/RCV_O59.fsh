Logical: RCV_O59
Parent: V2MessageStructure
Id: RCV_O59
Title: "HL7 v2 RCV_O59 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RCV_O59"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RCV_O59"
* . ^definition = "RCV_O59 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Header)" "Notes and Comments (for Header)"
* 4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-NTE ^extension.valueCode = #A
* 5-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.2-PD1 ^extension.valueCode = #A
* 5-PATIENT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Additional Demographics)" "Participation (for Additional Demographics)"
* 5-PATIENT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.3-PRT ^extension.valueCode = #A
* 5-PATIENT.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 5-PATIENT.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.4-NTE ^extension.valueCode = #A
* 5-PATIENT.5-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 5-PATIENT.5-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.5-AL1 ^extension.valueCode = #A
* 5-PATIENT.6-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 5-PATIENT.6-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT.6-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 5-PATIENT.6-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 5-PATIENT.6-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 5-PATIENT.6-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 5-PATIENT.6-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 6-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 6-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 6-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.1-ORC ^extension.valueCode = #A
* 6-ORDER.2-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 6-ORDER.2-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 6-ORDER.2-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.2-TIMING.1-TQ1 ^extension.valueCode = #A
* 6-ORDER.2-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 6-ORDER.2-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.2-TIMING.2-TQ2 ^extension.valueCode = #A
* 6-ORDER.3-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 6-ORDER.3-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy /Treatment Order" "Pharmacy /Treatment Order"
* 6-ORDER.3-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.3-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT 0..1 BackboneElement "ORDER_DETAIL_SUPPLEMENT" "ORDER_DETAIL_SUPPLEMENT"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.1-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.1-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.1-NTE ^extension.valueCode = #A
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.2-RXR ^extension.valueCode = #A
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT 0..* BackboneElement "COMPONENT" "COMPONENT"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.1-RXC ^extension.valueCode = #A
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.3-ORDER_DETAIL.2-ORDER_DETAIL_SUPPLEMENT.3-COMPONENT.2-NTE ^extension.valueCode = #A
* 6-ORDER.4-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order)" "Participation (for Order)"
* 6-ORDER.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.4-PRT ^extension.valueCode = #A
* 6-ORDER.5-ENCODING 0..1 BackboneElement "ENCODING" "ENCODING"
* 6-ORDER.5-ENCODING.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 6-ORDER.5-ENCODING.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.1-RXE ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order Encoding)" "Participation (for Order Encoding)"
* 6-ORDER.5-ENCODING.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.2-PRT ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXE)" "Notes and Comments (for RXE)"
* 6-ORDER.5-ENCODING.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.3-NTE ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED 1..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.5-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 6-ORDER.5-ENCODING.5-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.5-RXR ^extension.valueCode = #A
* 6-ORDER.5-ENCODING.6-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 6-ORDER.5-ENCODING.6-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.5-ENCODING.6-RXC ^extension.valueCode = #A
* 6-ORDER.6-RXD 1..1 http://hl7.org/v2/StructureDefinition/RXD "Pharmacy/Treatment Dispense" "Pharmacy/Treatment Dispense"
* 6-ORDER.6-RXD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.6-RXD ^extension.valueCode = #A
* 6-ORDER.7-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Treatment Dispense)" "Participation (for Treatment Dispense)"
* 6-ORDER.7-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.7-PRT ^extension.valueCode = #A
* 6-ORDER.8-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXD)" "Notes and Comments (for RXD)"
* 6-ORDER.8-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.8-NTE ^extension.valueCode = #A
* 6-ORDER.9-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 6-ORDER.9-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.9-RXR ^extension.valueCode = #A
* 6-ORDER.10-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 6-ORDER.10-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.10-RXC ^extension.valueCode = #A
* 6-ORDER.11-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 6-ORDER.11-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 6-ORDER.11-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.11-OBSERVATION.1-OBX ^extension.valueCode = #A
* 6-ORDER.11-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 6-ORDER.11-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.11-OBSERVATION.2-PRT ^extension.valueCode = #A
* 6-ORDER.11-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 6-ORDER.11-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.11-OBSERVATION.3-NTE ^extension.valueCode = #A
* 6-ORDER.12-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction segment" "Financial Transaction segment"
* 6-ORDER.12-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ORDER.12-FT1 ^extension.valueCode = #A