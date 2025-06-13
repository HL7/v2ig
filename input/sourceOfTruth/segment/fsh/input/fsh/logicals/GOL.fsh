Logical: GOL
Parent: $Segment
Id: GOL
Title: "HL7 v2 GOL Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Goal Detail"
* 1 1..1 ID "GOL-1" "The action code field gives the intent of the problem or goal. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70287[_HL7 Table 0287 – Problem/Goal Action Co__de_] in Chapter 2C, Code Tables, for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0287 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2534
* 2 1..1 DTM "GOL-2" "This field contains the date/time that the operation represented by the action code was performed."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #817
* 3 1..1 CWE "GOL-3" "This field identifies the goal. This is the identifier from an institution's master list of goals."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #818
* 4 1..1 EI "GOL-4" "This field contains the unique identifier assigned by an initiating system to this instance of the goal."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #819
* 4 ^comment = "*Note:* It is required that the value in this field be unique over time. This instance ID identifies a specific instance for a specific patient and is unique across all patients. See entity ID data type description in Chapter 2."
* 5 0..1 EI "GOL-5" "This field uniquely identifies the episode of care to which this goal applies. See note under \"Ongoing issues.\""
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #820
* 5 ^comment = "*Note*: Based on application use, this field is required to be unique over time."
* 6 0..1 NM "GOL-6" "This field prioritizes this goal on a list that is maintained for an individual."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "3"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #821
* 7 0..1 DTM "GOL-7" "This field identifies the date/time when the stated goal was initially created."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #822
* 8 0..1 DTM "GOL-8" "This field contains the projected date/time for achieving the stated goal."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #824
* 9 0..1 CWE "GOL-9" "This field indicates the kind of goal. This field can be used to categorize goals so that they may be managed and viewed independently within different applications (e.g., admission, final, post-operative, pre-operative, outpatient, discharge, etc.)."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #825
* 9 ^comment = "*Note:* This field can be used to differentiate separate goal lists that may be managed independently within applications."
* 10 0..1 CWE "GOL-10" "This field indicates the category of caregiver with responsibility for managing this specific goal (e.g., care team, nursing, medicine, respiratory therapy, occupational therapy, dietary etc.). This is a repeating field to allow identification of all disciplines that may have the responsibility for this goal."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #826
* 11 0..1 CWE "GOL-11" "This field contains the current point in the continuum of a goal review cycle (e.g., due, initiated, reviewed, overdue, verified, etc.)."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #827
* 12 0..1 DTM "GOL-12" "This field contains the date/time of the current review of the goal."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #828
* 13 0..1 DTM "GOL-13" "This field contains the date/time of the next scheduled goal review."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #829
* 14 0..1 DTM "GOL-14" "This field contains the date/time that the goal was reviewed prior to the current review."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #830
* 15 0..1 BackboneElement "GOL-15" "GOL-15"
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #W
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #831
* 15 ^comment = "*_As of Version 2.5, this field was retained for backward compatibility only and withdrawn and removed as of v2.7._* Refer to the TQ1 segment described in Chapter 4."
* 16 0..1 CWE "GOL-16" "This field provides an indicator of progress towards achievement of the goal (e.g., achieved, ahead of schedule, delayed, failed to achieve, etc.)."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #832
* 17 0..0 ST "GOL-17" "This field contains the comments associated with the goal evaluation. Examples of comments that might be entered in this field include: a reason for delay in achieving goal, or a clinical footnote about progress made towards the goal, etc."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "300"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = false
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #833
* 18 0..1 CWE "GOL-18" "This field contains an indication of the state of the goal (e.g., Active, Canceled, Inactive, Suspended, etc.)."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #834
* 19 0..1 DTM "GOL-19" "This field contains the effective date/time of the current goal life cycle status."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #835
* 20 0..0 CWE "GOL-20" "This field contains the individual/group for whom the goal has been established (e.g., family group, family member, patient, etc.)."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #836
* 20 ^comment = "*Note*: This field is focused on a specific person/group that is directly patient-related."
* 21 0..0 XPN "GOL-21" "This field contains the identification of the person(s) on whom the goal is focused. This is a repeating field which allows for the identification of a group of individuals."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #837
* 22 0..1 CNE "GOL-22" "This field indicates the Mood of the Goal. It allows expression of the context of the problem."
* 22 from http://terminology.hl7.org/ValueSet/v2-0725 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2182
* 22 ^comment = "*Note:* As Mood Code changes the meaning of the segment it must only be used in new messages as of v2.6.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70725[_HL7 Table 0725 – Mood Codes_] in Chapter 2C, Code Tables, for allowed values."