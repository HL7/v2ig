Logical: CER
Parent: $Segment
Id: CER
Title: "HL7 v2 CER Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Certificate Detail"
* 1 1..1 SI "CER-1" "This field contains the number that identifies this transaction. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1856
* 2 0..1 ST "CER-2" "The serial number uniquely identifies the attribute certificate within the scope of its issuer. This field contains the number and/or characters that identify the certificate held by the health professional."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "80"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1857
* 2 ^comment = "An attribute certificate is a data structure which certifies (either digitally or manually) that one or more attributes (e.g., descriptors, capabilities, qualifications, etc.) are associated with a particular entity as verified/certified by the attribute authority (e.g., Credentialing Organization (US), Physician Chamber \"Ärztekammer\" (D), Physicians Statutory Association \"Kassenärztliche Vereinigung\" (D))."
* 3 0..1 ST "CER-3" "The version number differentiates among different versions of the attribute certificate."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "80"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1858
* 4 0..1 XON "CER-4" "It specifies the authority that granted the certificate to the person."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1859
* 5 0..1 XCN "CER-5" "Specifies the authority that issued the certificate to the person."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1860
* 6 0..1 ED "CER-6" "Digital Signature of the certifying authority. The Digital Signature includes a seal concept and is verifiable."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1861
* 7 0..1 ID "CER-7" "ID of the country granting the certificate. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70399[_External Table 0399 – Country Code_] for valid values."
* 7 from http://terminology.hl7.org/ValueSet/v2-0399 (required)
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 7 ^extension[=].extension[0].url = "min"
* 7 ^extension[=].extension[=].valueInteger = 3
* 7 ^extension[=].extension[+].url = "max"
* 7 ^extension[=].extension[=].valueInteger = 3
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1862
* 8 0..1 CWE "CER-8" "State/province granting the certificate. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70347[_User-defined Table 0347 – State/Province_] for valid values (in Chapter 2)"
* 8 from http://terminology.hl7.org/ValueSet/v2-0347 (required)
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1863
* 9 0..1 CWE "CER-9" "County/parish granting the certificate. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70289[_User-defined Table 0289 – County/Parish_] for valid values (in Chapter 2)."
* 9 from http://terminology.hl7.org/ValueSet/v2-0289 (required)
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1864
* 10 0..1 CWE "CER-10" "This field specifies the certificate's classification, e.g., being a privilege, permission, or qualification certificate."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1865
* 11 0..1 CWE "CER-11" "This field specifies the subject area to which the certificate is applicable, e.g., administrative, medical, or nursing issues."
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #O
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1866
* 12 0..1 EI "CER-12" "This field expresses the identifier of the certificate's subject as used by the certifying body. (The subject is the owner of the certificate, e.g., person, organization, device, application, component.) If the certificate is expressed as a X.509 document this field is required."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #C
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1867
* 13 1..1 ST "CER-13" "This field defines the name of the subject of the certificate as used by the certifying body."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #R
* 13 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 13 ^extension[=].extension[0].url = "length"
* 13 ^extension[=].extension[=].valueInteger = "250"
* 13 ^extension[=].extension[+].url = "noTruncate"
* 13 ^extension[=].extension[=].valueInteger = false
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1907
* 14 0..0 CWE "CER-14" "In individual identity certificates, this Subject Directory Attribute extension MAY contain a Healthcare Professional Role attribute and may contain a Qualified Certificate Statement attribute. In addition, Subject Directory Attributes MAY contain other attributes not specified by this technical specification."
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1868
* 15 0..1 CWE "CER-15" "This field contains the algorithm identifier. Referred to this field, the X.509 extension field MAY contain a Subject Public Key Identifier to identify the public key used in the Subject Public Key Info."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1869
* 15 ^comment = "X.509 is an ISO standard specifying certificates."
* 16 0..1 CWE "CER-16" "The Authority Key Identifier extension SHALL identify the public key to be used to verify the signature of the certificate. It enables distinct keys, used by one CA, to be distinguished (e.g., as key updating occurs)."
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1870
* 17 0..1 ID "CER-17" "The Basic Constraints extension contains a boolean used to specify whether or not the subject can act as a CA (certificate authority), using the certified key to sign certificates."
* 17 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1871
* 18 0..0 CWE "CER-18" "The Certificate Revocation List (CRL) Distribution Point extension SHALL identify the location of the associated CRL (or Authority Revocation List (ARL) for attribute certificates) in the PKI directory."
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1872
* 19 0..1 ID "CER-19" "This field contains the country for which the qualification is valid. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70399[_External Table 0399 – Country Code_] for valid values."
* 19 from http://terminology.hl7.org/ValueSet/v2-0399 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 3
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 3
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1875
* 20 0..1 CWE "CER-20" "This field contains the state for which the qualification is valid. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70347[_User-defined Table 0347 – State/Province_]."
* 20 from http://terminology.hl7.org/ValueSet/v2-0347 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1873
* 21 0..1 CWE "CER-21" "This field contains the county/parish for which the qualification is valid. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70289[_User-defined Table 0289 – County/Parish_]."
* 21 from http://terminology.hl7.org/ValueSet/v2-0289 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1874
* 22 0..0 CWE "CER-22" "This field contains the breadth/extent of the jurisdiction where the qualification is valid. HL7 suggests using values in file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70547[_User-defined Table 0547 – Jurisdictional Breadth_]."
* 22 from http://terminology.hl7.org/ValueSet/v2-0547 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1895
* 22 ^comment = "Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70547[_User-defined Table 0547 – Jurisdictional Breadth_] in Chapter 2C, Code Tables, for valid values. This table contains values for County, Parish, County etc."
* 23 0..1 DTM "CER-23" "This field contains the date when the certificate was granted."
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1876
* 24 0..1 DTM "CER-24" "This field contains the date/time when the certificate was issued."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #O
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1877
* 25 0..1 DTM "CER-25" "This field contains the date/time when the certificate became or will become active."
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #O
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1878
* 26 0..1 DTM "CER-26" "This field contains the date/time when the certificate became or will become inactive."
* 26 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 26 ^extension[=].valueCode = #O
* 26 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 26 ^code.code = #1879
* 27 0..1 DTM "CER-27" "This field contains the date/time when the certificate expires or will expire."
* 27 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 27 ^extension[=].valueCode = #O
* 27 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 27 ^code.code = #1880
* 28 0..1 DTM "CER-28" "This field contains the date/time when the certificate must/will/ be / has been renewed."
* 28 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 28 ^extension[=].valueCode = #O
* 28 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 28 ^code.code = #1881
* 29 0..1 DTM "CER-29" "This field contains the date/time when the certificate has been revoked."
* 29 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 29 ^extension[=].valueCode = #O
* 29 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 29 ^code.code = #1882
* 30 0..1 CWE "CER-30" "This field contains the reason for revoking the certificate (e.g., having been compromised, changes of conditions/environment, etc.)"
* 30 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 30 ^extension[=].valueCode = #O
* 30 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 30 ^code.code = #1883
* 31 0..1 CWE "CER-31" "This field contains the state of the certificate held by the health professional, such as provisional, revoked, etc. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70536[_User-defined Table 0536 – Certificate Status_] in Chapter 2C, Code Tables, for suggested values."
* 31 from http://terminology.hl7.org/ValueSet/v2-0536 (required)
* 31 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 31 ^extension[=].valueCode = #O
* 31 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 31 ^code.code = #1884