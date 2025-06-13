Logical: RXD
Parent: $Segment
Id: RXD
Title: "HL7 v2 RXD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Dispense"
* 1 1..1 NM "RXD-1" "This field starts with 1 the first time that medication/treatment is delivered/dispensed for this order. Increments by one with each additional issuance."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #334
* 2 1..1 CWE "RXD-2" "This field identifies the medical substance or treatment ordered to be given to the patient; it is equivalent to _OBR-4-Universal Service ID_. See the RXE segment for a complete definition of the _RXE-2-give code_. If the substance dispensed is a vaccine, CVX codes may be used to code this field (see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70292[_HL7 Table 0292 - Vaccines Administered_] in Chapter 2C, Code Tables)."
* 2 from http://terminology.hl7.org/ValueSet/v2-0292 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #335
* 2 ^comment = "*Note:* The contents of RXD-2-dispense/give code should be compatible with the comparable field in the RXE (RXE-2-give code). The RDS message refers ONLY to the dispensing of the drug or treatment by the pharmacy or treatment supplier."
* 3 1..1 DTM "RXD-3" "This field indicates when the pharmaceutical/treatment is dispensed from the pharmacy or treatment supplier. Use the time stamp format."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #336
* 4 1..1 NM "RXD-4" "This field indicates the amount dispensed."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #337
* 5 0..1 CWE "RXD-5" "This field indicates the units dispensed. Site-defined table. This field is required if the units are not implied by the actual dispense code. If present, it overrides units implied by the actual dispense code. This must be in simple units that reflect the actual quantity of the substance dispensed. It does not include compound units. Refer to Table 0704 - Actual Dispense Units in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0704 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #338
* 6 0..1 CWE "RXD-6" "The dosage form indicates the manner in which the medication/treatment is aggregated for dispensing, e.g., tablets, capsules, suppositories. In some cases, this information is implied by the dispense/give code in _RXD-2-dispense/give code._ Use this field when the give code and the dispense code do not specify the dosage form. Refer to Table 0705 - Actual Dosage Form in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0705 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #339
* 7 1..1 ST "RXD-7" "This field is equivalent in uniqueness to the pharmacy/treatment supplier filler order number. At some sites, this may be the pharmacy/treatment supplier (internal) sequential form. At other sites, this may be an external number."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "20"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #325
* 8 0..1 NM "RXD-8" "This field is conditional because it is required when a prescription is dispensed to an outpatient. It is not relevant to inpatient treatment orders."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #C
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #326
* 9 0..0 ST "RXD-9" "This field contains free text notes to the person dispensing the medication/treatment (may include the ordering provider's original notes, as well as any notes from the formulary or the pharmacy or treatment supplier). This may contain free text describing a custom IV, mixture, or salve for example."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "200"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #340
* 10 0..0 XCN "RXD-10" "*_This field is retained for backward compatibility only as of v 27._* The reader is referred to the PRT segment described in Chapter.7."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #B
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #341
* 10 ^comment = "This field contains the provider ID of the person dispensing the pharmaceutical. If the person referenced in this field is also referenced in PRT segment, they must contain the same information. However, if there is a difference, then PRT segment takes precedence."
* 11 0..1 ID "RXD-11" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70167[_HL7 Table 0167 - Substitution Status_] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0167 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 1
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #322
* 12 0..1 CQ "RXD-12" "This field contains the total daily dose being dispensed as expressed in terms of the actual dispense units."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #329
* 12 ^comment = "*Note:* The next two fields are equivalent to the corresponding fields of the RXE segment. They are included (optionally) in the RXD so that it may \"stand alone\" as a dispense result instruction segment."
* 13 0..1 BackboneElement "RXD-13" "*_This field is retained for backward compatibility only as of v 2.6 and withdrawn from the standard as of v 2.8_*. The reader is referred toRXD-30 and RXD-31."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #W
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1303
* 14 0..1 ID "RXD-14" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 - Yes/no indicator_] for valid values. The values have the following meaning for this field:"
* 14 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^extension[=].extension[+].url = "max"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #307
* 14 ^comment = "Y Yes - Indicates that a warning is present. The application receiving the dispense order needs to warn the person dispensing/administering the drug or treatment to pay attention to the text in _RXD-15-Special dispensing instructions_.\n\nN No - Indicates no warning is present. This is the equivalent default (null) value."
* 15 0..0 CWE "RXD-15" "This field contains pharmacy or treatment supplier-generated special instructions to the provider dispensing/administering the order. Refer to Table 0706 - Special Dispensing Instructions in Chapter 2C for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0706 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #330
* 16 0..1 NM "RXD-16" "Use when _RXD-2-Dispense/Give Code_ does not specify the strength. This is the numeric part of the strength, of a single dosage unit of the dispensed product, used in combination with _RXD-17-actual strength unit_."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1132
* 17 0..1 CWE "RXD-17" "Use when _RXD-2-Dispense/Give Code_ does not specify the strength. This is the unit of the strength, of a single dosage unit of the dispensed product, used in combination with _RXD-16-actual strength_. Refer to Table 0707 - Actual Strength Unit in Chapter 2C for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0707 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1133
* 17 ^comment = "*Note:* These units can be a \"compound quantity;\" i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 18 0..0 ST "RXD-18" "This field contains the lot number of the medical substance administered."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "20"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = false
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1129
* 18 ^comment = "*Note:* The lot number is the number printed on the label attached to the container holding the substance and on the packaging which houses the container. If the substance is a vaccine, for example, and a diluent is required, a lot number may appear on the vial containing the diluent; however, any such identifier associated with a diluent is not the identifier of interest. The substance lot number should be reported, not that of the diluent."
* 19 0..0 DTM "RXD-19" "This field contains the expiration date of the medical substance administered."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1130
* 19 ^comment = "*Note:* Vaccine expiration date does not always have a \"day\" component; therefore, such a date may be transmitted as YYYYMM^L."
* 20 0..0 CWE "RXD-20" "This field contains the manufacturer of the medical substance administered when it is a manufactured substance."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1131
* 20 ^comment = "*Note:* For vaccines, code system MVX may be used to code this field. See Section _4A.7.1_, \"_Vaccine administration data_\". This field may be used if the manufacturer of the substance is not identified by the code used in RXA-5-Administered code."
* 21 0..0 CWE "RXD-21" "This field contains the identifier of the condition or problem for which the drug/treatment was prescribed. May repeat if multiple indications are relevant. Refer to Table 0708 - Indication in Chapter 2C for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0708 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1123
* 22 0..1 NM "RXD-22" "This field contains the size of package to be dispensed. Units are transmitted in _RXD-23-dispense package size unit._"
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1220
* 23 0..1 CWE "RXD-23" "This field contains the units in which _RXE-28-dispense package size_ is denominated. The advertised number of units in the manufacturer's package, i.e., the package as it comes from the supplier. Refer to Table 0709 - Dispense Package Size Unit in Chapter 2C for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0709 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1221
* 24 0..1 ID "RXD-24" "This field contains the method by which treatment is dispensed. Refer To file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70321[_HL7 Table 0321 - Dispense Method_] in Chapter 2C, Code Tables, for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0321 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 24 ^extension[=].extension[0].url = "min"
* 24 ^extension[=].extension[=].valueInteger = 1
* 24 ^extension[=].extension[+].url = "max"
* 24 ^extension[=].extension[=].valueInteger = 2
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1222
* 25 0..0 CWE "RXD-25" "This field accommodates the identification of any codes that might be associated with the pharmaceutical substance. Common codes include: the Generic Product Identifier (GPI), Generic Code Number_Sequence Number (GCN_SEQNO), National Drug Code (NDC**)_._** *_Refer to Table 0710 - Supplementary Code in Chapter 2C for valid values._*"
* 25 from http://terminology.hl7.org/ValueSet/v2-0710 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1476
* 26 0..1 CWE "RXD-26" "This field identifies the pharmacy or other treatment dispensing service (e.g., respiratory) that received the initial request. Refer to Table 0711 - Initiating Location in Chapter 2C for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0711 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1477
* 26 ^comment = "Example: Pharmacy A (the Intake/Receiving) receives a phone call from the patient requesting a medication refill, but stipulates that the prescription will be picked up in pharmacy B. In accordance with the business process the prescription will be packaged/assembled in Pharmacy C."
* 27 0..1 CWE "RXD-27" "This field identifies the pharmacy which packaged/assembled request. Refer to Table 0712 - Packaging/Assembly Location in Chapter 2C for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0712 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1478
* 28 0..1 NM "RXD-28" "RXD-28"
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 28 ^extension[=].extension[0].url = "length"
* 28 ^extension[=].extension[=].valueInteger = "5"
* 28 ^extension[=].extension[+].url = "noTruncate"
* 28 ^extension[=].extension[=].valueInteger = false
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1686
* 28 ^comment = "Description: This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5 ML , which would be encoded in RXD-16, RXD-17, RXD-28 and RXD-29 as\n\nRXD||||||||||||||||120|mg^^ISO|||||||||||5|ml^^ISO ...<cr>"
* 29 0..1 CWE "RXD-29" "RXD-29"
* 29 from http://terminology.hl7.org/ValueSet/v2-0713 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1687
* 29 ^comment = "Description: This field indicates the volumetric unit associated with _RXD-28 Actual Drug Strength Volume_. See example in RXD-28. Refer to Table 0713 - Actual Drug Strength Volume Units in Chapter 2C for valid values."
* 30 0..1 CWE "RXD-30" "*_This field is retained for backward compatibility only as of v 27._* The information formerly communicated using this field should now be communicated using the PRT segment. The reader is referred to chapter 7 for a description of that segment. Refer to Table 0714 - Dispense to Pharmacy in Chapter 2C for valid values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0714 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #B
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1688
* 30 ^comment = "This field specifies the pharmacy that will dispense or has dispensed the prescription. In the context of an order/request (i.e., in an RXO segment) this field represents the requested dispensing pharmacy. In the context of a registered order (i.e., in an RXE segment) this field represents the intended dispensing pharmacy, the pharmacy that is expected to dispense the prescription."
* 31 0..1 XAD "RXD-31" "*_This field is retained for backward compatibility only as of v 27._* The information formerly communicated using this field should now be communicated using the PRT segment. The reader is referred to chapter 7 for a description of that segment."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #B
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1689
* 31 ^comment = "This field specifies the address of the dispensing facility or the patient's location where the dispensing will occur."
* 32 0..1 ID "RXD-32" "The Pharmacy Order Type field defines the general category of pharmacy order which may be used to determine the processing path the order will take. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70480[_HL7 Table 0480 - Pharmacy Order Types_] in Chapter 2C, Code Tables, for valid values."
* 32 from http://terminology.hl7.org/ValueSet/v2-0480 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 32 ^extension[=].extension[0].url = "min"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^extension[=].extension[+].url = "max"
* 32 ^extension[=].extension[=].valueInteger = 1
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1690
* 32 ^comment = "This field may also be used for grouping of related orders for processing and/or reports. For example, Medication Administration Records (MARs) often group large volume solutions, medications and small volume solutions differently based upon site-specific workflow.\n\nUsage Rule: This field is optional for all Pharmacy transactions. When not populated, a default value of \"M\" is assumed."
* 33 0..1 CWE "RXD-33" "This is the type of dispensing event that occurred. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70484[_User-defined Table 0484 – Dispense Type_] for suggested values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0484 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1691
* 34 0..0 XTN "RXD-34" "This field contains the telecommunication contact information for the pharmacy. Repetitions may be supplied for various device types or use codes, or multiple instances of the same type or use. This concept also exists as RXO-36 and RXE-45 to support pharmacy contact information in the context of the order, the encoded order and the dispense."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #2311
* 35 0..0 EI "RXD-35" "This field contains an identifier for the individual product instance for the dispense occurrence. This may represent a barcode, RFID or other means of automatically-readable product instance. Repetitions represent the same instance where more than one barcode, RFID or other identification is present."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #3392
* 35 ^comment = "For example, the medication preparer, e.g., a semi-automatic system, can inform the nurse that \"for the 8 a.m. administration event, the medication that has been assigned and available at the patient bedside has the barcode BBBBBBBBBBB.\" The nurse would scan the barcode to ensure that the right medication is being administered."