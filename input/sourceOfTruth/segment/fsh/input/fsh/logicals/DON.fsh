Logical: DON
Parent: $Segment
Id: DON
Title: "HL7 v2 DON Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Donation"
* 1 0..1 EI "DON-1" "This field contains a unique identifier, Donation Identification Number (DIN), for the specific donation and is therefore mandatory except when using an eligibility message type in which only DON-9, DON-10, and DON-11 are populated. DON-2 Donation Type (CNE) 03341"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #C
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3340
* 2 0..1 CNE "DON-2" "The type of donation. This element is mandatory except when using an eligibility message type in which only DON-9, DON-10, and DON-11 are populated. The values for this field are defined in Table RT008 - Type of Donation or Collection in 6th Position of Product Code in the ISBT 128 Standard Technical Specification, which is maintained by ICCBBA. Link: _http://iccbba.org/technicalspecification.pdf._ Table 5 Data Structure 002."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #3341
* 3 1..1 DTM "DON-3" "The start date and time of the phlebotomy."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3342
* 4 1..1 DTM "DON-4" "The end date and time of the phlebotomy."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3343
* 5 1..1 NM "DON-5" "The duration of the phlebotomy or the length of time that elapsed between the phlebotomy start date and time and the phlebotomy end date and time."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3344
* 6 1..1 CNE "DON-6" "The duration units. The duration units and duration are restricted to minutes and seconds. Concepts are pulled from the UCUM code system (_http://www.unitsofmeasure.org[www.unitsofmeasure.org])._ Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70932[HL7-Defined Table 0932 – Donation Duration Units] in Chapter 2C, Code Tables, for valid entries__.__"
* 6 from http://terminology.hl7.org/ValueSet/v2-0932 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #3345
* 7 1..0 CNE "DON-7" "The procedure(s) intended to be performed on the donor. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70933[HL7-Defined Table 0933 – Intended Procedure Type] in Chapter 2C, Code Tables, for valid entries__.__"
* 7 from http://terminology.hl7.org/ValueSet/v2-0933 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3346
* 8 1..0 CNE "DON-8" "The actual procedure(s) performed on the donor. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70933[HL7-Defined Table 0933 – Intended Procedure Type] in Chapter 2C, Code Tables, for valid entries."
* 8 from http://terminology.hl7.org/ValueSet/v2-0933 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #3347
* 9 1..1 ID "DON-9" "Is the Donor eligible for donation? Yes or No. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 -Yes/No Indicator] as defined in Chapter 2C, Code Tables."
* 9 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #R
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3348
* 10 1..0 CNE "DON-10" "The procedure(s) for which the donor is eligible. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70933[HL7-Defined Table 0933 – Intended Procedure Type] in Chapter 2C, Code Tables, for valid entries."
* 10 from http://terminology.hl7.org/ValueSet/v2-0933 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #R
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3349
* 11 1..1 DTM "DON-11" "The date and time on which the donor is eligible to donate."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3350
* 12 1..1 CNE "DON-12" "Was the donation process interrupted after it began? Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70923[HL7-Defined Table 0923 – Process Interruption] in Chapter 2C, Code Tables, for valid entries."
* 12 from http://terminology.hl7.org/ValueSet/v2-0923 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #R
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #3351
* 13 1..1 CNE "DON-13" "Reason that the donation process was interrupted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70935[HL7-Defined Table 0935 – Process Interruption Reason] in Chapter 2C, Code Tables, for valid entries."
* 13 from http://terminology.hl7.org/ValueSet/v2-0935 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #R
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #3352
* 14 1..0 CNE "DON-14" "Indicates whether there is a problem or issue with the phlebotomy itself. This may be due to an incorrect needle procedure, needle defect, tube blockage, problem with the apheresis machine, or improper action by the phlebotomist. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70925[HL7-Defined Table 0925 – Phlebotomy Issue] in Chapter 2C, Code Tables, for valid entries."
* 14 from http://terminology.hl7.org/ValueSet/v2-0925 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #R
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #3353
* 15 1..1 ID "DON-15" "If this donation has an intended recipient (directed, dedicated, designated), is the intended recipient a blood relative of the donor? Yes or No. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 -Yes/No Indicator] as defined in Chapter 2C, Code Tables."
* 15 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #R
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #3354
* 16 1..1 XPN "DON-16" "If this is donation has an intended recipient (autologous, directed, dedicated, designated), the intended recipient’s name."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #R
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #3355
* 17 1..1 DTM "DON-17" "If this donation has an intended recipient (autologous, directed, dedicated, designated), the intended recipient’s date of birth."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #R
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #3356
* 18 1..1 XON "DON-18" "If this donation has an intended recipient (autologous, directed, dedicated, designated), the facility where the intended recipient is expected to receive the transfusion."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #R
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #3357
* 19 1..1 DTM "DON-19" "If this donation has an intended recipient (autologous, directed, dedicated, designated), the date the intended recipient is expected to receive the transfusion."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #R
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #3358
* 20 1..1 XPN "DON-20" "If this is donation has an intended recipient (autologous, directed, dedicated, designated), the provider who ordered the directed donation for the intended recipient."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #R
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3359
* 21 1..1 CNE "DON-21" "Whether the phlebotomy was successful, not drawn, or unsuccessful, and if unsuccessful, the extent to which it was unsuccessful. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70926[HL7-Defined Table 0926 – Phlebotomy Status] in Chapter 2C, Code Tables, for valid entries."
* 21 from http://terminology.hl7.org/ValueSet/v2-0926 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #R
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #3360
* 22 1..1 CNE "DON-22" "The arm(s) stuck for the donation. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70927[HL7-Defined Table 0927 – Arm Stick] in Chapter 2C, Code Tables, for valid entries."
* 22 from http://terminology.hl7.org/ValueSet/v2-0927 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #R
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #3361
* 23 1..1 XPN "DON-23" "The Phlebotomist who starts the blood flow into the container."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #R
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #3362
* 24 1..1 XPN "DON-24" "The Phlebotomist who ends the blood flow into the container."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #R
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #3363
* 25 1..1 ST "DON-25" "The type of aphaeresis machine, if used, for the donation. It will be the specific product name of the machine (e.g. Trima, Amicus, Alyx, Symal, etc.)."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #R
* 25 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 25 ^extension[=].extension[0].url = "length"
* 25 ^extension[=].extension[=].valueInteger = "75"
* 25 ^extension[=].extension[+].url = "noTruncate"
* 25 ^extension[=].extension[=].valueInteger = true
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #3364
* 26 1..1 ST "DON-26" "The serial number of the aphaeresis machine, if used, for the donation."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #R
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 26 ^extension[=].extension[0].url = "length"
* 26 ^extension[=].extension[=].valueInteger = "25"
* 26 ^extension[=].extension[+].url = "noTruncate"
* 26 ^extension[=].extension[=].valueInteger = true
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #3365
* 27 1..1 ID "DON-27" "Did the donor have any adverse reaction during the donation procedure? Yes or No. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 Table 0136 -Yes/No Indicator] as defined in Chapter 2C, Code Tables. If this element is valued \"Y\"es, there should be OBX segments following the Donation segment which details the adverse reactions."
* 27 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #R
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #3366
* 28 1..1 XPN "DON-28" "The Staff member conducting the final review and reconciliation of all documentation created during the collection process."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #R
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #3367
* 29 1..1 DTM "DON-29" "The date and time a final review of all documentation and labeling of the blood material is completed."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #R
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #3368
* 30 1..1 NM "DON-30" "The number of samples collected during the donation which will be used for subsequent testing."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #R
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #3369
* 31 1..0 EI "DON-31" "The sample identifier for the sample collected during a donation for the purpose of testing. This is a field for sample or specimen identifiers."
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #R
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #3370
* 32 1..1 XCN "DON-32" "The staff member who reviewed all the intake materials, assessments and determined the donor can undergo a donation procedure at this time."
* 32 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 32 ^extension[=].valueCode = #R
* 32 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 32 ^code.code = #3371
* 33 1..0 XCN "DON-33" "The staff member who performs review on all documentation subsequent to donation procedure."
* 33 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 33 ^extension[=].valueCode = #R
* 33 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 33 ^code.code = #3372
* 34 0..1 ID "DON-34" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] for valid values."
* 34 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 34 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 34 ^extension[=].valueCode = #O
* 34 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 34 ^extension[=].extension[0].url = "min"
* 34 ^extension[=].extension[=].valueInteger = 1
* 34 ^extension[=].extension[+].url = "max"
* 34 ^extension[=].extension[=].valueInteger = 1
* 34 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 34 ^code.code = #816
* 34 ^comment = "The action code can only be used when an DON is uniquely identified sufficiently within the specific implementation using DON-1 in accordance with Chapter 2, Section 2.10.4.2."