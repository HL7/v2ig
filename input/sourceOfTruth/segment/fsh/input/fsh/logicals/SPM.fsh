Logical: SPM
Parent: $Segment
Id: SPM
Title: "HL7 v2 SPM Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Specimen"
* 1 0..1 SI "SPM-1" "This field contains the sequence number. This field is used to identify SPM segment instances in message structures where the SPM segment repeats."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1754
* 2 0..1 EIP "SPM-2" "This field contains a unique identifier for the specimen as referenced by the Placer application, the Filler application, or both."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1755
* 2 ^comment = "This field is not required, as there are use cases in which a unique specimen identifier may not exist. In the first scenario, a placer application may initiate an observation request against an existing specimen without uniquely identifying the specimen. Additionally, in the case of the TCU_U10 message structure, used in Automated equipment test code settings messages, the SPM segment is used to define required characteristics of the specimen. As such, TCU_U10 uses SPM to define a virtual specimen, and a specific specimen identifier would not exist. Filler applications would be expected to assign a Specimen Identifier and populate this field accordingly."
* 3 0..0 EIP "SPM-3" "This field contains the identifiers for the specimen or specimens that contributed to the specimen that is described by the segment instance."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1756
* 3 ^comment = "If this field repeats, then _SPM-11-Specimen Role_ should be valued with \"L\" (pooled). The repetitions of this field then carry the specimen IDs of the parent specimens contributing to the pool."
* 4 1..1 CWE "SPM-4" "This field describes the precise nature of the entity that will be the source material for the observation."
* 4 from http://terminology.hl7.org/ValueSet/v2-0487 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1900
* 4 ^comment = "Any physical entity that may have observations made about it may qualify as a specimen. The entry in this attribute describes the specific entity as precisely as possible, whether that is a complex organism (e.g., an ostrich) or a specific cellular mass (e.g., a specific muscle biopsy).\n\nA nationally recognized coding system is to be used for this field. Valid coding sources for this field include:\n\n• file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70487[_HL7 Table 0487 – Specimen Type_] (replaces file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70070[_HL7 Table 0070 – Specimen source codes_])\n\n• SNOMED, etc.\n\n• Veterinary medicine may choose the tables supported for the components of this field as decided by their industry."
* 5 0..0 CWE "SPM-5" "This field contains modifying or qualifying description(s) about the specimen type"
* 5 from http://terminology.hl7.org/ValueSet/v2-0541 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1757
* 5 ^comment = "The use of this attribute is to modify, qualify or further specify, the entity described by _SPM-4 -Specimen Type_. This is particularly useful when the code set used in _SPM-4-Specimen Type_ does not provide the precision required to fully describe the specimen. For example, if the specimen was precisely described as 'capillary venous blood' but the code set employed only provided 'venous blood,' this attribute could be employed to add the modifier 'capillary.'\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70541[_User-Defined Table 0541 Specimen Type Modifier_] for suggested values."
* 6 0..0 CWE "SPM-6" "This field identifies any additives introduced to the specimen before or at the time of collection. These additives may be introduced in order to preserve, maintain or enhance the particular nature or component of the specimen. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70371[_HL7 Table 0371 – Additive/Preservative_] for valid values. When multiple additives are introduced and valid individual additive codes exist but a valid value for the combination does not exist, repeating the field with individual values is most appropriate."
* 6 from http://terminology.hl7.org/ValueSet/v2-0371 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1758
* 7 0..1 CWE "SPM-7" "Describes the procedure or process by which the specimen was collected."
* 7 from http://terminology.hl7.org/ValueSet/v2-0488 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1759
* 7 ^comment = "Any nationally recognized coding system might be used for this field including SNOMED; alternatively the file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70488[_HL7 Table 0488 – Specimen Collection Method_] may be used. Veterinary medicine may choose the tables supported for the components of this field as decided by their industry."
* 8 0..1 CWE "SPM-8" "specifies the source from which the specimen was obtained. For example, in the case where a liver biopsy is obtained via a percutaneous needle, the source would be 'liver'. Refer to Table 0784 - Specimen Source Site in Chapter 2C for valid values.Any nationally recognized coding system might be used for this field including SNOMED; alternatively the file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70163[_HL7 Table 0163 – Body Site_] may be used. Veterinary medicine may choose the tables supported for the components of this field as decided by their industry."
* 8 from http://terminology.hl7.org/ValueSet/v2-0784 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1901
* 9 0..0 CWE "SPM-9" "This field contains modifying or qualifying description(s) about the specimen source site"
* 9 from http://terminology.hl7.org/ValueSet/v2-0542 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1760
* 9 ^comment = "The use of this attribute is to modify, qualify or further specify, the entity described by _SPM-8 – Specimen Source Site_. This is particularly useful when the code set used in _SPM-8_ does not provide the precision required to fully describe the site from which the specimen originated. For example, if the specimen source site was precisely described as 'left radial vein' but the code set employed only provided 'radial vein,' this attribute could be employed to add the modifier 'left.'\n\nVeterinary medicine may choose the tables supported for the components of this field as decided by their industry.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70542[_User-Defined Table 0542 – Specimen Source Type Modifier_] for suggested values."
* 10 0..1 CWE "SPM-10" "This field differs from _SPM-8-Specimen Source Site_ in those cases where the source site must be approached via a particular site (e.g., anatomic location). For example, in the case where a liver biopsy is obtained via a percutaneous needle, the collection site would be the point of entry of the needle. For venous blood collected from the left radial vein, the collection site could be \"antecubital fossa\"."
* 10 from http://terminology.hl7.org/ValueSet/v2-0543 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1761
* 10 ^comment = "Veterinary medicine may choose the tables supported for the components of this field as decided by their industry.\n\nRefer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70543[_User-Defined Table 0543 – Specimen Collection Site_] for suggested values."
* 11 0..0 CWE "SPM-11" "SPM-11"
* 11 from http://terminology.hl7.org/ValueSet/v2-0369 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1762
* 11 ^comment = "This field indicates the role of the sample. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70369[_User-defined Table 0369 – Specimen role_] for suggested values. Each of these values is normally identifiable by the systems and its components and can influence processing and data management related to the specimen.\n\nIf this field is not populated, then the specimen described has no special, or specific, role other than serving as the focus of the observation. Such specimens include patient, environmental and other specimens that are intended for analysis.\n\nA grouped specimen consists of identical specimen types from multiple individuals that do not have individual identifiers and upon which the same services will be performed. If the specimen role value is \"G\" then the Grouped Specimen Count (_SPM-13_) must be valued with the total number of specimens contained in the group.\n\nIf the specimen role is \"L\", the repetitions of Parent Specimen ID (SPM-4) represent the individual parent specimens that contribute to the pooled specimen."
* 12 0..1 CQ "SPM-12" "This field specifies the volume or mass of the collected specimen. For laboratory tests, the collection volume is the volume of a specimen. Specifically, units should be expressed in the ISO Standard unit abbreviations (ISO‑2955, 1977). This is a results-only field except when the placer or a party has already drawn the specimen. Use of UCUM is strongly recommended as one of the delivered units (could be in addition to the local units). (See Chapter 7 Section 7.4.2.6 for a full discussion regarding units.)"
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1902
* 13 0..1 NM "SPM-13" "This field refers to the number of individual specimens of a particular type represented by this instance of a specimen. The use of this field is restricted to specimens upon which all specimen related attributes are identical. This field would only be valued if SPM-11 Specimen Role has the value \"G\" or “L”."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #C
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "6"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1763
* 14 0..0 ST "SPM-14" "This is a text field that allows additional information *specifically about the specimen* to be sent in the message"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1764
* 15 0..0 CWE "SPM-15" "This describes how the specimen and/or container need to be handled from the time of collection through the initiation of testing. As this field is not required, no assumptions can be made as to meaning when this field is not populated."
* 15 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1908
* 15 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[_User-defined Table 0376 – Special Handling Code_] for suggested values."
* 16 0..0 CWE "SPM-16" "This field contains any known or suspected specimen hazards, e.g., exceptionally infectious agent or blood from a hepatitis patient. Either code and/or text may be absent. However, the code is always placed in the first component position and any free text in the second component. Thus, a component delimiter must precede free text without a code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70489[_User-defined Table 0489 – Risk Codes_] for suggested entries"
* 16 from http://terminology.hl7.org/ValueSet/v2-0489 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1903
* 17 0..1 DR "SPM-17" "The date and time when the specimen was acquired from the source. The use of the Date Range data type allows for description of specimens collected over a period of time, for example, 24-hour urine collection. For specimens collected at a point in time, only the first component (start date/time) will be populated."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1765
* 18 0..1 DTM "SPM-18" "The specimen received date/time is the time that the specimen is received at the diagnostic service facility. The actual time that is recorded is based on how specimen receipt is managed and may correspond to the time the sample is logged in. This is fundamentally different from _SPM-17 Specimen Collection date/time_."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #248
* 19 0..1 DTM "SPM-19" "This field is the date and time the specimen can no longer be used for the purpose implied by the order. For example, in the Blood Banking environment the specimen can no longer be used for pre-transfusion compatibility testing. The specimen segment will include a _SPM-21-Specimen Reject Reason_ of 'EX' indicating 'Expired' for message instances created after this date and time."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1904
* 20 0..1 ID "SPM-20" "This describes whether the specimen, as it exists, is currently available to use in an analysis. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator_] for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 1
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1766
* 21 0..0 CWE "SPM-21" "This describes one or more reasons the specimen is rejected for the specified observation/result/analysis. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70490[_HL7 Table 0490 – Specimen Reject Reason_] for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0490 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1767
* 22 0..1 CWE "SPM-22" "The degree or grade of excellence of the specimen at receipt. The filler populates this attribute. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70491[_User-defined Table 0491 – Specimen Quality_] for suggested entries."
* 22 from http://terminology.hl7.org/ValueSet/v2-0491 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1768
* 23 0..1 CWE "SPM-23" "The suitability of the specimen for the particular planned use as determined by the filler. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70492[_User-defined Table 0492 – Specimen Appropriateness_] for suggested entries."
* 23 from http://terminology.hl7.org/ValueSet/v2-0492 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1769
* 24 0..0 CWE "SPM-24" "A mode or state of being that describes the nature of the specimen. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70493[_User-defined Table 0493 – Specimen Condition_] for suggested entries."
* 24 from http://terminology.hl7.org/ValueSet/v2-0493 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1770
* 25 0..1 CQ "SPM-25" "This attributes contains the amount of specimen that currently exists or is available for use in further testing."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1771
* 26 0..1 NM "SPM-26" "This field identifies the number of containers for a given sample. For sample receipt verification purposes; may be different from the total number of samples that accompany the order."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 26 ^extension[=].extension[0].url = "length"
* 26 ^extension[=].extension[=].valueInteger = "4"
* 26 ^extension[=].extension[+].url = "noTruncate"
* 26 ^extension[=].extension[=].valueInteger = false
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1772
* 27 0..1 CWE "SPM-27" "The container in or on which a specimen is transported. Refer to Table 0785 - Container Type in Chapter 2C for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0785 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1773
* 27 ^comment = "*Note:* If the container type is categorized (e.g., FBT (false-bottom-tube), Cup, …), the specific codes should be transferred in the SPM-27 field \"Container Type\". If the container is characterized by dimensions and other characteristics this information should be transferred as specific values in the SAC segment (fields: SAC-16 … SAC-21)."
* 28 0..1 CWE "SPM-28" "In chain of custody cases where specimens are moved from lab to lab, the status of the container that the specimen is shipped in must be recorded at each receipt. If the container is compromised in any way (seal broken, container cracked or leaking, etc) then this needs to be recorded for legal reasons."
* 28 from http://terminology.hl7.org/ValueSet/v2-0544 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1774
* 28 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70544[_HL7 Table 0544 – Container Condition_] for suggested values."
* 29 0..1 CWE "SPM-29" "For child specimens, this field identifies the relationship between this specimen and the parent specimen. If this field is populated, then _SPM-3-Specimen Parent ID_ must be populated. This field differs from _SPM-15-Specimen Role_ in that this field refers to the role of this specimen relative to a parent role rather than the role of this specimen to the ordered service."
* 29 from http://terminology.hl7.org/ValueSet/v2-0494 (required)
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1775
* 29 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70494[_HL7 Table 0494 – Specimen Child Role_] for valid values."
* 30 0..0 CX "SPM-30" "This field contains accession identifier(s) associated with the specimen. In many cases, applications involved in the collection, transportation or testing of the specimen will assign their own accession identifiers. This field allows communication of these accession identifiers."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2314
* 30 ^comment = "An accession id may or may not, depending up laboratory practice, identify a single specimen. Best practice is to use accession identifiers that are globally unique (typically ID Number + Assigning Facility components). However, an accession id may or may not, depending up laboratory practice, identify a single specimen. In addition, accession ids are commonly re-used over time, so the accession id may not uniquely identify a specimen."
* 31 0..0 CX "SPM-31" "This field contains other identifier(s) for the specimen as referenced in an application. Normally this field is used to carry additional identifiers for the specimen in addition to those identified in _SPM-2, Specimen ID_. In may cases other applications involved in the collection, transportation or testing of the specimen will assign additional specimen identifiers. This field allows communication of those other specimen identifiers."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2315
* 32 0..1 EI "SPM-32" "The shipment identifier is the identifier assigned by the shipment transportation provider that uniquely identifies this shipment from all other shipments by the same provider. The addressee for the shipment should be able to use this identifier to match a physical shipment with the electronic manifest for the shipment."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #2316
* 33 0..1 DTM "SPM-33" "The Culture Start date/time is the time that the specimen is plated, or inoculated to selective and differential growth mediums that are used in organism identification in microbiology. This is the start of differential diagnosis and is a clinically relevant date and time. The actual time that is recorded is based on when specimen is directly inoculated onto growth media and may correspond to the time the sample is logged in or received."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #3485
* 34 0..1 DTM "SPM-34" "The Culture Final date/time is the time in which the order filler is communicating to the clinician that all work on a cultured specimen is completed and no further updates will be received. All work, including determination of growth, Organism Identification, and sensitivity testing are completed. The clinician should expect no further updates on this cultured specimen."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #3486
* 35 0..1 ID "SPM-35" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 35 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 35 ^extension[=].extension[0].url = "min"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^extension[=].extension[+].url = "max"
* 35 ^extension[=].extension[=].valueInteger = 1
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #816
* 35 ^comment = "The action code can only be used when an SPM-2 or SPM-31 is valued in accordance with the guidance in Chapter 2, Section 2.10.4.2."