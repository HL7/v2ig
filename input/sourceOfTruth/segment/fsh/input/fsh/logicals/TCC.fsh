Logical: TCC
Parent: $Segment
Id: TCC
Title: "HL7 v2 TCC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Test Code Configuration"
* 1 1..1 CWE "TCC-1" "This field identifies the test code that information is being transmitted about. The alternate elements represent the test code identifier that has been assigned by the manufacturer to this particular test code. Refer to Table 0787 - Universal Service Identifier in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0787 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #238
* 2 1..1 EI "TCC-2" "This field identifies the test application code assigned by the manufacturer of the equipment or reagents and associated with performing of the particular test specified by the Universal Test Identifier."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1408
* 3 0..1 BackboneElement "TCC-3" "TCC-3"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #W
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #249
* 3 ^comment = "*_Attention: As of version 2.5 this field was deprecated and retained for backward compatibility only and withdrawn as of v2.7._*"
* 4 0..1 SN "TCC-4" "This field is the value that is to be used as the default factor for automatically diluting a specimen by an instrument for this particular test code. (See examples in definition of _13.3.3.29_, \"_SAC-29 Dilution Factor_ (SN) 01356\" in, \"Specimen Container Detail Segment.\")"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1410
* 5 0..1 SN "TCC-5" "This field is the value that is to be used as the default factor for automatically diluting a specimen in case of rerun for this particular test code."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1411
* 6 0..1 SN "TCC-6" "This field is the value that is to be used as the default factor for a specimen that is delivered to the laboratory automation system as pre-diluted for this particular test code."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1412
* 7 0..1 SN "TCC-7" "This field represents a baseline value for the measured test that is inherently contained in the diluent. In the calculation of the actual result for the measured test, this baseline value is normally considered."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1413
* 8 0..1 NM "TCC-8" "This field is the value that is to be used as the threshold for initiating inventory warning-level messages."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "10"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1414
* 9 0..1 ID "TCC-9" "This field identifies whether or not automatic reruns are to be initiated on specimens for this particular test code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 -Yes/no Indicator_] for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1415
* 10 0..1 ID "TCC-10" "This field identifies whether or not automatic repeat testing is to be initiated on specimens for this particular test code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 -Yes/no Indicator_] for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1416
* 11 0..1 ID "TCC-11" "This field identifies whether or not automatic or manual reflex testing is to be initiated on specimens for this particular test code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 -Yes/no Indicator_] for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1417
* 12 0..1 SN "TCC-12" "This is the range over which the equipment can produce results."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1418
* 13 0..1 CWE "TCC-13" "This field is the units that have a data type of CWE. The default coding system for the units codes consists of the ISO+ abbreviation for a single case unit (ISO 2955‑83) plus extensions, that do not collide with ISO abbreviations (see Chapter 7, section 7.4.2.6). We designate this coding system as ISO+. Both the ISO unit's abbreviations and the extensions are defined in Chapter 7, section 7.4.2.6.2 and listed in Figure 7-9. The ISO+ abbreviations are the codes for the default coding system. Consequently, when ISO+ units are being used, only ISO+ abbreviations need be sent, and the contents of the units field will be backward compatible to HL7 Version 2.1. For more information on this field see reference Chapter 7, section 7.4.2.6."
* 13 from http://terminology.hl7.org/ValueSet/v2-0788 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #574
* 13 ^comment = "These units apply to fields \"Endogenous content of pre-dilution diluent\" and \"Equipment dynamic range\".\n\nRefer to Table 0788 - Units in Chapter 2C for valid values."
* 14 0..1 CWE "TCC-14" "This field identifies the processing type that applies to this test code. If this attribute is omitted, then regular production is the default. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70388[_HL7 Table 0388 – Processing Type_] in Chapter 2C, Code Tables, for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0388 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1419
* 15 0..1 CWE "TCC-15" "This field identifies the test the Test Criticality. The values in this field are used for decisions, which tests should be performed, in case of, e.g., insufficient specimen volume. +\n\nThe data type is CWE because its meaning is a coded value. However, in order to make the processing decisions easy the content can be a sequential number of the test sorted according to the criticality assigned by the lab. The lower numbers are more critical than higher numbers."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 705
* 15 ^extension[=].extension[+].url = "max"
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3313