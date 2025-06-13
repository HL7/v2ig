Logical: MFN_M07
Parent: V2MessageStructure
Id: MFN_M07
Title: "HL7 v2 MFN_M07 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M07"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M07"
* . ^definition = "MFN_M07 Message Structure"
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
* 5-MF_CLIN_STUDY_SCHED 1..* BackboneElement "MF_CLIN_STUDY_SCHED" "MF_CLIN_STUDY_SCHED"
* 5-MF_CLIN_STUDY_SCHED.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_CLIN_STUDY_SCHED.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_CLIN_STUDY_SCHED.1-MFE ^extension.valueCode = #A
* 5-MF_CLIN_STUDY_SCHED.2-CM0 1..1 http://hl7.org/v2/StructureDefinition/CM0 "Clinical Study Master" "Clinical Study Master"
* 5-MF_CLIN_STUDY_SCHED.2-CM0 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_CLIN_STUDY_SCHED.2-CM0 ^extension.valueCode = #A
* 5-MF_CLIN_STUDY_SCHED.3-CM2 0..* http://hl7.org/v2/StructureDefinition/CM2 "Clinical Study Schedule" "Clinical Study Schedule"
* 5-MF_CLIN_STUDY_SCHED.3-CM2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_CLIN_STUDY_SCHED.3-CM2 ^extension.valueCode = #A