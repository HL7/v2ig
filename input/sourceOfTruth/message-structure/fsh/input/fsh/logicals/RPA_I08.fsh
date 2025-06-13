Logical: RPA_I08
Parent: V2MessageStructure
Id: RPA_I08
Title: "HL7 v2 RPA_I08 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RPA_I08"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "RPA_I08"
* . ^definition = "RPA_I08 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software segment" "Software segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 5-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-RF1 ^extension.valueCode = #A
* 6-AUTHORIZATION 0..1 BackboneElement "AUTHORIZATION" "AUTHORIZATION"
* 6-AUTHORIZATION.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 6-AUTHORIZATION.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION.1-AUT ^extension.valueCode = #A
* 6-AUTHORIZATION.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 6-AUTHORIZATION.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION.2-CTD ^extension.valueCode = #A
* 7-PROVIDER 1..* BackboneElement "PROVIDER" "PROVIDER"
* 7-PROVIDER.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 7-PROVIDER.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER.1-PRD ^extension.valueCode = #A
* 7-PROVIDER.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-PROVIDER.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER.2-CTD ^extension.valueCode = #A
* 8-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PID ^extension.valueCode = #A
* 9-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSP ^extension.valueCode = #A
* 10-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 10-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GSR ^extension.valueCode = #A
* 11-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 11-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-GSC ^extension.valueCode = #A
* 12-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 12-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 12-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 12-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 12-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 12-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 12-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 13-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 13-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-GT1 ^extension.valueCode = #A
* 14-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 14-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 14-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-INSURANCE.1-IN1 ^extension.valueCode = #A
* 14-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 14-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-INSURANCE.2-IN2 ^extension.valueCode = #A
* 14-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Add'l Info - Cert" "Insurance Add'l Info - Cert"
* 14-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-INSURANCE.3-IN3 ^extension.valueCode = #A
* 15-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 15-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-ACC ^extension.valueCode = #A
* 16-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 16-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-DG1 ^extension.valueCode = #A
* 17-DRG 0..* http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 17-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-DRG ^extension.valueCode = #A
* 18-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 18-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-AL1 ^extension.valueCode = #A
* 19-PROCEDURE 1..* BackboneElement "PROCEDURE" "PROCEDURE"
* 19-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Procedure"
* 19-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 19-PROCEDURE.2-AUTHORIZATION 0..1 BackboneElement "AUTHORIZATION" "AUTHORIZATION"
* 19-PROCEDURE.2-AUTHORIZATION.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 19-PROCEDURE.2-AUTHORIZATION.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PROCEDURE.2-AUTHORIZATION.1-AUT ^extension.valueCode = #A
* 19-PROCEDURE.2-AUTHORIZATION.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 19-PROCEDURE.2-AUTHORIZATION.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PROCEDURE.2-AUTHORIZATION.2-CTD ^extension.valueCode = #A
* 20-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 20-OBSERVATION.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 20-OBSERVATION.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.1-OBR ^extension.valueCode = #A
* 20-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 20-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.2-PRT ^extension.valueCode = #A
* 20-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (Observation Request)" "Notes and Comments (Observation Request)"
* 20-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.3-NTE ^extension.valueCode = #A
* 20-OBSERVATION.4-RESULTS 0..* BackboneElement "RESULTS" "RESULTS"
* 20-OBSERVATION.4-RESULTS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 20-OBSERVATION.4-RESULTS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.4-RESULTS.1-OBX ^extension.valueCode = #A
* 20-OBSERVATION.4-RESULTS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 20-OBSERVATION.4-RESULTS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.4-RESULTS.2-PRT ^extension.valueCode = #A
* 20-OBSERVATION.4-RESULTS.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 20-OBSERVATION.4-RESULTS.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION.4-RESULTS.3-NTE ^extension.valueCode = #A
* 21-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 21-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 21-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 21-VISIT.1-PV1 ^extension.valueCode = #A
* 21-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit Additional Info" "Patient Visit Additional Info"
* 21-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 21-VISIT.2-PV2 ^extension.valueCode = #A
* 22-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 22-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 22-NTE ^extension.valueCode = #A