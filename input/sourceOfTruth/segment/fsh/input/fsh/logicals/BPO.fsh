Logical: BPO
Parent: $Segment
Id: BPO
Title: "HL7 v2 BPO Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Blood Product Order"
* 1 1..1 SI "BPO-1" "This field contains the sequence number for the BPO segment within the message. For the first order transmitted, the sequence number shall be 1; for the second order, it shall be 2; and so on."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1700
* 2 1..1 CWE "BPO-2" "This field contains the identifier code for the requested blood product. This can be based on local and/or \"universal\" codes. We recommend the \"universal\" procedure identifier. The structure of this CWE data type is described in the control section. The preferred coding system is the _ISBT 128 Product Code._ _Refer to Table 0575 - BP Universal Service Identifier in Chapter 2C for valid values._"
* 2 from http://terminology.hl7.org/ValueSet/v2-0575 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1701
* 2 ^comment = "Blood Product Orders for commercial products, such as Rh Immune Globulin or Factor VIII concentrate, are not at this time defined in an international or national coding system as are blood products. Therefore, locally defined codes can be used for the Universal Service Identifier for commercial products."
* 3 0..0 CWE "BPO-3" "This field contains additional information about the blood component class associated with the Universal Service ID. The placer of the order can specify any required processing of the blood product that must be completed prior to transfusion to the intended recipient. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70508[User-Defined Table 0508 - Blood Product Processing Requirements] in Chapter 2C, Code Tables, for suggested values."
* 3 from http://terminology.hl7.org/ValueSet/v2-0508 (required)
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1702
* 4 1..1 NM "BPO-4" "This field contains the number of blood products ordered."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #R
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "5"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = false
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1703
* 5 0..1 NM "BPO-5" "This field contains the ordered amount (volume) associated with each quantity of blood product."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "5"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1704
* 6 0..1 CWE "BPO-6" "This field contains the units of measure for the blood product amount. (See Chapter 7 for more details about reporting units.) This field specifies the units of measure for volume of a blood component (i.e., 50 ml) or the units of measure or dosage of a commercial product (i.e., 910 I.U. - International Units - of Factor VIII Concentrate). Use of UCUM is strongly recommended as one of the delivered units (could be in addition to the local units). Refer to Table 0576 - BP Units in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0576 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1705
* 7 0..1 DTM "BPO-7" "This field specifies the date/time that the placer intends to use the blood product that is being ordered."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1706
* 7 ^comment = "This is the time when the placer expects the product to be available within the transfusion service. For example, the product should be available for use, but not dispensed, on this date/time."
* 8 0..1 PL "BPO-8" "This field contains the location from which the blood component is to be dispensed."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1707
* 9 0..1 XAD "BPO-9" "This field contains the actual address of the location from which the blood component is to be dispensed."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1708
* 10 0..1 DTM "BPO-10" "This field specifies the date/time that the requested blood products must be ready to dispense. This date/time may be different from the intended use date/time. For example, the patient may be scheduled to come in for a transfusion at a specified time. However, the placer would request that the blood product be ready to dispense prior to that time in order to have the blood component ready for transfusion at the scheduled time. The field may also be used to indicate that the placer is now ready to pick up the ordered blood product and is requesting the blood product be ready to dispense at that time."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1709
* 11 0..1 PL "BPO-11" "This field contains the inpatient or outpatient location to which the blood component is to be dispensed. The default dispense to location is the current census location for the patient."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1710
* 12 0..1 XAD "BPO-12" "This field contains the actual address of the location to which the blood component is to be dispensed. The default dispense to location is the current census location for the patient."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1711
* 13 0..0 CWE "BPO-13" "This is a coded optional field. The value indicates the reason that the blood product was ordered. This information is helpful for prospective review or retrospective studies of blood product ordering practices of the ordering provider by the Quality Assurance Department and/or Transfusion Committee. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70509[User-Defined Table 0509 - Indication for Use] in Chapter 2C, Code Tables, for suggested values."
* 13 from http://terminology.hl7.org/ValueSet/v2-0509 (required)
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1712
* 14 0..1 ID "BPO-14" "BPO-14"
* 14 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 14 ^extension[=].extension[0].url = "min"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^extension[=].extension[+].url = "max"
* 14 ^extension[=].extension[=].valueInteger = 1
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1713
* 14 ^comment = "This field indicates whether consent for the transfusion has been obtained. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[HL7 table 0136 -Yes/No indicator] as defined in Chapter 2C, Code Tables."