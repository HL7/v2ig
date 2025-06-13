Logical: OMP_O09
Parent: V2MessageStructure
Id: OMP_O09
Title: "HL7 v2 OMP_O09 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OMP_O09"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "OMP_O09"
* . ^definition = "OMP_O09 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Acccess Restrictions" "Acccess Restrictions"
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
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS 0..1 BackboneElement "ADDITIONAL_DEMOGRAPHICS" "ADDITIONAL_DEMOGRAPHICS"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.1-PD1 1..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.1-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.1-PD1 ^extension.valueCode = #A
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.2-GSP ^extension.valueCode = #A
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.3-GSR ^extension.valueCode = #A
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.4-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical UseSex Parameter for Clinical Use" "Sex Parameter for Clinical UseSex Parameter for Clinical Use"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.4-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.4-GSC ^extension.valueCode = #A
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Additional Demographics)" "Participation (for Additional Demographics)"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.2-ADDITIONAL_DEMOGRAPHICS.5-PRT ^extension.valueCode = #A
* 6-PATIENT.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.3-NTE ^extension.valueCode = #A
* 6-PATIENT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.4-ARV ^extension.valueCode = #B
* 6-PATIENT.5-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 6-PATIENT.5-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.5-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.5-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
* 6-PATIENT.5-PATIENT_VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-PATIENT_VISIT.2-PV2 ^extension.valueCode = #A
* 6-PATIENT.5-PATIENT_VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 6-PATIENT.5-PATIENT_VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-PATIENT_VISIT.3-PRT ^extension.valueCode = #A
* 6-PATIENT.5-PATIENT_VISIT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.5-PATIENT_VISIT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.5-PATIENT_VISIT.4-ARV ^extension.valueCode = #B
* 6-PATIENT.6-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 6-PATIENT.6-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 6-PATIENT.6-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-INSURANCE.1-IN1 ^extension.valueCode = #A
* 6-PATIENT.6-INSURANCE.2-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance Additional Information" "Insurance Additional Information"
* 6-PATIENT.6-INSURANCE.2-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-INSURANCE.2-IN2 ^extension.valueCode = #A
* 6-PATIENT.6-INSURANCE.3-IN3 0..1 http://hl7.org/v2/StructureDefinition/IN3 "Insurance Additional Information, Certification" "Insurance Additional Information, Certification"
* 6-PATIENT.6-INSURANCE.3-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-INSURANCE.3-IN3 ^extension.valueCode = #A
* 6-PATIENT.7-GT1 0..1 http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 6-PATIENT.7-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-GT1 ^extension.valueCode = #A
* 6-PATIENT.8-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 6-PATIENT.8-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-AL1 ^extension.valueCode = #A
* 7-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.1-ORC ^extension.valueCode = #A
* 7-ORDER.2-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.2-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.2-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.2-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.2-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.3-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 7-ORDER.3-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-RXO ^extension.valueCode = #A
* 7-ORDER.4-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXO)" "Participation (for RXO)"
* 7-ORDER.4-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-PRT ^extension.valueCode = #A
* 7-ORDER.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 7-ORDER.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-NTE ^extension.valueCode = #A
* 7-ORDER.6-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.6-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-RXR ^extension.valueCode = #A
* 7-ORDER.7-COMPONENT 0..* BackboneElement "COMPONENT" "COMPONENT"
* 7-ORDER.7-COMPONENT.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 7-ORDER.7-COMPONENT.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-COMPONENT.1-RXC ^extension.valueCode = #A
* 7-ORDER.7-COMPONENT.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 7-ORDER.7-COMPONENT.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-COMPONENT.2-NTE ^extension.valueCode = #A
* 7-ORDER.8-CDO 0..* http://hl7.org/v2/StructureDefinition/CDO "Cumulative Dosage Segment" "Cumulative Dosage Segment"
* 7-ORDER.8-CDO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.8-CDO ^extension.valueCode = #A
* 7-ORDER.9-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER.9-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 7-ORDER.9-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.9-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 7-ORDER.9-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.9-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 7-ORDER.9-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-OBSERVATION.3-NTE ^extension.valueCode = #A
* 7-ORDER.10-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Transaction" "Financial Transaction"
* 7-ORDER.10-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.10-FT1 ^extension.valueCode = #A
* 7-ORDER.11-BLG 0..1 http://hl7.org/v2/StructureDefinition/BLG "Billing Segment" "Billing Segment"
* 7-ORDER.11-BLG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.11-BLG ^extension.valueCode = #A