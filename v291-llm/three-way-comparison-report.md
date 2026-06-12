# V2.9.1 Three-Way Structural Comparison

Neutral peer comparison of three independent methodologies: **python-docx** (rule-based table parsing), **LLM** (Claude-mediated extraction), and **FHIR** (the published StructureDefinitions).

> **Reading guide.** No methodology is treated as authoritative. Agreement is corroborating evidence; disagreement is a flag to check the source `.docx`. A *2-vs-1 split* names the outlier as the value to **examine against source**, not as the value that is wrong — the two-agreeing sources could share a blind spot. A *three-way split* means all three differ. Element coverage gaps (a structure or element present in some sources but not others) are reported separately from value disagreements.


## Segments (fields)

### Structure coverage

| Sources containing the structure | Count |
|---|---:|
| 3 of 3 | 190 |
| 2 of 3 | 1 |
| 1 of 3 | 1 |

### Element coverage (across structures present in ≥1 source)

| Sources containing the element | Count |
|---|---:|
| 3 of 3 | 2909 |
| 2 of 3 | 2 |
| 1 of 3 | 3 |

### Per-dimension agreement (elements present in ≥2 sources)

| Dimension | agree | 2-vs-1 split | 2-only split | 3-way split |
|---|---:|---:|---:|---:|
| name | 2719 | 191 | 0 | 1 |
| data_type | 2905 | 6 | 0 | 0 |
| optionality | 2909 | 2 | 0 | 0 |
| length | 2905 | 6 | 0 | 0 |
| conf_length | 2910 | 1 | 0 | 0 |
| binding | 2911 | 0 | 0 | 0 |

### 2-vs-1 splits: which source to examine against source `.docx`

_When two sources agree and one differs, the differing source is listed here as the one to check first — NOT as confirmed wrong._

| Outlier source | 2-vs-1 splits |
|---|---:|
| pydocx | 4 |
| llm | 2 |
| fhir | 200 |

### Detailed disagreements

#### BPX
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Set ID – BPX', llm='Set ID – BPX', fhir='BPX-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Dispense Status', llm='BP Dispense Status', fhir='BPX-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Status', llm='BP Status', fhir='BPX-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Date/Time of Status', llm='BP Date/Time of Status', fhir='BPX-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Donation ID', llm='BC Donation ID', fhir='BPX-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Component', llm='BC Component', fhir='BPX-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Donation Type / Intended Use', llm='BC Donation Type / Intended Use', fhir='BPX-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Commercial Product', llm='CP Commercial Product', fhir='BPX-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Manufacturer', llm='CP Manufacturer', fhir='BPX-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Lot Number', llm='CP Lot Number', fhir='BPX-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Blood Group', llm='BP Blood Group', fhir='BPX-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Special Testing', llm='BC Special Testing', fhir='BPX-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Expiration Date/Time', llm='BP Expiration Date/Time', fhir='BPX-13'
- seq 14 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Quantity', llm='BP Quantity', fhir='BPX-14'
- seq 15 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Amount', llm='BP Amount', fhir='BPX-15'
- seq 16 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Units', llm='BP Units', fhir='BPX-16'
- seq 17 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Unique ID', llm='BP Unique ID', fhir='BPX-17'
- seq 18 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Actual Dispensed To Location', llm='BP Actual Dispensed To Location', fhir='BPX-18'
- seq 19 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Actual Dispensed To Address', llm='BP Actual Dispensed To Address', fhir='BPX-19'
- seq 20 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Dispensed to Receiver', llm='BP Dispensed to Receiver', fhir='BPX-20'
- seq 21 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Dispensing Individual', llm='BP Dispensing Individual', fhir='BPX-21'
- seq 22 · length · 2-vs-1 (examine **pydocx** vs source): pydocx='22..22', llm='1..1', fhir='1..1'
- seq 22 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Action Code', llm='Action Code', fhir='BPX-22'
- seq 22 · optionality · 2-vs-1 (examine **pydocx** vs source): pydocx='ID', llm='O', fhir='O'

