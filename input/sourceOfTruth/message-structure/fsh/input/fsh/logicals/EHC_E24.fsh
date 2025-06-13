Logical: EHC_E24
Parent: V2MessageStructure
Id: EHC_E24
Title: "HL7 v2 EHC_E24 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E24"
* ^date = "2025-06-13T21:11:38Z"
* . ^short = "EHC_E24"
* . ^definition = "EHC_E24 Message Structure"
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
* 6-AUTHORIZATION_RESPONSE_INFO 1..1 BackboneElement "AUTHORIZATION_RESPONSE_INFO" "AUTHORIZATION_RESPONSE_INFO"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group 0..1 BackboneElement "Choice 1 within AUTHORIZATION_RESPONSE_INFO" "Choice 1 within AUTHORIZATION_RESPONSE_INFO"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.1-IVC ^extension.valueCode = #A
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO 1..* BackboneElement "PSL_ITEM_INFO" "PSL_ITEM_INFO"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.1-PSL ^extension.valueCode = #A
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.2-AUT 0..1 http://hl7.org/v2/StructureDefinition/AUT "Authorization" "Authorization"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.2-AUT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.2-AUT ^extension.valueCode = #A
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.3-ADJ 0..* http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.3-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-AUTHORIZATION_RESPONSE_INFO.choice-1-Group.2-PSL_ITEM_INFO.3-ADJ ^extension.valueCode = #A