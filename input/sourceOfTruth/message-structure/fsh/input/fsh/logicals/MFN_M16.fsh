Logical: MFN_M16
Parent: V2MessageStructure
Id: MFN_M16
Title: "HL7 v2 MFN_M16 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "MFN_M16"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "MFN_M16"
* . ^definition = "MFN_M16 Message Structure"
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
* 5-MATERIAL_ITEM_RECORD 1..* BackboneElement "MATERIAL_ITEM_RECORD" "MATERIAL_ITEM_RECORD"
* 5-MATERIAL_ITEM_RECORD.1-MFE 1..1 http://hl7.org/v2/StructureDefinition/MFE "Master File Entry" "Master File Entry"
* 5-MATERIAL_ITEM_RECORD.1-MFE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.1-MFE ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.2-ITM 1..1 http://hl7.org/v2/StructureDefinition/ITM "Material Item" "Material Item"
* 5-MATERIAL_ITEM_RECORD.2-ITM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.2-ITM ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes for ITM" "Notes for ITM"
* 5-MATERIAL_ITEM_RECORD.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.3-NTE ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION 0..* BackboneElement "STERILIZATION" "STERILIZATION"
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.1-STZ 1..1 http://hl7.org/v2/StructureDefinition/STZ "Sterilization Parameters" "Sterilization Parameters"
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.1-STZ ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.1-STZ ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes for STZ" "Notes for STZ"
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.4-STERILIZATION.2-NTE ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR 0..* BackboneElement "PURCHASING_VENDOR" "PURCHASING_VENDOR"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.1-VND 1..1 http://hl7.org/v2/StructureDefinition/VND "Purchasing Vendor" "Purchasing Vendor"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.1-VND ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.1-VND ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING 0..* BackboneElement "PACKAGING" "PACKAGING"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.1-PKG 1..1 http://hl7.org/v2/StructureDefinition/PKG "Packaging" "Packaging"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.1-PKG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.1-PKG ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.2-PCE 0..* http://hl7.org/v2/StructureDefinition/PCE "Patient Charge Cost Center Exception" "Patient Charge Cost Center Exception"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.2-PCE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.5-PURCHASING_VENDOR.2-PACKAGING.2-PCE ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION 0..* BackboneElement "MATERIAL_LOCATION" "MATERIAL_LOCATION"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.1-IVT 1..1 http://hl7.org/v2/StructureDefinition/IVT "Material Location" "Material Location"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.1-IVT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.1-IVT ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.2-ILT 0..* http://hl7.org/v2/StructureDefinition/ILT "Material Lot/Quantity" "Material Lot/Quantity"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.2-ILT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.2-ILT ^extension.valueCode = #A
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes for IVT" "Notes for IVT"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-MATERIAL_ITEM_RECORD.6-MATERIAL_LOCATION.3-NTE ^extension.valueCode = #A