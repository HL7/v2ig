Logical: DRG
Parent: $Segment
Id: DRG
Title: "HL7 v2 DRG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Diagnosis Related Group"
* 1 0..1 CNE "DRG-1" "This field contains the DRG for the transaction. Interim DRG's could be determined for an encounter. Refer to _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70055[Externally-defined Table 0055 – Diagnosis Related G]roup_ in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0055 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #382
* 2 0..1 DTM "DRG-2" "This field contains the time stamp to indicate the date and time that the DRG was assigned."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #769
* 3 0..1 ID "DRG-3" "This field indicates if the DRG has been approved by a reviewing entity. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #383
* 3 ^comment = "Y the DRG has been approved by a reviewing entity\n\nN the DRG has not been approved"
* 4 0..1 CWE "DRG-4" "This code indicates that the grouper results have been reviewed and approved. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70056[_User-defined Table 0056 - DRG Grouper Review Code_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0056 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #384
* 5 0..1 CWE "DRG-5" "Refers to the type of outlier (i.e., period of care beyond DRG-standard stay in facility) that has been paid. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70083[_User-defined Table 0083 - Outlier Type_] in Chapter 2C, code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0083 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #385
* 6 0..1 NM "DRG-6" "This field contains the number of days that have been approved as an outlier payment."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "3"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #386
* 7 0..1 CP "DRG-7" "This field contains the amount of money that has been approved for an outlier payment."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #387
* 8 0..1 CWE "DRG-8" "This field indicates the associated DRG Payor. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70229[_User-defined Table 0229 - DRG Payor_] in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0229 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #770
* 9 0..1 CP "DRG-9" "Where applicable, the outlier reimbursement amount indicates the part of the total reimbursement designated for reimbursement of outlier conditions (day or cost)."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #771
* 10 0..1 ID "DRG-10" "This field indicates if the DRG contains a confidential diagnosis. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #767
* 10 ^comment = "Y the DRG contains a confidential diagnosis\n\nN the DRG does not contain a confidential diagnosis"
* 11 0..1 CWE "DRG-11" "This field indicates the type of hospital receiving a transfer patient, which affects how a facility is reimbursed under diagnosis related group (DRG's), for example, exempt or non-exempt. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70415[_User-defined Table 0415 - DRG Transfer Type_] in Chapter 2C, code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0415 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1500
* 12 0..1 XPN "DRG-12" "This field holds the name of the person (\"coder\") who supervised or undertook the determination of the DRG code."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2156
* 13 0..1 CWE "DRG-13" "This field indicates the grouper status in general. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70734[_Externally-defined Table 0734 - Grouper Status_] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0734 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2157
* 14 0..1 CWE "DRG-14" "This field indicates the PCCL (Patient Clinical Complexity Level) value for the calculated DRG as a single value. This value is calculated based on all individual CCL values calculated so far in relation to the basic DRG. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70728[_Externally-defined Table 0728 - CCL Value_] in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0728 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2158
* 15 0..1 NM "DRG-15" "This field contains the effective weight as calculated for this DRG. When exceeding the upper or lower trim point the effective weight is lower or higher."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "5"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = true
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2159
* 16 0..1 MO "DRG-16" "This field contains the monetary amount as calculated for this DRG, i.e., the sum of money the insurance company will pay."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2160
* 17 0..1 CWE "DRG-17" "This field contains the status of the patient concerning the financial aspects. It indicates whether the length of stay is normal or respectively shorter or longer than normal. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70739[_User-defined Table 0739 – DRG Status Patient_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0739 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2161
* 17 ^comment = "This field is also used along with DRG-23 and DRG-24 as an indication of whether a surcharge (long length of stay) or a discount (short length of stay) has been determined."
* 18 0..1 ST "DRG-18" "This field contains the name of the software used for grouping."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "100"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = true
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2162
* 19 0..1 ST "DRG-19" "This field contains the version information of the software used for grouping."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 19 ^extension[=].extension[0].url = "length"
* 19 ^extension[=].extension[=].valueInteger = "100"
* 19 ^extension[=].extension[+].url = "noTruncate"
* 19 ^extension[=].extension[=].valueInteger = true
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #2282
* 20 0..1 CWE "DRG-20" "This field contains the status of the DRG calculation regarding the financial aspects. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70742[_User-defined Table 0742 – DRG Status Financial Calculation_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0742 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #2163
* 21 0..1 MO "DRG-21" "There will be a discount/surcharge for the calculated price due to a very short stay, early referral or a very long stay. This field contains the discount or surcharge that is included in the final price."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2164
* 22 0..1 MO "DRG-22" "The basic charge is calculated as a multiplication of the relative weight with the base rate."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2165
* 23 0..1 MO "DRG-23" "This field contains the total charge including surcharges or discounts."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2166
* 24 0..1 MO "DRG-24" "This field contains the discount/surcharge as determined for this DRG. The addition/re­duction is indicated by _DRG-17 - Status Patient_."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2167
* 25 0..1 NM "DRG-25" "This field contains the number of days, for which a surcharge/discount has been determined. The addition/reduction is indicated by _DRG-17 - Status Patient_."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 25 ^extension[=].extension[0].url = "length"
* 25 ^extension[=].extension[=].valueInteger = "5"
* 25 ^extension[=].extension[+].url = "noTruncate"
* 25 ^extension[=].extension[=].valueInteger = false
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2168
* 26 0..1 CWE "DRG-26" "This field contains the status of the use of the gender information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70749[_User-defined Table 0749 – DRG Grouping Status_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0749 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2169
* 27 0..1 CWE "DRG-27" "This field contains the status of the use of the age information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70749[_User-defined Table 0749 – DRG Grouping Status_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0749 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2170
* 28 0..1 CWE "DRG-28" "This field contains the status of the DRG calculation for the length of stay information. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70749[_User-defined Table 0749 – DRG Grouping Status_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0749 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2171
* 29 0..1 CWE "DRG-29" "This field contains the status of the use of the same day information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70749[_User-defined Table 0749 – DRG Grouping Status_] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0749 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2172
* 30 0..1 CWE "DRG-30" "This field contains the status of the use of the separation mode information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70749[_User-defined Table 0749 – DRG Grouping Status_] in Chapter 2C, Code Tables, for suggested values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0749 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2173
* 31 0..1 CWE "DRG-31" "This field contains the status of the use of the weight at birth information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70755[_User-defined Table 0755 – DRG Status Weight At Birth_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0755 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2174
* 32 0..1 CWE "DRG-32" "This field contains the status of the use of the respiration minutes information for DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70757[_User-defined Table 0757 – DRG Status Respiration Minutes_] in Chapter 2C, Code Tables, for suggested values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0757 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #2175
* 33 0..1 CWE "DRG-33" "This field contains the admission status for the DRG determination. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70759[_User-defined Table 0759 – Status Admission_] in Chapter 2C, Code Tables, for suggested values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0759 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #2176