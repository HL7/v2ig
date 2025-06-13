Logical: ADD
Parent: $Segment
Id: ADD
Title: "HL7 v2 ADD Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Addendum"
* 1 0..1 ST "ADD-1" "This field is used to define the continuation of the prior segment in a continuation message. See section _2.9.2_, \"_Continuation messages and segments_\" for details. When the ADD is sent after the segment being continued, it contains no fields. It is only a marker that the previous segment is being continued in a subsequent message. Thus fields 1‑N are not present. The sequence designation, 1‑N, means the remainder of the fields in the segment being continued. These remainder of the segment being continued fields are present only when the ADD is sent with a continuation message."
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #O
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #66