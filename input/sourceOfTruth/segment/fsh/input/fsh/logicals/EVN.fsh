Logical: EVN
Parent: $Segment
Id: EVN
Title: "HL7 v2 EVN Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:32Z"
* . ^short = "Event Type"
* 1 0..1 BackboneElement "EVN-1" "EVN-1"
* 1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension.valueCode = #W
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #99
* 1 ^comment = "*_Attention: The EVN-1 field was retained for backward compatibilty only as of v2.5 and the detail was withdrawn and removed from the standard as of v2.7._*"
* 2 1..1 DTM "EVN-2" "Most systems will default to the system date/time when the transaction was entered, but they should also permit an override."
* 2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension.valueCode = #R
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #100
* 3 0..1 DTM "EVN-3" "This field contains the date/time that the event is planned. We recommend that _PV2-8 - Expected Admit Date/Time_, _PV2-9 - Expected Discharge Date/Time_ or _PV2-47 - Expected LOA Return date/time_ be used whenever possible."
* 3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension.valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #101
* 4 0..1 CWE "EVN-4" "This field contains the reason for this event. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70062[_User-defined Table 0062 - Eve__nt Re__ason_] in Chapter 2C, Code Tables, for suggested values."
* 4 from http://terminology.hl7.org/ValueSet/v2-0062 (required)
* 4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension.valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #102
* 5 0..0 XCN "EVN-5" "This field identifies the individual responsible for triggering the event. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70188[_User-defined Table 0188 - Ope__rator ID_] in Chapter 2C, Code Tables, for suggested values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0188 (required)
* 5 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension.valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #103
* 6 0..1 DTM "EVN-6" "This field contains the date/time that the event actually occurred. For example, on a transfer (A02 transfer a patient), this field would contain the date/time the patient was actually transferred. On a cancellation event, this field should contain the date/time that the event being cancelled occurred."
* 6 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension.valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1278
* 7 0..1 HD "EVN-7" "This field identifies the actual facility where the event occurred as differentiated from the sending facility (MSH-4). It would be the facility at which the Operator (EVN-5) has entered the event."
* 7 ^extension.url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 7 ^extension.valueCode = #O
* 7 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 7 ^code.code = #1534
* 7 ^comment = "Use Case: System A is where the patient is originally registered. This registration message is sent to an MPI, System B. The MPI needs to broadcast the event of this update and would become the sending facility. This new field would allow for retention of knowledge of the originating facility where the event occurred. The MPI could be the assigning authority for the ID number as well which means that it is performing the function of assigning authority for the facility originating the event."