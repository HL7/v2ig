Logical: PV2
Parent: $Segment
Id: PV2
Title: "HL7 v2 PV2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Patient Visit - Additional Information"
* 1 0..1 PL "PV2-1" "This field is required for cancel pending transfer (A26) messages. In all other events it is optional."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #181
* 2 0..1 CWE "PV2-2" "This field indicates the specific patient accommodations for this visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70129[_User-defined Table 0129 - Accommodation Code_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0129 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #182
* 3 0..1 CWE "PV2-3" "This field contains the short description of the reason for patient admission."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #183
* 4 0..1 CWE "PV2-4" "This field contains the short description of the reason for a patient location change."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #184
* 5 0..0 ST "PV2-5" "This field contains the short description of patient valuables checked in during admission."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "25"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #185
* 6 0..1 ST "PV2-6" "This field indicates the location of the patient's valuables."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "25"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #186
* 7 0..0 CWE "PV2-7" "This field further categorizes a patient's visit with respect to an individual institution's needs, and is expected to be site-specific. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70130[_User-defined Table 0130 - Visit User Code_] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0130 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #187
* 8 0..1 DTM "PV2-8" "This field contains the date and time that the patient is expected to be admitted. This field is also used to reflect the date/time of an outpatient/emergency patient registration."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #188
* 9 0..1 DTM "PV2-9" "This field contains the date and time that the patient is expected to be discharged. This is a non-event related date used by ancillaries to determine more accurately the projected workloads. This field is also used to reflect the anticipated discharge date/time of an outpatient/emergency patient, or an inpatient."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #189
* 10 0..1 NM "PV2-10" "This field specifies the estimated days of inpatient stays."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "3"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #711
* 11 0..1 NM "PV2-11" "This field contains the actual days of inpatient stays. The actual length of the inpatient stay may not be calculated from the admission and discharge dates because of possible leaves of absence."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 11 ^extension[=].extension[0].url = "length"
* 11 ^extension[=].extension[=].valueInteger = "3"
* 11 ^extension[=].extension[+].url = "noTruncate"
* 11 ^extension[=].extension[=].valueInteger = false
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #712
* 12 0..1 ST "PV2-12" "This field contains a brief user-defined description of the visit."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "50"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = true
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #713
* 13 0..0 XCN "PV2-13" "This field contains the name and the identification numbers of the person or organization that made the referral. This person/organization is not the same as the referring doctor. For example, Adam Everyman referred me to the Clinic (or to Dr. Everywoman at the Clinic)."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #714
* 14 0..1 DT "PV2-14" "This field contains the date of previous service for the same recurring condition. This may be a required field for billing certain illnesses (e.g., accident related) to a third party."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #715
* 15 0..1 ID "PV2-15" "This field specifies whether a patient's illness was job-related. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^extension[=].extension[+].url = "max"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #716
* 15 ^comment = "Y the patient's illness was job-related\n\nN the patient's illness was not job-related"
* 16 0..1 CWE "PV2-16" "This field contains the purge status code for the account. It is used by the application program to determine purge processing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70213[_User-defined Table 0213 - Purge Status Code_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0213 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #717
* 17 0..1 DT "PV2-17" "This field contains the date on which the data will be purged from the system."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #718
* 18 0..1 CWE "PV2-18" "This field designates the specific health insurance program for a visit required for healthcare reimbursement. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70214[_User-defined Table 0214 - Special Program Codes_] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0214 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #719
* 19 0..1 ID "PV2-19" "This field allows the user to control the financial and demographic purge processes at the visit. It is used to preserve demographic and financial data on specific, high priority visits. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #720
* 19 ^comment = "Y retain data\n\nN normal purge processing"
* 20 0..1 NM "PV2-20" "This field contains the number of insurance plans that may provide coverage for this visit."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "1"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = false
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #721
* 21 0..1 CWE "PV2-21" "This field contains a user-defined code indicating what level of publicity is allowed for a specific visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70215[_User-defined Table 0215 - Publicity Code_] in Chapter 2C, Code Tables, for suggested values. Refer to _PD1-11 - Publicity Code_ for the patient level publicity code."
* 21 from http://terminology.hl7.org/ValueSet/v2-0215 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #722
* 22 0..1 ID "PV2-22" "*From v 2.6 onward, this field has been retained for backwards compatibility only.* Use the ARV segment instead. This field identifies the person's protection that determines, in turn, whether access to information about this person should be kept from users who do not have adequate authority for a specific visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #B
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #723
* 22 ^comment = "Y protect access to patient information\n\nN normal access\n\nRefer to _PD1-12 - Protection Indicator_ for the patient level protection indicator."
* 23 0..0 XON "PV2-23" "This field contains the organization name or sub-unit and identifier that is associated with the (visit) episode of care. For example, the Allergy or Oncology Clinic within the healthcare facility might be named."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #724
* 24 0..1 CWE "PV2-24" "This field indicates the status of the episode of care. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70216[_User-defined Table 0216 - Patient Status_] in Chapter 2C, Code Tables, for suggested values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0216 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #725
* 25 0..1 CWE "PV2-25" "This field contains the priority of the visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70217[_User-defined Table 0217 - Visit Priority Code_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0217 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #726
* 26 0..1 DT "PV2-26" "This field contains the date that the patient last had treatment for any condition prior to this visit. In the case of a prior hospital visit, it is likely to be the previous discharge date."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #727
* 27 0..1 CWE "PV2-27" "This field describes what the patient's disposition is expected to be at the end of the visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70112[_User-defined Table 0112 - Discharge Disposition_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0112 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #728
* 28 0..1 DT "PV2-28" "This field contains the date on which a signature was obtained for insurance billing purposes."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #729
* 29 0..1 DT "PV2-29" "This field is used to determine if the patient has a pre-existing condition."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #730
* 30 0..1 CWE "PV2-30" "This field contains a user-defined code that indicates which adjustments should be made to this patient's charges. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70218[_User-defined Table 0218 - Patient Charge Adjustment_] in in chapter 2C, for suggested values. This field is the same as _GT1-26 - Guarantor Charge Adjustment Code_."
* 30 from http://terminology.hl7.org/ValueSet/v2-0218 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #731
* 31 0..1 CWE "PV2-31" "This field indicates whether the treatment is continuous. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70219[_User-defined Table 0219 - Recurring Service_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0219 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #732
* 32 0..1 ID "PV2-32" "This field indicates if the account is to be rejected from tape billing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 32 ^extension[=].extension[0].url = "min"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^extension[=].extension[+].url = "max"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #733
* 32 ^comment = "Y reject account from tape billing\n\nN normal processing"
* 33 0..1 DTM "PV2-33" "This field contains the date and time on which the surgery is expected to occur."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #734
* 34 0..1 ID "PV2-34" "This field indicates that a military healthcare facility has contracted with a non-military healthcare facility for the use of its services. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 34 ^extension[=].extension[0].url = "min"
* 34 ^extension[=].extension[=].valueInteger = 1
* 34 ^extension[=].extension[+].url = "max"
* 34 ^extension[=].extension[=].valueInteger = 1
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #735
* 34 ^comment = "Y contract(s) exist\n\nN no contract(s) exist"
* 35 0..1 ID "PV2-35" "This field indicates whether a patient has permission to use a non-military healthcare facility for treatment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 35 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 35 ^extension[=].extension[0].url = "min"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^extension[=].extension[+].url = "max"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #736
* 35 ^comment = "Y the patient has permission to use a non-military healthcare facility\n\nN the patient does not have permissions to use a non-military healthcare facility"
* 36 0..1 ID "PV2-36" "This field indicates whether the patient is a baby. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 36 ^extension[=].extension[0].url = "min"
* 36 ^extension[=].extension[=].valueInteger = 1
* 36 ^extension[=].extension[+].url = "max"
* 36 ^extension[=].extension[=].valueInteger = 1
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #737
* 36 ^comment = "Y the patient is a baby\n\nN the patient is not a baby"
* 37 0..1 ID "PV2-37" "This field indicates if the baby is detained after the mother's discharge. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 37 ^extension[=].extension[0].url = "min"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^extension[=].extension[+].url = "max"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #738
* 37 ^comment = "Y the baby was detained\n\nN normal discharge of mother and baby"
* 38 0..1 CWE "PV2-38" "Identifies how the patient was brought to the healthcare facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70430[_User-defined Table 0430 - Mode of Arrival Code_] in Chapter 2C, Code Tables, for suggested values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0430 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1543
* 39 0..0 CWE "PV2-39" "This field indicates what recreational drugs the patient uses. It is used for the purpose of room assignment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70431[_User-defined Table 0431 - Recreational Drug Use Code_] in Chapter 2C, Code Tables, for suggested values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0431 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1544
* 40 0..1 CWE "PV2-40" "This field indicates the acuity level assigned to the patient at the time of admission. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70432[_User-defined Table 0432 - Admission Level of Care Code_] in Chapter 2C, Code Tables, for suggested values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0432 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #1545
* 41 0..0 CWE "PV2-41" "This field indicates non-clinical precautions that need to be taken with the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70433[_User-defined Table 0433 - Precaution Code_] in Chapter 2C, Code Tables, for suggested values."
* 41 from http://terminology.hl7.org/ValueSet/v2-0433 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1546
* 42 0..1 CWE "PV2-42" "This field indicates the patient's current medical condition for the purpose of communicating to non-medical outside parties, e.g., family, employer, religious minister, media, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70434[_User-defined Table 0434 - Patient Condition Code_] in Chapter 2C, Code Tables, for suggested values."
* 42 from http://terminology.hl7.org/ValueSet/v2-0434 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #1547
* 43 0..1 CWE "PV2-43" "This field indicates whether or not the patient has a living will and, if so, whether a copy of the living will is on file at the healthcare facility. If the patient does not have a living will, the value of this field indicates whether the patient was provided information on living wills. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70315[_User-defined Table 0315 - Living Will Code_] in Chapter 2C, Code Tables, for suggested values. See also _PD1-7 - Living Will_."
* 43 from http://terminology.hl7.org/ValueSet/v2-0315 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #759
* 44 0..1 CWE "PV2-44" "This field indicates whether the patient wants to donate his/her organs and whether an organ donor card or similar documentation is on file with the healthcare organization. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70316[_User-defined Table 0316 - Organ Donor Code_] in Chapter 2C, Code Tables, for suggested values. See also _PD1-8 - Organ Donor_."
* 44 from http://terminology.hl7.org/ValueSet/v2-0316 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #760
* 45 0..0 CWE "PV2-45" "This field indicates the patient's instructions to the healthcare facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70435[_User-defined Table 0435 - Advance Directive Code_] in Chapter 2C, Code Tables, for suggested values. See also _PD1-15 - Advance Directive Code_. This field is required if _PV2-50 - Advance Directive Last Verified Date_ is valued."
* 45 from http://terminology.hl7.org/ValueSet/v2-0435 (required)
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #C
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #1548
* 45 ^comment = "*Note:* for details about specific consent refer to the Consent (CON) segment in chapter 9."
* 46 0..1 DT "PV2-46" "This field indicates the effective date for _PV2-24 - Patient Status_."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #1549
* 47 0..1 DTM "PV2-47" "This field is conditionally required for _A21 - Patient goes on LOA_. It may be populated in _A22 - Patient returns from LOA_ as well as in the _A53 - Cancel LOA for a patient_ and the _A54 - Cancel patient returns from LOA_ triggers. This field contains the date/time that the patient is expected to return from LOA."
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #C
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #1550
* 48 0..1 DTM "PV2-48" "This field contains the date/time that the patient is expected for pre-admission testing."
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #1841
* 49 0..0 CWE "PV2-49" "This field allows the user to indicate whether the clergy should be notified. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70534[_User-defined Table 0534 - Notify Clergy Code_] in Chapter 2C, Code Tables, for suggested values."
* 49 from http://terminology.hl7.org/ValueSet/v2-0534 (required)
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #1842
* 50 0..1 DT "PV2-50" "This field indicates the date that all the advance directives held in _PV2-45 - Advance Directive Code_ were last verified. When this field is valued, the field _PV2-45 - Advance Directive Code_ is required."
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #2141