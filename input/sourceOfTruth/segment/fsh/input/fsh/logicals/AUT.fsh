Logical: AUT
Parent: $Segment
Id: AUT
Title: "HL7 v2 AUT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Authorization Information"
* 1 0..1 CWE "AUT-1" "This field contains the ID of the coverage plan authorizing treatment. Values should be entries in a locally defined table of plan codes. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70072[_User_ _defined Table 0072- Insurance Plan ID_] is used as the HL7 identifier for the user-defined table of values for this field."
* 1 from http://terminology.hl7.org/ValueSet/v2-0072 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1146
* 2 1..1 CWE "AUT-2" "This field contains the ID of the insurance company or other entity that administers the authorizing coverage plan. Values may be entries in a locally defined table of payor codes__. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70285[User-defined Table 0285 - Insurance Company ID Codes]__ is used as the HL7 identifier for the user-defined table of values for this field."
* 2 from http://terminology.hl7.org/ValueSet/v2-0285 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1147
* 3 0..1 ST "AUT-3" "This field contains the name of the insurance company or other entity that administers the authorizing coverage plan."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "45"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1148
* 4 0..1 DTM "AUT-4" "This field contains the effective date of the authorization."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1149
* 5 0..1 DTM "AUT-5" "This field contains the expiration date after which the authorization to treat will no longer be in effect from the perspective of the coverage plan."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1150
* 6 0..1 EI "AUT-6" "This field contains the coverage application's permanent identifier assigned to track the authorization and all related billing documents. This field is conditionally required. It is not required when authorization information is being requested. However, it is required when this segment is contained in a message which is responding to a request and contains the authorization information. This is a composite field."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1151
* 6 ^comment = "The first component of this field is a string of up to 15 characters that identifies an individual authorization. It is assigned by the coverage application, and it identifies an authorization, and the subsequent billing transactions resulting from the given authorization, uniquely among all such authorizations granted from a particular processing application.\n\nThe second component is optional because this field, itself, is already defined as an _authorization identifier_.\n\nThe third component is optional. If used it should contain the application identifier for the coverage application. The application identifier is a string of up to six characters that is uniquely associated with an application. A given healthcare provider facility, or group of intercommunicating healthcare provider facilities, should establish a unique list of applications that may be potential originators and recipients, and then assign unique application identifiers to each of those applications. This list of application identifiers becomes one of the healthcare provider facility's master dictionary lists. Since applications fulfilling different application roles can send and receive referral messages containing authorizations, the coverage application identifier may not identify the application sending or receiving a particular message. Data elements on the Message Header (MSH) segment are available to identify the actual sending and receiving applications."
* 7 0..1 CP "AUT-7" "This field contains the dollar limit for reimbursement specified by the coverage plan for the authorized treatment."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1152
* 8 0..1 CQ "AUT-8" "This field contains the _requested_ number of times that the treatment may be administered to the patient without obtaining additional authorization."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1153
* 9 0..1 CQ "AUT-9" "This field contains the number of times that the authorized treatment may be administered to the patient without obtaining additional authorization."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1154
* 10 0..1 DTM "AUT-10" "This field contains the date that the authorization originated with the authorizing party."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1145
* 11 0..0 CWE "AUT-11" "Discipline – The scope of medical service(s) for which reimbursement for services rendered is requested. Examples include Physiotherapy, Occupational Therapy, Speech, etc. This field contains the requested discipline(s). Refer to Table 0522 - Requested Discipline(s) in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0522 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2375
* 12 0..0 CWE "AUT-12" "Discipline – The scope of medical service(s) for which reimbursement for services rendered is authorized. Examples include Physiotherapy, Occupational Therapy, Speech, etc. This field contains the authorized discipline(s). Refer to Table 0546 - Authorized Discipline(s) in Chapter 2C for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0546 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2376
* 13 1..1 CWE "AUT-13" "The authorization/referral type distinguishes the content of the segment as pertaining to an authorization vs a referral vs other types. Refer to Table 0551 - Authorization Referral Type in Chapter 2C for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0551 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #R
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 250
* 13 ^extension[=].extension[+].url = "max"
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3413
* 14 0..1 CWE "AUT-14" "The authorization/referral approval status indicates that status of an authorization. Refer to Table 0563 - Approval Status in Chapter 2C for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0563 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 250
* 14 ^extension[=].extension[+].url = "max"
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3414
* 15 0..1 DTM "AUT-15" "The authorization planned treatment stop date is the date that the patient's treatment from this authorization is expected to complete, based on procedural protocols. This value can be used to indicate that an extension to an authorization is necessary, if the treatment continues longer than expected."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 24
* 15 ^extension[=].extension[+].url = "max"
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3415
* 16 0..1 CWE "AUT-16" "The authorization clinical service provides a means of categorizing the authorization. This is especially valuable for differentiating authorizations that do not have specific procedure codes associated with them. Refer to Table 0573 - Clinical Service in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0573 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 250
* 16 ^extension[=].extension[+].url = "max"
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3416
* 17 0..1 ST "AUT-17" "The authorization reason is a free text field allowing a user to capture, in a non-coded format, the reason for the authorization. Typically this would describe the patient's condition or illness for which the authorization is recorded."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 60
* 17 ^extension[=].extension[+].url = "max"
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3417
* 18 0..1 CQ "AUT-18" "The authorized duration is the amount of time, in days or visits, that the patient has been authorized for treatment by this authorization. The duration of \"days\" is reserved for inpatient authorizations."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 721
* 18 ^extension[=].extension[+].url = "max"
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3418
* 19 0..1 CQ "AUT-19" "The used duration is the amount of time, in days or visits that the patient has used of the originally authorized duration. The duration of \"days\" is reserved for inpatient authorizations."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 721
* 19 ^extension[=].extension[+].url = "max"
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3419
* 20 0..1 CQ "AUT-20" "The scheduled treatments is the amount of time, in days or visits that the patient has planned treatments scheduled The duration of \"days\" is reserved for inpatient authorizations."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 721
* 20 ^extension[=].extension[+].url = "max"
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3420
* 21 0..1 CWE "AUT-21" "The authorization encounter type provides a means of specifying the environment for the performance of the authorized services. For example, it is common for a procedure to be authorized only for an outpatient environment. If something causes the procedure to be performed in an inpatient environment, a new authorization would be needed. Refer to Table 0574 - Encounter Type in Chapter 2C for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0574 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 250
* 21 ^extension[=].extension[+].url = "max"
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3421
* 22 0..1 MO "AUT-22" "The authorization benefit amount is the amount remaining from the insurance company related to this authorization."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 20
* 22 ^extension[=].extension[+].url = "max"
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3422
* 23 0..1 XON "AUT-23" "This represents the organization to which the patient was referred, or that is authorized to perform the procedure(s). The authorized provider represents the organization recognized by the insurance carrier that is authorized to perform the services for the patient specified on the authorization."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 250
* 23 ^extension[=].extension[+].url = "max"
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #3423
* 24 0..1 XCN "AUT-24" "The authorized HP represents the specific health professional being authorized to perform the services for the patient. This is a less frequently used field, as most often the authorization is for a group/organization and not a specific HP within that group."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 250
* 24 ^extension[=].extension[+].url = "max"
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #3424
* 25 0..1 ST "AUT-25" "The authorization source text allows a user to capture information (such as the name) of the person contacted regarding the specific authorization."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 60
* 25 ^extension[=].extension[+].url = "max"
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #3425
* 26 0..1 DTM "AUT-26" "The authorization source date allows a user to capture the date the person was contacted regarding the specific authorization."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 26 ^extension[=].extension[0].url = "min"
* 26 ^extension[=].extension[=].valueInteger = 24
* 26 ^extension[=].extension[+].url = "max"
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #3426
* 27 0..1 XTN "AUT-27" "The authorization source phone number allows a user to capture the phone number of the person contacted regarding the specific authorization."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 27 ^extension[=].extension[0].url = "min"
* 27 ^extension[=].extension[=].valueInteger = 250
* 27 ^extension[=].extension[+].url = "max"
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #3427
* 28 0..1 ST "AUT-28" "The authorization notes allow for a free text capture of any notes the user wishes to capture related to the authorization. This is a single notes field that allows the user to add additional text over time, or replace the text that already exists."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 28 ^extension[=].extension[0].url = "min"
* 28 ^extension[=].extension[=].valueInteger = 254
* 28 ^extension[=].extension[+].url = "max"
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #3428
* 29 0..1 ID "AUT-29" "This field defines the action to be taken for this authorization. Refer to HL7 Table 0206 - Segment Action Code in Chapter 2C for valid values. When this field is valued, the AUT segment is not in \"snapshot mode\", rather in \"action mode\"."
* 29 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 29 ^extension[=].extension[0].url = "min"
* 29 ^extension[=].extension[=].valueInteger = 1
* 29 ^extension[=].extension[+].url = "max"
* 29 ^extension[=].extension[=].valueInteger = 1
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #3429