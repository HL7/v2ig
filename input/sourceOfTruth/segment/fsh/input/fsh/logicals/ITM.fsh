Logical: ITM
Parent: $Segment
Id: ITM
Title: "HL7 v2 ITM Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Material Item"
* 1 1..1 EI "ITM-1" "The Item Identifier is a unique code assigned to the material item by the Item Inventory Master catalog software application to identify the item."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2186
* 2 0..1 ST "ITM-2" "The Item Description is a description of the material item identified in ITM-1."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "999"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = true
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2274
* 3 0..1 CWE "ITM-3" "The status (useful for reporting and item usage purposes) that applies to an item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70776[_User-defined Table 0776 – Item Status_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0776 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2187
* 4 0..1 CWE "ITM-4" "The Item Type is a classification of material items into like groups as defined and utilized within an Operating Room setting for charting procedures. An Item Type is a higher level of classification than an Item Category as described in ITM-4. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70778[_User-defined Table 0778 – Item Type_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0778 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2188
* 5 0..1 CWE "ITM-5" "The Item Category is a classification of material items into like groups for the purpose of categorizing purchases and reporting within a materials management setting. The Item Category classification is a lower level grouping of material items than what is described in ITM-3 as Item Type. UNSPSC is the recommended coding system."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2189
* 6 0..1 CNE "ITM-6" "This field contains an indicator used as a reference to specify whether the item is subject to containing an expiration date. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2190
* 7 0..1 EI "ITM-7" "This field identifies the identifying code of the manufacturer of the item."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2191
* 8 0..1 ST "ITM-8" "This field identifies the name of the manufacturer of the manufacturer identified in ITM-7."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "999"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2275
* 9 0..1 ST "ITM-9" "This field contains the catalog assigned to the item by the manufacturer."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "20"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2192
* 10 0..1 CWE "ITM-10" "This field contains the Labeler Identification Code (LIC) number assigned to the manufacturer that represents the manufacturer of the item."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2193
* 11 0..1 CNE "ITM-11" "This field indicates whether the item is patient chargeable. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2070
* 12 0..1 CWE "ITM-12" "This field contains the code assigned by the institution for the purpose of uniquely identifying a patient billing code specific for a supply item. In the context of this message, this is a code that is a cross-reference to the Item Code/Id. This field would be used to uniquely identify a procedure, supply item, or test for charges; or to identify the payment medium for payments. It can reference, for example, a CBC (a lab charge), or an Elastic Bandage 3'' (supply charge), or Chest 1 View (radiology charge). For instance the code would be 300-0001, with a description of CBC."
* 12 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #361
* 12 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[_User-__defined Table 0132 - Transaction Code_] in Chapter 2C, Code Tables, for suggested values. See Chapter 7 for a discussion of the universal service ID for charges."
* 13 0..1 CP "ITM-13" "Unit price of transaction. Price of a single item. This field contains the dollar amount charged to patients for this item."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #366
* 14 0..1 CNE "ITM-14" "This field contains an indicator signifying whether the item is stocked in any inventory location in the healthcare organization. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2197
* 15 0..1 CWE "ITM-15" "This field contains a code that identifies any known or suspected hazard associated with this material item. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70871[User-defined Table 0871 – Supply Risk Code]s_ in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0871 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2266
* 16 0..0 XON "ITM-16" "This field contains a code indicating the regulatory agency the item has been approved by, such as the FDA or AMA."
* 16 from http://terminology.hl7.org/ValueSet/v2-0790 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2199
* 16 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70790[_User-defined Table 0790 – Approving Regulatory Agency_] in Chapter 2C, Code Tables, for suggested values."
* 17 0..1 CNE "ITM-17" "This field contains an indicator signifying whether the item is made of or contains latex. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2200
* 18 0..0 CWE "ITM-18" "This field contains a code indicating an act containing a rule that the item is legally required to be included in notification reporting. This code is often used for reporting or tracking. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70793[_User-defined Table 0793 – Ruling Act_] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0793 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2201
* 19 0..1 CWE "ITM-19" "This field contains the expense/natural account number from the general ledger chart of accounts associated with the item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70320[_HL7 Table 0320 – Item Natural Account Code_] in Chapter 4, Orders, for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0320 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #282
* 20 0..1 NM "ITM-20" "This field contains the quantity of this item that can be purchased within a user-defined time frame (e.g., one year) at the order unit of measure."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "6"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = true
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #2203
* 21 0..1 MO "ITM-21" "This field contains the dollar limit of this item that you can purchase within a user-defined time frame (e.g., one year)."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2204
* 22 0..1 CNE "ITM-22" "This field contains an indicator signifying whether the item is taxable when purchasing the item or issuing the item to patients. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2205
* 23 0..1 CNE "ITM-23" "This field contains an indicator signifying whether freight is an allowable charge to be allocated to the line of an invoice containing the item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2206
* 24 0..1 CNE "ITM-24" "This field contains an indicator signifying whether the item is an 'item set' rather than an individual item. An item set is a set of surgical supplies. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2207
* 25 0..1 EI "ITM-25" "The Item Set Identifier is a unique code assigned to the material item by the Item Inventory Master catalog software application to identify the item set."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2208
* 26 0..1 CNE "ITM-26" "This field contains an indicator signifying whether the usage figures are tracked for this item by department. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2209
* 27 0..1 CNE "ITM-27" "This field contains a unique identifier assigned to the service item, if any, associated with the charge. In the United States this is often the HCPCS code. Refer to Externally defined Table 0088 - Procedure code for suggested values. This field is a CNE data type for compatibility with clinical and ancillary systems. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70088[_HL7 Table 0088 – Procedure Coding Systems_] in Chapter 2C, Code Tables, for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #393
* 27 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation."
* 28 0..0 CNE "ITM-28" "This field contains the procedure code modifier to the procedure code reported in _ITM-27, Procedure Code_, when applicable. Procedure code modifiers are defined by USA regulatory agencies such as CMS and the AMA. Multiple modifiers may be reported. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70340[_Externally-defined Table 0340 - Procedure Code Modifier_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0340 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1316
* 29 0..1 CWE "ITM-29" "This field contains a special handling code to describe special handling considerations for this item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[_User-defined Table 0376 – Special Handling Code_] in Chapter 2C, Code Tables, for suggested values. The value set can be extended with user specific values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1370
* 30 0..1 CNE "ITM-30" "This field contains an indicator signifying whether the item contains hazardous material or not. Refer to _HL7 Table 0532 - Expanded yes/no indicator table_ in Chapter 2, Code Tables, for valid values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #3388
* 31 0..1 CNE "ITM-31" "This field contains an indicator signifying whether the item is sterile or not. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[HL7 Table 0532 - Expanded yes/no indicator table]_ in Chapter 2, Code Tables, for valid values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #3304
* 32 0..1 EI "ITM-32" "The Material Safety Data Sheet Number is the manufacturer's identification number for the Material Saftey Data Sheet (if one exists for the item). A Material Safety Data Sheet contains the characteristics, protected measures, and regulations to follow when handling the item. It is relevant for dangerous substances. Field3 3 and 4 of the EI data type may be blank for communicating MSDS number; Manufacturer is already identified in this message via _ITM-7, Manufacturer Identifier_, and _ITM-8, Manufacturer Name_."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #3305
* 33 0..1 CWE "ITM-33" "The United Nations Standard Products and Services Code is the category code assigned by the UNSPSC organization to the item. Please refer to the code \"UNSPSC\" as indicated for the United Nations Standards Products and Services Code as referenced in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70396[_HL7 Table 0396 - Coding System_] in Chapter 2C, Code Tables."
* 33 from http://terminology.hl7.org/ValueSet/v2-0396 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #3306
* 34 0..1 DR "ITM-34" "The date that the contract becomes effective (Range Start Date/Time) and when it expires (Range End Date/Time) for the item specified in ITM-1. The effective date is the date that the contract becomes available to purchase this item. The expiration date is the date that the contract becomes unavailable to purchase this item."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #2415
* 35 0..1 XPN "ITM-35" "This field contains the name of the contact person associated to the manufacturer of this item."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #2416
* 36 0..1 XTN "ITM-36" "This field contains the contact information of the contact person associated to the manufacturer of this item."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #2417
* 37 0..1 ST "ITM-37" "This field contains the class of trade if identified at the item level."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #2418
* 38 0..1 ID "ITM-38" "The event code related to the item in ITM.1. Refer to _HL7 Table 0180 – Master File Action Code table_ in Chapter 2, Code Tables, for valid values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0180 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #2419