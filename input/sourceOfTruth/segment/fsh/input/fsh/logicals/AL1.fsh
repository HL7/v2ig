Logical: AL1
Parent: $Segment
Id: AL1
Title: "HL7 v2 AL1 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Patient Allergy Information"
* 1 1..1 SI "AL1-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #203
* 2 0..1 CWE "AL1-2" "This field indicates a general allergy category (drug, food, pollen, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70127[_User-defined Table 0127 - Allergen Type_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0127 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #204
* 3 0..1 CWE "AL1-3" "This field uniquely identifies a particular allergen. This element may conform to some external, standard coding system (that must be identified), or it may conform to local, largely textual or mnemonic descriptions."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #205
* 4 0..1 CWE "AL1-4" "This field indicates the general severity of the allergy. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70128[_User-defined T__able 0128 - Allergy Severity_] in Chapter 2C, Code Tables, for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0128 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #206
* 5 0..0 ST "AL1-5" "This field identifies the specific allergic reaction that was documented. This element may conform to some external, standard coding system, or it may conform to local, largely textual or mnemonic descriptions (e.g., convulsions, sneeze, rash, etc.)."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "15"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #207
* 6 0..1 BackboneElement "AL1-6" "*The Al-6 field was retained for backward compatibility only as of v 2.4 and has been withdrawn as of v 2.7.* The reader is referred to the _IAM-11 – Onset Date_ or _IAM-13 – Inset Date_ fields for dates when the allergy was identified.."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #W
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #208