Logical: BAR_P12
Parent: V2MessageStructure
Id: BAR_P12
Title: "HL7 v2 BAR_P12 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "BAR_P12"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "BAR_P12"
* . ^definition = "BAR_P12 Message Structure"
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
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PRT ^extension.valueCode = #A
* 7-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 7-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PV1 ^extension.valueCode = #A
* 8-DIAGNOSIS 0..* BackboneElement "DIAGNOSIS" "DIAGNOSIS"
* 8-DIAGNOSIS.1-DG1 1..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 8-DIAGNOSIS.1-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-DIAGNOSIS.1-DG1 ^extension.valueCode = #A
* 9-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 9-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DRG ^extension.valueCode = #A
* 10-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 10-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedures" "Procedures"
* 10-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 10-PROCEDURE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PROCEDURE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PROCEDURE.2-PRT ^extension.valueCode = #A
* 10-PROCEDURE.3-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 10-PROCEDURE.3-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PROCEDURE.3-ROL ^extension.valueCode = #B
* 11-OBX 0..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 11-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-OBX ^extension.valueCode = #A
* 12-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-PRT ^extension.valueCode = #A