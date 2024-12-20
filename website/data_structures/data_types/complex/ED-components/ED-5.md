## ED.5 - Data (TX)

Displayable ASCII characters which constitute the data to be sent from source application to destination application. The characters are limited to the legal characters of the ST data type, as defined in Section _2A.2.76_, "_ST - string data_," and, if encoded binary, are encoded according to the method of Section _2A.2.24.2_, "_Type of Data (ID)_".

If the encoding component (see Section _2A.2.24.4_, "_Encoding (ID)_") = "A" (none), then the data component must be scanned before transmission for HL7 delimiter characters, and any found must be escaped by using the HL7 escape sequences defined in Section 2.7 – "Use of escape sequences in text fields." On the receiving application, the data field must be de-escaped after being parsed.

If the encoding component ED.4 does not equal "A", then, after encoding, the (encoded) data must be scanned for HL7 delimiter characters, and any found must be escaped by using the HL7 escape sequences. Only then can the component be added to the HL7 segment/message. On the receiving application, the data field must be de-escaped after being parsed out of the message before being decoded. This can be expressed as "encode", "escape", "parse", "de-escape" or "decode".
