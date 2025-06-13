Logical: PSH
Parent: $Segment
Id: PSH
Title: "HL7 v2 PSH Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Product Summary Header"
* 1 1..1 ST "PSH-1" "This field contains the name, title, or other description of the report. Typically, the field will include the agency name (e.g., FDA), agency component if applicable (e.g., CDRH) and the report type (e.g., Medical Device Reporting Baseline Report)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "60"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1233
* 2 0..1 ST "PSH-2" "This field contains the form descriptor which describes the report. Typically, the field will include the agency name (e.g., FDA), agency component if applicable (e.g., CDRH) and the form number (e.g., 3417)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "60"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1297
* 3 1..1 DTM "PSH-3" "This field contains the date as assigned by the sender."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1235
* 4 0..1 DTM "PSH-4" "This field contains the date that marks the beginning of the time interval covered by the current report."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1236
* 5 0..1 DTM "PSH-5" "This field contains the date which marks the inclusive end of the time interval covered by the current report."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1237
* 6 0..1 CQ "PSH-6" "This field is used to send the number of units of the product manufactured during the reporting interval. The second component can be used to specify the units for the quantity."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1238
* 7 0..1 CQ "PSH-7" "This field is used to send the number of units of the product which was distributed during the reporting interval. The second component can be used to specify the units for the quantity."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1239
* 8 0..1 ID "PSH-8" "This field is used for measuring the quantity distributed. An explanation of the method used for estimation can be included in _PSH-9 Quantity Distributed Comment_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70329[_HL7 Table 0329 - Quantity Method_] for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0329 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 8 ^extension[=].extension[0].url = "min"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^extension[=].extension[+].url = "max"
* 8 ^extension[=].extension[=].valueInteger = 1
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1240
* 9 0..1 FT "PSH-9" "This field is used for any explanatory text needed but in particular should provide a description of the estimation method used. If referring to the description used in a previous report, the comment should include the product identifier and data of that report."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "600"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1241
* 10 0..1 CQ "PSH-10" "This field is used to send the number of units of the product which were in use during the reporting interval. The second component can be used to specify the units for the quantity."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1242
* 11 0..1 ID "PSH-11" "This field contains the method used for measuring the quantity in use. An explanation of the method used for estimation can be included in _PSH-12-quantity in use comment_. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70329[_HL7 Table 0329 - Quantity Method_] for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0329 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1243
* 12 0..1 FT "PSH-12" "This field can be used for any explanatory text needed but in particular should provide a description of the estimation method used. If referring to the description used in a previous report, the comment should include the product identifier and data of the report."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "600"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1244
* 13 0..8 NM "PSH-13" "The field contains the number of product experience reports filed by facility."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "16"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1245
* 14 0..8 NM "PSH-14" "This field contains the number of product experience reports filed by distributor."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "16"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1246