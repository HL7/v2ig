Logical: OM4
Parent: $Segment
Id: OM4
Title: "HL7 v2 OM4 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Observations That Require Specimens"
* 1 0..1 NM "OM4-1" "The OM4-1 contains a numeric value that indicates a unique set of OM1, OM2, OM3, and OM4 components; each OMn-1 in a set will have the same value as illustrated in the example below. Because the OM4 segment can repeat, but needs to have a unique number for use with OM4-17, the sequence number must be appended with a sequence number as shown in the second example below."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 1 ^comment = "*OM4-1 Sequence Number – Test/Observation Master File Example:*\n\nMSH|...<cr>\n\n// start MFE Test Begin group\n\nMFE|A|...<cr>\n\nOM1|1|...<cr>\n\nOM2|1|...<cr>\n\nOM3|1|...<cr>\n\nOM4|1|...<cr>\n\n// end MFE Test Begin group\n\n// start MFE_Test_Begin group\n\nMFE|A|...<cr>\n\nOM1|2|...<cr>\n\nOM2|2|...<cr>\n\nOM3|2|...<cr>\n\nOM4|2.1|...<cr>\n\nOM4|2.2|...<cr>\n\n//end MFE_Test_Begin group"
* 2 0..1 ID "OM4-2" "This field contains the codes that identify the parents and children for diagnostic studies—especially in microbiology—where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture). The process also produces new \"specimens\" (e.g., pure culture of staphylococcus, and E. coli), and these are studied by a second order process (bacterial sensitivities). The parents (e.g., blood culture) and children (e.g., penicillin MIC) are identified in such cases. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70170[HL7 Table 0170 - Derived Specimen] in Chapter 2C, Code Tables, for valid values:"
* 2 from http://terminology.hl7.org/ValueSet/v2-0170 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #642
* 3 0..0 TX "OM4-3" "This field contains the physical appearance, including color of tube tops, shape, and material composition (e.g., red-top glass tube). Note that the color is not necessarily a unique identifier of the additive and/or use of the tube. This is especially true for black and some blue tube tops, as can be seen above. Color is included here for user convenience. This field repeats to accommodate all the possible specimen that will be allowed. If a container is preferred, only that container should be messaged here with the alternate containers messaged in a repeat OM4 segment."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 60
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "60"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #643
* 4 0..0 NM "OM4-4" "This field indicates the capacity of the container. This field repeats to accommodate all the possible specimen that will be allowed. If a container is preferred, only that container should be messaged here with the alternate containers messaged in a repeat OM4 segment"
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #644
* 5 0..0 CWE "OM4-5" "This field contains the units of measure of the container volume. If the units are ISO+ units, they should be recorded as single case abbreviations. If the units are ANS+ or L (local), the units and the source code table must be recorded, except that in this case, component delimiters should be replaced by subcomponent delimiters. For example, 1 indicates liters, whereas pt&&ANS+ indicates pints (ANSI units). The default unit is milliliters (ml), which should be assumed if no units are reported. This field repeats to accommodate all the possible specimen that will be allowed. If a container is preferred, only that container units should be messaged here with the alternate containers messaged in a repeat OM4 segment. Refer to Table 0658 - Container Units in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0658 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #645
* 6 0..1 CWE "OM4-6" "Describes the specimen from an appropriate controlled vocabulary. If multiple kinds of specimen are associated with this observation (as in the case for a creatinine clearance), multiple segments may be included, one for each specimen type. Refer to Table 0660 - Specimen in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0660 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #646
* 7 0..1 CWE "OM4-7" "This field contains the codes that should be those provided by NCCLSfootnote:[NCCLS Document H1-A3: Evacuated tubes for blood specimen collection -- Third Edition, Volume 11, Number 9, Approved standard. July 1991.]. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70371[HL7 Table 0371 - Additive/Preservative] in Chapter 2C, Code Tables, for valid values. The table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0371 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #647
* 7 ^comment = "This table was not specified in previous versions and thus sites may choose to use other site-specific tables."
* 8 0..1 TX "OM4-8" "This field contains the special processing that should be applied to the container, e.g., add acidifying tablets before sending."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #648
* 9 0..1 TX "OM4-9" "This field contains the special handling requirements here (e.g., ice specimen, deliver within two hours of obtaining)."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #649
* 10 0..1 CQ "OM4-10" "This field contains the normal specimen volume required by the lab. This is the amount used by the normal methods and provides enough specimens to repeat the procedure at least once if needed. The default unit is milliliters (ml)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #650
* 11 0..1 CQ "OM4-11" "This field contains the amount of specimen needed by the most specimen sparing method (e.g., using micro techniques). The minimum amount allows for only one determination. The default unit is milliliters (ml)."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #651
* 12 0..1 TX "OM4-12" "This field contains the other requirements for specimen delivery and special handling (e.g., delivery within one hour, iced)."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #652
* 13 0..0 ID "OM4-13" "This field contains the allowed priorities for obtaining the specimen. Note that they may be different from the processing priorities given in _OM1-25 - Processing Priority_. When a test is requested, the specimen priority given in _TQ1-9 - Priority_ should be one of the priorities listed here. Multiple priorities are separated by repeat delimiters. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70027[HL7 Table 0027 - Priority] in Chapter 2C, Code Tables, for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0027 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #653
* 14 0..1 CQ "OM4-14" "This field contains the usual time that a specimen for this observation is retained after the observation is completed, for the purpose of additional testing. The first component is the duration, and the second component is an ISO time unit."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #654
* 15 0..0 CWE "OM4-15" "This describes how the specimen and/or container need to be handled from the time of collection through the initiation of testing. As this field is not required, no assumptions can be made as to meaning when this field is not populated."
* 15 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1908
* 15 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[User-defined Table 0376 – Special Handling Code] in Chapter 2C, Code Tables, for suggested values."
* 16 0..1 ID "OM4-16" "This field indicates whether the Specimen/Attribute is Preferred or alternate for collection of the specimen. There can only be one occurrence of a Preferred or Alternate Specimen/Attribute for the code referenced in _OM4-6 Specimen_. For example, if two OM4 segments are received for specimen type of Serum, only one can be marked as Preferred. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70920[HL7 Table 0920 – Preferred Specimen/Attribute Status] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0920 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3311
* 17 0..1 NM "OM4-17" "This field contains the value of the sequence number of the Preferred Specimen that these specimens are the alternative for. Note: For the preferred specimen (i.e., OM4-16 = \"P\"), this field is not populated. This field is used by the Alternate Specimen (i.e., OM4-16 = \"A\") to point to the preferred specimen that it is to replace or be used as an alternative."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3312
* 17 ^comment = "Example:\n\nPreferred specimen\n\nOM4|1||Tiger Top|… to field16|P||\n\nOM4|2||Plastic Screw Top|0.5|mL|Urine|without 6N HCI| … to field16|P||\n\n_Alternate specimen_\n\nOM4|3||Red Top|… to field16|A|1|"
* 18 0..0 CWE "OM4-18" "The species of living organism. This may include the common or scientific name, based on the coding system(s) used. SNOMED is the recommended coding system. If this field is not valued, a human is assumed. Refer to Table 0661 - Taxonomic Classification Code in Chapter 2C for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0661 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1539
* 18 ^comment = "For example:\n\n...|L-80700^Canine, NOS^SNM3|...\n\n...|L-80100^Bovine^SNM3|...\n\n...|L-80A00^Feline^SNM3|....\n\nThis field is a list of species or other taxonomic classification(s) to which the indicated specimen type may appropriately be applied for the indicated observation or test. If this field is omitted the default meaning is that the test or observation is applicable to humans. In a veterinary context, if the test is applicable to any species, an appropriate code such as \"Kingdom Animalia (organism)\" should be used to avoid confusion with the meaning of human only."