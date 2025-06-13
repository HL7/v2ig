Logical: FT1
Parent: $Segment
Id: FT1
Title: "HL7 v2 FT1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Financial Transaction"
* 1 0..1 SI "FT1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment the sequence number shall be 1, for the second occurrence it shall be 2, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #355
* 2 0..1 CX "FT1-2" "This field contains a number assigned by the sending system for control purposes. The number can be returned by the receiving system to identify errors."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 12
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #356
* 3 0..1 ST "FT1-3" "This field uniquely identifies the batch in which this transaction belongs."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 10
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #357
* 4 1..1 DR "FT1-4" "This field contains the date/time or date/time range of the transaction. For example, this field would be used to identify the date a procedure, item, or test was conducted or used. It may be defaulted to today's date. To specify a single point in time, only the first component is valued. When the second component is valued, the field specifies a time interval during which the transaction took place."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #358
* 5 0..1 DTM "FT1-5" "This field contains the date of the transaction that was sent to the financial system for posting."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #359
* 6 1..1 CWE "FT1-6" "This field contains the code that identifies the type of transaction. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70017[_User-de__f__ined Table 0017 - Transaction Ty__pe_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0017 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #360
* 7 1..1 CWE "FT1-7" "This field contains the code assigned by the institution for the purpose of uniquely identifying the transaction based on the Transaction Type (FT1-6). For example, this field would be used to uniquely identify a procedure, supply item, or test for charges, or to identify the payment medium for payments. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70132[_User-__defined Table 0132 - Transaction Code_] in Chapter 2C, Code Tables, for suggested values. See Chapter 7 for a discussion of the universal service ID for charges."
* 7 from http://terminology.hl7.org/ValueSet/v2-0132 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #361
* 8 0..1 BackboneElement "FT1-8" "FT1-8"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #W
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #362
* 8 ^comment = "*Attention: FT__1-8 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6.__*"
* 9 0..1 BackboneElement "FT1-9" "FT1-9"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #W
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #363
* 9 ^comment = "*Attention: FT__1-9 was deprecated as of v 2.3 and the detail was withdrawn and removed from the standard as of v 2.6.__*"
* 10 0..1 NM "FT1-10" "This field contains the quantity of items associated with this transaction."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "6"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #364
* 11 0..1 CP "FT1-11" "This field contains the amount of a transaction. It may be left blank if the transaction is automatically priced. Total price for multiple items."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #365
* 12 0..1 CP "FT1-12" "This field contains the unit price of a transaction. Price of a single item."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #366
* 13 0..1 CWE "FT1-13" "This field contains the department code that controls the transaction code described above. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70049[_User-defined Table 0049 - Department C__ode_] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0049 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #367
* 14 0..1 CWE "FT1-14" "This field contains the identifier of the primary insurance plan with which this transaction should be associated. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70072[_User-defined Table 0072 - Insurance P__l__an ID_] in Chapter 2C, Code Tables, for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0072 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #368
* 15 0..1 CP "FT1-15" "This field contains the amount to be posted to the insurance plan referenced above."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #369
* 16 0..1 PL "FT1-16" "This field contains the current patient location. This can be the location of the patient when the charge item was ordered or when the charged service was rendered. For the current assigned patient location, use _PV1-3 - Assigned Patient Location._"
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #133
* 17 0..1 CWE "FT1-17" "This field contains the code used to select the appropriate fee schedule to be used for this transaction posting. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70024[_User-defined Table 0024 - Fee Schedule_] in chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0024 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #370
* 18 0..1 CWE "FT1-18" "This field contains the type code assigned to the patient for this episode of care (visit or stay). Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70018[_User-defined Table 0018 - Patient Type_] in Chapter 2C, Code Tables, for suggested values. This is for use when the patient type for billing purposes is different than the visit patient type in _PV1-18 - Patient Type_."
* 18 from http://terminology.hl7.org/ValueSet/v2-0018 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #148
* 19 0..0 CWE "FT1-19" "This field contains the primary diagnosis code for billing purposes. ICD9‑CM is assumed for all diagnosis codes. This is the most current diagnosis code that has been assigned to the patient. ICD10 can also be used. The name of coding system (third component) indicates which coding system is used. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70051[_User-defined Table 0051 - Diagnosis Co__de_] in Chapter 2C, Code Tables, for suggested values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0051 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #371
* 20 0..0 XCN "FT1-20" "This field contains the composite number/name of the person/group that performed the test/procedure/transaction, etc. This is the service provider. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70084[_User-defined Table 0084 - Performed by_] in Chapter 2C, Code Tables, for suggested values. As of v 2.7, if _XCN.1 - ID Number_ is populated, then the _XCN.13 - Identifier Type Code_ and the _XCN.9 - Assigning Authority_ or _XCN.22 - Assigning Jurisdiction_ or _XCN.23 - Assigning Agency or Department_ are required. If _XCN.2 - Family Name_ is populated, then the _XCN.10 - Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated."
* 20 from http://terminology.hl7.org/ValueSet/v2-0084 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #372
* 21 0..0 XCN "FT1-21" "This field contains the composite number/name of the person/group that ordered the test/ procedure/transaction, etc. As of v 2.7, if _XCN.1 - ID Number_ is populated, then the _XCN.13 - Identifier Type Code_ and the _XCN.9 - Assigning Authority_ or _XCN.22 - Assigning Jurisdiction_ or _XCN.23 - Assigning Agency or Department_ are required. If _XCN.2 - Family Name_ is populated, then the _XCN.10 - Name Type Code_ is required. No assumptions can be safely made based on position or sequence. Specification of meaning based on sequence is deprecated. ."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #373
* 22 0..1 CP "FT1-22" "This field contains the unit cost of transaction. The cost of a single item."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #374
* 23 0..1 EI "FT1-23" "This field is used when the billing system is requesting observational reporting justification for a charge. This is the number used by a filler to uniquely identify a result. See Chapter 4 for a complete description."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #217
* 24 0..0 XCN "FT1-24" "This field identifies the composite number/name of the person who entered the insurance information."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #765
* 25 0..1 CNE "FT1-25" "This field contains a unique identifier assigned to the procedure, if any, associated with the charge. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70088[_Externally-defined Table 0088 - Procedure Code_] in Chapter 2C, Code Tables, for suggested values. This field is a coded data type for compatibility with clinical and ancillary systems."
* 25 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #393
* 25 ^comment = "As of v 2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nProcedure Code Coding Systems (from HL7 Table 0396)\n\nProcedure Code Coding Systems (from HL7 Table 0396)\n|===\n|Code |Description |Comment / Source\n|C4 |CPT-4 |American Medical Association, P.O. Box 10946, Chicago IL 60610.\n|C5 |CPT-5 |(under development – same contact as above)\n|HCPCS |CMS (formerly HCFA) Common Procedure Coding System |HCPCS: contains codes for medical equipment, injectable drugs, transportation services, and other services not found in CPT4.\n|HPC |CMS (formerly HCFA )Procedure Codes (HCPCS) |Health Care Financing Administration (HCFA) Common Procedure Coding System (HCPCS) including modifiers.footnote:[The HCPCS code is divided into three \"levels.\" Level I includes the entire CPT-4 code by reference. Level II includes the American Dental Association’s Current Dental Terminology (CDT-2) code by reference. Level II also includes the genuine HCPCS codes, approved and maintained jointly by the Alpha-Numeric Editorial Panel, consisting of CMS, the Health Insurance Association of America, and the Blue Cross and Blue Shield Association. Level III are codes developed locally by Medicare carriers. The HCPCS modifiers are divided into the same three levels, I being CPT-4 modifiers, II CDT-2 and genuine HCPCS modifiers, and III being locally agreed modifiers. +\n+\nThe genuine HCPCS codes and modifiers of level II can be found at http://www.hcfa.gov/stats/anhcpcdl.htm. CMS distributes the HCPCS codes via the National Technical Information Service (NTIS, http://www.ntis.gov[www.ntis.gov]) and NTIS distribution includes the CDT-2 part of HCPCS Level II, but does not include the CPT-4 part (Level I). CMS may distribute the CPT-4 part to its contractors.]\n|I10P |ICD-10 Procedure Codes |Procedure Coding System (ICD-10-PCS.) See http://www/hcfa.gov/stats/icd10.icd10.htm for more information.\n|==="
* 26 0..0 CNE "FT1-26" "This field contains the procedure code modifier to the procedure code reported in link:#ft1-25-procedure-code-cne-00393[_FT1-25 - Procedure Code_], when applicable. Procedure code modifiers are defined by regulatory agencies such as CMS and the AMA. Multiple modifiers may be reported. The modifiers are sequenced in priority according to user entry. This is a requirement of the UB and the 1500 claim forms. Multiple modifiers are allowed and the order placed on the form affects reimbursement. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70340[_Externally-defined Table 0340 - Procedure Code Modifier_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0340 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1316
* 26 ^comment = "Usage Rule: This field can only be used if link:#ft1-25-procedure-code-cne-00393[_FT1-25 - Procedure Code_] contains certain procedure codes that require a modifier in order to be billed or performed. For example, HCPCS codes that require a modifier to be precise.\n\nAs of v 2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nProcedure Code Modifier Coding Systems (From HL7 Table 0396)\n\nProcedure Code Modifier Coding Systems (From HL7 Table 0396)\n|===\n|Code |Description |Comment / Source\n|CPTM |CPT Modifier Code |Available for the AMA at the address listed for CPT above. These codes are found in Appendix A of CPT 2000 Standard Edition. (CPT 2000 Standard Edition, American Medical Association, Chicago, IL).\n|HPC |CMS (formerly HCFA )Procedure Codes (HCPCS) |Health Care Financing Administration (HCFA) Common Procedure Coding System (HCPCS) including modifiers.footnote:[The HCPCS code is divided into three \"levels.\" Level I includes the entire CPT-4 code by reference. Level II includes the American Dental Association’s Current Dental Terminology (CDT-2) code by reference. Level II also includes the genuine HCPCS codes, approved and maintained jointly by the Alpha-Numeric Editorial Panel, consisting of CMS, the Health Insurance Association of America, and the Blue Cross and Blue Shield Association. Level III are codes developed locally by Medicare carriers. The HCPCS modifiers are divided into the same three levels, I being CPT-4 modifiers, II CDT-2 and genuine HCPCS modifiers, and III being locally agreed modifiers. +\n+\nThe genuine HCPCS codes and modifiers of level II can be found at http://www.hcfa.gov/stats/anhcpcdl.htm. CMS distributes the HCPCS codes via the National Technical Information Service (NTIS, http://www.ntis.gov[www.ntis.gov]) and NTIS distribution includes the CDT-2 part of HCPCS Level II, but does not include the CPT-4 part (Level I). CMS may distribute the CPT-4 part to its contractors.]\n|I10P |ICD-10 Procedure Codes |Procedure Coding System (ICD-10-PCS.) See http://www/hcfa.gov/stats/icd10.icd10.htm for more information.\n|I9C |ICD-9CM |Commission on Professional and Hospital Activities, 1968 Green Road, Ann Arbor, MI 48105 (includes all procedures and diagnostic tests).\n|ICD10AM |ICD-10 Australian modification |\n|ICD10CA |ICD-10 Canada |\n|==="
* 27 0..1 CWE "FT1-27" "This field indicates the status of the patient's or the patient's representative's consent for responsibility to pay for potentially uninsured services. This element is introduced to satisfy CMS Medical Necessity requirements for outpatient services. This element indicates (a) whether the associated diagnosis codes for the service are subject to medical necessity procedures, (b) whether, for this type of service, the patient has been informed that they may be responsible for payment for the service, and (c) whether the patient agrees to be billed for this service. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70339[_User-defined Table 0339 - Advanced Beneficiary Notice Code_] in Chapter 2C, Code Tables, for suggested values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0339 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1310
* 28 0..1 CWE "FT1-28" "This field is used to document why the procedure found in link:#ft1-25-procedure-code-cne-00393[_FT1-25 - Procedure Code_] is a duplicate of one ordered/charged previously for the same patient within the same date of service and has been determined to be medically necessary. The reason may be coded or it may be a free text entry. This field is intended to provide financial systems information on who to bill for duplicate procedures. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70476[_User-Defined Table 0476 – Medically Necessary Duplicate Procedure Reason_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0476 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1646
* 29 0..1 CWE "FT1-29" "This field has been defined for NDC codes that are required by HIPAA for electronic claims for Pharmacy charges. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70549[_Externally-defined Table 0549- NDC Codes_] in Chapter 2C, Code Tables, for suggested values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0549 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1845
* 29 ^comment = "If a system supports multiple NDC codes for a charge, this information will be sent in OBX segments. FT1-29 and FT1-43 can be used for single NDC codes and quantities instead of using OBX."
* 30 0..1 CX "FT1-30" "The payment reference number of the payment medium reported in link:#ft1-7-transaction-code-cwe-00361[_FT1-7 - Transaction Code_]."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1846
* 31 0..0 SI "FT1-31" "The reference key linking the payment to the corresponding charge in an e-claim. This field should contain the link:#ft1-1-set-id-ft1-si-00355[_FT1-1 - Set ID FT1_] that identifies the charge corresponding to the payment. This field is repeating to allow a payment to be posted against multiple charges."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 31 ^extension[=].extension[0].url = "min"
* 31 ^extension[=].extension[=].valueInteger = 1
* 31 ^extension[=].extension[+].url = "max"
* 31 ^extension[=].extension[=].valueInteger = 4
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1847
* 32 0..0 XON "FT1-32" "This field contains the name of the Facility where the service is performed by the Provider Person/Group identified in _FT1-20 – Performed By Code_."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #2361
* 33 0..1 XON "FT1-33" "This field contains the name of the Facility where the service is ordered by the Ordering Provider/Group identified in _FT1-21 – Ordered By Code_."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #2362
* 34 0..1 CWE "FT1-34" "This field contains the Item Number for a product. If valued, this field will override the value in the Service Catalog. Item Number (along with Model Number) can be seen as a supplemental number for specific equipment or inventory-related charges."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #2363
* 35 0..1 ST "FT1-35" "This field contains the Model Number for a product. If valued, this field will override the value in the Service Catalog. Model Number (along with Item Number) can be seen as a supplemental number for specific equipment or inventory-related charges."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 35 ^extension[=].extension[0].url = "length"
* 35 ^extension[=].extension[=].valueInteger = "20"
* 35 ^extension[=].extension[+].url = "noTruncate"
* 35 ^extension[=].extension[=].valueInteger = false
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #2364
* 36 0..0 CWE "FT1-36" "This field contains a Special Processing Code that is available in reimbursement expressions. If valued, this field will override the value in the Service Catalog."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #2365
* 37 0..1 CWE "FT1-37" "This field contains the state specific or payer specific type of service or place of service."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #2366
* 38 0..1 CX "FT1-38" "This field contains the Referral Number associated with the charge."
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #2367
* 39 0..1 CX "FT1-39" "This field contains an authorization number assigned to the referral charge."
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #2368
* 40 0..1 CWE "FT1-40" "This field contains the Taxonomy code for the Service Provider. It allows the provider to identify their specialty category for the particular service."
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #2369
* 41 0..1 CWE "FT1-41" "This field contains the Revenue Code for the charge. If valued, this field will override the value in the Service Catalog. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70456[_User-defined Table 0456 – Revenue Code_] in Chapter 2C, Code Tables, for suggested values."
* 41 from http://terminology.hl7.org/ValueSet/v2-0456 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1600
* 42 0..1 ST "FT1-42" "This field contains the prescription number as assigned by the pharmacy or treatment application. Equivalent in uniqueness to the pharmacy/treatment filler order number. At some sites, this may be the pharmacy or treatment system (internal) sequential form. At other sites, this may be an external form."
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #325
* 43 0..1 CQ "FT1-43" "This field contains the Drug Code Quantity and the Units of Measurement for the corresponding NDC-Code in _FT1-29 – NDC Code_."
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #2370
* 44 0..1 CWE "FT1-44" "This code defines the timing, transmission method, or format by which a DME Certificate of Medical Necessity report is to be sent for the service."
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #3496
* 44 ^comment = "For the US realm, the ANSI ASC X12 PWK DMERC CMN Indicator Segment, reference element PWK02, listed below is suggested to map to the X12 837 values:\n\nFor the US realm, the ANSI ASC X12 PWK DMERC CMN Indicator Segment, reference element PWK02, listed below is suggested to map to the X12 837 values:\n|===\n|AB |Previously Submitted to Payer\n|AD |Certification Included in this Claim\n|AF |Narrative Segment Included in this Claim\n|AG |No Documentation is Required\n|NS |Not Specified\n|==="
* 45 0..1 CWE "FT1-45" "This code identifies the type of certification for the durable medical equipment service."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #3497
* 45 ^comment = "For the US realm, the ANSI ASC X12 CR3 Durable Medical Equipment Certification Segment, reference element CR301, listed below is suggested to map to the X12 837 values:\n\nFor the US realm, the ANSI ASC X12 CR3 Durable Medical Equipment Certification Segment, reference element CR301, listed below is suggested to map to the X12 837 values:\n|===\n|I |Initial\n|R |Renewal\n|S |Revised\n|==="
* 46 0..1 NM "FT1-46" "This is the length of time, in months, the durable medical equipment is needed."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #3498
* 47 0..1 DT "FT1-47" "This is the durable medical equipment certification revision/recertification date. It is required when the DME Certification Type Code is set to Renewal or Revised."
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #3499
* 48 0..1 DT "FT1-48" "This is durable medical equipment initial certification date. It is used to indicate the beginning of therapy and the DME Certification Type Code is set to Initial."
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #3500
* 49 0..1 DT "FT1-49" "This is the durable medical equipment last certification date. This is required if it is necessary to include supporting documentation in an electronic form for Medicare DMERC claims for which the provider is required to obtain a Certificate of Medical Necessity (CMN) from the physician."
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #3501
* 50 0..1 NM "FT1-50" "This is the length of duration, in days, of medical necessity for the purchased or rental durable medical equipment service."
* 50 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 50 ^extension[=].valueCode = #O
* 50 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 50 ^code.code = #3502
* 51 0..1 MO "FT1-51" "This is the rental price of the durable medical equipment."
* 51 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 51 ^extension[=].valueCode = #O
* 51 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 51 ^code.code = #3503
* 52 0..1 MO "FT1-52" "This is the purchase price for the durable medical equipment."
* 52 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 52 ^extension[=].valueCode = #O
* 52 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 52 ^code.code = #3504
* 53 0..1 CWE "FT1-53" "This is the frequency or type of payment for the rental of durable medical equipment."
* 53 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 53 ^extension[=].valueCode = #O
* 53 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 53 ^code.code = #3505
* 53 ^comment = "For the US realm, the ANSI ASC X12 SV5 Durable Medical Equipment Service Segment, reference element SV506, listed below is suggested to map to the X12 837 values:\n\nFor the US realm, the ANSI ASC X12 SV5 Durable Medical Equipment Service Segment, reference element SV506, listed below is suggested to map to the X12 837 values:\n|===\n|1 |Weekly\n|4 |Monthly\n|6 |Daily\n|==="
* 54 0..1 ID "FT1-54" "This field indicates if the DME Condition Codes apply to the service. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 - Yes/no Indicator] for valid values. A \"Y\" value indicates the condition codes apply. An \"N\" value indicates the condition codes do not apply."
* 54 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 54 ^extension[=].valueCode = #O
* 54 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 54 ^code.code = #3506
* 55 0..2 CWE "FT1-55" "This the condition indicator code for durable medical equipment. It is used on the claim service line when this information is necessary for adjudication. Two occurrences are supported."
* 55 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 55 ^extension[=].valueCode = #O
* 55 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 55 ^code.code = #3507
* 55 ^comment = "For the US realm, the ANSI ASC X12 CRC DMERC Condition Indicator Segment, reference element CRC03, listed below is suggested to map to the X12 837 values:\n\nFor the US realm, the ANSI ASC X12 CRC DMERC Condition Indicator Segment, reference element CRC03, listed below is suggested to map to the X12 837 values:\n|===\n|38 |Certification signed by the physician is on file at the supplier’s office\n|ZV |Replacement Item\n|==="
* 56 0..1 CWE "FT1-56" "This field contains the reason why the service has been performed. Refer to file:///E:\\V2\\V29_CH02C_Tables.docx#HL70964[_User-defined Table HL70964 –Service Reason Code_] for suggested values."
* 56 from http://terminology.hl7.org/ValueSet/v2-0964 (required)
* 56 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 56 ^extension[=].valueCode = #O
* 56 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 56 ^code.code = #3508