# V2+ IG Structural Comparison: Findings for V2 Management Review

This document summarizes findings from a systematic comparison of the V2+ FHIR Implementation Guide resources against V2.9.1 Word document extractions. Items flagged here require discussion with the V2 Management Group to determine the correct resolution.

---

## 1. Conformance Length: Bare `=` Without Numeric Value

### Finding

10 data type components in V2.9.1 Chapter 2A have a conformance length value of just `=` (no numeric length). Per a strict reading of clause 2.4.5.3, this is not valid — a conformance length should be a numeric value optionally followed by `=` or `#` to indicate truncation behavior.

However, the intent is clear: _"whatever value was received, it is never acceptable to truncate it, regardless of length."_

### Affected Components

| Data Type | Component | Conf Length | Section |
|-----------|-----------|-------------|---------|
| CP | .3 From Value | `=` | HL7 Component Table – CP – Composite Price |
| CP | .4 To Value | `=` | HL7 Component Table – CP – Composite Price |
| ERL | .1 Segment ID | `=` | HL7 Component Table – ERL – Message Location |
| ERL | .2 Segment Sequence | `=` | HL7 Component Table – ERL – Message Location |
| ERL | .3 Field Position | `=` | HL7 Component Table – ERL – Message Location |
| ERL | .4 Field Repetition | `=` | HL7 Component Table – ERL – Message Location |
| ERL | .5 Component Number | `=` | HL7 Component Table – ERL – Message Location |
| ERL | .6 Sub-Component Number | `=` | HL7 Component Table – ERL – Message Location |
| MO | .1 Quantity | `=` | HL7 Component Table – MO – Money |
| MOP | .2 Money or Percentage Quantity | `=` | HL7 Component Table – MOP – Money or Percentage |

### FHIR Representation Problem

The V2+ IG represents conformance length using a complex extension (`http://hl7.org/v2/StructureDefinition/conformance-length`) with two sub-extensions:

- `length` (valueInteger) — the numeric conformance length
- `noTruncate` (valueBoolean) — `true` for `=`, `false` for `#`

Currently, the extension cannot express "never truncate" without also specifying a numeric length, because both sub-extensions are treated as a pair. These 10 components therefore have no conformance-length extension at all in the FHIR resources.

### Questions for V2 Management

1. **Is bare `=` a valid conformance length value?** If so, clause 2.4.5.3 should be updated to document this usage.
2. **What is the intended semantic?** Our interpretation: "the receiver must accept and store the full value without truncation, regardless of actual length." Is this correct?
3. **Should the FHIR extension be restructured?** One option: allow `noTruncate` to appear without `length`, meaning "no truncation permitted; no specific conformance length defined." This would require updating the extension StructureDefinition to make `length` optional.

---

## 2. Events: Retained / Withdrawn Without Extractable Definitions

### Finding

30 events in the FHIR StructureDefinitions exist in V2.9.1 only as "retained for backward compatibility" or "withdrawn" references. The V2.9.1 Word documents contain no message structure tables or acknowledgment choreography tables for these events — they point readers to older versions of the standard or to other chapters.

These events exist as FHIR StructureDefinitions but their content (message structures, segments used, acknowledgment choreography) cannot be verified against V2.9.1 source material.

### Affected Events

