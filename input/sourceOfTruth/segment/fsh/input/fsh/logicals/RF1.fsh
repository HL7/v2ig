Logical: RF1
Parent: $Segment
Id: RF1
Title: "HL7 v2 RF1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Referral Information"
* 1 0..1 CWE "RF1-1" "This field contains the status of the referral as defined by either the referred-to or the referred-by provider. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70283[_User-defined Table_ _0283 - Referral Status_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0283 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1137
* 2 0..1 CWE "RF1-2" "This field contains the urgency of the referral. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70280[_User-defined Table 0280 - Referral Priority_] in Chapter 2C, Code Tables, for suggested values__.__"
* 2 from http://terminology.hl7.org/ValueSet/v2-0280 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1138
* 3 0..1 CWE "RF1-3" "This field contains the type of referral. It is loosely associated with a clinical specialty or type of resource. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70281[_User-defined Table 0281 - Referral Type_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0281 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1139
* 4 0..0 CWE "RF1-4" "This field contains the type of response or action that the referring provider would like from the referred-to provider. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70282[_User-defined Table 0282 - Referral Disposition_] for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0282 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1140
* 5 0..1 CWE "RF1-5" "This field contains the location at which the referral will take place. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70284[User-defined Table 0284 - Referral Categor]y_ for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0284 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1141
* 6 1..1 EI "RF1-6" "This field contains the originating application's permanent identifier for the referral. This is a composite field."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1142
* 6 ^comment = "The first component is a string of up to 15 characters that identifies an individual referral. It is assigned by the originating application, and it identifies a referral, and the subsequent referral transactions, uniquely among all such referrals from a particular processing application.\n\nThe second component is optional because this field, itself, is already defined as a _referral identifier_.\n\nThe third component is optional. If used, it should contain the application identifier for the referred-to or external applications (i.e., _not_ the originating application). The application identifier is a string of up to 15 characters that is uniquely associated with an application. A given healthcare provider facility, or group of intercommunicating healthcare provider facilities, should establish a unique list of applications that may be potential originators and recipients, and then assign unique application identifiers to each of those applications. This list of application identifiers becomes one of the healthcare provider facility's master dictionary lists. Since applications fulfilling different application roles can send and receive referral messages, the assigning authority application identifier may not identify the application sending or receiving a particular message. Data elements on the Message Header (MSH) segment are available to identify the actual sending and receiving applications."
* 7 0..1 DTM "RF1-7" "This field contains the date on which the referral is effective."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1143
* 8 0..1 DTM "RF1-8" "This field contains the date on which the referral expires."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1144
* 9 0..1 DTM "RF1-9" "This field contains the date on which the referral originated. It is used in cases of retroactive approval."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1145
* 10 0..0 CWE "RF1-10" "This field contains the reason for which the referral will take place. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70336[_User-defined Table 0336 - Referral Reason_] for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0336 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1228
* 11 0..0 EI "RF1-11" "This field contains an external application's permanent identifier for the referral. That is, this referral identifier does not belong to the application that originated the referral and assigned the originating referral identifier."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1300
* 11 ^comment = "The first component is a string of up to 15 characters that identifies an individual referral. It is typically assigned by the referred-to provider application responding to a referral originating from a referring provider application, and it identifies a referral, and the subsequent referral transactions, uniquely among all such referrals for a particular referred-to provider processing application. For example, when a primary care provider (referring provider) sends a referral to a specialist (referred-to provider), the specialist's application system may accept the referral and assign it a new referral identifier which uniquely identifies that particular referral within the specialist's application system. This new referral identifier would be placed in the external referral identifier field when the specialist responds to the primary care physician.\n\nThe second component is optional because this field, itself, is already defined as a _referral identifier_.\n\nThe third component is optional. If used, it should contain the application identifier for the referred-to or external application (i.e., not the originating application). The application identifier is a string of up to 15 characters that is uniquely associated with an application. A given healthcare provider facility, or group of intercommunicating healthcare provider facilities, should establish a unique list of applications that may be potential originators and recipients, and then assign unique application identifiers to each of those applications. This list of application identifiers becomes one of the healthcare provider facility's master dictionary lists. Since applications fulfilling different application roles can send and receive referral messages, the assigning authority application identifier may not identify the application sending or receiving a particular message. Data elements on the Message Header (MSH) segment are available to identify the actual sending and receiving applications."
* 12 0..1 CWE "RF1-12" "This field can be used to indicate to the receiving provider that the clinical history in the message is incomplete and that more will follow. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70865[_User-defined Table 0865 - Referral Documentation Completion Status_] for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0865 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2262
* 13 0..1 DTM "RF1-13" "The planned treatment stop date is the date that the patient's treatment from this referral is expected to complete, based on procedural protocols. This value can be used to indicate that an extension to an authorization is necessary, if the treatment continues longer than expected."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 24
* 13 ^extension[=].extension[+].url = "max"
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3400
* 14 0..1 ST "RF1-14" "The referral reason is a free text field allowing a user to capture, in a non-coded format, the reason for the referral. Typically this would describe the patient's condition or illness for which the referral is recorded."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 60
* 14 ^extension[=].extension[+].url = "max"
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3401
* 15 0..1 CQ "RF1-15" "The authorized duration is the amount of time, in days or visits, that the patient has been authorized for treatment for this referral. The duration of \"days\" is reserved for inpatient authorizations."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 721
* 15 ^extension[=].extension[+].url = "max"
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3402
* 16 0..1 CQ "RF1-16" "The used duration is the amount of time, in days or visits that the patient has used of the originally authorized duration. The duration of \"days\" is reserved for inpatient authorizations."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 721
* 16 ^extension[=].extension[+].url = "max"
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3403
* 17 0..1 CQ "RF1-17" "The scheduled treatments is the amount of time, in days or visits that the patient has planned treatments scheduled. The duration of \"days\" is reserved for inpatient authorizations."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 721
* 17 ^extension[=].extension[+].url = "max"
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3404
* 18 0..1 MO "RF1-18" "The remaining benefit amount is the amount remaining from the insurance company related to this referral."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 20
* 18 ^extension[=].extension[+].url = "max"
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3405
* 19 0..1 XON "RF1-19" "This represents the organization to which the patient was referred to perform the procedure(s). The authorized provider represents the organization recognized by the insurance carrier that is authorized to perform the services for the patient specified on the referral."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 250
* 19 ^extension[=].extension[+].url = "max"
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3406
* 20 0..1 XCN "RF1-20" "The authorized HP represents the specific health professional authorized to perform the services for the patient. This is a less frequently used field, as most often the authorization is for a group/organization and not a specific HP within that group."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 250
* 20 ^extension[=].extension[+].url = "max"
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3407
* 21 0..1 ST "RF1-21" "The source text allows a user to capture information (such as the name) of the person contacted regarding the specific referral."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 60
* 21 ^extension[=].extension[+].url = "max"
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3408
* 22 0..1 DTM "RF1-22" "The source date allows a user to capture the date the person was contacted regarding the specific referral."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 24
* 22 ^extension[=].extension[+].url = "max"
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3409
* 23 0..1 XTN "RF1-23" "The source phone number allows a user to capture the phone number of the person contacted regarding the specific referral."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 250
* 23 ^extension[=].extension[+].url = "max"
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #3410
* 24 0..1 ST "RF1-24" "The comment allows for a free text capture of any notes the user wishes to capture related to the referral. This is a single notes field that allows the user to add additional text over time, or replace the text that already exists."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 250
* 24 ^extension[=].extension[+].url = "max"
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #3411
* 25 0..1 ID "RF1-25" "This field defines the action to be taken for this referral. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2, Code Tables, for valid values. When this field is valued, the AUT segment is not in \"snapshot mode\", rather in \"action mode\"."
* 25 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #3412