#### BTX
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Set ID – BTX', llm='Set ID – BTX', fhir='BTX-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Donation ID', llm='BC Donation ID', fhir='BTX-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Component', llm='BC Component', fhir='BTX-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BC Blood Group', llm='BC Blood Group', fhir='BTX-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Commercial Product', llm='CP Commercial Product', fhir='BTX-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Manufacturer', llm='CP Manufacturer', fhir='BTX-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='CP Lot Number', llm='CP Lot Number', fhir='BTX-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Quantity', llm='BP Quantity', fhir='BTX-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Amount', llm='BP Amount', fhir='BTX-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Units', llm='BP Units', fhir='BTX-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion/Disposition Status', llm='BP Transfusion/Disposition Status', fhir='BTX-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Message Status', llm='BP Message Status', fhir='BTX-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Date/Time of Status', llm='BP Date/Time of Status', fhir='BTX-13'
- seq 14 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion Administrator', llm='BP Transfusion Administrator', fhir='BTX-14'
- seq 15 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion Verifier', llm='BP Transfusion Verifier', fhir='BTX-15'
- seq 16 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion Start Date/Time of Status', llm='BP Transfusion Start Date/Time of Status', fhir='BTX-16'
- seq 17 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion End Date/Time of Status', llm='BP Transfusion End Date/Time of Status', fhir='BTX-17'
- seq 18 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Adverse Reaction Type', llm='BP Adverse Reaction Type', fhir='BTX-18'
- seq 19 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Transfusion Interrupted Reason', llm='BP Transfusion Interrupted Reason', fhir='BTX-19'
- seq 20 · name · 2-vs-1 (examine **fhir** vs source): pydocx='BP Unique ID', llm='BP Unique ID', fhir='BTX-20'
- seq 21 · length · 2-vs-1 (examine **pydocx** vs source): pydocx='21..21', llm='1..1', fhir='1..1'
- seq 21 · name · 3-way split: pydocx='00816', llm='Action Code', fhir='BTX-21'
- seq 21 · optionality · 2-vs-1 (examine **pydocx** vs source): pydocx='ID', llm='O', fhir='O'

#### BUI
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Set ID – BUI', llm='Set ID – BUI', fhir='BUI-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Blood Unit Identifier', llm='Blood Unit Identifier', fhir='BUI-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Blood Unit Type', llm='Blood Unit Type', fhir='BUI-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Blood Unit Weight', llm='Blood Unit Weight', fhir='BUI-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Weight Units', llm='Weight Units', fhir='BUI-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Blood Unit Volume', llm='Blood Unit Volume', fhir='BUI-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Volume Units', llm='Volume Units', fhir='BUI-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Catalog Number', llm='Container Catalog Number', fhir='BUI-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Lot Number', llm='Container Lot Number', fhir='BUI-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Manufacturer', llm='Container Manufacturer', fhir='BUI-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Transport Temperature', llm='Transport Temperature', fhir='BUI-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Transport Temperature Units', llm='Transport Temperature Units', fhir='BUI-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Action Code', llm='Action Code', fhir='BUI-13'

#### CNS
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Starting Notification Reference Number', llm='Starting Notification Reference Number', fhir='CNS-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Ending Notification Reference Number', llm='Ending Notification Reference Number', fhir='CNS-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Starting Notification Date/Time', llm='Starting Notification Date/Time', fhir='CNS-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Ending Notification Date/Time', llm='Ending Notification Date/Time', fhir='CNS-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Starting Notification Code', llm='Starting Notification Code', fhir='CNS-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Ending Notification Code', llm='Ending Notification Code', fhir='CNS-6'

#### DST
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Destination', llm='Destination', fhir='DST-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Route', llm='Route', fhir='DST-2'

#### ECD
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Reference Command Number', llm='Reference Command Number', fhir='ECD-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Remote Control Command', llm='Remote Control Command', fhir='ECD-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Response Required', llm='Response Required', fhir='ECD-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Requested Completion Time', llm='Requested Completion Time', fhir='ECD-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Parameters', llm='Parameters', fhir='ECD-5'

#### ECR
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Command Response', llm='Command Response', fhir='ECR-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Date/Time Completed', llm='Date/Time Completed', fhir='ECR-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Command Response Parameters', llm='Command Response Parameters', fhir='ECR-3'

#### EQP
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Event type', llm='Event type', fhir='EQP-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='File Name', llm='File Name', fhir='EQP-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Start Date/Time', llm='Start Date/Time', fhir='EQP-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='End Date/Time', llm='End Date/Time', fhir='EQP-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Transaction Data', llm='Transaction Data', fhir='EQP-5'

#### EQU
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Equipment Instance Identifier', llm='Equipment Instance Identifier', fhir='EQU-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Event Date/Time', llm='Event Date/Time', fhir='EQU-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='EQU-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Local/Remote Control State', llm='Local/Remote Control State', fhir='EQU-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Alert Level', llm='Alert Level', fhir='EQU-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Expected date/time of the next status change', llm='Expected date/time of the next status change', fhir='EQU-6'

