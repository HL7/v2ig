Logical: GP1
Parent: $Segment
Id: GP1
Title: "HL7 v2 GP1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Grouping/Reimbursement - Visit"
* 1 1..1 CWE "GP1-1" "This field is the same as UB92 Form Locator 4 \"Type of Bill\". Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70455[_Us__er-defi__ned Table_ _0455 - Type_ _of Bi__ll Code_] in Chapter 2C, Code Tables, for suggested values. Refer to a UB specification for additional information. This field is defined by CMS or other regulatory agencies. It is a code indicating the specific type of bill with digit 1 showing type of facility, digit 2 showing bill classification, and digit 3 showing frequency."
* 1 from http://terminology.hl7.org/ValueSet/v2-0455 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1599
* 2 0..0 CWE "GP1-2" "This field is the same as UB92 Form Locator 42 \"Revenue Code\". Refer to E:\\\\V2\\\\V29_CH02C_Tables.docx#HL70456[_User-__defined Table 0456 - Revenue Code_] in Chapter 2C, Code Tables, for suggested values. This field identifies revenue codes that are not linked to a HCPCS/CPT code. It is used for claiming for non-medical services such as telephone, TV or cafeteria charges, etc. There can be many per visit or claim. This field is defined by CMS or other regulatory agencies."
* 2 from http://terminology.hl7.org/ValueSet/v2-0456 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1600
* 2 ^comment = "There can also be a revenue code linked to a HCPCS/CPT code. These are found in link:#gp2-1-revenue-code-cwe-01600[_GP2-1 - Revenue Code_]. Refer to UB92 specifications."
* 3 0..1 CWE "GP1-3" "This field identifies the final status of the claim. The codes listed as examples are not an exhaustive or current list, refer to OPPS Final Rule. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70457[_User-define__d Table 04__57 - Overall Claim Disposition_] _Code_ in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 3 from http://terminology.hl7.org/ValueSet/v2-0457 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1601
* 4 0..0 CWE "GP1-4" "This field contains the edits that result from processing the HCPCS/CPT procedures for a record after evaluating all the codes, revenue codes, and modifiers. The codes listed as examples are not an exhaustive or current list, refer to OPPS Final Rule. OCE (Outpatient Code Editor) edits also exist at the pre-procedure level. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70458[_User-defined Table 0458 - OCE_ _Edit Code_] in Chapter 2C, Code Tables, for suggested values. This field is defined by CMS or other regulatory agencies."
* 4 from http://terminology.hl7.org/ValueSet/v2-0458 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1602
* 5 0..1 CP "GP1-5" "This field contains the amount that exceeds the outlier limitation as defined by APC regulations. This field is analogous to link:#drg-7-outlier-cost-cp-00387[_DRG-7 - Outlier Cost_]; however, the definition in this field note supersedes the DRG-7 definition."
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #387