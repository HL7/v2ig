## CF.6 - Name of Alternate Coding System (ID)

Contains the name of the coding system employed for the alternate identifier. Analogous to _CF.3 Name of Coding System_.

Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 - Coding System] in Chapter 2C, Code Tables, for valid values.

As of v2.7 this component is required when _CF.4_ is populated and _CF.17_ is not populated. Both _CF.6_ and _CF.17_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the coding ystem as specified in _CF.6_ and/or _CF.17_, the Coding System component or the Coding System OID, for the tuple.
