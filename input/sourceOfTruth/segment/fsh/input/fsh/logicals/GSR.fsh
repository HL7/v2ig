Logical: GSR
Parent: $Segment
Id: GSR
Title: "HL7 v2 GSR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Recorded Gender and Sex"
* 1 1..1 SI "GSR-1" "This field contains the sequence number used to identify the GSR segment instances in a message."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3543
* 2 1..1 ID "GSR-2" "This field contains a code defining the action to be taken for this segment."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #816
* 3 0..1 EI "GSR-3" "This field contains the value that uniquely identifies a single GSR declaration for an individual. This field is conditionally required when the Action Code in GSR-2 indicates data is not being sent in Snapshot Mode (valued “S”)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2515
* 4 1..1 CWE "GSR-4" "This field contains the sex or gender property for the individual from a document or other record. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70001[_User-defined Table HL70001 –_] _Administrative Sex_ in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2516
* 5 0..1 CWE "GSR-5" "This field contains the label of the source field on the document. From a data modeling perspective this is similar to the use of GSP-4 (Gender Harmony Concept), when there is a formal definition for the source field, for example in an EHR-s or in an electronic data exchange object. For paper documents this will be just the words and can be represented in any characters set. For example, on a Russian identity card it could be ‘Пол’, which would be populated in the original text component of the CWE datatype. Refer to User-defined table HL7 0824 - _Recorded Sex Or Gender Type_ in Chapter 2 C, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0824 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2517
* 6 0..1 CWE "GSR-6" "This field contains the source document where this sex or gender property is recorded. E.g., national ID card, birth certificate, passport, patient medical record. Refer to User-defined Table _0826 Document Gender Type (for gender uses)_ for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0826 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2519
* 7 0..1 CWE "GSR-7" "This field contains the jurisdiction or organization that issued the document from which the recorded sex or gender was acquired. Refer to _User Defined HL7 Table 0827 – Jurisdiction Gender Type_ in Chapter 2C for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0827 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2520
* 8 0..1 DTM "GSR-8" "This field contains the date/time when the sex or gender value was first recorded in the system."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2521
* 9 0..1 DR "GSR-9" "This field asserts the time period during which the recorded gender or sex value in GSR-4 applies to the individual. May be just a Start Date/Time for values which are still valid."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2522
* 10 0..1 TX "GSR-10" "This field contains a free text explanation about the context or source of the recorded sex or gender value."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2523