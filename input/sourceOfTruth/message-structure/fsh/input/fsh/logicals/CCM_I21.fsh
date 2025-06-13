Logical: CCM_I21
Parent: V2MessageStructure
Id: CCM_I21
Title: "HL7 v2 CCM_I21 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CCM_I21"
* ^date = "2025-06-13T21:11:34Z"
* . ^short = "CCM_I21"
* . ^definition = "CCM_I21 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 4-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PID ^extension.valueCode = #A
* 5-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PD1 ^extension.valueCode = #A
* 6-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSP ^extension.valueCode = #A
* 7-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSR ^extension.valueCode = #A
* 8-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 8-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSC ^extension.valueCode = #A
* 9-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 9-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 9-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 9-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 9-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 10-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 10-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 10-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-INSURANCE.1-IN1 ^extension.valueCode = #A
* 10-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info." "Insurance Additional Info."
* 10-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-INSURANCE.2-IN2 ^extension.valueCode = #A
* 10-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Info – Cert." "Insurance Additional Info – Cert."
* 10-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-INSURANCE.3-IN3 ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY 0..* BackboneElement "APPOINTMENT_HISTORY" "APPOINTMENT_HISTORY"
* 11-APPOINTMENT_HISTORY.1-SCH 1..1 http://hl7.org/v2/StructureDefinition/SCH "Schedule Activity Information" "Schedule Activity Information"
* 11-APPOINTMENT_HISTORY.1-SCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.1-SCH ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES 0..* BackboneElement "RESOURCES" "RESOURCES"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS 1..1 http://hl7.org/v2/StructureDefinition/RGS "Resource Group Segment" "Resource Group Segment"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL 0..* BackboneElement "RESOURCE_DETAIL" "RESOURCE_DETAIL"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT 1..1 BackboneElement "RESOURCE_OBJECT" "RESOURCE_OBJECT"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS 0..1 http://hl7.org/v2/StructureDefinition/AIS "Appointment Information - Service" "Choice 1 within RESOURCE_OBJECT"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG 0..1 http://hl7.org/v2/StructureDefinition/AIG "Appointment Information – General Resource" "Choice 2 within RESOURCE_OBJECT"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL 0..1 http://hl7.org/v2/StructureDefinition/AIL "Appointment Information – Location" "Choice 3 within RESOURCE_OBJECT"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP 0..1 http://hl7.org/v2/StructureDefinition/AIP "Appointment Information – Personnel" "Choice 4 within RESOURCE_OBJECT"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION 0..* BackboneElement "RESOURCE_OBSERVATION" "RESOURCE_OBSERVATION"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.valueCode = #A
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.valueCode = #A
* 12-CLINICAL_HISTORY 0..* BackboneElement "CLINICAL_HISTORY" "CLINICAL_HISTORY"
* 12-CLINICAL_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 12-CLINICAL_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.1-ORC ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL 0..* BackboneElement "CLINICAL_HISTORY_DETAIL" "CLINICAL_HISTORY_DETAIL"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "CLINICAL_HISTORY_OBJECT" "CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group 0..1 BackboneElement "Choice 1 within CLINICAL_HISTORY_OBJECT" "Choice 1 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS 0..1 http://hl7.org/v2/StructureDefinition/ODS "Dietary Order, Suppl., Prefer." "Choice 2 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 0..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Choice 3 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Choice 4 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 0..1 http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Choice 5 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM 0..1 http://hl7.org/v2/StructureDefinition/IAM "Patient adverse reaction information" "Choice 6 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Choice 7 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI 0..1 http://hl7.org/v2/StructureDefinition/RMI "Risk Management Incident" "Choice 8 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 0..1 http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Choice 9 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 0..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Choice 10 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Choice 11 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA 0..1 http://hl7.org/v2/StructureDefinition/PDA "Patient Death and Autopsy" "Choice 12 within CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION 0..* BackboneElement "CLINICAL_HISTORY_OBSERVATION" "CLINICAL_HISTORY_OBSERVATION"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY 0..* BackboneElement "PARTICIPATION_CLINICAL_HISTORY" "PARTICIPATION_CLINICAL_HISTORY"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "PARTICIPATION_CLINICAL_HISTORY_OBJECT" "PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group 0..1 BackboneElement "Choice 1 within PARTICIPATION_CLINICAL_HISTORY_OBJECT" "Choice 1 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.1-ROL 1..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.1-ROL ^extension.valueCode = #B
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (CLINICAL_HISTORY)" "Participation (CLINICAL_HISTORY)"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (CLINICAL_HISTORY)" "Choice 2 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRD ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (CLINICAL_HISTORY)" "Variance (CLINICAL_HISTORY)"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.valueCode = #A
* 12-CLINICAL_HISTORY.4-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 12-CLINICAL_HISTORY.4-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-CLINICAL_HISTORY.4-CTI ^extension.valueCode = #A
* 13-PATIENT_VISITS 1..* BackboneElement "PATIENT_VISITS" "PATIENT_VISITS"
* 13-PATIENT_VISITS.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 13-PATIENT_VISITS.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PATIENT_VISITS.1-PV1 ^extension.valueCode = #A
* 13-PATIENT_VISITS.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info." "Patient Visit – Additional Info."
* 13-PATIENT_VISITS.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PATIENT_VISITS.2-PV2 ^extension.valueCode = #A
* 14-MEDICATION_HISTORY 0..* BackboneElement "MEDICATION_HISTORY" "MEDICATION_HISTORY"
* 14-MEDICATION_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 14-MEDICATION_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.1-ORC ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL 0..1 BackboneElement "MEDICATION_ORDER_DETAIL" "MEDICATION_ORDER_DETAIL"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-RXR ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXO)" "Pharmacy/Treatment Component (for RXO)"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXC ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION 0..* BackboneElement "MEDICATION_ORDER_OBSERVATION" "MEDICATION_ORDER_OBSERVATION"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL 0..1 BackboneElement "MEDICATION_ENCODING_DETAIL" "MEDICATION_ENCODING_DETAIL"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-RXR ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXE)" "Pharmacy/Treatment Component (for RXE)"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXC ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION 0..* BackboneElement "MEDICATION_ENCODING_OBSERVATION" "MEDICATION_ENCODING_OBSERVATION"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL 0..* BackboneElement "MEDICATION_ADMINISTRATION_DETAIL" "MEDICATION_ADMINISTRATION_DETAIL"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA 1..* http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-RXR 1..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-RXR ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION 0..* BackboneElement "MEDICATION_ADMINISTRATION_OBSERVATION" "MEDICATION_ADMINISTRATION_OBSERVATION"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.valueCode = #A
* 14-MEDICATION_HISTORY.5-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 14-MEDICATION_HISTORY.5-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-MEDICATION_HISTORY.5-CTI ^extension.valueCode = #A
* 15-PROBLEM 0..* BackboneElement "PROBLEM" "PROBLEM"
* 15-PROBLEM.1-PRB 1..1 http://hl7.org/v2/StructureDefinition/PRB "Problem" "Problem"
* 15-PROBLEM.1-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.1-PRB ^extension.valueCode = #A
* 15-PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem)" "Variance (Problem)"
* 15-PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.2-VAR ^extension.valueCode = #A
* 15-PROBLEM.3-PARTICIPATION_PROBLEM 0..* BackboneElement "PARTICIPATION_PROBLEM" "PARTICIPATION_PROBLEM"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT 1..1 BackboneElement "PARTICIPATION_PROBLEM_OBJECT" "PARTICIPATION_PROBLEM_OBJECT"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_PROBLEM_OBJECT"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Problem Role)" "Choice 2 within PARTICIPATION_PROBLEM_OBJECT"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Problem Role)" "Choice 3 within PARTICIPATION_PROBLEM_OBJECT"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem Role)" "Variance (Problem Role)"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.valueCode = #A
* 15-PROBLEM.4-PROBLEM_OBSERVATION 0..* BackboneElement "PROBLEM_OBSERVATION" "PROBLEM_OBSERVATION"
* 15-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 15-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT ^extension.valueCode = #A
* 16-GOAL 0..* BackboneElement "GOAL" "GOAL"
* 16-GOAL.1-GOL 1..1 http://hl7.org/v2/StructureDefinition/GOL "Goal" "Goal"
* 16-GOAL.1-GOL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.1-GOL ^extension.valueCode = #A
* 16-GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal)" "Variance (Goal)"
* 16-GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.2-VAR ^extension.valueCode = #A
* 16-GOAL.3-PARTICIPATION_GOAL 0..* BackboneElement "PARTICIPATION_GOAL" "PARTICIPATION_GOAL"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT 1..1 BackboneElement "PARTICIPATION_GOAL_OBJECT" "PARTICIPATION_GOAL_OBJECT"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_GOAL_OBJECT"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Goal Role)" "Choice 2 within PARTICIPATION_GOAL_OBJECT"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Goal Role)" "Choice 3 within PARTICIPATION_GOAL_OBJECT"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 16-GOAL.3-PARTICIPATION_GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal Role)" "Variance (Goal Role)"
* 16-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.valueCode = #A
* 16-GOAL.4-GOAL_OBSERVATION 0..* BackboneElement "GOAL_OBSERVATION" "GOAL_OBSERVATION"
* 16-GOAL.4-GOAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 16-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 16-GOAL.4-GOAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 16-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 17-PATHWAY 0..* BackboneElement "PATHWAY" "PATHWAY"
* 17-PATHWAY.1-PTH 1..1 http://hl7.org/v2/StructureDefinition/PTH "Pathway" "Pathway"
* 17-PATHWAY.1-PTH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.1-PTH ^extension.valueCode = #A
* 17-PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway)" "Variance (Pathway)"
* 17-PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.2-VAR ^extension.valueCode = #A
* 17-PATHWAY.3-PARTICIPATION_PATHWAY 0..* BackboneElement "PARTICIPATION_PATHWAY" "PARTICIPATION_PATHWAY"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT 1..1 BackboneElement "PARTICIPATION_PATHWAY_OBJECT" "PARTICIPATION_PATHWAY_OBJECT"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Pathway Participation)" "Choice 1 within PARTICIPATION_PATHWAY_OBJECT"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-PRT ^extension.valueCode = #A
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Pathway Participation)" "Choice 2 within PARTICIPATION_PATHWAY_OBJECT"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRD ^extension.valueCode = #A
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway Participation)" "Variance (Pathway Participation)"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.valueCode = #A
* 17-PATHWAY.4-PATHWAY_OBSERVATION 0..* BackboneElement "PATHWAY_OBSERVATION" "PATHWAY_OBSERVATION"
* 17-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 17-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 17-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 18-REL 0..* http://hl7.org/v2/StructureDefinition/REL "Relationship" "Relationship"
* 18-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-REL ^extension.valueCode = #A