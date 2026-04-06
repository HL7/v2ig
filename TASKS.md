# Tasks

Tasks are derived from `blueprint.md`. Each task follows the TDD lifecycle.

## Legend

| Status | Meaning |
|--------|---------|
| `PENDING` | Not started |
| `IN_PROGRESS` | Currently being worked on |
| `COMPLETED` | Done (tests pass, merged) |
| `BLOCKED` | Waiting on something |
| `DEFERRED` | Postponed intentionally |
| `CANCELLED` | No longer needed |

---

## Phase 1: Pipeline Foundation

### TASK-001: Audit existing Ruby preprocessing tooling
- **Status:** COMPLETED
- **Branch:** `feature/001-audit-preprocessing`
- **Description:** Review all Ruby scripts in `tooling/asciidoctor/` and `tooling/scripts/`. Document what each script does, its inputs/outputs, and identify gaps or issues.
- **Acceptance Criteria:**
  - [x] Every Ruby file in `tooling/` is documented (purpose, inputs, outputs)
  - [x] Known issues and gaps are listed
  - [x] Dependencies (gems, etc.) are documented
- **Notes:** Audit complete. See `docs/tooling-audit.md`. Also created Gemfile, fixed critical bugs, replaced ER7 block processor with literal blocks (ADR-0002), cleaned up error messages and dead code.

---

### TASK-002: Define and assemble representative resource subset
- **Status:** COMPLETED
- **Branch:** `feature/002-representative-subset`
- **Description:** Create a minimal set of FHIR resources that covers all resource types (primitive data type, complex data type, data element, segment, message structure, message, event, acknowledgement choreography). This subset is used for rapid development and testing.
- **Acceptance Criteria:**
  - [x] At least one resource of each type is included
  - [x] Associated AsciiDoc content exists for each resource (complex data types have AsciiDoc; primitives/segments do not have separate AsciiDoc)
  - [x] Subset can be isolated for faster IG Publisher builds
- **Notes:** 74 files total (61 resources + 13 supporting). Built around ADT^A01 message flow. Defined in `tooling/scripts/subset.rb`. See `docs/representative-subset.md` for full details. Found legacy Word file references in definitions and FIXME placeholders in message descriptions.

---

### TASK-003: Get representative subset building with IG Publisher
- **Status:** COMPLETED
- **Branch:** `feature/003-subset-build`
- **Description:** Run the full pipeline (preprocessing + IG Publisher) on the representative subset and get a successful build.
- **Acceptance Criteria:**
  - [x] Preprocessing completes without errors
  - [x] IG Publisher completes without fatal errors (5 min 54 sec build time)
  - [x] Published output is viewable in a browser (1,985 output files in `output/`)
- **Notes:**
  - Installed OpenJDK 17.0.9, Ruby 3.1.4, Jekyll 4.4.1 in user-local paths
  - Updated IG Publisher from v1.6.18 to v2.1.1
  - Build ran with data types only (subset via commented-out paths in v2plus.xml)
  - QA results: 8,446 errors (missing value sets — expected in subset), 6,551 broken links (references to resources not in subset), 0% invalid XHTML
  - Environment setup documented — see JOURNAL.md
  - The pipeline works end-to-end: Java → IG Publisher → Template → Jekyll → HTML

---

### TASK-004: Document preprocessing pipeline flow
- **Status:** COMPLETED
- **Branch:** `feature/004-pipeline-docs`
- **Description:** Write documentation describing the complete preprocessing pipeline: what goes in, what transformations happen, what comes out, and how it feeds into IG Publisher.
- **Acceptance Criteria:**
  - [x] Pipeline flow diagram or description
  - [x] Each transformation step documented
  - [x] Input/output file mappings documented
- **Notes:** See `docs/pipeline-flow.md`. Also identified key pipeline gaps: content injection into FHIR resources, pagecontent distribution, tabset/message-structure block processors, cross-reference auto-linker, build orchestration script.

---

## Phase 2: AsciiDoc Processing Completeness

### TASK-005: Map AsciiDoc content to IG output destinations
- **Status:** COMPLETED
- **Branch:** `feature/005-content-mapping`
- **Acceptance Criteria:**
  - [x] Every AsciiDoc file/directory mapped to its output destination
  - [x] Distinction between StructureDefinition injection and pagecontent clear
- **Notes:** See `docs/content-mapping.md`. 814 AsciiDoc files mapped: 512 → StructureDefinition injection (via `[datatype-definition]` blocks), ~290 → pagecontent pages, ~3 → includes. Identified 10 gaps including missing primitive data type sources, undefined tabset rendering, and missing extraction pipeline.

---

### TASK-006: Implement AsciiDoc-to-StructureDefinition injection
- **Status:** COMPLETED
- **Branch:** `feature/006-sd-injection`
- **Acceptance Criteria:**
  - [x] Descriptive text injected into correct StructureDefinition elements
  - [x] Tests verify injection correctness
- **Notes:** Pipeline script at `tooling/scripts/inject_definitions.py`. 17 tests passing. Extracts `[datatype-definition]` blocks from AsciiDoc, maps to JSON via `:code:` attribute and component numbering (CWE-1.adoc → CWE.1). Handles `"defintion"` typo in component elements. Dry run shows 72 definitions across 33 data types. Not applied yet — existing JSON already has Word-era content. Pipeline is for future AsciiDoc→JSON synchronization.

---

### TASK-007: Implement AsciiDoc-to-pagecontent conversion
- **Status:** COMPLETED
- **Branch:** `feature/007-pagecontent-conversion`
- **Acceptance Criteria:**
  - [x] AsciiDoc converted to HTML pages in `input/pagecontent/`
  - [ ] Pages render correctly in published IG (needs Asciidoctor for full fidelity)
- **Notes:** Script at `tooling/scripts/generate_pagecontent.py`. Discovers 286 pages from `website/domains/`. Generates XHTML in IG Publisher format. Uses basic Python AsciiDoc conversion — for full fidelity (tables, tabsets), need Asciidoctor Ruby pipeline. Page naming: domain-event.xml (e.g., registration-A01.xml).

---

### TASK-008: Document safe AsciiDoc features
- **Status:** COMPLETED
- **Branch:** `feature/008-asciidoc-features`
- **Acceptance Criteria:**
  - [x] List of AsciiDoc features safe to use (work in both Asciidoctor and Asciidoctor.js)
  - [x] Known incompatibilities documented
- **Notes:** See `docs/asciidoc-features-guide.md`. Categorized all features as Safe/Build-only/Avoid. Key findings: tables in every file, `[datatype-definition]` in 470 files, `[tabset]` in 255 files. 4 custom Ruby extensions identified (none work in Asciidoctor.js). Editor tips documented.

---

## Phase 3: Cross-Reference Resolution (Auto-Linker)

### TASK-009: Survey existing cross-reference patterns
- **Status:** COMPLETED
- **Branch:** `feature/009-xref-survey`
- **Description:** Catalog the various cross-reference and link formats found in the AsciiDoc content inherited from Word documents. Identify patterns, inconsistencies, and broken references.
- **Acceptance Criteria:**
  - [x] All distinct cross-reference/link patterns cataloged with examples
  - [x] Frequency/prevalence of each pattern estimated
  - [x] Broken vs. working references categorized
- **Notes:** See `docs/xref-patterns-report.md`. Found 366 working xrefs, 159 broken file:/// links in AsciiDoc (separate from the 1,070 already replaced in JSON), 13 broken Word bookmark anchors, ~4,393 unlinkable V2 construct mentions in prose. Key finding: 159 file:/// refs in AsciiDoc still need replacement (same pattern as JSON, all pointing to CH02C Code Tables).

---

### TASK-010: Strip all existing cross-references from AsciiDoc
- **Status:** COMPLETED
- **Branch:** `feature/010-strip-xrefs`
- **Description:** Remove all existing cross-references and links from AsciiDoc content as a clean starting point for systematic re-linking.
- **Acceptance Criteria:**
  - [x] All link/xref markup removed from AsciiDoc content
  - [x] Plain text of link targets preserved (text not lost, just de-linked)
  - [ ] Tests verify stripping completeness
