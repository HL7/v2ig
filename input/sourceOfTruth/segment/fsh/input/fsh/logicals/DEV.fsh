Logical: DEV
Parent: $Segment
Id: DEV
Title: "HL7 v2 DEV Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Device"
* 1 1..1 ID "DEV-1" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70287[_HL7 Table 0287 – Problem/goal action code_] for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0287 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 2
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2534
* 2 0..1 EI "DEV-2" "This field contains a unique identifier for the Device represented, either an actual device, or type of device."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2457
* 2 ^comment = "When this segment is used as an extension of a PRT segment in the message, e.g., additional device information obtained for an implantable device, DEV-2 must be equal to PRT-10 Participation Device. When PRT-22 Participation Device Type is used, DEV-3 must be equal to PRT-22.\n\nCondition: Either DEV-2 Unique Device Identifier or DEV-3 Device Type must be valued, or both are valued."
* 3 0..0 CNE "DEV-3" "This field contains the type of device used in the participation."
* 3 from http://terminology.hl7.org/ValueSet/v2-0961 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3483
* 3 ^comment = "See Externally HL7 defined 0961 in Chapter 2C for a list of suggested values. This field can repeat.\n\nWhen intended to have the additional device information for the device referenced in a PRT segment in the message, DEV-2 must be equal to PRT-10 Device. When PRT-22 Device Type is used, DEV-3 must be equal.\n\nWhen communicating a UDI Carrier, the UDI may either be uniquely identifying an instance of a device, or a type of device. This can be asserted based on the inclusion or absence of a serial number in the Product Identifier section of the UDI. When the serial number is present, PRT-10 must be used, while if it is absent, PRT-22 must be used.\n\nWhen communicating a UDI Carrier in this field, the coding system used is limited to FDA (FDAUDI), HIBCC (HIBUDI), ICCBBA (ICCUDI), and GS1 (GS1UDI) coding systems defined in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396].\n\nCondition: Either DEV-2 Unique Device Identifier or DEV-3 Device Type must be valued, or both are valued."
* 4 0..1 CNE "DEV-4" "The device status indicates the availability of the device, e.g., active, inactive. Refer to Externally HL7 Defined Table 0962 for a list of valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0962 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2501
* 5 0..1 XON "DEV-5" "This field contains the identity of the manufacturer/distributor."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1247
* 6 0..1 ST "DEV-6" "This field contains the name under which the product is marketed by this manufacturer."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1249
* 7 0..1 ST "DEV-7" "This field contains the manufacturer's model identifier for the product."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1252
* 8 0..1 ST "DEV-8" "This field contains the manufacturer's catalogue identifier for the product."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1253
* 9 0..1 EI "DEV-9" "Provides the U.S. FDA UDI _device identifier_ (DI) element. This is not the same as DEV-2, Unique Device Identifier as DEV-2 represents either the full UDI Carrier in the case of an implantable Device,"
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3476
* 9 ^comment = "This is the first component in the UDI and acts as the look up key for the Global Unique Device Identification Database (GUDIDfootnote:[See www.fda.gov/udi]), and may be used for retrieving additional attributes.\n\nWhen exchanging Device Identifiers (DI) the root shall be the OID, or standards’ appropriate corollary to the OID, assigned to DI and the extension shall be the Human Readable Form of the content. For example, for DIs the root shall be:\n\nGS1 DIs: 2.51.1.1\n\nHIBCC DIs: 1.0.15961.10.816\n\nICCBBA DIs: 2.16.840.1.113883.6.18.1.17 for Blood containers and 2.16.840.1.113883.6.18.1.34 otherwise.\n\nExample: |00643169001763^^2.51.1.1^ISO|"
* 10 0..1 ST "DEV-10" "Alphanumeric string that identifies the device’s production lot number."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3479
* 10 ^comment = "Example: |123ABC|"
* 11 0..1 ST "DEV-11" "Manufacturer’s serial number for this device. This field may be the same as DEV-2, Unique Device Identifier when the device does not involve a UDI Carrier for UDI and DEV-2 represents a serial number. The implementation guide would determine whether DEV-11 is then used or not."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3480
* 12 0..1 DTM "DEV-12" "Date and time when the device was manufacturered."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3477
* 12 ^comment = "*Note:* The user system may need to convert the date and optional hour from the UDI Human Readable Form to a timestamp style data type, augmenting the date as required to provide for a complete date and optionally the hour.\n\nExample: |20140401|"
* 13 0..1 DTM "DEV-13" "Date and time when the device is no longer approved for use."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3478
* 13 ^comment = "*Note:* The user system may need to convert the date and optional hour from the UDI Human Readable Form to a timestamp style data type, augmenting the date as required to provide for a complete date and optionally the hour.\n\nExample: |20160712|\n\nCAUTION: See the related privacy considerations discussion in PRT-10.\n\nExample: |21A11F4855|"
* 14 0..0 CWE "DEV-14" "This field a safety characteristic of a device, e.g., latex safety, MRI safety."
* 14 from http://terminology.hl7.org/ValueSet/v2-0963 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2465
* 14 ^comment = "See Externally HL7 defined 0963 in Chapter 2C for a suggested values."
* 15 0..1 EI "DEV-15" "Identifies a device related to a donation."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3481
* 15 ^comment = "When exchanging Donation Identification Numbers (DIN) the root shall be the OID assigned to DIN and the extension shall be the Human Readable Form of the content. For example, for DINs the root shall be:\n\nICCBBA DINs: 2.16.840.1.113883.6.18.2.1\n\nAn ICCBBA DIN OID is available for reference where required, but is not required when the specific data element is scoped to ICCBBA DINs.\n\nExample: | RA12345678BA123^^2.16.840.1.113883.6.18.1.34^ISO|"
* 16 0..1 ST "DEV-16" "The version number of the software that is part of the device."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2502
* 17 0..1 CNE "DEV-17" "This field contains the implantation status of the device, e.g., implanted, explanted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70795[_HL7 Table 0795 – Implanatation Status_] in Chapter 2C for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0795 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2459