Logical: IN3
Parent: $Segment
Id: IN3
Title: "HL7 v2 IN3 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Insurance Additional Information, Certification"
* 1 1..1 SI "IN3-1" "_IN3-1 - Set ID - IN3_ contains the number that identifies this transaction. For the first occurrence of the segment the sequence number shall be 1, for the second occurrence it shall be 2, etc. The set ID in the IN3 segment is used when there are multiple certifications for the insurance plan identified in IN1-2. The set ID in the IN3 segment is provided because there can be multiple repetitions of the IN3 segment if there are multiple certifications for the same insurance plan, e.g., IN1 (Set ID 1), IN2, IN3 (Set ID 1), IN3 (Set ID 2), IN3 (Set ID 3). Further details are provided in 6.5.6.1."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #502
* 2 0..1 CX "IN3-2" "This field contains the number assigned by the certification agency. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #503
* 3 0..0 XCN "IN3-3" "This field contains the party that approved the certification. Multiple names and identifiers for the same person may be sent in this sequence Specification of meaning based on sequence is deprecated."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #504
* 4 0..1 ID "IN3-4" "This field indicates whether certification is required. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #505
* 4 ^comment = "Y certification required\n\nN certification not required"
* 5 0..1 MOP "IN3-5" "This field contains the penalty, in dollars or a percentage that will be assessed if the pre-certification is not performed."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #506
* 6 0..1 DTM "IN3-6" "This field contains the date and time stamp that indicates when insurance was certified to exist for the patient."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #507
* 7 0..1 DTM "IN3-7" "This field contains the date/time that the certification was modified."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #508
* 8 0..0 XCN "IN3-8" "This field contains the name party who is responsible for sending this certification information. Multiple names for the same person may be sent in this sequence. Specification of meaning based on sequence is deprecated."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #509
* 9 0..1 DT "IN3-9" "This field contains the date that this certification begins."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #510
* 10 0..1 DT "IN3-10" "This field contains date that this certification ends."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #511
* 11 0..1 DTN "IN3-11" "This field contains the number of days for which this certification is valid. This field applies to denied, pending, or approved days."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #512
* 12 0..1 CWE "IN3-12" "This field contains the non-concur code and description for a denied request. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70233[_User-defined Table 0233 - Non-Concur Code/Description_] in Chapter 2C, Code Tables, for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0233 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #513
* 13 0..1 DTM "IN3-13" "This field contains the effective date of the non-concurrence classification."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #514
* 14 0..0 XCN "IN3-14" "This field contains the physician who works with and reviews cases that are pending physician review for the certification agency. Multiple names for the same person may be sent in this sequence. Specification of meaning based on sequence is deprecated. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70010[_U__ser-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #515
* 15 0..1 ST "IN3-15" "This field contains the name of the party contacted at the certification agency who granted the certification and communicated the certification number."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "48"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = true
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #516
* 16 0..0 XTN "IN3-16" "This field contains the phone number of the certification contact. Multiple phone numbers for the same certification contact may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #517
* 17 0..1 CWE "IN3-17" "This field contains the reason that an appeal was made on a non-concur for certification. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70345[_User-defined Table 0345 - Appeal Reason_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0345 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #518
* 18 0..1 CWE "IN3-18" "This field contains the certification agency. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70346[_User-defined Table 0346 - Certification Agency_] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0346 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #519
* 19 0..0 XTN "IN3-19" "This field contains the phone number of the certification agency."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #520
* 20 0..0 ICD "IN3-20" "This field indicates whether pre-certification is required for particular patient types, and the time window for obtaining the certification. The following components of this field are defined as follows:"
* 20 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #521
* 20 ^comment = "• pre-certification required refers to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values.\n\nY pre-certification required\n\nN no pre-certification required\n\n• pre-certification window is the date/time by which the pre-certification must be obtained."
* 21 0..1 ST "IN3-21" "This field contains the name of the entity, which is handling this particular patient's case (e.g., UR nurse, or a specific healthcare facility location)."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 21 ^extension[=].extension[0].url = "length"
* 21 ^extension[=].extension[=].valueInteger = "48"
* 21 ^extension[=].extension[+].url = "noTruncate"
* 21 ^extension[=].extension[=].valueInteger = true
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #522
* 22 0..1 DT "IN3-22" "This field contains the date that the second opinion was obtained."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #523
* 23 0..1 CWE "IN3-23" "This field contains the code that represents the status of the second opinion. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70151[_User-defined Table 0151 - Second Opinion Status_] in Chapter 2C, Code Tables, for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0151 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #524
* 24 0..0 CWE "IN3-24" "Use this field if accompanying documentation has been received by the provider. Refer to _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70152[User-defined Table 0152 - Second Opinion Documentation Received]_ in Chapter 2C, Code Tables, for suggested values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0152 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #525
* 25 0..0 XCN "IN3-25" "This field contains an identifier and name of the physician who provided the second opinion. Multiple names and identifiers for the same person may be sent in this sequence. Specification of meaning based on sequence is deprecated. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70010[_User-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #526
* 26 0..1 CWE "IN3-26" "This field contains the certification type code for a specific certification. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70921[_User-defined Table 0921 – Certification Type Code_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0921 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #3336
* 27 0..1 CWE "IN3-27" "This field contains the certification category code for a specific certification. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70922[_User-defined Table 0922 – Certification Category Code_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0922 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #3337
* 28 0..1 DTM "IN3-28" "This field contains the timestamp of the online verification of the insurance information."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2483
* 29 0..1 CWE "IN3-29" "This field contains the result of the online verification. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70970[_User-defined Table 0970 – Online Verification Result_] in Chapter 2C, Code Tables, for suggested values. This field is required if IN3-28 is populated."
* 29 from http://terminology.hl7.org/ValueSet/v2-0970 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #C(R/X)
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2484
* 30 0..1 CWE "IN3-30" "This field contains the error code for the result of the online verification. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70791[_User-defined Table 0791 – Online Verification Result Error Code_] in Chapter 2C, Code Tables, for suggested values. This field is required if IN3-28 is populated and an error status is returned."
* 30 from http://terminology.hl7.org/ValueSet/v2-0971 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #C(RE/X)
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2485
* 31 0..1 ST "IN3-31" "This field contains the check digit for the online verification of the insurance information. This field is required if IN3-28 is populated."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #C(R/X)
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2486