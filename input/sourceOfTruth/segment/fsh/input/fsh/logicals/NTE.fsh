Logical: NTE
Parent: $Segment
Id: NTE
Title: "HL7 v2 NTE Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Notes and Comments"
* 1 0..1 SI "NTE-1" "This field MAY be used where multiple NTE segments are included in a message. Their numbering must be described in the application message definition."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #96
* 2 0..1 ID "NTE-2" "This field is used when source of comment must be identified. This table MAY be extended locally during implementation. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70105[_HL7 Table 0105 - Source of Com__ment_] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0105 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #97
* 3 0..0 FT "NTE-3" "This field contains the comment contained in the segment."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #98
* 3 ^comment = "Conditionality Predicate: In support of backwards compatibility, when NTE-9 is populated, the sending system SHALL also populate a human-readable version of the comment in NTE-3. When NTE-9 is not populated then NTE-3 MAY be populated.\n\n*Note: NTE-3 has been left blank for the use cases where legacy systems are sending a blank NTE as a line feed.*\n\n*Note:* As of v2.2, this field uses the FT rather than a TX data type. Since there is no difference between an FT data type without any embedded formatting commands, and a TX data type, this change is compatible with the previous version."
* 4 0..1 CWE "NTE-4" "This field contains a value to identify the type of comment text being sent in the specific comment record. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70364[_User-Defined Table 0364 - Comment Type_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0364 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1318
* 4 ^comment = "Note: A field already exists on the NTE record that identifies the Sources of Comment (e.g., ancillary, placer, other). However some applications need to support other types of comment text (e.g., instructions, reason, remarks, etc.). A separate NTE segment can be used for each type of comment (e.g., instructions are on one NTE and remarks on another NTE)."
* 5 0..1 XCN "NTE-5" "This field contains the identity of the person who actually keyed the comment into the application. It provides an audit trail in case the comment is entered incorrectly and the ancillary department needs to clarify the comment. By local agreement, either the ID number or name component MAY be omitted."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #224
* 6 0..1 DTM "NTE-6" "This field contains the actual date the comment was keyed into the application."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #661
* 7 0..1 DTM "NTE-7" "This field contains the date the comment becomes or became effective."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1004
* 8 0..1 DTM "NTE-8" "This field contains the date the comment becomes or became non-effective."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2185
* 9 0..0 CWE "NTE-9" "This field contains a value to identify a codified comment being sent in the specific comment record. If this field is valued, NTE-3 will be populated with text from this field. In support of backwards compatibility, when NTE-9 is populated, the sending system SHALL also populate a human-readable version of the comment in NTE-3. Refer to Table 0611 - Coded Comment in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0611 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3495