Logical: CCU_I20
Parent: V2MessageStructure
Id: CCU_I20
Title: "HL7 v2 CCU_I20 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CCU_I20"
* ^date = "2025-06-13T21:11:36Z"
* . ^short = "CCU_I20"
* . ^definition = "CCU_I20 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-RF1 1..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-RF1 ^extension.valueCode = #A
* 5-PROVIDER_CONTACT 0..* BackboneElement "PROVIDER_CONTACT" "PROVIDER_CONTACT"
* 5-PROVIDER_CONTACT.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 5-PROVIDER_CONTACT.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.1-PRD ^extension.valueCode = #A
* 5-PROVIDER_CONTACT.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-PROVIDER_CONTACT.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.2-CTD ^extension.valueCode = #A
* 6-PATIENT 0..* BackboneElement "PATIENT" "PATIENT"
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
* 7-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 7-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 7-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 7-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 7-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 8-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 8-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 8-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-INSURANCE.1-IN1 ^extension.valueCode = #A
* 8-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info." "Insurance Additional Info."
* 8-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-INSURANCE.2-IN2 ^extension.valueCode = #A
* 8-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Info – Cert." "Insurance Additional Info – Cert."
* 8-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-INSURANCE.3-IN3 ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY 0..* BackboneElement "APPOINTMENT_HISTORY" "APPOINTMENT_HISTORY"
* 9-APPOINTMENT_HISTORY.1-SCH 1..1 http://hl7.org/v2/StructureDefinition/SCH "Schedule Activity Information" "Schedule Activity Information"
* 9-APPOINTMENT_HISTORY.1-SCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.1-SCH ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES 0..* BackboneElement "RESOURCES" "RESOURCES"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS 1..1 http://hl7.org/v2/StructureDefinition/RGS "Resource Group Segment" "Resource Group Segment"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL 0..* BackboneElement "RESOURCE_DETAIL" "RESOURCE_DETAIL"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT 1..1 BackboneElement "RESOURCE_OBJECT" "RESOURCE_OBJECT"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS 0..1 http://hl7.org/v2/StructureDefinition/AIS "Appointment Information - Service" "Choice 1 within RESOURCE_OBJECT"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG 0..1 http://hl7.org/v2/StructureDefinition/AIG "Appointment Information – General Resource" "Choice 2 within RESOURCE_OBJECT"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL 0..1 http://hl7.org/v2/StructureDefinition/AIL "Appointment Information – Location" "Choice 3 within RESOURCE_OBJECT"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP 0..1 http://hl7.org/v2/StructureDefinition/AIP "Appointment Information – Personnel" "Choice 4 within RESOURCE_OBJECT"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION 0..* BackboneElement "RESOURCE_OBSERVATION" "RESOURCE_OBSERVATION"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.valueCode = #A
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-CLINICAL_HISTORY 0..* BackboneElement "CLINICAL_HISTORY" "CLINICAL_HISTORY"
* 10-CLINICAL_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 10-CLINICAL_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.1-ORC ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL 0..* BackboneElement "CLINICAL_HISTORY_DETAIL" "CLINICAL_HISTORY_DETAIL"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "CLINICAL_HISTORY_OBJECT" "CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group 0..1 BackboneElement "Choice 1 within CLINICAL_HISTORY_OBJECT" "Choice 1 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS 0..1 http://hl7.org/v2/StructureDefinition/ODS "Dietary Order, Suppl., Prefer." "Choice 2 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 0..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Choice 3 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Choice 4 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 0..1 http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Choice 5 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM 0..1 http://hl7.org/v2/StructureDefinition/IAM "Patient adverse reaction information" "Choice 6 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Choice 7 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI 0..1 http://hl7.org/v2/StructureDefinition/RMI "Risk Management Incident" "Choice 8 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 0..1 http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Choice 9 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 0..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Choice 10 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Choice 11 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA 0..1 http://hl7.org/v2/StructureDefinition/PDA "Patient Death and Autopsy" "Choice 12 within CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-12-PDA ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION 0..* BackboneElement "CLINICAL_HISTORY_OBSERVATION" "CLINICAL_HISTORY_OBSERVATION"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY 0..* BackboneElement "PARTICIPATION_CLINICAL_HISTORY" "PARTICIPATION_CLINICAL_HISTORY"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "PARTICIPATION_CLINICAL_HISTORY_OBJECT" "PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (CLINICAL_HISTORY)" "Choice 2 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (CLINICAL_HISTORY)" "Choice 3 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (CLINICAL_HISTORY)" "Variance (CLINICAL_HISTORY)"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.valueCode = #A
* 10-CLINICAL_HISTORY.4-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 10-CLINICAL_HISTORY.4-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-CLINICAL_HISTORY.4-CTI ^extension.valueCode = #A
* 11-PATIENT_VISITS 1..* BackboneElement "PATIENT_VISITS" "PATIENT_VISITS"
* 11-PATIENT_VISITS.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 11-PATIENT_VISITS.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PATIENT_VISITS.1-PV1 ^extension.valueCode = #A
* 11-PATIENT_VISITS.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info." "Patient Visit – Additional Info."
* 11-PATIENT_VISITS.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PATIENT_VISITS.2-PV2 ^extension.valueCode = #A
* 12-MEDICATION_HISTORY 0..* BackboneElement "MEDICATION_HISTORY" "MEDICATION_HISTORY"
* 12-MEDICATION_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 12-MEDICATION_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.1-ORC ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL 0..1 BackboneElement "MEDICATION_ORDER_DETAIL" "MEDICATION_ORDER_DETAIL"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXO)" "Pharmacy/Treatment Component (for RXO)"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION 0..* BackboneElement "MEDICATION_ORDER_OBSERVATION" "MEDICATION_ORDER_OBSERVATION"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL 0..1 BackboneElement "MEDICATION_ENCODING_DETAIL" "MEDICATION_ENCODING_DETAIL"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXE)" "Pharmacy/Treatment Component (for RXE)"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION 0..* BackboneElement "MEDICATION_ENCODING_OBSERVATION" "MEDICATION_ENCODING_OBSERVATION"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL 0..* BackboneElement "MEDICATION_ADMINISTRATION_DETAIL" "MEDICATION_ADMINISTRATION_DETAIL"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR 1..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION 0..* BackboneElement "MEDICATION_ADMINISTRATION_OBSERVATION" "MEDICATION_ADMINISTRATION_OBSERVATION"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.valueCode = #A
* 12-MEDICATION_HISTORY.5-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 12-MEDICATION_HISTORY.5-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-MEDICATION_HISTORY.5-CTI ^extension.valueCode = #A
* 13-PROBLEM 0..* BackboneElement "PROBLEM" "PROBLEM"
* 13-PROBLEM.1-PRB 1..1 http://hl7.org/v2/StructureDefinition/PRB "Problem" "Problem"
* 13-PROBLEM.1-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.1-PRB ^extension.valueCode = #A
* 13-PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem)" "Variance (Problem)"
* 13-PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.2-VAR ^extension.valueCode = #A
* 13-PROBLEM.3-PARTICIPATION_PROBLEM 0..* BackboneElement "PARTICIPATION_PROBLEM" "PARTICIPATION_PROBLEM"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT 1..1 BackboneElement "PARTICIPATION_PROBLEM_OBJECT" "PARTICIPATION_PROBLEM_OBJECT"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_PROBLEM_OBJECT"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Problem Role)" "Choice 2 within PARTICIPATION_PROBLEM_OBJECT"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Problem Role)" "Choice 3 within PARTICIPATION_PROBLEM_OBJECT"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem Role)" "Variance (Problem Role)"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.valueCode = #A
* 13-PROBLEM.4-PROBLEM_OBSERVATION 0..* BackboneElement "PROBLEM_OBSERVATION" "PROBLEM_OBSERVATION"
* 13-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 13-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.4-PROBLEM_OBSERVATION.1-OBX ^extension.valueCode = #A
* 13-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PROBLEM.4-PROBLEM_OBSERVATION.2-PRT ^extension.valueCode = #A
* 14-GOAL 0..* BackboneElement "GOAL" "GOAL"
* 14-GOAL.1-GOL 1..1 http://hl7.org/v2/StructureDefinition/GOL "Goal" "Goal"
* 14-GOAL.1-GOL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.1-GOL ^extension.valueCode = #A
* 14-GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal)" "Variance (Goal)"
* 14-GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.2-VAR ^extension.valueCode = #A
* 14-GOAL.3-PARTICIPATION_GOAL 0..* BackboneElement "PARTICIPATION_GOAL" "PARTICIPATION_GOAL"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT 1..1 BackboneElement "PARTICIPATION_GOAL_OBJECT" "PARTICIPATION_GOAL_OBJECT"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_GOAL_OBJECT"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Goal Role)" "Choice 2 within PARTICIPATION_GOAL_OBJECT"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Goal Role)" "Choice 3 within PARTICIPATION_GOAL_OBJECT"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 14-GOAL.3-PARTICIPATION_GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal Role)" "Variance (Goal Role)"
* 14-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.valueCode = #A
* 14-GOAL.4-GOAL_OBSERVATION 0..* BackboneElement "GOAL_OBSERVATION" "GOAL_OBSERVATION"
* 14-GOAL.4-GOAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 14-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-GOAL.4-GOAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-PATHWAY 0..* BackboneElement "PATHWAY" "PATHWAY"
* 15-PATHWAY.1-PTH 1..1 http://hl7.org/v2/StructureDefinition/PTH "Pathway" "Pathway"
* 15-PATHWAY.1-PTH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.1-PTH ^extension.valueCode = #A
* 15-PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway)" "Variance (Pathway)"
* 15-PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.2-VAR ^extension.valueCode = #A
* 15-PATHWAY.3-PARTICIPATION_PATHWAY 0..* BackboneElement "PARTICIPATION_PATHWAY" "PARTICIPATION_PATHWAY"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT 1..1 BackboneElement "PARTICIPATION_PATHWAY_OBJECT" "PARTICIPATION_PATHWAY_OBJECT"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_PATHWAY_OBJECT"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Pathway Participation)" "Choice 2 within PARTICIPATION_PATHWAY_OBJECT"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Pathway Participation)" "Choice 3 within PARTICIPATION_PATHWAY_OBJECT"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway Participation)" "Variance (Pathway Participation)"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.valueCode = #A
* 15-PATHWAY.4-PATHWAY_OBSERVATION 0..* BackboneElement "PATHWAY_OBSERVATION" "PATHWAY_OBSERVATION"
* 15-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 15-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 16-REL 0..* http://hl7.org/v2/StructureDefinition/REL "Relationship" "Relationship"
* 16-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-REL ^extension.valueCode = #A