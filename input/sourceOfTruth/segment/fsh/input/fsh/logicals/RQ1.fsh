Logical: RQ1
Parent: $Segment
Id: RQ1
Title: "HL7 v2 RQ1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Requisition Detail-1"
* 1 0..1 ST "RQ1-1" "This field contains the reference price for the requisition unit of measure that is known to the requisition application. It may or may not be the actual cost of acquiring the item from a supplier. It is also not the price charged to the patient."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "10"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #285
* 2 0..1 CWE "RQ1-2" "This field contains the unique code that identifies the manufacturer on the application receiving the requisition. This field is conditional because either RQ1-2-manufacturer ID and RQ1-3-manufacturer's catalog or RQ1-4-vendor ID and RQ1-5-vendor catalog must be valued."
* 2 from http://terminology.hl7.org/ValueSet/v2-0385 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #286
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70385[User-defined Table 0385 – Manufacturer identifier] in Chapter 2C, Code Tables, for suggested values, or relevant external code sets may be used (e.g., HIBCC Manufacturers Labeler ID Code (LIC), UPC, NDC)."
* 3 0..1 ST "RQ1-3" "This field is the manufacturer's catalog number or code for this item. This field is conditional because either RQ1-2-manufacturer ID and RQ1-3-manufacturer's catalog or RQ1-4-vendor ID and RQ1-5-vendor catalog must be valued."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "16"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #287
* 4 0..1 CWE "RQ1-4" "This field is the unique code that identifies the vendor on the application receiving the requisition. This field is conditional because either RQ1-2-manufacturer ID and RQ1-3-manufacturer's catalog or RQ1-4-vendor ID and RQ1-5-vendor catalog must be valued. Refer to Table 0683 - Vendor ID in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0683 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #288
* 4 ^comment = "Because of this, it is recommended that each non-stock item have RQ1-2-manufacturers ID and RQ1-3-manufacturer's catalog, or RQ1-4-vendor ID and RQ1-5-vendor catalog. It is also possible that the requisitioning application will not know the identifier, as listed in the Manufacturer's or Vendor's catalog. In this case, it is important to include the name portion of this coded element field."
* 5 0..1 ST "RQ1-5" "This field is the vendor's catalog number, name, or code for this item. This field is conditional because either RQ1-2-manufacturer ID and RQ1-3-manufacturer's catalog or RQ1-4-vendor ID and RQ1-5-vendor catalog must be valued."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "16"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #289
* 6 0..1 ID "RQ1-6" "This field indicates whether this item is subject to tax."
* 6 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #290
* 6 ^comment = "In general, non-stock requisitioned items will be printed by the receiving application and then processed by a human. In other words, the human will use the information to call the vendor or manufacturer to get pricing and other related purchasing information before placing the order with an outside vendor. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 -Yes/No Indicator] as defined in Chapter 2C, Code Tables."
* 7 0..1 ID "RQ1-7" "This field indicates whether the ancillary department may substitute an equivalent version of the item(s) ordered. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/No Indicator] as defined in Chapter 2C, Code Tables."
* 7 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #291