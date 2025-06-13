Logical: MCP
Parent: $Segment
Id: MCP
Title: "HL7 v2 MCP Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:37Z"
* . ^short = "Master File Coverage Policy"
* 1 1..1 SI "MCP-1" "_MCP-1 - set ID - MCP_ contains the number that identifies this transaction. For the first occurrence the sequence number shall be 1, for the second occurrence it shall be 2, etc. The Set ID in the MCP segment is used to uniquely identify the segment. There are likely multiple instances of Universal Service Identifier, Diagnosis and Procedure code."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #R
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/length"
* 1 ^extension[=].extension[0].url = "min"
* 1 ^extension[=].extension[=].valueInteger = 1
* 1 ^extension[=].extension[+].url = "max"
* 1 ^extension[=].extension[=].valueInteger = 4
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #3468
* 2 1..1 CWE "MCP-2" "This field contains the producer's usual or preferred identification of the test or observation. Only three components should be included: <ID code>^<service text name/description>^<source list of code>. All components should be non-null."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #587
* 3 0..1 MO "MCP-3" "Specifies the lowest price for the Universal Service that needs to be disclosed on the payer notification to the patient (for example Medicare ABN). If there is a single price for this Universal Service Identifier, MCP-3 is not valued."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #3469
* 3 ^comment = "Components:  <Quantity (NM)> ^ <Denomination (ID)>\n\nExample: MCP|||35.00^USD|75.00^USD"
* 4 0..1 MO "MCP-4" "Specifies the highest price for the Universal Service that needs to be disclosed on the payer notification to the patient (for example Medicare ABN). If there is a single price for this Universal Service Identifier, it is valued in this field."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #3470
* 4 ^comment = "Components:  <Quantity (NM)> ^ <Denomination (ID)>\n\nExample of MCP-4 where price of test is $65.00 and there are no variants to the cost:\n\nMCP||||65.00^USD\n\nExample of MCP-3 and MCP-4 value when the price of test is variable and can range from $35.00 (low) to $75.00 (high)\n\nMCP||||$35.00^USD|75.00^USD"
* 5 0..1 ST "MCP-5" "Specifies the reason for the interval between the lowest and the highest price for the Universal Service, for example additional testing (reflex test) that is added based on values of the initial test. There maybe some instances when the value between MCP-3 and MCP-4 is not significant enough to warrant a reason as defined by health authorities."
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #C
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #3471
* 5 ^comment = "Condition: This is conditionally required when MCP-3 is valued."