Logical: IAM
Parent: $Segment
Id: IAM
Title: "HL7 v2 IAM Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Patient Adverse Reaction Information"
* 1 1..1 SI "IAM-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one, for the second occurrence, the sequence number shall be two, etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1612
* 2 0..1 CWE "IAM-2" "This field indicates a general allergy category (drug, food, pollen, etc.). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70127[_User-d__efined Table 0127 - Allerg__en Type_] in Chapter 2C, Code Tables, for suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0127 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #204
* 3 1..1 CWE "IAM-3" "This field uniquely identifies a particular allergen. This element may conform to some external, standard coding system (that must be identified), or it may conform to local, largely textual or mnemonic descriptions."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #205
* 3 ^comment = "If a system maintains allergen codes as its unique identifier for a particular allergy, and two systems have agreed to process the IAM using update mode, then this field can be used as the unique identifier instead of _IAM-8 - Allergy Unique Identifier_. This does not preclude using allergen codes for unique identifiers for snapshot processing."
* 4 0..1 CWE "IAM-4" "This field indicates the general severity of the allergy. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70128[_User-defined Table 0128 - Allergy Severity Code_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0128 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #206
* 5 0..0 ST "IAM-5" "This field identifies the specific allergic reaction that was documented. This element may conform to some external, standard coding system, or it may conform to local, largely textual or mnemonic descriptions (e.g., convulsions, sneeze, rash, etc.)."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "15"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #207
* 6 1..1 CNE "IAM-6" "This field contains a code defining the status of the record. It allows allergy messages to be sent to delete or update previously sent allergy messages. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 6 ^extension[=].extension[0].url = "min"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^extension[=].extension[+].url = "max"
* 6 ^extension[=].extension[=].valueInteger = 1
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1551
* 7 0..1 EI "IAM-7" "This field contains a value that uniquely identifies a single allergy for a person."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1552
* 7 ^comment = "This field is conditionally required. The surrogate field to use is _IAM-3 - Allergen Code/Mnemonic/Description_ if that field can uniquely identify the allergy on the receiving system."
* 8 0..1 ST "IAM-8" "This field contains the reason for the action indicated in the _IAM-6 - Allergy Action Code_ field."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "60"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1553
* 9 0..1 CWE "IAM-9" "This field contains the reason why the patient should not be exposed to a substance. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70436[_User-defined Table 0436 - Sensitivity to Causative Agent Code_] in Chapter 2C, Code Tables, for suggested values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0436 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1554
* 10 0..1 CWE "IAM-10" "This field contains the code, mnemonic, or description used to uniquely identify an allergen group when both a detailed allergy (_IAM-3 - Allergen Code/Mnemonic/Description_) and group level (_IAM-10 - Allergen Group Code/Mnemonic/Description_) need to be communicated. In cases where systems want to communicate both a specific drug allergy and the group of drugs to which the specific drug belongs (i.e., Bactrim and Sulfa drugs; Ceclor and Penicillins/Cephalosporins) then the specific drug allergy is sent in _IAM-3 - Allergen Code/Mnemonic/Description_ and the group level is sent in _IAM-10 - Allergen Group Code/Mnemonic/Description_. However, if only a group level is being communicated, then it can be sent in IAM-3 as the primary identifier of the allergy."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1555
* 11 0..1 DT "IAM-11" "This field contains the actual date of the first reaction."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1556
* 12 0..1 ST "IAM-12" "This field contains a text description of the time period of the first reaction when an exact date is not known (e.g., adolescence, childhood, spring 1990)."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "60"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1557
* 13 0..1 DTM "IAM-13" "This field contains the date/time the allergy was reported to a caregiver."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1558
* 14 0..1 XPN "IAM-14" "This field contains the name of the person reporting the allergy to a caregiver at the time reported in _IAM-14 - Reported Date/Time_."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1559
* 15 0..1 CWE "IAM-15" "This field contains the personal relationship that the person reporting the allergy has to the patient. It uses the same table as that used by NK1-3. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70063[_User-defined Table 0063 - Relationship_] in Chapter 2C, Code Tables, for suggested values. Examples include: brother, sister, mother, father, friend, spouse, etc."
* 15 from http://terminology.hl7.org/ValueSet/v2-0063 (required)
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1560
* 16 0..1 CWE "IAM-16" "This field describes any type of allergy alert device the patient may be carrying or wearing. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70437[_User-defined Table 0437 - Alert Device_] in Chapter 2C, Code Tables, for suggested values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0437 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1561
* 17 0..1 CWE "IAM-17" "This field indicates the verification status for the allergy. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70438[_User-defined Table 0438 - Allergy Clinical Status_] in Chapter 2C, Code Tables, for suggested values."
* 17 from http://terminology.hl7.org/ValueSet/v2-0438 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1562
* 18 0..1 XCN "IAM-18" "This field identifies the provider who assigned the clinical status to the allergy (e.g., ...| S12345^EVERYMAN^ADAM^J^III^DR^MD|...)."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1563
* 19 0..1 XON "IAM-19" "This field contains the name of the organization providing the update to the allergy (e.g., Good Health Hospital)."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1564
* 20 0..1 DTM "IAM-20" "The date and time that this allergy was last statused by the _IAM-18 - Statused by Person_ in the _IAM-19 - Statused by Organization_."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1565
* 21 0..1 XCN "IAM-21" "This field identifies the user that inactivated the record entry about the patient’s allergy"
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #2294
* 21 ^comment = "(e.g. ...| S12345^Smith^John^J^III^DR^MD|...)."
* 22 0..1 DTM "IAM-22" "The date and time that this allergy was inactivated by the _IAM-21 Inactivated by Person_."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #2295
* 23 0..1 XCN "IAM-23" "This field identifies the user that created the entry in the record stating the allergy (e.g. ...| S12345^Smith^John^J^III^DR^MD|...)."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #2296
* 24 0..1 DTM "IAM-24" "The date and time that this allergy entry was created by the _IAM-23 Created by Person_."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #2297
* 25 0..1 XCN "IAM-25" "This field identifies the user that modified the allergy (e.g. ...|S12345^Smith^John^J^III^DR^MD|...)."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #2298
* 26 0..1 DTM "IAM-26" "The date and time that this allergy was modified by the _IAM-25 Modified by Person_."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #2299
* 27 0..1 CWE "IAM-27" "This field identifies the clinician entered description associated to a particular allergen. This element may conform to some external, standard coding system (that must be identified), or it may conform to local, largely textual or mnemonic descriptions."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2300
* 28 0..1 XON "IAM-28" "This field contains the name of the organization that initially recorded the allergy (e.g., a General Hospital)."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #3293
* 29 0..1 XON "IAM-29" "This field contains the name of the organization that modified the allergy (e.g., a General Hospital)."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #3294
* 30 0..1 XON "IAM-30" "This field contains the name of the organization that inactivated the allergy (e.g., a General Hospital)."
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #3295