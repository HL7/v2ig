Logical: MFE
Parent: $Segment
Id: MFE
Title: "HL7 v2 MFE Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Master File Entry"
* 1 1..1 ID "MFE-1" "This field defines the record-level event for the master file record identified by the MFI segment and the primary key field in this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70180[HL7 Table 0180 - Record Level Event Code] in Chapter 2C, Code Tables, for valid values."
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
* 1 ^comment = "*Note:* If the _MFI-3 - File-level event code_ is \"REP\" (replace file), then each MFE segment must have an _MFE-1 - Record-level event code_ of \"MAD\" (add record to master file)."
* 2 0..1 ST "MFE-2" "A number or other identifier that uniquely identifies this change to this record from the point of view of the originating system. When returned to the originating system via the MFA segment, this field allows the target system to precisely identify which change to this record is being acknowledged. It is only required if the MFI response level code requires responses at the record level (any value other than NE)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "20"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #665
* 2 ^comment = "*Note:* Note that this segment does not contain a Set ID field. The _MFE-2 - MFN Control ID_ implements a more general concept than the Set ID. It takes the place of the SET ID in the MFE segment."
* 3 0..1 DTM "MFE-3" "An optional effective date/time can be included for the record-level action specified. It is the date/time the originating system expects that the event is to have been completed on the receiving system. If this field is not present, the effective date/time should default to the current date/time (when the message is received)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #662
* 4 1..0 Varies "MFE-4" "This field uniquely identifies the record of the master file (identified in the MFI segment) to be changed (as defined by the record-level event code). The data type of field is defined by the value of _MFE-5 - Value Type_, and may take on the format of any of the HL7 data types defined in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70355[HL7 Table 0355 - Primary Key Value Type] in Chapter 2C, Code Tables. The PL data type is used only on Location master transactions. Refer to Table 0608 - Primary Key Value - MFE in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0608 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #667
* 4 ^comment = "The repetition of the primary key permits the identification of an individual component of a complex record as the object of the record-level event code. This feature allows the Master Files protocol to be used for modifications of single components of complex records. If this field repeats, the field _MFE-5 - Value Type_ must also repeat (with the same number of repetitions), and the data type of each repetition of _MFE-4 - Primary Key Value - MFE_ is specified by the corresponding repetition of _MFE-5 - Value Type_."
* 5 1..0 ID "MFE-5" "This field contains the HL7 data type of _MFE-4 - Primary Key Value - MFE_. The valid values for the data type of a primary key are listed in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70355[HL7 Table 0355 - Primary Key Value Type] in Chapter 2C, Code Tables."
* 5 from http://terminology.hl7.org/ValueSet/v2-0355 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 5 ^extension[=].extension[0].url = "min"
* 5 ^extension[=].extension[=].valueInteger = 2
* 5 ^extension[=].extension[+].url = "max"
* 5 ^extension[=].extension[=].valueInteger = 3
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1319
* 6 0..1 DTM "MFE-6" "This field contains the date and time of the last change of the record."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #661
* 7 0..1 XCN "MFE-7" "This field contains the identity of the person who actually keyed the master file entry into the application. It provides an audit trail in case the request is entered incorrectly and the ancillary department needs to clarify the request."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #224