## CWE.20 - Second Alternate Coding System OID (ST)

This component contains the ISO Object Identifier (OID) for the coding system or value set named in _CWE.12_. Analogous to _CWE.14 - Coding System OID_.

The value for this component for an HL7 or User Defined table SHALL be the value published for the code system OID for the table in _Chapter 2C Code Tables_. For externally defined code systems the OID registered in the HL7 OID registry SHALL be used.

This component is required when _CWE.10_ is populated and _CWE.12_ is not populated. Both _CWE.12_ and _CWE.20_ may be populated.
