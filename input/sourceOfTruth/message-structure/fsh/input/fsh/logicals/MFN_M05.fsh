Logical: MFN_M05
Parent: V2MessageStructure
Id: MFN_M05
Title: "HL7 v2 MFN_M05 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M05"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M05"
* . ^definition = "MFN_M05 Message Structure"
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
* 5-MF_LOCATION 1..* BackboneElement "MF_LOCATION" "MF_LOCATION"
* 5-MF_LOCATION.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_LOCATION.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.1-MFE ^extension.valueCode = #A
* 5-MF_LOCATION.2-LOC 1..1 http://hl7.org/v2/StructureDefinition/LOC "Patient Location Master" "Patient Location Master"
* 5-MF_LOCATION.2-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.2-LOC ^extension.valueCode = #A
* 5-MF_LOCATION.3-LCH 0..* http://hl7.org/v2/StructureDefinition/LCH "Location Characteristic" "Location Characteristic"
* 5-MF_LOCATION.3-LCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.3-LCH ^extension.valueCode = #A
* 5-MF_LOCATION.4-LRL 0..* http://hl7.org/v2/StructureDefinition/LRL "Location Relationship" "Location Relationship"
* 5-MF_LOCATION.4-LRL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.4-LRL ^extension.valueCode = #A
* 5-MF_LOCATION.5-MF_LOC_DEPT 1..* BackboneElement "MF_LOC_DEPT" "MF_LOC_DEPT"
* 5-MF_LOCATION.5-MF_LOC_DEPT.1-LDP 1..1 http://hl7.org/v2/StructureDefinition/LDP "Location Department" "Location Department"
* 5-MF_LOCATION.5-MF_LOC_DEPT.1-LDP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.5-MF_LOC_DEPT.1-LDP ^extension.valueCode = #A
* 5-MF_LOCATION.5-MF_LOC_DEPT.2-LCH 0..* http://hl7.org/v2/StructureDefinition/LCH "Location Characteristic" "Location Characteristic"
* 5-MF_LOCATION.5-MF_LOC_DEPT.2-LCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.5-MF_LOC_DEPT.2-LCH ^extension.valueCode = #A
* 5-MF_LOCATION.5-MF_LOC_DEPT.3-LCC 0..* http://hl7.org/v2/StructureDefinition/LCC "Location Charge Code" "Location Charge Code"
* 5-MF_LOCATION.5-MF_LOC_DEPT.3-LCC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_LOCATION.5-MF_LOC_DEPT.3-LCC ^extension.valueCode = #A