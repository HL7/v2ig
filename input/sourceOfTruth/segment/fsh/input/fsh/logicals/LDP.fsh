Logical: LDP
Parent: $Segment
Id: LDP
Title: "HL7 v2 LDP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Location Department"
* 1 1..1 PL "LDP-1" "This field contains the institution's identification code for the location. The identifying key value. This field has the same components as the patient location fields in the PV1 segment (except that bed status is not included here). At least the first component of this field is required. The contents of this field must exactly match the content of its preceding MFE (_MFE-4 - Primary Key Value - MFE)_ and its preceding LOC (_LOC-1 - Primary Key Value - LOC)_."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #963
* 2 1..1 CWE "LDP-2" "This field contains the institution's department to which this location belongs, or its cost center. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70264[User-defined Table 0264 - Location Department] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0264 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #964
* 3 0..0 CWE "LDP-3" "This field contains the hospital or ancillary service with which this location is associated. Depends on institution use. Repeats for rooms that can be used, for example, by different services on different days. These values should match the values used for _PV1-10 - Hospital Service_, which is site defined. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70069[User-defined Table 0069 - Hospital Service] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0069 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "3"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #965
* 4 0..0 CWE "LDP-4" "This field contains the specialty type (if any) of the department or clinic. This may also be considered a bed type. Specialty type is a physical accommodation type, whereas 'accommodation type' (_LCC-3 - Accommodation Type_) is a financial accommodation type. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70265[User-defined Table 0265 – Specialty Type] in Chapter 2C, Code Tables, for suggested values. See also _LCH-4 - Location Characteristic ID_ and _LHC-5 - Location Characteristic Value_."
* 4 from http://terminology.hl7.org/ValueSet/v2-0265 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #966
* 5 0..0 CWE "LDP-5" "This field contains the patient types that are allowed to be assigned to this bed. For example, Inpatient, Outpatient, Series, Clinic, ER, Ambulatory, Observation, etc. These values should be the same set of values as those used for _PV1-2 - Patient Class_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70004[User-defined Table 0004 – Patient Class] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0004 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "1"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #967
* 6 0..1 ID "LDP-6" "This field indicates whether the entry for this location is currently an active, that is, valid, usable entry (disregarding whether it's waiting to be maintained by housekeeping). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70183[HL7 Table 0183 - Active/Inactive] in Chapter 2C, Code Tables, for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0183 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #675
* 7 0..1 DTM "LDP-7" "This field contains the date and time when the location became active or \"in service\" for a department (disregarding whether it is waiting to be maintained by housekeeping)."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #969
* 8 0..1 DTM "LDP-8" "This field contains the date when the location became inactive or \"out of service\" for this department (disregarding whether it is waiting to be maintained by housekeeping)."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #970
* 9 0..1 ST "LDP-9" "This field contains the reason the location was put out of service. It is used when _LDP-8 - Inactivation Date-LDP_ is sent."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "80"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #971
* 10 0..0 VH "LDP-10" "This field contains the hours when this location is open for visiting. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70267[HL7 Table 0267 - Days of the Week] in Chapter 2C, Code Tables, for valid values for the first two components."
* 10 from http://terminology.hl7.org/ValueSet/v2-0267 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #976
* 11 0..1 XTN "LDP-11" "This field contains the phone number to use to contact facility personnel about the patient location, in case of inquiries about the location. This phone is not necessarily within the named patient location."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #978
* 12 0..1 CWE "LDP-12" "This field contains the cost center to which this location belongs. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70462[User-defined Table 0462 - Location Cost Center] in Chapter 2C, Code Tables, for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0462 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1584