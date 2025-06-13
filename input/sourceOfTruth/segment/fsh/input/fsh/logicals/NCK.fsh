Logical: NCK
Parent: $Segment
Id: NCK
Title: "HL7 v2 NCK Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "System Clock"
* 1 1..1 DTM "NCK-1" "This field contains an HL7 time stamp. It is strongly recommended that seconds be included. If the message contains an NST or NSC segment, the NCK segment is optional. If the NCK segment is present, this field is required. If present in the NMQ message, or the unsolicited NMD message, it contains the system date/time of the sending system. If present in the NMR response message, it contains the responding system's date/time."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 24
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1172