# Representative Resource Subset — TASK-002

**Date:** 2026-02-25
**Purpose:** A minimal set of FHIR resources covering all resource types, used for rapid development and testing. Built around the ADT^A01 (Admit/Visit Notification) message flow.

---

## Subset Contents (74 files total)

### Primitive Data Types (7)
ST, ID, IS, NM, DT, DTM, SI

These are the most commonly referenced primitive types in V2 segment field definitions. They cover string, identifier, numeric, and date/time patterns.

### Complex Data Types (11)
CWE, CX, XPN, XAD, HD, PL, XTN, AD, XON, MSG, EI

Selected to cover key V2 patterns:
- **CWE** — Coded with Exceptions (most common coded type)
- **CX** — Extended Composite ID (patient identifiers)
- **XPN** — Extended Person Name
- **XAD** — Extended Address
- **HD** — Hierarchic Designator (facility/application IDs)
- **PL** — Person Location
- **XTN** — Extended Telecommunication Number
- **AD** — Address (simpler than XAD)
- **XON** — Extended Composite Name and ID for Organizations
- **MSG** — Message Type
- **EI** — Entity Identifier

All 11 have corresponding AsciiDoc content in `website/data_structures/data_types/complex/`.

### Segments (38)
All segments referenced by the ADT_A01-A message structure, plus MSA and ERR for the ACK:

MSH, EVN, PID, PD1, PV1, PV2, NK1, AL1, OBX, DG1, GT1, IN1, IN2, IN3,
SFT, UAC, ARV, ROL, PRT, DB1, IAM, DRG, PR1, ACC, UB1, UB2, PDA,
GSP, GSR, GSC, OH1, OH2, OH3, OH4, AUT, RF1, MSA, ERR

### Message Structures (2)
- **ADT_A01-A** — Full admit message structure (38 segments, including groups: NEXT_OF_KIN, OBSERVATION, PROCEDURE, INSURANCE with nested AUTHORIZATION and REFERRAL)
- **ACK-A** — Simple acknowledgement structure (MSH, SFT, UAC, MSA, ERR)

### Messages (2)
- **ADT-A01** — Admit/Visit Notification message
- **ACK-A01** — Acknowledgement for ADT-A01

### Events (1)
- **A01** — Admit/Visit Notification event

### Supporting Files (13)
Profile definitions, base StructureDefinitions, CodeSystems, and ValueSets for each resource type category. Required as foundational resources.

---

## Why ADT^A01?

ADT^A01 is the most commonly used V2 message type (Admit/Visit Notification). It exercises:
- Many segments (38 in the -A variant)
- Nested segment groups (BackboneElement patterns)
- Required and optional segments with various cardinalities
- Both active and backward-compatible segments
- References to diverse data types
- Acknowledgement choreography
- A simple counterpart (ACK) for contrast

---

## AsciiDoc Content Coverage

| Resource Type | AsciiDoc Available | Notes |
|--------------|-------------------|-------|
| Complex data types | Yes (all 11) | In `website/data_structures/data_types/complex/` with component subdirectories |
| Primitive data types | No | No AsciiDoc content exists for primitives |
| Segments | No | No segment-specific AsciiDoc found in `website/` |
| Messages/Events | Varies | Domain-specific content in `website/domains/` |

This means the subset is suitable for testing the AsciiDoc→HTML pipeline for complex data types, but segment and primitive type descriptions are currently only in the FHIR JSON `definition` fields.

---

## Notable Findings

1. **Legacy Word references in definitions:** Some FHIR resource `definition` fields contain Word document file paths (e.g., `file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\...`). These need cleanup.

2. **Data type references are by short code:** Segment fields reference data types by short code (e.g., `"code": "CWE"`) not by full URL. The IG Publisher needs to resolve these.

3. **Segment groups use BackboneElement:** Nested groups in message structures (NEXT_OF_KIN, OBSERVATION, PROCEDURE, INSURANCE) use `"code": "BackboneElement"` as their type.

4. **FIXME in message definitions:** The ADT-A01 message definition has `"description": "FIXME"`.

---

## Subset Management

The subset is defined in `tooling/scripts/subset.rb`. Use:
```bash
ruby tooling/scripts/subset.rb list       # Show contents
ruby tooling/scripts/subset.rb validate   # Check completeness
```
