Logical: ORP_O10
Parent: V2MessageStructure
Id: ORP_O10
Title: "HL7 v2 ORP_O10 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORP_O10"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "ORP_O10"
* . ^definition = "ORP_O10 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-MSA 1..1 http://hl7.org/v2/StructureDefinition/MSA "Message Acknowledgment" "Message Acknowledgment"
* 2-MSA ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-MSA ^extension.valueCode = #A
* 3-ERR 0..* http://hl7.org/v2/StructureDefinition/ERR "Error" "Error"
* 3-ERR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-ERR ^extension.valueCode = #A
* 4-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software" "Software"
* 4-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-SFT ^extension.valueCode = #A
* 5-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 5-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-UAC ^extension.valueCode = #A
* 6-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Response Header)" "Notes and Comments (for Response Header)"
* 6-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-NTE ^extension.valueCode = #A
* 7-RESPONSE 0..1 BackboneElement "RESPONSE" "RESPONSE"
* 7-RESPONSE.1-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 7-RESPONSE.1-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 7-RESPONSE.1-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.1-PATIENT.1-PID ^extension.valueCode = #A
* 7-RESPONSE.1-PATIENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 7-RESPONSE.1-PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.1-PATIENT.2-PRT ^extension.valueCode = #A
* 7-RESPONSE.1-PATIENT.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 7-RESPONSE.1-PATIENT.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.1-PATIENT.3-NTE ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER 1..* BackboneElement "ORDER" "ORDER"
* 7-RESPONSE.2-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 7-RESPONSE.2-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.1-ORC ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for ORC)" "Participation (for ORC)"
* 7-RESPONSE.2-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.2-PRT ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 7-RESPONSE.2-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 7-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 7-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL 0..1 BackboneElement "ORDER_DETAIL" "ORDER_DETAIL"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO 1..1 http://hl7.org/v2/StructureDefinition/RXO "Pharmacy/Treatment Order" "Pharmacy/Treatment Order"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.1-RXO ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for RXO)" "Participation (for RXO)"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.2-PRT ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for RXO)" "Notes and Comments (for RXO)"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.3-NTE ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR 1..* http://hl7.org/v2/StructureDefinition/RXR "Pharmacy/Treatment Route" "Pharmacy/Treatment Route"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.4-RXR ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT 0..* BackboneElement "COMPONENT" "COMPONENT"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.1-RXC 1..1 http://hl7.org/v2/StructureDefinition/RXC "Pharmacy/Treatment Component" "Pharmacy/Treatment Component"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.1-RXC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.1-RXC ^extension.valueCode = #A
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for each RXC)" "Notes and Comments (for each RXC)"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-RESPONSE.2-ORDER.4-ORDER_DETAIL.5-COMPONENT.2-NTE ^extension.valueCode = #A