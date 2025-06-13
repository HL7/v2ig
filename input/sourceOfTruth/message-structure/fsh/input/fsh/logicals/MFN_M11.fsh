Logical: MFN_M11
Parent: V2MessageStructure
Id: MFN_M11
Title: "HL7 v2 MFN_M11 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M11"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M11"
* . ^definition = "MFN_M11 Message Structure"
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
* 5-MF_TEST_CALCULATED 1..* BackboneElement "MF_TEST_CALCULATED" "MF_TEST_CALCULATED"
* 5-MF_TEST_CALCULATED.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_TEST_CALCULATED.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.1-MFE ^extension.valueCode = #A
* 5-MF_TEST_CALCULATED.2-OM1 1..1 http://hl7.org/v2/StructureDefinition/OM1 "General Segment (Fields That Apply to Most Observations)" "General Segment (Fields That Apply to Most Observations)"
* 5-MF_TEST_CALCULATED.2-OM1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.2-OM1 ^extension.valueCode = #A
* 5-MF_TEST_CALCULATED.3-OMC 0..* http://hl7.org/v2/StructureDefinition/OMC "Supporting Clinical Information" "Supporting Clinical Information"
* 5-MF_TEST_CALCULATED.3-OMC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.3-OMC ^extension.valueCode = #A
* 5-MF_TEST_CALCULATED.4-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-MF_TEST_CALCULATED.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.4-PRT ^extension.valueCode = #A
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL 0..1 BackboneElement "MF_TEST_CALC_DETAIL" "MF_TEST_CALC_DETAIL"
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.1-OM6 1..1 http://hl7.org/v2/StructureDefinition/OM6 "Observations Calculated from Other Observations" "Observations Calculated from Other Observations"
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.1-OM6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.1-OM6 ^extension.valueCode = #A
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.2-OM2 1..1 http://hl7.org/v2/StructureDefinition/OM2 "Numeric Observation Segment" "Numeric Observation Segment"
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.2-OM2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_TEST_CALCULATED.5-MF_TEST_CALC_DETAIL.2-OM2 ^extension.valueCode = #A