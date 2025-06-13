Logical: CSR
Parent: $Segment
Id: CSR
Title: "HL7 v2 CSR Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Clinical Study Registration"
* 1 1..1 EI "CSR-1" "The field contains the universal identifier for the clinical trial. Since many clinical trials are collaborative and multi‑centered, and since one goal of these standards is to promote automated data exchange among sites, the primary identifier should come from the sponsor. The coding system component may reference the sponsor. Example:"
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1011
* 1 ^comment = "T93‑0807^NCI (where NCI refers to the National Cancer Institute)."
* 2 0..1 EI "CSR-2" "This field contains an alternate identifier that may be used as agreed upon by messaging parties. For example, the sending application may code its internal study number here."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1036
* 3 0..1 CWE "CSR-3" "This field distinguishes the institution where registration occurred. The legal approval to give patients access to a trial lies with the Internal Review Board for the institution. Universal healthcare provider facility codes should be used when they exist. Currently coding systems must be devised by users. Refer to Table 0589 - Institution Registering the Patient in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0589 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1037
* 4 1..1 CX "CSR-4" "This field contains the main patient identification for the study. The sponsor patient ID allows automation of records on patients treated at various institutions. The sponsor patient ID should be unique for each patient participating on the study identified in _CSR-1 Sponsor Study ID_."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1038
* 5 0..1 CX "CSR-5" "This field may be the sending application's patient identification. Coding conventions may be used as agreed upon by users."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1039
* 6 1..1 DTM "CSR-6" "This field containing the date of the patient registration is mandatory. The time component is optional. The time stamp for a registration may be useful. For example, patients may be randomized at the pharmacy according to the order in which they were registered."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1040
* 7 0..0 XCN "CSR-7" "This field contains the healthcare facility employee who actually phoned, submitted a form, or interactively registered the patient on the clinical trial. This is generally done under authorization from the attending physician or a principal or collaborating investigator."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1041
* 8 1..0 XCN "CSR-8" "This field contains the healthcare provider, generally the attending physician, who is accountable that the patient is eligible for the trial and has signed an informed consent. National standard healthcare provider codes should be used when they exist. This field is required for the patient registration trigger event (C01)."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1042
* 9 0..1 DTM "CSR-9" "This field contains the consent form signing date is collected to provide a checkpoint that the consent form was obtained. Since many trials involve unapproved drugs and other treatment modalities, the consent form is highly important to document and store. This field is required for the patient registration trigger event (C01). The time component is optional."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #C
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1043
* 10 0..1 CWE "CSR-10" "This field indicates whether the patient was an appropriate candidate for the trial. It is important for quality control and data analysis. The code set will vary among clinical trials. An example answer set is: *_Yes, No, By Approval, Not Assessed, Unknown_*. This field is required for the patient registration trigger event (C01). Refer to Table 0590 - Patient Study Eligibility Status in Chapter 2C for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0590 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1044
* 11 0..3 DTM "CSR-11" "This field contains the date the patient was randomized. The time component is optional. Up to three randomizations are supported. Sequential randomizations are listed in chronological order."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1045
* 12 0..3 CWE "CSR-12" "This field contains codes that must be developed by users. The blind treatment assignment may be communicated as a dummy text: *^blind* or if a coded treatment assignment must also be communicated**: 1^blind^local_code**. If more than one randomization occurs, the second and third repetitions will correspond to the second and third repetitions of _CSR-11 Study Randomization Date/Time_, if they exist. Refer to Table 0591 - Randomized Study Arm in Chapter 2C for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0591 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1046
* 13 0..3 CWE "CSR-13" "Many studies have stratified randomization schemas. The strata codes must be developed for each clinical trial. This field is important for statistical analysis of the study results. The second and third repetitions will correspond to the second and third repetitions of _CSR-11 Study Randomization Date/Time_ and _CSR-12 Randomized Study Arm_, if they exist. Refer to Table 0592 - Stratum for Study Randomization in Chapter 2C for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0592 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1047
* 14 0..1 CWE "CSR-14" "This field categorizes the inclusion of this patient's data for various analyses. The patient's data may be evaluable for analysis of adverse events but not for outcomes. Or it may be evaluable for some outcomes and not others. The coding systems will vary among trials. This field is required for the off‑study trigger event (C04). Refer to Table 0593 - Patient Evaluability Status in Chapter 2C for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0593 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #C
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1048
* 15 0..1 DTM "CSR-15" "This field contains the date the patient completes or is otherwise removed from the study. This field is required for the off‑study event (C04). The time component is optional."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1049
* 16 0..1 CWE "CSR-16" "This information is important for quality control and data analysis. The coding systems will vary among trials. An example answer set is: *Adverse Events, Completed Trial, Death, Drug Resistance, Intercurrent Illness, Lost to Follow up, No Response to Therapy, Noncompliance, Progression of Disease, Protocol Violation, Refused Further Therapy.* This field is required for the off‑study trigger event (C04). Refer to Table 0594 - Reason Ended Study in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0594 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1050
* 17 0..1 ID "CSR-17" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #816
* 17 ^comment = "The action code can only be used when CSR-1 and CSR-4, or CSR-2 and CSR-5 are valued as agreed to by the trading partners in accordance with the guidance in Chapter 2, Section 2.10.4.2."