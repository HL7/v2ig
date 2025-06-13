Logical: RXV
Parent: $Segment
Id: RXV
Title: "HL7 v2 RXV Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Infusion"
* 1 0..1 SI "RXV-1" "For the first timing specification transmitted, the sequence number shall be 1; for the second timing specification, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3318
* 2 1..1 ID "RXV-2" "This field identifies the type of bolus being ordered. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70917[_HL7 Defined Table 0917 – Bolus Type_] in Chapter 2C, Code Tables, for example values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0917 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #3319
* 3 0..1 NM "RXV-3" "This field contains the ordered bolus amount. For example, if the ordered bolus is 50 mg, this field contains the value of 50."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3320
* 4 0..1 CWE "RXV-4" "This field indicates the amount units associated with the bolus dose amount. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0767 - Bolus Dose Amount Units in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0767 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3321
* 4 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 5 0..1 NM "RXV-5" "This field defines the volume measurement for the ordered bolus amount. For example, if the ordered bolus is 5 ml, this field contains the value of 5."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "20"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3322
* 6 0..1 CWE "RXV-6" "This field indicates the amount units associated with the bolus dose volume. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0768 - Bolus Dose Volume Units in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0768 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3323
* 6 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 7 1..1 ID "RXV-7" "This field identifies the type of bolus being ordered. See file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70918[_HL7 Defined Table 0918 – PCA Type_] in Chapter 2C, Code Tables, for example values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0918 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 1
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 2
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3324
* 8 0..1 NM "RXV-8" "This field contains the order’s PCA dose amount. Example: if the ordered bolus is 3 mg, this field contains the value of 3."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "20"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #3325
* 9 0..1 CWE "RXV-9" "This field indicates the amount units associated with the PCA dose amount. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0769 - PCA Dose Amount Units in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0769 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3326
* 9 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 10 0..1 NM "RXV-10" "This field defines the volume measurement for the ordered PCA amount volume. For example, if the ordered bolus is 5 ml, this field contains the value of 5."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "20"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = false
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3327
* 11 0..1 CWE "RXV-11" "This field indicates the amount units associated with the PCA dose volume. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0770 - PCA Dose Amount Volume Units in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0770 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3328
* 11 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 12 0..1 NM "RXV-12" "This field contains the order’s maximum dose amount. For example, if the ordered bolus is 50 mg, this field contains the value of 50."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "20"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3329
* 13 0..1 CWE "RXV-13" "This field indicates the amount units associated with the maximum dose volume. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0772 - Max Dose Amount Units in Chapter 2C for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0772 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3330
* 13 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 14 0..1 NM "RXV-14" "This field defines the volume measurement for the ordered max dose amount. For example, if the ordered bolus is 5 ml, this field contains the value of 5."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "20"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3331
* 15 0..1 CWE "RXV-15" "This field indicates the amount units associated with the maximum dose volume. The preferred coding system is MDC; UCUM are also acceptable. Refer to Table 0773 - Max Dose Amount Volume Units in Chapter 2C for valid values."
* 15 from http://terminology.hl7.org/ValueSet/v2-0773 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3332
* 15 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 16 1..1 CQ "RXV-16" "This field contains the time unit expression of the lock out parameter. For example, if the ordered max dose per time is 4 hours, this field format is \"4^h&hours&UCUM\"."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #R
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3333
* 17 0..1 CQ "RXV-17" "This field contains the length of time that must expire between deliveries of PCA doses. For example, if the ordered max dose per time is 10 minutes, this field format is \"10^min&minute&UCUM\"."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3334
* 18 0..1 CWE "RXV-18" "This field contains the manufacturer of the syringe containing the ordered medication."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3339
* 19 0..1 CWE "RXV-19" "This field contains the model number of the syringe containing the ordered medication."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3385
* 20 0..1 NM "RXV-20" "This field contains the syringe’s numeric total volume size."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #C
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 20 ^extension[=].extension[0].url = "length"
* 20 ^extension[=].extension[=].valueInteger = "20"
* 20 ^extension[=].extension[+].url = "noTruncate"
* 20 ^extension[=].extension[=].valueInteger = false
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3386
* 21 0..1 CWE "RXV-21" "This field indicates the amount units associated with the syringe size. The preferred coding system is MDC; UCUM are also acceptable."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #C
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3431
* 21 ^comment = "Examples:\n\n263890^MDC_DIM_MILLI_G^MDC\n\nmg^milligram^UCUM"
* 22 0..1 ID "RXV-22" "The intended handling by the receiver of the infusion order is represented by this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 – Segment Action Code_] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #816