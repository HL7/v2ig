Logical: TQ2
Parent: $Segment
Id: TQ2
Title: "HL7 v2 TQ2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Timing/Quantity Relationship"
* 1 0..1 SI "TQ2-1" "For the first timing specification transmitted, the sequence number shall be 1; for the second timing specification, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1648
* 2 0..1 ID "TQ2-2" "This flag defines the sequencing relationship between the current service request, and the related service request(s) specified in this TQ2 segment. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70503[HL7 Table 0503 – Sequence/Results Flag] in Chapter 2C, Code Tables, for values. If not value is present, the S - Sequential is the default value."
* 2 from http://terminology.hl7.org/ValueSet/v2-0503 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1649
* 3 0..0 EI "TQ2-3" "The placer numbers of the service request(s) to which this TQ2 segment links the current service request. This field should be populated with the appropriate \"Placer number\" from the current service request. For orders, the Placer Order Number from ORC-2 is the appropriate \"Placer number\". Repeats of this field indicate the current service request is related to multiple service requests."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1650
* 3 ^comment = "Conditional Rule: At least one of TQ2-3, TQ2-4, TQ2-5 must contain a value."
* 4 0..0 EI "TQ2-4" "The filler numbers of the service request(s) to which this TQ2 segment links the current service request. This field should be populated with the appropriate \"Filler number\" from the current service request. For orders, the Filler Order Number from ORC-3 is the appropriate \"Filler number\". Repeats of this field indicate the current service request is related to multiple service requests."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1651
* 4 ^comment = "Conditional Rule: At least one of TQ2-3, TQ2-4, TQ2-5 must contain a value."
* 5 0..0 EI "TQ2-5" "The placer group numbers of the service request(s) to which this TQ2 segment links the current service request. This field should be populated with the appropriate \"Placer group number\" from the current service request. For orders, the Placer Group Number from ORC-4 is the appropriate \"Placer group number\". Repeats of this field indicate that the current service request is related to multiple groups of service requests."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1652
* 5 ^comment = "Conditional Rule: At least one of TQ2-3, TQ2-4, TQ2-5 must contain a value."
* 6 0..1 ID "TQ2-6" "Defines the relationship between the start/end of the related service request(s) (from TQ2-3, TQ2-4, or TQ2-5) and the current service request from ORC-2, 3 or 4. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70504[HL7 Table 0504 – Sequence Condition Code] in Chapter 2C Code Tables, for allowed values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0504 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 2
* 6 ^extension[=].extension[+].url = "max"
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1653
* 6 ^comment = "Conditional Rule: Either this field or TQ2-10 must be present."
* 7 0..1 ID "TQ2-7" "Indicates if this service request is the first, last, service request in a cyclic series of service requests. If null or not present, this field indicates that the current service request is neither the first or last service request in a cyclic series of service requests. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70505[HL7 Table 0505 – Cyclic Entry/Exit Indicator] in Chapter 2C, Code Tables, for allowed values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0505 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1654
* 7 ^comment = "Conditional Rule: Should not be populated when TQ2-2 (Sequence/Results Flag) is not equal to a 'C' (cyclic service request).\n\nExample of TQ2 - 6, 7, & 8 Usage:\n\nExample of TQ2 - 6, 7, & 8 Usage:\n|===\n|Example |Translation\n|...\\|ES\\|*\\|+10^min\\|... |translates to: execute this service request the first time without evaluating the condition specified in the TQ2 segment; but repeat only its execution when the specified external service request's start or finish date/time has met this condition. This specification generates a repetition of the service request for each iteration of the cycle.\n|===\n\n*Note:* This requires that the requesting application be able to specify the placer/filler/placer group number of the last service request in the cycle in the first service request's quantity/timing specification."
* 8 0..1 CQ "TQ2-8" "Defines the interval of time between the start/end of the related service request(s) and the start/end of the current service request. The unit's component is constrained to units of time. If this field is not populated, then there should be no interruption between start/ending the current service request, and the related service request(s)."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1655
* 9 0..1 NM "TQ2-9" "The maximum number of repeats for a cyclic group."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "10"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1656
* 9 ^comment = "The total number of repeats is constrained by the end date/time of the last repeat or the end date/time of the parent, whichever is first. For example, if the total number or repeats is valued at 10 and the group has already repeated 5 times, the current order will not be repeated again if either the current order, or the prior order in the cycle, has reached its end date/time.\n\nThis field is meaningful only when TQ2-2 Sequence/Results Flag is valued with 'C'. However, even in this case this field is optional."
* 10 0..1 ID "TQ2-10" "This defines an additional or alternate relationship between this service request and other service requests. Its primary intended use is for Pharmacy administration service requests, but it may be useful for other domains. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70506[HL7 Table 0506 – Service Request Relationship] in Chapter 2C, Code Tables, for allowed values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0506 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1657
* 10 ^comment = "Conditional Rule: Either this field or TQ2-6 must be present."