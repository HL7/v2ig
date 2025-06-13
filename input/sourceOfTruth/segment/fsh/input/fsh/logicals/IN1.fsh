Logical: IN1
Parent: $Segment
Id: IN1
Title: "HL7 v2 IN1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Insurance"
* 1 1..1 SI "IN1-1" "link:#in1-1-set-id-in1-si-00426[_IN1-1 - set ID - IN1_] contains the number that identifies this transaction. For the first occurrence the sequence number shall be 1, for the second occurrence it shall be 2, etc. The Set ID in the IN1 segment is used to aggregate the grouping of insurance segments. For example, a patient with two insurance plans would have two groupings of insurance segments. IN1, IN2, and IN3 segments for Insurance Plan A with set ID 1, followed by IN1, IN2, and IN3 segments for Insurance Plan B, with set ID 2. There is no set ID in the IN2 segment because it is contained in the IN1, IN2, IN3 grouping, and is therefore not needed. The set ID in the IN3 segment is provided because there can be multiple repetitions of the IN3 segment if there are multiple certifications for the same insurance plan, e.g., IN1 (Set ID 1), IN2, IN3 (Set ID 1), IN3 (Set ID 2), IN3 (Set ID 3)"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #426
* 2 1..1 CWE "IN1-2" "This field contains a unique identifier for the insurance plan. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70072[_User-defined Table 0072 - Insurance Plan ID_] in Chapter 2C, Code Tables, for suggested values. To eliminate a plan, the plan could be sent with Delete Indication values in each subsequent element. If the respective systems can support it, a Delete Indication value can be sent in the plan field."
* 2 from http://terminology.hl7.org/ValueSet/v2-0072 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #368
* 2 ^comment = "The assigning authority for _IN1-2, Health Plan ID_ is assumed to be the Entity named in _IN1-3, Insurance Company ID_."
* 3 1..0 CX "IN1-3" "This field contains unique identifiers for the insurance company. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #428
* 4 0..0 XON "IN1-4" "This field contains the name of the insurance company. Multiple names for the same insurance company may be sent in this field. Specification of meaning based on sequence is deprecated."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #429
* 5 0..0 XAD "IN1-5" "This field contains the address of the insurance company. Multiple addresses for the same insurance company may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #430
* 6 0..0 XPN "IN1-6" "This field contains the name of the person who should be contacted at the insurance company. Multiple names for the same contact person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #431
* 7 0..0 XTN "IN1-7" "This field contains the phone number of the insurance company. Multiple phone numbers for the same insurance company may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #432
* 8 0..1 ST "IN1-8" "This field contains the group number of the insured's insurance."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "12"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #433
* 9 0..0 XON "IN1-9" "This field contains the group name of the insured's insurance."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #434
* 10 0..0 CX "IN1-10" "This field holds the group employer ID for the insured's insurance. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #435
* 11 0..0 XON "IN1-11" "This field contains the name of the employer that provides the employee's insurance. Multiple names for the same employer may be sent in this sequence Specification of meaning based on sequence is deprecated."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #436
* 12 0..1 DT "IN1-12" "This field contains the date that the insurance goes into effect."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #437
* 13 0..1 DT "IN1-13" "This field indicates the last date of service that the insurance will cover or be responsible for."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #438
* 14 0..1 AUI "IN1-14" "Based on the type of insurance, some coverage plans require that an authorization number or code be obtained prior to all non-emergency admissions, and within 48 hours of an emergency admission. Insurance billing would not be permitted without this number. The date and source of authorization are the components of this field."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #439
* 15 0..1 CWE "IN1-15" "This field contains the coding structure that identifies the various plan types, for example, Medicare, Medicaid, Blue Cross, HMO, etc. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70086[_User-defined Table 0086 - Plan ID_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0086 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #440
* 16 0..0 XPN "IN1-16" "This field contains the name of the insured person. The insured is the person who has an agreement with the insurance company to provide healthcare services to persons covered by the insurance policy. Multiple names for the same insured person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #441
* 17 0..1 CWE "IN1-17" "This field indicates the insured's relationship to the patient. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #442
* 18 0..1 DTM "IN1-18" "This field contains the date of birth of the insured."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #443
* 19 0..0 XAD "IN1-19" "This field contains the address of the insured person. The insured is the person who has an agreement with the insurance company to provide healthcare services to persons covered by an insurance policy. Multiple addresses for the same insured person may be in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #444
* 20 0..1 CWE "IN1-20" "This field indicates whether the insured agreed to assign the insurance benefits to the healthcare provider. If so, the insurance will pay the provider directly. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70135[_User-defined Table 0135 - Assignment of Benefits_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0135 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #445
* 21 0..1 CWE "IN1-21" "This field indicates whether this insurance works in conjunction with other insurance plans, or if it provides independent coverage and payment of benefits regardless of other insurance that might be available to the patient. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70173[_User-defined Table 0173 - Coordination of Benefits_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0173 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #446
* 22 0..1 ST "IN1-22" "If the insurance works in conjunction with other insurance plans, this field contains priority sequence. Values are: 1, 2, 3, etc."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 22 ^extension[=].extension[0].url = "length"
* 22 ^extension[=].extension[=].valueInteger = "2"
* 22 ^extension[=].extension[+].url = "noTruncate"
* 22 ^extension[=].extension[=].valueInteger = false
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #447
* 23 0..1 ID "IN1-23" "This field indicates whether the insurance company requires a written notice of admission from the healthcare provider. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #448
* 23 ^comment = "Y written notice of admission required\n\nN no notice required"
* 24 0..1 DT "IN1-24" "If a notice is required, this field indicates the date that it was sent."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #449
* 25 0..1 ID "IN1-25" "This field indicates whether this insurance carrier sends a report that indicates that the patient is eligible for benefits and whether it identifies those benefits. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #450
* 25 ^comment = "Y eligibility report is sent\n\nN no eligibility report is sent"
* 26 0..1 DT "IN1-26" "This field indicates whether a report of eligibility (ROE) was received, and also indicates the date that it was received."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #451
* 27 0..1 CWE "IN1-27" "This field indicates whether the healthcare provider can release information about the patient, and what information can be released. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70093[_User-defined Table 0093 - Release Information_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0093 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #452
* 28 0..1 ST "IN1-28" "This field contains the pre‑admission certification code. If the admission must be certified before the admission, this is the code associated with the admission."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 28 ^extension[=].extension[0].url = "length"
* 28 ^extension[=].extension[=].valueInteger = "15"
* 28 ^extension[=].extension[+].url = "noTruncate"
* 28 ^extension[=].extension[=].valueInteger = false
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #453
* 29 0..1 DTM "IN1-29" "This field contains the date/time that the healthcare provider verified that the patient has the indicated benefits."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #454
* 30 0..0 XCN "IN1-30" "Refers to the person who verified the benefits. Multiple names for the same insured person may be sent in this field Specification of meaning based on sequence is deprecated."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #455
* 31 0..1 CWE "IN1-31" "This field is used to further identify an insurance plan. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70098[_User-defined Table 0098 - Type of Agreement_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0098 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #456
* 32 0..1 CWE "IN1-32" "This field indicates whether the particular insurance has been billed and, if so, the type of bill. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70022[_User-defined Table 0022 - Billing Status_] in Chapter 2C, Code Tables, for suggested values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0022 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #457
* 33 0..1 NM "IN1-33" "This field contains the number of days left for a certain service to be provided or covered under an insurance policy."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 33 ^extension[=].extension[0].url = "length"
* 33 ^extension[=].extension[=].valueInteger = "4"
* 33 ^extension[=].extension[+].url = "noTruncate"
* 33 ^extension[=].extension[=].valueInteger = false
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #458
* 34 0..1 NM "IN1-34" "This field indicates the delay before lifetime reserve days."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 34 ^extension[=].extension[0].url = "length"
* 34 ^extension[=].extension[=].valueInteger = "4"
* 34 ^extension[=].extension[+].url = "noTruncate"
* 34 ^extension[=].extension[=].valueInteger = false
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #459
* 35 0..1 CWE "IN1-35" "This field contains optional information to further define the data in link:#in1-3-insurance-company-id-cx-00428[_IN1-3 - Insurance Company ID_]. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70042[_U__ser-defined Table 0042 - Company Plan Code_] in Chapter 2C, Code Tables, for suggested values. This table contains codes used to identify an insurance company plan uniquely."
* 35 from http://terminology.hl7.org/ValueSet/v2-0042 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #460
* 36 0..1 ST "IN1-36" "This field contains the individual policy number of the insured to uniquely identify this patient's plan. For special types of insurance numbers, there are also special fields in the IN2 segment for Medicaid, Medicare, Champus (i.e., link:#in2-6-medicare-health-ins-card-number-st-00477[_IN2-6 - Medicare Health Ins Card Number_], link:#in2-8-medicaid-case-number-st-00479[_IN2-8 - Medicaid Case Number_], link:#in2-10-military-id-number-st-00481[_IN2-10 - Military ID Number_]). But we recommend that this field (link:#in1-36-policy-number-st-00461[_IN1-36 - Policy Number_]) be filled even when the patient's insurance number is also passed in one of these other fields."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 36 ^extension[=].extension[0].url = "length"
* 36 ^extension[=].extension[=].valueInteger = "15"
* 36 ^extension[=].extension[+].url = "noTruncate"
* 36 ^extension[=].extension[=].valueInteger = false
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #461
* 37 0..1 CP "IN1-37" "This field contains the amount specified by the insurance plan that is the responsibility of the guarantor (i.e., deductible, excess, etc.)."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #462
* 38 0..1 BackboneElement "IN1-38" "IN1-38"
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #W
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #463
* 38 ^comment = "*Attention: _IN1-38 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 39 0..1 NM "IN1-39" "This field contains the maximum number of days that the insurance policy will cover."
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 39 ^extension[=].extension[0].url = "length"
* 39 ^extension[=].extension[=].valueInteger = "4"
* 39 ^extension[=].extension[+].url = "noTruncate"
* 39 ^extension[=].extension[=].valueInteger = false
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #464
* 40 0..1 BackboneElement "IN1-40" "IN1-40"
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #W
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #465
* 40 ^comment = "*Attention: _IN1-40 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 41 0..1 BackboneElement "IN1-41" "IN1-41"
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #W
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #466
* 41 ^comment = "*Attention: _IN1-41 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6._*"
* 42 0..1 CWE "IN1-42" "This field holds the employment status of the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70066[_User-defined Table 0066 - Employment Status_] in Chapter 2C, Code Tables, for suggested values. This field contains UB92 field 64. For this field element, values from the US CMS UB92 and others are used."
* 42 from http://terminology.hl7.org/ValueSet/v2-0066 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #467
* 43 0..1 CWE "IN1-43" "This field contains the gender of the insured. Refer to _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70001[User-defined Table 0001 - Administrative Sex]_ in Chapter 2C, Code Tables, for suggested values."
* 43 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #468
* 43 ^comment = "This field has historically been used to variably exchange both sex and gender values and therefore this field is not clearly defined. This field is expected to continue to be used as it has been in existing implementations and use of this field is subject to local existing interpretation and/or implementation guides. The GSP and GSR segments should be used to exchange more rigorously defined sex or gender concept."
* 44 0..0 XAD "IN1-44" "This field contains the address of the insured employee's employer. Multiple addresses for the same employer may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #469
* 45 0..1 ST "IN1-45" "This field contains the status of this patient's relationship with this insurance carrier."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 45 ^extension[=].extension[0].url = "length"
* 45 ^extension[=].extension[=].valueInteger = "2"
* 45 ^extension[=].extension[+].url = "noTruncate"
* 45 ^extension[=].extension[=].valueInteger = false
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #470
* 46 0..1 CWE "IN1-46" "This field uniquely identifies the prior insurance plan when the plan ID changes. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70072[_User-defined Table 0072 - Insurance Plan ID_] in Chapter 2C, Code Tables, for suggested values."
* 46 from http://terminology.hl7.org/ValueSet/v2-0072 (required)
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #471
* 47 0..1 CWE "IN1-47" "This field contains the coding structure that identifies the type of insurance coverage, or what types of services are covered for the purposes of a billing system. For example, a physician billing system will only want to receive insurance information for plans that cover physician/professional charges. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70309[_User-defined Table 0309 - Coverage Type_] in Chapter 2C, Code Tables, for suggested values."
* 47 from http://terminology.hl7.org/ValueSet/v2-0309 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #1227
* 48 0..1 CWE "IN1-48" "This field contains a code to describe the insured's disability. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70295[_User-defined Table 0295 - Handicap_] in Chapter 2C, Code Tables, for suggested values."
* 48 from http://terminology.hl7.org/ValueSet/v2-0295 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #753
* 49 0..0 CX "IN1-49" "This data element contains a healthcare institution's identifiers for the insured. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #1230
* 50 0..1 CWE "IN1-50" "This field contains the code to indicate how the patient/subscriber authorization signature was obtained and how it is being retained by the provider. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70535[_User-defined Table 0535 - Signature Code_] in Chapter 2C, Code Tables, for suggested values."
* 50 from http://terminology.hl7.org/ValueSet/v2-0535 (required)
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #1854
* 51 0..1 DT "IN1-51" "The date the patient/subscriber authorization signature was obtained."
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #1855
* 52 0..1 ST "IN1-52" "This field contains the description of the insured's birth place, for example \"St. Francis Community Hospital of Lower South Side.\" The actual address is reported in _IN1-19 – Insured's Address_ with an identifier of \"N\"."
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #1899
* 53 0..1 CWE "IN1-53" "This field identifies the type of VIP for the insured. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70099[_User-defined Table 0099 – VIP Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 53 from http://terminology.hl7.org/ValueSet/v2-0099 (required)
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #1852
* 54 0..0 CX "IN1-54" "This field contains the external Health Plan Identifiers that correspond to the internal Health Plan ID in _IN1-2 – Health Plan ID_. The assigning authority and identifier type code are strongly recommended for al CX data types."
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #3292
* 55 0..1 ID "IN1-55" "The Insurance Action Code Defines the action to be taken for this insurance. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for valid values. When this field is valued, the IN1, IN2, and IN3 are not in \"snapshot mode\", rather in \"action mode\"."
* 55 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 55 ^extension[=].extension[0].url = "min"
* 55 ^extension[=].extension[=].valueInteger = 1
* 55 ^extension[=].extension[+].url = "max"
* 55 ^extension[=].extension[=].valueInteger = 1
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #3335
* 56 0..1 CX "IN1-56" "IN1-56"
* 56 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 56 ^extension[=].valueCode = #O
* 56 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 56 ^code.code = #2535