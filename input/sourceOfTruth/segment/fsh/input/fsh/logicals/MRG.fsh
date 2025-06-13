Logical: MRG
Parent: $Segment
Id: MRG
Title: "HL7 v2 MRG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Merge Patient Information"
* 1 1..0 CX "MRG-1" "This field contains the prior patient identifier list. This field contains a list of potential \"old\" numbers to match. Only one old number can be merged with one new number in a transaction. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[HL7 Table 0061 - Check Digit Schem]e_ for valid values. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 1 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #211
* 2 0..1 BackboneElement "MRG-2" "*The MRG-2 field was retained for backward compatibility only as of v 2.3.1 and withdrawn as of v 2.7. The reader is referred to section _3.4.10.1_, _MRG-1 Prior Patient Identifier List_* (CX) 00211**, instead.**"
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #W
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #212
* 3 0..1 CX "MRG-3" "This field contains the prior patient account number. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] for valid values. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 3 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #213
* 4 0..1 BackboneElement "MRG-4" "*The MRG-4 field was retained for backward compatibility only as of v 2.3.1 and withdrawn as of v 2.7. The reader is referred to section _3.4.10.1_, _MRG-1 Prior Patient Identifier List_* (CX) 00211**, instead.**"
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #W
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #214
* 5 0..1 CX "MRG-5" "This field contains the prior visit number. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] for valid values. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 5 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1279
* 6 0..0 CX "MRG-6" "This field contains the prior alternate visit number. Multiple alternate identifiers may be sent. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70061[_HL7 Table 0061 - Check Digit Scheme_] in Chapter 2C, Code Tables, for valid values. The assigning authority and identifier type code are strongly recommended for all CX data types."
* 6 from http://terminology.hl7.org/ValueSet/v2-0061 (required)
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1280
* 7 0..0 XPN "MRG-7" "This field contains the prior name of the patient. This field is not used to change a patient name. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70200[_HL7 Table 0200 - Name Type_] in Chapter 2C, Code Tables, for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0200 (required)
* 7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension.valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1281