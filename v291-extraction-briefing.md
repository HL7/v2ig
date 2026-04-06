# V2.9.1 Content Extraction — Session Briefing

## Objective

Extract structured, machine-readable content from the HL7 V2.9.1 specification (Word documents) into a canonical intermediate format. This extracted data will serve as:

1. **The authoritative reference** for populating FHIR StructureDefinition resources in the v2ig project
2. **A validation layer** for cross-checking the ~1,779 existing FHIR JSON resources already generated
3. **A content source** for normative text, field names, and other metadata currently missing from the FHIR resources

## Why This Is Needed

The v2ig project (`/workspace`) converts the HL7 V2+ standard into a FHIR Implementation Guide. The existing FHIR JSON resources in `/workspace/input/sourceOfTruth/` were previously generated from Word documents, but the conversion was lossy. Known gaps include:

- **Segment field names missing**: The `short` field in segment StructureDefinitions contains only codes like "MSH-1" instead of the standard field name "Field Separator". Complex data types have proper names (e.g., XPN has "Family Name", "Given Name") but segments do not. There are 192 segments with ~2,900 fields total.
- **Data element definitions empty**: `/workspace/input/sourceOfTruth/data-element/` exists but is completely empty.
- **Data quality issues**: `valueInteger` fields contain boolean values (`false`/`true`) instead of integers (`0`/`1`). Extension URLs use wrong namespace (`http://hl7.org/fhir/` vs `http://hl7.org/v2/`). These are systematic across all 192 segment files and 419 message structure files.
- **Normative text incomplete**: Field definitions contain raw Word artifacts (e.g., `E:\\V2\\v2.9 final Nov from Frank\\V29_CH02C_Tables.docx#HL70361`).
- **No AsciiDoc content for segments**: The `website/data_structures/` directory has data type AsciiDoc content but no segment content.

## Source Material

The user has:
- **PDF files** of all V2.9.1 chapters
- **Microsoft Word documents** of all V2.9.1 chapters

Word documents are the preferred extraction source — they preserve structural metadata (styles, tables, headings) that PDFs lose.

### V2.9.1 Chapter Structure (for reference)

The V2 standard is organized into chapters. Key chapters for extraction:

| Chapter | Content | Priority |
|---------|---------|----------|
| 2 | Control (MSH, MSA, ERR segments; message processing rules) | High |
| 2C | Code Tables (value sets / vocabulary) | High |
| 3 | Patient Administration (ADT segments: PID, PV1, NK1, EVN, etc.) | High |
| 4 | Order Entry (ORC, OBR segments) | High |
| 7 | Observation Reporting (OBX, OBR) | High |
| 5 | Query | Medium |
| 6 | Financial Management | Medium |
| 8 | Master Files | Medium |
| 9 | Medical Records | Medium |
| 10 | Scheduling | Medium |
| 11 | Patient Referral | Medium |
| 12 | Patient Care | Medium |
| 13 | Clinical Laboratory Automation | Low |
| 14 | Application Management | Low |
| 15 | Personnel Management | Low |
| 16 | E-Commerce | Low |
| 17 | Materials Management | Low |

## Extraction Targets

For each chapter, extract the following structured data:

### 1. Segment Definitions
For each segment (e.g., MSH, PID, OBX):
- Segment code and name (e.g., MSH = "Message Header")
- Purpose/description text
- For each field:
  - **Field number** (e.g., 1, 2, 3)
  - **Field name** (e.g., "Field Separator", "Encoding Characters") — THIS IS THE CRITICAL MISSING DATA
  - **Data type** (e.g., ST, HD, MSG)
  - **Optionality** (R, O, C, W, B, X)
  - **Cardinality** (min/max repetitions)
  - **Length** (min/max)
  - **Value set / table binding** (e.g., Table 0361)
  - **Definition text** (normative description)
  - **Data element number** (the numeric code from the DataElements CodeSystem)

### 2. Data Type Definitions
For each data type (primitive and complex):
- Type code and name
- For complex types, each component with name, type, optionality, length

### 3. Message Definitions
For each message type and trigger event:
- Event code and name (e.g., A01 = "Admit/Visit Notification")
- Message type (e.g., ADT)
- Message structure reference
- Acknowledgment choreography

### 4. Message Structures
For each message structure (e.g., ADT_A01):
- Ordered list of segments with grouping, optionality, and repetition

### 5. Value Sets / Tables
For each HL7 table:
- Table number and name
- Table type (HL7, User, External)
- Code values with display text and definitions

### 6. Normative Text
- Chapter narrative content (descriptions, rules, usage notes)
- Field-level usage notes and examples

## Proposed Output Format

A directory of JSON files organized by extraction category:

