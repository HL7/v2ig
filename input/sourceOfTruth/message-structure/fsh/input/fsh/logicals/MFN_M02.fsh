Logical: MFN_M02
Parent: V2MessageStructure
Id: MFN_M02
Title: "HL7 v2 MFN_M02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M02"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M02"
* . ^definition = "MFN_M02 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MFI 1..1 http://hl7.org/v2/StructureDefinition/MFI "Master File Identification" "Master File Identification"
* 4-MFI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MFI ^extension.valueCode = #A
* 5-MF_STAFF 1..* BackboneElement "MF_STAFF" "MF_STAFF"
* 5-MF_STAFF.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_STAFF.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.1-MFE ^extension.valueCode = #A
* 5-MF_STAFF.2-STF 1..1 http://hl7.org/v2/StructureDefinition/STF "Staff Identification" "Staff Identification"
* 5-MF_STAFF.2-STF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.2-STF ^extension.valueCode = #A
* 5-MF_STAFF.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-MF_STAFF.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.3-GSP ^extension.valueCode = #A
* 5-MF_STAFF.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-MF_STAFF.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.4-GSR ^extension.valueCode = #A
* 5-MF_STAFF.5-PRA 0..* http://hl7.org/v2/StructureDefinition/PRA "Practitioner Detail" "Practitioner Detail"
* 5-MF_STAFF.5-PRA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.5-PRA ^extension.valueCode = #A
* 5-MF_STAFF.6-ORG 0..* http://hl7.org/v2/StructureDefinition/ORG "Practitioner Organization Unit Segment" "Practitioner Organization Unit Segment"
* 5-MF_STAFF.6-ORG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.6-ORG ^extension.valueCode = #A
* 5-MF_STAFF.7-AFF 0..* http://hl7.org/v2/StructureDefinition/AFF "Professional Affiliation" "Professional Affiliation"
* 5-MF_STAFF.7-AFF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.7-AFF ^extension.valueCode = #A
* 5-MF_STAFF.8-LAN 0..* http://hl7.org/v2/StructureDefinition/LAN "Language Detail" "Language Detail"
* 5-MF_STAFF.8-LAN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.8-LAN ^extension.valueCode = #A
* 5-MF_STAFF.9-EDU 0..* http://hl7.org/v2/StructureDefinition/EDU "Educational Detail" "Educational Detail"
* 5-MF_STAFF.9-EDU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.9-EDU ^extension.valueCode = #A
* 5-MF_STAFF.10-CER 0..* http://hl7.org/v2/StructureDefinition/CER "Certificate Detail" "Certificate Detail"
* 5-MF_STAFF.10-CER ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.10-CER ^extension.valueCode = #A
* 5-MF_STAFF.11-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the STF" "Notes and Comments for the STF"
* 5-MF_STAFF.11-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_STAFF.11-NTE ^extension.valueCode = #A