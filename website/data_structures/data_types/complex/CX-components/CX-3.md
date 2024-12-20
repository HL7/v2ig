## CX.3 - Check Digit Scheme (ID)

Contains the code identifying the check digit scheme employed.

Refer to file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70061[_HL7 T__ab__le 00__61 - Check Digit Scheme_] for valid values.

The algorithm for calculating a Mod10 check digit is as follows:

Assume you have an identifier - 12345. Take the odd digit positions, counting from the right, i.e., 531, multiply this number by 2 to get 1062. Take the even digit positions, starting from the right (i.e., 42), prepend these to the 1062 to get 421062. Add all of these six digits together to get 15. Subtract this number from the next highest multiple of 10, i.e., 20 - 15 to get 5. The Mod10 check digit is 5. The Mod10 check digit for 401 is 0; for 9999, it’s 4; for 99999999, it’s 8.

The algorithm for calculating a Mod11 check digit is as follows:

**Terms**

|     |     |     |
| --- | --- | --- |
| d | = | digit of number starting from units digit, followed by 10’s position, followed by 100’s position, etc. |
| w | = | weight of digit position starting with the units position, followed by 10’s position, followed by 100’s position etc. Values for w = 2, 3, 4, 5, 6, 7, 2, 3, 4, 5, 6, 7, etc. (repeats for each group of 6 digits) |
| c | = | check digit |

**Calculation**

|     |     |     |
| --- | --- | --- |
| (Step 1) m | = | sum of (d * w) for positions 1, 2, etc. starting with units digit for d = digit value starting with units position to highest order for w = weight value from 2 to 7 for every six positions starting with units digit |
| (Step 2) c1 | = | m mod 11 |
| (Step 3) if c1 | = | 0 then reset c1 = 1 |
| (Step 4) | = | (11 - c1) mod 10 |

**Example:**

If the number is 1234567, then the mod 11 check digit = 4

The calculations are:

M = (7*2)+(6*3)+(5*4)+(4*5)+(3*6)+(2*7)+(1*2)

= 14 + 18 + 20 + 20 + 18 + 14 + 2

= 106

c1 = 106 mod 11

= 7

c = (11-c1) mod 10

= 4 mod 10

= 4

Other variants of these check digit algorithms exist and may be used by local bilateral site agreement.

The check digit and code identifying check digit scheme are null if ID is alphanumeric.
