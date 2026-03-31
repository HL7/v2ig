# V2 Vocabulary Comparison Report

**Sources:** CH02C (Word) vs Colleague's IG (frankoemig) vs UTG/THO
**Generated:** 2026-03-30

## Summary

| Metric | Count |
|--------|-------|
| Total unique tables across all sources | 815 |
| All Sources | 367 |
| Ch02C And Colleague | 7 |
| Ch02C And Utg | 31 |
| Ch02C Only | 392 |
| Utg Only | 18 |
| Tables with code-level differences | 123 |
| Tables with metadata differences | 404 |
| Total individual code differences | 1237 |

## Tables in CH02C WITH Codes — Missing from Colleague

These tables have HL7-defined coded content in the Word document but no corresponding CodeSystem in the colleague's IG.

| Table | Name | Type | CH02C Codes | In UTG? | UTG Codes |
|-------|------|------|-------------|---------|-----------|
| 0069 | Hospital Service | User | 5 | Yes | 5 |
| 0092 | Re-Admission Indicator | User | 1 | Yes | 1 |
| 0093 | Release Information | ConceptDomainOnly | 3 | No | - |
| 0098 | Type of Agreement | User | 3 | Yes | 3 |
| 0125 | Value Type | HL7 | 78 | No | - |
| 0136 | Yes/no Indicator | HL7 | 2 | No | - |
| 0161 | Allow Substitution | HL7 | 3 | Yes | 3 |
| 0189 | Ethnic Group | User | 3 | Yes | 3 |
| 0203 | Identifier Type | HL7 | 140 | Yes | 147 |
| 0214 | Special Program Code | User | 5 | Yes | 5 |
| 0215 | Publicity Code | User | 4 | Yes | 4 |
| 0216 | Patient Status Code | User | 2 | Yes | 2 |
| 0232 | Insurance Company Contact Reason | User | 3 | Yes | 3 |
| 0286 | Provider Role | User | 4 | Yes | 4 |
| 0340 | Procedure Code Modifier | ConceptDomainOnly | 2 | No | - |
| 0374 | System Induced Contaminants | User | 1 | Yes | 1 |
| 0377 | Other Environmental Factors | User | 2 | Yes | 2 |
| 0393 | Match Algorithms | User | 2 | Yes | 2 |
| 0401 | Government Reimbursement Program | User | 2 | Yes | 2 |
| 0402 | School Type | User | 4 | Yes | 4 |
| 0406 | Participant Organization Unit Type | User | 7 | Yes | 7 |
| 0409 | Application Change Type | User | 3 | Yes | 3 |
| 0423 | Case Category Code | User | 1 | Yes | 1 |
| 0435 | Advance Directive Code | User | 2 | Yes | 2 |
| 0451 | Substance Identifier | ConceptDomainOnly | 1 | No | - |
| 0473 | Formulary Status | User | 4 | Yes | 4 |
| 0530 | Organization, Agency, Department | User | 6 | Yes | 6 |
| 0556 | Benefit Group | User | 2 | Yes | 2 |
| 0560 | Quantity Units | User | 5 | Yes | 5 |
| 0567 | Weight Units | HL7 | 4 | No | - |
| 0568 | Volume Units | HL7 | 3 | No | - |
| 0625 | Item Status Codes | User | 3 | Yes | 3 |
| 0634 | Item Importance Codes | User | 1 | Yes | 1 |
| 0657 | Device Type | User | 3 | Yes | 3 |
| 0790 | Approving Regulatory Agency | User | 2 | Yes | 2 |
| 0793 | Ruling Act | User | 1 | Yes | 1 |
| 0923 | Process Interruption | User | 3 | Yes | 3 |
| 0929 | Weight Units | HL7 | 4 | No | - |
| 0930 | Volume Units | HL7 | 3 | No | - |
| 0931 | Temperature Units | HL7 | 3 | No | - |
| 0932 | Donation Duration Units | User | 2 | No | - |

## Tables in CH02C WITHOUT Codes — Missing from Colleague

These 382 tables are concept-domain-only, externally-defined, or user-defined tables 
with no HL7-managed coded content. It is expected that the colleague's IG does not include them.

<details>
<summary>Show all 382 tables</summary>

| Table | Name | Type |
|-------|------|------|
| 0005 | Race | ConceptDomainOnly |
| 0010 | Physician ID | User |
| 0018 | Patient Type | ConceptDomainOnly |
| 0019 | Anesthesia Code | ConceptDomainOnly |
| 0021 | Bad Debt Agency Code | ConceptDomainOnly |
| 0022 | Billing Status | ConceptDomainOnly |
| 0023 | Admit Source | ConceptDomainOnly |
| 0024 | Fee Schedule | ConceptDomainOnly |
| 0032 | Charge/Price Indicator | ConceptDomainOnly |
| 0042 | Company Plan Code | ConceptDomainOnly |
| 0043 | Condition Code | ConceptDomainOnly |
| 0044 | Contract Code | ConceptDomainOnly |
| 0045 | Courtesy Code | ConceptDomainOnly |
| 0046 | Credit Rating | ConceptDomainOnly |
| 0049 | Department Code | ConceptDomainOnly |
| 0050 | Accident Code | ConceptDomainOnly |
| 0051 | Diagnosis Code | ConceptDomainOnly |
| 0055 | Diagnosis Related Group | ConceptDomainOnly |
| 0056 | DRG Grouper Review Code | ConceptDomainOnly |
| 0059 | Consent Code | ConceptDomainOnly |
| 0064 | Financial Class | ConceptDomainOnly |
| 0068 | Guarantor Type | ConceptDomainOnly |
| 0072 | Insurance Plan ID | ConceptDomainOnly |
| 0073 | Interest Rate Code | ConceptDomainOnly |
| 0078 | Interpretation Codes | HL7-EXT |
| 0084 | Performed by | ConceptDomainOnly |
| 0086 | Plan ID | ConceptDomainOnly |
| 0087 | Pre-Admit Test Indicator | ConceptDomainOnly |
| 0088 | Procedure Code | ConceptDomainOnly |
| 0099 | VIP Indicator | ConceptDomainOnly |
| 0110 | Transfer to Bad Debt Code | ConceptDomainOnly |
| 0111 | Delete Account Code | ConceptDomainOnly |
| 0112 | Discharge Disposition | ConceptDomainOnly |
| 0113 | Discharged to Location | ConceptDomainOnly |
| 0114 | Diet Type | ConceptDomainOnly |
| 0115 | Servicing Facilities | ConceptDomainOnly |
| 0117 | Account Status | ConceptDomainOnly |
| 0118 | Major Diagnostic Category | ConceptDomainOnly |
| 0129 | Accommodation Code | ConceptDomainOnly |
| 0132 | Transaction Code | ConceptDomainOnly |
| 0133 | Procedure practitioner identifier code type | ConceptDomainOnly |
| 0139 | Employer Information Data | ConceptDomainOnly |
| 0141 | Military Rank/Grade | ConceptDomainOnly |
| 0143 | Non-covered Insurance Code | ConceptDomainOnly |
| 0151 | Second Opinion Status | ConceptDomainOnly |
| 0152 | Second Opinion Documentation Received | ConceptDomainOnly |
| 0153 | Value Code | ConceptDomainOnly |
| 0171 | Citizenship | ConceptDomainOnly |
| 0172 | Veterans Military Status | ConceptDomainOnly |
| 0182 | Staff type | ConceptDomainOnly |
| 0184 | Department | ConceptDomainOnly |
| 0186 | Practitioner Category | ConceptDomainOnly |
| 0188 | Operator ID | User |
| 0212 | Nationality | ConceptDomainOnly |
| 0218 | Patient Charge Adjustment | ConceptDomainOnly |
| 0219 | Recurring Service Code | ConceptDomainOnly |
| 0222 | Contact Reason | ConceptDomainOnly |
| 0227 | Manufacturers of Vaccines (code=MVX) | Imported |
| 0229 | DRG Payor | ConceptDomainOnly |
| 0233 | Non-Concur Code/Description | ConceptDomainOnly |
| 0244 | Single Use Device | ConceptDomainOnly |
| 0245 | Product Problem | ConceptDomainOnly |
| 0246 | Product Available for Inspection | ConceptDomainOnly |
| 0249 | Generic Product | ConceptDomainOnly |
| 0259 | Modality | ConceptDomainOnly |
| 0264 | Location Department | ConceptDomainOnly |
| 0285 | Insurance Company ID Codes | ConceptDomainOnly |
| 0288 | Census Tract | ConceptDomainOnly |
| 0289 | County/Parish | ConceptDomainOnly |
| 0292 | Vaccines Administered | ConceptDomainOnly |
| 0293 | Billing Category | ConceptDomainOnly |
| 0295 | Handicap | ConceptDomainOnly |
| 0296 | Primary Language | ConceptDomainOnly |
| 0297 | CN ID Source | ConceptDomainOnly |
| 0300 | Namespace ID | ConceptDomainOnly |
| 0302 | Point of Care | ConceptDomainOnly |
| 0303 | Room | ConceptDomainOnly |
| 0304 | Bed | ConceptDomainOnly |
| 0306 | Location Status | ConceptDomainOnly |
| 0307 | Building | ConceptDomainOnly |
| 0308 | Floor | ConceptDomainOnly |
| 0312 | Policy Scope | ConceptDomainOnly |
| 0313 | Policy Source | ConceptDomainOnly |
| 0319 | Department Cost Center | ConceptDomainOnly |
| 0320 | Item Natural Account Code | ConceptDomainOnly |
| 0327 | Job Code | ConceptDomainOnly |
| 0328 | Employee Classification | ConceptDomainOnly |
| 0333 | Driver's License Issuing Authority | ConceptDomainOnly |
| 0341 | Guarantor Credit Rating Code | ConceptDomainOnly |
| 0342 | Military Recipient | ConceptDomainOnly |
| 0343 | Military Handicapped Program Code | ConceptDomainOnly |
| 0345 | Appeal Reason | ConceptDomainOnly |
| 0346 | Certification Agency | ConceptDomainOnly |
| 0347 | State/Province | User |
| 0350 | Occurrence Code | ConceptDomainOnly |
| 0351 | Occurrence Span | ConceptDomainOnly |
| 0358 | Practitioner Group | ConceptDomainOnly |
| 0361 | Application | ConceptDomainOnly |
| 0362 | Facility | ConceptDomainOnly |
| 0363 | Assigning Authority | ConceptDomainOnly |
| 0378 | Carrier Type | ConceptDomainOnly |
| 0379 | Tray Type | ConceptDomainOnly |
| 0380 | Separator Type | ConceptDomainOnly |
| 0381 | Cap Type | ConceptDomainOnly |
| 0382 | Drug Interference | ConceptDomainOnly |
| 0385 | Manufacturer Identifier | ConceptDomainOnly |
| 0386 | Supplier Identifier | ConceptDomainOnly |
| 0399 | Country Code | External |
| 0405 | Organization Unit | ConceptDomainOnly |
| 0412 | Category Identifier | ConceptDomainOnly |
| 0413 | Consent Identifier | ConceptDomainOnly |
| 0414 | Units of Time | ConceptDomainOnly |
| 0446 | Species Code | ConceptDomainOnly |
| 0447 | Breed Code | ConceptDomainOnly |
| 0448 | Name Context | ConceptDomainOnly |
| 0452 | Health Care Provider Type Code | ConceptDomainOnly |
| 0453 | Health Care Provider Classification | ConceptDomainOnly |
| 0454 | Health Care Provider Area of Specialization | ConceptDomainOnly |
| 0455 | Type of Bill Code | ConceptDomainOnly |
| 0456 | Revenue code | ConceptDomainOnly |
| 0458 | OCE Edit Code | User |
| 0461 | License Number | ConceptDomainOnly |
| 0462 | Location Cost Center | ConceptDomainOnly |
| 0463 | Inventory Number | ConceptDomainOnly |
| 0464 | Facility ID | ConceptDomainOnly |
| 0467 | Modifier Edit Code | User |
| 0471 | Query Name | ConceptDomainOnly |
| 0476 | Medically Necessary Duplicate Procedure Reason | ConceptDomainOnly |
| 0479 | Pharmaceutical Substances | ConceptDomainOnly |
| 0509 | Indication for Use | ConceptDomainOnly |
| 0512 | Commercial Product | ConceptDomainOnly |
| 0515 | Transfusion Interrupted Reason | ConceptDomainOnly |
| 0519 | Override Reason | ConceptDomainOnly |
| 0521 | Override Code | ConceptDomainOnly |
| 0522 | Requested Discipline(s) (AUT-11) | ConceptDomainOnly |
| 0525 | Privilege | ConceptDomainOnly |
| 0526 | Privilege Class | ConceptDomainOnly |
| 0531 | Institution | ConceptDomainOnly |
| 0533 | Application Error Code | ConceptDomainOnly |
| 0537 | Institution | ConceptDomainOnly |
| 0539 | Cost Center Code | ConceptDomainOnly |
| 0541 | Specimen Type Modifier | ConceptDomainOnly |
| 0542 | Specimen Source Type Modifier | ConceptDomainOnly |
| 0543 | Specimen Collection Site | ConceptDomainOnly |
| 0546 | Authorized Discipline(s) (AUT-12) | ConceptDomainOnly |
| 0549 | NDC Codes | ConceptDomainOnly |
| 0551 | Authorization Referral Type (AUT-13) | ConceptDomainOnly |
| 0552 | Advanced Beneficiary Notice Override Reason | ConceptDomainOnly |
| 0563 | Approval Status (AUT-14) | ConceptDomainOnly |
| 0573 | Clinical Service (AUT-16) | ConceptDomainOnly |
| 0574 | Encounter Type (AUT-21) | ConceptDomainOnly |
| 0575 | BP Universal Service Identifier (BPO-2) | ConceptDomainOnly |
| 0576 | BP Units (BPO-6) | ConceptDomainOnly |
| 0577 | BC Component  (BPX-6) | ConceptDomainOnly |
| 0578 | BC Donation Type / Intended Use  (BPX-7) | ConceptDomainOnly |
| 0579 | BP Blood Group  (BPX-11) | ConceptDomainOnly |
| 0580 | BC Special Testing  (BPX-12) | ConceptDomainOnly |
| 0581 | BP Units (BPX-16) | ConceptDomainOnly |
| 0582 | BC Component  (BTX-3) | ConceptDomainOnly |
| 0583 | BC Blood Group (BTX-4) | ConceptDomainOnly |
| 0584 | BP Units (BTX-10) | ConceptDomainOnly |
| 0585 | Starting Notification Code (CNS-5) | ConceptDomainOnly |
| 0586 | Ending Notification Code (CNS-6) | ConceptDomainOnly |
| 0587 | Study Phase Identifier (CSP-1) | ConceptDomainOnly |
| 0588 | Study Phase Evaluability (CSP-4) | ConceptDomainOnly |
| 0589 | Institution Registering the Patient (CSR-3) | ConceptDomainOnly |
| 0590 | Patient Study Eligibility Status (CSR-10) | ConceptDomainOnly |
| 0591 | Randomized Study Arm (CSR-12) | ConceptDomainOnly |
| 0592 | Stratum for Study Randomization (CSR-13) | ConceptDomainOnly |
| 0593 | Patient Evaluability Status (CSR-14) | ConceptDomainOnly |
| 0594 | Reason Ended Study (CSR-16) | ConceptDomainOnly |
| 0595 | Study Scheduled Time Point (CSS-1) | ConceptDomainOnly |
| 0596 | Study Quality Control Codes (CSS-3) | ConceptDomainOnly |
| 0597 | Study Phase Identifier (CTI-2) | ConceptDomainOnly |
| 0598 | Study Scheduled Time Point (CTI-3) | ConceptDomainOnly |
| 0599 | Inventory Container Identifier (INV-4) | ConceptDomainOnly |
| 0600 | Container Carrier Identifier (INV-5) | ConceptDomainOnly |
| 0601 | Position on Carrier (INV-6) | ConceptDomainOnly |
| 0602 | Quantity Units (INV-11) | ConceptDomainOnly |
| 0603 | Test/Fluid Identifier(s) (INV-15) | ConceptDomainOnly |
| 0604 | Modality  (IPC-5) | ConceptDomainOnly |
| 0605 | Protocol Code (IPC-6) | ConceptDomainOnly |
| 0606 | Scheduled Procedure Step Location (IPC-8) | ConceptDomainOnly |
| 0607 | Primary Key Value - MFA (MFA-5) | ConceptDomainOnly |
| 0608 | Primary Key Value - MFE (MFE-4) | ConceptDomainOnly |
| 0609 | Principal Language Of Message (MSH-19) | ConceptDomainOnly |
| 0610 | Notification Code (NDS-4) | ConceptDomainOnly |
| 0611 | Coded Comment (NTE-9) | ConceptDomainOnly |
| 0612 | Universal Service Identifier (OBR-4) | ConceptDomainOnly |
| 0613 | Danger Code (OBR-12) | ConceptDomainOnly |
| 0614 | Transport Logistics of Collected Sample * (OBR-38) | ConceptDomainOnly |
| 0619 | Collector's Comment * (OBR-39) | ConceptDomainOnly |
| 0620 | Transport Arrangement Responsibility (OBR-40) | ConceptDomainOnly |
| 0621 | Planned Patient Transport Comment (OBR-43) | ConceptDomainOnly |
| 0622 | Observation Identifier (OBX-3) | ConceptDomainOnly |
| 0623 | Units (OBX-6) | ConceptDomainOnly |
| 0624 | Producer's ID (OBX-15) | ConceptDomainOnly |
| 0626 | Observation Method (OBX-17) | ConceptDomainOnly |
| 0627 | Service Period (ODS-2) | ConceptDomainOnly |
| 0628 | Diet, Supplement, or Preference Code (ODS-3) | ConceptDomainOnly |
| 0629 | Service Period (ODT-2) | ConceptDomainOnly |
| 0630 | Producer's Service/Test/Observation ID (OM1-2) | ConceptDomainOnly |
| 0631 | Producer ID (OM1-5) | ConceptDomainOnly |
| 0632 | Other Service/Test/Observation IDs for the Observation (OM1-7) | ConceptDomainOnly |
| 0633 | Identity of Instrument Used to Perform this Study (OM1-13) | ConceptDomainOnly |
| 0635 | Coded Representation of Method (OM1-14) | ConceptDomainOnly |
| 0636 | Observation Producing Department/Section (OM1-16) | ConceptDomainOnly |
| 0637 | Report Subheader (OM1-19) | ConceptDomainOnly |
| 0638 | Outside Site(s) Where Observation May Be Performed (OM1-27) | ConceptDomainOnly |
| 0639 | Observations Required to Interpret this Observation (OM1-31) | ConceptDomainOnly |
| 0640 | Contraindications to Observations (OM1-33) | ConceptDomainOnly |
| 0641 | Reflex Tests/Observations (OM1-34) | ConceptDomainOnly |
| 0643 | Fixed Canned Message (OM1-36) | ConceptDomainOnly |
| 0644 | Procedure Medication (OM1-38) | ConceptDomainOnly |
| 0645 | Target Anatomic Site Of Test (OM1-46) | ConceptDomainOnly |
| 0646 | Replacement Producer's Service/Test/Observation ID (OM1-52) | ConceptDomainOnly |
| 0647 | Observation/Identifier associated with Producer’s Service/Test/Observation ID (OM1-56) | ConceptDomainOnly |
| 0648 | Units of Measure (OM2-2) | ConceptDomainOnly |
| 0649 | Corresponding SI Units of Measure (OM2-4) | ConceptDomainOnly |
| 0650 | Preferred Coding System (OM3-2) | ConceptDomainOnly |
| 0652 | Valid Coded "Answers" (OM3-3) | ConceptDomainOnly |
| 0654 | Normal Text/Codes for Categorical Observations (OM3-4) | ConceptDomainOnly |
| 0655 | Abnormal Text/Codes for Categorical Observations (OM3-5) | ConceptDomainOnly |
| 0656 | Critical Text/Codes for Categorical Observations (OM3-6) | ConceptDomainOnly |
| 0658 | Container Units (OM4-5) | ConceptDomainOnly |
| 0660 | Specimen (OM4-6) | ConceptDomainOnly |
| 0661 | Taxonomic Classification Code (OM4-18) | ConceptDomainOnly |
| 0662 | Test/Observations Included Within an Ordered Test Battery (OM5-2) | ConceptDomainOnly |
| 0663 | Test/Service Default Duration Units (OM7-9) | ConceptDomainOnly |
| 0664 | Clinical Information Request (OMC-4) | ConceptDomainOnly |
| 0665 | Answer Choices (OMC-11) | ConceptDomainOnly |
| 0666 | Entering Organization (ORC-17) | ConceptDomainOnly |
| 0668 | Entering Device (ORC-18) | ConceptDomainOnly |
| 0670 | Implicated Product (PCR-1) | ConceptDomainOnly |
| 0671 | Product Class (PCR-3) | ConceptDomainOnly |
| 0672 | Indication For Product Use (PCR-10) | ConceptDomainOnly |
| 0673 | Product Evaluation Performed (PCR-14) | ConceptDomainOnly |
| 0674 | Product Evaluation Results (PCR-16) | ConceptDomainOnly |
| 0675 | Country (PDC-2) | ConceptDomainOnly |
| 0676 | Generic Name (PDC-5) | ConceptDomainOnly |
| 0677 | Product Code (PDC-9) | ConceptDomainOnly |
| 0678 | Event Identifiers Used (PEO-1) | ConceptDomainOnly |
| 0679 | Event Symptom/Diagnosis Code (PEO-2) | ConceptDomainOnly |
| 0680 | Cause Of Death (PEO-18) | ConceptDomainOnly |
| 0681 | Primary Key Value - PRA (PRA-1) | ConceptDomainOnly |
| 0683 | Vendor ID (RQ1-4) | ConceptDomainOnly |
| 0684 | Item Code - Internal (RQD-2) | ConceptDomainOnly |
| 0686 | Hospital Item Code (RQD-4) | ConceptDomainOnly |
| 0687 | Requisition Unit of Measure (RQD-6) | ConceptDomainOnly |
| 0688 | Deliver To ID (RQD-9) | ConceptDomainOnly |
| 0689 | Administered Units (RXA-7) | ConceptDomainOnly |
| 0690 | Administered Dosage Form (RXA-8) | ConceptDomainOnly |
| 0691 | Administration Notes (RXA-9) | ConceptDomainOnly |
| 0692 | Administered Strength Units (RXA-14) | ConceptDomainOnly |
| 0693 | Substance/Treatment Refusal Reason (RXA-18) | ConceptDomainOnly |
| 0694 | Indication (RXA-19) | ConceptDomainOnly |
| 0695 | Administered Drug Strength Volume Units (RXA-24) | ConceptDomainOnly |
| 0696 | Administered Barcode Identifier (RXA-25) | ConceptDomainOnly |
| 0697 | Component Code (RXC-2) | ConceptDomainOnly |
| 0698 | Component Units (RXC-4) | ConceptDomainOnly |
| 0699 | Component Strength Units (RXC-6) | ConceptDomainOnly |
| 0700 | Supplementary Code (RXC-7) | ConceptDomainOnly |
| 0701 | Component Drug Strength Volume Units (RXC-9) | ConceptDomainOnly |
| 0703 | Dispense Units (RXC-11) | ConceptDomainOnly |
| 0704 | Actual Dispense Units (RXD-5) | ConceptDomainOnly |
| 0705 | Actual Dosage Form (RXD-6) | ConceptDomainOnly |
| 0706 | Special Dispensing Instructions (RXD-15) | ConceptDomainOnly |
| 0707 | Actual Strength Unit (RXD-17) | ConceptDomainOnly |
| 0708 | Indication (RXD-21) | ConceptDomainOnly |
| 0709 | Dispense Package Size Unit (RXD-23) | ConceptDomainOnly |
| 0710 | Supplementary Code (RXD-25) | ConceptDomainOnly |
| 0711 | Initiating Location (RXD-26) | ConceptDomainOnly |
| 0712 | Packaging/Assembly Location (RXD-27) | ConceptDomainOnly |
| 0713 | Actual Drug Strength Volume Units (RXD-29) | ConceptDomainOnly |
| 0714 | Dispense to Pharmacy (RXD-30) | ConceptDomainOnly |
| 0715 | Give Units (RXE-5) | ConceptDomainOnly |
| 0716 | Give Dosage Form (RXE-6) | ConceptDomainOnly |
| 0718 | Provider's Administration Instructions (RXE-7) | ConceptDomainOnly |
| 0719 | Access Restriction Reason Code | HL7-EXT |
| 0720 | Dispense Units (RXE-11) | ConceptDomainOnly |
| 0721 | Special Dispensing Instructions (RXE-21) | ConceptDomainOnly |
| 0722 | Give Rate Units (RXE-24) | ConceptDomainOnly |
| 0723 | Give Strength Units (RXE-26) | ConceptDomainOnly |
| 0724 | Give Indication (RXE-27) | ConceptDomainOnly |
| 0726 | Dispense Package Size Unit (RXE-29) | ConceptDomainOnly |
| 0727 | Supplementary Code (RXE-31) | ConceptDomainOnly |
| 0729 | Give Drug Strength Volume Units (RXE-34) | ConceptDomainOnly |
| 0730 | Pharmaceutical Substance Alternative (RXE-37) | ConceptDomainOnly |
| 0732 | Pharmacy of Most Recent Fill (RXE-38) | ConceptDomainOnly |
| 0733 | Dispensing Pharmacy (RXE-40) | ConceptDomainOnly |
| 0735 | Give Units (RXG-7) | ConceptDomainOnly |
| 0736 | Give Dosage Form (RXG-8) | ConceptDomainOnly |
| 0737 | Administration Notes (RXG-9) | ConceptDomainOnly |
| 0738 | Special Administration Instructions (RXG-13) | ConceptDomainOnly |
| 0740 | Give Rate Units (RXG-16) | ConceptDomainOnly |
| 0741 | Give Strength Units (RXG-18) | ConceptDomainOnly |
| 0743 | Indication (RXG-22) | ConceptDomainOnly |
| 0744 | Give Drug Strength Volume Units (RXG-24) | ConceptDomainOnly |
| 0745 | Give Barcode Identifier (RXG-25) | ConceptDomainOnly |
| 0746 | Dispense Units (RXG-33) | ConceptDomainOnly |
| 0747 | Requested Give Code (RXO-1) | ConceptDomainOnly |
| 0748 | Requested Give Units (RXO-4) | ConceptDomainOnly |
| 0750 | Requested Dosage Form (RXO-5) | ConceptDomainOnly |
| 0751 | Provider's Pharmacy/Treatment Instructions (RXO-6) | ConceptDomainOnly |
| 0752 | Provider's Administration Instructions (RXO-7) | ConceptDomainOnly |
| 0753 | Requested Dispense Code (RXO-10) | ConceptDomainOnly |
| 0754 | Requested Dispense Units (RXO-12) | ConceptDomainOnly |
| 0756 | Requested Give Strength Units (RXO-19) | ConceptDomainOnly |
| 0758 | Indication (RXO-20) | ConceptDomainOnly |
| 0760 | Requested Give Rate Units (RXO-22) | ConceptDomainOnly |
| 0762 | Supplementary Code (RXO-24) | ConceptDomainOnly |
| 0764 | Requested Drug Strength Volume Units (RXO-26) | ConceptDomainOnly |
| 0765 | Dispensing Pharmacy (RXO-32) | ConceptDomainOnly |
| 0766 | Routing Instruction (RXR-5) | ConceptDomainOnly |
| 0768 | Bolus Dose Volume Units (RXV-6) | ConceptDomainOnly |
| 0769 | PCA Dose Amount Units (RXV-9) | ConceptDomainOnly |
| 0770 | PCA Dose Amount Volume Units (RXV-11) | ConceptDomainOnly |
| 0771 | Resource Type or Category | ConceptDomainOnly |
| 0772 | Max Dose Amount Units (RXV-13) | ConceptDomainOnly |
| 0773 | Max Dose Amount Volume Units (RXV-15) | ConceptDomainOnly |
| 0774 | Location (SAC-15) | ConceptDomainOnly |
| 0775 | Container Height/Diameter/Delta Units (SAC-20) | ConceptDomainOnly |
| 0777 | Volume Units (SAC-24) | ConceptDomainOnly |
| 0779 | Hemolysis Index Units (SAC-33) | ConceptDomainOnly |
| 0780 | Lipemia Index Units (SAC-35) | ConceptDomainOnly |
| 0781 | Icterus Index Units (SAC-37) | ConceptDomainOnly |
| 0782 | Fibrin Index Units (SAC-39) | ConceptDomainOnly |
| 0783 | Application/Method Identifier (SID-1) | ConceptDomainOnly |
| 0784 | Specimen Source Site (SPM-8) | ConceptDomainOnly |
| 0785 | Container Type  (SPM-27) | ConceptDomainOnly |
| 0786 | Primary Key Value – STF (STF-1) | ConceptDomainOnly |
| 0787 | Universal Service Identifier (TCC-1) | ConceptDomainOnly |
| 0788 | Units (TCC-13) | ConceptDomainOnly |
| 0789 | Universal Service Identifier (TCD-1) | ConceptDomainOnly |
| 0791 | Folder Assignment (TXA-24) | ConceptDomainOnly |
| 0792 | Creating Specialty (TXA-28) | ConceptDomainOnly |
| 0794 | Units (CQ.2) | ConceptDomainOnly |
| 0795 | Implantation Status (DEV-17) | ConceptDomainOnly |
| 0809 | Maintenance Cycle | ConceptDomainOnly |
| 0811 | Maintenance Type | ConceptDomainOnly |
| 0821 | Gender Identity | HL7-EXT |
| 0822 | Personal Pronouns | HL7-EXT |
| 0824 | Recorded Sex or Gender Type | User |
| 0826 | SourceDocumentTypeForRecordedSexOrGender | ConceptDomainOnly |
| 0827 – Source Document Jurisdiction for Recorded Sex or  Gender |  | HL7 |
| 0828 | Sex Parameter for Clinical Use | HL7 |
| 0832 | Document Class | ConceptDomainOnly |
| 0833 | Document Event | ConceptDomainOnly |
| 0836 | Problem Severity | ConceptDomainOnly |
| 0838 | Problem Perspective | ConceptDomainOnly |
| 0865 | Referral Documentation Completion Status | ConceptDomainOnly |
| 0879 | Product/Service Code | ConceptDomainOnly |
| 0880 | Product/Service Code Modifier | ConceptDomainOnly |
| 0895 | Present On Admission (POA) Indicator | User |
| 0908 | Package Type | ConceptDomainOnly |
| 0910 | Acquisition Modality | User |
| 0913 | Monetary Denomination Code | ConceptDomainOnly |
| 0915 | Process Control Code | ConceptDomainOnly |
| 0934 | Order Workflow Profile | ConceptDomainOnly |
| 0941 | Procedure Code | ConceptDomainOnly |
| 0943 | Transport Destination | ConceptDomainOnly |
| 0944 | Transport Route | ConceptDomainOnly |
| 0947 | Class of Trade | ConceptDomainOnly |
| 0952 | Confidentiality Classification | External |
| 0953 | Security Label Handling Instructions | HL7-EXT |
| 0954 | Work Schedule ODH | HL7-EXT |
| 0955 | Industry | External |
| 0956 | Job Supervisory Level or Pay Grade | External |
| 0957 | Employment Status (ODH) | HL7-EXT |
| 0958 | Occupation | External |
| 0959 | Work Classification ODH | HL7-EXT |
| 0960 | Data Absent Reason | HL7-EXT |
| 0961 | Device Type | HL7-EXT |
| 0962 | Device Status | HL7-EXT |
| 0963 | Device Safety | HL7-EXT |
| 0964 | Service Reason | ConceptDomainOnly |
| 0965 | Contract Type | ConceptDomainOnly |
| 0966 | Pricing Tier Level | ConceptDomainOnly |
| 0967 | Container Form | ConceptDomainOnly |
| 0968 | Container Material | ConceptDomainOnly |
| 0969 | Container Common Name | ConceptDomainOnly |
| 9999 | Placeholder Table Representation | HL7 |

</details>

## Tables with Code-Level Differences

### Table 0003 — Event
Code counts: CH02C: 383, Colleague: 382, UTG: 384

**Codes in CH02C but not in Colleague (1):**

- `Varies` — MFQ/MFR - Master files query (use event same as asking for e.g., M05 - location) *(also in UTG)*

**Codes only in UTG (1):**

- `varies` — MFQ/MFR - Master files query (use event same as asking for e.g., M05 - location)

**Status mismatches (15):**

- `Q04`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `Q07`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `Q08`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `Q09`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R03`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R05`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R06`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R07`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R08`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `R09`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `RAR`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `RDR`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `RER`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `RGR`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `X01`: CH02C=`D`, Colleague=`inactive`, UTG=`active`

### Table 0006 — Religion
Code counts: CH02C: 85, Colleague: 85, UTG: 95

**Codes only in UTG (10):**

- `A` — Atheist
- `B` — Baptist
- `C` — Catholic
- `E` — Episcopalian
- `J` — Judaism
- `L` — Lutheran
- `M` — Church of Latter Day Saints (Mormon)
- `N` — Hindu
- `P` — Protestant
- `QUA` — Christian: Friends

### Table 0012 — stockLocation
Code counts: CH02C: 0, Colleague: 0, UTG: 2

**Codes only in UTG (2):**

- `AN` — Filled from ancillary department stock
- `FL` — Filled from floor stock

### Table 0027 — Priority
Code counts: CH02C: 5, Colleague: 5, UTG: 5

**Display name truncations (4):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `A` | As soon as possible (a priority lower than stat) | As soon as possible | As soon as possible (a priority lower than stat) |
| `P` | Preoperative (to be done prior to surgery) | Preoperative | Preoperative (to be done prior to surgery) |
| `S` | Stat (do immediately) | Stat | Stat (do immediately) |
| `T` | Timing critical (do as near as possible to requested time) | Timing critical | Timing critical (do as near as possible to requested time) |

### Table 0033 — route
Code counts: CH02C: 0, Colleague: 0, UTG: 28

**Codes only in UTG (28):**

- `AP` — Apply externally
- `CH` — Chew
- `DU` — Dust
- `EA` — Ear
- `EY` — Eye
- `IA` — Intro-arterial
- `ID` — Intra-dermal
- `IF` — Infiltrate
- `IH` — Inhalation
- `IM` — Intra-muscular
- `IN` — Intra-nasal
- `IR` — Irrigate
- `IS` — Inserted
- `IT` — Intrathecal
- `IV` — Intravenous
- `NB` — Nebulized
- `NG` — Nathogasic
- `PA` — Peri-anally
- `PT` — Paint
- `PU` — IV push
- `RC` — Rectally
- `SH` — Shampoo
- `SL` — Sublingual
- `SO` — Soak
- `SS` — IV soluset
- `TP` — Topically
- `WA` — Wash
- `WI` — Wipe

### Table 0034 — siteAdministered
Code counts: CH02C: 0, Colleague: 0, UTG: 2

**Codes only in UTG (2):**

- `B` — Buttock
- `L` — Left arm

### Table 0048 — whatSubjectFilter
Code counts: CH02C: 0, Colleague: 0, UTG: 38

**Codes only in UTG (38):**

- `ADV` — Advice/diagnosis
- `ANU` — Nursing unit lookup (returns patients in beds, excluding empty beds)
- `APA` — Account number query, return matching visit
- `APM` — Medical record number query, returns visits for a medical record number
- `APN` — Patient name lookup
- `APP` — Physician lookup
- `ARN` — Nursing unit lookup (returns patients in beds, including empty beds)
- `CAN` — Cancel.  Used to cancel a query
- `DEM` — Demographics
- `FIN` — Financial
- `GID` — Generate new identifier
- `GOL` — Goals
- `MFQ` — Master file query
- `MRI` — Most recent inpatient
- `MRO` — Most recent outpatient
- `NCK` — Network clock
- `NSC` — Network status change
- `NST` — Network statistic
- `ORD` — Order
- `OTH` — Other
- `PRB` — Problems
- `PRO` — Procedure
- `RAR` — Pharmacy administration information
- `RDR` — Pharmacy dispense information
- `RER` — Pharmacy encoded order information
- `RES` — Result
- `RGR` — Pharmacy give information
- `ROR` — Pharmacy prescription information
- `SAL` — All schedule related information, including open slots, booked slots, blocked slots
- `SBK` — Booked slots on the identified schedule
- `SBL` — Blocked slots on the identified schedule
- `SOF` — First open slot on the identified schedule after the start date/tiem
- `SOP` — Open slots on the identified schedule between the begin and end of the start date/time range
- `SSA` — Time slots available for a single appointment
- `SSR` — Time slots available for a recurring appointment
- `STA` — Status
- `VXI` — Vaccine Information
- `XID` — Get cross-referenced identifiers

### Table 0065 — Specimen Action Code
Code counts: CH02C: 7, Colleague: 8, UTG: 8

**Codes in Colleague but not in CH02C (1):**

- `C` — Cancel order for battery or tests named *(also in UTG)*

**Status mismatches (1):**

- `C`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0066 — Employment Status
Code counts: CH02C: 11, Colleague: 11, UTG: 15

**Codes only in UTG (4):**

- `...` — see chapter 6
- `D` — Per Diem
- `F` — Full Time
- `P` — Part Time

### Table 0069 — Hospital Service
Code counts: CH02C: 5, Colleague: 0, UTG: 5

**Codes in CH02C but not in Colleague (5):**

- `CAR` — Cardiac Service *(also in UTG)*
- `MED` — Medical Service *(also in UTG)*
- `PUL` — Pulmonary Service *(also in UTG)*
- `SUR` — Surgical Service *(also in UTG)*
- `URO` — Urology Service *(also in UTG)*

### Table 0070 — specimenSourceCodes
Code counts: CH02C: 0, Colleague: 0, UTG: 137

**Codes only in UTG (137):**

- `ABLD` — Arterial blood
- `ABS` — Abscess
- `AMN` — Amniotic fluid
- `ASP` — Aspirate
- `BBL` — Blood bag
- `BDY` — Whole body
- `BIFL` — Bile fluid
- `BLD` — Whole blood
- `BLDA` — Blood  arterial
- `BLDC` — Blood  capillary
- `BLDCO` — Cord blood
- `BLDV` — Blood  venous
- `BON` — Bone
- `BPH` — Basophils
- `BPU` — Blood product unit
- `BRN` — Burn
- `BRO` — Bronchial
- `BRTH` — Breath (use EXHLD)
- `CALC` — Calculus (=Stone)
- `CBLD` — Cord blood
- `CDM` — Cardiac muscle
- `CNJT` — Conjunctiva
- `CNL` — Cannula
- `COL` — Colostrum
- `CSF` — Cerebral spinal fluid
- `CTP` — Catheter tip
- `CUR` — Curettage
- `CVM` — Cervical mucus
- `CVX` — Cervix
- `CYST` — Cyst
- `DIAF` — Dialysis fluid
- `DOSE` — Dose med or substance
- `DRN` — Drain
- `DUFL` — Duodenal fluid
- `EAR` — Ear
- `EARW` — Ear wax (cerumen)
- `ELT` — Electrode
- `ENDC` — Endocardium
- `ENDM` — Endometrium
- `EOS` — Eosinophils
- `EXG` — Exhaled gas (=breath)
- `EXHLD` — Exhaled gas (=breath)
- `EYE` — Eye
- `FIB` — Fibroblasts
- `FIST` — Fistula
- `FLT` — Filter
- `FLU` — Body fluid, unsp
- `GAS` — Gas
- `GAST` — Gastric fluid/contents
- `GEN` — Genital
- `GENC` — Genital cervix
- `GENL` — Genital lochia
- `GENV` — Genital vaginal
- `HAR` — Hair
- `IHG` — Inhaled Gas
- `ISLT` — Isolate
- `IT` — Intubation tube
- `LAM` — Lamella
- `LIQ` — Liquid NOS
- `LN` — Line
- `LNA` — Line arterial
- `LNV` — Line venous
- `LYM` — Lymphocytes
- `MAC` — Macrophages
- `MAR` — Marrow
- `MBLD` — Menstrual blood
- `MEC` — Meconium
- `MILK` — Breast milk
- `MLK` — Milk
- `MN` — Amniotic Fluid
- `NAIL` — Nail
- `NOS` — Nose (nasal passage)
- `ORH` — Other
- `OTH` — Other
- `PAFL` — Pancreatic fluid
- `PAT` — Patient
- `PER` — Peritoneum
- `PLAS` — Plasma
- `PLB` — Plasma bag
- `PLC` — Placenta
- `PLR` — Pleural fluid (thoracentesis fld)
- `PMN` — Polymorphonuclear neutrophils
- `PPP` — Platelet poor plasma
- `PRP` — Platelet rich plasma
- `PRT` — Peritoneal fluid /ascites
- `PUS` — Pus
- `RBC` — Erythrocytes
- `RT` — Route of medicine
- `SAL` — Saliva
- `SEM` — Seminal fluid
- `SER` — Serum
- `SKM` — Skeletal muscle
- `SKN` — Skin
- `SMN` — Seminal fluid
- `SNV` — Synovial fluid (Joint fluid)
- `SPRM` — Spermatozoa
- `SPT` — Sputum
- `SPTC` — Sputum - coughed
- `SPTT` — Sputum - tracheal aspirate
- `STL` — Stool = Fecal
- `STON` — Stone (use CALC)
- `SWT` — Sweat
- `TEAR` — Tears
- `THRB` — Thrombocyte (platelet)
- `THRT` — Throat
- `TIS` — Tissue
- `TISB` — Tissue bone marrow
- `TISC` — Tissue curettage
- `TISG` — Tissue gall bladder
- `TISL` — Tissue lung
- `TISP` — Tissue peritoneum
- `TISPL` — Tissue placenta
- `TISS` — Tissue
- `TISU` — Tissue ulcer
- `TLGI` — Tissue large intestine
- `TLNG` — Tissue lung
- `TSMI` — Tissue small intestine
- `TUB` — Tube NOS
- `ULC` — Ulcer
- `UMB` — Umbilical blood
- `UMED` — Unknown medicine
- `UR` — Urine
- `URC` — Urine clean catch
- `URNS` — Urine sediment
- `URT` — Urine catheter
- `URTH` — Urethra
- `USUB` — Unknown substance
- `VITF` — Vitreous Fluid
- `VOM` — Vomitus
- `WAT` — Water
- `WBC` — Leukocytes
- `WICK` — Wick
- `WND` — Wound
- `WNDA` — Wound abscess
- `WNDD` — Wound drainage
- `WNDE` — Wound exudate
- `XXX` — To be specified in another part of the message

### Table 0074 — Diagnostic Service Section ID
Code counts: CH02C: 41, Colleague: 45, UTG: 45

**Codes in Colleague but not in CH02C (4):**

- `IMG` — Diagnostic Imaging *(also in UTG)*
- `PAR` — Parasitology *(also in UTG)*
- `PAT` — Pathology (gross & histopath, not surgical) *(also in UTG)*
- `URN` — Urinalysis *(also in UTG)*

**Display name truncations (3):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `EC` | Electrocardiac (e.g., EKG,  EEC, Holter) | Electrocardiac | Electrocardiac (e.g., EKG,  EEC, Holter) |
| `EN` | Electroneuro (EEG, EMG,EP,PSG) | Electroneuro | Electroneuro (EEG, EMG,EP,PSG) |
| `PHY` | Physician (Hx. Dx, admission note, etc.) | Physician | Physician (Hx. Dx, admission note, etc.) |

**Status mismatches (4):**

- `IMG`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PAR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PAT`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `URN`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0076 — Message Type
Code counts: CH02C: 147, Colleague: 158, UTG: 159

