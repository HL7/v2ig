Logical: OH4
Parent: $Segment
Id: OH4
Title: "HL7 v2 OH4 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Combat Zone Work"
* 1 1..1 SI "OH4-1" "This field contains the sequence number used to identify the OH4 segment instances in message structures where the OH4 segment repeats. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3543
* 2 0..1 ID "OH4-2" "This field contains a code defining the action to be taken for this segment. It allows this segment to be sent to delete or update, for example, previously sent information. Refer to file:///D:\\Eigene%20Dateien\\2018\\HL7\\Standards\\v2.9%20Jan%202019\\v29%20CH2C%20Table%200206[*_HL7 Table 0206 – Segment Action Code_*] in Chapter 2C, Code Tables, for valid values."
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
* 3 1..1 DT "OH4-3" "This field asserts when the combat zone duty began."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3544
* 4 0..1 DT "OH4-4" "OH4-4"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3545
* 5 0..1 DT "OH4-5" "This field records the date that the information was entered into the patient record."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3524
* 6 0..1 EI "OH4-6" "This field contains a value the uniquely identifies a single combat zone for a person."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2449