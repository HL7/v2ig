Logical: OM2
Parent: $Segment
Id: OM2
Title: "HL7 v2 OM2 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Numeric Observation"
* 1 0..1 NM "OM2-1" "This field contains the same value as the sequence number of the associated OM1 segment. Refer to Table 0648 - Units of Measure in Chapter 2C for valid values."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 0..1 CWE "OM2-2" "This field contains the single tests/observations (those with a nature code of A or C, as described in _OM1-18 - Nature of Service/Test/Observation_) that have numeric values. This field contains their customary units of measure. Use of UCUM is strongly recommended as one of the specified units (either alone or in addition to the local units)."
* 2 from http://terminology.hl7.org/ValueSet/v2-0648 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #627
* 3 0..0 NM "OM2-3" "This field contains the numerically valued single observations (code A or C as described in _OM1-18 - Nature of Service/Test/Observation_), specifies the total length in characters of the field needed to display the observation, and the number of digits displayed to the right of the decimal point. This is coded as a single number in the format <length>.<decimal-digits>. For example, a value of 6.2 implies 6 characters total (including the sign and decimal point) with 2 digits after the decimal point. For integer values, the period and <decimal-digits> portion may be omitted (that is, 5.0 and 5 are equivalent). More than one such mask may be transmitted (separated by repeat delimiters) when it is necessary to define multiple display formats that are possible."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "10"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = false
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #628
* 4 0..1 CWE "OM2-4" "This field contains the single tests/observations - the corresponding SI units of measure in the format, when these differ from the customary units of measure given in the previous field. Refer to Table 0649 - Corresponding SI Units of Measure in Chapter 2C for valid values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0649 (required)
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #629
* 5 0..1 TX "OM2-5" "This field contains the continuous, numerically valued tests/observations, with a nature code of A or C (see _OM1-18 - Nature of Service/Test/Observation_). This is a factor for converting the customary units to SI units."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "60"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = false
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #630
* 5 ^comment = "In the case that the observation units are not SI units, this field provides the formula needed to convert from the reported units to SI units, this shall include the equation needed to convert from the reporting to the SI units.\n\nIn the case that the relation is simply multiplicative, this field shall include only the conversion factor. For example, if (results SI units) = c * (results reporting units), then only c would be stored in this field. In the case of any other functional relationship, the entire equation would be stored as a test."
* 6 0..0 RFR "OM2-6" "This field contains the reference (normal) ranges for \"numeric\" observations/tests with a nature code of A or C (see _OM1-18 - Nature of Service/Test/Observation_). It can identify different reference (normal) ranges for different categories of patients according to age, sex, race, and other conditions."
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #631
* 6 ^comment = "In the first component of this field (Normal Range (NR)), the units are assumed to be identical to the reporting units given in _OM2-2 - Units of Measure_.\n\nWhen two different methods result in two different reference ranges, two different observations and corresponding OMx segments should be defined."
* 7 0..0 RFR "OM2-7" "This field applies only to single tests/observations (i.e., a nature code of A or C, as described in _OM1-18 - Nature of Service/Test/Observation_) with numeric results). When a critical range is defined for such observations, it should be recorded here in the same format as the normal range (see _OM2-6 - Reference (Normal) Range - Ordinal and Continuous Observations_)."
* 7 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension[=].valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #632
* 8 0..1 RFR "OM2-8" "This field applies only to single tests/observations with a nature code of A or C (see _OM1-18 - Nature of Service/Test/Observation_). It defines the range of possible results. Results outside this range are not possible. The field should be recorded in the same format as the normal and critical ranges."
* 8 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 8 ^extension[=].valueCode = #O
* 8 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 8 ^code.code = #633
* 9 0..0 DLT "OM2-9" "This field applies to numeric tests/observations with a nature code of A or C (see _OM1-18 - Nature of Service/Test/Observation_). The field describes the information that controls delta check warnings and includes four components."
* 9 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 9 ^extension[=].valueCode = #O
* 9 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 9 ^code.code = #634
* 9 ^comment = "{empty}1) The range to which the following applies: <low & high>. +\n\nAll the ranges are defined in terms of the customary reporting units given in _OM2-2 - Units of Measure_. If no value range is given, the check applies to all values.\n\n{empty}2) The numeric threshold of the change that is detected, e.g., 10.\n\n{empty}3) Whether the change is computed as a percent change or an absolute change. This component can have two possible values:\n\n% indicates a percent change +\n\na absolute change\n\n{empty}4) The length of time that the service retains a value for computing delta checks. This is recorded in number of days.\n\nMore than one delta check rule can apply. 13&16^10^%^100~16.1&20^2^a^100 implies that the delta check will trigger on a 10% change when the value of the observation is between 13 and 16. The check will trigger on an absolute change of 2 when the value is between 16.1 and 20. In both cases, the system will keep the last result for 100 days. In this example, beyond 100 days, the computer will not compute a delta check because it will not have a comparison value."
* 10 0..1 NM "OM2-10" "This field contains the numerically valued single observations (a nature code of A or C, as described in _OM1-18 - Nature of Service/Test/Observation_) and specifies the smallest meaningful difference between reported values (the effective resolution of the measuring instrument or technique for continuous data, or the smallest discrete interval that can occur for discrete data)."
* 10 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 10 ^extension[=].valueCode = #O
* 10 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 10 ^code.code = #635