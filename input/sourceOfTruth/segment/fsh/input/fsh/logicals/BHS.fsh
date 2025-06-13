Logical: BHS
Parent: $Segment
Id: BHS
Title: "HL7 v2 BHS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Batch Header"
* 1 1..1 ST "BHS-1" "This field contains the separator between the segment ID and the first real field, BHS-2 Batch Encoding Characters. As such it serves as the separator and defines the character to be used as a separator for the rest of the message. Recommended value is | (ASCII 124)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #81
* 2 1..1 ST "BHS-2" "This field contains the five characters in the following order: the component separator, repetition separator, escape characters, subcomponent separator, and truncation character. Recommended values are ^~\\&# (ASCII 94, 126, 92, 38,and 35, respectively). See Section _2.4.4_, \"link:#message-delimiters[_Message delimiters_].\""
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 4
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 5
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #82
* 3 0..1 HD "BHS-3" "This field uniquely identifies the sending application among all other applications within the network enterprise. The network enterprise consists of all those applications that participate in the exchange of HL7 messages within the enterprise. Entirely site-defined."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #83
* 4 0..1 HD "BHS-4" "This field contains the address of one of several occurrences of the same application within the sending system. Absent other considerations, the Medicare Provider ID might be used with an appropriate sub-identifier in the second component. Entirely site-defined."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #84
* 5 0..1 HD "BHS-5" "This field uniquely identifies the receiving applications among all other applications within the network enterprise. The network enterprise consists of all those applications that participate in the exchange of HL7 messages within the enterprise. Entirely site-defined."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #85
* 6 0..1 HD "BHS-6" "This field identifies the receiving application among multiple identical instances of the application running on behalf of different organizations. See comments _2.13.2.4_, \"_BHS-4 Batch Sending Facility (HD) 00084_.\" Entirely site-defined."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #86
* 7 0..1 DTM "BHS-7" "This field contains the date/time that the sending system created the message. If the time zone is specified, it will be used throughout the message as the default time zone."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #87
* 8 0..1 ST "BHS-8" "In some applications of HL7, this field is used to implement security features. For codified expression of security tags using BHS-15 through BHS-17."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "40"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #88
* 9 0..1 ST "BHS-9" "This field can be used by the application processing the batch. It can have extra components if needed."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "40"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #89
* 9 ^comment = "*Note:* the text regarding \"extra components\" has been retained for backward compatibilityas of V2.5, but it is not currently an accepted format for the ST data type."
* 10 0..1 ST "BHS-10" "This field is a comment field that is not further defined in the HL7 protocol."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "80"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #90
* 11 0..1 ST "BHS-11" "This field is used to uniquely identify a particular batch. It can be echoed back in BHS-12 Reference Batch Control ID if an answering batch is needed."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 11 ^extension[=].extension[0].url = "length"
* 11 ^extension[=].extension[=].valueInteger = "20"
* 11 ^extension[=].extension[+].url = "noTruncate"
* 11 ^extension[=].extension[=].valueInteger = false
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #91
* 12 0..1 ST "BHS-12" "This field contains the value of BHS-11 Batch Control ID when this batch was originally transmitted. Not present if this batch is being sent for the first time. See definition for BHS-11 Batch Control ID."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "20"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #92
* 13 0..1 HD "BHS-13" "Identifier of the network location the message was transmitted from. Identified by an OID or text string (e.g., URI). The reader is referred to the \"Report from the Joint W3C/IETF URI Planning Interest Group: Uniform Resource Identifiers (URIs), URLs, and Uniform Resource Names (URNs): Clarifications and Recommendations\".footnote:[The URI is: http://www.ietf.org/rfc/rfc3305.txt. Note: All IETF documents are available online, and RFCs are available through URIs using this format.]"
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2271
* 13 ^comment = "As with the Sending/Receiving Responsible Organization, the Sending Network Address provides a more detailed picture of the source of the message. This information is lower than the application layer, but is often useful/necessary for routing and identification purposes. This field SHALL only be populated when the underlying communication protocol does not support identification of sending network locations.\n\nThe specific values and usage must be site negotiated"
* 14 0..1 HD "BHS-14" "Identifier of the network location the message was transmitted to. Identified by an OID or text string. (e.g., URL)."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2272
* 14 ^comment = "This is analogous with the Sending Network Address, however in the receiving role.\n\nThis field SHALL only be populated when the underlying communication protocol does not support identification receiving network locations."
* 15 0..1 CWE "BHS-15" "This field defines the security classification (as defined by ISO/IEC 2382-8:1998(E/F)/ T-REC-X.812-1995) of an IT resource, in this case the message, which might be used to make access control decisions. It is conditionally required when MSH-27 or MSH-28 are used."
* 15 from http://terminology.hl7.org/ValueSet/v2-0952 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2429
* 15 ^comment = "Conditionality Predicate: Required if BHS-16 or BHS-17 or any contained FSH-16 or FSH-17 or MSH-26 or MSH-27 is valued, Optional if neither BHS-16 nor BHS-17 , nor any contained FSH-16 or FSH-17, nor MSH-26 nor MSH-27is valued.\"\n\nUse of this field supports the business requirement for declaring the level of confidentiality (classification) for a given message.\n\nRefer to Externally-defined HL7 Table 0952 – HL7 Confidentiality Code in Chapter 2C, Code Tables, for suggested values. Use of this table is recommended. The codes in this table are comprehensive, non-overlapping hierarchical codes: Very Restricted > Restricted > Normal > Moderate > Low > Unrestricted. Restrictions to a comprehensive, non-overlapping set of codes is required for purposes of access control system algorithms such as Bell–LaPadula Mode, which isl used to adjudicate access requests against privacy policies."
* 16 0..0 CWE "BHS-16" "This field is repeatable and conveys instructions to users and receivers for secure distribution, transmission, and storage; dictate obligations or mandated actions; specify any action prohibited by refrain policy such as dissemination controls; and stipulate the permissible purpose of use of an IT resource."
* 16 from http://terminology.hl7.org/ValueSet/v2-0953 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2430
* 16 ^comment = "Refer to HL7 Table 0953 – Security Control in Chapter 2C, Code Tables, for suggested values. –"
* 17 0..0 ST "BHS-17" "Used to convey specific instructions about the protection of the patient's data , which must be rendered to end users in accordance with patient consent directive, organizational policy, or jurisdictional law. For example, in US law 42 CFR Part 2, disclosed information made with patient consent must include a renderable “Prohibition on re-disclosure” warning (§ 2.32[multiblock footnote omitted]) In addition, organizational policy MAY require that some or all of the ARV field privacy tag values be rendered to end users, e.g., marking a consult note with “Restricted Confidentiality” or with sensitivity tags such as “VIP” or “EMP” for employee of the organization."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #C
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2431
* 17 ^comment = "This field MAY also be used to specify instructions about the release of information to family and friends (e.g., \"Do not release information to patient's brother, Adam Everyman\"). These instructions could be in conjunction with other fields (as elected by the system)."