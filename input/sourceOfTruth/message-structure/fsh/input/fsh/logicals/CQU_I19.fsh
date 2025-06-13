Logical: CQU_I19
Parent: V2MessageStructure
Id: CQU_I19
Title: "HL7 v2 CQU_I19 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CQU_I19"
* ^date = "2025-06-13T21:11:36Z"
* . ^short = "CQU_I19"
* . ^definition = "CQU_I19 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-RF1 1..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 6-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RF1 ^extension.valueCode = #A
* 7-PROVIDER_CONTACT 0..* BackboneElement "PROVIDER_CONTACT" "PROVIDER_CONTACT"
* 7-PROVIDER_CONTACT.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 7-PROVIDER_CONTACT.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER_CONTACT.1-PRD ^extension.valueCode = #A
* 7-PROVIDER_CONTACT.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-PROVIDER_CONTACT.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PROVIDER_CONTACT.2-CTD ^extension.valueCode = #A
* 8-PATIENT 0..* BackboneElement "PATIENT" "PATIENT"
* 8-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PATIENT.1-PID ^extension.valueCode = #A
* 8-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 8-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PATIENT.2-PD1 ^extension.valueCode = #A