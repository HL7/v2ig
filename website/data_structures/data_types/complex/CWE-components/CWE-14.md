## CWE.14 - Coding System OID (ST)

This component contains the ISO Object Identifier (OID) for the coding system or value set named in _CWE.3_. The value for this component for an HL7 or User Defined table SHALL be the value published for the code system OID for the table in _Chapter 2C Code Tables_. For externally defined code systems the OID registered in the HL7 OID registry SHALL be used.

This component is required when _CWE.1_ is populated and _CWE.3_ is not populated. Both _CWE.3_ and _CWE.14_ may be populated.

If a code is provided, the meaning of the code must come from the definition of the code in the code system. The meaning of the code SHALL NOT depend on the value set. Applications SHALL NOT be required to interpret the code in light of the valueSet, and they SHALL NOT reject an instance because of the presence or absence of any or a particular value set/ value set version ID.
