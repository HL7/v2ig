Logical: GT1
Parent: $Segment
Id: GT1
Title: "HL7 v2 GT1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Guarantor"
* 1 1..1 SI "GT1-1" "_GT1-1 - Set ID_ contains a number that identifies this transaction. For the first occurrence of the segment the sequence shall be 1, for the second occurrence it shall be 2, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #405
* 2 0..0 CX "GT1-2" "This field contains the primary identifier, or other identifiers, assigned to the guarantor. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #406
* 3 1..0 XPN "GT1-3" "This field contains the name of the guarantor. Multiple names for the same guarantor may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #407
* 3 ^comment = "Beginning with version 2.3, if the guarantor is an organization, send a Delete Indication value (\"\") in link:#gt1-3-guarantor-name-xpn-00407[_GT1-3 - Guarantor Name_] and put the organization name in link:#gt1-21-guarantor-organization-name-xon-00425[_GT1-21 - Guarantor Organization Name_]. Either guarantor name or guarantor organization name is required."
* 4 0..0 XPN "GT1-4" "This field contains the name of the guarantor's spouse. Multiple names for the same guarantor spouse may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #408
* 5 0..0 XAD "GT1-5" "This field contains the guarantor's address. Multiple addresses for the same person may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #409
* 6 0..0 XTN "GT1-6" "This field contains the guarantor's home phone number. All personal phone numbers for the guarantor may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated. ."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #410
* 7 0..0 XTN "GT1-7" "This field contains the guarantor's business phone number. All business phone numbers for the guarantor may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #411
* 8 0..1 DTM "GT1-8" "This field contains the guarantor's date of birth."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #412
* 9 0..1 CWE "GT1-9" "This field contains the guarantor's gender. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70001[_User-defined Table 0001 - Administrative Sex_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #413
* 9 ^comment = "This field has historically been used to variably exchange both sex and gender values and therefore this field is not clearly defined. This field is expected to continue to be used as it has been in existing implementations and use of this field is subject to local existing interpretation and/or implementation guides. The GSP and GSR segments should be used to exchange more rigorously defined sex or gender concept."
* 10 0..1 CWE "GT1-10" "This field indicates the type of guarantor, e.g., individual, institution, etc. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70068[_User-defined Table 0068 - Guarantor Type_] in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0068 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #414
* 11 0..1 CWE "GT1-11" "This field indicates the relationship of the guarantor with the patient, e.g., parent, child, etc. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #415
* 12 0..1 ST "GT1-12" "This field contains the guarantor's social security number."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "11"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #416
* 13 0..1 DT "GT1-13" "This field contains the date that the guarantor becomes responsible for the patient's account."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #417
* 14 0..1 DT "GT1-14" "This field contains the date that the guarantor stops being responsible for the patient's account."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #418
* 15 0..1 NM "GT1-15" "This field is used to determine the order in which the guarantors are responsible for the patient's account."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^extension[=].extension[+].url = "max"
* 15 ^extension[=].extension[=].valueInteger = 2
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #419
* 15 ^comment = "\"1\" = primary guarantor\n\n\"2\" = secondary guarantor, etc."
* 16 0..0 XPN "GT1-16" "This field contains the name of the guarantor's employer, if the employer is a person. When the guarantor's employer is an organization, use link:#gt1-51-guarantor-employers-organization-name-xon-01299[_GT1-51 - Guarantor Employer's Organization Name_]. Multiple names for the same person may be sent in this field, not multiple employers. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #420
* 17 0..0 XAD "GT1-17" "This field contains the guarantor's employer's address. Multiple addresses for the same employer may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #421
* 18 0..0 XTN "GT1-18" "This field contains the guarantor's employer's phone number. Multiple phone numbers for the same employer may be sent in this field. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated. ."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #422
* 19 0..0 CX "GT1-19" "This field contains the guarantor's employee number. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #423
* 20 0..1 CWE "GT1-20" "This field contains the code that indicates the guarantor's employment status. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70066[_User-Defin__ed Table 0066 - Employment Status_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0066 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #424
* 21 0..0 XON "GT1-21" "This field contains the name of the guarantor when the guarantor is an organization. Multiple names for the same guarantor may be sent in this field, not multiple guarantors. .Specification of meaning based on sequence is deprecated"
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #425
* 21 ^comment = "Beginning with version 2.3, if the guarantor is a person, send a Delete Indication value (\"\") in link:#gt1-21-guarantor-organization-name-xon-00425[_GT1-21 - Guarantor Organization Name_] and put the person name in link:#gt1-3-guarantor-name-xpn-00407[_GT1-3 - Guarantor Name_]. Either guarantor person name or guarantor organization name is required."
* 22 0..1 ID "GT1-22" "Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values. This field indicates whether or not a system should suppress printing of the guarantor's bills."
* 22 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #773
* 22 ^comment = "Y a system should suppress printing of guarantor's bills\n\nN a system should not suppress printing of guarantor's bills"
* 23 0..1 CWE "GT1-23" "This field contains the guarantor's credit rating. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70341[_User-defined Table 0341 - Guarantor Credit Rating Code_] in Chapter 2C, Code Tables, for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0341 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #774
* 24 0..1 DTM "GT1-24" "This field is used to indicate the date and time at which the guarantor's death occurred."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #775
* 25 0..1 ID "GT1-25" "This field indicates whether or not the guarantor is deceased. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #776
* 25 ^comment = "Y the guarantor is deceased\n\nN the guarantor is living"
* 26 0..1 CWE "GT1-26" "This field contains user-defined codes that indicate which adjustments should be made to this guarantor's charges. For example, when the hospital agrees to adjust this guarantor's charges to a sliding scale. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70218[_User-defined Table 0218 - Patient Charge Adjustment_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0218 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #777
* 26 ^comment = "Example: This field would contain the value used for sliding-fee scale processing."
* 27 0..1 CP "GT1-27" "This field contains the combined annual income of all members of the guarantor's household."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #778
* 28 0..1 NM "GT1-28" "This field specifies the number of people living at the guarantor's primary residence."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 28 ^extension[=].extension[0].url = "length"
* 28 ^extension[=].extension[=].valueInteger = "3"
* 28 ^extension[=].extension[+].url = "noTruncate"
* 28 ^extension[=].extension[=].valueInteger = false
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #779
* 29 0..0 CX "GT1-29" "This is a code that uniquely identifies the guarantor's employer when the employer is a person. It may be a user-defined code or a code defined by a government agency (Federal Tax ID#)."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #780
* 29 ^comment = "When further breakdowns of employer information are needed, such as a division or plant, it is recommended that the coding scheme incorporate the relationships (e.g., define separate codes for each division). The assigning authority and identifier type code are strongly recommended for all CX data types."
* 30 0..1 CWE "GT1-30" "This field contains the marital status of the guarantor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70002[_User-defined Table 0002 - Marital Status_] in Chapter 2C, Code Tables, for suggested values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0002 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #781
* 31 0..1 DT "GT1-31" "This field contains the date that the guarantor's employment began."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #782
* 32 0..1 DT "GT1-32" "This field indicates the date on which the guarantor's employment with a particular employer ended."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #783
* 33 0..1 CWE "GT1-33" "Identifies the specific living conditions of the guarantor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70223[_User-defined Table 0223 - Living Dependency_] in Chapter 2C, Code Tables, for suggested values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0223 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #755
* 34 0..0 CWE "GT1-34" "Identifies the transient state of mobility for the guarantor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70009[_User-defined Table 0009 - Ambulatory Status_] in Chapter 2C, Code Tables, for suggested values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0009 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #145
* 35 0..0 CWE "GT1-35" "This field contains the code to identify the guarantor's citizenship. HL7 recommends using ISO table 3166 as the suggested values in file:///E:\\V2\\V29_CH02C_Tables.docx#HL70171[_User-defined Table 0171 - Citizenship_] in Chapter 2C, Code Tables."
* 35 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #129
* 36 0..1 CWE "GT1-36" "This field identifies the guarantor's primary speaking language. HL7 recommends using ISO table 639 as the suggested values in _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70296[User-defined Table 0296 - Primary Language]_ defined in Chapter 2C, Code Tables."
* 36 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #118
* 37 0..1 CWE "GT1-37" "This field identifies the situation in which the person lives at his residential address. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70220[_User-defined Table 0220 - Living Arrangement_] in Chapter 2C, Code Tables, for suggested values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0220 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #742
* 38 0..1 CWE "GT1-38" "This field contains a user-defined code indicating what level of publicity is allowed (e.g., No Publicity, Family Only) for a guarantor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70215[_User-defined Table 0215 - Publicity Code_] in Chapter 2C, Code Tables, for suggested values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0215 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #743
* 39 0..1 ID "GT1-39" "This field identifies the guarantor's protection, which determines whether or not access to information about this enrollee should be restricted from users who do not have adequate authority. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 39 ^extension[=].extension[0].url = "min"
* 39 ^extension[=].extension[=].valueInteger = 1
* 39 ^extension[=].extension[+].url = "max"
* 39 ^extension[=].extension[=].valueInteger = 1
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #744
* 39 ^comment = "Y restrict access\n\nN do not restrict access"
* 40 0..1 CWE "GT1-40" "This field indicates whether the guarantor is currently a student, and whether the guarantor is a full-time or part-time student. This field does not indicate the degree level (high school, college) of the student, or his/her field of study (accounting, engineering, etc.). Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70231[_User-defined Table 0231- Student Status_] in Chapter 2C, Code Tables, for suggested values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0231 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #745
* 41 0..1 CWE "GT1-41" "This field indicates the type of religion practiced by the guarantor. Refer to _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70006[User-defined Table 0006 - Religion]_ in Chapter 2C, Code Tables, for suggested values."
* 41 from http://terminology.hl7.org/ValueSet/v2-0006 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #120
* 42 0..0 XPN "GT1-42" "This field indicates the guarantor's mother's maiden name."
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #109
* 43 0..1 CWE "GT1-43" "This field contains a code that identifies the nation or national grouping to which the person belongs. This may be different from a person's citizenship in countries in which multiple nationalities are recognized (for example, Spain: Basque, Catalan, etc.). HL7 recommends using ISO table 3166 as suggested values in _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70212[User-defined Table 0212 - Nationality]_ in Chapter 2C, Code Tables."
* 43 from http://terminology.hl7.org/ValueSet/v2-0212 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #739
* 44 0..0 CWE "GT1-44" "This field contains the guarantor's ethnic group. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70189[_User-defined Table 0189 - Ethnic Group_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CE data type for ethnic group (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes. In the US, a current use is to report ethnicity in line with US federal standards for Hispanic origin."
* 44 from http://terminology.hl7.org/ValueSet/v2-0189 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #125
* 45 0..0 XPN "GT1-45" "This field contains the name of the person who should be contacted regarding the guarantor bills, etc. This may be someone other than the guarantor. (E.g., Contact guarantor's wife regarding all bills - guarantor lives out of country.)"
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #748
* 45 ^comment = "This is a repeating field that allows for multiple names for the same person. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 46 0..0 XTN "GT1-46" "This field contains the telephone number of the guarantor (person) to contact regarding guarantor bills, etc. Multiple phone numbers for that person may be sent in this sequence. As of v 2.7, no assumptions can be made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #749
* 47 0..1 CWE "GT1-47" "This field contains a user-defined code that identifies the reason for contacting the guarantor, for example, to phone the guarantor if payments are late. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70222[_User-defined Table 0222 - Contact reason_] in Chapter 2C, Code Tables, for suggested values."
* 47 from http://terminology.hl7.org/ValueSet/v2-0222 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #747
* 48 0..1 CWE "GT1-48" "Identifies the guarantor relationship to the contact person specified above. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values. Examples include wife, attorney, power of attorney, self, and organization."
* 48 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #784
* 49 0..1 ST "GT1-49" "This field contains a descriptive name of the guarantor's occupation (e.g., Sr. Systems Analyst, Sr. Accountant)."
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 49 ^extension[=].extension[0].url = "length"
* 49 ^extension[=].extension[=].valueInteger = "20"
* 49 ^extension[=].extension[+].url = "noTruncate"
* 49 ^extension[=].extension[=].valueInteger = true
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #785
* 50 0..1 JCC "GT1-50" "This field contains the guarantor's job code and employee classification."
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #786
* 51 0..0 XON "GT1-51" "This field contains the name of the guarantor's employer when the guarantor's employer is an organization. When the guarantor's employer is a person, use link:#gt1-16-guarantor-employer-name-xpn-00420[_GT1-16 - Guarantor Employer Name_]. Multiple names for the same guarantor may be sent in this field Specification of meaning based on sequence is deprecated."
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #1299
* 52 0..1 CWE "GT1-52" "This field contains a code to describe the guarantor's disability. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70295[_User-defined Table 0295 - Handicap_] in Chapter 2C, Code Tables, for suggested values."
* 52 from http://terminology.hl7.org/ValueSet/v2-0295 (required)
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #753
* 53 0..1 CWE "GT1-53" "This field contains a code that identifies the guarantor's current job status. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70311[_User-defined Table 0311 - Job Status_] in Chapter 2C, Code Tables, for suggested values."
* 53 from http://terminology.hl7.org/ValueSet/v2-0311 (required)
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #752
* 54 0..1 FC "GT1-54" "This field contains the financial class (FC) assigned to the guarantor for the purpose of identifying sources of reimbursement. It can be different than that of the patient. When the FC of the guarantor is different than the FC of the patient, and the guarantor's coverage for that patient has been exhausted, the source of reimbursement falls back onto the FC of the patient."
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #1231
* 55 0..0 CWE "GT1-55" "This field refers to the guarantor's race. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70005[_User-defined Table 0005 - Race_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CE data type for race (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes."
* 55 from http://terminology.hl7.org/ValueSet/v2-0005 (required)
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #1291
* 56 0..1 ST "GT1-56" "This field contains the description of the guarantor's birth place, for example \"St. Francis Community Hospital of Lower South Side.\" The actual address is reported in link:#gt1-5-guarantor-address-xad-00409[_GT1-5 – Guarantor Address_] with an identifier of \"N\"."
* 56 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 56 ^extension[=].valueCode = #O
* 56 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 56 ^extension[=].extension[0].url = "length"
* 56 ^extension[=].extension[=].valueInteger = "100"
* 56 ^extension[=].extension[+].url = "noTruncate"
* 56 ^extension[=].extension[=].valueInteger = true
* 56 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 56 ^code.code = #1851
* 57 0..1 CWE "GT1-57" "This field identifies the type of VIP for the guarantor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70099[_User-defined Table 0099 – VIP Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 57 from http://terminology.hl7.org/ValueSet/v2-0099 (required)
* 57 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 57 ^extension[=].valueCode = #O
* 57 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 57 ^code.code = #146