**Codes in Colleague but not in CH02C (11):**

- `CNQ` — Cancel query *(also in UTG)*
- `EDR` — Enhanced display response *(also in UTG)*
- `EQQ` — Embedded query language query *(also in UTG)*
- `ERP` — Event replay response *(also in UTG)*
- `ERQ` — Event replay query *(also in UTG)*
- `MCF` — Delayed Acknowledgment (Retained for backward compatibility only) *(also in UTG)*
- `ROC` — Request clinical information *(also in UTG)*
- `ROD` — Request pateint demographics *(also in UTG)*
- `RQQ` — Event replay query *(also in UTG)*
- `SPQ` — Stored procedure request *(also in UTG)*
- `VQQ` — Virtual table query *(also in UTG)*

**Codes only in UTG (1):**

- `ARD` — Ancillary RPT (display) (for backward compatibility only)

**Status mismatches (47):**

- `ADR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `CNQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `DOC`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `DSR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `EDR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `EQQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ERP`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ERQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `MCF`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `MFD`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `MFQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `MFR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `NMQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `NMR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ORF`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ORM`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ORR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `OSQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `OSR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PPT`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PPV`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PRR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `PTR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `QCK`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `QRY`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RAR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RCI`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RCL`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RDR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RER`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RGR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ROC`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ROD`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `ROR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RQC`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `RQQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SET`: CH02C=``, Colleague=`inactive`, UTG=`N`
- `SPQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SQM`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SQR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SUR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `TBR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `UDM`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `VQQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `VXQ`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `VXR`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `VXX`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0085 — Observation Result Status Codes Interpretation
Code counts: CH02C: 15, Colleague: 15, UTG: 15

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `S` | Partial results.   Deprecated. Retained only for backward compatibility as of V2.6. | Partial results | Partial results.   Deprecated. Retained only for backward compatibility as of V2.6. |
| `U` | Results status change to final without retransmitting results already sent as 'preliminary.'  E.g., radiology changes status from preliminary to final | Results status change to final without retransmitting results already sent as 'preliminary'. E.g., radiology changes status from preliminary to final | Results status change to final without retransmitting results already sent as 'preliminary.'  E.g., radiology changes status from preliminary to final |

### Table 0092 — Re-Admission Indicator
Code counts: CH02C: 1, Colleague: 0, UTG: 1

**Codes in CH02C but not in Colleague (1):**

- `R` — Re-admission *(also in UTG)*

### Table 0093 — Release Information
Code counts: CH02C: 3, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (3):**

- `...` — user-defined codes *(not in UTG either)*
- `N` — No *(not in UTG either)*
- `Y` — Yes *(not in UTG either)*

### Table 0098 — Type of Agreement
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `M` — Maternity *(also in UTG)*
- `S` — Standard *(also in UTG)*
- `U` — Unified *(also in UTG)*

### Table 0102 — delayedAcknowledgmentType
Code counts: CH02C: 0, Colleague: 0, UTG: 2

**Codes only in UTG (2):**

- `D` — Message received, stored for later processing
- `F` — acknowledgment after processing

### Table 0104 — Version ID
Code counts: CH02C: 17, Colleague: 17, UTG: 17

**Codes only in UTG (1):**

- `2.3.2` — Release 2.3.2

**Codes in CH02C/Colleague but missing from UTG (1):**

- `2.9.1` — Draft 2.9.1

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `2.9` | Release 2.9 | Release 2.9 | Draft 2.9 |

### Table 0106 — queryResponseFormat
Code counts: CH02C: 0, Colleague: 0, UTG: 3

**Codes only in UTG (3):**

- `D` — Response is in display format
- `R` — Response is in record-oriented format
- `T` — Response is in tabular format

### Table 0107 — deferredResponseType
Code counts: CH02C: 0, Colleague: 0, UTG: 2

**Codes only in UTG (2):**

- `B` — Before the Date/Time specified
- `L` — Later than the Date/Time specified

### Table 0108 — queryResultsLevel
Code counts: CH02C: 0, Colleague: 0, UTG: 4

**Codes only in UTG (4):**

- `O` — Order plus order status
- `R` — Results without bulk text
- `S` — Status only
- `T` — Full results

### Table 0109 — reportPriority
Code counts: CH02C: 0, Colleague: 0, UTG: 2

**Codes only in UTG (2):**

- `R` — Routine
- `S` — Stat

### Table 0125 — Value Type
Code counts: CH02C: 78, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (78):**

- `AUI` — Authorization information *(not in UTG either)*
- `CCD` — Charge code and date *(not in UTG either)*
- `CCP` — Channel calibration parameters *(not in UTG either)*
- `CD` — Channel definition *(not in UTG either)*
- `CF` — Coded element with formatted values *(not in UTG either)*
- `CNE` — Coded with no exceptions *(not in UTG either)*
- `CNN` — Composite ID number and name simplified *(not in UTG either)*
- `CP` — Composite price *(not in UTG either)*
- `CSU` — Channel sensitivity and units *(not in UTG either)*
- `CWE` — Coded with exceptions *(not in UTG either)*
- `CX` — Extended composite ID with check digit *(not in UTG either)*
- `DDI` — Daily deductible information *(not in UTG either)*
- `DIN` — Date and institution name *(not in UTG either)*
- `DLD` — Discharge to location and date *(not in UTG either)*
- `DLN` — Driver's license number *(not in UTG either)*
- `DLT` — Delta *(not in UTG either)*
- `DR` — Date/time range *(not in UTG either)*
- `DT` — Date *(not in UTG either)*
- `DTM` — Date/time *(not in UTG either)*
- `DTN` — Day type and number *(not in UTG either)*
- `ED` — Encapsulated data *(not in UTG either)*
- `EI` — Entity identifier *(not in UTG either)*
- `EIP` — Entity identifier pair *(not in UTG either)*
- `ERL` — Error location *(not in UTG either)*
- `FC` — Financial class *(not in UTG either)*
- `FT` — Formatted text *(not in UTG either)*
- `GTS` — General timing specification *(not in UTG either)*
- `HD` — Hierarchic designator *(not in UTG either)*
- `ICD` — Insurance certification definition *(not in UTG either)*
- `IS` — Coded value for user-defined tables *(not in UTG either)*
- `JCC` — Job code/class *(not in UTG either)*
- `LA1` — Location with address variation 1 *(not in UTG either)*
- `LA2` — Location with address variation 2 *(not in UTG either)*
- `MA` — Multiplexed array *(not in UTG either)*
- `MO` — Money *(not in UTG either)*
- `MOC` — Money and charge code *(not in UTG either)*
- `MOP` — Money or percentage *(not in UTG either)*
- `MSG` — Message type *(not in UTG either)*
- `NA` — Numeric array *(not in UTG either)*
- `NDL` — Name with date and location *(not in UTG either)*
- `NM` — Numeric *(not in UTG either)*
- `NR` — Numeric range *(not in UTG either)*
- `OCD` — Occurrence code and date *(not in UTG either)*
- `OSP` — Occurrence span code and date *(not in UTG either)*
- `PIP` — Practitioner institutional privileges *(not in UTG either)*
- `PL` — Person location *(not in UTG either)*
- `PLN` — Practitioner license or other ID number *(not in UTG either)*
- `PPN` — Performing person time stamp *(not in UTG either)*
- `PRL` — Parent result link *(not in UTG either)*
- `PT` — Processing type *(not in UTG either)*
- `PTA` — Policy type and amount *(not in UTG either)*
- `QIP` — Query input parameter list *(not in UTG either)*
- `QSC` — Query selection criteria *(not in UTG either)*
- `RCD` — Row column definition *(not in UTG either)*
- `RFR` — Reference range *(not in UTG either)*
- `RI` — Repeat interval *(not in UTG either)*
- `RMC` — Room coverage *(not in UTG either)*
- `RP` — Reference pointer *(not in UTG either)*
- `RPT` — Repeat pattern *(not in UTG either)*
- `SCV` — Scheduling class value pair *(not in UTG either)*
- `SN` — Structured numeric *(not in UTG either)*
- `SNM` — String of telephone number digits *(not in UTG either)*
- `SPD` — Specialty description *(not in UTG either)*
- `SRT` — Sort order *(not in UTG either)*
- `ST` — String data *(not in UTG either)*
- `TM` — Time *(not in UTG either)*
- `TX` — Text data *(not in UTG either)*
- `UVC` — UB value code and amount *(not in UTG either)*
- `VH` — Visiting hours *(not in UTG either)*
- `VID` — Version identifier *(not in UTG either)*
- `VR` — Value range *(not in UTG either)*
- `WVI` — Channel Identifier *(not in UTG either)*
- `WVS` — Waveform source *(not in UTG either)*
- `XAD` — Extended address *(not in UTG either)*
- `XCN` — Extended composite ID number and name for persons *(not in UTG either)*
- `XON` — Extended composite name and ID number for organizations *(not in UTG either)*
- `XPN` — Extended person name *(not in UTG either)*
- `XTN` — Extended telecommunications number *(not in UTG either)*

### Table 0131 — Contact Role
Code counts: CH02C: 8, Colleague: 8, UTG: 12

**Codes only in UTG (4):**

- `BP` — Billing contact person
- `CP` — Contact person
- `EP` — Emergency contact person
- `PR` — Person preparing referral

### Table 0133 — Procedure practitioner identifier code type
Code counts: CH02C: 0, Colleague: 0, UTG: 9

**Codes only in UTG (9):**

- `AN` — Anesthesiologist/Anesthetist
- `AS` — Assistant Surgeon
- `CM` — Certified Nurse Midwife
- `NP` — Nurse Practitioner
- `PR` — Procedure MD/ Surgeon
- `PS` — Primary Surgeon
- `RD` — Radiologist
- `RS` — Resident
- `SN` — Scrub Nurse

### Table 0136 — Yes/no Indicator
Code counts: CH02C: 2, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (2):**

- `N` — No *(not in UTG either)*
- `Y` — Yes *(not in UTG either)*

### Table 0156 — whichDate-timeQualifier
Code counts: CH02C: 0, Colleague: 0, UTG: 7

**Codes only in UTG (7):**

- `ANY` — Any date/time within a range
- `CAN` — Cancellation date/time
- `COL` — Collection date/time, equivalent to film or sample collection date/time
- `ORD` — Order date/time
- `RCT` — Specimen receipt date/time, receipt of specimen in filling ancillary (Lab)
- `REP` — Report date/time, report date/time at filling ancillary (i.e., Lab)
- `SCHED` — Schedule date/time

### Table 0157 — whichDate-timeStatusQualifier
Code counts: CH02C: 0, Colleague: 0, UTG: 6

**Codes only in UTG (6):**

- `ANY` — Any status
- `CFN` — Current final value, whether final or corrected
- `COR` — Corrected only (no final with corrections)
- `FIN` — Final only (no corrections)
- `PRE` — Preliminary
- `REP` — Report completion date/time

### Table 0158 — date-timeSelectionQualifier
Code counts: CH02C: 0, Colleague: 0, UTG: 4

**Codes only in UTG (4):**

- `1ST` — First value within range
- `ALL` — All values within the range
- `LST` — Last value within the range
- `REV` — All values within the range returned in reverse chronological order (This is the default if not otherwise specified.)

### Table 0161 — Allow Substitution
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `G` — Allow generic substitutions. *(also in UTG)*
- `N` — Substitutions are NOT authorized.  (This is the default - null.) *(also in UTG)*
- `T` — Allow therapeutic substitutions *(also in UTG)*

### Table 0163 — Body Site
Code counts: CH02C: 54, Colleague: 54, UTG: 56

**Codes only in UTG (2):**

- `LNB` — Nebulized
- `LV` — Left Vastus Lateralis

### Table 0167 — Substitution Status
Code counts: CH02C: 11, Colleague: 11, UTG: 11

**Display name truncations (3):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `G` | A generic substitution was dispensed. | A generic substitution was dispensed | A generic substitution was dispensed. |
| `N` | No substitute was dispensed.  This is equivalent to the default (null) value. | No substitute was dispensed | No substitute was dispensed.  This is equivalent to the default (null) value. |
| `T` | A therapeutic substitution was dispensed. | A therapeutic substitution was dispensed | A therapeutic substitution was dispensed. |

### Table 0168 — Processing Priority
Code counts: CH02C: 7, Colleague: 7, UTG: 7

**Display name truncations (6):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `A` | As soon as possible (a priority lower than stat) | As soon as possible | As soon as possible (a priority lower than stat) |
| `B` | Do at bedside or portable (may be used with other codes) | Do at bedside or portable | Do at bedside or portable (may be used with other codes) |
| `C` | Measure continuously (e.g., arterial line blood pressure) | Measure continuously | Measure continuously (e.g., arterial line blood pressure) |
| `P` | Preoperative (to be done prior to surgery) | Preoperative | Preoperative (to be done prior to surgery) |
| `S` | Stat (do immediately) | Stat | Stat (do immediately) |
| `T` | Timing critical (do as near as possible to requested time) | Timing critical | Timing critical (do as near as possible to requested time) |

### Table 0174 — Nature of Service/Test/Observation
Code counts: CH02C: 5, Colleague: 5, UTG: 5

**Display name truncations (5):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `A` | Atomic service/test/observation (test code or treatment code) | Atomic service/test/observation | Atomic service/test/observation (test code or treatment code) |
| `C` | Single observation calculated via a rule or formula from other independent observations (e.g., Alveolar-arterial ratio, cardiac output) | Single observation, calculated | Single observation calculated via a rule or formula from other independent observations (e.g., Alveolar-arterial ratio, cardiac output) |
| `F` | Functional procedure that may consist of one or more interrelated measures (e.g., glucose tolerance test, creatinine clearance), usually done at different times and/or on different specimens | Functional procedure | Functional procedure that may consist of one or more interrelated measures (e.g., glucose tolerance test, creatinine clearance), usually done at different times and/or on different specimens |
| `P` | Profile or battery consisting of many independent atomic observations (e.g., SMA12, electrolytes), usually done at one instrument on one specimen | Profile or battery | Profile or battery consisting of many independent atomic observations (e.g., SMA12, electrolytes), usually done at one instrument on one specimen |
| `S` | Superset-a set of batteries or procedures ordered under a single code unit but processed as separate batteries (e.g., routines = CBC, UA, electrolytes)
This set indicates that the code being described is used to order multiple service/test/observation b | Superset-a set of batteries or procedures | Superset-a set of batteries or procedures ordered under a single code unit but processed as separate batteries (e.g., routines = CBC, UA, electrolytes)<p>This set indicates that the code being described is used to order multiple service/test/observation b |

### Table 0175 — Master File Identifier Code
Code counts: CH02C: 16, Colleague: 16, UTG: 26

**Codes only in UTG (10):**

- `CM0` — Clinical study master
- `CM1` — Clinical study phase master
- `CM2` — Clinical study Data Schedule Master
- `OM1` — Observation text master file segments (e.g., Lab)
- `OM1-OM6` — Observation text master file segments (e.g., Lab)
- `OM2` — Observation text master file segments (e.g., Lab)
- `OM3` — Observation text master file segments (e.g., Lab)
- `OM4` — Observation text master file segments (e.g., Lab)
- `OM5` — Observation text master file segments (e.g., Lab)
- `OM6` — Observation text master file segments (e.g., Lab)

### Table 0179 — Response Level
Code counts: CH02C: 4, Colleague: 4, UTG: 4

**Display name truncations (4):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `AL` | Always.  All MFA segments (whether denoting errors or not) must be returned via the application-level acknowledgment message | Always | Always.  All MFA segments (whether denoting errors or not) must be returned via the application-level acknowledgment message |
| `ER` | Error/Reject conditions only.  Only MFA segments denoting errors must be returned via the application-level acknowledgment for this message | Error/Reject conditions only | Error/Reject conditions only.  Only MFA segments denoting errors must be returned via the application-level acknowledgment for this message |
| `NE` | Never.  No application-level response needed | Never | Never.  No application-level response needed |
| `SU` | Success.  Only MFA segments denoting success must be returned via the application-level acknowledgment for this message | Success | Success.  Only MFA segments denoting success must be returned via the application-level acknowledgment for this message |

### Table 0180 — Masterfile Action Code
Code counts: CH02C: 5, Colleague: 5, UTG: 5

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `MDC` | Deactivate: discontinue using record in master file, but do not delete from database | Deactivate/discontinue record | Deactivate: discontinue using record in master file, but do not delete from database |

### Table 0185 — Preferred Method of Contact
Code counts: CH02C: 6, Colleague: 6, UTG: 6

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `E` | E-Mail Address (for backward compatibility) | E-Mail Address | E-Mail Address (for backward compatibility) |

### Table 0189 — Ethnic Group
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `H` — Hispanic or Latino *(also in UTG)*
- `N` — Not Hispanic or Latino *(also in UTG)*
- `U` — Unknown *(also in UTG)*

### Table 0190 — Address Type
Code counts: CH02C: 18, Colleague: 18, UTG: 18

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `N` | Birth (nee)  (birth address, not otherwise specified) | Birth (nee) (birth address, not otherwise specified) | Birth (nee)  (birth address, not otherwise specified) |
| `RH` | Registry home. Refers to the information system, typically managed by a public health agency, that stores patient information such as immunization histories or cancer data, regardless of where the patient obtains services. | Registry home | Registry home. Refers to the information system, typically managed by a public health agency, that stores patient information such as immunization histories or cancer data, regardless of where the patient obtains services. |

### Table 0191 — Type of Referenced Data
Code counts: CH02C: 10, Colleague: 10, UTG: 13

**Codes only in UTG (3):**

- `Application` — Other application data, typically uninterpreted binary data  (HL7 V2.3 and later)
- `Audio` — Audio data  (HL7 V2.3 and later)
- `Image` — Image data  (HL7 V2.3 and later)

**Display name truncations (9):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `AP` | Other application data, typically uninterpreted binary data (HL7 V2.3 and later) | Other application data, typically uninterpreted binary data | Other application data, typically uninterpreted binary data (HL7 V2.3 and later) |
| `AU` | Audio data (HL7 V2.3 and later) | Audio Data | Audio data (HL7 V2.3 and later) |
| `FT` | Formatted text (HL7 V2.2 only) | Formatted Text | Formatted text (HL7 V2.2 only) |
| `IM` | Image data (HL7 V2.3 and later) | Image Data | Image data (HL7 V2.3 and later) |
| `NS` | Non-scanned image (HL7 V2.2 only) | Non-scanned Image | Non-scanned image (HL7 V2.2 only) |
| `SD` | Scanned document (HL7 V2.2 only) | Scanned document | Scanned document (HL7 V2.2 only) |
| `SI` | Scanned image (HL7 V2.2 only) | Scanned Image | Scanned image (HL7 V2.2 only) |
| `TEXT` | Machine readable text document (HL7 V2.3.1 and later) | Machine readable text document | Machine readable text document (HL7 V2.3.1 and later) |
| `TX` | Machine readable text document (HL7 V2.2 only) | Machine Readable Text Document | Machine readable text document (HL7 V2.2 only) |

**Status mismatches (5):**

- `FT`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `NS`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SD`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `SI`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `TX`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0200 — Name Type
Code counts: CH02C: 22, Colleague: 23, UTG: 24

**Codes in Colleague but not in CH02C (1):**

- `O` — Other *(also in UTG)*

**Codes only in UTG (1):**

- `...` — No suggested values defined

**Status mismatches (1):**

- `O`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0201 — Telecommunication Use Code
Code counts: CH02C: 9, Colleague: 10, UTG: 10

**Codes in Colleague but not in CH02C (1):**

- `DSM` — Direct Secure Messaging *(also in UTG)*

### Table 0202 — Telecommunication Equipment Type
Code counts: CH02C: 11, Colleague: 11, UTG: 10

**Codes in CH02C/Colleague but missing from UTG (1):**

- `DSM` — Direct Secure Messaging

### Table 0203 — Identifier Type
Code counts: CH02C: 140, Colleague: 0, UTG: 147

**Codes in CH02C but not in Colleague (140):**

- `AC` — Accreditation/Certification Identifier *(also in UTG)*
- `ACSN` — Accession ID *(also in UTG)*
- `AIN` — Animal Identification Number (US Official) *(also in UTG)*
- `AM` — American Express *(also in UTG)*
- `AMA` — American Medical Association Number *(also in UTG)*
- `AN` — Account number *(also in UTG)*
- `ANC` — Account number Creditor *(also in UTG)*
- `AND` — Account number debitor *(also in UTG)*
- `ANON` — Anonymous identifier *(also in UTG)*
- `ANT` — Temporary Account Number *(also in UTG)*
- `APRN` — Advanced Practice Registered Nurse number *(also in UTG)*
- `ASID` — Ancestor Specimen ID *(also in UTG)*
- `BA` — Bank Account Number *(also in UTG)*
- `BC` — Bank Card Number *(also in UTG)*
- `BCFN` — Birth Certificate File Number *(also in UTG)*
- `BCT` — Birth Certificate *(also in UTG)*
- `BR` — Birth registry number *(also in UTG)*
- `BRN` — Breed Registry Number *(also in UTG)*
- `BSNR` — Primary physician office number *(also in UTG)*
- `CAAI` — Consumer Application Account Identifier *(also in UTG)*
- `CC` — Cost Center number *(also in UTG)*
- `CONM` — Change of Name Document *(also in UTG)*
- `CY` — County number *(also in UTG)*
- `CZ` — Citizenship Card *(also in UTG)*
- `DC` — Death Certificate ID *(also in UTG)*
- `DCFN` — Death Certificate File Number *(also in UTG)*
- `DDS` — Dentist license number *(also in UTG)*
- `DEA` — Drug Enforcement Administration registration number *(also in UTG)*
- `DFN` — Drug Furnishing or prescriptive authority Number *(also in UTG)*
- `DI` — Diner's Club card *(also in UTG)*
- `DL` — Driver's license number *(also in UTG)*
- `DN` — Doctor number *(also in UTG)*
- `DO` — Osteopathic License number *(also in UTG)*
- `DP` — Diplomatic Passport *(also in UTG)*
- `DPM` — Podiatrist license number *(also in UTG)*
- `DR` — Donor Registration Number *(also in UTG)*
- `DS` — Discover Card *(also in UTG)*
- `DSG` — Diagnostic Study Group *(also in UTG)*
- `EI` — Employee number *(also in UTG)*
- `EN` — Employer number *(also in UTG)*
- `ESN` — Staff Enterprise Number *(also in UTG)*
- `FDR` — Fetal Death Report ID *(also in UTG)*
- `FDRFN` — Fetal Death Report File Number *(also in UTG)*
- `FGN` — Filler Group Number *(also in UTG)*
- `FI` — Facility ID *(also in UTG)*
- `FILL` — Filler Identifier *(also in UTG)*
- `GI` — Guarantor internal identifier *(also in UTG)*
- `GIN` — Animal Group Identifier (US Official) *(also in UTG)*
- `GKV` — insured's ID with public insurance *(also in UTG)*
- `GL` — General ledger number *(also in UTG)*
- `GN` — Guarantor external  identifier *(also in UTG)*
- `HC` — Health Card Number *(also in UTG)*
- `IND` — Indigenous/Aboriginal *(also in UTG)*
- `JHN` — Jurisdictional health number *(also in UTG)*
- `KZVA` — dentist office number *(also in UTG)*
- `LACSN` — Laboratory Accession ID *(also in UTG)*
- `LANR` — Lifelong physician number *(also in UTG)*
- `LI` — Labor and industries number *(also in UTG)*
- `LN` — License number *(also in UTG)*
- `LR` — Local Registry ID *(also in UTG)*
- `MA` — Patient Medicaid number *(also in UTG)*
- `MB` — Member Number *(also in UTG)*
- `MC` — Patient's Medicare number *(also in UTG)*
- `MCD` — Practitioner Medicaid number *(also in UTG)*
- `MCN` — Microchip Number *(also in UTG)*
- `MCR` — Practitioner Medicare number *(also in UTG)*
- `MCT` — Marriage Certificate *(also in UTG)*
- `MD` — Medical License number *(also in UTG)*
- `MI` — Military ID number *(also in UTG)*
- `MR` — Medical record number *(also in UTG)*
- `MRT` — Temporary Medical Record Number *(also in UTG)*
- `MS` — MasterCard *(also in UTG)*
- `NBSNR` — Secondary physician office number *(also in UTG)*
- `NCT` — Naturalization Certificate *(also in UTG)*
- `NE` — National employer identifier *(also in UTG)*
- `NH` — National Health Plan Identifier *(also in UTG)*
- `NI` — National unique individual identifier *(also in UTG)*
- `NII` — National Insurance Organization Identifier *(also in UTG)*
- `NIIP` — National Insurance Payor Identifier (Payor) *(also in UTG)*
- `NNxxx` — National Person Identifier where the xxx is the ISO table 3166 3-character (alphabetic) country code *(also in UTG)*
- `NP` — Nurse practitioner number *(also in UTG)*
- `NPI` — National provider identifier *(also in UTG)*
- `OBI` — Observation Instance Identifier *(also in UTG)*
- `OD` — Optometrist license number *(also in UTG)*
- `PA` — Physician Assistant number *(also in UTG)*
- `PC` — Parole Card *(also in UTG)*
- `PCN` — Penitentiary/correctional institution Number *(also in UTG)*
- `PE` — Living Subject Enterprise Number *(also in UTG)*
- `PEN` — Pension Number *(also in UTG)*
- `PGN` — Placer Group Number *(also in UTG)*
- `PHC` — Public Health Case Identifier *(also in UTG)*
- `PHE` — Public Health Event Identifier *(also in UTG)*
- `PHO` — Public Health Official ID *(also in UTG)*
- `PI` — Patient internal identifier *(also in UTG)*
- `PIN` — Premises Identifier Number (US Official) *(also in UTG)*
- `PKV` — insured's ID with private insurance *(also in UTG)*
- `PLAC` — Placer Identifier *(also in UTG)*
- `PN` — Person number *(also in UTG)*
- `PNT` — Temporary Living Subject Number *(also in UTG)*
- `PPIN` — Medicare/CMS Performing Provider Identification Number *(also in UTG)*
- `PPN` — Passport number *(also in UTG)*
- `PRC` — Permanent Resident Card Number *(also in UTG)*
- `PRN` — Provider number *(also in UTG)*
- `PT` — Patient external identifier *(also in UTG)*
- `QA` — QA number *(also in UTG)*
- `RI` — Resource identifier *(also in UTG)*
- `RN` — Registered Nurse Number *(also in UTG)*
- `RPH` — Pharmacist license number *(also in UTG)*
- `RR` — Railroad Retirement number *(also in UTG)*
- `RRI` — Regional registry ID *(also in UTG)*
- `RRP` — Railroad Retirement Provider *(also in UTG)*
- `SAMN` — SAMN# accession Number *(also in UTG)*
- `SB` — Social Beneficiary Identifier *(also in UTG)*
- `SID` — Specimen ID *(also in UTG)*
- `SL` — State license *(also in UTG)*
- `SN` — Subscriber Number *(also in UTG)*
- `SNBSN` — State assigned NDBS card Identifier *(also in UTG)*
- `SNO` — Serial Number *(also in UTG)*
- `SP` — Study Permit *(also in UTG)*
- `SR` — State registry ID *(also in UTG)*
- `SRX` — SRA Accession number *(also in UTG)*
- `SS` — Social Security number *(also in UTG)*
- `STN` — Shipment Tracking Number *(also in UTG)*
- `TAX` — Tax ID number *(also in UTG)*
- `TN` — Treaty Number/ (Canada) *(also in UTG)*
- `TPR` — Temporary Permanent Resident (Canada) *(also in UTG)*
- `TRL` — Training License Number *(also in UTG)*
- `U` — Unspecified identifier *(also in UTG)*
- `UDI` — Universal Device Identifier *(also in UTG)*
- `UPIN` — Medicare/CMS (formerly HCFA)'s Universal Physician Identification numbers *(also in UTG)*
- `USID` — Unique Specimen ID *(also in UTG)*
- `VN` — Visit number *(also in UTG)*
- `VP` — Visitor Permit *(also in UTG)*
- `VS` — VISA *(also in UTG)*
- `WC` — WIC identifier *(also in UTG)*
- `WCN` — Workers' Comp Number *(also in UTG)*
- `WP` — Work Permit *(also in UTG)*
- `XV` — Health Plan Identifier *(also in UTG)*
- `XX` — Organization identifier *(also in UTG)*
- `ZANR` — dentist identifier *(also in UTG)*

**Codes only in UTG (7):**

- `ETIN` — Electronic Transmitter Identification Number
- `IRISTEM` — An IRI stem
- `L&I` — Labor and industries number
- `NIIH` — National Insurance Headquarters Organization Identifier
- `PAYERID` — Payer Identifier
- `UCID` — Unique Claim Identifier
- `UMB` — Unique Product-independent Payer Person Identifier

**Status mismatches (1):**

- `NNxxx`: CH02C=`D`, Colleague=``, UTG=`active`

### Table 0207 — Processing Mode
Code counts: CH02C: 5, Colleague: 4, UTG: 6

**Codes in CH02C but not in Colleague (1):**

- `Not present` — Not present (the default, meaning current  processing) *(also in UTG)*

**Codes only in UTG (1):**

- `not present` — Not present (the default, meaning current  processing)

### Table 0210 — Relational Conjunction
Code counts: CH02C: 2, Colleague: 2, UTG: 2

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `AND` | Default | "and" - Default | Default |

### Table 0211 — Alternate Character Sets
Code counts: CH02C: 21, Colleague: 25, UTG: 25

**Codes in Colleague but not in CH02C (4):**

- `JAS2020` — A subset of ISO2020 used for most Kanjii transmissions *(also in UTG)*
- `JIS X 0202` — ISO 2022 with escape sequences for Kanjii *(also in UTG)*
- `UNICODE UTF-16` — UCS Transformation Format, 16-bit form *(also in UTG)*
- `UNICODE UTF-32` — UCS Transformation Format, 32-bit form *(also in UTG)*

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `ASCII` | The printable 7-bit ASCII character set. | The printable 7-bit ASCII character set | The printable 7-bit ASCII character set. |

**Status mismatches (2):**

- `UNICODE UTF-16`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `UNICODE UTF-32`: CH02C=``, Colleague=`inactive`, UTG=`active`

### Table 0213 — Purge Status Code
Code counts: CH02C: 3, Colleague: 3, UTG: 3

**Display name truncations (3):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `D` | The visit is marked for deletion and the user cannot enter new data against it. | marked for deletion | The visit is marked for deletion and the user cannot enter new data against it. |
| `I` | The visit is marked inactive and the user cannot enter new data against it. | marked as inactive | The visit is marked inactive and the user cannot enter new data against it. |
| `P` | Marked for purge.  User is no longer able to update the visit. | marked for purge | Marked for purge.  User is no longer able to update the visit. |

### Table 0214 — Special Program Code
Code counts: CH02C: 5, Colleague: 0, UTG: 5

**Codes in CH02C but not in Colleague (5):**

- `CH` — Child Health Assistance *(also in UTG)*
- `ES` — Elective Surgery Program *(also in UTG)*
- `FP` — Family Planning *(also in UTG)*
- `O` — Other *(also in UTG)*
- `U` — Unknown *(also in UTG)*

### Table 0215 — Publicity Code
Code counts: CH02C: 4, Colleague: 0, UTG: 4

**Codes in CH02C but not in Colleague (4):**

- `F` — Family only *(also in UTG)*
- `N` — No Publicity *(also in UTG)*
- `O` — Other *(also in UTG)*
- `U` — Unknown *(also in UTG)*

### Table 0216 — Patient Status Code
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `AI` — Active Inpatient *(also in UTG)*
- `DI` — Discharged Inpatient *(also in UTG)*

### Table 0223 — Living Dependency
Code counts: CH02C: 5, Colleague: 5, UTG: 8

**Codes only in UTG (3):**

- `CB` — Common Bath
- `D` — Spouse dependent
- `WU` — Walk up

### Table 0232 — Insurance Company Contact Reason
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `01` — Medicare claim status *(also in UTG)*
- `02` — Medicaid claim status *(also in UTG)*
- `03` — Name/address change *(also in UTG)*

### Table 0256 — Time Delay Post Challenge
Code counts: CH02C: 44, Colleague: 44, UTG: 44

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `5H` | 5  hours post challenge | 5 hours post challenge | 5  hours post challenge |

### Table 0257 — Nature of Challenge
Code counts: CH02C: 3, Colleague: 3, UTG: 3

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `EXCZ` | Exercise undertaken as challenge (can be quantified) | Exercise undertaken as challenge | Exercise undertaken as challenge (can be quantified) |

### Table 0272 — Document Confidentiality Status
Code counts: CH02C: 3, Colleague: 3, UTG: 9

**Codes only in UTG (6):**

- `1` — ASTM Level 1
- `2` — ASTM Level 2
- `3` — ASTM Level 3
- `RE` — Restricted
- `UC` — Usual control
- `VR` — Very restricted

### Table 0277 — Appointment Type Codes
Code counts: CH02C: 3, Colleague: 3, UTG: 6

**Codes only in UTG (3):**

- `COMPLETE` — A request to add a completed appointment, used to maintain records of completed appointments that did not appear in the schedule (e.g., STAT, walk-in, etc.)
- `NORMAL` — Routine schedule request type - default if not valued
- `TENTATIVE` — A request for a tentative (e.g., “penciled in”) appointment

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `Normal` | Routine schedule request type – default if not valued | Routine schedule request type - default if not valued | Routine schedule request type – default if not valued |
| `Tentative` | A request for a tentative (e.g., “penciled in”) appointment | A request for a tentative (e.g., "penciled in") appointment | A request for a tentative (e.g., “penciled in”) appointment |

### Table 0278 — Filler status codes
Code counts: CH02C: 12, Colleague: 12, UTG: 21

**Codes only in UTG (9):**

- `BLOCKED` — Blocked
- `BOOKED` — Booked
- `CANCELLED` — Cancelled
- `COMPLETE` — Complete
- `DELETED` — Deleted
- `OVERBOOK` — Overbook
- `PENDING` — Pending
- `STARTED` — Started
- `WAITLIST` — Waitlist

**Display name truncations (12):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `Blocked` | The indicated time slot(s) is(are) blocked | Blocked | Blocked |
| `Booked` | The indicated appointment is booked | The indicated appointment is booked | Booked |
| `Cancelled` | The indicated appointment was stopped from occurring (canceled prior to starting) | Cancelled | Cancelled |
| `Complete` | The indicated appointment has completed normally (was not discontinued, canceled, or deleted) | Complete | Complete |
| `DC` | The indicated appointment was discontinued (DC’ed while in progress, discontinued parent appointment, or discontinued child appointment) | Discontinued | Discontinued |
| `Deleted` | The indicated appointment was deleted from the filler application | Deleted | Deleted |
| `Discontinued` | The indicated appointment was discontinued (DC’ed while in progress, discontinued parent appointment, or discontinued child appointment) | Discontinued | Discontinued |
| `Noshow` | The patient did not show up for the appointment | Noshow | Noshow |
| `Overbook` | The appointment has been confirmed; however it is confirmed in an overbooked state | Overbook | Overbook |
| `Pending` | Appointment has not yet been confirmed | Pending | Pending |
| `Started` | The indicated appointment has begun and is currently in progress | Started | Started |
| `Waitlist` | Appointment has been placed on a waiting list for a particular slot, or set of slots | Waitlist | Waitlist |

### Table 0279 — Allow Substitution Codes
Code counts: CH02C: 4, Colleague: 4, UTG: 8

**Codes only in UTG (4):**

- `CONFIRM` — Contact the Placer Contact Person prior to making any substitutions of this resource
- `NO` — Substitution of this resource is not allowed
- `NOTIFY` — Notify the Placer Contact Person, through normal institutional procedures, that a substitution of this resource has been made
- `YES` — Substitution of this resource is allowed

### Table 0281 — Referral Type
Code counts: CH02C: 6, Colleague: 6, UTG: 12

**Codes only in UTG (6):**

- `HOM` — Home Care
- `LAB` — Laboratory
- `MED` — Medical
- `PSY` — Psychiatric
- `RAD` — Radiology
- `SKN` — Skilled Nursing

### Table 0286 — Provider Role
Code counts: CH02C: 4, Colleague: 0, UTG: 4

**Codes in CH02C but not in Colleague (4):**

- `CP` — Consulting Provider *(also in UTG)*
- `PP` — Primary Care Provider *(also in UTG)*
- `RP` — Referring Provider *(also in UTG)*
- `RT` — Referred to Provider *(also in UTG)*

### Table 0290 — mimeBase64EncodingCharacters
Code counts: CH02C: 0, Colleague: 0, UTG: 65

**Codes only in UTG (65):**

- `(pad)` — =
- `0` — A
- `1` — B
- `10` — K
- `11` — L
- `12` — M
- `13` — N
- `14` — O
- `15` — P
- `16` — Q
- `17` — R
- `18` — S
- `19` — T
- `2` — C
- `20` — U
- `21` — V
- `22` — W
- `23` — X
- `24` — Y
- `25` — Z
- `26` — a
- `27` — b
- `28` — c
- `29` — d
- `3` — D
- `30` — e
- `31` — f
- `32` — g
- `33` — h
- `34` — I
- `35` — j
- `36` — k
- `37` — l
- `38` — m
- `39` — n
- `4` — E
- `40` — o
- `41` — p
- `42` — q
- `43` — r
- `44` — s
- `45` — t
- `46` — u
- `47` — v
- `48` — w
- `49` — x
- `5` — F
- `50` — y
- `51` — z
- `52` — 0
- `53` — 1
- `54` — 2
- `55` — 3
- `56` — 4
- `57` — 5
- `58` — 6
- `59` — 7
- `6` — G
- `60` — 8
- `61` — 9
- `62` — +
- `63` — /
- `7` — H
- `8` — I
- `9` — J

### Table 0291 — Subtype of Referenced Data
Code counts: CH02C: 15, Colleague: 15, UTG: 17

**Codes only in UTG (2):**

- `...` — Source RFC 2046
- `…` — Source RFC 2046

### Table 0294 — Time Selection Criteria Parameter Class Codes
Code counts: CH02C: 9, Colleague: 9, UTG: 18

**Codes only in UTG (9):**

- `FRI` — An indicator that Friday is or is not preferred for the day on which the appointment will occur.  OK =  Preferred appointment day NO = Day is not preferred
- `MON` — An indicator that Monday is or is not preferred for the day on which the appointment will occur.  OK = Preferred appointment day NO = Day is not preferred
- `PREFEND` — The preferred end time for the appointment request, service or resource.  Any legal time specification in the format HHMM, using 24-hour clock notation
- `PREFSTART` — The preferred start time for the appointment request, service or resource.   Any legal time specification in the format HHMM, using 24-hour clock notation
- `SAT` — An indicator that Saturday is or is not preferred for the day on which the appointment will occur.  OK =  Preferred appointment day NO = Day is not preferred
- `SUN` — An indicator that Sunday is or is not preferred for the day on which the appointment will occur.  OK = Preferred appointment day NO = Day is not preferred
- `THU` — An indicator that Thursday is or is not preferred for the day on which the appointment will occur.  OK = Preferred appointment day NO = Day is not preferred
- `TUE` — An indicator that Tuesday is or is not preferred for the day on which the appointment will occur.  OK = Preferred appointment day NO = Day is not preferred
- `WED` — An indicator that Wednesday is or is not preferred for the day on which the appointment will occur. OK = Preferred appointment day NO = Day is not preferred

### Table 0298 — CP Range Type
Code counts: CH02C: 2, Colleague: 2, UTG: 2

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `F` | Flat-rate. Apply the entire price to this interval, do not pro-rate the price if the full interval has not occurred/been consumed | Flat-rate | Flat-rate. Apply the entire price to this interval, do not pro-rate the price if the full interval has not occurred/been consumed |
| `P` | Pro-rate. Apply this price to this interval, pro-rated by whatever portion of the interval has occurred/been consumed | Pro-rate | Pro-rate. Apply this price to this interval, pro-rated by whatever portion of the interval has occurred/been consumed |

### Table 0299 — Encoding
Code counts: CH02C: 3, Colleague: 3, UTG: 3

**Display name truncations (3):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `A` | No encoding - data are displayable ASCII characters. | no encoding | No encoding - data are displayable ASCII characters. |
| `Base64` | Encoding as defined by MIME (Multipurpose Internet Mail Extensions) standard RFC 1521. Four consecutive ASCII characters represent three consecutive octets of binary data. Base64 utilizes a 65-character subset of US-ASCII, consisting of both the upper and | Encoding as defined by MIME (Multipurpose Internet Mail Extensions) standard RFC 1521. | Encoding as defined by MIME (Multipurpose Internet Mail Extensions) standard RFC 1521. Four consecutive ASCII characters represent three consecutive octets of binary data. Base64 utilizes a 65-character subset of US-ASCII, consisting of both the upper and |
| `Hex` | Hexadecimal encoding - consecutive pairs of hexadecimal digits represent consecutive single octets. | Hexadecimal encoding | Hexadecimal encoding - consecutive pairs of hexadecimal digits represent consecutive single octets. |

### Table 0301 — Universal ID Type
Code counts: CH02C: 19, Colleague: 18, UTG: 19

**Codes in CH02C but not in Colleague (1):**

- `L,M,N` — Local *(also in UTG)*

### Table 0317 — Annotations
Code counts: CH02C: 5, Colleague: 4, UTG: 5

**Codes in CH02C but not in Colleague (1):**

- `9904` — etc. *(also in UTG)*

### Table 0323 — actionCodes
Code counts: CH02C: 0, Colleague: 0, UTG: 4

**Codes only in UTG (4):**

- `A` — Add/Insert
- `D` — Delete
- `U` — Update
- `X` — No change

### Table 0325 — Location Relationship ID
Code counts: CH02C: 7, Colleague: 7, UTG: 7

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `RX` | Nearest  pharmacy | Nearest pharmacy | Nearest  pharmacy |

### Table 0335 — Repeat Pattern
Code counts: CH02C: 28, Colleague: 28, UTG: 28

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `Q<integer>J<day#>` | repeats on a particular day of the week, | repeats on a particular day of the week | repeats on a particular day of the week, |

