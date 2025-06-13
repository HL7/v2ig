Logical: CCF_I22
Parent: V2MessageStructure
Id: CCF_I22
Title: "HL7 v2 CCF_I22 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CCF_I22"
* ^date = "2025-06-13T21:11:36Z"
* . ^short = "CCF_I22"
* . ^definition = "CCF_I22 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 4-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PID ^extension.valueCode = #A
* 5-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-GSP ^extension.valueCode = #A
* 6-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 6-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSR ^extension.valueCode = #A
* 7-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 7-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSC ^extension.valueCode = #A