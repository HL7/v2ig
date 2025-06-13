Logical: ORC
Parent: $Segment
Id: ORC
Title: "HL7 v2 ORC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Common Order"
* 1 1..1 ID "ORC-1" "Determines the function of the order segment. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70119[HL7 Table 0119 – Order Control Codes] in Chapter 2C, Code Tables, for valid entries. Depending on the message, the action of the control code may refer to an order or an individual service. For example, the code CA in an OMP message cancels the order. The same code in an RDS message, cancels the dispense. Very detailed explanatory notes are given at the end of this section."
* 1 from http://terminology.hl7.org/ValueSet/v2-0119 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #215
* 1 ^comment = "This field may be considered the \"trigger event\" identifier for orders. The codes fall roughly into the following three categories:\n\n{empty}a) event request – Codes like \"NW\" (new order) and \"CA\" (cancel order request) are used to initiate an event .\n\n{empty}b) event acknowledgment – Codes like \"OK\" (order accepted) and \"CR\" (canceled as requested) are used to reply to the event request .\n\n{empty}c) event notification – Codes like \"OC\" (order canceled) and \"OD\" (order discontinued) are used to notify other applications that an event has occurred. No application reply is necessary.\n\nEvent request codes are intended to initiate an event. Event acknowledgment codes are intended to reply to an application that requested an event. Event notification codes are intended to notify another application that, e.g., the filler has performed some action on an order that the other application, e.g., the placer, needs to know.\n\nFillers, placers, and other applications can use event requests, event acknowledgments, and event – notification-type trigger events interchangeably. However, certain order control codes can originate only from the filler (e.g., CR) and others can only originate from the placer (e.g., CA).\n\nRefer file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70119[HL7 Table 0119 – Order Control Codes] in Chapter 2C, Code Tables__.__"
* 2 0..1 EI "ORC-2" "This field is the placer application's order number."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #216
* 2 ^comment = "This field is a case of the Entity Identifier data type (See Section 2.A.28, \"EI – Entity Identifier\"). The first component is a string that identifies an individual order (i.e., ORC segment and associated order detail segment). It is assigned by the placer (ordering application). It identifies an order uniquely among all orders from a particular ordering application. The second through fourth components contain the application ID of the placing application in the same form as the HD data type (Section 2.A.36, \"HD – Hierarchic designator\"). The second component, namespace ID, is a user-defined coded value that will be uniquely associated with an application. A limit of six (6) characters is suggested but not required. A given institution or group of intercommunicating institutions should establish a unique list of applications that may be potential placers and fillers and assign unique application IDs. The components are separated by component delimiters.\n\nThere are three situations in which the true placer is somewhat arbitrary (and thus not unique):\n\n{empty}a) in ORC-1-order control value of RO, following an RU replacement;\n\n{empty}b) in ORC-1-order control value of CH (child orders); and\n\n{empty}c) in ORC-1-order control value of SN (send number).\n\nSee the Table Notes under ORC-1-order control for the details of how the ORC-2-placer order number is assigned in these cases.\n\nThe application ID list becomes one of the institution's master dictionary lists that is documented in Chapter 8. Since third-party applications (those other than the placer and filler of an order) can send and receive ORM and ORR messages, the placer application ID in this field may not be the same as any sending and receiving application on the network (as identified in the MSH segment).\n\nThe conditions which make this field required are divided into two main issues. The data in ORC-2 and OBR-2 are logically the same thing: a placer id. The data in ORC-3 and OBR-3 are logically the same thing: the filler id.\n\nFrom that perspective each message must have either a placer or a filler id with an exception for the case of a \"Send Number\" control code since its purpose is to request a placer id.\n\nIf both ORC and OBR are present in a message, then only one of the Segments must contain the value(s). Note that if both ORC-2 and OBR-2 are valued then they must be valued the same; as well, if both ORC-3 and OBR-3 are valued, then they must be valued the same. The sending system can include both the filler and the placer number in both the ORC and OBR segments as long as the data is the same between the two segments.\n\nIt is recommended that the initiating system should provide a unique number for the placer order number when a new order is placed or a unique number for the filler order number when an unsolicited result is initially communicated.\n\nThese rules apply to the few other fields that are present in both ORC and OBR for upward compatibility (e.g., quantity/timing, parent numbers, ordering provider, and ordering call back numbers)."
* 3 0..1 EI "ORC-3" "This field is the order number associated with the filling application. It is a case of the Entity Identifier data type (Section 2.A.28). Its first component is a string that identifies an order detail segment (i.e., ORC segment and associated order detail segment). It is assigned by the order filler (receiving) application. This string must uniquely identify the order (as specified in the order detail segment) from other orders in a particular filling application (e.g., clinical laboratory). This uniqueness must persist over time."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #217
* 3 ^comment = "The second through fourth components contain the filler application ID, in the form of the HD data type (see Section 2.A.36, \"HD – hierarchic designator\"). The second component is a user-defined coded value that uniquely defines the application from other applications on the network. A limit of six (6) characters is suggested but not required. The second component of the filler order number always identifies the actual filler of an order.\n\nA given institution or group of intercommunicating institutions should establish a list of applications that may be potential placers and fillers of orders and assign each a unique application ID. The application ID list becomes one of the institution's master dictionary lists that is documented in Chapter 8. Since third- party applications (those other than the placer and filler of an order) can send and receive ORM and ORR messages, the filler application ID in this field may not be the same as any sending and receiving application on the network (as identified in the MSH segment).\n\nThe conditions which make this field required are divided into two main issues. The data in ORC-2 and OBR-2 are logically the same thing: a placer id. The data in ORC-3 and OBR-3 are logically the same thing: the filler id.\n\nFrom that perspective each message must have either a placer or a filler id with an exception for the case of a \"Send Number\" control code since its purpose is to request a placer id.\n\nIf both ORC and OBR are present in a message, then only one of the Segments must contain the value(s). Note that if both ORC-2 and OBR-2 are valued, then they must be valued the same; as well, if both ORC-3 and OBR-3 are valued, then they must be valued the same. The sending system can include both the filler and the placer number in both the ORC and OBR segments as long as the data is the same between the two segments. It is recommended that the initiating system should provide a unique number for the placer order number when a new order is placed or a unique number for the filler order number when an unsolicited result is initially communicated.\n\nThe filler order number (OBR-3 or ORC-3) also uniquely identifies an order and its associated observations. For example, suppose that an institution collects observations from several ancillary applications into a common database and this common database is queried by yet another application for observations. In this case, the filler order number and placer order number transmitted by the common database application would be that of the original filler and placer, respectively, rather than a new one assigned by the common database application.\n\nSimilarly, if a third-party application, not the filler or placer, of an order were authorized to modify the status of an order (say, cancel it), the third-party application would send the filler an ORM message containing an ORC segment with ORC-1-order control equal to \"CA\" and containing the original placer order number and filler order number, rather than assign either itself."
* 4 0..1 EI "ORC-4" "This field contains a unique identifier for an Order Group as referenced by the Placer application. An Order Group is a set of orders grouped together by the placer application."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #218
* 4 ^comment = "The first component is a string that uniquely identifies all order groups from the placer application. A limit of fifteen (15) characters is suggested but not required.\n\nThe second through fourth components constitute a placer or filler application ID identical to the analogous components of ORC-3-filler order number . Order groups and how to use them are described in detail in Section _4.5.1_, \"_ORC – Common Order Segment_.\""
* 5 0..1 ID "ORC-5" "This field specifies the status of an order. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70038[HL7 Table 0038 – Order status] in Chapter 2C, Code Tables, for valid entries. The purpose of this field is to report the status of an order either upon request (solicited), or when the status changes (unsolicited). It does not initiate action. It is assumed that the order status always reflects the status as it is known to the sending application at the time that the message is sent. Only the filler can originate the value of this field."
* 5 from http://terminology.hl7.org/ValueSet/v2-0038 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 5 ^extension[=].extension[0].url = "min"
* 5 ^extension[=].extension[=].valueInteger = 1
* 5 ^extension[=].extension[+].url = "max"
* 5 ^extension[=].extension[=].valueInteger = 2
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #219
* 5 ^comment = "Although file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70038[HL7 Table 0038 – Order status] contains many of the same values contained in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70119[HL7 Table 0119 – Order control codes and their meaning], its purpose is different. Order status may typically be used in a message with an ORC-1-order control value of SR or SC to report the status of the order on request or to any interested party at any time."
* 6 0..1 ID "ORC-6" "This field allows the placer (sending) application to determine the amount of information to be returned from the filler. Sometimes the requested level of response may not be possible immediately, but when it is possible, the filler (receiving) application must send the information. When the field is null, D is the default value of the field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70121[HL7 Table 0121 – Response flag] in Chapter 2C, Code Tables, for valid entries."
* 6 from http://terminology.hl7.org/ValueSet/v2-0121 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #220
* 7 0..0 BackboneElement "ORC-7" "ORC-7"
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #W
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #221
* 7 ^comment = "*_Attention: The ORC-7 field was retained for backward compatibility only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7._* The reader is referred to the TQ1 and TQ2 segments described in sections _4.5.4_ and _4.5.5_, respectively."
* 8 0..0 EIP "ORC-8" "This field relates a child order to its parent order when a parent child order relationship exists. The parent child order mechanism is described in HL7 Table 0119 under order control code PA. This field uniquely identifies the parent order; no other information is required to link the child order with its parent order. It can be used to link the order to the results that triggered this order (e.g., a reflex order) or other order it relates to as an occurrence. This field repeats to allow linking to more than one parent, if necessary."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #222
* 8 ^comment = "The first component has the same format as ORC-2-Placer Order Number (Section _link:#_OBR-2___Placer order number   (EI) [4.5.3.2],_ \"link:#_OBR-2___Placer order number   (EI) [_Placer Order Number_ (EI) 00216]\"). The second component has the same format as ORC-3-Filler Order Number (Section link:#_OBR-3___Filler Order Number   (EI) [_4.5.3.3_], \"link:#_OBR-3___Filler Order Number   (EI) [_Filler Order Number_ (EI) 00217]\"). The components of the placer order number and the filler order number are transmitted in sub‑components of the two components of this field.\n\nNote that ORC-8 – Parent Order is equivalent to OBR-54 – Parent Order, but neither one is the same as OBR-29 – Result Observation Identifier.\n\nCondition: Where the message has matching ORC/OBR pairs, ORC-8 and OBR-54 Must carry the same value."
* 9 0..1 DTM "ORC-9" "This field contains the date and time of the event that initiated the current transaction as reflected in ORC-1 Order Control Code. This field is not equivalent to MSH-7 Date and Time of Message, which reflects the date/time of message generation."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #223
* 9 ^comment = "Examples: When ORC-1 is “NW” this date represents the date/time when the order was placed by the ordering provider; when ORC-1 is \"CA\" this date represents the date/time when request for a cancellation was made by the placer, while for a \"CR\" this date represents the date/time when the cancellation was accepted by the filler (e.g., the change request was applied). When an ORC is included in an ORU message and ORC-1 is \"RE\", then the date represents the date/time when the observation(s) on the transaction were made available by the source system."
* 10 0..1 BackboneElement "ORC-10" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #W
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #224
* 11 0..1 BackboneElement "ORC-11" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #225
* 12 0..1 BackboneElement "ORC-12" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #W
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #226
* 13 0..1 PL "ORC-13" "This field specifies the location (e.g., nurse station, ancillary service location, clinic, floor) where the person who entered the request was physically located when the order was entered. Note that this refers to the current transaction as reflected in ORC-1 Order Control Code. Only those subcomponents relevant to enterer's location should be valued (commonly, nursing unit; facility; building; floor). The person who entered the request is defined in ORC-10-entered by."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #227
* 14 0..2 XTN "ORC-14" "This field contains the telephone number to call for clarification of a request or other information regarding the order. ORC-14-call back phone number is the same as OBR-17-order callback phone number."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #228
* 15 0..1 DTM "ORC-15" "This field focuses on when the information communicated is to take effect. It is most appropriate when used on an order that is by nature a “continuing” (or continuous) order. This field has a close relationship to ORC-9 and the TQ1, TQ2 segments in so much as the value in ORC-15 takes precedence over both. For example, an order is placed on June 1, for an activity that is to be performed over ten days as indicated in the TQ1 segment. The Filler then receives a cancel message on June 2 with the ORC-9 value of June 2, but the ORC-15 Order Effective Date/Time indicated the cancel is to be effective on June 7th. ORC-15 by taking precedence over TQ1 and ORC-9, would tell the Filler to continue to perform the order event until June 7, and cancel all remaining events (treatment, procedures etc..) after that time. If the order identified in the ORC has children, the children which have not started should be canceled; if there is a child in process, it should be discontinued; if a child has progressed beyond the point where it can be discontinued, its status is unaffected."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #229
* 16 0..1 CWE "ORC-16" "This field contains the explanation (either in coded or text form) of the reason for the order event described by the order control code (file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70119[HL7 Table 0119 - Order control codes]). Whereas an NTE after the order-specific segment (e.g., RXO, ORO, OBR) would provide a comment for that specific segment, the purpose of the order control code reason is only to expand on the reason for the order event."
* 16 from http://terminology.hl7.org/ValueSet/v2-0949 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #230
* 16 ^comment = "ORC-16-order control code reason is typically not valued when ORC-1-order control is NW, although it could be. In the case of a canceled order, for example, this field is commonly used to explain the cancellation. A Pharmacy system that canceled a drug order from a physician because of a well-documented allergy would likely report the fact of the allergy in this field.\n\nIf it canceled the order because of a drug interaction this field might contain at least the names (and codes, if needed) of the interacting substances, the text describing the interaction, and the level of severity of the interaction.\n\nRefer file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70949[HL7 Table 0949 – Order Control Code Reason] in Chapter 2C, Code Tables__.__"
* 17 0..1 BackboneElement "ORC-17" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7. Refer to Table 0666 - Entering Organization in Chapter 2C for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0666 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #W
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #231
* 18 0..1 BackboneElement "ORC-18" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7. Refer to Table 0668 - Entering Device in Chapter 2C for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0668 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #W
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #232
* 19 0..1 BackboneElement "ORC-19" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #W
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #233
* 20 0..1 CWE "ORC-20" "This field indicates the status of the patient's or the patient's representative's consent for responsibility to pay for potentially uninsured services. This element is introduced to satisfy CMS Medical Necessity requirements for outpatient services. This element indicates (a) whether the associated diagnosis codes for the service are subject to medical necessity procedures, (b) whether, for this type of service, the patient has been informed that they may be responsible for payment for the service, and (c) whether the patient agrees to be billed for this service. The values for this field are drawn from file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70339[User-Defined Table 0339 – Advanced Beneficiary Notice Code] in Chapter 2C, Code Tables."
* 20 from http://terminology.hl7.org/ValueSet/v2-0339 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1310
* 21 0..1 BackboneElement "ORC-21" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #W
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1311
* 22 0..1 BackboneElement "ORC-22" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #W
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1312
* 23 0..1 BackboneElement "ORC-23" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #W
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1313
* 24 0..1 BackboneElement "ORC-24" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._* The reader is referred to the PRT segment described in Chapter 7."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #W
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1314
* 25 0..1 CWE "ORC-25" "This field is a modifier or refiner of the ORC-5-Order status field. This field may be used to provide additional levels of specificity or additional information for the defined order status codes. Unlike the Order Status field, which is controlled by an HL7 defined table, this field is a CE data type allowing applications to support an unlimited library of Order Status Modifier codes."
* 25 from http://terminology.hl7.org/ValueSet/v2-0950 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1473
* 25 ^comment = "Usage Rule: This field may only be populated if the ORC-5-Order Status field is valued.\n\nExamples: An LIS processing an order with an order status of IP may send an update using the order status modifier to indicate the progress of the order through the laboratory or to indicate that the order has been sent to an external laboratory. Another example using the non-medical orders would be a case in which a phone has been ordered delivered to a patient's room but has been disconnected temporarily. The ORC-5-Order status indicates IP and the ORC-25-Order status modifier would indicate a disconnected status. A third example involves pharmacy dispenses. It is sometimes not enough to know that a prescription is being dispensed. The ORC-25-Order status modifier would indicate if a label had been printed, the prescription filled, or the prescription sold.\n\nRefer file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70950[HL7 Table 0950 – Order Status Modifier] in Chapter 2C, Code Tables__.__"
* 26 0..1 CWE "ORC-26" "This field contains the reason why the patient did not sign an Advanced Beneficiary Notice. The reason may be coded or it may be a free text entry. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70552[HL7 Table 0552 – Advanced beneficiary notice override reason] in Chapter 2C, Code Tables."
* 26 from http://terminology.hl7.org/ValueSet/v2-0552 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #C
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1641
* 26 ^comment = "Condition: This field is required if the value of ORC-20 Advanced Beneficiary Notice Code indicates that the notice was not signed. For example, additional qualifying or explanatory information would be justified if ORC-20 was populated with the values \"3\" or \"4\" in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70339[User-defined Table 0339 – Advanced Beneficiary Notice Code], or similar values in related external code tables."
* 27 0..1 DTM "ORC-27" "This field specifies the date/time the Filler expects to complete the order, e.g., have the results available, the prescription ready, etc. This is a Filler assigned field and would typically only be sent from Filler to Placer on either application level acknowledgments or order status messages. (Could be delivered with result message, but would have little relevance at that time.)"
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1642
* 28 0..1 CWE "ORC-28" "This field contains information about the level of security and/or sensitivity surrounding the order (e.g., highly sensitive, not sensitive, sensitive, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70177[HL7 Table 0177 – Confidentiality Code] in Chapter 2C, Code Tables, for allowed values. The specific treatment of data with a particular confidentiality level is subject to site-specific negotiation."
* 28 from http://terminology.hl7.org/ValueSet/v2-0177 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #615
* 29 0..1 CWE "ORC-29" "This field indicates whether the order is to be executed in an inpatient setting or an outpatient setting. If this field is not valued, the system default is assumed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70482[HL7 Table 0482 – Order Type] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0482 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1643
* 29 ^comment = "Examples: Before discharge an order is placed for follow-up physical therapy, or to pick up a prescription at a community pharmacy. The patient is an inpatient according to PV1, but the order is an outpatient order."
* 30 0..1 CNE "ORC-30" "This field indicates the form of authorization a recorder had from the responsible practitioner to create or change an order. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70483[HL7 Table 0483 - Authorization Mode] in Chapter 2C, Code Tables, for suggested values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0483 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1644
* 30 ^comment = "• To be harmonized to Participation.mode_cd in version 3."
* 31 0..1 BackboneElement "ORC-31" "*_This field was retained for backward compatibility only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9._*"
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #W
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2287
* 32 0..1 DT "ORC-32" "This field contains the date the patient gave consent to pay for potentially uninsured services or the date that the Advanced Beneficiary Notice Code (ORC-20) was collected."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #2301
* 33 0..0 CX "ORC-33" "This field enables a shorter number to be communicated that is unique within other identifiers."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #3300
* 34 0..0 CWE "ORC-34" "ORC-34"
* 34 from http://terminology.hl7.org/ValueSet/v2-0934 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #3387
* 34 ^comment = "The Order Workflow Profile references/represents the information necessary to define the workflow variant when that is not fully described through the use of ORC-1 Order Control and MSH-21 Message Profile. This enables contributing systems to apply locally agreed to rules. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70934[User-defined Table 0934 - Order Workflow Profile] for a list of suggested values."
* 35 0..1 ID "ORC-35" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] for valid values."
* 35 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 35 ^extension[=].extension[0].url = "min"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^extension[=].extension[+].url = "max"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #816
* 35 ^comment = "The action code can only be used when either ORC-2 and/or ORC 3 is valued with a unique identifier in accordance with Chapter 2, Section 2.10.4.2."
* 36 0..1 DR "ORC-36" "This field is a Filler assigned date/time indicating a date range that the ORC-5 Order Status is intended to be effective. For example, if the Filler recommends an alternate test, and sets the ORC-5 status to “Hold”, this date/time reflects how long the Filler will keep the order in that status (Barring additional communications from the Placer or Filler in regard to this order.) When the date is outside the specified order status date range, ORC-5 (Order Status) should be considered an unspecified status, i.e., the status represented in ORC-5 would not necessarily be reflective of the actual status anymore."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #3509
* 37 0..1 DTM "ORC-37" "This field represents the official date/time when the order was originally created; whether as an electronic order or as an initial paper requisition. This may also be known as Prescription Date/Time. This date/time is designed to preserve the creation date/time from initial order to final result, and for all stages in-between. (Acknowledgments, Updates, Cancels, Results etc.). When ORC-1 Order Control Code is “NW” for a new order, this date/time, if valued, is typically expected to be the same as ORC-9 Date/Time of Order Event. An example where the ORC-37, Order Creation Date/Time, is not the same as ORC-9, Date/Time of Order Event, while ORC-1, Order Control Code, is “NW” is when the order originally was and signed by a physician on paper (ORC-37), but not entered in a system until some time (ORC-9) thereafter."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #3515
* 37 ^comment = "As different date/times can be considered the initiation of the order (the first person entering it or a subsequent step), or data is not available (e.g., a paper request without a date/time when it was created), the system where the order was first documented determines which date/time it reflects according to the organization's policies and would represent that in ORC-37. +\n\nWhen an order is resulted (ORC-1 = “RE”) the value in ORC-37 does not change from the value supplied in the original order."
* 38 0..1 EI "ORC-38" "This field contains a unique identifier for the Order Group as referenced by the Filler application. An Order Group is a set of orders grouped together by the placer application."
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #2482
* 38 ^comment = "The first component is a string that uniquely identifies all order groups from the filler application. A limit of fifteen (15) characters is suggested but not required.\n\nThe second through fourth components constitute a filler application ID identical to the analogous components of ORC-3-filler order number . Order groups and how to use them are described in detail in Section _4.5.1_, \"_ORC – Common Order Segment_.\""