## XCN.9 - Assigning Authority (HD)

The assigning authority is a unique identifier of the system (or organization or agency of department) that creates the data. file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70363[_User-defined Table 0363 – Assig__ning Authority_] is used as the HL7 identifier for the user-defined table of values for the first sub-component of the HD component, &lt;namespace ID>.

As of v 2.7, the Assigning Authority is conditional. It is required if _XCN.1_ is populated and neither _XCN.22_ nor _XCN.23_ are populated. All 3 components may be populated. No assumptions can be safely made based on position or sequence. Best practice is to send an OID in this component when populated.

The reader is referred to _XCN.22_ and _XCN.23_ if there is a need to transmit values with semantic meaning for an assigning jurisdiction or assigning department or agency in addition to, or instead of, an assigning authority. However, all 3 components may be valued. If, in so doing, it is discovered that the values in _XCN.22_ and/or _XCN.23_ conflict with _XCN.9_, the user would look to the Message Profile or other implementation agreement for a statement as to which takes precedence.

When the HD data type is used in a given segment as a component of a field of another data type, file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 - Namespa__ce I__D_] (referenced by the first sub-component of the HD component) may be re-defined (given a different user-defined table number and name) by the technical committee responsible for that segment.

By site agreement, implementors may continue to use file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first sub-component.
