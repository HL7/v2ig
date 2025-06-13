Logical: ADT_A60
Parent: V2MessageStructure
Id: ADT_A60
Title: "HL7 v2 ADT_A60 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ADT_A60"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "ADT_A60"
* . ^definition = "ADT_A60 Message Structure"
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
* 7-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSP ^extension.valueCode = #A
* 8-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSR ^extension.valueCode = #A
* 9-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSC ^extension.valueCode = #A
* 10-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 10-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ARV ^extension.valueCode = #B
* 11-VISIT_GROUP 0..1 BackboneElement "VISIT_GROUP" "VISIT_GROUP"
* 11-VISIT_GROUP.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 11-VISIT_GROUP.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-VISIT_GROUP.1-PV1 ^extension.valueCode = #A
* 11-VISIT_GROUP.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info." "Patient Visit - Additional Info."
* 11-VISIT_GROUP.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-VISIT_GROUP.2-PV2 ^extension.valueCode = #A
* 11-VISIT_GROUP.3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 11-VISIT_GROUP.3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-VISIT_GROUP.3-ARV ^extension.valueCode = #B
* 12-ADVERSE_REACTION_GROUP 0..* BackboneElement "ADVERSE_REACTION_GROUP" "ADVERSE_REACTION_GROUP"
* 12-ADVERSE_REACTION_GROUP.1-IAM 1..1 http://hl7.org/v2/StructureDefinition/IAM "Patient adverse reaction information" "Patient adverse reaction information"
* 12-ADVERSE_REACTION_GROUP.1-IAM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-ADVERSE_REACTION_GROUP.1-IAM ^extension.valueCode = #A
* 12-ADVERSE_REACTION_GROUP.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 12-ADVERSE_REACTION_GROUP.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-ADVERSE_REACTION_GROUP.2-NTE ^extension.valueCode = #A
* 12-ADVERSE_REACTION_GROUP.3-IAR 0..* http://hl7.org/v2/StructureDefinition/IAR "Allergy Reaction Segment" "Allergy Reaction Segment"
* 12-ADVERSE_REACTION_GROUP.3-IAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-ADVERSE_REACTION_GROUP.3-IAR ^extension.valueCode = #A