| Event | Chapter | Status | Description |
|-------|---------|--------|-------------|
| A18 | CH03 | Withdrawn v2.3.1/v2.7 | ADT/ACK — Merge Patient Information |
| A19 | CH03 | Withdrawn v2.4/v2.7 | QRY/ADR — Patient Query (Original Mode) |
| A30 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Merge Person Information |
| A34 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Merge Patient Info (Patient ID Only) |
| A35 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Merge Patient Info (Account Number Only) |
| A36 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Merge Patient Info (Patient ID & Account Number) |
| A39 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Merge Person – Patient ID |
| A46 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Change Patient ID |
| A48 | CH03 | Withdrawn v2.3.1 | ADT/ACK — Change Alternate Patient ID |
| I05 | CH11 | Removed v2.8 | RQC/RCI — Request for Patient Clinical Information |
| I06 | CH11 | Removed v2.8 | RQC/RCL — Request/Receipt of Clinical Data Listing |
| M01 | CH08 | Withdrawn v2.7 | MFN/MFK — Master File Notification |
| M03 | CH08 | Withdrawn v2.7 | MFN/MFK — Master File Notification – Test/Observation |
| N01 | CH14 | Withdrawn v2.5 | NMQ — Application Management Query |
| P04 | CH06 | Retained v2.4 | QRY/DSR — Generate Bills and AR Statements |
| P09 | CH06→CH07 | Withdrawn v2.7 | Product Experience (CH06 refers to CH07) |
| PC4 | CH12 | Retained v2.4 / removed v2.8 | QRY — Patient Care Problem Query |
| PC5 | CH12 | Retained v2.4 / removed v2.8 | PRR — Patient Problem Response |
| PC9 | CH12 | Retained v2.4 / removed v2.8 | QRY — Patient Goal Query |
| PCA | CH12 | Retained v2.4 / removed v2.8 | PPV — Patient Goal Response |
| PCE | CH12 | Retained v2.4 / removed v2.8 | QRY — Patient Pathway (Problem-Oriented) Query |
| PCF | CH12 | Retained v2.4 / removed v2.8 | PTR — Patient Pathway (Problem-Oriented) Response |
| PCK | CH12 | Retained v2.4 / removed v2.8 | QRY — Patient Pathway (Goal-Oriented) Query |
| PCL | CH12 | Retained v2.4 / removed v2.8 | PPT — Patient Pathway (Goal-Oriented) Response |
| R02 | CH07 | Withdrawn | QRY/ORF — Query for Results of Observation |
| R04 | CH07 | Withdrawn | QRY/ORF — Query for Results of Observation |
| R21 | CH07 | Withdrawn v2.5/v2.7 | OUL — Unsolicited Laboratory Observation |
| S25 | CH10 | Withdrawn v2.7 | SQM/SQR — Schedule Query and Response |
| T12 | CH09 | Withdrawn v2.7 | QRY/DOC — Document Query |
| V01 | CH04A | Withdrawn v2.4/v2.7 | XQ — Query for Vaccination Record |
| V02 | CH04A | Withdrawn | VXX — Response to Vaccination Query |
| V03 | CH04A | Withdrawn v2.4/v2.7 | VXR — Vaccination Record Response |

### Questions for V2 Management

1. **Should withdrawn/removed events remain in the V2+ IG?** If yes, their definitions would need to be sourced from the version where they were last active (e.g., V2.3.1, V2.4, V2.7).
2. **For events removed as of v2.8, is "retained for backward compatibility" still the correct status in V2+?** Or should they be marked as withdrawn?

---

## 3. Z Events and Z Segments

### Finding

Several Z-prefixed events and structures appear in the V2.9.1 documents as example / template content:

- **ZNN / Znn** (CH05): Template placeholder for user-defined queries. Appears in multiple acknowledgment choreography tables and message structure captions as `QBP^Znn^QBP_Qnn`.
- **Z01, Z02** (CH02): Example events used in the HL7 Acknowledgment Choreography Example section (Widget Request/Response).
- **Z85, Z86, Z95, Z96** (CH05): Query grammar examples for specific query profiles.

In the FHIR resources, some of these are represented as real events with sub-variants (ZNN_A through ZNN_F), while others (Z85, Z95) are not represented at all.

### Questions for V2 Management

1. **Should Z events/structures be included in the V2+ IG?** Z messages are user-defined by convention and not part of the base standard. The ones in V2.9.1 appear to be illustrative examples.
2. **If included, how should they be marked?** As examples? As templates? With a specific extension indicating they are user-defined?
3. **The FHIR resources have ZNN sub-variants (ZNN_A through ZNN_F) — is this the intended representation?** Or should there be a single ZNN template?