#### INV
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance Identifier', llm='Substance Identifier', fhir='INV-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance Status', llm='Substance Status', fhir='INV-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance Type', llm='Substance Type', fhir='INV-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Inventory Container Identifier', llm='Inventory Container Identifier', fhir='INV-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Carrier Identifier', llm='Container Carrier Identifier', fhir='INV-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Position on Carrier', llm='Position on Carrier', fhir='INV-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Initial Quantity', llm='Initial Quantity', fhir='INV-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Current Quantity', llm='Current Quantity', fhir='INV-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Available Quantity', llm='Available Quantity', fhir='INV-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Consumption Quantity', llm='Consumption Quantity', fhir='INV-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Quantity Units', llm='Quantity Units', fhir='INV-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Expiration Date/Time', llm='Expiration Date/Time', fhir='INV-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='First Used Date/Time', llm='First Used Date/Time', fhir='INV-13'
- seq 14 · name · 2-vs-1 (examine **fhir** vs source): pydocx='On Board Stability Duration', llm='On Board Stability Duration', fhir='INV-14'
- seq 15 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Test/Fluid Identifier(s)', llm='Test/Fluid Identifier(s)', fhir='INV-15'
- seq 16 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Manufacturer  Number', llm='Manufacturer  Number', fhir='INV-16'
- seq 17 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Manufacturer Identifier', llm='Manufacturer Identifier', fhir='INV-17'
- seq 18 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Supplier Identifier', llm='Supplier Identifier', fhir='INV-18'
- seq 19 · name · 2-vs-1 (examine **fhir** vs source): pydocx='On Board Stability Time', llm='On Board Stability Time', fhir='INV-19'
- seq 20 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Target Value', llm='Target Value', fhir='INV-20'
- seq 21 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Equipment State Indicator Type Code', llm='Equipment State Indicator Type Code', fhir='INV-21'
- seq 22 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Equipment State Indicator Value', llm='Equipment State Indicator Value', fhir='INV-22'

#### ISD
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Reference Interaction Number', llm='Reference Interaction Number', fhir='ISD-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Interaction Type Identifier', llm='Interaction Type Identifier', fhir='ISD-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='ISD-3'

#### IVC
- seq 24 · conf_length · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='1'

#### LAN
- seq 1 · length · 2-vs-1 (examine **llm** vs source): pydocx='1..4', llm=∅, fhir='1..4'

#### NDS
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Notification Reference Number', llm='Notification Reference Number', fhir='NDS-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Notification Date/Time', llm='Notification Date/Time', fhir='NDS-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Notification Alert Severity', llm='Notification Alert Severity', fhir='NDS-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Notification Code', llm='Notification Code', fhir='NDS-4'

#### NK1
- seq 5 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='XTN', llm='XTN', fhir=∅
- seq 6 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='XTN', llm='XTN', fhir=∅
- seq 31 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='XTN', llm='XTN', fhir=∅

#### OM1
- seq 56 · name · 2-vs-1 (examine **llm** vs source): pydocx='Observation/Identifier associated with Producer’s Service/Test/Observation ID', llm="Observation/Identifier associated with Producer's Service/Test/Observation ID", fhir='Observation/Identifier associated with Producer’s Service/Test/Observation ID'

#### PID
- seq 13 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='XTN', llm='XTN', fhir=∅
- seq 14 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='XTN', llm='XTN', fhir=∅

#### PM1
- seq 7 · length · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='12'

