Logical: ORU_R01-B
Parent: V2MessageStructure
Id: ORU_R01-B
Title: "HL7 v2 ORU_R01-B Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORU_R01-B"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "ORU_R01-B"
* . ^definition = "ORU_R01-B Message Structure"
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
* 5-PATIENT_RESULT 1..* BackboneElement "PATIENT_RESULT" "PATIENT_RESULT"
* 5-PATIENT_RESULT.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT_RESULT.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT_RESULT.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-PATIENT_RESULT.1-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.2-PD1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-PATIENT_RESULT.1-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.3-GSP ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-PATIENT_RESULT.1-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.4-GSR ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 5-PATIENT_RESULT.1-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.5-GSC ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 5-PATIENT_RESULT.1-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.6-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.7-OH1 0..* http://hl7.org/v2/StructureDefinition/OH1 "Employment Status" "Employment Status"
* 5-PATIENT_RESULT.1-PATIENT.7-OH1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.7-OH1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.8-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 5-PATIENT_RESULT.1-PATIENT.8-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.8-OH2 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.9-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 5-PATIENT_RESULT.1-PATIENT.9-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.9-OH3 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.10-OH4 0..* http://hl7.org/v2/StructureDefinition/OH4 "Combat Zone Work" "Combat Zone Work"
* 5-PATIENT_RESULT.1-PATIENT.10-OH4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.10-OH4 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.11-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 5-PATIENT_RESULT.1-PATIENT.11-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.11-NTE ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.4-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.4-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.4-OH2 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.5-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.5-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.12-NEXT_OF_KIN.5-OH3 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.13-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 5-PATIENT_RESULT.1-PATIENT.13-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.13-ARV ^extension.valueCode = #B
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION 0..* BackboneElement "PATIENT_OBSERVATION" "PATIENT_OBSERVATION"
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation (for Patient ID)" "Observation (for Patient ID)"
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (Observation Participation)" "Participation (Observation Participation)"
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.14-PATIENT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.1-PV1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.2-PV2 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.15-VISIT.3-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.1-IN1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.2-IN2 ^extension.valueCode = #A
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.1-PATIENT.16-INSURANCE.3-IN3 ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION 1..* BackboneElement "ORDER_OBSERVATION" "ORDER_OBSERVATION"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER 0..1 BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Order common" "Order common"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for common order)" "Participation (for common order)"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT 0..1 BackboneElement "ORDER_DOCUMENT" "ORDER_DOCUMENT"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation containing Document" "Observation containing Document"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA 1..1 http://hl7.org/v2/StructureDefinition/TXA "Transcription Document Header" "Transcription Document Header"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.1-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.2-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observations Request" "Observations Request"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.2-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.2-OBR ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.3-NTE ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION 0..* BackboneElement "OBSERVATION_PARTICIPATION" "OBSERVATION_PARTICIPATION"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.1-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.1-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.1-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.2-DEV 0..* http://hl7.org/v2/StructureDefinition/DEV "Device" "Device"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.2-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.4-OBSERVATION_PARTICIPATION.2-DEV ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY 0..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.5-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.6-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.6-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.6-CTD ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation related to OBR" "Observation related to OBR"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (Observation Participation)" "Participation (Observation Participation)"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.3-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.7-OBSERVATION.3-NTE ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.8-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction" "Financial Transaction"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.8-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.8-FT1 ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.9-CTI 1..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.9-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.9-CTI ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN 0..* BackboneElement "SPECIMEN" "SPECIMEN"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.1-SPM ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation (for Patient ID)" "Observation (for Patient ID)"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (Observation Participation)" "Participation (Observation Participation)"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.2-ORDER_OBSERVATION.10-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-PATIENT_RESULT.3-DEVICE 0..* BackboneElement "DEVICE" "DEVICE"
* 5-PATIENT_RESULT.3-DEVICE.1-DEV 1..1 http://hl7.org/v2/StructureDefinition/DEV "Device (for Participation)" "Device (for Participation)"
* 5-PATIENT_RESULT.3-DEVICE.1-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.3-DEVICE.1-DEV ^extension.valueCode = #A
* 5-PATIENT_RESULT.3-DEVICE.2-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 5-PATIENT_RESULT.3-DEVICE.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT_RESULT.3-DEVICE.2-OBX ^extension.valueCode = #A
* 6-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 6-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DSC ^extension.valueCode = #A