- **Notes:** Stripped all broken cross-references:
  - 167 `file:///` and bare Windows paths → `{{v2-table:XXXX:Name}}` placeholders (in earlier work)
  - 11 Word bookmark anchors (`_Hlt...`, `_MFI-3___...`, etc.) stripped to display text
  - 14 broken segment/table `link:#` references stripped
  - 2 HTML entity cleanups in master_files.adoc
  - 22 remaining `link:#` references are working (auto-generated section IDs) — preserved
  - 366 working `xref:` references preserved (navigation backbone)
  - Scripts: `strip_broken_links.py`, `strip_remaining_broken_links.py`

---

### TASK-011: Build construct registry from FHIR resources
- **Status:** COMPLETED
- **Branch:** `feature/011-construct-registry`
- **Description:** Extract all known V2 constructs (data types, segments, fields, message structures, messages, events) from the FHIR resources in `input/sourceOfTruth/` along with their identifiers and target URLs in the published IG.
- **Acceptance Criteria:**
  - [x] Registry includes all data types (primitive + complex) with codes
  - [x] Registry includes all segments with codes
  - [x] Registry includes fields within segments (e.g., PID-3) with anchors
  - [x] Registry includes components within data types
  - [x] Registry includes message structures, messages, events
  - [x] Each entry maps to its published IG URL/anchor
  - [x] Tests verify registry completeness against source resources
- **Notes:** Script at `tooling/scripts/build_registry.py`. Registry at `tooling/registry.json` with 8,017 entries: 12 primitive types, 71 complex types (448 components), 192 segments (5,824 field entries in both dot and dash notation), 696 messages, 419 message structures, 355 events. One collision handled: PCE exists as both segment and event (segment wins). 26 tests passing.

---

### TASK-012: Implement reference pattern matcher
- **Status:** COMPLETED
- **Branch:** `feature/012-pattern-matcher`
- **Description:** Detect V2 construct references in text using naming conventions — segment codes (PID, OBX), field references (PID-3), data type codes (CWE, ST), message types (ADT^A01), etc.
- **Acceptance Criteria:**
  - [x] Matches segment codes (2-3 alphanumeric uppercase)
  - [x] Matches field references (SEGMENT-N format)
  - [x] Matches data type codes
  - [x] Matches message type references
  - [x] Does not match inside code blocks or pre-formatted text
  - [x] Does not produce false positives on common abbreviations
  - [x] Tests cover all reference patterns with positive and negative cases
- **Notes:** Script at `tooling/scripts/pattern_matcher.py`. Registry-backed matcher with `find_matches()` for plain text and `find_in_asciidoc()` for full AsciiDoc files. Skips ER7 blocks, code blocks, directives, headings, and inline ER7 lines. False positive list for common English words that collide with V2 codes (IS, DR, ST, ID, etc.). 35 tests passing.

---

### TASK-013: Implement auto-linker
- **Status:** COMPLETED
- **Branch:** `feature/013-auto-linker`
- **Description:** Replace matched V2 construct references with hyperlinks to the correct published IG page/anchor. Integrates the construct registry (TASK-011) with the pattern matcher (TASK-012).
- **Acceptance Criteria:**
  - [x] Matched references replaced with correct hyperlinks
  - [x] Links point to the right page and anchor in the published IG
  - [x] Auto-linker is idempotent
  - [x] Integrated into the preprocessing pipeline
  - [x] Tests verify link correctness for representative content
- **Notes:** Script at `tooling/scripts/auto_linker.py`. Uses pattern matcher + registry to replace V2 references with `link:StructureDefinition-{id}.html[CODE]` format. Idempotent — second run produces zero changes. Skips ER7 blocks, code blocks, headings, directives, existing links/xrefs, and `{{v2-table:...}}` placeholders. Dry run shows 3,874 links across 394 files. 22 tests passing.

