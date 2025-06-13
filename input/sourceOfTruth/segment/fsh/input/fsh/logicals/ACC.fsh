Logical: ACC
Parent: $Segment
Id: ACC
Title: "HL7 v2 ACC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:35Z"
* . ^short = "Accident"
* 1 0..1 DTM "ACC-1" "This field contains the date/time of the accident."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #527
* 2 0..1 CWE "ACC-2" "This field contains the type of accident. Refer to _file:///E:\\V2\\V29_CH02C_Tables.docx#HL70050[User-defined Table 0050 - Accident Code]_ in Chapter 2C, Code Tables, for suggested values. ICD accident codes are recommended."
* 2 from http://terminology.hl7.org/ValueSet/v2-0050 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #528
* 3 0..1 ST "ACC-3" "This field contains the location of the accident."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "25"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #529
* 4 0..1 CWE "ACC-4" "*_As of Version 2.5, this field has been retained for backward compatibility only._* *_Use_* __link:\\l[ACC-11 - Accident Address] *instead of this field, *__as the state in which the accident occurred is part of the address. This field specifies the state in which the auto accident occurred. (CMS 1500 requirement in the US.) Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70347[_User-defined Table 0347 - State/Province_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0347 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #B
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #812
* 5 0..1 ID "ACC-5" "This field indicates if the accident was related to a job. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 5 ^extension[=].extension[0].url = "min"
* 5 ^extension[=].extension[=].valueInteger = 1
* 5 ^extension[=].extension[+].url = "max"
* 5 ^extension[=].extension[=].valueInteger = 1
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #813
* 5 ^comment = "Y the accident was job related\n\nN the accident was not job related"
* 6 0..1 ID "ACC-6" "This field indicates whether or not a patient has died as a result of an accident. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #814
* 6 ^comment = "Y the patient has died as a result of an accident\n\nN the patient has not died as a result of an accident"
* 7 0..1 XCN "ACC-7" "This field identifies the person entering the accident information."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #224
* 8 0..1 ST "ACC-8" "Description of the accident."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "1000"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1503
* 9 0..1 ST "ACC-9" "This field identifies the person or organization that brought in the patient."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "80"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1504
* 10 0..1 ID "ACC-10" "This field indicates if the police were notified. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1505
* 10 ^comment = "Y the police were notified\n\nN the police were not notified."
* 11 0..1 XAD "ACC-11" "This field contains the address where the accident occurred."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1853
* 12 0..1 NM "ACC-12" "This field conveys the amount to which the patient is found to be liable for an accident. The numeric value is given as a percentage value."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "3"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = true
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2374
* 12 ^comment = "If the accident is totally caused by others this value is set to \"0\". If it is caused by the patient, it is set to \"100\". Any other value in between allows for a leverage of the fault between the patient and third parties."
* 13 0..0 EI "ACC-13" "This field contains the identifier of the accident report assigned by a jurisdiction that is required in the insurance accident claim."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3338