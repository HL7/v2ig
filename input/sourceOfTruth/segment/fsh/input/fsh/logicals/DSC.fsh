Logical: DSC
Parent: $Segment
Id: DSC
Title: "HL7 v2 DSC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Continuation Pointer"
* 1 0..1 ST "DSC-1" "This field contains the continuation pointer. In an initial query, this field is not present. If the responder returns a value of delete indicator or not present, then there is no more data to fulfill any future continuation requests. For use with continuations of unsolicited messages, see chapter 5 and section _2.9.2_, \"_Continuation messages and segments_.\" Note that continuation protocols work with both display- and record-oriented messages."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "180"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #14
* 2 0..1 ID "DSC-2" "Indicates whether this is a fragmented message (see Section _2.9.2_, \"_Continuation messages and segments_\"), or if it is part of an interactive continuation message (see Section 5.6.3, \"Interactive continuation of response messages\")."
* 2 from http://terminology.hl7.org/ValueSet/v2-0398 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1354
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70398[_HL7 Table 0398 – Continuation Style Code_] in Chapter 2C, Code Tables, for valid values."