Logical: ARQ
Parent: $Segment
Id: ARQ
Title: "HL7 v2 ARQ Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Appointment Request"
* 1 1..1 EI "ARQ-1" "This field contains placer application's permanent identifier for the appointment request (and the scheduled appointment itself, when confirmed as booked by the filler application). This is a composite field. The first component is a string that identifies an individual appointment request, or booked appointment. It is assigned by the placer application, and it identifies an appointment request, and the subsequent scheduled appointment, uniquely among all such requests and/or booked appointments from a particular requesting application. If the placer appointment ID identifies a parent of a repeating schedule request, then the individual scheduled child appointments can be uniquely identified either by a new placer appointment ID or the parent's placer appointment ID plus an occurrence number, specified in _ARQ-3-Occurrence number._"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #860
* 1 ^comment = "The second through fourth components contain the assigning authority identifying information."
* 2 0..1 EI "ARQ-2" "This field contains the filler application's permanent identifier for the appointment request (and the scheduled appointment itself, when confirmed as a booked slot by the filler application). This is a composite field. The first component is a string that identifies an individual appointment request, or booked appointment. It is assigned by the filler application, and it identifies an appointment request and the subsequent scheduled appointment, uniquely among all such requests and/or booked appointments from a particular processing application. If the filler appointment ID identifies a parent of a repeating schedule request, then the individual scheduled child appointments can be uniquely identified either by a new filler appointment ID or the parent's filler appointment ID plus an occurrence number, specified in _ARQ-3-Occurrence number_."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #861
* 2 ^comment = "The second through fourth components contain the assigning authority identifying information. This is a conditionally required field. On initial request messages and other messages where a filler has not yet assigned a filler appointment ID, this field should not contain a value. In all other subsequent messages, where a filler application has assigned a filler appointment ID and communicated it to other applications, this field is required."
* 3 0..1 NM "ARQ-3" "This field is used in conjunction with the placer appointment ID and/or the filler appointment ID to uniquely identify an individual occurrence (a child) of a parent repeating schedule appointment."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "5"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #862
* 3 ^comment = "This field is conditionally required. If the transaction using this segment is meant to apply only to one occurrence of a repeating appointment, and an occurrence number is required to uniquely identify the child appointment (that is, the child does not have a separate and unique placer appointment ID or filler appointment ID), then this field is required."
* 4 0..1 EI "ARQ-4" "This field contains a unique identifier for the Placer Group as referenced by the Placer application. A Placer Order Group is a set of appointments grouped together by the placer application, and subsequently identified by the placer application."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #218
* 4 ^comment = "The second through fourth components contain the assigning authority identifying information."
* 5 0..1 CWE "ARQ-5" "This field contains an identifier code for the schedule in which this appointment should be (or is) booked. This field is provided for situations in which filler applications maintain multiple schedules, and in which a particular resource or set of resources is controlled by more than one of those schedules."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #864
* 5 ^comment = "If a new appointment must be booked, it may be necessary to provide a schedule ID to uniquely identify the intended slot(s) being requested in the transaction. After the request has been assigned to one or more slots; however, the filler application should assign a unique filler appointment ID (see sections _10.6.1.1_, \"_ARQ-1 Placer Appointment ID (EI) 00860_,\" and _10.6.1.2_, \"_ARQ-2 Filler Appointment ID (EI) 00861_).\" This filler appointment ID, as its definition indicates, should uniquely identify the appointment among all such requests and appointments within the filler application. This means that, once assigned, the filler appointment ID should uniquely identify the appointment (either as a request or as a booked appointment) without a need to provide the schedule ID too. As a cautionary note regarding implementation, if the filler appointment ID would not otherwise be unique, it may be necessary to include the schedule ID as part of the filler appointment ID. This can be done either by prefixing the appointment ID with the schedule ID, or by appending the schedule ID to the appointment ID."
* 6 0..1 CWE "ARQ-6" "This field contains the identifier code for the reason that the request event is being triggered. This field may contain a code describing the cancel reason, the delete reason, the discontinue reason, the add reason, or any other code describing the reason that a specific event is occurring."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #865
* 7 0..1 CWE "ARQ-7" "This field contains the identifier code for the reason that the appointment is to take place. This field may contain a Universal Service ID describing the observation/test/battery/procedure or other activity that is to be performed during the requested appointment, similar to the Universal Service ID defined for the OBR segment in Chapter 4 on Order Entry. It may also contain a site-specific code describing a pre-defined set of reasons that an appointment may be set to occur. This code can be based on local and/or universal codes. The use of universal codes is recommended. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70276[_User-defined Table 0276 - Appointment reason codes_] in Chapter 2C, Code Tables, for suggested values. This table provides codes for appointment reasons such as routine appointment, previously unscheduled walk-in visit, etc."
* 7 from http://terminology.hl7.org/ValueSet/v2-0276 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #866
* 8 0..1 CWE "ARQ-8" "This field contains an identifier code for the type of appointment being requested. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70277[_User-Defined Table 0277 - Appointment Type Codes_] in Chapter 2C, Code Tables, for suggested values. This table provides codes for appointment types such as routine schedule request, request for a tentative appointment, etc."
* 8 from http://terminology.hl7.org/ValueSet/v2-0277 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #867
* 9 0..1 NM "ARQ-9" "This field contains the amount of time being requested for the appointment. In cases of requests for repeating appointments, this field describes the duration of one instance of the appointment. If this field is unvalued, then the institution's standard duration for the type of appointment requested will be assumed."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "5"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #868
* 9 ^comment = "The appointment duration field must contain a positive, non-zero number. A negative number or zero (0) is nonsensical in the context of a duration."
* 10 0..1 CNE "ARQ-10" "This field contains a code describing the units of time used in expressing the _ARQ-9-Appointment duration_ field. This field should be valued according to the recommendations in Chapters 2 and 7. If this component is not valued, the ISO base unit of seconds (code \"_s_\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO and ANSI+ unit codes."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #869
* 10 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 11 0..0 DR "ARQ-11" "This field contains the date and time that the appointment is requested to begin, in the form of a date/time range. The first component contains the earliest date and time that the appointment may be scheduled to begin. The second component contains the latest date and time that the appointment may be scheduled to begin."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #870
* 11 ^comment = "The DTM (time stamp) data type allows for two components: the time stamp, and a degree of precision. If used, the degree of precision should be separated from the time stamp by a subcomponent delimiter.\n\nIf only the range start date/time has been provided, then the range end date/time is assumed to be infinity. Using this scenario is equivalent to requesting the next available slot on/after a particular date and time. If only the range end date/time has been provided, then the range start date/time is assumed to be immediate. Using this scenario is equivalent to requesting the appointment start some time between the current date and time, and the specified range end date/time. Requesting an appointment when the range start and range end date/time are the same is equivalent to requesting a specific slot on a schedule. If this field is unvalued, then the filler application will assume that the next available slot should be scheduled, using the institution's processing rules for scheduling appointments.\n\nThis field may repeat. Repetitions of this field are used to construct a list of acceptable ranges. Repetitions of this field are connected with a logical OR to construct this list. This procedure allows applications to provide multiple preferences for the scheduling of appointments. Applications should take steps to ensure that nonsensical ranges are not indicated in this field (for example, redundant ranges).\n\nExamples:\n\nSchedule the appointment to begin at some time between 8:00AM on Tuesday, May 17th, 1994 and 12:00PM on Friday, May 20th, 1994 local time:\n\n...|199405170800^199405201200|...\n\nSchedule the appointment in the next available slot on/after 6:00AM on Monday, April 25th, 1994 local time:\n\n...|199405250600^|...\n\nNote: The field value ...|199405250600|... is equivalent to making the above request, according to the HL7 rules for processing fields.\n\nSchedule the appointment in the next available slot on/*[.underline]#before#* 6:00AM on Monday, April 25th, 1994 local time:\n\n...|^199405250600|...\n\nSchedule the appointment in the next available slot:\n\n...||...\n\nSchedule the appointment to begin on any weekday during the two weeks beginning Monday, April 4th, 1994. In this example, the degree of precision (sub)component of the time stamp is used to indicate that the date/time ranges refer to the institution's standard operating day:\n\n...|199404040000&D^199404080000&D~199404110000&D^199404150000&D|...\n\nSchedule the appointment in the next available slot that does not occur during the May 1994 HL7 Working Group Meeting:\n\n...|^199405161600~199405230800^|...\n\nSchedule the appointment to begin on/before 4:00PM on Thursday, December 23rd, 1993, or any weekday between Monday, December 27th, and Thursday, December 30th, or on/after 8:00AM on Monday, January 3rd, 1994:\n\n...|^199312231600~199312270000&D^199312300000&D~199401030800^|..."
* 12 0..1 ST "ARQ-12" "This field contains the urgency of the request. The definition of this field is equivalent to the definition of TQ1-9 in the Order Entry chapter (Chapter 4), \"Priority\" component.\""
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "5"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #871
* 13 0..1 RI "ARQ-13" "This field contains the interval between repeating appointments. The default setting indicates that the appointment should occur once, if the component is not valued. If an explicit time interval is specified for the repeat pattern, then it specifies the actual time(s) at which the appointment should be scheduled. The _ARQ-11-Requested Start Date/Time Range_ ought to indicate the first repetition that should occur."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #872
* 13 ^comment = "*Note:* The subcomponent delimiter defined for the Interval component of the Quantity/Timing field definition has been replaced by a component delimiter for this field."
* 14 0..1 ST "ARQ-14" "This field indicates how long the appointment repetitions should continue, once they have begun. The default setting indicates that the appointment should occur once. If the Interval Duration is defined as indefinitely repeating, the repetition of this appointment can only be stopped by using a discontinue event."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "5"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #873
* 15 1..0 XCN "ARQ-15" "This field identifies the person responsible for requesting the scheduling of a requested appointment. This person could be the same person responsible for executing the actual appointment, or it could be the provider requesting that an appointment be made on behalf of the patient, with another provider."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #R
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #874
* 16 0..0 XTN "ARQ-16" "This field contains the phone number used to contact the placer contact person."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #875
* 17 0..0 XAD "ARQ-17" "This field contains the address used to contact the placer contact person."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #876
* 18 0..1 PL "ARQ-18" "This field contains a code that identifies the location of the placer contact person."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #877
* 19 1..0 XCN "ARQ-19" "This field identifies the person responsible for entering the request for the scheduling of an appointment. It is included to provide an audit trail of persons responsible for the request. This person may be someone other than the placer contact person, who is responsible for entering orders and requests."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #R
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #878
* 20 0..0 XTN "ARQ-20" "This field contains the phone number used to contact the _ARQ-19-Entered by Person_."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #879
* 21 0..1 PL "ARQ-21" "This field contains a code that identifies the location of the entered by person."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #880
* 22 0..1 EI "ARQ-22" "This field relates a child to its parent, when a parent-child relationship exists. It contains the placer application's permanent identifier for the parent of the appointment request. This is a composite field."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #881
* 22 ^comment = "The first component is a string that identifies the parent appointment request. It is assigned by the placer application, and identifies an appointment request uniquely among all such requests from a particular requesting application."
* 23 0..1 EI "ARQ-23" "This field relates a child to its parent, when a parent-child relationship exists. It contains the filler application's permanent identifier for the parent of the appointment request. This is a composite field."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #882
* 23 ^comment = "The first component is a string that identifies the parent appointment request. It is assigned by the filler application, and identifies an appointment request uniquely among all such requests on a particular processing application."
* 24 0..0 EI "ARQ-24" "This field is the placer application's order number for the order associated with this scheduling request."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #C
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #216
* 24 ^comment = "This field is described in detail in Chapter 4, section 4.5.1.2, \"ORC-2 – Placer Order Number.\" It is an optional field, but if a Placer order number is present, then a Filler order number (_ARQ-25 – Filler Order Number_) must also be present."
* 25 0..0 EI "ARQ-25" "This field is the order number assigned by the filler application for the order associated with this scheduling request."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #C
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #217
* 25 ^comment = "This field is described in detail in Chapter 4, section 4.5.1.3, \"ORC-3 – Filler Order Number.” It is conditionally mandatory depending on the presence of the Placer order number (_ARQ-24 – Placer Order Number_). This conditionally mandatory requirement addresses the concern that a Scheduling system cannot and should not create or fill an order. Therefore, an order must have been accepted by the filler application before scheduling the resources associated with that order."
* 26 0..1 EIP "ARQ-26" "This field contains a unique identifier for the Placer Group as referenced by the Placer application, the Filler application, or both. A Placer Group is a set of appointments grouped together by the placer application, and subsequently identified by the placer application and/or by the filler application."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #3547
* 26 ^comment = "Within each of the two Subcomponents, the first component is a string that identifies a group of appointment requests. It is assigned by the placer or filler application, and it identifies an appointment group uniquely among all such groups of requests from a particular requesting application."