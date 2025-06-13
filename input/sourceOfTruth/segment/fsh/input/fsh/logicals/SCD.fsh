Logical: SCD
Parent: $Segment
Id: SCD
Title: "HL7 v2 SCD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Anti-Microbial Cycle Data"
* 1 0..1 TM "SCD-1" "The time that the load cycle begins."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2104
* 2 0..1 NM "SCD-2" "The number of cycles that have been completed."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "16"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2105
* 3 0..1 CQ "SCD-3" "The maximum temperature achieved during a specific cycle."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2106
* 4 0..1 CQ "SCD-4" "The minimum temperature achieved during a specific cycle."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2107
* 5 0..1 NM "SCD-5" "A number assigned to the load by the anti-microbial device. This number is incremented by the machine per cycle during the day and reset at midnight."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "16"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2108
* 6 0..1 CQ "SCD-6" "The actual amount of cycle time spent in the conditioning phase. For example, in a pre-vac sterilizer the condition phase is achieved by pulsing the machine six times to create a vacuum."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2109
* 7 0..1 CQ "SCD-7" "The actual amount of cycle time spent sterilizing supplies."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2110
* 8 0..1 CQ "SCD-8" "The actual amount of cycle time spent draining pressure from the sterilizer chamber."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2111
* 9 0..1 CQ "SCD-9" "The sum of time spent in all phases of a cycle."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2112
* 10 0..1 CWE "SCD-10" "The status of a device. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70682[_User-defined Table 0682 – Device Status_] in Chapter 2C, Code Tables, for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0682 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2113
* 11 0..1 DTM "SCD-11" "The date and time that the cycle started."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2114
* 12 0..1 CQ "SCD-12" "The amount of cycle time spent drying the load."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2115
* 13 0..1 CQ "SCD-13" "The amount of pressure that the chamber can hold expressed as barometric pressure."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2116
* 14 0..1 CQ "SCD-14" "Amount of overdrive above the sterilize temperature."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2117
* 15 0..1 CQ "SCD-15" "The current temperature in the anti-microbial device."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2118
* 16 0..1 TM "SCD-16" "The time of day that the cycle completed."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2119
* 17 0..1 CQ "SCD-17" "The temperature reached during a cycle, which fell below the required temperature range."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2120
* 18 0..1 CQ "SCD-18" "The temperature reached during a cycle, which exceeded the required temperature."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2121
* 19 0..1 CNE "SCD-19" "A notification that the cycle was aborted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #2122
* 20 0..1 CNE "SCD-20" "A notification that the time, temperature, or pressure reached is invalid for a specific phase of a cycle. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #2123
* 21 0..1 CNE "SCD-21" "A notification that the charge phase in the cycle has exceeded the maximum time allowed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2124
* 22 0..1 CNE "SCD-22" "A notification that the exhaust phase in the cycle has exceeded the maximum time allowed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2125
* 23 0..1 CNE "SCD-23" "A notification that the fast exhaust phase in the cycle has exceeded the maximum time allowed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2126
* 24 0..1 CNE "SCD-24" "An indicator that specific anti-microbial device parameters have been set to system defaults. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 24 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2127
* 25 0..1 XCN "SCD-25" "The name of the operator that unloaded the anti-microbial device."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2128
* 26 0..1 CNE "SCD-26" "An indicator that the door is open. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2129
* 27 0..1 CNE "SCD-27" "A notification that an error was encountered while reading the cycle data for a specific cycle. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70532[_HL7 Table 0532 - Expanded Yes/no Indicator_] in Chapter 2C, Code Tables, for valid values."
* 27 from http://terminology.hl7.org/ValueSet/v2-0532 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2130
* 28 0..1 CWE "SCD-28" "The type of cycle that is being executed. A cycle type is a specific sterilization method used for a specific type of supply item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70702[_User-defined Table 0702 – Cycle Type_] in Chapter 2C, Code Tables, for suggested values."
* 28 from http://terminology.hl7.org/ValueSet/v2-0702 (required)
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2131
* 29 0..1 CQ "SCD-29" "The amount of time spent in the thermal rinse phase of a decontamination cycle."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #2132
* 30 0..1 CQ "SCD-30" "The amount of time spent in the wash phase of a decontamination cycle."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #2133
* 31 0..1 CQ "SCD-31" "The injection rate of a wash or dry agent."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #2134
* 32 0..1 CNE "SCD-32" "The unique identifier indicating the type of procedure performed on the patient with the supplies being sterilized."
* 32 from http://terminology.hl7.org/ValueSet/v2-0088 (required)
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #O
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #393
* 32 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70088[_HL7 Table 0088 – Procedure Code_] in Chapter 2C, Code Tables, for suggested values.\n\nAs of v2.6, the known applicable external coding systems include those in the referenced table. If the code set you are using is in this table, then you must use that designation."
* 33 0..0 CX "SCD-33" "The unique identifier associating the patient with the supplies being sterilized."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #O
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #106
* 34 0..1 XCN "SCD-34" "The unique identifier associating the physician with the supplies being sterilized, used for the procedure and patient identified in this message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70010[_User-defined Table 0010 - Physician ID_] in Chapter 2C, Code Tables, for suggested values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0010 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #137
* 35 0..1 SN "SCD-35" "The dilution ratio of peracetic acid to water."
* 35 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 35 ^extension[=].valueCode = #O
* 35 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 35 ^code.code = #1356
* 36 0..1 CQ "SCD-36" "The amount of time spent in filling the sterilizer chamber with dilutant."
* 36 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 36 ^extension[=].valueCode = #O
* 36 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 36 ^code.code = #2139
* 37 0..1 CQ "SCD-37" "The temperature of the dilutant upon entering the sterilizer chamber."
* 37 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 37 ^extension[=].valueCode = #O
* 37 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 37 ^code.code = #2140