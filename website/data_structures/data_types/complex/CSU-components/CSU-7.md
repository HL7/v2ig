## CSU.7 - Alternate Unit of Measure Coding System (ID)

Specifies the coding system for the alternate unit of measure. Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 – Coding System] in Chapter 2C, section "Coding System Table" for valid values. Analogous to _CSU.4 Unit of Measure Coding System_.

This field is required if the _CSU.5 Alternate Unit of Measure Identifier_ is present. Both _CSU.7_ and _CSU.18_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the codingSystem as specified in _CSU.7_ and/or _CSU.18_, the "Coding System" component or the "Coding System OID" for the tuple.
