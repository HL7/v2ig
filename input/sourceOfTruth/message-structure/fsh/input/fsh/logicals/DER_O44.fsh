Logical: DER_O44
Parent: V2MessageStructure
Id: DER_O44
Title: "HL7 v2 DER_O44 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "DER_O44"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "DER_O44"
* . ^definition = "DER_O44 Message Structure"
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
* 5-DONOR 0..1 BackboneElement "DONOR" "DONOR"
* 5-DONOR.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification Segment" "Patient Identification Segment"
* 5-DONOR.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.1-PID ^extension.valueCode = #A
* 5-DONOR.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-DONOR.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.2-PD1 ^extension.valueCode = #A
* 5-DONOR.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-DONOR.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.3-PRT ^extension.valueCode = #A
* 5-DONOR.4-DONOR_OBSERVATIONS 0..* BackboneElement "DONOR_OBSERVATIONS" "DONOR_OBSERVATIONS"
* 5-DONOR.4-DONOR_OBSERVATIONS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Donor Observations" "Donor Observations"
* 5-DONOR.4-DONOR_OBSERVATIONS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.4-DONOR_OBSERVATIONS.1-OBX ^extension.valueCode = #A
* 5-DONOR.4-DONOR_OBSERVATIONS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-DONOR.4-DONOR_OBSERVATIONS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.4-DONOR_OBSERVATIONS.2-PRT ^extension.valueCode = #A
* 5-DONOR.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor)" "Notes and Comments (for Donor)"
* 5-DONOR.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.5-NTE ^extension.valueCode = #A
* 5-DONOR.6-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 5-DONOR.6-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.6-AL1 ^extension.valueCode = #A
* 5-DONOR.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatbility only as of V2.9." "For backwards compatbility only as of V2.9."
* 5-DONOR.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.7-ARV ^extension.valueCode = #B
* 5-DONOR.8-DONOR_REGISTRATION 0..1 BackboneElement "DONOR_REGISTRATION" "DONOR_REGISTRATION"
* 5-DONOR.8-DONOR_REGISTRATION.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit (Donor Registration)" "Patient Visit (Donor Registration)"
* 5-DONOR.8-DONOR_REGISTRATION.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.8-DONOR_REGISTRATION.1-PV1 ^extension.valueCode = #A
* 5-DONOR.8-DONOR_REGISTRATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-DONOR.8-DONOR_REGISTRATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.8-DONOR_REGISTRATION.2-PRT ^extension.valueCode = #A
* 5-DONOR.8-DONOR_REGISTRATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor Registration)" "Notes and Comments (for Donor Registration)"
* 5-DONOR.8-DONOR_REGISTRATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-DONOR.8-DONOR_REGISTRATION.3-NTE ^extension.valueCode = #A
* 6-DONOR_ORDER 1..* BackboneElement "DONOR_ORDER" "DONOR_ORDER"
* 6-DONOR_ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation" "Observation"
* 6-DONOR_ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONOR_ORDER.1-OBR ^extension.valueCode = #A
* 6-DONOR_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-DONOR_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONOR_ORDER.2-PRT ^extension.valueCode = #A
* 6-DONOR_ORDER.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Detail)" "Notes and Comments (for Detail)"
* 6-DONOR_ORDER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-DONOR_ORDER.3-NTE ^extension.valueCode = #A