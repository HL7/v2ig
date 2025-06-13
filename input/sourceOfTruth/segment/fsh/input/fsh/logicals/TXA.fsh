Logical: TXA
Parent: $Segment
Id: TXA
Title: "HL7 v2 TXA Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Transcription Document Header"
* 1 1..1 SI "TXA-1" "This field contains a number that uniquely identifies this transaction for the purpose of adding, changing, or deleting the transaction."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #914
* 2 1..1 CWE "TXA-2" "This field identifies the type of document (as defined in the transcription system). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70270[_User-Defined Table 0270 - Document Type_] for suggested values. The organization is free to add more entries. Receivers are required to inspect the Coding System component of the CWE data type to accurately interpret the meaning of the code. Senders transmitting messages to Receivers on earlier version of the standard may elect to negotiate business rules to ensure that expected data is not lost. HL7 does not assign positional meaning to user-defined codes."
* 2 from http://terminology.hl7.org/ValueSet/v2-0270 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #915
* 3 0..1 ID "TXA-3" "This is a conditional field which is required whenever the message contains content as presented in one or more OBX segments. This field identifies the method by which this document was obtained or originated. Refer to E:\\\\V2\\\\v2.9 final Nov from Frank\\\\V29_CH02C_Tables.docx#HL70191[_HL7 Table 0191 – Type of Referenced Dat__a_] for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0191 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #916
* 4 0..1 DTM "TXA-4" "This field contains the date/time identified in the document as the date a procedure or activity was performed. This date can identify date of surgery, non-invasive procedure, consultation, examination, etc."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #917
* 5 0..0 XCN "TXA-5" "This field contains the name of the person identified in the document as being responsible for performing the procedure or activity. This field includes the code and name (if available) of the caregiver. This field is conditional based upon the presence of a value in link:#txa-4-activity-datetime-dtm-00917[TXA-4-Activity Date/Time]."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #918
* 6 0..1 DTM "TXA-6" "This field contains the date and time the document was created (i.e., dictated, recorded, etc.)."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #919
* 7 0..1 DTM "TXA-7" "This field contains the date and time the input was actually transcribed. This field is conditional based upon the presence of a value in link:#txa-17-document-completion-status-id-00928[TXA-17-Document Completion Status] of anything except \"dictated.\""
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #920
* 8 0..0 DTM "TXA-8" "This field contains the date and time the document was edited."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #921
* 9 0..0 XCN "TXA-9" "This field identifies the person who originated (i.e., dictated) the document. The document originator may differ from the person responsible for authenticating the document."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #922
* 10 0..0 XCN "TXA-10" "This field identifies the person(s) responsible for authenticating the document, who may differ from the originator. Multiple persons may be responsible for authentication, especially in teaching facilities. This field is allowed to repeat an undefined number of times."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #923
* 11 0..0 XCN "TXA-11" "This field identifies the person transcribing the document. This is a conditional value; it is required on all transcribed documents."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #C
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #924
* 11 ^comment = "TXA-11 - Condition: If TXA-11 is valued and the corresponding OBR segment is present in the message OBR-35 must be blank. If OBR-35 is valued while TXA-11 is valued, OBR-35 shall be ignored. See message definitions including TXA for further guidanceon which ORC/OBR pairs to consider."
* 12 1..1 EI "TXA-12" "This field contains a unique document identification number assigned by the sending system. This document number is used to assist the receiving system in matching future updates to the document, as well as to identify the document in a query. When the vendor does not provide a unique document ID number, some type of document identifier should be entered here, or the Unique Document File name should be utilized. See Chapter 2A, section 2.A.89, \"XTN - extended telecommunication number.\" Where the system does not customarily have a document filler number, this number could serve as that value, as well."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #R
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #925
* 13 0..1 EI "TXA-13" "This field contains a document number that identifies the parent document to which this document belongs. The parent document number can be used to assist the receiving system in matching future updates to this document. This is a conditional field that is always required on T05 (document addendum notification), T06 (document addendum notification and content), T09 (document replacement notification), and T10 (document replacement notification and content) events."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #C
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #926
* 14 0..0 EI "TXA-14" "This field is the placer application's order number."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #216
* 14 ^comment = "This is a composite field. The first component is a string of characters that identifies an individual order (i.e., OBR). It is assigned by the placer (ordering application). It identifies an order uniquely among all orders from a particular ordering application. The second through fourth components contain the (filler) assigning authority of the placing application. The (filler) assigning authority is a string of characters that will be uniquely associated with an application. A given institution or group of intercommunicating institutions should establish a unique list of applications that may be potential placers and fillers and assign unique entity identifiers. The components are separated by component delimiters.\n\nTXA-14 - Condition: If corresponding ORC and/or OBR segments are present in the message and ORC-2 or OBR-2 is valued, this field must be blank. If TXA-14 is valued while ORC-2 or OBR-2 is valued it shall be ignored. See message definitions including TXA for further guidance on which ORC/OBR pairs to consider."
* 15 0..1 EI "TXA-15" "This field is the order number associated with the filling application. Where a transcription service or similar organization creates the document and uses an internally unique identifier, that number should be inserted in this field. Its first component is a string of characters that identifies an order detail segment (i.e., OBR). This string must uniquely identify the order (as specified in the order detail segment) from other orders in a particular filling application (i.e., transcription service). This uniqueness must persist over time. Where a number is reused over time, a date can be affixed to the non-unique number to make it unique."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #217
* 15 ^comment = "The second through fourth components contains the (filler) assigning authority. The (filler) assigning authority is a string of characters that uniquely defines the application from other applications on the network. The second through fourth components of the filler order number always identify the actual filler of an order.\n\nTXA-15 - Condition: If corresponding ORC and/or OBR segments are present in the message and ORC-3 or OBR-3 is valued, this field must be blank. If TXA-14 is valued while ORC-3 or OBR-3 is valued it shall be ignored. See message definitions including TXA for further guidanceon which ORC/OBR pairs to consider.\n\nFor further details, please see the definitions provided in Chapter 4, \"Orders\"."
* 16 0..1 ST "TXA-16" "This field contains a unique name assigned to a document by the sending system. The file name is used to assist the receiving system in matching future updates to the document."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #927
* 17 1..1 ID "TXA-17" "This field identifies the current completion state of the document. This is a required, table-driven field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70271[_HL7 Table 0271 - Document Completion Status_] for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0271 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #R
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 2
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 2
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #928
* 17 ^comment = "Figure 9-1. Document completion status state transition table\n\nFigure 9-1. Document completion status state transition table\n|===\n|Transition (Action) |Old State |New State\na|\nT01 Original Notification\n\nT02 Original Notification and Content\n\n|NA a|\nDictated\n\nIn Progress\n\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\na|\nT03 Status Change Notification\n\nT04 Status Change Notification and Content\n\n|Dictated a|\nIn Progress\n\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |In Progress a|\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |Incomplete a|\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |Pre-authenticated a|\nAuthenticated\n\nLegally authenticated\n\n| |Authenticated |Legally authenticated\n| |Legally authenticated |NA\n| |Documented a|\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\na|\nT05 Addendum Notification\n\nT06 Addendum Notification and Content\n\n|NA a|\nDictated\n\nIn Progress\n\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\na|\nT07 Edit Notification\n\nT08 Edit Notification and Content\n\n|Dictated a|\nIn Progress\n\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |In Progress a|\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |Incomplete a|\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n| |Pre-authenticated a|\nAuthenticated\n\nLegally authenticated\n\n| |Authenticated |Legally authenticated\n| |Legally authenticated |NA\n| |Documented a|\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\na|\nT09 Replacement Notification\n\nT10 Replacement Notification and Content\n\n|NA a|\nDictated\n\nIn Progress\n\nIncomplete\n\nPre-authenticated\n\nAuthenticated\n\nLegally authenticated\n\n|T11 Cancel Notification |Dictated +\nIn Progress +\nIncomplete +\nPre-authenticated +\nand Availability status of \"Unavailable\" |Canceled\n|==="
* 18 0..1 ID "TXA-18" "This is an optional field which identifies the degree to which special confidentiality protection should be applied to this information. The assignment of data elements to these categories is left to the discretion of the healthcare organization. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70272[_HL7 Table 0272 - Document Confidentiality Status_] for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0272 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^extension[=].extension[+].url = "max"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #929
* 19 0..1 ID "TXA-19" "This is an optional field which identifies a document's availability for use in patient care. If an organization's business rules allow a document to be used for patient care before it is authenticated, the value of this field should be set to \"AV.\" If a document has been made available for patient care, it cannot be changed or deleted. If an erroneous document has been made available at any point in time and a replacement is not appropriate, then it may be marked as \"Canceled\" and removed, as in the case of a document being assigned to the wrong patient. Additional information must be provided via an addendum, which is separately authenticated and date/time stamped. If the content of a document whose status is \"Available\" must be revised, this is done by issuing a replacement, which is separately authenticated and date/time stamped. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70273[_HL7 Table 0273 - Document Availability Status_] for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0273 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 2
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 2
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #930
* 19 ^comment = "Figure 9-2. Document availability status state transition table\n\nFigure 9-2. Document availability status state transition table\n|===\n|Transition (Action) |Old State |New State |Notes\na|\nT01 Original Notification\n\nT02 Original Notification and Content\n\n|NA a|\nUnavailable\n\nAvailable\n\n|\na|\nT03 Status Change Notification\n\nT04 Status Change Notification and Content\n\n|Unavailable a|\nUnavailable\n\nAvailable\n\nObsolete\n\n|\n| |Available a|\nAvailable\n\nObsolete\n\n|\n| |Obsolete |NA |\na|\nT05 Addendum Notification\n\nT06 Addendum Notification and Content\n\n|NA a|\nUnavailable\n\nAvailable\n\n|\na|\nT07 Edit Notification\n\nT08 Edit Notification and Content\n\n|Unavailable a|\nUnavailable\n\nAvailable\n\n|\na|\nT09 Replacement Notification\n\nT10 Replacement Notification and Content\n\n|NA a|\nUnavailable\n\nAvailable\n\n|Set parent document to \"obsolete\"\n|T11 Cancel |Unavailable |Delete |\n|===\n\n*Note:* NA means not applicable."
* 20 0..1 ID "TXA-20" "This optional field identifies the storage status of the document. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70275[_HL7 Table 0275 - Document Storage Status_] for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0275 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 2
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 2
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #932
* 21 0..1 ST "TXA-21" "This free text field (limited to 30 characters) contains the reason for document status change."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #933
* 22 0..0 PPN "TXA-22" "This field contains a set of components describing by whom and when authentication was performed (either manually or electronically). The Date/Time Action Performed component describes the date/time of the authentication (Authentication Time Stamp). The remaining components identify the person performing the authentication (Authentication Person). If either of the Authenticating Person or the Authentication Time Stamp is valued as non-null, then both must be valued as non-null."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #934
* 22 ^comment = "TXA-22 - Condition: If TXA-22 is valued and the corresponding OBR segment is present in the message OBR-32 must be blank. If OBR-32 is valued while TXA-22 is valued, OBR-32 shall be ignored. See message definitions including TXA for further guidanceon which ORC/OBR pairs to consider."
* 23 0..0 XCN "TXA-23" "This field identifies the persons who received a copy of this document."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #935
* 24 0..0 CWE "TXA-24" "This field is used to assign documents to folders. These folders are not nested; a document may either be part of none or several folders. In practice this can be used to separate the documents into domain specific types (e.g., cardiology reports, radiology reports), organizational types (e.g., administrational document, billing document), body region types (e.g., chest CT, leg CT), or something else. Furthermore, this information can be combined. This usually depends on the system involved and therefore it must be up to the user to define it. The systems can use the information to define workflows or manage access to the document. Receivers are required to inspect the Coding System component of the CWE data type to accurately interpret the meaning of the code. Senders transmitting messages to Receivers on earlier version of the standard may elect to negotiate business rules to ensure that expected data is not lost. HL7 does not assign positional meaning to user-defined codes. Refer to Table 0791 - Folder Assignment in Chapter 2C for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0791 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2378
* 25 0..0 ST "TXA-25" "This field supports the identification of the document title. When communicating the meta information without the document contents you may submit the document title as well."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #3301
* 26 0..1 DTM "TXA-26" "This field contains the date and time the document is or will be due back to the original author or dictator from the transcriptionist."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #3302
* 27 0..1 HD "TXA-27" "This field identifies the facility in which this document has been created."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2413
* 28 0..1 CWE "TXA-28" "This field identifies the specialty of the provider which created this document. Refer to Table 0792 - Creating Specialty in Chapter 2C for valid values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0792 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2414
* 28 ^comment = "*Note*: There are no suggested values for speciality."
* 29 0..0 CWE "TXA-29" "The code specifying the high-level use classification of the document type (e.g., Report, Summary, Images, Treatment Plan, Patient Preferences, Workflow). Refer to file:///C:\\Users\\cnewman\\Downloads\\V281_CH02C_CodeTables.doc#HL70270[_User-Defined Table 0832 - Document Class_] in Chapter 2C for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0832 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2530
* 30 0..0 CWE "TXA-30" "This list of codes represents the main clinical acts, such as a colonoscopy or an appendectomy, being documented. Refer to file:///C:\\Users\\cnewman\\Downloads\\V281_CH02C_CodeTables.doc#HL70270[_User-Defined Table 0833 – Document Event_] in Chapter 2C for suggested values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0833 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2531
* 31 0..0 EI "TXA-31" "This field contains a set of unique folder identification numbers that are associated with a document. This folder instance number is used to assist all systems to manage the documents by allowing for filtering, grouping, access control or other use cases."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2532