Logical: RXO
Parent: $Segment
Id: RXO
Title: "HL7 v2 RXO Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Order"
* 1 0..1 CWE "RXO-1" "This field identifies the treatment product or treatment ordered to be given to the patient; it is analogous to _OBR-4-universal service ID_ in function. Examples of treatments products include medications and certain devices or supplies, e.g., inhaler spacers, blood glucose monitors, syringes, infusion sets, which might require prescription. Refer to Table 0747 - Requested Give Code in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0747 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #292
* 1 ^comment = "Often the coded entry implies dosage form and a dosage form is required in addition to the product name. When the give code does not include the dosage form, use _RXO-5-requested dosage form_. When the give code does not include the strength, use _RXO-18-requested give strength_ and the _RXO-19-requested give units. Realize that strengths do not apply to some such orders._\n\nThe RXO-1, RXO-2 and RXO-4 are mandatory unless the prescription/treatment is transmitted as free text using RXO-6; then RXO-1, RXO-2, and RXO-4 may be blank and the first subcomponent of RXO-6 must be blank.\n\nUse of the RXO-6.2 versus the RXO-1.2 for a free text order is dependent on whether or not the free text describes a product or if it is more commentary in nature.\n\nPlease refer to the request –to-dispense fields RXO-10, RXO-11, and RXO-12 for a discussion of the interrelationship with the request-to-give fields."
* 2 0..1 NM "RXO-2" "This field is the ordered amount. In a variable dose order, this is the minimum ordered amount. In a non-varying dose order, this is the exact amount of the order."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #293
* 2 ^comment = "The RXO-1, RXO-2 and RXO-4 are mandatory unless the prescription/treatment is transmitted as free text using RXO-6, then RXO-1, RXO-2, and RXO-4 may be blank and the first subcomponent of RXO-6 must be blank.\n\n*Note:* This field is not a duplication of the first component of the quantity/timing field, since in non-pharmacy/treatment orders, that component can be used to specify multiples of an ordered amount. +\n\n+\n\nAnother way to say this is that, for pharmacy/treatment orders, the quantity component of the quantity/timing field refers to what is to be given out at each service interval; thus, in terms of the RX order, that first component always defaults to 1. Hence, in the actual execution of the order, the value of 1 in the first component of the quantity/timing field always refers to one administration of the amount specified in this field (the Requested Give Amount field)."
* 3 0..1 NM "RXO-3" "In a variable dose order, this is the maximum ordered amount. In a non-varying dose order, this field is not used."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #294
* 4 0..1 CWE "RXO-4" "This field indicates the units for the give amount. Refer to Table 0748 - Requested Give Units in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0748 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #295
* 4 ^comment = "The RXO-1, RXO-2 and RXO-4 are mandatory unless the prescription is transmitted as free text using RXO-6, then RXO-1, RXO-2, and RXO-4 may be blank and the first subcomponent of RXO-6 must be blank.\n\n*Note:* These units can be a \"compound quantity\"; i.e., the units may contain the word \"per.\" For example, micrograms per KG (micg/kg) is an acceptable value, which means that the units are micrograms per KG (of body weight). See Chapter 7 for full definition of ISO+ units.\n\nA table of standard units is needed to define standard abbreviations for compound units. Until such a table is agreed on, a user-defined table is needed for each site. If the interpretation of a compound unit requires knowledge of some observation results (such as body weight or height), these results can be sent in the same order message using the optional OBX segments."
* 5 0..1 CWE "RXO-5" "This field indicates the manner in which the treatment is aggregated for dispensing, e.g., tablets, capsules suppositories. In some cases, this information is implied by the dispense/give code in _RXO-1-requested give code_ or _RXO-10-Requested dispense code_. Required when both _RXO-1-Requested give code_ and _RXO-10-Requested dispense code_ do not specify the drug/treatment form; optionally included otherwise. Refer to Table 0750 - Requested Dosage Form in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0750 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #296
* 6 0..0 CWE "RXO-6" "This field identifies the ordering provider's instructions to the pharmacy or the non-pharmacy treatment provider (e.g., respiratory therapy). If coded, a user-defined table must be used. If transmitted as a free text field, place a null in the first component and the text in the second, e.g., |^this is a free text treatment instruction|.Refer to Table 0751 - Provider's Pharmacy/Treatment Instructions in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0751 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #297
* 6 ^comment = "If the prescription is transmitted as free text using RXO-6, then RXO-1, RXO-2, and RXO-4 may be blank and the first subcomponent of RXO-6 must be blank. Otherwise, RXO-1, RXO-2 and RXO-4 are mandatory."
* 7 0..0 CWE "RXO-7" "This field identifies the ordering provider's instructions to the patient or to the provider administering the drug or treatment. If coded, a user-defined table must be used. If transmitted as free text, place a null in the first component and the text in the second, e.g., |^this is a free text administration instruction|.Refer to Table 0752 - Provider's Administration Instructions in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0752 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #298
* 8 0..1 BackboneElement "RXO-8" "RXO-8"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #W
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #299
* 8 ^comment = "Attention: The RXO-8 field was retained for backward compatibilty only as of v 2.6 and the detail was withdrawn and removed from the standard as of v 2.8."
* 9 0..1 ID "RXO-9" "Coded values indicate whether substitutions are allowed, and, if yes, what type of substitutions. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70161[_HL7 Table 0161 – Allow Substitution_] in Chapter 2C, Code Tables, for valid codes."
* 9 from http://terminology.hl7.org/ValueSet/v2-0161 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 9 ^extension[=].extension[0].url = "min"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^extension[=].extension[+].url = "max"
* 9 ^extension[=].extension[=].valueInteger = 1
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #300
* 10 0..1 CWE "RXO-10" "This field indicates what is to be/was dispensed; it is analogous to _OBR-4-universal service ID_ in function. It may be present in the order or not, depending on the application. If not present, and values are given for _RXO-11-requested dispense amount_ and _RXO-12-requested dispense units_, the _RXO-1-requested give code_ is assumed. If the requested dispense code does not include the dosage form, then _RXO-5-requested dosage form_ is required. Refer to Table 0753 - Requested Dispense Code in Chapter 2C for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0753 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #301
* 10 ^comment = "Note on request-to-dispense fields:\n\nSometimes an order will be written in which the total amount of the drug or treatment requested to be dispensed has no direct relationship with the give amounts and schedule. For example, an outpatient pharmacy/treatment order might be _take four tablets a day of <drug name, value>, Q6H (every 6 hours) -- dispense 30 tablets_. An inpatient order might be _NS/D5W (normal saline with 5% dextrose) at 1000cc/hour—dispense 3 1-liter bottles of NSD5W solution_. The request-to-dispense fields support this common style of ordering."
* 11 0..1 NM "RXO-11" "This field specifies the amount to be dispensed. See above note."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #302
* 12 0..1 CWE "RXO-12" "This field identifies the units for the dispense amount. This must be in simple units that reflect the actual quantity of the substance to be dispensed. It does not include compound units. See above note. Refer to Table 0754 - Requested Dispense Units in Chapter 2C for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0754 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #303
* 13 0..1 NM "RXO-13" "This field defines the number of times the requested dispense amount can be given to the patient, subject to local regulation. Refers to outpatient only."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "3"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #304
* 14 0..1 BackboneElement "RXO-14" "RXO-14"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #W
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #305
* 14 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7."
* 15 0..0 XCN "RXO-15" "This field is the provider ID of the pharmacist/treatment supplier verifier. Use if required by the pharmacy or treatment application or site on orders (or some subgroup of orders), in addition to _ORC-11-verified by_."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #306
* 15 ^comment = "Example:\n\nThe site requires a \"verified by\" provider (such as a nurse) and a \"verifying pharmacist/treatment supplier\" on the order. In this case the first field, _ORC-11-verified by_, is already present; but the second field, _RXO-15-pharmacist/treatment supplier's verifier ID_, is needed."
* 16 0..1 ID "RXO-16" "This field uses file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] in Chapter 2C, Code Tables. The values have the following meaning for this field:"
* 16 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^extension[=].extension[+].url = "max"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #307
* 16 ^comment = "Y Yes - Indicates that the pharmacist or non-pharmacist treatment supplier filling the order needs to pay special attention to the text in the _RXO-6-provider's pharmacy/treatment instructions_. A warning is present.\n\nN No - No warning is present. This is the equivalent default (null) value.\n\nAn example of the use of this field is given by the following case:\n\nA _smart_ Order Entry application knows of a possible drug or treatment interaction on a certain order, but the provider issuing the order wants to override the condition. In this case, the pharmacy or treatment application receiving the order will want to have a staff pharmacist or non-pharmacist treatment supplier review the interaction and contact the ordering physician."
* 17 0..1 ST "RXO-17" "This field identifies the time unit to use to calculate the rate at which the pharmaceutical is to be administered."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #C
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "20"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = false
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #308
* 17 ^comment = "Format:\n\nFormat:\n|===\n|S<integer> |= |<integer> seconds\n|M<integer> |= |<integer> minutes\n|H<integer> |= |<integer> hours\n|D<integer> |= |<integer> days\n|W<integer> |= |<integer> weeks\n|L<integer> |= |<integer> months\n|===\n\n*Note:* This is the same as the format specified for the DURATION component of the quantity/timing field, excluding the \"X\" specification.\n\nThis field is defined as conditional because it is required when the ordered substance is to be administered continuously at a prescribed rate (e.g., certain IVs). For example, if the \"give amount/units\" are 300 ml and the \"give per\" time unit is H1, the rate is 300ml/hr and the duration of this dose is 1 hour. Thus the give amount and give per time unit define the duration of the service.\n\nThis field is distinct from the \"interval\" component of the quantity/timing field, but it could be used in conjunction with it, as in _give 300ml of NS per hr for 1 hour, repeat twice a day_."
* 18 0..1 NM "RXO-18" "Required when RXO-1-requested give code does not specify the strength; optionally included otherwise. This is the numeric part of the strength, used in combination with _RXO-19-requested give strength units_."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1121
* 18 ^comment = "The need for strength and strength unit fields in addition to the amount and amount units fields included in various RX_ segments requires explanation. Physicians can write a prescription for a drug such as Ampicillin in two ways. One way would be: \"Ampicillin 250 mg capsules, 2 capsules four times a day.\" In this case the give amount would be 2, the give units would be capsules, the strength would be 250 and the strength units would milligrams.\n\nHowever, the provider could also write the pharmaceutical treatment as \"Ampicillin 500 mg four times a day.\" In this case the give amount would be 500 and the give units would be milligrams. The strength would not be reported in the RXO segment because it is not specified; the drug could be given in two 250 mg caps or one 500 mg cap. But the pharmacist would dispense a specific capsule size and would record the strength in the RXE segment as 250 or 500, depending upon which capsule size was dispensed.\n\nSome coding systems imply the strength, units, route of administration, and manufacturer of substances within a single instructional code. NDC codes, for example, usually imply not only the medical substance, but also the strength, the units, and the form, e.g., 0047-0402-30^Ampicillin 250 MG CAPS^NDC. So all of this information can also be completely specified in _RXO-1-requested give code_ and in the analogous CWE/CNE fields in other pharmacy/treatment segments. In this case, it is not necessary to use the strength and strength units fields to specify this information."
* 19 0..1 CWE "RXO-19" "Required when both _RXO-1-requested give code_ and _RXO-10-requested dispense code_ do not specify the strength; optionally included otherwise. This is the unit of the strength, used in combination with _RXO-18-requested give strength_. Refer to Table 0756 - Requested Give Strength Units in Chapter 2C for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0756 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1122
* 19 ^comment = "*Note:* These units can be a \"compound quantity;\" i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 20 0..0 CWE "RXO-20" "This field identifies the condition or problem for which the drug/treatment was prescribed. May repeat if multiple indications are relevant. Refer to Table 0758 - Indication in Chapter 2C for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0758 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1123
* 21 0..1 ST "RXO-21" "This field contains the rate at which to administer a treatment, e.g., 150 ml/hr (for an IV) or 4 liters/min for nasal oxygen."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 21 ^extension[=].extension[0].url = "length"
* 21 ^extension[=].extension[=].valueInteger = "6"
* 21 ^extension[=].extension[+].url = "noTruncate"
* 21 ^extension[=].extension[=].valueInteger = false
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1218
* 22 0..1 CWE "RXO-22" "This field contains the units in which _RXO-21-requested give rate amount_ is denominated. Refer to Table 0760 - Requested Give Rate Units in Chapter 2C for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0760 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1219
* 23 0..1 CQ "RXO-23" "This field contains the total daily dose for this particular pharmaceutical as expressed in terms of actual dispense units."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #329
* 24 0..0 CWE "RXO-24" "RXO-24"
* 24 from http://terminology.hl7.org/ValueSet/v2-0762 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1476
* 24 ^comment = "This field accommodates the identification of any codes that might be associated with the pharmaceutical substance. Common codes include: the Generic Product Identifier (GPI), Generic Code Number_Sequence Number (GCN_SEQNO), National Drug Code (NDC)*_._* *_Refer to Table 0762 - Supplementary Code in Chapter 2C for valid values._*"
* 25 0..1 NM "RXO-25" "RXO-25"
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 25 ^extension[=].extension[0].url = "length"
* 25 ^extension[=].extension[=].valueInteger = "5"
* 25 ^extension[=].extension[+].url = "noTruncate"
* 25 ^extension[=].extension[=].valueInteger = true
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1666
* 25 ^comment = "Description: This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5 ML, which would be encoded in RXO-18, RXO-19, RXO-25 and RXO-26 as:\n\nRXO||||||||||||||||||120|mg^^ISO||||||5|ml^^ISO ...<cr>"
* 26 0..1 CWE "RXO-26" "RXO-26"
* 26 from http://terminology.hl7.org/ValueSet/v2-0764 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1667
* 26 ^comment = "Description: This field indicates the volumetric unit associated with _RXO-25 Requested Drug Strength Volume_. See example in RXO-25. Refer to Table 0764 - Requested Drug Strength Volume Units in Chapter 2C for valid values."
* 27 0..1 ID "RXO-27" "The Pharmacy Order Type field defines the general category of pharmacy order which may be used to determine the processing path the order will take. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70480[_HL7 Table 0480 — Pharmacy Order Types_] in Chapter 2C, Code Tables, for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0480 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 27 ^extension[=].extension[0].url = "min"
* 27 ^extension[=].extension[=].valueInteger = 1
* 27 ^extension[=].extension[+].url = "max"
* 27 ^extension[=].extension[=].valueInteger = 1
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1668
* 27 ^comment = "This field may also be used for grouping of related orders for processing and/or reports. For example, Medication Administration Records (MARs) often group large volume solutions, medications and small volume solutions differently based upon site-specific workflow.\n\nUsage Rule: This field is optional for all Pharmacy transactions. When not populated, a default value of \"M\" is assumed."
* 28 0..1 NM "RXO-28" "This field specifies the minimum number of days that must occur between dispensing events"
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1669
* 29 0..1 EI "RXO-29" "This field contains a value that uniquely identifies the medication associated with this segment. Rather than identifying the product to be given, as in _RXO-1 Requested Give Code_, this field serves to identify the medication in association with the order represented by the segment instance. This identifier is persistent within and across message instances."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2149
* 29 ^comment = "Note: RXO-29 Medication Instance Identifier was introduced in v2.6 to support Patient Care messaging concepts and constructs. At this time, there are no documented use cases for this field in the context of a pharmacy/treatment orders as described in this chapter. This statement does not preclude the use of RXO-29 in pharmacy messages, but implementers should exercise caution in using this field outside of the Patient Care context until the pharmacy/treatment use cases are established."
* 30 0..1 EI "RXO-30" "This field contains a value that uniquely identifies this segment across time and messages. This is not intended as a \"Set ID\", but as a unique identifier allowing references not only to segments of the same message, but also to segments of other messages and indirectly to the entities described in those segments if the necessary persistence was manageable by the applications. This identifier is persistent within and across message instances."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2150
* 30 ^comment = "Note: RXO-30 Segment Instance Identifier was introduced in v 2.6 to support Patient Care messaging concepts and constructs. At this time, there are no documented use cases for this field in the context of a pharmacy/treatment orders as described in this chapter. This statement does not preclude the use of RXO-30 in pharmacy messages, but implementers should exercise caution in using this field outside of the Patient Care context until the pharmacy/treatment use cases are established."
* 31 0..1 CNE "RXO-31" "This field represents the functional state of the order represented by this segment instance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70725[_HL7 Table 0725 – Mood Codes_] in Chapter 2C, Code Tables, for valid values. This field may only be used with new trigger events and new messages from v2.6 onward. When this field is not valued in a message that qualifies, then the value is assumed to be 'EVN'."
* 31 from http://terminology.hl7.org/ValueSet/v2-0725 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #C
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2151
* 31 ^comment = "There may appear to be overlap between this field and _ORC-5 Order Status_. However, the intent of Mood Code is to support the description and documentation of historical events. In this context, Mood codes may clash with Order Status codes, a Mood code may apply for different Order Status values, or this segment may be being used outside of the order paradigm (e.g., in a patient care plan). Moods are meant to change the semantics of clinical data in a message when it is not inferable from the trigger event: when the data can represent a past medication, a future medication (e.g., in a patient care plan), or in a request (e.g., as a reason for referral). The reader is referred to Chapter 12, Patient Care, for further discussion of patient care plans and referrals.\n\nNote: RXO-31 Mood Code was introduced in v2.6 to support Patient Care messaging concepts and constructs. At this time, there are no documented use cases for this field in the context of a pharmacy/treatment orders as described in this chapter. This statement does not preclude the use of RXO-31 in pharmacy messages, but implementers should exercise caution in using this field outside of the Patient Care context until the pharmacy/treatment use cases are established. While a similar note exists for RXO-29 Medication Instance Identifier and RXO-30 Segment Instance Identifier, particular care should be taken with RXO-31 as this could modify the intent of the segment/message and create backward compatibility problems."
* 32 0..1 CWE "RXO-32" "RXO-32"
* 32 from http://terminology.hl7.org/ValueSet/v2-0765 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #B
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1681
* 32 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7. Refer to Table 0765 - Dispensing Pharmacy in Chapter 2C for valid values.\n\nense the prescription."
* 33 0..1 XAD "RXO-33" "RXO-33"
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #B
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1682
* 33 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7."
* 34 0..1 PL "RXO-34" "This field specifies the location of the patient to whom the pharmaceutical substance is to be delivered."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1683
* 35 0..1 XAD "RXO-35" "This field specifies the address, either mailing or physical, to which the prescription should be mailed or delivered."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1684
* 36 0..0 XTN "RXO-36" "This field contains the telecommunication contact information for the pharmacy. Repetitions may be supplied for various device types or use codes, or multiple instances of the same type or use. This concept also exists as RXE-45 and RXD-34 to support pharmacy contact information in the context of the order, the encoded order and the dispense."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #2309