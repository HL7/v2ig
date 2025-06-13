Logical: RCP
Parent: $Segment
Id: RCP
Title: "HL7 v2 RCP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Response Control Parameter"
* 1 0..1 ID "RCP-1" "This field contains the time frame in which the response is expected. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70091[_HL7 Table 0091 – Query priority_] in Chapter 2C, Code Tables, for valid values. Table values and subsequent fields specify time frames for response."
* 1 from http://terminology.hl7.org/ValueSet/v2-0091 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #27
* 2 0..1 CQ "RCP-2" "This field contains the maximum length of the response that can be accepted by the requesting system. Valid entries are numerical values (in the first component) given in the units specified in the second component. Default is LI (lines)."
* 2 from http://terminology.hl7.org/ValueSet/v2-0126 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #31
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70126[_HL7 Table 0126 – Quantity limited request_] in Chapter 2C, Code Tables, for valid entries for the second component. In a segment pattern response, a line is defined as a single segment."
* 3 0..1 CNE "RCP-3" "This field specifies the timing and grouping of the response message(s). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70394[_HL7 Table 0394 – Response modality_] in Chapter 2C, Code Tables, for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0394 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1440
* 4 0..1 DTM "RCP-4" "Specifies the time the response is to be returned. This field is only valued when _RCP-1-Query priority_ contains the value *D* (Deferred)."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1441
* 5 0..1 ID "RCP-5" "This field specifies whether the subscription is new or is being modified. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70395[HL7 Table 0395 – Modify indicator]_ in Chapter 2C, Code Tables, for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0395 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 5 ^extension[=].extension[0].url = "min"
* 5 ^extension[=].extension[=].valueInteger = 1
* 5 ^extension[=].extension[+].url = "max"
* 5 ^extension[=].extension[=].valueInteger = 1
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1443
* 6 0..0 SRT "RCP-6" "For queries requesting a tabular response, this field specifies by which fields the response is to be sorted, and the order(s) in which sorting is to be performed. When the QSC variant is not in use, the values specified for the first component in this field are derived from the ColName field of the Output Specification and Commentary; see section _5.3.3.1_, \"_Query Profile template for query with tabular response_.\" When the QSC variant is used, the values are derived from the ColName field of the Input/Output Specification and Commentary; see section _5.9.4.1_, \"_Pharmacy example_\" for an example."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1624
* 6 ^comment = "Each repetition of this field specifies a single sort field. Thus, the first repetition of this field specifies the primary sort field; the second repetition specifies the secondary sort field; etc."
* 7 0..0 ID "RCP-7" "Specifies those optional segment groups which are to be included in the response. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70391[_HL7 Table 0391—Segment group_] in Chapter 2C, Code Tables, for values for Segment Group. This is a repeating field, to accommodate inclusion of multiple segment groups. The default for this field, not present, means that all relevant groups are included."
* 7 from http://terminology.hl7.org/ValueSet/v2-0391 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 256
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1594