Logical: STF
Parent: $Segment
Id: STF
Title: "HL7 v2 STF Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Staff Identification"
* 1 0..1 CWE "STF-1" "For MFN Master File Notification, this field is required and must match _MFE-4 Primary Key Value_ to identify which entry is being referenced. For all other messages, this field should not be used. Refer to Table 0786 - Primary Key Value – STF in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0786 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #671
* 2 0..0 CX "STF-2" "This field contains the list of identifiers (one or more) used by the institution to identify this person. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] (component 2), file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70203[_User-defined Table 0203 - Identifier Type_] (component 5) and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70363[_User-defined Table 0363 - Assigning Authority_] (component 4) for valid values (see Chapter 2A). If a Staff Member has institution identifiers that are valid only in specific organization units, that Staff identifier should be recorded in the _ORG Practitioner Organization Unit_ segment."
* 2 from http://terminology.hl7.org/ValueSet/v2-0363 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #672
* 3 0..0 XPN "STF-3" "This field contains the staff person's name. This field may repeat to transmit multiple names for the same person."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #673
* 4 0..0 CWE "STF-4" "This field contains a code identifying what type of staff. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70182[_User-defined Table 0182 - Staff type_] in Chapter 2C, Code Tables, for suggested values. This table contains no suggested values. Values may include codes for staff, practitioner, referral agent or agency, etc. This field may repeat to allow for staff to be assigned multiple types."
* 4 from http://terminology.hl7.org/ValueSet/v2-0182 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #674
* 4 ^comment = "Typically, this field would be populated with the most granular types that may be associated with the staff. If less granular typing or categorization of the staff is required in addition to the specific type(s) found in this field, the reader is referred to _STF-39 Generic Resource Type or Category_. Thus, while STF-4 may contain the code for a specific staff or practitioner type, STF-39 may contain \"staff\" or \"practitioner\". For further discussion of specific and generic types, the reader is referred to _STF-39 Generic Resource Type or Category_."
* 5 0..1 CWE "STF-5" "This field contains the staff person's sex. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70001[_User-defined Table 0001 – Administrative Sex_] for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #111
* 6 0..1 DTM "STF-6" "This field contains a staff member's date and time of birth."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #110
* 7 0..1 ID "STF-7" "This field indicates whether person is currently a valid staff member. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70183[HL7 Table 0183 - Active/Inactive]_ in Chapter 2C, Code Tables, for valid values. This table contains values for active or inactive."
* 7 from http://terminology.hl7.org/ValueSet/v2-0183 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #675
* 8 0..0 CWE "STF-8" "This field contains the institution department to which this person reports or belongs. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70184[User-defined Table 0184 - Departmen]t_ in Chapter 2C, Code Tables, for suggested values. This table contains no suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0184 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #676
* 9 0..0 CWE "STF-9" "This field contains the hospital or ancillary service with which this staff person is associated. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70069[_User-defined Table 0069 - Hospital Service_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0069 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #677
* 10 0..0 XTN "STF-10" "This field contains the staff person's phone number. This is a repeating field with a component for indicating which phone number is which."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #678
* 11 0..0 XAD "STF-11" "This field contains the office, and home address and/or place of birth of the staff person. This is a repeating field. The address type identifies the usage."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #679
* 12 0..0 DIN "STF-12" "This field contains the date when staff became active for an institution. This is a repeating field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70537[_User-defined Table 0537 - Institution_] in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0537 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #680
* 13 0..0 DIN "STF-13" "This field contains the date when staff became inactive for an institution. This is a repeating field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70537[_HL7 Table 0537 - Institution_] in Chapter 2C, Code Tables, for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0537 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #681
* 14 0..0 CWE "STF-14" "This field contains the _MFE-4 Primary Key Value_ of the master file entry that corresponds to the designated backup person for this staff person."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #682
* 15 0..0 ST "STF-15" "*_This field has been retained for backward compatibility._* (It is now present in the fourth component of _STF-10 Phone_)."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #B
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "40"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #683
* 16 0..1 CWE "STF-16" "This field indicates which of a group of multiple phone numbers is the preferred method of contact for this person. Note that all values of this code refer to this segment's phone field, except for the value \"E,\" which refers to the E-mail address field. If more than one phone number of the preferred type exists in _STF-10-phone_, this field refers to the first such instance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70185[_HL7 Table_ _0185 - Preferred Method of Contact_] in Chapter 2C, Code Tables, for valid values. This table contains values for beeper, cell phone etc."
* 16 from http://terminology.hl7.org/ValueSet/v2-0185 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #684
* 17 0..1 CWE "STF-17" "This field contains the staff member's marital status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70002[_User-defined Table 0002 - Marital Status_] in Chapter 2C, Code Tables, for suggested values. Same values as those for _PID-16 Marital Status_."
* 17 from http://terminology.hl7.org/ValueSet/v2-0002 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #119
* 18 0..1 ST "STF-18" "This field contains a descriptive name of the staff member's occupation (e.g., Sr. Systems Analyst, Sr. Accountant)."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "20"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = true
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #785
* 19 0..1 JCC "STF-19" "This field contains the staff member's job code and employee classification. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70327[_User-defined Table 0327 - Job Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70328[_User-defined Table 0328 - Employee Classification_] in Chapter 2C, Code Tables, for suggested values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0327 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #786
* 20 0..1 CWE "STF-20" "This field contains the code that indicates the staff member's employment status, e.g., full-time, part-time, self-employed, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70066[_User-defined Table 0066 - Employment Status_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0066 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1276
* 21 0..1 ID "STF-21" "This field contains an indicator for whether the present institution is named as an additional insured on the staff member's auto insurance, especially for use when staff is a driver for the institution. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1275
* 21 ^comment = "Y indicates that the institution is named as an additional insured\n\nN indicates that the institution is not named as an additional insured"
* 22 0..1 DLN "STF-22" "This field contains the driver's license information of staff, especially for use when staff is a driver for the institution. For state or province refer to official postal codes for that country; for country refer to ISO 3166 for codes."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1302
* 23 0..1 ID "STF-23" "This field contains an indicator for whether the institution has on file a copy of the staff member's auto insurance, especially for use when staff is a driver for the institution. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1229
* 23 ^comment = "Y indicates that the institution has a copy on file\n\nN indicates that the institution does not have a copy on file"
* 24 0..1 DT "STF-24" "This field contains the date on which the staff member's driver's license expires, especially for use when staff is a driver for the institution."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1232
* 25 0..1 DT "STF-25" "This field contains the date of the staff member's most recent Department of Motor Vehicles review, especially for use when staff is a driver for the institution."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1298
* 26 0..1 DT "STF-26" "This field contains the date of the staff member's next Department of Motor Vehicles review, especially for use when staff is a driver for the institution."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1234
* 27 0..1 CWE "STF-27" "This field refers to the person's race. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70005[_User-defined Table 0005 - Race_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CWE data type for race (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes."
* 27 from http://terminology.hl7.org/ValueSet/v2-0005 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #113
* 28 0..1 CWE "STF-28" "This field further defines the person's ancestry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70189[_User-defined Table 0189 - Ethnic Group_] in Chapter 2C, Code Tables, for suggested values. The second couplet of the CWE data type for ethnic group (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes. In the United States, a current use is to report ethnicity in line with US federal standards for Hispanic origin."
* 28 from http://terminology.hl7.org/ValueSet/v2-0189 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #125
* 29 0..1 ID "STF-29" "This field contains an indicator for whether the re-activation of this record requires special approval. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 29 ^extension[=].extension[0].url = "min"
* 29 ^extension[=].extension[=].valueInteger = 1
* 29 ^extension[=].extension[+].url = "max"
* 29 ^extension[=].extension[=].valueInteger = 1
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1596
* 29 ^comment = "Y the re-activation requires approval\n\nN this re-activation does not require approval"
* 30 0..0 CWE "STF-30" "This field contains the staff person's current country of citizenship. HL7 recommends using ISO table 3166 as the suggested values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70171[_User-defined Table 0171 - Citizenship_] (in Chapter 2C, Code Tables)."
* 30 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #129
* 31 0..1 DTM "STF-31" "This field contains the date and time at which the staff person death occurred."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1886
* 32 0..1 ID "STF-32" "This field indicates whether the staff person is deceased. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 32 ^extension[=].extension[0].url = "min"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^extension[=].extension[+].url = "max"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1887
* 32 ^comment = "Y the staff person is deceased +\n\nN the staff person is not deceased"
* 33 0..1 CWE "STF-33" "This field specifies the relationship the staff person has with the institution for whom he/she provides services. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70538[_User–defined Table 0538 – Institution Relationship Type_] in Chapter 2C, Code Tables, for suggested values. This table contains values for employee, volunteer, etc."
* 33 from http://terminology.hl7.org/ValueSet/v2-0538 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1888
* 34 0..1 DR "STF-34" "This field contains the period during which the staff person started and ended the relationship specified in _STF-33 Institution Relationship Type Code_."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1889
* 35 0..1 DT "STF-35" "This field contains the date on which an inactive staff member expects to return to work."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1890
* 36 0..0 CWE "STF-36" "This field describes the organization unit in the General Ledger to which the staff member is currently assigned. It is sometimes referred to as the \"home\" cost center because it is the organization unit to which the staff member's regular costs are accrued. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70539[User-defined Table 0539 – Cost Center Code]_ in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0539 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #1891
* 37 0..1 ID "STF-37" "This field describes whether or not this STF record represents an identifiable (i.e., real) human being or is a \"placeholder\" for one whose identity is not yet known. For example, work schedules may need to be created before the actual staff member has been hired, or appointments may be made with a floating resource who is not specifically known until the actual appointment date/time. Because these functions require a Staff Member ID code, it is important to distinguish whether or not the Staff Member is a real human resource or not. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 37 ^extension[=].extension[0].url = "min"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^extension[=].extension[+].url = "max"
* 37 ^extension[=].extension[=].valueInteger = 1
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1892
* 37 ^comment = "Y indicates that the staff member is an identifiable human being\n\nN indicates that the staff member is not an identifiable human being"
* 38 0..1 CWE "STF-38" "This field contains the reason that the staff member is inactive. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70540[_User-defined Table 0540 – Inactive Reason Code_] in Chapter 2C, Code Tables, for suggested values. This table contains values for leave of absence, terminated, etc."
* 38 from http://terminology.hl7.org/ValueSet/v2-0540 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1893
* 39 0..0 CWE "STF-39" "This field transmits a code that represents a high level categorization of resources. This is a companion field for the _STF-4 Staff Type_ and allows an institution or enterprise to impose [line-through]#a# one or more super category levels. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70771[_User-defined Table 0771 – Resource Type or Category_] in Chapter 2C, Code Tables, for suggested values. This table contains no suggested values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0771 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #2184
* 39 ^comment = "An enterprise might have more than one method to categorize or type resources at a high level. Therefore, this field can repeat.\n\nExample: An organization may define discreet staff types (e.g., Pediatric Oncologist, Gerontologist, Oncology Pharmacist, Pediatric Pharmacist, Critical Care Nurse, Nurse Case Manager – Cardiology) as well as broad categories (e.g., Physician, Pharmacist, Nurse, Pediatric, Oncology, Cardiology, Case Management, Nephrology). Employing STF-4 for the discreet terms and STF-39 for the more generic terms allows both the levels of granularity to be apply to the staff without confusing the specific types with generic types. Thus, one may see:\n\nExample: An organization may define discreet staff types (e.g., Pediatric Oncologist, Gerontologist, Oncology Pharmacist, Pediatric Pharmacist, Critical Care Nurse, Nurse Case Manager – Cardiology) as well as broad categories (e.g., Physician, Pharmacist, Nurse, Pediatric, Oncology, Cardiology, Case Management, Nephrology). Employing STF-4 for the discreet terms and STF-39 for the more generic terms allows both the levels of granularity to be apply to the staff without confusing the specific types with generic types. Thus, one may see:\n|===\n|STF-4 |STF-39\n|• Custodian |• Staff\n|• Non-clinical Nursing Supervisor |• Manager\n|• Pediatric Oncologist |• Physician ~ Pediatrics ~ Oncology\n|• Gerontologist |• Physician\n|• Oncology Pharmacist |• Pharmacist ~ Oncology\n|• Pediatric Pharmacist |• Pediatrics ~ Pharmacist\n|• Critical Care Nurse |• Nurse\n|• Nurse Case Manager – Cardiology |• Nurse ~ Cardiology ~ Case Management\n|==="
* 40 0..1 CWE "STF-40" "This field contains the staff member's religion. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70006[_User-defined Table 0006 - Religion_] in Chapter 2C, Code Tables, for suggested values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0006 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #120
* 41 0..1 ED "STF-41" "Digital Signature of the staff member. The Digital Signature includes a seal concept and is verifiable."
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1861