Logical: OML_O59
Parent: V2MessageStructure
Id: OML_O59
Title: "HL7 v2 OML_O59 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OML_O59"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "OML_O59"
* . ^definition = "OML_O59 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Header)" "Notes and Comments (for Header)"
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
* 6-PATIENT.7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-NTE ^extension.valueCode = #A
* 6-PATIENT.8-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 6-PATIENT.8-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-NK1 ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit- Additional Info" "Patient Visit- Additional Info"
* 6-PATIENT.9-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 6-PATIENT.9-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 6-PATIENT.10-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 6-PATIENT.10-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 6-PATIENT.10-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-INSURANCE.1-IN1 ^extension.valueCode = #A
* 6-PATIENT.10-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 6-PATIENT.10-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-INSURANCE.2-IN2 ^extension.valueCode = #A
* 6-PATIENT.10-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 6-PATIENT.10-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.10-INSURANCE.3-IN3 ^extension.valueCode = #A
* 6-PATIENT.11-GT1 0..1 http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 6-PATIENT.11-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.11-GT1 ^extension.valueCode = #A
* 6-PATIENT.12-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 6-PATIENT.12-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.12-AL1 ^extension.valueCode = #A
* 7-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.1-ORC ^extension.valueCode = #A
* 7-ORDER.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Order)" "Notes and Comments (for Order)"
* 7-ORDER.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-NTE ^extension.valueCode = #A
* 7-ORDER.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Common Order)" "Participation (for Common Order)"
* 7-ORDER.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-PRT ^extension.valueCode = #A
* 7-ORDER.4-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.4-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.4-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.4-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.4-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST 0..1 BackboneElement "OBSERVATION_REQUEST" "OBSERVATION_REQUEST"
* 7-ORDER.5-OBSERVATION_REQUEST.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 7-ORDER.5-OBSERVATION_REQUEST.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.1-OBR ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.2-TCD 0..1 http://hl7.org/v2/StructureDefinition/TCD "Test Code Details" "Test Code Details"
* 7-ORDER.5-OBSERVATION_REQUEST.2-TCD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.2-TCD ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Detail)" "Notes and Comments (for Detail)"
* 7-ORDER.5-OBSERVATION_REQUEST.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.3-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.4-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Request)" "Participation (for Observation Request)"
* 7-ORDER.5-OBSERVATION_REQUEST.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.4-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.5-CTD 0..1 http://hl7.org/v2/StructureDefinition/CTD "Contact Data" "Contact Data"
* 7-ORDER.5-OBSERVATION_REQUEST.5-CTD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.5-CTD ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.6-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 7-ORDER.5-OBSERVATION_REQUEST.6-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.6-DG1 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.7-REL 0..1 http://hl7.org/v2/StructureDefinition/REL "Relationship (Observation)" "Relationship (Observation)"
* 7-ORDER.5-OBSERVATION_REQUEST.7-REL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.7-REL ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for OBX)" "Participation (for OBX)"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.3-TCD 0..1 http://hl7.org/v2/StructureDefinition/TCD "Test Code Detail" "Test Code Detail"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.3-TCD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.3-TCD ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Results)" "Notes and Comments (for Results)"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.8-OBSERVATION.4-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN 0..* BackboneElement "SPECIMEN" "SPECIMEN"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.1-SPM ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Specimen)" "Notes and Comments (for Specimen)"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.2-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result related to specimen" "Observation/Result related to specimen"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen Observation)" "Participation (for Specimen Observation)"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER 0..* BackboneElement "CONTAINER" "CONTAINER"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container" "Specimen Container"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.1-SAC ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notest and Comments (for Specimen Container)" "Notest and Comments (for Specimen Container)"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.2-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION 0..* BackboneElement "CONTAINER_OBSERVATION" "CONTAINER_OBSERVATION"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result related to container" "Observation/Result related to container"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Container Observation)" "Participation (for Container Observation)"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.9-SPECIMEN.4-CONTAINER.3-CONTAINER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.10-IPC 0..1 http://hl7.org/v2/StructureDefinition/IPC "Imaging Procedure Control" "Imaging Procedure Control"
* 7-ORDER.5-OBSERVATION_REQUEST.10-IPC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.10-IPC ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.11-SGH 0..1 http://hl7.org/v2/StructureDefinition/SGH "Segment Group Header" "Segment Group Header"
* 7-ORDER.5-OBSERVATION_REQUEST.11-SGH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.11-SGH ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT 0..* BackboneElement "PRIOR_RESULT" "PRIOR_RESULT"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR 0..1 BackboneElement "PATIENT_PRIOR" "PATIENT_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification – previous result" "Patient Identification – previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.1-PID ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics – previous result" "Additional Demographics – previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.2-PD1 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.3-GSP ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.4-GSR ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.5-GSC ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Prior)" "Participation (for Patient Prior)"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.1-PATIENT_PRIOR.6-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR 0..1 BackboneElement "PATIENT_VISIT_PRIOR" "PATIENT_VISIT_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit – previous result" "Patient Visit – previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.1-PV1 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit Add. Info – previous result" "Patient Visit Add. Info – previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.2-PV2 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit Prior)" "Participation (for Patient Visit Prior)"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.2-PATIENT_VISIT_PRIOR.3-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.3-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information - previous result" "Allergy Information - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.3-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.3-AL1 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR 1..* BackboneElement "ORDER_PRIOR" "ORDER_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order - previous result" "Common Order - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.1-ORC ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.3-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Order Detail - previous result" "Order Detail - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.3-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.3-OBR ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments - previous result" "Notes and Comments - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.4-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR 0..* BackboneElement "OBSERVATION_PARTICIPATION_PRIOR" "OBSERVATION_PARTICIPATION_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.1-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order Prior)" "Participation (for Order Prior)"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.1-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.1-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.2-DEV 0..* http://hl7.org/v2/StructureDefinition/DEV "Device" "Device"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.2-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.5-OBSERVATION_PARTICIPATION_PRIOR.2-DEV ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR 0..* BackboneElement "TIMING_PRIOR" "TIMING_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.6-TIMING_PRIOR.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR 1..* BackboneElement "OBSERVATION_PRIOR" "OBSERVATION_PRIOR"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result - previous result" "Observation/Result - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.1-OBX ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Prior)" "Participation (for Observation Prior)"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.2-PRT ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments - previous result" "Notes and Comments - previous result"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.12-PRIOR_RESULT.4-ORDER_PRIOR.7-OBSERVATION_PRIOR.3-NTE ^extension.valueCode = #A
* 7-ORDER.5-OBSERVATION_REQUEST.13-SGT 0..1 http://hl7.org/v2/StructureDefinition/SGT "Segment Group Trailer" "Segment Group Trailer"
* 7-ORDER.5-OBSERVATION_REQUEST.13-SGT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-OBSERVATION_REQUEST.13-SGT ^extension.valueCode = #A
* 7-ORDER.6-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction" "Financial Transaction"
* 7-ORDER.6-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-FT1 ^extension.valueCode = #A
* 7-ORDER.7-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 7-ORDER.7-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-CTI ^extension.valueCode = #A
* 7-ORDER.8-BLG 0..1 http://hl7.org/v2/StructureDefinition/BLG "Billing Segment" "Billing Segment"
* 7-ORDER.8-BLG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.8-BLG ^extension.valueCode = #A