Logical: MFN_M18
Parent: V2MessageStructure
Id: MFN_M18
Title: "HL7 v2 MFN_M18 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M18"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M18"
* . ^definition = "MFN_M18 Message Structure"
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
* 5-MF_PAYER 1..* BackboneElement "MF_PAYER" "MF_PAYER"
* 5-MF_PAYER.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_PAYER.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_PAYER.1-MFE ^extension.valueCode = #A
* 5-MF_PAYER.2-PAYER_MF_ENTRY 1..* BackboneElement "PAYER_MF_ENTRY" "PAYER_MF_ENTRY"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.1-PM1 1..1 http://hl7.org/v2/StructureDefinition/PM1
* 5-MF_PAYER.2-PAYER_MF_ENTRY.1-PM1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.1-PM1 ^extension.valueCode = #A
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE 1..* BackboneElement "PAYER_MF_COVERAGE" "PAYER_MF_COVERAGE"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.1-MCP 1..1 http://hl7.org/v2/StructureDefinition/MCP
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.1-MCP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.1-MCP ^extension.valueCode = #A
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.2-DPS 0..* http://hl7.org/v2/StructureDefinition/DPS "Diagnosis and Procedure" "Diagnosis and Procedure"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.2-DPS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_PAYER.2-PAYER_MF_ENTRY.2-PAYER_MF_COVERAGE.2-DPS ^extension.valueCode = #A