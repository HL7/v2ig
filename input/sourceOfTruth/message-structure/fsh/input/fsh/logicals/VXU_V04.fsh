Logical: VXU_V04
Parent: V2MessageStructure
Id: VXU_V04
Title: "HL7 v2 VXU_V04 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "VXU_V04"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "VXU_V04"
* . ^definition = "VXU_V04 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header Segment" "Message Header Segment"
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
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification Segment" "Patient Identification Segment"
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
* 11-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 11-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-NK1 ^extension.valueCode = #A
* 12-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 12-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-GSP ^extension.valueCode = #A
* 13-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 13-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 13-GSR ^extension.valueCode = #A
* 14-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 14-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 14-ARV ^extension.valueCode = #B
* 15-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 15-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 15-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 15-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 15-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 15-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 15-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 15-PATIENT_VISIT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 15-PATIENT_VISIT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 15-PATIENT_VISIT.4-ARV ^extension.valueCode = #B
* 16-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 16-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 16-GT1 ^extension.valueCode = #A
* 17-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 17-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 17-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-INSURANCE.1-IN1 ^extension.valueCode = #A
* 17-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 17-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-INSURANCE.2-IN2 ^extension.valueCode = #A
* 17-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 17-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 17-INSURANCE.3-IN3 ^extension.valueCode = #A
* 18-PERSON_OBSERVATION 0..* BackboneElement "PERSON_OBSERVATION" "PERSON_OBSERVATION"
* 18-PERSON_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 18-PERSON_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PERSON_OBSERVATION.1-OBX ^extension.valueCode = #A
* 18-PERSON_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 18-PERSON_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PERSON_OBSERVATION.2-PRT ^extension.valueCode = #A
* 18-PERSON_OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes (Regarding Patient Observation)" "Notes (Regarding Patient Observation)"
* 18-PERSON_OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 18-PERSON_OBSERVATION.3-NTE ^extension.valueCode = #A
* 19-ORDER 0..* BackboneElement "ORDER" "ORDER"
* 19-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 19-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.1-ORC ^extension.valueCode = #A
* 19-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for ORC)" "Participation (for ORC)"
* 19-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.2-PRT ^extension.valueCode = #A
* 19-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 19-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 19-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 19-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 19-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 19-ORDER.4-RXA 1..1 http://hl7.org/v2/StructureDefinition/RXA "Pharmacy Administration Segment" "Pharmacy Administration Segment"
* 19-ORDER.4-RXA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.4-RXA ^extension.valueCode = #A
* 19-ORDER.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 19-ORDER.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.5-PRT ^extension.valueCode = #A
* 19-ORDER.6-RXR 0..1 http://hl7.org/v2/StructureDefinition/RXR "Pharmacy Route" "Pharmacy Route"
* 19-ORDER.6-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.6-RXR ^extension.valueCode = #A
* 19-ORDER.7-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 19-ORDER.7-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 19-ORDER.7-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.7-OBSERVATION.1-OBX ^extension.valueCode = #A
* 19-ORDER.7-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 19-ORDER.7-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.7-OBSERVATION.2-PRT ^extension.valueCode = #A
* 19-ORDER.7-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes (Regarding Immunization)" "Notes (Regarding Immunization)"
* 19-ORDER.7-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 19-ORDER.7-OBSERVATION.3-NTE ^extension.valueCode = #A