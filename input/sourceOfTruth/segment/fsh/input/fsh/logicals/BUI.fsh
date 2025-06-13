Logical: BUI
Parent: $Segment
Id: BUI
Title: "HL7 v2 BUI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Blood Unit information"
* 1 0..1 SI "BUI-1" "This field contains a sequence number. When multiple BUI segments are included in the same segment group, this number differentiates between them."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3373
* 2 1..1 EI "BUI-2" "The blood unit identifier is a unique identifier assigned to the particular blood unit in a container."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #3374
* 3 1..1 CWE "BUI-3" "The type of blood unit. For donations, this is the type blood unit being described. This element defines which of the types from the referenced table are being described. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70566[HL7-Defined Table 0566 – Blood Unit Type] in Chapter 2C, Code Tables, for valid entries."
* 3 from http://terminology.hl7.org/ValueSet/v2-0566 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3375
* 4 1..1 NM "BUI-4" "The weight of the blood unit collected, not including the weight of the container."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3376
* 5 1..1 CNE "BUI-5" "The unit of measure for the weight of the blood unit. Concepts are pulled from the UCUM code system (_http://www.unitsofmeasure.org[www.unitsofmeasure.org])._ Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70929[_HL7-Defined Table 0929 – Weight Units_] in Chapter 2C, Code Tables, for valid entries."
* 5 from http://terminology.hl7.org/ValueSet/v2-0929 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3377
* 6 1..1 NM "BUI-6" "The volume of the blood unit collected."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3378
* 7 1..1 CNE "BUI-7" "The unit of measure for the volume of the blood unit. Concepts are pulled from the UCUM code system (_http://www.unitsofmeasure.org[www.unitsofmeasure.org])._ Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70930[HL7-Defined Table 0930 – Volume Units] in Chapter 2C, Code Tables, for valid entries."
* 7 from http://terminology.hl7.org/ValueSet/v2-0930 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3379
* 8 1..1 ST "BUI-8" "The string catalog number of the blood unit container, which includes a specific container code to identify a collection bag."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #3380
* 9 1..1 ST "BUI-9" "The lot number for the collection bag container as assigned by the container manufacturer."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #R
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3381
* 10 1..1 XON "BUI-10" "The organization which manufactured the collection bag container."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #R
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3382
* 11 1..1 NR "BUI-11" "The temperature range between which the blood unit must be kept during transport."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3383
* 12 1..1 CNE "BUI-12" "The unit of measure of the transport temperature range. Concepts are pulled from the UCUM code system (_http://www.unitsofmeasure.org[www.unitsofmeasure.org])._ Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70931[HL7-Defined Table 0931 – Temperature Units] in Chapter 2C, Code Tables, for valid entries."
* 12 from http://terminology.hl7.org/ValueSet/v2-0931 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #R
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3384
* 13 0..1 ID "BUI-13" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #816
* 13 ^comment = "The action code can only be used when an BUI is uniquely identified sufficiently within the specific implementation using BUI-2 in accordance with Chapter 2, Section 2.10.4.2"