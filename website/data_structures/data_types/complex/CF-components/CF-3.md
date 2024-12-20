## CF.3 - Name of Coding System (ID)

Contains the name of the coding system employed.

Refer to E:\\V2\\v2.9 final Nov from Frank\\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 - Coding System] in Chapter 2C, Code Tables, for valid values.

As of v2.7 this component is required when _CF.1_ is populated and _CF.14_ is not populated. Both _CF.3_ and _CF.14_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the coding system as specified in _CF.3_ and/or _CF.14_, the Coding System component or the Coding System OID, for the tuple.
