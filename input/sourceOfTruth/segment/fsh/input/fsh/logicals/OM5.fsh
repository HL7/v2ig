Logical: OM5
Parent: $Segment
Id: OM5
Title: "HL7 v2 OM5 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Observation Batteries (Sets)"
* 1 0..1 NM "OM5-1" "This field contains the same value as the sequence number of the associated OM1 segment."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "4"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #586
* 2 0..0 CWE "OM5-2" "This field contains the codes and names of all tests/observations included within a single battery (nature code P, as described in _OM1-18 - Nature of Service/Test/Observation_), a single functional procedure (nature code F), or a given superset (nature code S). When a segment includes a list of component elements, the sending system should be sure that the segments defining all of the components are sent before the segment that references them. An entry in this list can itself be a battery. Refer to Table 0662 - Test/Observations Included Within an Ordered Test Battery in Chapter 2C for valid values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0662 (required)
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #655
* 2 ^comment = "The individual service/test/observation code should be recorded as type CWE, i.e., in the standard format for coded observation identifiers. Multiple observations should be separated by repeat delimiters. In the US, it is recommended that, within a single occurrence of OM5-2 Tests/Observations included within an Orders Test Battery, these child observations be identified with LOINC codes as well as by the producer’s local identifier. Examples of code systems used may be LOINC (emerging as the global standard for observation identifiers), JLAC10, or SNOMED CT.\n\nIf the definition segment defined serum electrolytes, this field might look like the following:\n\n2951-2^SODIUM^LN~\n\n2823-3^POTASSIUM^LN~\n\n2075-0^CHLORIDE^LN~\n\n2028-9^CARBON DIOXIDE^LN\n\nFor S (superset) parameters, this field contains the batteries that are included within the \"super\" battery. For example, ROUTINES might be defined as:\n\n402^Electrolytes~352^Urinalysis~432^CBC~520^SMA12"
* 3 0..1 ST "OM5-3" "This field contains the tests or procedures that produce a type which uses observation ID suffixes following the service/test/observation ID code. This field lists the possible options. For example, a chest X-ray may use the suffixes IMP, REC, DEV, or others. Each of the expected suffixes should be listed here."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #656