Logical: OPU_R25
Parent: V2MessageStructure
Id: OPU_R25
Title: "HL7 v2 OPU_R25 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OPU_R25"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "OPU_R25"
* . ^definition = "OPU_R25 Message Structure"
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
* 5-NTE 0..1 http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-NTE ^extension.valueCode = #A
* 6-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PV1 ^extension.valueCode = #A
* 7-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Information" "Patient Visit – Additional Information"
* 7-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-PV2 ^extension.valueCode = #A
* 8-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 8-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PRT ^extension.valueCode = #A
* 9-PATIENT_VISIT_OBSERVATION 0..* BackboneElement "PATIENT_VISIT_OBSERVATION" "PATIENT_VISIT_OBSERVATION"
* 9-PATIENT_VISIT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation on the Visit" "Observation on the Visit"
* 9-PATIENT_VISIT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PATIENT_VISIT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 9-PATIENT_VISIT_OBSERVATION.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments on Visit" "Notes and Comments on Visit"
* 9-PATIENT_VISIT_OBSERVATION.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PATIENT_VISIT_OBSERVATION.2-NTE ^extension.valueCode = #A
* 9-PATIENT_VISIT_OBSERVATION.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 9-PATIENT_VISIT_OBSERVATION.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-PATIENT_VISIT_OBSERVATION.3-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL 1..* BackboneElement "ACCESSION_DETAIL" "ACCESSION_DETAIL"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN 1..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.1-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 10-ACCESSION_DETAIL.2-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient" "Patient"
* 10-ACCESSION_DETAIL.2-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.1-PID ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 10-ACCESSION_DETAIL.2-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.2-PD1 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 10-ACCESSION_DETAIL.2-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.3-GSP ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 10-ACCESSION_DETAIL.2-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.4-GSR ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 10-ACCESSION_DETAIL.2-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.5-GSC ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 10-ACCESSION_DETAIL.2-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.6-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.7-OH1 0..* http://hl7.org/v2/StructureDefinition/OH1 "Employment Status" "Employment Status"
* 10-ACCESSION_DETAIL.2-PATIENT.7-OH1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.7-OH1 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.8-OH2 0..* http://hl7.org/v2/StructureDefinition/OH2 "Past or Present Job" "Past or Present Job"
* 10-ACCESSION_DETAIL.2-PATIENT.8-OH2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.8-OH2 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.9-OH3 0..1 http://hl7.org/v2/StructureDefinition/OH3 "Usual Work" "Usual Work"
* 10-ACCESSION_DETAIL.2-PATIENT.9-OH3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.9-OH3 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.10-OH4 0..* http://hl7.org/v2/StructureDefinition/OH4 "Combat Zone Work" "Combat Zone Work"
* 10-ACCESSION_DETAIL.2-PATIENT.10-OH4 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.10-OH4 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.11-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 10-ACCESSION_DETAIL.2-PATIENT.11-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.11-ARV ^extension.valueCode = #B
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION 0..* BackboneElement "PATIENT_OBSERVATION" "PATIENT_OBSERVATION"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observations on Patient" "Observations on Patient"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation on Patient)" "Participation (for Observation on Patient)"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for Observation on Patient" "Notes and Comments for Observation on Patient"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.2-PATIENT.12-PATIENT_OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN 1..* BackboneElement "SPECIMEN" "SPECIMEN"
* 10-ACCESSION_DETAIL.3-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 10-ACCESSION_DETAIL.3-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.1-SPM ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation on Specimen" "Observation on Specimen"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for Observation on Specimen" "Notes and Comments for Observation on Specimen"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.2-SPECIMEN_OBSERVATION.3-NTE ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER 0..* BackboneElement "CONTAINER" "CONTAINER"
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Container information" "Container information"
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.1-SAC ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.2-INV 0..1 http://hl7.org/v2/StructureDefinition/INV "Detailed Substance information (e.g., id, lot, manufacturer, ... of QC specimen)" "Detailed Substance information (e.g., id, lot, manufacturer, ... of QC specimen)"
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.2-INV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.3-CONTAINER.2-INV ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Order" "Observation Order"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.1-OBR ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for observation)" "Participation (for observation)"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.2-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER 0..1 BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for common order)" "Participation (for common order)"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Detail)" "Notes and Comments (for Detail)"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.4-NTE ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Deprecated as of V2.8" "Deprecated as of V2.8"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.5-PRT ^extension.valueCode = #D
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY 0..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT 1..* BackboneElement "RESULT" "RESULT"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Result" "Observation Result"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.1-OBX ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.2-PRT ^extension.valueCode = #A
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ACCESSION_DETAIL.3-SPECIMEN.4-ORDER.7-RESULT.3-NTE ^extension.valueCode = #A