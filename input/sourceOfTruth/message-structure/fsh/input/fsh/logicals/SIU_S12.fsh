Logical: SIU_S12
Parent: V2MessageStructure
Id: SIU_S12
Title: "HL7 v2 SIU_S12 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "SIU_S12"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "SIU_S12"
* . ^definition = "SIU_S12 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SCH 1..1 http://hl7.org/v2/StructureDefinition/SCH "Schedule Activity Information" "Schedule Activity Information"
* 2-SCH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SCH ^extension.valueCode = #A
* 3-TQ1 0..* http://hl7.org/v2/StructureDefinition/TQ1 "Timing/Quantity" "Timing/Quantity"
* 3-TQ1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-TQ1 ^extension.valueCode = #A
* 4-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the SCH" "Notes and Comments for the SCH"
* 4-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-NTE ^extension.valueCode = #A
* 5-PATIENT 0..* BackboneElement "PATIENT" "PATIENT"
* 5-PATIENT.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PATIENT.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.1-PID ^extension.valueCode = #A
* 5-PATIENT.2-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 5-PATIENT.2-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.2-PD1 ^extension.valueCode = #A
* 5-PATIENT.3-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-PATIENT.3-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.3-GSP ^extension.valueCode = #A
* 5-PATIENT.4-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-PATIENT.4-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.4-GSR ^extension.valueCode = #A
* 5-PATIENT.5-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 5-PATIENT.5-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.5-GSC ^extension.valueCode = #A
* 5-PATIENT.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-PATIENT.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.6-PRT ^extension.valueCode = #A
* 5-PATIENT.7-PV1 0..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 5-PATIENT.7-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.7-PV1 ^extension.valueCode = #A
* 5-PATIENT.8-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 5-PATIENT.8-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.8-PV2 ^extension.valueCode = #A
* 5-PATIENT.9-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-PATIENT.9-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.9-PRT ^extension.valueCode = #A
* 5-PATIENT.10-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 5-PATIENT.10-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.10-OBX ^extension.valueCode = #A
* 5-PATIENT.11-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 5-PATIENT.11-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.11-PRT ^extension.valueCode = #A
* 5-PATIENT.12-DG1 0..* http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 5-PATIENT.12-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PATIENT.12-DG1 ^extension.valueCode = #A
* 6-RESOURCES 1..* BackboneElement "RESOURCES" "RESOURCES"
* 6-RESOURCES.1-RGS 1..1 http://hl7.org/v2/StructureDefinition/RGS "Resource Group Segment" "Resource Group Segment"
* 6-RESOURCES.1-RGS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.1-RGS ^extension.valueCode = #A
* 6-RESOURCES.2-SERVICE 0..* BackboneElement "SERVICE" "SERVICE"
* 6-RESOURCES.2-SERVICE.1-AIS 1..1 http://hl7.org/v2/StructureDefinition/AIS "Appointment Information - Service" "Appointment Information - Service"
* 6-RESOURCES.2-SERVICE.1-AIS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.2-SERVICE.1-AIS ^extension.valueCode = #A
* 6-RESOURCES.2-SERVICE.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the AIS" "Notes and Comments for the AIS"
* 6-RESOURCES.2-SERVICE.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.2-SERVICE.2-NTE ^extension.valueCode = #A
* 6-RESOURCES.3-GENERAL_RESOURCE 0..* BackboneElement "GENERAL_RESOURCE" "GENERAL_RESOURCE"
* 6-RESOURCES.3-GENERAL_RESOURCE.1-AIG 1..1 http://hl7.org/v2/StructureDefinition/AIG "Appointment Information - General Resource" "Appointment Information - General Resource"
* 6-RESOURCES.3-GENERAL_RESOURCE.1-AIG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.3-GENERAL_RESOURCE.1-AIG ^extension.valueCode = #A
* 6-RESOURCES.3-GENERAL_RESOURCE.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the AIG" "Notes and Comments for the AIG"
* 6-RESOURCES.3-GENERAL_RESOURCE.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.3-GENERAL_RESOURCE.2-NTE ^extension.valueCode = #A
* 6-RESOURCES.4-LOCATION_RESOURCE 0..* BackboneElement "LOCATION_RESOURCE" "LOCATION_RESOURCE"
* 6-RESOURCES.4-LOCATION_RESOURCE.1-AIL 1..1 http://hl7.org/v2/StructureDefinition/AIL "Appointment Information - Location Resource" "Appointment Information - Location Resource"
* 6-RESOURCES.4-LOCATION_RESOURCE.1-AIL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.4-LOCATION_RESOURCE.1-AIL ^extension.valueCode = #A
* 6-RESOURCES.4-LOCATION_RESOURCE.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the AIL" "Notes and Comments for the AIL"
* 6-RESOURCES.4-LOCATION_RESOURCE.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.4-LOCATION_RESOURCE.2-NTE ^extension.valueCode = #A
* 6-RESOURCES.5-PERSONNEL_RESOURCE 0..* BackboneElement "PERSONNEL_RESOURCE" "PERSONNEL_RESOURCE"
* 6-RESOURCES.5-PERSONNEL_RESOURCE.1-AIP 1..1 http://hl7.org/v2/StructureDefinition/AIP "Appointment Information - Personnel Resource" "Appointment Information - Personnel Resource"
* 6-RESOURCES.5-PERSONNEL_RESOURCE.1-AIP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.5-PERSONNEL_RESOURCE.1-AIP ^extension.valueCode = #A
* 6-RESOURCES.5-PERSONNEL_RESOURCE.2-NTE 0..* http://hl7.org/v2/StructureDefinition/NTE "Notes and Comments for the AIP" "Notes and Comments for the AIP"
* 6-RESOURCES.5-PERSONNEL_RESOURCE.2-NTE ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-RESOURCES.5-PERSONNEL_RESOURCE.2-NTE ^extension.valueCode = #A