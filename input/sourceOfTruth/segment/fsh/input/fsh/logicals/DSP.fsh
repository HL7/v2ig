Logical: DSP
Parent: $Segment
Id: DSP
Title: "HL7 v2 DSP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Display Data"
* 1 0..1 SI "DSP-1" "This field is used optionally to number multiple display segments."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #61
* 2 0..1 SI "DSP-2" "This field contains numbering to define groups of fields as assigned by the individual sites or applications."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 2 ^extension[=].extension[0].url = "min"
* 2 ^extension[=].extension[=].valueInteger = 1
* 2 ^extension[=].extension[+].url = "max"
* 2 ^extension[=].extension[=].valueInteger = 4
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #62
* 3 1..1 TX "DSP-3" "This field contains an actual line as it should be displayed. As described for the TX data type, highlighting and other special display characteristics may be included."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #R
* 3 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 3 ^extension[=].extension[0].url = "length"
* 3 ^extension[=].extension[=].valueInteger = "300"
* 3 ^extension[=].extension[+].url = "noTruncate"
* 3 ^extension[=].extension[=].valueInteger = true
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #63
* 4 0..1 ST "DSP-4" "This field is non‑null if this line is the last line of a logical break point in the response as defined by the responding system."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 4 ^extension[=].extension[0].url = "length"
* 4 ^extension[=].extension[=].valueInteger = "2"
* 4 ^extension[=].extension[+].url = "noTruncate"
* 4 ^extension[=].extension[=].valueInteger = true
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #64
* 4 ^comment = "Often the lines of display text will fall into logical groups that differ from the physical size of a screen or printer page. For example, a complete battery or an entire radiology report might be thought of as comprising a logical group, though it might have as few as six or as many as 120 lines. Knowledge of the logical break points in the display data can be useful to the application system that is displaying or printing data. For this reason, _DSP-4-Logical break point_ is used. The sending application (the one that formats the data) places the logical break points where appropriate. If there is a particular ancillary result ID associated with the data delineated by _DSP-4-Logical break point_, the value of this ID also can be returned in _DSP-5-Result ID_. Then if the user selects the area of the display delineated by _DSP-4-Logical break point_, the displaying system can query for the associated _DSP-5-Result ID_."
* 5 0..1 TX "DSP-5" "When the user selects a result ID (defined by _DSP-4-Logical break point_) from the screen display corresponding to a record in which _DSP-5-Result ID_ is non-null, the application can initiate a second query (a separate session) to the ancillary with the _QRD-10-What department data code_ filled in with this non-null value (e.g., the ancillary accession number or its equivalent). The ancillary response will contain the report referenced by this result ID (e.g., accession number). The ancillary should correlate the result ID with _DSP-4-Logical break point_ as follows: If more than one line of text is sent per result, _DSP-5-Result ID_ should be only non-null for a DSP segment that contains a non-null _DSP-4-Logical break point_. This field may be broken into components by local agreement. A common example might be to include placer order number, filler order number, and universal service identifier. Whenever such fields are used as components of the result ID, their components will be sent as subcomponents."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 5 ^extension[=].extension[0].url = "length"
* 5 ^extension[=].extension[=].valueInteger = "20"
* 5 ^extension[=].extension[+].url = "noTruncate"
* 5 ^extension[=].extension[=].valueInteger = true
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #65