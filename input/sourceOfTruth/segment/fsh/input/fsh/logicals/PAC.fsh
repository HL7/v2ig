Logical: PAC
Parent: $Segment
Id: PAC
Title: "HL7 v2 PAC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Shipment Package"
* 1 1..1 SI "PAC-1" "This field contains the sequence number. This field is used to identify PAC segment instances in message structures where the PAC segment repeats"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2350
* 2 0..1 EI "PAC-2" "The Package ID uniquely identifies this package from all other packages within its shipment."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2351
* 2 ^comment = "Condition: If _SHP-8 Number of Packages in Shipment_ is greater then 1, then Package ID must be valued."
* 3 0..1 EI "PAC-3" "The parent package id identifies the package which contains this package. This is used to link a nested set of packages. For instance a shipping container may itself contain several smaller packages. These contained packages would identify the shipping container as their parent package. Multiple layers of nested packaging can be documented in this fashion."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2352
* 4 0..1 NA "PAC-4" "The position in parent package field is used when it is important to communicate specifically where in the parent package this package resides. Each position is identified with a position number. The NA (numeric array) data type is used to allow, if necessary, to transfer multiple axis information, e.g., 2-dimensional tray (X^Y)."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2353
* 5 1..1 CWE "PAC-5" "The package type field identifies the type of container. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70908[_User-defined Table 0908 – Package Type_] for values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0908 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2354
* 6 0..0 CWE "PAC-6" "The package condition field describes the condition of the package at the time of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70544[_HL7 Table 0544 – Container Condition_] for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0544 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2355
* 7 0..0 CWE "PAC-7" "This describes how the package needs to be handled during transport. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[_User-defined Table 0376 – Special Handling Code_] for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2356
* 8 0..0 CWE "PAC-8" "This field contains any known or suspected hazards associated with this package, e.g., exceptionally infectious agent or blood from a hepatitis patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70489[_User-defined Table 0489 – Risk Codes_] for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0489 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2357
* 9 0..1 ID "PAC-9" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #816
* 9 ^comment = "The action code can only be used when PAC-2 is valued in accordance with the guidance in Chapter 2, Section 2.10.4.2."