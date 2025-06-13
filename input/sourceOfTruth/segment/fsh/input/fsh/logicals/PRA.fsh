Logical: PRA
Parent: $Segment
Id: PRA
Title: "HL7 v2 PRA Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Practitioner Detail"
* 1 0..1 CWE "PRA-1" "For MFN Master File Notification, this field is required and must match _MFE-4 Primary Key Value_ to identify which entry is being referenced. For all other messages, this field should not be used. Refer to Table 0681 - Primary Key Value - PRA in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0681 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #685
* 2 0..0 CWE "PRA-2" "This field contains the name and/or code of a group of practitioners to which this practitioner belongs. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70358[_User-defined Table 0358 Practitioner Group_] for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0358 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #686
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70358[_User.defined Table 0358 – Practitioner Group_] in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 3 0..0 CWE "PRA-3" "This field contains the category of practitioner. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70186[_User-defined Table 0186 - Practitioner Category_] for suggested values. Values may include codes for staff physician, courtesy physician, resident, physician assistant, physical therapist, psychiatrist, psychologist, pharmacist, registered nurse, licensed practical nurse, licensed vocational nurse, nurse practitioner, etc. If the provider works in different Practitioner Categories in different organization units, then this information should be recorded separately in ORG-6,7,8."
* 3 from http://terminology.hl7.org/ValueSet/v2-0186 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #687
* 3 ^comment = "[#HL70186 .anchor]####Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70186[_User.defined Table 0186 – Practitioner Category_] in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 4 0..1 ID "PRA-4" "This field indicates how provider services are billed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70187[_HL7 Table 0187 - Provider Billing_] for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0187 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #688
* 4 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70187[_HL7 Table 0187 – Provider Billing_] for valid values. This table contains values for provider or institutional billing."
* 5 0..0 SPD "PRA-5" "This repeating field is made up of multiple components to record the practitioner's specialties. The multiple components of each specialty are: (1) specialty name or abbreviation, identifies provider's specialty, (2) name of specialty governing board, (3) Certification Status, (4) certified date contains the date of certification, if certified. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70337[_HL7 Table 0337 – Certification Status_] for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0337 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #689
* 5 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70337[_HL7 Table 0337 – Certification Status_] in Chapter 2C, Code Tables, for valid values. This table contains values for certified or eligible."
* 6 0..0 PLN "PRA-6" "*_As of version 2.5, this field has been retained for backward compatibility only._* Practitioner ID numbers should be contained in _STF-2 Staff Identifier List_. This repeating field contains this practitioner's license numbers and other ID numbers. This is a field made up of the following components: (1) the ID number, and (2) the type of number, and optionally (3) the state or province in which it is valid, if relevant, or other qualifying information. It is recommended that state qualifications use the abbreviations from the postal service of the country. The practitioner ID number type (component 2) is a user-defined table (file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70338[_User-defined Table 0338 – Practitioner ID Number_] in Chapter 2C, Code Tables)."
* 6 from http://terminology.hl7.org/ValueSet/v2-0338 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #B
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #690
* 7 0..0 PIP "PRA-7" "This field contains the institutional privileges which this provider may exercise. Depends upon institutional needs. For example, admit, transfer, discharge, place orders, verify orders, review results, etc. Can also be used for privileges other than patient services. This is a repeating field, with each privilege made up of the following components: (1) privilege; (2) privilege class; (3) privilege expiration date, if any; (4) privilege activation date, if any, and (5) facility. Note that the privilege and privilege class components are CWE data types, and thus they are encoded with the subcomponent delimiter (&) rather than the component delimiter (^). The facility component is an EI data type specifying the facility to which the privilege applies and is encoded with the subcomponent delimiter (&) rather than the component delimiter (^). The facility component is an EI data type specifying the facility to which the privilege applies and is encoded with the subcomponent delimiter (&) rather than the component delimiter (^)."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #691
* 8 0..1 DT "PRA-8" "This field contains the date the practitioner began practicing at the present institution (e.g., at hospital, at physician organization, at managed care network)."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1296
* 9 0..1 CWE "PRA-9" "This field contains the institution the practitioner began or intends to begin practicing at (e.g., at hospital, at physician organization, at managed care network). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70537[_User-defined Table 0537 - Institution_] for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0537 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1613
* 9 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70537[_User-defined Table 0537 – Institution_] in Chapter 2C, Code Tables, for valid values. This table contains no suggested values."
* 10 0..1 DT "PRA-10" "This field contains the date the practitioner ended or intends to end practicing at the given institution (e.g., at hospital, at physician organization, at managed care network)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1348
* 11 0..0 CWE "PRA-11" "This field contains a code that indicates the agency that the practitioner is authorized to bill for medical services. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70401[_User-defined Table 0401 – Government Reimbursement Program_] in Chapter 2C, Code Tables,for valid values. This table contains the associated code values for medicaid and medical. This is a repeating field."
* 11 from http://terminology.hl7.org/ValueSet/v2-0401 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1388
* 12 0..1 SI "PRA-12" "For all messages except the Staff/Practitioner Master File Notification, this field is required and contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc. For the Staff/Practitioner Master File Notification message, this field should not be used."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #C
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 4
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1616