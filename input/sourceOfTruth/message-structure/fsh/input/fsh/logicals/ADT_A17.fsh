Logical: ADT_A17
Parent: V2MessageStructure
Id: ADT_A17
Title: "HL7 v2 ADT_A17 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A17"
* ^date = "2025-06-13T21:11:30Z"
* . ^short = "ADT_A17"
* . ^definition = "ADT_A17 Message Structure"
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
* 7-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSP ^extension.valueCode = #A
* 8-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSR ^extension.valueCode = #A
* 9-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSC ^extension.valueCode = #A
* 10-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 10-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PD1 ^extension.valueCode = #A
* 11-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient (1) Visit" "Patient (1) Visit"
* 11-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PV1 ^extension.valueCode = #A
* 12-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient (1) Visit - Additional Info." "Patient (1) Visit - Additional Info."
* 12-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-PV2 ^extension.valueCode = #A
* 13-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 13-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-DB1 ^extension.valueCode = #A
* 14-OBSERVATION_RESULT_1 0..* BackboneElement "OBSERVATION_RESULT_1" "OBSERVATION_RESULT_1"
* 14-OBSERVATION_RESULT_1.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result (1)" "Observation/Result (1)"
* 14-OBSERVATION_RESULT_1.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-OBSERVATION_RESULT_1.1-OBX ^extension.valueCode = #A
* 14-OBSERVATION_RESULT_1.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-OBSERVATION_RESULT_1.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-OBSERVATION_RESULT_1.2-PRT ^extension.valueCode = #A
* 15-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient (2) Identification" "Patient (2) Identification"
* 15-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PID ^extension.valueCode = #A
* 16-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 16-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PD1 ^extension.valueCode = #A
* 17-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient (2) Visit" "Patient (2) Visit"
* 17-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-PV1 ^extension.valueCode = #A
* 18-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient (2) Visit - Additional Info." "Patient (2) Visit - Additional Info."
* 18-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PV2 ^extension.valueCode = #A
* 19-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 19-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-DB1 ^extension.valueCode = #A
* 20-OBSERVATION_RESULT_2 0..* BackboneElement "OBSERVATION_RESULT_2" "OBSERVATION_RESULT_2"
* 20-OBSERVATION_RESULT_2.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result (2)" "Observation/Result (2)"
* 20-OBSERVATION_RESULT_2.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION_RESULT_2.1-OBX ^extension.valueCode = #A
* 20-OBSERVATION_RESULT_2.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 20-OBSERVATION_RESULT_2.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-OBSERVATION_RESULT_2.2-PRT ^extension.valueCode = #A