---

## 4. Event O59: One Event Code, Two Message Types

### Finding

Event O59 is used by two different message types with two different message structures:

| Message | Structure | Chapter | Clause | Description |
|---------|-----------|---------|--------|-------------|
| OML^O59 | OML_O59 | CH04 (Orders) | Table 50 | Laboratory Order Message |
| RCV^O59 | RCV_O59 | CH04A (Orders) | Table 38 | Pharmacy/Treatment Dispense Message |

In HL7 V2, a message is identified by the combination of message type + trigger event (e.g., OML^O59 and RCV^O59 are distinct messages). The message structures (OML_O59 and RCV_O59) are different and correctly defined. However, the event code O59 is shared between them.

In the current FHIR representation, there are no O59 event StructureDefinitions. Instead, there are sub-variants `O59_A` and `O59_B`, apparently one for each message type. This is an artifact of the encoding tool — it could not represent a single event code associated with two different message types.

### The Problem

Event StructureDefinitions link event → message → message structure. A single event StructureDefinition for O59 cannot point to two different message structures. The sub-variant approach (O59_A, O59_B) works mechanically but is not standard V2 naming.

### Questions for V2 Management

1. **Is it valid for two different message types to share the same event code?** This appears to be an anomaly in the standard.
2. **What is the correct representation?** Options include:
   - A single O59 event that references both messages (requires an extension or multi-valued link)
   - Two sub-variant events (O59_A, O59_B) — current FHIR approach
   - Rename one of the events to a different code
3. **Are there other cases of shared event codes?** If so, a consistent policy is needed.

---

## 5. Events I12–I15: Missing FHIR Event Definitions

### Finding

Events I12 through I15 are defined in CH11 (Patient Referral) and used by two message types:

| Message | Structure | Chapter | Clause | Description |
|---------|-----------|---------|--------|-------------|
| REF^I12–I15 | REF_I12 | CH11 | 11.5.1, Table 27 | Patient Referral |
| RRI^I12–I15 | RRI_I12 | CH11 | 11.5.2, Table 29 | Return Referral Information |

All four events (I12, I13, I14, I15) share the same message structures (REF_I12 and RRI_I12). The FHIR resources include the message structures but no individual event StructureDefinitions for I12–I15.

### Resolution

FHIR event StructureDefinitions should be created for I12, I13, I14, and I15, each linking to both message types (REF and RRI) and their respective structures (REF_I12 and RRI_I12).

---

## 6. Other Events in V291 Not in FHIR

### Finding

Additional event codes extracted from V2.9.1 have no corresponding FHIR StructureDefinition:

| Event | Chapter | Source | Explanation |
|-------|---------|--------|-------------|
| YYY | CH02 | Ack table | Placeholder example (XXX^YYY^ZZZ) from Control chapter |
| Z01, Z02 | CH02 | Ack table / caption | Widget example events |
| Z86, Z96 | CH05 | Caption | Query grammar examples |
| ZNN / Znn | CH05 | Ack table / caption | User-defined query template |

These are all examples, templates, or user-defined event codes — not base standard events.

---

## 7. Message Structure Comparison Findings

### Finding

A field-level comparison of 415 FHIR message structures against V2.9.1 Word document extractions found 565 discrepancies:

| Category | Count | Description |
|----------|-------|-------------|
| **Cosmetic** | 272 | Whitespace, capitalization, punctuation, abbreviation differences — auto-resolvable |
| **FHIR-only segments** | 67 | Segments in FHIR not found in V291 (PRT=18, NTE=16, CTI=4, others) |
| **Group nesting** | 155 | Different grouping of segments (mostly anonymous groups in financial/claims structures) |
| **Repetition** | 28 | Disagreements on whether a segment repeats (e.g., ERR in ACK) |
| **Description** | 23 | Meaningful differences in segment descriptions |
| **Optionality** | 13 | Required vs optional disagreements |
| **V291-only segments** | 7 | Segments in V291 not found in FHIR |

3 structures (CCM_I21, CCR_I16, CCU_I20 from CH11) were skipped due to truncated V291 extraction.

Full report: `v291-extracted/message-structure-comparison-report.html`

### Notable Patterns

- **ACK ERR repetition**: V291 Chapter 5 defines ERR as `[ ERR ]` (non-repeating) while most other chapters use `[{ ERR }]` (repeating). This inconsistency in the standard produces repetition mismatches across ACK sub-variants.
- **PRT segments**: 18 PRT (Participation) segments appear in FHIR but not V291. These may be intentional additions or extraction gaps.
- **FIXME group names**: 5 group names in MDM_T02 FHIR structures are set to "FIXME" — these need correction.

### Questions for V2 Management

1. **ERR in ACK**: Should ERR be repeating (`[{ ERR }]`) or non-repeating (`[ ERR ]`) in the ACK structure? The standard is inconsistent across chapters.
2. **PRT additions**: Are the 18 FHIR-only PRT segments intentional additions to V2+, or should they be verified against a later version of the standard?

---

## 8. Varies Data Type: Contextual Typing in FHIR

### Finding

Five segment fields use data type "Varies" — meaning their actual data type is determined at runtime by the value of another field:

| Segment | Field | Controlling Field | Chapter | Semantics |
|---------|-------|--------------------|---------|-----------|
| OBX | .5 Observation Value | OBX-2 Value Type (table 0125) | CH07 | Enumerated: NM, CWE, DTM, ST, TX, ED, etc. |
| MFE | .4 Primary Key Value | MFE-5 Primary Key Value Type | CH08 | Any type, determined by master file definition |
| MFA | .5 Primary Key Value | MFA-3 (inherits from MFE) | CH08 | Same as MFE.4 |
| QPD | .3–N User Parameters | Query definition | CH05 | Variable number of fields, each with variable type |
| RDT | .1 Column Value | RDF column definitions | CH05 | Type per column, determined by preceding RDF segment |

The previous FHIR representation incorrectly classified Varies as a Segment StructureDefinition (in `segment/segments/Varies.json` with `Segment-Profile`). This has been corrected: Varies is now a data type StructureDefinition derived from Base, marked as abstract, in `data-type/Varies.json`.

### Open Questions

1. **OBX-5**: The allowed types are enumerated in table 0125 (Value Type). Should OBX.5 use a FHIR choice type listing these explicitly, or is the abstract Varies reference sufficient?
2. **QPD.3–N**: The current FHIR representation has a single QPD.3 element with `max: "1"`. The real QPD allows fields 3 through N (variable count, variable types). This likely needs a repeating element with `max: "*"`. FHIR logical models do preserve element order, so ordering semantics are maintained. However, the semantic that each position may have a _different_ type is not expressible in a single repeating element.
3. **RDT.1**: Similar to QPD — variable number of columns, each with its own type defined by the RDF segment. Same representation challenge.

---

## 9. Hxx: "Any Segment or Segment Group" Placeholder

### Finding

The Hxx placeholder appears in 4 message structures in CH12 (Patient Care):

| Structure | Chapter | Context |
|-----------|---------|---------|
| PGL_PC6 | CH12, Table 3 | ORDER_DETAIL CHOICE: `OBR \| Hxx` |
| PPG_PCG | CH12 | ORDER_DETAIL CHOICE: `OBR \| Hxx` |
| PPP_PCB | CH12 | ORDER_DETAIL CHOICE: `OBR \| Hxx` |
| PPR_PC1 | CH12 | ORDER_DETAIL CHOICE: `OBR \| Hxx` |

In all cases, Hxx appears as an alternative to OBR in a choice group, with description "etc." It means: "the order detail could be an OBR, or it could be some other segment (or group of segments) that we are not enumerating."

### FHIR Representation

