Logical: PPG_PCG
Parent: V2MessageStructure
Id: PPG_PCG
Title: "HL7 v2 PPG_PCG Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "PPG_PCG"
* ^date = "2025-06-13T21:11:36Z"
* . ^short = "PPG_PCG"
* . ^definition = "PPG_PCG Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 4-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-PID ^extension.valueCode = #A
* 5-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-GSP ^extension.valueCode = #A
* 6-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 6-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-GSR ^extension.valueCode = #A
* 7-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 7-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSC ^extension.valueCode = #A
* 8-PROVIDER 1..* BackboneElement "PROVIDER" "PROVIDER"
* 8-PROVIDER.1-PRD 1..1 http://hl7.org/v2/StructureDefinition/PRD "Provider Data" "Provider Data"
* 8-PROVIDER.1-PRD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PROVIDER.1-PRD ^extension.valueCode = #A
* 8-PROVIDER.2-CTD 0..* http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 8-PROVIDER.2-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PROVIDER.2-CTD ^extension.valueCode = #A
* 9-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 9-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 9-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 9-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit" "Patient Visit"
* 9-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 10-PATHWAY 1..* BackboneElement "PATHWAY" "PATHWAY"
* 10-PATHWAY.1-PTH 1..1 http://hl7.org/v2/StructureDefinition/PTH "Pathway Detail" "Pathway Detail"
* 10-PATHWAY.1-PTH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.1-PTH ^extension.valueCode = #A
* 10-PATHWAY.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments(Pathway Comments)" "Notes & Comments(Pathway Comments)"
* 10-PATHWAY.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.2-NTE ^extension.valueCode = #A
* 10-PATHWAY.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Pathway)" "Variance (Pathway)"
* 10-PATHWAY.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.4-PATHWAY_PARTICIPATION 0..* BackboneElement "PATHWAY_PARTICIPATION" "PATHWAY_PARTICIPATION"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.1-ROL 1..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.1-ROL ^extension.valueCode = #B
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.2-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Pathway)" "Participation (Pathway)"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Participation)" "Variance (Participation)"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.4-PATHWAY_PARTICIPATION.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL 0..* BackboneElement "GOAL" "GOAL"
* 10-PATHWAY.5-GOAL.1-GOL 1..1 http://hl7.org/v2/StructureDefinition/GOL "Detail Goal" "Detail Goal"
* 10-PATHWAY.5-GOAL.1-GOL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.1-GOL ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments(Goal Comments)" "Notes & Comments(Goal Comments)"
* 10-PATHWAY.5-GOAL.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.2-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Goal)" "Variance (Goal)"
* 10-PATHWAY.5-GOAL.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION 0..* BackboneElement "GOAL_PARTICIPATION" "GOAL_PARTICIPATION"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.1-ROL 1..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.1-ROL ^extension.valueCode = #B
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.2-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Goal)" "Participation (Goal)"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Participation)" "Variance (Participation)"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.4-GOAL_PARTICIPATION.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION 0..* BackboneElement "GOAL_OBSERVATION" "GOAL_OBSERVATION"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments(Observation/Result Comments)" "Notes & Comments(Observation/Result Comments)"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.5-GOAL_OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM 0..* BackboneElement "PROBLEM" "PROBLEM"
* 10-PATHWAY.5-GOAL.6-PROBLEM.1-PRB 1..1 http://hl7.org/v2/StructureDefinition/PRB "Detail Problem" "Detail Problem"
* 10-PATHWAY.5-GOAL.6-PROBLEM.1-PRB ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.1-PRB ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments (Problem Comments)" "Notes & Comments (Problem Comments)"
* 10-PATHWAY.5-GOAL.6-PROBLEM.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.2-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Problem)" "Variance (Problem)"
* 10-PATHWAY.5-GOAL.6-PROBLEM.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION 0..* BackboneElement "PROBLEM_PARTICIPATION" "PROBLEM_PARTICIPATION"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.1-ROL 1..1 http://hl7.org/v2/StructureDefinition/ROL "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.1-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.1-ROL ^extension.valueCode = #B
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.2-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (Problem)" "Participation (Problem)"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Participation)" "Variance (Participation)"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.4-PROBLEM_PARTICIPATION.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION 0..* BackboneElement "PROBLEM_OBSERVATION" "PROBLEM_OBSERVATION"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments(Observation/Result Comments)" "Notes & Comments(Observation/Result Comments)"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.6-PROBLEM.5-PROBLEM_OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER 0..* BackboneElement "ORDER" "ORDER"
* 10-PATHWAY.5-GOAL.7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 10-PATHWAY.5-GOAL.7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.1-ORC ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE 1..1 BackboneElement "CHOICE" "CHOICE"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-1-OBR 0..1 http://hl7.org/v2/StructureDefinition/OBR "Order Detail Segment" "Choice 1 within CHOICE"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-1-OBR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-2-Hxx 0..1 http://hl7.org/v2/StructureDefinition/Hxx "etc." "Choice 2 within CHOICE"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-2-Hxx ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.1-CHOICE.choice-2-Hxx ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments (Order Detail Comments)" "Notes & Comments (Order Detail Comments)"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.2-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.3-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Order)" "Variance (Order)"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.3-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.3-VAR ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION 0..* BackboneElement "ORDER_OBSERVATION" "ORDER_OBSERVATION"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes & Comments(Observation Comments)" "Notes & Comments(Observation Comments)"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.4-VAR 0..* http://hl7.org/v2/StructureDefinition/VAR "Variance (Observation/Result)" "Variance (Observation/Result)"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.4-VAR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PATHWAY.5-GOAL.7-ORDER.2-ORDER_DETAIL.4-ORDER_OBSERVATION.4-VAR ^extension.valueCode = #A