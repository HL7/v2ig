Logical: PRD
Parent: $Segment
Id: PRD
Title: "HL7 v2 PRD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "provider data"
* 1 1..0 CWE "PRD-1" "This field contains the contact role that defines the relationship of the person or organization described in this segment to the patient being referred. When a referral is inter-enterprise in nature, there are several important relationships that must be identified. For example, the proper identification of both the referring and the referred-to provider is critical for proper processing of a referral. In addition, some enterprises may want information regarding a consulting provider or the identity of the person who actually prepared the referral. This contact role may also expand to represent affiliated persons to whom information regarding this referral must be forwarded or copied. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70286[_User-defined Table 0286 - Provider Role_] for suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0286 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1155
* 2 0..0 XPN "PRD-2" "This field contains the name of the provider identified in this segment. Generally, this field will describe a physician associated with the referral. However, it is not limited to physicians. If the provider is an organization then _PRD-10 – Provider Organization Name and Identifier_ will be used. This field may contain the name of any valid healthcare provider associated with this referral. If this Provider Name is a physician's name, you may refer to _PRD-7-Provider identifiers_ for the physician identifier."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1156
* 3 0..0 XAD "PRD-3" "This field contains the mailing address of the provider identified in this segment. One of the key components to completing the \"circle of care\" and provider/institution bonding is the issuance of follow‑up correspondence to the referring provider."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1157
* 4 0..1 PL "PRD-4" "This field contains the location of the provider as needed when a provider that may be external to a given enterprise must be referenced. For example, if this provider represented the referred-to physician, the _PRD-4-Provider location_ should identify the clinic of the physician or provider to whom this referral has been sent. An application and facility identifier carried in the facility field specifies the identification of the provider's location. The application ID and facility ID would be used in the same manner as their corresponding fields in the MSH segment (_MSH-3-Sending application, MSH-5-Receiving application,_ _MSH-4-Sending facility, MSH-6-Receiving facility_). That is, the facility field will contain an application identifier and facility identifier which describe the location of this provider. However, it should be noted that they may describe a different location because the provider location being referenced in this field _may not be_ the location from which the message originated, which is being described by the MSH."
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1158
* 5 0..0 XTN "PRD-5" "This field contains information, such as the phone number or electronic mail address, used to communicate with the provider or organization."
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1159
* 6 0..1 CWE "PRD-6" "This field contains the preferred method to use when communicating with the provider. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70185[_User-defined Table 0185 - Preferred Method of Contact_] in Chapter 2C, \"Code Tables\", for suggested values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0185 (required)
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #684
* 7 0..0 PLN "PRD-7" "This repeating field contains the provider's unique identifiers such as UPIN, Medicare and Medicaid numbers. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70338[_User-defined Table 0338 - Practitioner ID Number Type_] (in Chapter 2C, \"Code Tables\") for suggested values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0338 (required)
* 7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension.valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1162
* 8 0..1 DTM "PRD-8" "This field contains the date that the role of the provider effectively began. For example, this date may represent the date on which a physician was assigned as a patient's primary care provider."
* 8 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension.valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1163
* 9 0..0 DTM "PRD-9" "This field contains the date that the role of the provider effectively ended. For example, this date may represent the date that a physician was removed as a patient's primary care provider."
* 9 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension.valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1164
* 9 ^comment = "*Note:* The _PRD-8-Effective Start Date of Role_ and _PRD-9-Effective End Date of Role_ fields should _not_ be used as trigger events. For example, they should not be used to trigger a change in role. These two dates are for informational purposes only."
* 10 0..1 XON "PRD-10" "This field contains the name of the provider where the provider is an organization."
* 10 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension.valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #2256
* 11 0..0 XAD "PRD-11" "This field contains the address of the provider if it is an organization."
* 11 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension.valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #2257
* 12 0..0 PL "PRD-12" "This field contains the location details of the provider if it is an organization."
* 12 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension.valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #2258
* 13 0..0 XTN "PRD-13" "This field contains information, such as the phone number or electronic mail address, used to communicate with the provider if it is an organization."
* 13 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension.valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #2259
* 14 0..1 CWE "PRD-14" "This field contains the preferred method to use when communicating with the provider if provider is an organization. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70185[_User-defined Table 0185 - Preferred Method of Contact_] in Chapter 2C, \"Code Tables\", for suggested values."
* 14 from http://terminology.hl7.org/ValueSet/v2-0185 (required)
* 14 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension.valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #2260