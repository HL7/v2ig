Logical: PRT
Parent: $Segment
Id: PRT
Title: "HL7 v2 PRT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Participation Information"
* 1 0..1 EI "PRT-1" "This field contains a unique identifier of the specific participation record."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2379
* 1 ^comment = "In the case of waypoints tracked for a shipment, it identifies the waypoint.\n\nCondition: The identifier is required when known, but there are times we may only know a name but do not have an identifier."
* 2 1..1 ID "PRT-2" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70287[_HL7 Table 0287 – Problem/goal action code_] for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0287 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 2
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 2
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2534
* 3 0..1 CWE "PRT-3" "This field indicates the reason why the person, organization, location, or device is assuming (or changing) the role (e.g., shift change, new primary nurse, etc.)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2380
* 4 1..1 CWE "PRT-4" "This field indicates the functional involvement with the activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70912[_HL7 Table 0912 – Participation_] for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0912 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2381
* 5 0..0 XCN "PRT-5" "This field contains the identity of the person who is represented in the participation that is being transmitted."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2382
* 5 ^comment = "If this attribute repeats, all instances must represent the same person.\n\nCondition: At least one of PRT-5 Person, PRT-8 Organization, PRT-9 Location, or PRT-10 Device or PRT-22 Device Type fields must be valued."
* 6 0..1 CWE "PRT-6" "This field contains a code identifying the provider type for the participating person. This attribute correlates to the following master file attribute: _STF-4 Staff Type_. Coded values from the correlated master file table are used; the user defined master file table is used as the coding system for this attribute. For example, if you are using values from _STF-2 Staff Type_, the coding system would be HL70182 which is the table number for the user defined Staff Type table. This field is included in this segment to support international requirements. When ROL is used in an encounter message, it is not intended as a master file update."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2383
* 6 ^comment = "Condition: This field may only be valued if _PRT-5 Person_ is valued."
* 7 0..1 CWE "PRT-7" "This field identifies the environment in which the participant acts in the role specified in _PRT-3 Action Reason_. In the case of a person, the environment is not the specialty for the provider. The specialty information for the provider is defined in the PRA segment."
* 7 from http://terminology.hl7.org/ValueSet/v2-0406 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2384
* 7 ^comment = "This attribute is included in the PRT segment to allow communication of this data when the participant information may not have been communicated previously in a master file or to provide better context. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70406[_User-defined table 0406 - Organization unit type_]. This field is included in this segment to support international requirements, and is not intended as a master file update.\n\nCondition: This field may only be valued if PRT-5 Person is valued."
* 8 0..0 XON "PRT-8" "The organization that is involved in the participation. If _PRT-5 Person_ is valued, it reflects the affiliation of the individual participating as identified in _PRT-4 Role of Participation_. Otherwise the organization is directly participating as identified in _PRT-4 Role of Participation_."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #C
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2385
* 8 ^comment = "If this attribute repeats, all instances must represent the same organization.\n\nCondition: At least one of the PRT-5 Person, PRT-8 Organization, PRT-9 Location, or PRT-10 Device or PRT-22 Device Type fields must be valued."
* 9 0..0 PL "PRT-9" "This field specifies the physical location (e.g., nurse station, ancillary service location, clinic, or floor) that is participating. If either _PRT-5 Person_ or _PRT-8 Organization_ is valued, it reflects the location of the individual or organization participating as identified in _PRT-4 Role of Participation_. Otherwise the location is directly participating as identified in _PRT-4 Role of Participation_."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #C
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2386
* 9 ^comment = "If this attribute repeats, all instances must represent the same organization.\n\nCondition: At least one of the PRT-5 Person, PRT-8 Organization, PRT-9 Location, or PRT-10 Device or PRT-22 Device Type fields must be valued."
* 10 0..0 EI "PRT-10" "Identifier for the device participating. This may reflect an unstructured or a structured identifier such as FDA UDI, RFID, IEEE EUI-64 identifiers, or bar codes."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2348
* 10 ^comment = "Example: The device used to register the shipment at the waypoint.\n\nIf this attribute repeats, all instances must represent the same device.\n\nCondition: At least one of the PRT-5 Person, PRT-8 Organization, PRT-9 Location, or PRT-10 Device or PRT-22 Device Type fields must be valued.\n\nIf this field contains an FDA UDI, it shall contain the entire Human Readable Form of the UDI. For example, a GS1-based UDI would be represented as follows:\n\n|(01)00643169001763(17)160712(21)21A11F4855^^2.16.840.1.113883.3.3719^ISO|\n\nA HIBCC-based example would be represented as follows:\n\n|+H123PARTNO1234567890120/$$420020216LOT123456789012345/SXYZ4567890123 45678/16D20130202C^^2.16.840.1.113883.3.3719^ISO\n\nAn ICCBBA-based example would be represented as follows:\n\n|=/A9999XYZ100T0944=,000025=A99971312345600=>014032=}013032\\T\\,1000000000000XYZ123^^2.16.840.1.113883.3.3719^ISO|\n\nOr for ICCBBA (for blood bags only) an example would be represented as follows:\n\n|=)1TE123456A\\T\\)RZ12345678^^2.16.840.1.113883.3.3719^ISO|\n\nThe identifier root shall be the OID assigned to UDI. For example, for FDA UDIs the root shall be 2.16.840.1.113883.3.3719, and the extension shall be the Human Readable Form appropriate for the style of content. When captured as a simple string, the string shall be the Human Readable Form appropriate for the style of content. The content style can be determined from the leading characters of the content:\n\nUDIs beginning with:\n\n‘(‘ are in the GS1 Human Readable style;\n\n‘0-9’ are a GS1 DI (containing only the DI value, no PI or GS1 AI);\n\n‘+‘ are in the HIBCC Human Readable style;\n\n‘=‘ or ‘&’ are in the ICCBBA Human Readable style.\n\nNote: If “&” is used in the UDI while one of the delimiters in MSH.2 includes “&” as well, it must be properly escaped per Chapter 2.7.\n\nThe exchange of UDI sub-elements in PRT-16 through PRT-21 is not required when the full UDI string is provided in PRT-10. Whether to include some or all these fields as well when PRT-10 is present with a UDI that the rules are subject to specific implementation guides that will have to consider the patient safety implications of potentially conflicting data.\n\nWhen a UDI is provided and sub-elements are also provided, then for those sub-elements that are valued, the content must match the content encoded in the UDI if it is encoded within the UDI.\n\nWhen communicating a UDI, the UDI may either be uniquely identifying an instance of a device, or a type of device. This can be asserted based on the inclusion or absence of a serial number in the Product Identifier section of the UDI. When the serial number is present, PRT-10 must be used, while if it is absent, PRT-22 must be used.\n\n*Caution:* The UDI may contain personally identifying information in the form of the device *serial number* which may be used to link to other information on a patient. Security and privacy consideration should be addressed, particularly when sending a UDI with a serial number, as that may inadvertently be able to identify a patient. Note: In the US realm that would be addressed by HIPAA.\n\nNote: PRT-10 Device is a repeating field. Additional device identifiers, such as an IEEE EUI-64 may also be contained in this field."
* 11 0..1 DTM "PRT-11" "This field contains the date/time when the participation began."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2387
* 11 ^comment = "In the case of waypoints, this reflects the time a shipment arrives at the waypoint."
* 12 0..1 DTM "PRT-12" "This field contains the date/time when the participation ended."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2388
* 12 ^comment = "In the case of waypoints, this reflects the time a shipment departs from the waypoint."
* 13 0..1 CWE "PRT-13" "This field contains the qualitative length of time for participation (e.g., until the next assessment, four days, until discharge, etc.)."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2389
* 14 0..0 XAD "PRT-14" "This field contains addresses associated with the participation. The address can repeat to indicate alternate addresses or an alternate expression of the same address."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #C
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2390
* 14 ^comment = "Condition: The address must be present if the Participation is Performing Organization Medical Director."
* 15 0..0 XTN "PRT-15" "The waypoint telecommunication address field carries telecommunications addresses for the waypoint. These telecommunications addresses are used to contact the waypoint for additional information regarding the receipt of the shipment. The address can repeat to indicate alternate addresses or an alternate expression of the same address."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2391
* 16 0..1 EI "PRT-16" "Provides the U.S. FDA UDI _device identifier_ (DI) element."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3476
* 16 ^comment = "This is the first component in the UDI and acts as the look up key for the Global Unique Device Identification Database (GUDIDfootnote:[See www.fda.gov/udi]), and may be used for retrieving additional attributes.\n\nWhen exchanging Device Identifiers (DI) the root shall be the OID, or standards’ appropriate corollary to the OID, assigned to DI and the extension shall be the Human Readable Form of the content. For example, for DIs the root shall be:\n\nGS1 DIs: 2.51.1.1\n\nHIBCC DIs: 1.0.15961.10.816\n\nICCBBA DIs: 2.16.840.1.113883.6.18.1.17 for Blood containers and 2.16.840.1.113883.6.18.1.34 otherwise.\n\nExample: |00643169001763^^2.51.1.1^ISO|"
* 17 0..1 DTM "PRT-17" "Date and time when the device was manufacturered."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3477
* 17 ^comment = "Note: The user system may need to convert the date and optional hour from the UDI Human Readable Form to a timestamp style data type, augmenting the date as required to provide for a complete date and optionally the hour.\n\nExample: |20140401|"
* 18 0..1 DTM "PRT-18" "Date and time when the device is no longer approved for use."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3478
* 18 ^comment = "Note: The user system may need to convert the date and optional hour from the UDI Human Readable Form to a timestamp style data type, augmenting the date as required to provide for a complete date and optionally the hour.\n\nExample: |20160712|"
* 19 0..1 ST "PRT-19" "Alphanumeric string that identifies the device’s production lot number."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3479
* 19 ^comment = "Example: |123ABC|"
* 20 0..1 ST "PRT-20" "Manufacturer’s serial number for this device."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3480
* 20 ^comment = "CAUTION: See the related privacy considerations discussion in PRT-10.\n\nExample: |21A11F4855|"
* 21 0..1 EI "PRT-21" "Identifies a device related to a donation (e.g., whole blood)."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3481
* 21 ^comment = "When exchanging Donation Identification Numbers (DIN) the root shall be the OID assigned to DIN and the extension shall be the Human Readable Form of the content. For example, for DINs the root shall be:\n\nICCBBA DINs: 2.16.840.1.113883.6.18.2.1\n\nAn ICCBBA DIN OID is available for reference where required, but is not required when the specific data element is scoped to ICCBBA DINs.\n\nExample: | RA12345678BA123^^2.16.840.1.113883.6.18.1.34^ISO|"
* 22 0..1 CNE "PRT-22" "This field contains the type of device used in the participation."
* 22 from http://terminology.hl7.org/ValueSet/v2-0961 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #C
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3483
* 22 ^comment = "When communicating a UDI, the UDI may either be uniquely identifying an instance of a device, or a type of device. This can be asserted based on the inclusion or absence of a serial number in the Product Identifier section of the UDI. When the serial number is present, PRT-10 must be used, while if it is absent, PRT-22 must be used.\n\nWhen communicating a UDI in this field, the coding system used is limited to FDA (FDAUDI), HIBCC (HIBUDI), ICCBBA (ICCUDI), and GS1 (GS1UDI) coding systems defined in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396].\n\nCondition: At least one of the PRT-5 Person, PRT-8 Organization, PRT-9 Location, or PRT-10 Device or PRT-22 Device Type fields must be valued.\n\nSee Externally HL7 defined HL70961 in Chapter 2C for suggested values."
* 23 0..1 CWE "PRT-23" "This field contains the preferred method to use when communicating particularly when the contact is a person or organization This is typically used in combination with PRT-5 Person, and/or PRT-8 Organization. Refer to User-defined Table 0185 - Preferred Method of Contact in Chapter 2C, \"Code Tables\", for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0185 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #684
* 24 0..0 PLN "PRT-24" "This field contains the contact identifier to use when communicating particularly when the contact is a person or organization This is typically used in combination with PRT-5 Person, and/or PRT-8 Organization. This repeating field contains the contact's unique identifiers such as UPIN, Medicare and Medicaid numbers."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1171