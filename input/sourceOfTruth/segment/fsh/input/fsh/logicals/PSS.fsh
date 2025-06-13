Logical: PSS
Parent: $Segment
Id: PSS
Title: "HL7 v2 PSS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Product/Service Section"
* 1 1..1 EI "PSS-1" "Unique Product/Service Section Number assigned by the Provider Application."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1946
* 2 0..1 EI "PSS-2" "Unique Product/Service Section Number assigned by the Payer Application."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1947
* 3 1..1 SI "PSS-3" "Unique sequence number for the Product/Service Section (3) – starts with 1, then 2, etc. for each unique Product/Service Section in this Invoice."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 4
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1948
* 4 1..1 CP "PSS-4" "Sum of all Product/Service Billed Amounts for all Product/Service Line Items for this Product/Service Section."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1949
* 5 1..1 ST "PSS-5" "Section description or heading."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "254"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2043