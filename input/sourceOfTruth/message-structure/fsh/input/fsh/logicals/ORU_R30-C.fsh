Logical: ORU_R30-C
Parent: V2MessageStructure
Id: ORU_R30-C
Title: "HL7 v2 ORU_R30-C Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORU_R30-C"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "ORU_R30-C"
* . ^definition = "ORU_R30-C Message Structure"
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
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PD1 ^extension.valueCode = #A
* 7-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSP ^extension.valueCode = #A
* 8-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSR ^extension.valueCode = #A
* 9-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSC ^extension.valueCode = #A
* 10-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 10-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PRT ^extension.valueCode = #A
* 11-OH1 0..* http://hl7.org/v2/StructureDefinition/OH1 "Employment Status" "Employment Status"
* 11-OH1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-OH1 ^extension.valueCode = #A
* 12-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 12-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-OH2 ^extension.valueCode = #A
* 13-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 13-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-OH3 ^extension.valueCode = #A
* 14-OH4 0..* http://hl7.org/v2/StructureDefinition/OH4 "Combat Zone Work" "Combat Zone Work"
* 14-OH4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-OH4 ^extension.valueCode = #A
* 15-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 15-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-ARV ^extension.valueCode = #B
* 16-PATIENT_OBSERVATION 0..* BackboneElement "PATIENT_OBSERVATION" "PATIENT_OBSERVATION"
* 16-PATIENT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation (for Patient ID)" "Observation (for Patient ID)"
* 16-PATIENT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATIENT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 16-PATIENT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 16-PATIENT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATIENT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 17-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 17-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 17-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-VISIT.1-PV1 ^extension.valueCode = #A
* 17-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional" "Patient Visit – Additional"
* 17-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-VISIT.2-PV2 ^extension.valueCode = #A
* 17-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 17-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-VISIT.3-PRT ^extension.valueCode = #A
* 18-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order information" "Common Order information"
* 18-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-ORC ^extension.valueCode = #A
* 19-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for common order)" "Participation (for common order)"
* 19-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PRT ^extension.valueCode = #A
* 20-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 20-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBR ^extension.valueCode = #A
* 21-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes or Comments for order/result" "Notes or Comments for order/result"
* 21-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 21-NTE ^extension.valueCode = #A
* 22-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Request)" "Participation (for Observation Request)"
* 22-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 22-PRT ^extension.valueCode = #A
* 23-TIMING_QTY 0..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 23-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 23-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 23-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 23-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 23-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 23-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 24-OBSERVATION 1..* BackboneElement "OBSERVATION" "OBSERVATION"
* 24-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Results, one per reported value" "Observation Results, one per reported value"
* 24-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-OBSERVATION.1-OBX ^extension.valueCode = #A
* 24-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Results)" "Participation (for Observation Results)"
* 24-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-OBSERVATION.2-PRT ^extension.valueCode = #A
* 24-OBSERVATION.3-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes or Comments for individual result" "Notes or Comments for individual result"
* 24-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-OBSERVATION.3-NTE ^extension.valueCode = #A
* 25-DEVICE 0..* BackboneElement "DEVICE" "DEVICE"
* 25-DEVICE.1-DEV 1..1 http://hl7.org/v2/StructureDefinition/DEV "Device (for Participation)" "Device (for Participation)"
* 25-DEVICE.1-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 25-DEVICE.1-DEV ^extension.valueCode = #A
* 25-DEVICE.2-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 25-DEVICE.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 25-DEVICE.2-OBX ^extension.valueCode = #A