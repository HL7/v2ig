Logical: GSP
Parent: $Segment
Id: GSP
Title: "HL7 v2 GSP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Person Gender and Sex"
* 1 1..1 SI "GSP-1" "This field contains the sequence number used to identify the GSP segment instances in a message."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3543
* 2 1..1 ID "GSP-2" "This field contains a code defining the action to be taken for this segment."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #816
* 3 0..1 EI "GSP-3" "This field contains the value that uniquely identifies a single GSP declaration for an individual. This field is conditionally required when the Action Code in GSP-2 indicates data is not being sent in Snapshot Mode (valued “S”)."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2510
* 4 1..1 CWE "GSP-4" "This field contains an identifer for the SOGI related concept being asserted (eg. Gender Identity, or Personal Pronouns). Refer to User-defined Table HL7 Table 0820 - Gender Harmony Concepts in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0820 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2511
* 5 1..1 CWE "GSP-5" "This field contains the value asserted for the concept conveyed in GSP-4. The appropriate value set to use will vary with the concept being communicated (i.e. the valid list of concepts for Gender Identity will be different than the valid list of concepts for Sexual Orientation)."
* 5 from http://terminology.hl7.org/ValueSet/v2-0821 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2512
* 5 ^comment = "For Gender Identity (GSP-4 is populated with ‘76691-5^Gender Identity^LN) refer to User-defined Table HL7 Table 0821 - Gender Identity in Chapter 2C, Code Tables, for suggested values.\n\nFor Personal Pronouns (GSP-4 is populated with ‘90778-2^Personal pronouns - Reported^LN) refer to User-defined Table HL7 Table 0822 - Personal Pronouns in Chapter 2C, Code Tables,for suggested values.\n\nFor Sexual Orientation (GSP-4 is populated with ‘76690-7^Sexual orientation^LN) refer to User-defined Table HL7 0823 - Sexual Orientation in Chapter 2C, Code Tables, for suggested values; use of external code systems like SNOMED CT to represent these concepts is recommended; for example in the US see USCDI v2 values (https://www.healthit.gov/isa/taxonomy/term/2741/uscdi-v2), which can be used as the base set, if appropriate for the jurisdiction."
* 6 0..1 DR "GSP-6" "This field asserts the time frame during which the value in GSP-5 applies to the individual. This field may contain values for both the Start Date/Time and End Date/Time for values known to no longer be in use. Alternatively, the field may be populated with just a Start Date/Time which indicates that the value is still currently in use. *Note that the Start Date/Time for the Validitity Period may be different than the date on which the data was collected and/or entered.*"
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2513
* 7 0..1 TX "GSP-7" "This field contains a free text comment pertaining to the value conveyed in GSP-5."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2514
* 7 ^comment = "As an example, consider an individual who identified as male as of January 1 2021 and used he/him/his pronouns until July 1 2021 when the individual began to also identify as non-binary and adopt the they/them/theirs pronouns. If the individual had encounters with a provider in March and October, the following segments would represent the Person Gender and Sex information known at those times.\n\nMessage generated in March:\n\nGSP|1|S||76691-5^Gender identity^LN|446151000124109^Identifies as male gender^SCT|20210101\n\nGSP|2|S||90778-2^Personal pronouns – Reported^LN|LA29518-0^he/him/his/his/himself^LN|20210101\n\nGSP|3|S||76690-7^Sexual orientation^LN|42035005^Bisexual^SCT|20210101\n\nMessage generated in October where the entire individual’s history is conveyed:\n\nGSP|1|S||76691-5^Gender identity^LN|446151000124109^Identifies as male gender^SCT|20210101\n\nGSP|2|S||76691-5^Gender identity^LN|33791000087105^Identifies as nonbinary gender^SCT|20210701\n\nGSP|3|S||90778-2^Personal pronouns – Reported^LN|LA29518-0^he/him/his/his/himself^LN|20210101^20210630\n\nGSP|4|S||90778-2^Personal pronouns – Reported^LN|LA29520-6^they/them/their/theirs/themselves^LN|20210701\n\nGSP|5|S||76690-7^Sexual orientation^LN|42035005^Bisexual^SCT|20210101\n\nOR\n\nMessage generated in October where only the individual’s current valid values are being conveyed\n\nGSP|1|S||76691-5^Gender identity^LN|446151000124109^Identifies as male gender^SCT|20210101\n\nGSP|2|S||76691-5^Gender identity^LN|33791000087105^Identifies as nonbinary gender^SCT|20210701\n\nGSP|3|S||90778-2^Personal pronouns – Reported^LN|LA29520-6^they/them/their/theirs/themselves^LN|20210701\n\nGSP|4|S||76690-7^Sexual orientation^LN|42035005^Bisexual^SCT|20210101"