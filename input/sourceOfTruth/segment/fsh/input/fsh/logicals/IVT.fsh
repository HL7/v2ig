Logical: IVT
Parent: $Segment
Id: IVT
Title: "HL7 v2 IVT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Material Location"
* 1 1..1 SI "IVT-1" "This field contains a sequential number that identifies this segment within a given Material Location segment group. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2062
* 2 1..1 EI "IVT-2" "This field contains the code identifying an inventory supply location that stocks or purchases this item."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2063
* 3 0..1 ST "IVT-3" "This field contains the name of the inventory supply location identified in _IVT-2, Inventory Location Identifier_."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "999"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2277
* 4 0..1 EI "IVT-4" "This field contains the code identifying the source location that purchases and stocks items in addition to filling supply requests for the location specified in _IVT-2, Inventory Location Identifier_. For example, IVT-2 may be considered Central Supply, an inventory location that issues to departments. _IVT-3, Inventory Location Name_, may be considered General Stores, a supply location that most items are received into when delivered to the healthcare facility. General Stores would then replenish the Central Supply inventory. Central Supply would then issue supplies to departments based on requests for supplies."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2064
* 5 0..1 ST "IVT-5" "This field contains the name of the source supply location identified in _IVT-4, Source Location Identifier_."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "999"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2278
* 6 0..1 CWE "IVT-6" "This field contains the status that applies to the inventory supply item for the inventory location specified in IVT-2. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70625[_User-defined Table 0625 – Item Status Codes_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0625 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2065
* 7 0..0 EI "IVT-7" "A unique code assigned to a bin location located within the inventory location in IVT-2, where the inventory supply item may be stored."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2066
* 8 0..1 CWE "IVT-8" "This field contains the primary packaging unit by which the item can be requisitioned or ordered to replenish the inventory supply item for the corresponding inventory location specified in _IVT-2, Inventory Location Identifier_. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70818[_User-defined Table 0818 – Package_] as described in _PKG-2 Packaging Units_, and presented in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0818 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2067
* 9 0..1 CWE "IVT-9" "This field contains the primary issue packaging unit by which the inventory supply item can be issued to departments or other locations by the corresponding inventory location specified in IVT-2. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70818[_User-defined Table 0818 – Package_] as described in _PKG-2 Packaging Units_, and presented in Chapter 2C, Code Tables, for suggested values."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2068
* 10 0..1 EI "IVT-10" "This field contains the general ledger number for the default inventory asset account used in journal transactions associated with items stored in this inventory location. The account includes all elements of a general ledger account (a fully qualified general ledger account number). All elements may include a corporation, department/cost center account, and expense account."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2069
* 11 0..1 CNE "IVT-11" "This field indicates whether the item is patient chargeable at this inventory location. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator Table_] in Chapter 2C, Code Tables, for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2070
* 12 0..1 CWE "IVT-12" "This field contains a code that is used by a billing system to charge for the inventory supply item, the descriptive name of the patient charge for that system (as it may appear on a patient's bill or charge labels) and the name of the coding system that assigned the charge code. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 – Transaction Codes]_ in Chapter 2C, Code Tables, for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #361
* 13 0..1 CP "IVT-13" "This field contains the dollar amount charged to patients for this single inventory supply item."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #366
* 14 0..1 CWE "IVT-14" "This field contains an indicator of the level of importance of an item considered for this inventory location, such as an indicator signifying whether the item is considered critical for this inventory location. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70634[_User-defined Table 0634 – Item Importance Codes_] in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0634 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2073
* 15 0..1 CNE "IVT-15" "This field contains an indicator that identifies whether the item is regularly stocked in this inventory location. Stock items are ordered regularly as part of the healthcare organization's inventory replenishment cycle. If the item is not regularly stocked in this inventory location (non-stock item), the item is available to be ordered from this inventory location if requested by a department. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator Table_] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2074
* 16 0..1 CNE "IVT-16" "This field contains an indicator signifying whether the inventory supply item is purchased on consignment. If the item is purchased on consignment, the healthcare organization does not pay for the inventory supply item until it is used. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator Table_] in Chapter 2C, Code Tables, for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2075
* 17 0..1 CNE "IVT-17" "This field contains an indicator signifying that the inventory supply item is reusable, for example, after sterilization. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator Table_] in Chapter 2C, Code Tables, for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2076
* 18 0..1 CP "IVT-18" "This field contains the issue cost charged to a department or patient for a reusable item. This cost is calculated based on the cost of reprocessing the item. Examples of reusable items are linens, restraints, and procedure packs (custom for specific procedures)."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2077
* 19 0..0 EI "IVT-19" "The substitute item is an item that is recommended as a substitute for the corresponding item in ITM-1."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #2078
* 20 0..1 EI "IVT-20" "The latex-free substitute item is an item that is latex-free, recommended as a substitute for the corresponding item in the _ITM-1_ segment when a latex-free item is needed."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #2079
* 21 0..1 CWE "IVT-21" "This field contains the method used to calculate a recommendation for when and how much of an inventory supply item to reorder. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70642[_User-defined Table 0642 – Reorder Theory Codes_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0642 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2080
* 22 0..1 NM "IVT-22" "This field contains the number of days for stock to be kept on-hand to cushion against a stock-out for this item."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 22 ^extension[=].extension[0].url = "length"
* 22 ^extension[=].extension[=].valueInteger = "4"
* 22 ^extension[=].extension[+].url = "noTruncate"
* 22 ^extension[=].extension[=].valueInteger = false
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2081
* 23 0..1 NM "IVT-23" "This field contains the maximum number of days of inventory to have on-hand at any one point in time. This value is used in calculations of recommended order quantities"
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "4"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = false
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2082
* 24 0..1 NM "IVT-24" "This field contains the on-hand quantity referencing the recommended level of inventory at which the item should be re-ordered."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 24 ^extension[=].extension[0].url = "length"
* 24 ^extension[=].extension[=].valueInteger = "8"
* 24 ^extension[=].extension[+].url = "noTruncate"
* 24 ^extension[=].extension[=].valueInteger = true
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2083
* 25 0..1 NM "IVT-25" "This field contains the quantity that the system should recommend to order when the on-hand quantity is equal to or less than the reorder point. The quantity should be set at the Order Unit of Measure."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 25 ^extension[=].extension[0].url = "length"
* 25 ^extension[=].extension[=].valueInteger = "8"
* 25 ^extension[=].extension[+].url = "noTruncate"
* 25 ^extension[=].extension[=].valueInteger = true
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2084
* 26 0..1 CNE "IVT-26" "This field contains an indicator that determines whether on-hands inventory will be decremented when performing Preference List Issues. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator Table_] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2085
* 26 ^comment = "If valued with a 'Y', this indicates to the system that the item to be issued is contained in an OR Par Level area (in an actual Operating Room) and not an Operating Room inventory area; therefore, on-hands of the Operation Room inventory area will not be decremented. If valued with a 'N', the item is contained in an Operating Room inventory location and on-hands will be decremented when performing Preference List Issues."