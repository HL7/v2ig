## QIP.1 - Segment Field Name (ST)

This component contains the segment field name.

Naming conventions:

Segment field names are designated by the “@” symbol concatenated with the HL7 segment ID followed by the sequence number for the field separated by a period. See sections 2.5.2, "Segments and segment groups" and 2.5.3.1, "Position (sequence within the segment)" for a definition of segment ID and sequence number. If the field is divided into components, the designation may be suffixed with ".nn", to identify a particular component (a suffix of “.3” indicates the third component of the field); otherwise, the whole field is assumed. If the field is further divided into subcomponents, the designation is suffixed with “.nn.mm", which identifies the component and subcomponent requested by relative position.

Site-specific segment field names may be used***.*** In this case, the site-specific segment ID (if the field is not being added to an existing HL7 segment) and the sequence number must be defined so that they do not conflict with existing HL7 segment IDs and field sequence numbers.

Values for this field are defined in the function-specific chapters of this specification.

If the “@” is being used as one of the delimiter characters defined in MSH-2-encoding characters, it must be “escaped.” See Section 2.7.1, "Formatting Codes".