#### SAC
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='External Accession Identifier', llm='External Accession Identifier', fhir='SAC-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Accession Identifier', llm='Accession Identifier', fhir='SAC-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Identifier', llm='Container Identifier', fhir='SAC-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Primary (Parent) Container Identifier', llm='Primary (Parent) Container Identifier', fhir='SAC-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Equipment Container Identifier', llm='Equipment Container Identifier', fhir='SAC-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Specimen Source', llm='Specimen Source', fhir='SAC-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Registration Date/Time', llm='Registration Date/Time', fhir='SAC-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Status', llm='Container Status', fhir='SAC-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Carrier Type', llm='Carrier Type', fhir='SAC-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Carrier Identifier', llm='Carrier Identifier', fhir='SAC-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Position in Carrier', llm='Position in Carrier', fhir='SAC-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Tray Type – SAC', llm='Tray Type – SAC', fhir='SAC-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Tray Identifier', llm='Tray Identifier', fhir='SAC-13'
- seq 14 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Position in Tray', llm='Position in Tray', fhir='SAC-14'
- seq 15 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Location', llm='Location', fhir='SAC-15'
- seq 16 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Height', llm='Container Height', fhir='SAC-16'
- seq 17 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Diameter', llm='Container Diameter', fhir='SAC-17'
- seq 18 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Barrier Delta', llm='Barrier Delta', fhir='SAC-18'
- seq 19 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Bottom Delta', llm='Bottom Delta', fhir='SAC-19'
- seq 20 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Height/Diameter/Delta Units', llm='Container Height/Diameter/Delta Units', fhir='SAC-20'
- seq 21 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Volume', llm='Container Volume', fhir='SAC-21'
- seq 22 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Available Specimen Volume', llm='Available Specimen Volume', fhir='SAC-22'
- seq 23 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Initial Specimen Volume', llm='Initial Specimen Volume', fhir='SAC-23'
- seq 24 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Volume Units', llm='Volume Units', fhir='SAC-24'
- seq 25 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Separator Type', llm='Separator Type', fhir='SAC-25'
- seq 26 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Cap Type', llm='Cap Type', fhir='SAC-26'
- seq 27 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Additive', llm='Additive', fhir='SAC-27'
- seq 28 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Specimen Component', llm='Specimen Component', fhir='SAC-28'
- seq 29 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Dilution Factor', llm='Dilution Factor', fhir='SAC-29'
- seq 30 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Treatment', llm='Treatment', fhir='SAC-30'
- seq 31 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Temperature', llm='Temperature', fhir='SAC-31'
- seq 32 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Hemolysis Index', llm='Hemolysis Index', fhir='SAC-32'
- seq 33 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Hemolysis Index Units', llm='Hemolysis Index Units', fhir='SAC-33'
- seq 34 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Lipemia Index', llm='Lipemia Index', fhir='SAC-34'
- seq 35 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Lipemia Index Units', llm='Lipemia Index Units', fhir='SAC-35'
- seq 36 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Icterus Index', llm='Icterus Index', fhir='SAC-36'
- seq 37 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Icterus Index Units', llm='Icterus Index Units', fhir='SAC-37'
- seq 38 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Fibrin Index', llm='Fibrin Index', fhir='SAC-38'
- seq 39 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Fibrin Index Units', llm='Fibrin Index Units', fhir='SAC-39'
- seq 40 · name · 2-vs-1 (examine **fhir** vs source): pydocx='System Induced Contaminants', llm='System Induced Contaminants', fhir='SAC-40'
- seq 41 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Drug Interference', llm='Drug Interference', fhir='SAC-41'
- seq 42 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Artificial Blood', llm='Artificial Blood', fhir='SAC-42'
- seq 43 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Special Handling Code', llm='Special Handling Code', fhir='SAC-43'
- seq 44 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Other Environmental Factors', llm='Other Environmental Factors', fhir='SAC-44'
- seq 45 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Length', llm='Container Length', fhir='SAC-45'
- seq 46 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Width', llm='Container Width', fhir='SAC-46'
- seq 47 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Form', llm='Container Form', fhir='SAC-47'
- seq 48 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Material', llm='Container Material', fhir='SAC-48'
- seq 49 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Container Common Name', llm='Container Common Name', fhir='SAC-49'

#### SID
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Application/Method Identifier', llm='Application/Method Identifier', fhir='SID-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance  Number', llm='Substance  Number', fhir='SID-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance Container Identifier', llm='Substance Container Identifier', fhir='SID-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Substance Manufacturer Identifier', llm='Substance Manufacturer Identifier', fhir='SID-4'

#### TCC
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Universal Service Identifier', llm='Universal Service Identifier', fhir='TCC-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Equipment Test Application Identifier', llm='Equipment Test Application Identifier', fhir='TCC-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Specimen Source', llm='Specimen Source', fhir='TCC-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Auto-Dilution Factor Default', llm='Auto-Dilution Factor Default', fhir='TCC-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Rerun Dilution Factor Default', llm='Rerun Dilution Factor Default', fhir='TCC-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Pre-Dilution Factor Default', llm='Pre-Dilution Factor Default', fhir='TCC-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Endogenous Content of Pre-Dilution Diluent', llm='Endogenous Content of Pre-Dilution Diluent', fhir='TCC-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Inventory Limits Warning Level', llm='Inventory Limits Warning Level', fhir='TCC-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Automatic Rerun Allowed', llm='Automatic Rerun Allowed', fhir='TCC-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Automatic Repeat Allowed', llm='Automatic Repeat Allowed', fhir='TCC-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Automatic Reflex Allowed', llm='Automatic Reflex Allowed', fhir='TCC-11'
- seq 12 · name · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='TCC-12'
- seq 13 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Units', llm='Units', fhir='TCC-13'
- seq 14 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Processing Type', llm='Processing Type', fhir='TCC-14'
- seq 15 · length · 2-vs-1 (examine **fhir** vs source): pydocx='705..705', llm='705..705', fhir='705'
- seq 15 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Test Criticality', llm='Test Criticality', fhir='TCC-15'

