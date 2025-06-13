Logical: OH3
Parent: $Segment
Id: OH3
Title: "HL7 v2 OH3 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Usual Work"
* 1 1..1 SI "OH3-1" "This field contains the sequence number used to identify the OH3 segment instances in message structures where the OH3 segment repeats. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc. If the subject of the OH3 segment changes (e.g. Patient vs Next of Kin) the Set ID sequence will be reset."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3535
* 2 0..1 ID "OH3-2" "This field contains a code defining the action to be taken for this segment. It allows this segment to be sent to delete or update, for example, previously sent information. Refer to file:///D:\\Eigene%20Dateien\\2018\\HL7\\Standards\\v2.9%20Jan%202019\\v29%20CH2C%20Table%200206[HL7 Table 0206 – Segment Action Code] in Chapter 2C, Code Tables, for valid values."
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
* 3 1..1 CWE "OH3-3" "This field contains a code defining the occupation a person has held for the longest time during his or her life, regardless of the occupation currently held and regardless of whether or not it has been continuous time. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70958[_HL7 Table 0958 – Occupation Code_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Occupation CDC Census 2010 codes published at https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.7186"
* 3 from http://terminology.hl7.org/ValueSet/v2-0958 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3537
* 4 1..1 CWE "OH3-4" "This field contains a code defining the industry a person has worked in for the longest time while in the usual occupation. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70955[_HL7 Table 0955 – Industry Code_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Industry CDC Census 2010 codes published at https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.7187"
* 4 from http://terminology.hl7.org/ValueSet/v2-0955 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3538
* 5 0..1 NM "OH3-5" "This field asserts the number of years that the person has been working in the usual occupation. Decimals shall be used to indicate a duration shorter than 1 year."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3539
* 6 0..1 DT "OH3-6" "This field identifies the year that the person began work in their usual occupation."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3540
* 7 0..1 DT "OH3-7" "This field records the date that the information was entered into the patient record."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3542
* 8 0..1 EI "OH3-8" "This field contains a value the uniquely identifies a single work for a person."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2446