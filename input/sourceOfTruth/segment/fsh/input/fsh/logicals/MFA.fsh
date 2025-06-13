Logical: MFA
Parent: $Segment
Id: MFA
Title: "HL7 v2 MFA Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Master File Acknowledgment"
* 1 1..1 ID "MFA-1" "This field defines record-level event for the master file record identified by the MFI segment and the primary key in this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70180[HL7 Table 0180 - Record-level Event Code] in Chapter 2C, Code Tables, for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0180 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 3
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 3
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #664
* 1 ^comment = "*Note:* If the _MFI-3 - File-level event code_ is \"REP\" (replace file), then each MFA segment must have an _MFA-1 - Record-level event code_ of \"MAD\" (add record to master file)."
* 2 0..1 ST "MFA-2" "This field contains a number or other identifier that uniquely identifies this change to this record from the point of view of the originating system. This field uniquely identifies the particular record (identified by the MFE segment) being acknowledged by this MFA segment. When returned to the originating system via the MFA segment, this field allows the target system to precisely identify which change to this record is being acknowledged. It is only required if _MFI-6 - Response Level Code_ requires responses at the record level (any value other than NE)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "20"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #665
* 3 0..1 DTM "MFA-3" "This field may be required or optional depending on the site specifications for the given master file, master file event, and receiving facility."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #668
* 4 1..1 CWE "MFA-4" "This field contains the status of the requested update. Site-defined table, specific to each master file being updated via this transaction."
* 4 from http://terminology.hl7.org/ValueSet/v2-0181 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #669
* 4 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70181[User-defined Table 0181 - MFN Record-level Error Return] in Chapter 2C, Code Tables, for suggested values. All such tables will have at least the following two return code values: \"S\" for successful and \"U\" for unsuccessful."
* 5 1..0 Varies "MFA-5" "This field uniquely identifies the record of the master file (identified in the MFI segment) for which the update status is being acknowledged (as defined by the field _MFN-4 - Record Level Error Return_). The data type of this field is defined by the value of _MFA-6 - Value Type - MFA_, and may take on the format of any of the HL7 data types defined in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70355[HL7 Table 0355 - Primary Key Value Type] in Chapter 2C, Code Tables. The PL data type is used only on location master transactions. Refer to Table 0607 - Primary Key Value - MFA in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0607 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1308
* 5 ^comment = "The repetition of the primary key permits the identification of an individual component of a complex record as the object of the record-level event code. This feature allows the Master Files protocol to be used for modifications of single components of complex records. If this field repeats, the field _MFA-6 - Primary Key Value Type - MFA_ must also repeat (with the same number of repetitions), and the data type of each repetition of _MFA-5 - Primary Key Value - MFA_ is specified by the corresponding repetition of _MFA-6 - Value Type - MFA_."
* 6 1..0 ID "MFA-6" "This field contains the HL7 data type of _MFA-5 - Primary Key Value - MFA_. The valid HL7 data types are listed in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70355[HL7 Table 0355 - Primary Key Value Type] in Chapter 2C, Code Tables."
* 6 from http://terminology.hl7.org/ValueSet/v2-0355 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 2
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 3
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1320