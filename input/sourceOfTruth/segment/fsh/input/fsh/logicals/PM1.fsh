Logical: PM1
Parent: $Segment
Id: PM1
Title: "HL7 v2 PM1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Payer Master File"
* 1 1..1 CWE "PM1-1" "This field contains a unique identifier for the insurance plan. Refer to _User-defined Table 0072 - Insurance Plan ID_ in Chapter 2C, Code Tables, for suggested values. To eliminate a plan, the plan could be sent with null values in each subsequent element. If the respective systems can support it, a null value can be sent in the plan field."
* 1 from http://terminology.hl7.org/ValueSet/v2-0072 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #368
* 1 ^comment = "The assigning authority for PM1-1, Health Plan ID is assumed to be the Entity named in PM1-2, Insurance Company ID."
* 2 1..0 CX "PM1-2" "This field contains unique identifiers for the insurance company. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #428
* 3 0..0 XON "PM1-3" "This field contains the name of the insurance company. Multiple names for the same insurance company may be sent in this field."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #429
* 4 0..0 XAD "PM1-4" "This field contains the address of the insurance company. Multiple addresses for the same insurance company may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #430
* 5 0..0 XPN "PM1-5" "This field contains the name of the person who should be contacted at the insurance company. Multiple names for the same contact person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #431
* 6 0..0 XTN "PM1-6" "This field contains the phone number of the insurance company. Multiple phone numbers for the same insurance company may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #432
* 7 0..1 ST "PM1-7" "This field contains the group number of the insured's insurance."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 12
* 7 ^extension[=].extension[+].url = "max"
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #433
* 8 0..0 XON "PM1-8" "This field contains the group name of the insured's insurance."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #434
* 9 0..1 DT "PM1-9" "This field contains the date that the insurance goes into effect."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #437
* 10 0..1 DT "PM1-10" "This field indicates the last date of service that the insurance will cover or be responsible for."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #438
* 11 0..1 ID "PM1-11" "This field indicates whether this insurance carrier requires the patient DOB. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3454
* 11 ^comment = "Y DOB Required\n\nN DOB Not Required"
* 12 0..1 ID "PM1-12" "This field indicates whether this insurance carrier requires the patient Gender. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3455
* 12 ^comment = "Y Patient Gender Required\n\nN Patient Gender Not Rquired"
* 13 0..1 ID "PM1-13" "This field indicates whether this insurance carrier requires the patient’s Relationship to insured. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3456
* 13 ^comment = "Y Patient’s relationship to insured Required\n\nN Patient’s relationship to insured Not Required"
* 14 0..1 ID "PM1-14" "This field indicates whether this insurance carrier requires the patient Signature. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3457
* 14 ^comment = "Y Patient’s relationship to insured Required\n\nN Patient’s relationship to insured Not Required"
* 15 0..1 ID "PM1-15" "This field indicates whether this insurance carrier requires a diagnosis. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3458
* 15 ^comment = "Y Diagnosis Required\n\nN Diagnosis Not Required"
* 16 0..1 ID "PM1-16" "This field indicates whether this insurance carrier requires services to be listed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3459
* 16 ^comment = "Y Services Required\n\nN Services Not Required"
* 17 0..1 ID "PM1-17" "This field indicates whether this insurance carrier requires a patient name on all requests. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3460
* 17 ^comment = "Y Patient’s name Required\n\nN Patient’s name Not Required"
* 18 0..1 ID "PM1-18" "This field indicates whether this insurance carrier requires a patient address on all requests. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3461
* 18 ^comment = "Y Patient’s Address Required\n\nN Patient’s Address Not Required"
* 19 0..1 ID "PM1-19" "This field indicates whether this insurance carrier requires subscribers name on all requests. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3462
* 19 ^comment = "Y Subscribers name Required\n\nN Subscribers name Not Required"
* 20 0..1 ID "PM1-20" "This field indicates whether this insurance carrier requires workman compensation to be identified. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3463
* 20 ^comment = "Y Workman compensation idenfication Required\n\nN Workman compensation idenfication Not Required"
* 21 0..1 ID "PM1-21" "This field indicates whether this insurance carrier requires subscribers bill type. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3464
* 21 ^comment = "Y Subscribers bill type Required\n\nN Subscribers bill type Not Required"
* 22 0..1 ID "PM1-22" "This field indicates whether this insurance carrier requires commerical carrier name and address. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3465
* 22 ^comment = "Y Commerical carrier name and address Required\n\nN Commerical carrier name and address Not Required"
* 23 0..1 ST "PM1-23" "This field contains the policy number pattern. This describes what the policy number should look like. There will likely be multiple patterns to identify the Policy number. It is recommended that Edit patterns are a sequence of the characters ‘A’ for alpha, ‘N’ for numeric, ‘X’ for alphanumeric, ‘B’ for blank, and ‘*’ for wildcard. Digits positionally refer to the two-character edit pattern list in the corresponding list field."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #3466
* 23 ^comment = "Edit pattern lists are a sequence characters to respresent the format and size of the Policy Number.\n\nExample 1: The policy number has 3 numbers, 1 blank, 5 numbers and it would be defined in a Pattern as NNNBNNNNN\n\nExample 2: The policy number has 2 numerics, 2 characters for state, 1 blank 5 Alphanumerics and would be represented as NNCCBXXXXX"
* 24 0..1 ST "PM1-24" "This field contains the Group number pattern. This describes what the group number should look like. There will likely be multiple patterns to identify the group number. It is recommended that Edit patterns are a sequence of the characters ‘A’ for alpha, ‘N’ for numeric, ‘X’ for alphanumeric, ‘B’ for blank, and ‘*’ for wildcard. Digits positionally refer to the two-character edit pattern list in the corresponding list field."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #3467
* 24 ^comment = "Edit pattern lists are a sequence characters to respresent the format and size of the Group Number.\n\nExample 1: The group number has 3 numbers, 1 blank, 5 numbers and it would be defined in a Pattern as NNNBNNNNN\n\nExample 2: The group number has 2 numerics, 2 characters for state, 1 blank 5 Alphanumerics and would be represented as NNCCBXXXXX"