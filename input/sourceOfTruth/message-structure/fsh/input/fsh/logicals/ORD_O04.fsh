Logical: ORD_O04
Parent: V2MessageStructure
Id: ORD_O04
Title: "HL7 v2 ORD_O04 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORD_O04"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "ORD_O04"
* . ^definition = "ORD_O04 Message Structure"
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
* 7-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for MSA)" "Notes and Comments (for MSA)"
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
* 8-RESPONSE.1-PATIENT.3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibility only as of V2.9." "For backwards compatibility only as of V2.9."
* 8-RESPONSE.1-PATIENT.3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.3-ARV ^extension.valueCode = #B
* 8-RESPONSE.1-PATIENT.4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for Patient ID)" "Notes and Comments (for Patient ID)"
* 8-RESPONSE.1-PATIENT.4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.4-NTE ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET 1..* BackboneElement "ORDER_DIET" "ORDER_DIET"
* 8-RESPONSE.2-ORDER_DIET.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-RESPONSE.2-ORDER_DIET.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.1-ORC ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-RESPONSE.2-ORDER_DIET.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET 0..* BackboneElement "TIMING_DIET" "TIMING_DIET"
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.1-TQ1 ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.3-TIMING_DIET.2-TQ2 ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET.4-ODS 0..* http://hl7.org/v2/StructureDefinition/ODS "Dietary Orders, Supplements, and Preferences" "Dietary Orders, Supplements, and Preferences"
* 8-RESPONSE.2-ORDER_DIET.4-ODS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.4-ODS ^extension.valueCode = #A
* 8-RESPONSE.2-ORDER_DIET.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for ODS)" "Notes and Comments (for ODS)"
* 8-RESPONSE.2-ORDER_DIET.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-ORDER_DIET.5-NTE ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY 0..* BackboneElement "ORDER_TRAY" "ORDER_TRAY"
* 8-RESPONSE.3-ORDER_TRAY.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-RESPONSE.3-ORDER_TRAY.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.1-ORC ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-RESPONSE.3-ORDER_TRAY.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY 0..* BackboneElement "TIMING_TRAY" "TIMING_TRAY"
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.1-TQ1 ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.3-TIMING_TRAY.2-TQ2 ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY.4-ODT 0..* http://hl7.org/v2/StructureDefinition/ODT "Diet Tray Instructions" "Diet Tray Instructions"
* 8-RESPONSE.3-ORDER_TRAY.4-ODT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.4-ODT ^extension.valueCode = #A
* 8-RESPONSE.3-ORDER_TRAY.5-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for ODT)" "Notes and Comments (for ODT)"
* 8-RESPONSE.3-ORDER_TRAY.5-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.3-ORDER_TRAY.5-NTE ^extension.valueCode = #A