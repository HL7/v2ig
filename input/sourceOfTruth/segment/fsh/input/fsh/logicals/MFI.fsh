Logical: MFI
Parent: $Segment
Id: MFI
Title: "HL7 v2 MFI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Master File Identification"
* 1 1..1 CWE "MFI-1" "This field is a CWE data type that identifies a standard HL7 master file. This table may be extended by local agreement during implementation to cover site-specific master files (z-master files). HL7 recommends use of the HL7 assigned table number as the master file identifier code if one is not specified in Table 0175. For example, a master file of Marital Status codes would be identified by HL70002 as the _MFI-1 - Master file identifier_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70175[HL7 Table 0175 – Master File Identifier Code] in Chapter 2C, Code Tables, for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0175 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #658
* 2 0..0 HD "MFI-2" "This field contains an optional code of up to 180 characters which (if applicable) uniquely identifies the application responsible for maintaining this file at a particular site. A group of intercommunicating applications may use more than a single instance of a master file of certain type (e.g., charge master or physician master). The particular instance of the file is identified by this field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70361[User-defined table 0361 - Applications]."
* 2 from http://terminology.hl7.org/ValueSet/v2-0361 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #659
* 3 1..1 ID "MFI-3" "This field defines the file-level event code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70178[HL7 Table 0178 – File Level Event Code] in Chapter 2C, Code Tables, for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0178 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 3
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 3
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #660
* 3 ^comment = "*Note*: The replace option allows the sending system to replace a file without sending delete record-level events for each record in that file. UPD means that the events are defined according to the record-level event code contained in each MFE segment in that message.\n\nIf the _MFI-3 - File-Level Event Code_ is \"REP\" (replace file), then each MFE segment must have an _MFE-1 - Record-Level Event Code_ of \"MAD\" (add record to master file)."
* 4 0..1 DTM "MFI-4" "This field contains the date/time for the file-level event on originating system."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #661
* 5 0..1 DTM "MFI-5" "This optional field contains the effective date/time, which can be included for file-level action specified. It is the date/time the originating system expects that the event is to have been completed on the receiving system. If this field is not present, the action date/time should default to the current date/time (when the message is received)."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #662
* 6 1..1 ID "MFI-6" "These codes specify the application response level defined for a given Master File Message at the MFE segment level as defined in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70179[HL7 Table 0179 – Response Level] in Chapter 2C, Code Tables. Required for MFN-Master File Notification message. Specifies additional detail (beyond _MSH-15 - Accept Acknowledgment Type_ and _MSH-16 - Application Acknowledgment Type_) for application-level acknowledgment paradigms for Master Files transactions. _MSH-15 - Accept Acknowledgment Type_ and _MSH-16 - Application Acknowledgment Type_ operate as defined in Chapter 2."
* 6 from http://terminology.hl7.org/ValueSet/v2-0179 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 2
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 2
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #663