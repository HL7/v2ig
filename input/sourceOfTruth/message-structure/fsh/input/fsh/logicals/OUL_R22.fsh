Logical: OUL_R22
Parent: V2MessageStructure
Id: OUL_R22
Title: "HL7 v2 OUL_R22 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OUL_R22"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "OUL_R22"
* . ^definition = "OUL_R22 Message Structure"
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
* 6-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 6-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 6-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.1-PID ^extension.valueCode = #A
* 6-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-PD1 ^extension.valueCode = #A
* 6-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.3-GSP ^extension.valueCode = #A
* 6-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 6-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.4-GSR ^extension.valueCode = #A
* 6-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 6-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-GSC ^extension.valueCode = #A
* 6-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 6-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-PRT ^extension.valueCode = #A
* 6-PATIENT.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9" "For backwards compatibility only as of V2.9"
* 6-PATIENT.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-ARV ^extension.valueCode = #B
* 6-PATIENT.8-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.8-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-NTE ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_OBSERVATION 0..* BackboneElement "PATIENT_OBSERVATION" "PATIENT_OBSERVATION"
* 6-PATIENT.9-PATIENT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation (for Patient ID)" "Observation (for Patient ID)"
* 6-PATIENT.9-PATIENT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 6-PATIENT.9-PATIENT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 6-PATIENT.10-VISIT 0..1 BackboneElement "VISIT" "VISIT"
* 6-PATIENT.10-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.10-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.10-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Information" "Patient Visit – Additional Information"
* 6-PATIENT.10-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-VISIT.2-PV2 ^extension.valueCode = #A
* 6-PATIENT.10-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 6-PATIENT.10-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-VISIT.3-PRT ^extension.valueCode = #A
* 7-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 7-NEXT_OF_KIN.1-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin" "Next of Kin"
* 7-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 7-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 7-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 8-SPECIMEN 1..* BackboneElement "SPECIMEN" "SPECIMEN"
* 8-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen information" "Specimen information"
* 8-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.1-SPM ^extension.valueCode = #A
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Result (for Specimen)" "Observation Result (for Specimen)"
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen Observation)" "Participation (for Specimen Observation)"
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 8-SPECIMEN.3-CONTAINER 0..* BackboneElement "CONTAINER" "CONTAINER"
* 8-SPECIMEN.3-CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Container information" "Container information"
* 8-SPECIMEN.3-CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.3-CONTAINER.1-SAC ^extension.valueCode = #A
* 8-SPECIMEN.3-CONTAINER.2-INV 0..1 http://hl7.org/v2/StructureDefinition/INV "Detailed Substance information (e.g., id, lot, manufacturer, ... of QC specimen)" "Detailed Substance information (e.g., id, lot, manufacturer, ... of QC specimen)"
* 8-SPECIMEN.3-CONTAINER.2-INV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.3-CONTAINER.2-INV ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 8-SPECIMEN.4-ORDER.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Order" "Observation Order"
* 8-SPECIMEN.4-ORDER.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.1-OBR ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for observation)" "Participation (for observation)"
* 8-SPECIMEN.4-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.2-PRT ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER 0..1 BackboneElement "COMMON_ORDER" "COMMON_ORDER"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.1-ORC ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for common order)" "Participation (for common order)"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.2-PRT ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT 0..1 BackboneElement "ORDER_DOCUMENT" "ORDER_DOCUMENT"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation containing Document" "Observation containing Document"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.1-OBX ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.2-PRT ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA 1..1 http://hl7.org/v2/StructureDefinition/TXA "Transcription Document Header" "Transcription Document Header"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.3-COMMON_ORDER.3-ORDER_DOCUMENT.3-TXA ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Detail)" "Notes and Comments (for Detail)"
* 8-SPECIMEN.4-ORDER.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.4-NTE ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Deprecated as of V2.8" "Deprecated as of V2.8"
* 8-SPECIMEN.4-ORDER.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.5-PRT ^extension.valueCode = #D
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY 0..* BackboneElement "TIMING_QTY" "TIMING_QTY"
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.1-TQ1 ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.6-TIMING_QTY.2-TQ2 ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.7-RESULT 0..* BackboneElement "RESULT" "RESULT"
* 8-SPECIMEN.4-ORDER.7-RESULT.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation Result" "Observation Result"
* 8-SPECIMEN.4-ORDER.7-RESULT.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.1-OBX ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.7-RESULT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Result)" "Participation (for Observation Result)"
* 8-SPECIMEN.4-ORDER.7-RESULT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.2-PRT ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.7-RESULT.3-TCD 0..1 http://hl7.org/v2/StructureDefinition/TCD "Test Code Detail" "Test Code Detail"
* 8-SPECIMEN.4-ORDER.7-RESULT.3-TCD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.3-TCD ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.7-RESULT.4-SID 1..* http://hl7.org/v2/StructureDefinition/SID "Substance Identifier (e.g., reagents used for testing)" "Substance Identifier (e.g., reagents used for testing)"
* 8-SPECIMEN.4-ORDER.7-RESULT.4-SID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.4-SID ^extension.valueCode = #B
* 8-SPECIMEN.4-ORDER.7-RESULT.5-INV 0..* http://hl7.org/v2/StructureDefinition/INV "Inventory Detail (Detailed substance data, e.g., reagents used for testing)" "Inventory Detail (Detailed substance data, e.g., reagents used for testing)"
* 8-SPECIMEN.4-ORDER.7-RESULT.5-INV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.5-INV ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.7-RESULT.6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments" "Notes and Comments"
* 8-SPECIMEN.4-ORDER.7-RESULT.6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.7-RESULT.6-NTE ^extension.valueCode = #A
* 8-SPECIMEN.4-ORDER.8-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 8-SPECIMEN.4-ORDER.8-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-SPECIMEN.4-ORDER.8-CTI ^extension.valueCode = #A
* 9-DEVICE 0..* BackboneElement "DEVICE" "DEVICE"
* 9-DEVICE.1-DEV 1..1 http://hl7.org/v2/StructureDefinition/DEV "Device (for Participation)" "Device (for Participation)"
* 9-DEVICE.1-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DEVICE.1-DEV ^extension.valueCode = #A
* 9-DEVICE.2-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 9-DEVICE.2-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-DEVICE.2-OBX ^extension.valueCode = #A
* 10-DSC 0..1 http://hl7.org/v2/StructureDefinition/DSC "Continuation Pointer" "Continuation Pointer"
* 10-DSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-DSC ^extension.valueCode = #A