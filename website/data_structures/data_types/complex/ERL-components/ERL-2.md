## ERL.2 - Segment Sequence (SI)

Identifies the segment occurrence within the message. The first occurrence of a segment is assigned the number of 1.

This number refers to the absolute position of the referenced instance of the segment type in the message – it is not synonymous with the Set-ID of the segment – for example if the referenced element is OBX in field position 5, that means it is the 5th OBX segment in the message, regardless of the number of OBR segments that may be interspersed between them, which causes a reset of the Set-ID.*