### Table 0338 — Practitioner ID Number Type
Code counts: CH02C: 12, Colleague: 12, UTG: 0

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `DEA` | Drug Enforcement Agency no. | Drug Enforcement Agency no |  |
| `UPIN` | Unique physician ID no. | Unique physician ID no |  |

### Table 0340 — Procedure Code Modifier
Code counts: CH02C: 2, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (2):**

- `CPTM` — CPT Modifier Code *(not in UTG either)*
- `HPC` — CMS (formerly HCFA) Procedure Codes (HCPCS) *(not in UTG either)*

### Table 0354 — Message Structure
Code counts: CH02C: 261, Colleague: 261, UTG: 316

**Codes only in UTG (55):**

- `ADT_A28` — A28, A31
- `ARD_A19` — A19
- `BRP_030` — O30
- `DSR_P04` — P04
- `DSR_Q01` — Q01
- `DSR_Q03` — Q03
- `EDR_R07` — R07
- `EQQ_Q04` — Q04
- `ERP_R09` — R09
- `MFD_MFA` — MFA
- `MFD_P09` — P09
- `OMD_O01` — 
- `OMN_O01` — 
- `OMS_O01` — 
- `ORD_O02` — 
- `ORF_R02` — R02, R04
- `ORM_Q06` — Q06
- `ORN_O02` — 
- `ORR_Q06` — Q06
- `ORS_O02` — 
- `ORU_R31` — R31
- `ORU_R32` — R32
- `PIN_I07` — I07
- `QBP_Qnn` — Qnn
- `QBP_Z73` — Z73
- `QRY_P04` — P04
- `RAS_O01` — O01
- `RAS_O02` — O022
- `RDE_O01` — O01
- `RDO_O01` — 
- `RDS_O01` — O01
- `RDY_K11` — K11
- `RGV_O01` — O01
- `RPI_I0I` — I01, I04
- `RQC_I06` — I06
- `RQI_I0I` — I01, I02, I03
- `RQQ_Q09` — Q09
- `RRA_O02` — O02
- `RRD_O02` — O02
- `RRE_O02` — O02
- `RRG_O02` — O02
- `RRO_O02` — 
- `RSP_K24` — K24
- `RSP_Z82` — Z82
- `RSP_Z86` — Z86
- `RSP_Z88` — Z88
- `RSP_Z90` — Z90
- `RTB_Knn` — Knn
- `RTB_Z74` — Z74
- `SPQ_Q08` — Q08
- `SRM_T12` — T12
- `SRR_T12` — T12
- `TBR_R08` — R08
- `TBR_R09` — R09
- `VQQ_Q07` — Q07

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `ADT_A30` | A30 | A30 | A30, A34, A35, A36, A46, A47, A48, A49 |

### Table 0356 — Alternate Character Set Handling Scheme
Code counts: CH02C: 3, Colleague: 2, UTG: 3

**Codes in CH02C but not in Colleague (1):**

- `<null>` — This is the default, indicating that there is no character set switching occurring in this message. *(also in UTG)*

**Display name truncations (2):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `2.3` | The character set switching mode specified in HL7 2.5, section 2.7.2 and section 2.A.46, "XPN - extended person name". | The character set switching mode specified in HL7 2.5 | The character set switching mode specified in HL7 2.5, section 2.7.2 and section 2.A.46, "XPN - extended person name". |
| `ISO 2022-1994` | This standard is titled "Information Technology - Character Code Structure and Extension Technique". . | This standard is titled "Information Technology - Character Code Structure and Extension Technique". | This standard is titled "Information Technology - Character Code Structure and Extension Technique". . |

### Table 0359 — Diagnosis Priority
Code counts: CH02C: 5, Colleague: 5, UTG: 8

**Codes only in UTG (3):**

- `...` — No suggested values defined
- `2 ...` — For ranked secondary diagnoses
- `2 and higher` — for ranked secondary diagnoses

### Table 0365 — Equipment State
Code counts: CH02C: 18, Colleague: 18, UTG: 20

**Codes only in UTG (2):**

- `...` — (null) No state change
- `…` — (null) No state change

### Table 0366 — Local/Remote Control State
Code counts: CH02C: 2, Colleague: 2, UTG: 4

**Codes only in UTG (2):**

- `...` — (null) No state change
- `…` — (null) No state change

### Table 0367 — Alert Level
Code counts: CH02C: 4, Colleague: 4, UTG: 6

**Codes only in UTG (2):**

- `...` — (null) No level change
- `…` — (null) No level change

### Table 0368 — Remote Control Command
Code counts: CH02C: 21, Colleague: 21, UTG: 21

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `EX` | Execute (command specified in field Parameters (ST) 01394) | Execute | Execute (command specified in field Parameters (ST) 01394) |

### Table 0369 — Specimen Role
Code counts: CH02C: 12, Colleague: 12, UTG: 12

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `R` | Replicate (of patient sample as a control) | Replicate | Replicate (of patient sample as a control) |

### Table 0374 — System Induced Contaminants
Code counts: CH02C: 1, Colleague: 0, UTG: 1

**Codes in CH02C but not in Colleague (1):**

- `CNTM` — Present, type of contamination unspecified *(also in UTG)*

### Table 0377 — Other Environmental Factors
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `A60` — Opened container, indoor atmosphere, 60 minutes duration *(also in UTG)*
- `ATM` — Opened container, atmosphere and duration unspecified *(also in UTG)*

### Table 0391 — Segment Group
Code counts: CH02C: 132, Colleague: 257, UTG: 148

**Codes in Colleague but not in CH02C (125):**

- `ACCESSION_DETAIL` — ACCESSION_DETAIL *(not in UTG either)*
- `ADDITIONAL_DEMOGRAPHICS` — ADDITIONAL_DEMOGRAPHICS *(not in UTG either)*
- `ADJUSTMENT_PAYEE` — ADJUSTMENT_PAYEE *(not in UTG either)*
- `ADVERSE_REACTION_GROUP` — ADVERSE_REACTION_GROUP *(not in UTG either)*
- `ANTI-MICROBIAL_DEVICE_CYCLE_DA` — ANTI-MICROBIAL_DEVICE_CYCLE_DA *(not in UTG either)*
- `ANTI-MICROBIAL_DEVICE_DATA` — ANTI-MICROBIAL_DEVICE_DATA *(not in UTG either)*
- `APPOINTMENT_HISTORY` — APPOINTMENT_HISTORY *(not in UTG either)*
- `ASSOCIATED_OBSERVATION` — ASSOCIATED_OBSERVATION *(not in UTG either)*
- `AUTHORIZATION_CONTACT2` — AUTHORIZATION_CONTACT2 *(not in UTG either)*
- `AUTHORIZATION_INFO` — AUTHORIZATION_INFO *(not in UTG either)*
- `AUTHORIZATION_REQUEST` — AUTHORIZATION_REQUEST *(not in UTG either)*
- `AUTHORIZATION_RESPONSE_INFO` — AUTHORIZATION_RESPONSE_INFO *(not in UTG either)*
- `BLOOD_UNIT` — BLOOD_UNIT *(not in UTG either)*
- `CHOICE` — CHOICE *(not in UTG either)*
- `CLINICAL_HISTORY` — CLINICAL_HISTORY *(not in UTG either)*
- `CLINICAL_HISTORY_DETAIL` — CLINICAL_HISTORY_DETAIL *(not in UTG either)*
- `CLINICAL_HISTORY_OBJECT` — CLINICAL_HISTORY_OBJECT *(not in UTG either)*
- `CLINICAL_HISTORY_OBSERVATION` — CLINICAL_HISTORY_OBSERVATION *(not in UTG either)*
- `CLINICAL_ORDER` — CLINICAL_ORDER *(not in UTG either)*
- `CLINICAL_ORDER_DETAIL` — CLINICAL_ORDER_DETAIL *(not in UTG either)*
- `CLINICAL_ORDER_OBJECT` — CLINICAL_ORDER_OBJECT *(not in UTG either)*
- `CLINICAL_ORDER_OBSERVATION` — CLINICAL_ORDER_OBSERVATION *(not in UTG either)*
- `CLINICAL_ORDER_TIMING` — CLINICAL_ORDER_TIMING *(not in UTG either)*
- `CONTAINER_OBSERVATION` — CONTAINER_OBSERVATION *(not in UTG either)*
- `CONTRACT_RECORD` — CONTRACT_RECORD *(not in UTG either)*
- `DEVICE` — DEVICE *(not in UTG either)*
- `DIAGNOSIS` — DIAGNOSIS *(not in UTG either)*
- `DIAGNOSIS_FT1` — DIAGNOSIS_FT1 *(not in UTG either)*
- `DONATION` — DONATION *(not in UTG either)*
- `DONATION_OBSERVATION` — DONATION_OBSERVATION *(not in UTG either)*
- `DONATION_OBSERVATIONS` — DONATION_OBSERVATIONS *(not in UTG either)*
- `DONATION_ORDER` — DONATION_ORDER *(not in UTG either)*
- `DONOR` — DONOR *(not in UTG either)*
- `DONOR_OBSERVATIONS` — DONOR_OBSERVATIONS *(not in UTG either)*
- `DONOR_ORDER` — DONOR_ORDER *(not in UTG either)*
- `DONOR_REGISTRATION` — DONOR_REGISTRATION *(not in UTG either)*
- `FINANCIAL_OBSERVATION_2` — FINANCIAL_OBSERVATION_2 *(not in UTG either)*
- `FINANCIAL_OBSERVATION_STANDALO` — FINANCIAL_OBSERVATION_STANDALO *(not in UTG either)*
- `FINANCIAL_ORDER_STANDALONE` — FINANCIAL_ORDER_STANDALONE *(not in UTG either)*
- `GOAL_PARTICIPATION` — GOAL_PARTICIPATION *(not in UTG either)*
- `GUARANTOR` — GUARANTOR *(not in UTG either)*
- `INVOICE_INFORMATION_CANCEL` — INVOICE_INFORMATION_CANCEL *(not in UTG either)*
- `INVOICE_INFORMATION_SUBMIT` — INVOICE_INFORMATION_SUBMIT *(not in UTG either)*
- `INVOICE_PROCESSING_RESULTS_INF` — INVOICE_PROCESSING_RESULTS_INF *(not in UTG either)*
- `MATERIAL_ITEM_RECORD` — MATERIAL_ITEM_RECORD *(not in UTG either)*
- `MATERIAL_LOCATION` — MATERIAL_LOCATION *(not in UTG either)*
- `MEDICATION_ADMINISTRATION_DETA` — MEDICATION_ADMINISTRATION_DETA *(not in UTG either)*
- `MEDICATION_ADMINISTRATION_OBSE` — MEDICATION_ADMINISTRATION_OBSE *(not in UTG either)*
- `MEDICATION_ENCODING_DETAIL` — MEDICATION_ENCODING_DETAIL *(not in UTG either)*
- `MEDICATION_ENCODING_OBSERVATIO` — MEDICATION_ENCODING_OBSERVATIO *(not in UTG either)*
- `MEDICATION_HISTORY` — MEDICATION_HISTORY *(not in UTG either)*
- `MEDICATION_ORDER_DETAIL` — MEDICATION_ORDER_DETAIL *(not in UTG either)*
- `MEDICATION_ORDER_OBSERVATION` — MEDICATION_ORDER_OBSERVATION *(not in UTG either)*
- `MF_DRG` — MF_DRG *(not in UTG either)*
- `MF_OBS_OTHER_ATTRIBUTES` — MF_OBS_OTHER_ATTRIBUTES *(not in UTG either)*
- `MF_PAYER` — MF_PAYER *(not in UTG either)*
- `NEXT_OF_KIN` — NEXT_OF_KIN *(not in UTG either)*
- `OBSERVATIONS_ON_PATIENT` — OBSERVATIONS_ON_PATIENT *(not in UTG either)*
- `OBSERVATION_GROUP` — OBSERVATION_GROUP *(not in UTG either)*
- `OBSERVATION_PARTICIPATION` — OBSERVATION_PARTICIPATION *(not in UTG either)*
- `OBSERVATION_PARTICIPATION_PRIO` — OBSERVATION_PARTICIPATION_PRIO *(not in UTG either)*
- `OBSERVATION_RESULT_1` — OBSERVATION_RESULT_1 *(not in UTG either)*
- `OBSERVATION_RESULT_2` — OBSERVATION_RESULT_2 *(not in UTG either)*
- `OBSERVATION_RESULT_GROUP` — OBSERVATION_RESULT_GROUP *(not in UTG either)*
- `OCCUPATIONAL_DATA_FOR_HEALTH` — OCCUPATIONAL_DATA_FOR_HEALTH *(not in UTG either)*
- `ORDER_DETAIL_PARTICIPATION_PRI` — ORDER_DETAIL_PARTICIPATION_PRI *(not in UTG either)*
- `ORDER_DOCUMENT` — ORDER_DOCUMENT *(not in UTG either)*
- `ORDER_FOR_SPECIMEN_CONTAINER` — ORDER_FOR_SPECIMEN_CONTAINER *(not in UTG either)*
- `ORDER_RELATED_OBSERVATION` — ORDER_RELATED_OBSERVATION *(not in UTG either)*
- `ORDER_STATUS` — ORDER_STATUS *(not in UTG either)*
- `PACKAGE` — PACKAGE *(not in UTG either)*
- `PACKAGING` — PACKAGING *(not in UTG either)*
- `PARTICIPATION_CLINICAL_HISTORY` — PARTICIPATION_CLINICAL_HISTORY *(not in UTG either)*
- `PARTICIPATION_GOAL` — PARTICIPATION_GOAL *(not in UTG either)*
- `PARTICIPATION_GOAL_OBJECT` — PARTICIPATION_GOAL_OBJECT *(not in UTG either)*
- `PARTICIPATION_OBSERVATION` — PARTICIPATION_OBSERVATION *(not in UTG either)*
- `PARTICIPATION_PATHWAY` — PARTICIPATION_PATHWAY *(not in UTG either)*
- `PARTICIPATION_PATHWAY_OBJECT` — PARTICIPATION_PATHWAY_OBJECT *(not in UTG either)*
- `PARTICIPATION_PROBLEM` — PARTICIPATION_PROBLEM *(not in UTG either)*
- `PARTICIPATION_PROBLEM_OBJECT` — PARTICIPATION_PROBLEM_OBJECT *(not in UTG either)*
- `PATHWAY_OBSERVATION` — PATHWAY_OBSERVATION *(not in UTG either)*
- `PATHWAY_PARTICIPATION` — PATHWAY_PARTICIPATION *(not in UTG either)*
- `PATIENT_INFO` — PATIENT_INFO *(not in UTG either)*
- `PATIENT_OBSERVATION` — PATIENT_OBSERVATION *(not in UTG either)*
- `PATIENT_VISITS` — PATIENT_VISITS *(not in UTG either)*
- `PATIENT_VISIT_OBSERVATION` — PATIENT_VISIT_OBSERVATION *(not in UTG either)*
- `PAT_INFO` — PAT_INFO *(not in UTG either)*
- `PAYER_MF_COVERAGE` — PAYER_MF_COVERAGE *(not in UTG either)*
- `PAYER_MF_ENTRY` — PAYER_MF_ENTRY *(not in UTG either)*
- `PAYMENT_REMITTANCE_DETAIL_INFO` — PAYMENT_REMITTANCE_DETAIL_INFO *(not in UTG either)*
- `PAYMENT_REMITTANCE_HEADER_INFO` — PAYMENT_REMITTANCE_HEADER_INFO *(not in UTG either)*
- `PERSON_OBSERVATION` — PERSON_OBSERVATION *(not in UTG either)*
- `PHARMACY_TREATMENT_INFUSION_OR` — PHARMACY_TREATMENT_INFUSION_OR *(not in UTG either)*
- `PROBLEM_PARTICIPATION` — PROBLEM_PARTICIPATION *(not in UTG either)*
- `PRODUCT_SERVICE_GROUP` — PRODUCT_SERVICE_GROUP *(not in UTG either)*
- `PRODUCT_SERVICE_LINE_INFO` — PRODUCT_SERVICE_LINE_INFO *(not in UTG either)*
- `PRODUCT_SERVICE_LINE_ITEM` — PRODUCT_SERVICE_LINE_ITEM *(not in UTG either)*
- `PRODUCT_SERVICE_SECTION` — PRODUCT_SERVICE_SECTION *(not in UTG either)*
- `PSG` — PSG *(not in UTG either)*
- `PSL_ITEM_INFO` — PSL_ITEM_INFO *(not in UTG either)*
- `PURCHASING_VENDOR` — PURCHASING_VENDOR *(not in UTG either)*
- `QUERY` — QUERY *(not in UTG either)*
- `QUERY_ACK` — QUERY_ACK *(not in UTG either)*
- `QUERY_ACK_IPR` — QUERY_ACK_IPR *(not in UTG either)*
- `QUERY_INFORMATION` — QUERY_INFORMATION *(not in UTG either)*
- `REASSESSMENT_REQUEST_INFO` — REASSESSMENT_REQUEST_INFO *(not in UTG either)*
- `REFERRAL` — REFERRAL *(not in UTG either)*
- `RESOURCE_DETAIL` — RESOURCE_DETAIL *(not in UTG either)*
- `RESOURCE_OBJECT` — RESOURCE_OBJECT *(not in UTG either)*
- `RESOURCE_OBSERVATION` — RESOURCE_OBSERVATION *(not in UTG either)*
- `RX_ADMIN` — RX_ADMIN *(not in UTG either)*
- `SEGMENT_PATTERN` — SEGMENT_PATTERN *(not in UTG either)*
- `SHIPMENT` — SHIPMENT *(not in UTG either)*
- `SHIPMENT_OBSERVATION` — SHIPMENT_OBSERVATION *(not in UTG either)*
- `SHIPPING_OBSERVATION` — SHIPPING_OBSERVATION *(not in UTG either)*
- `SPECIMEN_CONTAINER_IN_PACKAGE` — SPECIMEN_CONTAINER_IN_PACKAGE *(not in UTG either)*
- `SPECIMEN_IN_PACKAGE` — SPECIMEN_IN_PACKAGE *(not in UTG either)*
- `SPECIMEN_OBSERVATION` — SPECIMEN_OBSERVATION *(not in UTG either)*
- `SPECIMEN_SHIPMENT` — SPECIMEN_SHIPMENT *(not in UTG either)*
- `STERILIZATION` — STERILIZATION *(not in UTG either)*
- `STUDY_OBSERVATION_ORDER` — STUDY_OBSERVATION_ORDER *(not in UTG either)*
- `STUDY_PHARM` — STUDY_PHARM *(not in UTG either)*
- `SUBJECT_PERSON_OR_ANIMAL_IDENT` — SUBJECT_PERSON_OR_ANIMAL_IDENT *(not in UTG either)*
- `SUBJECT_POPULATION_OR_LOCATION` — SUBJECT_POPULATION_OR_LOCATION *(not in UTG either)*
- `VISIT_GROUP` — VISIT_GROUP *(not in UTG either)*

**Codes only in UTG (16):**

- `CLOCK_AND_STATS_WITH_NOTE` — 
- `ENCODED ORDER` — 
- `FINANCIAL_COMMON ORDER` — 
- `FINANCIAL_TIMING QUANTITY` — 
- `GENERAL RESOURCE` — 
- `LOCATION RESOURCE` — 
- `OBRG` — OBR group
- `ORCG` — ORC group
- `PATIENT VISIT` — 
- `PERSONNEL RESOURCE` — 
- `PIDG` — PID group
- `RXAG` — RXA group
- `RXDG` — RXD group
- `RXEG` — RXE group
- `RXOG` — RXO group
- `etc` — 

**Codes in CH02C/Colleague but missing from UTG (125):**

- `ACCESSION_DETAIL` — ACCESSION_DETAIL
- `ADDITIONAL_DEMOGRAPHICS` — ADDITIONAL_DEMOGRAPHICS
- `ADJUSTMENT_PAYEE` — ADJUSTMENT_PAYEE
- `ADVERSE_REACTION_GROUP` — ADVERSE_REACTION_GROUP
- `ANTI-MICROBIAL_DEVICE_CYCLE_DA` — ANTI-MICROBIAL_DEVICE_CYCLE_DA
- `ANTI-MICROBIAL_DEVICE_DATA` — ANTI-MICROBIAL_DEVICE_DATA
- `APPOINTMENT_HISTORY` — APPOINTMENT_HISTORY
- `ASSOCIATED_OBSERVATION` — ASSOCIATED_OBSERVATION
- `AUTHORIZATION_CONTACT2` — AUTHORIZATION_CONTACT2
- `AUTHORIZATION_INFO` — AUTHORIZATION_INFO
- `AUTHORIZATION_REQUEST` — AUTHORIZATION_REQUEST
- `AUTHORIZATION_RESPONSE_INFO` — AUTHORIZATION_RESPONSE_INFO
- `BLOOD_UNIT` — BLOOD_UNIT
- `CHOICE` — CHOICE
- `CLINICAL_HISTORY` — CLINICAL_HISTORY
- `CLINICAL_HISTORY_DETAIL` — CLINICAL_HISTORY_DETAIL
- `CLINICAL_HISTORY_OBJECT` — CLINICAL_HISTORY_OBJECT
- `CLINICAL_HISTORY_OBSERVATION` — CLINICAL_HISTORY_OBSERVATION
- `CLINICAL_ORDER` — CLINICAL_ORDER
- `CLINICAL_ORDER_DETAIL` — CLINICAL_ORDER_DETAIL
- `CLINICAL_ORDER_OBJECT` — CLINICAL_ORDER_OBJECT
- `CLINICAL_ORDER_OBSERVATION` — CLINICAL_ORDER_OBSERVATION
- `CLINICAL_ORDER_TIMING` — CLINICAL_ORDER_TIMING
- `CONTAINER_OBSERVATION` — CONTAINER_OBSERVATION
- `CONTRACT_RECORD` — CONTRACT_RECORD
- `DEVICE` — DEVICE
- `DIAGNOSIS` — DIAGNOSIS
- `DIAGNOSIS_FT1` — DIAGNOSIS_FT1
- `DONATION` — DONATION
- `DONATION_OBSERVATION` — DONATION_OBSERVATION
- `DONATION_OBSERVATIONS` — DONATION_OBSERVATIONS
- `DONATION_ORDER` — DONATION_ORDER
- `DONOR` — DONOR
- `DONOR_OBSERVATIONS` — DONOR_OBSERVATIONS
- `DONOR_ORDER` — DONOR_ORDER
- `DONOR_REGISTRATION` — DONOR_REGISTRATION
- `FINANCIAL_OBSERVATION_2` — FINANCIAL_OBSERVATION_2
- `FINANCIAL_OBSERVATION_STANDALO` — FINANCIAL_OBSERVATION_STANDALO
- `FINANCIAL_ORDER_STANDALONE` — FINANCIAL_ORDER_STANDALONE
- `GOAL_PARTICIPATION` — GOAL_PARTICIPATION
- `GUARANTOR` — GUARANTOR
- `INVOICE_INFORMATION_CANCEL` — INVOICE_INFORMATION_CANCEL
- `INVOICE_INFORMATION_SUBMIT` — INVOICE_INFORMATION_SUBMIT
- `INVOICE_PROCESSING_RESULTS_INF` — INVOICE_PROCESSING_RESULTS_INF
- `MATERIAL_ITEM_RECORD` — MATERIAL_ITEM_RECORD
- `MATERIAL_LOCATION` — MATERIAL_LOCATION
- `MEDICATION_ADMINISTRATION_DETA` — MEDICATION_ADMINISTRATION_DETA
- `MEDICATION_ADMINISTRATION_OBSE` — MEDICATION_ADMINISTRATION_OBSE
- `MEDICATION_ENCODING_DETAIL` — MEDICATION_ENCODING_DETAIL
- `MEDICATION_ENCODING_OBSERVATIO` — MEDICATION_ENCODING_OBSERVATIO
- `MEDICATION_HISTORY` — MEDICATION_HISTORY
- `MEDICATION_ORDER_DETAIL` — MEDICATION_ORDER_DETAIL
- `MEDICATION_ORDER_OBSERVATION` — MEDICATION_ORDER_OBSERVATION
- `MF_DRG` — MF_DRG
- `MF_OBS_OTHER_ATTRIBUTES` — MF_OBS_OTHER_ATTRIBUTES
- `MF_PAYER` — MF_PAYER
- `NEXT_OF_KIN` — NEXT_OF_KIN
- `OBSERVATIONS_ON_PATIENT` — OBSERVATIONS_ON_PATIENT
- `OBSERVATION_GROUP` — OBSERVATION_GROUP
- `OBSERVATION_PARTICIPATION` — OBSERVATION_PARTICIPATION
- `OBSERVATION_PARTICIPATION_PRIO` — OBSERVATION_PARTICIPATION_PRIO
- `OBSERVATION_RESULT_1` — OBSERVATION_RESULT_1
- `OBSERVATION_RESULT_2` — OBSERVATION_RESULT_2
- `OBSERVATION_RESULT_GROUP` — OBSERVATION_RESULT_GROUP
- `OCCUPATIONAL_DATA_FOR_HEALTH` — OCCUPATIONAL_DATA_FOR_HEALTH
- `ORDER_DETAIL_PARTICIPATION_PRI` — ORDER_DETAIL_PARTICIPATION_PRI
- `ORDER_DOCUMENT` — ORDER_DOCUMENT
- `ORDER_FOR_SPECIMEN_CONTAINER` — ORDER_FOR_SPECIMEN_CONTAINER
- `ORDER_RELATED_OBSERVATION` — ORDER_RELATED_OBSERVATION
- `ORDER_STATUS` — ORDER_STATUS
- `PACKAGE` — PACKAGE
- `PACKAGING` — PACKAGING
- `PARTICIPATION_CLINICAL_HISTORY` — PARTICIPATION_CLINICAL_HISTORY
- `PARTICIPATION_GOAL` — PARTICIPATION_GOAL
- `PARTICIPATION_GOAL_OBJECT` — PARTICIPATION_GOAL_OBJECT
- `PARTICIPATION_OBSERVATION` — PARTICIPATION_OBSERVATION
- `PARTICIPATION_PATHWAY` — PARTICIPATION_PATHWAY
- `PARTICIPATION_PATHWAY_OBJECT` — PARTICIPATION_PATHWAY_OBJECT
- `PARTICIPATION_PROBLEM` — PARTICIPATION_PROBLEM
- `PARTICIPATION_PROBLEM_OBJECT` — PARTICIPATION_PROBLEM_OBJECT
- `PATHWAY_OBSERVATION` — PATHWAY_OBSERVATION
- `PATHWAY_PARTICIPATION` — PATHWAY_PARTICIPATION
- `PATIENT_INFO` — PATIENT_INFO
- `PATIENT_OBSERVATION` — PATIENT_OBSERVATION
- `PATIENT_VISITS` — PATIENT_VISITS
- `PATIENT_VISIT_OBSERVATION` — PATIENT_VISIT_OBSERVATION
- `PAT_INFO` — PAT_INFO
- `PAYER_MF_COVERAGE` — PAYER_MF_COVERAGE
- `PAYER_MF_ENTRY` — PAYER_MF_ENTRY
- `PAYMENT_REMITTANCE_DETAIL_INFO` — PAYMENT_REMITTANCE_DETAIL_INFO
- `PAYMENT_REMITTANCE_HEADER_INFO` — PAYMENT_REMITTANCE_HEADER_INFO
- `PERSON_OBSERVATION` — PERSON_OBSERVATION
- `PHARMACY_TREATMENT_INFUSION_OR` — PHARMACY_TREATMENT_INFUSION_OR
- `PROBLEM_PARTICIPATION` — PROBLEM_PARTICIPATION
- `PRODUCT_SERVICE_GROUP` — PRODUCT_SERVICE_GROUP
- `PRODUCT_SERVICE_LINE_INFO` — PRODUCT_SERVICE_LINE_INFO
- `PRODUCT_SERVICE_LINE_ITEM` — PRODUCT_SERVICE_LINE_ITEM
- `PRODUCT_SERVICE_SECTION` — PRODUCT_SERVICE_SECTION
- `PSG` — PSG
- `PSL_ITEM_INFO` — PSL_ITEM_INFO
- `PURCHASING_VENDOR` — PURCHASING_VENDOR
- `QUERY` — QUERY
- `QUERY_ACK` — QUERY_ACK
- `QUERY_ACK_IPR` — QUERY_ACK_IPR
- `QUERY_INFORMATION` — QUERY_INFORMATION
- `REASSESSMENT_REQUEST_INFO` — REASSESSMENT_REQUEST_INFO
- `REFERRAL` — REFERRAL
- `RESOURCE_DETAIL` — RESOURCE_DETAIL
- `RESOURCE_OBJECT` — RESOURCE_OBJECT
- `RESOURCE_OBSERVATION` — RESOURCE_OBSERVATION
- `RX_ADMIN` — RX_ADMIN
- `SEGMENT_PATTERN` — SEGMENT_PATTERN
- `SHIPMENT` — SHIPMENT
- `SHIPMENT_OBSERVATION` — SHIPMENT_OBSERVATION
- `SHIPPING_OBSERVATION` — SHIPPING_OBSERVATION
- `SPECIMEN_CONTAINER_IN_PACKAGE` — SPECIMEN_CONTAINER_IN_PACKAGE
- `SPECIMEN_IN_PACKAGE` — SPECIMEN_IN_PACKAGE
- `SPECIMEN_OBSERVATION` — SPECIMEN_OBSERVATION
- `SPECIMEN_SHIPMENT` — SPECIMEN_SHIPMENT
- `STERILIZATION` — STERILIZATION
- `STUDY_OBSERVATION_ORDER` — STUDY_OBSERVATION_ORDER
- `STUDY_PHARM` — STUDY_PHARM
- `SUBJECT_PERSON_OR_ANIMAL_IDENT` — SUBJECT_PERSON_OR_ANIMAL_IDENT
- `SUBJECT_POPULATION_OR_LOCATION` — SUBJECT_POPULATION_OR_LOCATION
- `VISIT_GROUP` — VISIT_GROUP

### Table 0393 — Match Algorithms
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `LINKSOFT_2.01` — Proprietary algorithm for LinkSoft v2.01 *(also in UTG)*
- `MATCHWARE_1.2` — Proprietary algorithm for MatchWare v1.2 *(also in UTG)*

### Table 0396 — Coding System
Code counts: CH02C: 276, Colleague: 302, UTG: 254

**Codes in CH02C but not in Colleague (1):**

- `ISO+` — ISO 2955.83 (units of measure) with HL7 extensions *(also in UTG)*

**Codes in Colleague but not in CH02C (27):**

- `ALPHAID2024` — German Alpha-ID v2024 *(not in UTG either)*
- `ALPHAID2025` — German Alpha-ID v2025 *(not in UTG either)*
- `CMSHCC` — CMS Hierarchical Condition Categories *(also in UTG)*
- `DCL` — DICOM Class Label *(also in UTG)*
- `DQL` — DICOM Query Label *(also in UTG)*
- `FDAUDI` — FDA Unique Device Identifier *(also in UTG)*
- `GDRG2010` — G-DRG German DRG Codes v2010 *(not in UTG either)*
- `GDRG2011` — G-DRG German DRG Codes v2011 *(not in UTG either)*
- `GDRG2012` — G-DRG German DRG Codes v2012 *(not in UTG either)*
- `GDRG2013` — G-DRG German DRG Codes v2013 *(not in UTG either)*
- `GDRG2014` — G-DRG German DRG Codes v2014 *(not in UTG either)*
- `GDRG2015` — G-DRG German DRG Codes v2015 *(not in UTG either)*
- `GDRG2016` — G-DRG German DRG Codes v2016 *(not in UTG either)*
- `GDRG2017` — G-DRG German DRG Codes v2017 *(not in UTG either)*
- `GDRG2018` — G-DRG German DRG Codes v2018 *(not in UTG either)*
- `GDRG2019` — G-DRG German DRG Codes v2019 *(not in UTG either)*
- `GMDC2024` — German Major Diagnostic Codes v2024 *(not in UTG either)*
- `GMDC2025` — German Major Diagnostic Codes v2025 *(not in UTG either)*
- `GS1UDI` — GS1 Unique Device Identifier *(also in UTG)*
- `HIBUDI` — HIBCC Unique Device Identifier *(also in UTG)*
- `IBTnnnn` — ISBT 128 codes where nnnn  specifies a specific table within ISBT 128. *(also in UTG)*
- `ICCUDI` — ICCBBA Unique Device Identifier *(also in UTG)*
- `ICD10GM2024` — ICD 10 Germany v2024 *(not in UTG either)*
- `ICD10GM2025` — ICD 10 Germany v2025 *(not in UTG either)*
- `NCIT` — NCI Thesaurus *(also in UTG)*
- `OPS2024` — OPS Germany v2024 *(not in UTG either)*
- `OPS2025` — OPS Germany v2025 *(not in UTG either)*

