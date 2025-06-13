Logical: PID
Parent: $Segment
Id: PID
Title: "HL7 v2 PID Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Patient Identification"
* 1 0..1 SI "PID-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #104
* 2 0..1 BackboneElement "PID-2" "PID-2"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #W
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #105
* 2 ^comment = "*Attention:* The PID-2 field was retained for backward compatibility only as of v2.3.1 and was withdrawn and removed from this message structure as of v2.7. It is recommended to use _PID-3 - Patient Identifier List_ for all patient identifiers."
* 3 1..0 CX "PID-3" "This field contains the list of identifiers (one or more) used by the healthcare facility to uniquely identify a patient (e.g., medical record number, billing number, birth registry, national unique individual identifier, etc.). In Canada, the Canadian Provincial Healthcare Number should be sent in this field. The arbitrary term of \"internal ID\" has been removed from the name of this field for clarity."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #106
* 4 0..1 BackboneElement "PID-4" "PID-4"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #W
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #107
* 4 ^comment = "*Attention:* The PID-4 field was retained for backward compatibility only as of v2.3.1 and was withdrawn and removed from this message structure as of v2.7. It is recommended to use _PID-3 - Patient Identifier List_ for all patient identifiers."
* 5 1..0 XPN "PID-5" "This field contains one or more of the names of the patient. The XPN.7 Name Type Code, and not the order, conveys how the name should be interpreted. As of v2.7, Name Type Code is Required. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70200[_HL7 Table 0200 - Name_ _Type_] in Chaper 2C, Code Tables, for valid values. Specification of meaning based on sequence is deprecated."
* 5 from http://terminology.hl7.org/ValueSet/v2-0200 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #108
* 5 ^comment = "In addition to allowing repetition of this field for transmitting multiple names with different Name Type Codes, repetition also allows for representing the same name in different character sets based on the value in XPN.8 Name Representation Code.\n\nIn order to support “name to use” to indicate how to address the patient, when that does not match their legal name, include an occurrence of Patient Name (PID-5), where the nametype code (PID-5.7) is valued ‘N’.Multiple given names and/or initials are separated by spaces.\n\nFor animals, if a Name Type of \"R\" is used, use \"Name Context\" to identify the authority with which the animal's name is registered."
* 6 0..0 XPN "PID-6" "This field contains the family name under which the mother was born (i.e., before marriage). It is used to distinguish between patients with the same last name."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #109
* 7 0..1 DTM "PID-7" "This field contains the patient's date and time of birth."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #110
* 8 0..1 CWE "PID-8" "This field contains the patient's sex. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70001[_User-defined_ _Table 0001 -_ _Administrative Sex_] in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #111
* 8 ^comment = "This field has historically been used to variably exchange both sex and gender values and therefore this field is not clearly defined. This field is expected to continue to be used as it has been in existing implementations and use of this field is subject to local existing interpretation and/or implementation guides. The GSP and GSR segments should be used to exchange more rigorously defined sex or gender concept."
* 9 0..1 BackboneElement "PID-9" "PID-9"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #W
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #112
* 9 ^comment = "*Attention:* The PID-9 field was retained for backward compatibility only as of v2.4 and was withdrawn and removed from this message structure as of v2.7. it is recommended to use _PID-5 - Patient Name_ for all patient names."
* 10 0..0 CWE "PID-10" "This field refers to the patient's race. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70005[_User-defined Table 0005 -_ _Race_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CWE data type for race (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes."
* 10 from http://terminology.hl7.org/ValueSet/v2-0005 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #113
* 11 0..0 XAD "PID-11" "This field contains the address of the patient. Multiple addresses for the same person may be sent. As of v2.7 the \"primary mailing address\" constraint as the first sequence has been removed..."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #114
* 12 0..1 BackboneElement "PID-12" "PID-12"
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #W
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #115
* 12 ^comment = "*Attention:* The PID-12 field was retained for backward compatibility only as of v2.3 and was withdrawn and removed from this message structure as of v2.7. The county can now be supported in the county/parish code component of the XAD data type (_PID-11 - Patient Address_)."
* 13 0..0 XTN "PID-13" "PID-13"
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #W
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #116
* 13 ^comment = "*Attention:* The PID13 field has been retained for backward compatibility as of v 2.7 and withdrawn as of v 2.9. The reader is referrred to section _3.4.2.40_, _PID-40 – Patient Telecommunication Information_ instead, which replaces _PID-13 – Phone Number - Home_ with the intention that the components of the XTN data type be used to identify phone usage (Telecommunication use code) and type of equipment (telecommunication equipment type).\n\nThis field contains the patient's personal phone numbers. All personal phone numbers for the patient are sent in the following sequence. The first sequence is considered the primary number (for backward compatibility). If the primary number is not sent, then a repeat delimiter is sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70201[_HL7 Table 0201 - Telecommunication Use Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70202[_HL7 Table 0202 - Telecommunication Equipment Type_] in Chapter 2C, Code Tables, for valid values."
* 14 0..0 XTN "PID-14" "PID-14"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #W
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #117
* 14 ^comment = "*Attention:* The PID-14 field has been retained for backward compatibility only as of v2.7 and withdrawn as of v 2.9.. The reader is referred to section _3.4.2.40_, _PID-40 – Patient Telecommunication Information_ instead, which replaces _PID-14 – Phone Number - Business_ with the intention that the components of the XTN data type be used to identify phone usage (Telecommunication use code) and type of equipment (telecommunication equipment type).\n\nThis field contains the patient's business telephone numbers. All business numbers for the patient are sent in the following sequence. The first sequence is considered the patient's primary business phone number (for backward compatibility). If the primary business phone number is not sent, then a repeat delimiter must be sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70201[_HL7 Table 0201 - Telecommunication Use Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70202[_HL7 Table 0202 - Telecommunication Equipment Type_] in Chapter 2C, Code Tables, for valid values."
* 15 0..1 CWE "PID-15" "This field contains the patient's primary language. HL7 recommends using ISO table 639 as the suggested values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70296[_User-defined Table 0296 - Primary Language_] within Chapter 2C, Code Tables."
* 15 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #118
* 16 0..1 CWE "PID-16" "This field contains the patient's marital (civil) status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70002[_User-defined Table 0002 - Marital Status_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0002 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #119
* 17 0..1 CWE "PID-17" "This field contains the patient's religion. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70006[_User-defined Table 0006 - Religion_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0006 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #120
* 18 0..1 CX "PID-18" "This field contains the patient account number assigned by accounting to which all charges, payments, etc., are recorded. It is used to identify the patient's account. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] in Chapter 2C, Code Tables, for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #121
* 19 0..1 BackboneElement "PID-19" "PID-19"
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #W
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #122
* 19 ^comment = "*Attention:* The PID-19 field was retained for backward compatibility only as of v 2.3.1 and was withdrawn and removed from this message structure as of v 2.7. It is recommended to use _PID-3 - Patient Identifier List_ for all patient identifiers."
* 20 0..1 BackboneElement "PID-20" "PID-20"
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #W
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #123
* 20 ^comment = "*Attention:* The PID-20 field was retained for backward compatibility only as of v 2.5 and was withdrawn and removed from this message structure as of v 2.7. It is recommended to use _PID-3 - Patient Identifier List_ for all patient identifiers."
* 21 0..0 CX "PID-21" "This field is used, for example, as a link field for newborns. Typically a patient ID or account number may be used. This field can contain multiple identifiers for the same mother. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] in Chapter 2C, Code Tables, for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #124
* 22 0..0 CWE "PID-22" "This field further defines the patient's ancestry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70189[_User-defined Table 0189 - Ethnic Group_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CWE data type for ethnic group (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes. In the US, a current use is to report ethnicity in line with US federal standards for Hispanic origin."
* 22 from http://terminology.hl7.org/ValueSet/v2-0189 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #125
* 23 0..1 ST "PID-23" "This field indicates the location of the patient's birth, for example \"St. Francis Community Hospital of Lower South Side\". The actual address is reported in PID-11 with an identifier of \"N\"."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "250"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = true
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #126
* 24 0..1 ID "PID-24" "This field indicates whether the patient was part of a multiple birth. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^extension[=].extension[+].url = "max"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #127
* 24 ^comment = "Y the patient was part of a multiple birth\n\nN the patient was a single birth"
* 25 0..1 NM "PID-25" "When a patient was part of a multiple birth, a value (number) indicating the patient's birth order is entered in this field."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 25 ^extension[=].extension[0].url = "length"
* 25 ^extension[=].extension[=].valueInteger = "2"
* 25 ^extension[=].extension[+].url = "noTruncate"
* 25 ^extension[=].extension[=].valueInteger = false
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #128
* 26 0..0 CWE "PID-26" "PID-26"
* 26 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #129
* 26 ^comment = "This field contains the information related to a person's country citizenship. For country citizenship HL7 recommends using ISO table 3166. For a local definition, file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70171[_User-defined Table 0171 - Citizenship_] in Chapter 2C, Code Tables, should be used.\n\nThis field repeats since persons can be citizens of more than one country. The Name of Coding System component(s) of the CWE datatype should be used to identify the table from which citizenship membership is drawn.\n\nIn the Netherlands, this field is used for \"Nationaliteit\"."
* 27 0..1 CWE "PID-27" "This field contains the military status assigned to a veteran. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70172[_User-defined Table 0172 - Veterans Military Status_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0172 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #130
* 28 0..1 BackboneElement "PID-28" "PID-28"
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #W
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #739
* 28 ^comment = "*Attention:* The PID-28 field was retained for backward compatibility only as of v 2.4 and was withdrawn and removed from this message structure as of v 2.7. It is recommended to refer to _PID-10 - Race_, _PID-22 - Ethnic group_ and _PID-26 - Citizenship_."
* 29 0..1 DTM "PID-29" "This field contains the date and time at which the patient death occurred."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #740
* 30 0..1 ID "PID-30" "This field indicates whether the patient is deceased. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 30 ^extension[=].extension[0].url = "min"
* 30 ^extension[=].extension[=].valueInteger = 1
* 30 ^extension[=].extension[+].url = "max"
* 30 ^extension[=].extension[=].valueInteger = 1
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #741
* 30 ^comment = "Y the patient is deceased\n\nN the patient is not deceased"
* 31 0..1 ID "PID-31" "This field indicates whether or not the patient's/person's identity is known. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 31 ^extension[=].extension[0].url = "min"
* 31 ^extension[=].extension[=].valueInteger = 1
* 31 ^extension[=].extension[+].url = "max"
* 31 ^extension[=].extension[=].valueInteger = 1
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1535
* 31 ^comment = "Y the patient's/person's identity is unknown\n\nN the patient's/person's identity is known"
* 32 0..0 CWE "PID-32" "This field contains a coded value used to communicate information regarding the reliability of patient/person identifying data transmitted via a transaction. Values could indicate that certain fields on a PID segment for a given patient/person are known to be false (e.g., use of default or system-generated values for Date of Birth or Social Security Number). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70445[_User-defined Table 0445 - Identity Reliability Code_] in Chapter 2C, Code Tables, for suggested values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0445 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1536
* 33 0..1 DTM "PID-33" "This field contains the last update date and time for the patient's/person's identifying and demographic data, as defined in the PID segment. Receiving systems will use this field to determine how to apply the transaction to their systems. If the receiving system (such as an enterprise master patient index) already has a record for the person with a later last update date/time, then the EMPI could decide not to apply the patient's/person's demographic and identifying data from this transaction."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1537
* 34 0..1 HD "PID-34" "This field identifies the facility of the last update to a patient's/person's identifying and demographic data, as defined in the PID segment. Receiving systems or users will use this field to determine how to apply the transaction to their systems. If the receiving system (such as a hospital's patient management system) already has a record for the patient/person, then it may decide to only update its data if the source is a \"trusted\" source. A hospital might consider other hospitals trusted sources, but not \"trust\" updates from non-acute care facilities. For example:"
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1538
* 34 ^comment = "...|GOOD HEALTH Hospital|..."
* 35 0..1 CWE "PID-35" "A code representing the taxonomic classification (e.g. species and/or breed) of an organism. This may include the common or scientific name in the description component, based on the coding system(s) used. SNOMED-CT is the recommended coding system. If this field is not valued, a human is assumed. If the specificity of the coding system is insufficient to represent the organism to the degree desired, the most detailed coded value available may be used in this field and additional information sent in the text field, _PID-37 – Strain_."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1539
* 35 ^comment = "For example:\n\n...|L-80700^Canine, NOS^SNM3|...\n\n...|L-80100^Bovine^SNM3|...\n\n...|L-80A00^Feline^SNM3|..."
* 36 0..1 CWE "PID-36" "*From v 2.8 onward, this field has been retained for backward compatibility only.* The specific breed of animal. This field, unlike Species and Strain is specific to animals and cannot be generally used for all living organisms. SNOMED is the recommended coding system. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70447[_User-defined Table 0447 - Breed Code_] in Chapter 2C, Code Tables, for suggested values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0447 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #B
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #1540
* 36 ^comment = "Conditionality Rule: This field must be valued if _PID-37 - Strain_ is valued.\n\nFor example, (showing primary and alternative coding systems, using locally defined \"American Kennel Club\" nomenclature):\n\n...|L-80733^ Staffordshire bull terrier^SNM3^^American Staffordshire Terrier^99AKC|...\n\n...|L-80900^Weimaraner^SNM3|...\n\n...|L-80439^Peruvian Paso Horse^SNM3|..."
* 37 0..1 ST "PID-37" "This field contains the specific strain of animal. It can also be expanded to include strain of any living organism and is not restricted to animals."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 37 ^extension[=].extension[0].url = "length"
* 37 ^extension[=].extension[=].valueInteger = "80"
* 37 ^extension[=].extension[+].url = "noTruncate"
* 37 ^extension[=].extension[=].valueInteger = false
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1541
* 37 ^comment = "Example:\n\n...|DeKalb|...\n\n...|Balb/c|...\n\n...|DXL|..."
* 38 0..2 CWE "PID-38" "This field contains the code and/or text indicating the primary use for which the living subject was bred or grown. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70429[_User-defined Table 0429 - Production Class Code_] in Chapter 2C, Code Tables, for suggested values. For example:"
* 38 from http://terminology.hl7.org/ValueSet/v2-0429 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1542
* 38 ^comment = "...|DA^Dairy^L|...\n\n...|MT^Meat^L|...\n\n...|RA^Racing^L|..."
* 39 0..0 CWE "PID-39" "PID-39"
* 39 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1840
* 39 ^comment = "This field contains the information related to a person's tribal citizenship. For tribal citizenship, in the United States, HL7 recommends using the Bureau of Indian Affairs (BIA) Tribal Identity List. For a local definition, file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70171[_User-defined Table 0171 - Citizenship_] in Chapter 2C, Code Tables should be used.\n\nThis field repeats since persons can have tribal membership(s) and can be members of more than one tribe. The Name of Coding System component(s) of the CWE datatype should be used to identify the table from which tribal membership is drawn."
* 40 0..0 XTN "PID-40" "This field contains the patient's personal telecommunication contact information. This field replaces _PID-13 – Phone Number - Home_ and _PID-14 – Phone Number – Business_ with the intention that the components of the XTN data type be used to identify phone usage (Telecommunication use code) and type of equipment (telecommunication equipment type). Jointly, these components will describe the nature of the telecommunication data contained in this field and removes the sequenced-based assumptions in PID-13 and PID-14."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #2289