Logical: PEO
Parent: $Segment
Id: PEO
Title: "HL7 v2 PEO Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Product Experience Observation"
* 1 0..0 CWE "PEO-1" "This field may be used to transmit the event identifier used by other entities for this event. The entry would typically contain a unique alphanumeric identifier assigned by an entity with the text component null or repeating the unique alphanumeric identifier followed by the organization's identifier. An event identifier might be GB1234^GB1234^PharmaGiant for example. Refer to Table 0678 - Event Identifiers Used in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0678 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1073
* 2 0..0 CWE "PEO-2" "This field is the coded diagnosis or problem description which best describes the event. A text representation of the coded item should routinely be included. MEDDRA and WHO-ART are examples of appropriate coding schemes, as are the patient and device codes included in the FDA Center for Devices and Radiologic Health's coding manual for Form 3500A. Refer to Table 0679 - Event Symptom/Diagnosis Code in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0679 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1074
* 3 1..1 DTM "PEO-3" "This field contains a report or best estimate of the date/time of onset of the event. The date/time can be recorded to any level of precision it is known (hour, day, month, year)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1075
* 4 0..1 DTM "PEO-4" "This field identifies the best estimate of the date/time the event was exacerbated."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1076
* 5 0..1 DTM "PEO-5" "This field identifies the best estimate of the date/time the event improved."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1077
* 6 0..1 DTM "PEO-6" "This field identifies the best estimate of the date/time the event resolved."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1078
* 7 0..0 XAD "PEO-7" "This field identifies the location at which the event started. Often this will specify only the country in which the event started."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1079
* 8 0..0 ID "PEO-8" "This field is contains a classification of the type of product experience this event is considered to represent. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70237[_HL7 Table 0237 - Event Qualification_] for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0237 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 8 ^extension[=].extension[0].url = "min"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^extension[=].extension[+].url = "max"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1080
* 8 ^comment = "Unexpected beneficial effects would not often be reported but are required by certain countries."
* 9 0..1 ID "PEO-9" "This field indicates whether the event was judged as serious. If the event did not meet the criteria for seriousness but the sender judges the event significant on other grounds, the event can be identified as significant [_but not serious_]. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70238[_HL7 Table 0238 - Event Seriousness_] for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0238 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1081
* 10 0..1 ID "PEO-10" "This field indicates whether the observed event was expected or unexpected as judged. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70239[_HL7 Table 0239 - Event Expected_] for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0239 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1082
* 11 0..0 ID "PEO-11" "This field identifies the consequence of the [.underline]#event# on the patient. If the consequence of the event is not understood or not available, the patient outcome element may be used although neither is required. May be repeated if more than one is appropriate. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70240[_HL7 Table 0240 - Event Consequence_] for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0240 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1083
* 12 0..1 ID "PEO-12" "PEO-12"
* 12 from http://terminology.hl7.org/ValueSet/v2-0241 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1084
* 12 ^comment = "When an event specific outcome is not available, the patient outcome element may be used to represent the patient's overall outcome if that information is known. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70241[_HL7 Table 0241 - Patient Outcome_] for valid values."
* 13 0..0 FT "PEO-13" "This field contains a summary narrative text description of the event that occurred written by the sender. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative. By representing clinical information in OBX segments rather than in the narrative, these data become much more useful and flexible."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "600"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1085
* 14 0..0 FT "PEO-14" "This field contains a summary narrative text description of the event provided by the original reporter. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "600"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1086
* 15 0..0 FT "PEO-15" "This field contains a summary narrative text description of the event obtained directly from the patient. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative, which will allow the data to be more readily represented and manipulated."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "600"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1087
* 16 0..0 FT "PEO-16" "This field contains a summary narrative text description of the event provided by the practitioner most familiar with the event. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 16 ^extension[=].extension[0].url = "length"
* 16 ^extension[=].extension[=].valueInteger = "600"
* 16 ^extension[=].extension[+].url = "noTruncate"
* 16 ^extension[=].extension[=].valueInteger = false
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1088
* 17 0..0 FT "PEO-17" "This field contains a summary narrative text description of the autopsy results. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "600"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = false
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1089
* 18 0..0 CWE "PEO-18" "This field identifies the coded cause of death. May be repeated as necessary to list multiple contributing causes. A text description can be included by including text but no code or coding system. For example, if the cause of death is to be determined at autopsy but results are not yet available, the cause of death element could be ^Pending autopsy^. The date/time of death can be sent in the PID and the autopsy results sent in the event description from autopsy element of the PEO segment. Refer to Table 0680 - Cause Of Death in Chapter 2C for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0680 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1090
* 19 0..0 XPN "PEO-19" "This field identifies the name of the person who initially described the event."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1091
* 20 0..0 XAD "PEO-20" "This field identifies the address of the person who initially described the event."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1092
* 21 0..0 XTN "PEO-21" "This field identifies the telephone number of the person who initially described the event."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1093
* 22 0..1 ID "PEO-22" "This field contains the qualification of the primary observer which may assist in assessing the validity of the observations. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70242[_HL7 Table 0242 - Primary Observer's Qualification_] for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0242 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1094
* 23 0..1 ID "PEO-23" "This field contains the qualification of the health professional who confirmed the observation if the primary observer was not a health professional. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70242[_HL7 Table 0242 - Primary Observer's Qualification_] for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0242 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1095
* 24 0..1 DTM "PEO-24" "This field identifies the date/time the primary observer became aware of event."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1096
* 25 0..1 ID "PEO-25" "Indicates whether or not the primary observer, if known to the sender, grants permission to disclose his or her identity to the product manufacturer for the purpose of further investigating the event. If the element is absent, the assumption should be made that permission is not granted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70243[_HL7 Table 0243 - Identity May Be Divulged_] for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0243 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 2
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1097