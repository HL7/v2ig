Logical: NST
Parent: $Segment
Id: NST
Title: "HL7 v2 NST Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Application Control-Level Statistics"
* 1 1..1 ID "NST-1" "This field indicates the availability of statistics. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no Indicator_] for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1173
* 1 ^comment = "N - the responding application does not keep any statistics. If the value \"N\" is specified, the response message is used to signify to the initiating application that the communication link between the initiating application and the responding application is operational (and fields 2‑15 are empty in the response message).\n\nY - the responding application does keep statistics, fields 4 and 5 are required (and the response message contains one or more not empty or not unvalued fields in the range 2‑3, 6‑15)."
* 2 0..1 ST "NST-2" "This field identifies a particular lower level link (e.g., a port number)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1174
* 3 0..1 ID "NST-3" "This field identifies (in certain systems) whether a lower level source identifier is an initiate or accept type. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70332[_HL7 Table 033__2 – Sou__rce Type_] in Chapter 2C, Code Tables, for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0332 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1175
* 4 0..1 DTM "NST-4" "This field contains the date/time stamp of the start of the collection of the statistics reported in fields 6‑15 of this segment. It is strongly recommended that this value include seconds."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1176
* 5 0..1 DTM "NST-5" "This field contains the date/time stamp of the end of the statistics collection period reported in fields 6‑15 of this segment. It is strongly recommended that this value include seconds."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1177
* 6 0..1 NM "NST-6" "This field contains the number of characters received."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1178
* 7 0..1 NM "NST-7" "This field contains the number of characters sent."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1179
* 8 0..1 NM "NST-8" "This field contains the number of messages received."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1180
* 9 0..1 NM "NST-9" "This field contains the number of messages sent."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1181
* 10 0..1 NM "NST-10" "This field contains the number of messages received with checksum errors."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1182
* 11 0..1 NM "NST-11" "This field contains the number of messages received with length errors."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1183
* 12 0..1 NM "NST-12" "This field contains the number of \"other\" invalid messages received (excluding length and checksum errors)."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1184
* 13 0..1 NM "NST-13" "This field contains the number of connect timeout errors."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1185
* 14 0..1 NM "NST-14" "This field contains the number of timeouts while waiting for a response to an initiated message."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1186
* 15 0..1 NM "NST-15" "This field contains the number of application control-level errors in response to an initiated message."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1187