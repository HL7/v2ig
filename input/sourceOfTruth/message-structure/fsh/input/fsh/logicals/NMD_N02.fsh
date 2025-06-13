Logical: NMD_N02
Parent: V2MessageStructure
Id: NMD_N02
Title: "HL7 v2 NMD_N02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "NMD_N02"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "NMD_N02"
* . ^definition = "NMD_N02 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES 1..* BackboneElement "CLOCK_AND_STATS_WITH_NOTES" "CLOCK_AND_STATS_WITH_NOTES"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK 0..1 BackboneElement "CLOCK" "CLOCK"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.1-NCK 1..1 http://hl7.org/v2/StructureDefinition/NCK "System Clock" "System Clock"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.1-NCK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.1-NCK ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for NCK" "Notes and Comments for NCK"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.1-CLOCK.2-NTE ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS 0..1 BackboneElement "APP_STATS" "APP_STATS"
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.1-NST 1..1 http://hl7.org/v2/StructureDefinition/NST "Application control-level Statistics" "Application control-level Statistics"
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.1-NST ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.1-NST ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for NST" "Notes and Comments for NST"
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.2-APP_STATS.2-NTE ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS 0..1 BackboneElement "APP_STATUS" "APP_STATUS"
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.1-NSC 1..1 http://hl7.org/v2/StructureDefinition/NSC "Application Status Change" "Application Status Change"
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.1-NSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.1-NSC ^extension.valueCode = #A
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for NSC" "Notes and Comments for NSC"
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-CLOCK_AND_STATS_WITH_NOTES.3-APP_STATUS.2-NTE ^extension.valueCode = #A