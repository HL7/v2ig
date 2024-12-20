## CWE.6 - Name of Alternate Coding System (ID)

Identifies the coding scheme being used in the alternate identifier component. Analogous to _CWE.3 - Name of Coding System_. See usage note in section introduction.

As of v2.7 this component is required when _CWE.4_ is populated and _CWE.17_ is not populated. Both _CWE.6_ and _CWE.17_ may be populated. Receivers should not identify a code based on its position within the tuples (Identifier, Alternate Identifier, or Second Alternate Identifier) or position within a repeating field. Instead, the receiver should always examine the coding System as specified in _CWE.6_ and/or _CWE.17_, the "Coding System" component or the "Coding System OID", for the tuple.
