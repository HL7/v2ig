Logical: MSA
Parent: $Segment
Id: MSA
Title: "HL7 v2 MSA Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Message Acknowledgment"
* 1 1..1 ID "MSA-1" "This field contains an acknowledgment code, see message processing rules. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70008[_HL7 Table 0008 - Acknowledgment Code_] for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0008 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #18
* 2 1..1 ST "MSA-2" "This field contains the message control ID of the message sent by the sending system. It allows the sending system to associate this response with the message for which it is intended."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 199
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "199"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #10
* 3 0..1 BackboneElement "MSA-3" "MSA-3"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #W
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #20
* 3 ^comment = "*Attention: The _MSA-3_ was deprecated as of v 2.4* and the detail was withdrawn and removed from the standard as of v 2.7**. The reader is referred to the ERR segment. The ERR segment allows for richer descriptions of the erroneous conditions.**"
* 4 0..1 NM "MSA-4" "This optional numeric field is used in the sequence number protocol."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #21
* 5 0..1 BackboneElement "MSA-5" "MSA-5"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #W
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #22
* 5 ^comment = "*Attention: The _MSA-5_ was deprecated as of v2.2* and the detail was withdrawn and removed from the standard as of v 2.5."
* 6 0..1 BackboneElement "MSA-6" "MSA-6"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #W
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #23
* 6 ^comment = "*Attention: The _MSA-3_ was deprecated as of v 2.4* and the detail was withdrawn and removed from the standard as of v 2.7**. The reader is referred to the ERR segment. The ERR segment allows for richer descriptions of the erroneous conditions.**"
* 7 0..1 NM "MSA-7" "If present, indicates the number of messages the Acknowledging Application has waiting on a queue for the Requesting Application. These messages would then need to be retrieved via a query. This facilitates receiving applications that cannot receive unsolicited message (i.e., polling)."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1827
* 7 ^comment = "For example, if there are 3 low priority messages, 1 medium priority message and 1 high priority message, the message waiting number would be 5, because that is the total number of messages.\n\nUse Case: An application that is playing a \"requesting\" role has limited network access to a centralized application playing a receiving role. When the requesting application contacts the acknowledging application with a regular update or query message, the acknowledging application replies with the appropriate response message, along with an indication that there are urgent messages waiting. The requesting application submits a query to retrieve the queued messages."
* 8 0..1 ID "MSA-8" "If present, indicates that the Sending Application has messages waiting on a queue for the Receiving Application. These messages would then need to be retrieved via a query. This facilitates receiving applications that cannot receive unsolicited messages (i.e., polling). The code specified identifies how important the most important waiting message is (and can govern how soon the receiving application is required to poll for the message)."
* 8 from http://terminology.hl7.org/ValueSet/v2-0520 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 8 ^extension[=].extension[0].url = "min"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^extension[=].extension[+].url = "max"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1828
* 8 ^comment = "For example, if there are 3 low priority messages, 1 medium priority message and 1 high priority message, the message waiting priority would be 'high', because that is the highest priority of any message waiting.\n\nWith some applications, there is no guarantee that the sending application will be running. The receiving application is therefore unable to submit unsolicited messages. To mitigate this, a polling approach is used where the receiving application requests any queued messages when it is connected. To avoid the network overhead of continuous polling, the sending application needs a way to indicate that there are queued messages awaiting retrieval. It is also useful to provide an indication of the importance of those messages to indicate how quickly they must be retrieved.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70520[_HL7 Table 0520 - Message Waiting Priority_] in Chapter 2C, Code Tables, for valid values.\n\nSee MSA-7 above for Use Case."