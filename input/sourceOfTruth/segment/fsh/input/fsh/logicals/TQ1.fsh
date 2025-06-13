Logical: TQ1
Parent: $Segment
Id: TQ1
Title: "HL7 v2 TQ1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Timing/Quantity"
* 1 0..1 SI "TQ1-1" "For the first timing specification transmitted, the sequence number shall be 1; for the second timing specification, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1627
* 2 0..1 CQ "TQ1-2" "This field specifies the numeric quantity of the service that should be provided at each service interval. For example, if two blood cultures are to be obtained every 4 hours, the quantity would be '2', or if three units of blood are to be typed and cross-matched, the quantity would be '3'. The default value for this field is '1'."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1628
* 2 ^comment = "If multiple identical services are to be requested, it is strongly recommended that multiple service requests be placed, giving each service request its own unique placer/filler number."
* 3 0..0 RPT "TQ1-3" "The repeating frequency with which the treatment is to be administered. It is similar to the frequency and SIG code tables used in order entry systems."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1629
* 3 ^comment = "This field may be repeated to build up more complex repeat patterns. For example, daily at bedtime can be represent as \"|QD~HS|\".\n\nWhen the quantity timing specification must change to a different repeat pattern after some period of time, a new TQ1 segment must be used to show the new repeat pattern. Note that the end date of the current TQ1 will show when the current timing specification ends, and the start date of the next TQ1 shows when the new timing specification begins. The Conjunction field, TQ1-12 determines if the next TQ1 segment is to be performed sequentially or in parallel."
* 4 0..0 TM "TQ1-4" "This field explicitly lists the actual times referenced by the code in TQ1-3. This field will be used to clarify the TQ1-3 in cases where the actual administration times vary within an institution. If the time of the service request spans more than a single day, this field is only practical if the same times of administration occur for each day of the service request. If the actual start time of the service request (as given by TQ1-7) is after the first explicit time, the first administration is taken to be the first explicit time after the start time. In the case where the patient moves to a location having a different set of explicit times, the existing service request may be updated with a new quantity/timing segment showing the changed explicit times."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1630
* 4 ^comment = "Usage Note: This field is not valued if a _Repeat Pattern_ is not present."
* 5 0..0 CQ "TQ1-5" "This field is used to define the interval between schedules for service request or bottle records. If this field contains a value, it overrides any value in the explicit time interval field. The units component of the CQ data type is constrained to units of time."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1631
* 5 ^comment = "Examples:\n\nTQ1|1|1|Q1H||60^min&&ANS+ - Q1H is defined with an interval between services of 60 minutes\n\nTQ1|1|1|Q6H||6^hr&&ANS+ - Q6H is defined with an interval between services of 6 hours\n\nTQ1|1|1|QD||1^d&&ANS+ - QD is defined with an interval between services of 1 day"
* 6 0..1 CQ "TQ1-6" "This field contains the duration for which the service is requested."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1632
* 6 ^comment = "The quantity component of this field must be a positive, non-zero number. The unit's portion of this field is constrained to units of time.\n\nExample: Whirlpool twenty minutes three times per day for 3 days. Three days is the service duration.\n\nTQ1|1||TID|||3^d&&ANS+||||||20^min&&ANS+|9<cr>"
* 7 0..1 DTM "TQ1-7" "This field may be specified by the requester, in which case it indicates the earliest date/time at which the services should be started. In many cases, however, the start date/time will be implied or will be defined by other fields in the service request record (e.g., urgency ‑ STAT). In such a case, this field will be empty."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1633
* 7 ^comment = "The filling service will often record a value in this field after receipt of the service request, however, and compute an end time on the basis of the start date/time for the filling service's internal use."
* 8 0..1 DTM "TQ1-8" "When filled in by the requester of the service, this field should contain the latest date/time that the service should be performed. If it has not been performed by the specified time, it should not be performed at all. The requester may not always fill in this value, yet the filling service may fill it in on the basis of the instruction it receives and the actual start time."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1634
* 8 ^comment = "Regardless of the value of the end date/time, the service should be stopped at the earliest of the date/times specified by either the duration or the end date/time."
* 9 0..0 CWE "TQ1-9" "This field describes the urgency of the request. If this field is blank, the default is R. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70485[User-Defined Table 0485 – Extended Priority Codes] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0485 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1635
* 10 0..1 TX "TQ1-10" "This is a free text field that describes the conditions under which the drug is to be given. For example, \"PRN pain,\" or \"to keep blood pressure below 110.\""
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "250"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1636
* 10 ^comment = "The presence of text in this field should be taken to mean that human review is needed to determine the how and/or when this drug should be given.\n\nFor complex codified conditions see the TQ2 segment below."
* 11 0..1 TX "TQ1-11" "This field is a full text version of the instruction (optional)."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 11 ^extension[=].extension[0].url = "length"
* 11 ^extension[=].extension[=].valueInteger = "250"
* 11 ^extension[=].extension[+].url = "noTruncate"
* 11 ^extension[=].extension[=].valueInteger = false
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1637
* 12 0..1 ID "TQ1-12" "This field indicates that a second TQ1 segment is to follow. Refer To link:#HL70472[HL7 Table 0472 – TQ Conjunction ID] in Chapter 2C, Code Tables, for allowed values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0472 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #C
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1638
* 12 ^comment = "For continuous or periodic services, the point at which the service is actually stopped is determined by the field TQ1-8 end date/time and TQ1-6 duration, whichever indicates an earlier stopping time. Ordinarily, only one of these fields would be present.\n\nCondition Rule: If the TQ1 segment is repeated in the message, this field must be populated with the appropriate Conjunction code indicating the sequencing of the following TQ1 segment."
* 13 0..1 CQ "TQ1-13" "This field contains the duration for which a single performance of a service is requested. The quantity component of this field must be a positive, non-zero number when populated. The units component is constrained to be units of time."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1639
* 13 ^comment = "Example: Whirlpool twenty minutes three times per day for three days. Twenty minutes is the occurrence duration.\n\nTQ1|1||TID|||3^d&&ANS+||||||20^min&&ANS+|9<cr>"
* 14 0..1 NM "TQ1-14" "This field contains the total number of occurrences of a service that should result from this service request. If both the end date/time (TQ1-8) and the total occurrences are valued and the occurrences would extend beyond the end date/time, then the end date/time takes precedence. Otherwise the number of occurrences takes precedence."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "10"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1640
* 14 ^comment = "Example: Whirlpool twenty minutes three times per day for three days. The total occurrences would be 9.\n\nTQ1|1||TID|||3^d&&ANS+||||||20^min&&ANS+|9<cr>"