Logical: EHC_E10
Parent: V2MessageStructure
Id: EHC_E10
Title: "HL7 v2 EHC_E10 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E10"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E10"
* . ^definition = "EHC_E10 Message Structure"
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
* 6-INVOICE_PROCESSING_RESULTS_INFO 1..* BackboneElement "INVOICE_PROCESSING_RESULTS_INFO" "INVOICE_PROCESSING_RESULTS_INFO"
* 6-INVOICE_PROCESSING_RESULTS_INFO.1-IPR 1..1 http://hl7.org/v2/StructureDefinition/IPR "Invoice Processing Results" "Invoice Processing Results"
* 6-INVOICE_PROCESSING_RESULTS_INFO.1-IPR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.1-IPR ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 6-INVOICE_PROCESSING_RESULTS_INFO.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.2-NTE ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.3-PYE 1..1 http://hl7.org/v2/StructureDefinition/PYE "Payee" "Payee"
* 6-INVOICE_PROCESSING_RESULTS_INFO.3-PYE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.3-PYE ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.4-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 6-INVOICE_PROCESSING_RESULTS_INFO.4-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.4-IN1 ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.5-GSP 0..1 http://hl7.org/v2/StructureDefinition/GSP "*Person Gender and Sex*" "*Person Gender and Sex*"
* 6-INVOICE_PROCESSING_RESULTS_INFO.5-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.5-GSP ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.6-GSR 0..1 http://hl7.org/v2/StructureDefinition/GSR "*Recorded Gender and Sex*" "*Recorded Gender and Sex*"
* 6-INVOICE_PROCESSING_RESULTS_INFO.6-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.6-GSR ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.7-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Info" "Insurance Additional Info"
* 6-INVOICE_PROCESSING_RESULTS_INFO.7-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.7-IN2 ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.8-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 6-INVOICE_PROCESSING_RESULTS_INFO.8-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.8-IVC ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION 1..* BackboneElement "PRODUCT_SERVICE_SECTION" "PRODUCT_SERVICE_SECTION"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.1-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.1-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.1-PSS ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP 1..* BackboneElement "PRODUCT_SERVICE_GROUP" "PRODUCT_SERVICE_GROUP"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO 1..* BackboneElement "PRODUCT_SERVICE_LINE_INFO" "PRODUCT_SERVICE_LINE_INFO"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.1-PSL ^extension.valueCode = #A
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.2-ADJ 0..* http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.2-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-INVOICE_PROCESSING_RESULTS_INFO.9-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PRODUCT_SERVICE_LINE_INFO.2-ADJ ^extension.valueCode = #A