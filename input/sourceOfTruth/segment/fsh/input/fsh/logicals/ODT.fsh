Logical: ODT
Parent: $Segment
Id: ODT
Title: "HL7 v2 ODT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "diet tray instructions"
* 1 1..1 CWE "ODT-1" "This field defines the type of dietary tray. Refer To file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70160[HL7 Table 0160 - Tray Type] in Chapter 2C, Code Tables, for valid entries."
* 1 from http://terminology.hl7.org/ValueSet/v2-0160 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #273
* 1 ^comment = "Tray specifications are useful for early and late tray delivery in cases where a patient undergoes a procedure during normal feeding times. Tray specifications can also be used for guest trays, no trays, and messages. The value MSG means the ODT segment does not specify the type of tray but provides additional information about an existing tray. This information is found in ODT-3-text instruction."
* 2 0..10 CWE "ODT-2" "When blank, the modifier applies to all service periods. This field allows you to designate one or more of the feeding periods during a day by combining the codes as needed. It can also combine with quantity/timing to give such information as which service period the order belongs with. This field is identical in meaning with ODS-2-service period. See section _4.8.1.2_, \"_ODS-2 Service Period_ (CWE) 00270,\" for further details. Refer to Table 0629 - Service Period in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0629 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #270
* 3 0..1 ST "ODT-3" "This field defines instructions associated with the tray. Example:"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "80"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #272
* 3 ^comment = "|PLASTIC SILVERWARE|."