Logical: PRB
Parent: $Segment
Id: PRB
Title: "HL7 v2 PRB Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Problem Detail"
* 1 1..1 ID "PRB-1" "This field contains the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70287[_HL7 Table 0287 – Problem/Goal Action Code_] in Chapter 2C, Code Tables, for valid values."
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
* 2 1..1 DTM "PRB-2" "This field contains the date/time that the operation represented by the action code was performed."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #817
* 3 1..1 CWE "PRB-3" "This field identifies the problem. This is the identifier from an institution's master list of problems."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #838
* 4 1..1 EI "PRB-4" "This field contains the identifier assigned by an initiating system to an instance of a problem."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #839
* 4 ^comment = "*Note:* It is required that this value remain unique over time. This instance ID identifies a specific instance for a specific patient and is unique across all patients. See entity ID data type description in Chapter 2."
* 5 0..1 EI "PRB-5" "This field uniquely identifies the episode of care to which this problem applies. (See note under \"Ongoing issues.\")"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #820
* 5 ^comment = "*Note:* It is required that this field be unique over time."
* 6 0..1 NM "PRB-6" "This field prioritizes this problem on a list that is maintained for the individual."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #841
* 7 0..1 DTM "PRB-7" "This field contains the date/time when the corresponding problem was initially identified by the caregiver."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #842
* 8 0..1 DTM "PRB-8" "This field contains the estimated date/time for resolving the stated problem."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #843
* 9 0..1 DTM "PRB-9" "This field contains the date/time that the problem was actually resolved."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #844
* 10 0..1 CWE "PRB-10" "This field indicates the kind of problem. This field can be used to categorize problems so that they may be managed and viewed independently within different applications (e.g., admission, final, post-operative, pre-operative, outpatient, discharge, etc.)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #845
* 11 0..0 CWE "PRB-11" "This field indicates the category of caregiver with responsibility for managing this specific problem (e.g., care team, nursing, medicine, respiratory therapy, occupational therapy, dietary, etc.). This is a repeating field to allow identification of all disciplines that may have the responsibility for this problem."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #846
* 12 0..1 CWE "PRB-12" "This field contains the perseverance of a problem (e.g., acute, chronic, etc.)."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #847
* 13 0..1 CWE "PRB-13" "This field contains the verification status of a problem (e.g., confirmed, differential, provisional, rule-out, etc.)."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #848
* 14 0..1 CWE "PRB-14" "This field contains the current status of the problem at this particular date/time (e.g., active, active-improving, active-stable, active-worsening, inactive, resolved, etc.)."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #849
* 15 0..1 DTM "PRB-15" "This field indicates the effective date/time of the current problem life cycle status."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #850
* 16 0..1 DTM "PRB-16" "This field contains the date/time when the problem began."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #851
* 17 0..1 ST "PRB-17" "This field allows for a textual representation of the time when the problem began."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "80"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = false
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #852
* 18 0..1 CWE "PRB-18" "This field contains a user-defined prioritization of a problem (e.g., numeric ranking, or the use of words such as \"primary,\" \"secondary,\" etc.)."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #853
* 19 0..1 CWE "PRB-19" "This field contains a qualitative representation of the certainty of a problem (e.g., HI - high, LO - low, ME - medium, etc.)."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #854
* 20 0..1 NM "PRB-20" "This field contains a quantitative or numeric representation of the certainty that the problem exists for this patient. This field has a valid range of 0 to 1. For example, a healthcare provider may be 75% (.75) sure that the problem has been correctly identified."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "4"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = true
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #855
* 20 ^comment = "*Note*: We have provided for two different representations of the certainty of the problem due to varying representations in applications."
* 21 0..1 CWE "PRB-21" "This field contains the individual's comprehension of the problem (e.g., full, marginal, partial, etc.)."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #856
* 22 0..1 CWE "PRB-22" "This field contains the prognosis for the individual's problem (e.g., good, poor, etc.)."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #857
* 23 0..1 CWE "PRB-23" "This field contains the individual's comprehension of the prognosis for the problem (e.g., full, marginal, partial, etc.)."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #858
* 24 0..1 ST "PRB-24" "This field indicates the individual's family or significant other's comprehension of the actual problem/prognosis."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 24 ^extension[=].extension[0].url = "length"
* 24 ^extension[=].extension[=].valueInteger = "200"
* 24 ^extension[=].extension[+].url = "noTruncate"
* 24 ^extension[=].extension[=].valueInteger = false
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #859
* 25 0..1 CWE "PRB-25" "This field contains information about the level of security and/or sensitivity surrounding the problem (e.g., highly sensitive, not sensitive, sensitive, etc.)."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #823
* 26 0..1 CWE "PRB-26" "This field indicates the severity of the Problem. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70836[_User-defined Table 0836- Problem Severity_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0836 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2234
* 27 0..1 CWE "PRB-27" "This field indicates from whose perspective this problem was identified. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70838[_User-defined Table 0838 - Problem Perspective_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0838 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2235
* 28 0..1 CNE "PRB-28" "This field indicates the Mood of the Problem. It allows expression of the context of the problem."
* 28 from http://terminology.hl7.org/ValueSet/v2-0725 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #C
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2237
* 28 ^comment = "*Note:* As Mood Code changes the meaning of the segment it must only be used in new messages as of v2.6.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70725[HL7 Table 0725 - Mood Codes] in Chapter 2C, Code Tables, for allowed values."