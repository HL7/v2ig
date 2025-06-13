Logical: ADT_A01-D
Parent: V2MessageStructure
Id: ADT_A01-D
Title: "HL7 v2 ADT_A01-D Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A01-D"
* ^date = "2025-06-13T21:11:30Z"
* . ^short = "ADT_A01-D"
* . ^definition = "ADT_A01-D Message Structure"
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
* 5-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 5-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-EVN ^extension.valueCode = #A
* 6-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 6-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PID ^extension.valueCode = #A
* 7-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 7-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PD1 ^extension.valueCode = #A
* 8-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSP ^extension.valueCode = #A
* 9-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSR ^extension.valueCode = #A
* 10-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 10-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GSC ^extension.valueCode = #A
* 11-OH1 0..* http://hl7.org/v2/StructureDefinition/OH1 "Employment Status" "Employment Status"
* 11-OH1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-OH1 ^extension.valueCode = #A
* 12-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 12-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-OH2 ^extension.valueCode = #A
* 13-OH3 0..* http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 13-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-OH3 ^extension.valueCode = #A
* 14-OH4 0..* http://hl7.org/v2/StructureDefinition/OH4 "Combat Zone Work" "Combat Zone Work"
* 14-OH4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-OH4 ^extension.valueCode = #A
* 15-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 15-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-ARV ^extension.valueCode = #B
* 16-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 16-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-ROL ^extension.valueCode = #B
* 17-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PRT ^extension.valueCode = #A
* 18-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 18-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 18-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 18-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 18-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 18-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 18-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 18-NEXT_OF_KIN.4-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 18-NEXT_OF_KIN.4-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-NEXT_OF_KIN.4-OH2 ^extension.valueCode = #A
* 18-NEXT_OF_KIN.5-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 18-NEXT_OF_KIN.5-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-NEXT_OF_KIN.5-OH3 ^extension.valueCode = #A
* 19-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 19-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PV1 ^extension.valueCode = #A
* 20-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info." "Patient Visit - Additional Info."
* 20-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-PV2 ^extension.valueCode = #A
* 21-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 21-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 21-ARV ^extension.valueCode = #B
* 22-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 22-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 22-ROL ^extension.valueCode = #B
* 23-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 23-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 23-PRT ^extension.valueCode = #A
* 24-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 24-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-DB1 ^extension.valueCode = #A
* 25-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 25-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 25-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 25-OBSERVATION.1-OBX ^extension.valueCode = #A
* 25-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 25-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 25-OBSERVATION.2-PRT ^extension.valueCode = #A
* 26-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 26-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 26-AL1 ^extension.valueCode = #A
* 27-IAM 0..* http://hl7.org/v2/StructureDefinition/IAM "Patient Adverse Reaction Information" "Patient Adverse Reaction Information"
* 27-IAM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 27-IAM ^extension.valueCode = #A
* 28-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis Information" "Diagnosis Information"
* 28-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 28-DG1 ^extension.valueCode = #A
* 29-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 29-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 29-DRG ^extension.valueCode = #A
* 30-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 30-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedures" "Procedures"
* 30-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 30-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 30-PROCEDURE.2-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 30-PROCEDURE.2-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 30-PROCEDURE.2-ROL ^extension.valueCode = #B
* 30-PROCEDURE.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 30-PROCEDURE.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 30-PROCEDURE.3-PRT ^extension.valueCode = #A
* 31-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 31-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 31-GT1 ^extension.valueCode = #A
* 32-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 32-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 32-GSP ^extension.valueCode = #A
* 33-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 33-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 33-GSR ^extension.valueCode = #A
* 34-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 34-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 34-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.1-IN1 ^extension.valueCode = #A
* 34-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info." "Insurance Additional Info."
* 34-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.2-IN2 ^extension.valueCode = #A
* 34-INSURANCE.3-IN3 0..* http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Info - Cert." "Insurance Additional Info - Cert."
* 34-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.3-IN3 ^extension.valueCode = #A
* 34-INSURANCE.4-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 34-INSURANCE.4-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.4-GSP ^extension.valueCode = #A
* 34-INSURANCE.5-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 34-INSURANCE.5-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.5-GSR ^extension.valueCode = #A
* 34-INSURANCE.6-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 34-INSURANCE.6-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.6-ROL ^extension.valueCode = #B
* 34-INSURANCE.7-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 34-INSURANCE.7-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.7-PRT ^extension.valueCode = #A
* 34-INSURANCE.8-AUTHORIZATION 0..* BackboneElement "AUTHORIZATION" "AUTHORIZATION"
* 34-INSURANCE.8-AUTHORIZATION.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Record" "Authorization Record"
* 34-INSURANCE.8-AUTHORIZATION.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.8-AUTHORIZATION.1-AUT ^extension.valueCode = #A
* 34-INSURANCE.8-AUTHORIZATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 34-INSURANCE.8-AUTHORIZATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.8-AUTHORIZATION.2-PRT ^extension.valueCode = #A
* 34-INSURANCE.9-REFERRAL 0..* BackboneElement "REFERRAL" "REFERRAL"
* 34-INSURANCE.9-REFERRAL.1-RF1 1..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 34-INSURANCE.9-REFERRAL.1-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.9-REFERRAL.1-RF1 ^extension.valueCode = #A
* 34-INSURANCE.9-REFERRAL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 34-INSURANCE.9-REFERRAL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 34-INSURANCE.9-REFERRAL.2-PRT ^extension.valueCode = #A
* 35-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 35-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 35-ACC ^extension.valueCode = #A
* 36-UB1 0..1 http://hl7.org/v2/StructureDefinition/UB1 "Universal Bill Information" "Universal Bill Information"
* 36-UB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 36-UB1 ^extension.valueCode = #A
* 37-UB2 0..1 http://hl7.org/v2/StructureDefinition/UB2 "Universal Bill 92 Information" "Universal Bill 92 Information"
* 37-UB2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 37-UB2 ^extension.valueCode = #A
* 38-PDA 0..1 http://hl7.org/v2/StructureDefinition/PDA "Patient Death and Autopsy" "Patient Death and Autopsy"
* 38-PDA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 38-PDA ^extension.valueCode = #A