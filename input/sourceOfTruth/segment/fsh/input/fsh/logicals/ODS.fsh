Logical: ODS
Parent: $Segment
Id: ODS
Title: "HL7 v2 ODS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "dietary orders, supplements, and preferences"
* 1 1..1 ID "ODS-1" "This field specifies type of diet. Refer To file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70159[HL7 Table 0159 - Diet Code Specification Type] in Chapter 2C, Code Tables, for valid entries."
* 1 from http://terminology.hl7.org/ValueSet/v2-0159 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #269
* 2 0..10 CWE "ODS-2" "When blank, the modifier applies to all service periods. Diet orders, for example, typically apply to all service periods. This field usually specifies supplements. This field allows you to designate a modification for one or more of the service periods during a day by combining service specifications as needed. The service periods will be local CEs, normally numbers. Suggested are:"
* 2 from http://terminology.hl7.org/ValueSet/v2-0627 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #270
* 2 ^comment = "Definition: When blank, the modifier applies to all service periods. Diet orders, for example, typically apply to all service periods. This field usually specifies supplements. This field allows you to designate a modification for one or more of the service periods during a day by combining service specifications as needed. The service periods will be local CEs, normally numbers. Suggested are:\n|===\n|service 1 |is |breakfast\n|service 2 |is |mid-morning snack\n|service 3 |is |lunch\n|service 4 |is |mid-afternoon snack\n|service 5 |is |dinner\n|service 6 |is |bedtime snack\n|===\n\nEx: |1~5| means service 1 and service 5, whatever these are locally defined to be.\n\nRefer to Table 0627 - Service Period in Chapter 2C for valid values."
* 3 1..20 CWE "ODS-3" "This field is the identifier of the ordered item for a patient; it is equivalent to OBR-4-universal service ID in function. Since ODS is a repeating segment, multiple entities get multiple segments. Refer to Table 0628 - Diet, Supplement, or Preference Code in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0628 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #271
* 3 ^comment = "Example:\n\n|^REG|, |023^^99FD6|, |^NOLACT|, |^TUBEFD|, and |011^HIPRO100^99FD1~123^LOFAT20^99FD1|\n\nIn the case where this segment requests a diet supplement, i.e., ODS-1-type = S, this attribute specifies a particular item or class of items. If institutional codes for patient food preferences (P) have been codified, they are also expressed as coded segments; otherwise, the information is passed as a text string in the fourth component of the ODS segment, described below."
* 4 0..2 ST "ODS-4" "This field defines the specific instructions for dietary. These instructions may address specific patient needs, such as isolation. This field provides the ordering provider's dietary instructions as free text. It can represent the full dietary instruction or indicate supplemental information."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "80"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = true
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #272