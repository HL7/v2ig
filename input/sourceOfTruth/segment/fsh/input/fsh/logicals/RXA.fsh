Logical: RXA
Parent: $Segment
Id: RXA
Title: "HL7 v2 RXA Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Pharmacy/Treatment Administration"
* 1 1..1 NM "RXA-1" "Use this field if matching this RXA segment to its corresponding RXG segment. If the two applications are not matching RXG and RXA segments, this field's value is zero (0)."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #342
* 2 1..1 NM "RXA-2" "This field starts with 1 the first time that medication/treatment is administered for this order. Increments by one with each additional administration of the medication/treatment."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "4"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #344
* 2 ^comment = "*Note:* More than one RXA segment can be \"matched\" to a single RXG segment, as is the case when recording a change of the rate of administration of an IV solution."
* 3 1..1 DTM "RXA-3" "If the order is for a continuous administration (such as an IV), and the rate is changed at a certain time after the start, an RAS message can be issued to record the change. For such an RAS message, this field records the time the rate was changed to the new value recorded in the _RXA-12-Administered Per (time unit)_ of the same message."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #345
* 4 1..1 DTM "RXA-4" "If null, the date/time of _RXA-3-Date/Time Start of Administration_ is assumed."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #346
* 5 1..1 CWE "RXA-5" "This field contains the identifier of the medical substance/treatment administered. It is equivalent to _OBR-4-universal service ID_ in function. If the substance administered is a vaccine, CVX codes may be used to code this field (see link:#HL70292[_HL7 Table 0292 - Vaccines Administered_]). If CVX code is used to identify vaccines, the coding system component (RXA-5.3) should be valued as \"CVX\", not as \"HL70292.\""
* 5 from http://terminology.hl7.org/ValueSet/v2-0292 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #R
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #347
* 6 1..1 NM "RXA-6" "This field contains the amount administered."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #R
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #348
* 7 0..1 CWE "RXA-7" "This field is conditional because it is required if the administered amount code does not imply units. This field must be in simple units that reflect the actual quantity of the substance administered. It does not include compound units. Refer to Table 0689 - Administered Units in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0689 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #349
* 8 0..1 CWE "RXA-8" "The dosage form indicates the manner in which the medication/treatment is aggregated for dispensing, e.g., tablets, capsules, suppositories. In some cases, this information is implied by the dispense/give code in _RXA-5-Administered Code_. Use this field when the administered code does not specify the dosage form. Refer to Table 0690 - Administered Dosage Form in Chapter 2C for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0690 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #350
* 9 0..0 CWE "RXA-9" "This field contains notes from the provider administering the medication/treatment. If coded, requires a user-defined table. If free text (describing a custom IV, mixture, or salve, for example) place a null in the first component and the text in the second, e.g., |^this is a free text administration note|. Refer to Table 0691 - Administration Notes in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0691 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #351
* 10 0..1 BackboneElement "RXA-10" "RXA-10"
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #W
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #352
* 10 ^comment = "Attention: This field was retained for backward compatibilty only as of v 2.7 and the detail was withdrawn and removed from the standard as of v 2.9. The reader is referred to the PRT segment described in Chapter 7."
* 11 0..1 BackboneElement "RXA-11" "*_This field is retained for backward compatibility only as of v 2.6 and withdrawn from the standard as of v 2.8_*. The reader is referred to RXA-27 and RXA-28._._"
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #W
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #353
* 12 0..1 ST "RXA-12" "This field contains the rate at which this medication/treatment was administered as calculated by using _RXA-6-administered amount_ and _RXA-7-administered units_. This field is conditional because it is required when a treatment is administered continuously at a prescribed rate, e.g., certain IV solutions."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #C
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 12 ^extension[=].extension[0].url = "length"
* 12 ^extension[=].extension[=].valueInteger = "20"
* 12 ^extension[=].extension[+].url = "noTruncate"
* 12 ^extension[=].extension[=].valueInteger = false
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #354
* 13 0..1 NM "RXA-13" "Use when _RXA-5-Administered Code_ does not specify the strength. This is the numeric part of the strength, used in combination with _RXA-14-Administered Strength Units_."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1134
* 14 0..1 CWE "RXA-14" "Use when _RXA-5-Administered Code_ does not specify the strength. This is the unit of the strength, used in combination with _RXA-13-Administered Strength_. Refer to Table 0692 - Administered Strength Units in Chapter 2C for valid values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0692 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1135
* 14 ^comment = "*Note*: These units can be a \"compound quantity;\" i.e., the units may express a quantity per unit of time. For example, micrograms per hour (micg/h) is an acceptable value. These compound units are contained in the ISO+ table. See Chapter 7 for full definition of ISO+ units."
* 15 0..0 ST "RXA-15" "This field contains the lot number of the medical substance administered."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "20"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1129
* 15 ^comment = "*Note:* The lot number is the number printed on the label attached to the container holding the substance and on the packaging which houses the container. If the substance is a vaccine, for example, and a diluent is required, a lot number may appear on the vial containing the diluent; however, any such identifier associated with a diluent is not the identifier of interest. The substance lot number should be reported, not that of the diluent."
* 16 0..0 DTM "RXA-16" "This field contains the expiration date of the medical substance administered."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1130
* 16 ^comment = "*Note:* Vaccine expiration date does not always have a \"day\" component; therefore, such a date may be transmitted as YYYYMM."
* 17 0..0 CWE "RXA-17" "This field contains the manufacturer of the medical substance administered."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1131
* 17 ^comment = "*Note:* For vaccines, code system MVX may be used to code this field. See section _4A.7.1_, \"_Vaccine administration data_.\" This field may be used if the manufacturer of the substance is not identified by the code used in RXA-5- administered code. When using this code system to identify vaccines, the coding system component of the CWE field should be valued as \"MVX\", not as \"HL70227.\""
* 18 0..0 CWE "RXA-18" "This field contains the reason the patient refused the medical substance/treatment. Any entry in the field indicates that the patient did not take the substance. Refer to Table 0693 - Substance/Treatment Refusal Reason in Chapter 2C for valid values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0693 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1136
* 19 0..0 CWE "RXA-19" "This field contains the identifier of the condition or problem for which the drug/treatment was prescribed. May repeat if multiple indications are relevant. Refer to Table 0694 - Indication in Chapter 2C for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0694 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1123
* 20 0..1 ID "RXA-20" "Status of treatment administration event. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70322[_HL7 Table 0322 - Completion Status_] in Chapter 2C, Code Tables, for valid values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0322 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 20 ^extension[=].extension[0].url = "min"
* 20 ^extension[=].extension[=].valueInteger = 2
* 20 ^extension[=].extension[+].url = "max"
* 20 ^extension[=].extension[=].valueInteger = 2
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1223
* 21 0..1 ID "RXA-21" "Status of record. The information in this field enables the use of the RXA in the vaccine messages."
* 21 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1224
* 21 ^comment = "Definition: Status of record. The information in this field enables the use of the RXA in the vaccine messages.\n|===\n|Acknowledgement Choreography | | | |\n|VXU^V04^VXU_V04 | | | |\n|Field name |Field Value: Original mode |Field value: Enhanced mode | |\n|MSH.15 |Blank |NE |NE |AL, SU, ER\n|MSH.16 |Blank |NE |AL, SU, ER |AL, SU, ER\n|Immediate Ack |- |- |- |ACK^V04^ACK\n|Application Ack |ACK^V04^ACK |- |ACK^V04^ACK |ACK^V04^ACK\n|===\n\nVaccine Segments\"), where a method of correcting vaccination information transmitted with incorrect patient identifying information is needed. Refer To file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] in Chapter 2C, Code Tables, for valid values."
* 22 0..1 DTM "RXA-22" "Date/time the administration information was entered into the source system. This field is used to detect instances where treatment administration information is inadvertently entered multiple times by providing a unique identification field. Under usual circumstances, this field would be provided automatically by the computer system rather than being entered by a person."
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1225
* 23 0..1 NM "RXA-23" "RXA-23"
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 23 ^extension[=].extension[0].url = "length"
* 23 ^extension[=].extension[=].valueInteger = "5"
* 23 ^extension[=].extension[+].url = "noTruncate"
* 23 ^extension[=].extension[=].valueInteger = false
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1696
* 23 ^comment = "Description: This numeric field defines the volume measurement in which the drug strength concentration is contained. For example, Acetaminophen 120 MG/5ML Elixir means that 120 MG of the drug is in a solution with a volume of 5 ML , which would be encoded in RXA-13, RXA-14, RXA-23 and RXA-24 as:\n\nRXA|||||||||||||120|mg^^ISO|||||||||5|ml^^ISO ...<cr>"
* 24 0..1 CWE "RXA-24" "RXA-24"
* 24 from http://terminology.hl7.org/ValueSet/v2-0695 (required)
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1697
* 24 ^comment = "Description: This field indicates the volumetric unit associated with _RXA-23 Administered Drug Strength Volume_. See example in RXA-23. Refer to Table 0695 - Administered Drug Strength Volume Units in Chapter 2C for valid values."
* 25 0..1 CWE "RXA-25" "This field contains the pharmacy system's assigned barcode number for the give occurrence. For IV orders, many pharmacy systems generate a barcode number to identify a specific bag/bottle of the order. This number can be an instance identifier; unique for the patient, drug combination, and schedule instance or it may be just a drug identifier. Refer to Table 0696 - Administered Barcode Identifier in Chapter 2C for valid values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0696 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1698
* 25 ^comment = "The composition and use of the barcode number is dependent on application negotiation. An example of this field follows: The barcode number is in the following format, 9XXXXXXX000. The number '9' is a constant, XXXXXXX is seven (7) characters for a unique identifier assigned or derived from the patient account and order ID and 000 is the zero-filled three (3) character IV bottle number.\n\nThe maximum length of the first component of this field is 40 characters to allow for the maximum existing barcode length in use today. The second component contains the description of the item being coded and the third component may define the barcode type.\n\nExample: 12345678901^IV bottle^3X9"
* 26 0..1 ID "RXA-26" "The Pharmacy Order Type field defines the general category of pharmacy order which may be used to determine the processing path the order will take. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70480[_HL7 Table 0480 - Pharmacy Order Types_] in Chapter 2C, Code Tables, for valid values."
* 26 from http://terminology.hl7.org/ValueSet/v2-0480 (required)
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 26 ^extension[=].extension[0].url = "min"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^extension[=].extension[+].url = "max"
* 26 ^extension[=].extension[=].valueInteger = 1
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1699
* 26 ^comment = "This field may also be used for grouping of related orders for processing and/or reports. For example, Medication Administration Records (MARs) often group large volume solutions, medications and small volume solutions differently based upon site-specific workflow.\n\nUsage Rule: This field is optional for all Pharmacy transactions. When not populated, a default value of \"M\" is assumed."
* 27 0..1 PL "RXA-27" "This field specifies the location where the drug or treatment was administered."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #2264
* 28 0..1 XAD "RXA-28" "This field specifies the address of the location where the drug or treatment was administered."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #2265
* 29 0..0 EI "RXA-29" "This field contains an identifier for the individual product instance for the dispense occurrence. This may represent a barcode, RFID or other means of automatically-readable product instance. Repetitions represent the same instance where more than one barcode, RFID or other identification is present."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #3396
* 29 ^comment = "For example, the medication preparer, e.g., a semi-automatic system, can inform the nurse that “for the 8.am administration event, the medication that has been assigned and available at the patient bedside has the barcode BBBBBBBBBBB.” The nurse would scan the barcode, to ensure that the right medication is being administered.\n\nThis differs from _RXA-25 Administered Barcode Identifier_ in that RXA-25 may include other workflow content or the product at various levels of granularity. RXA-29 specifically identifies the product instance."