Logical: AIG
Parent: $Segment
Id: AIG
Title: "HL7 v2 AIG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Appointment Information - General Resource"
* 1 1..1 SI "AIG-1" "This field contains a number that uniquely identifies the information represented by this segment in this transaction for the purposes of addition, change or deletion."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #896
* 2 0..1 ID "AIG-2" "This field contains the action to be taken when updating or modifying information in this segment from previously sent interface transactions. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #763
* 2 ^comment = "This field is conditionally required. It is required for all updating or modifying trigger events."
* 3 0..1 CWE "AIG-3" "This field contains the ID number and name of the resource being requested or scheduled for an appointment. This field is used to identify a specific resource being requested, or a specific resource that has been scheduled for an appointment. If the specific resource is not known but the type of resource is, _AIG-4 Resource Type_ is used to identify the type of resource required or scheduled."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #897
* 3 ^comment = "At a minimum, the ID number component should be supplied to identify either the specific resource being requested or the specific resource that has been scheduled. For inter-enterprise communications, for which a shared ID number may not be available, the minimum components required to uniquely identify a resource may be defined by site-specific negotiations.\n\nThis field is conditionally required for this segment. In new schedule request messages, it is required if the request asks that a specific resource be scheduled. For all other request messages, the specific resource should be identified if the information is available (either because a specific resource was initially requested, or because the filler application returned the ID of the specific resource that has been scheduled).\n\nThis field is required for all unsolicited transactions from the filler application.\n\nThis field is optional for all query transactions."
* 4 1..1 CWE "AIG-4" "This field identifies the role of the resource requested/scheduled for this appointment. For requests, if a specific resource is not identified in _AIG-3-Resource ID_, then this field identifies the type of resource that should be scheduled by the filler application. At a minimum, the type of the identifier component should be valued."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #898
* 5 0..0 CWE "AIG-5" "This field identifies the requested resource as a member of the indicated group. If, in a Schedule Request Message (SRM), no specific resource is requested, but a resource type is requested, this field can be used to further qualify the type of resource being requested."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #899
* 6 0..1 NM "AIG-6" "This field contains the quantity of the specified resource or resource type identified in either or both of the preceding two fields. If it is not valued, this field defaults to a value of one (1)."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "5"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = true
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #900
* 7 0..1 CNE "AIG-7" "This field contains the units of the resource requested, whose quantity is given in the preceding field. This field should be valued according to the recommendations in Chapters 2 and 7. If this field is not valued, the unit of each (code \"ea\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO+ and ANS+ unit codes."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #901
* 7 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 8 0..1 DTM "AIG-8" "This field contains the date and time this service needs for the appointment. This field allows the application to identify that the service is required for the appointment at a different time than the appointment's start date/time"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #C
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1202
* 8 ^comment = "This field is conditionally required. If a value for _AIG-9-Start Date/Time Offset_ is not provided, then a value is required for this field. To specify that there is no difference between the appointment's start date/time and the resource's start date/time either replicate the appointment's start date/time into this field, or specify an offset of zero (0) in _AIG-9-Start Date/Time Offset_ and any valid time unit code in _AIG-10-Start Date/Time Offset Units_."
* 9 0..1 NM "AIG-9" "This field contains the offset that this resource needs for the appointment, expressed in units of time relative to the scheduled start date/time. This field indicates to the application that the resource is required for the appointment at a different time than the appointment's start date/time. The first component indicates the offset amount. An offset of zero (0), or an unvalued field, indicates that the resource is required at the start date/time of the appointment."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #C
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #891
* 9 ^comment = "A positive offset (an unsigned or positive number) indicates that the resource is required after the appointment's start date/time. Specifying a negative offset indicates that the resource is required prior to the specified start date/time of the appointment. Negative offsets are allowed, and sites should clearly define the effect of a negative offset on the appointment's start date/time.\n\nThis field is conditionally required. If a value for _AIG-8-Start Date/Time_ is not provided, then a value is required for this field. To specify that there is no difference between the appointment's start date/time and the resource's start date/time either replicate the appointment's start date/time into this field, or specify an offset of zero (0) in _AIG-9-Start Date/Time Offset_ and any valid time unit code in _AIG10-Start Date/Time Offset Units_."
* 10 0..1 CNE "AIG-10" "This field contains a code describing the units of time used for expressing _AIG-9-Start Date/Time Offset_. This field should be valued according to the recommendations made in Chapters 2 and 7. If this field is not valued, the ISO base unit of seconds (code \"_s_\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO+ and ANS+ unit codes."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #892
* 10 ^comment = "This field is conditionally required. If a value for _AIG-9-Start Date/Time Offset_ is provided, then a value is required for this field.\n\nAs of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 11 0..1 NM "AIG-11" "This field contains the duration for which the resource is requested/scheduled for this appointment, if it is different than the overall duration of the requested/scheduled appointment. This field indicates to the application that a resource is required for a different amount of time than the appointment's overall duration. An unvalued duration indicates that the resource is required from its start date/time offset (specified in the previous two fields) until the end of the appointment. If no start date/time offset is specified, then the resource is required for the full duration of the appointment."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #893
* 11 ^comment = "This field must be a positive, non-zero number. A negative number or zero (0) is nonsensical in the context of a duration."
* 12 0..1 CNE "AIG-12" "This field contains a code describing the units of time used for expressing the _AIG-11-Duration_ field. This field should be valued according to the recommendations in Chapters 2 and 7. If this field is not valued, the ISO base unit of seconds (code \"_s_\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO+ and ANS+ unit codes."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #894
* 12 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 13 0..1 CWE "AIG-13" "This field contains a code indicating whether the identified resource can be substituted with an equivalent resource by the filler application. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70279[_User-Defined Table 0279 - Allow Substitution Codes_] for suggested codes."
* 13 from http://terminology.hl7.org/ValueSet/v2-0279 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #C
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #895
* 13 ^comment = "This field is conditionally required. It is required for all request messages. It is optional for all unsolicited transactions, and for all query messages."
* 14 0..1 CWE "AIG-14" "This field contains a code that describes the requested/scheduled status of scheduling resource or activity, from the point of view of the filler application. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70278[_User-Defined Table 0278 - Filler Status Codes_] for suggested codes."
* 14 from http://terminology.hl7.org/ValueSet/v2-0278 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #C
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #889
* 14 ^comment = "This is a conditionally required field. Because the information contained in this field is only appropriate in transactions originating from a filler application, it is required for those messages. This includes all unsolicited transactions originating from a filler application, as well as all response messages originating from a filler application. This field is optional for all transactions originating from placer, querying and auxiliary applications. It is recommended that this field be left unvalued in transactions originating from applications other than the filler application."