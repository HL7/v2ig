Logical: EHC_E15
Parent: V2MessageStructure
Id: EHC_E15
Title: "HL7 v2 EHC_E15 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E15"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E15"
* . ^definition = "EHC_E15 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-PAYMENT_REMITTANCE_HEADER_INFO 1..1 BackboneElement "PAYMENT_REMITTANCE_HEADER_INFO" "PAYMENT_REMITTANCE_HEADER_INFO"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group 0..1 BackboneElement "Choice 1 within PAYMENT_REMITTANCE_HEADER_INFO" "Choice 1 within PAYMENT_REMITTANCE_HEADER_INFO"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.1-PMT 1..1 http://hl7.org/v2/StructureDefinition/PMT "Payment Information" "Payment Information"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.1-PMT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.1-PMT ^extension.valueCode = #A
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.2-PYE 1..1 http://hl7.org/v2/StructureDefinition/PYE "Payee Information" "Payee Information"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.2-PYE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PAYMENT_REMITTANCE_HEADER_INFO.choice-1-Group.2-PYE ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO 0..* BackboneElement "PAYMENT_REMITTANCE_DETAIL_INFO" "PAYMENT_REMITTANCE_DETAIL_INFO"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.1-IPR 1..1 http://hl7.org/v2/StructureDefinition/IPR "Invoice Processing Results" "Invoice Processing Results"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.1-IPR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.1-IPR ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.2-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.2-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.2-IVC ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION 1..* BackboneElement "PRODUCT_SERVICE_SECTION" "PRODUCT_SERVICE_SECTION"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.1-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "Product/Service Section" "Product/Service Section"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.1-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.1-PSS ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP 1..* BackboneElement "PRODUCT_SERVICE_GROUP" "PRODUCT_SERVICE_GROUP"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.1-PSG ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO 1..* BackboneElement "PSL_ITEM_INFO" "PSL_ITEM_INFO"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.1-PSL 1..1 http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.1-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.1-PSL ^extension.valueCode = #A
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.2-ADJ 0..* http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.2-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PAYMENT_REMITTANCE_DETAIL_INFO.3-PRODUCT_SERVICE_SECTION.2-PRODUCT_SERVICE_GROUP.2-PSL_ITEM_INFO.2-ADJ ^extension.valueCode = #A
* 6-ADJUSTMENT_PAYEE 0..* BackboneElement "ADJUSTMENT_PAYEE" "ADJUSTMENT_PAYEE"
* 6-ADJUSTMENT_PAYEE.1-ADJ 1..1 http://hl7.org/v2/StructureDefinition/ADJ "Adjustment" "Adjustment"
* 6-ADJUSTMENT_PAYEE.1-ADJ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ADJUSTMENT_PAYEE.1-ADJ ^extension.valueCode = #A
* 6-ADJUSTMENT_PAYEE.2-PRT 0..1 http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-ADJUSTMENT_PAYEE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ADJUSTMENT_PAYEE.2-PRT ^extension.valueCode = #A
* 6-ADJUSTMENT_PAYEE.3-ROL 0..1 http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 6-ADJUSTMENT_PAYEE.3-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-ADJUSTMENT_PAYEE.3-ROL ^extension.valueCode = #A