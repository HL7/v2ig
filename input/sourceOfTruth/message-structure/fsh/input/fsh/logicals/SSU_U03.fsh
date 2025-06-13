Logical: SSU_U03
Parent: V2MessageStructure
Id: SSU_U03
Title: "HL7 v2 SSU_U03 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "SSU_U03"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "SSU_U03"
* . ^definition = "SSU_U03 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EQU 1..1 http://hl7.org/v2/StructureDefinition/EQU "Equipment Detail" "Equipment Detail"
* 4-EQU ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EQU ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER 1..* BackboneElement "SPECIMEN_CONTAINER" "SPECIMEN_CONTAINER"
* 5-SPECIMEN_CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container Detail" "Specimen Container Detail"
* 5-SPECIMEN_CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.1-SAC ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.2-OBX 1..* http://hl7.org/v2/StructureDefinition/OBX "Additional specimen container characteristics" "Additional specimen container characteristics"
* 5-SPECIMEN_CONTAINER.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.2-OBX ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.3-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Additional specimen container information" "Additional specimen container information"
* 5-SPECIMEN_CONTAINER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.3-NTE ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.4-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation for OBX" "Participation for OBX"
* 5-SPECIMEN_CONTAINER.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.4-PRT ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.5-SPECIMEN 0..* BackboneElement "SPECIMEN" "SPECIMEN"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.1-SPM ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.2-OBX 1..* http://hl7.org/v2/StructureDefinition/OBX "Specimen related observation" "Specimen related observation"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.2-OBX ^extension.valueCode = #A
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.3-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation for OBX" "Participation for OBX"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SPECIMEN_CONTAINER.5-SPECIMEN.3-PRT ^extension.valueCode = #A
* 6-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "Role Detail" "Role Detail"
* 6-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ROL ^extension.valueCode = #B