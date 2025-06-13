Logical: ADJ
Parent: $Segment
Id: ADJ
Title: "HL7 v2 ADJ Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Adjustment"
* 1 1..1 EI "ADJ-1" "Unique Adjustment Number assigned by the Provider Application."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2003
* 2 1..1 EI "ADJ-2" "Unique Adjustment Number assigned by the Payer Application."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2004
* 3 1..1 SI "ADJ-3" "Unique sequence number for this adjustment – starts with 1, then 2, etc., for each unique adjustment for the Product/Service Line Item."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 4
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2005
* 4 1..1 CWE "ADJ-4" "Indicates the category of adjustment and is used to assist in determining which table is used for Adjustment Reason. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70564[_User-defined Table 0564 – Adjustment Category Code_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0564 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2006
* 5 0..5 CP "ADJ-5" "Adjustment amount, such as taxes, deductibles, previously paid amount."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2007
* 6 0..1 CQ "ADJ-6" "Adjustment quantity."
* 6 from http://terminology.hl7.org/ValueSet/v2-0560 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2008
* 6 ^comment = "X12 REF: table 673 Quantity Qualifier. New values from X12 673 can be added as required. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70560[_User-defined Table 0560 – Quantity Units_] in Chapter 2C, Code Tables, for suggested values."
* 7 0..0 CWE "ADJ-7" "Reason for this adjustment. Codes used to explain a Provider adjustment to a Product/Service Group or Product/Service Line Item by a Provider. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70565[_User-defined Table 0565 – Provider Adjustment Reason Code_] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0565 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2009
* 8 0..1 ST "ADJ-8" "Description of adjustment, such as client instructions."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "250"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2010
* 9 0..1 NM "ADJ-9" "Original value of data item noted in this adjustment."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "16"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2011
* 10 0..1 NM "ADJ-10" "Substituted value of data item noted in this adjustment."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "16"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2012
* 11 0..1 CWE "ADJ-11" "Action requested of party that receives this adjustment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70569[_User-defined Table 0569 – Adjustment Action_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0569 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2013
* 12 0..1 EI "ADJ-12" "Unique Provider Adjustment Number assigned by the Provider Application that is referenced by this Payer Adjustment."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2014
* 13 0..1 EI "ADJ-13" "Unique Provider Product/Service Line Item Number assigned by the Provider Application that is referenced by this Payer Adjustment; used for groups with multiple line items that need to be singled out by a Payer Adjustment."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2015
* 14 1..1 DTM "ADJ-14" "Date/Time adjustment was made. May also be synonymous with Adjudication Date."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #R
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2016
* 15 0..1 XON "ADJ-15" "Business organization that is responsible for the adjustment (e.g., Payer organization); can be used for a Payment/Remittance Advice for 1 Payee from multiple Payers."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2017