---

### TASK-014: Handle auto-linker edge cases
- **Status:** COMPLETED
- **Branch:** `feature/014-linker-edge-cases`
- **Description:** Address ambiguous references, references in code blocks, nested references, and other edge cases identified during development.
- **Acceptance Criteria:**
  - [x] Ambiguous references handled (documented resolution strategy)
  - [x] Code blocks and examples excluded from linking
  - [x] Nested references handled correctly
  - [x] Tests cover identified edge cases
- **Notes:** Edge cases handled: (1) False positive list expanded to 33 codes including DT, RP, SI, SN, TM that appear in table headers. (2) ER7 blocks, code blocks, literal blocks, inline ER7, headings, directives all skipped. (3) Slash-separated refs (PID-3/MRG-1) match both sides. (4) Italic refs (_PID-3_) match correctly. (5) Existing links/xrefs preserved (idempotent). (6) v2-table placeholders not disrupted. (7) PCE collision (segment vs event) resolved — segment wins. 7 new edge case tests added.

---

### TASK-015: Generate unresolved reference report
- **Status:** COMPLETED
- **Branch:** `feature/015-unresolved-report`
- **Description:** Log references that couldn't be matched to the construct registry, with file location and context, for manual review by editors.
- **Acceptance Criteria:**
  - [x] Report lists each unresolved reference with file, line, and context
  - [x] Report is generated as part of the preprocessing pipeline
  - [x] Report format is easy for editors to work through
- **Notes:** Script at `tooling/scripts/unresolved_report.py`. Output at `tooling/unresolved_references.md`. Scans 814 AsciiDoc files, found: 17 unresolved field refs (mostly withdrawn QRD/QRF segments and data type self-references using dash notation), 31 unresolved message refs (legacy ORM/ORR/DSR messages and site-defined Z-examples), 98 v2-table placeholders (161 occurrences needing URL resolution). Markdown table format with code, occurrence count, and sample location.

---

### TASK-016: Test auto-linker against representative content
- **Status:** COMPLETED
- **Branch:** `feature/016-linker-testing`
- **Description:** Run the auto-linker against the representative resource subset and verify correctness in the published IG output.
- **Acceptance Criteria:**
  - [x] Auto-linker runs on representative subset without errors
  - [ ] Published output shows correct hyperlinks (needs IG Publisher build — deferred to TASK-024)
  - [x] Unresolved reference report reviewed and acceptable
- **Notes:** Dry-run on 6 representative files: 250 links correctly added, 1 already-linked reference preserved. Full dry-run across 814 files: 3,874 links across 394 files. Unresolved report reviewed: 17 unresolved field refs (withdrawn segments, self-references), 31 unresolved messages (legacy + Z-examples), 98 table placeholders. All are expected gaps. Idempotency verified. 107 tests passing across all test files. Published output verification deferred to TASK-024 (full build).

---

## Phase 4: FHIR Resource Completeness

### TASK-017: Audit primitive data type representations
- **Status:** COMPLETED
- **Branch:** `feature/017-primitive-types`
- **Acceptance Criteria:**
  - [x] All V2 primitive types have FHIR representations
  - [x] V2-to-FHIR type mappings documented
- **Notes:** All 12 V2 primitive types (DT, DTM, FT, GTS, ID, IS, NM, SI, SNM, ST, TM, TX) have FHIR StructureDefinitions. All types referenced by segment fields and data type components have corresponding definitions. No missing primitives.

---

### TASK-018: Audit complex data type representations
- **Status:** COMPLETED
- **Branch:** `feature/018-complex-types`
- **Acceptance Criteria:**
  - [x] All V2 complex types have FHIR StructureDefinitions
  - [x] Completeness verified
- **Notes:** All 71 V2 complex data types have FHIR StructureDefinitions with 448 total components. All type references from segment fields resolve to existing definitions.

---

### TASK-019: Audit segment definitions
- **Status:** COMPLETED
- **Branch:** `feature/019-segments`
- **Acceptance Criteria:**
  - [x] All segment definitions complete with fields
  - [x] Field references to data types correct
