Logical: NK1
Parent: $Segment
Id: NK1
Title: "HL7 v2 NK1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Next of Kin / Associated Parties"
* 1 1..1 SI "NK1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #190
* 2 0..0 XPN "NK1-2" "This field contains one or more of the names of the next of kin or associated party. The _XPN.7 Name Type Code_, and not the order, conveys how the name should be interpreted. As of v 2.7 Name Type Code is required. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70200[_HL7 Table 0200 - Name Type_] in Chapter 2C, Code Tables, for valid values. Specification of meaning based on sequence is deprecated."
* 2 from http://terminology.hl7.org/ValueSet/v2-0200 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #191
* 2 ^comment = "In addition to allowing repetition of this field for transmitting multiple names with different Name Type Codes, repetition also allows for representing the same name in different character sets based on the value in _XPN.8 Name Representation Code_."
* 3 0..1 CWE "NK1-3" "This field contains the actual personal relationship that the next of kin/associated party has to the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #192
* 4 0..0 XAD "NK1-4" "This field contains the address of the next of kin/associated party. Multiple addresses are allowed for the same person. As of v2.7 the \"primary mailing address\" constraint as the first sequence has been removed. Primary Mailing Address is not an entry in either _XAD.7 – Address Type_ or in _XAD.18 – Address Usage_."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #193
* 5 0..0 XTN "NK1-5" "NK1-5"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #W
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #194
* 5 ^comment = "*Attention:* The NK1-5 field was retained for backward compatibility as of v2.7 and withdrawn as of v 2.9. The reader is referred to section _3.4.5.40 NK1-40_ instead. This field contains the telephone number of the next of kin/associated party. Multiple phone numbers are allowed for the same person. The primary telephone number must be sent in the first sequence. If the primary telephone number is not sent, then the repeat delimiter must be sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70201[_HL7 Table 0201 - Telecommunication Use Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70202[_HL7 Table 0202 - Telecommunication Equipment Type_] in Chapter 2C, Code Tables, for valid values."
* 6 0..0 XTN "NK1-6" "NK1-6"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #W
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #195
* 6 ^comment = "*Attention:* The NK1-5 field was retained for backward compatibility as of v2.7 and withdrawn as of v 2.9. The reader is referred to section _3.4.5.40 NK1-40_ instead. Multiple phone numbers are allowed for the same person. The primary business telephone number must be sent in the first sequence. If the primary business telephone number is not sent, then the repeat delimiter must be sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70201[_HL7 Table 0201 - Telecommunication Use Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70202[_HL7 Table 0202 - Telecommunication Equipment Type_] in Chapter 2C, Code Tables, for valid values."
* 7 0..1 CWE "NK1-7" "This field indicates the specific relationship role. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70131[_User-defined Table 0131 - Contact Role_] in Chapter 2C, Code Tables, for suggested values. This field specifies the role that the next of kin/associated parties plays with regard to the patient."
* 7 from http://terminology.hl7.org/ValueSet/v2-0131 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #196
* 8 0..1 DT "NK1-8" "This field contains the start date of the contact role."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #197
* 9 0..1 DT "NK1-9" "This field contains the end date of the contact role."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #198
* 10 0..1 ST "NK1-10" "This field contains the title of the next of kin/associated parties at their place of employment. However, if the contact role is the patient's employer, this field contains the job title of the patient at their place of employment."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "60"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = true
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #199
* 11 0..1 JCC "NK1-11" "This field contains the employer's job code and the employee classification used for the next of kin/associated parties at their place of employment. However, if the contact role is the patient's employer, this field contains the job code/class of the patient at their place of employment."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #200
* 11 ^comment = "*Note:* The JCC data element appears in other segments as ITEM# 00786 (GT1-50, IN2-47, STF-19). It is assigned a different ITEM# in the NK1 segment because the element name and usage is variable. For example the job code/class can be for the patient's employer, or for an associated party's employment information."
* 12 0..1 CX "NK1-12" "For backward compatibility, the ST data type can be sent; however, HL7 recommends that the CX data type be used for new implementations. This field contains the number that the employer assigns to the employee that is acting as next of kin/associated parties. However, if the contact role is the patient's employer, this field contains the employee number of the patient at their place of employment. The assigning authority and identifier type codes are strongly recommended for all CX data types."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #201
* 13 0..0 XON "NK1-13" "This field contains the name of the organization that serves as a next of kin/associated party or as the next of kin of the patient. This field may also be used to communicate the name of the organization at which the associated party works. Multiple names for the same organization may be sent. If multiple names are sent, the legal name must be sent in the first sequence. If the legal name is not sent, then a repeat delimiter must be sent in the first sequence."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #202
* 14 0..1 CWE "NK1-14" "This field contains the next of kin/associated party's marital status. Refer to _E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70002[User-defined Table 0002 - Marital Status]_ in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0002 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #119
* 15 0..1 CWE "NK1-15" "This field contains the next of kin/associated party's sex. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70001[_User-defined Table 0001 - Administrative Sex_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #111
* 16 0..1 DTM "NK1-16" "This field contains the next of kin/associated party's birth date and time."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #110
* 17 0..0 CWE "NK1-17" "This field identifies specific living conditions (e.g., spouse dependent on patient, walk-up) that are relevant to an evaluation of the patient's healthcare needs. This information can be used for discharge planning. Examples might include Spouse Dependent, Medical Supervision Required, Small Children Dependent. This field repeats because, for example, \"spouse dependent\" and \"medical supervision required\" can apply at the same time. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70223[_User-defined Table 0223 - Living Dependency_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0223 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #755
* 18 0..0 CWE "NK1-18" "This field identifies the transient rate of mobility for the next of kin/associated party. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70009[_User-defined Table 0009 - Ambulatory Status_] in Chapter 2C, Code Tables for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0009 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #145
* 19 0..0 CWE "NK1-19" "This field contains the code to identify the next of kin/associated party's citizenship. HL7 recommends using ISO 3166 as the suggested values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70171[_User-defined Table 0171 - Citizenship_] in Chapter 2C, Code Tables."
* 19 from http://terminology.hl7.org/ValueSet/v2-0171 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #129
* 20 0..1 CWE "NK1-20" "This field identifies the next of kin/associated party's primary speaking language. HL7 recommends using ISO 639 as the suggested values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70296[_User-defined Table 0296 - Language_] in Chapter 2C, Code Tables."
* 20 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #118
* 21 0..1 CWE "NK1-21" "This field identifies the situation that the associated party lives in at his/her residential address. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70220[_User-defined Table 0220 - Living Arrangement_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0220 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #742
* 22 0..1 CWE "NK1-22" "This field indicates what level of publicity is allowed (e.g., No Publicity, Family Only) for the next of kin/associated party. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70215[_User-defined Table 0215 - Publicity Code_] in Chapter 2C, Code Tables, for suggested values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0215 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #743
* 23 0..1 ID "NK1-23" "This field identifies that next of kin/associated party's protection that determines, in turn, whether access to information about this person should be kept from users who do not have adequate authority. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #744
* 23 ^comment = "Y protect access to next-of-kin information\n\nN normal access"
* 24 0..1 CWE "NK1-24" "This field identifies whether the next of kin/associated party is currently a student or not, and whether the next of kin/associated party is a full- or a part-time student. This field does not indicate the degree (high school, college) of the student or the field of study. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70231[_User-defined Table 0231 - Student Status_] in chapter 2C, for suggested values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0231 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #745
* 25 0..1 CWE "NK1-25" "This field indicates the type of religion practiced by the next of kin/associated party. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70006[_User-defined Table 0006 - Religion_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0006 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #120
* 26 0..0 XPN "NK1-26" "This field indicates the maiden name of the next of kin/associated party's mother."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #109
* 27 0..1 CWE "NK1-27" "This field identifies the nation or national group to which the next of kin/associated party belongs. This information may be different than the person's citizenship in countries in which multiple nationalities are recognized (e.g., Spain: Basque, Catalan, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70212[_User-defined Table 0212 - Nationality_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0212 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #739
* 28 0..0 CWE "NK1-28" "This field contains the next of kin/associated party's ethnic group. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70189[_User-defined Table 0189 - Ethnic Group_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CWE data type for ethnic group (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes. In the US, a current use is to report ethnicity in line with US federal standards for Hispanic origin."
* 28 from http://terminology.hl7.org/ValueSet/v2-0189 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #125
* 29 0..0 CWE "NK1-29" "This field identifies how the contact should be used (e.g., contact employer if patient is unable to work). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70222[_User-defined Table 0222 - Contact Reason_] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0222 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #747
* 30 0..0 XPN "NK1-30" "This field contains one or more of the names of the person to contact, depending on the value of the relationship defined in _NK1-3 - Relationship_. This field is typically needed when the NK1 is an organization. The _XPN.7 Name Type Code_, and not the order, conveys how the name should be interpreted. As of v2.7, Name Type Code is required. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70200[_HL7 Table 0200 - Name Type_] in Chapter 2C, Code Tables, for valid values. Specification of meaning based on sequence is deprecated."
* 30 from http://terminology.hl7.org/ValueSet/v2-0200 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #748
* 30 ^comment = "In addition to allowing repetition of this field for transmitting multiple names with different Name Type Codes, repetition also allows for representing the same name in different character sets based on the value in _XPN.8 Name Representation Code_."
* 31 0..0 XTN "NK1-31" "NK1-31"
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #W
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #749
* 31 ^comment = "*Attention:* The NK1-31 field was retained for backward compatibility as of v2.7 and withdrawn as of v 2.9 The reader is referred to section _3.4.5.41 NK-41 Contact Person’s Telecommunication Information_ instead. This field contains the telephone numbers of the contact person depending on the value of the relationship defined in _NK1-3 - Relationship_. This field is typically needed when the NK1 is an organization. The primary telephone number must be sent in the first sequence. If the primary telephone number is not sent, then a repeat delimiter must be sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70201[_HL7 Table 0201 - Telecommunication Use Code_] and file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70202[_HL7 Table 0202 - Telecommunication Equipment Type_] in Chapter 2C, Code Tables, for valid values."
* 32 0..0 XAD "NK1-32" "This field contains the addresses of the contact person depending on the value of the relationship defined in _NK1-3 - Relationship_. This field is typically used when the NK1 is an organization. As of v2.7, the \"primary mailing address\" constraint as the first sequence has been removed. Primary Mailing Address is not an entry in either _XAD.7 – Address Type_ or in _XAD.18 – Address Usage_."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #750
* 33 0..0 CX "NK1-33" "This field contains the identifiers for the next of kin/associated party, for example, Social Security Number, driver's license, etc. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #751
* 34 0..1 CWE "NK1-34" "This field identifies the next of kin/associated party's job status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70311[_User-defined Table 0311 - Job Status_] in Chapter 2C, Code Tables, for suggested values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0311 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #752
* 35 0..0 CWE "NK1-35" "This field identifies the race of the next of kin/associated party. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70005[_User-defined Table 0005 - Race_] in Chapter 2C, Code Tables, for suggested values. The second triplet of the CWE data type for race (alternate identifier, alternate text, and name of alternate coding system) is reserved for governmentally assigned codes."
* 35 from http://terminology.hl7.org/ValueSet/v2-0005 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #113
* 36 0..1 CWE "NK1-36" "This field contains the code that describes an associated party's disability. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70295[_User-defined Table 0295 - Handicap_] in Chapter 2C, Code Tables, for suggested values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0295 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #753
* 37 0..1 ST "NK1-37" "In the US, this field contains the contact person's social security number. This number may also be a RR retirement number. For the Social Security number of the associated party, see _NK1-33 - Next of Kin/Associated Party's identifiers_."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 37 ^extension[=].extension[0].url = "length"
* 37 ^extension[=].extension[=].valueInteger = "16"
* 37 ^extension[=].extension[+].url = "noTruncate"
* 37 ^extension[=].extension[=].valueInteger = true
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #754
* 38 0..1 ST "NK1-38" "This field indicates the location of the next-of-kin's birth; for example, \"St. Francis Community Hospital of Lower South Side.\" The actual address is reported in _NK1-4 - Address_ with an identifier of \"N\"."
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 38 ^extension[=].extension[0].url = "length"
* 38 ^extension[=].extension[=].valueInteger = "250"
* 38 ^extension[=].extension[+].url = "noTruncate"
* 38 ^extension[=].extension[=].valueInteger = true
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1905
* 39 0..1 CWE "NK1-39" "This field identifies the type of VIP for the next-of-kin. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70099[_User-defined Table 0099 – VIP Indicator_] in Chapter 2C, Code Tables."
* 39 from http://terminology.hl7.org/ValueSet/v2-0099 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #146
* 40 0..1 XTN "NK1-40" "This field contains the next of kin’s telecommunication contact information. This field replaces _NK1-5 – Phone Number_ and _NK1-6 – Business Phone Number_ with the intention that the components of the XTN data type be used to identify phone usage (Telecommunication use code) and type of equipment (telecommunication equipment type). Jointly, these components will describe the nature of the telecommunication data contained in this field."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #2292
* 41 0..1 XTN "NK1-41" "This field contains the contact person’s telecommunication contact information. This field replaces _NK1-31 – Contact Person’s Telephone Number_ with the intention that the components of the XTN data type be used to identify phone usage (Telecommunication use code) and type of equipment (telecommunication equipment type). Jointly, these components will describe the nature of the telecommunication data contained in this field."
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #2293