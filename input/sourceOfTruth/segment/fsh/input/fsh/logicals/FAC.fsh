Logical: FAC
Parent: $Segment
Id: FAC
Title: "HL7 v2 FAC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Facility"
* 1 1..1 EI "FAC-1" "This field contains the facility identifier."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1262
* 2 0..1 ID "FAC-2" "This field contains the type of facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70331[_HL7 Table 0331 - Facility Type_] for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0331 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1263
* 3 1..0 XAD "FAC-3" "This field contains the facility's address."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1264
* 4 1..1 XTN "FAC-4" "This field contains the facility's telecommunication information."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1265
* 5 0..0 XCN "FAC-5" "This field contains the primary contact person's name."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1266
* 6 0..0 ST "FAC-6" "This field contains the primary contact person's title."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "60"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1267
* 7 0..0 XAD "FAC-7" "This field contains the primary contact person's address."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1166
* 8 0..0 XTN "FAC-8" "This field contains the primary contact person's telecommunication information."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1269
* 9 1..0 XCN "FAC-9" "This field contains the name of the individual with signature authority or who is responsible for the report."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #R
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1270
* 10 0..1 ST "FAC-10" "This field contains the title of the individual with signature authority or who is responsible for this report."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "199"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1271
* 11 0..0 XAD "FAC-11" "This field contains the address of the individual with signature authority or who is responsible for this report."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1272
* 12 0..1 XTN "FAC-12" "This field contains the telecommunication information of the individual with signature authority of who is responsible for this report."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1273