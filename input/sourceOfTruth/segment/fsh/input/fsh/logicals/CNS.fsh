Logical: CNS
Parent: $Segment
Id: CNS
Title: "HL7 v2 CNS Segment Definition"
* ^meta.profile = "http://hl7.org/v2/StructureDefinition/Segment-Profile"
* ^date = "2025-06-11T19:08:38Z"
* . ^short = "Clear Notification"
* 1 0..1 NM "CNS-1" "This field contains the starting notification reference number that is to be cleared."
* 1 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 1 ^extension[=].valueCode = #O
* 1 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 1 ^extension[=].extension[0].url = "length"
* 1 ^extension[=].extension[=].valueInteger = "10"
* 1 ^extension[=].extension[+].url = "noTruncate"
* 1 ^extension[=].extension[=].valueInteger = false
* 1 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 1 ^code.code = #1402
* 2 0..1 NM "CNS-2" "This field contains the ending notification reference number that is to be cleared. If empty, then only notification with Starting Notification Reference Number will be cleared."
* 2 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 2 ^extension[=].valueCode = #O
* 2 ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/conformance-length"
* 2 ^extension[=].extension[0].url = "length"
* 2 ^extension[=].extension[=].valueInteger = "10"
* 2 ^extension[=].extension[+].url = "noTruncate"
* 2 ^extension[=].extension[=].valueInteger = false
* 2 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 2 ^code.code = #1403
* 3 0..1 DTM "CNS-3" "This field is the starting date/time of the notifications to be cleared. If this field is empty but Ending Notification Date/Time is filled, then all notifications before Ending Notification Date/Time will be cleared."
* 3 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 3 ^extension[=].valueCode = #O
* 3 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 3 ^code.code = #1404
* 4 0..1 DTM "CNS-4" "This field is the ending date/time of the notifications to be cleared. If this field is empty but Starting Notification Date/Time is filled, then all notifications after Starting Notification Date/Time will be cleared."
* 4 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 4 ^extension[=].valueCode = #O
* 4 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 4 ^code.code = #1405
* 5 0..1 CWE "CNS-5" "This field contains the starting notification code that is to be cleared (see _13.3.7.4_, \"_NDS-4 Notification Code (CWE) 01401_\").Refer to Table 0585 - Starting Notification Code in Chapter 2C for valid values."
* 5 from http://terminology.hl7.org/ValueSet/v2-0585 (required)
* 5 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 5 ^extension[=].valueCode = #O
* 5 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 5 ^code.code = #1406
* 6 0..1 CWE "CNS-6" "This field contains the ending notification code that is to be cleared (see _13.3.7.4_, \"_NDS-4 Notification Code (CWE) 01401_\"). If empty, then only notification with Starting Notification Code will be cleared. Refer to Table 0586 - Ending Notification Code in Chapter 2C for valid values."
* 6 from http://terminology.hl7.org/ValueSet/v2-0586 (required)
* 6 ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/optionality"
* 6 ^extension[=].valueCode = #O
* 6 ^code.system = "http://hl7.org/v2/CodeSystem/DataElements"
* 6 ^code.code = #1407