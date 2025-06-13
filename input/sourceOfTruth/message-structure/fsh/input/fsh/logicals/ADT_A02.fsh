Logical: ADT_A02
Parent: V2MessageStructure
Id: ADT_A02
Title: "HL7 v2 ADT_A02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A02"
* ^date = "2025-06-13T21:11:30Z"
* . ^short = "ADT_A02"
* . ^definition = "ADT_A02 Message Structure"
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
* 13-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
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
* 18-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 18-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PV1 ^extension.valueCode = #A
* 19-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info." "Patient Visit - Additional Info."
* 19-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-PV2 ^extension.valueCode = #A
* 20-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 20-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-ARV ^extension.valueCode = #B
* 21-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 21-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 21-ROL ^extension.valueCode = #B
* 22-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 22-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 22-PRT ^extension.valueCode = #A
* 23-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 23-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 23-DB1 ^extension.valueCode = #A
* 24-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 24-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 24-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-OBSERVATION.1-OBX ^extension.valueCode = #A
* 24-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 24-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 24-OBSERVATION.2-PRT ^extension.valueCode = #A
* 25-PDA 0..1 http://hl7.org/v2/StructureDefinition/PDA "Patient Death and Autopsy" "Patient Death and Autopsy"
* 25-PDA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 25-PDA ^extension.valueCode = #A