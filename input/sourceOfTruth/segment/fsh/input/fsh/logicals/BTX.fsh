Logical: BTX
Parent: $Segment
Id: BTX
Title: "HL7 v2 BTX Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Blood Product Transfusion/Disposition"
* 1 1..1 SI "BTX-1" "This field contains the sequence number for the BTX segment under the related BPO segment. For the first product transfusion/disposition transmitted, the sequence number shall be 1; for the second product transfusion/disposition, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1735
* 2 0..1 EI "BTX-2" "The donation ID is the unique identification number assigned to a blood donation. The Donation ID depends upon the bar code labeling system used for the component. There are currently two blood component labeling standards: _ABC CODABAR_ and _ISBT 128_. The preferred labeling system is _ISBT 128_. If using _ISBT 128,_ the Donation ID is an internationally unique identifier consisting of the following 13 characters:"
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #C
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1736
* 2 ^comment = "Country Code & Collection Facility - 5 characters\n\nDonation Year - 2 characters\n\nSerial Number - 6 characters\n\nThis is required for blood components and is not applicable for commercial product messages."
* 3 0..1 CNE "BTX-3" "The Blood Component field includes an identifier and description of the specific blood component. Refer to Table 0582 - BC Component in Chapter 2C for valid values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0582 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #C
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1737
* 3 ^comment = "The identifier consists of a numeric or alphanumeric product code that represents the type of blood component. The coding system will be determined by the bar code labeling system on the particular component of blood. The preferred coding system is _ISBT 128_.\n\nIf using _ISBT 128_ labeling standard, the product code will consist of an 8-character alphanumeric code, starting with an alpha character and including the component class, donation type/intended use and division indicator.\n\nIf using CODABAR product labeling standard, the product code is a 5-digit number.\n\nThis field is required for blood components and is not applicable for commercial product messages."
* 4 0..1 CNE "BTX-4" "This field indicates the ABO/Rh blood group of the blood component. The preferred values for the blood group are the specified values in _Table 3A - Encodation of ABO/Rh Blood Group_ in the _ISBT 128 Application Specification_. Refer to Table 0583 - BC Blood Group in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0583 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #C
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1738
* 4 ^comment = "This field is required for blood components and certain commercial products (such as solvent detergent plasma)."
* 5 0..1 CWE "BTX-5" "This field contains the code and/or text to identify a commercial product. Examples of commercial products are blood derivatives such as Rh Immune Globulin and Factor VIII concentrate, Leukoreduction filters, and blood administration sets."
* 5 from http://terminology.hl7.org/ValueSet/v2-0512 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1739
* 5 ^comment = "Either code and/or text may be absent. However, the code is always placed in the first component position and any free text in the second component. Thus, free text without a code must be preceded by a component delimiter. Free text can be utilized if no update is to occur. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70512[User-Defined Table 0512 - Commercial Product] in Chapter 2C, Code Tables, for suggested values.\n\nThis field is required for commercial blood products and is not applicable to blood component messages."
* 6 0..1 XON "BTX-6" "This field identifies the manufacturer of the commercial product. The manufacturer may not be the same as the supplier of the commercial product."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1740
* 6 ^comment = "This field is required for commercial blood products and is not applicable for blood component messages."
* 7 0..1 EI "BTX-7" "This field identifies the lot number for blood derivatives or commercially supplied items used as accessories to transfusion."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #C
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1741
* 7 ^comment = "This field is required for commercial blood products and is not applicable for blood component messages."
* 8 1..1 NM "BTX-8" "This field indicates the number of blood components or commercial products to which the message refers."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #R
* 8 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 8 ^extension[=].extension[0].url = "length"
* 8 ^extension[=].extension[=].valueInteger = "5"
* 8 ^extension[=].extension[+].url = "noTruncate"
* 8 ^extension[=].extension[=].valueInteger = false
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1742
* 9 0..1 NM "BTX-9" "This field contains the amount (volume) associated with each blood component or commercial product. When included in this segment, it may be used to indicate the volume of the blood component or product that was actually transfused."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 9 ^extension[=].extension[0].url = "length"
* 9 ^extension[=].extension[=].valueInteger = "5"
* 9 ^extension[=].extension[+].url = "noTruncate"
* 9 ^extension[=].extension[=].valueInteger = false
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1743
* 10 0..1 CWE "BTX-10" "This field contains the units of measure for the blood component or commercial product amount. (See Chapter 7 for more details about reporting units.) This specifies the units of measure for volume of a blood component (i.e., 50 ml) or the units of measure or dosage of a commercial product (i.e., 910 I.U. - International Units - of Factor VIII Concentrate). Refer to Table 0584 - BP Units in Chapter 2C for valid values."
* 10 from http://terminology.hl7.org/ValueSet/v2-0584 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1744
* 11 1..1 CWE "BTX-11" "This field indicates the current status of the specified blood product as indicated by the placer. For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood component may have been entered, but the line was clogged and could not be used, in which case the component must be wasted. A final status would indicate that the product has actually been \"transfused.\" Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70513[HL7 Table 0513 - Blood Product Transfusion/Disposition Status] in Chapter 2C, Code Tables, for suggested values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0513 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1745
* 12 1..1 ID "BTX-12" "The most commonly used message status values in a BTX will be preliminary and final. A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first cross-matched and a status message is sent, it would be considered preliminary. When the product is dispensed to the patient, that status would also be considered preliminary. However, once the product is transfused, the status would be considered final. The status of a blood product (BTX-11) can continue to change and the previous result should be overwritten until it reaches a final status (BTX-12). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70511[HL7 Table 0511 – BP Observation Status Codes Interpretation] in Chapter 2C, Code Tables, for valid entries."
* 12 from http://terminology.hl7.org/ValueSet/v2-0511 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #R
* 12 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 12 ^extension[=].extension[0].url = "min"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^extension[=].extension[+].url = "max"
* 12 ^extension[=].extension[=].valueInteger = 1
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1746
* 13 1..1 DTM "BTX-13" "This field indicates the date and time that the status of the blood component was changed. For example, if the blood component had a status of \"TX\" (Transfused), the date and time in this field would indicate the date and time the component was transfused by the placer system."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #R
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1747
* 14 0..1 XCN "BTX-14" "This field contains the identity of the individual who administers the transfusion of the blood product. If the code is sent as a local code, it should be unique and unambiguous. This field can be free text to permit capture without table update. In this case, the administrator's name must be the second through fourth components of the field."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1748
* 15 0..1 XCN "BTX-15" "This field contains the identity of the individual who assists in the identification of the patient and verification of the product information prior to transfusion of the blood product. If the ID Number is sent as a local code, it should be unique and unambiguous. This field can be free text to permit capture without table update. In this case, the verifier's name must be the second through fourth components of the field."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1749
* 16 0..1 DTM "BTX-16" "This field indicates the date and time that the administrator started the transfusion of the blood component or commercial product."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1750
* 17 0..1 DTM "BTX-17" "This field indicates the date and time that the transfusion of the blood component or commercial product was completed or stopped."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1751
* 18 0..0 CWE "BTX-18" "This field contains the type of adverse reaction that the recipient of the blood product experienced. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70514[User-Defined Table 0514 - Transfusion Adverse Reaction] in Chapter 2C, Code Tables, for suggested values."
* 18 from http://terminology.hl7.org/ValueSet/v2-0514 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1752
* 19 0..1 CWE "BTX-19" "This field contains the reason that the transfusion of the blood product was interrupted. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70515[User-Defined Table 0515 - Transfusion Interrupted Reason] in Chapter 2C, Code Tables, for suggested values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0515 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1753
* 20 0..1 EI "BTX-20" "This field is a unique system-generated number assigned to the blood product to which the message is referring. Each time the status is updated, the new message should replace the previous message if the Blood Product Unique ID is the same. If the Blood Product Unique ID is different, it indicates that the status applies to a different blood product."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #3391
* 21 0..1 ID "BTX-21" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] for valid values."
* 21 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #816
* 21 ^comment = "The action code can only be used when an BTX is uniquely identified sufficiently within the specific implementation using BTX-20 or BTX-3 as agreed to by the trading partners in accordance with Chapter 2, Section 2.10.4.2."