**Codes only in UTG (5):**

- `99zzz or L` — Local general code (where z is an alphanumeric character)
- `CE (obsolete)` — CEN ECG diagnostic codes
- `General code` — Active
- `ISOnnnn (deprecated)` — ISO Defined Codes where nnnn is the ISO table number
- `X12Dennnn` — ASC X12 Code List nnnn

**Codes in CH02C/Colleague but missing from UTG (54):**

- `ALPHAID2017` — German Alpha-ID v2017
- `ALPHAID2018` — German Alpha-ID v2018
- `ALPHAID2019` — German Alpha-ID v2019
- `ALPHAID2020` — German Alpha-ID v2020
- `ALPHAID2021` — German Alpha-ID v2021
- `ALPHAID2022` — German Alpha-ID v2022
- `ALPHAID2023` — German Alpha-ID v2023
- `ALPHAID2024` — German Alpha-ID v2024
- `ALPHAID2025` — German Alpha-ID v2025
- `GDRG2010` — G-DRG German DRG Codes v2010
- `GDRG2011` — G-DRG German DRG Codes v2011
- `GDRG2012` — G-DRG German DRG Codes v2012
- `GDRG2013` — G-DRG German DRG Codes v2013
- `GDRG2014` — G-DRG German DRG Codes v2014
- `GDRG2015` — G-DRG German DRG Codes v2015
- `GDRG2016` — G-DRG German DRG Codes v2016
- `GDRG2017` — G-DRG German DRG Codes v2017
- `GDRG2018` — G-DRG German DRG Codes v2018
- `GDRG2019` — G-DRG German DRG Codes v2019
- `GLN` — Global Location Number
- `GMDC2010` — German Major Diagnostic Codes v2010
- `GMDC2011` — German Major Diagnostic Codes v2011
- `GMDC2012` — German Major Diagnostic Codes v2012
- `GMDC2013` — German Major Diagnostic Codes v2013
- `GMDC2014` — German Major Diagnostic Codes v2014
- `GMDC2015` — German Major Diagnostic Codes v2015
- `GMDC2016` — German Major Diagnostic Codes v2016
- `GMDC2017` — German Major Diagnostic Codes v2017
- `GMDC2018` — German Major Diagnostic Codes v2018
- `GMDC2019` — German Major Diagnostic Codes v2019
- `GMDC2020` — German Major Diagnostic Codes v2020
- `GMDC2021` — German Major Diagnostic Codes v2021
- `GMDC2022` — German Major Diagnostic Codes v2022
- `GMDC2023` — German Major Diagnostic Codes v2023
- `GMDC2024` — German Major Diagnostic Codes v2024
- `GMDC2025` — German Major Diagnostic Codes v2025
- `ICD10GM2017` — ICD 10 Germany v2017
- `ICD10GM2018` — ICD 10 Germany v2018
- `ICD10GM2019` — ICD 10 Germany v2019
- `ICD10GM2020` — ICD 10 Germany v2020
- `ICD10GM2021` — ICD 10 Germany v2021
- `ICD10GM2022` — ICD 10 Germany v2022
- `ICD10GM2023` — ICD 10 Germany v2023
- `ICD10GM2024` — ICD 10 Germany v2024
- `ICD10GM2025` — ICD 10 Germany v2025
- `OPS2017` — OPS Germany v2017
- `OPS2018` — OPS Germany v2018
- `OPS2019` — OPS Germany v2019
- `OPS2020` — OPS Germany v2020
- `OPS2021` — OPS Germany v2021
- `OPS2022` — OPS Germany v2022
- `OPS2023` — OPS Germany v2023
- `OPS2024` — OPS Germany v2024
- `OPS2025` — OPS Germany v2025

**Display name truncations (3):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `ACTRELSS` | Used to indicate that the target of the relationship will be a filtered subset of the total related set of targets.
Used when there is a need to limit the number of components to the first, the last, the next, the total, the average or some other filtere | Used to indicate that the target of the relationship will be a filtered subset of the total related set of targets.
Used when there is a need to limit the number of components to the first, the last, the next, the total, the average or some other filtere | Used to indicate that the target of the relationship will be a filtered subset of the total related set of targets.
Used when there is a need to limit the number of components to the first, the last, the next, the total, the average or some other filtere |
| `ALPHAID2012` | German Alpha-ID v2012 | German Alpha-ID v2012 | German Alpha-ID v2013 |
| `OPS2009` | OPS Germany v2009 | OPS Germany v2009 | OPS Germany v2008 |

**Status mismatches (32):**

- `99zzz`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `ALPHAID2010`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `ALPHAID2011`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `ALPHAID2012`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ALPHAID2013`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ALPHAID2014`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ALPHAID2015`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ALPHAID2016`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `CMSHCC`: CH02C=``, Colleague=`new`, UTG=`active`
- `DAR`: CH02C=``, Colleague=`new`, UTG=`active`
- `DCL`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `DQL`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `FDAUDI`: CH02C=``, Colleague=`inactive`, UTG=`active`
- `GMDC2009`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `ICD10GM2010`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `ICD10GM2011`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `ICD10GM2012`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ICD10GM2013`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ICD10GM2014`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ICD10GM2015`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `ICD10GM2016`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `NCIT`: CH02C=``, Colleague=`new`, UTG=`active`
- `NCPDPnnnnsss`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `OPS2010`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `OPS2011`: CH02C=`N`, Colleague=`new`, UTG=`active`
- `OPS2012`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `OPS2013`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `OPS2014`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `OPS2015`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `OPS2016`: CH02C=`N`, Colleague=`new`, UTG=`deprecated`
- `SPCU`: CH02C=``, Colleague=`new`, UTG=`active`
- `X12DEnnnn`: CH02C=`D`, Colleague=`inactive`, UTG=`active`

### Table 0401 — Government Reimbursement Program
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `C` — Medi-Cal *(also in UTG)*
- `MM` — Medicare *(also in UTG)*

### Table 0402 — School Type
Code counts: CH02C: 4, Colleague: 0, UTG: 4

**Codes in CH02C but not in Colleague (4):**

- `D` — Dental *(also in UTG)*
- `G` — Graduate *(also in UTG)*
- `M` — Medical *(also in UTG)*
- `U` — Undergraduate *(also in UTG)*

### Table 0406 — Participant Organization Unit Type
Code counts: CH02C: 7, Colleague: 0, UTG: 7

**Codes in CH02C but not in Colleague (7):**

- `1` — Hospital *(also in UTG)*
- `2` — Physician Clinic *(also in UTG)*
- `3` — Long Term Care *(also in UTG)*
- `4` — Acute Care *(also in UTG)*
- `5` — Other *(also in UTG)*
- `H` — Home *(also in UTG)*
- `O` — Office *(also in UTG)*

### Table 0409 — Application Change Type
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `M` — Migrates to different CPU *(also in UTG)*
- `SD` — Shut down *(also in UTG)*
- `SU` — Start up *(also in UTG)*

### Table 0418 — Procedure Priority
Code counts: CH02C: 4, Colleague: 3, UTG: 5

**Codes in CH02C but not in Colleague (1):**

- `...` — No suggested values defined *(also in UTG)*

**Codes only in UTG (1):**

- `…` — 

### Table 0423 — Case Category Code
Code counts: CH02C: 1, Colleague: 0, UTG: 1

**Codes in CH02C but not in Colleague (1):**

- `D` — Doctor's Office Closed *(also in UTG)*

### Table 0435 — Advance Directive Code
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `DNR` — Do not resuscitate *(also in UTG)*
- `N` — No directive *(also in UTG)*

### Table 0440 — Data Types
Code counts: CH02C: 95, Colleague: 95, UTG: 96

**Codes only in UTG (1):**

- `CNS` — Composite ID number and name simplified

**Status mismatches (15):**

- `AD`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `CE`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `CK`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `CM`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `CN`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `CSU`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `ELD`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `LA1`: CH02C=`D`, Colleague=`inactive`, UTG=`B`
- `LA2`: CH02C=`D`, Colleague=`inactive`, UTG=`B`
- `OSD`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `PN`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `SPS`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `TN`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `TQ`: CH02C=`D`, Colleague=`inactive`, UTG=`active`
- `TS`: CH02C=`D`, Colleague=`inactive`, UTG=`active`

### Table 0451 — Substance Identifier
Code counts: CH02C: 1, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (1):**

- `ALL` — Used for query of all inventory items *(not in UTG either)*

### Table 0466 — Ambulatory Payment Classification Code
Code counts: CH02C: 4, Colleague: 3, UTG: 4

**Codes in CH02C but not in Colleague (1):**

- `...` — No suggested values defined *(also in UTG)*

### Table 0473 — Formulary Status
Code counts: CH02C: 4, Colleague: 0, UTG: 4

**Codes in CH02C but not in Colleague (4):**

- `G` — This observation/service is on the formulary, and has guidelines *(also in UTG)*
- `N` — This observation/service is not on the formulary *(also in UTG)*
- `R` — This observation/service is on the formulary, but is restricted *(also in UTG)*
- `Y` — This observation/service is on the formulary *(also in UTG)*

### Table 0474 — Practitioner Organization Unit Type
Code counts: CH02C: 5, Colleague: 5, UTG: 7

**Codes only in UTG (2):**

- `L` — Local market area
- `M` — Medical Center Area

### Table 0487 — Specimen Type
Code counts: CH02C: 313, Colleague: 313, UTG: 315

**Codes only in UTG (2):**

- `...` — No suggested values
- `BONE` — Bone

### Table 0492 — Specimen Appropriateness
Code counts: CH02C: 3, Colleague: 3, UTG: 4

**Codes only in UTG (1):**

- `??` — Inappropriate due to ...

### Table 0524 — sequenceCondition
Code counts: CH02C: 0, Colleague: 0, UTG: 3

**Codes only in UTG (3):**

- `C` — Repeating cycle of orders
- `R` — Reserved for possible future use
- `S` — Sequence conditions

### Table 0529 — precision
Code counts: CH02C: 0, Colleague: 0, UTG: 6

**Codes only in UTG (6):**

- `D` — day
- `H` — hour
- `L` — month
- `M` — minute
- `S` — second
- `Y` — year

### Table 0530 — Organization, Agency, Department
Code counts: CH02C: 6, Colleague: 0, UTG: 6

**Codes in CH02C but not in Colleague (6):**

- `AE` — American Express *(also in UTG)*
- `DEA` — Drug Enforcement Agency *(also in UTG)*
- `DOD` — Department of Defense *(also in UTG)*
- `MC` — Master Card *(also in UTG)*
- `VA` — Veterans Affairs *(also in UTG)*
- `VI` — Visa *(also in UTG)*

### Table 0535 — Signature Code
Code counts: CH02C: 4, Colleague: 4, UTG: 4

**Display name truncations (1):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `C` | Signed CMS-1500 claim form on file, e.g., authorization for release of any medical or other information necessary to process this claim and assignment of benefits. | Signed CMS-1500 claim form on file | Signed CMS-1500 claim form on file, e.g., authorization for release of any medical or other information necessary to process this claim and assignment of benefits. |

### Table 0544 — Container Condition
Code counts: CH02C: 21, Colleague: 21, UTG: 22

**Codes only in UTG (1):**

- `...` — No suggested values

### Table 0556 — Benefit Group
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `AMB` — AMBULATORY CARE *(also in UTG)*
- `DENT` — DENTAL *(also in UTG)*

### Table 0560 — Quantity Units
Code counts: CH02C: 5, Colleague: 0, UTG: 5

**Codes in CH02C but not in Colleague (5):**

- `DY` — Days *(also in UTG)*
- `FL` — Units *(also in UTG)*
- `HS` — Hours *(also in UTG)*
- `MN` — Month *(also in UTG)*
- `YY` — Years *(also in UTG)*

### Table 0567 — Weight Units
Code counts: CH02C: 4, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (4):**

- `[lb_av]` — Pound *(not in UTG either)*
- `[oz_av]` — Ounce *(not in UTG either)*
- `g` — Gram *(not in UTG either)*
- `kg` — Kilogram *(not in UTG either)*

### Table 0568 — Volume Units
Code counts: CH02C: 3, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (3):**

- `[pt_us]` — Pint *(not in UTG either)*
- `l` — Liter *(not in UTG either)*
- `ml` — Milliliters *(not in UTG either)*

### Table 0625 — Item Status Codes
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `1` — Active *(also in UTG)*
- `2` — Pending Inactive *(also in UTG)*
- `3` — Inactive *(also in UTG)*

### Table 0634 — Item Importance Codes
Code counts: CH02C: 1, Colleague: 0, UTG: 1

**Codes in CH02C but not in Colleague (1):**

- `CRT` — Critical *(also in UTG)*

### Table 0657 — Device Type
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `1` — EO Gas Sterilizer *(also in UTG)*
- `2` — Steam Sterilizer *(also in UTG)*
- `3` — Peracetic Acid *(also in UTG)*

### Table 0790 — Approving Regulatory Agency
Code counts: CH02C: 2, Colleague: 0, UTG: 2

**Codes in CH02C but not in Colleague (2):**

- `AMA` — American Medical Association *(also in UTG)*
- `FDA` — Food and Drug Administration *(also in UTG)*

### Table 0793 — Ruling Act
Code counts: CH02C: 1, Colleague: 0, UTG: 1

**Codes in CH02C but not in Colleague (1):**

- `SMDA` — Safe Medical Devices Act *(also in UTG)*

### Table 0909 — Patient Results Release Categorization Scheme
Code counts: CH02C: 6, Colleague: 6, UTG: 6

**Display name truncations (6):** Colleague uses shorter form (parenthetical/detail stripped)

| Code | CH02C | Colleague | UTG |
|------|-------|-----------|-----|
| `SID` | Share In1 Day -
Share result regardless of reference/therapeutic range after 1 or more business day as agreed to by the systems in play. | Share In1 Day -<p>Share result regardless of reference/therapeutic range after 1 or more business day as agreed to by the systems in play. | Share In1 Day -<p>Share result regardless of reference/therapeutic range after 1 or more business day as agreed to by the systems in play. |
| `SIDC` | Share in 1 Day Conditionally -
Share result in reference ranges/therapeutic with patient after 1 or more business day as agreed to by the systems in play.
Withhold result out of reference/therapeutic range until physician release | Share in 1 Day Conditionally -<p>Share result in reference ranges/therapeutic with patient after 1 or more business day as agreed to by the systems in play.<p>Withhold result out of reference/therapeutic range until physician release | Share in 1 Day Conditionally -<p>Share result in reference ranges/therapeutic with patient after 1 or more business day as agreed to by the systems in play.<p>Withhold result out of reference/therapeutic range until physician release |
| `SIMM` | Share Immediately -
Share result with patient immediately | Share Immediately -<p>Share result with patient immediately | Share Immediately -<p>Share result with patient immediately |
| `STBD` | Share To Be Determined -
Category to be determined | Share To Be Determined -<p>Category to be determined | Share To Be Determined -<p>Category to be determined |
| `SWNL` | Share Within Normal Limits -
Share result in reference/therapeutic range with patient immediately
Share result out of reference/therapeutic ranges with patient after 1 or more business day as agreed to by the systems in play. | Share Within Normal Limits -<p>Share result in reference/therapeutic range with patient immediately<p>Share result out of reference/therapeutic ranges with patient after 1 or more business day as agreed to by the systems in play. | Share Within Normal Limits -<p>Share result in reference/therapeutic range with patient immediately<p>Share result out of reference/therapeutic ranges with patient after 1 or more business day as agreed to by the systems in play. |
| `SWTH` | Share Withhold -
Withhold result regardless of reference/therapeutic ranges | Share Withhold -<p>Withhold result regardless of reference/therapeutic ranges | Share Withhold -<p>Withhold result regardless of reference/therapeutic ranges |

### Table 0923 — Process Interruption
Code counts: CH02C: 3, Colleague: 0, UTG: 3

**Codes in CH02C but not in Colleague (3):**

- `ABR` — Aborted Run: Process interrupted after the Phlebotomist inserts the needle in the Donor's arm *(also in UTG)*
- `NIN` — Process was not interrupted *(also in UTG)*
- `WOT` — Walk Out: Process interrupted before the Phlebotomist inserts the needle in the Donor's arm *(also in UTG)*

### Table 0929 — Weight Units
Code counts: CH02C: 4, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (4):**

- `[lb_av]` — Pound *(not in UTG either)*
- `[oz_av]` — Ounce *(not in UTG either)*
- `g` — Gram *(not in UTG either)*
- `kg` — Kilogram *(not in UTG either)*

### Table 0930 — Volume Units
Code counts: CH02C: 3, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (3):**

- `[pt_us]` — Pint *(not in UTG either)*
- `l` — Liter *(not in UTG either)*
- `ml` — Milliliters *(not in UTG either)*

### Table 0931 — Temperature Units
Code counts: CH02C: 3, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (3):**

- `Cel` — Degrees Celsius *(not in UTG either)*
- `[degF]` — Degrees Fahrenheit *(not in UTG either)*
- `degF` — Degrees Fahrenheit *(not in UTG either)*

### Table 0932 — Donation Duration Units
Code counts: CH02C: 2, Colleague: 0, UTG: 0

**Codes in CH02C but not in Colleague (2):**

- `min` — Minutes *(not in UTG either)*
- `s` — Seconds *(not in UTG either)*

### Table 4000 — name-addressRepresentation
Code counts: CH02C: 0, Colleague: 0, UTG: 3

**Codes only in UTG (3):**

- `A` — Alphabetic (i.e., Default or some single-byte)
- `I` — Ideographic (i.e., Kanji)
- `P` — Phonetic (i.e., ASCII, Katakana, Hiragana, etc.)

## Tables with Metadata Differences

| Table | Name | Difference Type | CH02C | Colleague | UTG |
|-------|------|----------------|-------|-----------|-----|
| 0001 | Administrative Sex | codeSystemOID | 2.16.840.1.113883.18.458 | 2.16.840.1.113883.18.458 | 2.16.840.1.113883.18.2 |
| 0001 | Administrative Sex | description | Table of codes specifying a patient's sex. | tbd | Code system of concepts specifying a patient's sex for administrative purposes.  Used in HL7 Version 2.x messages in the PID segment. |
| 0002 | Marital Status | description | Table of codes specifying a person's marital (civil/legal) status. | Code system of concepts specifying a person's marital (civil/legal) status.  Used in HL7 Version 2.x messages in the PID segment. | Code system of concepts specifying a person's marital (civil/legal) status.  Used in HL7 Version 2.x messages in the PID segment. |
| 0003 | Event | description | HL7-defined table of codes specifying the trigger event for Version 2.x interface messages. | HL7-defined code system of concepts specifying the trigger event for Version 2.x interface messages.  Used in HL7 Version 2.x messaging in the MSH segment. | HL7-defined code system of concepts specifying the trigger event for Version 2.x interface messages.  Used in HL7 Version 2.x messaging in the MSH segment. |
| 0004 | Patient Class | description | Table of codes used by systems to categorize patients by site in HL7 Version 2.x interfaces. | Code system of concepts used by systems to categorize patients by site in HL7 Version 2.x interfaces in the PV1 segment. | Code system of concepts used by systems to categorize patients by site in HL7 Version 2.x interfaces in the PV1 segment. |
| 0006 | Religion | description | Table of codes specifying a person's religion. | Code system of concepts specifying a person's religion.    Used in HL7 Version 2.x messaging in the PID segment. | Code system of concepts specifying a person's religion.    Used in HL7 Version 2.x messaging in the PID segment. |
| 0007 | Admission Type | description | Table of codes specifying the circumstances under which the patient was or will be admitted. | Code system of concepts specifying the circumstances under which the patient was or will be admitted.  Used in HL7 Version 2.x messaging in the PV1 segment. | Code system of concepts specifying the circumstances under which the patient was or will be admitted.  Used in HL7 Version 2.x messaging in the PV1 segment. |
| 0008 | Acknowledgment code | description | HL7-defined table of codes specifying acknowledgment codes used in Version 2.x message.  For details of usage, see message processing rules in the published Standard. | HL7-defined code system of concepts specifying acknowledgment codes.  For details of usage, see message processing rules in the published Standard.  Used in HL7 Version 2.x messaging in the MSA segment. | HL7-defined code system of concepts specifying acknowledgment codes.  For details of usage, see message processing rules in the published Standard.  Used in HL7 Version 2.x messaging in the MSA segment. |
| 0009 | Ambulatory Status | description | Table of codes specifying permanent or transient handicapped conditions of a person. | Code system of concepts specifying permanent or transient handicapped conditions of a person.  Used in HL7 Version 2.x messaging in the PV1 segment. | Code system of concepts specifying permanent or transient handicapped conditions of a person.  Used in HL7 Version 2.x messaging in the PV1 segment. |
| 0017 | Transaction Type | description | Table of codes specifying a type of financial transaction. | Code system of concepts specifying a type of financial transaction.  Used in HL7 Version 2.x messaging in the FT1 segment. | Code system of concepts specifying a type of financial transaction.  Used in HL7 Version 2.x messaging in the FT1 segment. |
| 0027 | Priority | description | HL7-defined table of codes specifying the allowed priorities for obtaining the specimen. | HL7-defined code system of concepts specifying the allowed priorities for obtaining the specimen.  Used in HL7 Version 2.x messaging in the OM4 segment. | HL7-defined code system of concepts specifying the allowed priorities for obtaining the specimen.  Used in HL7 Version 2.x messaging in the OM4 segment. |
| 0038 | Order status | description | HL7-defined table of codes specifying the status of an order. The purpose of these values are to report the status of an order either upon request (solicited), or when the status changes (unsolicited). The values are not intended to initiate action.  It is assumed that the order status value always reflects the status as it is known to the sending application at the time that a message is sent.  Only the filler can originate these values. | HL7-defined code system of concepts specifying the status of an order. The purpose of these values are to report the status of an order either upon request (solicited), or when the status changes (unsolicited). The values are not intended to initiate action.  It is assumed that the order status value always reflects the status as it is known to the sending application at the time that a message is sent.  Only the filler can originate these values.  Used in HL7 Version 2.x messaging in the ORC segment. | HL7-defined code system of concepts specifying the status of an order. The purpose of these values are to report the status of an order either upon request (solicited), or when the status changes (unsolicited). The values are not intended to initiate action.  It is assumed that the order status value always reflects the status as it is known to the sending application at the time that a message is sent.  Only the filler can originate these values.  Used in HL7 Version 2.x messaging in the ORC segment. |
| 0052 | Diagnosis Type | description | Table of codes that specify a type of diagnosis being sent. | Code system of concepts specifying a type of diagnosis being sent.  Used in HL7 Version 2.x messaging in the DG1 segment.. | Code system of concepts specifying a type of diagnosis being sent.  Used in HL7 Version 2.x messaging in the DG1 segment.. |
| 0061 | Check Digit Scheme | description | HL7-defined table of codes specifying the check digit scheme employed. | HL7-defined code system of concepts specifying the check digit scheme employed.   Used in HL7 Version 2.x messaging in PPN, XCN and XON segments. | HL7-defined code system of concepts specifying the check digit scheme employed.   Used in HL7 Version 2.x messaging in PPN, XCN and XON segments. |
| 0062 | Event Reason | description | Table of codes which specify the reason for an event. | Code system of concepts which specify the reason for an event.  Used in HL7 Version 2.x messaging in the EVN segment. | Code system of concepts which specify the reason for an event.  Used in HL7 Version 2.x messaging in the EVN segment. |
| 0063 | Relationship | description | Table of codes specifying an actual personal relationship that the next of kin/associated party has to a patient. | HL7-defined code system of concepts specifying an actual personal relationship that the next of kin/associated party has to a patient.  Used in HL7 Version 2.x messaging in the NK1 and IN1 segments. | HL7-defined code system of concepts specifying an actual personal relationship that the next of kin/associated party has to a patient.  Used in HL7 Version 2.x messaging in the NK1 and IN1 segments. |
| 0065 | Specimen Action Code | description | HL7-defined table of codes which specify actions to be taken with respect to the specimens that accompany or precede an order.  The purpose of these are to further qualify (when appropriate) the general action indicated by the order control code ( table 0119). | HL7-defined code system of concepts which specify actions to be taken with respect to the specimens that accompany or precede an order.  The purpose of these are to further qualify (when appropriate) the general action indicated by the order control code (code system xxxx).  Used in HL7 Version 2.x messaging in the OBR segment. | HL7-defined code system of concepts which specify actions to be taken with respect to the specimens that accompany or precede an order.  The purpose of these are to further qualify (when appropriate) the general action indicated by the order control code (code system xxxx).  Used in HL7 Version 2.x messaging in the OBR segment. |
| 0066 | Employment Status | description | Table of codes specifying the guarantor's employment status. | HL7-defined code system of concepts which specify an employment status of a person. Used in HL7 Version 2 messaging in the GT1 segment. | HL7-defined code system of concepts which specify an employment status of a person. Used in HL7 Version 2 messaging in the GT1 segment. |
| 0069 | Hospital Service | description | Table of codes specifying the treatment or type of surgery the patient is scheduled to receive. |  | Code system of concepts specifying the treatment or type of surgery the patient is scheduled to receive.   Used in HL7 Version 2.x messaging in the PV1 segment. |
| 0074 | Diagnostic Service Section ID | description | HL7-defined table of codes which specify a section of a diagnostic service where an observation may be performed. | HL7-defined code system of concepts which specify a section of a diagnostic service where the observation may be performed.  Used in HL7 Version 2.x messaging in the OBR and OM4 segments. | HL7-defined code system of concepts which specify a section of a diagnostic service where the observation may be performed.  Used in HL7 Version 2.x messaging in the OBR and OM4 segments. |
| 0076 | Message Type | description | HL7-defined table of codes which specify message types. | HL7-defined code system of concepts which specify message types.  Used in HL7 Version 2.x messaging in the MSH segment. | HL7-defined code system of concepts which specify message types.  Used in HL7 Version 2.x messaging in the MSH segment. |
| 0080 | Nature of Abnormal Testing | description | HL7-defined table of codes specifying the nature of an abnormal test. | HL7-defined code system of concepts specifying the nature of an abnormal test.  Used in HL7 Version 2.x messaging in the OBX segment. | HL7-defined code system of concepts specifying the nature of an abnormal test.  Used in HL7 Version 2.x messaging in the OBX segment. |
| 0083 | Outlier Type | description | Table of codes specifying the type of outlier (i.e. period of care beyond DRG-standard stay in facility) that has been paid. | HL7-defined code system of concepts specifying the type of outlier (i.e. period of care beyond DRG-standard stay in facility) that has been paid.   Used in HL7 Vesrion 2.x messaghing in the DRG segment. | HL7-defined code system of concepts specifying the type of outlier (i.e. period of care beyond DRG-standard stay in facility) that has been paid.   Used in HL7 Vesrion 2.x messaghing in the DRG segment. |
| 0085 | Observation Result Status Codes Interpretation | description | HL7-defined table of codes which specify observation result status. These codes reflect the current completion status of the results for one Observation Identifier. | HL7-defined code system of concepts which specify observation result status. These codes reflect the current completion status of the results for one Observation Identifier.  Used in HL7 Version 2.x messaging in the OBX segment. | HL7-defined code system of concepts which specify observation result status. These codes reflect the current completion status of the results for one Observation Identifier.  Used in HL7 Version 2.x messaging in the OBX segment. |
| 0091 | Query Priority | description | HL7-defined table of codes which specify a time frame in which a querry response is expected. | HL7-defined code system of concepts which specify a time frame in which a querry response is expected.  Used in HL7 Verson 2.x messaging in the RCP segment. | HL7-defined code system of concepts which specify a time frame in which a querry response is expected.  Used in HL7 Verson 2.x messaging in the RCP segment. |
| 0092 | Re-Admission Indicator | symbolicName | re-admissionIndicator |  | ReAdmissionIndicator |
| 0092 | Re-Admission Indicator | description | Table of codes which are used to specify that a patient is being re-admitted to a healthcare facility from which they were discharged, and indicates the circumstances around such re-admission. |  | Code system of concepts which are used to specify that a patient is being re admitted to a healthcare facilityin from which they were discharged, and indicates the circumstances around such re-admission.  Used in HL7 Version 2.x messagine in the PV1 segment. |
| 0098 | Type of Agreement | description | Table of codes which specify codes to further identify an insurance plan. |  | Code system of concepts which specify codes to further identify an insurance plan.  Used in HL7 Version 2.x messaging in the IN1 segment. |
| 0100 | Invocation event | description | HL7-defined table of codes which specify codes for an event precipitating/triggering a charge activity. | HL7-defined code system of concepts which specify codes for an event precipitating/triggering a charge activity.  Used in HL7 Version 2.x messaging in the CCD and BLG segments. | HL7-defined code system of concepts which specify codes for an event precipitating/triggering a charge activity.  Used in HL7 Version 2.x messaging in the CCD and BLG segments. |
| 0103 | Processing ID | description | HL7-defined table of codes which specify whether the message is part of a production, training or debugging system. | HL7-defined code system of concepts which specify whether the message is part of a production, training or debugging system.  Used in HL7 Version 2.x messaging in the PT datatype. | HL7-defined code system of concepts which specify whether the message is part of a production, training or debugging system.  Used in HL7 Version 2.x messaging in the PT datatype. |
| 0104 | Version ID | description | HL7-defined table of codes which are used to identify an HL7 version in the Version 2.x family of published standards. | HL7-defined code system of concepts which are used to identify an HL7 version in the Version 2.x family of published standards.  Used in HL7 Version 2.x messaging in the VID segment. | HL7-defined code system of concepts which are used to identify an HL7 version in the Version 2.x family of published standards.  Used in HL7 Version 2.x messaging in the VID segment. |
| 0105 | Source of Comment | description | HL7-defined table of codes which are used to specify the source of a comment. | HL7-defined code system of concepts which are used to specify the source of a comment.  Used in HL7 Version 2.x messaging in the NTE segment. | HL7-defined code system of concepts which are used to specify the source of a comment.  Used in HL7 Version 2.x messaging in the NTE segment. |
| 0116 | Bed Status | description | Table of codes which specify the state of a bed in an inpatient setting, and is used to determine if a patient may be assigned to it or not. | Code system of concepts which specify the state of a bed in an inpatient setting, and is used to determine if a patient may be assigned to it or not.  Used in HL7 Version 2.x messaging in the DLD and PV1 segments. | Code system of concepts which specify the state of a bed in an inpatient setting, and is used to determine if a patient may be assigned to it or not.  Used in HL7 Version 2.x messaging in the DLD and PV1 segments. |
| 0119 | Order Control Codes | description | HL7-defined table of codes which are used to determine the function of the order segment.  Depending on the message, the action specified by one of these control codes may refer to an order or an individual service. | HL7-defined code system of concepts which are used to determine the function of the order segment.  Depending on the message, the action specified by one of these control codes may refer to an order or an individual service.  Used in Version 2.x messaging of orders in the ORC segment. | HL7-defined code system of concepts which are used to determine the function of the order segment.  Depending on the message, the action specified by one of these control codes may refer to an order or an individual service.  Used in Version 2.x messaging of orders in the ORC segment. |
| 0121 | Response Flag | description | HL7-defined table of codes allowing the placer (sending) application to determine the amount of information to be returned from the filler. | HL7-defined code system of concepts allowing the placer (sending) application to determine the amount of information to be returned from the filler.  Used in HL7 Version 2.x messaging in the ORC segment. | HL7-defined code system of concepts allowing the placer (sending) application to determine the amount of information to be returned from the filler.  Used in HL7 Version 2.x messaging in the ORC segment. |
| 0122 | Charge Type | description | HL7-defined table of codes which specify someone or something other than the patient to be billed for a service. | HL7-defined code system of concepts which specify someone or something other than the patient to be billed for a service.  Used in HL7 Version 2.x messaging in the BLG segment. | HL7-defined code system of concepts which specify someone or something other than the patient to be billed for a service.  Used in HL7 Version 2.x messaging in the BLG segment. |
| 0123 | Result Status | description | HL7-defined table of codes which specify a status of results for an order. | HL7-defined code system of concepts which specify a status of results for an order.  Used in HL7 Version 2.x messaging in the OBR segment. | HL7-defined code system of concepts which specify a status of results for an order.  Used in HL7 Version 2.x messaging in the OBR segment. |
| 0124 | Transportation Mode | description | HL7-defined table of codes which specify how (or whether) to transport a patient, when applicable, for an ordered service. | HL7-defined code system of concepts which specify how (or whether) to transport a patient, when applicable, for an ordered service.  Used in HL7 Version 2.x messaging in the OBR segment. | HL7-defined code system of concepts which specify how (or whether) to transport a patient, when applicable, for an ordered service.  Used in HL7 Version 2.x messaging in the OBR segment. |
| 0126 | Quantity Limited Request | description | HL7-defined table of codes which specify the maximum length of a query response that can be accepted by a requesting system, and are expressed as units of mesaure of query response objects. | HL7-defined code system of concepts which specify the maximum length of a query response that can be accepted by a requesting system, and are expressed as units of mesaure of query response objects.  Used in HL7 Version 2.x messaging in the RCP segment. | HL7-defined code system of concepts which specify the maximum length of a query response that can be accepted by a requesting system, and are expressed as units of mesaure of query response objects.  Used in HL7 Version 2.x messaging in the RCP segment. |
| 0127 | Allergen Type | description | Table of codes speciying a classification of general allergy categories (drug, food, pollen, etc.). | Code system of concepts speciying a classification of general allergy categories (drug, food, pollen, etc.).  Used in HL7 Version 2.x messaging in the AL1 segment. | Code system of concepts speciying a classification of general allergy categories (drug, food, pollen, etc.).  Used in HL7 Version 2.x messaging in the AL1 segment. |
| 0128 | Allergy Severity | description | Table of codes which specify the general severity of an allergy. | Code system of concepts which specify the general severity of an allergy.  Used in HL7 Version 2.x messaging in the AL1 segment. | Code system of concepts which specify the general severity of an allergy.  Used in HL7 Version 2.x messaging in the AL1 segment. |
| 0130 | Visit User Code | description | Table of codes which specify categories of a patient's visit with respect to an individual institution's needs, and is expected to be different on a site-specific basis. | Code system of concepts which specify categories of a patient's visit with respect to an individual institution's needs, and is expected to be different on a site-specific basis.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts which specify categories of a patient's visit with respect to an individual institution's needs, and is expected to be different on a site-specific basis.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0131 | Contact Role | description | Table of codes which specify a relationship role that the next of kin/associated parties plays with regard to a patient. Also used in referrals, for example, it may be necessary to identify the contact representative at the clinic that issued a referral. | Code system of concepts which specify a relationship role that the next of kin/associated parties plays with regard to the patient. Also used in referrals, for example, it may be necessary to identify the contact representative at the clinic that sent a referral. Used in HL7 Version 2 messaging in the NK1 and CTD segments after 2.5, when it replace 2.16.840.1.113883.18.57. | Code system of concepts which specify a relationship role that the next of kin/associated parties plays with regard to the patient. Also used in referrals, for example, it may be necessary to identify the contact representative at the clinic that sent a referral. Used in HL7 Version 2 messaging in the NK1 and CTD segments after 2.5, when it replace 2.16.840.1.113883.18.57. |
| 0133 | Procedure practitioner identifier code type | description | HL7-defined table of concepts which specify the different types of practitioners associated with this procedure.   This set of codes is known to be incomplete.  Note that as of v2.6, this table and the field(s) it was used in was replaced by table 443 used in the ROL segment. |  | HL7-defined table of concepts which specify the different types of practitioners associated with this procedure.   This set of codes is known to be incomplete.  Note that as of v2.6, this table and the field(s) it was used in was replaced by table 443 used in the ROL segment.  Used in Version 2.x messaging in the PR1 segment, but was discontinued as of 2.6; usage replaced with code system 2.16.840.1.113883.18.283 providerRole. |
| 0135 | Assignment of Benefits | description | Table of codes which indicate whether an insured person agreed to assign the insurance benefits to a healthcare provider.  If so, the insurance will pay the provider directly. | Code system of concepts which indicate whether an insured person agreed to assign the insurance benefits to the healthcare provider.  If so, the insurance will pay the provider directly.  Used in HL7 Version 2.x messaging in the IN1 segment. | Code system of concepts which indicate whether an insured person agreed to assign the insurance benefits to the healthcare provider.  If so, the insurance will pay the provider directly.  Used in HL7 Version 2.x messaging in the IN1 segment. |
| 0137 | Mail Claim Party | description | Table of codes which specify a party to which a claim should be mailed when claims are sent by mail. | Code system of concepts which specify a party to which a claim should be mailed when claims are sent by mail.  Used in HL7 Version 2.x messaging in the IN2 segment. | Code system of concepts which specify a party to which a claim should be mailed when claims are sent by mail.  Used in HL7 Version 2.x messaging in the IN2 segment. |
| 0140 | Military Service | description | Table of codes which specify the military branch.  This field is defined by CMS or other regulatory agencies. | Code system of concepts which specify the military branch.  This field is defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the PD1 segment. | Code system of concepts which specify the military branch.  This field is defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the PD1 segment. |
| 0142 | Military Status | description | Table of codes which specify the military status of the patient.  This field is defined by CMS or other regulatory agencies. | Code system of concepts  which specify the military status of the patient.  This field is defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the PD1 segment. | Code system of concepts  which specify the military status of the patient.  This field is defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the PD1 segment. |
| 0144 | Eligibility Source | description | Table of codes which specify the source of information about the insured's eligibility for benefits. | Code system of concepts  which specify the source of information about the insured's eligibility for benefits.  Used in HL7 Version 2.x messaging in the IN2 segment. | Code system of concepts  which specify the source of information about the insured's eligibility for benefits.  Used in HL7 Version 2.x messaging in the IN2 segment. |
| 0145 | Room Type | description | Table of codes which specify the room type. | Code system of concepts  which specify the room type.  Used in HL7 Version 2.x messaging in the RMC segment. | Code system of concepts  which specify the room type.  Used in HL7 Version 2.x messaging in the RMC segment. |
| 0146 | Amount Type | description | Table of codes which specify amount quantity type. | Code system of concepts  which specify amount quantity type.  Used in HL7 Version 2.x messaging in the RMC segment. | Code system of concepts  which specify amount quantity type.  Used in HL7 Version 2.x messaging in the RMC segment. |
| 0147 | Policy Type | description | Table of codes which specify the policy type. | Code system of concepts which specify the policy type.  Used in HL7 Version 2.x messaging in the PTA segment. | Code system of concepts which specify the policy type.  Used in HL7 Version 2.x messaging in the PTA segment. |
| 0148 | Money or Percentage Indicator | description | HL7-defined table of codes which specify whether the amount is currency or a percentage. | HL7-defined code system of concepts  which specify whether the amount is currency or a percentage.  Used in HL7 Version 2.x messaging in the MOP segment. | HL7-defined code system of concepts  which specify whether the amount is currency or a percentage.  Used in HL7 Version 2.x messaging in the MOP segment. |
| 0149 | Day Type | description | Table of codes which specify whether the days are denied, pending or approved. | Code system of concepts  which specify whether the days are denied, pending or approved.  Used in HL7 Version 2.x messaging in the DTN segment. | Code system of concepts  which specify whether the days are denied, pending or approved.  Used in HL7 Version 2.x messaging in the DTN segment. |
| 0150 | Certification Patient Type | description | Table of codes which specify the category or type of patient for which this certification is requested. | Code system of concepts  which specify the category or type of patient for which this certification is requested.  Used in HL7 Version 2.x messaging in the ICD segment. | Code system of concepts  which specify the category or type of patient for which this certification is requested.  Used in HL7 Version 2.x messaging in the ICD segment. |
| 0155 | Accept/Application Acknowledgment Conditions | symbolicName | accept-applicationAcknowledgmentConditions | Accept-applicationAcknowledgmentConditions | AcceptApplicationAcknowledgmentConditions |
| 0155 | Accept/Application Acknowledgment Conditions | description | HL7-defined table of codes which identify conditions under which accept acknowledgments are required to be returned in response to a message, and required for enhanced acknowledgment mode. | HL7-defined code system of concepts which identify conditions under which accept acknowledgments are required to be returned in response to a message, and required for enhanced acknowledgment mode. Used in HL7 Versions 2 messaging in the MSH segment. | HL7-defined code system of concepts which identify conditions under which accept acknowledgments are required to be returned in response to a message, and required for enhanced acknowledgment mode. Used in HL7 Versions 2 messaging in the MSH segment. |
| 0159 | Diet Code Specification Type | description | HL7-defined table of codes which specify the type of diet. | HL7-defined code system of concepts  which specify whether the type of diet.    Used in HL7 Version 2.x messaging in the ODS segment. | HL7-defined code system of concepts  which specify whether the type of diet.    Used in HL7 Version 2.x messaging in the ODS segment. |
| 0160 | Tray Type | description | HL7-defined table of codes which specify the type of dietary tray. | HL7-defined code system of concepts  which specify whether the type of diet.    Used in HL7 Version 2.x messaging in the ODT segment. | HL7-defined code system of concepts  which specify whether the type of diet.    Used in HL7 Version 2.x messaging in the ODT segment. |
| 0161 | Allow Substitution | description | HL7-defined table of codes which specify whether substitutions are allowed and, if so, the type of substitutions allowed. |  | HL7-defined code system of concepts  which specify whether substitutions are allowed and, if so, the type of substitutions allowed.    Used in HL7 Version 2.x messaging in the RXO segment. |
| 0162 | Route of Administration | description | Table of codes which specify the route of administration. | Code system of concepts  which specify the route of administration.  Used in HL7 Version 2.x messaging in the RXR segment. | Code system of concepts  which specify the route of administration.  Used in HL7 Version 2.x messaging in the RXR segment. |
| 0163 | Body Site | description | HL7-defined table of codes that specify a body site from which a specimen is obtained. | HL7-defined code system of concepts that specify a body site from which a specimen is obtained.  Used in HL7 Version 2.x messaging in the OBX and CH7 segments. | HL7-defined code system of concepts that specify a body site from which a specimen is obtained.  Used in HL7 Version 2.x messaging in the OBX and CH7 segments. |
| 0164 | Administration Device | description | Table of codes which specify the mechanical device used to aid in the administration of the drug or other treatment.  Common examples are IV-sets of different types. | Code system of concepts  which specify the mechanical device used to aid in the administration of the drug or other treatment.  Common examples are IV-sets of different types.  Used in HL7 Version 2.x messaging in the RXR segment. | Code system of concepts  which specify the mechanical device used to aid in the administration of the drug or other treatment.  Common examples are IV-sets of different types.  Used in HL7 Version 2.x messaging in the RXR segment. |
| 0165 | Administration Method | description | Table of codes which specify the specific method requested for the administration of the drug or treatment to the patient. | Code system of concepts  which specify the specific method requested for the administration of the drug or treatment to the patient.  Used in HL7 Version 2.x messaging in the RXR segment. | Code system of concepts  which specify the specific method requested for the administration of the drug or treatment to the patient.  Used in HL7 Version 2.x messaging in the RXR segment. |
| 0166 | RX Component Type | description | HL7-defined table of codes which specify the RX component type. | HL7-defined code system of concepts  which specify the RX component type.  Used in HL7 Version 2.x messaging in the RXC segment. | HL7-defined code system of concepts  which specify the RX component type.  Used in HL7 Version 2.x messaging in the RXC segment. |
| 0167 | Substitution Status | description | HL7-defined table of codes which specify the substitution status. | HL7-defined code system of concepts  which specify the substitution status.  Used in HL7 Version 2.x messaging in the RXE, RXD, and RXG segments. | HL7-defined code system of concepts  which specify the substitution status.  Used in HL7 Version 2.x messaging in the RXE, RXD, and RXG segments. |
| 0168 | Processing Priority | description | HL7-defined table of codes which specify one or more available priorities for performing the observation or test. | HL7-defined code system of concepts  which specify one or more available priorities for performing the observation or test.  Used in HL7 Version 2.x messaging in the OM1 segment. | HL7-defined code system of concepts  which specify one or more available priorities for performing the observation or test.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0169 | Reporting Priority | description | HL7-defined table of codes which specify the available priorities reporting the test results when the user is asked to specify the reporting priority independent of the processing priority. | HL7-defined code system of concepts  which specify the available priorities reporting the test results when the user is asked to specify the reporting priority independent of the processing priority.  Used in HL7 Version 2.x messaging in the OM1 segment. | HL7-defined code system of concepts  which specify the available priorities reporting the test results when the user is asked to specify the reporting priority independent of the processing priority.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0170 | Derived Specimen | description | HL7-defined table of codes which specify the parents and children for diagnostic studies, especially in microbiology, where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture).  The process also produces new "specimens" (e.g., pure culture of staphylococcus, and E. coli), and these are studied by a second order process (bacterial sensitivities). The parents (e.g., blood culture) and children (e.g., penicillin MIC) are identified in such cases. | HL7-defined code system of concepts  which specify the parents and children for diagnostic studies, especially in microbiology, where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture).  The process also produces new "specimens" (e.g., pure culture of staphylococcus, and E. coli), and these are studied by a second order process (bacterial sensitivities). The parents (e.g., blood culture) and children (e.g., penicillin MIC) are identified in such cases.  Used in HL7 Version 2.x messaging in the OM4 segment. | HL7-defined code system of concepts  which specify the parents and children for diagnostic studies, especially in microbiology, where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture).  The process also produces new "specimens" (e.g., pure culture of staphylococcus, and E. coli), and these are studied by a second order process (bacterial sensitivities). The parents (e.g., blood culture) and children (e.g., penicillin MIC) are identified in such cases.  Used in HL7 Version 2.x messaging in the OM4 segment. |
| 0173 | Coordination of Benefits | description | Table of codes specifying whether this insurance works in conjunction with other insurance plans or if it provides independent coverage and payment of benefits regardless of other insurance that might be available to the patient. | Code system of concepts specifying whether this insurance works in conjunction with other insurance plans or if it provides independent coverage and payment of benefits regardless of other insurance that might be available to the patient.  Used in HL7 Version 2.x messaging in the IN1 segment. | Code system of concepts specifying whether this insurance works in conjunction with other insurance plans or if it provides independent coverage and payment of benefits regardless of other insurance that might be available to the patient.  Used in HL7 Version 2.x messaging in the IN1 segment. |
| 0174 | Nature of Service/Test/Observation | description | Table of codes specifying an identification of a test battery, an entire functional procedure or study, a single test value (observation), multiple test batteries or functional procedures as an orderable unit (profile), or a single test value (observation) calculated from other independent observations, typically used as an indicator for Master Files. | Code system of concepts specifying an identification of a test battery, an entire functional procedure or study, a single test value (observation), multiple test batteries or functional procedures as an orderable unit (profile), or a single test value (observation) calculated from other independent observations, typically used as an indicator for Master Files.  Used in HL7 Version 2.x messaging in the OM1 segment. | Code system of concepts specifying an identification of a test battery, an entire functional procedure or study, a single test value (observation), multiple test batteries or functional procedures as an orderable unit (profile), or a single test value (observation) calculated from other independent observations, typically used as an indicator for Master Files.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0175 | Master File Identifier Code | codeSystemOID | 2.16.840.1.113883.18.91 | 2.16.840.1.113883.18.460 | 2.16.840.1.113883.18.91 |
| 0175 | Master File Identifier Code | description | HL7-defined table of codes which are represented by codes identifying HL7 Versions 2.x Master Files. | HL7-defined code system of concepts which are represented by codes identifying HL7 Versions 2.x Master Files.  Used in HL7 Version 2.x messaging in the MFI segment. | HL7-defined code system of concepts which are represented by codes identifying HL7 Versions 2.x Master Files.  Used in HL7 Version 2.x messaging in the MFI segment. |
| 0177 | Confidentiality Code | description | Table of codes specifying the degree to which special confidentiality protection should be applied to the observation. | Code system of concepts specifying the degree to which special confidentiality protection should be applied to the observation.  Used in HL7 Version 2.x messaging in the OM1 and ORC segments. | Code system of concepts specifying the degree to which special confidentiality protection should be applied to the observation.  Used in HL7 Version 2.x messaging in the OM1 and ORC segments. |
| 0178 | File Level Event Code | symbolicName | file-levelEvent | File-levelEvent | FileLevelEvent |
| 0178 | File Level Event Code | description | HL7-defined table of codes specifying file-level events for master files. | HL7-defined code system of concepts specifying file-level events for master files.  Used in HL7 Version 2 messaging in the MFI segment. | HL7-defined code system of concepts specifying file-level events for master files.  Used in HL7 Version 2 messaging in the MFI segment.   |
| 0179 | Response Level | description | HL7-defined table of codes specifying application response levels defined for a given Master File Message at the MFE segment level, and used for MFN-Master File Notification message. | HL7-defined code system of concepts specifying application response levels defined for a given Master File Message at the MFE segment level, and used for MFN-Master File Notification message.  Specifies additional detail (beyond MSH-15 - Accept Acknowledgment Type and MSH-16 - Application Acknowledgment Type) for application-level acknowledgment paradigms for Master Files transactions.  Used in HL7 Version 2.x messaging in the MFI segment. | HL7-defined code system of concepts specifying application response levels defined for a given Master File Message at the MFE segment level, and used for MFN-Master File Notification message.  Specifies additional detail (beyond MSH-15 - Accept Acknowledgment Type and MSH-16 - Application Acknowledgment Type) for application-level acknowledgment paradigms for Master Files transactions.  Used in HL7 Version 2.x messaging in the MFI segment. |
| 0180 | Masterfile Action Code | description | HL7-defined table of codes specifying an action for a master file record. | HL7-defined code system of concepts specifying an action for a master file record. Used in HL7 Version 2.x messaging in the MFE segment. | HL7-defined code system of concepts specifying an action for a master file record. Used in HL7 Version 2.x messaging in the MFE segment. |
| 0181 | MFN Record-level Error Return | symbolicName | mfnRecord-levelErrorReturn | MfnRecord-levelErrorReturn | MfnRecordLevelErrorReturn |
| 0181 | MFN Record-level Error Return | description | Table of codes specifying the status of the requested update.  Site-defined table, specific to each master file being updated via this transaction. | Code system of concepts specifying the status of the requested update.  Site-defined table, specific to each master file being updated via this transaction.  Used in HL7 Version 2.x messaging in the MFA segment. | Code system of concepts specifying the status of the requested update.  Site-defined table, specific to each master file being updated via this transaction.  Used in HL7 Version 2.x messaging in the MFA segment. |
| 0183 | Active/Inactive | symbolicName | active-inactive | Active-inactive | ActiveInactive |
| 0183 | Active/Inactive | description | HL7-defined table of codes specifying whether a person is currently a valid staff member. | HL7-defined code system of concepts specifying whether a person is currently a valid staff member.  Used in HL7 Version 2.x messaging in the STF segment. | HL7-defined code system of concepts specifying whether a person is currently a valid staff member.  Used in HL7 Version 2.x messaging in the STF segment. |
| 0185 | Preferred Method of Contact | description | HL7-defined table of codes specifying which of a group of multiple phone numbers is the preferred method of contact for this person. | HL7-defined code system of concepts specifying which of a group of multiple phone numbers is the preferred method of contact for this person.  Used in HL7 Version 2.x messaging in the STF, PRD, and CTD segments. | HL7-defined code system of concepts specifying which of a group of multiple phone numbers is the preferred method of contact for this person.  Used in HL7 Version 2.x messaging in the STF, PRD, and CTD segments. |
| 0187 | Provider Billing | description | HL7-defined table of codes specifying how provider services are billed. | HL7-defined code system of concepts specifying how provider services are billed.  Used in HL7 Version 2.x messaging in the PRA segment. | HL7-defined code system of concepts specifying how provider services are billed.  Used in HL7 Version 2.x messaging in the PRA segment. |
| 0189 | Ethnic Group | description | Table of codes further defining a patient's ancestry.  In the US, a current use is to use these codes to report ethnicity in line with US federal standards for Hispanic origin. |  | Code system of concepts further defining a patient's ancestry.  In the US, a current use is to use these codes to report ethnicity in line with US federal standards for Hispanic origin.  Used for HL7 Version 2 messaging in the PID segment. |
| 0190 | Address Type | description | HL7-defined table of codes specifying types or kinds of addresses. | HL7-defined code system of concepts specifying types or kinds of addresses.  Used in HL7 Version 2.x messaging in the XAD segment. | HL7-defined code system of concepts specifying types or kinds of addresses.  Used in HL7 Version 2.x messaging in the XAD segment. |
| 0191 | Type of Referenced Data | description | HL7-defined table of codes declaring the general type of media data that is encoded. | HL7-defined code system of concepts declaring the general type of media data that is encoded.  Used in v2.5.1 interfaces and earlier, and replaced with the full set of IANA media types as a standard coding system for this after HL7 version 2.6 (see value set 2.16.840.1.113883.21.425 hl7VS-mimeTypes for HL7 table 0834 built on MIME types).  More information may be found at http://www.iana.org/assignments/media-types/media-types.xhtml | HL7-defined code system of concepts declaring the general type of media data that is encoded.  Used in v2.5.1 interfaces and earlier, and replaced with the full set of IANA media types as a standard coding system for this after HL7 version 2.6 (see value set 2.16.840.1.113883.21.425 hl7VS-mimeTypes for HL7 table 0834 built on MIME types).  More information may be found at http://www.iana.org/assignments/media-types/media-types.xhtml |
| 0193 | Amount Class | description | Table of codes specifying the amount quantity class. | Code system of concepts specifying the amount quantity class.  Used in HL7 Version 2.x messaging in the PTA segment. | Code system of concepts specifying the amount quantity class.  Used in HL7 Version 2.x messaging in the PTA segment. |
| 0200 | Name Type | description | HL7-defined table of codes for types of names for persons. | HL7-defined code system of concepts for types of names for persons.  Used in HL7 Version 2.x messaging in the XPN, PPN, XCN, PID and MRG segments. | HL7-defined code system of concepts for types of names for persons.  Used in HL7 Version 2.x messaging in the XPN, PPN, XCN, PID and MRG segments. |
| 0201 | Telecommunication Use Code | description | HL7-defined table of codes for specifying a specific use of a telecommunication number.  Best practice is to use this concept whenever a telecommunication number or access string is specified. | HL7-defined code system of concepts for specifying a specific use of a telecommunication number.  Best practice is to use this concept whenever a telecommunication number or access string is specified.  Used in HL7 Version 2.x messaging in the XTN segment. | HL7-defined code system of concepts for specifying a specific use of a telecommunication number.  Best practice is to use this concept whenever a telecommunication number or access string is specified.  Used in HL7 Version 2.x messaging in the XTN segment. |
| 0202 | Telecommunication Equipment Type | description | HL7-defined table of codes  for specifying a type of telecommunication equipment.  Best practice is to use this concept whenever a telecommunication number or access string for particular equipment is specified. | HL7-defined code system of concepts  for specifying a type of telecommunication equipment.  Best practice is to use this concept whenever a telecommunication number or access string for particular equipment is specified.  Used in HL7 Version 2.x messaging in the XTN segment. | HL7-defined code system of concepts  for specifying a type of telecommunication equipment.  Best practice is to use this concept whenever a telecommunication number or access string for particular equipment is specified.  Used in HL7 Version 2.x messaging in the XTN segment. |
| 0203 | Identifier Type | description | HL7-defined table of codes specifying the type of identififier. |  | HL7-defined code system of concepts specifying type of identifier. Used in HL7 Version 2.x messaging data types CX, PLN, PPN, XCN and XON. |
| 0204 | Organizational Name Type | description | Table of codes used to specify the type of name for an organization i.e., legal name, display name. | Code system of concepts used to specify the type of name for an organization i.e., legal name, display name.   Used in HL7 Version 2.x messaging in the XON and PD1 segments. | Code system of concepts used to specify the type of name for an organization i.e., legal name, display name.   Used in HL7 Version 2.x messaging in the XON and PD1 segments. |
| 0205 | Price Type | description | HL7-defined table of codes used to identify the intent for the dollar amount on a pricing transaction. | HL7-defined code system of concepts used to identify the intent for the dollar amount on a pricing transaction.  Used in HL7 Version 2.x messaging in the CP datatype. | HL7-defined code system of concepts used to identify the intent for the dollar amount on a pricing transaction.  Used in HL7 Version 2.x messaging in the CP datatype. |
| 0206 | Segment Action Code | description | HL7-defined table of codes specifying actions to be applied for segments when an HL7 version 2 interface is operating in "action code mode" (a kind of update mode in the Standard). | HL7-defined code system of concepts specifying actions to be applied for segments when an HL7 version 2 interface is operating in "action code mode" (a kind of update mode in the Standard).  Used in HL7 Version 2.x messaging in the RXA, RXV, LCH, IAM, ARV, IN1 and OH1 segments. | HL7-defined code system of concepts specifying actions to be applied for segments when an HL7 version 2 interface is operating in "action code mode" (a kind of update mode in the Standard).  Used in HL7 Version 2.x messaging in the RXA, RXV, LCH, IAM, ARV, IN1 and OH1 segments. |
| 0207 | Processing Mode | description | HL7-defined table of codes that indicate an archival process or an initial load process. | HL7-defined code system of concepts that indicate an archival process or an initial load process.  Used in HL7 Version 2.x messaging in the PT datatype. | HL7-defined code system of concepts that indicate an archival process or an initial load process.  Used in HL7 Version 2.x messaging in the PT datatype. |
| 0208 | Query Response Status | description | HL7-defined table of codes defining precise response status concepts in support of HL7 Version 2 query messaging.  It is commonly used to indicate no data is found that matches the query parameters, but no error. | HL7-defined code system of concepts defining precise response status concepts in support of HL7 Version 2 query messaging.  It is commonly used to indicate no data is found that matches the query parameters, but no error.   Used in HL7 Version 2.x messaging in the QAK segment. | HL7-defined code system of concepts defining precise response status concepts in support of HL7 Version 2 query messaging.  It is commonly used to indicate no data is found that matches the query parameters, but no error.   Used in HL7 Version 2.x messaging in the QAK segment. |
| 0209 | Relational Operator | description | HL7-defined table of codes used to define the relationship between HL7 segment field names identified in a query construct. | HL7-defined code system of concepts used to define the relationship between HL7 segment field names identified in a query construct.  Used in HL7 Version 2.x messaging in the QSC segment. | HL7-defined code system of concepts used to define the relationship between HL7 segment field names identified in a query construct.  Used in HL7 Version 2.x messaging in the QSC segment. |
| 0210 | Relational Conjunction | description | HL7-defined table of codes used with relational operator values to group more than one segment field name. | HL7-defined code system of concepts used with relationalOperator values to group more than one segment field name.   Used in HL7 Version 2.x messaging in the QSC segment. | HL7-defined code system of concepts used with relationalOperator values to group more than one segment field name.   Used in HL7 Version 2.x messaging in the QSC segment. |
| 0211 | Alternate Character Sets | description | Table of codes that identify one of a number of possible standard alternate character sets for a message, either single-byte or double-byte. | HL7-defined code system of concepts used to specify the character set(s) in use.  Includes both single-byte and double-byte characters sets, and used in Version 2.x messaging in the MSH segment. | HL7-defined code system of concepts used to specify the character set(s) in use.  Includes both single-byte and double-byte characters sets, and used in Version 2.x messaging in the MSH segment. |
| 0213 | Purge Status Code | description | Table of codes used to define the state of a visit relative to its place in a purge workflow. | Code system of concepts used to define the state of a visit relative to its place in a purge workflow.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts used to define the state of a visit relative to its place in a purge workflow.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0214 | Special Program Code | description | Table of codes used to record a health insurance program required for healthcare visit reimbursement. |  | Code system of concepts used to record a health insurance program required for healthcare visit reimbursement.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0215 | Publicity Code | description | Table of codes specifying a level of publicity of information about a patient for a specific visit. |  | Code system of concepts specifying a level of publicity of information about a patient for a specific visit.  Used in HL7 Version 2.x messaging in the PV2 and PD1 segments. |
| 0216 | Patient Status Code | description | Table of codes used to define the state of a care episode for a patient. |  | Code system of concepts used to define the state of a care episode for a patient.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0217 | Visit Priority Code | description | Table of codes used to define a relative level of urgency applied to a patient visit. | Code system of concepts used to define a relative level of urgency applied to a patient visit.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts used to define a relative level of urgency applied to a patient visit.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0220 | Living Arrangement | description | Table of codes characterizing the situation that patient-associated parties live in at their residential address. | Code system of concepts characterizing the situation that patient-associated parties live in at their residential address.  Used in HL7 Version 2.x messaging in the NK1 and PD1 segments. | Code system of concepts characterizing the situation that patient-associated parties live in at their residential address.  Used in HL7 Version 2.x messaging in the NK1 and PD1 segments. |
| 0223 | Living Dependency | description | Table of codes identifying specific living conditions (e.g., spouse dependent on patient, walk-up) that are relevant to an evaluation of the patient's healthcare needs. | HL7-defined code system of concepts that identify specific living conditions (e.g., spouse dependent on patient, walk-up) that are relevant to an evaluation of the patient’s healthcare needs.  This information can be used for discharge planning.  Examples might include Spouse Dependent, Medical Supervision Required, Small Children Dependent.  Used in Version 2.s messaging in the NK1 segment. | HL7-defined code system of concepts that identify specific living conditions (e.g., spouse dependent on patient, walk-up) that are relevant to an evaluation of the patient’s healthcare needs.  This information can be used for discharge planning.  Examples might include Spouse Dependent, Medical Supervision Required, Small Children Dependent.  Used in Version 2.s messaging in the NK1 segment. |
| 0224 | Transport Arranged | description | HL7-defined table of codes defining whether patient transportation preparations are in place. | HL7-defined code system of concepts defining whether patient transportation preparations are in place.  Used in HL7 Version 2.x messaging in the OBR segment. | HL7-defined code system of concepts defining whether patient transportation preparations are in place.  Used in HL7 Version 2.x messaging in the OBR segment. |
| 0225 | Escort Required | description | HL7-defined table of codes indicating whether a patient must be accompanied while travelling to a diagnostic service department. | HL7-defined code system of concepts defining whether patient transportation preparations are in place.  Used in HL7 Version 2.x messaging in the OBR segment. | HL7-defined code system of concepts defining whether patient transportation preparations are in place.  Used in HL7 Version 2.x messaging in the OBR segment. |
| 0228 | Diagnosis Classification | description | Table of codes used to classify whether a patient visit can be related to a diagnosis. | Code system of concepts used to classify whether a patient visit can be related to a diagnosis.  Used in HL7 Version 2.x messaging in the DG1 segment. | Code system of concepts used to classify whether a patient visit can be related to a diagnosis.  Used in HL7 Version 2.x messaging in the DG1 segment. |
| 0230 | Procedure Functional Type | description | Table of codes used to classify a procedure. | Code system of concepts used to classify a procedure.  Used in HL7 Version 2.x messaging in the PR1 segment. | Code system of concepts used to classify a procedure.  Used in HL7 Version 2.x messaging in the PR1 segment. |
| 0231 | Student Status | description | Table of codes used to designate whether a guarantor is a full or part time student. | Code system of concepts used to designate whether a guarantor is a full or part time student.  Used in HL7 Version 2.x messaging in the GT1, NK1 and PD1 segments. | Code system of concepts used to designate whether a guarantor is a full or part time student.  Used in HL7 Version 2.x messaging in the GT1, NK1 and PD1 segments. |
| 0232 | Insurance Company Contact Reason | description | Table of codes used to describe why an insurance company has been contacted. |  | Code system of concepts used to describe why an insurance company has been contacted.  Used in HL7 Version 2.x messaging in the IN2 segment. |
| 0234 | Report Timing | description | HL7-defined table of codes used to identify the time span of a report or the reason for a report sent to a regulatory agency. | HL7-defined code system of concepts used to identify the time span of a report or the reason for a report sent to a regulatory agency.  Used in HL7 Version 2.x messaging in the PES segment. | HL7-defined code system of concepts used to identify the time span of a report or the reason for a report sent to a regulatory agency.  Used in HL7 Version 2.x messaging in the PES segment. |
| 0235 | Report Source | description | HL7-defined table of codes used to identify where a report sender learned about an event. | HL7-defined code system of concepts used to identify where a report sender learned about an event.  Used in HL7 Version 2.x messaging in the PES segment. | HL7-defined code system of concepts used to identify where a report sender learned about an event.  Used in HL7 Version 2.x messaging in the PES segment. |
| 0236 | Event Reported To | description | HL7-defined table of codes used to identify the type of entity to which the event has been reported. | HL7-defined code system of concepts used to identify the type of entity to which the even has been reported.  Used in HL7 Version 2.x messaging in the PES segment. | HL7-defined code system of concepts used to identify the type of entity to which the even has been reported.  Used in HL7 Version 2.x messaging in the PES segment. |
| 0237 | Event Qualification | description | HL7-defined table of codes used to qualify an event related to a product experience. | HL7-defined code system of concepts used to qualify an event related to a product experience.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used to qualify an event related to a product experience.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0238 | Event Seriousness | description | HL7-defined table of codes used by a sender to designate an event as serious or significant. | HL7-defined code system of concepts used by a sender to designate an event as serious or significant.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used by a sender to designate an event as serious or significant.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0239 | Event Expected | description | HL7-defined table of codes used to communicate whether an event has been judged to be expected or unexpected. | HL7-defined code system of concepts used to communicate whether an event has been judged to be expected or unexpected.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used to communicate whether an event has been judged to be expected or unexpected.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0240 | Event Consequence | description | HL7-defined table of codes used to describe the impact of an event on a patient. | HL7-defined code system of concepts used to describe the impact of an event on a patient.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used to describe the impact of an event on a patient.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0241 | Patient Outcome | description | HL7-defined table of codes used to describe the overall state of a patient as a result of patient care. | HL7-defined code system of concepts used to describe the overall state of a patient as a result of patient care.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used to describe the overall state of a patient as a result of patient care.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0242 | Primary Observer's Qualification | description | HL7-defined table of codes used to provide a general description of the kind of health care professional who provided the primary observation. | HL7-defined code system of concepts used to provide a general description of the kind of health care professional who provided the primary observation.  Used in HL7 Version 2.x messaging in the PEO and PCR segments. | HL7-defined code system of concepts used to provide a general description of the kind of health care professional who provided the primary observation.  Used in HL7 Version 2.x messaging in the PEO and PCR segments. |
| 0243 | Identity May Be Divulged | description | HL7-defined table of codes used to define whether the primary observer has given permission for their identification information to be provided to a product manufacturer. | HL7-defined code system of concepts used to define whether the primary observer has given permission for their identification information to be provided to a product manufacturer.  Used in HL7 Version 2.x messaging in the PEO segment. | HL7-defined code system of concepts used to define whether the primary observer has given permission for their identification information to be provided to a product manufacturer.  Used in HL7 Version 2.x messaging in the PEO segment. |
| 0247 | Status of Evaluation | description | HL7-defined table of codes that describes the status of product evaluation. | HL7-defined code system of concepts that describes the status of product evaluation.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts that describes the status of product evaluation.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0248 | Product Source | description | HL7-defined table of codes used to describe the evaluation state of a product identified in an incident. | HL7-defined code system of concepts used to describe the evaluation state of a product identified in an incident.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts used to describe the evaluation state of a product identified in an incident.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0250 | Relatedness Assessment | description | HL7-defined table of codes used to provide an estimate of whether an issue with a  product was the cause of an event. | HL7-defined code system of concepts used to provide an estimate of whether an issue with a  product was the cause of an event.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts used to provide an estimate of whether an issue with a  product was the cause of an event.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0251 | Action Taken in Response to the Event | description | HL7-defined table of codes used to define the action taken as a result of an event related to a product issue. | HL7-defined code system of concepts used to define the action taken as a result of an event related to a product issue.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts used to define the action taken as a result of an event related to a product issue.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0252 | Causality Observations | description | HL7-defined table of codes used to record event observations regarding what may have caused a product related event. | HL7-defined code system of concepts used to record event observations regarding what may have caused a product related event.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts used to record event observations regarding what may have caused a product related event.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0253 | Indirect Exposure Mechanism | description | HL7-defined table of codes used to identify the mechanism of product transmission when the product has not been directly applied to the patient. | HL7-defined code system of concepts used to identify the mechanism of product transmission when the product has not been directly applied to the patient.  Used in HL7 Version 2.x messaging in the PCR segment. | HL7-defined code system of concepts used to identify the mechanism of product transmission when the product has not been directly applied to the patient.  Used in HL7 Version 2.x messaging in the PCR segment. |
| 0254 | Kind of Quantity | description | HL7-defined table of codes that describe the underlying kind of property represented by an observation.  The categories distinguish concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so forth.  These are discussed more fully in the LOINC Users' Manual.   They are derived from the approach described in 1995 edition of the IUPAC Silver Book.  These distinctions are used in IUPAC and LOINC standard codes.  The distinctions of true quantities in this table are based primarily on dimensional analyses. The table contains a number of "families," those related to simple counts (number, number concentration, etc.), to mass (mass, mass concentration, etc.), to enzyme activity (catalytic content, catalytic concentration, etc.), and molar or equivalents (substance content, substance concentration). | HL7 published code system of concepts that describe categories of an underlying kind of property represented by an observation.  These are intended to distinguish concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so forth.  These are discussed more fully in the LOINC Users’ Manual.   These defined categories are derived from the approach described in 1995 edition of the IUPAC Silver Book.  These distinctions are used in IUPAC and LOINC standard codes.  Needs review by OO and HTA to determined if this is a value set built on LOINC part codes or some other external vocabulary. | HL7 published code system of concepts that describe categories of an underlying kind of property represented by an observation.  These are intended to distinguish concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so forth.  These are discussed more fully in the LOINC Users’ Manual.   These defined categories are derived from the approach described in 1995 edition of the IUPAC Silver Book.  These distinctions are used in IUPAC and LOINC standard codes.  Needs review by OO and HTA to determined if this is a value set built on LOINC part codes or some other external vocabulary. |
| 0255 | Duration Categories | description | Table of codes used to classify an observation definition as intended to measure a patient's state at a point in time. | Code system of concepts used to classify an observation definition as intended to measure a patient's state at a point in time.  Used in HL7 Version 2.x messaging in the OM1 segment. | Code system of concepts used to classify an observation definition as intended to measure a patient's state at a point in time.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0256 | Time Delay Post Challenge | description | HL7-defined table of codes used to classify an observation definition as being a component of a challenge test. | HL7-defined code system of concepts used to classify an observation definition as being a component of a challenge test.  Used in HL7 Version 2.x messaging in the OM1 segment. | HL7-defined code system of concepts used to classify an observation definition as being a component of a challenge test.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0257 | Nature of Challenge | description | HL7-defined table of codes used to further describe an observation definition that is characterized as a challenge observation. | HL7-defined code system of concepts used to further describe an observation definition that is characterized as a challenge observation.  Used in HL7 Version 2.x messaging in the OM1 segment. | HL7-defined code system of concepts used to further describe an observation definition that is characterized as a challenge observation.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0258 | Relationship Modifier | description | HL7-defined table of codes used in an observation definition to describe the subject of an observation in relation to a patient. | HL7-defined code system of concepts used in an observation definition to describe the subject of an observation in relation to a patient.  Used in HL7 Version 2.x messaging in the OM1 segment. | HL7-defined code system of concepts used in an observation definition to describe the subject of an observation in relation to a patient.  Used in HL7 Version 2.x messaging in the OM1 segment. |
| 0260 | Patient Location Type | description | Table of codes used to identify the kind of location described in the location definition. | Code system of concepts used to identify the kind of location described in the location definition.  Used in HL7 Version 2.x messaging in the LOC segment. | Code system of concepts used to identify the kind of location described in the location definition.  Used in HL7 Version 2.x messaging in the LOC segment. |
| 0261 | Location Equipment | description | Table of codes used to identify the equipment available in a location definition identified as a room or bed. | Code system of concepts used to identify the equipment available in a location definition identified as a room or bed.  Used in HL7 Version 2.x messaging in the LOC segment. | Code system of concepts used to identify the equipment available in a location definition identified as a room or bed.  Used in HL7 Version 2.x messaging in the LOC segment. |
| 0262 | Privacy Level | description | Table of codes used to identify the level of privacy a patient will be afforded when assigned to this location definition. | Code system of concepts used to identify the level of privacy a patient will be afforded when assigned to this location definition.  Used in HL7 Version 2.x messaging in the LCH segment. | Code system of concepts used to identify the level of privacy a patient will be afforded when assigned to this location definition.  Used in HL7 Version 2.x messaging in the LCH segment. |
| 0263 | Level of Care | description | Table of codes used to identify the level of care a patient may be afforded when assigned to this location definition. | Code system of concepts used to identify the level of care a patient may be afforded when assigned to this location definition.  Used in HL7 Version 2.x messaging in the LCH segment. | Code system of concepts used to identify the level of care a patient may be afforded when assigned to this location definition.  Used in HL7 Version 2.x messaging in the LCH segment. |
| 0265 | Specialty Type | description | Table of codes used to identify the specialty of the care professional who is supported when using this location definition. | Code system of concepts used to identify the specialty of the care professional who is supported when using this location definition.  Used in HL7 Version 2.x messaging in the LDP segment. | Code system of concepts used to identify the specialty of the care professional who is supported when using this location definition.  Used in HL7 Version 2.x messaging in the LDP segment. |
| 0267 | Days of the Week | description | HL7-defined table of codes used to identify the day(s) of the week when a location may be scheduled for appointments. | HL7-defined code system of concepts used to identify the day(s) of the week when a location may be scheduled for appointments.  Used in HL7 Version 2.x messaging in the UVC and LDP segments. | HL7-defined code system of concepts used to identify the day(s) of the week when a location may be scheduled for appointments.  Used in HL7 Version 2.x messaging in the UVC and LDP segments. |
| 0268 | Override | description | Table of codes used to define whether a Charge Description Master description may be overridden or if it must be overridden. | Code system of concepts used to define whether a Charge Description Master description may be overridden or if it must be overridden.  Used in HL7 Version 2.x messaging in the CDM and PRC segments. | Code system of concepts used to define whether a Charge Description Master description may be overridden or if it must be overridden.  Used in HL7 Version 2.x messaging in the CDM and PRC segments. |
| 0269 | Charge On Indicator | description | Table of codes used to define the event upon which a charge should be generated. | Code system of concepts used to define the event upon which a charge should be generated.  Used in HL7 Version 2.x messaging in the PRC segment. | Code system of concepts used to define the event upon which a charge should be generated.  Used in HL7 Version 2.x messaging in the PRC segment. |
| 0270 | Document Type | description | Table of codes used to identify the kind of patient document. | Code system of concepts used to identify the kind of patient document.  Used in HL7 Version 2.x messaging in the TXA segment. | Code system of concepts used to identify the kind of patient document.  Used in HL7 Version 2.x messaging in the TXA segment. |
| 0271 | Document Completion Status | description | HL7-defined table of codes used to record the state of a document in a workflow. | HL7-defined code system of concepts used to record the state of a document in a workflow.  Used in HL7 Version 2.x messaging in the TXA segment. | HL7-defined code system of concepts used to record the state of a document in a workflow.  Used in HL7 Version 2.x messaging in the TXA segment. |
| 0272 | Document Confidentiality Status | description | HL7-defined table of codes that specify the degree to which special confidentiality protection should be applied to  information.  The assignment of data elements to these categories is left to the discretion of the healthcare organization. | HL7-defined code system of concetps used to identify the degree to which special confidentiality protection should be applied to this information.  Used in HL7 Version 2.x messaging in the TXA segment. | HL7-defined code system of concetps used to identify the degree to which special confidentiality protection should be applied to this information.  Used in HL7 Version 2.x messaging in the TXA segment. |
| 0273 | Document Availability Status | description | HL7-defined table of codes used to define whether a patient document is appropriate or available for use in patient care. | HL7-defined code system of concepts used to define whether a patient document is appropriate or available for use in patient care.  Used in HL7 Version 2.x messaging in the TXA segment. | HL7-defined code system of concepts used to define whether a patient document is appropriate or available for use in patient care.  Used in HL7 Version 2.x messaging in the TXA segment. |
| 0275 | Document Storage Status | description | HL7-defined table of codes used to describe the availability of a document in relation to the type of storage. | HL7-defined code system of concepts used to describe the availability of a document in relation to the type of storage.  Used in HL7 Version 2.x messaging in the TXA segment. | HL7-defined code system of concepts used to describe the availability of a document in relation to the type of storage.  Used in HL7 Version 2.x messaging in the TXA segment. |
| 0276 | Appointment reason codes | description | Table of codes used to describe the kind of appointment or the reason why an appointment has been scheduled. | Code system of concepts used to describe the kind of appointment or the reason why an appointment has been scheduled.  Used in HL7 Version 2.x messaging in the ARQ segment. | Code system of concepts used to describe the kind of appointment or the reason why an appointment has been scheduled.  Used in HL7 Version 2.x messaging in the ARQ segment. |
| 0277 | Appointment Type Codes | description | Table of codes used in an appointment request to describe the kind of appointment. | Code system of concepts used in an appointment request to describe the kind of appointment.  Used in HL7 Version 2.x messaging in the ARQ segment. | Code system of concepts used in an appointment request to describe the kind of appointment.  Used in HL7 Version 2.x messaging in the ARQ segment. |
| 0278 | Filler status codes | description | Table of codes used to describe an appointment status from the perspective of the entity assigned to fulfill the appointment. | Code system of concepts used to describe an appointment status from the perspective of the entity assigned to fulfill the appointment.  Used in HL7 Version 2.x messaging in the SCH segment. | Code system of concepts used to describe an appointment status from the perspective of the entity assigned to fulfill the appointment.  Used in HL7 Version 2.x messaging in the SCH segment. |
| 0279 | Allow Substitution Codes | description | Table of codes used to indicate whether the appointment resource may be substituted for another by the entity assigned to fulfill the appointment. | Code system of concepts used to indicate whether the appointment resource may be substituted for another by the entity assigned to fulfill the appointment.  Used in HL7 Version 2.x messaging in the AIS and AIG segments. | Code system of concepts used to indicate whether the appointment resource may be substituted for another by the entity assigned to fulfill the appointment.  Used in HL7 Version 2.x messaging in the AIS and AIG segments. |
| 0280 | Referral Priority | description | Table of codes used to designate the urgency of a  referral. | Code system of concepts used to designate the urgency of a  referral.  Used in HL7 Version 2.x messaging in the RF1 segment. | Code system of concepts used to designate the urgency of a  referral.  Used in HL7 Version 2.x messaging in the RF1 segment. |
| 0281 | Referral Type | description | Table of codes used to identify the general category of healthcare professional desired to satisfy a referral. | Code system of concepts used to identify the general category of healthcare professional desired to satisfy a referral.  Used in HL7 Version 2.x messaging in the RF1 segment. | Code system of concepts used to identify the general category of healthcare professional desired to satisfy a referral.  Used in HL7 Version 2.x messaging in the RF1 segment. |
| 0282 | Referral Disposition | description | Table of codes used to identify the expected response from the healthcare professional receiving a referral. | Code system of concepts used to identify the expected response from the healthcare professional receiving a referral.  Used in HL7 Version 2.x messaging in the RF1 segment. | Code system of concepts used to identify the expected response from the healthcare professional receiving a referral.  Used in HL7 Version 2.x messaging in the RF1 segment. |
| 0283 | Referral Status | description | Table of codes used to define the state of a  referral. | Code system of concepts used to define the state of a  referral.  Used in HL7 Version 2.x messaging in the RF1 segment. | Code system of concepts used to define the state of a  referral.  Used in HL7 Version 2.x messaging in the RF1 segment. |
| 0284 | Referral Category | description | Table of codes used to describe the patient care setting where a referral should take place. | Code system of concepts used to describe the patient care setting where a referral should take place.  Used in HL7 Version 2.x messaging in the RF1 segment. | Code system of concepts used to describe the patient care setting where a referral should take place.  Used in HL7 Version 2.x messaging in the RF1 segment. |
| 0286 | Provider Role | description | Table of codes used to define the relationship between a referral recipient and a patient or between a referral initiator and a patient. |  | Code system of concepts used to define the relationship between a referral recipient and a patient or between a referral initiator and a patient.  Used in HL7 Version 2.x messaging in the PRD segment. |
| 0287 | Problem/Goal Action Code | symbolicName | problem-goalAction | Problem-goalAction | ProblemGoalAction |
| 0287 | Problem/Goal Action Code | description | HL7-defined table of codes used in Patient Care for the intent of a problem or goal. | HL7-defined code system of concepts used in Patient Care for the intent of a problem or goal.  Used in HL7 Version 2.x messaging in the GOL, ROL, PRB and PTH segments. | HL7-defined code system of concepts used in Patient Care for the intent of a problem or goal.  Used in HL7 Version 2.x messaging in the GOL, ROL, PRB and PTH segments. |
| 0291 | Subtype of Referenced Data | description | Table of codes specifying a subset of the media subtypes of binary data that are encoded in an ascii structure or stream. | Code system of a subset of the media subtypes of binary data that are encoded in an ascii structure or stream.  Used in Version 2 messaging  ED and RP datatypes, but only in standard 2.5.1 and earlier; after that, it was recommended that the IANA media types be used instead of this short list of HL7-defined codes.   More information on the standard media types and subtypes may be found at http://www.iana.org/assignments/media-types/media-types.xhtml. | Code system of a subset of the media subtypes of binary data that are encoded in an ascii structure or stream.  Used in Version 2 messaging  ED and RP datatypes, but only in standard 2.5.1 and earlier; after that, it was recommended that the IANA media types be used instead of this short list of HL7-defined codes.   More information on the standard media types and subtypes may be found at http://www.iana.org/assignments/media-types/media-types.xhtml. |
| 0294 | Time Selection Criteria Parameter Class Codes | description | Table of codes used to describe acceptable start and end times, as well as days of the week, for appointment or resource scheduling. | Code system of concepts used to describe acceptable start and end times, as well as days of the week, for appointment or resource scheduling.  Used in HL7 Version 2.x messaging in the SCV and APR segments. | Code system of concepts used to describe acceptable start and end times, as well as days of the week, for appointment or resource scheduling.  Used in HL7 Version 2.x messaging in the SCV and APR segments. |
| 0298 | CP Range Type | description | HL7-defined table of codes that specify whether a composite price range is experssed as a flat rate or a percentage. | HL7-defined code system of concepts used to define a type of range used in composite pricing in financial transacxtions.  Used in HL7 Version 2 messaging in the CP datatype. | HL7-defined code system of concepts used to define a type of range used in composite pricing in financial transacxtions.  Used in HL7 Version 2 messaging in the CP datatype. |
| 0299 | Encoding | description | HL7-defined table of codes identifying the type of encoding used to represent successive octets of binary data as displayable ASCII characters.  These are defined by IETF; more information may be found at https://www.ietf.org/rfc/rfc1521.txt | HL7-defined code system of concept identifying the type of encoding used to represent successive octets of binary data as displayable ASCII characters.  These are defined by IETF; more information may be found at https://www.ietf.org/rfc/rfc1521.txt.  Used in HL7 Version 2.x messaging in the ED datatypes. | HL7-defined code system of concept identifying the type of encoding used to represent successive octets of binary data as displayable ASCII characters.  These are defined by IETF; more information may be found at https://www.ietf.org/rfc/rfc1521.txt.  Used in HL7 Version 2.x messaging in the ED datatypes. |
| 0301 | Universal ID Type | description | HL7-defined table of codes specifying the type of UID (Universal Identifier).  Open Issue:  Table 0301 has a mix of class and instance identifiers for namespaces, which is improper.  The values for instances. such as CLIA, CLIP, CAP, and NPI. These were added for pragmatic issues related to older datatypes that were universally bound tand should not be here but are needed for implementation pragmatics.   These should be annotated in Comment or Usage Notes that these are not universal ID types really. | HL7-defined code system of types of UID (Universal Identifiers).   Used in HL7 Version 2.x messaging HD and EI datatypes. | HL7-defined code system of types of UID (Universal Identifiers).   Used in HL7 Version 2.x messaging HD and EI datatypes. |
| 0305 | Person Location Type | description | Table of codes specifying the categorization of the person's location. | Code system of concepts specifying the categorization of the person's location.  Used in HL7 Version 2.x messaging datatypes that contain location identifiers such as Person Location (PL), Location with address variation (LA) and Name with date and location (NDL). | Code system of concepts specifying the categorization of the person's location.  Used in HL7 Version 2.x messaging datatypes that contain location identifiers such as Person Location (PL), Location with address variation (LA) and Name with date and location (NDL). |
| 0309 | Coverage Type | description | Table of codes specifying the type of insurance coverage or what types of services are covered for the purposes of a billing system.  For example, a physician billing system will only want to receive insurance information for plans that cover physician/professional charges. | Code system of concepts specifying the type of insurance coverage or what types of services are covered for the purposes of a billing system.  For example, a physician billing system will only want to receive insurance information for plans that cover physician/professional charges.  Used in HL7 Version 2.x messaging in the Insurance (IN1) segment. | Code system of concepts specifying the type of insurance coverage or what types of services are covered for the purposes of a billing system.  For example, a physician billing system will only want to receive insurance information for plans that cover physician/professional charges.  Used in HL7 Version 2.x messaging in the Insurance (IN1) segment. |
| 0311 | Job Status | description | Table of codes specifying a next of kin/associated party's job status. | HL7-defined code system of concepts specifying the next of kin/associated party's job status.  Used in HL7 Version 2.x messaging in the Next of Kin/Associated Parties (NK1) segment. | HL7-defined code system of concepts specifying the next of kin/associated party's job status.  Used in HL7 Version 2.x messaging in the Next of Kin/Associated Parties (NK1) segment. |
| 0315 | Living Will Code | description | Table of codes specifying whether or not the patient has a living will and, if so, whether a copy fo the living will is on file at the healthcare facility.  If the patient does not have a living will, the value of this field indicates whether the patient was provided information on living wills. | Code system of concepts specifying whether or not the patient has a living will and, if so, whether a copy fo the living will is on file at the healthcare facility.  If the patient does not have a living will, the value of this field indicates whether the patient was provided information on living wills.  Used in HL7 Version 2.x messaging in the Patient Visit - Additional Information ( PV2) and Patient Additional Demographic (PD1) segments. | Code system of concepts specifying whether or not the patient has a living will and, if so, whether a copy fo the living will is on file at the healthcare facility.  If the patient does not have a living will, the value of this field indicates whether the patient was provided information on living wills.  Used in HL7 Version 2.x messaging in the Patient Visit - Additional Information ( PV2) and Patient Additional Demographic (PD1) segments. |
| 0316 | Organ Donor Code | description | Table of codes specifying whether the patient wants to donate his/her organs and whether an organ donor card or similar documentation is on file with the healthcare organization. | Code system of concepts specifying whether the patient wants to donate his/her organs and whether an organ donor card or similar documentation is on file with the healthcare organization.   Used in HL7 Version 2.x messaging in the Patient Visit - Additional Information ( PV2) and Patient Additional Demographic (PD1) segments. | Code system of concepts specifying whether the patient wants to donate his/her organs and whether an organ donor card or similar documentation is on file with the healthcare organization.   Used in HL7 Version 2.x messaging in the Patient Visit - Additional Information ( PV2) and Patient Additional Demographic (PD1) segments. |
| 0317 | Annotations | description | Table of codes specifying the coded entry associated with a given point in time during the waveform recording.  Note codes beyond 9903 may exist; extensions to this table may be done by incrementing the code value. | Code system of concepts specifying the coded entry associated with a given point in time during the waveform recording.  Used in HL7 Version 2.x messaging in the Observation Result (OBX) Another Observation (ANO) segments. | Code system of concepts specifying the coded entry associated with a given point in time during the waveform recording.  Used in HL7 Version 2.x messaging in the Observation Result (OBX) Another Observation (ANO) segments. |
| 0321 | Dispense Method | description | HL7-defined table of codes specifying the method by which treatment is dispensed. | HL7-definde code system of concepts specifying the method by which treatment is dispensed.  Used in HL7 Version 2.x messaging in the Pharmacy/Treatment Encoded order (RXE) and Pharmacy/Treatment dispense (RXD) segments. | HL7-definde code system of concepts specifying the method by which treatment is dispensed.  Used in HL7 Version 2.x messaging in the Pharmacy/Treatment Encoded order (RXE) and Pharmacy/Treatment dispense (RXD) segments. |
| 0322 | Completion Status | description | HL7-defined table of codes specifying the status of the treatment administration event. | HL7-defined code system of concepts specifying the status of the treatment administration event segment.  Used in HL7 Version 2.x messaging in the Pharmacy Order Administration (RXA) segment. | HL7-defined code system of concepts specifying the status of the treatment administration event segment.  Used in HL7 Version 2.x messaging in the Pharmacy Order Administration (RXA) segment. |
| 0324 | Location Characteristic ID | description | Table of codes specifying an identifier code to show which characteristic is being communicated with the segment. | Code system of concepts specifying an identifier code to show which characteristic is being communicated with the segment.  Used in HL7 Version 2.x messaging in the Location Characteristic (LCH) segment. | Code system of concepts specifying an identifier code to show which characteristic is being communicated with the segment.  Used in HL7 Version 2.x messaging in the Location Characteristic (LCH) segment. |
| 0325 | Location Relationship ID | description | Table of codes specifying an identifier code to show which relationship is being communicated with the segment. | Code system of concepts specifying an identifier code to show which relationship is being communicated with the segment.  Used in HL7 Version 2.x messaging in the Location Relationship (LRL) segment. | Code system of concepts specifying an identifier code to show which relationship is being communicated with the segment.  Used in HL7 Version 2.x messaging in the Location Relationship (LRL) segment. |
| 0326 | Visit Indicator | description | Table of codes specifying the level on which data are being sent.  It is the indicator used to send data at two levels, visit and account.  HL7 recommends sending an "A" or no value when the data in the message are at the account level or "V" to indicate that the data sent in the message are at the visit level. | Code system of concepts specifying the level on which data are being sent.  It is the indicator used to send data at two levels, visit and account.  HL7 recommends sending an "A" or no value when the data in the message are at the account level or "V" to indicate that the data sent in the message are at the visit level.  Used in HL7 Version 2.x messaging in the Patient Visit (PV1) segment. | Code system of concepts specifying the level on which data are being sent.  It is the indicator used to send data at two levels, visit and account.  HL7 recommends sending an "A" or no value when the data in the message are at the account level or "V" to indicate that the data sent in the message are at the visit level.  Used in HL7 Version 2.x messaging in the Patient Visit (PV1) segment. |
| 0329 | Quantity Method | description | HL7-defined table of codes used to specify the method by which the quantity distributed is measured. | HL7-defined code system of concepts used to specify the method by which the quantity distributed is measured.   Used in HL7 Version 2.x messaging in the Product Summary Header (PSH) segment. | HL7-defined code system of concepts used to specify the method by which the quantity distributed is measured.   Used in HL7 Version 2.x messaging in the Product Summary Header (PSH) segment. |
| 0330 | Marketing Basis | description | HL7-defined table of codes used to specify the basis for marketing approval. | HL7-defined code system of concepts used to specify the basis for marketing approval.   Used in HL7 Version 2.x messaging in the Product Detail Country (PDC) segment. | HL7-defined code system of concepts used to specify the basis for marketing approval.   Used in HL7 Version 2.x messaging in the Product Detail Country (PDC) segment. |
| 0331 | Facility Type | description | HL7-defined table of codes used to specify the type of facility. | HL7-defined code system of concepts used to specify the type of facility.   Used in HL7 Version 2.x messaging in the Facility (FAC) segment. | HL7-defined code system of concepts used to specify the type of facility.   Used in HL7 Version 2.x messaging in the Facility (FAC) segment. |
| 0332 | Source Type | description | HL7-defined table of codes used to indicate (in certain systems) whether a lower level source identifier is an initiate or accept type. | HL7-defined code system of concepts used to specify the type of facility.   Used in HL7 Version 2.x messaging in the Facility (FAC) segment. | HL7-defined code system of concepts used to specify the type of facility.   Used in HL7 Version 2.x messaging in the Facility (FAC) segment. |
| 0334 | Disabled Person Code | description | Table of codes used to specify to which person the disability information relates in the message.  For example, if the value is PT, the disability information relates to the patient. | Code system of concepts used to specify to which person the disability information relates in the message.  For example, if the value is PT, the disability information relates to the patient.  Used in HL7 Version 2.x messaging in the Disability (DB1) segment. | Code system of concepts used to specify to which person the disability information relates in the message.  For example, if the value is PT, the disability information relates to the patient.  Used in HL7 Version 2.x messaging in the Disability (DB1) segment. |
| 0335 | Repeat Pattern | description | Table of codes used to specify the interval between repeated services. See the Comment/Usage Note in the table below, as the table contains both precoordinated codes that may be used in an HL7 field or component and also explanatory patterns illustrating the syntax used to construct expressions using the codes and other modifiers. | Code system of concepts used to specify the interval between repeated services.  Used in HL7 Version 2.x messaging in the RI datatype and RPT segment. | Code system of concepts used to specify the interval between repeated services.  Used in HL7 Version 2.x messaging in the RI datatype and RPT segment. |
| 0336 | Referral Reason | description | Table of codes used to specify the reason for which the referral will take place. | Code system of concepts used to specify the reason for which the referral will take place.  Used in HL7 Version 2.x messaging in the Referral Information (RF1) segment. | Code system of concepts used to specify the reason for which the referral will take place.  Used in HL7 Version 2.x messaging in the Referral Information (RF1) segment. |
| 0337 | Certification Status | description | HL7-defined table of codes used to specify the status of the practitioner's speciality certification. | HL7-defined code system of concepts used to specify the status of the practitioner's speciality certification.  Used in HL7 Version 2.x messaging in the Specialty Description (SPD) value and Practitioner Detail (PRA) segment. | HL7-defined code system of concepts used to specify the status of the practitioner's speciality certification.  Used in HL7 Version 2.x messaging in the Specialty Description (SPD) value and Practitioner Detail (PRA) segment. |
| 0338 | Practitioner ID Number Type | description | Table of codes specifying the type of number used for the practitioner identification. | HL7-defined code system of concepts specifying type of identifier. Used in HL7 Version 2.x messaging data types CX, PLN, PPN, XCN and XON. |  |
| 0339 | Advanced Beneficiary Notice Code | description | Table of codes specifying the status of the patient's or the patient's representative's consent for responsibility to pay for potentially uninsured services. This element was introduced to satisfy CMS Medical Necessity requirements for outpatient services in the United States. Includes concepts such as (a) whether the associated diagnosis codes for the service are subject to medical necessity procedures, (b) whether, for this type of service, the patient has been informed that they may be responsible for payment for the service, and (c) whether the patient agrees to be billed for this service. | Code system of concepts specifying the status of the patient's or the patient's representative's consent for responsibility to pay for potentially uninsured services. This element was introduced to satisfy CMS Medical Necessity requirements for outpatient services in the United States. Includes concepts such as (a) whether the associated diagnosis codes for the service are subject to medical necessity procedures, (b) whether, for this type of service, the patient has been informed that they may be responsible for payment for the service, and (c) whether the patient agrees to be billed for this service.  Used in HL7 Version 2.x messaging in the ORC and FT1 segments. | Code system of concepts specifying the status of the patient's or the patient's representative's consent for responsibility to pay for potentially uninsured services. This element was introduced to satisfy CMS Medical Necessity requirements for outpatient services in the United States. Includes concepts such as (a) whether the associated diagnosis codes for the service are subject to medical necessity procedures, (b) whether, for this type of service, the patient has been informed that they may be responsible for payment for the service, and (c) whether the patient agrees to be billed for this service.  Used in HL7 Version 2.x messaging in the ORC and FT1 segments. |
| 0344 | Patient's Relationship to Insured | description | Table of codes used to specify the relationship of the patient to the insured, as defined by CMS or other regulatory agencies. | Code system of concepts used to specify the relationship of the patient to the insured, as defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the Insurance Additional Information (IN2) segment. | Code system of concepts used to specify the relationship of the patient to the insured, as defined by CMS or other regulatory agencies.  Used in HL7 Version 2.x messaging in the Insurance Additional Information (IN2) segment. |
| 0353 | CWE statuses | description | HL7-defined table of codes that represent an exception identifier code; that is, a code that is not defined in the value set (either model or site-extended).  These are occationsally referred to a 'flavors of null' although this set of concepts is specific to the CWE datatype used in Version 2 messaging, and the codes may be used in the 'identifier' component of the 'triplets' in that datatype. | HL7-defined code system of comcepts that represent an exception identifier code; that is, a code that is not defined in the value set (either model or site-extended).  These are occationsally referred to a 'flavors of null' although this set of concepts is specific to the CWE datatype used in HL7 Version 2.x messaging, and the codes may be used in the 'identifier' component of the 'triplets' in that datatype. | HL7-defined code system of comcepts that represent an exception identifier code; that is, a code that is not defined in the value set (either model or site-extended).  These are occationsally referred to a 'flavors of null' although this set of concepts is specific to the CWE datatype used in HL7 Version 2.x messaging, and the codes may be used in the 'identifier' component of the 'triplets' in that datatype. |
| 0354 | Message Structure | description | HL7-defined table of abstract message structure codes. Each code identifies a specific message structure abstract syntax as published in the HL7 Version 2 standard. | HL7-defined code system of abstract message structure codes. Each code identifies a specific message structure abstract syntax as published in the HL7 Version 2 standard.  Used in HL7 Version 2.x messaging in the MSH segment. | HL7-defined code system of abstract message structure codes. Each code identifies a specific message structure abstract syntax as published in the HL7 Version 2 standard.  Used in HL7 Version 2.x messaging in the MSH segment. |
| 0355 | Primary Key Value Type | description | HL7-defined table of codes used to specify the type for the master file record identifier. | HL7-defined code system of concepts used to specify the type for the master file record identifier.  Used in HL7 Version 2.x messaging in the Master File Entry (MFE) segment. | HL7-defined code system of concepts used to specify the type for the master file record identifier.  Used in HL7 Version 2.x messaging in the Master File Entry (MFE) segment. |
| 0356 | Alternate Character Set Handling Scheme | description | HL7-defined table of codes that specify the scheme used when any alternative character sets are specified in the second or later iterations of MSH-18 Character Set, and if any special handling scheme is needed. | HL7-defined code system of concept that specify the scheme used when any alternative character sets are specified in the second or later iterations of MSH-18 Character Set, and if any special handling scheme is needed.  Used in HL7 Version 2.x messaging in the MSH segment. | HL7-defined code system of concept that specify the scheme used when any alternative character sets are specified in the second or later iterations of MSH-18 Character Set, and if any special handling scheme is needed.  Used in HL7 Version 2.x messaging in the MSH segment. |
| 0357 | Message Error Condition Codes | description | HL7-defined table of codes specifying the HL7 (communications) error code. | HL7-defined code system of concepts specifying the HL7 (communications) error code.  Used in the ERR segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts specifying the HL7 (communications) error code.  Used in the ERR segment in HL7 Version 2.x messaging. |
| 0359 | Diagnosis Priority | description | Table of codes that identify the significance or priority of the diagnosis code.  Note that the codes are numeric, and the number of the code represents the ordinal priority of the associated diagnosis. The predefined codes are the most common, and just a starter set, as the codes are an unbounded list; additional ranked procedures may be signified by incrementing the code value as needed. | Code system of concepts that identify the significance or priority of the diagnosis code.  Note that the codes are numeric, and the number of the code represents the ordinal priority of the associated diagnosis.  Used in the DG1 segment in HL7 Version 2.x messaging. The predefined codes are the most common, and just a starter set, as the codes are an unbounded list; additional ranked procedures may be signified by incrementing the code value as needed. | Code system of concepts that identify the significance or priority of the diagnosis code.  Note that the codes are numeric, and the number of the code represents the ordinal priority of the associated diagnosis.  Used in the DG1 segment in HL7 Version 2.x messaging. The predefined codes are the most common, and just a starter set, as the codes are an unbounded list; additional ranked procedures may be signified by incrementing the code value as needed. |
| 0360 | Degree/License/Certificate | description | Table of codes specifying an educational degree (e.g., MD).  Used in the CNN datatype (names and identifiers of clinicians) in Version 2 messaging. | Code system of concepts specifying an educational degree (e.g., MD).  Used in the CNN datatype (names and identifiers of clinicians) in Version 2 messaging.  Used in HL7 Version 2.x messaging in the CNN segment; note that in releases of HL7 prior to 2.3.1, was also used in person names (XPN), but this use was deprecated, then withdrawn in 2.7. | Code system of concepts specifying an educational degree (e.g., MD).  Used in the CNN datatype (names and identifiers of clinicians) in Version 2 messaging.  Used in HL7 Version 2.x messaging in the CNN segment; note that in releases of HL7 prior to 2.3.1, was also used in person names (XPN), but this use was deprecated, then withdrawn in 2.7. |
| 0364 | Comment Type | description | Table of codes that identify the type of comment text being sent in the specific comment record. | Code system of concepts that identify the type of comment text being sent in the specific comment record.  Used in the Notes and Comments (NTE) segment in HL7 Version 2.x messaging. | Code system of concepts that identify the type of comment text being sent in the specific comment record.  Used in the Notes and Comments (NTE) segment in HL7 Version 2.x messaging. |
| 0365 | Equipment State | description | HL7-defined table of codes that identify the status the equipment was in at the time the transaction was initiated. | HL7-defined code system of concepts that identify the status the equipment was in at the time the transaction was initiated.  Used in HL7 Version 2.x messaging in the EQU segment. | HL7-defined code system of concepts that identify the status the equipment was in at the time the transaction was initiated.  Used in HL7 Version 2.x messaging in the EQU segment. |
| 0366 | Local/Remote Control State | symbolicName | local-remoteControlState | Local-remoteControlState | LocalRemoteControlState |
| 0366 | Local/Remote Control State | description | HL7-defined table of codes that identify the current state of control associated with the equipment.   Equipment can either work autonomously ('Local' control state) or it can be controlled by another system, e.g., LAS computer ('Remote' control state). | HL7-defined code system of concepts that identify the current state of control associated with the equipment.   Equipment can either work autonomously ('Local' control state) or it can be controlled by another system, e.g., LAS computer ('Remote' control state).  Used in the Equipment Detail (EQU) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts that identify the current state of control associated with the equipment.   Equipment can either work autonomously ('Local' control state) or it can be controlled by another system, e.g., LAS computer ('Remote' control state).  Used in the Equipment Detail (EQU) segment in HL7 Version 2.x messaging. |
| 0367 | Alert Level | description | HL7-defined table of codes that identify the highest level of the alert state (e.g.,highest alert severity) that is associated with the indicated equipment (e.g. processing event, inventory event, QC event). | HL7-defined code system of concepts that identify the highest level of the alert state (e.g.,highest alert severity) that is associated with the indicated equipment (e.g. processing event, inventory event, QC event).  Used in the Equipment Detail (EQU) and Notification Detail (NDS) segments in HL7 Version 2.x messaging. | HL7-defined code system of concepts that identify the highest level of the alert state (e.g.,highest alert severity) that is associated with the indicated equipment (e.g. processing event, inventory event, QC event).  Used in the Equipment Detail (EQU) and Notification Detail (NDS) segments in HL7 Version 2.x messaging. |
| 0368 | Remote Control Command | description | Table of codes that identify the comment the component is to initiate. | Code system of concepts that identify the comment the component is to initiate.  Used in the Equipment Command (ECD) and Interaction Status Detail (ISD) segments in HL7 Version 2.x messaging. | Code system of concepts that identify the comment the component is to initiate.  Used in the Equipment Command (ECD) and Interaction Status Detail (ISD) segments in HL7 Version 2.x messaging. |
| 0369 | Specimen Role | description | Table of codes that identify the role of a sample. | HL7-defined code system of concepts that identify the role of a sample.  Used in HL7 Version 2.x messaging in the Specimen (SPM) and Observation Request (OBR) segments. | HL7-defined code system of concepts that identify the role of a sample.  Used in HL7 Version 2.x messaging in the Specimen (SPM) and Observation Request (OBR) segments. |
| 0370 | Container Status | description | HL7-defined table of codes that identify the status of the unique container in which the specimen resides at the time the transaction was initiated. | HL7-defined  code system of concepts that identify the status of the unique container in which the specimen resides at the time the transaction was initiated.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. | HL7-defined  code system of concepts that identify the status of the unique container in which the specimen resides at the time the transaction was initiated.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0371 | Additive/Preservative | description | HL7-defined table of codes specifying any additive introduced to the specimen before or at the time of collection.  These additives may be introduced in order to preserve, maintain or enhance the particular nature or component of the specimen. | HL7-defined code system of concepts specifying any additive introduced to the specimen before or at the time of collection.  These additives may be introduced in order to preserve, maintain or enhance the particular nature or component of the specimen.  Used in HL7 Version 2.x messaging in the SPM and SAC segments. | HL7-defined code system of concepts specifying any additive introduced to the specimen before or at the time of collection.  These additives may be introduced in order to preserve, maintain or enhance the particular nature or component of the specimen.  Used in HL7 Version 2.x messaging in the SPM and SAC segments. |
| 0372 | Specimen Component | description | Table of codes that identify the specimen component, e.g., supernatant, sediment, etc. | Code system of concepts that identify the specimen component, e.g., supernatant, sediment, etc.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. | Code system of concepts that identify the specimen component, e.g., supernatant, sediment, etc.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0373 | Treatment | description | Table of codes that identify the specimen treatment performed during lab processing. | Code system of concepts that identify the specimen treatment performed during lab processing.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. | Code system of concepts that identify the specimen treatment performed during lab processing.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0374 | System Induced Contaminants | description | Table of codes that identify the specimen contaminant identifier associated with the specimen in the container. |  | Code system of concepts that identify the specimen contaminant identifier associated with the specimen in the container.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0375 | Artificial Blood | description | Table of codes that identify the artificial blood identifier associated with the specimen. | Code system of concepts that identify the artificial blood identifier associated with the specimen.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. | Code system of concepts that identify the artificial blood identifier associated with the specimen.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0376 | Special Handling Code | description | Table of codes describing how a specimen and/or container needs to be handled from the time of collection through the initiation of testing. | Code system of concepts describing how a specimen and/or container needs to be handled from the time of collection through the initiation of testing.  Used in HL7 Version 2.x messaging in the SPM, SAC, PAC and OM4 segments. | Code system of concepts describing how a specimen and/or container needs to be handled from the time of collection through the initiation of testing.  Used in HL7 Version 2.x messaging in the SPM, SAC, PAC and OM4 segments. |
| 0377 | Other Environmental Factors | description | Table of codes that identify the other environmental factors associated with the specimen in a specific container, e.g., atmospheric exposure. |  | Code system of concepts that identify the other environmental factors associated with the specimen in a specific container, e.g., atmospheric exposure.  Used in the Interaction Specimen Container Detail (SAC) segment in HL7 Version 2.x messaging. |
| 0383 | Substance Status | description | HL7-defined table of codes identifying the status of the inventoried item.  The status indicates the current status of the substance. | HL7-defined code system of concepts identifying the status of the inventoried item.  The status indicates the current status of the substance.  Used in HL7 Version 2.x messaging in the Inventory Detail (INV) segment. | HL7-defined code system of concepts identifying the status of the inventoried item.  The status indicates the current status of the substance.  Used in HL7 Version 2.x messaging in the Inventory Detail (INV) segment. |
| 0384 | Substance Type | description | HL7-defined table of codes identifying the type of substance. | HL7-defined  code system of concepts identifying the type of substance.  Used in HL7 Version 2.x messaging in the Inventory Detail (INV) segment. | HL7-defined  code system of concepts identifying the type of substance.  Used in HL7 Version 2.x messaging in the Inventory Detail (INV) segment. |
| 0387 | Command Response | description | Table of codes identifying the response of the previously issued command. | Code system of concepts identifying the response of the previously issued command.  Used in HL7 Version 2.x messaging in the Equipment Command Response (ECR) and Interaction Status Detail (ISD) segments. | Code system of concepts identifying the response of the previously issued command.  Used in HL7 Version 2.x messaging in the Equipment Command Response (ECR) and Interaction Status Detail (ISD) segments. |
| 0388 | Processing Type | description | HL7-defined table of codes identifying the processing type that applies to the test code.  If this attribute is omitted, then regular production is the default. | HL7-defined code system of concepts identifying the processing type that applies to the test code.  If this attribute is omitted, then regular production is the default.  Used in HL7 Version 2.x messaging in the Test Code Configuration (TCC) segment. | HL7-defined code system of concepts identifying the processing type that applies to the test code.  If this attribute is omitted, then regular production is the default.  Used in HL7 Version 2.x messaging in the Test Code Configuration (TCC) segment. |
| 0389 | Analyte Repeat Status | description | HL7-defined table of codes identifying the repeat status for the analyte/result (e.g. original, rerun, repeat, reflex).  The following are assumptions regarding the table values: Repeated without dilution — performed usually to confirm correctness of results (e.g., in case of results flagged as "Panic" or mechanical failures).  Repeated with dilution — performed usually in the case the original result exceeded the measurement range (technical limits).  Reflex test — this test is performed as the consequence of rules triggered based on other test result(s). | HL7-defined code system of concepts identifying the repeat status for the analyte/result (e.g. original, rerun, repeat, reflex).  The following are assumptions regarding the table values:
Repeated without dilution — performed usually to confirm correctness of results (e.g., in case of results flagged as "Panic" or mechanical failures).
Repeated with dilution — performed usually in the case the original result exceeded the measurement range (technical limits).
Reflex test — this test is performed as the consequence of rules triggered based on other test result(s).  Used in HL7 Version 2.x messaging in the Test Code Detail (TCD) segment. | HL7-defined code system of concepts identifying the repeat status for the analyte/result (e.g. original, rerun, repeat, reflex).  The following are assumptions regarding the table values:
Repeated without dilution — performed usually to confirm correctness of results (e.g., in case of results flagged as "Panic" or mechanical failures).
Repeated with dilution — performed usually in the case the original result exceeded the measurement range (technical limits).
Reflex test — this test is performed as the consequence of rules triggered based on other test result(s).  Used in HL7 Version 2.x messaging in the Test Code Detail (TCD) segment. |
| 0391 | Segment Group | description | HL7-defined table of codes specifying the optional segment groups which are to be included in a response. | HL7-defined code system of concepts specifying the optional segment groups which are to be included in the response.  This is a repeating field, to accommodate inclusion of multiple segment groups. The default for this field, not present, means that all relevant groups are included.  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. | HL7-defined code system of concepts specifying the optional segment groups which are to be included in the response.  This is a repeating field, to accommodate inclusion of multiple segment groups. The default for this field, not present, means that all relevant groups are included.  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. |
| 0392 | Match Reason | description | Table of codes identifying what search components (e.g., name, birthdate, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels.  It provides a method for passing a descriptive indication of the reason a particular record was found. | Code system of concepts identifying what search components (e.g., name, birthdate, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels.  It provides a method for passing a descriptive indication of the reason a particular record was found.  Used in HL7 Version 2.x messaging in the Query Response Instance (QRI) segment. | Code system of concepts identifying what search components (e.g., name, birthdate, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels.  It provides a method for passing a descriptive indication of the reason a particular record was found.  Used in HL7 Version 2.x messaging in the Query Response Instance (QRI) segment. |
| 0393 | Match Algorithms | description | Table of codes identifying the name or identity of the specific search algorithm to which the RCP-5 Search Confidence Threshold and the QRI-1 Candidate Confidence refer. |  | Code system of concepts identifying the name or identity of the specific search algorithm to which the RCP-5 Search Confidence Threshold and the QRI-1 Candidate Confidence refer.  Used in HL7 Version 2.x messaging in the Query Response Instance (QRI) segment. |
| 0394 | Response Modality | description | HL7-defined table of codes identifying the timing and grouping of the response message(s). | HL7-defined code system of concepts identifying the timing and grouping of the response message(s).  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. | HL7-defined code system of concepts identifying the timing and grouping of the response message(s).  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. |
| 0395 | Modify Indicator | description | HL7-defined table of codes identifying whether the subscription is new or is being modified. | HL7-defined code system of concepts identifying whether the subscription is new or is being modified.  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. | HL7-defined code system of concepts identifying whether the subscription is new or is being modified.  Used in HL7 Version 2.x messaging in the Response Control Parameter (RCP) segment. |
| 0396 | Coding System | description | HL7-defined table of specifying the coding system.  This table is maintained outside of the published Version 2 standards; the content is not listed here; the content is maintained outside of the Version 2 Product Family maintenance process.  For the list of codes in the table, see the HL7 Webpage rendering, at http://www.hl7.org/Special/committees/vocab/table_0396/index.cfm. | HL7-defined code system of concepts specifying the coding system.  This table is maintained outside of the published Version 2 standards, and may be found at http://www.hl7.org/Special/committees/vocab/table_0396/index.cfm.  Used in HL7 Version 2.x messaging in the CWE segment. | HL7-defined code system of concepts specifying the coding system.  This table is maintained outside of the published Version 2 standards, and may be found at http://www.hl7.org/Special/committees/vocab/table_0396/index.cfm.  Used in HL7 Version 2.x messaging in the CWE segment. |
| 0397 | Sequencing | description | HL7-defined table of codes identifying how the field or parameter will be sorted and, if sorted, whether the sort will be case sensitive (the default) or not. | HL7-defined code system of concepts identifying how the field or parameter will be sorted and, if sorted, whether the sort will be case sensitive (the default) or not.  Used in HL7 Version 2.x messaging in the Sort Order (SRT) value. | HL7-defined code system of concepts identifying how the field or parameter will be sorted and, if sorted, whether the sort will be case sensitive (the default) or not.  Used in HL7 Version 2.x messaging in the Sort Order (SRT) value. |
| 0398 | Continuation Style Code | description | HL7-defined table of codes identifying whether it is a fragmented message or part of an interactive continuation message. | HL7-defined code system of concepts identifying whether it is a fragmented message or part of an interactive continuation message.  Used in HL7 Version 2.x messaging in the Continuation Pointer (DSC) segment. | HL7-defined code system of concepts identifying whether it is a fragmented message or part of an interactive continuation message.  Used in HL7 Version 2.x messaging in the Continuation Pointer (DSC) segment. |
| 0401 | Government Reimbursement Program | description | Table of codes which specify codes that indicate an agency that the practitioner is authorized to bill for medical services.  Existing codes only for use in the United States. |  | Code system of concepts which specify codes that indicate an agency that the practitioner is authorized to bill for medical services.  Existing codes only for use in the United States. Used in HL7 Version 2.x messaging in the PRA segment. |
| 0402 | School Type | description | Table of codes which specify a categorization of an academic institution that grants a degree to a Staff Member. |  | Code system of concepts which specify a categorization of an academic institution that grants a degree to a Staff Member.  Used in HL7 Version 2.x messaging in the EDU segment. |
| 0403 | Language Ability | description | Table of codes which specify codes that indicate the ability that a Staff Member possesses with respect to the language. | Code system of concepts which specify codes that indicate the ability that a Staff Member possesses with respect to the language. Used in HL7 Version 2.x messaging in the LAN segment. | Code system of concepts which specify codes that indicate the ability that a Staff Member possesses with respect to the language. Used in HL7 Version 2.x messaging in the LAN segment. |
| 0404 | Language Proficiency | description | HL7-defined table of codes which specify the level of knowledge a person possesses with respect to a language ability identified. | HL7-defined code system of concepts which specify a level of knowledge that a Staff Member possesses with respect to their language ability.  Used in HL7 Version 2 messaging in the LAN segment. | HL7-defined code system of concepts which specify a level of knowledge that a Staff Member possesses with respect to their language ability.  Used in HL7 Version 2 messaging in the LAN segment. |
| 0406 | Participant Organization Unit Type | description | HL7-defined table of codes that specify the environment in which the provider acts in the role associated with the provider type, and inludes codes for venues outside of formal organized healthcare settings, such as Home. The provider environment is not the specialty for the provider. |  | HL7-defined code system of concepts which identify an environment in which a provider acts in a specified role.  The provider environment is not the specialty for the provider.  This is intended to allow communication of this information when the provider information may not have been communicated previously in a master file, and is used to support international requirements.  Used in HL7 Version 2 messaging in the PRT and ROL segments. |
| 0409 | Application Change Type | description | HL7-defined table of codes that specify a type of change being requested (if NMR query) or announced (if NMD unsolicited update). |  | HL7-defined code system of concepts which specify the type of change being requested (if NMR query) or announced (if NMD unsolicited update) during application status changes. It is assumed that a "new" version starts up with no loss or duplication of data as the "old" one is shutting down (if possible).  Used in HL7 Version 2 Messaging in the NSC segment. |
| 0411 | Supplemental Service Information Values | description | Table of codes that specify supplemental service information sent between a placer system and a filler system for the universal procedure code reported in OBR-4 Universal Service ID. This specifies ordering information detail that is not available in other specific tables for fields in the OBR segment.  These might be details such as whether a study is to be done on the right or left, for example, where the study is of the arm and the order master file does not distinguish right from left, or whether a study is to be done with or without contrast (when the order master file does not make such distinctions). | HL7-defined code system of concepts which specify the supplemental service information sent between a placer system and a filler system for the universal procedure code reported in OBR-4 Universal Service ID. This specifies ordering information detail that is not available in other specific tables for fields in the OBR segment.  These might be details such as whether a study is to be done on the right or left, for example, where the study is of the arm and the order master file does not distinguish right from left, or whether a study is to be done with or without contrast (when the order master file does not make such distinctions). |  |
| 0415 | Transfer Type | description | HL7-defined table of codes that specify a type of hospital receiving a transfer patient, which affects how a facility is reimbursed under diagnosis related group (DRG's), for example, exempt or non-exempt. | HL7-defined code system of concepts which specify a type of hospital receiving a transfer patient, which affects how a facility is reimbursed under diagnosis related group (DRG’s), for example, exempt or non-exempt.  Used in HL7 Version 2 messaging in the DRG segment. | HL7-defined code system of concepts which specify a type of hospital receiving a transfer patient, which affects how a facility is reimbursed under diagnosis related group (DRG’s), for example, exempt or non-exempt.  Used in HL7 Version 2 messaging in the DRG segment. |
| 0416 | Procedure DRG Type | description | HL7-defined table of codes that specify a procedure's priority ranking relative to its DRG. | HL7-defined code system of concepts which specify a procedure’s priority ranking relative to its DRG.  Used in HL7 Version 2 messaging in the PR1 segment. | HL7-defined code system of concepts which specify a procedure’s priority ranking relative to its DRG.  Used in HL7 Version 2 messaging in the PR1 segment. |
| 0417 | Tissue Type Code | description | HL7-defined table of codes that specify | HL7-defined code system of concepts which specify a type of tissue removed from a patient during a procedure. Used in HL7 Version 2 messaging in the PR1 segment. | HL7-defined code system of concepts which specify a type of tissue removed from a patient during a procedure. Used in HL7 Version 2 messaging in the PR1 segment. |
| 0418 | Procedure Priority | description | HL7-defined table of codes specifying a number that identifies the significance or priority of the procedure code. | HL7-defined code system of concepts which specify the significance or priority of a procedure code.  Used in HL7 Version 2 messaging in the PR1 segment.  Note that this is a post-coordinated code system, where additional ordinal priorities are created by incrementing the numericinteger code value as needed.  Only the first 2 ordinal values are predefined in the code system. | HL7-defined code system of concepts which specify the significance or priority of a procedure code.  Used in HL7 Version 2 messaging in the PR1 segment.  Note that this is a post-coordinated code system, where additional ordinal priorities are created by incrementing the numericinteger code value as needed.  Only the first 2 ordinal values are predefined in the code system. |
| 0421 | Severity of Illness Code | description | Table of codes specifying the severity ranking of a patient's illness. | HL7-defined code system of concepts which specify the ranking of a patient’s illness.  Used in HL7 Version 2 messaging in the ABS segment. | HL7-defined code system of concepts which specify the ranking of a patient’s illness.  Used in HL7 Version 2 messaging in the ABS segment. |
| 0422 | Triage Code | description | Table of codes specifying a patient's prioritization within the context of this abstract. | HL7-defined code system of concepts which specify a patient’s prioritization within the context of a transmitted abstract. Used in HL7 Version 2 messaging in the ABS segment. | HL7-defined code system of concepts which specify a patient’s prioritization within the context of a transmitted abstract. Used in HL7 Version 2 messaging in the ABS segment. |
| 0423 | Case Category Code | description | Table of codes specifying the reason a non-urgent patient presents to the emergency room for treatment instead of a clinic or physican office. |  | HL7-defined code system of concepts which specify reasons that a non-urgent patient presents to the Emergency Room for treatment instead of a clinic or physician office.  Used in HL7 Version 2 messaging in the ABS segment. |
| 0424 | Gestation Category Code | description | Table of codes specifying the status of the birth in relation to the gestation | HL7-defined code system of concepts which specify the status of a birth in relation to the gestation.  Used in HL7 Version 2 messaging in the ABS segment. | HL7-defined code system of concepts which specify the status of a birth in relation to the gestation.  Used in HL7 Version 2 messaging in the ABS segment. |
| 0425 | Newborn Code | description | Table of codes specifying whether the baby was born in or out of the facility. | HL7-defined code system of concepts which specify whether the baby was born in or out of a specified facility.  Used in HL7 Version 2 messaging in the ABS segment. | HL7-defined code system of concepts which specify whether the baby was born in or out of a specified facility.  Used in HL7 Version 2 messaging in the ABS segment. |
| 0426 | Blood Product Code | description | Table of codes specifying the blood product code. | HL7-defined code system of concepts which specify a type of blood product.  Used in HL7 Version 2 messaging in the BLC segment. | HL7-defined code system of concepts which specify a type of blood product.  Used in HL7 Version 2 messaging in the BLC segment. |
| 0427 | Risk Management Incident Code | description | Table of codes specifying the incident that occurred during a patient's stay. | HL7-defined code system of concepts which specify a type of incident that occurs during a patient’s stay.  Used in HL7 Version 2 messaging in the RMI segment. | HL7-defined code system of concepts which specify a type of incident that occurs during a patient’s stay.  Used in HL7 Version 2 messaging in the RMI segment. |
| 0428 | Incident Type Code | description | Table of codes specifying a classification of the incident type. | HL7-defined code system of concepts which specify a classification of types of incidents.  Used in HL7 Version 2 messaging in the RMI segment. | HL7-defined code system of concepts which specify a classification of types of incidents.  Used in HL7 Version 2 messaging in the RMI segment. |
| 0429 | Production Class Code | description | Table of codes specifying the code and/or text indicating the primary use for which the living subject was bred or grown. | Code system of concepts  specifying the code and/or text indicating the primary use for which the living subject was bred or grown.  Used in HL7 Version 2.x messaging in the PID segment. | Code system of concepts  specifying the code and/or text indicating the primary use for which the living subject was bred or grown.  Used in HL7 Version 2.x messaging in the PID segment. |
| 0430 | Mode of Arrival Code | description | Table of codes specifying how the patient was brought to the healthcare facility. | Code system of concepts specifying how the patient was brought to the healthcare facility.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts specifying how the patient was brought to the healthcare facility.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0431 | Recreational Drug Use Code | description | Table of codes specifying what recreational drugs the patient uses. | Code system of concepts specifying what recreational drugs the patient uses.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts specifying what recreational drugs the patient uses.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0432 | Admission Level of Care Code | description | Table of codes specifying the acuity level assigned to the patient at the time of admission. | Code system of concepts  specifying the acuity level assigned to the patient at the time of admission.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts  specifying the acuity level assigned to the patient at the time of admission.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0433 | Precaution Code | description | Table of codes specifying non-clincal precautions that need to be taken with the patient. | Code system of concepts  specifying non-clincal precautions that need to be taken with the patient.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts  specifying non-clincal precautions that need to be taken with the patient.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0434 | Patient Condition Code | description | Table of codes specifying the patient's current medical condition for the purpose of communicating to non-medical outside parties, e.g. family, employer, religious minister, media, etc. | Code system of concepts specifying the patient's current medical condition for the purpose of communicating to non-medical outside parties, e.g. family, employer, religious minister, media, etc.  Used in HL7 Version 2.x messaging in the PV2 segment. | Code system of concepts specifying the patient's current medical condition for the purpose of communicating to non-medical outside parties, e.g. family, employer, religious minister, media, etc.  Used in HL7 Version 2.x messaging in the PV2 segment. |
| 0435 | Advance Directive Code | description | Table of codes specifying the patient's instructions to the healthcare facility. |  | Code system of concepts specifying the patient's instructions to the healthcare facility.  Used in HL7 Version 2.x messaging in the PV2 and PD1 segments. |
| 0436 | Sensitivity to Causative Agent Code | description | Table of codes specifying the reason the patient should not be exposed to a substance. | Code system of concepts specifying the reason the patient should not be exposed to a substance.  Used in HL7 Version 2.x messaging in the IAM segment. | Code system of concepts specifying the reason the patient should not be exposed to a substance.  Used in HL7 Version 2.x messaging in the IAM segment. |
| 0437 | Alert Device Code | description | Table of codes specifying any type of allergy alert device the patient may be carrying or wearing. | Code system of concepts specifying any type of allergy alert device the patient may be carrying or wearing.  Used in HL7 Version 2.x messaging in the IAM segment. | Code system of concepts specifying any type of allergy alert device the patient may be carrying or wearing.  Used in HL7 Version 2.x messaging in the IAM segment. |
| 0438 | Allergy Clinical Status | description | Table of codes specifying the verification status for the allergy. | Code system of concepts specifying the verification status for the allergy.  Used in HL7 Version 2.x messaging in the IAM segment. | Code system of concepts specifying the verification status for the allergy.  Used in HL7 Version 2.x messaging in the IAM segment. |
| 0440 | Data Types | description | HL7-defined table of codes specifying the data type. | HL7-defined code system of concepts specifying the format of the observation value in the Observation Result (OBX).   Used in HL7 Version 2.x messaging in the OBX, OM1, OM3 and OMC segments. | HL7-defined code system of concepts specifying the format of the observation value in the Observation Result (OBX).   Used in HL7 Version 2.x messaging in the OBX, OM1, OM3 and OMC segments. |
| 0441 | Immunization Registry Status | description | Table of codes specifying the immunization registry status of the patient. | Code system of concepts specifying the immunization registry status of the patient.  Used in HL7 Version 2.x messaging in the PD1 segment. | Code system of concepts specifying the immunization registry status of the patient.  Used in HL7 Version 2.x messaging in the PD1 segment. |
| 0442 | Location Service Code | description | Table of codes specifying the types of services provided by the location. | Code system of concepts  specifying the types of services provided by the location.  Used in HL7 Version 2.x messaging in the LOC segment. | Code system of concepts  specifying the types of services provided by the location.  Used in HL7 Version 2.x messaging in the LOC segment. |
| 0443 | Provider Role | description | Table of codes specifying the functional involvement with the activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.). | Code system of concepts specifying the functional involvement with the activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.).  Used in HL7 Version 2.x messaging in the ROL segment. | Code system of concepts specifying the functional involvement with the activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.).  Used in HL7 Version 2.x messaging in the ROL segment. |
| 0444 | Name Assembly Order | description | HL7-defined table of codes specifying the preferred display order of the components of this person name. | Code system of concepts specifying the preferred display order of the components of this person name.  Used in HL7 Version 2.x messaging in the PPN, XCN and XPN segments. | Code system of concepts specifying the preferred display order of the components of this person name.  Used in HL7 Version 2.x messaging in the PPN, XCN and XPN segments. |
| 0445 | Identity Reliability Code | description | Table of codes specifying the reliability of patient/person identifying data transmitted via a transaction. | Code system of concepts specifying the reliability of patient/person identifying data transmitted via a transaction.  Used in HL7 Version 2.x messaging in the PID segment. | Code system of concepts specifying the reliability of patient/person identifying data transmitted via a transaction.  Used in HL7 Version 2.x messaging in the PID segment. |
| 0450 | Event Type | description | HL7-defined table of codes specifying the type of event of the message. | HL7-defined code system of concepts specifying the type of event of the message.  Used in HL7 Version 2.x messaging in the EQP segment. | HL7-defined code system of concepts specifying the type of event of the message.  Used in HL7 Version 2.x messaging in the EQP segment. |
| 0457 | Overall Claim Disposition Code | description | Table of codes specifying the final status of the claim. | Code system of concepts specifying the final status of the claim.  Used in HL7 Version 2.x messaging in the GP1 segment. | Code system of concepts specifying the final status of the claim.  Used in HL7 Version 2.x messaging in the GP1 segment. |
| 0459 | Reimbursement Action Code | description | Table of codes specifying the action to be taken during reimbursement calculations. | Code system of concepts specifying the action to be taken during reimbursement calculations.  Used in HL7 Version 2.x messaging in the GP2 segment. |  |
| 0460 | Denial or Rejection Code | description | Table of codes specifying the OCE status of the line item. | Code system of concepts specifying the OCE status of the line item.  Used in HL7 Version 2.x messaging in the GP2 segment. |  |
| 0465 | Name/Address Representation | symbolicName | name-addressRepresentation | Name-addressRepresentation | NameAddressRepresentation |
| 0465 | Name/Address Representation | description | HL7-defined table of codes specifying an indication of the representation provided by the data item. | HL7-defined code system of concepts specifying an indication of the representation provided by the data item.  Used in HL7 Version 2.x messaging in the PPN, XAD, XCN and XON segments. | HL7-defined code system of concepts specifying an indication of the representation provided by the data item.  Used in HL7 Version 2.x messaging in the PPN, XAD, XCN and XON segments. |
| 0466 | Ambulatory Payment Classification Code | description | Table of codes specifying the derived Ambulatory Payment Classification (APC) code. | Code system of concepts specifying the derived Ambulatory Payment Classification (APC) code.  Used in HL7 Version 2.x messaging in the GP2 segment. | Code system of concepts specifying the derived Ambulatory Payment Classification (APC) code.  Used in HL7 Version 2.x messaging in the GP2 segment. |
| 0468 | Payment Adjustment Code | description | Table of codes specifying any payment adjustment due to drugs or medical devices. | Code system of concepts specifying any payment adjustment due to drugs or medical devices.  Used in HL7 Version 2.x messaging in the GP2 segment. | Code system of concepts specifying any payment adjustment due to drugs or medical devices.  Used in HL7 Version 2.x messaging in the GP2 segment. |
| 0469 | Packaging Status Code | description | Table of codes specifying the packaging status of the service. | Code system of concepts specifying the packaging status of the service.  Used in HL7 Version 2.x messaging in the GP2 segment. | Code system of concepts specifying the packaging status of the service.  Used in HL7 Version 2.x messaging in the GP2 segment. |
| 0470 | Reimbursement Type Code | description | Table of codes specifying the fee schedule reimbursement type applied to the line item. | Code system of concepts specifying the fee schedule reimbursement type applied to the line item.  Used in HL7 Version 2.x messaging in the GP2 segment. | Code system of concepts specifying the fee schedule reimbursement type applied to the line item.  Used in HL7 Version 2.x messaging in the GP2 segment. |
| 0472 | TQ Conjunction ID | description | HL7-defined table of codes specifying that a second timing specification is to follow using the repeat delimiter. | HL7-defined code system of concepts specifying that a second timing specification is to follow using the repeat delimiter.  Used in HL7 Version 2.x messaging in the TQ1 segment. | HL7-defined code system of concepts specifying that a second timing specification is to follow using the repeat delimiter.  Used in HL7 Version 2.x messaging in the TQ1 segment. |
| 0473 | Formulary Status | description | Table of codes specifying whether or not the service (pharmaceutical) is in the formulary. |  | Code system of concepts specifying whether or not the service (pharmaceutical) is in the formulary.  Used in HL7 Version 2.x messaging in the OM7 segment. |
| 0474 | Practitioner Organization Unit Type | description | Table of codes specifying the classification of the organization unit. | Code system of concepts specifying the classification of the organization unit.  Used in HL7 Version 2.x messaging in the ORG segment. | Code system of concepts specifying the classification of the organization unit.  Used in HL7 Version 2.x messaging in the ORG segment. |
| 0475 | Charge Type Reason | description | Table of codes specifying the choice of, and providing the clinical rationale for, a selected charge type. | Code system of concepts specifying the choice of, and providing the clinical rationale for, a selected charge type.  Used in HL7 Version 2.x messaging in the BLG segment. | Code system of concepts specifying the choice of, and providing the clinical rationale for, a selected charge type.  Used in HL7 Version 2.x messaging in the BLG segment. |
| 0477 | Controlled Substance Schedule | description | Table of codes specifying the class of the drug or other substance if its usage is controlled by legislation.  In the USA, such legislation includes the federal Controlled Substance Act (CSA) or a State Uniform Controlled Substance Act. Values are drawn from the Pharmacy Law Digest July 1988.  Other countries should create their own versions of this table.  No suggested values. | Code system of concepts specifying the class of the drug or other substance if its usage is controlled by legislation.  In the USA, such legislation includes the federal Controlled Substance Act (CSA) or a State Uniform Controlled Substance Act. Other countries should create their own versions of this table.  Used in HL7 Version 2.x messaging in the RXE segment.  The name of the table is taken from the Pharmacy Law Digest July 1988. | Code system of concepts specifying the class of the drug or other substance if its usage is controlled by legislation.  In the USA, such legislation includes the federal Controlled Substance Act (CSA) or a State Uniform Controlled Substance Act. Other countries should create their own versions of this table.  Used in HL7 Version 2.x messaging in the RXE segment.  The name of the table is taken from the Pharmacy Law Digest July 1988. |
| 0478 | Formulary Status | description | HL7-defined table of codes specifying whether or not the pharmaceutical substance is part of the local formulary. | HL7-defined code system of concepts specifying whether or not the pharmaceutical substance is part of the local formulary.  Used in HL7 Version 2.x messaging in the RXE segment. | HL7-defined code system of concepts specifying whether or not the pharmaceutical substance is part of the local formulary.  Used in HL7 Version 2.x messaging in the RXE segment. |
| 0480 | Pharmacy Order Types | description | HL7-defined table of codes specifying the general category of pharmacy order which may be used to determine the processing path the order will take. | HL7-defined code system of concepts specifying the general category of pharmacy order which may be used to determine the processing path the order will take.  Used in HL7 Version 2.x messaging in the RXO, RXE, RXD, RXG and RXA segments. | HL7-defined code system of concepts specifying the general category of pharmacy order which may be used to determine the processing path the order will take.  Used in HL7 Version 2.x messaging in the RXO, RXE, RXD, RXG and RXA segments. |
| 0482 | Order Type | description | HL7-defined table of codes specifying whether the order is to be executed in an inpatient setting or an outpatient setting. | HL7-defined code system of concepts specifying whether the order is to be executed in an inpatient setting or an outpatient setting.  Used in HL7 Version 2.x messaging in the ORC segment. | HL7-defined code system of concepts specifying whether the order is to be executed in an inpatient setting or an outpatient setting.  Used in HL7 Version 2.x messaging in the ORC segment. |
| 0483 | Authorization Mode | description | HL7-defined table of codes of forms of authorization a recorder may receive from the responsible practitioner to create or change an order. | HL7-defined code system of concepts of forms of authorization a recorder may receive from the responsible practitioner to create or change an order.  Used in HL7 Version 2.x messaging in the ORC segment. | HL7-defined code system of concepts of forms of authorization a recorder may receive from the responsible practitioner to create or change an order.  Used in HL7 Version 2.x messaging in the ORC segment. |
| 0484 | Dispense Type | description | Table of codes specifying the type of dispensing event that occurred. | Code system of concepts specifying the type of dispensing event that occurred.  Used in HL7 Version 2.x messaging in the RXD segment. | Code system of concepts specifying the type of dispensing event that occurred.  Used in HL7 Version 2.x messaging in the RXD segment. |
| 0485 | Extended Priority Codes | description | Table of codes describing the urgency of a request carried in an order. See the Comment/Usage Note in the table below, as the table contains both precoordinated codes that may be used in an HL7 field or component and also explanatory patterns illustrating the syntax used to construct expressions using the codes and other modifiers. | Code system of concepts describing the urgency of a request carried in an order.  Used in HL7 Version 2.x messaging in timing/quantity; in older versions of the Standard was used in the TQ datatype, but in later versions it is used in the TQ1 segment (which replaced the TQ datatype which has been withdrawn). | Code system of concepts describing the urgency of a request carried in an order.  Used in HL7 Version 2.x messaging in timing/quantity; in older versions of the Standard was used in the TQ datatype, but in later versions it is used in the TQ1 segment (which replaced the TQ datatype which has been withdrawn). |
| 0487 | Specimen Type | description | HL7-defined table of codes that describe the precise nature of an entity that may be used as the source material for an observation.  This is one of two code systems that are used instead of table 0070 (code system 2.16.840.1.113883.18.28) which conflated specimen types and specimen collection methods. | HL7-defined code system of concepts that describe the precise nature of an entity that may be used as the source material for an observation.  This is one of two code systems that are used instead of table 0070 (code system 2.16.840.1.113883.18.28) which conflated specimen types and specimen collection methods.   Used in HL7 Version 2.x messaging in the SPM segment. | HL7-defined code system of concepts that describe the precise nature of an entity that may be used as the source material for an observation.  This is one of two code systems that are used instead of table 0070 (code system 2.16.840.1.113883.18.28) which conflated specimen types and specimen collection methods.   Used in HL7 Version 2.x messaging in the SPM segment. |
| 0488 | Specimen Collection Method | description | HL7-defined table of codes specifying the specimen collection method.   Used in Version 2 messaging in the SPM segment. | HL7-defined code system of concepts specifying the specimen collection method.  Used in HL7 Version 2.x messaging in the SPM segment. | HL7-defined code system of concepts specifying the specimen collection method.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0489 | Risk Codes | description | Table of codes specifying any known or suspected specimen hazards, e.g., exceptionally infectious agent or blood from a hepatitis patient. | Code system of concepts specifying any known or suspected specimen hazards, e.g., exceptionally infectious agent or blood from a hepatitis patient.  Used in HL7 Version 2.x messaging in the SPM and PAC segments. | Code system of concepts specifying any known or suspected specimen hazards, e.g., exceptionally infectious agent or blood from a hepatitis patient.  Used in HL7 Version 2.x messaging in the SPM and PAC segments. |
| 0490 | Specimen Reject Reason | description | HL7-defined table of codes specifying the reasons a specimen may be rejected for a specified observation/result/analysis. | HL7-defined code system of reasons a specimen may be rejected for a specified observation/result/analysis.  Used in HL7 Version 2.x messaging in the SPM segment. | HL7-defined code system of reasons a specimen may be rejected for a specified observation/result/analysis.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0491 | Specimen Quality | description | Table of codes specifying the degree or grade of excellence of the specimen at receipt. | Code system of concepts specifying the degree or grade of excellence of the specimen at receipt.  Used in HL7 Version 2.x messaging in the SPM segment. | Code system of concepts specifying the degree or grade of excellence of the specimen at receipt.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0492 | Specimen Appropriateness | description | Table of codes specifying the suitability of the specimen for the particular planned use as determined by the filler. | Code system of concepts specifying the suitability of the specimen for the particular planned use as determined by the filler.  Used in HL7 Version 2.x messaging in the SPM segment. | Code system of concepts specifying the suitability of the specimen for the particular planned use as determined by the filler.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0493 | Specimen Condition | description | Table of codes specifying a mode or state of being that describes the nature of the specimen. | Code system of concepts specifying a mode or state of being that describes the nature of the specimen.  Used in HL7 Version 2.x messaging in the SPM segment. | Code system of concepts specifying a mode or state of being that describes the nature of the specimen.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0494 | Specimen Child Role | description | HL7-defined table of codes specifying for child specimens the relationship between this specimen and the parent specimen. | HL7-defined code system of concepts specifying for child specimens the relationship between this specimen and the parent specimen.  Used in HL7 Version 2.x messaging in the SPM segment. | HL7-defined code system of concepts specifying for child specimens the relationship between this specimen and the parent specimen.  Used in HL7 Version 2.x messaging in the SPM segment. |
| 0495 | Body Site Modifier | description | HL7-defined table of codes specifying the modifier for the body site. | HL7-defined code system of concepts specifying the modifier for the body site.  Used in HL7 Version 2.x messaging in the RXR segment. | HL7-defined code system of concepts specifying the modifier for the body site.  Used in HL7 Version 2.x messaging in the RXR segment. |
| 0496 | Consent Type | description | Table of codes specifying to what the subject is consenting, i.e. what type of service, surgical procedure, information access/release or other event. | Code system of concepts specifying to what the subject is consenting, i.e. what type of service, surgical procedure, information access/release or other event.  Used in HL7 Version 2.x messaging in the TXA and CON segments. | Code system of concepts specifying to what the subject is consenting, i.e. what type of service, surgical procedure, information access/release or other event.  Used in HL7 Version 2.x messaging in the TXA and CON segments. |
| 0497 | Consent Mode | description | HL7-defined table of codes specifying the method in which a subject provides consent. | HL7-defined code system of concepts specifying the method in which a subject provides consent.  Used in HL7 Version 2.x messaging in the TXA and CON segments. | HL7-defined code system of concepts specifying the method in which a subject provides consent.  Used in HL7 Version 2.x messaging in the TXA and CON segments. |
| 0498 | Consent Status | description | HL7-defined table of codes specifying whether the consent has been sought and granted. | HL7-code system of concepts specifying whether the consent has been sought and granted.  Used in HL7 Version 2.x messaging in the TXA and CON segments. | HL7-code system of concepts specifying whether the consent has been sought and granted.  Used in HL7 Version 2.x messaging in the TXA and CON segments. |
| 0499 | Consent Bypass Reason | description | Table of codes specifying the reason the subject's consent was not sought. | Code system of concepts specifying the reason the subject's consent was not sought.  Used in HL7 Version 2.x messaging in the CON segment. | Code system of concepts specifying the reason the subject's consent was not sought.  Used in HL7 Version 2.x messaging in the CON segment. |
| 0500 | Consent Disclosure Level | description | HL7-defined table of codes used to specify how much information was disclosed to the subject as part of the informed consent process. | HL7-defined code system of concepts specifying how much information was disclosed to the subject as part of the informed consent process.  Used in HL7 Version 2.x messaging in the CON segment. | HL7-defined code system of concepts specifying how much information was disclosed to the subject as part of the informed consent process.  Used in HL7 Version 2.x messaging in the CON segment. |
| 0501 | Consent Non-Disclosure Reason | symbolicName | consentNon-disclosureReason | ConsentNon-disclosureReason | ConsentNonDisclosureReason |
| 0501 | Consent Non-Disclosure Reason | description | Table of codes used to specify a reason the subject did not receive full disclosure. | Code system of concepts used to specify a reason the subject did not receive full disclosure.  Used in the Consent (CON) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify a reason the subject did not receive full disclosure.  Used in the Consent (CON) segment in HL7 Version 2.x messaging. |
| 0502 | Non-Subject Consenter Reason | symbolicName | non-subjectConsenterReason | Non-subjectConsenterReason | NonSubjectConsenterReason |
| 0502 | Non-Subject Consenter Reason | description | HL7-defined table of codes used to specify a reason consent was granted by a person other than the subject of the consent. | HL7-defined  code system of concepts used to specify a reason consent was granted by a person other than the subject of the consent.  Used in the Consent (CON) segment in HL7 Version 2.x messaging. | HL7-defined  code system of concepts used to specify a reason consent was granted by a person other than the subject of the consent.  Used in the Consent (CON) segment in HL7 Version 2.x messaging. |
| 0503 | Sequence/Results Flag | description | HL7-defined table of codes used to specify the sequencing relationship between the current service request and the related service request(s) specified in this TQ2 segment. | HL7-defined  code system of concepts used to specify the sequencing relationship between the current service request and the related service request(s) specified in this TQ2 segment.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. | HL7-defined  code system of concepts used to specify the sequencing relationship between the current service request and the related service request(s) specified in this TQ2 segment.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. |
| 0504 | Sequence Condition Code | description | HL7-defined table of codes used to specify the relationship between the start/end of the related service request(s) (from TQ2-3, TQ2-4 or TQ2-5) and the current service request from ORC-2, 3 or 4. | HL7-defined code system of concepts used to specify the relationship between the start/end of the related service request(s) (from TQ2-3, TQ2-4 or TQ2-5) and the current service request from ORC-2, 3 or 4.  Used in HL7 Version 2.x messaging in the TQ2 segment. | HL7-defined code system of concepts used to specify the relationship between the start/end of the related service request(s) (from TQ2-3, TQ2-4 or TQ2-5) and the current service request from ORC-2, 3 or 4.  Used in HL7 Version 2.x messaging in the TQ2 segment. |
| 0505 | Cyclic Entry/Exit Indicator | description | HL7-defined table of codes used to specify if this service request is the first or last service request in a cyclic series of service requests. | HL7-defined code system of concepts used to specify if this service request is the first or last service request in a cyclic series of service requests.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify if this service request is the first or last service request in a cyclic series of service requests.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. |
| 0506 | Service Request Relationship | description | HL7-defined table of codes used to specify an additional or alternate relationship between this service request and other service requests. | HL7-defined code system of concepts used to specify an additional or alternate relationship between this service request and other service requests.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify an additional or alternate relationship between this service request and other service requests.  Used in the Timing/Quantity Relationship (TQ2) segment in HL7 Version 2.x messaging. |
| 0507 | Observation Result Handling | description | Table of codes regarding the handling of a result.  For example, an order may specify that the result (e.g., an x-ray film) should be given to the patient for return to the requestor. | Code system of concepts regarding the handling of a result.  For example, an order may specify that the result (e.g., an x-ray film) should be given to the patient for return to the requestor.   Used in HL7 Version 2.x messaging in the OBR segment. | Code system of concepts regarding the handling of a result.  For example, an order may specify that the result (e.g., an x-ray film) should be given to the patient for return to the requestor.   Used in HL7 Version 2.x messaging in the OBR segment. |
| 0508 | Blood Product Processing Requirements | description | Table of codes used to specify additional information about the blood component class associated with the Universal Service ID.  The placer of the order can specify any required processing of the blood product that must be completed prior to transfusion to the intended recipient. | Code system of concepts used to specify additional information about the blood component class associated with the Universal Service ID.  The placer of the order can specify any required processing of the blood product that must be completed prior to transfusion to the intended recipient.  Used in the Blood Product Order (BPO) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify additional information about the blood component class associated with the Universal Service ID.  The placer of the order can specify any required processing of the blood product that must be completed prior to transfusion to the intended recipient.  Used in the Blood Product Order (BPO) segment in HL7 Version 2.x messaging. |
| 0510 | Blood Product Dispense Status | description | HL7-defined table of codes used to specify the current status of the specified blood product as indicated by the filler or placer.  For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it first becomes linked to a patient and is ready to dispense. The placer system may use the Blood Product Dispense Status Message to request the transfusion service to dispense the product.  When the blood product is delivered or issued to a patient, the status of the blood product would be changed to indicate that it has now been "dispensed". | HL7-defined code system of concepts used to specify the current status of the specified blood product as indicated by the filler or placer.  For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it first becomes linked to a patient and is ready to dispense. The placer system may use the Blood Product Dispense Status Message to request the transfusion service to dispense the product.  When the blood product is delivered or issued to a patient, the status of the blood product would be changed to indicate that it has now been "dispensed".  Used in the Blood Product Dispense Status (BPX) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify the current status of the specified blood product as indicated by the filler or placer.  For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it first becomes linked to a patient and is ready to dispense. The placer system may use the Blood Product Dispense Status Message to request the transfusion service to dispense the product.  When the blood product is delivered or issued to a patient, the status of the blood product would be changed to indicate that it has now been "dispensed".  Used in the Blood Product Dispense Status (BPX) segment in HL7 Version 2.x messaging. |
| 0511 | BP Observation Status Codes Interpretation | description | HL7-defined table of codes used to specify the interpretation for the blood product observation status codes.  A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first cross-matched and a status message is sent, it would be considered preliminary. When the product is dispensed to the patient, that status would also be considered preliminary.  However, once the product is transfused, the status would be considered final. | HL7-defined code system of concepts used to specify the interpretation for the blood product observation status codes.  A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first cross-matched and a status message is sent, it would be considered preliminary. When the product is dispensed to the patient, that status would also be considered preliminary.  However, once the product is transfused, the status would be considered final.  Used in the Blood Product Dispense Status (BPX) and Blood Product Transfusion/Disposition (BTX) segments in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify the interpretation for the blood product observation status codes.  A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first cross-matched and a status message is sent, it would be considered preliminary. When the product is dispensed to the patient, that status would also be considered preliminary.  However, once the product is transfused, the status would be considered final.  Used in the Blood Product Dispense Status (BPX) and Blood Product Transfusion/Disposition (BTX) segments in HL7 Version 2.x messaging. |
| 0513 | Blood Product Transfusion/Disposition Status | symbolicName | bloodProductTransfusion-dispositionStatus | BloodProductTransfusion-dispositionStatus | BloodProductTransfusionDispositionStatus |
| 0513 | Blood Product Transfusion/Disposition Status | description | HL7-defined table of codes used to specify the current status of the specified blood product as indicated by the placer.  For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood component may have been entered, but the line was clogged and could not be used, in which case the component must be wasted. A final status would indicate that the product has actually been "transfused." | HL7-defined code system of concepts used to specify the current status of the specified blood product as indicated by the placer.  For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood component may have been entered, but the line was clogged and could not be used, in which case the component must be wasted. A final status would indicate that the product has actually been "transfused."  Used in the Blood Product Transfusion/Disposition (BTX) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify the current status of the specified blood product as indicated by the placer.  For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood component may have been entered, but the line was clogged and could not be used, in which case the component must be wasted. A final status would indicate that the product has actually been "transfused."  Used in the Blood Product Transfusion/Disposition (BTX) segment in HL7 Version 2.x messaging. |
| 0514 | Transfusion Adverse Reaction | description | Table of codes used to specify the type of adverse reaction that the recipient of the blood product experienced. | Code system of concepts used to specify the type of adverse reaction that the recipient of the blood product experienced.  Used in the Blood Product Transfusion/Disposition (BTX) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the type of adverse reaction that the recipient of the blood product experienced.  Used in the Blood Product Transfusion/Disposition (BTX) segment in HL7 Version 2.x messaging. |
| 0516 | Error Severity | description | HL7-defined table of codes specifying the severity of an application error as reported during acknowledgment of messages. Knowing if something is Error, Warning or Information is intrinsic to how an application handles the content and the information flow. | HL7-defined code system of concepts specifying the severity of an application error as reported during acknowledgment of messages. Knowing if something is Error, Warning or Information is intrinsic to how an application handles the content and the information flow.  Used in HL7 Version 2.x messaging acknowledgment in the ERR segment. | HL7-defined code system of concepts specifying the severity of an application error as reported during acknowledgment of messages. Knowing if something is Error, Warning or Information is intrinsic to how an application handles the content and the information flow.  Used in HL7 Version 2.x messaging acknowledgment in the ERR segment. |
| 0517 | Inform Person Code | description | Table of codes used to specify who (if anyone) should be informed of the error.  This field may also be used to indicate that a particular person should NOT be informed of the error (e.g. do not inform patient.) | Code system of concepts specifying who (if anyone) should or should not be informed of an error.  Used in the Error (ERR) segment in HL7 Version 2.x messaging. | Code system of concepts specifying who (if anyone) should or should not be informed of an error.  Used in the Error (ERR) segment in HL7 Version 2.x messaging. |
| 0518 | Override Type | description | Table of codes used to specify what type of override can be used to override the specific error identified. | Code system of concepts used to specify what type of override can be used to override the specific error identified.   Used in HL7 Version 2 messaging in the ERR and OVR segments. | Code system of concepts used to specify what type of override can be used to override the specific error identified.   Used in HL7 Version 2 messaging in the ERR and OVR segments. |
| 0520 | Message Waiting Priority | description | HL7-defined table of codes used to specify how important the most important waiting mesasge is.  For example, if there are 3 low priority messages, 1 medium priority message and 1 high priority message, the message waiting priority would be "high", because that is the highest priority of any new message waiting. | HL7-defined code system of concepts which specify the disposition of the patient at time of discharge (i.e., discharged to home, expired, etc.).  Used in HL7 Version 2.x messaging in the MSA segment. | HL7-defined code system of concepts which specify the disposition of the patient at time of discharge (i.e., discharged to home, expired, etc.).  Used in HL7 Version 2.x messaging in the MSA segment. |
| 0523 | Computation Type | description | HL7-defined table of codes used to specify if the change is computed as a percent change or as an absolute change. | HL7-defined code system of concepts used to specify if the change is computed as a percent change or as an absolute change.  Used in the Delta (DLT) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify if the change is computed as a percent change or as an absolute change.  Used in the Delta (DLT) segment in HL7 Version 2.x messaging. |
| 0527 | Calendar Alignment | description | HL7-defined table of codes used to specify an alignment of the repetition to a calendar (e.g., to distinguish every  30 days from "the 5th of every month"). | HL7-defined code system of concepts used to specify an alignment of the repetition to a calendar (e.g., to distinguish every 30 days from "the 5th of every month").  Used in HL7 Version 2 messaging in the RPT segment. | HL7-defined code system of concepts used to specify an alignment of the repetition to a calendar (e.g., to distinguish every 30 days from "the 5th of every month").  Used in HL7 Version 2 messaging in the RPT segment. |
| 0528 | Event Related Period | description | HL7-defined table of codes used to specify a common (periodical) activity of daily living. | HL7-defined code system of concepts specifying a common (periodical) activity of daily living.  Used in HL7 Version 2 messaging in the RPT segment. | HL7-defined code system of concepts specifying a common (periodical) activity of daily living.  Used in HL7 Version 2 messaging in the RPT segment. |
| 0530 | Organization, Agency, Department | symbolicName | organization-Agency-Department |  | OrganizationAgencyDepartment |
| 0530 | Organization, Agency, Department | description | Table of codes used to specify the agency or department that assigned the identifier in component 1. |  | Code system of concepts used to specify the agency or department that assigned the identifier in component 1.  Used in the Performing Person Time Stamp (PPN), Extended Composite ID Number and Name for Persons (XCN) and Extended Composite ID with Check Digit (CX) segments in HL7 Version 2.x messaging. |
| 0532 | Expanded Yes/no Indicator | symbolicName | expandedYes-NoIndicator | ExpandedYes-NoIndicator | ExpandedYesNoIndicator |
| 0532 | Expanded Yes/no Indicator | description | HL7-defined table of codes used to specify an expansion on the original Yes/No indicator table by including "flavors of null".  It is intended to be applied to fields where the response is not limited to "yes" or "no". | HL7-defined code system of concepts used to specify an expansion on the original Yes/No indicator table by including "flavors of null".  It is intended to be applied to fields where the response is not limited to "yes" or "no".  Used in numerous locations in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify an expansion on the original Yes/No indicator table by including "flavors of null".  It is intended to be applied to fields where the response is not limited to "yes" or "no".  Used in numerous locations in HL7 Version 2.x messaging. |
| 0534 | Notify Clergy Code | description | Table of codes used to specify whether the clergy should be notified. | Code system of concepts specifying whether the clergy should be notified.  Used in HL7 Version 2 messaging in the PV2 segment. | Code system of concepts specifying whether the clergy should be notified.  Used in HL7 Version 2 messaging in the PV2 segment. |
| 0535 | Signature Code | description | Table of codes that indicate how a patient/subscriber authorization signature is obtained and how it is being retained by a provider. | Code system of concepts that indicate how a patient/subscriber authorization signature is obtained and how it is being retained by a provider.  Used in HL7 Version 2.x messaging in the IN1 segment. | Code system of concepts that indicate how a patient/subscriber authorization signature is obtained and how it is being retained by a provider.  Used in HL7 Version 2.x messaging in the IN1 segment. |
| 0536 | Certificate Status | description | Table of codes used to specify the status of the certificate held by the health professional. | Code system of concepts specifying the status of the certificate held by the health professional.  Used in HL7 Version 2 messaging in the CER segment. | Code system of concepts specifying the status of the certificate held by the health professional.  Used in HL7 Version 2 messaging in the CER segment. |
| 0538 | Institution Relationship Type | description | Table of codes used to specify the relationship the staff person has with the institution for whom he/she provides services. | Code system of concepts specifying the relationship the staff person has with the institution for whom he/she provides services.  Used in HL7 Version 2 messaging in the STF segment. | Code system of concepts specifying the relationship the staff person has with the institution for whom he/she provides services.  Used in HL7 Version 2 messaging in the STF segment. |
| 0540 | Inactive Reason Code | description | Table of codes used to specify the reason the staff member is inactive. | Code system of concepts specifying the reason the staff member is inactive.  Used in HL7 Version 2 messaging in the STF segment. | Code system of concepts specifying the reason the staff member is inactive.  Used in HL7 Version 2 messaging in the STF segment. |
| 0544 | Container Condition | description | HL7-defined table of codes used to specify at each receipt the status of the container in which the specimen is shipped in chain of custody cases where specimens are moved from lab to lab.  If the container is compromised in any way (seal broken, container cracked or leaking, etc.), then this status needs to be recorded for legal reasons. | HL7-defined  code system of concepts used to specify at each receipt the status of the container in which the specimen is shipped in chain of custody cases where specimens are moved from lab to lab.  If the container is compromised in any way (seal broken, container cracked or leaking, etc.), then this status needs to be recorded for legal reasons.  Used in the Specimen (SPM), Shipment (SHP) and Shipment Package (PAC) segments in HL7 Version 2.x messaging. | HL7-defined  code system of concepts used to specify at each receipt the status of the container in which the specimen is shipped in chain of custody cases where specimens are moved from lab to lab.  If the container is compromised in any way (seal broken, container cracked or leaking, etc.), then this status needs to be recorded for legal reasons.  Used in the Specimen (SPM), Shipment (SHP) and Shipment Package (PAC) segments in HL7 Version 2.x messaging. |
| 0547 | Jurisdictional Breadth | description | Table of codes used to specify the breadth/extent of the jurisdiction where the qualification is valid. | Code system of concepts specifying the breadth/extent of the jurisdiction where the qualification is valid.  Used in HL7 Version 2 messaging in the CER segment. | Code system of concepts specifying the breadth/extent of the jurisdiction where the qualification is valid.  Used in HL7 Version 2 messaging in the CER segment. |
| 0548 | Signatory's Relationship to Subject | description | Table of codes used to specify the relationship of the consenter to the subject. | Code system of concepts specifying the relationship of the consenter to the subject.  Used in HL7 Version 2 messaging in the CON segment. | Code system of concepts specifying the relationship of the consenter to the subject.  Used in HL7 Version 2 messaging in the CON segment. |
| 0550 | Body Parts | description | HL7-defined table of codes used to specify the part of the body. | HL7-defined code system of concepts specifying the part of the body.  Used in HL7 Version 2 messaging in the RXR segment. | HL7-defined code system of concepts specifying the part of the body.  Used in HL7 Version 2 messaging in the RXR segment. |
| 0553 | Invoice Control Code | description | Table of codes used to specify what invoice action is being performed by this message. | Code system of concepts used to specify what action is being performed by this message.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify what action is being performed by this message.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. |
| 0554 | Invoice Reason Codes | description | Table of codes used to specify the reason for an invoice. | Code system of concepts used to specify the reason for this invoice.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the reason for this invoice.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. |
| 0555 | Invoice Type | description | Table of codes used to specify the type of invoice. | Code system of concepts used to specify the type of invoice.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the type of invoice.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. |
| 0556 | Benefit Group | description | Table of codes used to specify the benefit group. |  | Code system of concepts used to specify the benefit group.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. |
| 0557 | Payee Type | description | Table of codes used to specify the type of payee (e.g., organization, person). | Code system of concepts used to specify the type of payee (e.g., organization, person).  Used in the Payee Information (PYE) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the type of payee (e.g., organization, person).  Used in the Payee Information (PYE) segment in HL7 Version 2.x messaging. |
| 0558 | Payee Relationship to Invoice | description | Table of codes used to specify the relationship to the invoice for Person Payee Types. | Code system of concepts used to specify the relationship to the invoice for Person Payee Types.  Used in the Payee Information (PYE) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the relationship to the invoice for Person Payee Types.  Used in the Payee Information (PYE) segment in HL7 Version 2.x messaging. |
| 0559 | Product/Service Status | symbolicName | product-serviceStatus | Product-serviceStatus | ProductServiceStatus |
| 0559 | Product/Service Status | description | Table of codes used to specify the processing status for the Product/Service Code. | Code system of concepts used to specify the processing status for the Product/Service Code.  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the processing status for the Product/Service Code.  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. |
| 0560 | Quantity Units | codeSystemOID | - |  | 2.16.840.1.113883.18.455 |
| 0560 | Quantity Units | symbolicName | noObject |  | QuantityUnits |
| 0560 | Quantity Units | description | Table of codes that specify the adjustment quantity.  No suggested values. |  | HL7-defined code system of concepts specifying the adjustment quantity. |
| 0561 | Product/Services Clarification Codes | symbolicName | product-servicesClarification | Product-servicesClarification | ProductServicesClarification |
| 0561 | Product/Services Clarification Codes | description | Table of codes used to specify the Product/Service Code. | Code system of concepts used to specify the Product/Service Code.  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the Product/Service Code.  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. |
| 0562 | Processing Consideration Codes | description | Table of codes used to specify special processing requested of Payer for this Product/Service Line Item (e.g., hold until paper supporting documentation is received by Payer). | Code system of concepts used to specify special processing requested of Payer for this Product/Service Line Item (e.g., hold until paper supporting documentation is received by Payer).  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify special processing requested of Payer for this Product/Service Line Item (e.g., hold until paper supporting documentation is received by Payer).  Used in the Product/Service Line Item (PSL) segment in HL7 Version 2.x messaging. |
| 0564 | Adjustment Category Code | description | Table of codes used to specify the category of adjustment and is used to assist in determining which table is used for Adjustment Reason. | Code system of concepts used to specify the category of adjustment and is used to assist in determining which table is used for Adjustment Reason.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the category of adjustment and is used to assist in determining which table is used for Adjustment Reason.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. |
| 0565 | Provider Adjustment Reason Code | description | Table of codes used to specify the reason for this adjustment. | Code system of concepts used to specify the reason for this adjustment.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the reason for this adjustment.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. |
| 0566 | Blood Unit Type | description | HL7-defined table of codes used to specify the type of blood unit | HL7-defined code system of concepts used to specify the type of blood unit.  Used in the Blood Unit Information (BUI) segment in HL7 Version 2.x messaging. | HL7-defined code system of concepts used to specify the type of blood unit.  Used in the Blood Unit Information (BUI) segment in HL7 Version 2.x messaging. |
| 0569 | Adjustment Action | description | Table of codes used to specify the action requested of a party that receives an adjustment. | Code system of concepts used to specify the action requested of the party that receives an adjustment.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the action requested of the party that receives an adjustment.  Used in the Adjustment (ADJ) segment in HL7 Version 2.x messaging. |
| 0570 | Payment Method Code | description | Table of codes used to specify the method for the movement of payment. | Code system of concepts used to specify the method for the movement of payment.  Used in the Payment Information (PMT) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the method for the movement of payment.  Used in the Payment Information (PMT) segment in HL7 Version 2.x messaging. |
| 0571 | Invoice Processing Results Status | description | Table of codes used to specify the processing status for an Invoice Processing Result. | Code system of concepts used to specify the processing status for an Invoice Processing Result.  Used in the Invoice Processing Result (IPR) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the processing status for an Invoice Processing Result.  Used in the Invoice Processing Result (IPR) segment in HL7 Version 2.x messaging. |
| 0572 | Tax status | description | Table of codes used to specify the tax status of a provider. | Code system of concepts used to specify the tax status of the provider.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. | Code system of concepts used to specify the tax status of the provider.  Used in the Invoice (IVC) segment in HL7 Version 2.x messaging. |
| 0615 | User Authentication Credential Type Code | description | HL7-defined table of codes specifying a type of user authentication credential. | HL7-defined code system of concepts specifying a type of user authentication credential.  Used in HL7 Version 2.x messaging in the UAC segment. | HL7-defined code system of concepts specifying a type of user authentication credential.  Used in HL7 Version 2.x messaging in the UAC segment. |
| 0616 | Address Expiration Reason | description | Table of codes specifying the reason this address was marked as "ended". | Code system of concepts specifying the reason this address was marked as "ended".  Used in HL7 Version 2.x messaging in the XAD segment. | Code system of concepts specifying the reason this address was marked as "ended".  Used in HL7 Version 2.x messaging in the XAD segment. |
| 0617 | Address Usage | description | HL7-defined table of codes specifying how an address is intended to be used. | HL7-defined code system of concepts specifying how an address is intended to be used.  Used in HL7 Version 2.x messaging in the XAD segment. | HL7-defined code system of concepts specifying how an address is intended to be used.  Used in HL7 Version 2.x messaging in the XAD segment. |
| 0618 | Protection Code | description | Table of codes specifying that an address needs to be treated with special care or sensitivity. | Code system of concepts specifying that an address needs to be treated with special care or sensitivity. Used in HL7 Version 2.x messaging in the XAD and XTN segments. | Code system of concepts specifying that an address needs to be treated with special care or sensitivity. Used in HL7 Version 2.x messaging in the XAD and XTN segments. |
| 0625 | Item Status Codes | description | Table of codes specifying the state of an inventory item within the context of an inventory location. |  | Code system of concepts that identify the state of an inventory item within the context of an inventory location. Used in HL7 Version 2.x messaging in the IVT segment. |
| 0634 | Item Importance Codes | description | Table of codes that denote a level or importance of an inventory item within the context of an inventory location. |  | Code system of concepts that denote a level or importance of an inventory item within the context of an inventory location. Used in HL7 Version 2.x messaging in the IVT segment. |
| 0642 | Reorder Theory Codes | description | Table of codes specifying the calculation method used to determine the resupply schedule. | Code system of concepts that identify the calculation method used to determine the resupply schedule. Used in HL7 Version 2.x messaging in the IVT segment. | Code system of concepts that identify the calculation method used to determine the resupply schedule. Used in HL7 Version 2.x messaging in the IVT segment. |
| 0651 | Labor Calculation Type | description | Table of codes specifying the method used to calculate employee labor and measure employee productivity. | Code system of concepts that identify the method used to calculate employee labor and measure employee productivity. Used in HL7 Version 2.x messaging in the SCP segment. | Code system of concepts that identify the method used to calculate employee labor and measure employee productivity. Used in HL7 Version 2.x messaging in the SCP segment. |
| 0653 | Date Format | description | Table of codes specifying the date format for a decontamination/sterilization instance. | Code system of concepts that identify the date format for a decontamination/sterilization instance. Used in HL7 Version 2.x messaging in the SCP segment. | Code system of concepts that identify the date format for a decontamination/sterilization instance. Used in HL7 Version 2.x messaging in the SCP segment. |
| 0657 | Device Type | description | Table of codes specifying the kind of device as defined by the manufacturer. |  | Code system of concepts that idenfity the kind of device as defined by the manufacturer. Used in HL7 Version 2.x messaging in the SCP segment. |
| 0659 | Lot Control | description | Table of codes specifying whether the sterilization load for a device is built in the sub-sterile area adjacent to an Operating Room or the Central Processing Department. | Code system of concepts that define whether the sterilization load for a device is built in the sub-sterile area adjacent to an Operating Room or the Central Processing Department. Used in HL7 Version 2.x messaging in the SCP segment. | Code system of concepts that define whether the sterilization load for a device is built in the sub-sterile area adjacent to an Operating Room or the Central Processing Department. Used in HL7 Version 2.x messaging in the SCP segment. |
| 0667 | Device Data State | description | Table of codes specifying the state of the data as provided from a device. | Code system of concepts that define the state of the data as provided from a device. Used in HL7 Version 2.x messaging in the SDD segment. | Code system of concepts that define the state of the data as provided from a device. Used in HL7 Version 2.x messaging in the SDD segment. |
| 0669 | Load Status | description | Table of codes specifying the status of the information provided in a device sterilization or decontamination cycle. | Code system of concepts used to define the status of the information provided in a device sterilization or decontamination cycle. Used in HL7 Version 2.x messaging in the SDD segment. | Code system of concepts used to define the status of the information provided in a device sterilization or decontamination cycle. Used in HL7 Version 2.x messaging in the SDD segment. |
| 0682 | Device Status | description | Table of codes specifying the state of a device. | Code system of concepts that communicate the state of a device. Used in HL7 Version 2.x messaging in the SCD segment. | Code system of concepts that communicate the state of a device. Used in HL7 Version 2.x messaging in the SCD segment. |
| 0702 | Cycle Type | description | Table of codes specifying the type of cycle that is being executed.  A cycle type is a specific sterilization method used for a specific type of supply item. | Code system of concepts  specifying the type of cycle that is being executed.  A cycle type is a specific sterilization method used for a specific type of supply item.  Used in HL7 Version 2.x messaging in the SCD segment. | Code system of concepts  specifying the type of cycle that is being executed.  A cycle type is a specific sterilization method used for a specific type of supply item.  Used in HL7 Version 2.x messaging in the SCD segment. |
| 0717 | Access Restriction Value | description | Table of codes specifying the policies governing the information to which access is controlled. | Code system of concepts specifying the information to which access is restricted.  Used in HL7 Version 2.x messaging in the ARV segment.  Note that these new codes as of November 2018 have been temporarily loaded into this V2 code system pending availability of the currently unavailable new tooling, at which time this code systrem will be retired and a value set of codes from the HL7 V3 ActCode code system will be used instead for this table. | Code system of concepts specifying the information to which access is restricted.  Used in HL7 Version 2.x messaging in the ARV segment.  Note that these new codes as of November 2018 have been temporarily loaded into this V2 code system pending availability of the currently unavailable new tooling, at which time this code systrem will be retired and a value set of codes from the HL7 V3 ActCode code system will be used instead for this table. |
| 0728 | CCL Value | description | Table of codes specifying the clinical complexity level (CCL) value for the determined diagnosis related group (DRG) for this diagnosis.  US Realm. | Code system of concepts specifying the clinical complexity level (CCL) value for the determined diagnosis related group (DRG) for this diagnosis.  US Realm.  Used in HL7 Version 2.x messaging in the DG1 segment. | Code system of concepts specifying the clinical complexity level (CCL) value for the determined diagnosis related group (DRG) for this diagnosis.  US Realm.  Used in HL7 Version 2.x messaging in the DG1 segment. |
| 0731 | DRG Diagnosis Determination Status | description | HL7-defined table of codes specifying the status of a diagnosis for a diagnosis related group (DRG) determination. US Realm. | HL7-defined cCode system of concepts specifying the status of a diagnosis for a diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DG1 segment. | HL7-defined cCode system of concepts specifying the status of a diagnosis for a diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DG1 segment. |
| 0734 | Grouper Status | description | Table of codes specifying the status of a grouper in general. US Realm. | Code system of concepts specifying the status of a grouper in general.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the status of a grouper in general.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0739 | DRG Status Patient | description | Table of codes specifying whether the length of stay is normal or respectively shorter or longer than normal. | Code system of concepts specifying whether the length of stay is normal or respectively shorter or longer than normal. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying whether the length of stay is normal or respectively shorter or longer than normal. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0742 | DRG Status Financial Calculation | description | Table of codes specifying the status of the diagnosis related group (DRG) calculation regarding the financial aspects. US Realm. | Code system of concepts specifying the status of the diagnosis related group (DRG) calculation regarding the financial aspects.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the status of the diagnosis related group (DRG) calculation regarding the financial aspects.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0749 | DRG Grouping Status | description | Table of codes specifying the status of the use of the gender information for diagnosis related group (DRG) determination. US Realm. | Code system of concepts specifying the status of the use of the gender information for diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the status of the use of the gender information for diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0755 | Status Weight At Birth | description | Table of codes specifying the status of the use of the weight at birth for diagnosis related group (DRG) determination.  US Realm. | Code system of concepts specifying the status of the use of the weight at birth for diagnosis related group (DRG) determination.  US Realm.  Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the status of the use of the weight at birth for diagnosis related group (DRG) determination.  US Realm.  Used in HL7 Version 2.x messaging in the DRG segment. |
| 0757 | DRG Status Respiration Minutes | description | Table of codes specifying the status of the use of the respiration minutes information for diagnosis related group (DRG) determination.  US Realm. | Code system of concepts specifying the status of the use of the respiration minutes information for diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the status of the use of the respiration minutes information for diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0759 | Status Admission | description | Table of codes specifying the admission status for the diagnosis related group (DRG) determination. US Realm. | Code system of concepts specifying the admission status for the diagnosis related group (DRG) determination. US Realm. Used in HL7 Version 2.x messaging in the DRG segment. | Code system of concepts specifying the admission status for the diagnosis related group (DRG) determination. US Realm. Used in HL7 Version 2.x messaging in the DRG segment. |
| 0761 | DRG Procedure Determination Status | description | Table of codes specifying the status of the use of this particular procedure for the diagnosis related group (DRG) determination.  US Realm. | Code system of concepts specifying the status of the use of this particular procedure for the diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the PR1 segment. | Code system of concepts specifying the status of the use of this particular procedure for the diagnosis related group (DRG) determination.  US Realm. Used in HL7 Version 2.x messaging in the PR1 segment. |
| 0763 | DRG Procedure Relevance | description | Table of codes specifying the relevance of this particular procedure for the diagnosis related group (DRG) determination. US Realm. | Code system of concepts specifying the relevance of this particular procedure for the diagnosis related group (DRG) determination. US Realm. Used in HL7 Version 2.x messaging in the PR1 segment. | Code system of concepts specifying the relevance of this particular procedure for the diagnosis related group (DRG) determination. US Realm. Used in HL7 Version 2.x messaging in the PR1 segment. |
| 0776 | Item Status | description | Table of codes specifying the status (useful for reporting and item usage purposes) that applies to an item. | Code system of concepts specifying the status (useful for reporting and item usage purposes) that applies to an item. Used in HL7 Version 2.x messaging in the ITM segment. | Code system of concepts specifying the status (useful for reporting and item usage purposes) that applies to an item. Used in HL7 Version 2.x messaging in the ITM segment. |
| 0778 | Item Type | description | Table of codes specifying a classification of material items into like groups as defined and utilized within an operating room setting for charting procedures. | Code system of concepts specifying a classification of material items into like groups as defined and utilized within an operating room setting for charting procedures.  Used in HL7 Version 2.x messaging in the ITM segment. | Code system of concepts specifying a classification of material items into like groups as defined and utilized within an operating room setting for charting procedures.  Used in HL7 Version 2.x messaging in the ITM segment. |
| 0790 | Approving Regulatory Agency | description | Table of codes specifying the regulatory agency by which the item has been approved, such as the FDA or AMA. |  | Code system of concepts specifying the regulatory agency by which the item has been approved, such as the FDA or AMA. Used in HL7 Version 2.x messaging in the ITM segment. |
| 0793 | Ruling Act | description | Table of codes specifying an act containing a rule that the item is legally required to be included in notification reporting. |  | Code system of concepts specifying an act containing a rule that the item is legally required to be included in notification reporting.  Used in HL7 Version 2.x messaging in the ITM segment. |
| 0806 | Sterilization Type | description | Table of codes specifying the type of sterilization used for sterilizing the inventory supply item in the ITM segment. | Code system of concepts specifying the type of sterilization used for sterilizing the inventory supply item in the ITM segment.  Used in HL7 Version 2.x messaging in the  STZ segment. | Code system of concepts specifying the type of sterilization used for sterilizing the inventory supply item in the ITM segment.  Used in HL7 Version 2.x messaging in the  STZ segment. |
| 0818 | Package | description | Table of codes specifying the packaging unit in which this inventory supply item can be ordered or issued when purchased from the vendor in the related vendor segment. | Code system of concepts specifying the packaging unit in which this inventory supply item can be ordered or issued when purchased from the vendor in the related vendor segment.  Used in HL7 Version 2.x messaging in the PKG segment. | Code system of concepts specifying the packaging unit in which this inventory supply item can be ordered or issued when purchased from the vendor in the related vendor segment.  Used in HL7 Version 2.x messaging in the PKG segment. |
| 0820 | Gender Harmony Concepts | description | Table used to properly describe a person’s self-asserted attributes like gender identity, pronouns and sexual orientation. | See http://loinc.org for a detailed description; the HL70396 code for LOINC is ‘LN’ |  |
| 0823 | Sexual Orientation | description | Table to properly describe a person’s emotional, romantic, sexual, or affectional attraction to another person | Snomed CT |  |
| 0834 | MIME Types | description | Table of codes specifying the general type of data. | Code system of concepts specifying the general type of data.  Used in HL7 Version 2.x messaging in the RP and ED datatypes. | Code system of concepts specifying the general type of data.  Used in HL7 Version 2.x messaging in the RP and ED datatypes. |
| 0868 | Telecommunication Expiration Reason | description | Table of codes specifying the reason this contact number/email was marked as "ended". | Code system of concepts specifying the reason this contact number/email was marked as "ended".  Used in HL7 Version 2.x messaging in the XTN segment. | Code system of concepts specifying the reason this contact number/email was marked as "ended".  Used in HL7 Version 2.x messaging in the XTN segment. |
| 0871 | Supply Risk Codes | description | Table of codes specifying any known or suspected hazard associated with this material item. | Code system of concepts specifying any known or suspected hazard associated with this material item.  Used in HL7 Version 2.x messaging in the ITM segment. | Code system of concepts specifying any known or suspected hazard associated with this material item.  Used in HL7 Version 2.x messaging in the ITM segment. |
| 0881 | Role Executing Physician | description | Table of codes specifying the account role of the physician, for example, only billing for the professional part, the technical part or both. | Code system of concepts specifying the account role of the physician, for example, only billing for the professional part, the technical part or both.  Used in HL7 Version 2.x messaging in the PSL segment. | Code system of concepts specifying the account role of the physician, for example, only billing for the professional part, the technical part or both.  Used in HL7 Version 2.x messaging in the PSL segment. |
| 0882 | Medical Role Executing Physician | description | Table of codes specifying the role of the physician ("self-employed" or "employed"). | Code system of concepts specifying the role of the physician ("self-employed" or "employed").  Used in HL7 Version 2.x messaging in the PSL segment. | Code system of concepts specifying the role of the physician ("self-employed" or "employed").  Used in HL7 Version 2.x messaging in the PSL segment. |
| 0894 | Side of body | description | Table of codes specifying the side of the body ("left" or "right"). | Code system of concepts specifying the side of the body ("left" or "right").  Used in HL7 Version 2.x messaging in the PSL segment. | Code system of concepts specifying the side of the body ("left" or "right").  Used in HL7 Version 2.x messaging in the PSL segment. |
| 0904 | Security Check Scheme | description | HL7-defined table of codes specifying the scheme for the security check. | HL7-defined code system of concepts specifying the scheme for the security check.  Used in HL7 Version 2.x messaging in the CX datatypes and PPN and XCN segments. | HL7-defined code system of concepts specifying the scheme for the security check.  Used in HL7 Version 2.x messaging in the CX datatypes and PPN and XCN segments. |
| 0905 | Shipment Status | description | HL7-defined table of codes specifying the status of the shipment. | HL7-defined code system of concepts specifying the status of the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. | HL7-defined code system of concepts specifying the status of the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. |
| 0906 | ActPriority | description | HL7-defined table of codes specifying the priority for the shipment. | HL7-defined code system of concepts specifying the priority for the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. | HL7-defined code system of concepts specifying the priority for the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. |
| 0907 | Confidentiality | description | HL7-defined table of codes specifying the confidentiality for the shipment. | HL7-defined code system of concepts specifying the confidentiality for the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. | HL7-defined code system of concepts specifying the confidentiality for the shipment.  Used in HL7 Version 2.x messaging in the SHP segment. |
| 0909 | Patient Results Release Categorization Scheme | description | HL7-defined table of codes specifying the scheme for the patient results release categorization. | HL7-defined code system of concepts specifying the scheme for the patient results release categorization.  Used in HL7 Version 2.x messaging in the OBX segment. | HL7-defined code system of concepts specifying the scheme for the patient results release categorization.  Used in HL7 Version 2.x messaging in the OBX segment. |
| 0912 | Participation | description | HL7-defined table of codes that represent functional involvement of a caregiver or member of a care team with an activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.). | HL7-defined code system of concepts that represent functional involvement of a caregiver or member of a care team with an activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.).  Used in HL7 Version 2.x messaging in the PRT segment. | HL7-defined code system of concepts that represent functional involvement of a caregiver or member of a care team with an activity being transmitted (e.g., Case Manager, Evaluator, Transcriber, Nurse Care Practitioner, Midwife, Physician Assistant, etc.).  Used in HL7 Version 2.x messaging in the PRT segment. |
| 0914 | Root Cause | description | Table of codes specifying the root cause. | Code system of concepts specifying the root cause.  Used in HL7 Version 2.x messaging in the OBX segment. | Code system of concepts specifying the root cause.  Used in HL7 Version 2.x messaging in the OBX segment. |
| 0916 | Relevant Clinicial Information | description | Table of codes specifying additional clinical information about the patient or specimen to report the supporting and/or suspected diagnosis and clinical findings on requests for interpreted diagnostic studies. | Code system of concepts specifying additional clinical information about the patient or specimen to report the supporting and/or suspected diagnosis and clinical findings on requests for interpreted diagnostic studies. Used in HL7 Version 2.x messaging in the OBR segment. | Code system of concepts specifying additional clinical information about the patient or specimen to report the supporting and/or suspected diagnosis and clinical findings on requests for interpreted diagnostic studies. Used in HL7 Version 2.x messaging in the OBR segment. |
| 0917 | Bolus Type | description | HL7-defined table of codes specifying the type of bolus. | HL7-defined code system of concepts specifying the type of bolus.  Used in HL7 Version 2.x messaging in the RXV segment. | HL7-defined code system of concepts specifying the type of bolus.  Used in HL7 Version 2.x messaging in the RXV segment. |
| 0918 | PCA Type | description | HL7-defined table of codes specifying the type of PCA. | HL7-defined code system of concepts specifying the type of PCA.  Used in HL7 Version 2.x messaging in the RXV segment. | HL7-defined code system of concepts specifying the type of PCA.  Used in HL7 Version 2.x messaging in the RXV segment. |
| 0919 | Exclusive Test | description | HL7-defined table of codes that define if a test should be a specific event with no other tests to be performed with this test, or not, or other special circumstances. | HL7-defined code system of concepts that define if a test should be a specific event with no other tests to be performed with this test, or not, or other special circumstances.  Used in HL7 Version 2.x messaging in Master Files (OM1 segment) to characterize observations in a master of such orderables. | HL7-defined code system of concepts that define if a test should be a specific event with no other tests to be performed with this test, or not, or other special circumstances.  Used in HL7 Version 2.x messaging in Master Files (OM1 segment) to characterize observations in a master of such orderables. |
| 0920 | Preferred Specimen/Attribute Status | symbolicName | preferredSpecimen-AttributeStatus | PreferredSpecimen-AttributeStatus | PreferredSpecimenAttributeStatus |
| 0920 | Preferred Specimen/Attribute Status | description | HL7-defined table of codes that indicate whether a Specimen/Attribute is Preferred or Alternate for collection of a particular specimen. | HL7-defined code system of concepts that indicate whether a Specimen/Attribute is Preferred or Alternate for collection of a particular specimen.  Used in HL7 Version 2.x messaging in Master Files (OM4 segment) to characterize information about specimens that are associated with certain observations. | HL7-defined code system of concepts that indicate whether a Specimen/Attribute is Preferred or Alternate for collection of a particular specimen.  Used in HL7 Version 2.x messaging in Master Files (OM4 segment) to characterize information about specimens that are associated with certain observations. |
| 0921 | Certification Type Code | description | Table of codes specifying the code for the certification type. | Code system of concepts specifying the code for the certification type.  Used in HL7 Version 2.x messaging in the IN3 segment. | Code system of concepts specifying the code for the certification type.  Used in HL7 Version 2.x messaging in the IN3 segment. |
| 0922 | Certification Category Code | description | Table of codes specifying the code for the certification category. | Code system of concepts specifying the code for the certification category.  Used in HL7 Version 2.x messaging in the IN3 segment. | Code system of concepts specifying the code for the certification category.  Used in HL7 Version 2.x messaging in the IN3 segment. |
| 0923 | Process Interruption | description | HL7-defined table of codes specifying whether the process was interrrupted and whether the needle had been inserted in the donor's arm prior to the interruption. |  | HL7-defined code system of concepts specifying whether the process was interrrupted and whether the needle had been inserted in the donor's arm prior to the interruption.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0924 | Cumulative Dosage Limit UoM | description | Table of codes specifying the unit of measure (UoM) for the cumulative dosage limit. | Code system of concepts specifying the unit of measure (UoM) for the cumulative dosage limit.  Used in HL7 Version 2.x messaging in the CDO segment. | Code system of concepts specifying the unit of measure (UoM) for the cumulative dosage limit.  Used in HL7 Version 2.x messaging in the CDO segment. |
| 0925 | Phlebotomy Issue | description | HL7-defined table of codes specifying the phlebotomy issue. | HL7-defined code system of concepts specifying the phlebotomy issue.  Used in HL7 Version 2.x messaging in the DON segment. | HL7-defined code system of concepts specifying the phlebotomy issue.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0926 | Phlebotomy Status | description | HL7-defined table of codes specifying the status of the phlebotomy. | HL7-defined code system of concepts specifying the status of the phlebotomy.  Used in HL7 Version 2.x messaging in the DON segment. | HL7-defined code system of concepts specifying the status of the phlebotomy.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0927 | Arm Stick | description | HL7-defined table of codes specifying the arm(s) receiving the stick. | HL7-defined code system of concepts specifying the arm(s) receiving the stick.  Used in HL7 Version 2.x messaging in the DON segment. | HL7-defined code system of concepts specifying the arm(s) receiving the stick.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0933 | Intended Procedure Type | description | HL7-defined table of codes specifying the type of intended procedure. | HL7-defined code system of concepts specifying the type of intended procedure.  Used in HL7 Version 2.x messaging in the DON segment. | HL7-defined code system of concepts specifying the type of intended procedure.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0935 | Process Interruption Reason | description | HL7-defined table of codes specifying the reason for the process interruption. | HL7-defined code system of concepts specifying the reason for the process interruption.  Used in HL7 Version 2.x messaging in the DON segment. | HL7-defined code system of concepts specifying the reason for the process interruption.  Used in HL7 Version 2.x messaging in the DON segment. |
| 0936 | Observation Type | description | HL7-defined table of codes specifying types of observations to enable systems to distinguish between observations sent along with an order, versus observations sent as the result to an order. | HL7-defined code system of concepts specifying types of observations to enable systems to distinguish between observations sent along with an order, versus observations sent as the result to an order. Used in HL7 Version 2.x messaging in the OBX segment. | HL7-defined code system of concepts specifying types of observations to enable systems to distinguish between observations sent along with an order, versus observations sent as the result to an order. Used in HL7 Version 2.x messaging in the OBX segment. |
| 0937 | Observation Sub-Type | description | HL7-defined table of codes specifying the observation sub-type. | HL7-defined code system of concepts specifying the observation sub-type.  Used in HL7 Version 2.x messaging in the OBX segment. | HL7-defined code system of concepts specifying the observation sub-type.  Used in HL7 Version 2.x messaging in the OBX segment. |
| 0938 | Collection Event/Process Step Limit | description | HL7-defined table of codes specifying the limit for the collection event or process step. | HL7-defined code system of concepts specifying the limit for the collection event or process step.  Used in HL7 Version 2.x messaging in the OMC segment. | HL7-defined code system of concepts specifying the limit for the collection event or process step.  Used in HL7 Version 2.x messaging in the OMC segment. |
| 0939 | Communication Location | description | HL7-defined table of codes specifying the communication location. | HL7-defined code system of concepts specifying the communication location.  Used in HL7 Version 2.x messaging in the OMC segment. | HL7-defined code system of concepts specifying the communication location.  Used in HL7 Version 2.x messaging in the OMC segment. |
| 0940 | Limitation Type Codes | description | HL7-defined table of codes specifying the type of limitation. | HL7-defined code system of concepts specifying the type of limitation.  Used in HL7 Version 2.x messaging in the DPS segment. | HL7-defined code system of concepts specifying the type of limitation.  Used in HL7 Version 2.x messaging in the DPS segment. |
| 0942 | Equipment State Indicator Type Code | description | HL7-defined table of codes that specify the type of measurement of the state of an automated laboratory instrument. | HL7-defined code sytem of cocepts that specify the type of measurement of the state of an automated laboratory instrument. Used in HL7 Version 2.x messaging in the INV segment. | HL7-defined code sytem of cocepts that specify the type of measurement of the state of an automated laboratory instrument. Used in HL7 Version 2.x messaging in the INV segment. |
| 0945 | Auto-Dilution Type | symbolicName | auto-DilutionType | Auto-DilutionType | AutoDilutionType |
| 0945 | Auto-Dilution Type | description | Vendor-defined codes of the pre‑configured dilution to be applied on the instrument, which can be used instead of a numeric declaration. | Code system of vendor-defined codes that specify the pre‑configured dilution to be applied on the instrument, which can be used instead of a numeric declaration.  Used in Version 2 messaging in the TCD segment. | Code system of vendor-defined codes that specify the pre‑configured dilution to be applied on the instrument, which can be used instead of a numeric declaration.  Used in Version 2 messaging in the TCD segment. |
| 0946 | Supplier Type | description | Table of codes specifying the type of supplier that will distribute the supply items associated to a contract number. | Code system that Identifies the type of supplier that will distribute the supply items associated to a contract number.  Used in HL7 Version 2.x messaging in the CTR segment. | Code system that Identifies the type of supplier that will distribute the supply items associated to a contract number.  Used in HL7 Version 2.x messaging in the CTR segment. |
| 0948 | Relationship Type | symbolicName | v2CS-relationshipType | V2CS-relationshipType | V2CSRelationshipType |
| 0948 | Relationship Type | description | HL7-defined table of codes specifying the type of relationship identified by Relationship Instance Identifier (REL-3) that is established between the Source Information Instance (REL-4)  and the Target Information Instance (REL-5). | HL7-defined code system of concepts that identify the type of relationship identified by Relationship Instance Identifier (REL-3) that is established between the Source Information Instance (REL-4)  and the Target Information Instance (REL-5). | HL7-defined code system of concepts that identify the type of relationship identified by Relationship Instance Identifier (REL-3) that is established between the Source Information Instance (REL-4)  and the Target Information Instance (REL-5). |
| 0949 | Order Control Code Reason | description | HL7-defined table of codes that describe reasons for the chosen order control codes – this table is extensible; while these codes are intended to be generally useful, they were developed to cover situations for replacement orders (ORC-1 = RO) and recommendations for replacement orders (ORC-1 = RP) | HL7-defined code system of concepts that describe reasons for the chosen order control codes. Used in HL7 Version 2 messaging in the ORC segment. | HL7-defined code system of concepts that describe reasons for the chosen order control codes. Used in HL7 Version 2 messaging in the ORC segment. |
| 0950 | Order Status Modifier | description | HL7-defined table of codes used to further define the status identified in ORC-5 | HL7-defined code system of concepts used to further define the status identified in ORC-5.  Used in HL7 Version 2 messaging in the ORC segment. | HL7-defined code system of concepts used to further define the status identified in ORC-5.  Used in HL7 Version 2 messaging in the ORC segment. |
| 0951 | Reason for Study | description | HL7-defined table of codes that provide additional information to the universal service identifier on why a test, study or review was ordered. Current suggested values are in support of the IHE LCC LAB-7 transaction. | HL7-defined code system of concepts that provide additional information to the universal service identifier on why a test, study or review was ordered. Initial values are to support the IHE LCC LAB-7 transaction. | HL7-defined code system of concepts that provide additional information to the universal service identifier on why a test, study or review was ordered. Initial values are to support the IHE LCC LAB-7 transaction. |
| 0970 | Online Verification Result | description | Result Code of the online verification of insurance data | Code values used to indicate the result of an online verification of insurance data. | Code values used to indicate the result of an online verification of insurance data. |
| 0971 | Online Verification Result Error Code | description | Error Code of the online verification of insurance data | Code values representing a type of error from a failed operation to perform online verification of insurance data. | Code values representing a type of error from a failed operation to perform online verification of insurance data. |

## Three-Way Presence Overview

| Category | Count | Description |
|----------|-------|-------------|
| all_sources | 367 | Table with CodeSystem in all three sources |
| ch02c_and_colleague | 7 | In CH02C and Colleague but not UTG |
| ch02c_and_utg | 31 | In CH02C and UTG but not Colleague |
| colleague_and_utg | 0 | In Colleague and UTG but not CH02C |
| ch02c_only | 392 | Only in CH02C (not in Colleague or UTG) |
| colleague_only | 0 | Only in Colleague |
| utg_only | 18 | Only in UTG |

## Tables in CH02C and Colleague — Missing from UTG

These tables are in both the published standard and colleague's IG but have no CodeSystem in UTG/THO.

| Table | Name | Type | CH02C Codes | Colleague Codes |
|-------|------|------|-------------|-----------------|
| 0338 | Practitioner ID Number Type | User | 12 | 12 |
| 0411 | Supplemental Service Information Values | User | 2 | 2 |
| 0459 | Reimbursement Action Code | External | 4 | 4 |
| 0460 | Denial or Rejection Code | User | 3 | 3 |
| 0725 | Mood Codes | HL7 | 9 | 9 |
| 0820 | Gender Harmony Concepts | External | 3 | 3 |
| 0823 | Sexual Orientation | HL7-EXT | 5 | 5 |

## Tables Only in UTG

These tables have a CodeSystem in UTG but are not in CH02C or the colleague's IG.

| Table | Name | UTG Codes |
|-------|------|-----------|
| 0012 | stockLocation | 2 |
| 0033 | route | 28 |
| 0034 | siteAdministered | 2 |
| 0048 | whatSubjectFilter | 38 |
| 0070 | specimenSourceCodes | 137 |
| 0102 | delayedAcknowledgmentType | 2 |
| 0106 | queryResponseFormat | 3 |
| 0107 | deferredResponseType | 2 |
| 0108 | queryResultsLevel | 4 |
| 0109 | reportPriority | 2 |
| 0156 | whichDate-timeQualifier | 7 |
| 0157 | whichDate-timeStatusQualifier | 6 |
| 0158 | date-timeSelectionQualifier | 4 |
| 0290 | mimeBase64EncodingCharacters | 65 |
| 0323 | actionCodes | 4 |
| 0524 | sequenceCondition | 3 |
| 0529 | precision | 6 |
| 4000 | name-addressRepresentation | 3 |