For the "any segment" case, the abstract Segment base type (`http://hl7.org/v2/StructureDefinition/Segment`) can be referenced. This is already defined in `meta-resources/segment--segment.json`.

The "any segment group" case is harder. FHIR uses BackboneElement for segment groups, but an unconstrained BackboneElement reference would allow arbitrary content. Options:

1. **Constrain BackboneElement**: Define a constraint that says the BackboneElement can only contain elements whose type is either a Segment or a recursive instance of the same BackboneElement (i.e., segments and nested groups of segments).
2. **Leave unconstrained**: Accept that Hxx is inherently open-ended and document the intent without formal constraints.
3. **Use Extension**: Add an extension on the Hxx element indicating "any segment or segment group" semantics.

### Questions for V2 Management

1. **Is "any segment or segment group" the correct interpretation of Hxx?** Or does it specifically mean "any order-detail-like segment" (a narrower set)?
2. **Should the V2+ IG attempt to constrain what Hxx allows?** Or is it intentionally unconstrained?

---

## 10. Choice Groups in Message Structures

### Finding

22 V2.9.1 message structures use choice groups (denoted by `<`, `|`, `>` markers) where exactly one of several segment alternatives must appear. These are found in:

| Chapter | Structures | Example |
|---------|-----------|---------|
| CH11 (Patient Referral) | CCR_I16 | `< OBR \| RXO \| ODS \| PR1 >` |
| CH12 (Patient Care) | PGL_PC6, PPG_PCG, PPP_PCB, PPR_PC1 | `OBR \| Hxx` |
| CH16 (Claims/Reimbursement) | EHC_E01, E02, E04, E15, E20, E21, E24, QBP_E03, E22, RSP_E03, E22 | Various product/service choices |
| CH17 (Sterilization) | SDR_S31, SDR_S32 | Device data alternatives |

Individual choices within a choice group may themselves be groups of more than one segment.

The current FHIR representation uses numbered anonymous BackboneElement groups (e.g., `1-Group`, `2-Group`) within a CHOICE BackboneElement. This is structurally correct but the naming convention ("1-Group") is a FHIR encoding artifact, not a V2 construct.

### Questions for V2 Management

1. **Is the FHIR CHOICE/numbered-Group representation adequate?** Or should there be a more explicit extension or naming convention for V2 choice groups?
2. **Are there choice groups where individual alternatives are multi-segment groups?** (The extraction data suggests yes — e.g., CCR_I16 in CH11.)

---

## 11. Segment Field Data Quality (Previously Resolved)

For reference, 1,109 segment field corrections were applied across 145 FHIR JSON files based on V2.9.1 comparison. Key categories:

- 494 active fields with `max: 0` restored to repeating
- 104 W (withdrawn) fields normalized with `standards-status: withdrawn`
- 36 B (backward compatible) fields normalized with `standards-status: deprecated`
- 320 conformance length flag corrections
- 39 length min/max corrections

These are documented in ADR-0005 and the segment comparison report at `v291-extracted/segment-comparison-report.html`.

---

## 12. Data Type Component Conformance Length (Previously Resolved)

71 conformance length flag corrections were applied across 26 FHIR complex data type files. In all cases, V2.9.1 specified `#` (truncation permitted) but FHIR had `noTruncate: true` (no truncation). The 10 bare `=` cases described in Section 1 remain unresolved.

---

## 13. ACK Structure Collapse and Scheduling Outlier

### Finding

The ACK (General Acknowledgment) message structure appears **115 times** across V2.9.1 (one per event using a standard acknowledgment response). After normalizing description text, ERR cardinality, and one extraction artifact (NMD_N02 caption-reuse), **114 of the 115 occurrences are now structurally identical** with the canonical 5-segment shape:

| # | Segment | Description |
|---|---------|-------------|
| 1 | `MSH` | Message Header |
| 2 | `[{ SFT }]` | Software (optional, repeating) |
| 3 | `[ UAC ]` | User Authentication Credential (optional, non-repeating) |
| 4 | `MSA` | Message Acknowledgment |
| 5 | `[{ ERR }]` | Error (optional, repeating) |

