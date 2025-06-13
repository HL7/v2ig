Logical: MFN_Znn
Parent: V2MessageStructure
Id: MFN_Znn
Title: "HL7 v2 MFN_Znn Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_Znn"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_Znn"
* . ^definition = "MFN_Znn Message Structure"
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
* 5-MF_SITE_DEFINED 1..* BackboneElement "MF_SITE_DEFINED" "MF_SITE_DEFINED"
* 5-MF_SITE_DEFINED.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_SITE_DEFINED.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_SITE_DEFINED.1-MFE ^extension.valueCode = #A
* 5-MF_SITE_DEFINED.2-... 1..1 http://hl7.org/v2/StructureDefinition/... "One or more HL7 and/or Z-segments carrying the data for the entry identified in the MFE segment" "One or more HL7 and/or Z-segments carrying the data for the entry identified in the MFE segment"
* 5-MF_SITE_DEFINED.2-... ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_SITE_DEFINED.2-... ^extension.valueCode = #A