Logical: GP2
Parent: $Segment
Id: GP2
Title: "HL7 v2 GP2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Grouping/Reimbursement - Procedure Line Item"
* 1 0..1 CWE "GP2-1" "This field identifies a specific ancillary service for each HCPC/CPT This field is the same as UB92 Form Locator 42 \"Revenue Code\". Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70456[_User-defined Table_ _0456 - Rev__enue Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 1 from http://terminology.hl7.org/ValueSet/v2-0456 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1600
* 2 0..1 NM "GP2-2" "This field contains the quantitative count of units for each HCPC/CPT. This field is the same as UB92 Form Locator 46 \"Units of Service\". This field is defined by CMS or other regulatory agencies."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "7"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = true
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1604
* 3 0..1 CP "GP2-3" "This field contains the amount charged for the specific individual line item (HCPC/CPT). This field is the same as UB92 Form Locator 56. This field is defined by CMS or other regulatory agencies."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1605
* 4 0..1 CWE "GP2-4" "This field identifies the action to be taken during reimbursement calculations. If valued, this code overrides the value in link:#gp2-6-oce-edit-code-cwe-01608[_GP2-6 - OCE Edit Code_]. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70459[_Us__er-defined Table 0459 - Reimbursement Action Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies"
* 4 from http://terminology.hl7.org/ValueSet/v2-0459 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1606
* 5 0..1 CWE "GP2-5" "This field determines the OCE status of the line item. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70460[_User-defined table 0460 - Denial or Rejection Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 5 from http://terminology.hl7.org/ValueSet/v2-0460 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1607
* 6 0..0 CWE "GP2-6" "This field contains the edit that results from the processing of HCPCS/CPT procedures for a line item HCPCS/CPT, after evaluating all the codes, revenue codes, and modifiers. Refer to E:\\\\V2\\\\V29_CH02C_Tables.docx#HL70458[_User-defined Table 0458 -_ _OCE Edit Code_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0458 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1608
* 7 0..1 CWE "GP2-7" "This field contains the derived APC code. This is the APC code used for payment, which is the same as the assigned APC, for all situations except partial hospitalization. If partial hospitalization is billed in this visit, the assigned APC will differ from the APC used for payment. Partial hospitalization is the only time an assigned APC differs from the APC used for payment. The payment APC is used for billing and should be displayed in this field. The first component contains the APC identifier. The second component reports the text description for the APC group. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70466[_User-defined table 0466 - Ambulatory Payment Classification Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 7 from http://terminology.hl7.org/ValueSet/v2-0466 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1609
* 8 0..0 CWE "GP2-8" "This field contains calculated edits of the modifiers for each line or HCPCS/CPT. This field can be repeated up to five times, one edit for each of the modifiers present. This field relates to the values in link:#pr1-16-procedure-code-modifier-cne-01316[_PR1-16 - Procedure Code Modifier_]. Each repetition corresponds positionally to the order of the PR1-16 modifier codes. If no modifier code exists, use the code \"U\" (modifier edit code unknown) as a placeholder. The repetitions of Modifier Edit Codes must match the repetitions of Procedure Code Modifiers. For example, if link:#pr1-16-procedure-code-modifier-cne-01316[_PR1-16 - Procedure Code Modifier_] reports ...|01~02~03~04|... as modifier codes, and modifier code 03 modifier status code is unknown, _GP2-8 - Modifier Edit Code_ would report ...|1~1~U~1|... Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70467[_User-defined table 0467 -_ _Modifier Edit Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies"
* 8 from http://terminology.hl7.org/ValueSet/v2-0467 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1610
* 9 0..1 CWE "GP2-9" "This field contains any payment adjustment due to drugs or medical devices. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70468[_User-defined Table 0468 - Payment Adjustment Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies"
* 9 from http://terminology.hl7.org/ValueSet/v2-0468 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1611
* 10 0..1 CWE "GP2-10" "This field contains the packaging status of the service. A status indicator of N may accompany this, unless it is part of a partial hospitalization. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70469[_User-defined (CMS) Table 0469 - Packaging Status Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 10 from http://terminology.hl7.org/ValueSet/v2-0469 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1617
* 11 0..1 CP "GP2-11" "This field contains the calculated dollar amount that CMS is expected to pay for the line item."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1618
* 12 0..1 CWE "GP2-12" "This field contains the fee schedule reimbursement type applied to the line item. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70470[_User-define__d Table 0470 - Reimbursement Type Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 12 from http://terminology.hl7.org/ValueSet/v2-0470 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1619
* 13 0..1 CP "GP2-13" "This field contains the patient's Co-pay amount for the line item."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1620
* 14 0..1 NM "GP2-14" "This field contains the calculated rate, or multiplying factor, for each service unit for the line item."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "4"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1621