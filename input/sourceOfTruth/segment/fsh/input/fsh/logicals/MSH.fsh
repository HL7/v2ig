Logical: MSH
Parent: $Segment
Id: MSH
Title: "HL7 v2 MSH Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Message Header"
* 1 1..1 ST "MSH-1" "This field contains the separator between the segment ID and the first real field, MSH-2 Encoding Characters. As such it serves as the separator and defines the character to be used as a separator for the rest of the message. Recommended value is | (ASCII 124)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1
* 2 1..1 ST "MSH-2" "This field contains five characters in the following order: the component separator, repetition separator, escape character, subcomponent separator, and truncation character. Recommended values are ^~\\& #(ASCII 94, 126, 92, 38, and 35, respectively). See Section _2.4.4_, \"_Message delimiters_'."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 4
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 5
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2
* 3 0..1 HD "MSH-3" "This field uniquely identifies the sending application among all other applications within the network enterprise. The network enterprise consists of all those applications that participate in the exchange of HL7 messages within the enterprise. Entirely site-defined. E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70361[_User-defined Table 0361- Application_] in Chapter 2C, Code Tables, is used as the user-defined table of values for the first component."
* 3 from http://terminology.hl7.org/ValueSet/v2-0361 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3
* 3 ^comment = "*Note:* By site agreement, implementers MAY continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0__300 – Namespace ID_] in Chapter 2C, Code Tables, for the first component."
* 4 0..1 HD "MSH-4" "This field further describes the sending application, MSH-3 Sending Application. With the promotion of this field to an HD data type, the usage has been broadened to include not just the sending facility but other organizational entities such as a) the organizational entity responsible for sending application; b) the responsible unit; c) a product or vendor's identifier, etc. Entirely site-defined. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70362[_User-defined Table 0362 - Facility_] in Chapter 2C, Code Tables, is used as the HL7 identifier for the user-defined table of values for the first component."
* 4 from http://terminology.hl7.org/ValueSet/v2-0362 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #4
* 4 ^comment = "*Note:* By site agreement, implementers MAY continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] in Chapter 2C, Code Tables, for the first component."
* 5 0..1 HD "MSH-5" "This field uniquely identifies the receiving application among all other applications within the network enterprise. The network enterprise consists of all those applications that participate in the exchange of HL7 messages within the enterprise. Entirely site-defined _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70361[User-defined Table 0361- Application]_ in Chapter 2C, Code Tables, is used as the HL7 identifier for the user-defined table of values for the first component."
* 5 from http://terminology.hl7.org/ValueSet/v2-0361 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #5
* 5 ^comment = "*Note*: By site agreement, implementers MAY continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] in Chapter 2C, Code Tables, for the first component."
* 6 0..1 HD "MSH-6" "This field identifies the receiving application among multiple identical instances of the application running on behalf of different organizations. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70362[_User-defined Table 0362 - Facilit__y_] in Chapter 2C, Code Tables, is used as the HL7 identifier for the user-defined table of values for the first component. Entirely site‑defined."
* 6 from http://terminology.hl7.org/ValueSet/v2-0362 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #6
* 6 ^comment = "*Note*: By site agreement, implementers MAY continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] in Chapter 2C, Code Tables, for the first component."
* 7 1..1 DTM "MSH-7" "This field contains the date/time that the sending system created the message. If the time zone is specified, it will be used throughout the message as the default time zone."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #7
* 7 ^comment = "*Note:* This field was made required in version 2.4. Messages with versions prior to 2.4 are not required to value this field. This usage supports backward compatibility."
* 8 0..1 ST "MSH-8" "In some applications of HL7, this field is used to implement security features. For codified expression of security tags use MSH-26 through MSH-29."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "40"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #8
* 9 1..1 MSG "MSH-9" "This field contains the message type, trigger event, and the message structure ID for the message."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #R
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #9
* 9 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70076[_HL7 Table 0076 - Message Type_] in Chapter 2C, Code Tables, for valid values for the message type code. This table contains values such as ACK, ADT, ORM, ORU etc.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70003[_HL7 Table 0003 – Event Type_] in Chapter 2C, Code Tables, for valid values for the trigger event. This table contains values like A01, O01, R01 etc.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70354[_HL7_ _Table 0354 - Message Structure_] in Chapter 2C, Code Tables, for valid values for the message structure. This table contains values such as ADT_A01, ORU_R01, SIU_S12, etc.\n\nThe receiving system uses this field to recognize the data segments, and possibly, the application to which to route this message. For certain queries, which could have more than a single response event type, the second component MAY, in the response message, vary to indicate the response event type. See the discussion of the display query variants in chapter 5."
* 10 1..1 ST "MSH-10" "This field contains a number or other identifier that uniquely identifies the message. The receiving system echoes this ID back to the sending system in the Message acknowledgment segment (MSA)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #R
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 199
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #10
* 11 1..1 PT "MSH-11" "This field is used to decide whether to process the message as defined in HL7 Application (level 7) Processing rules."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #11
* 12 1..1 VID "MSH-12" "This field is matched by the receiving system to its own version to be sure the message will be interpreted correctly. Beginning with Version 2.3.1, it has two additional \"internationalization\" components, for use by HL7 international affiliates. The <internationalization code> is CE data type (using the ISO country codes where appropriate) which represents the HL7 affiliate. The <internal version ID> is used if the HL7 Affiliate has more than a single 'local' version associated with a single US version. The <international version ID> has a CE data type, since the table values vary for each HL7 Affiliate. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70104[_HL7 Table 0104 – Version ID_] in Chapter 2C, Code Tables, for valid values."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #R
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #12
* 13 0..1 NM "MSH-13" "A non‑delete indicator value in this field implies that the sequence number protocol is in use. This numeric field is incremented by one for each subsequent value."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #13
* 14 0..1 ST "MSH-14" "This field is used to define continuations in application-specific ways."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "180"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #14
* 14 ^comment = "Only the sender of a fragmented message values this field."
* 15 0..1 ID "MSH-15" "This field identifies the conditions under which accept acknowledgments are required to be returned in response to this message. Conditionality: Either both MSH-15 and MSH-16 SHALL be populated OR both SHALL be empty. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70155[_HL7 Table 0155 - Accept/Application Acknowledgment Conditions_] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0155 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 2
* 15 ^extension[=].extension[+].url = "max"
* 15 ^extension[=].extension[=].valueInteger = 2
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #15
* 16 0..1 ID "MSH-16" "This field contains the conditions under which application acknowledgments are required to be returned in response to this message. Either both MSH-15 and MSH-16 SHALL be populated OR both SHALL be empty. Required for enhanced acknowledgment mode."
* 16 from http://terminology.hl7.org/ValueSet/v2-0155 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 2
* 16 ^extension[=].extension[+].url = "max"
* 16 ^extension[=].extension[=].valueInteger = 2
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #16
* 16 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70155[_HL7 Table 0155 - Accept/Application Acknowledgment Conditions_] in Chapter 2C, Code Tables, for valid values for MSH-15 Accept Acknowledgment Type and MSH-16 Application Acknowledgment Type.\n\n*Note:* If _MSH-15-accept acknowledgment type_ and _MSH-16-application acknowledgment type_ are omitted (or are both empty ), the original acknowledgment mode rules are used.-"
* 17 0..1 ID "MSH-17" "This field contains the country of origin for the message. It will be used primarily to specify default elements, such as currency denominations. The values to be used are those of ISO 3166,.footnote:[Available from ISO 1 Rue de Varembe, Case Postale 56, CH 1211, Geneve, Switzerland]. The ISO 3166 table has three separate forms of the country code: HL7 specifies that the 3-character (alphabetic) form be used for the country code."
* 17 from http://terminology.hl7.org/ValueSet/v2-0399 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 3
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 3
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #17
* 17 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70399[_External Table 0399 - Country Code_] in Chapter 2C, Code Tables, for the 3-character codes as defined by ISO 3166-1."
* 18 0..0 ID "MSH-18" "This field contains the character set for the entire message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70211[_HL7 Table 0211 - Alternate Character Sets_] in Chapter 2C, Code Tables, for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0211 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 5
* 18 ^extension[=].extension[+].url = "max"
* 18 ^extension[=].extension[=].valueInteger = 15
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #692
* 18 ^comment = "An HL7 message uses field MSH-18 Character Set to specify the character set(s) in use. Valid values for this field are specified in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70211[_HL7 Table 0211 - Alternate Character Sets_]. MSH-18 Character Set MAY be left blank, or MAY contain one or more values delimited by the repetition separator. If the field is left blank, the character set in use is understood to be the 7-bit ASCII set, decimal 0 through decimal 127 (hex 00 through hex 7F). This default value MAY also be explicitly specified as *ASCII*.\n\nMore than one character set MAY be used in a message. The first occurrence, if supplied, of the MSH-18 SHALL indicate the default encoding of the message. The second and subsequent occurrences of MSH-18-character set are used to specify additional character sets that are used.\n\nThe repetitions of this field to specify different character sets apply only to fields of the FT, ST and TX data types. See also section _2.6.3,_ \"_Escape sequences supporting multiple character sets_\".\n\nAny encoding system, single-byte or multi-byte, MAY be specified as the default character encoding in MSH-18 Character Set. If the default encoding is other than 7-bit ASCII, sites SHALL document this usage in the dynamic conformance profile or other implementation agreement. This is particularly effective in promoting interoperability between nations belonging to different HL7 Affiliates, while limiting the amount of testing required to determine the encoding of a message.\n\nBy using built-in language functions for string and character manipulation, parsers and applications need not be concerned whether a single or double byte character set is in use, provided it is applied to the entire message. Using a built in function to extract the fourth CHARACTER will always yield the field separator character, regardless of coding set. On the other hand, if the parser looks at the fourth BYTE, it is then limited to single byte character sets, since the fourth byte would contain the low order 8 bits of the character S in a double-byte system.\n\n*Note:* When describing encoding rules, this standard always speaks in terms of character position, not byte offset. Similarly, comparisons SHOULD be done on character values, not their byte equivalents. For this reason, delimiter characters SHOULD always have representation in the standard 7-bit ASCII character set, regardless of the actual character set being used, so that a search for the character CR (carriage return) can be performed.\n\n{empty}a) if the field is not valued, the default single-byte character set (ASCII (\"ISO IR6\")) SHOULD be assumed. No other character sets are allowed in the message.\n\n{empty}b) if the field repeats, but the first element is empty(I.e. unvalued), the single-byte ASCII (\"ISO IR6\") is assumed as the default character set.\n\n{empty}c) elements in the remainder of the sequence (i.e., elements 2..n) are alternate character sets that MAY be used.\n\nThe reader is referred to the following references for background information on character sets and encodings:\n\nUnicode Technical Report #17 - Character Encoding Model (http://www.unicode.org/unicode/reports/tr17/)\n\nExtensible Markup Language (XML) 1.0 (Second Edition), Section F Autodetection of Character Encodings (http://www.w3.org/TR/REC-xml#sec-guessing)"
* 19 0..1 CWE "MSH-19" "This field contains the principal language of the message. Codes come from ISO 639. Refer to Table 0609 - Principal Language Of Message in Chapter 2C for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0609 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #693
* 20 0..1 ID "MSH-20" "When any alternative character sets are used (as specified in the second or later iterations of link:#_MSH-18___Character Set   (ID)   006[MSH-18 Character Set]), and if any special handling scheme is needed, this component is to specify the scheme used, according to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70356[_HL7 Table 0356- Alternate Character Set Handling Scheme_] as defined in Chapter 2C, Code Tables,."
* 20 from http://terminology.hl7.org/ValueSet/v2-0356 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 3
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 13
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1317
* 21 0..0 EI "MSH-21" "Sites MAY use this field to assert adherence to, or reference, a message profile. Message profiles contain detailed explanations of grammar, syntax, and usage for a particular message or set of messages. See section 2B, \"Conformance Using Message Profiles\"."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1598
* 21 ^comment = "Repetition of this field allows more flexibility in creating and naming message profiles. Using repetition, this field can identify a set of message profiles that the message conforms to. For example, the first repetition could reference a vendor's message profile. The second could reference another compatible provider's profile or a later version of the first vendor profile.\n\nAs of v2.5, the HL7 message profile identifiers might be used for conformance claims and/or publish/subscribe systems. Refer to sections 2B.1.1\"Message profile identifier\" and 2.B.1.2, \"Message profile publish/subscribe topics\" for details of the message profile identifiers. Refer to sections 2.B.4.1, \"Static definition identifier\" and 2.B.4.2, \"Static definition publish/subscribe topics\" for details of the static definition identifiers.\n\nPrior to v2.5, the field was called Conformance Statement ID. For backward compatibility, the Conformance Statement ID can be used here. Examples of the use of Conformance Statements appear in Chapter 5, \"Query.\""
* 22 0..1 XON "MSH-22" "Business organization that originated and is accountable for the content of the message."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1823
* 22 ^comment = "Currently, MSH provides fields to transmit both sending/receiving applications and facilities (MSH.3 – MSH.6). However, these levels of organization do not necessarily relate to or imply a legal entity such as a business organization. As such, multiple legal entities (organizations) mightshare a service bureau, with the same application and facility identifiers. Another level of detail is required to delineate the various organizations using the same service bureau.\n\nTherefore, the Sending Responsible Organization field provides a complete picture from the application level to the overall business level. The Business Organization represents the legal entity responsible for the contents of the message.\n\nUse Case #1: A centralized system responsible for recording and monitoring instances of communicable diseases enforces a stringent authentication protocol with external applications that have been certified to access its information base. In order to allow message exchange, the centralized system mandates that external applications must provide the identity of the business organization sending the message (*Sending Responsible Organization*), the organization it is sending the message to (*Receiving Responsible Organization*, in this case the \"owner\" of the communicable diseases system), the network address from which the message has originated (*Sending Network Address*), the network address the message is being transmitted to (*Receiving Network Address*). The organization responsible for protecting the information stored within the communicable disease system requires this authentication due to the sensitive nature of the information it contains."
* 23 0..1 XON "MSH-23" "Business organization that is the intended receiver of the message and is accountable for acting on the data conveyed by the transaction."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1824
* 23 ^comment = "This field has the same justification as the Sending Responsible Organization except in the role of the Receiving Responsible Organization. The receiving organization has the legal responsibility to act on the information in the message.\n\nSee MSH-22 above for Use Case."
* 24 0..1 HD "MSH-24" "Identifier of the network location the message was transmitted from. Identified by an OID or text string (e.g., URI). The reader is referred to the \"Report from the Joint W3C/IETF URI Planning Interest Group: Uniform Resource Identifiers (URIs), URLs, and Uniform Resource Names (URNs): Clarifications and Recommendations\".footnote:[The URI is: http://www.ietf.org/rfc/rfc3305.txt. Note: All IETF documents are available online, and RFCs are available through URIs using this format.]"
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1825
* 24 ^comment = "As with the Sending/Receiving Responsible Organization, the Sending Network Address provides a more detailed picture of the source of the message. This information is lower than the application layer, but is often useful/necessary for routing and identification purposes. This field SHOULD only be populated when the underlying communication protocol does not support identification of sending network locations.\n\nAn agreement about the specific values and usage must exist among messaging partners. Use Case:\n\nDr. Hippocrates works for the ''Good Health Clinic\" (Sending facility) with a laptop running application XYZ (Sending App). He needs to talk to the provincial pharmacy system. He dials in and is assigned a network address. He then sends a message to the pharmacy system, which transmits a response back to him. Because the underlying network protocol does not have a place to communicate the sender and receiver network addresses, it therefore requires these addresses to be present in a known position in the payload.\n\nThere might be many doctors running application XYZ. In addition, the network address assigned to the laptop might change with each dial-in. This means there is not a 1..1 association between either the facility or the application and the network address.\n\nMSH||RX|GHC|||||OMP^O09^OMP_O09||||||||||||||||05782|\n\nExample 1: The Lone Tree Island satellite clinic transmits a notification of patient registration to its parent organization Community Health and Hospitals. The communication protocol does not support the identification of sending network location, so the sending network location is identified in the message by using its enterprise-wide network identifier \"HNO2588\".\n\nMSH||Reg|Lone|||||ADT^A04^ADT_A04||||||||||||||||HN02588|\n\nExample 2: The Stone Mountain satellite clinic transmits a notification of patient registration to its parent organization Community Health and Hospitals. The sending network location is identified by using its URI.\n\nMSH||Reg|Stone|||||ADT^A04^ADT_A04|||||||||||||||| ^ftp://www.goodhealth.org/somearea/someapp^URI|\n\nExample 3: The Three Rivers satellite clinic transmits a notification of patient registration to its parent organization Community Health and Hospitals. The sending network location is identified by using its Ipv4 address, port 5123 at node 25.152.27.69. The following example shows how to represent a port and DNS address using HD as the scheme\n\nMSH||Reg|TRC||||| ADT^A04^ADT_A04||||||||||||||||5123^25.152.27.69^DNS|\n\nExample 4: The Bayview satellite clinic transmits a notification of patient registration to its parent organization Community Health and Hospitals. The sending network location is identified by using \"4086::132:2A57:3C28\" its IPv6 address.\n\nMSH||REG|BAY||||| ADT^A04^ADT_A04||||||||||||||||^4086::132:2A57:3C28^IPv6|"
* 25 0..1 HD "MSH-25" "Identifier of the network location the message was transmitted to. Identified by an OID or text string (e.g., URL)."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1826
* 25 ^comment = "This is analogous with the Sending Network Address, however in the receiving role.\n\nThis field SHOULD only be populated when the underlying communication protocol does not support identification receiving network locations"
* 26 0..1 CWE "MSH-26" "This field defines the security classification (as defined by ISO/IEC 2382-8:1998(E/F)/ T-REC-X.812-1995) of an IT resource, in this case the message, which MAY be used to make access control decisions."
* 26 from http://terminology.hl7.org/ValueSet/v2-0952 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #C
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2429
* 26 ^comment = "Conditionality Predicate: Required if MSH-27 or MSH-28 is valued, Optional if neither MSH-27 nor MSH-28 is valued.\"Use of this field supports the business requirement for declaring the level of confidentiality (classification) for a given message.\n\nNote: This field is used to declare the ‘high watermark’, meaning the most restrictive handling that needs to be applied to the message based on its content requiring a certain security classification level and SHOULD be viewed as the v2 equivalent of the document header in CDA, in v3 models, and in FHIR Security Labels\n\nthe high water mark in the header of message content is -described in the Guide to the HL7 Healthcare Privacy and Security Classification System, Release 1, which is platform independent.\n\nRefer to _Externally-defined HL7 Table 0952 – HL7 Confidentiality Code_ in Chapter 2C, Code Tables, for suggested values. Use of this table is recommended. The codes in this table are comprehensive, non-overlapping hierarchical codes: Very Restricted > Restricted > Normal > Moderate > Low > Unrestricted. Restrictions to a comprehensive, non-overlapping set of codes is required for purposes of access control system algorithms such as Bell–LaPadula Mode, which is used to adjudicate access requests against privacy policies."
* 27 0..0 CWE "MSH-27" "This field is repeatable and conveys instructions to users and receivers for secure distribution, transmission, and storage; dictate obligations or mandated actions; specify any action prohibited by refrain policy such as dissemination controls; and stipulate the permissible purpose of use of an IT resource."
* 27 from http://terminology.hl7.org/ValueSet/v2-0953 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2430
* 27 ^comment = "Refer to _Externally define HL7 Table 0953 – Security Control_ in Chapter 2C, Code Tables, for suggested values."
* 28 0..0 ST "MSH-28" "Used to convey specific instructions about the protection of the patient's data, which must be rendered to end users in accordance with patient consent directive, organizational policy, or jurisdictional law. For example, in US law 42 CFR Part 2, disclosed information made with patient consent must include a renderable “Prohibition on re-disclosure” warning (§ 2.32[multiblock footnote omitted]) In addition, organizational policy might require that some or all of the ARV field privacy tag values be rendered to end users, e.g., marking a consult note with “Restricted Confidentiality” or with sensitivity tags such as “VIP” or “EMP” for employee of the organization."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2431
* 28 ^comment = "This field MAY also be used to specify instructions about the release of information to family and friends (e.g., \"Do not release information to patient's brother, Adam Everyman\"). These instructions MAY be in conjunction with other fields (as elected by the system)."