Logical: OM7
Parent: $Segment
Id: OM7
Title: "HL7 v2 OM7 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Additional Basic Attributes"
* 1 1..1 NM "OM7-1" "This field contains the same value as the sequence number of the associated OM1 segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 1..1 CWE "OM7-2" "This field contains the producer's usual or preferred identification of the test or service."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #238
* 3 0..0 CWE "OM7-3" "This field contains the category name (term given to a group of service items for the purpose of classification). Examples: Laboratory, Pharmacy, Diagnostic Imaging, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70412[User-defined Table 0412 - Category Identifier] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0412 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1481
* 4 0..1 TX "OM7-4" "This field contains a text description for the category of the test/service item."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "200"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = false
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1482
* 4 ^comment = "Example: The category \"Pathology\" may be described as a specialty practice concerned with all aspects of disease, with special reference to the essential natural cause and development of abnormal conditions, as well as the structural and functional changes that result from the disease process."
* 5 0..0 ST "OM7-5" "This field contains an alternate name(s) for the category of the test/service. Example: The category \"Radiology\" is a synonym name for the category \"Diagnostic Imaging\"."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "200"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1483
* 6 0..1 DTM "OM7-6" "This field contains the date and time that the service item is available to be ordered, performed, etc."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1484
* 7 0..1 DTM "OM7-7" "This field contains the date and time that the service item is no longer authorized to be ordered, performed, etc."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1485
* 8 0..1 NM "OM7-8" "This field indicates the default duration quantity for the service."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "5"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1486
* 9 0..1 CWE "OM7-9" "This field indicates the default duration units for the service. Refer to Table 0663 - Test/Service Default Duration Units in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0663 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1487
* 10 0..1 CWE "OM7-10" "This field indicates the default frequency (how often) the service would be ordered for or performed on."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "60"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1488
* 11 0..1 ID "OM7-11" "This field indicates if a consent is needed for the service item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables."
* 11 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1489
* 11 ^comment = "Y A consent is required for service item to be ordered/performed.\n\nN No consent is needed for service item to be ordered/performed"
* 12 0..1 CWE "OM7-12" "This field contains the identifier for the consent specified for the service item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70413[User-defined Table 0413 - Consent Identifier] in Chapter 2C, Code Tables, for suggested values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0413 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1490
* 13 0..1 DTM "OM7-13" "This field contains the date and time the consent is valid for the service item."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1491
* 14 0..1 DTM "OM7-14" "This field contains the date and time the consent is no longer valid for the test/service."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1492
* 15 0..1 NM "OM7-15" "This field specifies the period of time for which a consent is valid for a specific service item."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "5"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = true
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1493
* 16 0..1 CWE "OM7-16" "This field specifies the unit of time for _OM7-15 - Consent Interval Quantity_. Refer to link:\\\\\\\\vmware-host\\\\Shared Folders\\\\Standards\\\\HL7\\\\Labs - US Realm\\\\Archives\\\\eDOS Past Ballots\\\\V281_CH02C_CodeTables.doc#HL70414[User-defined Table 0414 - Units of Time] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0414 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1494
* 16 ^comment = "*Note:* If Consent Interval Quantity is specified, then Consent Interval Unit is required."
* 17 0..1 NM "OM7-17" "This field contains the time period between the time the consent is signed and the procedure can be performed."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "5"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = true
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1495
* 18 0..1 CWE "OM7-18" "This field specifies the unit of time for _OM7-17 - Consent Waiting Period Quantity_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70414[User-defined Table 0414 - Units of time] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0414 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #C
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1496
* 18 ^comment = "*Note:* If Consent Waiting Period Quantity is specified, then Consent Waiting Period Unit is required."
* 19 0..1 DTM "OM7-19" "This field contains the date and time of the last change in the test procedure that would make previous results incompatible with new results."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #607
* 20 0..1 XCN "OM7-20" "This field contains the identity of the person who actually keyed the service item into the application. It provides an audit trail in case the request is entered incorrectly and the ancillary department needs to clarify the request."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #B
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #224
* 20 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 21 0..0 PL "OM7-21" "This field contains the location(s) where the test/service can be ordered."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #B
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1497
* 21 ^comment = "*Note: This field is deprecated and retained for backward compatibility as of v 2.8.*"
* 22 0..1 CWE "OM7-22" "This field indicates whether or not the service (pharmaceutical) is in the formulary. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70473[User-defined Table 0473 - Formulary Status] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0473 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 22 ^extension[=].extension[0].url = "length"
* 22 ^extension[=].extension[=].valueInteger = "1"
* 22 ^extension[=].extension[+].url = "noTruncate"
* 22 ^extension[=].extension[=].valueInteger = false
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1498
* 23 0..1 ID "OM7-23" "This field indicates whether or not the service (pharmaceutical) is a special order. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1499
* 23 ^comment = "Y This is a special order.\n\nN This is not a special order"
* 24 0..0 CWE "OM7-24" "Allows the ability to associate a Service/Test/Observation item with a CIM (charge item master). This field contains the corresponding value of CDM-1 for the CIM being linked to. It is possible to allow multiple charge items to a single Service/Test/Observation item."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1306