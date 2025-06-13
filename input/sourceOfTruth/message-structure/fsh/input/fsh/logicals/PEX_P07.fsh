Logical: PEX_P07
Parent: V2MessageStructure
Id: PEX_P07
Title: "HL7 v2 PEX_P07 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "PEX_P07"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "PEX_P07"
* . ^definition = "PEX_P07 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 5-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-EVN ^extension.valueCode = #A
* 6-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 6-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PID ^extension.valueCode = #A
* 7-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 7-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PD1 ^extension.valueCode = #A
* 8-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSP ^extension.valueCode = #A
* 9-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 9-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSR ^extension.valueCode = #A
* 10-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 10-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-GSC ^extension.valueCode = #A
* 11-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 11-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-PRT ^extension.valueCode = #A
* 12-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 12-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-ARV ^extension.valueCode = #B
* 13-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 13-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-NTE ^extension.valueCode = #A
* 14-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 14-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 14-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-VISIT.1-PV1 ^extension.valueCode = #A
* 14-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 14-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-VISIT.2-PV2 ^extension.valueCode = #A
* 14-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 14-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-VISIT.3-PRT ^extension.valueCode = #A
* 15-EXPERIENCE 1..* BackboneElement "EXPERIENCE" "EXPERIENCE"
* 15-EXPERIENCE.1-PES 1..1 http://hl7.org/v2/StructureDefinition/PES "Product Experience Sender" "Product Experience Sender"
* 15-EXPERIENCE.1-PES ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.1-PES ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION 1..* BackboneElement "PEX_OBSERVATION" "PEX_OBSERVATION"
* 15-EXPERIENCE.2-PEX_OBSERVATION.1-PEO 1..1 http://hl7.org/v2/StructureDefinition/PEO "Product Experience Observation" "Product Experience Observation"
* 15-EXPERIENCE.2-PEX_OBSERVATION.1-PEO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.1-PEO ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE 1..* BackboneElement "PEX_CAUSE" "PEX_CAUSE"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.1-PCR 1..1 http://hl7.org/v2/StructureDefinition/PCR "Potential Causal Relationship" "Potential Causal Relationship"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.1-PCR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.1-PCR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER 0..1 BackboneElement "RX_ORDER" "RX_ORDER"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.1-RXE ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Pharmacy/Treatment)" "Participation (for Pharmacy/Treatment)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.2-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY 1..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.3-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.4-RXR 0..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.4-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.2-RX_ORDER.4-RXR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION 0..* BackboneElement "RX_ADMINISTRATION" "RX_ADMINISTRATION"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.1-RXA ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.2-RXR 0..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.2-RXR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Pharmacy Administration)" "Participation (for Pharmacy Administration)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.3-RX_ADMINISTRATION.3-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.4-PRB 0..* http://hl7.org/v2/StructureDefinition/PRB "Detail problem segment" "Detail problem segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.4-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.4-PRB ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment" "Observation/Result Segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Result)" "Participation (for Observation Result)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.5-OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.6-NTE ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON 0..1 BackboneElement "ASSOCIATED_PERSON" "ASSOCIATED_PERSON"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Associated parties segment" "Associated parties segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.1-NK1 ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.2-GSP ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.3-GSR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER 0..1 BackboneElement "ASSOCIATED_RX_ORDER" "ASSOCIATED_RX_ORDER"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.1-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.1-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.1-RXE ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Pharmacy/Treatment)" "Participation (for Pharmacy/Treatment)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.2-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY 1..* BackboneElement "NK1_TIMING_QTY" "NK1_TIMING_QTY"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.3-NK1_TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.4-RXR 0..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.4-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.4-ASSOCIATED_RX_ORDER.4-RXR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN 0..* BackboneElement "ASSOCIATED_RX_ADMIN" "ASSOCIATED_RX_ADMIN"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy/Treatment Administration" "Pharmacy/Treatment Administration"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.1-RXA ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.2-RXR 0..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.2-RXR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Pharmacy Administration)" "Participation (for Pharmacy Administration)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.5-ASSOCIATED_RX_ADMIN.3-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.6-PRB 0..* http://hl7.org/v2/StructureDefinition/PRB "Detail Problem Segment" "Detail Problem Segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.6-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.6-PRB ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION 0..* BackboneElement "ASSOCIATED_OBSERVATION" "ASSOCIATED_OBSERVATION"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Results Segment" "Observation/Results Segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Result)" "Participation (for Observation Result)"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.7-ASSOCIATED_PERSON.7-ASSOCIATED_OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY 0..* BackboneElement "STUDY" "STUDY"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.1-CSR 1..1 http://hl7.org/v2/StructureDefinition/CSR "Clinical study registration" "Clinical study registration"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.1-CSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.1-CSR ^extension.valueCode = #A
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.2-CSP 0..* http://hl7.org/v2/StructureDefinition/CSP "Clinical study phase segment" "Clinical study phase segment"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.2-CSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-EXPERIENCE.2-PEX_OBSERVATION.2-PEX_CAUSE.8-STUDY.2-CSP ^extension.valueCode = #A