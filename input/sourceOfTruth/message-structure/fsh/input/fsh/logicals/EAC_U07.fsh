Logical: EAC_U07
Parent: V2MessageStructure
Id: EAC_U07
Title: "HL7 v2 EAC_U07 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EAC_U07"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EAC_U07"
* . ^definition = "EAC_U07 Message Structure"
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
* 5-COMMAND 1..* BackboneElement "COMMAND" "COMMAND"
* 5-COMMAND.1-ECD 1..1 http://hl7.org/v2/StructureDefinition/ECD "Equipment Command Detail" "Equipment Command Detail"
* 5-COMMAND.1-ECD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.1-ECD ^extension.valueCode = #A
* 5-COMMAND.2-TQ1 0..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/quantity" "Timing/quantity"
* 5-COMMAND.2-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.2-TQ1 ^extension.valueCode = #A
* 5-COMMAND.3-SPECIMEN_CONTAINER 0..* BackboneElement "SPECIMEN_CONTAINER" "SPECIMEN_CONTAINER"
* 5-COMMAND.3-SPECIMEN_CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container Detail" "Specimen Container Detail"
* 5-COMMAND.3-SPECIMEN_CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.3-SPECIMEN_CONTAINER.1-SAC ^extension.valueCode = #A
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER 0..* BackboneElement "ORDER_FOR_SPECIMEN_CONTAINER" "ORDER_FOR_SPECIMEN_CONTAINER"
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.1-OBR 0..* http://hl7.org/v2/StructureDefinition/OBR "Specimen container info. on requested test" "Specimen container info. on requested test"
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.1-OBR ^extension.valueCode = #A
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for requested test)" "Participation (for requested test)"
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.3-SPECIMEN_CONTAINER.2-ORDER_FOR_SPECIMEN_CONTAINER.2-PRT ^extension.valueCode = #A
* 5-COMMAND.3-SPECIMEN_CONTAINER.3-SPM 0..* http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 5-COMMAND.3-SPECIMEN_CONTAINER.3-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.3-SPECIMEN_CONTAINER.3-SPM ^extension.valueCode = #A
* 5-COMMAND.3-SPECIMEN_CONTAINER.4-DST 0..* http://hl7.org/v2/StructureDefinition/DST "Transport destination" "Transport destination"
* 5-COMMAND.3-SPECIMEN_CONTAINER.4-DST ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.3-SPECIMEN_CONTAINER.4-DST ^extension.valueCode = #A
* 5-COMMAND.4-CNS 0..1 http://hl7.org/v2/StructureDefinition/CNS "Clear Notification" "Clear Notification"
* 5-COMMAND.4-CNS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-COMMAND.4-CNS ^extension.valueCode = #A
* 6-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "Role Detail" "Role Detail"
* 6-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ROL ^extension.valueCode = #B