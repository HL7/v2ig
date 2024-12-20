## CWE.15 - Value Set OID (ST)

This component contains the ISO Object Identifier (OID) to allow identification of the value set from which the value in _CWE.1_ is obtained. The value for this component is identified for each of the HL7 Tables that have values published in C__hapter 2C Code Tables__. For externally defined value sets, the OID registered in the HL7 OID registry and/or published in an HL7 balloted Implementation Guide SHALL be used.

A value set may or need not be present irrespective of other fields.

If a code is provided, the meaning of the code must come from the definition of the code in the code system. The meaning of the code SHALL NOT depend on the value set. Applications SHALL NOT be required to interpret the code in light of the valueSet, and they SHALL NOT reject an instance because of the presence or absence of any or a particular value set/ value set version ID.
