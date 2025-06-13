Logical: PYE
Parent: $Segment
Id: PYE
Title: "HL7 v2 PYE Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Payee Information"
* 1 1..1 SI "PYE-1" "Sequence Number."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1939
* 2 1..1 CWE "PYE-2" "Type of Payee (e.g., Organization, Person). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70557[_User-defined Table 0557 – Payee Type_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0557 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1940
* 3 0..1 CWE "PYE-3" "Conditional or empty: if Payee Type in list (\"PERS\", \"PPER\"), then Required, else Not Permitted."
* 3 from http://terminology.hl7.org/ValueSet/v2-0558 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1941
* 3 ^comment = "For Person Payee Types, the relationship to Invoice. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70558[_User-defined Table 0558 – Payee Relationship to Invoice_] in Chapter 2C, Code Tables, for suggested values."
* 4 0..5 XON "PYE-4" "Conditional or empty: if Payee Type in list (\"PPER\", \"ORG\"), then Required, else Not Permitted."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1942
* 4 ^comment = "Payee or Business Arrangement identification information; up to 5; defined by Payer/Provider agreement."
* 5 0..4 XPN "PYE-5" "Conditional or empty: if Payee Type = (\"PERS\", \"PPER), then Required, else Not Permitted."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1943
* 5 ^comment = "Individual's name; may be a patient's name or other individual."
* 6 0..4 XAD "PYE-6" "Conditional or empty: if Payee Type = (\"PERS\", \"PPER), then Required, else Not Permitted."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1944
* 6 ^comment = "Address for payee. If not specified, then Payer will use address on file for this Payee, if applicable. If Payee is an individual, then this address can be used to send a check."
* 7 0..1 CWE "PYE-7" "For Payee organizations that have more than one payment method."
* 7 from http://terminology.hl7.org/ValueSet/v2-0570 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1945
* 7 ^comment = "If for individual, then we may also need to indicate EFT, bank info, etc.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70570[_User-defined Table 0570 – Payment Method Code_] in Chapter 2C, Code Tables, for suggested values."