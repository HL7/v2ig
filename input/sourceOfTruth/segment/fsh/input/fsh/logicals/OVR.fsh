Logical: OVR
Parent: $Segment
Id: OVR
Title: "HL7 v2 OVR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Override"
* 1 0..1 CWE "OVR-1" "Identifies what type of business rule override is being performed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70518[_User-defined Table 0518 - Override Type_] in Chapter 2C, Code Tables, for suggested values. Given that an application provides end users with the ability to override business rules, there must be a way to communicate what business rule is being overridden."
* 1 from http://terminology.hl7.org/ValueSet/v2-0518 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1829
* 2 0..1 CWE "OVR-2" "Indicates the reason for the business rule override. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70521[_User-defined Table 0521 – Override Code_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0521 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1830
* 2 ^comment = "If users are allowed to override business rules in an application, the user will typically need to provide a reason why the rule is being overridden. The Override Code field in this segment will provide the mechanism to transmit a coded reason."
* 3 0..1 TX "OVR-3" "Additional descriptive comments detailing the circumstances of the override."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "200"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1831
* 3 ^comment = "When overriding a business rule there might be special circumstances that require a further explanation of the override action. The Override Comments field will allow users to provide more specific information in a free text format."
* 4 0..1 XCN "OVR-4" "Identifies the user entering the override in the system."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1832
* 4 ^comment = "When a business rule is overridden, an application must be able to link the override with the user who made it in order to provide a complete audit history of the transaction, especially when there might be a risk associated with the override. In situations where the original message was submitted by batch, the overriding user MAY be different than the original author of the message."
* 5 0..1 XCN "OVR-5" "Identifies the health services provider who accepts professional responsibility for overriding the business rule. This field SHOULD be left empty if the recording and responsible health care provider is the same as who entered the override."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1833
* 5 ^comment = "In some cases, a business rule override might be entered by a data entry clerk on behalf of a health service provider who carries professional responsibility for the decision to override the rule. In order to represent this scenario, the segment must have a field identifying who is responsible for the override decision, in addition to the person recording the override."