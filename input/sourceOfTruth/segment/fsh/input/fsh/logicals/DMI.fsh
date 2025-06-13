Logical: DMI
Parent: $Segment
Id: DMI
Title: "HL7 v2 DMI Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "DRG Master File Information"
* 1 0..1 CNE "DMI-1" "This field contains the DRG for the transaction. Interim DRG's could be determined for an encounter. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70055[External Table 0055 – Diagnosis Related Group] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0055 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #382
* 2 0..1 CNE "DMI-2" "This field indicates the determined Major Diagnostic Category (MDC) value. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70118[External Table 0118 – Major Diagnostic Category] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0118 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #381
* 3 0..1 NR "DMI-3" "This field contains the lower and upper trim points as calculated for this DRG.."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2231
* 3 ^comment = "Example as used in Germany: The \"lower trim point\" is equivalent to 1/3 of the average length of stay for patients having this DRG. The \"upper trim point\" is equivalent to 3 times the average length of stay. It is marked as the right dotted line within the graphics below.\n\nThe following graphics provides an overview of the German usage:\n\nimage:extracted-media/media/image1.wmf[extracted-media/media/image1]\n\nThe gray boxes represent the amount of cases according to the length of stay. The higher and lower 2,5% outliers (white boxes) are cut off. The average length of stay is calculated thereof and is represented by the middle dotted line. From that the lower trim point is calculated by dividing by 3, the upper trim point is the average multiplied with 3."
* 4 0..1 NM "DMI-4" "This field contains the average length of stay in days, calculated as the geometric mean value, allocated to the determined DRG."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "5"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = true
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2232
* 5 0..1 NM "DMI-5" "Each DRG has its own relative weight (cost weight) which is calculated (defined) by official institutions. This value is the basis for calculating other values, e.g., the effective weight."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "7"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2233