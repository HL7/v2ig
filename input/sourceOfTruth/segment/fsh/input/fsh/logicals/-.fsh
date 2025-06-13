Logical: CON
Parent: $Segment
Id: CON
Title: "HL7 v2 CON Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Consent"
* 1 1..1 SI "CON-1" "This field contains the number that identifies this segment instance within the message. For the first occurrence of the segment, the sequence number shall be one; for the second occurrence, the sequence number shall be two; etc."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1776
* 2 0..1 CWE "CON-2" "This field describes what the subject is consenting to, i.e., what type of service, surgical procedure, information access/release or other event. For values see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70496[_User-Defined Table 0496 – Consent Type._]"
* 2 from http://terminology.hl7.org/ValueSet/v2-0496 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1777
* 3 0..1 ST "CON-3" "Identifies a specific version of a consent form used to record the consent. A given version of a consent form implies a particular set of wording that appears on the form."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1778
* 4 0..1 EI "CON-4" "Uniquely identifies a specific recorded consent. This may be the number assigned to an electronic consent, or may be the number on a printed consent form."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1779
* 5 0..0 FT "CON-5" "Describes the specific procedures/information releases/events the subject is consenting to."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1780
* 6 0..0 FT "CON-6" "Describes any additions or variations to the standard procedures/information releases/events from a standard consent that are applicable to the subject whose consent is sought."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1781
* 7 0..0 FT "CON-7" "Describes any additional information relating to the procedure/information release/event that needs to be understood by the subject for informed consent. May include the reason for the service, the expected benefit, risks, etc."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1782
* 8 0..0 FT "CON-8" "Describes any additions or variations to the standard additional information that needs to be understood by the patient for informed consent. May include a description of benefits and risks that are specific to the subject from whom consent is sought. May also include an indication that there are *no* subject-specific risks/benefits."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #1783
* 9 0..0 FT "CON-9" "Describes any restrictions or limitations placed on their consent by the subject."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #1784
* 10 0..1 CNE "CON-10" "The method in which a subject provides consent. For values see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70497[_HL7 Table 0497 – Consent Mode._]"
* 10 from http://terminology.hl7.org/ValueSet/v2-0497 (required)
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #1785
* 11 1..1 CNE "CON-11" "Indicates whether consent has been sought and granted. For values see file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70498[_HL7 Table 0498 – Consent Status_]."
* 11 from http://terminology.hl7.org/ValueSet/v2-0498 (required)
* 11 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 11 ^extension[=].valueCode = #R
* 11 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 11 ^code.code = #1786
* 12 0..1 DTM "CON-12" "Identifies the time when consent was discussed with the subject. This should only be specified if this differs from the time the consent decision is made."
* 12 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 12 ^extension[=].valueCode = #O
* 12 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 12 ^code.code = #1787
* 13 0..1 DTM "CON-13" "Identifies the time when the decision to grant/refuse consent was made. In the case of written consent, this is the time the consent form is signed."
* 13 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 13 ^extension[=].valueCode = #O
* 13 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 13 ^code.code = #1788
* 14 0..1 DTM "CON-14" "The time the consent becomes/became effective. This only needs to be specified if the time differs from the Consent Decision Date/Time"
* 14 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 14 ^extension[=].valueCode = #O
* 14 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 14 ^code.code = #1789
* 15 0..1 DTM "CON-15" "The time the consent becomes ineffective. If not specified, the consent is assumed to be indefinite. For consents relating to information release, the end date/time is the date by which the released information must be returned/destroyed."
* 15 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 15 ^extension[=].valueCode = #O
* 15 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 15 ^code.code = #1790
* 16 0..1 ID "CON-16" "Identifies whether the subject was deemed competent to provide consent. Refer to table file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator._]"
* 16 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 16 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 16 ^extension[=].valueCode = #O
* 16 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 16 ^extension[=].extension[0].url = "min"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^extension[=].extension[+].url = "max"
* 16 ^extension[=].extension[=].valueInteger = 1
* 16 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 16 ^code.code = #1791
* 17 0..1 ID "CON-17" "Identifies whether translation was (or will be) required to obtain informed consent from the subject. Refer to table file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator._]"
* 17 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 17 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 17 ^extension[=].valueCode = #O
* 17 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 17 ^extension[=].extension[0].url = "min"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^extension[=].extension[+].url = "max"
* 17 ^extension[=].extension[=].valueInteger = 1
* 17 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 17 ^code.code = #1792
* 18 0..1 CWE "CON-18" "Identifies the language the consent material must be translated to. Refer to _file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70296[User Defined table 0296 – Primary Language]_ which contains no suggested values. This table may be populated with values similar to those that may be found in _ISO table 639 – Language Codes._"
* 18 from http://terminology.hl7.org/ValueSet/v2-0296 (required)
* 18 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 18 ^extension[=].valueCode = #O
* 18 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 18 ^code.code = #1793
* 19 0..1 ID "CON-19" "Identifies whether additional educational or reference material was provided to the subject as part of the consent process. Refer to table file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70136[_HL7 Table 0136 – Yes/No Indicator._]"
* 19 from http://terminology.hl7.org/ValueSet/v2-0136 (required)
* 19 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 19 ^extension[=].valueCode = #O
* 19 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 19 ^extension[=].extension[0].url = "min"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^extension[=].extension[+].url = "max"
* 19 ^extension[=].extension[=].valueInteger = 1
* 19 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 19 ^code.code = #1794
* 20 0..1 CWE "CON-20" "Identifies why the subject's consent was not sought. This field must be populated when _CON-11 - Consent Status_ is B – Bypassed. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70499[_User Defined table 0499 – Consent Bypass Reason_] for suggested values."
* 20 from http://terminology.hl7.org/ValueSet/v2-0499 (required)
* 20 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 20 ^extension[=].valueCode = #O
* 20 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 20 ^code.code = #1795
* 21 0..1 ID "CON-21" "Identifies how much information was disclosed to the subject as part of the informed consent process. Refer to table file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70500[_HL7 Table 0500 – Consent Disclosure Level_]."
* 21 from http://terminology.hl7.org/ValueSet/v2-0500 (required)
* 21 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 21 ^extension[=].valueCode = #O
* 21 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 21 ^extension[=].extension[0].url = "min"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^extension[=].extension[+].url = "max"
* 21 ^extension[=].extension[=].valueInteger = 1
* 21 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 21 ^code.code = #1796
* 22 0..1 CWE "CON-22" "Identifies why the subject did not receive full disclosure. . Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70501[_User-Defined Table 0501 – Consent Non-Disclosure Reason_] for suggested values."
* 22 from http://terminology.hl7.org/ValueSet/v2-0501 (required)
* 22 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 22 ^extension[=].valueCode = #O
* 22 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 22 ^code.code = #1797
* 23 0..1 CWE "CON-23" "Identifies why consent was granted by a person other than the subject of the consent. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70502[_User-defined Table 0502 – Non-Subject Consenter Reason_] for suggested values."
* 23 from http://terminology.hl7.org/ValueSet/v2-0502 (required)
* 23 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 23 ^extension[=].valueCode = #O
* 23 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 23 ^code.code = #1798
* 24 1..0 XPN "CON-24" "Identification of the individual(s) who is (are) consenting."
* 24 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 24 ^extension[=].valueCode = #R
* 24 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 24 ^code.code = #1909
* 25 1..0 CWE "CON-25" "Identification of the relationship of the consenter to the subject. Receivers are required to inspect the Coding System component of the CWE data type to accurately interpret the meaning of the code. Senders transmitting messages to Receivers on earlier version of the standard may elect to negotiate business rules to ensure that expected data is not lost. HL7 does not assign positional meaning to user-defined codes. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70548[_User-Defined Table 0548 – Signatory's Relationship to Subject_] for suggested values."
* 25 from http://terminology.hl7.org/ValueSet/v2-0548 (required)
* 25 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 25 ^extension[=].valueCode = #R
* 25 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 25 ^code.code = #1898