Logical: SCH
Parent: $Segment
Id: SCH
Title: "HL7 v2 SCH Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Schedule Activity Information"
* 1 0..1 EI "SCH-1" "This field contains the placer application's permanent identifier for the appointment request (and the scheduled appointment itself, when it has been confirmed as a booked slot by the filler application). This is a composite field."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #860
* 1 ^comment = "The first component is a string that identifies an individual appointment request, or a booked appointment. It is assigned by the placer application, and identifies an appointment request, and the subsequent scheduled appointment, uniquely among all such requests and/or booked appointments from a particular requesting application. If _SCH-1-Placer Appointment ID_ identifies a parent of a repeating schedule request, then the individual child scheduled appointments can be uniquely identified either by a new _SCH-1-Placer Appointment ID_ or by _SCH-23-Parent Placer Appointment ID_ plus an _SCH-3-Occurrence Number_.\n\nIf a schedule request originates from a placer it MUST have a placer appointment ID. If the filler sends responses, it may use the placer appointment ID and/or assign a filler appointment ID (which it would echo back to the placer to enable the placer application to associate the two). If the placer appointment ID is not present, the filler appointment ID must be present and vice versa."
* 2 0..1 EI "SCH-2" "This field contains the filler application's permanent identifier for the appointment request (and the scheduled appointment itself, when it has been confirmed as a booked slot by the filler application). This is a composite field."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #861
* 2 ^comment = "The first component is a string of up to fifteen characters that identifies an individual appointment request, or a booked appointment. It is assigned by the filler application, and identifies an appointment request, and the subsequent scheduled appointment, uniquely among all such requests and/or booked appointments from a particular processing application. If _SCH-2-Filler Appointment ID_ identifies a parent of a repeating schedule request, then the individual child scheduled appointments can be uniquely identified either by a new _SCH-2-Filler Appointment ID_ or by _SCH-25-Parent Filler Appointment ID_ plus an _SCH-3-Occurrence Number_."
* 3 0..1 NM "SCH-3" "This field is used in conjunction with _SCH-1-Placer Appointment ID_ and/or _SCH-2-Filler Appointment ID_ to uniquely identify an individual occurrence (a child) of a parent repeating schedule appointment."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "5"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #862
* 3 ^comment = "This field is conditionally required. If the transaction using this segment is intended to apply only to one occurrence of a repeating appointment, and an occurrence number is required to uniquely identify the child appointment (that is, the child does not have a separate and unique _SCH-1-Placer Appointment ID_ or _SCH-2-Filler Appointment ID_), then this field is required."
* 4 0..1 EI "SCH-4" "This field contains a unique identifier for the Placer Group as referenced by the Placer application, the Filler application, or both. A Placer Group is a set of appointments grouped together by the placer application, and subsequently identified by the placer application and/or by the filler application."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #218
* 4 ^comment = "Within each of the two subcomponents, the first component is a string that identifies a group of appointment requests. It is assigned by the Placer or Filler application, and it identifies an appointment group uniquely among all such groups of requests from a particular requesting application."
* 5 0..1 CWE "SCH-5" "This field contains an identifier code for the schedule in which this appointment is (or will be) booked. This field is provided for instances in which filler applications maintain multiple schedules, and when a particular resource or set of resources is controlled by more than one of those schedules."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #864
* 5 ^comment = "This field is provided on the SCH segment for informational purposes to applications fulfilling the placer, querying and auxiliary roles."
* 6 1..1 CWE "SCH-6" "This field contains an identifier code for the reason that the notification event was triggered. This field may contain a code describing the cancel reason, the delete reason, the discontinue reason, the add reason, the block reason or any other code describing the reason that a specific event will occur."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #883
* 6 ^comment = "This field should not have been made required but is retained as such for reasons of backwards compatibility."
* 7 0..1 CWE "SCH-7" "This field contains an identifier code for the reason that the appointment is to take place. This field may contain a Universal Service ID describing the observation/test/battery/procedure or other activity that is to take place during the requested appointment, similar to the Universal Service ID defined for the OBR segment in the Order Entry chapter (Chapter 4). It may also contain a site-specific code describing a pre-defined set of reasons that an appointment may be set to occur. This code can be based on local and/or universal codes. The use of universal codes is recommended. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70276[User-Defined Table 0276 - Appointment Reason Code]s_ in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0276 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #866
* 8 0..1 CWE "SCH-8" "This field contains the identifier code for the type of appointment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70277[_User-Defined Table 0277 - Appointment Type Codes_] in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0277 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #867
* 9 0..1 BackboneElement "SCH-9" "SCH-9"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #W
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #868
* 9 ^comment = "*_As of version 2.5, this field was retained for backward compatibility only and withdrawn and removed as of v2.7._* Refer to the TQ1 segment described in Chapter 4."
* 10 0..1 CNE "SCH-10" "This field contains a code describing the units of time used for expressing the _ARQ-9-Appointment Duration_ field. This field should be valued according to the recommendations in Chapters 2 and 7. If this component is not valued, the ISO base unit of seconds (code \"_s_\") is assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO and ANSI+ unit codes."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #B
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #869
* 10 ^comment = "*_As of version 2.5, this field is retained for backward compatibility only._* Refer to the TQ1 segment described in Chapter 4.\n\nAs of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 11 0..1 BackboneElement "SCH-11" "SCH-11"
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #884
* 11 ^comment = "*_As of version 2.5, this field was retained for backward compatibility only and withdrawn and removed as of v2.7._* Refer to the TQ1 segment described in Chapter 4."
* 12 0..0 XCN "SCH-12" "This field identifies the person responsible for requesting the scheduling of a requested appointment. Most often, this person will be the same person responsible for executing the appointment."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #874
* 13 0..1 XTN "SCH-13" "This field contains the phone number used to contact the _SCH-12-Placer Contact Person_."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #875
* 14 0..0 XAD "SCH-14" "This field contains the address used to contact the _SCH-12-Placer Contact Person_."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #876
* 15 0..1 PL "SCH-15" "This field contains a code that identifies the location of the _SCH-12-Placer Contact Person_."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #877
* 16 1..0 XCN "SCH-16" "This field identifies the person responsible for the scheduling of the requested appointment. Most often, this person will be the same person responsible for maintaining the schedule and for reviewing appointment requests."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #R
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #885
* 16 ^comment = "This field should not have been made required but is retained as such for reasons of backward compatibility."
* 17 0..1 XTN "SCH-17" "This field contains the phone number used to contact the _SCH-16-Filler Contact Person_."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #886
* 18 0..0 XAD "SCH-18" "This field contains the address used to contact the _SCH-16-Filler Contact Person_."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #887
* 19 0..1 PL "SCH-19" "This field contains a code that identifies the location of the _SCH-16-Filler Contact Person_."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #888
* 20 1..0 XCN "SCH-20" "This field identifies the person responsible for entering the request for the scheduling of an appointment. It is included to provide an audit trail of persons responsible for the request. This person may be someone other than the placer contact person, who is responsible for entering orders and requests."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #R
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #878
* 20 ^comment = "This field should not have been made required but is retained as such for reasons of backwards compatibility."
* 21 0..0 XTN "SCH-21" "This field contains the phone number used to contact the _ARQ-19-Entered by Person_."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #879
* 22 0..1 PL "SCH-22" "This field contains a code that identifies the location of the entered by person."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #880
* 23 0..1 EI "SCH-23" "This field relates a child to its parent, when a parent-child relationship exists. It contains the placer application's permanent identifier for the parent of the appointment request. This is a composite field."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #881
* 23 ^comment = "The first component is a string that identifies the parent appointment request. It is assigned by the placer application, and identifies an appointment request uniquely among all such requests from a particular requesting application."
* 24 0..1 EI "SCH-24" "This field relates a child to its parent, when a parent-child relationship exists. It contains the filler application's permanent identifier for the parent of the appointment request. This is a composite field."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #C
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #882
* 24 ^comment = "The first component is a string that identifies the parent appointment request. It is assigned by the filler application, and it identifies an appointment request uniquely among all such requests on a particular processing application.\n\nThis is a conditionally required field. On initial messages where a filler has not yet assigned a filler appointment ID, this field should not contain a value. In all other subsequent messages, where a filler application has assigned a filler appointment ID, this field is required."
* 25 0..1 CWE "SCH-25" "This field contains a code describing the status of the appointment with respect to the filler application. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70278[_User-Defined Table 0278 - Filler Status Codes_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0278 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #889
* 26 0..0 EI "SCH-26" "This field is the placer application's order number for the order associated with this scheduling filler application response."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #C
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #216
* 26 ^comment = "This field is described in detail in Section 4.5.1.2. It is an optional field, but if a Placer order number is present, then a Filler order number (Section 10.6.2.27) must also be present. Both this field and the Filler order number below may have been sent as part of the appointment request in the ARQ segment or they may be assigned by the scheduling filler application only."
* 27 0..0 EI "SCH-27" "This field is the order number assigned by the filler application for the order associated with this scheduling filler response."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #C
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #217
* 27 ^comment = "This field is described in detail in Chapter 4, Orders, section 4.5.1.3. It is conditionally mandatory depending on the presence of the placer order number (section _10.6.2.26_). This conditionally mandatory requirement addresses the concern that a Scheduling system cannot and should not create or fill an order. Therefore, an order must have been accepted by the order filler application before scheduling the resources associated with that order."
* 28 0..1 EIP "SCH-28" "This field contains a unique identifier for the Placer Group as referenced by the Placer application, the Filler application, or both. A Placer Group is a set of appointments grouped together by the placer application, and subsequently identified by the placer application and/or by the filler application."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #3547
* 28 ^comment = "Within each of the two Subcomponents, the first component is a string that identifies a group of appointment requests. It is assigned by the placer or filler application, and it identifies an appointment group uniquely among all such groups of requests from a particular requesting application."