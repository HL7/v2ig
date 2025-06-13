Logical: OM3
Parent: $Segment
Id: OM3
Title: "HL7 v2 OM3 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Categorical Service/Test/Observation"
* 1 0..1 NM "OM3-1" "This field contains the same value as the sequence number of the associated OM1 segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 0..1 CWE "OM3-2" "This field contains the observations whose categorical responses are taken from a specified table of codes (e.g., CWE data types). Record the preferred coding system for these responses as observations (e.g., ICD10, HGVS, ISCN, SNOMED CT). Refer to Table 0650 - Preferred Coding System in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0650 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #636
* 3 0..0 CWE "OM3-3" "This field contains a list of valid coded answers. In the case that the list of coded answers is easily enumerated, list the valid coded answers for this observation here using the preferred coding system given in _OM3-2 - Preferred Coding System_. If, for example, the given observation was VDRL, the valid answers might be \"non-reactive\", \"86^ intermediate\", and \"87^ reactive\".Refer to Table 0652 - Valid Coded \"Answers\" in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0652 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #637
* 4 0..0 CWE "OM3-4" "Certain observations/tests with a nature code of A or C (see _OM1-18 - Nature of Service/Test/Observation_) have text (alpha) results (e.g., reactive, nonreactive). Alpha normals for those tests should be entered in this field (e.g., \"nonreactive\"). Refer to Table 0654 - Normal Text/Codes for Categorical Observations in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0654 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #638
* 4 ^comment = "The format of this field is:\n\nThe first component is a code taken from a standard code source list. The second component is the text associated with the code. The third component is the identification of the code table source. When only a text description of a possible answer is available, it is recorded as ^<text>.\n\nCare should be taken to transmit only those results that are considered normal for that test. A drug screen may have possible results of \"negative\" and \"positive.\" However, only a result of \"negative\" is considered to be normal. When an observation has more than one \"normal\" result, multiple values in this field should be separated with a repeat delimiter."
* 5 0..0 CWE "OM3-5" "This field contains the list of the text answers that are abnormal for the test. Refer to Table 0655 - Abnormal Text/Codes for Categorical Observations in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0655 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #639
* 6 0..0 CWE "OM3-6" "This field contains the list of coded results that are critically abnormal for this observation. Refer to Table 0656 - Critical Text/Codes for Categorical Observations in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0656 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #640
* 7 0..1 ID "OM3-7" "This field contains the allowed data type for a single categorical observation (code A or C in _OM1-18 - Nature of Observation_). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70125[HL7 Table 0125 – Value Type] in Chapter 2C, Code Tables, for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0125 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 2
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 3
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #570