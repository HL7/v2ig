Logical: FHS
Parent: $Segment
Id: FHS
Title: "HL7 v2 FHS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "File Header"
* 1 1..1 ST "FHS-1" "This field has the same definition as the corresponding field in the MSH segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #67
* 2 1..1 ST "FHS-2" "This field has the same definition as the corresponding field in the MSH segment."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 4
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 5
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #68
* 3 0..1 HD "FHS-3" "This field has the same definition as the corresponding field in the MSH segment."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #69
* 4 0..1 HD "FHS-4" "This field has the same definition as the corresponding field in the MSH segment."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #70
* 5 0..1 HD "FHS-5" "This field has the same definition as the corresponding field in the MSH segment."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #71
* 6 0..1 HD "FHS-6" "This field has the same definition as the corresponding field in the MSH segment."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #72
* 7 0..1 DTM "FHS-7" "This field has the same definition as the corresponding field in the MSH segment."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #73
* 8 0..1 ST "FHS-8" "This field has the same definition as the corresponding field in the MSH segment."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "40"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #74
* 9 0..1 ST "FHS-9" "This field can be used by the application processing file. Its use is not further specified."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "20"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #75
* 10 0..1 ST "FHS-10" "This field contains the free text field, the use of which is not further specified."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 10 ^extension[=].extension[0].url = "length"
* 10 ^extension[=].extension[=].valueInteger = "80"
* 10 ^extension[=].extension[+].url = "noTruncate"
* 10 ^extension[=].extension[=].valueInteger = true
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #76
* 11 0..1 ST "FHS-11" "This field is used to identify a particular file uniquely. It can be echoed back in FHS-12-reference file control ID."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 11 ^extension[=].extension[0].url = "length"
* 11 ^extension[=].extension[=].valueInteger = "20"
* 11 ^extension[=].extension[+].url = "noTruncate"
* 11 ^extension[=].extension[=].valueInteger = false
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #77
* 12 0..1 ST "FHS-12" "This field contains the value of FHS-11-file control ID when this file was originally transmitted. Not present if this file is being transmitted for the first time."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "20"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #78
* 13 0..1 HD "FHS-13" "Identifier of the network location the message was transmitted from. Identified by an OID or text string (e.g., URI). The reader is referred to the \"Report from the Joint W3C/IETF URI Planning Interest Group: Uniform Resource Identifiers (URIs), URLs, and Uniform Resource Names (URNs): Clarifications and Recommendations\".footnote:[The URI is: http://www.ietf.org/rfc/rfc3305.txt. Note: All IETF documents are available online, and RFCs are available through URIs using this format.]"
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2269
* 14 0..1 HD "FHS-14" "Identifier of the network location the message was transmitted to. Identified by an OID or text string. (e.g., URL)."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2270
* 14 ^comment = "This is analogous with the Sending Network Address, however in the receiving role.\n\nThis field SHOULD only be populated when the underlying communication protocol does not support identification receiving network locations."
* 15 0..1 CWE "FHS-15" "This field defines the security classification (as defined by ISO/IEC 2382-8:1998(E/F)/ T-REC-X.812-1995) of an IT resource, in this case the message, which MAY be used to make access control decisions. It is conditionally required when MSH-27 or MSH-28 are used."
* 15 from http://terminology.hl7.org/ValueSet/v2-0952 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #C
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #2429
* 15 ^comment = "Conditionality Predicate: Required if FHS-16 or FHS-17 is valued, or any contained MSH-26 is valued, Optional if neither FHS-16 nor FHS-17 or any contained MSH-26 is valued.\n\nUse of this field supports the business requirement for declaring the level of confidentiality (classification) for a given message.\n\nNote: This field is used to declare the ‘high watermark’, meaning the most restrictive handling that needs to be applied to the message based on its content requiring a certain security classification level and SHOULD be viewed as the v2 equivalent of the document header in CDA, in v3 models, and in FHIR Security Labels on Resources and Bundles. The use of confidentiality codes to classify message content and its inclusion in the high water mark in the header of message content is -described in the Guide to the HL7 Healthcare Privacy and Security Classification System, Release 1, which is platform independent.\n\nRefer to _Externally-defined HL7 Table 0952 – HL7 Confidentiality Code_ in Chapter 2C, Code Tables, for suggested values. Use of this table is recommended. The codes in this table are comprehensive, non-overlapping hierarchical codes: Very Restricted > Restricted > Normal > Moderate > Low > Unrestricted. Restrictions to a comprehensive, non-overlapping set of codes is required for purposes of access control system algorithms such as Bell–LaPadula Mode, which isl used to adjudicate access requests against privacy policies."
* 16 0..0 CWE "FHS-16" "This field is repeatable and conveys instructions to users and receivers for secure distribution, transmission, and storage; dictate obligations or mandated actions; specify any action prohibited by refrain policy such as dissemination controls; and stipulate the permissible purpose of use of an IT resource."
* 16 from http://terminology.hl7.org/ValueSet/v2-0953 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #C
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #2430
* 16 ^comment = "Refer to _HL7 Table 0953 – Security Control_ in Chapter 2C, Code Tables, for suggested values."
* 17 0..0 ST "FHS-17" "Used to convey specific instructions about the protection of the patient's data , which must be rendered to end users in accordance with patient consent directive, organizational policy, or jurisdictional law. For example, in US law 42 CFR Part 2, disclosed information made with patient consent must include a renderable “Prohibition on re-disclosure” warning (§ 2.32[multiblock footnote omitted]) In addition, organizational policy might require that some or all of the ARV field privacy tag values be rendered to end users, e.g., marking a consult note with “Restricted Confidentiality” or with sensitivity tags such as “VIP” or “EMP” for employee of the organization."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #C
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #2431
* 17 ^comment = "This field MAY also be used to specify instructions about the release of information to family and friends (e.g., \"Do not release information to patient's brother, Adam Everyman\"). These instructions MAY be in conjunction with other fields (as elected by the system)."