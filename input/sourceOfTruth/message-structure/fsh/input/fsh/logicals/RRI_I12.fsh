Logical: RRI_I12
Parent: V2MessageStructure
Id: RRI_I12
Title: "HL7 v2 RRI_I12 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RRI_I12"
* ^date = "2025-06-13T21:11:34Z"
* . ^short = "RRI_I12"
* . ^definition = "RRI_I12 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software segment" "Software segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 0..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-RF1 0..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 5-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-RF1 ^extension.valueCode = #A
* 6-AUTHORIZATION_CONTACT2 0..1 BackboneElement "AUTHORIZATION_CONTACT2" "AUTHORIZATION_CONTACT2"
* 6-AUTHORIZATION_CONTACT2.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 6-AUTHORIZATION_CONTACT2.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_CONTACT2.1-AUT ^extension.valueCode = #A
* 6-AUTHORIZATION_CONTACT2.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 6-AUTHORIZATION_CONTACT2.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_CONTACT2.2-CTD ^extension.valueCode = #A
* 7-PROVIDER_CONTACT 1..* BackboneElement "PROVIDER_CONTACT" "PROVIDER_CONTACT"
* 7-PROVIDER_CONTACT.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 7-PROVIDER_CONTACT.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER_CONTACT.1-PRD ^extension.valueCode = #A
* 7-PROVIDER_CONTACT.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-PROVIDER_CONTACT.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER_CONTACT.2-CTD ^extension.valueCode = #A
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
* 12-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 12-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-ACC ^extension.valueCode = #A
* 13-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 13-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-DG1 ^extension.valueCode = #A
* 14-DRG 0..* http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 14-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-DRG ^extension.valueCode = #A
* 15-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 15-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-AL1 ^extension.valueCode = #A
* 16-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 16-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Procedure"
* 16-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2 0..1 BackboneElement "AUTHORIZATION_CONTACT2" "AUTHORIZATION_CONTACT2"
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.1-AUT 1..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.1-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.1-AUT ^extension.valueCode = #A
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.2-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PROCEDURE.2-AUTHORIZATION_CONTACT2.2-CTD ^extension.valueCode = #A
* 17-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 17-OBSERVATION.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 17-OBSERVATION.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.1-OBR ^extension.valueCode = #A
* 17-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.2-PRT ^extension.valueCode = #A
* 17-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (Observation Request)" "Notes and Comments (Observation Request)"
* 17-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.3-NTE ^extension.valueCode = #A
* 17-OBSERVATION.4-RESULTS_NOTES 0..* BackboneElement "RESULTS_NOTES" "RESULTS_NOTES"
* 17-OBSERVATION.4-RESULTS_NOTES.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 17-OBSERVATION.4-RESULTS_NOTES.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.4-RESULTS_NOTES.1-OBX ^extension.valueCode = #A
* 17-OBSERVATION.4-RESULTS_NOTES.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-OBSERVATION.4-RESULTS_NOTES.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.4-RESULTS_NOTES.2-PRT ^extension.valueCode = #A
* 17-OBSERVATION.4-RESULTS_NOTES.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 17-OBSERVATION.4-RESULTS_NOTES.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-OBSERVATION.4-RESULTS_NOTES.3-NTE ^extension.valueCode = #A
* 18-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 18-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 18-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 18-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit Additional Info" "Patient Visit Additional Info"
* 18-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 19-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 19-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-NTE ^extension.valueCode = #A