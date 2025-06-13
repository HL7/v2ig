Logical: SDD
Parent: $Segment
Id: SDD
Title: "HL7 v2 SDD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:39Z"
* . ^short = "Sterilization Device Data"
* 1 0..1 EI "SDD-1" "A unique number associated with an instance of a sterilization/decontamination cycle assigned by the instrument-tracking system."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2098
* 2 0..1 EI "SDD-2" "The number of the device (e.g., 01 VAC)."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2099
* 3 0..1 ST "SDD-3" "The name of the device associated with the device number in SDD-2 (e.g., 01 VAC)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "999"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2281
* 4 0..1 CWE "SDD-4" "The state of data being sent, i.e., historic data of the cycle or a real-time snapshot of the current value of the cycle data. During a sterilization process, data is consistently being output to record the value of the data at each point in time within the instance of a cycle. For example, the temperature is recorded at every point in time during the cycle. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70667[User-defined Table 0667 – Device] Data State_ in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0667 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2100
* 5 0..1 CWE "SDD-5" "The status of the load. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70669[_User-defined Table 0669 – Load Status_] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0669 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2101
* 6 0..1 NM "SDD-6" "A code to command the device to send cycle data from the previous load to the instrument-tracking system."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "3"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2102
* 7 0..1 ST "SDD-7" "The person who started the device load for the decontamination/sterilization process."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "15"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2103