Logical: ERR
Parent: $Segment
Id: ERR
Title: "HL7 v2 ERR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Error"
* 1 0..1 BackboneElement "ERR-1" "ERR-1"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #W
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #24
* 1 ^comment = "Attention: The ERR-1 field *was deprecated in V2.4 and is withdrawn in V2.7*. Please refer to ERR-2 and ERR-3 instead."
* 2 0..0 ERL "ERR-2" "Identifies the location in a message related to the identified error, warning or message. If multiple repetitions are present, the error results from the values in a combination of places."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1812
* 3 1..1 CWE "ERR-3" "Identifies the HL7 (communications) error code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70357[_HL7_ _Tabl__e_ _0357 – Message Error Condition Codes_] in Chapter 2C, Code Tables, for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0357 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1813
* 4 1..1 ID "ERR-4" "Identifies the severity of an application error. Knowing if something is Error, Warning or Information is intrinsic to how an application handles the content. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70516[_HL7 Table 0516 - Error Severity_] in Chapter 2C, Code Tables, for valid values. If ERR-3 has a value of \"0\", ERR-4 will have a value of \"I\"."
* 4 from http://terminology.hl7.org/ValueSet/v2-0516 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1814
* 4 ^comment = "Example: a Warning could be used to indicate that notes were present, but ignored because they could not be automatically processed, and therefore information could have been missed.\n\nExample of Information: When submitting a claim, a payor might indicate remaining coverage under limit."
* 5 0..1 CWE "ERR-5" "Application specific code identifying the specific error that occurred. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70533[_User-Defined Table 0533 – Application Error Cod__e_] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0533 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1815
* 5 ^comment = "If the message associated with the code has parameters, it is recommended that the message be indicated in the format of the java.text.MessageFormat approach.footnote:[Details on MessageFormat can be found at _http://liveweb.archive.org/http://docs.oracle.com/javase/1.5.0/docs/api/java/text/MessageFormat.html_.] This style provides information on the parameter type to allow numbers, dates and times to be formatted appropriately for the language."
* 6 0..10 ST "ERR-6" "Additional information to be used, together with the Application Error Code, to understand a particular error condition/warning/etc. This field can repeat to allow for up to 10 parameters."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "80"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = true
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1816
* 6 ^comment = "Example: If the application error code specified in ERR.5 corresponded with the English message \"The patient has a remaining deductible of \\{0, number, currency} for the period ending \\{1, date, medium}.\", and the first two repetitions of ERR.6 were \"250\" and \"20021231\", then a receiving application in the U.S. would display the message as \"The patient has a remaining deductible of $250.00 for the period ending Dec 31, 2002.\""
* 7 0..1 TX "ERR-7" "Information that MAY be used by help desk or other support personnel to diagnose a problem."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "2048"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = true
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1817
* 8 0..1 TX "ERR-8" "The text message to be displayed to the application user."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "250"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1818
* 8 ^comment = "Example:\n\n|This program is having trouble communicating with another system. Please contact the help desk.|\n\nThis differs from the actual error code and could provide more diagnostic information."
* 9 0..0 CWE "ERR-9" "A code to indicate who (if anyone) SHOULD be informed of the error. This field MAY also be used to indicate that a particular person SHOULD NOT be informed of the error (e.g., Do not inform patient). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70517[_User-defined table 0517- Inform Person Code_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0517 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1819
* 10 0..1 CWE "ERR-10" "Identifies what type of override can be used to override the specific error identified. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70518[_User-defined Table 0518 - Override Type_] in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0518 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1820
* 11 0..0 CWE "ERR-11" "Provides a list of potential override codes that can be used to override enforcement of the application rule that generated the error. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70519[_User-defined table 0519 – Override Reason_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0519 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1821
* 12 0..0 XTN "ERR-12" "Lists phone, e-mail, fax, and other relevant numbers for helpdesk support related to the specified error."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1822