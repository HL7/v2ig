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

## 8. Segment Field Data Quality (Previously Resolved)

For reference, 1,109 segment field corrections were applied across 145 FHIR JSON files based on V2.9.1 comparison. Key categories:

- 494 active fields with `max: 0` restored to repeating
- 104 W (withdrawn) fields normalized with `standards-status: withdrawn`
- 36 B (backward compatible) fields normalized with `standards-status: deprecated`
- 320 conformance length flag corrections
- 39 length min/max corrections

These are documented in ADR-0005 and the segment comparison report at `v291-extracted/segment-comparison-report.html`.

---

## 9. Data Type Component Conformance Length (Previously Resolved)

71 conformance length flag corrections were applied across 26 FHIR complex data type files. In all cases, V2.9.1 specified `#` (truncation permitted) but FHIR had `noTruncate: true` (no truncation). The 10 bare `=` cases described in Section 1 remain unresolved.

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
