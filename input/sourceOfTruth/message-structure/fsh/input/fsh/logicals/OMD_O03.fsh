Logical: OMD_O03
Parent: V2MessageStructure
Id: OMD_O03
Title: "HL7 v2 OMD_O03 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OMD_O03"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "OMD_O03"
* . ^definition = "OMD_O03 Message Structure"
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
* 6-PATIENT.7-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.7-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-ARV ^extension.valueCode = #B
* 6-PATIENT.8-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.8-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-NTE ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_VISIT 0..1 BackboneElement "PATIENT_VISIT" "PATIENT_VISIT"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_VISIT.1-PV1 ^extension.valueCode = #A
* 6-PATIENT.9-PATIENT_VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit – Additional Info" "Patient Visit – Additional Info"
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
* 7-ORDER_DIET 1..* BackboneElement "ORDER_DIET" "ORDER_DIET"
* 7-ORDER_DIET.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order Segment" "Common Order Segment"
* 7-ORDER_DIET.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.1-ORC ^extension.valueCode = #A
* 7-ORDER_DIET.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER_DIET.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.2-PRT ^extension.valueCode = #A
* 7-ORDER_DIET.3-TIMING_DIET 0..* BackboneElement "TIMING_DIET" "TIMING_DIET"
* 7-ORDER_DIET.3-TIMING_DIET.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER_DIET.3-TIMING_DIET.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.3-TIMING_DIET.1-TQ1 ^extension.valueCode = #A
* 7-ORDER_DIET.3-TIMING_DIET.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER_DIET.3-TIMING_DIET.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.3-TIMING_DIET.2-TQ2 ^extension.valueCode = #A
* 7-ORDER_DIET.4-DIET 0..1 BackboneElement "DIET" "DIET"
* 7-ORDER_DIET.4-DIET.1-ODS 1..* http://hl7.org/v2/StructureDefinition/ODS "Dietary Orders, Suppl., Prefer." "Dietary Orders, Suppl., Prefer."
* 7-ORDER_DIET.4-DIET.1-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.4-DIET.1-ODS ^extension.valueCode = #A
* 7-ORDER_DIET.4-DIET.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for ODS)" "Notes and Comments (for ODS)"
* 7-ORDER_DIET.4-DIET.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.4-DIET.2-NTE ^extension.valueCode = #A
* 7-ORDER_DIET.4-DIET.3-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER_DIET.4-DIET.3-OBSERVATION.3-NTE ^extension.valueCode = #A
* 8-ORDER_TRAY 0..* BackboneElement "ORDER_TRAY" "ORDER_TRAY"
* 8-ORDER_TRAY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order Segment" "Common Order Segment"
* 8-ORDER_TRAY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.1-ORC ^extension.valueCode = #A
* 8-ORDER_TRAY.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-ORDER_TRAY.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.2-PRT ^extension.valueCode = #A
* 8-ORDER_TRAY.3-TIMING_TRAY 0..* BackboneElement "TIMING_TRAY" "TIMING_TRAY"
* 8-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 ^extension.valueCode = #A
* 8-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 ^extension.valueCode = #A
* 8-ORDER_TRAY.4-ODT 1..* http://hl7.org/v2/StructureDefinition/ODT "Diet Tray Instructions" "Diet Tray Instructions"
* 8-ORDER_TRAY.4-ODT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.4-ODT ^extension.valueCode = #A
* 8-ORDER_TRAY.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for ODT)" "Notes and Comments (for ODT)"
* 8-ORDER_TRAY.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-ORDER_TRAY.5-NTE ^extension.valueCode = #A