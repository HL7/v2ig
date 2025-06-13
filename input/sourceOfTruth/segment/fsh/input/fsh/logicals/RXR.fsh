Logical: RXR
Parent: $Segment
Id: RXR
Title: "HL7 v2 RXR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Route"
* 1 1..1 CWE "RXR-1" "This field is the route of administration."
* 1 from http://terminology.hl7.org/ValueSet/v2-0162 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #309
* 1 ^comment = "Some current \"route codes,\" such as some of the NDC-derived codes include the site already. In such cases, the entire code can be included in this field as a \"locally-defined code\" for the CWE data type. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70162[_User-Defined Table 0162 - Route of Administration_] in Chapter 2C, Code Tables, for valid values."
* 2 0..1 CWE "RXR-2" "This field contains the site of the administration route. When using a post-coordinated code table in this field, RXR-6 Administration Site may be used to modify the meaning of this field."
* 2 from http://terminology.hl7.org/ValueSet/v2-0550 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #310
* 2 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70550[_HL7 Table 0550 – Body_] _Parts_ in Chapter 2C, Code Tables, for valid values. Other appropriate external code sets (e.g., SNOMED) may also be employed."
* 3 0..1 CWE "RXR-3" "This field contains the mechanical device used to aid in the administration of the drug or other treatment. Common examples are IV-sets of different types. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70164[_User-defined Table 0164 - Administration device_] in Chapter 2C, Code Tables, for valid entries."
* 3 from http://terminology.hl7.org/ValueSet/v2-0164 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #311
* 4 0..1 CWE "RXR-4" "This field identifies the specific method requested for the administration of the drug or treatment to the patient. Refer To _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70165[User-defined Table 0165 – Administration M]ethod_ in Chapter 2C, Code Tables, for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0165 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #312
* 5 0..1 CWE "RXR-5" "This field provides instruction on administration routing, especially in cases where more than one route of administration is possible. A typical case would be designating which IV line should be used when more than one IV line is a possible route for injection. Refer to Table 0766 - Routing Instruction in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0766 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1315
* 6 0..1 CWE "RXR-6" "This field contains a modifier which modifies the meaning of _RXR-2 Administration Site_."
* 6 from http://terminology.hl7.org/ValueSet/v2-0495 (required)
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1670
* 6 ^comment = "The code table used in this field is dependent upon the code table used in _RXR-2 Administration site_. If RXR-2 employs file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70550[_HL7 Table 0550 – Body_] _Parts_, then this field may only be populated with values from file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70495[_HL7 Table 0495 – Body Parts Modifier_]. In the case of other code sets (e.g., SNOMED) in RXR-2, RXR-6 may only be populated if modifiers are defined within, or related to, that code set.\n\nCondition Rule: This field may only be populated if _RXR-2 Administration Site_ is populated. This field is not required if RXR-2 is populated."