Logical: DST
Parent: $Segment
Id: DST
Title: "HL7 v2 DST Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Transport Destination"
* 1 1..1 CWE "DST-1" "This field identifies the destination for transport of a specific container. Refer to User-defined Table _0943 –_ _Transport Destination_ in Chapter 2C, Code Tables; there are no suggested values."
* 1 from http://terminology.hl7.org/ValueSet/v2-0943 (required)
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3491
* 2 0..0 CWE "DST-2" "This field identifies the route for transport of a specific container. . Refer to _User-defined Table 0944 – Transport Route_ in Chapter 2C, Code Tables; there are no suggested values."
* 2 from http://terminology.hl7.org/ValueSet/v2-0944 (required)
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #O
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #3492
* 2 ^comment = "Each repetion indicates the device to which the sample needs to be moved along the route."