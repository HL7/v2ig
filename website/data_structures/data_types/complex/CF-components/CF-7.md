## CF.7 - Coding System Version ID (ST)

This component carries the version for the coding system identified by components 1-3. If _CF.3_ is populated with a value other than HL7nnnn or is of table type user-defined, version ID must be valued with an actual version ID. If _CF.3_ is populated with a value of HL7nnnn and nnnn is of table type HL7, version ID may have an actual value or it may be absent. If version ID is absent, it will be interpreted to have the same value as the HL7 version number in the message header.
