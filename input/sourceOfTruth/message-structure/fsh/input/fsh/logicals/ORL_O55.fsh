Logical: ORL_O55
Parent: V2MessageStructure
Id: ORL_O55
Title: "HL7 v2 ORL_O55 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "ORL_O55"
* ^date = "2025-06-13T21:11:31Z"
* . ^short = "ORL_O55"
* . ^definition = "ORL_O55 Message Structure"
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
* 8-RESPONSE.1-PATIENT.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 8-RESPONSE.1-PATIENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.1-PATIENT.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN 1..* BackboneElement "SPECIMEN" "SPECIMEN"
* 8-RESPONSE.2-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen" "Specimen"
* 8-RESPONSE.2-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.1-SPM ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observations related to specimen" "Observations related to specimen"
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen Related Observation)" "Participation (for Specimen Related Observation)"
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.2-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.3-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments (for specimen)" "Notes and Comments (for specimen)"
* 8-RESPONSE.2-SPECIMEN.3-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.3-NTE ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER 1..* BackboneElement "SPECIMEN_CONTAINER" "SPECIMEN_CONTAINER"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Specimen Container" "Specimen Container"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.1-SAC ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER 0..* BackboneElement "ORDER" "ORDER"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.1-ORC 1..1 http://hl7.org/v2/StructureDefinition/ORC "Common Order" "Common Order"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.1-ORC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.1-ORC ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Order)" "Participation (for Order)"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.2-PRT ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING 0..* BackboneElement "TIMING" "TIMING"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.1-TQ1 1..1 http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.1-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.1-TQ1 ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.2-TQ2 0..* http://hl7.org/v2/StructureDefinition/TQ2 "Timing/Quantity Order Sequence" "Timing/Quantity Order Sequence"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.2-TQ2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.3-TIMING.2-TQ2 ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST 0..1 BackboneElement "OBSERVATION_REQUEST" "OBSERVATION_REQUEST"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.1-OBR 1..1 http://hl7.org/v2/StructureDefinition/OBR "Observation Request" "Observation Request"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.1-OBR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.1-OBR ^extension.valueCode = #A
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation Request)" "Participation (for Observation Request)"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-RESPONSE.2-SPECIMEN.4-SPECIMEN_CONTAINER.2-ORDER.4-OBSERVATION_REQUEST.2-PRT ^extension.valueCode = #A