Logical: OSM_R26
Parent: V2MessageStructure
Id: OSM_R26
Title: "HL7 v2 OSM_R26 Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/MessageStructure-Profile"
* ^type = "OSM_R26"
* ^date = "2025-06-13T21:11:33Z"
* . ^short = "OSM_R26"
* . ^definition = "OSM_R26 Message Structure"
* 1-MSH 1..1 http://hl7.org/v2/StructureDefinition/MSH "Message Header" "Message Header"
* 1-MSH ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 1-MSH ^extension.valueCode = #A
* 2-ARV 1..* http://hl7.org/v2/StructureDefinition/ARV "Access Restrictions" "Access Restrictions"
* 2-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 2-ARV ^extension.valueCode = #A
* 3-SFT 0..* http://hl7.org/v2/StructureDefinition/SFT "Software Segment" "Software Segment"
* 3-SFT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 3-SFT ^extension.valueCode = #A
* 4-UAC 0..1 http://hl7.org/v2/StructureDefinition/UAC "User Authentication Credential" "User Authentication Credential"
* 4-UAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 4-UAC ^extension.valueCode = #A
* 5-SHIPMENT 1..* BackboneElement "SHIPMENT" "SHIPMENT"
* 5-SHIPMENT.1-SHP 1..1 http://hl7.org/v2/StructureDefinition/SHP "Shipment Segment" "Shipment Segment"
* 5-SHIPMENT.1-SHP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.1-SHP ^extension.valueCode = #A
* 5-SHIPMENT.2-PRT 1..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Shipment)" "Participation (for Shipment)"
* 5-SHIPMENT.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.3-SHIPPING_OBSERVATION 0..* BackboneElement "SHIPPING_OBSERVATION" "SHIPPING_OBSERVATION"
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment (Additional Shipping Information)" "Observation/Result Segment (Additional Shipping Information)"
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Shipping Observation)" "Participation (for Shipping Observation)"
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.3-SHIPPING_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE 1..* BackboneElement "PACKAGE" "PACKAGE"
* 5-SHIPMENT.4-PACKAGE.1-PAC 1..1 http://hl7.org/v2/StructureDefinition/PAC "Shipping Package Segment" "Shipping Package Segment"
* 5-SHIPMENT.4-PACKAGE.1-PAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.1-PAC ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Shipping Package)" "Participation (for Shipping Package)"
* 5-SHIPMENT.4-PACKAGE.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN 0..* BackboneElement "SPECIMEN" "SPECIMEN"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.1-SPM 1..1 http://hl7.org/v2/StructureDefinition/SPM "Specimen Information" "Specimen Information"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.1-SPM ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.1-SPM ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen)" "Participation (for Specimen)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION 0..* BackboneElement "SPECIMEN_OBSERVATION" "SPECIMEN_OBSERVATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment (For Specimen)" "Observation/Result Segment (For Specimen)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Specimen Observation)" "Participation (for Specimen Observation)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.3-SPECIMEN_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER 0..* BackboneElement "CONTAINER" "CONTAINER"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.1-SAC 1..1 http://hl7.org/v2/StructureDefinition/SAC "Container Information" "Container Information"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.1-SAC ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.1-SAC ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION 0..* BackboneElement "CONTAINER_OBSERVATION" "CONTAINER_OBSERVATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment (For Container)" "Observation/Result Segment (For Container)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Container Observation Result)" "Participation (for Container Observation Result)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.4-CONTAINER.2-CONTAINER_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION 0..1 BackboneElement "SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION" "SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.1-PID 1..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification (For Person/Animal)" "Patient Identification (For Person/Animal)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.1-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.1-PID ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.3-ARV 0..* http://hl7.org/v2/StructureDefinition/ARV "For backwards compability only as of V2.9." "For backwards compability only as of V2.9."
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.3-ARV ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.3-ARV ^extension.valueCode = #B
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION 0..* BackboneElement "PATIENT_OBSERVATION" "PATIENT_OBSERVATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment (For Patient)" "Observation/Result Segment (For Patient)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Observation)" "Participation (for Observation)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.4-PATIENT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties (For Person/Animal)" "Next of Kin/Associated Parties (For Person/Animal)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.5-SUBJECT_PERSON_OR_ANIMAL_IDENTIFICATION.5-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION 0..1 BackboneElement "SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION" "SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.1-PV1 1..1 http://hl7.org/v2/StructureDefinition/PV1 "Patient Visit (For Population/Location)" "Patient Visit (For Population/Location)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.1-PV1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.1-PV1 ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit)" "Participation (for Patient Visit)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION 0..* BackboneElement "PATIENT_VISIT_OBSERVATION" "PATIENT_VISIT_OBSERVATION"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.1-OBX 1..1 http://hl7.org/v2/StructureDefinition/OBX "Observation/Result Segment (For Visit)" "Observation/Result Segment (For Visit)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.1-OBX ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.1-OBX ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.2-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient Visit Observation)" "Participation (for Patient Visit Observation)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.2-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.3-PATIENT_VISIT_OBSERVATION.2-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.4-PID 0..1 http://hl7.org/v2/StructureDefinition/PID "Patient Identification (For Population)" "Patient Identification (For Population)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.4-PID ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.4-PID ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.5-PRT 0..* http://hl7.org/v2/StructureDefinition/PRT "Participation (for Patient)" "Participation (for Patient)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.5-PRT ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.5-PRT ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN 0..* BackboneElement "NEXT_OF_KIN" "NEXT_OF_KIN"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.1-NK1 1..1 http://hl7.org/v2/StructureDefinition/NK1 "Next of Kin/Associated Parties (For Population/Location)" "Next of Kin/Associated Parties (For Population/Location)"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.1-NK1 ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.1-NK1 ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.2-GSP 0..* http://hl7.org/v2/StructureDefinition/GSP "Person Gender and Sex" "Person Gender and Sex"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.2-GSP ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.2-GSP ^extension.valueCode = #A
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.3-GSR 0..* http://hl7.org/v2/StructureDefinition/GSR "Recorded Gender and Sex" "Recorded Gender and Sex"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.3-GSR ^extension.url = "http://hl7.org/fhir/StructureDefinition/v2-segment-status"
* 5-SHIPMENT.4-PACKAGE.3-SPECIMEN.6-SUBJECT_POPULATION_OR_LOCATION_IDENTIFICATION.6-NEXT_OF_KIN.3-GSR ^extension.valueCode = #A