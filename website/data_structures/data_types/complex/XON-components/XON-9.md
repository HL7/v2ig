## XON.9 - Name Representation Code (ID)

Different &lt;name/address types> and representations of the same &lt;name/address> should be described by repeating of this field, with different values of the &lt;name/address type> and/or &lt;name/address representation> component.

This new component remains in “alphabetic” representation with each repetition of the field using these data types, i.e. even though the name may be represented in an ideographic character set, this component will remain represented in an alphabetic character set.

Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70465[_HL7 Table 0465 – Name/address Representation Code_] for valid values.

In general this component provides an indication of the representation provided by the data item. It does not necessarily specify the character sets used. Thus, even though the representation might provide an indication of what to expect, the sender is still free to encode the contents using whatever character set is desired. This component provides only hints for the receiver, so it can make choices regarding what it has been sent and what it is capable of displaying.
