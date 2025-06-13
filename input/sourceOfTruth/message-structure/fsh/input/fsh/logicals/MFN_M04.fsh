Logical: MFN_M04
Parent: V2MessageStructure
Id: MFN_M04
Title: "HL7 v2 MFN_M04 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M04"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M04"
* . ^definition = "MFN_M04 Message Structure"
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
* 5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments Segment" "Notes and Comments Segment"
* 5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-NTE ^extension.valueCode = #A
* 6-MF_CDM 1..* BackboneElement "MF_CDM" "MF_CDM"
* 6-MF_CDM.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 6-MF_CDM.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MF_CDM.1-MFE ^extension.valueCode = #A
* 6-MF_CDM.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments Segment" "Notes and Comments Segment"
* 6-MF_CDM.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MF_CDM.2-NTE ^extension.valueCode = #A
* 6-MF_CDM.3-CDM 1..1 http://hl7.org/v2/StructureDefinition/CDM "Charge Description Master" "Charge Description Master"
* 6-MF_CDM.3-CDM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MF_CDM.3-CDM ^extension.valueCode = #A
* 6-MF_CDM.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments Segment" "Notes and Comments Segment"
* 6-MF_CDM.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MF_CDM.4-NTE ^extension.valueCode = #A
* 6-MF_CDM.5-PRC 0..* http://hl7.org/v2/StructureDefinition/PRC "Price Segment" "Price Segment"
* 6-MF_CDM.5-PRC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-MF_CDM.5-PRC ^extension.valueCode = #A