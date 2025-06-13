Logical: RAS_O17
Parent: V2MessageStructure
Id: RAS_O17
Title: "HL7 v2 RAS_O17 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RAS_O17"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RAS_O17"
* . ^definition = "RAS_O17 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Header)" "Notes and Comments (for Header)"
* 5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-NTE ^extension.valueCode = #A
* 6-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 6-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 6-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.1-PID ^extension.valueCode = #A
* 6-PATIENT.2-PD1 1..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-PD1 ^extension.valueCode = #A
* 6-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.3-GSP ^extension.valueCode = #A
* 6-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 6-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.4-GSR ^extension.valueCode = #A
* 6-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 6-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-GSC ^extension.valueCode = #A
* 6-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Additional Demographics)" "Participation (for Additional Demographics)"
* 6-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-PRT ^extension.valueCode = #A
* 6-PATIENT.7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for PID)" "Notes and Comments (for PID)"
* 6-PATIENT.7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-NTE ^extension.valueCode = #A
* 6-PATIENT.8-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.8-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-ARV ^extension.valueCode = #B
* 6-PATIENT.9-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 6-PATIENT.9-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-AL1 ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 6-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For access compatibiliy only as of V2.9." "For access compatibiliy only as of V2.9."
* 6-PATIENT.10-PATIENT_VISIT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.4-ARV ^extension.valueCode = #B
* 7-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.1-ORC ^extension.valueCode = #A
* 7-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for ORC)" "Participation (for ORC)"
* 7-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-PRT ^extension.valueCode = #A
* 7-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 7-ORDER.4-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy /Treatment Order" "Pharmacy /Treatment Order"
* 7-ORDER.4-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER.4-ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT 0..1 BackboneElement "ORDER_DETAIL_SUPPLEMENT" "ORDER_DETAIL_SUPPLEMENT"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.1-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.1-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.1-NTE ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.2-RXR ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS 0..* BackboneElement "COMPONENTS" "COMPONENTS"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.1-RXC ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.3-ORDER_DETAIL_SUPPLEMENT.3-COMPONENTS.2-NTE ^extension.valueCode = #A
* 7-ORDER.5-ENCODING 0..1 BackboneElement "ENCODING" "ENCODING"
* 7-ORDER.5-ENCODING.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 7-ORDER.5-ENCODING.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.1-RXE ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Encoded Order)" "Participation (for Encoded Order)"
* 7-ORDER.5-ENCODING.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXE)" "Notes and Comments (for RXE)"
* 7-ORDER.5-ENCODING.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.3-NTE ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED 1..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.4-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.5-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.5-ENCODING.5-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.5-RXR ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.6-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 7-ORDER.5-ENCODING.6-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.6-RXC ^extension.valueCode = #A
* 7-ORDER.5-ENCODING.7-CDO 0..* http://hl7.org/v2/StructureDefinition/CDO "Cumulative Dosage Segment" "Cumulative Dosage Segment"
* 7-ORDER.5-ENCODING.7-CDO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-ENCODING.7-CDO ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION 1..* BackboneElement "ADMINISTRATION" "ADMINISTRATION"
* 7-ORDER.6-ADMINISTRATION.1-RXA 1..* http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 7-ORDER.6-ADMINISTRATION.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.1-RXA ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Administration)" "Participation (for Administration)"
* 7-ORDER.6-ADMINISTRATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION.3-RXR 1..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.6-ADMINISTRATION.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.3-RXR ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-ADMINISTRATION.4-OBSERVATION.3-NTE ^extension.valueCode = #A
* 7-ORDER.7-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 7-ORDER.7-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-CTI ^extension.valueCode = #A