Logical: ISD
Parent: $Segment
Id: ISD
Title: "HL7 v2 ISD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Interaction Status Detail"
* 1 1..1 NM "ISD-1" "This number uniquely identifies the interaction. If the interaction is performed as the result of a previous command, then the Reference Command Number should be used. (See _13.3.5.1_, \"_ECD-1 Reference Command Number (NM) 01390_.\")"
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1326
* 2 0..1 CWE "ISD-2" "This field specifies the type of interaction. If the interaction is performed as the result of a previous command, then the interaction type as specified in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70368[_User-defined Table 0368 - Remote Control command_] should be used."
* 2 from http://terminology.hl7.org/ValueSet/v2-0368 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1327
* 3 1..1 CWE "ISD-3" "This field transfers the state of the interaction. If the interaction is performed as the result of a previous command, then the interaction state should be one of the Command Responses (Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70387[_User-defined Table 0387 – Command Response_]). If the interaction is not performed as a result of a command (e.g., periodically time triggered automatic maintenance) then this state is interaction specific, and should refer to either the LECIS state transitions for interactions or a user or equipment specific table."
* 3 from http://terminology.hl7.org/ValueSet/v2-0387 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1328