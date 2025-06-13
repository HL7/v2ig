Logical: EHC_E02
Parent: V2MessageStructure
Id: EHC_E02
Title: "HL7 v2 EHC_E02 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "EHC_E02"
* ^date = "2025-06-13T21:11:37Z"
* . ^short = "EHC_E02"
* . ^definition = "EHC_E02 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Secondary Header" "Secondary Header"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..* http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL 1..1 BackboneElement "INVOICE_INFORMATION_CANCEL" "INVOICE_INFORMATION_CANCEL"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group 0..1 BackboneElement "Choice 1 within INVOICE_INFORMATION_CANCEL" "Choice 1 within INVOICE_INFORMATION_CANCEL"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.1-IVC 1..1 http://hl7.org/v2/StructureDefinition/IVC "Invoice" "Invoice"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.1-IVC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.1-IVC ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.2-PYE 1..1 http://hl7.org/v2/StructureDefinition/PYE "Payee Information" "Payee Information"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.2-PYE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.2-PYE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.3-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.3-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.3-CTD ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.4-NTE ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION 0..* BackboneElement "PRODUCT_SERVICE_SECTION" "PRODUCT_SERVICE_SECTION"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.1-PSS 1..1 http://hl7.org/v2/StructureDefinition/PSS "DESCRIPTION NEEDED" "DESCRIPTION NEEDED"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.1-PSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.1-PSS ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG 0..* BackboneElement "PSG" "PSG"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.1-PSG 1..1 http://hl7.org/v2/StructureDefinition/PSG "Product/Service Group" "Product/Service Group"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.1-PSG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.1-PSG ^extension.valueCode = #A
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.2-PSL 0..* http://hl7.org/v2/StructureDefinition/PSL "Product/Service Line Item" "Product/Service Line Item"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.2-PSL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-INVOICE_INFORMATION_CANCEL.choice-1-Group.5-PRODUCT_SERVICE_SECTION.2-PSG.2-PSL ^extension.valueCode = #A