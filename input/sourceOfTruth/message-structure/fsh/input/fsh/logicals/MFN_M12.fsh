Logical: MFN_M12
Parent: V2MessageStructure
Id: MFN_M12
Title: "HL7 v2 MFN_M12 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M12"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M12"
* . ^definition = "MFN_M12 Message Structure"
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
* 5-MF_OBS_ATTRIBUTES 1..* BackboneElement "MF_OBS_ATTRIBUTES" "MF_OBS_ATTRIBUTES"
* 5-MF_OBS_ATTRIBUTES.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MF_OBS_ATTRIBUTES.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_OBS_ATTRIBUTES.1-MFE ^extension.valueCode = #A
* 5-MF_OBS_ATTRIBUTES.2-OM1 1..1 http://hl7.org/v2/StructureDefinition/OM1 "General Segment (Fields That Apply to Most Observations)" "General Segment (Fields That Apply to Most Observations)"
* 5-MF_OBS_ATTRIBUTES.2-OM1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_OBS_ATTRIBUTES.2-OM1 ^extension.valueCode = #A
* 5-MF_OBS_ATTRIBUTES.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-MF_OBS_ATTRIBUTES.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_OBS_ATTRIBUTES.3-PRT ^extension.valueCode = #A
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES 0..1 BackboneElement "MF_OBS_OTHER_ATTRIBUTES" "MF_OBS_OTHER_ATTRIBUTES"
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.1-OM7 1..1 http://hl7.org/v2/StructureDefinition/OM7 "Other Basic Observation/Service Attributes" "Other Basic Observation/Service Attributes"
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.1-OM7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.1-OM7 ^extension.valueCode = #A
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MF_OBS_ATTRIBUTES.4-MF_OBS_OTHER_ATTRIBUTES.2-PRT ^extension.valueCode = #A