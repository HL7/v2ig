Logical: PRC
Parent: $Segment
Id: PRC
Title: "HL7 v2 PRC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Pricing"
* 1 1..1 CWE "PRC-1" "This field contains the code assigned by the institution for the purpose of uniquely identifying the thing that can be charged. The key field of the entry. For example, this field would be used to uniquely identify a procedure, item, or test for charging purposes. Probably the same set of values as used in _FT1-7 - Transaction Code_ in financial messages. Must match _MFE-4 - Primary Key - MFE_ and _CDM-1 - Primary Key - CDM_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 - Transaction code] in Chapter 2C, Code Tables, for suggested values. See Chapter 7 for discussion of the universal service ID."
* 1 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #982
* 2 0..0 CWE "PRC-2" "This field contains the facility of the institution for which this price (for the preceding CDM entry) is valid. For use when needing multi-facility pricing. If null, assume all facilities. In a multi-facility environment, the facility associated with this chargeable item may not be the same as the sending or receiving facility identified in the MSH segment. Use only when the price is not the same for all facilities, that is, a null value indicates that this pricing is valid for all facilities."
* 2 from http://terminology.hl7.org/ValueSet/v2-0464 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #995
* 2 ^comment = "When two PRC segments are sent with the same key values but different facility identifiers, the second is sent in addition to the first, not to replace the first. The effective unique identifier is the charge code (_PRC-1 - Primary Key Value - PRC_) plus the facility ID (_PRC-2 - Facility ID_). Multiple facility identifiers can be sent in the same segment to indicate that those facilities use the same pricing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70464[User-defined Table 0464 - Facility ID] in Chapter 2C, Code Tables, for suggested values."
* 3 0..0 CWE "PRC-3" "This field contains the department of the facility which accrues revenue/cost for this type of charge. When pricing is different for different departments within the same facility, this will indicate for which department the following pricing information is valid. Use only when the price is not the same for all departments, that is, a null value indicates that this pricing is valid for all departments."
* 3 from http://terminology.hl7.org/ValueSet/v2-0184 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #676
* 3 ^comment = "When two PRC segments are sent the same key values but with different departments, the second is sent in addition to the first, not to replace the first. The effective unique identifier is the charge code _(PRC-1 - Primary Key - PRC_) plus the facility ID (_PRC-2 - Facility ID_) plus the department (_PRC-3 - Department_). Multiple departments can be sent in the same segment to indicate that those departments use the same pricing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70184[User-defined Table 0184 - Department] in Chapter 2C, Code Tables, for suggested values."
* 4 0..0 CWE "PRC-4" "This field contains the patient types for which this charge description is valid. For example, Inpatient, Outpatient, Series, Clinic, ER, Ambulatory, Observation, etc. These values should be the same set of values as those used for _PV1-3 - Patient Class_, which is site defined. Use only when the price is not valid for all patient types, that is, a null value indicates that this pricing is valid for all patient classes. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70004[User-defined Table 0004 - Patient Class] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0004 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "1"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = false
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #967
* 4 ^comment = "When two PRC segments are sent the same key values but with different valid patient classes, the second is sent in addition to the first, not to replace the first. The effective unique identifier is the charge code (_PRC-1 - PRC Primary Key_) plus the facility ID (_PRC-2 - Facility ID_) plus the department (_PRC-3 - Department_) plus the patient class (_PRC-4 - Valid Patient Classes_). Multiple patient classes can be sent in the same segment to indicate that those patient classes use the same pricing."
* 5 0..0 CP "PRC-5" "This field contains the price to be charged for service, item, or procedure. If CDM price will always be overridden when charges are posted, then this field is optional. Otherwise, price would be a required field. The formula or calculation that is to be used to get total price from these price components is left to implementation negotiations agreed upon by the participating institutions. See Chapter 2, section 2.8.8, \"CP - composite price,\" for a description of the use of the composite price (CP) data type."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #998
* 6 0..0 ST "PRC-6" "This field contains the mathematical formula to apply to _PRC-5 - Price_ in order to compute total price. The syntax of this formula must conform to Arden Syntax rules."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "200"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #999
* 7 0..1 NM "PRC-7" "This field contains the minimum number of identical charges allowed on one patient account for this CDM entry."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "4"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1000
* 8 0..1 NM "PRC-8" "This field contains the maximum number of identical charges allowed on one patient account for this CDM entry."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "4"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1001
* 9 0..1 MO "PRC-9" "This field contains the minimum total price (after computation of components of price) that can be charged for this item."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1002
* 10 0..1 MO "PRC-10" "This field contains the maximum total price (after computation of components of price) that can be charged for this item."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1003
* 11 0..1 DTM "PRC-11" "This field contains the date/time when this CDM entry becomes effective."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1004
* 12 0..1 DTM "PRC-12" "This field contains the date/time when this CDM entry is no longer effective."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1005
* 13 0..1 CWE "PRC-13" "This field indicates whether this CDM entry's price can be overridden. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70268[User-defined Table 0268 - Override] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0268 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "1"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1006
* 14 0..0 CWE "PRC-14" "This field contains the billing category codes for any classification systems needed, for example, general ledger codes and UB92 categories. Repeating field with coded entry made up of category code plus category system. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70293[User-defined Table 0293 - Billing category] in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0293 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1007
* 15 0..1 ID "PRC-15" "This field contains a chargeable indicator. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^extension[=].extension[+].url = "max"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1008
* 15 ^comment = "N charge is not billable, that is, do not create charges for this CDM entry; this is zero price item\n\nY item is billable (this is also the default when NULL)"
* 16 0..1 ID "PRC-16" "This indicates whether this is a usable CDM entry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70183[HL7 Table 0183 - Active/Inactive] in Chapter 2C, Code Tables, for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0183 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^extension[=].extension[+].url = "max"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #675
* 17 0..1 MO "PRC-17" "This field contains the institution's calculation of how much it costs to provide this item, that is, what the institution had to pay for the material plus any specified payment expenditure, effort or loss due to performing or providing the chargeable item."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #989
* 18 0..1 CWE "PRC-18" "This field contains the user-defined table of values which indicates when a charge for services or procedures should be accrued. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70269[User-defined Table 0269 - Charge On Indicator] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0269 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "1"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = false
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1009