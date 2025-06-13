Logical: APR
Parent: $Segment
Id: APR
Title: "HL7 v2 APR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Appointment Preferences"
* 1 0..0 SCV "APR-1" "This field is used to communicate parameters and preferences to the filler application regarding the selection of an appropriate time slot for an appointment. The first component of this field is a code identifying the parameter or preference being passed to the filler application. The second component is the actual data value for that parameter."
* 1 from http://terminology.hl7.org/ValueSet/v2-0294 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #908
* 1 ^comment = "For example, if a filler application allows preference parameters to be passed to specify a preferred start time, a preferred end time, and preferred days of the week for the appointment, it may define the parameter class codes and valid data sets based on suggested codes from file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70294[_User-defined Table 0294 - Time Selection Criteria Parameter Class Codes_] in Chapter 2C, Code Tables, for suggested values.\n\nGiven the set of parameter class codes and valid value sets from User-Defined table 0294, a placer may indicate a preferred start time of 8:00 AM on Monday, Wednesday or Friday by specifying the following in _APR-1 Time Selection Criteria_:\n\n...|PREFSTART^0800~MON^OK~WED^OK~FRI^OK~TUE^NO~THU^NO~SAT^NO~SUN^NO|...\n\nThe valid set of preferences should be determined by the placer and filler applications during implementation of the interface."
* 2 0..0 SCV "APR-2" "This field is used to communicate parameters and preferences to the filler application regarding the selection of an appropriate resource for an appointment. The first component of this field is a code identifying the parameter or preference being passed to the filler application. The second component is the actual data value for that parameter."
* 2 from http://terminology.hl7.org/ValueSet/v2-0294 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #909
* 2 ^comment = "Refer to Section _10.6.8.1_, \"_APR-1 Time Selection Criteria (SCV) 00908_,\" for an example illustrating how this mechanism works within an interface.\n\nThe valid set of preferences should be determined by the placer and filler applications during implementation of the interface. Refer to file:///E:\\\\V2\\\\v2.9%20final%20Nov%20from%20Frank\\\\V29_CH02C_Tables.docx#HL70294[_User-defined Table 0294 - Time Selection Criteria Parameter Class Codes_] in Chapter 2C, Code Tables, for suggested examples."
* 3 0..0 SCV "APR-3" "This field is used to communicate parameters and preferences to the filler application regarding the selection of an appropriate location for the appointment. The first component of this field is a code identifying the parameter or preference being passed to the filler application. The second component is the actual data value for that parameter."
* 3 from http://terminology.hl7.org/ValueSet/v2-0294 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #910
* 3 ^comment = "Refer to Section _10.6.8.1_, \"_APR-1 Time Selection Criteria (SCV) 00908_,\" for an example illustrating how this mechanism works within an interface.\n\nThe valid set of preferences should be determined by the placer and filler applications during implementation of the interface. Refer to file:///E:\\\\V2\\\\v2.9%20final%20Nov%20from%20Frank\\\\V29_CH02C_Tables.docx#HL70294[_User-defined Table 0294 - Time Selection Criteria Parameter Class Codes_] in Chapter 2C, Code Tables, for suggested examples."
* 4 0..1 NM "APR-4" "This field is used in queries returning lists of possible appointment slots, or other lists of slots. If the filler application allows it, the querying application may indicate the spacing of the slots returned to the querying application, in relation to the requested start date/time in the ARQ segment. The value in this field should be a positive integer, representing the number of minutes between slot starting times that is returned in the query."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "5"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = false
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #911
* 4 ^comment = "For example, if there is a request that an appointment with a duration of 1.5 hours be scheduled some time between 9:00 AM and 11:30 AM, and the _APR-4 Slot Spacing Criteria_ field contains a value of 15, then the list of slots returned should read as follows:\n\n9:00 - 10:30 +\n\n9:15 - 10:45 +\n\n9:30 - 11:00 +\n\n9:45 - 11:15 +\n\n10:00 - 11:30"
* 5 0..0 SCV "APR-5" "This field is used to communicate override parameters to the filler application. These override parameters allow placer applications to override specific features of filler applications such as conflict checking. It is assumed that the placer and filler applications will pass enough information to determine whether the requestor is allowed to override such features. This chapter does not provide any security or permission information."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #912
* 5 ^comment = "The first component of this field is a code identifying the parameter being passed to the filler application. The second component is the actual data value for that parameter.\n\nRefer to Section _10.6.8.1_, \"_APR-1 Time Selection Criteria (SCV) 00908_,\" for an example illustrating how this mechanism works within an interface.\n\nThe valid set of parameters should be determined by the placer and filler applications during implementation of the interface."