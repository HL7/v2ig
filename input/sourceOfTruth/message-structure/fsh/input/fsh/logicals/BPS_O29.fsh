Logical: BPS_O29
Parent: V2MessageStructure
Id: BPS_O29
Title: "HL7 v2 BPS_O29 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "BPS_O29"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "BPS_O29"
* . ^definition = "BPS_O29 Message Structure"
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
* 7-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.1-ORC ^extension.valueCode = #A
* 7-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.2-PRT ^extension.valueCode = #A
* 7-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-ORDER.4-BPO 1..1 http://hl7.org/v2/StructureDefinition/BPO "Blood Product Order" "Blood Product Order"
* 7-ORDER.4-BPO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.4-BPO ^extension.valueCode = #A
* 7-ORDER.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for BPO)" "Notes and Comments (for BPO)"
* 7-ORDER.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.5-NTE ^extension.valueCode = #A
* 7-ORDER.6-PRODUCT 0..* BackboneElement "PRODUCT" "PRODUCT"
* 7-ORDER.6-PRODUCT.1-BPX 1..1 http://hl7.org/v2/StructureDefinition/BPX "Blood Product Dispense Status" "Blood Product Dispense Status"
* 7-ORDER.6-PRODUCT.1-BPX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-PRODUCT.1-BPX ^extension.valueCode = #A
* 7-ORDER.6-PRODUCT.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for BPX)" "Notes and Comments (for BPX)"
* 7-ORDER.6-PRODUCT.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-ORDER.6-PRODUCT.2-NTE ^extension.valueCode = #A