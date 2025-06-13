Logical: IN2
Parent: $Segment
Id: IN2
Title: "HL7 v2 IN2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Insurance Additional Information"
* 1 0..0 CX "IN2-1" "This field contains the employee ID of the insured. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #472
* 2 0..1 ST "IN2-2" "This field contains the social security number of the insured."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "11"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #473
* 3 0..0 XCN "IN2-3" "This field contains the name and ID of the insured's employer or the person who purchased the insurance for the insured, if the employer is a person. Multiple names and identifiers for the same person may be sent in this field, not multiple persons Specification of meaning based on sequence is deprecated. When the employer is an organization use link:#in2-70-insured-employer-organization-name-and-id-xon-00810[_IN2-70 - Insured Employer Organization Name and ID_]."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #474
* 4 0..1 CWE "IN2-4" "This field contains the required employer information data for UB82 form locator 71. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70139[_User-defined Table 0139 - Employer Information Data_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0139 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #475
* 5 0..0 CWE "IN2-5" "This field contains the party to which the claim should be mailed. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70137[_User-defined Table 0137 - Mail Claim Party_] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0137 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #476
* 6 0..1 ST "IN2-6" "This field contains the Medicare Health Insurance Number (HIN), defined by CMS or other regulatory agencies."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "15"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #477
* 7 0..0 XPN "IN2-7" "This field contains the Medicaid case name, defined by CMS or other regulatory agencies. Multiple names for the same person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #478
* 8 0..1 ST "IN2-8" "This field contains the Medicaid case number, defined by CMS or other regulatory agencies which can be used to group household members for Medicaid service eligibility."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "15"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #479
* 9 0..0 XPN "IN2-9" "This field is defined by CMS or other regulatory agencies. Multiple names for the same person may be sent in this field. Specification of meaning based on sequence is deprecated."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #480
* 10 0..1 ST "IN2-10" "This field contains the military ID number, defined by CMS or other regulatory agencies, which uniquely identifies a patient's military policy."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "20"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #481
* 11 0..1 CWE "IN2-11" "This field is defined by CMS or other regulatory agencies. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70342[_User-defined Table 0342 - Military Recipient_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0342 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #482
* 12 0..1 ST "IN2-12" "This field is defined by CMS or other regulatory agencies."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "25"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #483
* 13 0..1 ST "IN2-13" "This field is defined by CMS or other regulatory agencies."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "25"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #484
* 14 0..1 CWE "IN2-14" "This field is defined by CMS or other regulatory agencies and refers to the military branch of service. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70140[_User-defined Table 0140 - Military_ _Servic__e_] in Chapter 2C, Code Tables, for suggested values. The UB codes listed may not represent a complete list; refer to a UB specification for additional information."
* 14 from http://terminology.hl7.org/ValueSet/v2-0140 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #485
* 15 0..1 CWE "IN2-15" "This user-defined field identifies the military rank/grade of the insured. Refer to E:\\\\V2\\\\V29_CH02C_Tables.docx#HL70141[_User-defined Table 0141 - Military Rank/Grade_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0141 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #486
* 16 0..1 CWE "IN2-16" "This field is defined by CMS or other regulatory agencies. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70142[_User-defined Table 0142 - Military Status_] in Chapter 2C, Code Tables, for suggested values. The UB codes listed may not represent a complete list; refer to a UB specification for additional information"
* 16 from http://terminology.hl7.org/ValueSet/v2-0142 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #487
* 17 0..1 DT "IN2-17" "This field is defined by CMS or other regulatory agencies."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #488
* 18 0..1 ID "IN2-18" "Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^extension[=].extension[+].url = "max"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #489
* 18 ^comment = "Y Certification on file\n\nN Certification not on file"
* 19 0..1 ID "IN2-19" "Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #490
* 19 ^comment = "Y Baby coverage\n\nN No baby coverage"
* 20 0..1 ID "IN2-20" "Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #491
* 20 ^comment = "Y Combine bill\n\nN Normal billing"
* 21 0..1 ST "IN2-21" "Use this field instead of link:#ub1-2-blood-deductible-00531[_UB1-2 - Blood Deductible_], as the blood deductible can be associated with the specific insurance plan via this field."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 21 ^extension[=].extension[0].url = "length"
* 21 ^extension[=].extension[=].valueInteger = "1"
* 21 ^extension[=].extension[+].url = "noTruncate"
* 21 ^extension[=].extension[=].valueInteger = false
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #492
* 22 0..0 XPN "IN2-22" "This field contains the name of the individual who approves any special coverage. Multiple names for the same person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #493
* 23 0..1 ST "IN2-23" "This field contains the title of the person who approves special coverage."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "30"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = true
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #494
* 24 0..0 CWE "IN2-24" "This field contains the code that describes why a service is not covered. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70143[_User-defined Table 0143 - Non-covered Insu__rance Code_] in Chapter 2C, Code Tables, for suggested values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0143 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #495
* 25 0..0 CX "IN2-25" "IN2-25"
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #496
* 26 0..0 CX "IN2-26" "Subscriber Identifier assigned by the Payer."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #497
* 27 0..1 CWE "IN2-27" "Identifies the source of information about the insured's eligibility for benefits. Refer to User-defined Table 0144 - Eligibility Source in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0144 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #498
* 28 0..0 RMC "IN2-28" "Use this field instead of link:#in1-40-room-rate-semiprivate-00465[_IN1-40 - Room Rate - Semi-Private_] and link:#in1-41-room-rate-private-00466[_IN1-41 - Room Rate - Private_]. This field contains room type (e.g., private, semi-private), amount type (e.g., limit, percentage) and amount covered by the insurance."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #499
* 29 0..0 PTA "IN2-29" "This field contains the policy type (e.g., ancillary, major medical) and amount (e.g., amount, percentage, limit) covered by the insurance. Use this field instead of link:#in1-38-policy-limit-amount-00463[_IN1-38 - Policy Limit - Amount_]."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #500
* 30 0..1 DDI "IN2-30" "This field contains the number of days after which the daily deductible begins, the amount of the deductible, and the number of days to apply the deductible."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #501
* 30 ^comment = "If \"number of days\" is not valued, the deductible is ongoing."
* 31 0..1 CWE "IN2-31" "This field identifies the specific living conditions for the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70223[_User-defined Table 0223 - Living Dependency_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0223 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #755
* 32 0..0 CWE "IN2-32" "This field identifies the insured's state of mobility. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70009[_User-defined Table 0009 - Ambulatory Status_] in Chapter 2C, Code Tables, for suggested values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0009 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #145
* 33 0..0 CWE "IN2-33" "This field contains the code that identifies the insured's citizenship. HL7 recommends using ISO table 3166 as the suggested values in _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70171[User-defined Table 0171 - Citizenship]_ defined in Chapter 2C, Code Tables."
* 33 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #129
* 34 0..1 CWE "IN2-34" "This field identifies the insured's primary speaking language. HL7 recommends using ISO table 639 as the suggested values in _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70296[User-defined Table 0296 - Primary Language]_ defined in Chapter 2C, Code Tables."
* 34 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #118
* 35 0..1 CWE "IN2-35" "This field indicates the situation in which the insured person lives at his primary residence. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70220[_User-defined Table 0220 - Living Arrangement_] in Chapter 2C, Code Tables, for suggested values."
* 35 from http://terminology.hl7.org/ValueSet/v2-0220 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #742
* 36 0..1 CWE "IN2-36" "This field contains a user-defined code indicating what level of publicity is allowed (e.g., No Publicity, Family Only) for the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70215[_User-defined Table 0215 - Publicity Code_] in Chapter 2C, Code Tables, for suggested values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0215 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #743
* 37 0..1 ID "IN2-37" "This field identifies the insured's protection, which determines whether or not access to information about this enrollee should be restricted from users who do not have adequate authority. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 37 ^extension[=].extension[0].url = "min"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^extension[=].extension[+].url = "max"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #744
* 37 ^comment = "Y Restrict access\n\nN Do not restrict access"
* 38 0..1 CWE "IN2-38" "This field identifies whether the insured is currently a student or not, and whether the insured is a full-time or a part-time student. This field does not indicate the degree level (high school, college) of student, or his/her field of study (accounting, engineering, etc.). Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70231[_User-defined Table 0231 - Student Status_] in Chapter 2C, Code Tables, for suggested values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0231 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #745
* 39 0..1 CWE "IN2-39" "This field indicates the type of religion practiced by the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70006[_User-defined Table 0006 - Religion_] in Chapter 2C, Code Tables, for suggested values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0006 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #120
* 40 0..0 XPN "IN2-40" "This field indicates the insured's mother's maiden name."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #109
* 41 0..1 CWE "IN2-41" "This field contains a code that identifies the nation or national grouping to which the insured person belongs. This information may be different from a person's citizenship in countries in which multiple nationalities are recognized (for example, Spain: Basque, Catalan, etc.). HL7 recommends using ISO table 3166 as the suggested values in file:///E:\\V2\\V29_CH02C_Tables.docx#HL70212[_User-defined Table 0212 - Nationality_] in Chapter 2C, Code Tables."
* 41 from http://terminology.hl7.org/ValueSet/v2-0212 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #739
* 42 0..0 CWE "IN2-42" "This field indicates the insured's ethnic group. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70189[_User-defined Table 0189 - Ethnic Group_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CE data type for ethnic group (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes. In the US, a current use is to report ethnicity in line with US federal standards for Hispanic origin."
* 42 from http://terminology.hl7.org/ValueSet/v2-0189 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #125
* 43 0..0 CWE "IN2-43" "This field contains the insured's marital status. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70002[_User-defined Table 0002 - Marital Status_] in Chapter 2C, Code Tables, for suggested values."
* 43 from http://terminology.hl7.org/ValueSet/v2-0002 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #119
* 44 0..1 DT "IN2-44" "This field indicates the date on which the insured's employment with a particular employer began."
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #787
* 45 0..1 DT "IN2-45" "This field indicates the date on which the person's employment with a particular employer ended."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #783
* 46 0..1 ST "IN2-46" "This field contains a descriptive name for the insured's occupation (for example, Sr. Systems Analyst, Sr. Accountant)."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 46 ^extension[=].extension[0].url = "length"
* 46 ^extension[=].extension[=].valueInteger = "20"
* 46 ^extension[=].extension[+].url = "noTruncate"
* 46 ^extension[=].extension[=].valueInteger = true
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #785
* 47 0..1 JCC "IN2-47" "This field indicates a code that identifies the insured's job code (for example, programmer, analyst, doctor, etc.)."
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #786
* 48 0..1 CWE "IN2-48" "This field indicates a code that identifies the insured's current job status. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70311[_User-defined Table 0311 - Job Status_] in Chapter 2C, Code Tables, for suggested values."
* 48 from http://terminology.hl7.org/ValueSet/v2-0311 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #752
* 49 0..0 XPN "IN2-49" "This field contains the name of the contact person that should be contacted at the insured's place of employment. (Joe Smith is the insured. He works at GTE. Contact Sue Jones at GTE regarding Joe Smith's policy). Multiple names for the same person may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #789
* 50 0..0 XTN "IN2-50" "This field contains the telecommunications contact for the employer contact person. Multiple phone numbers for the same contact person may be sent in this sequence, not multiple contacts. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #790
* 51 0..1 CWE "IN2-51" "Definition: This field contains the reason(s) that employer contact person should be contacted on behalf of the employee. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70222[_User-defined Table 0222 - Contact Reason_] in Chapter 2C, Code Tables, for suggested values."
* 51 from http://terminology.hl7.org/ValueSet/v2-0222 (required)
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #791
* 52 0..0 XPN "IN2-52" "This field contains the contact person for the insured."
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #792
* 53 0..0 XTN "IN2-53" "This field contains the telephone number for the contact person for the insured. Multiple phone numbers for the same person may be sent in this contact, not multiple contacts. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #793
* 54 0..0 CWE "IN2-54" "This field contains the reason(s) the person should be contacted regarding the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70222[_User-defined Table 0222 - Contact Reason_] in Chapter 2C, Code Tables, for suggested values"
* 54 from http://terminology.hl7.org/ValueSet/v2-0222 (required)
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #794
* 55 0..1 DT "IN2-55" "This field indicates the date on which the insured's patient relationship (defined in link:#in1-17-insureds-relationship-to-patient-cwe-00442[_IN1-17 - Insured's Relationship to Patient_]) became effective (began)."
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #795
* 56 0..0 DT "IN2-56" "This field indicates the date after which the relationship (defined in link:#in1-17-insureds-relationship-to-patient-cwe-00442[_IN1-17 - Insured's Relationship to Patient_]) is no longer effective."
* 56 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 56 ^extension[=].valueCode = #O
* 56 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 56 ^code.code = #796
* 57 0..1 CWE "IN2-57" "This field contains a user-defined code that specifies how the contact should be used. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70232[_User-defined Table 0232 - Insurance Company Contact Reason_] in Chapter 2C, Code Tables, for suggested values."
* 57 from http://terminology.hl7.org/ValueSet/v2-0232 (required)
* 57 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 57 ^extension[=].valueCode = #O
* 57 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 57 ^code.code = #797
* 58 0..0 XTN "IN2-58" "This field contains the telephone number of the person who should be contacted at the insurance company for questions regarding an insurance policy/claim, etc. Multiple phone numbers for the insurance company may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 58 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 58 ^extension[=].valueCode = #O
* 58 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 58 ^code.code = #798
* 59 0..1 CWE "IN2-59" "This field contains a user-defined code designating the extent of the coverage for a participating member (e.g., \"single,\" \"family,\" etc). Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70312[_User-defined Table 0312 - Policy Scope_] in Chapter 2C, Code Tables, for suggested values."
* 59 from http://terminology.hl7.org/ValueSet/v2-0312 (required)
* 59 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 59 ^extension[=].valueCode = #O
* 59 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 59 ^code.code = #799
* 60 0..1 CWE "IN2-60" "This user-defined field identifies how the policy information got established. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70313[_User-defined Table 0313 - Policy Source_] in Chapter 2C, Code Tables, for suggested values."
* 60 from http://terminology.hl7.org/ValueSet/v2-0313 (required)
* 60 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 60 ^extension[=].valueCode = #O
* 60 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 60 ^code.code = #800
* 61 0..1 CX "IN2-61" "This field contains an identifying number assigned by the payor for each individual covered by the insurance policy issued to the insured. For example, each individual family member may have a different member number from the insurance policy number issued to the head of household. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 61 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 61 ^extension[=].valueCode = #O
* 61 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 61 ^code.code = #801
* 62 0..1 CWE "IN2-62" "This field specifies the relationship of the guarantor to the insurance subscriber. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values."
* 62 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 62 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 62 ^extension[=].valueCode = #O
* 62 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 62 ^code.code = #802
* 63 0..0 XTN "IN2-63" "The value of this field represents the insured's telephone number. Multiple phone numbers may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 63 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 63 ^extension[=].valueCode = #O
* 63 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 63 ^code.code = #803
* 64 0..0 XTN "IN2-64" "The value of this field represents the insured's employer's telephone number. Multiple phone numbers may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 64 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 64 ^extension[=].valueCode = #O
* 64 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 64 ^code.code = #804
* 65 0..1 CWE "IN2-65" "This field indicates the military program for the handicapped in which the patient is enrolled. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70343[_User-defined Table 0343 - Military Handicapped Program Code_] in Chapter 2C, Code Tables, for suggested values."
* 65 from http://terminology.hl7.org/ValueSet/v2-0343 (required)
* 65 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 65 ^extension[=].valueCode = #O
* 65 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 65 ^code.code = #805
* 66 0..1 ID "IN2-66" "This field indicates whether charges should be suspended for a patient. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 66 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 66 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 66 ^extension[=].valueCode = #O
* 66 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 66 ^extension[=].extension[0].url = "min"
* 66 ^extension[=].extension[=].valueInteger = 1
* 66 ^extension[=].extension[+].url = "max"
* 66 ^extension[=].extension[=].valueInteger = 1
* 66 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 66 ^code.code = #806
* 66 ^comment = "Y charges should be suspended\n\nN charges should NOT be suspended"
* 67 0..1 ID "IN2-67" "This field indicates if the patient has reached the co-pay limit so that no more co-pay charges should be calculated for the patient. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 67 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 67 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 67 ^extension[=].valueCode = #O
* 67 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 67 ^extension[=].extension[0].url = "min"
* 67 ^extension[=].extension[=].valueInteger = 1
* 67 ^extension[=].extension[+].url = "max"
* 67 ^extension[=].extension[=].valueInteger = 1
* 67 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 67 ^code.code = #807
* 67 ^comment = "Y the patient is at or exceeds the co-pay limit\n\nN the patient is under the co-pay limit"
* 68 0..1 ID "IN2-68" "This field indicates if the patient has reached the stoploss limit established in the Contract Master. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 68 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 68 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 68 ^extension[=].valueCode = #O
* 68 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 68 ^extension[=].extension[0].url = "min"
* 68 ^extension[=].extension[=].valueInteger = 1
* 68 ^extension[=].extension[+].url = "max"
* 68 ^extension[=].extension[=].valueInteger = 1
* 68 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 68 ^code.code = #808
* 68 ^comment = "Y the patient has reached the stoploss limit\n\nN the patient has not reached the stoploss limit"
* 69 0..0 XON "IN2-69" "This field indicates the name of the insured if the insured/subscriber is an organization. Multiple names for the insured may be sent in this sequence, not multiple insured people Specification of meaning based on sequence is deprecated."
* 69 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 69 ^extension[=].valueCode = #O
* 69 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 69 ^code.code = #809
* 70 0..0 XON "IN2-70" "This field indicates the name of the insured's employer, or the organization that purchased the insurance for the insured, if the employer is an organization. Multiple names and identifiers for the same organization may be sent in this field, not multiple organizations. Specification of meaning based on sequence is deprecated."
* 70 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 70 ^extension[=].valueCode = #O
* 70 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 70 ^code.code = #810
* 71 0..0 CWE "IN2-71" "Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70005[_User-defined Table 0005 - Race_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CE data type for race (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes."
* 71 from http://terminology.hl7.org/ValueSet/v2-0005 (required)
* 71 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 71 ^extension[=].valueCode = #O
* 71 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 71 ^code.code = #113
* 72 0..1 CWE "IN2-72" "This field indicates the relationship of the patient to the insured, as defined by CMS or other regulatory agencies. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70344[_User-defined Table 0344 - Patient's Relati__onship to Insured_] in Chapter 2C, Code Tables, for suggested values. The UB codes listed may not represent a complete list; refer to a UB specification for additional information."
* 72 from http://terminology.hl7.org/ValueSet/v2-0344 (required)
* 72 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 72 ^extension[=].valueCode = #O
* 72 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 72 ^code.code = #811
* 73 0..1 CP "IN2-73" "This field contains the patient's Co-pay amount for visit."
* 73 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 73 ^extension[=].valueCode = #O
* 73 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 73 ^code.code = #1620