The single outlier is **clause 10.4 (`ACK^S12-S24, S26, S27`)** — scheduling acknowledgments — where `UAC` is encoded as `[{ UAC }]` (optional + repeating) rather than `[ UAC ]`. We have flagged this as **REVIEW-0001**.

### FHIR Representation

The 115 enumerated `ACK-A` ... `ACK-DK` StructureDefinitions in V2+ have been collapsed into two:

- `ACK` — the canonical structure used by 279 ACK message definitions
- `ACK-Scheduling` — a provisional name for the outlier referenced by 15 message definitions (`ACK-S12` ... `ACK-S24`, `ACK-S26`, `ACK-S27`). This name is intentionally placeholder and will not survive without V2 Management endorsement.

The 113 unreferenced `ACK-*` files have been moved out of `input/sourceOfTruth/` and are no longer published.

### Caption-Description Variants (Exemplars)

Most ACK captions read `ACK^XXX^ACK: General Acknowledgment`. Seven occurrences use a different caption description — these may be intentional refinements or simply chapter-author drift:

| Caption description | Exemplar clauses |
|---------------------|------------------|
| `Acknowledgment` (no "General") | CH07 §7.3.5 (`ACK^R31`) |
| `General Acknowledgement` (British spelling) | CH13 §13.3.1 (`ACK^U01`) |
| `Observation Message` | CH07 §7.3.1 (`ACK^R01`), §7.3.4 (`ACK^R30`), §7.3.6 (`ACK^R32`) |
| `Anti-Microbial Device Data Request Response` | CH17 §17.5.4 (`ACK^S31`) |
| `Anti-Microbial Device Cycle Data Request Response` | CH17 §17.5.5 (`ACK^S32`) |

### Questions for V2 Management

1. **Is the `[{ UAC }]` repetition in clause 10.4 intentional** for scheduling acknowledgments, or a typo? If a typo, we collapse all 115 ACKs into one canonical structure. If intentional, we keep `ACK-Scheduling` as a permanent variant (and pick a real name for it).
2. **Are the seven non-standard caption descriptions intentional?** (e.g., "Observation Message" in CH07 may signal a domain-specific ACK contract.) If not, normalize all captions to "General Acknowledgment".
3. **NMD_N02 §14.3.2 second table**: a structure captioned `ACK^N02^ACK` was extracted under `structureId=NMD_N02` because the Word doc reused the prior caption. We have reclassified it as a standard ACK (5-segment shape, matches the 114). Confirm this is correct.

---

## 14. NTE Description Form in MDM_T01/T02 (CH09)

### Finding

The NTE segment is described inconsistently across CH09 occurrences of `MDM_T01` and `MDM_T02`. Same segment, same role within the structure (notes attached to OBR/OBX), four different phrasings:

| Form | Example text | Frequency |
|------|--------------|-----------|
| **Short** | `"Notes and comments about the OBR"` | 5 of 6 `MDM_T01`; 4 of 5 `MDM_T02` (most occurrences) |
| **Long** | `"Notes and comments about the observation request (OBR)"` | 1 of 6 `MDM_T01` (clause 9.6.1) |
| **Variant ("observation")** | `"Notes and comments about the observation (OBR)"` / `"... (OBX)"` | 1 of 5 `MDM_T02` (clause 9.6.2) |
| **Variant ("segment for")** | `"Notes and comments segment for OBX"` | 1 of 5 `MDM_T02` (clause 9.6.4) |

### Question for V2 Management

Pick a single canonical phrasing for use in V2+. Recommend either:

- **Short** (`"Notes and comments about the OBR"` / `"... about the OBX"`) — matches majority usage, terse, refers by segment code.
- **Long** (`"Notes and comments about the observation request (OBR)"`) — more descriptive for readers unfamiliar with segment codes; one well-formed example in clause 9.6.1.

