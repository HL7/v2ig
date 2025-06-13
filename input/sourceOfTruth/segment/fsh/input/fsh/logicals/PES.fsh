Logical: PES
Parent: $Segment
Id: PES
Title: "HL7 v2 PES Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Product Experience Sender"
* 1 0..0 XON "PES-1" "This field contains the name of the organization sending the message. Coded lists of manufacturers such as that from the World Health Organization database might be used in the component of the coded name to identify the source code type. If sent from an individual, this field may not be sent."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1059
* 2 0..0 XCN "PES-2" "This field contains the name of the contact individual. If sent by an organization, the individuals in the organization who serve as primary contact points correspondence regarding this event."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1060
* 3 0..0 XAD "PES-3" "This field contains the postal address of the message sender to which correspondence regarding the experience being reported should be directed."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1062
* 4 0..0 XTN "PES-4" "This field contains the telephone number of the message sender to which telephone communications regarding the experience being reported should be directed. An electronic mail address can be specified in this field."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1063
* 5 0..1 EI "PES-5" "The first component of this field contains the product manufacturer's unique alphanumeric identifier for this specific event. This identifier will be used on all subsequent communications regarding this event. For events reported to the FDA, the identifier is: the FDA assigned manufacturer or distributor number; a hyphen; the 4-digit year; a hyphen; and a consecutive 5-digit sequence number for each report filled by the sender that year. For example, the event identifier for the third event reported in 1996 by a manufacturer whose FDA-assigned registration number is 1234567 would be 1234567-1993-3. Organizations without a FDA-assigned registration number should use 0000000 until assigned a number. Reports from other facilities should use the 10-digit HCFA number left padded with zeros in place of the FDA-assigned registration number. The second through fourth components are defined in exactly the same way as the three components of the hierarchic designator (HD) data type (Section 2.8.18, \"HD - hierarchic designator\")."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1064
* 6 0..1 NM "PES-6" "This field contains sequentially assigned integer values which distinguish messages which share the same sender event identification element. 0 for initial report, 1 for second, and so on."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 6 ^extension[=].extension[0].url = "length"
* 6 ^extension[=].extension[=].valueInteger = "16"
* 6 ^extension[=].extension[+].url = "noTruncate"
* 6 ^extension[=].extension[=].valueInteger = false
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1065
* 7 0..0 FT "PES-7" "This field contains the summary narrative text description of the event that occurred written by the sender, which may include a description of the nature of the event, how the product was involved, any environmental conditions that may have influenced the event, and patient follow-up or required treatment. Note that laboratory results can be encoded as OBX segments rather then including them in the narrative. By representing clinical information in OBX segments rather than in the narrative, these data become much more useful and flexible."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 7 ^extension[=].extension[0].url = "length"
* 7 ^extension[=].extension[=].valueInteger = "600"
* 7 ^extension[=].extension[+].url = "noTruncate"
* 7 ^extension[=].extension[=].valueInteger = false
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1066
* 8 0..1 FT "PES-8" "This field contains the text commentary regarding the report being made, such as disclaimers, which is not necessarily part of the report."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "600"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1067
* 9 0..1 DTM "PES-9" "This field identifies the date the sender became aware of the event."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1068
* 10 1..1 DTM "PES-10" "This field contains the date the message was originally sent to the regulatory agency."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #R
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1069
* 11 0..2 ID "PES-11" "This field contains the timing type of report as required by regulatory agency. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70234[_HL7 Table 0234 - Report Timing_] for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0234 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 11 ^extension[=].extension[0].url = "min"
* 11 ^extension[=].extension[=].valueInteger = 2
* 11 ^extension[=].extension[+].url = "max"
* 11 ^extension[=].extension[=].valueInteger = 3
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1070
* 12 0..1 ID "PES-12" "This field identifies the source from which the sender learned about the event. Multiple sources may be reported by repeating the element."
* 12 from http://terminology.hl7.org/ValueSet/v2-0235 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1071
* 12 ^comment = "If the source of the report is a clinical trial, the CSR and CSP segments can be included to define the study. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70235[_HL7 Table 0235 - Report Source_] for valid values."
* 13 0..0 ID "PES-13" "This field indicates all the entities to whom the entity submitting the report has reported the event. Repeat the element if the report was submitted to more than one entity. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70236[_HL7 Table 0236 - Event reported to_] for valid values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0236 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 13 ^extension[=].extension[0].url = "min"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^extension[=].extension[+].url = "max"
* 13 ^extension[=].extension[=].valueInteger = 1
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1072