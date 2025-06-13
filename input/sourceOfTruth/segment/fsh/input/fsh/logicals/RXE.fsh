Logical: RXE
Parent: $Segment
Id: RXE
Title: "HL7 v2 RXE Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Encoded Order"
* 1 0..1 BackboneElement "RXE-1" "RXE-1"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #W
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #221
* 1 ^comment = "Attention: The RXE-1 field was retained for backward compatibilty only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7."
* 2 1..1 CWE "RXE-2" "This field identifies the medical substance or treatment that has been ordered to be given to the patient, as encoded by the pharmacy or treatment supplier; it is equivalent to _OBR-4-universal service ID_ in function. In the RXE segment, this give code must be fully encoded. The dispense fields, which define the units and amount of what is to be issued to the patient (see _RXE-10-dispense amount_ and _RXE-11-dispense units_ below) do not necessarily correlate with the instructions of what amount is to be \"given\" or administered with each dose, and may or may not be specified with the order. For example, the \"give\" part of the order may convey the field-representation of _give 250 mg of Ampicillin_, while the request to dispense part of the order may convey _issue 30 tablets of generic equivalent for this outpatient prescription_."
* 2 from http://terminology.hl7.org/ValueSet/v2-0479 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #317
* 2 ^comment = "The coding system used is conditional on both the nature of the medical substance or treatment ordered and site-specific implementation considerations. For vaccines, file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70292[_HL7 Table 0292 – Vaccines Administered_] is the preferred coding system. For non-vaccine products, the coding system may be a local implementation of file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70479[_User-defined Table 0479 – Pharmaceutical Substances_] or an external coding system. Examples of external coding systems include, but are not limited to, National Drug Codes (NDC), Medispan Generic Product Identifier (MGPI), Drug Descriptor Identifier (DDID), and other drug codes listed in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70396[_HL7 Table 0396 – Coding Systems_]. The following examples illustrate some code tables other than User-defined Table 0479:\n\nNDC: 0006915404^Norvasc 10mg Tabs^NDC\n\nDDID: 015189^Norvasc 10mg Tabs^DDID\n\nCVX (HL70292): 30^HBIG^CVX"
* 3 1..1 NM "RXE-3" "This field contains the ordered amount as encoded by the pharmacy or treatment supplier. In a variable dose order, this is the minimum ordered amount. In a non-varying dose order, this is the exact amount of the order."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #318
* 3 ^comment = "*Note:* This field is not a duplication of the first component of the quantity/timing field, since in non-pharmacy/treatment orders, that component can be used to specify multiples of an ordered amount. +\n\n+\n\nAnother way to say this is that, for pharmacy/treatment orders, the quantity component of the quantity/timing field refers to what is to be given out at each service interval; thus, in terms of the RX order, that first component always defaults to 1. Hence, in the actual execution of the order, the value of 1 in the first component of the quantity/timing field always refers to one administration of the amount specified in this field (the requested Give Amount field)."
* 4 0..1 NM "RXE-4" "In a variable dose order, this is the maximum ordered amount. In a non-varying dose, this field is not used."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #319
* 5 1..1 CWE "RXE-5" "This field contains the units for the give amount as encoded by the pharmacy or treatment (e.g., respiratory therapy) application. Refer to Table 0715 - Give Units in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0715 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #320
* 5 ^comment = "*Note:* These units can be a \"compound quantity\"; i.e., the units may contain the word \"per.\" For example, micrograms per KG (micg/kg) is an acceptable value, which means that the units are micrograms per KG (of body weight).\n\nA table of standard units that contains compound units is needed. Until such a table is agreed on, a user-defined table is needed for each site."
* 6 0..1 CWE "RXE-6" "The dosage form indicates the manner in which the medication or treatment is aggregated for dispensing, e.g., tablets, capsules, suppositories. In some cases, this information is implied by the give code in _RXE-2-Give Code_. Use the _RXE-6-Give Dosage Form_ when the give code does not specify the dosage form. Refer to Table 0716 - Give Dosage Form in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0716 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #321
* 7 0..0 CWE "RXE-7" "This field contains the ordering provider's instructions to the patient or the provider administering the drug or treatment. If coded, a user-defined table must be used; if free text (describing a custom IV, mixture, or salve, for example), place the text in the second component, e.g., |^this is a free text administration instruction|.Refer to Table 0718 - Provider's Administration Instructions in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0718 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #298
* 8 0..1 BackboneElement "RXE-8" "RXE-8"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #W
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #299
* 8 ^comment = "Attention: The RXE-8 field was retained for backward compatibilty only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7."
* 9 0..1 ID "RXE-9" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70167[_HL7 Table 0167 - Substitution Status_] in Chapter 2C, Code Tables, for valid values. If a substitution has been made, and a record of the original requested give code (_RXO-1-requested give code_) is needed, the optional RXO segment can be included in the RDE message."
* 9 from http://terminology.hl7.org/ValueSet/v2-0167 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #322
* 10 0..1 NM "RXE-10" "This field contains the amount to be dispensed as encoded by the pharmacy or treatment supplier."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #323
* 11 0..1 CWE "RXE-11" "This field contains the units for the dispense amount as encoded by the pharmacy or treatment supplier. This field is required if the units are not implied by the actual dispense code. This must be in simple units that reflect the actual quantity of the substance dispensed. It does not include compound units. Refer to Table 0720 - Dispense Units in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0720 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #C
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #324
* 12 0..1 NM "RXE-12" "This field contains the total original number of refills. Outpatient only."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "3"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #304
* 13 0..0 XCN "RXE-13" "*_This field is retained for backward compatibility only as of v 27._* The reader is referred to the PRT segment described in Chapter 7."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #B
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #305
* 13 ^comment = "This field is defined as conditional because it is required when the substance requested is a controlled substance (e.g., a narcotic). If the person referenced in this field is also referenced in PRT segment, they must contain the same information. However, if there is a difference, then PRT segment takes precedence."
* 14 0..0 XCN "RXE-14" "*_This field is retained for backward compatibility only as of v 27._* The reader is referred to the PRT segment described in chapter 7."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #B
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #306
* 14 ^comment = "This field contains the provider ID of Pharmacist/treatment supplier's verifier. Use if required by the pharmacy or treatment application or site on orders (or some subgroup of orders). If the person referenced in this field is also referenced in PRT segment, they must contain the same information. However, if there is a difference, then PRT segment takes precedence."
* 15 0..1 ST "RXE-15" "This field contains the prescription number as assigned by the pharmacy or treatment application. Equivalent in uniqueness to the pharmacy/treatment filler order number. At some sites, this may be the pharmacy or treatment system (internal) sequential form. At other sites, this may be an external form. This is a required field in RXE when used in pharmacy/treatment messages, but it is not required when used in product experience messages (see Chapter 7)."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "20"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #325
* 16 0..1 NM "RXE-16" "Number of refills remaining. This field is conditional because it is required when a prescription is dispensed to an outpatient. It is not relevant to inpatient treatment orders."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #326
* 17 0..1 NM "RXE-17" "Number of refills remaining. This field is conditional because it is required when a prescription is dispensed to an outpatient. It is not relevant to inpatient treatment orders."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #C
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #327
* 18 0..1 DTM "RXE-18" "Date/time of the most recent refill or dose dispensed."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #C
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #328
* 19 0..1 CQ "RXE-19" "This field contains the total daily dose for this particular pharmaceutical as expressed in terms of actual dispense units."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #C
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #329
* 20 0..1 ID "RXE-20" "This field uses file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables. The values have the following meaning for this field:"
* 20 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #307
* 20 ^comment = "Y Yes - Indicates that a warning is present. The application receiving the encoded order needs to warn the person administering the drug or treatment to pay attention to the text in _RXE-21-pharmacy/treatment special dispensing instructions_.\n\nN No - Indicates no warning is present. This is the equivalent default (null) value."
* 21 0..0 CWE "RXE-21" "This field contains the pharmacy or treatment supplier's provider-generated special instructions to the provider dispensing/administering the order. Refer to Table 0721 - Special Dispensing Instructions in Chapter 2C for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0721 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #330
* 22 0..1 ST "RXE-22" "This field contains the time unit to use to calculate the rate at which the pharmaceutical is to be administered."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 22 ^extension[=].extension[0].url = "length"
* 22 ^extension[=].extension[=].valueInteger = "20"
* 22 ^extension[=].extension[+].url = "noTruncate"
* 22 ^extension[=].extension[=].valueInteger = false
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #331
* 22 ^comment = "Format:\n\nFormat:\n|===\n|S<integer> |= |<integer> seconds\n|M<integer> |= |<integer> minutes\n|H<integer> |= |<integer> hours\n|D<integer> |= |<integer> days\n|W<integer> |= |<integer> weeks\n|L<integer> |= |<integer> months\n|T<integer> |= |at the interval and amount stated until a total of <integer> \"DOSAGE\" is accumulated. Units would be assumed to be the same as in the QUANTITY field.\n|INDEF |= |do indefinitely - also the default\n|===\n\nThis is the same as the format specified for the DURATION component of the quantity/timing field, excluding the \"X\" specification.\n\nThis field is defined as conditional because it is required when the ordered substance is to be administered continuously at a prescribed rate (e.g., certain IVs). For example, if the \"give amount/units\" were 300 ml and the \"give per\" time unit were H1 (equivalent to one hour), the rate is 300ml/hr."
* 23 0..1 ST "RXE-23" "This field contains the rate at which the substance should be administered."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "6"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = false
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #332
* 24 0..1 CWE "RXE-24" "This field contains the units for _RXE-23-give rate amount_. May be composite. The ratio of the _RXE-23-give rate amount_ and _RXE-24-give rate units_ defines the actual rate of administration. Thus, if _RXE-23-give rate amount_ = 100 and _RXE-24-give rate units_ = ml/hr, the requested rate of administration is 100 ml/hr. (See ISO+ figure 7-9 in Chapter 7 for possible compound units codes.) Refer to Table 0722 - Give Rate Units in Chapter 2C for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0722 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #333
* 25 0..1 NM "RXE-25" "Use when _RXE-2-give code_ does not specify the strength. This is the numeric part of the strength, used in combination with _RXE-26-give strength units_."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1126
* 26 0..1 CWE "RXE-26" "Use when _RXE-2-Give Code_ does not specify the strength. This is the unit of the strength, used in combination with _RXE-25-Give Strength_. Refer to Table 0723 - Give Strength Units in Chapter 2C for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0723 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1127
* 26 ^comment = "*Note:* These units can be a \"compound quantity\"; i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 27 0..0 CWE "RXE-27" "This field identifies the condition or problem for which the drug/treatment was prescribed. May repeat if multiple indications are relevant. Refer to Table 0724 - Give Indication in Chapter 2C for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0724 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1128
* 28 0..1 NM "RXE-28" "This field contains the size of package to be dispensed. Units are transmitted in _RXE-29-dispense package size unit._"
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1220
* 29 0..1 CWE "RXE-29" "This field contains the units in which _RXE-28-dispense package size_ is denominated. Refer to Table 0726 - Dispense Package Size Unit in Chapter 2C for valid values."
* 29 from http://terminology.hl7.org/ValueSet/v2-0726 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1221
* 30 0..1 ID "RXE-30" "This field contains the method by which treatment is dispensed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70321[_HL7 Table 0321 - Dispense Method_] in Chapter 2C, Code Tables, for valid values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0321 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 30 ^extension[=].extension[0].url = "min"
* 30 ^extension[=].extension[=].valueInteger = 1
* 30 ^extension[=].extension[+].url = "max"
* 30 ^extension[=].extension[=].valueInteger = 2
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1222
* 31 0..0 CWE "RXE-31" "This field accommodates the identification of any codes that might be associated with the pharmaceutical substance. Common codes include: the Generic Product Identifier (GPI), Generic Code Number_Sequence Number (GCN_SEQNO), National Drug Code (NDC). Refer to Table 0727 - Supplementary Code in Chapter 2C for valid values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0727 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1476
* 32 0..1 DTM "RXE-32" "This field contains the date/time of the original order (ORC-9) when a refill authorization is being requested. This was represented in the ORC-9 of the original order transaction."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1673
* 33 0..1 NM "RXE-33" "RXE-33"
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 33 ^extension[=].extension[0].url = "length"
* 33 ^extension[=].extension[=].valueInteger = "5"
* 33 ^extension[=].extension[+].url = "noTruncate"
* 33 ^extension[=].extension[=].valueInteger = true
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1674
* 33 ^comment = "Description: This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5 ML, which would be encoded in RXE-25, RXE-26, RXE-33 and RXE-34 as:\n\nRXE|||||||||||||||||||||||||120|mg^^ISO|||||||5|ml^^ISO ...<cr>"
* 34 0..1 CWE "RXE-34" "RXE-34"
* 34 from http://terminology.hl7.org/ValueSet/v2-0729 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1675
* 34 ^comment = "Description: This field indicates the volumetric unit associated with _RXE-33 Give Drug Strength Volume_. See example in RXE-33. Refer to Table 0729 - Give Drug Strength Volume Units in Chapter 2C for valid values."
* 35 0..1 CWE "RXE-35" "This field specifies the class of the drug or other substance if its usage is controlled by legislation. In the USA, such legislation includes the federal Controlled Substance Act (CSA) or a State Uniform Controlled Substance Act. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70477[_User-defined table 0477 – Controlled Substance Schedule_] in Chapter 2C, Code Tables, for valid values for USA usage. Other countries should create their own versions of this table."
* 35 from http://terminology.hl7.org/ValueSet/v2-0477 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1676
* 35 ^comment = "Because some jurisdictions may extend the list of drugs in a particular class and may create an additional schedule, table 0477 is user-defined."
* 36 0..1 ID "RXE-36" "This field specifies whether or not the pharmaceutical substance is part of the local formulary. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70478[_HL7 table 0478 - Formulary Status_] in Chapter 2C, Code Tables, for valid values."
* 36 from http://terminology.hl7.org/ValueSet/v2-0478 (required)
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 36 ^extension[=].extension[0].url = "min"
* 36 ^extension[=].extension[=].valueInteger = 1
* 36 ^extension[=].extension[+].url = "max"
* 36 ^extension[=].extension[=].valueInteger = 1
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #1677
* 37 0..0 CWE "RXE-37" "This field specifies a pharmaceutical substance that is in the formulary that could be prescribed in lieu of the substance being prescribed. In the case where the specified medication is non-formulary this field would contain therapeutic alternatives that are on the formulary. Refer to Table 0730 - Pharmaceutical Substance Alternative in Chapter 2C for valid values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0730 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1678
* 38 0..1 CWE "RXE-38" "This field specifies the pharmacy that last filled the prescription. Refer to Table 0732 - Pharmacy of Most Recent Fill in Chapter 2C for valid values."
* 38 from http://terminology.hl7.org/ValueSet/v2-0732 (required)
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1679
* 39 0..1 NM "RXE-39" "This field specifies the quantity dispensed on the original fill (first fill) of a prescription when that amount is not the same as the quantity to be used in refills. One use case is when a new medication is being prescribed and the prescriber wants to determine if the patient will tolerate the medication. The prescriber indicates that the medication should be filled for an initial amount of 30 tablets and, if tolerated, refilled using a quantity of 100 tablets. In this case, RXE-39 would contain 30 and RXE-10 would contain 100."
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1680
* 39 ^comment = "If this field is not populated, then the initial dispense amount is the same as RXE-10.\n\nThe units are identified in RXE-11."
* 40 0..1 CWE "RXE-40" "*_This field is retained for backward compatibility only as of v 27._* The information formerly communicated using this field should now be communicated using the PRT segment. The reader is referred to chapter 7 for a description of that segment. Refer to Table 0733 - Dispensing Pharmacy in Chapter 2C for valid values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0733 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #B
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #1681
* 40 ^comment = "This field specifies the pharmacy that will dispense or has dispensed the prescription. In the context of an order/request (i.e., in an RXO segment) this field represents the requested dispensing pharmacy. In the context of a registered order (i.e., in an RXE segment) this field represents the intended dispensing pharmacy, the pharmacy that is expected to dispense the prescription."
* 41 0..1 XAD "RXE-41" "*_This field is retained for backward compatibility only as of v 27._* The information formerly communicated using this field should now be communicated using the PRT segment. The reader is referred to chapter 7 for a description of that segment."
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #B
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1682
* 41 ^comment = "This field specifies the address of the dispensing facility."
* 42 0..1 PL "RXE-42" "This field specifies the location of the patient to whom the pharmaceutical substance is to be delivered."
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #1683
* 43 0..1 XAD "RXE-43" "This field specifies the address, either mailing or physical, to which the prescription should be mailed or delivered."
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #1684
* 44 0..1 ID "RXE-44" "The Pharmacy Order Type field defines the general category of pharmacy order which may be used to determine the processing path the order will take. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70480[_HL7 Table 0480 Pharmacy Order Types_] in Chapter 2C, Code Tables, for valid values."
* 44 from http://terminology.hl7.org/ValueSet/v2-0480 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 44 ^extension[=].extension[0].url = "min"
* 44 ^extension[=].extension[=].valueInteger = 1
* 44 ^extension[=].extension[+].url = "max"
* 44 ^extension[=].extension[=].valueInteger = 1
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #1685
* 44 ^comment = "This field may also be used for grouping of related orders for processing and/or reports. For example, Medication Administration Records (MARs) often group large volume solutions, medications and small volume solutions differently based upon site-specific workflow.\n\nUsage Rule: This field is optional for all Pharmacy transactions. When not populated, a default value of \"M\" is assumed."
* 45 0..0 XTN "RXE-45" "This field contains the telecommunication contact information for the pharmacy. Repetitions may be supplied for various device types or use codes, or multiple instances of the same type or use. This concept also exists as RXO-36 and RXD-34 to support pharmacy contact information in the context of the order, the encoded order and the dispense."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #2310