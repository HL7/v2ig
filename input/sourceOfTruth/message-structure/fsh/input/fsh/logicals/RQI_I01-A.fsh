Logical: RQI_I01-A
Parent: V2MessageStructure
Id: RQI_I01-A
Title: "HL7 v2 RQI_I01-A Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RQI_I01-A"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "RQI_I01-A"
* . ^definition = "RQI_I01-A Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software segment" "Software segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-PROVIDER 1..* BackboneElement "PROVIDER" "PROVIDER"
* 4-PROVIDER.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 4-PROVIDER.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PROVIDER.1-PRD ^extension.valueCode = #A
* 4-PROVIDER.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 4-PROVIDER.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PROVIDER.2-CTD ^extension.valueCode = #A
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSP ^extension.valueCode = #A
* 7-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSR ^extension.valueCode = #A
* 8-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 8-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSC ^extension.valueCode = #A
* 9-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 9-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin / Associated Parties" "Next of Kin / Associated Parties"
* 9-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 9-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 9-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 9-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 10-GUARANTOR_INSURANCE 0..1 BackboneElement "GUARANTOR_INSURANCE" "GUARANTOR_INSURANCE"
* 10-GUARANTOR_INSURANCE.1-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 10-GUARANTOR_INSURANCE.1-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GUARANTOR_INSURANCE.1-GT1 ^extension.valueCode = #A
* 10-GUARANTOR_INSURANCE.2-INSURANCE 1..* BackboneElement "INSURANCE" "INSURANCE"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.1-IN1 ^extension.valueCode = #A
* 10-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.2-IN2 ^extension.valueCode = #A
* 10-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Add'l Info - Cert" "Insurance Add'l Info - Cert"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GUARANTOR_INSURANCE.2-INSURANCE.3-IN3 ^extension.valueCode = #A
* 11-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 11-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-NTE ^extension.valueCode = #A