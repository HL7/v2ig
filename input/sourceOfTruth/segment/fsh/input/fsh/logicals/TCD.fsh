Logical: TCD
Parent: $Segment
Id: TCD
Title: "HL7 v2 TCD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Test Code Detail"
* 1 1..1 CWE "TCD-1" "This field identifies the test code that information is being transmitted about. Refer to Table 0789 - Universal Service Identifier in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0789 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #238
* 2 0..1 SN "TCD-2" "This field is the value that is to be used as the factor for automatically diluting a particular specimen by an instrument for this particular test code. (See examples in definition of _13.3.3.29_, \"_SAC-29 Dilution Factor_ (SN) 01356,\" in the \"Specimen Container Detail Segment.\")"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1420
* 3 0..1 SN "TCD-3" "This field is the value that is to be used as the factor for automatically diluting a particular specimen in case of rerun for this particular test code."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1421
* 4 0..1 SN "TCD-4" "This field is the value that is to be used as the factor for a particular specimen that is delivered to the automated system as pre-diluted for this particular test code."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1422
* 5 0..1 SN "TCD-5" "This field represents the rest concentration of the measured test in the diluent. It is the value that is to be used for calculation of the concentration of pre-diluted specimens for this particular test code."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1413
* 6 0..1 ID "TCD-6" "This field identifies whether or not automatic repeats are to be initiated for this particular specimen for this particular test code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 -Yes/no Indicator_] for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1416
* 7 0..1 ID "TCD-7" "This field identifies whether or not automatic or manual reflex testing is to be initiated for this particular specimen. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 -Yes/no Indicator_] for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1424
* 8 0..1 CWE "TCD-8" "This field identifies the repeat status for the analyte/result (e.g., original, rerun, repeat, reflex). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70389[_HL7 Table 0389 – Analyte Repeat Status_] in Chapter 2C, Code Tables, for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0389 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1425
* 8 ^comment = "For purpose of this chapter we assume the following:\n\n• Repeated test without dilution — performed usually to confirm correctness of results (e.g., in case of results flagged as \"Panic\" or mechanical failures).\n\n• Repeated test with dilution — performed usually in the case the original result exceeded the measurement range (technical limits).\n\n• Reflex test — this test is performed as the consequence of rules triggered based on other test result(s)."
* 9 0..1 CQ "TCD-9" "The specimen consumption quantity determines how much of the specimen shall be consumed in each run of the test. For some types of equipment, observation accuracy depends on this parameter."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3490
* 10 0..1 NM "TCD-10" "In order submission messages, this field defines the maximal size of the pool where the given specimen may be combined into. In result submission messages, this field defines the actual size of such pool."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3493
* 11 0..1 CWE "TCD-11" "This field contains a vendor-defined code of the auto-dilution factor pre‑configured on the instrument, which can be used instead of TCD‑2 “Auto-Dilution Factor”. Refer to _User-defined Table 0945– Auto Dilution Type_ in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0945 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3494
* 11 ^comment = "If both TCD‑2 “Auto-Dilution Factor” and TCD‑11 “Auto-Dilution Type” are populated, they shall not contradict each other."