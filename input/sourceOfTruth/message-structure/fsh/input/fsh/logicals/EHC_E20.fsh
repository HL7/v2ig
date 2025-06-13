Logical: EHC_E20
Parent: V2MessageStructure
Id: EHC_E20
Title: "HL7 v2 EHC_E20 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E20"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E20"
* . ^definition = "EHC_E20 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST 1..1 BackboneElement "AUTHORIZATION_REQUEST" "AUTHORIZATION_REQUEST"
* 4-AUTHORIZATION_REQUEST.choice-1-Group 0..1 BackboneElement "Choice 1 within AUTHORIZATION_REQUEST" "Choice 1 within AUTHORIZATION_REQUEST"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice Header" "Invoice Header"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.1-IVC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-CTD 1..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-CTD ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.3-LOC 0..* http://hl7.org/v2/StructureDefinition/LOC "Location Identification" "Location Identification"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.3-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.3-LOC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.4-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Provider Identification" "Provider Identification"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.4-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.4-ROL ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO 1..* BackboneElement "PAT_INFO" "PAT_INFO"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Person Identification" "Person Identification"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.1-PID ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.2-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.2-GSP ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.3-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.3-GSR ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.4-GSC 0..1 http://hl7.org/v2/StructureDefinition/GSC "*Sex Parameter for Clinical Use*" "*Sex Parameter for Clinical Use*"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.4-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.4-GSC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.5-PRT ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.6-ACC 0..* http://hl7.org/v2/StructureDefinition/ACC "Accident" "Accident"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.6-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.6-ACC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE 1..* BackboneElement "INSURANCE" "INSURANCE"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.1-IN1 ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.2-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.2-GSP ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.3-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.3-GSR ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.4-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.4-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.7-INSURANCE.4-IN2 ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS 0..* BackboneElement "DIAGNOSIS" "DIAGNOSIS"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.1-DG1 1..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.1-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.1-DG1 ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.8-DIAGNOSIS.2-NTE ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.9-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation" "Observation"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.9-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.9-OBX ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.10-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.10-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.5-PAT_INFO.10-PRT ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO 1..* BackboneElement "PSL_ITEM_INFO" "PSL_ITEM_INFO"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.1-PSL ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.2-NTE ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.3-ADJ 0..* http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.3-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.3-ADJ ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.4-LOC 0..* http://hl7.org/v2/StructureDefinition/LOC "Location Identification" "Location Identification"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.4-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.4-LOC ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.5-PRT ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.6-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.6-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.6-PSL_ITEM_INFO.6-ROL ^extension.valueCode = #A