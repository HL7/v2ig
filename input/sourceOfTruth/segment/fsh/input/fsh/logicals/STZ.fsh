Logical: STZ
Parent: $Segment
Id: STZ
Title: "HL7 v2 STZ Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Sterilization Parameter"
* 1 0..1 CWE "STZ-1" "This field contains the type of sterilization used for sterilizing the inventory supply item in the ITM segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70806[_User-defined Table 0806 – Sterilization Type_] in Chapter 2C, Code Tables, for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0806 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2213
* 2 0..1 CWE "STZ-2" "This field contains the sterilization cycle used for sterilization of the inventory supply item. The AAMI Standard defines steam sterilization cycles – cycle names: pressure, temperature, dry time. Refer to _SCD-28 Cycle Type_ (CWE) 02131 which references file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70702[_User-defined Table 0702 – Cycle Type_] in Chapter 2C, Code Tables, providing suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0702 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2214
* 3 0..1 CWE "STZ-3" "This field contains the maintenance cycle used for the inventory supply item, such as the number of times to sharpen after five uses. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70809[_User-defined Table 0809 – Maintenance Cycle_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0809 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2215
* 4 0..1 CWE "STZ-4" "This field contains the type of maintenance performed on the inventory supply item. This is different than the maintenance cycle in the sense that it can describe the number of maintenance cycles that can be performed before disposing of the inventory supply item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70811[_User-defined Table 0811 – Maintenance Type_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0811 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2216