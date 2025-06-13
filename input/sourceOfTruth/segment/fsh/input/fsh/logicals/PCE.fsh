Logical: PCE
Parent: $Segment
Id: PCE
Title: "HL7 v2 PCE Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Patient Charge Cost Center Exception"
* 1 1..1 SI "PCE-1" "This field contains a sequential number that identifies this segment within a given material item segment group. For the first occurrence of the segment in a given group, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2228
* 2 0..1 CX "PCE-2" "This field would contain the specific general ledger cost center account number associated with a department that may issue or charge for this item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70319[_HL7 Table 0319 – Department Cost Center_] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0319 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #281
* 3 0..1 CWE "PCE-3" "This field contains a code that is used by a billing system to charge for the inventory supply item, the descriptive name of the patient charge for that system (as it may appear on a patient's bill or charge labels) and the name of the coding system that assigned the charge code. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70132[User-defined Table 0132 – Transaction Codes]_ in Chapter 6, Financial Management, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #361
* 4 0..1 CP "PCE-4" "The price that a department charges to a patient for this inventory supply item when using the Patient Charge Billing code present in this segment."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #366