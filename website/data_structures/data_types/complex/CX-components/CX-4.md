## CX.4 - Assigning Authority (HD)

The assigning authority is a unique name and/or identifierof the system (or organization or agency or department) that creates the data. As of v2.7, _CX.4 Assigning Authority_ is required if neither _CX.9_ nor _CX.10_ are populated. Best practice is to always send an OID in the Assigning Authority component

Refer to E:\\V2\\v2.9 final Nov from Frank\\V29_CH02C_Tables.docx#HL70363[_User-defined T__a__ble 0363 - Assigning Authority_] for suggested values.

The reader is referred to the _CX.9_ and the _CX.10_ if there is a need to transmit values with semantic meaning for an assigning jurisdiction or assigning department or agency in addition to, or instead of, an assigning authority. However, all 3 components may be valued. If, in so doing, it is discovered that the values in _CX.9_ and/or _CX.10_ conflict with _CX.4_, the user would look to the Message Profile or other implementation agreement for a statement as to which takes precedence.

When the HD data type is used in a given segment as a component of a field of another data type, file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 - Namespace ID_] (referenced by the first sub-component of the HD component) may be re-defined (given a different user-defined table number and name) by the technical committee responsible for that segment.\
+
By site agreement, implementers may continue to use file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70300[_User-defined Table 0300 – Namespace ID_] for the first sub-component.
