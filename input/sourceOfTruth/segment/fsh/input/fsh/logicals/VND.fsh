Logical: VND
Parent: $Segment
Id: VND
Title: "HL7 v2 VND Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Purchasing Vendor"
* 1 1..1 SI "VND-1" "This field contains a sequential number that identifies this segment within a given PURCHASING_VENDOR segment group. For the first occurrence of the segment in a given group, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2217
* 2 1..1 EI "VND-2" "This field contains the identifier of the vendor in the system."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2218
* 3 0..1 ST "VND-3" "This field contains the name of the vendor identified in _VND-2_."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "999"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2276
* 4 0..1 EI "VND-4" "This field contains the catalog number assigned to the item by a purchasing vendor."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2219
* 5 0..1 CNE "VND-5" "This field contains an indicator to communicate whether this purchasing vendor is the primary vendor used to place orders for inventory supply item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2220
* 6 0..0 EI "VND-6" "This field contains a corporation indentifier (code and name) of the entity allowed to purchase from this contract for this vendor."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2420
* 7 0..1 XCN "VND-7" "This field contains the primary contact person of this vendor item."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2421
* 8 0..1 MOP "VND-8" "This field contains the markup amount for this contract item and vendor combination."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2422
* 9 0..0 EI "VND-9" "This field contains a contract that is linked to the contract sent in the CTR segment (described in Chapter 8). For example, the contract in CTR maybe of supplier type M (manufacturer); a contract sent in VND may be a linked distributor contract for a supplier authoized so distribute this item."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2423
* 10 0..0 ST "VND-10" "This field contains the class of trade if identified at the vendor item level."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2424
* 11 0..1 CWE "VND-11" "This field contains the tier level at which this contract is priced for the vendor sent in this segment. Pricing Tier level determines the price of the item on the contract. Tier Level can be assigned to an IDN or at a corporation level and is typically based on volume purchased (determined by $ or a %). The larger the volume purchased, the lower priced tier level is assigned to the contract. This value can change over the life of the contract if purchasing volume changes after initial contract signing.Example 01^Tier One, 02^Tier 2, etc No HL7 table is defined here, because it needs to be defined by trading partner agreement, including the identification of code system to use."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2425