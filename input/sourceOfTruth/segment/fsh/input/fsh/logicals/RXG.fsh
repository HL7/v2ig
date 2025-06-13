Logical: RXG
Parent: $Segment
Id: RXG
Title: "HL7 v2 RXG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Give"
* 1 1..1 NM "RXG-1" "Use if this RXG segment carries information about a single administration. This field must contain a unique number for the placer order number. This field along with the placer order number provides a unique reference to the specific scheduled give date/time transmitted by the pharmacy/treatment supplier for this order."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #342
* 1 ^comment = "If the RXG segment carries information about multiple administrations, this field's value is zero (0), since in this case a one-to-one matching with the RXA segment is ambiguous."
* 2 0..1 NM "RXG-2" "This is the dispense sub-ID to which this give message is related."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "4"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #334
* 3 0..1 BackboneElement "RXG-3" "RXG-3"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #W
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #221
* 3 ^comment = "Attention: The RXG-3 field was retained for backward compatibilty only as of v 2.5 and the detail was withdrawn and removed from the standard as of v 2.7.\n\n*Note:* The contents of fields 3-8 should be identical to the comparable fields in the RXE (RXE-2 thru 5)."
* 4 1..1 CWE "RXG-4" "This field is the identifier of the medical substance/treatment ordered to be given to the patient; it is equivalent to _OBR-4-Universal service ID_ in function. See the RXE segment for a complete definition of the _RXE-2-Give code_. If the substance given is a vaccine, CVX codes may be used to code this field (see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70292[_HL7 Table 0292 - Vaccines administered_] in Chapter 2C, Code Tables)."
* 4 from http://terminology.hl7.org/ValueSet/v2-0292 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #317
* 5 1..1 NM "RXG-5" "This field contains the ordered amount as encoded by the pharmacy/treatment supplier. In a variable dose order, this is the minimum ordered amount. In a non-varying dose order, this is the exact amount of the order."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #318
* 5 ^comment = "*Note:* This field is not a duplication of the first component of the quantity/timing field, since in non-pharmacy/treatment orders, that component can be used to specify multiples of an ordered amount.\n\nAnother way to say this is that, for pharmacy/treatment orders, the quantity component of the quantity/timing field refers to what is to be given out at each service interval; and thus, in terms of the RX order, that first component always defaults to 1. Hence, in the actual execution of the order, the value of 1 in the first component of the quantity/timing field always refers to one administration of the amount specified in this field (the requested Give Amount field)."
* 6 0..1 NM "RXG-6" "In a variable dose order, this is the maximum ordered amount. In a non-varying dose order, this field is not used."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #319
* 7 1..1 CWE "RXG-7" "This field contains the units for the give amount. Refer to Table 0735 - Give Units in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0735 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #320
* 7 ^comment = "*Note:* These units can be a \"compound quantity;\" i.e., the units may contain the word \"per.\" For example, micrograms per KG (micg/kg) is an acceptable value, which means that the units are micrograms per KG (of body weight).\n\nA table of standard units that contains compound units is needed. Until such a table is agreed on, a user-defined table is needed for each site."
* 8 0..1 CWE "RXG-8" "The dosage form indicates the manner in which the medication/treatment is aggregated for dispensing, e.g., tablets, capsules, suppositories. In some cases, this information is implied by the give code in _RXG-4-Give Code_. Use this field when the give code does not specify the dosage form. Refer to Table 0736 - Give Dosage Form in Chapter 2C for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0736 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #321
* 9 0..0 CWE "RXG-9" "This field contains notes to the person administering the medication/treatment (may include the ordering provider's original notes, as well as any notes from the formulary or the pharmacy or treatment supplier). If coded, a user-defined table must be used. If free text, place a null in the first component and the text in the second, e.g., |^this is a free text administration note|. Refer to Table 0737 - Administration Notes in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0737 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #351
* 10 0..1 ID "RXG-10" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70167[_HL7 Table 0167 - Substitution Status_] in Chapter 2C, Code Tables, for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0167 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 10 ^extension[=].extension[0].url = "min"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^extension[=].extension[+].url = "max"
* 10 ^extension[=].extension[=].valueInteger = 1
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #322
* 10 ^comment = "*Note:* The next two fields are equivalent to the corresponding fields of the RXE segment. They are included (optionally) in the RXG so that it may \"stand alone\" as a \"give\" instruction segment."
* 11 0..1 BackboneElement "RXG-11" "*_This field is retained for backward compatibility only as of v 2.6 and removed from the standard as of v 2.8._* The reader is referred to RXG-27 and RXG-28."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1303
* 12 0..1 ID "RXG-12" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/No Indicator_] for valid values. The values have the following meaning for this field:"
* 12 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #307
* 12 ^comment = "Y Yes - Indicates that a warning is present. The application receiving the dispense order needs to warn the person dispensing/administering the drug or treatment to pay attention to the text in _RXG-13-Special administration instructions_.\n\nN No - Indicates no warning is present. This is the equivalent default (null) value."
* 13 0..0 CWE "RXG-13" "This field contains pharmacy/treatment supplier-generated special instructions to the provider administering the order. Refer to Table 0738 - Special Administration Instructions in Chapter 2C for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0738 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 250
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #343
* 14 0..1 ST "RXG-14" "This field contains the time unit to use to calculate the rate at which the pharmaceutical/treatment is to be administered."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #C
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "20"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #331
* 14 ^comment = "Format:\n\nFormat:\n|===\n|S<integer> |= |<integer> seconds\n|M<integer> |= |<integer> minutes\n|H<integer> |= |<integer> hours\n|D<integer> |= |<integer> days\n|W<integer> |= |<integer> weeks\n|L<integer> |= |<integer> months\n|T<integer> |= |at the interval and amount stated until a total of <integer> \"DOSAGE\" is accumulated. Units would be assumed to be the same as in the QUANTITY field.\n|INDEF |= |do indefinitely - also the default\n|===\n\nThis is the same as the format specified for the DURATION component of the quantity/timing field, excluding the \"X\" specification.\n\nRequired when relevant (e.g., certain IVs). For example, if the \"give amount/units\" were 300 ml and the \"give per\" time unit were H1 (equivalent to one hour), the rate is 300ml/hr."
* 15 0..1 ST "RXG-15" "This field contains the amount (number) of substance/treatment to be administered."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "6"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #332
* 16 0..1 CWE "RXG-16" "This field contains the units for _RXG-15-give rate amount_. May be composite. The ratio of the _RXG-15-give rate amount_ and _RXG-16-give rate units_ fields define the actual rate of administration. Thus, if _RXG-15-give rate amount_ = 100 and _RXG-16-give rate units_ = ml/hr, the requested rate of administration is 100 ml/hr. Refer to Table 0740 - Give Rate Units in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0740 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #333
* 17 0..1 NM "RXG-17" "Use when _RXG-4-Give code_ does not specify the strength. This is the numeric part of the strength, used in combination with _RXG-18-Give strength units_."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1126
* 18 0..1 CWE "RXG-18" "Use when _RXG-4-Give Code_ does not specify the strength. This is the unit of the strength, used in combination with _RXG-17-Give Strength_. Refer to Table 0741 - Give Strength Units in Chapter 2C for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0741 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1127
* 18 ^comment = "*Note:* These units can be a \"compound quantity\"; i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 19 0..0 ST "RXG-19" "This field contains the lot number of the medical substance administered."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 19 ^extension[=].extension[0].url = "length"
* 19 ^extension[=].extension[=].valueInteger = "20"
* 19 ^extension[=].extension[+].url = "noTruncate"
* 19 ^extension[=].extension[=].valueInteger = false
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1129
* 19 ^comment = "*Note:* The lot number is the number printed on the label attached to the container holding the substance and on the packaging which houses the container. If the substance is a vaccine, for example, and a diluent is required, a lot number may appear on the vial containing the diluent; however, any such identifier associated with a diluent is not the identifier of interest. The substance lot number should be reported, not that of the diluent."
* 20 0..0 DTM "RXG-20" "This field contains the expiration date of the medical substance administered."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1130
* 20 ^comment = "*Note*: Vaccine expiration date does not always have a \"day\" component; therefore, such a date may be transmitted as YYYYMM."
* 21 0..0 CWE "RXG-21" "This field contains the manufacturer of the medical substance administered."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1131
* 21 ^comment = "*Note:* For vaccines, code system MVX may be used to code this field (see section _4A.7.1_, \"_Vaccine administration data_\"). This field may be used if the manufacturer of the substance is not identified by the code used in RXA-5-administered code."
* 22 0..0 CWE "RXG-22" "This field contains the identifier of the condition or problem for which the drug/treatment was prescribed. May repeat if multiple indications are relevant. Refer to Table 0743 - Indication in Chapter 2C for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0743 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1123
* 23 0..1 NM "RXG-23" "RXG-23"
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "5"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = true
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1692
* 23 ^comment = "Description: This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5 ML, which would be encoded in RXG-17, RXG-18, RXG-23 and RXG-24 as:\n\nRXG|||||||||||||||||120|mg^^ISO|||||5|ml^^ISO ...<cr>"
* 24 0..1 CWE "RXG-24" "RXG-24"
* 24 from http://terminology.hl7.org/ValueSet/v2-0744 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1693
* 24 ^comment = "Description: This field indicates the volumetric unit associated with _RXG-23 Give Drug Strength Volume_. See example in RXG-23. Refer to Table 0744 - Give Drug Strength Volume Units in Chapter 2C for valid values."
* 25 0..1 CWE "RXG-25" "This field contains the pharmacy system's assigned barcode number for the give occurrence. For IV orders, many pharmacy systems generate a barcode number to identify a specific bag/bottle of the order. This number can be an instance identifier; unique for the patient, drug combination, and schedule instance or it may be just a drug identifier. Refer to Table 0745 - Give Barcode Identifier in Chapter 2C for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0745 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1694
* 25 ^comment = "The composition and use of the barcode number is dependent on application negotiation. An example of this field follows: The barcode number is in the following format, 9XXXXXXX000. The number '9' is a constant, XXXXXXX is seven (7) characters for a unique identifier assigned or derived from the patient account and order ID and 000 is the zero-filled three (3) character IV bottle number.\n\nThe maximum length of the first component of this field is 40 characters to allow for the maximum existing barcode length in use today. The second component contains the description of the item being coded and the third component may define the barcode type.\n\n12345678901^IV bottle^3X9"
* 26 0..1 ID "RXG-26" "The Pharmacy Order Type field defines the general category of pharmacy order which may be used to determine the processing path the order will take. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70480[_HL7 Table 0480 Pharmacy Order Types_] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0480 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 26 ^extension[=].extension[0].url = "min"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^extension[=].extension[+].url = "max"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1695
* 26 ^comment = "This field may also be used for grouping of related orders for processing and/or reports. For example, Medication Administration Records (MARs) often group large volume solutions, medications and small volume solutions differently based upon site-specific workflow.\n\nUsage Rule: This field is optional for all Pharmacy transactions. When not populated, a default value of \"M\" is assumed."
* 27 0..1 BackboneElement "RXG-27" "RXG-27"
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #W
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1688
* 27 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7."
* 28 0..1 BackboneElement "RXG-28" "RXG-28"
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #W
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1689
* 28 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7."
* 29 0..1 PL "RXG-29" "This field specifies the location of the patient to whom the pharmaceutical substance is to be delivered."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1683
* 30 0..1 XAD "RXG-30" "This field specifies the address, either mailing or physical, to which the prescription should be mailed or delivered."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1684
* 31 0..0 EI "RXG-31" "This field contains an identifier for the individual product instance for the dispense occurrence. This may represent a barcode, RFID or other means of automatically-readable product instance. Repetitions represent the same instance where more than one barcode, RFID or other identification is present."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #3393
* 31 ^comment = "For example, the medication preparer, e.g., a semi-automated system, can inform the nurse that \"for the 8.am administration event, the medication that has been assigned and available at the patient bedside has the barcode BBBBBBBBBBB.\" The nurse would scan the barcode to ensure that the right medication is being administered.\n\nThis differs from _RXG-25 Give Barcode Identifier_ in that RXG-25 may include other workflow content or the product at various levels of granularity. RXG-31 specifically identifies the product instance."
* 32 0..1 NM "RXG-32" "This field contains the amount to be dispensed as encoded by the pharmacy or treatment supplier."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #C
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #3316
* 33 0..1 CWE "RXG-33" "This field contains the units for the dispense amount as encoded by the pharmacy or treatment supplier. This field is required if the units are not implied by the actual dispense code. This must be in simple units that reflect the actual quantity of the substance dispensed. It does not include compound units. Refer to Table 0746 - Dispense Units in Chapter 2C for valid values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0746 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #C
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #3317