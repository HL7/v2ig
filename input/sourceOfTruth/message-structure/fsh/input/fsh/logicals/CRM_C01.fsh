Logical: CRM_C01
Parent: V2MessageStructure
Id: CRM_C01
Title: "HL7 v2 CRM_C01 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CRM_C01"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "CRM_C01"
* . ^definition = "CRM_C01 Message Structure"
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
* 5-PATIENT 1..* BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-PATIENT.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.2-GSP ^extension.valueCode = #A
* 5-PATIENT.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-PATIENT.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.3-GSR ^extension.valueCode = #A
* 5-PATIENT.4-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 5-PATIENT.4-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.4-GSC ^extension.valueCode = #A
* 5-PATIENT.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient" "Participation (for Patient"
* 5-PATIENT.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.5-PRT ^extension.valueCode = #A
* 5-PATIENT.6-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 5-PATIENT.6-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-ARV ^extension.valueCode = #B
* 5-PATIENT.7-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 5-PATIENT.7-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT.7-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.7-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 5-PATIENT.7-PATIENT_VISIT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit" "Participation (for Patient Visit"
* 5-PATIENT.7-PATIENT_VISIT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.7-PATIENT_VISIT.2-PRT ^extension.valueCode = #A
* 5-PATIENT.8-CSR 1..1 http://hl7.org/v2/StructureDefinition/CSR "Clinical Study Registration" "Clinical Study Registration"
* 5-PATIENT.8-CSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.8-CSR ^extension.valueCode = #A
* 5-PATIENT.9-CSP 0..* http://hl7.org/v2/StructureDefinition/CSP "Clinical Study Phase" "Clinical Study Phase"
* 5-PATIENT.9-CSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.9-CSP ^extension.valueCode = #A