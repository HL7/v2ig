Logical: SAC
Parent: $Segment
Id: SAC
Title: "HL7 v2 SAC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Specimen Container Detail"
* 1 0..1 EI "SAC-1" "This field identifies the laboratory accession (see section _Glossary_). This identifier is assigned by the external laboratory information system."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1329
* 1 ^comment = "Example: If laboratory A sends a specimen to laboratory B, then within laboratory B this field contains accession identifier of lab A."
* 2 0..1 EI "SAC-2" "This field identifies the laboratory accession (see section _13.1.3_, \"_Glossary_\"). This identifier is assigned by the information system of the laboratory performing the tests."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1330
* 2 ^comment = "An accession identifier can refer to more than one container. A Container Identifier (see below) is a Unique Identifier for that container."
* 3 0..1 EI "SAC-3" "This field identifies the container. This field is the container's unique identifier assigned by the corresponding equipment. A container may contain the primary (original) specimen or an aliquot (secondary sample) of that specimen. For primary sample this field contains Primary Container ID; for bar-coded aliquot samples this field contains Aliquot Container ID; for non-bar-coded aliquot samples (e.g., microtiter plate) this field is empty.[multiblock footnote omitted]"
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1331
* 3 ^comment = "The NCCLS standard requires a unique identifier for each container introduced into the Laboratory Automation System. The combination of the fields: Primary Container ID, Container ID, Carrier ID / Position, Tray ID / Position must identify the container uniquely within the LAS. The naturally best solution is unique machine-readable ID attached to the container (which of course is sufficient to ensure the uniqueness of the fields' combination). A bar code that symbolizes this ID should meet the proposed standard NCCLS AUTO2 (_Laboratory Automation: Bar Codes for Specimen Container Identification)._"
* 4 0..1 EI "SAC-4" "If this field is filled in, it identifies the primary container from which this specimen came. For primary samples this field is empty; for aliquot samples this field should contain the identifier of primary container."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1332
* 5 0..1 EI "SAC-5" "This field identifies the container in a particular device (e.g., one container in a carousel or rack of containers within an analyzer, analyzer specific bar code mapping, etc.)."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1333
* 6 0..1 BackboneElement "SAC-6" "SAC-6"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #W
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #249
* 6 ^comment = "*_Attention: This field was deprecated and retained for backward compatibilityonly as of v2.5 and withdrawn and removed as of v2.7._*"
* 7 0..1 DTM "SAC-7" "This field is the date/time that the container was last registered with the \"automated system,\" e.g., reading of a container bar code by a device."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1334
* 8 0..1 CWE "SAC-8" "This field identifies the status of the unique container in which the specimen resides at the time that the transaction was initiated. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70370[_HL7 Table 0370 - Container Status_] in Chapter 2C, Code Tables, for valid values. The equipment specific container status should be sent as _<alternate identifier>_ as needed."
* 8 from http://terminology.hl7.org/ValueSet/v2-0370 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1335
* 8 ^comment = "The container states are relevant for the exchange of information among devices (within the LAS). Not all of them are relevant for information transfer between the LAS and the LIS."
* 9 0..1 CWE "SAC-9" "This field identifies the type of the carrier (see section _13.1.3_, \"_Glossary_\"). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70378[_User-defined Table 0378 – Carrier Type_] in Chapter 2C, Code Tables, for suggested values. Because the geometry can be different, the carrier type should, if possible, express the number of positions in the carrier."
* 9 from http://terminology.hl7.org/ValueSet/v2-0378 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1336
* 9 ^comment = "The definition assumes hierarchical nesting using the following phrases: container is located in a carrier; carrier is located in a tray."
* 10 0..1 EI "SAC-10" "This field identifies the carrier. It is the ID (e.g., number or bar code) of the carrier where the container (e.g., tube) is located."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1337
* 10 ^comment = "Example: A carrier could be a rack with single or multiple specimen containers. A carrier is usually used for automated specimen transport. Multiple carriers can be stacked in a tray, which is then used for manual or automatic transport."
* 11 0..1 NA "SAC-11" "This field identifies the position of the container in the carrier (e.g., 1...3...). The sub-components allow, if necessary, to transfer multiple axis information, e.g., 2-dimensional carrier (X^Y)."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1338
* 12 0..1 CWE "SAC-12" "This field identifies the type of the tray (see section _13.1.3_, \"_Glossary_\"). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70379[_User-defined Table 0379 – Tray Type_] in chapter 2C for suggested values. Because the geometry can be different, the tray type should if possible express the number of positions in the tray."
* 12 from http://terminology.hl7.org/ValueSet/v2-0379 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1339
* 12 ^comment = "The definition assumes hierarchical nesting using the following phrases: container is located in a carrier, carrier is located in a tray."
* 13 0..1 EI "SAC-13" "This field identifies the tray identifier (e.g., a number of a tray or a bar code on the tray) where the container carrier is located."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1340
* 14 0..1 NA "SAC-14" "This field identifies the position of the carrier in the tray. The sub-components allow, if necessary, to transfer multiple axis information, e.g., 2-dimensional tray (X^Y)."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1341
* 15 0..0 CWE "SAC-15" "This field is the physical location that the specimen was at the time that the transaction was initiated. The location description can vary with the LAS. For example, it can be an X,Y,Z coordinate in a storage system; a refrigerator number and drawer number where the container-carrier-tray is located; or it can be the name of the institution and the laboratory which owns the container currently. The repeating of this field allows for hierarchical representation of location (lowest level first), e.g., shelf number, refrigerator storage id, lab name, institution name, etc. Refer to Table 0774 - Location in Chapter 2C for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0774 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1342
* 16 0..1 NM "SAC-16" "This field identifies the height of the container in units specified below."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 16 ^extension[=].extension[0].url = "length"
* 16 ^extension[=].extension[=].valueInteger = "10"
* 16 ^extension[=].extension[+].url = "noTruncate"
* 16 ^extension[=].extension[=].valueInteger = true
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1343
* 16 ^comment = "*Note:* If the container type is categorized (FBT (false-bottom-tube), Cup, etc.), the specific codes should be transferred in the SPM-27 field “Container Type”. If the container is characterized by dimensions and other characteristics this information should be transferred as specific values in the SAC segment (fields: SAC-16 through SAC-21, or SAC-45 to SAC-48)."
* 17 0..1 NM "SAC-17" "This field identifies the outside diameter of the container in units specified below. For non-cylindrical containers SAC-45 Container Length and SAC-46 Container Width may be used instead of SAC-17 Container Diameter."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 17 ^extension[=].extension[0].url = "length"
* 17 ^extension[=].extension[=].valueInteger = "10"
* 17 ^extension[=].extension[+].url = "noTruncate"
* 17 ^extension[=].extension[=].valueInteger = true
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1344
* 18 0..1 NM "SAC-18" "This field identifies the distance from the Point of Reference to the separator material (barrier) within the container in units specified below. This distance may be provided by the LAS to the instrument and/or specimen processing/handling device to facilitate the insertion of a sampling probe into the specimen without touching the separator. Refer to Point Of Reference definition in section _Glossary_ or in NCCLS standard AUTO5 _Laboratory Automation: Electromechanical Interfaces_."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 18 ^extension[=].extension[0].url = "length"
* 18 ^extension[=].extension[=].valueInteger = "10"
* 18 ^extension[=].extension[+].url = "noTruncate"
* 18 ^extension[=].extension[=].valueInteger = true
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1345
* 19 0..1 NM "SAC-19" "This field identifies the distance from the Point of Reference to the outside bottom of the container in units specified below. Refer to Point Of Reference definition in section _13.1.3_, \"_Glossary_,\" or in NCCLS standard AUTO5 _Laboratory Automation: Electromechanical Interfaces_."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 19 ^extension[=].extension[0].url = "length"
* 19 ^extension[=].extension[=].valueInteger = "10"
* 19 ^extension[=].extension[+].url = "noTruncate"
* 19 ^extension[=].extension[=].valueInteger = true
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1346
* 20 0..1 CWE "SAC-20" "This field is the unit identifier that is being used to describe the diameter, height and deltas of the container. If the units are ISO+ units, they should be recorded as single case abbreviations. If the units are ANS+ or L (local), the units and the source code table must be recorded, except that in this case, component delimiters should be replaced by subcomponent delimiters. The default unit is millimeters (mm), which should be assumed if no units are reported. Refer to Table 0775 - Container Height/Diameter/Delta Units in Chapter 2C for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0775 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1347
* 21 0..1 NM "SAC-21" "This field indicates the capacity of the container in the units specified below."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 21 ^extension[=].extension[0].url = "length"
* 21 ^extension[=].extension[=].valueInteger = "10"
* 21 ^extension[=].extension[+].url = "noTruncate"
* 21 ^extension[=].extension[=].valueInteger = true
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #644
* 22 0..1 NM "SAC-22" "This field identifies the current specimen volume available for use in this container in the units specified below."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 22 ^extension[=].extension[0].url = "length"
* 22 ^extension[=].extension[=].valueInteger = "10"
* 22 ^extension[=].extension[+].url = "noTruncate"
* 22 ^extension[=].extension[=].valueInteger = true
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1349
* 23 0..1 NM "SAC-23" "This field identifies the volume of the specimen initially filled in this container in the units specified below."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "10"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = true
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1350
* 24 0..1 CWE "SAC-24" "This field is the unit identifier that is being used to describe the volume of the container. If the units are ISO+ units, they should be recorded as single case abbreviations. The default unit is milliliters (ml), which should be assumed if no units are reported. Refer to Table 0777 - Volume Units in Chapter 2C for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0777 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1351
* 25 0..1 CWE "SAC-25" "This field identifies the type of the separator that is being used (e.g., gel separator in the container – not to be confused with the communication separators). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70380[_User-defined Table 0380 – SeparatorType_] in Chapter 2C, Code Tables, for suggested values. It is recommended that the first table entry be \"NO\" meaning \"No Separator.\""
* 25 from http://terminology.hl7.org/ValueSet/v2-0380 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1352
* 26 0..1 CWE "SAC-26" "This field indicates the type of cap that is to be used with this container for decapping, piercing or other mechanisms. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70381[_User-defined Table 0381 – Cap Type_] in Chapter 2C, Code Tables, for suggested values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0381 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1353
* 27 0..0 CWE "SAC-27" "This field identifies any additives introduced to the specimen before or at the time of collection. These additives may be introduced in order to preserve, maintain or enhance the particular nature or component of the specimen. It is a repetitive field. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70371[_HL7 Table 0371 – Additive/Preservative_] for valid values. 'The value set can be extended with user specific values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0371 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #647
* 27 ^comment = "When the SPM (Specimen) segment is sent together with the SAC segment the additive attribute value from the SPM segment can be included in this field of the SAC."
* 28 0..1 CWE "SAC-28" "This field identifies the specimen component, e.g., supernatant, sediment, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70372[_User-defined Table 0372 – Specimen Component_] in Chapter 2C, Code Tables, for valid values. This table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0372 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1355
* 29 0..1 SN "SAC-29" "This field identifies the factor of dilution already performed on the specimen. The equipment entity that changes the dilution is responsible for sending this information to other equipment. If the endogenous content of the test (analyte) in the diluent is required for the calculation of the test (analyte) concentration, then the test (analyte) specific values should be exchanged between the systems via Master Files or other means."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1356
* 29 ^comment = "Examples of use:\n\n|^1^:^5| - means dilution 1 to 5, i.e., 1 part sample, 4 parts diluent\n\n|^1^+| - sample is diluted, but the factor is unknown\n\n|^1^:^1| - not diluted sample\n\n|| - dilution not changed"
* 30 0..1 CWE "SAC-30" "This field identifies the specimen treatment performed during lab processing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70373[_User-defined Table 03__73 – Treatment_] in chapter 2C for valid values. This table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 30 from http://terminology.hl7.org/ValueSet/v2-0373 (required)
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1357
* 31 0..1 SN "SAC-31" "This field identifies the specimen temperature in degrees Celsius [°C] at the time of the transaction specified in the EQU segment."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1358
* 32 0..1 NM "SAC-32" "This field is the index identifier that is being used to describe the Hemolysis Index of the specimen."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 32 ^extension[=].extension[0].url = "length"
* 32 ^extension[=].extension[=].valueInteger = "10"
* 32 ^extension[=].extension[+].url = "noTruncate"
* 32 ^extension[=].extension[=].valueInteger = true
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #1359
* 33 0..1 CWE "SAC-33" "This field is the unit's identifier that is being used to describe the Hemolysis Index of the specimen. It is recommended to use g/L. (The transmission of the index values is added here instead of the original use of the OBX segments, because the frequency of the transfer of the specimen details justifies use of more efficient mechanism.) Refer to Table 0779 - Hemolysis Index Units in Chapter 2C for valid values."
* 33 from http://terminology.hl7.org/ValueSet/v2-0779 (required)
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #1360
* 33 ^comment = "If this field is null, the recommended value is assumed."
* 34 0..1 NM "SAC-34" "This field is the index identifier that is being used to describe the Lipemia Index of the specimen. It is recommended to use the optical turbidity at 600 nm (in absorbance units)."
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 34 ^extension[=].extension[0].url = "length"
* 34 ^extension[=].extension[=].valueInteger = "10"
* 34 ^extension[=].extension[+].url = "noTruncate"
* 34 ^extension[=].extension[=].valueInteger = true
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #1361
* 35 0..1 CWE "SAC-35" "This field is the unit's identifier that is being used to describe the Lipemia Index of the specimen. Refer to Table 0780 - Lipemia Index Units in Chapter 2C for valid values."
* 35 from http://terminology.hl7.org/ValueSet/v2-0780 (required)
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1362
* 35 ^comment = "If this field is null, the recommended value is assumed."
* 36 0..1 NM "SAC-36" "This field is the index identifier that is being used to describe the Icterus Index of the specimen."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 36 ^extension[=].extension[0].url = "length"
* 36 ^extension[=].extension[=].valueInteger = "10"
* 36 ^extension[=].extension[+].url = "noTruncate"
* 36 ^extension[=].extension[=].valueInteger = true
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #1363
* 37 0..1 CWE "SAC-37" "This field is the unit's identifier that is being used to describe the Icterus Index of the specimen. It is recommended to use mMol/L of bilirubin. Refer to Table 0781 - Icterus Index Units in Chapter 2C for valid values."
* 37 from http://terminology.hl7.org/ValueSet/v2-0781 (required)
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #1364
* 37 ^comment = "If this field is null, the recommended value is assumed."
* 38 0..1 NM "SAC-38" "This field is the index identifier that is being used to describe the Fibrin Index of the specimen. In the case of only differentiating between Absent and Present, we recommend using 0 and 1 respectively and send the field Fibrin Index Units null."
* 38 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 38 ^extension[=].valueCode = #O
* 38 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 38 ^extension[=].extension[0].url = "length"
* 38 ^extension[=].extension[=].valueInteger = "10"
* 38 ^extension[=].extension[+].url = "noTruncate"
* 38 ^extension[=].extension[=].valueInteger = true
* 38 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 38 ^code.code = #1365
* 39 0..1 CWE "SAC-39" "This field is the unit's identifier that is being used to describe the Fibrin Index of the specimen. Refer to Table 0782 - Fibrin Index Units in Chapter 2C for valid values."
* 39 from http://terminology.hl7.org/ValueSet/v2-0782 (required)
* 39 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 39 ^extension[=].valueCode = #O
* 39 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 39 ^code.code = #1366
* 40 0..0 CWE "SAC-40" "This field describes the specimen contaminant identifier that is associated with the specimen in this container. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70374[_User-defined Table 0374 – System Induced Contaminants_] in Chapter 2C, Code Tables, for valid values. This table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 40 from http://terminology.hl7.org/ValueSet/v2-0374 (required)
* 40 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 40 ^extension[=].valueCode = #O
* 40 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 40 ^code.code = #1367
* 41 0..0 CWE "SAC-41" "This field describes the drug interference identifier that is associated with the specimen. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70382[_User-defined Table 0382 – Drug Interference_] in Chapter 2C, Code Tables, for suggested values."
* 41 from http://terminology.hl7.org/ValueSet/v2-0382 (required)
* 41 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 41 ^extension[=].valueCode = #O
* 41 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 41 ^code.code = #1368
* 42 0..1 CWE "SAC-42" "This field describes the artificial blood identifier that is associated with the specimen. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70375[_User-defined Table 0375 – Artificial Blood_] in Chapter 2C, Code Tables, for valid values. This table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 42 from http://terminology.hl7.org/ValueSet/v2-0375 (required)
* 42 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 42 ^extension[=].valueCode = #O
* 42 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 42 ^code.code = #1369
* 43 0..0 CWE "SAC-43" "This field describes any special handling considerations that are associated with the specimen in the specific container (e.g., centrifugation). This describes how the specimen needs to be stored during collection, in transit, and upon receipt. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[_User-defined Table 0376 – Special Handling Code_] in Chapter 2C, Code Tables, for valid values. 'The value set can be extended with user specific values."
* 43 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 43 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 43 ^extension[=].valueCode = #O
* 43 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 43 ^code.code = #1370
* 44 0..0 CWE "SAC-44" "This field describes other environmental factors that are associated with the specimen in a specific container, e.g., atmospheric exposure. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70377[_User-defined Table 0377 – Other Environmental Factors_] in Chapter 2C, Code Tables, for valid values. This table's values are taken from _NCCLS AUTO4_. The value set can be extended with user specific values."
* 44 from http://terminology.hl7.org/ValueSet/v2-0377 (required)
* 44 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 44 ^extension[=].valueCode = #O
* 44 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 44 ^code.code = #1371
* 45 0..1 CQ "SAC-45" "This field describes the longest horizontal measurement of the container, for non-cylindrical containers. For cylindrical containers SAC-17 Container Diameter may be used instead of SAC-45 Container Length and SAC-46 Container Width."
* 45 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 45 ^extension[=].valueCode = #O
* 45 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 45 ^code.code = #2496
* 46 0..1 CQ "SAC-46" "This field desrcibes the distance from side to side, measuring across the object at right angles to the length, for non-cylindrical containers. For cylindrical containers SAC-17 Container Diameter may be used instead of SAC-45 Container Length and SAC-46 Container Width."
* 46 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 46 ^extension[=].valueCode = #O
* 46 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 46 ^code.code = #2497
* 47 0..1 CWE "SAC-47" "This field is the coded representation of the format or type of the container (e.g. tube/vial, jar, bag, block, slide, etc.). Refer to User-Defined Table 0967 for suggested values."
* 47 from http://terminology.hl7.org/ValueSet/v2-0967 (required)
* 47 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 47 ^extension[=].valueCode = #O
* 47 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 47 ^code.code = #2498
* 48 0..1 CWE "SAC-48" "This field is the coded representation of the material composition (i.e. physical substance) of the container and may be considered to modify for further describe SAC-47 (Container Form). It may also indicate a virtual container in the cases of digitized specimens (e.g. scans obtained by whole slide imaging techniques, etc.). Refer to User-Defined Table 0968 for suggested values."
* 48 from http://terminology.hl7.org/ValueSet/v2-0968 (required)
* 48 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 48 ^extension[=].valueCode = #O
* 48 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 48 ^code.code = #2499
* 49 0..1 CWE "SAC-49" "This field is a coded representation of the way the container type is commonly referenced in an organization, in order to aid in ensuring the appropriate container is used. Examples include “Red Top” (for tubes/vials), “Wet Mount” (for slides), etc. Frequently these values will be locally defined and meaning may vary by supplier. Refer to User-Defined Table 0969 for suggested values."
* 49 from http://terminology.hl7.org/ValueSet/v2-0969 (required)
* 49 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 49 ^extension[=].valueCode = #O
* 49 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 49 ^code.code = #2500
* 49 ^comment = "In many cases this is a shorthand way to express a combination of other container attributes, for example the combination of SAC-47 (Container Form) of “Tube/vial” + SAC-48 (Container Material) of “Glass” + SAC-27 (Additive) of “EDTA” may be referenced commonly in an organization as a “Lavender Top”."