Logical: OM1
Parent: $Segment
Id: OM1
Title: "HL7 v2 OM1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "General"
* 1 1..1 NM "OM1-1" "This field contains the first OM1 segment in a message and is described as 1, the second as 2, and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 1..1 CWE "OM1-2" "This field contains the producer's usual or preferred identification of the test or observation. Only three components should be included: <ID code>^<service text name/description>^<source list of code>. All components should be non-null. Refer to Table 0630 - Producer's Service/Test/Observation ID in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0630 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #587
* 3 0..0 ID "OM1-3" "This field contains the allowed data type(s) for this observation. The codes are the same as those listed for OBX (a given observation may, under different circumstances, take on different data types). Indeed, under limited circumstances, an observation can consist of one or more fragments of different data types. When an observation may have more than one data type, e.g., coded (CWE) and numeric (NM) the allowable data types should be separated by repeat delimiters. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70125[HL7 Table 0125 – Value Type] in Chapter 2C, Code Tables, for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0125 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 2
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 3
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #588
* 4 1..1 ID "OM1-4" "This field contains a flag indicating whether or not at least one specimen is required for the service/test/observation. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] as defined in Chapter 2C, Code Tables."
* 4 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 4 ^extension[=].extension[0].url = "min"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^extension[=].extension[+].url = "max"
* 4 ^extension[=].extension[=].valueInteger = 1
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #589
* 4 ^comment = "Y one or more specimens are required to obtain this observation\n\nN a specimen is not required\n\nWhen a specimen is required, segment OM4 will usually be included (one per specimen is required)."
* 5 1..1 CWE "OM1-5" "This field uniquely identifies the service producing the observation described in this segment. Three components should be included: an identifying code, the name of the producer, and the identity of the coding system (e.g., 323-5678^Acme Special Lab^MC). The identity of the coding system will usually be MC (Medicare provider number or HIBCC site codes) in the United States. Each country may want to specify its preferred coding system and define a coding system ID to identify it. Refer to Table 0631 - Producer ID in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0631 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #590
* 5 ^comment = "Remember that the magnitude of a treatment or the setting on a machine, such as a ventilator, can be regarded as an observation. Thus, pharmacy, respiratory care, and nursing may be producers of such observations."
* 6 0..1 TX "OM1-6" "This field contains a text description of this observation."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "200"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = true
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #591
* 7 0..0 CWE "OM1-7" "This field contains all alias codes/identifiers for this observation. If more than one alias code needs to be specified, multiple three-component, CWE-format entries (<code 1>^<name 1>^<code system 1>) may be given, separated by repeat delimiters. An observation may have as many names/codes as are applicable (e.g., ICD9, ACR-NEMA, SNOMED, and READ). We encourage the inclusion of as many different codes as may apply to assist cross-system mapping of terminology. All components of each triplet should be non-null (that is, names and coding system IDs within the CWE data type are required in addition to codes). Refer to Table 0632 - Other Service/Test/Observation IDs for the Observation in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0632 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #592
* 7 ^comment = "Because the size (dose) of a treatment can also be an observation, codes that identify treatments (e.g., NDC, ICCS) may also be included in this field.\n\n*Note:* In this field, the names within the CWE data type are required."
* 8 0..0 ST "OM1-8" "This field contains any test aliases or synonyms for the name in the context of the ordering service. These are alternative names, not associated with a particular coding system, by which the battery, test, or observation (e.g., measurement, test, diagnostic study, treatment, etc.) is known to users of the system. Multiple names in this list are separated by repeat delimiters."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #B
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "200"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #593
* 8 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8. See OM1-51.*"
* 9 0..1 ST "OM1-9" "This field contains the preferred name for reporting the observation or battery. The name can contain up to 30 characters (including blanks). It is the preferred name for columnar reports that require a maximum name size."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "30"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = true
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #594
* 10 0..1 ST "OM1-10" "This field contains the name that can be used in space-limited reports (e.g., specimen labels) to identify the observation for the convenience of human readers. The name can contain up to eight characters."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 8
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #595
* 11 0..1 ST "OM1-11" "This field contains the fully-specified name for the observation or battery. It may include the full (unabbreviated) multiple-word names and contain up to 200 characters. It should be as scientifically precise as possible."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 11 ^extension[=].extension[0].url = "length"
* 11 ^extension[=].extension[=].valueInteger = "200"
* 11 ^extension[=].extension[+].url = "noTruncate"
* 11 ^extension[=].extension[=].valueInteger = false
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #596
* 12 0..1 ID "OM1-12" "This field indicates whether or not a service/test/observation is an orderable code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #597
* 12 ^comment = "Y the service/test/observation is an orderable code\n\nN the service/test/observation is not orderable\n\nFor example, blood differential count is usually an orderable \"test,\" MCV, contained within the differential count, is usually not independently orderable."
* 13 0..0 CWE "OM1-13" "When applicable, this field identifies the instrument or device that is used to generate this observation or battery. Examples are the automated instrument in the laboratory, the imaging device and model number in radiology, and the automatic blood pressure machine on the ward. The instrument is specified as a coded entry in anticipation that these identifiers could be specified as codes. Initially, we expect that most of the information about devices will be transmitted as text in the second component of the CWE identifier. If more than one kind of instrument is used, all of them can be listed, separated by repeat delimiters. Refer to Table 0633 - Identity of Instrument Used to Perform this Study in Chapter 2C for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0633 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #598
* 14 0..0 CWE "OM1-14" "This field contains the method(s) used to produce the observation and should be recorded in a computer-understandable (coded) form here. This field should report the same method(s) reported in narrative in the following field. More than one method may be listed, but only if they produce results that are clinically indistinguishable. Multiple methods must be separated by repeat delimiters. Refer to Table 0635 - Coded Representation of Method in Chapter 2C for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0635 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #599
* 15 0..1 ID "OM1-15" "This field indicates whether or not a portable device may be used for the service/test/observation. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^extension[=].extension[+].url = "max"
* 15 ^extension[=].extension[=].valueInteger = 1
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #600
* 15 ^comment = "Y the observation can be obtained with a portable device brought to the patient\n\nN the patient or specimen must be transported to the device"
* 16 0..0 CWE "OM1-16" "This field permits the sorting of observation orders and values by the providing service's department/section. It provides \"source oriented\" reporting when required. Free text may be used instead of these codes, but in that case, they should be recorded as the second \"component\" of the field to distinguish them from the standard codes. Multiple codes in this field are separated by repeat delimiters. Refer to Table 0636 - Observation Producing Department/Section in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0636 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #B
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #601
* 16 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 17 0..1 XTN "OM1-17" "This field contains the telephone number for calling responsible parties in this section to ask results or advice about the use of this test."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #B
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #602
* 17 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 18 1..1 CWE "OM1-18" "This field indicates whether the definition entry identifies a test battery, an entire functional procedure or study, a single test value (observation), multiple test batteries or functional procedures as an orderable unit (profile), or a single test value (observation) calculated from other independent observations. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70174[User-defined Table 0174 - Nature of Service/Test/Observation] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0174 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #R
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 18 ^extension[=].extension[0].url = "min"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^extension[=].extension[+].url = "max"
* 18 ^extension[=].extension[=].valueInteger = 1
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #603
* 19 0..1 CWE "OM1-19" "This field contains an optional string that defines the preferred header under which this observation should be listed on a standard display. For example, if the test is hemoglobin, this string might be \"Complete blood count.\" It is represented as a coded data type so that a battery can be a header. Only the description part of the string may be included in case the subheader does not have an associated code. When a series of observations is displayed according to the sort order given below, the subheader that groups those observations is presented whenever the subheader changes. Refer to Table 0637 - Report Subheader in Chapter 2C for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0637 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #604
* 20 0..1 ST "OM1-20" "This field contains an optional string that defines the sort order in which this observation is presented in a standard report or display that contains the many observations."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "20"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = false
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #605
* 21 0..1 DTM "OM1-21" "This field contains the date and time that the last of any field change was made and in the host's record corresponding to the OM1 segment."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #606
* 22 0..1 DTM "OM1-22" "This field contains the date and time of the last change in the test procedure that would make previous results incompatible with new results, e.g., the last time that normal reference range or units changed for a numeric test/observation."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #607
* 22 ^comment = "We strongly suggest that observation producers never use the same observation ID when the measurement procedures change in such a way that results produced under the new procedure are clinically different from those produced with the old procedure. Rather, the producer should try to adjust the new procedure so that its values are clinically indistinguishable from the old. Failing that, one should create a new observation ID for the observation produced under the new procedure.\n\nIn the rare circumstances when a procedure change occurs and neither of the above two options is viable, this field shall be used to transmit the effective date/time of the new procedure. The receiving system shall assume that any values that come across under this observation ID are under the new procedure after this date and take appropriate steps to distinguish the old from the new observations.\n\nThis number is included to provide a means of communicating with the observation producing service when they have questions about particular observations or results."
* 23 0..1 NM "OM1-23" "This field contains the typical processing time for single test/observation. This field indicates the time from the delivery of a specimen or transport of a patient to a diagnostic service and the completion of the study. It includes the usual waiting time. The units are measured in minutes."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #B
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #608
* 23 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.2. See OM1-57.*"
* 24 0..1 NM "OM1-24" "This field contains the usual length of time (in minutes) between the start of a test process and its completion."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #609
* 25 0..0 ID "OM1-25" "This field contains one or more available priorities for performing the observation or test. This is the priority that can be placed in _TQ1-9 - Priority_. Multiple priorities may be given, separated by repeat delimiters. For example, S~A~R~P~T indicates that the test may be ordered using codes S, A, R, P, or T. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70168[HL7 Table 0168 - Processing Priority] in Chapter 2C, Code Tables, for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0168 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 25 ^extension[=].extension[0].url = "min"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^extension[=].extension[+].url = "max"
* 25 ^extension[=].extension[=].valueInteger = 1
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #610
* 25 ^comment = "For tests requiring a specimen, the priority for obtaining the specimen is included in _OM4-13 - Specimen Priorities_."
* 26 0..1 ID "OM1-26" "This field contains the available priorities reporting the test results when the user is asked to specify the reporting priority independent of the processing priority. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70169[HL7 Table 0169 - Reporting Priority] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0169 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 26 ^extension[=].extension[0].url = "min"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^extension[=].extension[+].url = "max"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #611
* 27 0..0 CWE "OM1-27" "This field contains the identification(s) of the outside service(s) that produce(s) the observation. The format of this CWE field uses the producer ID (as defined in _OM1-5 - Producer ID_) and the name of the service separated by component delimiters. An example is ...|39221^ACME lab^MC|... If multiple services are used, they should be separated by repeat delimiter(s). Refer to Table 0638 - Outside Site(s) Where Observation May Be Performed in Chapter 2C for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0638 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #B
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #612
* 27 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 28 0..0 XAD "OM1-28" "This field contains the address of the outside services listed in _OM1-28 - Address of Outside Site(s)_ where observation may be performed. If multiple services are recorded in that field, their addresses should be separated by repeat delimiters, and the addresses should appear in the same order in which the services appear in the preceding field."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #B
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #613
* 28 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 29 0..1 XTN "OM1-29" "This field contains the telephone number of the outside site."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #B
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #614
* 29 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 30 0..1 CWE "OM1-30" "This field contains the degree to which special confidentiality protection should be applied to the observation. For example, a tighter control may be applied to an HIV test than to a CBC. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70177[User-defined Table 0177 - Confidentiality Code] in Chapter 2C, Code Tables, for suggested values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0177 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #615
* 31 0..0 CWE "OM1-31" "This field contains the list of variables that the diagnostic service needs to interpret the results of an ordered study. The observations specified here should be sent to the diagnostic service as OBX segments along with the order (OBR) segment. Separate multiple items by repeat delimiters. Refer to Table 0639 - Observations Required to Interpret this Observation in Chapter 2C for valid values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0639 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #B
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #616
* 31 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.2. See OMC Segment.*"
* 32 0..1 TX "OM1-32" "This field contains the clinical information about interpreting test results. Examples are the conditions (drugs) that may cause false abnormals, and the information about the sensitivity and specificity of the test for diagnoses."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #617
* 33 0..0 CWE "OM1-33" "This field contains the diagnosis or problem for which the test is a contraindication or of possible danger (e.g., pacemaker, pregnancy, diabetes). For example, if the test identified in OM1 was an intravenous pyelogram, this field would include warnings about the use of contrast media in diabetes. The contraindication diagnoses should be separated by repeat delimiters. Refer to Table 0640 - Contraindications to Observations in Chapter 2C for valid values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0640 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #618
* 33 ^comment = "Most contraindication rules will be transmitted as free text. In such cases, the contents serve only as information for human reading. However, an alternative for machine readable contraindication rules also exists. The rule may be defined formally in the Arden Syntax (ASTM 1460-1992) which has syntax for defining algebraic and transcendental equations, as well as temporal and logical selection criteria based on patient information stored in the computer record. Reflex rules that are written in Arden Syntax should begin and end with a double semi-colon (;;), the Arden slot delimiter."
* 34 0..0 CWE "OM1-34" "This field contains the test names as type CWE (i.e., <code>^<text name>^<coding system>) that may be ordered automatically by the diagnostic service, depending on the results obtained from the ordered battery. A screening CBC might trigger a reticulocyte count if the Hgb is less than 12. Multiple reflex tests are separated by repeat delimiters. Refer to Table 0641 - Reflex Tests/Observations in Chapter 2C for valid values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0641 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #619
* 35 0..0 TX "OM1-35" "This field contains the rules that trigger the reflex tests listed above. If multiple reflex tests are listed in _OM1-34 - Reflex Text/Observations_ separated by repeat delimiters, a set of corresponding rules will be included in this section. The first rule will apply to the first test, the second to the second test, and so on."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #620
* 35 ^comment = "Most reflex rules will usually be transmitted as free text. In such cases, the contents serve only as information for human reading. However, an alternative for machine readable rules also exists. The rule may be defined formally in the Arden Syntax (ASTM 1460-1992) which has syntax for defining algebraic and transcendental equations, as well as temporal and logical selection criteria based on patient information stored in the computer record. Reflex rules that are written in Arden Syntax should begin and end with a double semi-colon (;;), the Arden slot delimiter."
* 36 0..0 CWE "OM1-36" "This field contains the codes and a fixed text message that is always associated with an abbreviation. The field may include multiple messages separated by repeat delimiters. Refer to Table 0643 - Fixed Canned Message in Chapter 2C for valid values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0643 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #621
* 36 ^comment = "Most rules about patient testing will be transmitted as free text. In such cases, the contents serve only as information for human reading. However, an alternative for machine readable rules also exists. The rule may be defined formally in the Arden Syntax (ASTM 1460-1992) which has syntax for defining algebraic and transcendental equations, as well as temporal and logical selection criteria based on patient information stored in the computer record. Rules about patient preparation are written in Arden Syntax should begin and end with a double semi-colon (;;), the Arden slot delimiter."
* 37 0..0 TX "OM1-37" "This field contains the tests or observations that require special patient preparation, diet, or medications. For GI contrast studies, this field would contain the pretest diet, e.g., low residue for two days, NPO before study, and the preferred purgatives. Each separate med, diet, or preparation should be delimited by a repeat delimiter. Separate each requirement by a repeat delimiter. Example for a sigmoidectomy:"
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 37 ^extension[=].extension[0].url = "length"
* 37 ^extension[=].extension[=].valueInteger = "200"
* 37 ^extension[=].extension[+].url = "noTruncate"
* 37 ^extension[=].extension[=].valueInteger = false
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #622
* 37 ^comment = "...|clear liquid diet full day before procedure~take 8 oz mag citrate 6pm day before procedure~take 2 ducat tabs (5m) at 4pm day before procedure~NPO past midnight.|..."
* 38 0..1 CWE "OM1-38" "This field contains the treatments that may be needed as part of the procedure. Examples are radioactive iodine for a thyroid screen, and methacholine for a methacholine spirometry challenge. This field should be identified as a CWE data type. Refer to Table 0644 - Procedure Medication in Chapter 2C for valid values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0644 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #623
* 39 0..1 TX "OM1-39" "This field contains the text description of the foods, diagnoses, drugs, or other conditions that may influence the interpretation of the observation. Information about the direction of the effect, and any recommendation about altering the diet, conditions, or drug before initiating the test observation."
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 39 ^extension[=].extension[0].url = "length"
* 39 ^extension[=].extension[=].valueInteger = "200"
* 39 ^extension[=].extension[+].url = "noTruncate"
* 39 ^extension[=].extension[=].valueInteger = false
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #624
* 39 ^comment = "Most rules about factors that effect the test interpretation will be transmitted as free text. In such cases, the contents serve only as information for human reading. However, an alternative for machine readable rules also exists. The rule may be defined formally in the Arden Syntax (ASTM 1460-1992) which has syntax for defining algebraic and transcendental equations, as well as temporal and logical selection criteria based on patient information stored in the computer record. Rules about patient preparation are written in Arden Syntax and should begin and end with a double semi-colon (;;), the Arden slot delimiter."
* 40 0..0 ST "OM1-40" "This field contains the diagnostic studies/tests that are performed only at certain times during the course of a work day or work week. This field indicates the maximum interval between successive test performances (the test may actually be performed more frequently). The format given in Chapter 4, Section 4.3.2.1, \"Repeat Pattern,\" should be used. If necessary, multiple codes may be given, separated by repeat delimiters. The use of multiple codes indicates that the test is performed at multiple concurrent intervals. For example, Q6H indicates that the test is performed at least once every 6 hours around the clock. QJ1 indicates that the test is performed at least every week on Mondays. QAM~QPM indicates that the test is performed at least once every morning and every evening. QJ1~QJ3~QJ5 indicates that the test is performed at least every week on Mondays, Wednesdays, and Fridays. C indicates that the test is performed continuously, 7 days per week."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 40 ^extension[=].extension[0].url = "length"
* 40 ^extension[=].extension[=].valueInteger = "60"
* 40 ^extension[=].extension[+].url = "noTruncate"
* 40 ^extension[=].extension[=].valueInteger = false
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #625
* 41 0..1 TX "OM1-41" "This field contains the text description of the methods used to perform the text and generate the observations. Bibliographic citations may be included."
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #626
* 42 0..1 CWE "OM1-42" "OM1-42"
* 42 from http://terminology.hl7.org/ValueSet/v2-0254 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #937
* 42 ^comment = "Definitions: This optional attribute describes the underlying kind of property represented by this observation. This attribute distinguishes concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so forth. These are discussed more fully in the LOINC Users' Manual.footnote:[LOINC Committee. Logical Observation Identifier Names and Codes. Indianapolis: Regenstrief Institute and LOINC Committee, 1995.] They are derived from the approach described in 1995 edition of the IUPAC Silver Book.footnote:[International Union of Pure and Applied Chemistry/International Federation of Clinical Chemistry. The Silver Book: Compendium of terminology and nomenclature of properties in clinical laboratory sciences. Oxford: Blackwell Scientific Publishers, 1995.] These distinctions are used in IUPAC and LOINC standard codes. Defined categories are listed in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70254[_HL7 Table 0254 - Kind of Quantity_] in Chapter 2C, Code Tables.\n\nThe distinctions of true quantities in this table are based primarily on dimensional analyses. The table contains a number of \"families,\" those related to simple counts (number, number concentration, etc.), to mass (mass, mass concentration, etc.), to enzyme activity (catalytic content, catalytic concentration, etc.), and molar or equivalents (substance content, substance concentration).\n\nBy this classification, a glucose (in the US) would be classed as a mass concentration. A sodium would be classed as a substance concentration. Within the family, a total amount should be described as the unadorned variant; e.g., the property of measure for a patient's weight would be mass, not mass content. Most chemical measures produce concentrations, as exemplified by sodium and glucose. However, a 24-hour urine protein is not a mass concentration, but a mass rate (mass per unit time). The content variants (e.g., mass content, substance content) are used to reflect an amount per mass (usually) of tissue.\n\nThis attribute would be valued in a master file only if the service sending the master file classified observations by their principle of measurement."
* 43 0..1 CWE "OM1-43" "This optional attribute allows master files to classify observations as measuring the patient's state at a point in time (e.g., spot urines, random urines, serum potassium), or averaged over an interval of time (e.g., concentration, total amount, or clearance over a 24-hour collection). Interval measures most often apply to urine and stool specimens (e.g., 24-hour urines, 3-day stool fats). They also apply to clinical measurements such as urine outputs, which are reported as shift totals and 24-hour totals, and event counts on physiologic monitors such as the number of PVCs on a 24-hour Holter monitor."
* 43 from http://terminology.hl7.org/ValueSet/v2-0255 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #938
* 43 ^comment = "This field would only be valued in a transaction if the service sending this master file message classified its observation by point versus time interval. This field is *not* used to record the time collection interval for a particular sample. It is used to specify a characteristic of an observation which has a defined normal range and to distinguish observations of the same kind but observed over varying periods of time. A spot urine sodium would have PT stored in this field. A 24-hour urine sodium and a 24-hour Holter monitor would have 24H stored here. This attribute would only be valued if the filling service classified its observations by timing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70255[User-defined Table 0255 - Duration Categories] in Chapter 2C, Code Tables, for suggested values."
* 44 0..1 TX "OM1-44" "This optional attribute provides information for classifying observations by the challenge component of the test, if a challenge does speciate the observation. For example, distinguishing tests that have a challenge component in database. There co-ascribes the physiologic or drug challenge that is intrinsic to the measurement. To identify, for example, tests that include a glucose challenge."
* 44 from http://terminology.hl7.org/ValueSet/v2-0257 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 44 ^extension[=].extension[0].url = "length"
* 44 ^extension[=].extension[=].valueInteger = "200"
* 44 ^extension[=].extension[+].url = "noTruncate"
* 44 ^extension[=].extension[=].valueInteger = false
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #939
* 44 ^comment = "To construct this text string, use the following template. (Note: This field is not constructed of formally defined components; it is a free text field. Component delimiters are not used and it is not necessary to supply placeholders if some \"components\" are not used.)\n\nThe time delay follows the syntax: n<S|M|H|D|W> where n is a number (possibly a decimal); S denotes seconds; M denotes minutes; H denotes hours; D denotes days; and W denotes weeks. The time delay can be preceded by a 'greater than' (>) sign, e.g. >4H.\n\nfile:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70256[HL7 Table 0256 - Time Delay Post Challenge] in Chapter 2C, Code Tables, lists possible values for time delay.\n\nExamples:\n\nPRE 100 GM GLUCOSE PO\n\nPRE 100 GM GLUCOSE PO\n\n30M POST 100 GM GLUCOSE PO\n\n2H POST 100 GM GLUCOSE PO\n\nTROUGH\n\nFor drug peak and trough measures the nature of the substance challenged is the same as the analyte name, and need not be included.\n\nWe denote the route of the challenge via abbreviations for medication routes (see Chapter 4A, section 4A.4.2.1, \"Route,\" which references file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70162[HL7 Table 0162 - Route of Administration] in Chapter 2C, Code Tables). An oral route of administration would be denoted by \"PO,\" an intravenous route by \"IV.\"\n\nDetails of the drug dose, time the dose was given, route of administration, etc., would be noted in separate OBX, and would have corresponding master observation definitions stored in the observation master file map to different records stored in the master file segments contained in the drug level message.\n\nThe nature of a physiologic (non-drug) challenge may also be specified, using the terms in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70257[HL7 Table 0257 - Nature of challenge] in Chapter 2C, Code Tables."
* 45 0..1 CWE "OM1-45" "This optional attribute provides a mechanism for classifying observations according to the subject, in relation to the patient whose results might be stored with as \"patient\" data. It is standard practice, for example, to report values for controls, donors, and blood product units as well as the patient's own values, and store them in the patient's record. (This may not be the best way to model such information, but it is the way it is usually reported.) This should be valued when two values (e.g., one for patient and one for a blood product unit) could otherwise be confused."
* 45 from http://terminology.hl7.org/ValueSet/v2-0258 (required)
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #940
* 45 ^comment = "The default value is \"Patient,\" and if not specified, this value is assumed. The persons sub-component can refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70258[HL7 Table 0258 - Relationship Modifier] in Chapter 2C, Code Tables, for valid values."
* 46 0..1 CWE "OM1-46" "This optional attribute formally indicates the site of the observation (to make it easy for a system to find all tests related to one anatomic site). It can be used to classify the observation by target site of the examination. For example, \"heart\" might be recorded as the target of the electrocardiogram, cardiac echo, and thallium exercise test. This attribute would be applicable to most imaging and electro-physiologic examinations. The SNOMED topology axis is an example of a coding system for anatomic sites. User-defined tables may also apply here. Refer to Table 0645 - Target Anatomic Site Of Test in Chapter 2C for valid values."
* 46 from http://terminology.hl7.org/ValueSet/v2-0645 (required)
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #941
* 47 0..1 CWE "OM1-47" "This optional attribute describes the modality used to acquire the observation data, e.g., radiograph, ultrasound, CT scan, MR, etc. This attribute is especially important for imaging studies. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70910[External Table 0910 – Acquisition Modality] in Chapter 2C, Code Tables, for the defined value set, which may be repalce or extended with local codes. If the DICOM codes are used, the coding system ID is DCM."
* 47 from http://terminology.hl7.org/ValueSet/v2-0910 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #942
* 47 ^comment = "*Note: The use of User-defined Table 0259 - Modality for this field is deprecated and retained for backward compatibility as of v 2.7.*"
* 48 0..1 ID "OM1-48" "This field defines if this test should be a specific event with no other tests to be performed with this test. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70919[HL7 Table 0919 – Exclusive Test] in Chapter 2C, Code Tables, for valid values."
* 48 from http://terminology.hl7.org/ValueSet/v2-0919 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 48 ^extension[=].extension[0].url = "min"
* 48 ^extension[=].extension[=].valueInteger = 1
* 48 ^extension[=].extension[+].url = "max"
* 48 ^extension[=].extension[=].valueInteger = 1
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #3310
* 48 ^comment = "If not populated, the default value of \"N\" is assumed and that this test can be included with any number of other tests.\n\nWhen D is specified for this field, using field OM1-49 determines how tests must be grouped together. Tests within the same Diagnostic Service Sector may be on the same requisition, and therefore in the same message."
* 49 0..1 ID "OM1-49" "This field is the section of the diagnostic service where the observation was performed. If the study was performed by an outside service, the identification of that service should be recorded here. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70074[HL7 Table 0074 – Diagnostic Service Section ID] in Chapter 2C, Code Tables, for valid entries. Same as OBR-24."
* 49 from http://terminology.hl7.org/ValueSet/v2-0074 (required)
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 49 ^extension[=].extension[0].url = "min"
* 49 ^extension[=].extension[=].valueInteger = 2
* 49 ^extension[=].extension[+].url = "max"
* 49 ^extension[=].extension[=].valueInteger = 3
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #257
* 50 0..1 CWE "OM1-50" "The species of living organism. This may include the common or scientific name, based on the coding system(s) used. SNOMED is the recommended coding system. If this field is not valued, a human is assumed. Refer to Table 0661 - Taxonomic Classification Code in Chapter 2C for valid values."
* 50 from http://terminology.hl7.org/ValueSet/v2-0661 (required)
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #1539
* 50 ^comment = "For example:\n\n...|L-80700^Canine, NOS^SNM3|...\n\n...|L-80100^Bovine^SNM3|...\n\n...|L-80A00^Feline^SNM3|....\n\nThis field is a list of species or other taxonomic classification(s) to which the indicated specimen type may appropriately be applied for the indicated observation or test. If this field is omitted the default meaning is that the test or observation is applicable to humans. In a veterinary context if the test is applicable to any species, an appropriate code such as \"Kingdom Animalia (organism)\" should be used to avoid confusion with the meaning of human only."
* 51 0..0 ST "OM1-51" "This field contains any test aliases or synonyms for the name in the context of the ordering service. These are alternative names, not associated with a particular coding system, by which the battery, test, or observation (e.g., measurement, test, diagnostic study, treatment, etc.) is known to users of the system. Multiple names in this list are separated by repeat delimiters."
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 51 ^extension[=].extension[0].url = "min"
* 51 ^extension[=].extension[=].valueInteger = 200
* 51 ^extension[=].extension[+].url = "max"
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #3399
* 52 0..0 CWE "OM1-52" "This field is used in conjunction with a MFE-1 Record-Level Event Code 'MDC' defined as: \"Deactivate: discontinue using record in master file, but do not delete from database\", in conjunction with an OM1 segment providing detail for the deactivate code. When the OM1-2 Producer's Service/Test/Observation ID is being deactivated, use OM1-52 to indicate the producer's replacement test or observation code(s), as it was defined in the OM1-2 Producer's Service/Test/Observation ID when the new/replacement code was added. Refer to Table 0646 - Replacement Producer's Service/Test/Observation ID in Chapter 2C for valid values."
* 52 from http://terminology.hl7.org/ValueSet/v2-0646 (required)
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #3433
* 52 ^comment = "*Note:* Replacement codes referenced by OM1-52 must be added to the receiver's system before sending a deactivate record for the code being obsoleted. The Sequence is illustrated below:\n\nSequence 1 – Activate new code\n\nOM1-2 Adding a new code X; Example: X^New Code X^L\n\nOM1-52 Empty\n\nSequence 2 – Deactive obsolete code and indicate it's new replacement code\n\nOM1-2 obsolete code: Examle: Y^Deactivated code^L\n\nOM1-52 X^New Code X^L\n\n_Table below for information in change request proposal process and not intended for inclusion in the base standard:_\n\n_Table below for information in change request proposal process and not intended for inclusion in the base standard:_\n|===\na|\n*File-Level Event*\n\n*MFI-3*\n\na|\n*Record-Level Event*\n\n*MFE-1*\n\n|*Comment*\n|REP |MAD – Add record to master file |Note: If the _MFI-3 - File-Level Event Code_ is \"REP\" (replace file), then each MFE segment must have an _MFE-1 - Record-Level Event Code_ of \"MAD\" (add record to master file).\n|UPD |MAD – Add record to master file |(MFI-3) UPD means that the events are defined according to the record-level event code contained in each MFE segment in that message.\n|UPD |MDC – Deactivate: discontinue using record in master file, but do not delete from database |(MFI-3) UPD means that the events are defined according to the record-level event code contained in each MFE segment in that message.\n|UPD |MAC – Reactivate deactivated record |(MFI-3) UPD means that the events are defined according to the record-level event code contained in each MFE segment in that message.\n|==="
* 53 0..0 TX "OM1-53" "This field is used to indicate when the test in OM1-2 Producer's Service/Test/Observation ID is ordered, prior results should accompany the order (OML^O21^OML_O21: Laboratory Order Message). For example, when ordering a Thyroid FNA (Fine Needle Aspiration) Evaluation, send the prior results of Ultrasound Findings. The instructions may also indicate a timeframe; for example, send the prior results of CBC in past 60 days."
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #3434
* 54 0..1 TX "OM1-54" "This field is used to convey special instructions for the test, for example: \"Chain-of-custody documentation is required for samples submitted for pre-employment, random employee testing, and forensic purposes. For other applications, use the standard request form.\" (Note: this is for toxicology testing); \"If reflex test is performed, additional charges/CPT code(s) may apply.\"; \"Please direct any questions regarding this test to Oncology Customer Service\"; \"Please include tentative diagnosis/treatment on the request form. This is necessary for proper culturing and result interpretation.\" (Note: this is for chromosome analysis.)"
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #3435
* 55 0..0 CWE "OM1-55" "This field may be used to organize tests for display or other user defined purpose. For example, tests might be categorized by disease state, such as molecular tests for solid tumors; example categories are: breast, colorectal, lung, and melanoma."
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #3436
* 56 0..1 CWE "OM1-56" "This field contains the code for resulted tests, which are associated with the Producer’s Service/Test/Observation ID code in OM1-2 and will appear in OBX-3 Observation Identifier in a result message. Refer to Table 0647 - Observation/Identifier associated with Producer’s Service/Test/Observation ID in Chapter 2C for valid values."
* 56 from http://terminology.hl7.org/ValueSet/v2-0647 (required)
* 56 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 56 ^extension[=].valueCode = #O
* 56 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 56 ^code.code = #3437
* 57 0..1 CQ "OM1-57" "This field contains the typical processing time for single test/observation. This field indicates the time from delivery of a specimen or transport of a patient to a diagnostic service and the completion of the study. It includes the usual waiting time."
* 57 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 57 ^extension[=].valueCode = #O
* 57 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 57 ^code.code = #3438
* 58 0..0 CWE "OM1-58" "This field is used to convey gender restrictions for ordering the test specified in OM1-2 Producer's Service/Test/Observation ID. If there are no restrictions the field is left empty. If the test is restricted to order for certain gender(s), the restricted genders are listed. For example, a Prostate Specific AG (PSA) test is typically ordered only for male patients, thus for PSA the field would be valued 'M' for Male."
* 58 from http://terminology.hl7.org/ValueSet/v2-0001 (required)
* 58 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 58 ^extension[=].valueCode = #O
* 58 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 58 ^code.code = #3439
* 58 ^comment = "Note that the field name is historical as gender restriction for procedures and laboratory tests are based upon Sex Parameter for Clinical Use. Refer to User-defined Table 0001 Administrative Sex – or 0828Sex Parameter for Clinical Use in Chapter 2C, Code Tables, for suggested values."
* 59 0..0 NR "OM1-59" "This field is used to convey age restrictions for ordering the test specified in OM1-2 Producer's Service/Test/Observation ID. If there are no restrictions the field is left empty. If the test is restricted to order for certain age(s), the age range restriction(s) are listed in years. For example, newborn tests are typically restricted to age 1 year or below, thus for newborn tests the field would be valued 0^1."
* 59 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 59 ^extension[=].valueCode = #O
* 59 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 59 ^code.code = #3440