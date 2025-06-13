Logical: CTR
Parent: $Segment
Id: CTR
Title: "HL7 v2 CTR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Contract Master Outbound"
* 1 1..1 EI "CTR-1" "The Contract Identifier is a unique code assigned to the contract by the manufacturer or distributor to identify the contract."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2392
* 2 0..1 ST "CTR-2" "The Contract Description is a description of the contract identified in CTR-1."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "999"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = true
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2393
* 3 0..1 CWE "CTR-3" "The status (useful for determining whether the contract price should be used for ordering) that applies to the contract. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70536[_User-defined Table 0536 – Certificate Status_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0536 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2394
* 4 1..1 DTM "CTR-4" "The Effective Date is the date that the contract becomes available to purchase from."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2395
* 5 1..1 DTM "CTR-5" "Definition: The Expiration Date is the date that the contract becomes unavailable to purchase from."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2396
* 6 0..1 XPN "CTR-6" "This field contains the name of the person who manages the contract."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2397
* 7 0..1 XPN "CTR-7" "This field contains the name of the person who created the contract."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2398
* 8 1..1 CWE "CTR-8" "This field contains the type of supplier associated to the contract. Suggested values ‘Distributor’ or ‘Manufacturer’."
* 8 from http://terminology.hl7.org/ValueSet/v2-0946 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2399
* 8 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70946[_User-defined Table 0946 – Supplier Type_] in Chapter 2C, Code Tables, for suggested values."
* 9 0..1 CWE "CTR-9" "The Contract Type is an identifier of the contract which designates the source of the contract. Suggested values: L=Local, G=Global, and values can be defined by the source (user defined) such as the GPO or the distributor. Refer to User Defined Table 0965 – Contract Types in Chapter 2 C for examples."
* 9 from http://terminology.hl7.org/ValueSet/v2-0965 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2400
* 10 0..1 CNE "CTR-10" "This field indicates whether or not Free On Board freight terms are applicable to the contract."
* 10 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2401
* 10 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[HL7 Table 0532 - Expanded Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 11 0..1 DTM "CTR-11" "This field contains the date through which the contract item prices are protected by an agreement with the vendor."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2402
* 12 0..1 CNE "CTR-12" "This field indicates whether the items selected for the contract are purchased at the price indicated in the Contract Price or not. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[HL7 Table 0532 - Expanded Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2403
* 13 0..1 XON "CTR-13" "This field contains the identifier which identifies the GPO organization."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2404
* 14 0..1 MOP "CTR-14" "This field contains the highest percentage that can be applied to each item’s Product Cost."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2405
* 15 0..1 MOP "CTR-15" "This field contains the actual percentage (markup or discount) applied to each item’s Product Cost."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2406
* 16 0..0 XON "CTR-16" "This field contains a corporation identifier (code and name) of the entity allowed to purchase from this contract."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2407
* 16 ^comment = "Condition: This field shall be valued if CRT-17 Parent of Corporation is valued."
* 17 0..1 XON "CTR-17" "This field contains the parent of the corporation sent in CTR-17 such as an integrated delivery network."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2408
* 18 0..1 CWE "CTR-18" "This field contains the tier level at which this contract is priced. Pricing Tier level determines the price of the item on the contract. Tier Level can be assigned to an IDN or at a corporation level and is typically based on volume purchased (determined by $ or a %). The larger the volume purchased, the lower priced tier level is assigned to the contract. This value can change over the life of the contract if purchasing volume changes after initial contract signing. Example 01^Tier One, 02^Tier 2, etc. Refer to User Defined Table 0966 – Pricing Tier Level in Chapter2C for examples."
* 18 from http://terminology.hl7.org/ValueSet/v2-0966 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2409
* 19 0..1 ST "CTR-19" "This field contains the a value which represents the priority of this contract. In some cases there are multiple contracts associated to a given supply item, each needs a priority to determine which price to default to when ordering items on this contract. This field could be text or numeric."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #2410
* 20 0..1 CWE "CTR-20" "This field contains an indicator signifying whether the purchasing channel such as a hospital or retail, etc."
* 20 from http://terminology.hl7.org/ValueSet/v2-0947 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #2411
* 20 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70947[_User-defined Table 0947 – Supplier Type Class of Trade_] in Chapter 2C, Code Tables, for suggested values."
* 21 0..1 EI "CTR-21" "This field contains an indicator signifying contract IDs of related contracts. An example is a vendor contract which (supplier type = D) could be associated to a manufacturer (supplier type = M) contract; this field would contain the manufacturer contract ID."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2412