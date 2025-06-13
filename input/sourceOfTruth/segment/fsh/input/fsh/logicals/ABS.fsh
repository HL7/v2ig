Logical: ABS
Parent: $Segment
Id: ABS
Title: "HL7 v2 ABS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Abstract"
* 1 0..1 XCN "ABS-1" "Identification number of the provider responsible for the discharge of the patient from his/her care. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70010[_User-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1514
* 2 0..1 CWE "ABS-2" "Medical code representing the patient's medical services when they are transferred. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70069[_User-defined Table 0069 - Hospital Service_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0069 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1515
* 3 0..1 CWE "ABS-3" "Code representing the ranking of a patient's illness. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70421[_User-defi__ned Table 0421 - Severity of Ill__ness Code_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0421 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1516
* 4 0..1 DTM "ABS-4" "Date/time that the medical record was reviewed and accepted."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1517
* 5 0..1 XCN "ABS-5" "Identification number of the person (usually a provider) who reviewed and accepted the abstract of the medical record."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1518
* 6 0..1 CWE "ABS-6" "Code representing a patient's prioritization within the context of this abstract. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70422[_User-defined Table 0422 - Triage Code_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0422 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1519
* 7 0..1 DTM "ABS-7" "Date/time the abstraction was completed."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1520
* 8 0..1 XCN "ABS-8" "Identification number of the person completing the Abstract."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1521
* 9 0..1 CWE "ABS-9" "Code indicating the reason a non-urgent patient presents to the Emergency Room for treatment instead of a clinic or physician office. Refer to E:\\\\V2\\\\V29_CH02C_Tables.docx#HL70423[_User-defined Table 0423 - Case Category Code_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0423 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1522
* 10 0..1 ID "ABS-10" "Indicates if the delivery was by Caesarian Section. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1523
* 10 ^comment = "Y Delivery was by Caesarian Section.\n\nN Delivery was not by Caesarian Section."
* 11 0..1 CWE "ABS-11" "The gestation category code is used to indicate the status of the birth in relation to the gestation. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70424[_User-defined Table 0424 - Gestation Category Code_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0424 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1524
* 12 0..1 NM "ABS-12" "Newborn's gestation period expressed as a number of weeks."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "3"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1525
* 13 0..1 CWE "ABS-13" "The newborn code is used to indicate whether the baby was born in or out of the facility. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70425[_User-defined Table 0425 - Newborn Code_] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0425 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1526
* 14 0..1 ID "ABS-14" "Indicates whether or not a newborn was stillborn. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^extension[=].extension[+].url = "max"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1527
* 14 ^comment = "Y Stillborn.\n\nN Not stillborn."