The remaining variants (`"about the observation (OBR)"`, `"segment for OBX"`) should be dropped regardless.

---

## 15. `GUARANTOR_INSURANCE` Group Name in RQI_I01

### Finding

The group surrounding `GT1`, `IN1`, `IN2`, `IN3` in `RQI_I01` is named four times in CH11 with two different separators:

| Clause | Group name |
|--------|------------|
| 11.3.1 | `GUARANTOR_INSURANCE` |
| 11.3.2 | `GUARANTOR_INSURANCE` |
| 11.3.3 | `GUARANTOR+INSURANCE` (note the `+`) |
| 11.3.7 | `GUARANTOR_INSURANCE` |

The `+` character is not used as a group-name separator anywhere else in the V2.9.1 standard. All other compound group names use `_` (e.g., `PATIENT_VISIT`, `ORDER_DETAIL_SUPPLEMENT`).

### Question for V2 Management

Is the `+` in clause 11.3.3 a typo (Word document drift), or is it semantically meaningful (e.g., concatenation, parallel structure)? Recommend treating as a typo and standardizing all four occurrences to `GUARANTOR_INSURANCE`.

---

## 16. `...` Segment Placeholder Unification with `Hxx`

### Finding

The V2.9.1 standard uses the literal token `...` (three dots) as an "any segment / variable" placeholder in several message structures across multiple chapters. In the V2.9.1 source it appears as:

1. An entry in the segments registry (V2 segments CodeSystem) with display `"Variable"`
2. A row in 11 message structure tables, including:

| Chapter | Message Structure | Element position | Description |
|---------|------------------|------------------|-------------|
| CH05 | `QBP_Q11-A`, `-B`, `-C`, `-D`, `-E` | `.6-QBP.1-...` | "Optional query by example segments" |
| CH05 | `QBP_Q15` | `.5-...` | "Optional query by example segments" |
| CH05 | `QVR_Q17` | `.5-QBP.1-...` | "Optional query by example segments" |
| CH05 | `RSP_K11` | `.8-SEGMENT_PATTERN.1-...` | (no description in source) |
| CH05 | `RSP_Znn` | `.8-...` | "(additional segments according to the data to be produced)" |
| CH05 | `RTB_Knn` | `.8-...` | (description not yet recovered) |
| CH08 | `MFN_Znn` | `.5-MF_SITE_DEFINED.2-...` | "One or more HL7 and/or Z-segments carrying the data for the entry identified in the MFE segment" |

### Problem with literal `...`

In FHIR `StructureDefinition` element ids and paths, the literal `...` was carried through verbatim:

```
"id":   "MFN_Znn.5-MF_SITE_DEFINED.2-..."
"path": "MFN_Znn.5-MF_SITE_DEFINED.2-..."
"type": [ { "code": "http://hl7.org/v2/StructureDefinition/..." } ]
```

The IG Publisher splits element paths on `.` to walk the parent hierarchy. The literal `...` produces empty path segments, causing snapshot generation to fail with errors of the form:

> *Unable to find parent path `X.Y.Z-..` for element `X.Y.Z-..`*

This blocked the IG build entirely. (Same class of bug as the previously-resolved `Varies` data type, whose id was originally `"..."` and broke Jekyll for the same reason.)

### Action taken

The fix substitutes the existing `Hxx` placeholder (already used by 4 CH12 message structures: `PGL_PC6`, `PPG_PCG`, `PPP_PCB`, `PPR_PC1`) for the literal `...`:

