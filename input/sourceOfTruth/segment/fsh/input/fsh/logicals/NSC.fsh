Logical: NSC
Parent: $Segment
Id: NSC
Title: "HL7 v2 NSC Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Application Status Change"
* 1 1..1 CWE "NSC-1" "This field contains the type of change being requested (if NMR query) or announced (if NMD unsolicited update). Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70409[_User-Defined Table 0409 - Application Change Type_] in Chapter 2C, Code Tables, for suggested values. It is assumed that \"new\" version starts up with no loss or duplication of data as old one is shutting down (if possible)."
* 1 from http://terminology.hl7.org/ValueSet/v2-0409 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1188
* 2 0..1 ST "NSC-2" "This field contains a site-specific name for the current CPU."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1189
* 3 0..1 ST "NSC-3" "This field contains a site‑specific name for the current fileserver or file system used by this application."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1190
* 4 0..1 HD "NSC-4" "This field contains a site-specific name used to identify the \"current\" application process for interfacing with lower level protocols. To be used in conjunction with the sending/receiving system and facility values in the MSH. Entirely site-defined. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70361[_User-defined Table 0361-Sending/Receiving Application_] is used as the user-defined table of values for the first component."
* 4 from http://terminology.hl7.org/ValueSet/v2-0361 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1191
* 4 ^comment = "*Note:* By site agreement, implementors may continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first component."
* 5 0..1 HD "NSC-5" "This field contains a site-specific name for the current facility used by this application. To be used in conjunction with the values for the sending/receiving system and facility values in the MSH. This field further describes the current application, _NSC-5 Current Application_. With the promotion of this field to an HD data type, the usage has been broadened to include not just the current facility but other organizational entities, such as: a) the organizational entity responsible for current application; b) the responsible unit; c) a product or vendor's identifier, etc. Entirely site‑defined. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70362[_User-defined Table 0362 – Sending/Receiving Facility_] is used as the HL7 identifier for the user-defined table of values for the first component."
* 5 from http://terminology.hl7.org/ValueSet/v2-0362 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1192
* 5 ^comment = "*Note:* By site agreement, implementors may continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first component."
* 6 0..1 ST "NSC-6" "This field contains a site-specific name for the new CPU."
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1193
* 7 0..1 ST "NSC-7" "This field contains a site-specific name for the new fileserver or file system used by this application."
* 7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension.valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1194
* 8 0..1 HD "NSC-8" "This field contains a site-specific name used to identify \"new\" application processes for interfacing with lower level protocols. To be used in conjunction with the sending/receiving system and facility values in the MSH. Entirely site-defined. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70361[_User-defined Table 0361-Sending/Receiving Application_] is used as the user-defined table of values for the first component."
* 8 from http://terminology.hl7.org/ValueSet/v2-0361 (required)
* 8 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension.valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1195
* 8 ^comment = "*Note:* By site agreement, implementors may continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first component."
* 9 0..1 HD "NSC-9" "This field contains a site-specific name for the new facility used by this application. To be used in conjunction with the values for the sending/receiving system and facility values in the MSH."
* 9 from http://terminology.hl7.org/ValueSet/v2-0362 (required)
* 9 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension.valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1196
* 9 ^comment = "This field further describes the new application, _NSC-8 New Application_. With the promotion of this field to an HD data type, the usage has been broadened to include not just the new facility but other organizational entities, such as: a) the organizational entity responsible for new application; b) the responsible unit; c) a product or vendor's identifier, etc. Entirely site‑defined. file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70362[_User-defined Table 0362 – Sending/Receiving Facility_] is used as the HL7 identifier for the user-defined table of values for the first component.\n\n*Note:* By site agreement, implementors may continue to use file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first component."