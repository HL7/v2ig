Logical: OPL_O37
Parent: V2MessageStructure
Id: OPL_O37
Title: "HL7 v2 OPL_O37 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OPL_O37"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "OPL_O37"
* . ^definition = "OPL_O37 Message Structure"
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
* 5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for header)" "Notes and Comments (for header)"
* 5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-NTE ^extension.valueCode = #A
* 6-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PRT ^extension.valueCode = #A
* 7-GUARANTOR 0..1 BackboneElement "GUARANTOR" "GUARANTOR"
* 7-GUARANTOR.1-GT1 1..1 http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 7-GUARANTOR.1-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GUARANTOR.1-GT1 ^extension.valueCode = #A
* 7-GUARANTOR.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Guarantor)" "Notes and Comments (for Guarantor)"
* 7-GUARANTOR.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GUARANTOR.2-NTE ^extension.valueCode = #A
* 8-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 8-ORDER.1-NK1 1..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 8-ORDER.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.1-NK1 ^extension.valueCode = #A
* 8-ORDER.2-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 8-ORDER.2-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient" "Patient"
* 8-ORDER.2-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.1-PID ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Patient Additional Demographics" "Patient Additional Demographics"
* 8-ORDER.2-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.2-PD1 ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-ORDER.2-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.3-GSP ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-ORDER.2-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.4-GSR ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 8-ORDER.2-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.5-GSC ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 8-ORDER.2-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.6-PRT ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 8-ORDER.2-PATIENT.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.7-ARV ^extension.valueCode = #B
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT 0..* BackboneElement "OBSERVATIONS_ON_PATIENT" "OBSERVATIONS_ON_PATIENT"
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observations on the Patient" "Observations on the Patient"
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.1-OBX ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observations on Patient)" "Participation (for Observations on Patient)"
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.8-OBSERVATIONS_ON_PATIENT.2-PRT ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.9-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 8-ORDER.2-PATIENT.9-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 8-ORDER.2-PATIENT.9-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.9-INSURANCE.1-IN1 ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.9-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 8-ORDER.2-PATIENT.9-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.9-INSURANCE.2-IN2 ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.9-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 8-ORDER.2-PATIENT.9-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.9-INSURANCE.3-IN3 ^extension.valueCode = #A
* 8-ORDER.2-PATIENT.10-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 8-ORDER.2-PATIENT.10-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.2-PATIENT.10-AL1 ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN 1..* BackboneElement "SPECIMEN" "SPECIMEN"
* 8-ORDER.3-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 8-ORDER.3-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.1-SPM ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result related to specimen" "Observation/Result related to specimen"
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen Observation)" "Participation (for Specimen Observation)"
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.3-CONTAINER 0..* BackboneElement "CONTAINER" "CONTAINER"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container" "Specimen Container"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.1-SAC ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION 0..* BackboneElement "CONTAINER_OBSERVATION" "CONTAINER_OBSERVATION"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result related to container" "Observation/Result related to container"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Containter Observation)" "Participation (for Containter Observation)"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.3-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST 1..* BackboneElement "OBSERVATION_REQUEST" "OBSERVATION_REQUEST"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.1-ORC ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.2-PRT ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.3-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.3-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.3-OBR ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.4-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Request)" "Participation (for Observation Request)"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.4-PRT ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.1-TQ1 ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.5-TIMING.2-TQ2 ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.6-TCD 0..1 http://hl7.org/v2/StructureDefinition/TCD "Test Code Details" "Test Code Details"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.6-TCD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.6-TCD ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.7-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.7-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.7-DG1 ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION 0..* BackboneElement "ORDER_RELATED_OBSERVATION" "ORDER_RELATED_OBSERVATION"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Related to Order" "Observation/Result Related to Order"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order Related Observation)" "Participation (for Order Related Observation)"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.3-SPECIMEN.4-OBSERVATION_REQUEST.8-ORDER_RELATED_OBSERVATION.2-PRT ^extension.valueCode = #A
* 8-ORDER.4-SGH 0..1 http://hl7.org/v2/StructureDefinition/SGH "Segment Group Header" "Segment Group Header"
* 8-ORDER.4-SGH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.4-SGH ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT 0..1 BackboneElement "PRIOR_RESULT" "PRIOR_RESULT"
* 8-ORDER.5-PRIOR_RESULT.1-NK1 1..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 8-ORDER.5-PRIOR_RESULT.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.1-NK1 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR 0..1 BackboneElement "PATIENT_PRIOR" "PATIENT_PRIOR"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient" "Patient"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.1-PID ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Patient Additional Demographics" "Patient Additional Demographics"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.2-PD1 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.3-GSP ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.4-GSR ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.5-GSC ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Prior)" "Participation (for Patient Prior)"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.6-PRT ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.2-PATIENT_PRIOR.7-ARV ^extension.valueCode = #B
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR 0..1 BackboneElement "PATIENT_VISIT_PRIOR" "PATIENT_VISIT_PRIOR"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.1-PV1 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Information" "Patient Visit – Additional Information"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.2-PV2 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit Prior)" "Participation (for Patient Visit Prior)"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.3-PATIENT_VISIT_PRIOR.3-PRT ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.4-AL1 0..1 http://hl7.org/v2/StructureDefinition/AL1 "Patient Allergy Information" "Patient Allergy Information"
* 8-ORDER.5-PRIOR_RESULT.4-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.4-AL1 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR 1..* BackboneElement "ORDER_PRIOR" "ORDER_PRIOR"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.1-OBR ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.2-ORC 0..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.2-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.2-ORC ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR 0..* BackboneElement "OBSERVATION_PARTICIPATION_PRIOR" "OBSERVATION_PARTICIPATION_PRIOR"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.1-PRT 1..1 http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order Prior)" "Participation (for Order Prior)"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.1-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.1-PRT ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.2-DEV 0..* http://hl7.org/v2/StructureDefinition/DEV "Device" "Device"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.2-DEV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.3-OBSERVATION_PARTICIPATION_PRIOR.2-DEV ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING 0..1 BackboneElement "TIMING" "TIMING"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.1-TQ1 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Relationship" "Timing/Quantity Relationship"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.4-TIMING.2-TQ2 ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP 1..* BackboneElement "OBSERVATION_RESULT_GROUP" "OBSERVATION_RESULT_GROUP"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result for prior order" "Observation/Result for prior order"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.1-OBX ^extension.valueCode = #A
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation/Result)" "Participation (for Observation/Result)"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.5-PRIOR_RESULT.5-ORDER_PRIOR.5-OBSERVATION_RESULT_GROUP.2-PRT ^extension.valueCode = #A
* 8-ORDER.6-SGT 0..1 http://hl7.org/v2/StructureDefinition/SGT "Segment Group Trailer" "Segment Group Trailer"
* 8-ORDER.6-SGT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.6-SGT ^extension.valueCode = #A
* 8-ORDER.7-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction" "Financial Transaction"
* 8-ORDER.7-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.7-FT1 ^extension.valueCode = #A
* 8-ORDER.8-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 8-ORDER.8-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.8-CTI ^extension.valueCode = #A
* 8-ORDER.9-BLG 0..1 http://hl7.org/v2/StructureDefinition/BLG "Billing Segment" "Billing Segment"
* 8-ORDER.9-BLG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER.9-BLG ^extension.valueCode = #A