Logical: OMI_O23
Parent: V2MessageStructure
Id: OMI_O23
Title: "HL7 v2 OMI_O23 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OMI_O23"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "OMI_O23"
* . ^definition = "OMI_O23 Message Structure"
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
* 6-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
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
* 6-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 6-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-PRT ^extension.valueCode = #A
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH 0..1 BackboneElement "OCCUPATIONAL_DATA_FOR_HEALTH" "OCCUPATIONAL_DATA_FOR_HEALTH"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.1-OH1 0..* http://hl7.org/v2/StructureDefinition/OH1 "Employment Status" "Employment Status"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.1-OH1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.1-OH1 ^extension.valueCode = #A
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.2-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.2-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.2-OH2 ^extension.valueCode = #A
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.3-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.3-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.3-OH3 ^extension.valueCode = #A
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.4-OH4 0..* http://hl7.org/v2/StructureDefinition/OH4 "Combat Zone Work" "Combat Zone Work"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.4-OH4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-OCCUPATIONAL_DATA_FOR_HEALTH.4-OH4 ^extension.valueCode = #A
* 6-PATIENT.8-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.8-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-ARV ^extension.valueCode = #B
* 6-PATIENT.9-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.9-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-NTE ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit- Additional Info" "Patient Visit- Additional Info"
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 6-PATIENT.10-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 6-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 6-PATIENT.11-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 6-PATIENT.11-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 6-PATIENT.11-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.11-INSURANCE.1-IN1 ^extension.valueCode = #A
* 6-PATIENT.11-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 6-PATIENT.11-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.11-INSURANCE.2-IN2 ^extension.valueCode = #A
* 6-PATIENT.11-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 6-PATIENT.11-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.11-INSURANCE.3-IN3 ^extension.valueCode = #A
* 6-PATIENT.12-GT1 0..1 http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 6-PATIENT.12-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.12-GT1 ^extension.valueCode = #A
* 6-PATIENT.13-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 6-PATIENT.13-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.13-AL1 ^extension.valueCode = #A
* 7-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.1-ORC ^extension.valueCode = #A
* 7-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-PRT ^extension.valueCode = #A
* 7-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.4-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 7-ORDER.4-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-OBR ^extension.valueCode = #A
* 7-ORDER.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Detail)" "Notes and Comments (for Detail)"
* 7-ORDER.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-NTE ^extension.valueCode = #A
* 7-ORDER.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order)" "Participation (for Order)"
* 7-ORDER.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-PRT ^extension.valueCode = #A
* 7-ORDER.7-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-ORDER.7-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-CTD ^extension.valueCode = #A
* 7-ORDER.8-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 7-ORDER.8-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.8-DG1 ^extension.valueCode = #A
* 7-ORDER.9-REL 0..1 http://hl7.org/v2/StructureDefinition/REL "Relationship (for Observation)" "Relationship (for Observation)"
* 7-ORDER.9-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-REL ^extension.valueCode = #A
* 7-ORDER.10-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER.10-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 7-ORDER.10-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.10-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.10-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 7-ORDER.10-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.10-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.10-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Results)" "Notes and Comments (for Results)"
* 7-ORDER.10-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.10-OBSERVATION.3-NTE ^extension.valueCode = #A
* 7-ORDER.11-IPC 1..* http://hl7.org/v2/StructureDefinition/IPC "Imaging Procedure Control" "Imaging Procedure Control"
* 7-ORDER.11-IPC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.11-IPC ^extension.valueCode = #A
* 8-DEVICE 0..* BackboneElement "DEVICE" "DEVICE"
* 8-DEVICE.1-DEV 1..1 http://hl7.org/v2/StructureDefinition/DEV "Device (for Participation)" "Device (for Participation)"
* 8-DEVICE.1-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DEVICE.1-DEV ^extension.valueCode = #A
* 8-DEVICE.2-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 8-DEVICE.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DEVICE.2-OBX ^extension.valueCode = #A