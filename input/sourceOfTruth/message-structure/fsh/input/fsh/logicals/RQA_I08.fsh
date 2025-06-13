Logical: RQA_I08
Parent: V2MessageStructure
Id: RQA_I08
Title: "HL7 v2 RQA_I08 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RQA_I08"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "RQA_I08"
* . ^definition = "RQA_I08 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software segment" "Software segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-RF1 ^extension.valueCode = #A
* 5-AUTHORIZATION 0..1 BackboneElement "AUTHORIZATION" "AUTHORIZATION"
* 5-AUTHORIZATION.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 5-AUTHORIZATION.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-AUTHORIZATION.1-AUT ^extension.valueCode = #A
* 5-AUTHORIZATION.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-AUTHORIZATION.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-AUTHORIZATION.2-CTD ^extension.valueCode = #A
* 6-PROVIDER 1..* BackboneElement "PROVIDER" "PROVIDER"
* 6-PROVIDER.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 6-PROVIDER.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PROVIDER.1-PRD ^extension.valueCode = #A
* 6-PROVIDER.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 6-PROVIDER.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PROVIDER.2-CTD ^extension.valueCode = #A
* 7-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 7-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PID ^extension.valueCode = #A
* 8-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSP ^extension.valueCode = #A
* 9-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSR ^extension.valueCode = #A
* 10-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 10-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GSC ^extension.valueCode = #A
* 11-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 11-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 11-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 11-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 11-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 11-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 11-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 12-GUARANTOR_INSURANCE 0..1 BackboneElement "GUARANTOR_INSURANCE" "GUARANTOR_INSURANCE"
* 12-GUARANTOR_INSURANCE.1-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 12-GUARANTOR_INSURANCE.1-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GUARANTOR_INSURANCE.1-GT1 ^extension.valueCode = #A
* 12-GUARANTOR_INSURANCE.2-INSURANCE 1..* BackboneElement "INSURANCE" "INSURANCE"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 ^extension.valueCode = #A
* 12-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 ^extension.valueCode = #A
* 12-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Add'l Info - Cert" "Insurance Add'l Info - Cert"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 ^extension.valueCode = #A
* 13-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 13-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-ACC ^extension.valueCode = #A
* 14-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 14-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-DG1 ^extension.valueCode = #A
* 15-DRG 0..* http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 15-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-DRG ^extension.valueCode = #A
* 16-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 16-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-AL1 ^extension.valueCode = #A
* 17-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 17-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Procedure"
* 17-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 17-PROCEDURE.2-AUTHORIZATION 0..1 BackboneElement "AUTHORIZATION" "AUTHORIZATION"
* 17-PROCEDURE.2-AUTHORIZATION.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 17-PROCEDURE.2-AUTHORIZATION.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PROCEDURE.2-AUTHORIZATION.1-AUT ^extension.valueCode = #A
* 17-PROCEDURE.2-AUTHORIZATION.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 17-PROCEDURE.2-AUTHORIZATION.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PROCEDURE.2-AUTHORIZATION.2-CTD ^extension.valueCode = #A
* 18-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 18-OBSERVATION.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 18-OBSERVATION.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.1-OBR ^extension.valueCode = #A
* 18-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 18-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.2-PRT ^extension.valueCode = #A
* 18-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (Observation Request)" "Notes and Comments (Observation Request)"
* 18-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.3-NTE ^extension.valueCode = #A
* 18-OBSERVATION.4-RESULTS 0..* BackboneElement "RESULTS" "RESULTS"
* 18-OBSERVATION.4-RESULTS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 18-OBSERVATION.4-RESULTS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.4-RESULTS.1-OBX ^extension.valueCode = #A
* 18-OBSERVATION.4-RESULTS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 18-OBSERVATION.4-RESULTS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.4-RESULTS.2-PRT ^extension.valueCode = #A
* 18-OBSERVATION.4-RESULTS.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 18-OBSERVATION.4-RESULTS.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-OBSERVATION.4-RESULTS.3-NTE ^extension.valueCode = #A
* 19-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 19-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 19-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-VISIT.1-PV1 ^extension.valueCode = #A
* 19-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit Additional Info" "Patient Visit Additional Info"
* 19-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-VISIT.2-PV2 ^extension.valueCode = #A
* 20-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 20-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-NTE ^extension.valueCode = #A