Logical: ADT_A24
Parent: V2MessageStructure
Id: ADT_A24
Title: "HL7 v2 ADT_A24 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A24"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "ADT_A24"
* . ^definition = "ADT_A24 Message Structure"
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
* 6-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient (1) Identification" "Patient (1) Identification"
* 6-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PID ^extension.valueCode = #A
* 7-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Patient (1) Additional Demographics" "Patient (1) Additional Demographics"
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
* 11-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient (1) Visit" "Patient (1) Visit"
* 11-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PV1 ^extension.valueCode = #A
* 12-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Patient (1) Disability Information" "Patient (1) Disability Information"
* 12-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-DB1 ^extension.valueCode = #A
* 13-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient (2) Identification" "Patient (2) Identification"
* 13-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PID ^extension.valueCode = #A
* 14-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Patient (2) Additional Demographics" "Patient (2) Additional Demographics"
* 14-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PD1 ^extension.valueCode = #A
* 15-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 15-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-GSP ^extension.valueCode = #A
* 16-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 16-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GSR ^extension.valueCode = #A
* 17-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 17-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-GSC ^extension.valueCode = #A
* 18-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient (2) Visit" "Patient (2) Visit"
* 18-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PV1 ^extension.valueCode = #A
* 19-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Patient (2) Disability Information" "Patient (2) Disability Information"
* 19-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-DB1 ^extension.valueCode = #A