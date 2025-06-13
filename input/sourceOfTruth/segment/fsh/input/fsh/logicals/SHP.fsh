Logical: SHP
Parent: $Segment
Id: SHP
Title: "HL7 v2 SHP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:36Z"
* . ^short = "Shipment"
* 1 1..1 EI "SHP-1" "The shipment id is the identifier assigned by the shipment transportation provider that uniquely identifies this shipment from all other shipments by the same provider. The addressee for the shipment should be able to use this identifier to match a physical shipment with the electronic manifest for the shipment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #2317
* 2 0..0 EI "SHP-2" "The internal shipment id is an identifier assigned to the shipment by the sender or addressee of the shipment. The field repeats allowing multiple identifiers to be transmitted."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #2318
* 3 0..1 CWE "SHP-3" "The shipment status specifies where in the shipment process the package is at the time of messaging. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70905[_HL7 Table 0905 – Shipment Status_] for specific values:"
* 3 from http://terminology.hl7.org/ValueSet/v2-0905 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #2319
* 4 1..1 DTM "SHP-4" "The shipment status date/time carries the date and time the status in _SHP-3 Shipment Status_ occurred."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #2320
* 5 0..1 TX "SHP-5" "The shipment status reason is used to document the reason for the status in _SHP-3 Shipment Status_. This reason field is of particular importance when a shipment is rejected."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #2321
* 6 0..1 CWE "SHP-6" "The shipment priority documents the priority the shipment has been given by the sender. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70906[_HL7 Table 0906 - ActPriority_] for specific values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0906 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #2322
* 7 0..0 CWE "SHP-7" "The shipment confidentiality documents any confidentiality that may be associated with this particular shipment. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70907[_HL7 Table 0907 – Confidentiality_] for specific values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0907 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #2323
* 8 0..1 NM "SHP-8" "The number of packages in shipment field documents the total number of separate packages that are contained in the shipment. This total should not include packages that are nested inside of one another. For instance if a shipment consisted of 3 separate boxes, this field would contain the value"
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "4"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #2324
* 8 ^comment = "\"…|3|…\"."
* 9 0..0 CWE "SHP-9" "The shipment condition field allows the receiver of the shipment to document the condition of the shipment when it was received. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70544[_HL7 Table 0544 – Container Condition_] for suggested values. Many of the values found in Table 0544 are associated with values found in Table 0376 (Special Handling Codes). Values from Table 0376 have had an X placed in front of them, and the meaning of the code has been changed to indicate that the type of handling has failed during shipment. For instance if a handling code indicated that the shipment was to be kept at body temperature (C37), and the shipment arrived at some other temperature, the XC37 condition code would be used to indicate the shipment arrived with a temperature outside the range indicated by the handling code."
* 9 from http://terminology.hl7.org/ValueSet/v2-0544 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #2325
* 10 0..0 CWE "SHP-10" "This describes how the shipment needs to be handled during transport. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70376[_User-defined Table 0376 – Special Handling Code_] for suggested values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0376 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2326
* 11 0..0 CWE "SHP-11" "This field contains any known or suspected hazards associated with this shipment, e.g., exceptionally infectious agent or blood from a hepatitis patient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70489[_User-defined Table 0489 – Risk Codes_] for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0489 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2327
* 12 0..1 ID "SHP-12" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[_HL7 Table 0206 - Segment Action Code_] for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #816
* 12 ^comment = "The action code can only be used when SHP-1 is valued in accordance with the guidance in Chapter 2, Section 2.10.4.2."