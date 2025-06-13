Logical: DPS
Parent: $Segment
Id: DPS
Title: "HL7 v2 DPS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Diagnosis and Procedure Code"
* 1 1..1 CWE "DPS-1" "DPS-1 contains the diagnosis code assigned to this diagnosis. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70051[User-defined Table 0051 - Diagnosis Code] for suggested values. This field is a CWE data type for compatibility with clinical and ancillary systems. Either _DPS-1.1-Identifier_ or _DPS-1.2-Text_ is required. When a code is used in _DPS-1.1-Identifier_, a coding system is required in _DPS-1.3-Name of Coding System_."
* 1 from http://terminology.hl7.org/ValueSet/v2-0051 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3472
* 1 ^comment = "Names of various diagnosis coding systems are listed in Chapter 2, Section 2.16.4, “Coding system table.”"
* 2 1..0 CWE "DPS-2" "This field contains the procedure code for procedure, if any, associated with this charge description. Repeating field allows for different procedure coding systems such as CPT4, ASTM, ICD9. Coded entry made up of code plus coding schema. See Externally Defined Table 0941 – Procedure Code."
* 2 from http://terminology.hl7.org/ValueSet/v2-0941 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #3484
* 3 0..1 DTM "DPS-3" "An optional effective date/time can be included for the record-level action specified. It is the date/time the originating system expects that the event is to have been completed on the receiving system. If this field is not present, the effective date/time should default to the current date/time (when the message is received)."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #662
* 4 0..1 DTM "DPS-4" "An optional expiration date/time can be included for the record-level action specified. It is the date/time the originating system expects that the event is to have been completed on the receiving system."
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3473
* 5 0..1 CNE "DPS-5" "This field contains the type of limitations as determined by the Payer. This field has a defined value set that may need to be extended. See HL7 Table 0940 - Limitation Type Codes, in Chapter 2C, Code Tables for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0940 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3474