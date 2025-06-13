Logical: SDR_S31-B
Parent: V2MessageStructure
Id: SDR_S31-B
Title: "HL7 v2 SDR_S31-B Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "SDR_S31-B"
* ^date = "2025-06-13T21:11:38Z"
* . ^short = "SDR_S31-B"
* . ^definition = "SDR_S31-B Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential Segment" "User Authentication Credential Segment"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-ANTI-MICROBIAL_DEVICE_DATA 1..1 BackboneElement "ANTI-MICROBIAL_DEVICE_DATA" "ANTI-MICROBIAL_DEVICE_DATA"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group 0..1 BackboneElement "Choice 1 within ANTI-MICROBIAL_DEVICE_DATA" "Choice 1 within ANTI-MICROBIAL_DEVICE_DATA"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.1-SDD 1..1 http://hl7.org/v2/StructureDefinition/SDD "Sterilization Device" "Sterilization Device"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.1-SDD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.1-SDD ^extension.valueCode = #A
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.2-SCD 0..* http://hl7.org/v2/StructureDefinition/SCD "Sterilization Cycle" "Sterilization Cycle"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.2-SCD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-ANTI-MICROBIAL_DEVICE_DATA.choice-1-Group.2-SCD ^extension.valueCode = #A