Logical: LOC
Parent: $Segment
Id: LOC
Title: "HL7 v2 LOC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Location Identification"
* 1 1..1 PL "LOC-1" "This field contains the institution's identification code for the location. The identifying key value. Must match _MFE-4 -Primary Key Value - MFE_. This field has the same components as the patient location fields in the PV1 segment (except that bed status is not included here)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1307
* 1 ^comment = "At least the first component of this field is required. The first component can be an identifying code for the nursing station for inpatient locations, or clinic, department or home for patient locations other than inpatient ones."
* 2 0..1 ST "LOC-2" "This field contains the optional free text description of the location, to elaborate upon LOC primary key value."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "48"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = true
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #944
* 3 1..0 CWE "LOC-3" "This field contains the code identifying what type of location this is. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70260[User-defined Table 0260 - Patient Location Type] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0260 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "1"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #945
* 4 0..0 XON "LOC-4" "This field contains the organization(s) of which this location is a part. For inpatient locations, this can be the hospital or institution name. For outpatient locations, this can be the clinic or office name."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #947
* 5 0..0 XAD "LOC-5" "This field contains the address of the patient location, especially for use for outpatient clinic or office locations."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #948
* 6 0..0 XTN "LOC-6" "This field contains the phone number within the patient location, if any. For example, the room or bed phone for use by the patient."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #949
* 7 0..0 CWE "LOC-7" "This field contains the multiple license numbers for the facility. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70461[User-defined Table 0461 - License Number] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0461 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #951
* 8 0..0 CWE "LOC-8" "This repeating field indicates what types of equipment are built in. Applies only to room or bed locations. If _LOC-3 - Location Type_ indicates that this is a room, this will be the equipment in the room which can be used by more than one bed. If _LOC-3 - Location Type_ indicates this is a bed, this will be the bedside devices available to this bed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70261[User-defined Table 0261 - Location Equipment] in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0261 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "3"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #953
* 9 0..1 CWE "LOC-9" "This field categorizes the types of services provided by the location. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70442[User-defined Table 0442 - Location Service Code] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0442 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "1"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1583