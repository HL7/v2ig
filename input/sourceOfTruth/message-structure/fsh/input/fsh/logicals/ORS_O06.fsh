Logical: ORS_O06
Parent: V2MessageStructure
Id: ORS_O06
Title: "HL7 v2 ORS_O06 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORS_O06"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "ORS_O06"
* . ^definition = "ORS_O06 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 2-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-MSA ^extension.valueCode = #A
* 3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-ARV ^extension.valueCode = #A
* 4-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 4-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-ERR ^extension.valueCode = #A
* 5-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 5-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SFT ^extension.valueCode = #A
* 6-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 6-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-UAC ^extension.valueCode = #A
* 7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Header)" "Notes and Comments (for Header)"
* 7-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-NTE ^extension.valueCode = #A
* 8-RESPONSE 0..1 BackboneElement "RESPONSE" "RESPONSE"
* 8-RESPONSE.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 8-RESPONSE.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-RESPONSE.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.1-PID ^extension.valueCode = #A
* 8-RESPONSE.1-PATIENT.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-RESPONSE.1-PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.1-PATIENT.3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibilitty only as of V2.9." "For backwards compatibilitty only as of V2.9."
* 8-RESPONSE.1-PATIENT.3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.3-ARV ^extension.valueCode = #B
* 8-RESPONSE.1-PATIENT.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 8-RESPONSE.1-PATIENT.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.4-NTE ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 8-RESPONSE.2-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-RESPONSE.2-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.1-ORC ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-RESPONSE.2-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 8-RESPONSE.2-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.4-RQD 1..1 http://hl7.org/v2/StructureDefinition/RQD "Requisition Detail" "Requisition Detail"
* 8-RESPONSE.2-ORDER.4-RQD ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.4-RQD ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.5-RQ1 0..1 http://hl7.org/v2/StructureDefinition/RQ1 "Requisition Detail-1" "Requisition Detail-1"
* 8-RESPONSE.2-ORDER.5-RQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.5-RQ1 ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER.6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RQD)" "Notes and Comments (for RQD)"
* 8-RESPONSE.2-ORDER.6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER.6-NTE ^extension.valueCode = #A