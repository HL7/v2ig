Logical: CDM
Parent: $Segment
Id: CDM
Title: "HL7 v2 CDM Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Charge Description Master"
* 1 1..1 CWE "CDM-1" "The key field of the entry. Must match _MFE-4 - Primary Key Value - MFE_. This field contains the code assigned by the institution for the purpose of uniquely identifying the thing that can be charged. For example, this field would be used to uniquely identify a procedure, item, or test for charging purposes. Probably the same set of values as used in _FT1-7- Transaction Code_ in financial messages (refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 - Transaction Code] in Chapter 2C, Code Tables, for suggested values). See Chapter 7 for discussion of the universal service ID."
* 1 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1306
* 2 0..0 CWE "CDM-2" "This field contains an alternative charge code. For example, points to another charge description master entry in cases where one code supersedes or overrides another code. Repeating field allows for different codes used by different systems which should be handled as if they were the same; for example, the general ledger code may differ from the billing code. Or, in a multi-facility environment which does facility-specific pricing, there may be more than one of these master file entries for one charge description, each with a different facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 - Transaction Code] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #983
* 3 1..1 ST "CDM-3" "This field contains the text abbreviations or code that is associated with this CDM entry."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "20"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #984
* 4 0..1 ST "CDM-4" "This field contains the full text description of this CDM entry."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "250"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = true
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #985
* 5 0..1 CWE "CDM-5" "This field indicates whether this CDM entry's description can be overridden. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70268[User-defined Table 0268 - Override] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0268 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "1"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #986
* 6 0..0 CWE "CDM-6" "This field contains the repeating occurrences for a list of other CDM entry charge codes identifying the other charges which should be generated from this CDM entry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 - Transaction Code] in Chapter 2C, Code Tables, for suggested values. If non-null, posting a charge to this CDM entry should result in posting the charges identified here. These are sometimes called \"linked items.\""
* 6 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #987
* 6 ^comment = "In the case of \"chained\" charges where the \"lead\" charge must be included in the exploded charges, the \"lead\" charge should be included in the list of exploding charges. If the price of this parent charge is included in the message, then it overrides the sum of the exploded charges prices."
* 7 0..0 CNE "CDM-7" "This field contains the procedure code for procedure, if any, associated with this charge description. Repeating field allows for different procedure coding systems such as CPT4, ICD9. Coded entry made up of code plus coding schema. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70088[Externally-defined Table 0088 - Procedure Code] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #393
* 8 0..1 ID "CDM-8" "This field indicates whether this is a usable CDM entry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70183[HL7 Table 0183 - Active/Inactive] in Chapter 2C, Code Tables, for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0183 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 8 ^extension[=].extension[0].url = "min"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^extension[=].extension[+].url = "max"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #675
* 9 0..0 CWE "CDM-9" "This optional field contains an identifying stock number, if any, which might be used, for example, as a cross reference for materials management. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70463[User-defined Table 0463 - Inventory number] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0463 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #990
* 10 0..1 NM "CDM-10" "This field contains the Relative Value Unit (RVU) minutes and ATS, a factor related to CPT4 coding and to pricing structure for physical billing."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "12"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #991
* 11 0..0 CX "CDM-11" "This field contains any contract number pertaining to this chargeable item; for example, supplier contract or service contract."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #992
* 12 0..0 XON "CDM-12" "This field contains the organization with which there is a contractual arrangement for providing the service or material used for this chargeable item."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #993
* 13 0..1 ID "CDM-13" "This field contains a room fee indicator. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #994
* 13 ^comment = "Y this is a component of the room fees\n\nN this is any other chargeable item other than room fees"