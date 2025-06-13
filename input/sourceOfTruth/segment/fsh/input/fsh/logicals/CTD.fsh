Logical: CTD
Parent: $Segment
Id: CTD
Title: "HL7 v2 CTD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Contact Data"
* 1 1..0 CWE "CTD-1" "This field contains the contact role that defines the relationship of the person described in this segment to the patient being referred. When a referral is inter-enterprise in nature, there are some important relationships that must be identified. For example, it may be necessary to identify the contact representative at the clinic that sent the referral. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70131[_User-defined Table 0131 - Contact Role_] (in Chapter 3, \"Patient Administration\")is used as the HL7 identifier for the user-defined table of values for this field."
* 1 from http://terminology.hl7.org/ValueSet/v2-0131 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #196
* 2 0..0 XPN "CTD-2" "This field contains the name of the contact person identified in this segment. Generally, this field will describe a person or provider associated with the referral. If this contact name is a physician, you may refer to the _CTD-7-Contact identifiers_ (section ) for the physician identifier."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1165
* 3 0..0 XAD "CTD-3" "This field contains the mailing address of the contact person identified in this segment. One of the key components for completing the \"circle of care\" and provider/institution bonding is the issuance of follow‑up correspondence to the referring provider."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1166
* 4 0..1 PL "CTD-4" "This field contains the location of the contact, which is required when a contact that may be external to a given enterprise must be referenced. For example, if this contact represents the office manager of the referred-to physician, then the contact location should identify the clinic of the physician or provider to whom this referral has been sent. An application and facility identifier carried in the facility field specifies the identification of the contact's location. The application identifier and the facility identifier would be used in the same manner as their corresponding fields in the MSH segment (_MSH-3-Sending application, MSH-5-Receiving application, MSH-4-Sending facility, MSH-6-Receiving facility_). That is, the facility field will contain an application identifier and facility identifier which describe the location of this contact. However, it should be noted that they may describe a different location because the contact location being referenced in this field _may not be_ the location from which the message originated, which is being described by the MSH."
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1167
* 5 0..0 XTN "CTD-5" "This field contains the information, such as the phone number or electronic mail address, used to communicate with the contact person or organization."
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1168
* 6 0..1 CWE "CTD-6" "This field contains the preferred method to use when communicating with the contact person. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70185[_User-defined Table 0185 - Preferred Method of Contact_] in Chapter 2C, \"Code Tables\", for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0185 (required)
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #684
* 7 0..0 PLN "CTD-7" "This repeating field contains the contact's unique identifiers such as UPIN, Medicare and Medicaid numbers. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70338[User-defined Table 0338 - Practitioner ID Number Type]_ (see Chapter 2, \"Code Tables\") for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0338 (required)
* 7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension.valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1171