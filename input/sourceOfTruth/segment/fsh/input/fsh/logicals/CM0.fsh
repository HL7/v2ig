Logical: CM0
Parent: $Segment
Id: CM0
Title: "HL7 v2 CM0 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Clinical Study Master"
* 1 0..1 SI "CM0-1" "This field contains a number that uniquely identifies this transaction for the purpose of adding, changing, or deleting the transaction. For those messages that permit segments to repeat, the Set ID field is used to identify the repetitions."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1010
* 2 1..1 EI "CM0-2" "This field contains the study number established by the study sponsor. Please see discussion in Chapter 7, section 7.7.1.1, \"Sponsor study ID.\""
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1011
* 3 0..3 EI "CM0-3" "This field contains the local or collaborators' cross-referenced study numbers."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1036
* 4 1..1 ST "CM0-4" "This field contains the sending institution's title for the clinical trial. It gives recipients further identification of the study."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "300"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = true
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1013
* 5 0..0 XCN "CM0-5" "This field contains the sending institution's chairman. It further identifies the study. The chairman's name may be needed for communication purposes."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1014
* 6 0..1 DT "CM0-6" "This field contains an institution's Internal Review Board approval dates which are required annually to continue participation in a clinical trial."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1015
* 7 0..1 NM "CM0-7" "This field is a quality control field to enable checks that patient data have been transmitted on all registered patients."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "8"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1016
* 8 0..1 DT "CM0-8" "This field contains the status information on the patient registration activity for quality control and operations purposes."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1017
* 9 0..0 XCN "CM0-9" "This field contains the name of the individual who should be contacted for inquiries about data transmitted for this study."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1018
* 10 0..1 XTN "CM0-10" "This field contains the phone number of the study contact identified in _CM0-9 - Contact for Study_."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1019
* 11 0..0 XAD "CM0-11" "This field contains the address of the study contact identified in _CM0-9 - Contact for Study_."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1020