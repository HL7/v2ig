Logical: QRI
Parent: $Segment
Id: QRI
Title: "HL7 v2 QRI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Query Response Instance"
* 1 0..1 NM "QRI-1" "This field contains a numeric value indicating the match weight or confidence level associated with the record."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "10"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = true
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1436
* 1 ^comment = "Example: |0.88| or |12.32|\n\nOne use of this optional field is in Patient Look-up transactions where the searching system employs a numeric algorithm for determining potential matches to patient/person look-ups."
* 2 0..0 CWE "QRI-2" "This field contains a coded value indicating what search components (e.g., name, birth date, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels. In short, it provides a method for passing a descriptive indication of why a particular record was found."
* 2 from http://terminology.hl7.org/ValueSet/v2-0392 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 2
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 2
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1437
* 2 ^comment = ".Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70392[_User-defined Table 0392 – Match reason_] in Chapter 2C, Code Tables, for suggested values."
* 3 0..1 CWE "QRI-3" "This field contains a text value indicating the name or identity of the specific search algorithm to which the _RCP-5 Search confidence threshold_ and the _QRI-1 Candidate confidence_ refer. Note that there are sometimes significant differences among the algorithms in their numeric scales (e.g., one is 0-100, another might be 10 – 20) as well as their meanings of the same value (two algorithms with an 80% match might not return the same records). Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70393[User-defined Table 0393 – Match algorithms]_ in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0393 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1438
* 3 ^comment = "Example: |MATCHWARE_1.2^^HL70393| or |LINKSOFT_2.01^^HL70393|\n\nOne use of this optional field is in Patient Look-up transactions where the searching system employs a numeric algorithm for determining potential matches to patient/person look-ups."