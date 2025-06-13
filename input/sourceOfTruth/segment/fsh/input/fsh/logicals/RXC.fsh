Logical: RXC
Parent: $Segment
Id: RXC
Title: "HL7 v2 RXC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Component Order"
* 1 1..1 ID "RXC-1" "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70166[_HL7 Table 0166 – RX Component Type_] in Chapter 2C, Code Tables for valide values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0166 (required)
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #313
* 1 ^comment = "For the non-IV case, the \"B\" value may still apply. For example, if a custom dermatologic salve is being prepared, the \"B\" item might be a standard base ointment into which other components are mixed.\n\nThe amount of the \"base\" specified in the \"B\" segment(s) is defined to be the quantity into which amounts specified in the \"A\" components are mixed. Thus the RXC segments as a group define the \"recipe\" for a particular amount (defined by the base segment(s)). The give amount, as defined in the RXO, does not need to correspond to this base amount. For example, the RXC segments may specify a recipe for a liter of a standard type of saline with 1 gram of a particular antimicrobial, while the give amount (from the RXO) may specify the administration of 2 liters of this IV-solution every 24 hours.\n\nThe amount specified in each \"A\" segment is defined to be the quantity to be added to the amount of the base as specified in its RXC segment.\n\nIf any \"base\" components are present then these should be transmitted first. The first \"base\" component in the transmission should be considered the \"primary base\" if such a distinction is necessary. Similarly, the first \"additive\" in the transmission should be considered the \"primary additive\" if such a distinction is necessary."
* 2 1..1 CWE "RXC-2" "This field is equivalent to _OBR-4-universal service ID_. It defines the base or component in the same manner as the give and dispense codes. As with the give and dispense codes, it may contain text only, code only, text + code, or text + code + units (implied or explicit). As with the give and dispense codes, if _RXC-4-component units_ is present, this overrides the units implied by the code. If only text is present, the pharmacy or treatment application must include a manual review or reentering of the component drug or treatment. Refer to Table 0697 - Component Code in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0697 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #314
* 3 1..1 NM "RXC-3" "This field identifies the amount of this component to be added to the specified amount of the base."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #315
* 4 1..1 CWE "RXC-4" "This field identifies the units for the component amount. If present, this overrides the units implied by _RXC-2-component code_. This must be in simple units that reflect the actual quantity of the component being added. It does not include compound units. Refer to Table 0698 - Component Units in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0698 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #316
* 5 0..1 NM "RXC-5" "Use when _RXC-2-component code_ does not specify the strength. This is the numeric part of the strength, used in combination with _RXC-6-component strength units._"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1124
* 6 0..1 CWE "RXC-6" "Use when _RXC-2-component code_ does not specify the strength. This is the unit of the strength, used in combination with _RXC-5-component strength_. Refer to Table 0699 - Component Strength Units in Chapter 2C for valid values.*Note:* These units can be a \"compound quantity;\" i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 6 from http://terminology.hl7.org/ValueSet/v2-0699 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1125
* 7 0..0 CWE "RXC-7" "This field accommodates the identification of any codes that might be associated with the pharmaceutical or other treatment substance. Common codes include: the Generic Product Identifier (GPI), Generic Code Number_Sequence Number (GCN_SEQNO), National Drug Code (NDC)_._ _Refer to Table 0700 - Supplementary Code in Chapter 2C for valid values._"
* 7 from http://terminology.hl7.org/ValueSet/v2-0700 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1476
* 8 0..1 NM "RXC-8" "This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5, which would be encoded in RXC-5, RXC-6, RXC-8 and RXC-9 as"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "5"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = true
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1671
* 8 ^comment = "RXC|||||120|mg^^ISO||5|ml^^ISO ...<cr>"
* 9 0..1 CWE "RXC-9" "This field indicates the volumetric unit associated with _RXC-8 Component Drug Strength Volume_. See example in RXC-8. Refer to Table 0701 - Component Drug Strength Volume Units in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0701 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1672
* 10 0..1 NM "RXC-10" "This field contains the amount to be dispensed as encoded by the pharmacy or treatment supplier."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #3314
* 11 0..1 CWE "RXC-11" "This field contains the units for the dispense amount as encoded by the pharmacy or treatment supplier. This field is required if the units are not implied by the actual dispense code. This must be in simple units that reflect the actual quantity of the substance dispensed. It does not include compound units. Refer to Table 0703 - Dispense Units in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0703 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #C
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #3315