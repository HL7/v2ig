Logical: DFT_P03
Parent: V2MessageStructure
Id: DFT_P03
Title: "HL7 v2 DFT_P03 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "DFT_P03"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "DFT_P03"
* . ^definition = "DFT_P03 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PD1 ^extension.valueCode = #A
* 7-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSP ^extension.valueCode = #A
* 8-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSR ^extension.valueCode = #A
* 9-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSC ^extension.valueCode = #A
* 10-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PRT ^extension.valueCode = #A
* 11-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "*Role*" "*Role*"
* 11-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-ROL ^extension.valueCode = #
* 12-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 12-VISIT.1-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 12-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.1-PV1 ^extension.valueCode = #A
* 12-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 12-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.2-PV2 ^extension.valueCode = #A
* 12-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.3-PRT ^extension.valueCode = #A
* 12-VISIT.4-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "*Role*" "*Role*"
* 12-VISIT.4-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.4-ROL ^extension.valueCode = #
* 13-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 13-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-DB1 ^extension.valueCode = #A
* 14-COMMON_ORDER 0..* BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 14-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order (across all FT1s)" "Common Order (across all FT1s)"
* 14-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 14-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 14-COMMON_ORDER.3-TIMING_QUANTITY 0..* BackboneElement "TIMING_QUANTITY" "TIMING_QUANTITY"
* 14-COMMON_ORDER.3-TIMING_QUANTITY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 14-COMMON_ORDER.3-TIMING_QUANTITY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.3-TIMING_QUANTITY.1-TQ1 ^extension.valueCode = #A
* 14-COMMON_ORDER.3-TIMING_QUANTITY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 14-COMMON_ORDER.3-TIMING_QUANTITY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.3-TIMING_QUANTITY.2-TQ2 ^extension.valueCode = #A
* 14-COMMON_ORDER.4-ORDER 0..1 BackboneElement "ORDER" "ORDER"
* 14-COMMON_ORDER.4-ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Order Detail Segment" "Order Detail Segment"
* 14-COMMON_ORDER.4-ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.4-ORDER.1-OBR ^extension.valueCode = #A
* 14-COMMON_ORDER.4-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-COMMON_ORDER.4-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.4-ORDER.2-PRT ^extension.valueCode = #A
* 14-COMMON_ORDER.4-ORDER.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (on Order Detail)" "Notes and Comments (on Order Detail)"
* 14-COMMON_ORDER.4-ORDER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.4-ORDER.3-NTE ^extension.valueCode = #A
* 14-COMMON_ORDER.5-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 14-COMMON_ORDER.5-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observations / Result" "Observations / Result"
* 14-COMMON_ORDER.5-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.5-OBSERVATION.1-OBX ^extension.valueCode = #A
* 14-COMMON_ORDER.5-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 14-COMMON_ORDER.5-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.5-OBSERVATION.2-PRT ^extension.valueCode = #A
* 14-COMMON_ORDER.5-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (on Result)" "Notes and Comments (on Result)"
* 14-COMMON_ORDER.5-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-COMMON_ORDER.5-OBSERVATION.3-NTE ^extension.valueCode = #A
* 15-FINANCIAL 1..* BackboneElement "FINANCIAL" "FINANCIAL"
* 15-FINANCIAL.1-FT1 1..1 http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction" "Financial Transaction"
* 15-FINANCIAL.1-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.1-FT1 ^extension.valueCode = #A
* 15-FINANCIAL.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.3-ROL 1..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 15-FINANCIAL.3-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.3-ROL ^extension.valueCode = #A
* 15-FINANCIAL.4-NTE 1..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (on line item - FT1 - above)" "Notes and Comments (on line item - FT1 - above)"
* 15-FINANCIAL.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.4-NTE ^extension.valueCode = #A
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE 0..* BackboneElement "FINANCIAL_PROCEDURE" "FINANCIAL_PROCEDURE"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedure" "Procedure"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.1-PR1 ^extension.valueCode = #A
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.3-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.3-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.5-FINANCIAL_PROCEDURE.3-ROL ^extension.valueCode = #B
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE 0..* BackboneElement "FINANCIAL_OBSERVATION_STANDALONE" "FINANCIAL_OBSERVATION_STANDALONE"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation" "Observation"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.1-OBX ^extension.valueCode = #A
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comment (on Result)" "Notes and Comment (on Result)"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.6-FINANCIAL_OBSERVATION_STANDALONE.3-NTE ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE 0..* BackboneElement "FINANCIAL_ORDER_STANDALONE" "FINANCIAL_ORDER_STANDALONE"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Order Detail Segment" "Order Detail Segment"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.1-OBR ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comment (on Result)" "Notes and Comment (on Result)"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.3-NTE ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION 0..* BackboneElement "FINANCIAL_OBSERVATION" "FINANCIAL_OBSERVATION"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation" "Observation"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comment (on Result)" "Notes and Comment (on Result)"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.7-FINANCIAL_ORDER_STANDALONE.4-FINANCIAL_OBSERVATION.3-NTE ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER 0..* BackboneElement "FINANCIAL_COMMON_ORDER" "FINANCIAL_COMMON_ORDER"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order (specific to above FT1)" "Common Order (specific to above FT1)"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY 0..* BackboneElement "FINANCIAL_TIMING_QUANTITY" "FINANCIAL_TIMING_QUANTITY"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.1-TQ1 ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.3-FINANCIAL_TIMING_QUANTITY.2-TQ2 ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER 0..1 BackboneElement "FINANCIAL_ORDER" "FINANCIAL_ORDER"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Order Detail Segment" "Order Detail Segment"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.1-OBR ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (on Order Detail)" "Notes and Comments (on Order Detail)"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.4-FINANCIAL_ORDER.3-NTE ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION 0..* BackboneElement "FINANCIAL_OBSERVATION" "FINANCIAL_OBSERVATION"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observations / Result" "Observations / Result"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (on Result)" "Notes and Comments (on Result)"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-FINANCIAL.8-FINANCIAL_COMMON_ORDER.5-FINANCIAL_OBSERVATION.3-NTE ^extension.valueCode = #A
* 16-DIAGNOSIS 0..* BackboneElement "DIAGNOSIS" "DIAGNOSIS"
* 16-DIAGNOSIS.1-DG1 1..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis (global across all FT1s)" "Diagnosis (global across all FT1s)"
* 16-DIAGNOSIS.1-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-DIAGNOSIS.1-DG1 ^extension.valueCode = #A
* 17-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 17-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-DRG ^extension.valueCode = #A
* 18-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor (global across all FT1s)" "Guarantor (global across all FT1s)"
* 18-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-GT1 ^extension.valueCode = #A
* 19-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 19-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance (global across all FT1s)" "Insurance (global across all FT1s)"
* 19-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.1-IN1 ^extension.valueCode = #A
* 19-INSURANCE.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 19-INSURANCE.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.2-GSP ^extension.valueCode = #A
* 19-INSURANCE.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 19-INSURANCE.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.3-GSR ^extension.valueCode = #A
* 19-INSURANCE.4-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance - Additional Info." "Insurance - Additional Info."
* 19-INSURANCE.4-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.4-IN2 ^extension.valueCode = #A
* 19-INSURANCE.5-IN3 0..* http://hl7.org/v2/StructureDefinition/IN3 "Insurance - Add'l Info. - Cert." "Insurance - Add'l Info. - Cert."
* 19-INSURANCE.5-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.5-IN3 ^extension.valueCode = #A
* 19-INSURANCE.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 19-INSURANCE.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.6-PRT ^extension.valueCode = #A
* 19-INSURANCE.7-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 19-INSURANCE.7-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-INSURANCE.7-ROL ^extension.valueCode = #B
* 20-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 20-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 20-ACC ^extension.valueCode = #A