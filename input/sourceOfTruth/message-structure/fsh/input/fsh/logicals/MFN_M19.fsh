Logical: MFN_M19
Parent: V2MessageStructure
Id: MFN_M19
Title: "HL7 v2 MFN_M19 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M19"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M19"
* . ^definition = "MFN_M19 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-MFI 1..1 http://hl7.org/v2/StructureDefinition/MFI "Master File Identification" "Master File Identification"
* 4-MFI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-MFI ^extension.valueCode = #A
* 5-CONTRACT_RECORD 1..* BackboneElement "CONTRACT_RECORD" "CONTRACT_RECORD"
* 5-CONTRACT_RECORD.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-CONTRACT_RECORD.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.1-MFE ^extension.valueCode = #A
* 5-CONTRACT_RECORD.2-CTR 1..1 http://hl7.org/v2/StructureDefinition/CTR "Supply Item Contract" "Supply Item Contract"
* 5-CONTRACT_RECORD.2-CTR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.2-CTR ^extension.valueCode = #A
* 5-CONTRACT_RECORD.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes for CTR" "Notes for CTR"
* 5-CONTRACT_RECORD.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.3-NTE ^extension.valueCode = #A
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD 1..* BackboneElement "MATERIAL_ITEM_RECORD" "MATERIAL_ITEM_RECORD"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.1-ITM 1..1 http://hl7.org/v2/StructureDefinition/ITM "Material Item" "Material Item"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.1-ITM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.1-ITM ^extension.valueCode = #A
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR 1..* BackboneElement "PURCHASING_VENDOR" "PURCHASING_VENDOR"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.1-VND 1..1 http://hl7.org/v2/StructureDefinition/VND "Purchasing Vendor" "Purchasing Vendor"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.1-VND ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.1-VND ^extension.valueCode = #A
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.2-PACKAGING 0..* BackboneElement "PACKAGING" "PACKAGING"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.2-PACKAGING.1-PKG 1..1 http://hl7.org/v2/StructureDefinition/PKG "Packaging" "Packaging"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.2-PACKAGING.1-PKG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-CONTRACT_RECORD.4-MATERIAL_ITEM_RECORD.2-PURCHASING_VENDOR.2-PACKAGING.1-PKG ^extension.valueCode = #A