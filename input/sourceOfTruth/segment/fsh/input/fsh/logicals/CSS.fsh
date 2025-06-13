Logical: CSS
Parent: $Segment
Id: CSS
Title: "HL7 v2 CSS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Clinical Study Data Schedule"
* 1 1..1 CWE "CSS-1" "This field contains the time point for which some instance of data for the clinical trial was scheduled. The time point may be expressed in any coded format. Some examples of time point values are: *Prestudy, Pretreatment, 4 times/day, Weekly, Every 3 days, Every course, At Relapse, At Off Study.* Alternatively, frequency values from Section 2.A.81.2, \"Interval component (RI),\" (the Interval component of the TQ Timing/Quantity data type could be used; however, note that as of version 2.5, the TQ data type is retained only for backward compatibility). Time point naming conventions and usage must be specified by implementers. Refer to Table 0595 - Study Scheduled Time Point in Chapter 2C for valid values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0595 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1055
* 2 0..1 DTM "CSS-2" "This field contains the date/time that the scheduled time point should occur for this patient. The date/time may be used for a reference in reviewing the actual dates on which scheduled items that follow in OBR segments occur for the patient. The time component is optional."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1056
* 3 0..3 CWE "CSS-3" "In clinical settings, the *actual* date of a treatment or procedure may vary considerably from the *due* date. Various coding systems may be used to evaluate the adherence to the schedule or acceptability of the data. Coding systems will vary among trials. Refer to Table 0596 - Study Quality Control Codes in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0596 (required)
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1057