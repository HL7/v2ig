Logical: OBR
Parent: $Segment
Id: OBR
Title: "HL7 v2 OBR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Observation Request"
* 1 0..1 SI "OBR-1" "For the first order transmitted, the sequence number shall be 1; for the second order, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #237
* 2 0..1 EI "OBR-2" "This field is identical to _ORC-2-Placer Order Number_."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #216
* 2 ^comment = "This field is a special case of the Entity Identifier data type (Chapter 2A, section 2.A.28). The first component is a string that identifies an individual order (i.e., ORC segment and associated order detail segment). A limit of fifteen (15) characters is suggested but not required. It is assigned by the placer (ordering application). An implementation is HL7 compliant when the number of characters for this field is increased to accommodate applications that require a greater number of characters for the Placer order number. It identifies an order uniquely among all orders from a particular ordering application. The second through fourth components contain the application ID of the placing application in the same form as the HD data type (section 2.A.36, \"HD – Hierarchic designator\"). The second component, namespace ID, is a user-defined coded value that will be uniquely associated with an application. A limit of six (6) characters is suggested but not required. A given institution or group of intercommunicating institutions should establish a unique list of applications that may be potential placers and fillers and assign unique application IDs. The components are separated by component delimiters.\n\nSee _ORC-2-placer order number_ (section *Error! Reference source not found.*) for information on when this field must be valued.\n\nA given institution or group of intercommunicating institutions should establish a list of applications that may be potential placers and fillers of orders and assign each a unique application ID. The application ID list becomes one of the institution's master dictionary lists that is documented in Chapter 8. Since third-party applications (those other than the placer and filler of an order) can send and receive ORM and ORR messages, the placer application ID in this field may not be the same as any sending and receiving application on the network (as identified in the MSH segment).\n\nThe conditions which make this field required are divided into two main issues. The data in _ORC-2_ and _OBR-2_ are logically the same thing: a placer id. The data in _ORC-3_ and _OBR-3_ are logically the same thing: the filler id.\n\nFrom that perspective, each message must have either a placer or a filler id with an exception for the case of a \"Send Number\" control code since its purpose is to request a placer id.\n\nIf both ORC and OBR are present in a message, then only one of the Segments must contain the value(s). If both segments contain either ORC-2/OBR-2 or ORC-3/OBR-3, then each pair must be a matching pair. The sending system can include both the filler and the placer number in both the ORC and OBR segments as long as the data is the same between the two segments.\n\nIt is recommended that the initiating system should provide a unique number when a new order or unsolicited result is initially communicated.\n\nThese rules apply to the few other fields that are present in both ORC and OBR for upward compatibility (e.g., quantity/timing, parent numbers, ordering provider, and ordering call back numbers)."
* 3 0..1 EI "OBR-3" "This field is the order number associated with the filling application. This is a permanent identifier for an order and its associated observations. It is a special case of the Entity Identifier data type (see Chapter 2, section 2.A.28, \"EI – entity identifier\")."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #217
* 3 ^comment = "The first component is a string that identifies an individual order segment (i.e., ORC segment and associated order detail segment). It is assigned by the order filling (receiving) application. It identifies an order uniquely among all orders from a particular filling application (e.g., clinical laboratory). This uniqueness must persist over time.\n\nThe second through fourth components contain the filler application ID, in the form of the HD data type (see section 2.A.36, \"HD – hierarchic designator\"). The second component is a user-defined coded value that uniquely defines the application from other applications on the network. A limit of six (6) characters is suggested but not required. The second component of the filler order number always identifies the actual filler of an order.\n\nSee _ORC-3-filler order number_ for information on when this field must be valued.\n\nThe conditions which make this field required are divided into two main issues. The data in _ORC-2_ and _OBR-2_ are logically the same thing: a placer id. The data in _ORC-3_ and _OBR-3_ are logically the same thing: the filler id.\n\nFrom that perspective, each message must have either a placer or a filler id with an exception for the case of a \"Send Number\" control code since its purpose is to request a placer id.\n\nIf both ORC and OBR are present in a message, then only one of the Segments must contain the value(s). If both segments contain either ORC-2/OBR-2 or ORC-3/OBR-3, then each pair must be a matching pair. The sending system can include both the filler and the placer number in both the ORC and OBR segments as long as the data is the same between the two segments.\n\nIt is recommended that the initiating system should provide a unique number when a new order or unsolicited result is initially communicated.\n\nThe filler order number (OBR-3 or ORC-3) also uniquely identifies an order and its associated observations. For example, suppose that an institution collects observations from several ancillary applications into a common database and this common database is queried by yet another application for observations. In this case, the filler order number and placer order number transmitted by the common database application would be that of the original filler and placer, respectively, rather than a new one assigned by the common database application.\n\nSimilarly, if a third-party application, not the filler or placer, of an order were authorized to modify the status of an order (say, cancel it), the third-party application would send the filler an ORM message containing an ORC segment with _ORC-1-order control_ equal to \"CA\" and containing the original placer order number and filler order number, rather than assign either itself."
* 4 1..1 CWE "OBR-4" "This field contains the identifier code for the requested observation/test/battery. The identifier can come from either a local coding system or industry standards. Examples may be LOINC (emerging as the global standard for observation identifiers), JLAC10, or SNOMED CT. Refer to Table 0612 - Universal Service Identifier in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0612 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #238
* 5 0..1 BackboneElement "OBR-5" "OBR-5"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #W
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #239
* 5 ^comment = "*Attention: _The OBR-5 element was retained for backward compatibility only as of v 2.4 and the detail was withdrawn and removed from the standard as of v 2.7._*"
* 6 0..1 BackboneElement "OBR-6" "OBR-6"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #W
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #240
* 6 ^comment = "*Attention: _The OBR-6 element was retained for backward compatibility only as of v 2.4 and the detail was withdrawn and removed from the standard as of v 2.7._*"
* 7 0..1 DTM "OBR-7" "This field is the clinically relevant date/time of the observation. In the case of observations taken directly from a subject, it is the actual date and time the observation was obtained. In the case of a specimen‑associated study, this field shall represent the date and time the specimen was collected or obtained. (This is a results-only field except when the placer or a third party has already drawn the specimen.) This field is conditionally required. When the OBR is transmitted as part of a report message, the field *must* be filled in. If it is transmitted as part of a request *and* a sample has been sent along as part of the request, this field must be filled in because this specimen time is the physiologically relevant date/time of the observation."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #241
* 8 0..1 DTM "OBR-8" "This field contains the end date and time of a study or timed specimen collection. If an observation takes place over a substantial period of time, it will indicate when the observation period ended. For observations made at a point in time, it will be null. This is a results field except when the placer or a party other than the filler has already drawn the specimen."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #242
* 9 0..1 CQ "OBR-9" "Deprecated in version 2.9 in favor of SPM-12."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #B
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #243
* 10 0..0 XCN "OBR-10" "*_This field is retained for backward compatibility only as of v 2.7._* The reader is referred to the PRT segment described in Chapter 7."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #B
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #244
* 10 ^comment = "When a specimen is required for the study, this field will identify the person, department, or facility that collected the specimen. Either name or ID code, or both, may be present. If the person referenced in this field is also referenced in PRT segment, they must contain the same information. However, if there is a difference, then PRT segment takes precedence."
* 11 0..1 ID "OBR-11" "This field identifies the action to be taken with respect to the specimens that accompany or precede this order. The purpose of this field is to further qualify (when appropriate) the general action indicated by the order control code contained in the accompanying ORC segment. For example, when a new order (ORC – \"NW\") is sent to the lab, this field would be used to tell the lab whether or not to collect the specimen (\"L\" or \"O\"). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70065[_HL7 Table 0065 – Specimen Action Code_] in Chapter 2C, Code Tables, for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0065 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #245
* 12 0..1 CWE "OBR-12" "This field contains the code and/or text indicating any known or suspected patient or specimen hazards, e.g., patient with active tuberculosis or blood from a hepatitis patient. Either code and/or text may be absent. However, the code is always placed in the first component position and any free text in the second component. Thus, free text without a code must be preceded by a component delimiter. Refer to Table 0613 - Danger Code in Chapter 2C for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0613 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #246
* 13 0..0 CWE "OBR-13" "This field contains additional clinical information about the patient or specimen. This field is used to report the supporting and/or suspected diagnosis and clinical findings on requests for interpreted diagnostic studies where a simple text string or code is sufficient. This field could use all appropriate code sets including SNOMED to message Relevant Clinical Information. If more information is needed, such as date/time of the observation, who observed it, abnormal ranges, etc., or must be provided in further structured format, e.g., structured numeric with units of measure encoded, the Observation/Result group following the OBR should be used. Examples include reporting the amount of inspired carbon dioxide for blood gasses, the point in the menstrual cycle for cervical pap tests, and other conditions that influence test interpretations. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70916[_HL7 Table 0916 – Relevant Clinical Information_] in Chapter 2C, Code Tables, for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0916 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "300"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #247
* 14 0..1 BackboneElement "OBR-14" "OBR-14"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #W
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #248
* 14 ^comment = "*Attention: _The OBR-14 element was retained for backward compatibility only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7. See SPM in Chapter 7._*"
* 15 0..1 BackboneElement "OBR-15" "OBR-15"
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #W
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #249
* 15 ^comment = "*Attention: _The OBR-15 element was retained for backward compatibility only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7. See SPM in Chapter 7._*"
* 16 0..1 BackboneElement "OBR-16" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred ot the PRT segment as described in Chapter 7."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #W
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #226
* 17 0..2 XTN "OBR-17" "This field contains the telephone number for reporting a status or a result using the standard format with extension and/or beeper number when applicable."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #250
* 18 0..1 ST "OBR-18" "This field is user field #1. Text sent by the placer will be returned with the results."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "199"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = false
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #251
* 19 0..1 ST "OBR-19" "This field is similar to placer field #1."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 19 ^extension[=].extension[0].url = "length"
* 19 ^extension[=].extension[=].valueInteger = "199"
* 19 ^extension[=].extension[+].url = "noTruncate"
* 19 ^extension[=].extension[=].valueInteger = false
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #252
* 20 0..1 ST "OBR-20" "This field is definable for any use by the filler (diagnostic service)."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "199"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = false
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #253
* 21 0..1 ST "OBR-21" "This field is similar to filler field #1."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 21 ^extension[=].extension[0].url = "length"
* 21 ^extension[=].extension[=].valueInteger = "199"
* 21 ^extension[=].extension[+].url = "noTruncate"
* 21 ^extension[=].extension[=].valueInteger = false
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #254
* 22 0..1 DTM "OBR-22" "This field specifies the date/time when the results were reported or status changed. This conditional field is required whenever the OBR-25 is valued. This field is used to indicate the date and time that the results are composed into a report and released, or that a status, as defined in _ORC-5 order status_, is entered or changed. (This is a results field only.) When other applications (such as office or clinical database applications) query the laboratory application for un-transmitted results, the information in this field may be used to control processing on the communications link. Usually, the ordering service would want only those results for which the reporting date/time is greater than the date/time the inquiring application last received results."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #255
* 23 0..1 MOC "OBR-23" "This field is the charge to the ordering entity for the studies performed when applicable. The first component is a dollar amount when known by the filler. The second is a charge code when known by the filler (results only)."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #256
* 24 0..1 ID "OBR-24" "This field is the section of the diagnostic service where the observation was performed. If the study was performed by an outside service, the identification of that service should be recorded here. Refer to link:#obx-observationresult-segment[_HL7 Table 0074 – Diagnostic Service Section ID_] in Chapter 2C, Code Tables, for valid entries."
* 24 from http://terminology.hl7.org/ValueSet/v2-0074 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 2
* 24 ^extension[=].extension[+].url = "max"
* 24 ^extension[=].extension[=].valueInteger = 3
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #257
* 25 0..1 ID "OBR-25" "This field contains the status of results for this order. This conditional field is required whenever the OBR is contained in a report message. It is not required as part of an initial order."
* 25 from http://terminology.hl7.org/ValueSet/v2-0123 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #C
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #258
* 25 ^comment = "There are two methods of sending status information. If the status is that of the entire order, use _ORC-15-order effective date/time_ and _ORC-5-order status_. If the status pertains to the order detail segment, use _OBR-25-result status_ and _OBR-22-results rpt/status chng – date/time_. If both are present, the OBR values override the ORC values.\n\nThis field would typically be used in a response to an order status query where the level of detail requested does not include the OBX segments. When the individual status of each result is necessary, _OBX-11-observ result status_ may be used. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70123[_HL7 Table 0123 – Result Status_] in Chapter 2C, Code Tables, for valid entries."
* 26 0..1 PRL "OBR-26" "This field is defined to make it available for other types of linkages (e.g., toxicology). This important information, together with the information in _OBR-29-Parent Result Obersvation Identifier_ and _OBR-54 Parent Order,_ uniquely identifies the parent result's OBX segment related to this order. The value of this OBX segment in the parent result is the organism or chemical species about which this battery reports, or the specific result for which this order or observation is a reflex. For example, if the current battery is an antimicrobial susceptibility, the parent results identified OBX contains a result which identifies the organism on which the susceptibility was run. This indirect linkage is preferred because the name of the organism in the parent result may undergo several preliminary values prior to finalization. In the case of a reflex order, if it is necessary to point to the specific result value for which it is in response, OBR-26 enables pointing to that specific OBX segment."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #259
* 26 ^comment = "The third component may be used to record the name of the microorganism identified by the parent result directly. The organism in this case should be identified exactly as it is in the parent culture.\n\nWe emphasize that this field does not take the entire result field from the parent. It is meant only for the text name of the organism or chemical subspecies identified. This field is included only to provide a method for linking back to the parent result for those systems that could not generate unambiguous Observation IDs and sub-IDs.\n\nThis field is present only when the parent result is identified by _OBR-29-_ Result Observation Identifier or OBR-54, Parent Order__,__ and the parent spawns child orders or results for each of many results. (See Chapter 7 for more details about this linkage.)\n\nA second mode of conveying this information is to use a standard observation result segment (OBX). If more than one organism is present, _OBX-4-observation sub-ID_ is used to distinguish them. In this case, the first OBX with subID N will contain a value identifying the Nth microorganism, and each additional OBX with subID N will contain susceptibility values for a given antimicrobial test on this organism."
* 27 0..0 BackboneElement "OBR-27" "OBR-27"
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #W
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #221
* 27 ^comment = "*Attention: _The OBR-27 element was retained for backward compatibility only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7._*"
* 28 0..1 BackboneElement "OBR-28" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* Additional capabilities are now available through thePRT segment following the OBR using the \"RCT\" (Results Copy To) value in PRT-4 (Participation) from file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70912[_HL7 Table 912 - Participation_] in Chapter 2C, Code Tables, and referencing the appropriate participant information using other PRT Fields. The PRT segment is further described in Chapter 7 Section 7.3.4 \"PRT – Participation Information Segment\"."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #W
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #260
* 29 0..1 EIP "OBR-29" "This field relates a child result to its parent result when a parent child result relationship exists. This field uniquely identifies the order number of the parent result; no other information is required to link the child result with its parent result."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #261
* 30 0..1 ID "OBR-30" "This field identifies how (or whether) to transport a patient, when applicable. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70124[_HL7 Table 0124 – Transportation Mode_] in Chapter 2C, Code Tables, for valid codes."
* 30 from http://terminology.hl7.org/ValueSet/v2-0124 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 30 ^extension[=].extension[0].url = "min"
* 30 ^extension[=].extension[=].valueInteger = 4
* 30 ^extension[=].extension[+].url = "max"
* 30 ^extension[=].extension[=].valueInteger = 4
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #262
* 31 0..0 CWE "OBR-31" "This field is the code or text using the conventions for coded fields given in the Control chapter (Chapter 2). This is required for some studies to obtain proper reimbursement."
* 31 from http://terminology.hl7.org/ValueSet/v2-0951 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #263
* 31 ^comment = "Refer file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70951[_HL7 Table 0951 – Reason for Study_] in Chapter 2C, Code Tables__.__"
* 32 0..1 BackboneElement "OBR-32" "*_This field is retained for backward compatibility only as of v 2.6 and the detail was withdrawn and removed from the standard as of v 2.9.._* The reader is referred to the PRT segment described in Chapter 7."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #W
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #264
* 33 0..1 BackboneElement "OBR-33" "*_This field was retained for backward compatibility only as of v 2.6 and the detail was withdrawn and removed from the standard as of v 2.9.._* The reader is referred to the PRTsegment used relative to OBR as described in section *Error! Reference source not found.*, \"link:#obx-observationresult-segment[_Principal Result Interpreter_].\""
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #W
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #265
* 34 0..1 BackboneElement "OBR-34" "*_This field was retained for backward compatibility only as of v 2.6 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRTsegment used relative to OBR as described in section *Error! Reference source not found.*, \"link:#obx-observationresult-segment[_Principal Result Interpreter_].\""
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #W
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #266
* 35 0..1 BackboneElement "OBR-35" "*_This field was retained for backward compatibility only as of v 2.6 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRTsegment used relative to OBR as described in section *Error! Reference source not found.*, \"link:#obx-observationresult-segment[_Principal Result Interpreter_].\""
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #W
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #267
* 36 0..1 DTM "OBR-36" "This field is the date/time the filler scheduled an observation, when applicable (e.g., action code in _OBR-11-specimen action code_ = \"S\"). This is a result of a request to schedule a particular test and provides a way to inform the placer of the date/time a study is scheduled (result only)."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #268
* 37 0..1 NM "OBR-37" "This field identifies the number of containers for a given sample. For sample receipt verification purposes; may be different from the total number of samples which accompany the order."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 37 ^extension[=].extension[0].url = "length"
* 37 ^extension[=].extension[=].valueInteger = "16"
* 37 ^extension[=].extension[+].url = "noTruncate"
* 37 ^extension[=].extension[=].valueInteger = false
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1028
* 38 0..0 CWE "OBR-38" "This field is the means by which a sample reaches the diagnostic service provider. This information is to aid the lab in scheduling or interpretation of results. Possible answers: routine transport van, public postal service, etc. If coded, requires a user-defined table. Refer to Table 0614 - Transport Logistics of Collected Sample in Chapter 2C for valid values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0614 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1029
* 39 0..0 CWE "OBR-39" "This field is for reporting additional comments related to the sample. If coded, requires a user-defined table. If only free text is reported, it is placed in the second component with a null in the first component, e.g., ^difficulty clotting after venipuncture and ecchymosis. Refer to Table 0619 - Collector's Comment in Chapter 2C for valid values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0619 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1030
* 40 0..1 CWE "OBR-40" "This field is an indicator of who is responsible for arranging transport to the planned diagnostic service. Examples: Requester, Provider, Patient. If coded, requires a user-defined table. Refer to Table 0620 - Transport Arrangement Responsibility in Chapter 2C for valid values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0620 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #1031
* 41 0..1 ID "OBR-41" "This field is an indicator of whether transport arrangements are known to have been made. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70224[_HL7 Table 0224 – Transport Arranged_] in Chapter 2C, Code Tables, for valid codes."
* 41 from http://terminology.hl7.org/ValueSet/v2-0224 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 41 ^extension[=].extension[0].url = "min"
* 41 ^extension[=].extension[=].valueInteger = 1
* 41 ^extension[=].extension[+].url = "max"
* 41 ^extension[=].extension[=].valueInteger = 1
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1032
* 42 0..1 ID "OBR-42" "This field is an indicator that the patient needs to be escorted to the diagnostic service department. Note: The nature of the escort requirements should be stated in _OBR-43-planned patient transport comment_. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70225[_HL7 Table 0225 – Escort Required_] in Chapter 2C, Code Tables, for valid values."
* 42 from http://terminology.hl7.org/ValueSet/v2-0225 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 42 ^extension[=].extension[0].url = "min"
* 42 ^extension[=].extension[=].valueInteger = 1
* 42 ^extension[=].extension[+].url = "max"
* 42 ^extension[=].extension[=].valueInteger = 1
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #1033
* 43 0..0 CWE "OBR-43" "This field is the code or free text comments on special requirements for the transport of the patient to the diagnostic service department. If coded, requires a user-defined table. Refer to Table 0621 - Planned Patient Transport Comment in Chapter 2C for valid values."
* 43 from http://terminology.hl7.org/ValueSet/v2-0621 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #1034
* 44 0..1 CNE "OBR-44" "This field contains a unique identifier assigned to the procedure, if any, associated with the charge. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70088[Externally-defined table 0088 – Procedure code]_ in Chapter 2C, Code Tables, for suggested values__.__ This field is a coded data type for compatibility with clinical and ancillary systems."
* 44 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #393
* 44 ^comment = "As of version 2.6, applicable external coding systems include those in the referenced table. If the code set used is in the referenced table, then the coding scheme designation in the table shall be used."
* 45 0..0 CNE "OBR-45" "This field contains the procedure code modifier to the procedure code reported in _OBR-44-procedure code_, when applicable. Procedure code modifiers are defined by regulatory agencies such as CMS and the AMA. Multiple modifiers may be reported. The modifiers are sequenced in priority according to user entry. In the USA, this is a requirement of the UB and the 1500 claim forms. Multiple modifiers are allowed and the order placed on the form affects reimbursement. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70340[_Externally- defined table 0340 – Procedure code modifier_] in Chapter 2C, Code Tables, for suggested values."
* 45 from http://terminology.hl7.org/ValueSet/v2-0340 (required)
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #1316
* 45 ^comment = "Usage Rule: This field can only be used if _OBR-44 – procedure code_ contains certain procedure codes that require a modifier in order to be billed or performed. For example, HCPCS codes that require a modifier to be precise.\n\nAs of version 2.6, applicable external coding systems include those in the referenced table. If the code set used is in the referenced table, then the coding scheme designation in the table shall be used."
* 46 0..0 CWE "OBR-46" "This field contains supplemental service information sent from the placer system to the filler system for the universal procedure code reported in _OBR-4 Universal Service ID_. This field will be used to provide ordering information detail that is not available in other specific fields in the OBR segment. Multiple supplemental service information elements may be reported. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70411[_User-defined Table 0411 - Supplemental service information values_] in Chapter 2C, Code Tables."
* 46 from http://terminology.hl7.org/ValueSet/v2-0411 (required)
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #1474
* 46 ^comment = "This field can be used to describe details such as whether study is to be done on the right or left, for example, where the study is of the arm and the order master file does not distinguish right from left, or whether the study is to be done with or without contrast (when the order master file does not make such distinctions)."
* 47 0..0 CWE "OBR-47" "This field contains supplemental service information sent from the filler system to the placer system for the procedure code reported in _OBR-4 Universal Service ID._ This field will be used to report ordering information detail that is not available in other specific fields in the OBR segment. Typically it will reflect the same information as was sent to the filler system in _OBR-46-Placer supplemental service information_ unless the order was modified, in which case the filler system will report what was actually performed using this field. Multiple supplemental service information elements may be reported. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70411[_User-Defined Table 0411 - Supplemental Service Information Values_] in Chapter 2C, Code Tables."
* 47 from http://terminology.hl7.org/ValueSet/v2-0411 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #1475
* 47 ^comment = "This field can be used to describe details such as whether study is to be done on the right or left, for example, where the study is of the arm and the order master file does not distinguish right from left, or whether the study is to be done with or without contrast (when the order master file does not make such distinctions)."
* 48 0..1 CWE "OBR-48" "This field is used to document why the procedure found in _OBR-44 - Procedure Code_ is a duplicate of one ordered/charged previously for the same patient within the same date of service and has been determined to be medically necessary. The reason may be coded or it may be a free text entry."
* 48 from http://terminology.hl7.org/ValueSet/v2-0476 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #C
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #1646
* 48 ^comment = "This field is intended to provide financial systems information on who to bill for duplicate procedures.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70476[_User-Defined Table 0476 – Medically Necessary Duplicate Procedure Reason_] in Chapter 2C, Code Tables, for suggested values."
* 49 0..1 CWE "OBR-49" "Transmits information regarding the handling of the result. For example, an order may specify that the result (e.g., an x-ray film) should be given to the patient for return to the requestor. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70507[_HL7 Table 0507 - Observation Result Handling_] in Chapter 2C, Code Tables, for values. If this field is not populated or if it includes value \"CC^Copies Requested\", then routine handling is implied and PRT segments assocatied with this OBR with PRT-4 value of \"RCT^Result Copies To\" identify additional recipients for the results. When this field includes the value \"BCC^Blind Copy\", those PRT segments, which are included in the order message and in the observation result message sent to the requestor, shall not be included in the observation result messages sent to the copied recipients."
* 49 from http://terminology.hl7.org/ValueSet/v2-0507 (required)
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #1647
* 50 0..1 BackboneElement "OBR-50" "*_This field is retained for backward compatibility only as of v 2.7 and withdrawn as of v2.9._*"
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #W
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #2286
* 51 0..1 EI "OBR-51" "The Observation Group ID is the identifier assigned by the producer of a result to uniquely identify the results associated with this OBR segment. The Observation Group ID is intended to remain the same regardless of the change in status to the result (i.e., it is not a snapshot ID). This field is intended to promote forward compatibility with HL7 V3."
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #2307
* 52 0..1 EI "OBR-52" "The Parent Observation Group ID field relates this child OBR to its parent OBR segment using the Observation Group ID of the parent result."
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #2308
* 53 0..0 CX "OBR-53" "This field enables a shorter number to be communicated that is unique within other identifiers."
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #3303
* 54 0..0 EIP "OBR-54" "This field relates a child order to its parent order when a parent child order relationship exists. The parent child order mechanism is described in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70119[_HL7 Table 0119 – Order Control Codes_] in Chapter 2C, Code Tables, under order control code PA. This field uniquely identifies the parent orders; no other information is required to link the child order with its parent orders. It can be used to express that this order is a reflex being a consequence of original results referred here."
* 54 from http://terminology.hl7.org/ValueSet/v2-0119 (required)
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #222
* 54 ^comment = "The first component has the same format as _ORC-2-placer order number_ (Section _link:#_OBR-2___Placer order number   (EI) [*Error! Reference source not found.*],_ \"link:#_OBR-2___Placer order number   (EI) [*_Error! Reference source not found._*]\"). The second component has the same format as _ORC-3-filler order number_ (Section link:#_OBR-3___Filler Order Number   (EI) [*_Error! Reference source not found._*], \"link:#_OBR-3___Filler Order Number   (EI) [*_Error! Reference source not found._*]\"). The components of the placer order number and the filler order number are transmitted in sub‑components of the two components of this field.\n\n_Note that ORC-8 – Parent Order is equivalent to OBR-54-Parent Order, but neither one_ is the same as _OBR-29-Parent Result Obersvation Identifier_ .\n\nCondition: Where the message has matching ORC/OBR pairs, ORC-8 and OBR-54 must carry the same value."
* 55 0..1 ID "OBR-55" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 55 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 55 ^extension[=].extension[0].url = "min"
* 55 ^extension[=].extension[=].valueInteger = 1
* 55 ^extension[=].extension[+].url = "max"
* 55 ^extension[=].extension[=].valueInteger = 1
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #816
* 55 ^comment = "The action code can only be used when an either OBR-2 and/or OBR-3 is valued with unique identifier in accordance with Chapter 2, Section 2.10.4.2."