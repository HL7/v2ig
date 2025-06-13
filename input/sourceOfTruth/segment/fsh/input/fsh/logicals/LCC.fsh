Logical: LCC
Parent: $Segment
Id: LCC
Title: "HL7 v2 LCC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Location Charge Code"
* 1 1..1 PL "LCC-1" "This field contains the institution's identification code for the location. The identifying key value. This field has the same components as the patient location fields in the PV1 segment (except that bed status is not included here). At least the first component of this field is required. The content of this field must exactly match the content of its preceding MFE (_MFE-4 - Primary Key Value - MFE_), its preceding LOC (_LOC-1 - Primary Key Value - LOC_), and its preceding LDP (_LDP-1 - Primary Key Value - LDP_)."
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #979
* 2 1..1 CWE "LCC-2" "This field contains the institution's department to which this location belongs, or its cost center. It may match the value in its preceding LDP (_LDP-2 - Location Department_ or _LDP-12 - Location Cost Center_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70264[User-defined Table 0264 - Location Department] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0264 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #964
* 3 0..0 CWE "LCC-3" "This field contains the financial accommodation type of the bed or room which implies the rate to be used when occupied by a patient under specific medical conditions, which determines how it is billed. Not the same as specialty type. Used for general ledger categories. Specialty type is a physical accommodation type, whereas this field is a financial accommodation type. Repeating coded value. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70129[User-defined Table 0129 - Accommodation Code] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0129 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #980
* 4 1..0 CWE "LCC-4" "This field contains the repeating coded entry for codes identifying how the use of this location is to be charged. For cross-referencing beds master files with the charge master files, or for generating charges when a patient is assigned to a bed. These should be the same set of values used in _FT1-7 -Transaction Code_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 - Transaction Code] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #981