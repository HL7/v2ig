Logical: EHC_E13
Parent: V2MessageStructure
Id: EHC_E13
Title: "HL7 v2 EHC_E13 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E13"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E13"
* . ^definition = "EHC_E13 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-RFI 1..1 http://hl7.org/v2/StructureDefinition/RFI "Request for Information" "Request for Information"
* 6-RFI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RFI ^extension.valueCode = #A
* 7-CTD 1..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-CTD ^extension.valueCode = #A
* 8-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 8-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-IVC ^extension.valueCode = #A
* 9-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 9-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PSS ^extension.valueCode = #A
* 10-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 10-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PSG ^extension.valueCode = #A
* 11-PID 0..1 http://hl7.org/v2/StructureDefinition/PID "Person Identification" "Person Identification"
* 11-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PID ^extension.valueCode = #A
* 12-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 12-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GSP ^extension.valueCode = #A
* 13-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 13-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-GSR ^extension.valueCode = #A
* 14-GSC 0..1 http://hl7.org/v2/StructureDefinition/GSC "*Sex Parameter for Clinical Use*" "*Sex Parameter for Clinical Use*"
* 14-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-GSC ^extension.valueCode = #A
* 15-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PRT ^extension.valueCode = #A
* 16-PSL 0..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 16-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-PSL ^extension.valueCode = #A
* 17-REQUEST 1..* BackboneElement "REQUEST" "REQUEST"
* 17-REQUEST.1-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 17-REQUEST.1-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.1-CTD ^extension.valueCode = #A
* 17-REQUEST.2-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 17-REQUEST.2-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.2-OBR ^extension.valueCode = #A
* 17-REQUEST.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-REQUEST.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.3-PRT ^extension.valueCode = #A
* 17-REQUEST.4-NTE 0..1 http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 17-REQUEST.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.4-NTE ^extension.valueCode = #A
* 17-REQUEST.5-RESPONSE 1..* BackboneElement "RESPONSE" "RESPONSE"
* 17-REQUEST.5-RESPONSE.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Result" "Observation Result"
* 17-REQUEST.5-RESPONSE.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.5-RESPONSE.1-OBX ^extension.valueCode = #A
* 17-REQUEST.5-RESPONSE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 17-REQUEST.5-RESPONSE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.5-RESPONSE.2-PRT ^extension.valueCode = #A
* 17-REQUEST.5-RESPONSE.3-NTE 0..1 http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 17-REQUEST.5-RESPONSE.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.5-RESPONSE.3-NTE ^extension.valueCode = #A
* 17-REQUEST.5-RESPONSE.4-TXA 0..1 http://hl7.org/v2/StructureDefinition/TXA "Transcription Document Header" "Transcription Document Header"
* 17-REQUEST.5-RESPONSE.4-TXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-REQUEST.5-RESPONSE.4-TXA ^extension.valueCode = #A