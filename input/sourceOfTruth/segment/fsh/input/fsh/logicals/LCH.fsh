Logical: LCH
Parent: $Segment
Id: LCH
Title: "HL7 v2 LCH Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Location Characteristic"
* 1 1..1 PL "LCH-1" "This field contains the institution's identification code for the location. The identifying key value. This field has the same components as the patient location fields in the PV1 segment (except that bed status is not included here). At least the first component of this field is required. The contents of this field must exactly match the content of its preceding MFE (link:++#mfe-4-primary-key-value---mfe-varies-00667++[MFE-4 - Primary Key Value - MFE]), its preceding LOC (_LOC-1 - Primary Key Value - LOC_), and its preceding LDP (_LDP-1 - Primary Key Value - LDP_)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1305
* 2 0..1 ID "LCH-2" "This field indicates whether this repetition of the segment is being added, changed or deleted. The action code adds a validation check to indicate, from the point of view of the sending system, whether this repetition of a segment is being added, changed or deleted. This and the following field are used to implement the \"unique key\" mode of updating repeating segments. (See Chapter 2, section 2.10.4.2, \"Action code/unique identifier mode update definition.\") Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #763
* 3 0..1 EI "LCH-3" "This field contains a unique identifier for one of the multiple repetitions of this segment, to be used in conjunction with the preceding field. Each of the repetitions of the segment will be uniquely identified by this unique key field for the purposes of updates."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #764
* 4 1..1 CWE "LCH-4" "This field contains an identifier code to show WHICH characteristic is being communicated with this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70324[User-defined Table 0324 - Location Characteristic ID] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0324 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1295
* 5 1..1 CWE "LCH-5" "This field contains the value of the above field's characteristic. The expected coded values for this field will depend upon the previous field. For example, if the previous field is SMK, IMP, INF, the values would be \"Y\" or \"N\"."
* 5 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1294
* 5 ^comment = "When LCH-4-location characteristic ID contains \"SHA\"- Shadow, refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values for _LRL-5 - Organizational Location Relationship Value_.\n\nY not a real bed, but a temporary holding location that does not physically exist in the census\n\nN this is a real bed\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"PRL\"- Privacy level (CWE), then _LRL-5 - Organizational Location Relationship Value_ indicates how the room is set up and intended to be used, disregarding different uses under special circumstances. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70262[User-defined Table 0262 - Privacy Level] in Chapter 2C, Code Tables, for suggested values.\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"LCR\"- Level of care, then _LRL-5 - Organizational Location Relationship Value_ contains the code which indicates what severity of the patient's medical condition which this location is designed to handle. This indicates how the room is set up and intended to be used, disregarding different uses under special circumstances. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70263[User-defined Table 0263 - Level of Care] in Chapter 2C, Code Tables, for suggested values.\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"IFD\"- Infectious disease, refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values for _LRL-5 - Organizational Location Relationship Value_.\n\nY patients with infectious diseases can be admitted to this location, that is, this location can be used for isolation\n\nN this location cannot be used for isolation\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"SMO\"- Smoking, refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values for _LRL-5 - Organizational Location Relationship Value_.\n\nY this is a smoking location\n\nN this is a non-smoking location\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"IMP\"- Implant, refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values for _LRL-5 - Organizational Location Relationship Value_.\n\nY this location can be used by radiation implant patients\n\nN this location can not be used by radiation implant patients\n\nWhen _LCH-4 - Location Characteristic ID_ contains \"LIC\"- Licensed, refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values for _LRL-5 - Organizational Location Relationship Value_.\n\nY this location is licensed\n\nN this location is not licensed"