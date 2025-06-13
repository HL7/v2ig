Logical: CCR_I16
Parent: V2MessageStructure
Id: CCR_I16
Title: "HL7 v2 CCR_I16 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CCR_I16"
* ^date = "2025-06-13T21:11:34Z"
* . ^short = "CCR_I16"
* . ^definition = "CCR_I16 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-RF1 1..* http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-RF1 ^extension.valueCode = #A
* 5-PROVIDER_CONTACT 1..* BackboneElement "PROVIDER_CONTACT" "PROVIDER_CONTACT"
* 5-PROVIDER_CONTACT.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 5-PROVIDER_CONTACT.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.1-PRD ^extension.valueCode = #A
* 5-PROVIDER_CONTACT.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-PROVIDER_CONTACT.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.2-CTD ^extension.valueCode = #A
* 6-CLINICAL_ORDER 0..* BackboneElement "CLINICAL_ORDER" "CLINICAL_ORDER"
* 6-CLINICAL_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 6-CLINICAL_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.1-ORC ^extension.valueCode = #A
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING 0..* BackboneElement "CLINICAL_ORDER_TIMING" "CLINICAL_ORDER_TIMING"
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.1-TQ1 ^extension.valueCode = #A
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.2-CLINICAL_ORDER_TIMING.2-TQ2 ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL 1..* BackboneElement "CLINICAL_ORDER_DETAIL" "CLINICAL_ORDER_DETAIL"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT 1..1 BackboneElement "CLINICAL_ORDER_OBJECT" "CLINICAL_ORDER_OBJECT"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group 0..1 BackboneElement "Choice 1 within CLINICAL_ORDER_OBJECT" "Choice 1 within CLINICAL_ORDER_OBJECT"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.1-OBR ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-1-Group.2-PRT ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group 0..1 BackboneElement "Choice 2 within CLINICAL_ORDER_OBJECT" "Choice 2 within CLINICAL_ORDER_OBJECT"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.1-RXO ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-2-Group.2-PRT ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-3-ODS 0..1 http://hl7.org/v2/StructureDefinition/ODS "Dietary Order, Suppl., Prefer." "Choice 3 within CLINICAL_ORDER_OBJECT"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-3-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-3-ODS ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-4-PR1 0..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Choice 4 within CLINICAL_ORDER_OBJECT"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-4-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.1-CLINICAL_ORDER_OBJECT.choice-4-PR1 ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION 0..* BackboneElement "CLINICAL_ORDER_OBSERVATION" "CLINICAL_ORDER_OBSERVATION"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.3-CLINICAL_ORDER_DETAIL.2-CLINICAL_ORDER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 6-CLINICAL_ORDER.4-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 6-CLINICAL_ORDER.4-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-CLINICAL_ORDER.4-CTI ^extension.valueCode = #A
* 7-PATIENT 1..* BackboneElement "PATIENT" "PATIENT"
* 7-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 7-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PATIENT.1-PID ^extension.valueCode = #A
* 7-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 7-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PATIENT.2-PD1 ^extension.valueCode = #A
* 7-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PATIENT.3-GSP ^extension.valueCode = #A
* 7-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PATIENT.4-GSR ^extension.valueCode = #A
* 7-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 7-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PATIENT.5-GSC ^extension.valueCode = #A
* 8-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 8-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 8-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 8-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 8-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 9-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 9-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 9-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-INSURANCE.1-IN1 ^extension.valueCode = #A
* 9-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info." "Insurance Additional Info."
* 9-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-INSURANCE.2-IN2 ^extension.valueCode = #A
* 9-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Info – Cert." "Insurance Additional Info – Cert."
* 9-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-INSURANCE.3-IN3 ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY 0..* BackboneElement "APPOINTMENT_HISTORY" "APPOINTMENT_HISTORY"
* 10-APPOINTMENT_HISTORY.1-SCH 1..1 http://hl7.org/v2/StructureDefinition/SCH "Schedule Activity Information" "Schedule Activity Information"
* 10-APPOINTMENT_HISTORY.1-SCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.1-SCH ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES 0..* BackboneElement "RESOURCES" "RESOURCES"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS 1..1 http://hl7.org/v2/StructureDefinition/RGS "Resource Group Segment" "Resource Group Segment"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.1-RGS ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL 0..* BackboneElement "RESOURCE_DETAIL" "RESOURCE_DETAIL"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT 1..1 BackboneElement "RESOURCE_OBJECT" "RESOURCE_OBJECT"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS 0..1 http://hl7.org/v2/StructureDefinition/AIS "Appointment Information - Service" "Choice 1 within RESOURCE_OBJECT"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-1-AIS ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG 0..1 http://hl7.org/v2/StructureDefinition/AIG "Appointment Information – General Resource" "Choice 2 within RESOURCE_OBJECT"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-2-AIG ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL 0..1 http://hl7.org/v2/StructureDefinition/AIL "Appointment Information – Location" "Choice 3 within RESOURCE_OBJECT"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-3-AIL ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP 0..1 http://hl7.org/v2/StructureDefinition/AIP "Appointment Information – Personnel" "Choice 4 within RESOURCE_OBJECT"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.1-RESOURCE_OBJECT.choice-4-AIP ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION 0..* BackboneElement "RESOURCE_OBSERVATION" "RESOURCE_OBSERVATION"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-APPOINTMENT_HISTORY.2-RESOURCES.2-RESOURCE_DETAIL.2-RESOURCE_OBSERVATION.2-PRT ^extension.valueCode = #A
* 11-CLINICAL_HISTORY 0..* BackboneElement "CLINICAL_HISTORY" "CLINICAL_HISTORY"
* 11-CLINICAL_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 11-CLINICAL_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.1-ORC ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL 0..* BackboneElement "CLINICAL_HISTORY_DETAIL" "CLINICAL_HISTORY_DETAIL"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "CLINICAL_HISTORY_OBJECT" "CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group 0..1 BackboneElement "Choice 1 within CLINICAL_HISTORY_OBJECT" "Choice 1 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.1-OBR ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-1-Group.2-PRT ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS 0..1 http://hl7.org/v2/StructureDefinition/ODS "Dietary Order, Suppl., Prefer." "Choice 2 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-2-ODS ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 0..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Choice 3 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-3-PR1 ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Choice 4 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-4-RF1 ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 0..1 http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Choice 5 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-5-AL1 ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM 0..1 http://hl7.org/v2/StructureDefinition/IAM "Patient adverse reaction information" "Choice 6 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-6-IAM ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Choice 7 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-7-ACC ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI 0..1 http://hl7.org/v2/StructureDefinition/RMI "Risk Management Incident" "Choice 8 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-8-RMI ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 0..1 http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Choice 9 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-9-DB1 ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 0..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Choice 10 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-10-DG1 ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Choice 11 within CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.1-CLINICAL_HISTORY_OBJECT.choice-11-DRG ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION 0..* BackboneElement "CLINICAL_HISTORY_OBSERVATION" "CLINICAL_HISTORY_OBSERVATION"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.2-CLINICAL_HISTORY_DETAIL.2-CLINICAL_HISTORY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY 0..* BackboneElement "PARTICIPATION_CLINICAL_HISTORY" "PARTICIPATION_CLINICAL_HISTORY"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT 1..1 BackboneElement "PARTICIPATION_CLINICAL_HISTORY_OBJECT" "PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (CLINICAL_HISTORY)" "Choice 2 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (CLINICAL_HISTORY)" "Choice 3 within PARTICIPATION_CLINICAL_HISTORY_OBJECT"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.1-PARTICIPATION_CLINICAL_HISTORY_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (CLINICAL_HISTORY)" "Variance (CLINICAL_HISTORY)"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.3-PARTICIPATION_CLINICAL_HISTORY.2-VAR ^extension.valueCode = #A
* 11-CLINICAL_HISTORY.4-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 11-CLINICAL_HISTORY.4-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-CLINICAL_HISTORY.4-CTI ^extension.valueCode = #A
* 12-PATIENT_VISITS 1..* BackboneElement "PATIENT_VISITS" "PATIENT_VISITS"
* 12-PATIENT_VISITS.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 12-PATIENT_VISITS.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-PATIENT_VISITS.1-PV1 ^extension.valueCode = #A
* 12-PATIENT_VISITS.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info." "Patient Visit – Additional Info."
* 12-PATIENT_VISITS.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-PATIENT_VISITS.2-PV2 ^extension.valueCode = #A
* 13-MEDICATION_HISTORY 0..* BackboneElement "MEDICATION_HISTORY" "MEDICATION_HISTORY"
* 13-MEDICATION_HISTORY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 13-MEDICATION_HISTORY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.1-ORC ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL 0..1 BackboneElement "MEDICATION_ORDER_DETAIL" "MEDICATION_ORDER_DETAIL"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.3-RXR ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXO)" "Pharmacy/Treatment Component (for RXO)"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.4-RXC ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION 0..* BackboneElement "MEDICATION_ORDER_OBSERVATION" "MEDICATION_ORDER_OBSERVATION"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.2-MEDICATION_ORDER_DETAIL.5-MEDICATION_ORDER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL 0..1 BackboneElement "MEDICATION_ENCODING_DETAIL" "MEDICATION_ENCODING_DETAIL"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.1-RXE ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.3-RXR ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXE)" "Pharmacy/Treatment Component (for RXE)"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.4-RXC ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION 0..* BackboneElement "MEDICATION_ENCODING_OBSERVATION" "MEDICATION_ENCODING_OBSERVATION"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.1-OBX ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.3-MEDICATION_ENCODING_DETAIL.5-MEDICATION_ENCODING_OBSERVATION.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL 0..* BackboneElement "MEDICATION_ADMINISTRATION_DETAIL" "MEDICATION_ADMINISTRATION_DETAIL"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.1-RXA ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR 1..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.3-RXR ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION 0..* BackboneElement "MEDICATION_ADMINISTRATION_OBSERVATION" "MEDICATION_ADMINISTRATION_OBSERVATION"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.1-OBX ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.4-MEDICATION_ADMINISTRATION_DETAIL.4-MEDICATION_ADMINISTRATION_OBSERVATION.2-PRT ^extension.valueCode = #A
* 13-MEDICATION_HISTORY.5-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 13-MEDICATION_HISTORY.5-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-MEDICATION_HISTORY.5-CTI ^extension.valueCode = #A
* 14-PROBLEM 0..* BackboneElement "PROBLEM" "PROBLEM"
* 14-PROBLEM.1-PRB 1..1 http://hl7.org/v2/StructureDefinition/PRB "Problem" "Problem"
* 14-PROBLEM.1-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.1-PRB ^extension.valueCode = #A
* 14-PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem)" "Variance (Problem)"
* 14-PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.2-VAR ^extension.valueCode = #A
* 14-PROBLEM.3-PARTICIPATION_PROBLEM 0..* BackboneElement "PARTICIPATION_PROBLEM" "PARTICIPATION_PROBLEM"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT 1..1 BackboneElement "PARTICIPATION_PROBLEM_OBJECT" "PARTICIPATION_PROBLEM_OBJECT"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_PROBLEM_OBJECT"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Problem Role)" "Choice 2 within PARTICIPATION_PROBLEM_OBJECT"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Problem Role)" "Choice 3 within PARTICIPATION_PROBLEM_OBJECT"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.1-PARTICIPATION_PROBLEM_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem Role)" "Variance (Problem Role)"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.3-PARTICIPATION_PROBLEM.2-VAR ^extension.valueCode = #A
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION 0..* BackboneElement "PARTICIPATION_OBSERVATION" "PARTICIPATION_OBSERVATION"
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PROBLEM.4-PARTICIPATION_OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-GOAL 0..* BackboneElement "GOAL" "GOAL"
* 15-GOAL.1-GOL 1..1 http://hl7.org/v2/StructureDefinition/GOL "Goal" "Goal"
* 15-GOAL.1-GOL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.1-GOL ^extension.valueCode = #A
* 15-GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal)" "Variance (Goal)"
* 15-GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.2-VAR ^extension.valueCode = #A
* 15-GOAL.3-PARTICIPATION_GOAL 0..* BackboneElement "PARTICIPATION_GOAL" "PARTICIPATION_GOAL"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT 1..1 BackboneElement "PARTICIPATION_GOAL_OBJECT" "PARTICIPATION_GOAL_OBJECT"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_GOAL_OBJECT"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Goal Role)" "Choice 2 within PARTICIPATION_GOAL_OBJECT"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Goal Role)" "Choice 3 within PARTICIPATION_GOAL_OBJECT"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.3-PARTICIPATION_GOAL.1-PARTICIPATION_GOAL_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 15-GOAL.3-PARTICIPATION_GOAL.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal Role)" "Variance (Goal Role)"
* 15-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.3-PARTICIPATION_GOAL.2-VAR ^extension.valueCode = #A
* 15-GOAL.4-GOAL_OBSERVATION 0..* BackboneElement "GOAL_OBSERVATION" "GOAL_OBSERVATION"
* 15-GOAL.4-GOAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 15-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.4-GOAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-GOAL.4-GOAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GOAL.4-GOAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 16-PATHWAY 0..* BackboneElement "PATHWAY" "PATHWAY"
* 16-PATHWAY.1-PTH 1..1 http://hl7.org/v2/StructureDefinition/PTH "Pathway" "Pathway"
* 16-PATHWAY.1-PTH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.1-PTH ^extension.valueCode = #A
* 16-PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway)" "Variance (Pathway)"
* 16-PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.2-VAR ^extension.valueCode = #A
* 16-PATHWAY.3-PARTICIPATION_PATHWAY 0..* BackboneElement "PARTICIPATION_PATHWAY" "PARTICIPATION_PATHWAY"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT 1..1 BackboneElement "PARTICIPATION_PATHWAY_OBJECT" "PARTICIPATION_PATHWAY_OBJECT"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "Choice 1 within PARTICIPATION_PATHWAY_OBJECT"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-1-ROL ^extension.valueCode = #B
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Pathway Participation)" "Choice 2 within PARTICIPATION_PATHWAY_OBJECT"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-2-PRT ^extension.valueCode = #A
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD 0..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data (Pathway Participation)" "Choice 3 within PARTICIPATION_PATHWAY_OBJECT"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.1-PARTICIPATION_PATHWAY_OBJECT.choice-3-PRD ^extension.valueCode = #A
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway Participation)" "Variance (Pathway Participation)"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.3-PARTICIPATION_PATHWAY.2-VAR ^extension.valueCode = #A
* 16-PATHWAY.4-PATHWAY_OBSERVATION 0..* BackboneElement "PATHWAY_OBSERVATION" "PATHWAY_OBSERVATION"
* 16-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 16-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.4-PATHWAY_OBSERVATION.1-OBX ^extension.valueCode = #A
* 16-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 16-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PATHWAY.4-PATHWAY_OBSERVATION.2-PRT ^extension.valueCode = #A
* 17-REL 0..* http://hl7.org/v2/StructureDefinition/REL "Relationship" "Relationship"
* 17-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REL ^extension.valueCode = #A