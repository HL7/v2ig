Logical: OM6
Parent: $Segment
Id: OM6
Title: "HL7 v2 OM6 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Observations that are Calculated from Other Observations"
* 1 0..1 NM "OM6-1" "This field contains the same value as the sequence number of the associated OM1 segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 0..1 TX "OM6-2" "This field is used when there are patient variables that are derived from one or more other patient variables (e.g., creatinine clearance, ideal weight, maximum daily temperature, average glucose, framingham risk). This field contains the rules for deriving the value of this variable (i.e., nature code C, as given in _OM1-18 - Nature of Service/Test/Observation_). These can be described in terms of humanly understandable formulas or descriptions."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #657
* 2 ^comment = "When possible, however, they should be defined in terms of the Arden Syntax for specifying selection and transcendative functions and algebraic operations, ASTM E1460-92. Derivation rules that are represented in Arden Syntax should begin and end with an Arden slot delimiter (;;). Within this syntax, variables should be identified by _OM1-2 - Producer's Service/Test/Observation ID_. We recommend the use of the Arden Syntax because it permits the unambiguous specification of most such derived values and is a published standard for medical logic modules."