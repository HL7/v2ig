## CSU.13 - Name of Second Alternate Unit of Measure Coding System (ID)

Specifies the coding system for the second alternate unit of measure. Analogous to _CSU.4 Unit of Measure Coding System_. Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 – Coding System] in Chapter 2C, Code Tables, for valid values.

This component is required when _CSU.11_ is populated. Both _CSU.13_ and _CSU.21_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the codingSystem as specified in _CSU.13_ and/or _CSU.21_ the Coding System component or the Coding System OID for the tuple.
