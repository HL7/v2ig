Logical: AIS
Parent: $Segment
Id: AIS
Title: "HL7 v2 AIS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Appointment Information - Service"
* 1 1..1 SI "AIS-1" "This field contains a number that uniquely identifies the information represented by this segment in this transaction for the purposes of addition, change or deletion."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #890
* 2 0..1 ID "AIS-2" "This field contains the action to be taken when updating or modifying information in this segment from previously sent interface transactions. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for valid values."
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
* 3 1..1 CWE "AIS-3" "This field contains an identifier code for a service to be scheduled. This field may contain a universal service identifier describing the observation/test/battery/procedure or other activity that is to be performed during the requested appointment, similar to the universal service identifier defined for the OBR segment in the Order Entry chapter (Chapter 4). This code can be based on local and/or universal codes. The use of universal codes is recommended."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #238
* 4 0..1 DTM "AIS-4" "This field contains the date and time this service needs for the appointment. This field allows the application to identify that the service is required for the appointment at a different time than the appointment's start date/time."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1202
* 4 ^comment = "This field is conditionally required. If a value for _AIS-5-Start Date/Time Offset_ is not provided, then a value is required for this field. To specify that there is no difference between the appointment's start date/time and the resource's start date/time either replicate the appointment's start date/time into this field, or specify an offset of zero (0) in _AIS-5-Start Date/Time Offset_ and any valid time unit code in _AIS-6-Start Date/Time Offset Units_."
* 5 0..1 NM "AIS-5" "This field contains the offset this service needs for the appointment, expressed in units of time relative to the scheduled start date/time. This field allows the application to identify that the service is required for the appointment at a different time than the appointment's start date/time. The first component contains the offset amount. An offset of zero (0), or an unvalued field indicates that the service is required at the start date/time of the appointment."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #891
* 5 ^comment = "A positive offset (an unsigned or positive number) indicates that the service is required after the appointment's start date/time. Specifying a negative offset indicates that the service is required prior to the specified start date/time of the appointment. Negative offsets are allowed, and sites should clearly define the effect of a negative offset on the appointment's start date/time.\n\nThis field is conditionally required. If a value for _AIS-5-Start Date/Time Offset_ is not provided, then a value is required for this field. To specify that there is no difference between the appointment's start date/time and the resource's start date/time either replicate the appointment's start date/time into this field, or specify an offset of zero (0) in _AIS-5-Start Date/Time Offset_ and any valid time unit code in _AIS-6-Start Date/Time Offset Units_."
* 6 0..1 CNE "AIS-6" "This field contains a code describing the units of time used for expressing the start date/time offset. This field should be valued according to the recommendations in Chapters 2 and 7. If this field is not valued, the ISO base unit of seconds (code \"_s_\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO and ANSI+ unit codes."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #892
* 6 ^comment = "This field is conditionally required. If a value for _AIS-5-Start Date/Time Offset_ is provided, then a value is required for this field.\n\nAs of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 7 0..1 NM "AIS-7" "This field contains the duration for which the resource is requested/scheduled for this appointment, if different from the overall duration of the requested/scheduled appointment. This field indicates to the application that a resource is required for a different amount of time than the appointment's overall duration. An unvalued duration indicates that the resource is required from its start date/time offset (specified in the previous two fields) until the end of the appointment. If no start date/time offset is specified, then the resource is required for the full duration of the appointment."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #893
* 7 ^comment = "This field must be a positive, non-zero number. A negative number or zero (0) is nonsensical in the context of a duration."
* 8 0..1 CNE "AIS-8" "This field contains a code describing the units of time used for expressing the duration. This field should be valued according to the recommendations in Chapters 2 and 7. If this field is not valued, the ISO base unit of seconds (code _\"s_\") will be assumed. Refer to Chapter 7, Figures 7-6 through 7-9, for a list of ISO and ANSI+ unit codes."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #894
* 8 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nUnit of Measure Coding Systems from HL7 Table 0396\n\nUnit of Measure Coding Systems from HL7 Table 0396\n|===\n|Coding System |Description |Comment\n|ISO+ |ISO 2955.83 (units of measure) with HL7 extensions |See chapter 7.\n|ANS+ |HL7 set of units of measure |HL7 set of units of measure based upon ANSI X3.50 - 1986, ISO 2988-83, and US customary units / see chapter 7.\n|==="
* 9 0..1 CWE "AIS-9" "This field contains a code indicating whether the identified resource can be substituted with an equivalent resource by the filler application. This field is conditionally required. It is required for all request messages. It is optional for all unsolicited transactions, and for all query messages. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70279[_User-Defined Table 0279 - Allow Substitution Codes_] in Chapter 2C, Code Tables, for suggested codes."
* 9 from http://terminology.hl7.org/ValueSet/v2-0279 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #C
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #895
* 10 0..1 CWE "AIS-10" "This field contains a code that describes the requested/scheduled status of the resource or activity, from the point of view of the filler application. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70278[_User-Defined Table 0278 - Filler Status Codes_] in Chapter 2C, Code Tables, for suggested codes."
* 10 from http://terminology.hl7.org/ValueSet/v2-0278 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #889
* 10 ^comment = "This is a conditionally required field. Because the information contained in this field is only appropriate in transactions originating from a filler application, it is required for those messages. This includes all unsolicited transactions originating from a filler application, as well as all response messages originating from a filler application. This field is optional for all transactions originating from placer, querying and auxiliary applications. It is recommended that this field be left unvalued in transactions originating from applications other than the filler application."
* 11 0..0 CWE "AIS-11" "This field contains supplemental service and/or logistical information sent from the placer system to the filler system for the universal procedure code reported in field AIS-3. This field will be used to provide scheduling information detail that is not available in other, specific fields in the AIS segment. Multiple supplemental service information elements may be reported. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70411[User-defined Table 0411 – Supplemental Service Information Values]_ in Chapter 2C, Code Tables, for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0411 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1474
* 12 0..0 CWE "AIS-12" "This field contains supplemental service and/or logistical information sent from the filler system to the placer system for the procedure code reported in field AIS-3. This field will be used to report scheduling information details that is not available in other, specific fields in the AIS segment. Typically it will reflect the same information as was sent to the filler system in _AIS-11-Placer Supplemental_ information unless the scheduling was modified in which case the filler system will report what was actually performed using this field. Multiple supplemental service information elements may be reported. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70411[_User-defined Table 0411 - Supplemental service information values_] in Chapter 2C, Code Tables, for valid values.."
* 12 from http://terminology.hl7.org/ValueSet/v2-0411 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1475