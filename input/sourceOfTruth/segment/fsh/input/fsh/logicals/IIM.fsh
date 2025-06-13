Logical: IIM
Parent: $Segment
Id: IIM
Title: "HL7 v2 IIM Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Inventory Item Master"
* 1 1..1 CWE "IIM-1" "This field contains the code assigned by the institution for the purpose of uniquely identifying an inventoried item. It is the identifying key value, and must match _MFE-4 Primary Key Value - MFE_."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1897
* 2 1..1 CWE "IIM-2" "This field contains the identifier of the service item. It relates the inventory item of this message to an entry in an Other Observation/Service Item master file."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1799
* 3 0..1 ST "IIM-3" "This field contains the lot number of the service item in inventory."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "250"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1800
* 3 ^comment = "*Note:* The lot number is the number printed on the label attached to the item or container holding the substance. If the substance is a vaccine, for example, and a diluent is required, a lot number may appear on the vial containing the diluent; however, any such identifier associated with a diluent is not the identifier of interest. The substance lot number should be reported, not that of the diluent."
* 4 0..1 DTM "IIM-4" "This field contains the expiration date of the service item in inventory."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1801
* 4 ^comment = "*Note:* Expiration date does not always have a \"day\" component; therefore, such a date may be transmitted as YYYYMM."
* 5 0..1 CWE "IIM-5" "This field contains the manufacturer of the service item in inventory."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1802
* 6 0..1 CWE "IIM-6" "This field contains the location of the inventory. As an implementation consideration, this location can have a range of specificity. The location can be very general, e.g., a facility where the inventory is warehoused, or very specific, e.g., a shelf location."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1803
* 7 0..1 DTM "IIM-7" "This field contains the most recent date that the product in question was received into inventory."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1804
* 8 0..1 NM "IIM-8" "This field contains the quantity of this inventory item that was received on the date specific in _IIM-7 Inventory Received Date_."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "12"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1805
* 9 0..1 CWE "IIM-9" "This field specifies the unit for _IIM-8 Inventory Received Quantity_ and _IIM-10 Inventory Received Item Cost_."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1806
* 10 0..1 MO "IIM-10" "This field contains the per-unit cost of the inventory item at the time of receipt. _IIM-9 Inventory Received Quantity Unit_ specifies the per-unit basis of this field."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1807
* 11 0..1 DTM "IIM-11" "This field specifies the most recent date that an inventory count for the inventory item was performed."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1808
* 12 0..1 NM "IIM-12" "This field contains the quantity of this inventory item that was available for issue/use as of the date specified in _IIM-11 Inventory on Hand Date_. No adjustment has been made for subsequent use."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "12"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = true
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1809
* 13 0..1 CWE "IIM-13" "This field specifies the unit for _IIM-12 Inventory on Hand Quantity_."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1810
* 14 0..1 CNE "IIM-14" "This field contains a unique identifier assigned to the service item, if any, associated with the charge. In the United States this is often the HCPCS code. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70088[_Externally Defined Table 0088 - Procedure Code_] in Chapter 2C, Code Tables, for suggested values. This field is a CNE data type for compatibility with clinical and ancillary systems."
* 14 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #393
* 14 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation.\n\nProcedure Code Coding Systems\n\nProcedure Code Coding Systems\n|===\n|Coding System |Description |Comment\n|C4 |CPT-4 |American Medical Association, P.O. Box 10946, Chicago IL 60610.\n|C5 |CPT-5 |(under development – same contact as above)\n|HCPCS |CMS (formerly HCFA) Common Procedure Coding System |HCPCS: contains codes for medical equipment, injectable drugs, transportation services, and other services not found in CPT4.\n|HPC |CMS (formerly HCFA) Procedure Codes (HCPCS) |Health Care Financing Administration (HCFA) Common Procedure Coding System (HCPCS) including modifiers.footnote:[The HCPCS code is divided into three \"levels.\" Level I includes the entire CPT-4 code by reference. Level II includes the American Dental Association’s Current Dental Terminology (CDT-2) code by reference. Level II also includes the genuine HCPCS codes, approved and maintained jointly by the Alpha-Numeric Editorial Panel, consisting of CMS, the Health Insurance Association of America, and the Blue Cross and Blue Shield Association. Level III are codes developed locally by Medicare carriers. The HCPCS modifiers are divided into the same three levels, I being CPT-4 modifiers, II CDT-2 and genuine HCPCS modifiers, and III being locally agreed modifiers. +\n+\nThe genuine HCPCS codes and modifiers of level II can be found at http://www.hcfa.gov/stats/anhcpcdl.htm. CMS distributes the HCPCS codes via the National Technical Information Service (NTIS, http://www.ntis.gov[www.ntis.gov]) and NTIS distribution includes the CDT-2 part of HCPCS Level II, but does not include the CPT-4 part (Level I). CMS may distribute the CPT-4 part to its contractors.]\n|==="
* 15 0..0 CNE "IIM-15" "This field contains the procedure code modifier to the procedure code reported in _IIM-14 Procedure Code_, when applicable. Procedure code modifiers are defined by USA regulatory agencies such as CMS and the AMA. Multiple modifiers may be reported. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70340[_Externally defined Table 0340 - Procedure Code Modifier_] in Chapter 2C, Code Tables, for suggested values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0340 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1316
* 15 ^comment = "As of v2.6, the known applicable external coding systems include those in the table below. If the code set you are using is in this table, then you must use that designation."