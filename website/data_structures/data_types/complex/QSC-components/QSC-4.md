## QSC.4 - Relational Conjunction (ID)

Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70210[_HL7 Table 0210 - Relational Conjunction_] for valid values. The relational conjunction is defined as follows: If more than one comparison is to be made to select qualifying rows, a conjunction relates this repetition of the field to the next.

• When applied to strings, the relational operators LT, GT, LE, and GE imply an alphabetic comparison.

• A "generic" comparison selects a record for inclusion in the response when the beginning of the designated field matches the select string.

• Where a repeating field is specified as an operand, a match on any instance of that field qualifies the row for inclusion in the response message.

• AND takes precedence over OR. More sophisticated precedence rules require that the query be expressed as an embedded query language message or a stored procedure query message (see Chapter 5, "Query").
