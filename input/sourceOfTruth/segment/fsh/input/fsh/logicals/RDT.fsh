Logical: RDT
Parent: $Segment
Id: RDT
Title: "HL7 v2 RDT Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:34Z"
* . ^short = "Table Row Data"
* 1 1..1 Varies "RDT-1" "This field is a requested field. Fields occur in the position order defined for the query or table (unless overridden by an optional RDF segment on a stored procedure request or Virtual Table query message), separated by field delimiters."
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #R
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #703