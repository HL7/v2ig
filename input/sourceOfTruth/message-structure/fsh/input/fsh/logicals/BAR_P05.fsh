Logical: BAR_P05
Parent: V2MessageStructure
Id: BAR_P05
Title: "HL7 v2 BAR_P05 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "BAR_P05"
* ^date = "2025-06-13T21:11:32Z"
* . ^short = "BAR_P05"
* . ^definition = "BAR_P05 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 2-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-SFT ^extension.valueCode = #A
* 3-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 3-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-UAC ^extension.valueCode = #A
* 4-EVN 1..1 http://hl7.org/v2/StructureDefinition/EVN "Event Type" "Event Type"
* 4-EVN ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-EVN ^extension.valueCode = #A
* 5-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification" "Patient Identification"
* 5-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-PID ^extension.valueCode = #A
* 6-PD1 0..1 http://hl7.org/v2/StructureDefinition/PD1 "Additional Demographics" "Additional Demographics"
* 6-PD1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 6-PD1 ^extension.valueCode = #A
* 7-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 7-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 7-GSP ^extension.valueCode = #A
* 8-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 8-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 8-GSR ^extension.valueCode = #A
* 9-GSC 0..* http://hl7.org/v2/StructureDefinition/GSC "Sex Parameter for Clinical Use" "Sex Parameter for Clinical Use"
* 9-GSC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 9-GSC ^extension.valueCode = #A
* 10-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 10-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 10-PRT ^extension.valueCode = #A
* 11-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 11-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 11-ROL ^extension.valueCode = #B
* 12-VISIT 1..* BackboneElement "VISIT" "VISIT"
* 12-VISIT.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit" "Patient Visit"
* 12-VISIT.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.1-PV1 ^extension.valueCode = #A
* 12-VISIT.2-PV2 0..1 http://hl7.org/v2/StructureDefinition/PV2 "Patient Visit - Additional Info" "Patient Visit - Additional Info"
* 12-VISIT.2-PV2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.2-PV2 ^extension.valueCode = #A
* 12-VISIT.3-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-VISIT.3-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.3-PRT ^extension.valueCode = #A
* 12-VISIT.4-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 12-VISIT.4-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.4-ROL ^extension.valueCode = #B
* 12-VISIT.5-DB1 0..* http://hl7.org/v2/StructureDefinition/DB1 "Disability Information" "Disability Information"
* 12-VISIT.5-DB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.5-DB1 ^extension.valueCode = #A
* 12-VISIT.6-OBX 0..* http://hl7.org/v2/StructureDefinition/OBX "Observation/Result" "Observation/Result"
* 12-VISIT.6-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.6-OBX ^extension.valueCode = #A
* 12-VISIT.7-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-VISIT.7-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.7-PRT ^extension.valueCode = #A
* 12-VISIT.8-AL1 0..* http://hl7.org/v2/StructureDefinition/AL1 "Allergy Information" "Allergy Information"
* 12-VISIT.8-AL1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.8-AL1 ^extension.valueCode = #A
* 12-VISIT.9-DIAGNOSIS 0..* BackboneElement "DIAGNOSIS" "DIAGNOSIS"
* 12-VISIT.9-DIAGNOSIS.1-DG1 1..1 http://hl7.org/v2/StructureDefinition/DG1 "Diagnosis" "Diagnosis"
* 12-VISIT.9-DIAGNOSIS.1-DG1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.9-DIAGNOSIS.1-DG1 ^extension.valueCode = #A
* 12-VISIT.10-DRG 0..1 http://hl7.org/v2/StructureDefinition/DRG "Diagnosis Related Group" "Diagnosis Related Group"
* 12-VISIT.10-DRG ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.10-DRG ^extension.valueCode = #A
* 12-VISIT.11-PROCEDURE 0..* BackboneElement "PROCEDURE" "PROCEDURE"
* 12-VISIT.11-PROCEDURE.1-PR1 1..1 http://hl7.org/v2/StructureDefinition/PR1 "Procedures" "Procedures"
* 12-VISIT.11-PROCEDURE.1-PR1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.11-PROCEDURE.1-PR1 ^extension.valueCode = #A
* 12-VISIT.11-PROCEDURE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-VISIT.11-PROCEDURE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.11-PROCEDURE.2-PRT ^extension.valueCode = #A
* 12-VISIT.11-PROCEDURE.3-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 12-VISIT.11-PROCEDURE.3-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.11-PROCEDURE.3-ROL ^extension.valueCode = #B
* 12-VISIT.12-GT1 0..* http://hl7.org/v2/StructureDefinition/GT1 "Guarantor" "Guarantor"
* 12-VISIT.12-GT1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.12-GT1 ^extension.valueCode = #A
* 12-VISIT.13-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 12-VISIT.13-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.13-GSP ^extension.valueCode = #A
* 12-VISIT.14-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 12-VISIT.14-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.14-GSR ^extension.valueCode = #A
* 12-VISIT.15-NK1 0..* http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties" "Next of Kin/Associated Parties"
* 12-VISIT.15-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.15-NK1 ^extension.valueCode = #A
* 12-VISIT.16-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 12-VISIT.16-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.16-GSP ^extension.valueCode = #A
* 12-VISIT.17-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 12-VISIT.17-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.17-GSR ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE 0..* BackboneElement "INSURANCE" "INSURANCE"
* 12-VISIT.18-INSURANCE.1-IN1 1..1 http://hl7.org/v2/StructureDefinition/IN1 "Insurance" "Insurance"
* 12-VISIT.18-INSURANCE.1-IN1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.1-IN1 ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 12-VISIT.18-INSURANCE.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.2-GSP ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 12-VISIT.18-INSURANCE.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.3-GSR ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.4-IN2 0..1 http://hl7.org/v2/StructureDefinition/IN2 "Insurance - Additional Info." "Insurance - Additional Info."
* 12-VISIT.18-INSURANCE.4-IN2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.4-IN2 ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.5-IN3 0..* http://hl7.org/v2/StructureDefinition/IN3 "Insurance - Add'l Info. - Cert." "Insurance - Add'l Info. - Cert."
* 12-VISIT.18-INSURANCE.5-IN3 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.5-IN3 ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.6-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation" "Participation"
* 12-VISIT.18-INSURANCE.6-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.6-PRT ^extension.valueCode = #A
* 12-VISIT.18-INSURANCE.7-ROL 0..* http://hl7.org/v2/StructureDefinition/ROL "Role" "Role"
* 12-VISIT.18-INSURANCE.7-ROL ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.18-INSURANCE.7-ROL ^extension.valueCode = #B
* 12-VISIT.19-ACC 0..1 http://hl7.org/v2/StructureDefinition/ACC "Accident Information" "Accident Information"
* 12-VISIT.19-ACC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.19-ACC ^extension.valueCode = #A
* 12-VISIT.20-UB1 0..1 http://hl7.org/v2/StructureDefinition/UB1 "Universal Bill Information" "Universal Bill Information"
* 12-VISIT.20-UB1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.20-UB1 ^extension.valueCode = #B
* 12-VISIT.21-UB2 0..1 http://hl7.org/v2/StructureDefinition/UB2 "Universal Bill 92 Information" "Universal Bill 92 Information"
* 12-VISIT.21-UB2 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.21-UB2 ^extension.valueCode = #A
* 12-VISIT.22-ABS 0..1 http://hl7.org/v2/StructureDefinition/ABS "Abstract" "Abstract"
* 12-VISIT.22-ABS ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.22-ABS ^extension.valueCode = #A
* 12-VISIT.23-BLC 0..* http://hl7.org/v2/StructureDefinition/BLC "Blood Code" "Blood Code"
* 12-VISIT.23-BLC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.23-BLC ^extension.valueCode = #A
* 12-VISIT.24-RMI 0..1 http://hl7.org/v2/StructureDefinition/RMI "Risk Management Incident" "Risk Management Incident"
* 12-VISIT.24-RMI ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 12-VISIT.24-RMI ^extension.valueCode = #A