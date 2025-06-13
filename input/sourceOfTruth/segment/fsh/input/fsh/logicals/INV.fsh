Logical: INV
Parent: $Segment
Id: INV
Title: "HL7 v2 INV Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Inventory Detail"
* 1 0..1 CWE "INV-1" "Unique identifier for the substance that is in inventory. This is a manufacturer-specific identifier. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70451[_User-defined Table 0451 – Substance Identifier_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0451 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1372
* 1 ^comment = "This field is conditional. It is optional in queries INR^U14 and required in all other messages. Absence of this field in a query means that the result shall be not filtered on inventory item ID."
* 2 0..0 CWE "INV-2" "The status of the inventoried item. The status indicates the current status of the substance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70383[_HL7 Table 0383 – Substance Status_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0383 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1373
* 2 ^comment = "This field is conditional. It is optional in queries INR^U14 and required in all other messages. Absence of this field in a query means that the result shall be not filtered on inventory item status."
* 3 0..1 CWE "INV-3" "The type of substance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70384[_HL7 Table 0384 – Substance Type_] in chapter 2C for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0384 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1374
* 4 0..1 CWE "INV-4" "Identifies the inventory container, e.g., unique identifier of a specific package instance of a specific substance. This is a manufacturer-specific identifier.Refer to Table 0599 - Inventory Container Identifier in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0599 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1532
* 5 0..1 CWE "INV-5" "This is the carrier used to transport the substance containers (e.g., a removable rotor with reagent bottles). Refer to Table 0600 - Container Carrier Identifier in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0600 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1376
* 6 0..1 CWE "INV-6" "Identifies the position (e.g., index) on the carrier. Refer to Table 0601 - Position on Carrier in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0601 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1377
* 7 0..1 NM "INV-7" "This field identifies the initial quantity of the substance in inventory."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "10"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = true
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1378
* 8 0..1 NM "INV-8" "This field is the current quantity, i.e., initial quantity minus what has been actually used."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "10"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1379
* 9 0..1 NM "INV-9" "This field is the available quantity of substance. This is the current quantity minus any planned consumption (e.g., tests that are planned)."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "10"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = true
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1380
* 10 0..1 NM "INV-10" "This field is the consumption that is used each time the equipment uses this substance."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "10"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = true
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1381
* 11 0..1 CWE "INV-11" "This field is the units of measure of the available quantity. If the units are ISO+ units, they should be recorded as single case abbreviations. If the units are ANS+ or L (local), the units and the source code table must be recorded, except that in this case, component delimiters should be replaced by sub-component delimiters. For example, \"l\" indicates liters, whereas pt&&ANS+ indicates pints (ANSI units). The default unit is milliliters (ml), which should be assumed if no units are reported. Refer to Table 0602 - Quantity Units in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0602 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1382
* 12 0..1 DTM "INV-12" "This field is the expiration date/time of the substance."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1383
* 13 0..1 DTM "INV-13" "This field is the time and date when the substance was first used. This date and time can be necessary to determine the stability of the substance. The meaning of the \"first used\" element depends on the substance. In certain cases it means the time when the substance was put on board of the instrument or prepared (mixed), without actually using it in the analysis."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1384
* 14 0..1 BackboneElement "INV-14" "INV-14"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #W
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1385
* 14 ^comment = "*_Attention: As of v2.5 this field was retained for backward compatibility only and withdrawn and removed as of v2.7._* The TQ data type was deprecated; see Chapter 2A, section 2.A.81."
* 15 0..0 CWE "INV-15" "This field is the list of tests and body fluids that relate or correspond to this inventory item . This is a repeating field. An empty field means that this inventory item is not test specific, i.e., it applies to all tests. Refer to Table 0603 - Test/Fluid Identifier(s) in Chapter 2C for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0603 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1386
* 16 0..1 ST "INV-16" "This field specifies the lot number assigned by the manufacturer during production of the substance."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 16 ^extension[=].extension[0].url = "length"
* 16 ^extension[=].extension[=].valueInteger = "200"
* 16 ^extension[=].extension[+].url = "noTruncate"
* 16 ^extension[=].extension[=].valueInteger = false
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1387
* 17 0..1 CWE "INV-17" "This field identifies the manufacturer of this substance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70385[_User-defined Table 0385 – Manufacturer Identifier_] in Chapter 2C, Code Tables, for suggested values. Relevant external code systems may be used, e.g., HIBCC Manufacturers Labeler ID Code (LIC), UPC, NDC, etc."
* 17 from http://terminology.hl7.org/ValueSet/v2-0385 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #286
* 18 0..1 CWE "INV-18" "This field identifies the supplier of this substance. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70386[User-defined Table 0386 – Supplier Identifie]r_ in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0386 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1389
* 19 0..1 CQ "INV-19" "This field is the duration of time that the calibration/usability of the substance is stable. The duration is used to calculate the date/time when this calibration is no longer valid by adding this \"On board stability time\" (INV-19) to the \"First used date / time\" (INV-13)."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1626
* 19 ^comment = "The 1^st^ component defines the time quantity and the 2^nd^ component the time units (see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70255[_HL7 Table 0255 – Duration Categories_]). Recommended accuracy is \"minutes\", \"hours\" and \"days\"."
* 20 0..1 CQ "INV-20" "This field is the target analytical value for a particular test for a specific lot of a manufactured material. Target values for QC purposes are usually selected for their relevance to a reference (normal) range or to a clinically significant decision level."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1896
* 20 ^comment = "The 1^st^ component defines the value and the 2^nd^ component the measurement units."
* 21 0..1 CWE "INV-21" "The type code of an equipment state indicator. Refer to _HL7 Table 0942 – Equipment State Indicator Type Code_ in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0942 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #C
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3488
* 21 ^comment = "Due to its dynamic nature, an equipment state indicator is considered to be a [non-material] inventory item. Its value usually can be derived from the material inventory — in that way, a state indicator differs from static configuration parameters and master data stored on the equipment.\n\nThis field is conditional. It is optional when INV‑3 “Substance Type” is not populated and prohibited otherwise."
* 22 0..1 CQ "INV-22" "The numeric value of the equipment state indicator specified in INV-21. The 1^st^ component defines the number and the 2^nd^ component the units of measurement."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3489
* 22 ^comment = "This field is conditional. It is optional when INV‑21 “Equipment State Indicator Type Code” is populated and prohibited otherwise."