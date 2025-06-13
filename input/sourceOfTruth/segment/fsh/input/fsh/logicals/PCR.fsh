Logical: PCR
Parent: $Segment
Id: PCR
Title: "HL7 v2 PCR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Possible Causal Relationship"
* 1 1..1 CWE "PCR-1" "This field contains the coded identity of the product (drug, device, etc.) which is possibly causally related to the event. Includes the product identity number such as NDC, model or catalogue numbers. If a coded value is not available for the product a text description can be included as the second component of the CWE data. See Chapter 2 for a listing of some recognized coding systems for drugs and devices. Refer to Table 0670 - Implicated Product in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0670 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1098
* 2 0..1 IS "PCR-2" "This field indicates whether the product used was a generic or a branded product. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70249[_User-defined Table 0249 – Generic Product_] for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0249 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "1"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1099
* 3 0..1 CWE "PCR-3" "This field contains the coded classification of the implicated product. For drugs, this would usually be the drug class - calcium channel blocking agents for nifedipine, for example. For other products it would be the generic type of device, e.g., urinary catheter, cardiac pacemaker. If a coded value is not available for the class, a text description can be included. Refer to Table 0671 - Product Class in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0671 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1100
* 4 0..1 CQ "PCR-4" "This field represents the total duration of therapy with product listed. The treatment at the current dose and schedule are indicted in the quantity timing attribute of the RXE segment but the patient may have been treated for some time previously at a different dose or on a different schedule. The quantity in the second component of the CQ should be a time quantity."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1101
* 5 0..1 DTM "PCR-5" "This field indicates the date the product was manufactured."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1102
* 6 0..1 DTM "PCR-6" "This field contains the expiration date indicated on the product packaging."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1103
* 7 0..1 DTM "PCR-7" "If an implantable medical device, this field identifies the date device was implanted."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1104
* 8 0..1 DTM "PCR-8" "If an implantable medical device and it was removed, the field identifies the date it was removed."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1105
* 9 0..1 CWE "PCR-9" "This field indicates whether the product was designed for a single use. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70244[_User-defined Table 0244 – Single Use Device_] for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0244 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1106
* 10 0..1 CWE "PCR-10" "This field contains coded representation of the problem or diagnosis for which the product was used. See Chapter 2 for some coding systems which might be chosen to transmit diagnoses or problems. Refer to Table 0672 - Indication For Product Use in Chapter 2C for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0672 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1107
* 11 0..1 CWE "PCR-11" "A product problem would exist if a product malfunction could lead to death or serious injury. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70245[_User-defined Table 0245 - Product Problem_] for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0245 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1108
* 12 0..3 ST "PCR-12" "This field is an alphanumeric descriptor which identifies the specific item or lot of drug. This descriptor would normally be obtained from the package labeling or item itself."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "199"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1109
* 13 0..1 CWE "PCR-13" "This field indicates that the product is available for analysis. _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70246[User-defined Table 0246 -Product Available for Inspection]_ is used as the HL7 identifier for the user-defined table of values for this field. If the product was returned to the manufacturer, this would be indicated by including the date it was returned in the date product returned to manufacturer element."
* 13 from http://terminology.hl7.org/ValueSet/v2-0246 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1110
* 14 0..1 CWE "PCR-14" "This field indicates the type of product evaluation performed. The evaluation codes listed in SubPart B of the Coding Manual for FDA Form 3500A, \"Type of Evaluation Performed,\" may be used. If no codes are available, text may be sent in the second component of the field. Refer to Table 0673 - Product Evaluation Performed in Chapter 2C for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0673 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1111
* 15 0..1 CWE "PCR-15" "This field identifies the status of product evaluation. Subpart A Item H.3 of the Coding Manual for FDA Form 3500A may also be used. If no codes are available, text may be sent in the second component of the field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70247[_HL7 Table 0247 - Status of Evaluation_] for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0247 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1112
* 16 0..1 CWE "PCR-16" "This field contains the results of the product evaluation. Refer to Table 0674 - Product Evaluation Results in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0674 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1113
* 17 0..1 ID "PCR-17" "This field contains the source of the product evaluated. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70248[_HL7 Table 0248 - Product Source_] for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0248 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1114
* 18 0..1 DTM "PCR-18" "If the product was returned to the manufacturer, this field contains the date it was returned."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1115
* 19 0..1 ID "PCR-19" "This field identifies the qualification of the person operating the device when the event occurred. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70242[_HL7 Table 0242 - Primary Observer's Qualification_] for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0242 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1116
* 20 0..1 ID "PCR-20" "This field represents the assessment of relatedness of the product to the event. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70250[_HL7 Table 0250 - Relatedness Assessment_] for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0250 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1117
* 21 0..6 ID "PCR-21" "This field indicates the action taken as a result of the event. Segment may repeat if multiple categories of evidence are relevant. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70251[_HL7 Table 0251 - Action Taken in Response to the Event_] for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0251 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 2
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1118
* 22 0..6 ID "PCR-22" "This field contains observations made about the event which may bear on causality. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70252[_HL7 Table 0252 - Causality Observations_] for valid values. Segment may repeat if multiple categories of evidence are relevant."
* 22 from http://terminology.hl7.org/ValueSet/v2-0252 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 2
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 2
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1119
* 23 0..3 ID "PCR-23" "The patient identified in the PID segment, who experienced the event, might have been exposed to the potential causal product via an intermediary, e.g., a child might be exposed to a product through the placenta or in breast milk, or a transfusion recipient might be exposed via a blood product. If this is the case, the mechanism of product transmission is identified in this field, using the valid values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70253[_HL7 Table 0253 - Indirect Exposure Mechanism_]. If this field is populated, the identity of the person through whom the product was transmitted is contained in NK1 and RXE segments which follow."
* 23 from http://terminology.hl7.org/ValueSet/v2-0253 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 23 ^extension[=].extension[0].url = "min"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^extension[=].extension[+].url = "max"
* 23 ^extension[=].extension[=].valueInteger = 1
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1120