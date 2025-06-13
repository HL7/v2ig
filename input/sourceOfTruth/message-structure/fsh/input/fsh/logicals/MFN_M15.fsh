Logical: MFN_M15
Parent: V2MessageStructure
Id: MFN_M15
Title: "HL7 v2 MFN_M15 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M15"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M15"
* . ^definition = "MFN_M15 Message Structure"
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
* 5-MF_INV_ITEM 1..* BackboneElement "MF_INV_ITEM" "MF_INV_ITEM"
* 5-MF_INV_ITEM.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_INV_ITEM.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_INV_ITEM.1-MFE ^extension.valueCode = #A
* 5-MF_INV_ITEM.2-IIM 1..1 http://hl7.org/v2/StructureDefinition/IIM "Inventory Item Master" "Inventory Item Master"
* 5-MF_INV_ITEM.2-IIM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_INV_ITEM.2-IIM ^extension.valueCode = #A