Logical: PMU_B08
Parent: V2MessageStructure
Id: PMU_B08
Title: "HL7 v2 PMU_B08 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "PMU_B08"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "PMU_B08"
* . ^definition = "PMU_B08 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-STF 1..1 http://hl7.org/v2/StructureDefinition/STF "Staff" "Staff"
* 5-STF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-STF ^extension.valueCode = #A
* 6-PRA 0..1 http://hl7.org/v2/StructureDefinition/PRA "Practitioner" "Practitioner"
* 6-PRA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PRA ^extension.valueCode = #A
* 7-CER 0..* http://hl7.org/v2/StructureDefinition/CER "Certificate" "Certificate"
* 7-CER ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-CER ^extension.valueCode = #A