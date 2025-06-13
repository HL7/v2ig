Logical: EHC_E04
Parent: V2MessageStructure
Id: EHC_E04
Title: "HL7 v2 EHC_E04 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E04"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E04"
* . ^definition = "EHC_E04 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-REASSESSMENT_REQUEST_INFO 1..1 BackboneElement "REASSESSMENT_REQUEST_INFO" "REASSESSMENT_REQUEST_INFO"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group 0..1 BackboneElement "Choice 1 within REASSESSMENT_REQUEST_INFO" "Choice 1 within REASSESSMENT_REQUEST_INFO"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.1-IVC ^extension.valueCode = #A
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.2-NTE ^extension.valueCode = #A
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION 0..* BackboneElement "PRODUCT_SERVICE_SECTION" "PRODUCT_SERVICE_SECTION"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.1-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.1-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.1-PSS ^extension.valueCode = #A
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP 0..* BackboneElement "PRODUCT_SERVICE_GROUP" "PRODUCT_SERVICE_GROUP"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.valueCode = #A
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL 0..* http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-REASSESSMENT_REQUEST_INFO.choice-1-Group.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL ^extension.valueCode = #A