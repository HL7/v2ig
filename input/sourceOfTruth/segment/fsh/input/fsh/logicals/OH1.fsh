Logical: OH1
Parent: $Segment
Id: OH1
Title: "HL7 v2 OH1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Person Employment Status"
* 1 1..1 SI "OH1-1" "This field contains the number that identifies the OH1 segment instances in message structures where the OH1 segment repeats. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3516
* 2 0..1 ID "OH1-2" "This field contains a code defining the action to be taken for this segment. It allows this segment to be sent to delete or update, for example, previously sent information. Refer to file:///D:\\Eigene%20Dateien\\2018\\HL7\\Standards\\v2.9%20Jan%202019\\v29%20CH2C%20Table%200206[*_HL7 Table 0206 – Segment Action Code_*] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #816
* 3 1..1 CWE "OH1-3" "This field contains a code defining the employment status of a person during the associated time. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70957[_HL7 Table 0957 – Employment Status (ODH)_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0957 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3518
* 4 0..1 DT "OH1-4" "This field asserts when the employment status began."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3519
* 5 0..1 DT "OH1-5" "This field asserts when the employment status ended. If employment status is current, Employment Status End Date should be empty."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3520
* 5 ^comment = "*Note:* The Employment Status End Date SHALL not be greater than the time the observation is made (OH1-6 Entered Date)."
* 6 1..1 DT "OH1-6" "This field records the date that the information was entered into the patient record."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3521
* 7 0..1 EI "OH1-7" "This field contains a value that uniquely identifies a single employment status for a person."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2432