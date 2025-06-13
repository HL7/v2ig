Logical: OMC
Parent: $Segment
Id: OMC
Title: "HL7 v2 OMC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Supporting Clinical Information"
* 1 0..1 NM "OMC-1" "This field contains the same value as the sequence number of the associated OM1 segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 0..1 ID "OMC-2" "  This field indicates whether this repetition of the segment is being added, changed or deleted.  When using dynamic update mode (See Chapter 2, Section 2.23.4.2, \"Action code/unique identifier mode update definition.\")  OMC-2 and OMC-3 Segment Unique Key are used to establish the \"unique key\" and to determine the data subject to the action. Refer to HL7 Table 0206 – Segment action code for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C(R/X)
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #763
* 2 ^comment = "If the transaction uses dynamic/action code messaging, the field must be valued. \n\nCondition Predicate: Required if OMC-3 is valued."
* 3 0..1 EI "OMC-3" "This field contains a unique identifier for one of the multiple repetitions of this segment, to be used in conjunction with the preceding field. Each of the repetitions of the segment will be uniquely identified by this unique key field for the purposes of updates."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C(R/X)
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #764
* 3 ^comment = "Condition Predicate: Required if OMC-2 is valued."
* 4 1..1 CWE "OMC-4" "This field contains a variable that the diagnostic service needs to interpret the results of an ordered study. Where the observations specified here should be sent is specified in the OMC-6 (Communication Location). Refer to Table 0664 - Clinical Information Request in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0664 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3444
* 5 1..0 CWE "OMC-5" "This field indicates by when in the ordering process or workflow this information must be collected. Limit indicates must be done by X point in the workflow. Refer to _HL7 Table 0938 – Collection Even/Process Step Limit_ for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0938 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3445
* 6 1..1 CWE "OMC-6" "This field indicates where in the message this information is expected to be communicated, e.g. PID, OBR, and SPM). Refer to _HL7 Table 0939 – Communication Loction_ for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0939 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3446
* 7 0..1 ID "OMC-7" "Must the question be answered, or just displayed and can be blank. Refer to _HL7 Table 0136 – Yes/no Indicator_ for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3447
* 7 ^comment = "Y Answer must be provided\n\nN Answer not required"
* 8 0..1 ST "OMC-8" "This field gives guidance to the provider on how to answer the question."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #3448
* 9 0..1 ID "OMC-9" "This field contains the allowed datatype for answers, and is drawn from file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70125[HL7 Table 0125 – Value Type] for valid values. Type of answers include: numeric, date, coded, text, etc."
* 9 from http://terminology.hl7.org/ValueSet/v2-0125 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3449
* 10 0..1 ID "OMC-10" "This field indicates if multiple answers are allowed, which may impact EHR system display and selection functionality. Refer to _HL7 Table 0136 – Yes/no Indicator_ for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3450
* 10 ^comment = "Y Multiple Answers Allowed\n\nN Single Answer only Allowed"
* 11 0..0 CWE "OMC-11" "Allowed coded answers to be sent in HL7 file (CWE.1) and/or display Text for Ordering system to present to provider (CWE.2). Refer to Table 0665 - Answer Choices in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0665 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3451
* 11 ^comment = "The condition is valued only if OMC-9 is valued 'CWE' or 'CNE'."
* 12 0..1 NM "OMC-12" "Total number of characters allowed. Required for numeric and (long) text answers."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3452
* 12 ^comment = "The field is valued only if OMC-9 is valued 'NM', 'SN', 'ST\", 'TX', or 'FT'."
* 13 0..1 NM "OMC-13" "For numeric answers the number of digits after the decimal."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3453
* 13 ^comment = "The field is valued only if OMC-9 is valued 'NM' or 'SN'."