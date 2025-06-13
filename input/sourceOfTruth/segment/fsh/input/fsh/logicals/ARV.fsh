Logical: ARV
Parent: $Segment
Id: ARV
Title: "HL7 v2 ARV Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Access Restrictions"
* 1 0..1 SI "ARV-1" "This field contains the number that identifies this segment. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2143
* 2 1..1 CNE "ARV-2" "This field contains a code defining the action to be taken for this segment. It allows access restriction information to be sent to delete or update previously sent access restrictions. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2144
* 3 1..1 CWE "ARV-3" "This field specifies the information to which access to sensitive information is restricted by applicable jurisdictional, organizational, patient privacy policy or law. This field is used to identify overarching context, for example specific policy defined data elements or message groups when applicable to ALL groups in the message. For example, under a specific minor’s right to consent for healthcare law coded in ARV-3, all of the minor’s demographic data coded in ARV-4 is sensitive, which may be conveyed in several segments (PID, PD1, PD2)). To a specific element, access may be restricted at the field level by employing the specific HL7 field location in ARV-9. For example, when only some of the demographic data is considered sensitive under a particular minor’s consent coded in ARV-3. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70717[_User-defined Table 0717 – Access Restriction Value_] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0717 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2145
* 3 ^comment = "The intent of this table is to declare the applicable patient consent directive, organizational policy or jurisdicitonal law.\n\nAs examples in the US this could be HIPAA Authorizations for Disclosure, HIPAA Notice of Privacy Practice or 42 CFR Part 2."
* 4 0..0 CWE "ARV-4" "This field is used to convey the reason for the restricted access. Repeat of the Access Restriction Reason is allowed to accommodate communication of multiple reasons for an access restriction. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70719[_User-defined Table 0719 – Access Restriction Reason Code_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0719 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2146
* 5 0..0 ST "ARV-5" "Used to convey specific instructions about the protection of the patient's information which must be rendered to end users in accordance with patient consent directive, organizational policy, or jurisdictional law. For example, in US law 42 CFR Part 2, disclosed information made with patient consent must include a renderable “Prohibition on re-disclosure” warning (§ 2.32[multiblock footnote omitted]) In addition, organizational policy may require that some or all of the ARV field privacy tag values be rendered to end users, e.g., marking a consult note with “Restricted Confidentiality” or with sensitivity tags such as “VIP” or “EMP” for employee of the organization."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "250"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2147
* 5 ^comment = "This field may also be used to specify instructions about the release of information to family and friends (e.g., \"Do not release information to patient's brother, Adam Everyman\"). These instructions may be in conjunction with other fields (as elected by the system)."
* 6 0..1 DR "ARV-6" "This element defines the date from which an access restriction commences until the date it is specifically rescinded."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2148
* 7 1..1 CWE "ARV-7" "This field defines the security classification (as defined by ISO/IEC 2382-8:1998(E/F)/ T-REC-X.812-1995) of an IT resource, in this case the message, which may be used to make access control decisions. Use of this field supports the business requirement for increasing or decreasing the level of confidentiality (classification or declassification) for a given message."
* 7 from http://terminology.hl7.org/ValueSet/v2-0952 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #R
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #3512
* 7 ^comment = "Refer to Externally-defined HL7 Table 0952 – HL7 Confidentiality Classification. Use of this table is recommended. The codes in this table are comprehensive non-overlapping hierarchical codes: Very Restricted > Restricted > Normal > Moderate > Low > Unrestricted. Restrictions to a comprehensive, non-overlapping set of codes is required for purposes of access control system algorithms such as Bell–LaPadula Mode, which is used to adjudicate access requests against privacy policies. See Chapter 2C, Code Tables, for suggested values."
* 8 0..0 CWE "ARV-8" "This field is repeatable and conveys instructions to users and receivers for secure distribution, transmission, and storage; dictates obligations or mandated actions; specifies any action prohibited by refrain policy such as dissemination controls; and stipulates the permissible purpose of use of an IT resource. It is used where MSH-27 or MSH-28, which may be the compliation of all Security Handling Instructions across all labels, are used, but differ from the appliable ones for the data identified in this ARV segment."
* 8 from http://terminology.hl7.org/ValueSet/v2-0953 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #3513
* 8 ^comment = "Refer to Externally-defined Table 0953 – Security Label Handling Instructions in Chapter 2C, Code Tables, for suggested values. – Use of this table is recommended."
* 9 0..0 ERL "ARV-9" "This field is optional and repeating and identifies the location in a message related to the identified access restricted data. If multiple repetitions are present, the listed access restrictions apply to all listed places."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #3514
* 9 ^comment = "*Note:* Realm, business and policy rules will determine to what level the restrictions need to be supported. For example in a lab result exchange setting identifying elements more granular than the result at the segment level (i.e.OBX) is not expected, while in other settings more granular settings may apply."
* 10 0..1 EI "ARV-10" "This field carries the unique identifier for this access restriction and is conditionally required when ARV-2 is NOT valued ‘S’ to support the use of action code for tracking changes when using dynamic mode. This instance identifier is persistent between messages. Implementation guides may restrict what mode to use, which will affect the effective optionality of this field."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2470