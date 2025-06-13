Logical: ILT
Parent: $Segment
Id: ILT
Title: "HL7 v2 ILT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Material Lot"
* 1 1..1 SI "ILT-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2086
* 2 1..1 ST "ILT-2" "This field contains the lot number of the service item in inventory."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "250"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1800
* 2 ^comment = "*Note:* The lot number is the number printed on the label attached to the item or container holding the substance. If the substance is a vaccine, for example, and a diluent is required, a lot number may appear on the vial containing the diluent; however, any such identifier associated with a diluent is not the identifier of interest. The substance lot number should be reported, not that of the diluent.\n\nNote:"
* 3 0..1 DTM "ILT-3" "This field contains the expiration date of the service item in inventory."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1801
* 3 ^comment = "*Note:* Expiration date does not always have a \"day\" component; therefore, such a date may be transmitted as YYYYMM."
* 4 0..1 DTM "ILT-4" "This field contains the most recent date that the product in question was received into inventory."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1804
* 5 0..1 NM "ILT-5" "This field contains the quantity of this inventory item that was received on the date specific in _ILT-4 Inventory Received Date_ field."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "12"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1805
* 6 0..1 CWE "ILT-6" "This field specifies the unit for the _Inventory Received Quantity_. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70818[_User-defined Table 0818 – Package_] as described in _PKG-2 Packaging Units_ and as presented in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0818 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1806
* 7 0..1 MO "ILT-7" "This field contains the per-unit cost of the inventory item at the time of receipt. _ILT-6 Inventory Received Quantity Unit_ field specifies the per-unit basis of this field."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1807
* 8 0..1 DTM "ILT-8" "This field specifies the most recent date that an inventory count was performed for the inventory item."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1808
* 9 0..1 NM "ILT-9" "This field contains the quantity of this inventory item that was available for issue/use as of the date specified in _ILT-8 Inventory on Hand Date_ field. No adjustment has been made for subsequent use."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "12"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = true
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1809
* 10 0..1 CWE "ILT-10" "This field contains the quantity of this inventory item that was available for issue/use as of the date specified in _ILT-8 Inventory on Hand Date_ field. No adjustment has been made for subsequent use. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70818[_User-defined Table 0818 – Package_] as described in _PKG-2 Packaging Units_ and as presented in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0818 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1810