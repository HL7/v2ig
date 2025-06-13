Logical: IVC
Parent: $Segment
Id: IVC
Title: "HL7 v2 IVC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Invoice"
* 1 1..1 EI "IVC-1" "Unique Invoice Number assigned by the Provider Application."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1914
* 2 0..1 EI "IVC-2" "Unique Invoice Number assigned by the Payer Application."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1915
* 3 0..1 EI "IVC-3" "Contract/agreement number issued by Payer which must be specified in some circumstances by the Provider."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1916
* 4 1..1 CWE "IVC-4" "Code indicating what action is being performed by this message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70553[_User-defined Table 0553 – Invoice Control Code_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0553 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1917
* 5 1..1 CWE "IVC-5" "Code describing reason for this Invoice. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70554[_User-defined Table 0554 – Invoice Reason Codes_] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0554 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1918
* 6 1..1 CWE "IVC-6" "Code indicating the type of Invoice. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70555[_User-defined Table 0555 – Invoice Type_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0555 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1919
* 7 1..1 DTM "IVC-7" "Date Invoice was created."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1920
* 8 1..1 CP "IVC-8" "Sum total of Product/Service Billed Amount on PSL for all Product/Service Line Items for this Invoice."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1921
* 9 0..1 ST "IVC-9" "Terms for Payer payment of Invoice (e.g., 24% net 30 days)."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "80"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1922
* 10 1..1 XON "IVC-10" "Business organization that is responsible for the invoice (e.g., Provider organization, clinic organization)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #R
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1923
* 11 1..1 XON "IVC-11" "The business organization that is designated as Payer for this Invoice. This Payer may be the primary, secondary, tertiary Payer, depending on Insurance Information specified in the Invoice"
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1924
* 12 0..1 XCN "IVC-12" "Attention to individual in Payer Organization who needs to review this Invoice."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1925
* 13 0..1 ID "IVC-13" "Can be set to indicate that this is the last Invoice for a particular Case, Claim and/or Encounter (1). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator_] for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1926
* 14 0..1 DTM "IVC-14" "Period in which the invoice must be booked."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1927
* 15 0..1 ST "IVC-15" "Responsible Person for this specific invoice. For more structured output use CTD-Segment instead."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "250"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1928
* 16 0..1 CP "IVC-16" "Fixed Amount for this invoice."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1929
* 17 0..1 CP "IVC-17" "Special costs for this invoice."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1930
* 18 0..1 CP "IVC-18" "Special amount for doctor's treatment."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1931
* 19 0..1 XCN "IVC-19" "Doctor who is responsible for this invoice."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1932
* 20 0..1 CX "IVC-20" "Cost centers are organizational units or activities that provide goods and services. In this context, it would be the department which delivered the Service/Product Line Item, e.g., Radiology, Emergency Room."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1933
* 21 0..1 CP "IVC-21" "Deposit paid to the service Provider prior to admission"
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1934
* 22 0..1 CP "IVC-22" "Total amount of Invoice without the prepaid deposit (IV-8 minus IVC-21)."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1935
* 23 0..1 CP "IVC-23" "Total Amount of VAT included in the Total Invoice Amount (IVC-8)"
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #C
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1936
* 24 0..0 NM "IVC-24" "Applied VAT Rates on Invoice. Multiple VAT-rates may be applied according to the type of service"
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 24 ^extension[=].extension[0].url = "length"
* 24 ^extension[=].extension[=].valueInteger = "1"
* 24 ^extension[=].extension[+].url = "noTruncate"
* 24 ^extension[=].extension[=].valueInteger = true
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1937
* 25 1..1 CWE "IVC-25" "Code indicating the Benefit group. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70556[_User-defined Table 0556 – Benefit Group_] in Chapter 2C, Code Tables, for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0556 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #R
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1938
* 26 0..1 ST "IVC-26" "The Tax ID of the Provider (general Tax identification number or VAT number)."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 26 ^extension[=].extension[0].url = "length"
* 26 ^extension[=].extension[=].valueInteger = "20"
* 26 ^extension[=].extension[+].url = "noTruncate"
* 26 ^extension[=].extension[=].valueInteger = false
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2038
* 27 0..1 ST "IVC-27" "The Tax ID of the Payer (general Tax identification number or VAT number)"
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 27 ^extension[=].extension[0].url = "length"
* 27 ^extension[=].extension[=].valueInteger = "20"
* 27 ^extension[=].extension[+].url = "noTruncate"
* 27 ^extension[=].extension[=].valueInteger = false
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2039
* 28 0..1 CWE "IVC-28" "Code indicating the tax status of the provider. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70572[_User-defined Table 0572 – Tax status_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0572 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2040
* 29 0..1 CWE "IVC-29" "Code indicating the tax status of the payer. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70572[_User-defined Table 0572 – Tax status_] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0572 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2041
* 30 0..1 ST "IVC-30" "IVC-30"
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 30 ^extension[=].extension[0].url = "length"
* 30 ^extension[=].extension[=].valueInteger = "20"
* 30 ^extension[=].extension[+].url = "noTruncate"
* 30 ^extension[=].extension[=].valueInteger = false
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2042