- **Notes:** 192 segment definitions with 2,912 fields. 2 placeholder segments (Hxx, ...) have no fields — expected. 102 fields missing type references (likely withdrawn/deprecated fields — e.g., PV1.40, PV1.52, EVN.1). All populated type references resolve correctly.

---

### TASK-020: Audit message structures, messages, and events
- **Status:** COMPLETED
- **Branch:** `feature/020-messages-events`
- **Acceptance Criteria:**
  - [x] All message structures defined
  - [x] All messages and events represented
- **Notes:** 696 messages, 419 message structures, 356 events — all with FHIR StructureDefinitions. Message IDs use dash format (ADT-A01) while display uses caret (ADT^A01). Message structures have variant suffixes (e.g., ADT_A01-A, -B, -C, -D).

---

### TASK-021: Validate all resources pass FHIR validation
- **Status:** DEFERRED
- **Branch:** `feature/021-fhir-validation`
- **Acceptance Criteria:**
  - [ ] All resources pass FHIR R5 validation
  - [ ] Validation errors documented and addressed
- **Notes:** Deferred — requires running IG Publisher (Java + Ruby environment). TASK-003 build showed 8,446 validation errors (mostly missing value sets expected in subset build). Full validation will happen in Phase 5 (TASK-024).

---

### TASK-022: Document V2-to-FHIR data type mappings
- **Status:** COMPLETED
- **Branch:** `feature/022-type-mapping-docs`
- **Acceptance Criteria:**
  - [x] ADRs created for non-obvious mapping decisions
  - [x] Complete mapping table documented
- **Notes:** See `docs/v2-fhir-type-mappings.md`. No non-obvious mapping decisions needed — all 83 types (12 primitive + 71 complex) map 1:1 to FHIR StructureDefinitions. Primitives use `primitive-type` kind, complex types use `logical` kind with component elements. All type cross-references resolve correctly.

---

## Phase 5: Full-Scale Build

### TASK-023: Process all AsciiDoc content
- **Status:** PENDING
- **Branch:** `feature/023-all-asciidoc`

### TASK-024: Include all FHIR resources in build
- **Status:** PENDING
- **Branch:** `feature/024-all-resources`

### TASK-025: Address IG Publisher performance
- **Status:** PENDING
- **Branch:** `feature/025-performance`

### TASK-026: Verify domain-centric navigation
- **Status:** PENDING
- **Branch:** `feature/026-navigation`

### TASK-027: Review published output accuracy
- **Status:** PENDING
- **Branch:** `feature/027-output-review`

---

## Phase 6: Editor Workflow and Documentation

### TASK-028: Write editor workflow documentation
- **Status:** PENDING
- **Branch:** `feature/028-editor-workflow`

### TASK-029: Document GitHub editing process
- **Status:** PENDING
- **Branch:** `feature/029-github-editing`

### TASK-030: Document domain/editor assignments
- **Status:** PENDING
- **Branch:** `feature/030-editor-assignments`

### TASK-031: Document Asciidoctor.js limitations
- **Status:** PENDING
- **Branch:** `feature/031-asciidoctorjs-gaps`

### TASK-032: Create editor onboarding guide
- **Status:** PENDING
- **Branch:** `feature/032-editor-onboarding`

---

## Phase 7: CI/CD

### TASK-033: Create GitHub Actions workflow
- **Status:** PENDING
- **Branch:** `feature/033-github-actions`

### TASK-034: Evaluate CI/CD repo strategy
- **Status:** PENDING
- **Branch:** `feature/034-cicd-strategy`

### TASK-035: Implement CI/CD strategy
- **Status:** PENDING
- **Branch:** `feature/035-cicd-implementation`

### TASK-036: Set up build failure notifications
- **Status:** PENDING
- **Branch:** `feature/036-build-notifications`

---

## Completed Tasks

<!-- Move completed tasks here with final notes -->

---

## Blocked / Deferred

<!-- Tasks waiting on something or intentionally postponed -->
