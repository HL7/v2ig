Logical: RSP_E03
Parent: V2MessageStructure
Id: RSP_E03
Title: "HL7 v2 RSP_E03 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RSP_E03"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "RSP_E03"
* . ^definition = "RSP_E03 Message Structure"
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
* 6-QUERY_ACK_IPR 1..1 BackboneElement "QUERY_ACK_IPR" "QUERY_ACK_IPR"
* 6-QUERY_ACK_IPR.choice-1-Group 0..1 BackboneElement "Choice 1 within QUERY_ACK_IPR" "Choice 1 within QUERY_ACK_IPR"
* 6-QUERY_ACK_IPR.choice-1-Group.1-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QUERY_ACK_IPR.choice-1-Group.1-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK_IPR.choice-1-Group.1-QAK ^extension.valueCode = #A
* 6-QUERY_ACK_IPR.choice-1-Group.2-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 6-QUERY_ACK_IPR.choice-1-Group.2-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK_IPR.choice-1-Group.2-QPD ^extension.valueCode = #A
* 6-QUERY_ACK_IPR.choice-1-Group.3-IPR 0..* http://hl7.org/v2/StructureDefinition/IPR "Invoice Processing Results" "Invoice Processing Results"
* 6-QUERY_ACK_IPR.choice-1-Group.3-IPR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QUERY_ACK_IPR.choice-1-Group.3-IPR ^extension.valueCode = #A