Logical: RSP_O33
Parent: V2MessageStructure
Id: RSP_O33
Title: "HL7 v2 RSP_O33 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_O33"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_O33"
* . ^definition = "RSP_O33 Message Structure"
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
* 5-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 5-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MSA ^extension.valueCode = #A
* 6-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 6-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ERR ^extension.valueCode = #A
* 7-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 7-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QAK ^extension.valueCode = #A
* 8-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 8-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QPD ^extension.valueCode = #A
* 9-DONOR 0..1 BackboneElement "DONOR" "DONOR"
* 9-DONOR.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification Segment" "Patient Identification Segment"
* 9-DONOR.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.1-PID ^extension.valueCode = #A
* 9-DONOR.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-DONOR.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.2-PRT ^extension.valueCode = #A
* 9-DONOR.3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 9-DONOR.3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.3-ARV ^extension.valueCode = #B