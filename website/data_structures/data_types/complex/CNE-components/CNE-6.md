## CNE.6 - Name of Alternate Coding System (ID)

Identifies the coding scheme being used in the alternate identifier component. Analogous to _CNE.3 Name of Coding System_. Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 - Coding Systems] in Chapter 2C, Code Tables, for valid values.

As of v2.7 this component is required when _CNE.4_ is populated and _CNE.17_ is not populated. Both _CNE.6_ and _CNE.17_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the codingSystem as specified in _CNE.6_ and/or _CNE.17_, the "Coding System" component or the "Coding System OID", for the tuple.

**Usage Notes:** If present, _CNE.6_ obeys the same rules of use and interpretation as described for _CNE.3_.
