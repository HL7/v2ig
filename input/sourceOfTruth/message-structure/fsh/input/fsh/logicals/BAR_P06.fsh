Logical: BAR_P06
Parent: V2MessageStructure
Id: BAR_P06
Title: "HL7 v2 BAR_P06 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "BAR_P06"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "BAR_P06"
* . ^definition = "BAR_P06 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-PATIENT 1..* BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.2-PRT ^extension.valueCode = #A
* 5-PATIENT.3-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT.3-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.3-PV1 ^extension.valueCode = #A