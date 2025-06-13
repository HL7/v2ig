Logical: RSP_E22
Parent: V2MessageStructure
Id: RSP_E22
Title: "HL7 v2 RSP_E22 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_E22"
* ^date = "2025-06-13T21:11:38Z"
* . ^short = "RSP_E22"
* . ^definition = "RSP_E22 Message Structure"
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
* 6-QUERY_ACK 1..1 BackboneElement "QUERY_ACK" "QUERY_ACK"
* 6-QUERY_ACK.choice-1-Group 0..1 BackboneElement "Choice 1 within QUERY_ACK" "Choice 1 within QUERY_ACK"
* 6-QUERY_ACK.choice-1-Group.1-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QUERY_ACK.choice-1-Group.1-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK.choice-1-Group.1-QAK ^extension.valueCode = #A
* 6-QUERY_ACK.choice-1-Group.2-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 6-QUERY_ACK.choice-1-Group.2-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK.choice-1-Group.2-QPD ^extension.valueCode = #A
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO 0..1 BackboneElement "AUTHORIZATION_INFO" "AUTHORIZATION_INFO"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.1-IVC ^extension.valueCode = #A
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.2-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.2-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.2-PSG ^extension.valueCode = #A
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.3-PSL_ITEM_INFO 1..* BackboneElement "PSL_ITEM_INFO" "PSL_ITEM_INFO"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.3-PSL_ITEM_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.3-PSL_ITEM_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK.choice-1-Group.3-AUTHORIZATION_INFO.3-PSL_ITEM_INFO.1-PSL ^extension.valueCode = #A