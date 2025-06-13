Logical: EAR_U08
Parent: V2MessageStructure
Id: EAR_U08
Title: "HL7 v2 EAR_U08 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EAR_U08"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EAR_U08"
* . ^definition = "EAR_U08 Message Structure"
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
* 5-COMMAND_RESPONSE 1..* BackboneElement "COMMAND_RESPONSE" "COMMAND_RESPONSE"
* 5-COMMAND_RESPONSE.1-ECD 1..1 http://hl7.org/v2/StructureDefinition/ECD "Equipment Command Detail" "Equipment Command Detail"
* 5-COMMAND_RESPONSE.1-ECD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND_RESPONSE.1-ECD ^extension.valueCode = #A
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER 0..1 BackboneElement "SPECIMEN_CONTAINER" "SPECIMEN_CONTAINER"
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container Detail" "Specimen Container Detail"
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.1-SAC ^extension.valueCode = #A
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.2-SPM 1..* http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.2-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND_RESPONSE.2-SPECIMEN_CONTAINER.2-SPM ^extension.valueCode = #A
* 5-COMMAND_RESPONSE.3-ECR 1..1 http://hl7.org/v2/StructureDefinition/ECR "Equipment Command Response" "Equipment Command Response"
* 5-COMMAND_RESPONSE.3-ECR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND_RESPONSE.3-ECR ^extension.valueCode = #A
* 6-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "Role Detail" "Role Detail"
* 6-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ROL ^extension.valueCode = #B