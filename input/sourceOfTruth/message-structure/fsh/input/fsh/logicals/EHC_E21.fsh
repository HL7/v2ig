Logical: EHC_E21
Parent: V2MessageStructure
Id: EHC_E21
Title: "HL7 v2 EHC_E21 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E21"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E21"
* . ^definition = "EHC_E21 Message Structure"
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
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO 1..* BackboneElement "PSL_ITEM_INFO" "PSL_ITEM_INFO"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.1-PSL ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.2-NTE ^extension.valueCode = #A
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.3-AUT 0..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization" "Authorization"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.3-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-AUTHORIZATION_REQUEST.choice-1-Group.2-PSL_ITEM_INFO.3-AUT ^extension.valueCode = #A