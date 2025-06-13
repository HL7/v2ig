Logical: DEO_O45
Parent: V2MessageStructure
Id: DEO_O45
Title: "HL7 v2 DEO_O45 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "DEO_O45"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "DEO_O45"
* . ^definition = "DEO_O45 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-Donor 0..1 BackboneElement "Donor" "Donor"
* 5-Donor.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification Segment" "Patient Identification Segment"
* 5-Donor.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.1-PID ^extension.valueCode = #A
* 5-Donor.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-Donor.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.2-PRT ^extension.valueCode = #A
* 5-Donor.3-DONOR_OBSERVATIONS 0..* BackboneElement "DONOR_OBSERVATIONS" "DONOR_OBSERVATIONS"
* 5-Donor.3-DONOR_OBSERVATIONS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Donor Observations" "Donor Observations"
* 5-Donor.3-DONOR_OBSERVATIONS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.3-DONOR_OBSERVATIONS.1-OBX ^extension.valueCode = #A
* 5-Donor.3-DONOR_OBSERVATIONS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-Donor.3-DONOR_OBSERVATIONS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.3-DONOR_OBSERVATIONS.2-PRT ^extension.valueCode = #A
* 5-Donor.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 5-Donor.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.4-ARV ^extension.valueCode = #B
* 5-Donor.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor)" "Notes and Comments (for Donor)"
* 5-Donor.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.5-NTE ^extension.valueCode = #A
* 5-Donor.6-DONOR_REGISTRATION 0..1 BackboneElement "DONOR_REGISTRATION" "DONOR_REGISTRATION"
* 5-Donor.6-DONOR_REGISTRATION.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit (Donor Registration)" "Patient Visit (Donor Registration)"
* 5-Donor.6-DONOR_REGISTRATION.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.6-DONOR_REGISTRATION.1-PV1 ^extension.valueCode = #A
* 5-Donor.6-DONOR_REGISTRATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-Donor.6-DONOR_REGISTRATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.6-DONOR_REGISTRATION.2-PRT ^extension.valueCode = #A
* 5-Donor.6-DONOR_REGISTRATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor Registration)" "Notes and Comments (for Donor Registration)"
* 5-Donor.6-DONOR_REGISTRATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-Donor.6-DONOR_REGISTRATION.3-NTE ^extension.valueCode = #A
* 6-DONATION_ORDER 1..* BackboneElement "DONATION_ORDER" "DONATION_ORDER"
* 6-DONATION_ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observations Request" "Observations Request"
* 6-DONATION_ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.1-OBR ^extension.valueCode = #A
* 6-DONATION_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-DONATION_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.2-PRT ^extension.valueCode = #A
* 6-DONATION_ORDER.3-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 6-DONATION_ORDER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.3-NTE ^extension.valueCode = #A
* 6-DONATION_ORDER.4-DONATION_OBSERVATION 0..* BackboneElement "DONATION_OBSERVATION" "DONATION_OBSERVATION"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation related to OBR" "Observation related to OBR"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.1-OBX ^extension.valueCode = #A
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.2-PRT ^extension.valueCode = #A
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.3-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONATION_ORDER.4-DONATION_OBSERVATION.3-NTE ^extension.valueCode = #A