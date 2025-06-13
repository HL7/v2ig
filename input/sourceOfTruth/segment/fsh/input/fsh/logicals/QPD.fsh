Logical: QPD
Parent: $Segment
Id: QPD
Title: "HL7 v2 QPD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Query Parameter Definition"
* 1 1..1 CWE "QPD-1" "This field contains the name of the query. These names are assigned by the function-specific chapters of this specification. It is one to one with the Query Profile for this query name, and it is in fact an identifier for that Query Profile. Site-specific query names begin with the letter \"Z.\" Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70471[_User defined table 0471 – Q__uery name_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0471 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1375
* 2 0..1 ST "QPD-2" "This field may be valued by the initiating system to identify the query, and may be used to match response messages to the originating query. If this field is valued, the responding system is required to echo it back as the first field in the query acknowledgement segment (QAK)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "32"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #696
* 2 ^comment = "This field differs from _MSA-2-Message control ID_ in that its value remains constant for each message (i.e., all continuation messages) associated with the query, whereas _MSA-2-Message control ID_ may vary with each continuation message, since it is associated with each individual message, not the query as a whole.\n\n*_Implementation considerations:_* It is not necessary to value this field in implementations where the only return message on the socket will be the response to the query that was just sent. Conversely, in an \"asynchronous\" implementation where many queries, responses, and other messages may be communicated bidirectionally over the same socket, it is essential that this field be valued so that the Client knows to which query the Server is responding."
* 3 0..1 Varies "QPD-3" "These successive parameter fields hold the values that the Client passes to the Server."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "256"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1435
* 3 ^comment = "The client data is presented as a sequence of HL7 fields. Beginning at _QPD-3-User parameters_, the remaining fields of the QPD segment carry user parameter data. Each QPD user parameter field corresponds to one parameter defined in the Query Profile, where each name, type, optionality, and repetition of each parameter has been specified. While these parameters are understood to be usually \"anded\" together, the user SHALL inspect the required Query Profile to properly understand each. Except in the QSC variant, the parameter names do not need to be stated in the query; they are understood to be positional based on the Query Profile.\n\nEach parameter field may be specified in the Query Profile to be of any single data type, including the complex QIP and QSC types. Parameter fields may also contain the sort control (SRT) field or the segment group (ID) field defined in Sections _5.5.6.6_, \"_RCP-6 Sort-by Field (SRT)_ 01624,\" and _5.5.6.7_, \"_RCP-7 Segment Group Inclusion (ID)_ 01594,\" below.\n\nParameter fields in the QPD segment appear in the same order as in the Query Profile."