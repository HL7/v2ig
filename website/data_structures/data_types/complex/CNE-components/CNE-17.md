## CNE.17 - Alternate Coding System OID (ST)

This component contains the ISO Object Identifier (OID) for the coding system or value set named in _CNE.6_. Analogous to _CNE.14 OID for Coding System_.

The value for this component is 2.16.840.1.113883.12.<mark>#</mark># where "<mark>#</mark>#" is to be replaced by the HL7 table number in the case of an HL7 defined or user defined table. For externally defined code systems the OID registered in the HL7 OID registry SHALL be used.

This component is required when _CNE.4_ is populated and _CNE.6_ is not populated. Both _CNE.6_ and _CNE.17_ may be populated.
