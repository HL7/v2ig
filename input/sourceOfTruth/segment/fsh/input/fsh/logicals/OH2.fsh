Logical: OH2
Parent: $Segment
Id: OH2
Title: "HL7 v2 OH2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Past or Present Job"
* 1 1..1 SI "OH2-1" "This field contains the number that identifies the OH2 segment instances in message structures where the OH2 segment repeats. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc. If the subject of the OH2 segment changes (e.g. Patient vs Next of Kin) the Set ID sequence will be reset."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3522
* 2 0..1 ID "OH2-2" "This field contains a code defining the action to be taken for this segment. It allows this segment to be sent to delete or update, for example, previously sent information. Refer to file:///D:\\Eigene%20Dateien\\2018\\HL7\\Standards\\v2.9%20Jan%202019\\v29%20CH2C%20Table%200206[*_HL7 Table 0206 – Segment Action Code_*] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #816
* 3 0..1 DT "OH2-3" "This field records the date that the information was entered into the patient record."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3524
* 4 1..1 CWE "OH2-4" "This field contains a code defining the occupation in which an individual is engaged in for the job recorded in this segment, regardless of duration. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70958[_HL7 Table 0958 – Occupation Code_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Occupation CDC Census 2010 codes published at https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.7186"
* 4 from http://terminology.hl7.org/ValueSet/v2-0958 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3525
* 5 1..1 CWE "OH2-5" "This field contains a code defining the industry in which an individual is engaged for the job recorded in this segment, regardless of duration. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70955[_HL7 Table 0955 – Industry Code_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Industry CDC Census 2010 codes published at https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.7187"
* 5 from http://terminology.hl7.org/ValueSet/v2-0955 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3526
* 6 0..1 CWE "OH2-6" "This field contains a code defining the work classification associated with the job of a person recorded in this segment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70959[_HL7 Table 0959 – Work Classification Code_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0959 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3527
* 7 0..1 DT "OH2-7" "This field asserts when the job began."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 8
* 7 ^extension[=].extension[+].url = "max"
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2494
* 8 0..1 DT "OH2-8" "This field asserts when the job ended. If the job is current, Job End Date shall be empty."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 8 ^extension[=].extension[0].url = "min"
* 8 ^extension[=].extension[=].valueInteger = 8
* 8 ^extension[=].extension[+].url = "max"
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2495
* 8 ^comment = "*Note:* The Employment Status End Date SHALL not be greater than the date noted in OH2-3 Entered Date."
* 9 0..1 CWE "OH2-9" "This field contains a code defining the work schedule associated with the job of a person recorded in this segment. Describes an individual's typical arrangement of working hours for a job. For example, work schedule may capture that an individual typically works a regular day shift, evening shift, or night shift. It can also specify if an individual has another type of schedule such as a rotating shift, split shift, etc. In healthcare settings, knowledge of a patient's typical work schedule may assist in diagnosis of healthcare issues related to irregular work hours or sleep patterns. It may also assist in determining appropriate treatment and prevention plans that will coordinate with the patient's work schedule. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70954[_HL7 Table 0954 – Work Schedule Code_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0954 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3528
* 10 0..1 NM "OH2-10" "This field asserts the average hours worked per day for the job of a person recorded in this segment."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3529
* 11 0..1 NM "OH2-11" "This field asserts the average days worked per week for the job of a person recorded in this segment."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3530
* 12 0..1 XON "OH2-12" "This field asserts the name and or identifier of the employer organization for the job of a person recorded in this segment."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 48
* 12 ^extension[=].extension[+].url = "max"
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3531
* 13 0..0 XAD "OH2-13" "This field asserts the address of the employer organization for the job of a person recorded in this segment. This field shall be populated with the address of the employer rather than the site that the employee works."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 106
* 13 ^extension[=].extension[+].url = "max"
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3546
* 13 ^comment = "The field may repeat."
* 14 0..1 CWE "OH2-14" "This field contains a code defining the supervisory level associated with the job of a person recorded in this segment. Supervisory Level reflects the amount of supervisory or management responsibilities for an individual’s job. For example, in the US, in the military, this is the person’s pay grade, which serves as a proxy for supervisory level and can be interpreted across branches. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70956[_HL7 Table 0956 – Supervisory Level Code_] in Chapter 2C, Code Tables, for suggested values. In the US, this field should use the Job Supervisory Level or Pay Grade (ODH)codes published at https://phinvads.cdc.gov/vads/ViewCodeSystem.action?oid=2.16.840.1.114222.4.11.7613"
* 14 from http://terminology.hl7.org/ValueSet/v2-0956 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3532
* 15 0..0 ST "OH2-15" "This field lists the regular actions performed at work. For example, a person may have the occupation of “construction laborer” and his specific job duties are to carry construction supplies. Specific job information is important in the healthcare setting because it provides information regarding hazards to which a person may have been exposed, which is pertinent to treatment and prevention. This field may repeat to list multiple job duties, or the job duties may be compiled as a single narrative."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 15 ^extension[=].extension[0].url = "min"
* 15 ^extension[=].extension[=].valueInteger = 250
* 15 ^extension[=].extension[+].url = "max"
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3533
* 16 0..0 FT "OH2-16" "This field lists the hazard(s) associated with a person’s job. Job hazards are a source of potential harm to an individual’s physical or mental health. Hazards may be biological, physical, psychological, chemical, or radiological in nature. An occupational hazard is one that is specific to the work or work environment of an individual. This field may repeat to list multiple occupational hazards, or the occupational hazards may be compiled as a single narrative."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 250
* 16 ^extension[=].extension[+].url = "max"
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3534
* 17 0..1 EI "OH2-17" "This field contains a value the uniquely identifies a single job for a person."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2433
* 18 0..1 CWE "OH2-18" "This field defines a flag indicating if this is the person’s current job (at the time the record was last updated) using 'Yes', when current and 'No' when not. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/no_] _Indicator_ in Chapter 2C, Code Tables, for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #2471