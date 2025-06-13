Logical: RDE_O11-B
Parent: V2MessageStructure
Id: RDE_O11-B
Title: "HL7 v2 RDE_O11-B Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "RDE_O11-B"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "RDE_O11-B"
* . ^definition = "RDE_O11-B Message Structure"
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
* 6-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Additional Demographics)" "Participation (for Additional Demographics)"
* 6-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.6-PRT ^extension.valueCode = #A
* 6-PATIENT.7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 6-PATIENT.7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.7-NTE ^extension.valueCode = #A
* 6-PATIENT.8-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.8-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.8-ARV ^extension.valueCode = #B
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
* 6-PATIENT.9-PATIENT_VISIT.4-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 6-PATIENT.9-PATIENT_VISIT.4-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PATIENT.9-PATIENT_VISIT.4-ARV ^extension.valueCode = #B
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
* 7-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order)" "Participation (for Order)"
* 7-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-PRT ^extension.valueCode = #A
* 7-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 7-ORDER.4-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Prescription Order" "Pharmacy/Treatment Prescription Order"
* 7-ORDER.4-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXO)" "Participation (for RXO)"
* 7-ORDER.4-ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 7-ORDER.4-ORDER_DETAIL.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.3-NTE ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.4-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.4-ORDER_DETAIL.4-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.4-RXR ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS 0..* BackboneElement "COMPONENTS" "COMPONENTS"
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXO)" "Pharmacy/Treatment Component (for RXO)"
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.1-RXC ^extension.valueCode = #A
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-ORDER_DETAIL.5-COMPONENTS.2-NTE ^extension.valueCode = #A
* 7-ORDER.5-RXE 1..1 http://hl7.org/v2/StructureDefinition/RXE "Pharmacy/Treatment Encoded Order" "Pharmacy/Treatment Encoded Order"
* 7-ORDER.5-RXE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-RXE ^extension.valueCode = #A
* 7-ORDER.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXE)" "Participation (for RXE)"
* 7-ORDER.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-PRT ^extension.valueCode = #A
* 7-ORDER.7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXE)" "Notes and Comments (for RXE)"
* 7-ORDER.7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.7-NTE ^extension.valueCode = #A
* 7-ORDER.8-TIMING_ENCODED 1..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 7-ORDER.8-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.8-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.8-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.8-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.8-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.8-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER 0..* BackboneElement "PHARMACY_TREATMENT_INFUSION_ORDER" "PHARMACY_TREATMENT_INFUSION_ORDER"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.1-RXV 1..1 http://hl7.org/v2/StructureDefinition/RXV "Pharmacy/Treatment Infusion Order" "Pharmacy/Treatment Infusion Order"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.1-RXV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.1-RXV ^extension.valueCode = #A
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXV)" "Participation (for RXV)"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.2-PRT ^extension.valueCode = #A
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXV)" "Notes and Comments (for RXV)"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.3-NTE ^extension.valueCode = #A
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED 1..* BackboneElement "TIMING_ENCODED" "TIMING_ENCODED"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.9-PHARMACY_TREATMENT_INFUSION_ORDER.4-TIMING_ENCODED.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.10-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-ORDER.10-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.10-RXR ^extension.valueCode = #A
* 7-ORDER.11-RXC 0..* http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component (for RXE)" "Pharmacy/Treatment Component (for RXE)"
* 7-ORDER.11-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.11-RXC ^extension.valueCode = #A
* 7-ORDER.12-CDO 0..* http://hl7.org/v2/StructureDefinition/CDO "Cumulative Dosage Segment" "Cumulative Dosage Segment"
* 7-ORDER.12-CDO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.12-CDO ^extension.valueCode = #A
* 7-ORDER.13-OBSERVATION 0..* BackboneElement "OBSERVATION" "OBSERVATION"
* 7-ORDER.13-OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Results" "Results"
* 7-ORDER.13-OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.13-OBSERVATION.1-OBX ^extension.valueCode = #A
* 7-ORDER.13-OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for OBX)" "Participation (for OBX)"
* 7-ORDER.13-OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.13-OBSERVATION.2-PRT ^extension.valueCode = #A
* 7-ORDER.13-OBSERVATION.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for OBX)" "Notes and Comments (for OBX)"
* 7-ORDER.13-OBSERVATION.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.13-OBSERVATION.3-NTE ^extension.valueCode = #A
* 7-ORDER.14-FT1 0..* http://hl7.org/v2/StructureDefinition/FT1 "Financial Detail" "Financial Detail"
* 7-ORDER.14-FT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.14-FT1 ^extension.valueCode = #A
* 7-ORDER.15-BLG 0..1 http://hl7.org/v2/StructureDefinition/BLG "Billing Segment" "Billing Segment"
* 7-ORDER.15-BLG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.15-BLG ^extension.valueCode = #A
* 7-ORDER.16-CTI 0..* http://hl7.org/v2/StructureDefinition/CTI "Clinical Trial Identification" "Clinical Trial Identification"
* 7-ORDER.16-CTI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.16-CTI ^extension.valueCode = #A