Logical: RSP_K25
Parent: V2MessageStructure
Id: RSP_K25
Title: "HL7 v2 RSP_K25 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_K25"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "RSP_K25"
* . ^definition = "RSP_K25 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QAK ^extension.valueCode = #A
* 7-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 7-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QPD ^extension.valueCode = #A
* 8-RCP 1..1 http://hl7.org/v2/StructureDefinition/RCP "Response Control Parameter" "Response Control Parameter"
* 8-RCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RCP ^extension.valueCode = #A
* 9-STAFF 1..* BackboneElement "STAFF" "STAFF"
* 9-STAFF.1-STF 1..1 http://hl7.org/v2/StructureDefinition/STF "Staff" "Staff"
* 9-STAFF.1-STF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.1-STF ^extension.valueCode = #A
* 9-STAFF.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-STAFF.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.2-GSP ^extension.valueCode = #A
* 9-STAFF.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recordded Gender and Sex" "Recordded Gender and Sex"
* 9-STAFF.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.3-GSR ^extension.valueCode = #A
* 9-STAFF.4-PRA 0..* http://hl7.org/v2/StructureDefinition/PRA "Practitioner" "Practitioner"
* 9-STAFF.4-PRA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.4-PRA ^extension.valueCode = #A
* 9-STAFF.5-ORG 0..* http://hl7.org/v2/StructureDefinition/ORG "Organization" "Organization"
* 9-STAFF.5-ORG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.5-ORG ^extension.valueCode = #A
* 9-STAFF.6-AFF 0..* http://hl7.org/v2/StructureDefinition/AFF "Affiliation" "Affiliation"
* 9-STAFF.6-AFF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.6-AFF ^extension.valueCode = #A
* 9-STAFF.7-LAN 0..* http://hl7.org/v2/StructureDefinition/LAN "Language" "Language"
* 9-STAFF.7-LAN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.7-LAN ^extension.valueCode = #A
* 9-STAFF.8-EDU 0..* http://hl7.org/v2/StructureDefinition/EDU "Education" "Education"
* 9-STAFF.8-EDU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.8-EDU ^extension.valueCode = #A
* 9-STAFF.9-CER 0..* http://hl7.org/v2/StructureDefinition/CER "Certificate" "Certificate"
* 9-STAFF.9-CER ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.9-CER ^extension.valueCode = #A
* 9-STAFF.10-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 9-STAFF.10-NEXT_OF_KIN.1-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 9-STAFF.10-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.10-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 9-STAFF.10-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-STAFF.10-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.10-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 9-STAFF.10-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-STAFF.10-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.10-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 9-STAFF.11-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-STAFF.11-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.11-PRT ^extension.valueCode = #A
* 9-STAFF.12-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "deprecated as of v2.9" "deprecated as of v2.9"
* 9-STAFF.12-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-STAFF.12-ROL ^extension.valueCode = #d
* 10-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A