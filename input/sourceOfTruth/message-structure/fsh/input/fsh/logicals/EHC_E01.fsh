Logical: EHC_E01
Parent: V2MessageStructure
Id: EHC_E01
Title: "HL7 v2 EHC_E01 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E01"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E01"
* . ^definition = "EHC_E01 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT 1..1 BackboneElement "INVOICE_INFORMATION_SUBMIT" "INVOICE_INFORMATION_SUBMIT"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group 0..1 BackboneElement "Choice 1 within INVOICE_INFORMATION_SUBMIT" "Choice 1 within INVOICE_INFORMATION_SUBMIT"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.1-IVC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.2-PYE 0..1 http://hl7.org/v2/StructureDefinition/PYE "Payee Information" "Payee Information"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.2-PYE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.2-PYE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.3-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.3-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.3-CTD ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.4-AUT 0..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.4-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.4-AUT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.5-LOC 0..* http://hl7.org/v2/StructureDefinition/LOC "Location Identification" "Location Identification"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.5-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.5-LOC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.6-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.7-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.7-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.7-ROL ^extension.valueCode = #B
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION 1..* BackboneElement "PRODUCT_SERVICE_SECTION" "PRODUCT_SERVICE_SECTION"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.1-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.1-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.1-PSS ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP 1..* BackboneElement "PRODUCT_SERVICE_GROUP" "PRODUCT_SERVICE_GROUP"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-LOC 0..* http://hl7.org/v2/StructureDefinition/LOC "Location Identification" "Location Identification"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-LOC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.3-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.4-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.4-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.4-ROL ^extension.valueCode = #B
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO 0..* BackboneElement "PATIENT_INFO" "PATIENT_INFO"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Person Identification" "Person Identification"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.1-PID ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.2-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.2-GSP ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.3-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.3-GSR ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.4-GSC 0..1 http://hl7.org/v2/StructureDefinition/GSC "*Sex Parameter for Clinical Use*" "*Sex Parameter for Clinical Use*"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.4-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.4-GSC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.5-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.6-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.6-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.6-PV1 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.7-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.7-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.7-PV2 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.8-ACC 0..* http://hl7.org/v2/StructureDefinition/ACC "Accident" "Accident"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.8-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.8-ACC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE 1..* BackboneElement "INSURANCE" "INSURANCE"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.1-IN1 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.2-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.2-GSP ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.3-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.3-GSR ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.4-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.4-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.9-INSURANCE.4-IN2 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS 0..* BackboneElement "DIAGNOSIS" "DIAGNOSIS"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.1-DG1 1..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.1-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.1-DG1 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.10-DIAGNOSIS.2-NTE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.11-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation" "Observation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.11-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.11-OBX ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.12-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.12-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.5-PATIENT_INFO.12-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM 1..* BackboneElement "PRODUCT_SERVICE_LINE_ITEM" "PRODUCT_SERVICE_LINE_ITEM"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.1-PSL ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.2-NTE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.3-ADJ 0..* http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.3-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.3-ADJ ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.4-AUT 0..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization Information" "Authorization Information"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.4-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.4-AUT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.5-LOC 0..* http://hl7.org/v2/StructureDefinition/LOC "Location Identification" "Location Identification"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.5-LOC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.5-LOC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.6-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.7-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.7-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.6-PRODUCT_SERVICE_LINE_ITEM.7-ROL ^extension.valueCode = #B
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedures" "Procedures"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.2-NTE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.3-PRT ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.4-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.4-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.7-PROCEDURE.4-ROL ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.8-IPR 0..* http://hl7.org/v2/StructureDefinition/IPR "Invoice Processing Results" "Invoice Processing Results"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.8-IPR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_SUBMIT.choice-1-Group.8-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.8-IPR ^extension.valueCode = #A