| Change | Files affected | Detail |
|--------|----------------|--------|
| Replace `...` placeholder with `Hxx` in element id, path, and type code | 11 message structures (the table above) | One-shot script: `tooling/scripts/fix_dots_placeholder.py` (idempotent, has `--dry-run`) |
| Fix cardinality on `MFN_Znn.5-MF_SITE_DEFINED.2` only | `MFN_Znn.json` | `max: "1"` → `max: "*"` — the description explicitly says "one or more". Cardinality on the other 10 was left as-is because the descriptions are weaker ("Optional", `null`, etc.) and per-file investigation is warranted. |
| Remove `...` code from segments CodeSystem | `meta-resources/segment--v2-cs-segments.json` | The `{"code": "...", "display": "Variable"}` entry removed; `Hxx` was already present with display `"Any segment or segment group"` |
| Remove dangling `StructureDefinition/...` reference from segments control manifest | `control-manifests/segments.json` | Hxx already present in the manifest, so the `...` reference was simply removed |

### Questions for V2 Management

1. **Is `Hxx` semantically equivalent to the V2.9.1 `...` notation across all 11 message structures?** Both are open-ended segment placeholders, but `Hxx` was introduced in CH12 with description `"etc."` whereas `...` in the segments registry has display `"Variable"`. The descriptions on the affected elements range from "Optional query by example segments" (CH05 query patterns) to "One or more HL7 and/or Z-segments carrying the data for the entry identified in the MFE segment" (CH08 MFN_Znn). The V2 Management Group should confirm whether unifying these two notations is correct everywhere, or whether some uses of `...` deserve a distinct placeholder (e.g., a query-specific placeholder, a site-defined placeholder).
2. **Should the `...` segment-registry entry remain in any V2.9.1-faithful representation?** The V2.9.1 standard does enumerate `...` as a segment-table entry; removing it from the FHIR CodeSystem is a forward-looking simplification, not a faithful reproduction.
3. **Was the original `max: "1"` on `MFN_Znn.5-MF_SITE_DEFINED.2` an intentional constraint or a typo?** The description explicitly says "one or more". Treating it as a typo and fixing to `max: "*"`, but flagging in case the cardinality was meant to be tighter than the description implies.
4. **What should the cardinality of the other 10 `...`/`Hxx` placeholders be?** Most are currently `min: 0, max: "1"`, but the surrounding descriptions ("Optional query by example segments", "additional segments") suggest repeating semantics. Per-file review needed; we have not changed cardinality on these without committee input.
5. **`RSP_K11.8-SEGMENT_PATTERN.1` has `null` short and definition.** The V2.9.1 source apparently provided no caption text for this row. Should it be filled in (and if so, with what), or is `null` faithful to the standard?
6. **`RTB_Knn.8` description was not recovered during extraction.** Currently `"DESCRIPTION NEEDED"`. Should be captured during the next V2.9.1 extraction pass; flagging here as a known gap.

### Provenance

These changes were made to unblock the auto-IG build (which had failed twice in succession with the snapshot-generation error above — first on `MFN_Znn`, then on `QBP_Q11-A`). They are reversible — see commit history on `dev/framework`. The `Hxx` substitution was chosen over alternatives (e.g., creating new chapter-specific placeholders, leaving the elements unconstrained) because it reuses an existing convention already present in CH12 message structures, minimizing the surface area of the fix and the number of new V2 Management questions raised.

---

## Methodology

All findings are based on automated extraction from V2.9.1 Word documents (`v2plus_docx/*.docx`) using `tooling/scripts/extract_v291.py`, compared against FHIR StructureDefinitions in `input/sourceOfTruth/`. Comparison scripts:

- `tooling/scripts/compare_segments.py` — 9-dimension segment field comparison
- `tooling/scripts/compare_data_types.py` — 7-dimension data type component comparison
- `tooling/scripts/structural_inventory.py` — artifact-level gap analysis
- `tooling/scripts/compare_message_structures.py` — message structure content comparison
- `tooling/scripts/generate_event_gap_report.py` — event gap HTML report

Reports are in `v291-extracted/`:
- `structural-inventory.md` / `.json` — overview of all artifact types
- `segment-comparison-report.html` — navigable segment field comparison
- `data-type-comparison-report.md` / `.json` — data type component comparison
- `message-structure-comparison-report.html` — message structure content comparison
- `event-gap-report.html` — event gap analysis with chapter/clause references
