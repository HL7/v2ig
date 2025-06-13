Logical: PSG
Parent: $Segment
Id: PSG
Title: "HL7 v2 PSG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Product/Service Group"
* 1 1..1 EI "PSG-1" "Unique Product/Service Group Number assigned by the Provider Application."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1950
* 2 0..1 EI "PSG-2" "Unique Product/Service Group Number assigned by the Payer Application"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1951
* 3 1..1 SI "PSG-3" "Unique sequence number for the Product/Service Group (3) – starts with 1, then 2, etc. for each unique Product/Service Group in this Invoice."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 4
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1952
* 4 1..1 ID "PSG-4" "Adjudicate all Product/Service Line Items together as a group (IPRs will be reported against the Product/Service Group). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1953
* 5 1..1 CP "PSG-5" "Sum of all Product/Service Billed Amounts for all Product/Service Line Items for this Product/Service Group."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1954
* 6 1..1 ST "PSG-6" "Product/Service Group description or heading"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "254"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = true
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2044