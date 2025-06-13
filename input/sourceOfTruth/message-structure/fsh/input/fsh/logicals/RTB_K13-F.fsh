Logical: RTB_K13-F
Parent: V2MessageStructure
Id: RTB_K13-F
Title: "HL7 v2 RTB_K13-F Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RTB_K13-F"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RTB_K13-F"
* . ^definition = "RTB_K13-F Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgement" "Message Acknowledgement"
* 4-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MSA ^extension.valueCode = #A
* 5-ERR 0..1 http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 5-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-ERR ^extension.valueCode = #A
* 6-QAK 1..1 http://hl7.org/v2/StructureDefinition/QAK "Query Acknowledgement" "Query Acknowledgement"
* 6-QAK ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-QAK ^extension.valueCode = #A
* 7-QPD 1..1 http://hl7.org/v2/StructureDefinition/QPD "Query Parameter Definition" "Query Parameter Definition"
* 7-QPD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-QPD ^extension.valueCode = #A
* 8-ROW_DEFINITION 0..1 BackboneElement "ROW_DEFINITION" "ROW_DEFINITION"
* 8-ROW_DEFINITION.1-RDF 1..1 http://hl7.org/v2/StructureDefinition/RDF "Table Row Definition Segment" "Table Row Definition Segment"
* 8-ROW_DEFINITION.1-RDF ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ROW_DEFINITION.1-RDF ^extension.valueCode = #A
* 8-ROW_DEFINITION.2-RDT 0..* http://hl7.org/v2/StructureDefinition/RDT "Table Row Data Segment" "Table Row Data Segment"
* 8-ROW_DEFINITION.2-RDT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ROW_DEFINITION.2-RDT ^extension.valueCode = #A
* 9-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 9-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DSC ^extension.valueCode = #A