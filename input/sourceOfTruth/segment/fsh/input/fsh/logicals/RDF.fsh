Logical: RDF
Parent: $Segment
Id: RDF
Title: "HL7 v2 RDF Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Table Row Definition"
* 1 1..1 NM "RDF-1" "This field specifies the number of data columns (and therefore the number of fields) contained within each row of returned data."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "3"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #701
* 2 1..0 RCD "RDF-2" "Each repetition of this field consists of three components:"
* 2 from http://terminology.hl7.org/ValueSet/v2-0440 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #702
* 2 ^comment = "The segment field name that identifies the field occupying the column. The segment field name SHALL agree with the column name as it appears in the Query Profile. Use of the @ sign as prefix to the column name is optional.\n\nThe 2 or 3 character HL7 data type, as defined in Chapter 2. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70440[_HL7 Table 0440 – Data types_] in Chapter 2C, Code Tables, for valid values.\n\nThe maximum width of the column, as dictated by the responding system. (This may vary from the HL7-defined maximum field length.)"