## CSU.16 - Unit of Measure Value Set OID (ST)

This component contains the ISO Object Identifier (OID) to allow identification of the value set from which the value in _CSU.2_ is obtained. The value for this component is 2.16.840.1.113883.12.<mark>#</mark># where "<mark>#</mark>#" is to be replaced by the HL7 table number in the case of an HL7 defined or user defined table. For externally defined value sets, the OID registered in the HL7 OID registry SHALL be used.

If a code is provided, the meaning of the code must come from the definition of the code in the code system. The meaning of the code SHALL NOT depend on the value set. Applications SHALL NOT be required to interpret the code in light of the valueSet, and they SHALL NOT reject an instance because of the presence or absence of any or a particular value set/ value set version ID.

A value set may or need not be present irrespective of other fields.
