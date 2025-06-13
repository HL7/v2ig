Logical: RQD
Parent: $Segment
Id: RQD
Title: "HL7 v2 RQD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:33Z"
* . ^short = "Requisition Detail"
* 1 0..1 SI "RQD-1" "This field contains the number that identifies this line in the requisition."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #275
* 2 0..1 CWE "RQD-2" "This field contains the identifier and description that uniquely identify the item on the application sending the requisition. This field is conditional because at least one of the three fields – RQD-2-item code- internal__,__ RQD-3-item code-external, or RQD-4-hospital item code – must be valued. Refer to Table 0684 - Item Code - Internal in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0684 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #276
* 3 0..1 CWE "RQD-3" "This field contains the identifier and description that uniquely identify the item on the application receiving the requisition. This field is conditional because at least one of the three fields – RQD-2-item code-internal, RQD-3-item code-external or RQD-4-hospital item code – must be valued. Refer to Table 0685 - Item Code - External in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0685 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #277
* 4 0..1 CWE "RQD-4" "This field contains the identifier and description that uniquely identify the item on all applications in the hospital. The identifier is usually controlled by the hospital financial application in the charge description master file. This field is conditional because at least one of the three fields – RQD-2-item code-internal, RQD-3-item code-external or RQD-4-hospital item code _--_ must be valued. Refer to Table 0686 - Hospital Item Code in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0686 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #278
* 4 ^comment = "*Note:* At least one of the three fields 4.11.1.2 through 4.11.1.4 must be non-null."
* 5 0..1 NM "RQD-5" "This field contains the quantity requisitioned for this item."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "6"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #279
* 6 0..1 CWE "RQD-6" "This field contains the unit of measure for this item. Refer to Table 0687 - Requisition Unit of Measure in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0687 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #280
* 7 0..1 CX "RQD-7" "This field contains the general ledger cost center account number associated with a department that may issue or charge for this item. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70319[HL7 Table 0319 – Department Cost Center] in Chapter 2C, Code Tables, for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0319 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #281
* 8 0..1 CWE "RQD-8" "This field contains the accounting code that identifies this item in order to charge for this item. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70320[User-Defined Table 0320 - Item Natural Account Code] in Chapter 2C, Code Tables, is used as the HL7 identifier for the user-defined table of values for this field."
* 8 from http://terminology.hl7.org/ValueSet/v2-0320 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #282
* 9 0..1 CWE "RQD-9" "This field contains the unique identifier and descriptive name of the department/location where the item should be delivered. Refer to Table 0688 - Deliver To ID in Chapter 2C for valid values."
* 9 from http://terminology.hl7.org/ValueSet/v2-0688 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #283
* 10 0..1 DT "RQD-10" "This field contains the date this item is required."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #284
* 10 ^comment = "*Note:* Although none of the fields are required, one of the three identifying codes—RQD-2-item code-internal, RQD-3-item code-external, or RQD-4-hospital item code—must be specified in order for the receiving application to process the request.\n\nIt is left to the vendors to determine which will be used as the common link between the two applications. HL7 recommends using the RQD-4-Hospital Item Code.\n\nHospital accounting requires an identifier to charge a particular cost center or patient for a requisitioned supply. If the supply is for a patient, then this identifier comes from the PID segment; otherwise, from RQD-7-Dept. Cost Center and RQD-8-Item Natural Account Code must be used. It is recommended that the \"final\" cost center responsible for providing the supply to the patient be included, even when the patient ID is provided.\n\nHospital accounting applications use RQD-7-Dept. Cost Center concatenated with RQD-8-Item Natural Account Code in order to post this transaction to the General Ledger. This concatenated value should correspond to a valid entry in the accounting applications \"Chart of Accounts.\""