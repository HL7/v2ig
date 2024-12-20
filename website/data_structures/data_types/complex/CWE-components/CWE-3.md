## CWE.3 - Name of Coding System (ID)

The third component contains the code for the name of the coding system from which the value in _CWE.1_ is obtained. Each coding system is assigned a unique identifier. As of v2.7 this component is required when _CWE.1_ is populated and _CWE.14_ is not populated. Both _CWE.3_ and _CWE.14_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the codingSystem as specified in _CWE.3_ and/or _CWE.14_, the "Coding System" component or the "Coding System OID" for the tuple.

Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 – Coding System] in Chapter 2C, section "Coding System Table" for valid values.

Refer to section link:#_Name_of_Coding_System (ID)[_2A.2.8.3_], "link:#_Name_of_Coding_System (ID)[_Name of Coding System (ID)_]" for a discussion of coding system conventions.