```
v291-extracted/
├── metadata.json              # Extraction metadata, version, date
├── segments/
│   ├── MSH.json               # One file per segment
│   ├── PID.json
│   └── ...
├── data-types/
│   ├── primitives/
│   │   ├── ST.json
│   │   └── ...
│   └── complex/
│       ├── XPN.json
│       └── ...
├── messages/
│   ├── ADT-A01.json
│   └── ...
├── message-structures/
│   ├── ADT_A01.json
│   └── ...
├── events/
│   ├── A01.json
│   └── ...
├── tables/
│   ├── 0001.json
│   └── ...
└── narrative/
    ├── chapter-02.json         # Normative text by chapter
    └── ...
```

### Example Segment Output (segments/MSH.json)

```json
{
  "code": "MSH",
  "name": "Message Header",
  "chapter": 2,
  "description": "The MSH segment defines the intent, source, destination, and some specifics of the syntax of a message.",
  "fields": [
    {
      "sequence": 1,
      "name": "Field Separator",
      "dataElement": 1,
      "dataType": "ST",
      "optionality": "R",
      "cardinality": { "min": 1, "max": 1 },
      "length": { "min": 1, "max": 1 },
      "table": null,
      "definition": "This field contains the separator between the segment ID and the first real field..."
    },
    {
      "sequence": 3,
      "name": "Sending Application",
      "dataElement": 3,
      "dataType": "HD",
      "optionality": "O",
      "cardinality": { "min": 0, "max": 1 },
      "length": null,
      "table": "0361",
      "definition": "This field uniquely identifies the sending application..."
    }
  ]
}
```

## Existing FHIR Resources for Cross-Reference

The existing FHIR JSON files live at:
- Segments: `/workspace/input/sourceOfTruth/segment/segments/` (192 files)
- Complex data types: `/workspace/input/sourceOfTruth/data-type/complex/complex-data-types/` (71 files)
- Primitive data types: `/workspace/input/sourceOfTruth/data-type/primitive/primitives/` (12 files)
- Messages: `/workspace/input/sourceOfTruth/message/messages/` (697 files)
- Message structures: `/workspace/input/sourceOfTruth/message-structure/message_structures/` (419 files)
- Events: `/workspace/input/sourceOfTruth/event/events/` (356 files)

These can be used to validate extraction output and identify discrepancies.

## Technical Approach

### Phase 1: Word Document Analysis
- Examine the Word document structure (heading styles, table formats)
- Identify consistent patterns for segment definitions, field tables, data type tables
- Determine which Python libraries work best (python-docx for .docx, or pandoc for conversion)

### Phase 2: Extraction Script Development
- Build parsers for each content type (segments, data types, messages, etc.)
- Start with one high-value chapter (Chapter 2 or 3) as a proof of concept
- Validate extracted data against existing FHIR JSON resources

### Phase 3: Full Extraction
- Run extraction across all chapters
- Generate cross-reference report: extracted vs. existing FHIR resources
- Identify gaps, mismatches, and data quality issues

### Phase 4: Validation Report
- Produce a diff report comparing extracted content to existing FHIR JSON
- Flag specific issues (missing field names, wrong data types, incorrect optionality)
- Quantify the scope of corrections needed

## Resolved Information

- **Word document location**: `/workspace/v2plus_docx/`
- **Format**: .docx

## Critical Extraction Rules

### 1. NEVER Deduplicate — Capture Every Instance

The V2.9.1 standard contains known errors. Multiple messages may reference the same message structure name, but each occurrence of that structure in the standard may differ. **Do NOT assume that structures sharing a name are identical.** Every occurrence must be captured separately with full provenance metadata so that downstream analysis can detect and reconcile differences.

This applies to message structures specifically but the principle extends to all extracted content: if something appears more than once, capture every instance independently.

### 2. Traceability / Provenance Metadata

Every extracted data structure must include metadata recording exactly where in the standard it was found:
- **Chapter number** (e.g., 2, 3, 4)
- **Section/heading** within the chapter
- **Page or paragraph context** where feasible
- **Source file name** (the specific .docx file)

This provenance metadata is essential for later analysis, error detection, and reconciliation.

### 3. Preserve Associations Between Related Structures

Extracted data must preserve the relationships between related structures as they exist in the source material:
- Segments → fields → data types → components
- Messages → message structures → segment groups → segments
- Messages → trigger events → acknowledgment choreography
- Events → associated messages and acknowledgment patterns
- Fields → value set / table bindings
- Data elements → their parent segments and data types

These associations are partly inherent in the data structure hierarchy, but explicit cross-references (e.g., a field referencing a table number or data type code) must also be captured faithfully.

## Remaining Questions

1. Are all chapters in separate documents, or is there a single consolidated document?
2. Which chapter should we start with for the proof of concept?
3. Should the extraction output go into this same repository or a separate one?
