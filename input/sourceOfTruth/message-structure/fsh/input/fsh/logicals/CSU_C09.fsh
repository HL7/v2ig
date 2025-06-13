Logical: CSU_C09
Parent: V2MessageStructure
Id: CSU_C09
Title: "HL7 v2 CSU_C09 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "CSU_C09"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "CSU_C09"
* . ^definition = "CSU_C09 Message Structure"
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
* 5-PATIENT 1..* BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.2-PD1 ^extension.valueCode = #A
* 5-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.3-GSP ^extension.valueCode = #A
* 5-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.4-GSR ^extension.valueCode = #A
* 5-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 5-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.5-GSC ^extension.valueCode = #A
* 5-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 5-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-PRT ^extension.valueCode = #A
* 5-PATIENT.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 5-PATIENT.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.7-ARV ^extension.valueCode = #B
* 5-PATIENT.8-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and comments" "Notes and comments"
* 5-PATIENT.8-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.8-NTE ^extension.valueCode = #A
* 5-PATIENT.9-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 5-PATIENT.9-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT.9-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.9-VISIT.1-PV1 ^extension.valueCode = #A
* 5-PATIENT.9-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 5-PATIENT.9-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.9-VISIT.2-PV2 ^extension.valueCode = #A
* 5-PATIENT.9-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 5-PATIENT.9-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.9-VISIT.3-PRT ^extension.valueCode = #A
* 5-PATIENT.10-CSR 1..1 http://hl7.org/v2/StructureDefinition/CSR "Clinical Study Registration" "Clinical Study Registration"
* 5-PATIENT.10-CSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.10-CSR ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE 1..* BackboneElement "STUDY_PHASE" "STUDY_PHASE"
* 5-PATIENT.11-STUDY_PHASE.1-CSP 0..1 http://hl7.org/v2/StructureDefinition/CSP "Clinical Study Phase" "Clinical Study Phase"
* 5-PATIENT.11-STUDY_PHASE.1-CSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.1-CSP ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE 1..* BackboneElement "STUDY_SCHEDULE" "STUDY_SCHEDULE"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.1-CSS 0..1 http://hl7.org/v2/StructureDefinition/CSS "Clinical Study Data Schedule" "Clinical Study Data Schedule"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.1-CSS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.1-CSS ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION 1..* BackboneElement "STUDY_OBSERVATION" "STUDY_OBSERVATION"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME 0..1 BackboneElement "FIXME" "FIXME"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.1-ORC ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for common order)" "Participation (for common order)"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.1-FIXME.2-PRT ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.2-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Battery" "Observation Battery"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.2-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.2-OBR ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for observation)" "Participation (for observation)"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.3-PRT ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY 0..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.4-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.5-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Results" "Observation Results"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.5-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.5-OBX ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participaton (for Observation Results)" "Participaton (for Observation Results)"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.2-STUDY_OBSERVATION.6-PRT ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM 1..* BackboneElement "STUDY_PHARM" "STUDY_PHARM"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER 0..1 BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Common Order)" "Participation (for Common Order)"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.1-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN 1..* BackboneElement "RX_ADMIN" "RX_ADMIN"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.1-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy Administration" "Pharmacy Administration"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.1-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.1-RXA ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.2-RXR 1..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy Route" "Pharmacy Route"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.2-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.2-RXR ^extension.valueCode = #A
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Pharmacy Administration)" "Participation (for Pharmacy Administration)"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-STUDY_PHASE.2-STUDY_SCHEDULE.3-STUDY_PHARM.2-RX_ADMIN.3-PRT ^extension.valueCode = #A