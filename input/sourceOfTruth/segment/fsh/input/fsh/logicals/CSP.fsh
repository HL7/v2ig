Logical: CSP
Parent: $Segment
Id: CSP
Title: "HL7 v2 CSP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Clinical Study Phase"
* 1 1..1 CWE "CSP-1" "This field identifies the phase of the study that a patient has entered. The set of codes will generally be developed for each clinical trial, although there are patterns that trials in particular disease or prevention categories may follow. The phase structure will be based on data collation and reporting needs for the study. It is an operational structure and need not be discussed in the clinical trial protocol documentation or even made known to patient care or data collection personnel. The coding system will usually be developed by the sponsor for multicentered clinical trials to standardize the receipt of automated data. Local codes could be added if an additional local message is desired. Otherwise, local coding conventions will be used. Refer to Table 0587 - Study Phase Identifier in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0587 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1022
* 1 ^comment = "Example:\n\n2^Init Rx, Crs 1^NCI T93‑0807 Phases"
* 2 1..1 DTM "CSP-2" "This field contains the date the patient began this phase interval. The time is optional."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1052
* 3 0..1 DTM "CSP-3" "This field contains the date the patient ended this phase interval."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1053
* 4 0..1 CWE "CSP-4" "This field contains the disposition of the patient's data for this phase interval for quality control and data analysis purposes. The set of codes will vary across clinical trials. An example answer set: *Complete, Adverse Events Only, Outcome Only, None, Unknown*. Refer to Table 0588 - Study Phase Evaluability in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0588 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1054