#### TCD
- seq 1 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Universal Service Identifier', llm='Universal Service Identifier', fhir='TCD-1'
- seq 2 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Auto-Dilution Factor', llm='Auto-Dilution Factor', fhir='TCD-2'
- seq 3 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Rerun Dilution Factor', llm='Rerun Dilution Factor', fhir='TCD-3'
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Pre-Dilution Factor', llm='Pre-Dilution Factor', fhir='TCD-4'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Endogenous Content of Pre-Dilution Diluent', llm='Endogenous Content of Pre-Dilution Diluent', fhir='TCD-5'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Automatic Repeat Allowed', llm='Automatic Repeat Allowed', fhir='TCD-6'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Reflex Allowed', llm='Reflex Allowed', fhir='TCD-7'
- seq 8 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Analyte Repeat Status', llm='Analyte Repeat Status', fhir='TCD-8'
- seq 9 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Specimen Consumption Quantity', llm='Specimen Consumption Quantity', fhir='TCD-9'
- seq 10 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Pool Size', llm='Pool Size', fhir='TCD-10'
- seq 11 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Auto-Dilution Type', llm='Auto-Dilution Type', fhir='TCD-11'

#### TQ2
- seq 6 · length · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='2'

#### UB1
- seq 1 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='SI', llm='SI', fhir=∅


## Complex data types (components)

### Structure coverage

| Sources containing the structure | Count |
|---|---:|
| 3 of 3 | 71 |
| 2 of 3 | 12 |
| 1 of 3 | 0 |

### Element coverage (across structures present in ≥1 source)

| Sources containing the element | Count |
|---|---:|
| 3 of 3 | 448 |
| 2 of 3 | 0 |
| 1 of 3 | 0 |

### Per-dimension agreement (elements present in ≥2 sources)

| Dimension | agree | 2-vs-1 split | 2-only split | 3-way split |
|---|---:|---:|---:|---:|
| name | 436 | 12 | 0 | 0 |
| data_type | 447 | 1 | 0 | 0 |
| optionality | 448 | 0 | 0 | 0 |
| length | 447 | 1 | 0 | 0 |
| conf_length | 448 | 0 | 0 | 0 |
| binding | 447 | 1 | 0 | 0 |

### 2-vs-1 splits: which source to examine against source `.docx`

_When two sources agree and one differs, the differing source is listed here as the one to check first — NOT as confirmed wrong._

| Outlier source | 2-vs-1 splits |
|---|---:|
| fhir | 15 |

### Detailed disagreements

#### CNN
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Suffix (e.g., JR or III)', llm='Suffix (e.g., JR or III)', fhir='Suffix'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Prefix (e.g., DR)', llm='Prefix (e.g., DR)', fhir='Prefix'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Degree (e.g., MD)', llm='Degree (e.g., MD)', fhir='Degree'

#### MSG
- seq 3 · length · 2-vs-1 (examine **fhir** vs source): pydocx=∅, llm=∅, fhir='3..7'

#### PPN
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Suffix (e.g., JR or III)', llm='Suffix (e.g., JR or III)', fhir='Suffix'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Prefix (e.g., DR)', llm='Prefix (e.g., DR)', fhir='Prefix'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Degree (e.g., MD)', llm='Degree (e.g., MD)', fhir='Degree'
- seq 8 · data_type · 2-vs-1 (examine **fhir** vs source): pydocx='CWE', llm='CWE', fhir=∅

#### RFR
- seq 2 · binding · 2-vs-1 (examine **fhir** vs source): pydocx='0001/0828', llm='0001/0828', fhir='0828'

#### XCN
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Suffix (e.g., JR or III)', llm='Suffix (e.g., JR or III)', fhir='Suffix'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Prefix (e.g., DR)', llm='Prefix (e.g., DR)', fhir='Prefix'
- seq 7 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Degree (e.g., MD)', llm='Degree (e.g., MD)', fhir='Degree'

#### XPN
- seq 4 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Suffix (e.g., JR or III)', llm='Suffix (e.g., JR or III)', fhir='Suffix'
- seq 5 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Prefix (e.g., DR)', llm='Prefix (e.g., DR)', fhir='Prefix'
- seq 6 · name · 2-vs-1 (examine **fhir** vs source): pydocx='Degree (e.g., MD)', llm='Degree (e.g., MD)', fhir='Degree'

