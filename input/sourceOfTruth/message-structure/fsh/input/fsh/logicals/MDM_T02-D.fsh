Logical: MDM_T02-D
Parent: V2MessageStructure
Id: MDM_T02-D
Title: "HL7 v2 MDM_T02-D Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MDM_T02-D"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MDM_T02-D"
* . ^definition = "MDM_T02-D Message Structure"
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
* 4-EVN ^extension.valueCode = #B
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSP ^extension.valueCode = #A
* 7-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSR ^extension.valueCode = #A
* 8-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 8-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSC ^extension.valueCode = #A
* 9-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PRT ^extension.valueCode = #A
* 10-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 10-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PV1 ^extension.valueCode = #A
* 11-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation Segment" "Participation Segment"
* 11-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PRT ^extension.valueCode = #A
* 12-COMMON_ORDER 0..* BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 12-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common order segment" "Common order segment"
* 12-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 12-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 12-COMMON_ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 12-COMMON_ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 12-COMMON_ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 12-COMMON_ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 12-COMMON_ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 12-COMMON_ORDER.4-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation request segment" "Observation request segment"
* 12-COMMON_ORDER.4-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.4-OBR ^extension.valueCode = #A
* 12-COMMON_ORDER.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-COMMON_ORDER.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.5-PRT ^extension.valueCode = #A
* 12-COMMON_ORDER.6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments about the OBR" "Notes and comments about the OBR"
* 12-COMMON_ORDER.6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-COMMON_ORDER.6-NTE ^extension.valueCode = #A
* 13-TXA 1..1 http://hl7.org/v2/StructureDefinition/TXA "Document Notification" "Document Notification"
* 13-TXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-TXA ^extension.valueCode = #A
* 14-CON 0..* http://hl7.org/v2/StructureDefinition/CON "Consent Segment" "Consent Segment"
* 14-CON ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-CON ^extension.valueCode = #A
* 15-FIXME 1..* BackboneElement "FIXME" "FIXME"
* 15-FIXME.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result (one or more required)" "Observation/Result (one or more required)"
* 15-FIXME.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FIXME.1-OBX ^extension.valueCode = #A
* 15-FIXME.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FIXME.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FIXME.2-PRT ^extension.valueCode = #A
* 15-FIXME.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments about the OBX" "Notes and comments about the OBX"
* 15-FIXME.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FIXME.3-NTE ^extension.valueCode = #A