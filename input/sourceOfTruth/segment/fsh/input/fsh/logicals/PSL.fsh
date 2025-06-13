Logical: PSL
Parent: $Segment
Id: PSL
Title: "HL7 v2 PSL Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Product/Service Line Item"
* 1 1..1 EI "PSL-1" "Unique Product/Service Line Item Number assigned by the Provider Application."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1955
* 2 0..1 EI "PSL-2" "Unique Product/Service Line Item Number assigned by the Payer Application."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1956
* 3 1..1 SI "PSL-3" "Unique sequence number for the Product/Service Line Item – starts with 1, then 2, etc. for each unique Product/Service Line Item in this Invoice."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 4
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1957
* 4 0..1 EI "PSL-4" "Identifier for this Product/Service Line Item assigned by the Provider Application. This will be echoed on all interactions between participants for this Product/Service Line Item."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1958
* 5 0..1 EI "PSL-5" "Identifier for this Product/Service Line Item assigned by the Payer Application. This will be echoed on all interactions between participants for this Product/Service Line Item."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1959
* 6 1..1 CWE "PSL-6" "Processing status for the Product/Service Code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70559[_User-defined Table 0559 – Product/Service Status_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0559 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1960
* 7 1..1 CWE "PSL-7" "Code describing the service that was delivered/received. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70879[_User-defined Table 0879 – Product/Service Code_] in Chapter 2C, Code Tables, for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0879 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1961
* 8 0..5 CWE "PSL-8" "Additional optional modifier(s) for the Product/Service Code (e.g., after hours – evening, after hours – weekend); repeats up to 5 times. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70880[_User-defined Table 0880 – Product/Service Code Modifier_] in Chapter 2C, Code Tables, for suggested values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0880 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1962
* 9 0..1 ST "PSL-9" "Text describing Product/Service Code in PSL."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "80"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = true
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1963
* 10 0..1 DTM "PSL-10" "[ Start ] Date/Time product/service was delivered/received."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1964
* 11 0..1 DTM "PSL-11" "[ End ] Date/Time product/service was delivered/received. If specified, must be greater than or equal to Product/Service Effective Date."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1965
* 12 0..1 CQ "PSL-12" "Amount that has been negotiated for this Product/Service Code on PSL between a Provider and Payer for each unit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70560[_User-defined Table 0560 – Quantity Units_] in Chapter 2C, Code Tables, for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0560 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #C
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1966
* 13 0..1 CP "PSL-13" "This field contains the cost per unit either in monetary amount or in points."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #C
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1967
* 13 ^comment = "Examples:\n\n{empty}1. Qty * cost/unit = gross amount\n\n{empty}2. Qty * cost/unit * factor = gross amount\n\n{empty}3. Qty * cost/point * factor * points = gross amount"
* 14 0..1 NM "PSL-14" "Number of items in each unit – for Services, this should be set to 1."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #C
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "10"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = true
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1968
* 15 0..1 CP "PSL-15" "= Product/Service Quantity * Product/Service Unit Cost"
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1969
* 16 0..1 CP "PSL-16" "Amount that is being billed for this Product/Service Code on PSL, = Product/Service Gross Amount + sum of all Product/Service Adjustments on ADJ for this Product/Service Line Item."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1970
* 16 ^comment = "\\= Product/Service Gross Amount + sum of all Product/Service Adjustments on ADJ"
* 17 0..20 CWE "PSL-17" "Additional codes describing the Product/Service Code on PSL – examples are Northern Allowance, Data Center Numbers, Sequence Numbers; repeats with Product/Service Clarification Code Value. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70561[_User-defined Table 0561 – Product/Services Clarification Codes_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0561 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1971
* 18 0..20 ST "PSL-18" "Actual value for Product/Service Clarification Code Type (40) – examples are \"Y\", \"N\" for Northern Allowance, an actual number for a Data Center Number; repeats with Product/Service Clarification Code Type."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "40"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = false
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1972
* 18 ^comment = "Repeats with Product/Service Clarification Code Type."
* 19 0..5 EI "PSL-19" "Health Documents (electronic or paper) that support this Product/Service Line Item. This includes such health documents as forms used to register a claim with a Payer, reports, medical images, etc."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1973
* 20 0..20 CWE "PSL-20" "Codes indicating special processing requested of Payer for this Product/Service Line Item (e.g., hold until paper supporting documentation is received by Payer). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70562[_User-defined Table 0562 – Processing Consideration Codes_] in Chapter 2C, Code Tables, for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0562 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1974
* 21 1..1 ID "PSL-21" "Set to \"Yes\" if information on this invoice should be treated with increased confidentiality/security. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_User-defined Table 0532 – Expanded Yes/No Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #R
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 4
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1975
* 22 0..1 CWE "PSL-22" "Two Product /Service Line Items (PSL-7) may be in a relation to each other. One could be an addition to another. In this case this field contains the Code of PSL-7 of the \"master\" Product/Service Line Item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70879[_User-defined Table 0879 – Product/Service Code_] in Chapter 2C, Code Tables, for suggested values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0879 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1976
* 23 0..1 CP "PSL-23" "Monetary Amount of product/service item which is for the physician."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1977
* 24 0..1 NM "PSL-24" "Factor to increase the billed amount."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 24 ^extension[=].extension[0].url = "length"
* 24 ^extension[=].extension[=].valueInteger = "5"
* 24 ^extension[=].extension[+].url = "noTruncate"
* 24 ^extension[=].extension[=].valueInteger = true
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1978
* 25 0..1 CX "PSL-25" "Cost centers are organizational units or activities that provide goods and services. In this context, it would be the department which delivered the Service/Product Line Item, e.g., Radiology, Emergency Room."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1933
* 26 0..1 DR "PSL-26" "Begin and end of billing period."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1980
* 27 0..1 NM "PSL-27" "Number of Days for which no invoice is created."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 27 ^extension[=].extension[0].url = "length"
* 27 ^extension[=].extension[=].valueInteger = "5"
* 27 ^extension[=].extension[+].url = "noTruncate"
* 27 ^extension[=].extension[=].valueInteger = false
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1981
* 28 0..1 NM "PSL-28" "Several line items may be grouped to a session."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 28 ^extension[=].extension[0].url = "min"
* 28 ^extension[=].extension[=].valueInteger = 1
* 28 ^extension[=].extension[+].url = "max"
* 28 ^extension[=].extension[=].valueInteger = 4
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1982
* 29 0..1 XCN "PSL-29" "ID of the physician who is providing the Service, e.g., executing the radiology-exam (EAN ID = European Article Numbering)."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1983
* 30 0..1 XCN "PSL-30" "ID of the physician who is responsible for the Service."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1984
* 31 0..1 CWE "PSL-31" "Account role of the physician, for example only billing for the professional part, the technical part or both. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70881[_User-defined Table 0881 – Role Executing Physician_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0881 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1985
* 32 0..1 CWE "PSL-32" "The role of the Physician (\"self-employed\" or \"employed\"). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70882[_User-defined Table 0882 – Medical Role Executing Physician_] in Chapter 2C, Code Tables, for suggested values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0882 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1986
* 33 0..1 CWE "PSL-33" "Left / right. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70894[_User-defined Table 0894 – Side of Body_] in Chapter 2C, Code Tables, for suggested values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0894 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1987
* 34 0..1 NM "PSL-34" "Cost of the service \"professional part\" expressed in \"points\"."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 34 ^extension[=].extension[0].url = "length"
* 34 ^extension[=].extension[=].valueInteger = "6"
* 34 ^extension[=].extension[+].url = "noTruncate"
* 34 ^extension[=].extension[=].valueInteger = true
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1988
* 35 0..1 CP "PSL-35" "Monetary Value of one \"point\" for the professional part of the service."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1989
* 36 0..1 NM "PSL-36" "Internal Scaling Factor for the amount of the professional part of the service."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 36 ^extension[=].extension[0].url = "length"
* 36 ^extension[=].extension[=].valueInteger = "4"
* 36 ^extension[=].extension[+].url = "noTruncate"
* 36 ^extension[=].extension[=].valueInteger = true
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #1990
* 37 0..1 NM "PSL-37" "External Scaling Factor for the amount of the professional part of the service."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 37 ^extension[=].extension[0].url = "length"
* 37 ^extension[=].extension[=].valueInteger = "4"
* 37 ^extension[=].extension[+].url = "noTruncate"
* 37 ^extension[=].extension[=].valueInteger = true
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1991
* 38 0..1 CP "PSL-38" "Total Amount for the professional part of this service."
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1992
* 39 0..1 NM "PSL-39" "Cost of the service (Technical Part) expressed in \"points\"."
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 39 ^extension[=].extension[0].url = "length"
* 39 ^extension[=].extension[=].valueInteger = "6"
* 39 ^extension[=].extension[+].url = "noTruncate"
* 39 ^extension[=].extension[=].valueInteger = true
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1993
* 40 0..1 CP "PSL-40" "Monetary Value of one \"point\" for the technical part of the service."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #1994
* 41 0..1 NM "PSL-41" "Internal Scaling Factor for the amount of the technical part of the service."
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 41 ^extension[=].extension[0].url = "length"
* 41 ^extension[=].extension[=].valueInteger = "4"
* 41 ^extension[=].extension[+].url = "noTruncate"
* 41 ^extension[=].extension[=].valueInteger = true
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1995
* 42 0..1 NM "PSL-42" "External Scaling Factor for the amount of the technical part of the service."
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 42 ^extension[=].extension[0].url = "length"
* 42 ^extension[=].extension[=].valueInteger = "4"
* 42 ^extension[=].extension[+].url = "noTruncate"
* 42 ^extension[=].extension[=].valueInteger = true
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #1996
* 43 0..1 CP "PSL-43" "Total Amount for the technical part of this service."
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #1997
* 44 0..1 CP "PSL-44" "Total Amount of the cost of this service (Professional plus technical part)"
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #1998
* 45 0..1 NM "PSL-45" "VAT–Rate Applied on the total amount of this service."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 45 ^extension[=].extension[0].url = "length"
* 45 ^extension[=].extension[=].valueInteger = "3"
* 45 ^extension[=].extension[+].url = "noTruncate"
* 45 ^extension[=].extension[=].valueInteger = false
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #1999
* 46 0..1 ID "PSL-46" "Main service."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 46 ^extension[=].extension[0].url = "min"
* 46 ^extension[=].extension[=].valueInteger = 1
* 46 ^extension[=].extension[+].url = "max"
* 46 ^extension[=].extension[=].valueInteger = 20
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #2000
* 47 0..1 ID "PSL-47" "Service line item has passed an approved validator software (yes/no). For reason see PSL-48. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator_] in Chapter 2C, Code Tables, for suggested values."
* 47 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 47 ^extension[=].extension[0].url = "min"
* 47 ^extension[=].extension[=].valueInteger = 1
* 47 ^extension[=].extension[+].url = "max"
* 47 ^extension[=].extension[=].valueInteger = 1
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #2001
* 48 0..1 ST "PSL-48" "Reason why the service line item has not passed the validator software."
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 48 ^extension[=].extension[0].url = "length"
* 48 ^extension[=].extension[=].valueInteger = "255"
* 48 ^extension[=].extension[+].url = "noTruncate"
* 48 ^extension[=].extension[=].valueInteger = false
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #2002