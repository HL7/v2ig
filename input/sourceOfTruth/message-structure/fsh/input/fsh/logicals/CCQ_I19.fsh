Logical: CCQ_I19
Parent: V2MessageStructure
Id: CCQ_I19
Title: "HL7 v2 CCQ_I19 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CCQ_I19"
* ^date = "2025-06-13T21:11:36Z"
* . ^short = "CCQ_I19"
* . ^definition = "CCQ_I19 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-RF1 1..1 http://hl7.org/v2/StructureDefinition/RF1 "Referral Information" "Referral Information"
* 4-RF1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-RF1 ^extension.valueCode = #A
* 5-PROVIDER_CONTACT 0..* BackboneElement "PROVIDER_CONTACT" "PROVIDER_CONTACT"
* 5-PROVIDER_CONTACT.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 5-PROVIDER_CONTACT.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.1-PRD ^extension.valueCode = #A
* 5-PROVIDER_CONTACT.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-PROVIDER_CONTACT.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PROVIDER_CONTACT.2-CTD ^extension.valueCode = #A
* 6-REL 0..* http://hl7.org/v2/StructureDefinition/REL "Relationship" "Relationship"
* 6-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-REL ^extension.valueCode = #A