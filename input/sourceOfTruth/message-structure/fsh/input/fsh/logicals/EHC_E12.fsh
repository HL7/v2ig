Logical: EHC_E12
Parent: V2MessageStructure
Id: EHC_E12
Title: "HL7 v2 EHC_E12 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E12"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E12"
* . ^definition = "EHC_E12 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-RFI 1..1 http://hl7.org/v2/StructureDefinition/RFI "Request for Information" "Request for Information"
* 4-RFI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-RFI ^extension.valueCode = #A
* 5-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 5-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CTD ^extension.valueCode = #A
* 6-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 6-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-IVC ^extension.valueCode = #A
* 7-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 7-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PSS ^extension.valueCode = #A
* 8-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 8-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PSG ^extension.valueCode = #A
* 9-PID 0..1 http://hl7.org/v2/StructureDefinition/PID "Person Identification" "Person Identification"
* 9-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PID ^extension.valueCode = #A
* 10-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 10-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GSP ^extension.valueCode = #A
* 11-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 11-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-GSR ^extension.valueCode = #A
* 12-GSC 0..1 http://hl7.org/v2/StructureDefinition/GSC "*Sex Parameter for Clinical Use*" "*Sex Parameter for Clinical Use*"
* 12-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GSC ^extension.valueCode = #A
* 13-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 13-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-PRT ^extension.valueCode = #A
* 14-PSL 0..* http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 14-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-PSL ^extension.valueCode = #A
* 15-REQUEST 1..* BackboneElement "REQUEST" "REQUEST"
* 15-REQUEST.1-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 15-REQUEST.1-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.1-CTD ^extension.valueCode = #A
* 15-REQUEST.2-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 15-REQUEST.2-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.2-OBR ^extension.valueCode = #A
* 15-REQUEST.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-REQUEST.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.3-PRT ^extension.valueCode = #A
* 15-REQUEST.4-NTE 0..1 http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 15-REQUEST.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.4-NTE ^extension.valueCode = #A
* 15-REQUEST.5-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation Results" "Observation Results"
* 15-REQUEST.5-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.5-OBX ^extension.valueCode = #A
* 15-REQUEST.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-REQUEST.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-REQUEST.6-PRT ^extension.valueCode = #A