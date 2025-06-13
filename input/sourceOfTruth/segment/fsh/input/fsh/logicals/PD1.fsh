Logical: PD1
Parent: $Segment
Id: PD1
Title: "HL7 v2 PD1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Patient Additional Demographic"
* 1 0..0 CWE "PD1-1" "This field identifies specific living conditions (e.g., spouse dependent on patient, walk-up) that are relevant to an evaluation of the patient's healthcare needs. This information can be used for discharge planning. This field repeats because, for example, \"spouse dependent\" and \"medical supervision required\" can apply at the same time. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70223[_User-defined Table 0223 - Living Dependency_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0223 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #755
* 2 0..1 CWE "PD1-2" "This field identifies the situation in which the patient lives at his residential address. Examples might include Alone, Family, Relatives, Institution, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70220[_User-defined Table 0220 - Living Arrangement_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0220 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #742
* 3 0..0 XON "PD1-3" "This field contains the name and identifier that specifies the \"primary care\" healthcare facility selected by the patient at the time of enrolment in an HMO Insurance Plan. Multiple names and identifiers are allowed for the same facility. The legal name of the healthcare facility must be sent in the first sequence. If the legal name of the facility is not sent, then the repeat delimiter must be sent in the first sequence. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70204[_User-defined Table 0204 - Organizational Name Type_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0204 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #756
* 4 0..1 BackboneElement "PD1-4" "*The PD1-4 field was retained for backward compatibility only as of v 2.4 and withdrawn as of v 2.7.* The reader is advised that the PRT segment is now used to convey more complete information about the primary care provider."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #W
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #757
* 5 0..1 CWE "PD1-5" "This field indicates if the patient is currently a student or not, and whether the patient is a full-time or a part-time student. This field does not indicate the student's degree level (high school, college, elementary) or the student's field of study (accounting, engineering, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70231[_User-defined Table 0231 - Student Status_] in chapter 2C, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0231 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #745
* 6 0..1 CWE "PD1-6" "This field indicates the nature of the patient's permanent handicapped condition (e.g., deaf, blind). A handicapped condition is defined as a physical or mental disability that is permanent. Transient handicapped conditions should be sent in the ambulatory status. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70295[_User-defined Table 0295 - Handicap_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0295 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #753
* 7 0..1 CWE "PD1-7" "This field indicates whether or not the patient has a living will and, if so, whether a copy of the living will is on file at the healthcare facility. If the patient does not have a living will, the value of this field indicates whether the patient was provided information on living wills. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70315[_User-defined Table 0315 - Living Will Code_] in Chapter 2C, Code Tables, for suggested values. See also _PV2-43 - Living Will Code_."
* 7 from http://terminology.hl7.org/ValueSet/v2-0315 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #759
* 8 0..1 CWE "PD1-8" "This field indicates whether the patient wants to donate his/her organs and whether an organ donor card or similar documentation is on file with the healthcare organization. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70316[_User-defined Table 0316 - Organ Donor Code_] in Chapter 2C, Code Tables, for suggested values. See also _PV2-44 - Organ donor Code_."
* 8 from http://terminology.hl7.org/ValueSet/v2-0316 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #760
* 9 0..1 ID "PD1-9" "This field specifies that charges for this patient are to be billed separately from other patient bills with the same guarantor. (This bill is now a patient bill rather than a guarantor bill.) Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #761
* 9 ^comment = "Y Bill separately\n\nN normal processing"
* 10 0..0 CX "PD1-10" "This field indicates that a patient is the same as, or a duplicate of, another patient found on the sending system. The intent is to be informational only and no action is required by the receiver. Include the patient identifier if the sender knows an identifier for the patient. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #762
* 11 0..1 CWE "PD1-11" "This field contains a user-defined code indicating what level of publicity is allowed (e.g., No Publicity, Family Only) for the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70215[_User-defined Table 0215 - Publicity Code_] in Chapter 2C, Code Tables, for suggested values. Refer to _PV2-21 - Visit Publicity Code_ for visit level code."
* 11 from http://terminology.hl7.org/ValueSet/v2-0215 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #743
* 12 0..1 ID "PD1-12" "*From V2.6 onward, this field has been retained for backward compatibility only.* Use the ARV segment instead. This field identifies the patient's protection that determines, in turn, whether access to information about this person should be kept from users who do not have adequate authority for the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables, for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #B
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #744
* 12 ^comment = "Y protect access to information\n\nN normal access\n\nRefer to _PV2-22 - Visit Protection Indicator_ for visit level code."
* 13 0..1 DT "PD1-13" "*From v 2.6 onward, this field has been retained for backward compatibility only.* Use the ARV segment instead. This field indicates the effective date for _PD1-12 - Protection Indicator_."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #B
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1566
* 14 0..0 XON "PD1-14" "The patient's place of worship. For example, the patient attends the First Baptist Church of Atlanta."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1567
* 15 0..0 CWE "PD1-15" "This field indicates the patient's instructions to the healthcare facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70435[_User-defined Table 0435 - Advance Directive Code_] in Chapter 2C, Code Tables, for suggested values. See also _PV2-45 - Advance Directive Code_. When _PD1-22 - Advanced Directive Last Verified Date_ is valued, this field is required."
* 15 from http://terminology.hl7.org/ValueSet/v2-0435 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1548
* 16 0..1 CWE "PD1-16" "This field identifies the immunization registry status of the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70441[_User-defined Table 0441 - Immunization Registry Status_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0441 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1569
* 17 0..1 DT "PD1-17" "This field indicates the effective date for the immunization registry status reported in _PD1-16 - Immunization Registry Status_."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1570
* 18 0..1 DT "PD1-18" "This is the effective date for _PD1-11 - Publicity Code_."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1571
* 19 0..1 CWE "PD1-19" "This field is defined by CMS or other regulatory agencies. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70140[_User-defined Table 0140 - Military Service_] in Chapter 2C, Code Tables, for suggested values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0140 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1572
* 20 0..1 CWE "PD1-20" "This user-defined field identifies the military rank/grade of the patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70141[_User-defined Table 0141 - Military Rank/Grade_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0141 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #486
* 21 0..1 CWE "PD1-21" "This field is defined by CMS or other regulatory agencies. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70142[_User-defined Table 0142 - Military Status_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0142 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1573
* 22 0..1 DT "PD1-22" "This field indicates the date that all the advance directives held in _PD1-15 - Advance Directive Code_ were last validated. When this field is valued, the field _PD1-15 - Advance Directive Code_ is required."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2141
* 23 0..1 DT "PD1-23" "This field asserts a self-identified date that an individual considers themselves to have ‘retired’."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #3511