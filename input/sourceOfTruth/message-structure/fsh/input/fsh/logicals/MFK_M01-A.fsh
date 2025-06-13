Logical: MFK_M01-A
Parent: V2MessageStructure
Id: MFK_M01-A
Title: "HL7 v2 MFK_M01-A Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFK_M01-A"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFK_M01-A"
* . ^definition = "MFK_M01-A Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Acknowledgment" "Acknowledgment"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-MFI 1..1 http://hl7.org/v2/StructureDefinition/MFI "Master File Identification" "Master File Identification"
* 6-MFI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MFI ^extension.valueCode = #A
* 7-MFA 0..* http://hl7.org/v2/StructureDefinition/MFA "Master File ACK segment" "Master File ACK segment"
* 7-MFA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-MFA ^extension.valueCode = #A