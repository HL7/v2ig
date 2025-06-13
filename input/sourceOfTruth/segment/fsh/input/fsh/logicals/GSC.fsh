Logical: GSC
Parent: $Segment
Id: GSC
Title: "HL7 v2 GSC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Sex Parameter for Clinical Use"
* 1 1..1 SI "GSC-1" "This field contains the sequence number used to identify the GSC segment instances in a message."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3543
* 2 1..1 ID "GSC-2" "This field contains a code defining the action to be taken for this segment."
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
* 3 0..1 EI "GSC-3" "This field contains the value that uniquely identifies a single GSC declaration for an individual. This field is conditionally required when the Action Code in GSC-2 indicates data is not being sent in Snapshot Mode (valued “S”)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2524
* 4 1..1 CWE "GSC-4" "This field asserts the context-specific categorization of a patient's sex for the purpose of clinical use. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70001[_HL7-defined Table 0828 -_] _Sex Parameter for Clinical Use_ in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0828 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2525
* 5 0..1 DR "GSC-5" "This field asserts the time frame during which this value applies to the patient context. May be just an initial dateTime."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2526
* 6 1..0 ERL "GSC-6" "This field asserts the clinical context(s) relevant for the declared Sex Parameter for Clinical Use value. The ERL data type is used to specify a location in the message which carries the clinical context. For example, GSC-6 may point to procedure (PR1) or order (ORC) segment within the message. This field is allowed to repeat to allow a single declared Sex Parameter for Clinical Use value to be applied to multiple contexts within the message. As well, the GSC segment is allowed to repeat within a message as an individual may have different Sex Parameter for Clinical Use values for different contexts within a single message. The GSC-6 field is required as any Sex Parameter for Clinical Use value declared within a message must relate to at least one context within the same message."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2527
* 7 0..0 ERL "GSC-7" "This field asserts clinical data (e.g. observations, diagnoses) that are used to determine the Sex Parameter for Clinical Use value. The linked information should clearly align with the chosen Sex Parameter for Clinical Use value. This field is allowed to repeat as multiple pieces of clinical data may contribute to the chosen Sex Parameter for Clinical Use value."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2528
* 8 0..1 TX "GSC-8" "This field contains a free text comment pertaining to the Sex Parameter for Clinical Use."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2529