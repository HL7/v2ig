Logical: PV1
Parent: $Segment
Id: PV1
Title: "HL7 v2 PV1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Patient Visit"
* 1 0..1 SI "PV1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #131
* 2 1..1 CWE "PV1-2" "This field is used by systems to categorize patients by site. It does not have a consistent industry-wide definition. It is subject to site‑specific variations. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70004[_User-defined Table 0004 - Patient Class_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0004 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #132
* 2 ^comment = "\"Commercial Account\" is used by reference labs for specimen processing when the service is billed back to a third party. A registration is processed for the specimen to facilitate the subsequent billing. The identity of the patient may be known or unknown. In either case, for billing and statistical purposes, the patient class is considered a commercial account due to the third party billing responsibility.\n\n\"Not Applicable\" is used only in cases where the PV1 segment itself is not applicable but is retained in the message definitions for backwards compatibility (for example when a managed care system sends A28, A29, or A31 messages to indicate the enrolment of a patient in the system and there is no scheduled \"visit\" or \"encounter\" and hence the entire PV1 segment is not applicable)."
* 3 0..1 PL "PV1-3" "This field contains the patient's initial assigned location or the location to which the patient is being moved. The first component may be the nursing station for inpatient locations, or clinic or department, for locations other than inpatient. For canceling a transaction or discharging a patient, the current location (after the cancellation event or before the discharge event) should be in this field. If a value exists in the fifth component (location status), it supersedes the value in _PV1-40 - Bed Status_."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #133
* 4 0..1 CWE "PV1-4" "This field indicates the circumstances under which the patient was or will be admitted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70007[_User-defined Table 0007 - Admission Type_] in Chapter 2C, Code Tables, for suggested values. In the US, entities required to be compliant with the US Healthcare Information Technology Standards Panel (HITSP) are required to use the Official Universal Billing (UB) 04 2008 numeric codes found on form locator 14. Refer to External Table UB04FL14 for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0007 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #134
* 4 ^comment = "For example:\n\nNon-US |E^Emergency^HL70007|\n\nUS: |1^Emergency^UB04FL14^^^^2008, v 2.0|\n\nTo report that information is not available:\n\nNon-US: |NI^No Information^HL70532|\n\nUS: |9^Information not available^ UB04FL14^^^^2008, v 2.0|"
* 5 0..1 CX "PV1-5" "This field uniquely identifies the patient's pre‑admit account. Some systems will continue to use the pre‑admit number as the billing number after the patient has been admitted. For backward compatibility, a ST data type can be sent; however, HL7 recommends use of the CX data type, like the account number, for new implementations. The assigning authority and identifier type codes are strongly recommended for all CX data types."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #135
* 6 0..1 PL "PV1-6" "This field contains the prior patient location if the patient is being transferred. The old location is null if the patient is new. If a value exists in the fifth component (location status), it supersedes the value in _PV1-40 - Bed Status_."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #136
* 7 0..0 XCN "PV1-7" "This field contains the attending physician information. Multiple names and identifiers for the same physician may be sent. The field sequences are not used to indicate multiple attending doctors. As of v2.7, if _XCN.1 ID Number_ is populated, then the _XCN.13 Identifier Type Code_ and the _XCN.9 Assigning Authority_ or _XCN.22 Assigning Jurisdiction_ or _XCN.23 Assigning Agency or Department_ are required. If _XCN.2 Family Name_ is populated, then the _XCN.10 Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated. Depending on local agreements, either ID or the name may be absent in this field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70010[_User-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #137
* 8 0..0 XCN "PV1-8" "This field contains the referring physician information. Multiple names and identifiers for the same physician may be sent. The field sequences are not used to indicate multiple referring doctors. As of v 2.7 if _XCN.1 ID Number_ is populated, then the _XCN.13 Identifier Type Code_ and the _XCN.9 Assigning Authority_ or _XCN.22 Assigning Jurisdiction_ or _XCN.23 Assigning Agency or Department_ are required. If _XCN.2 Family Name_ is populated, then the _XCN.10 Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated. Depending on local agreements, either the ID or the name may be absent from this field. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70010[User-defined Table 0010 - Physician ID]_ in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #138
* 9 0..0 XCN "PV1-9" "PV1-9"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #B
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #139
* 9 ^comment = "*From V2.4 onward, this field has been retained for backward compatibility only.* It is recommended to use the PRT - Participation segment for consulting physicians instead."
* 10 0..1 CWE "PV1-10" "This field contains the treatment or type of surgery that the patient is scheduled to receive. It is a required field with trigger events A01 (admit/visit notification), A02 (transfer a patient), A14 (pending admit), A15 (pending transfer). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70069[_User-defined Table 0069 - Hospital Service_] in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0069 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #140
* 11 0..1 PL "PV1-11" "This field contains a location other than the assigned location required for a temporary period of time (e.g., OR, operating theatre, etc.). If a value exists in the fifth component (location status), it supersedes the value in _PV1-40 - Bed Status_."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #141
* 12 0..1 CWE "PV1-12" "This field indicates whether the patient must have pre‑admission testing done in order to be admitted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70087[_User-defined Table 0087 - Pre-Admit Test Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0087 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #142
* 13 0..1 CWE "PV1-13" "This field indicates that a patient is being re‑admitted to the healthcare facility and gives the circumstances. We suggest using \"*R*\" for readmission or else null. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70092[_User-defined Table 0092 - Re-Admission Indi__cator_] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0092 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #143
* 14 0..1 CWE "PV1-14" "This field indicates from where the patient was admitted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70023[_User-defined Table 0023 - Admit Source_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Official Uniform Billing (UB) 04 2008 numeric codes found on form locator 15. Refer to _External Table UB04FL15 Source of Origin_ for valid values. The UB has redefined the Admission Source as the Point of Origin for Admission or Visit. The new UB definition is the code indicating the Point of Origin for this Admission or Visit"
* 14 from http://terminology.hl7.org/ValueSet/v2-0023 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #144
* 14 ^comment = "For Example:\n\nUS: |1^Physician Referral^UB04FL15^^^^2008, v 2.0|\n\nTo report that information is not available:\n\nUS: |9^Information not available^ UB04FL15^^^^2008, v 2.0|"
* 15 0..0 CWE "PV1-15" "This field indicates any permanent or transient handicapped conditions. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70009[_User-defined Table 0009 - Ambulatory Status_] in Chapter 2C, Code Tables, for suggested entries."
* 15 from http://terminology.hl7.org/ValueSet/v2-0009 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #145
* 16 0..1 CWE "PV1-16" "This field identifies the type of VIP. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70099[_User-defined Table 0099 - VIP Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0099 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #146
* 17 0..0 XCN "PV1-17" "This field contains the admitting physician information. Multiple names and identifiers for the same physician may be sent. The field sequences are not used to indicate multiple admitting doctors. As of v2.7 if _XCN.1 ID Number_ is populated, then the _XCN.13 Identifier Type Code_ and the _XCN.9 Assigning Authority_ or _XCN.22 Assigning Jurisdiction_ or _XCN.23 Assigning Agency or Department_ are required. If _XCN.2 Family Name_ is populated, then the _XCN.10 Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated. By local agreement, the name or ID may be absent in this field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70010[_User-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #147
* 18 0..1 CWE "PV1-18" "This field contains site-specific values that identify the patient type. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70018[_User-defined Table 0018 - Patient Type_] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0018 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #148
* 19 0..1 CX "PV1-19" "For backward compatibility, a NM data type may be sent, but HL7 recommends that new implementations use the CX data type**.** This field contains the unique number assigned to each patient visit. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #149
* 20 0..0 FC "PV1-20" "This field contains the financial class(es) assigned to the patient for the purpose of identifying sources of reimbursement. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70064[_User-defined Table 0064 - Financial Class_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0064 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #150
* 21 0..1 CWE "PV1-21" "This field contains the code used to determine which price schedule is to be used for room and bed charges. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70032[_User-defined Table 0032 - Charge/Price Indi__c__at__or_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0032 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #151
* 22 0..1 CWE "PV1-22" "This field indicates whether the patient will be extended certain special courtesies. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70045[_User-defined Table 0045 - Courtesy Code_] in Chapter 2C, Code Tables, for suggested values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0045 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #152
* 23 0..1 CWE "PV1-23" "This field contains the user-defined code to determine past credit experience. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70046[_User-defined Table 0046 - Credit Rati__ng_] in Chapter 2C, Code Tables, for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0046 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #153
* 24 0..0 CWE "PV1-24" "This field identifies the type of contract entered into by the healthcare facility and the guarantor for the purpose of settling outstanding account balances. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70044[_User-defined Table 0044 - Contract Code_] in Chapter 2C, Code Tables, for suggested values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0044 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #154
* 25 0..0 DT "PV1-25" "This field contains the date that the contract is to start or started."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #155
* 26 0..0 NM "PV1-26" "This field contains the amount to be paid by the guarantor each period according to the contract."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 26 ^extension[=].extension[0].url = "length"
* 26 ^extension[=].extension[=].valueInteger = "12"
* 26 ^extension[=].extension[+].url = "noTruncate"
* 26 ^extension[=].extension[=].valueInteger = false
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #156
* 27 0..0 NM "PV1-27" "This field specifies the duration of the contract for user-defined periods."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 27 ^extension[=].extension[0].url = "length"
* 27 ^extension[=].extension[=].valueInteger = "3"
* 27 ^extension[=].extension[+].url = "noTruncate"
* 27 ^extension[=].extension[=].valueInteger = false
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #157
* 28 0..1 CWE "PV1-28" "This field indicates the amount of interest that will be charged the guarantor on any outstanding amounts. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70073[_User-defined Table 0073 - Interest Rate Code_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0073 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #158
* 29 0..1 CWE "PV1-29" "This field indicates that the account was transferred to bad debts and gives the reason. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70110[_User-defined Table 0110 - Transfer to Bad Debt Code_] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0110 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #159
* 30 0..1 DT "PV1-30" "This field contains the date that the account was transferred to a bad debt status."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #160
* 31 0..1 CWE "PV1-31" "This field can be used as a ST type for backward compatibility. This field uniquely identifies the bad debt agency to which the account was transferred. This code is site defined. One possible implementation would be to edit against a table such as file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70021[_User-defined Table 0021 - Bad Debt Agency Code_]; in chapter 2C, however, this is not required."
* 31 from http://terminology.hl7.org/ValueSet/v2-0021 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #161
* 32 0..1 NM "PV1-32" "This field contains the amount that was transferred to a bad debt status."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 32 ^extension[=].extension[0].url = "length"
* 32 ^extension[=].extension[=].valueInteger = "12"
* 32 ^extension[=].extension[+].url = "noTruncate"
* 32 ^extension[=].extension[=].valueInteger = false
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #162
* 33 0..1 NM "PV1-33" "This field contains the amount recovered from the guarantor on the account."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 33 ^extension[=].extension[0].url = "length"
* 33 ^extension[=].extension[=].valueInteger = "12"
* 33 ^extension[=].extension[+].url = "noTruncate"
* 33 ^extension[=].extension[=].valueInteger = false
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #163
* 34 0..1 CWE "PV1-34" "This field indicates that the account was deleted from the file and gives the reason. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70111[_User-defined Table 0111 - Delete Account Code_] in Chapter 2C, Code Tables, for suggested values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0111 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #164
* 35 0..1 DT "PV1-35" "This field contains the date that the account was deleted from the file."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #165
* 36 0..1 CWE "PV1-36" "This field contains the disposition of the patient at time of discharge (i.e., discharged to home, expired, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70112[_User-defined Table 0112 - Discharge Dispos__ition_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Official Uniform Billing (UB) 04 2008 numeric codes found on form locator 17. Refer to _External Table UB04FL17 Patient Discharge Status_ for valid values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0112 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #166
* 36 ^comment = "Examples:\n\nUS: |01^ Discharged to home or self care (routine discharge)^UB04FL17^^^^2008, v 2.0|\n\n*Usage Note:* NUBC does not supply a null value for this field."
* 37 0..1 DLD "PV1-37" "This field indicates the healthcare facility to which the patient was discharged and the date. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70113[_User-defined Table 0113 - Discharged to Location_] in Chapter 2C, Code Tables, for suggested values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0113 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #167
* 38 0..1 CWE "PV1-38" "This field indicates a special diet type for a patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70114[_User-defined Table 0114 - Diet Type_] in Chapter 2C, Code Tables, for suggested values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0114 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #168
* 39 0..1 CWE "PV1-39" "This field is used in a multiple facility environment, e.g., multiple campuses or buildings, to indicate the healthcare facility with which this visit is associated. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70115[_User-defined Table 0115 - Servicing Facility_] in Chapter 2C, Code Tables, for suggested values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0115 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #169
* 39 ^comment = "An optional sixth component, the facility ID, may be valued in each individual location field in PV1, instead of placing it here."
* 40 0..1 BackboneElement "PV1-40" "*The PV1-40 field was retained for backward compatibility only as of v 2.3, and the field withdrawn as of v 2.7*. The information is now held in the fifth component of the PL datatype in PV1-3."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #W
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #170
* 41 0..1 CWE "PV1-41" "This field contains the account status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70117[_User-defined Table 0117 - Account Status_] in Chapter 2C, Code Tables, for suggested values."
* 41 from http://terminology.hl7.org/ValueSet/v2-0117 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #171
* 42 0..1 PL "PV1-42" "This field indicates the point of care, room, bed, healthcare facility ID, and bed status to which the patient may be moved. The first component may be the nursing station for inpatient locations, or the clinic, department, or home for locations other than inpatient. If a value exists in the fifth component (location status), it supersedes the value in _PV1-40 - Bed Status_."
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #172
* 43 0..1 PL "PV1-43" "This field is used to reflect the patient's temporary location (such as the operating room/theatre or x-ray) prior to a transfer from a temporary location to an actual location, or from a temporary location to another temporary location. The first component may be the nursing station for inpatient locations, or the clinic, department, or home for locations other than inpatient."
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #173
* 44 0..1 DTM "PV1-44" "This field contains the admit date/time. It is to be used if the event date/time is different than the admit date and time, i.e., a retroactive update. This field is also used to reflect the date/time of an outpatient/emergency patient registration."
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #174
* 45 0..1 DTM "PV1-45" "This field contains the discharge date/time. It is to be used if the event date/time is different than the discharge date and time, that is, a retroactive update. This field is also used to reflect the date/time of an outpatient/emergency patient discharge."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #175
* 46 0..1 NM "PV1-46" "This field contains the visit balance due."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 46 ^extension[=].extension[0].url = "length"
* 46 ^extension[=].extension[=].valueInteger = "12"
* 46 ^extension[=].extension[+].url = "noTruncate"
* 46 ^extension[=].extension[=].valueInteger = false
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #176
* 47 0..1 NM "PV1-47" "This field contains the total visit charges."
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 47 ^extension[=].extension[0].url = "length"
* 47 ^extension[=].extension[=].valueInteger = "12"
* 47 ^extension[=].extension[+].url = "noTruncate"
* 47 ^extension[=].extension[=].valueInteger = false
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #177
* 48 0..1 NM "PV1-48" "This field contains the total adjustments for visit."
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 48 ^extension[=].extension[0].url = "length"
* 48 ^extension[=].extension[=].valueInteger = "12"
* 48 ^extension[=].extension[+].url = "noTruncate"
* 48 ^extension[=].extension[=].valueInteger = false
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #178
* 49 0..1 NM "PV1-49" "This field contains the total payments for visit."
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 49 ^extension[=].extension[0].url = "length"
* 49 ^extension[=].extension[=].valueInteger = "12"
* 49 ^extension[=].extension[+].url = "noTruncate"
* 49 ^extension[=].extension[=].valueInteger = false
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #179
* 50 0..0 CX "PV1-50" "This field contains the alternative, temporary, or pending optional visit ID number to be used if needed. Multiple alternate identifiers may be sent. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] in Chapter 2C, Code Tables, for valid values. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70203[_HL7 Table 0203 - Identifier Type_] in Chapter 2C, Code Tables, for valid values. The assigning authority and identifier type codes are strongly recommended for all CX data types."
* 50 from http://terminology.hl7.org/ValueSet/v2-0203 (required)
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #180
* 51 0..1 CWE "PV1-51" "This field specifies the level on which data are being sent. It is the indicator used to send data at two levels, visit and account. HL7 recommends sending an 'A' or no value when the data in the message are at the account level, or 'V' to indicate that the data sent in the message are at the visit level. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70326[_User-defined Table 0326 - Visit Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 51 from http://terminology.hl7.org/ValueSet/v2-0326 (required)
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #1226
* 51 ^comment = "The value of this element affects the context of data sent in PV1, PV2 and any associated hierarchical segments (e.g., DB1, AL1, DG1, etc.)."
* 52 0..1 BackboneElement "PV1-52" "*The PV1-52 field was retained for backward compatibility only as of v 2.4 and withdrawn as of v 2.7.* The reader is advised to use the PRT segment to communicate providers not specified elsewhere. Refer to Chapter 7 for the definition of the PRT segment."
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #W
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #1274
* 53 0..1 ST "PV1-53" "This field contains a brief user-defined description of a Service Episode in or for which the visit occurs. A Service Episode is the context in which the treatment or management of an arbitrary subset of a Patient’s medical conditions occurs. The definition of the start time, stop time, and included events of a Service Episode is entirely arbitrary; it may include a single outpatient visit or a hospitalization, or extend over significant period of time, e.g., the duration of a pregnancy, or an oncology treatment regimen, or a cardiac episode from infarction through rehabilitation. A Service Episode may involve one or more Healthcare Organizations."
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 53 ^extension[=].extension[0].url = "length"
* 53 ^extension[=].extension[=].valueInteger = "50"
* 53 ^extension[=].extension[+].url = "noTruncate"
* 53 ^extension[=].extension[=].valueInteger = true
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #2290
* 54 0..1 CX "PV1-54" "This field contains the identifier of a Service Episode in or for which the visit occurs."
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #2291