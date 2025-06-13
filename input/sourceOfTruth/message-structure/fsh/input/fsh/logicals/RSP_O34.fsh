Logical: RSP_O34
Parent: V2MessageStructure
Id: RSP_O34
Title: "HL7 v2 RSP_O34 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_O34"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RSP_O34"
* . ^definition = "RSP_O34 Message Structure"
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
* 5-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 5-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MSA ^extension.valueCode = #A
* 6-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 6-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ERR ^extension.valueCode = #A
* 7-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 7-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QAK ^extension.valueCode = #A
* 8-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 8-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-QPD ^extension.valueCode = #A
* 9-DONOR 0..1 BackboneElement "DONOR" "DONOR"
* 9-DONOR.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification Segment" "Patient Identification Segment"
* 9-DONOR.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.1-PID ^extension.valueCode = #A
* 9-DONOR.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 9-DONOR.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.2-PD1 ^extension.valueCode = #A
* 9-DONOR.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-DONOR.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.3-PRT ^extension.valueCode = #A
* 9-DONOR.4-DONOR_OBSERVATIONS 0..* BackboneElement "DONOR_OBSERVATIONS" "DONOR_OBSERVATIONS"
* 9-DONOR.4-DONOR_OBSERVATIONS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Donor Observations" "Donor Observations"
* 9-DONOR.4-DONOR_OBSERVATIONS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.4-DONOR_OBSERVATIONS.1-OBX ^extension.valueCode = #A
* 9-DONOR.4-DONOR_OBSERVATIONS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-DONOR.4-DONOR_OBSERVATIONS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.4-DONOR_OBSERVATIONS.2-PRT ^extension.valueCode = #A
* 9-DONOR.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor)" "Notes and Comments (for Donor)"
* 9-DONOR.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.5-NTE ^extension.valueCode = #A
* 9-DONOR.6-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 9-DONOR.6-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.6-AL1 ^extension.valueCode = #A
* 9-DONOR.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 9-DONOR.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.7-ARV ^extension.valueCode = #B
* 9-DONOR.8-DONOR_REGISTRATION 0..1 BackboneElement "DONOR_REGISTRATION" "DONOR_REGISTRATION"
* 9-DONOR.8-DONOR_REGISTRATION.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit (Donor Registration)" "Patient Visit (Donor Registration)"
* 9-DONOR.8-DONOR_REGISTRATION.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.8-DONOR_REGISTRATION.1-PV1 ^extension.valueCode = #A
* 9-DONOR.8-DONOR_REGISTRATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-DONOR.8-DONOR_REGISTRATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.8-DONOR_REGISTRATION.2-PRT ^extension.valueCode = #A
* 9-DONOR.8-DONOR_REGISTRATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Donor Registration)" "Notes and Comments (for Donor Registration)"
* 9-DONOR.8-DONOR_REGISTRATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DONOR.8-DONOR_REGISTRATION.3-NTE ^extension.valueCode = #A
* 10-DONATION 0..1 BackboneElement "DONATION" "DONATION"
* 10-DONATION.1-DON 1..1 http://hl7.org/v2/StructureDefinition/DON "Donation" "Donation"
* 10-DONATION.1-DON ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DONATION.1-DON ^extension.valueCode = #A
* 10-DONATION.2-DONOR_OBSERVATIONS 0..* BackboneElement "DONOR_OBSERVATIONS" "DONOR_OBSERVATIONS"
* 10-DONATION.2-DONOR_OBSERVATIONS.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Adverse Reaction Observations" "Adverse Reaction Observations"
* 10-DONATION.2-DONOR_OBSERVATIONS.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DONATION.2-DONOR_OBSERVATIONS.1-OBX ^extension.valueCode = #A
* 10-DONATION.2-DONOR_OBSERVATIONS.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-DONATION.2-DONOR_OBSERVATIONS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DONATION.2-DONOR_OBSERVATIONS.2-PRT ^extension.valueCode = #A
* 10-DONATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (For Donation)" "Notes and Comments (For Donation)"
* 10-DONATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DONATION.3-NTE ^extension.valueCode = #A