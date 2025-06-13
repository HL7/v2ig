Logical: OSU_O52
Parent: V2MessageStructure
Id: OSU_O52
Title: "HL7 v2 OSU_O52 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OSU_O52"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "OSU_O52"
* . ^definition = "OSU_O52 Message Structure"
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
* 8-PATIENT 0..1 BackboneElement "PATIENT" "PATIENT"
* 8-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 8-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PATIENT.1-PID ^extension.valueCode = #A
* 8-PATIENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 8-PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-PATIENT.2-PRT ^extension.valueCode = #A
* 9-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compatibilitty only as of V2.9." "For backwards compatibilitty only as of V2.9."
* 9-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-ARV ^extension.valueCode = #B
* 10-ORDER_STATUS 1..* BackboneElement "ORDER_STATUS" "ORDER_STATUS"
* 10-ORDER_STATUS.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 10-ORDER_STATUS.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ORDER_STATUS.1-ORC ^extension.valueCode = #A
* 10-ORDER_STATUS.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-ORDER_STATUS.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-ORDER_STATUS.2-PRT ^extension.valueCode = #A