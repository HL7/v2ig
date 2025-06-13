Logical: BPX
Parent: $Segment
Id: BPX
Title: "HL7 v2 BPX Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Blood Product Dispense Status"
* 1 1..1 SI "BPX-1" "This field contains the sequence number for the BPX segment under the related BPO segment. For the first blood product dispense status transmitted, the sequence number shall be 1; for the second product dispense status, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1714
* 2 1..1 CWE "BPX-2" "This field indicates the current status of the specified blood product as indicated by the filler or placer. For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it first becomes linked to a patient and is ready to dispense. The placer system may use the Blood Product Dispense Status Message to request the transfusion service to dispense the product. When the blood product is delivered or issued to a patient, the status of the blood product would be changed to indicate that it has now been \"dispensed.\" Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70510[HL7 Table 0510 - Blood Product Dispense Status] in Chapter 2C, Code Tables, for valid entries."
* 2 from http://terminology.hl7.org/ValueSet/v2-0510 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1715
* 3 1..1 ID "BPX-3" "The most commonly used message status values in a BPX will be preliminary and final. A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first cross-matched and a status message is sent, it would be considered preliminary. When the product is dispensed to the patient, that status would also be considered preliminary. However, once the product is transfused, the status would be considered final. The status of a blood product (BPX-2) can continue to change and the previous status should be overwritten until it reaches a final status (BPX-3). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70511[HL7 Table 0511 - BP Observation Status Codes Interpretation] in Chapter 2C, Code Tables, for valid entries."
* 3 from http://terminology.hl7.org/ValueSet/v2-0511 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 3 ^extension[=].extension[0].url = "min"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^extension[=].extension[+].url = "max"
* 3 ^extension[=].extension[=].valueInteger = 1
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1716
* 4 1..1 DTM "BPX-4" "This field indicates the date and time that the status of the blood component was changed. For example, if the blood component had a status, of \"RD\" (Ready to Dispense), the date and time in this field would indicate the date and time that component was made ready to dispense by the filler system."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1717
* 5 0..1 EI "BPX-5" "The Donation ID is the unique identification number assigned to a blood donation. The Donation ID depends upon the bar code labeling system used for the component. There are currently two blood component labeling standards: _ABC CODABAR_ and _ISBT 128_. The preferred labeling system is _ISBT 128_. If using _ISBT 128,_ the Donation ID is an internationally unique identifier consisting of the following 13 characters:"
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1718
* 5 ^comment = "Country Code & Collection Facility - 5 characters\n\nDonation Year - 2 characters\n\nSerial Number - 6 characters\n\nThis field is required for blood components and is not applicable for commercial product messages."
* 6 0..1 CNE "BPX-6" "The Component field includes an identifier and description of the specific blood component. Refer to Table 0577 - BC Component in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0577 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #C
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1719
* 6 ^comment = "The identifier consists of a numeric or alphanumeric product code that represents the type of blood component. The coding system will be determined by the bar code labeling system on the particular component of blood. The preferred coding system is _ISBT 128_.\n\nIf using _ISBT 128_ labeling standard, the product code will consist of an 8-character alphanumeric code, starting with an alpha character and including the component class, donation type/intended use and division indicator.\n\nIf using CODABAR product labeling standard, the product code is a 5-digit number.\n\nThis field is required for blood components and is not applicable for commercial product messages."
* 7 0..1 CNE "BPX-7" "This field indicates the type of donation or collection/intended use. This value is populated from _Table 5 -Type of Donation_ in the _ISBT 128 Application Specification_. The default value is \"0\", meaning \"Not specified.\" Other values indicate whether the blood product (1) is an allogeneic unit from a volunteer donor, (2) is intended for a specific recipient but may be crossed over and used for another recipient, or (3) is an autologous donation intended only for that particular recipient. Refer to Table 0578 - BC Donation Type / Intended Use in Chapter 2C for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0578 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1720
* 7 ^comment = "This field is optional for blood component messages and is not applicable for commercial product messages."
* 8 0..1 CWE "BPX-8" "This field contains the code and/or text to identify a commercial product. Examples of commercial products are blood derivatives such as Rh Immune Globulin and Factor VIII concentrate, Leukoreduction filters, and blood administration sets. Refer to Table 0579 - BP Blood Group in Chapter 2C for valid values."
* 8 from http://terminology.hl7.org/ValueSet/v2-0512 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #C
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1721
* 8 ^comment = "Either code and/or text may be absent. However, the code is always placed in the first component position and any free text in the second component. Thus, a component delimiter must precede free text without a code. Free text can be utilized if no update is to occur. Refer To file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70512[User-Defined Table 0512 - Commercial Product] in Chapter 2C, Code Tables, for suggested values.\n\nThis field is required for commercial blood products and is not applicable for blood component messages."
* 9 0..1 XON "BPX-9" "This field identifies the manufacturer of the commercial product. The manufacturer may be different from the supplier of the commercial product."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #C
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1722
* 9 ^comment = "This field is required for commercial blood products and is not applicable for blood component messages."
* 10 0..1 EI "BPX-10" "This field identifies the lot number for blood derivatives or commercially supplied items used as accessories to transfusion."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #C
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1723
* 10 ^comment = "This field is required for commercial blood products and is not applicable for blood component messages."
* 11 0..1 CNE "BPX-11" "This field indicates the ABO/Rh blood group of the blood component. The preferred values for the blood group are the specified values in _Table 3A - Encodation of ABO/Rh Blood Group_ in the _ISBT 128 Application Specification_. Refer to Table 0579 - BP Blood Group in Chapter 2C for valid values."
* 11 from http://terminology.hl7.org/ValueSet/v2-0579 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1724
* 11 ^comment = "This field is required for blood components and certain commercial products (such as solvent detergent plasma)."
* 12 0..0 CNE "BPX-12" "This is a repeating field to allow multiple entries for special testing that was performed on the blood component. The preferred coding system for Special Testing is defined in the _ISBT 128 Application Specification_. Proposals have been developed and will soon be published by ICCBBA, Inc. for the encodation of other antigen and antibody specificities, including HLA, platelet, red cell and other types of markers. Refer to Table 0580 - BC Special Testing in Chapter 2C for valid values."
* 12 from http://terminology.hl7.org/ValueSet/v2-0580 (required)
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1725
* 12 ^comment = "This field is optional for blood component messages. It is not applicable for non-commercial product messages.\n\nRefer to _Table I3 - Special Testing Codes_ of the _ISBT 128 Application Specification_."
* 13 0..1 DTM "BPX-13" "This field specifies the date and time that the blood product expires. The blood product is no longer considered acceptable once the expiration date has been reached unless cleared by the transfusion service medical staff."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1726
* 13 ^comment = "This field applies to blood components as well as commercial products. There are a few commercial products that have no expiration date. Therefore, the field is not required for those specific products."
* 14 1..1 NM "BPX-14" "This field indicates the number of blood components or commercial products to which this message refers."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #R
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 14 ^extension[=].extension[0].url = "length"
* 14 ^extension[=].extension[=].valueInteger = "5"
* 14 ^extension[=].extension[+].url = "noTruncate"
* 14 ^extension[=].extension[=].valueInteger = false
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1727
* 15 0..1 NM "BPX-15" "This field contains the ordered amount (volume) associated with each quantity of a blood component or commercial product to which this message refers."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 15 ^extension[=].extension[0].url = "length"
* 15 ^extension[=].extension[=].valueInteger = "5"
* 15 ^extension[=].extension[+].url = "noTruncate"
* 15 ^extension[=].extension[=].valueInteger = false
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1728
* 16 0..1 CWE "BPX-16" "This field contains the units of measure for the blood product amount. (See Chapter 7 for more details about reporting units.) This field specifies the units of measure for volume of a blood component (i.e., 50 ml) or the units of measure or dosage of a commercial product (i.e., 910 I.U. - International Units - of Factor VIII Concentrate). Refer to Table 0581 - BP Units in Chapter 2C for valid values."
* 16 from http://terminology.hl7.org/ValueSet/v2-0581 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1729
* 17 0..1 EI "BPX-17" "This field is a unique system-generated number assigned to the blood product to which the message is referring. Each time the status is updated, the new message should replace the previous message if the Blood Product Unique ID is the same. If the Blood Product Unique ID is different, it indicates that the status applies to a different blood product."
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1730
* 17 ^comment = "The sending and receiving systems must agree upon the use of this field."
* 18 0..1 PL "BPX-18" "This field contains the inpatient or outpatient location to which the blood product was actually dispensed. The default value is the current census location for the patient."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1731
* 19 0..1 XAD "BPX-19" "This field contains the actual address of the location to which the blood product was actually dispensed."
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1732
* 20 0..1 XCN "BPX-20" "This is the person who picked up and transported the blood component(s) or commercial product(s). The code for the receiver is as a XCN data type. This field can be free text. In this case, the receiver's name must be the second through fourth components of the field."
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1733
* 21 0..1 XCN "BPX-21" "This field identifies the individual who is dispensing the blood component or commercial product."
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1734
* 22 0..1 ID "BPX-22" "This field reveals the intent of the message. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70206[HL7 Table 0206 - Segment Action Code] for valid values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0206 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 22 ^extension[=].extension[0].url = "min"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^extension[=].extension[+].url = "max"
* 22 ^extension[=].extension[=].valueInteger = 1
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #816
* 22 ^comment = "The action code can only be used when an BPX is uniquely identified sufficiently within the specific implementation using BPX-17 or BPX-6 as agreed to by the trading partners and in accordance with Chapter 2, Section 2.10.4.2."