Logical: LRL
Parent: $Segment
Id: LRL
Title: "HL7 v2 LRL Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Location Relationship"
* 1 1..1 PL "LRL-1" "This field contains the institution's identification code for the location. The identifying key value. This field has the same components as the patient location fields in the PV1 segment (except that bed status is not included here). At least the first component of this field is required. The contents of this field must exactly match the content of its preceding MFE (_MFE-4 - Primary Key Value - MFE_), its preceding LOC (_LOC-1 - Primary Key Value - LOC_), and its preceding LDP (_LDP-1 - Primary Key Value - LDP_)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #943
* 2 0..1 ID "LRL-2" "This field indicates whether this repetition of the segment is being added, changed or deleted. The action code adds a validation check to indicate, from the point of view of the sending system, whether this repetition of a segment is being added, changed or deleted. This and the following field are used to implement the \"unique key\" mode of updating repeating segments. (See Chapter 2, section 2.10.4.2, \"Action code/unique identifier mode update definition.\") Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] in Chapter 2C, Code Tables, for valid values."
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
* 3 0..1 EI "LRL-3" "This field contains a unique identifier for one of the multiple repetitions of this segment, to be used in conjunction with the preceding field. Each of the repetitions of the segment will be uniquely identified by this unique key field for the purposes of updates."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #764
* 4 1..1 CWE "LRL-4" "This field contains an identifier code to show WHICH relationship is being communicated with this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70325[User-defined Table 0325 - Location Relationship ID] for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0325 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1277
* 5 0..0 XON "LRL-5" "This field is conditional on the value of _LRL-4 - Location Relationship ID_. When _LRL-4 -Location Relationship ID_ contains \"RX\"- Nearest Pharmacy, \"RX2\"- Other Pharmacy, \"LAB\"- Nearest Lab, \"LB2\"- Other Lab, or \"DTY\"- Dietary, this field holds that organization's extended name, i.e., the value of this field is conditional on the value of _LRL-4 - Location Relationship ID_. For example, for an inpatient location, this could be an in-house department ID code using only the third component of this data type. For an outpatient location, this could be the nearest external pharmacy."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1301
* 6 0..1 PL "LRL-6" "This field is conditional on the value of _LRL-4 - Location Relationship ID_. When _LRL-4 -Location Relationship ID_ contains \"ALI\"- Location aliases or \"PAR\"- Parent location this field holds the value of the associated patient location."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1292
* 6 ^comment = "When _LRL-4 - Location Relationship ID_ contains \"PAR\"- Parent, this field holds the value of the parent location to allow for nested entries. For example, a bed entry can point to its containing room or nurse unit. The value for the parent location should match the _LOC-1 - Primary Key Value - LOC_ of the parent entry. Not intended to be used for multiple designations of the same physical location, but for identifying the larger physical locations (supersets) which include this physical location as a subset."