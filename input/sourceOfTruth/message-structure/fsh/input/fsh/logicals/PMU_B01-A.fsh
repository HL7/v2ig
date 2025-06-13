Logical: PMU_B01-A
Parent: V2MessageStructure
Id: PMU_B01-A
Title: "HL7 v2 PMU_B01-A Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "PMU_B01-A"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "PMU_B01-A"
* . ^definition = "PMU_B01-A Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-STF 1..1 http://hl7.org/v2/StructureDefinition/STF "Staff" "Staff"
* 5-STF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-STF ^extension.valueCode = #A
* 6-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSP ^extension.valueCode = #A
* 7-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSR ^extension.valueCode = #A
* 8-PRA 0..* http://hl7.org/v2/StructureDefinition/PRA "Practitioner" "Practitioner"
* 8-PRA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PRA ^extension.valueCode = #A
* 9-ORG 0..* http://hl7.org/v2/StructureDefinition/ORG "Organization" "Organization"
* 9-ORG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-ORG ^extension.valueCode = #A
* 10-AFF 0..* http://hl7.org/v2/StructureDefinition/AFF "Affiliation" "Affiliation"
* 10-AFF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-AFF ^extension.valueCode = #A
* 11-LAN 0..* http://hl7.org/v2/StructureDefinition/LAN "Language" "Language"
* 11-LAN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-LAN ^extension.valueCode = #A
* 12-EDU 0..* http://hl7.org/v2/StructureDefinition/EDU "Education" "Education"
* 12-EDU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-EDU ^extension.valueCode = #A
* 13-CER 0..* http://hl7.org/v2/StructureDefinition/CER "Certificate" "Certificate"
* 13-CER ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-CER ^extension.valueCode = #A
* 14-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 14-NEXT_OF_KIN.1-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 14-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 14-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 14-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 14-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 14-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 15-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PRT ^extension.valueCode = #A
* 16-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "deprecated as of v2.9" "deprecated as of v2.9"
* 16-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-ROL ^extension.valueCode = #d