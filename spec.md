# Product Specification

This document defines **WHAT** we are building. It is created through a Socratic interview process and must be approved before creating `blueprint.md`.

---

## 1. Overview

### Problem Statement

The HL7 V2 standard — the most widely implemented health IT standard in the world, used by ~95% of U.S. healthcare organizations — has historically been maintained and published as a collection of Microsoft Word documents. This format is not computable, is difficult to maintain collaboratively, and does not integrate with modern health IT tooling ecosystems.

This project transitions the HL7 V2 standard into a computable representation using FHIR (Fast Healthcare Interoperability Resources) IG Publisher, with AsciiDoc as a transitional authoring layer.

### Target Users

1. **Content Authors/Editors** (~8 people from the V2 Management Group + working group stewards): Edit AsciiDoc content and maintain FHIR resource definitions via GitHub.
2. **Pipeline Operators** (very small group, technically skilled): Run the preprocessing pipeline and IG Publisher to produce builds.
3. **Consumers** (broad): Healthcare implementers worldwide — EHR vendors, hospitals, insurance providers, and anyone implementing HL7 V2.

### Success Criteria

- The complete HL7 V2 standard is representable as a FHIR IG
- All V2 data structures (data types, segments, messages, events, etc.) are represented as FHIR R5 resources
- AsciiDoc content is correctly preprocessed and injected into IG Publisher input
- The published output is accurate and navigable
- Editors can maintain content via GitHub with reasonable ease
- The pipeline is documented well enough for technically-minded operators to run and troubleshoot

---

## 2. Features

### Feature 1: AsciiDoc Preprocessing Pipeline

**Description:** A Ruby-based preprocessing step that converts AsciiDoc content into HTML/Markdown suitable for IG Publisher input. This includes injecting textual content into the appropriate locations — either as data elements within FHIR StructureDefinitions or as standalone HTML pages within the IG.

**User Stories:**
- As a pipeline operator, I want to run a single command that processes all AsciiDoc content into IG Publisher-ready files so that I can then generate the IG
- As a content editor, I want to write in AsciiDoc rather than raw HTML so that editing is more accessible

**Acceptance Criteria:**
- [ ] AsciiDoc files in `website/` are converted to HTML using Asciidoctor (Ruby)
- [ ] Converted content is distributed to appropriate IG input files
- [ ] Text content is injected into FHIR StructureDefinition elements where applicable
- [ ] The pipeline is idempotent (running it twice produces the same result)
- [ ] Errors in AsciiDoc content produce clear, actionable error messages

**Edge Cases:**
- AsciiDoc features that work in Asciidoctor (Ruby) but not in Asciidoctor.js (editor preview)
- Special characters and encoding issues in clinical terminology
- Cross-references between AsciiDoc documents and FHIR resources
- Very large files or deeply nested AsciiDoc includes

---

### Feature 2: FHIR Resource Completeness and Correctness

**Description:** Ensure all V2 data structures are completely and correctly represented as FHIR R5 resources, including proper mappings between V2 data types and FHIR data types.

**User Stories:**
- As a standards consumer, I want all V2 data types, segments, message structures, messages, and events represented as FHIR resources so that I can use standard FHIR tooling to work with V2 definitions
- As an editor, I want to be able to update FHIR resource definitions and have them validate correctly

**Acceptance Criteria:**
- [ ] All V2 primitive data types have corresponding FHIR representations with documented mappings
- [ ] All V2 complex data types are represented as FHIR StructureDefinitions
- [ ] All segment definitions are complete with field definitions
- [ ] Message structures, messages, and events are defined
- [ ] Acknowledgement choreographies are represented
- [ ] Resources pass FHIR validation

**Edge Cases:**
- V2 data types with no clean FHIR equivalent (mapping decisions documented in ADRs)
- Errors or inconsistencies inherited from the original Word documents
- Circular or complex references between V2 structures

---

### Feature 3: Cross-Reference Resolution (Auto-Linker)

**Description:** A system that strips all existing (inconsistent, partially broken) cross-references inherited from Word documents, builds a registry of all known V2 constructs from FHIR resources, and automatically identifies and links references to V2 data structures throughout the AsciiDoc content. This runs as part of the preprocessing pipeline.

**User Stories:**
- As a standards consumer, I want every mention of a data type, segment, field, message structure, or event in the published IG to be a clickable hyperlink to its definition so that I can navigate the standard efficiently
- As an editor, I want cross-references to be handled automatically so that I don't have to manually create and maintain links
- As a pipeline operator, I want a clear report of unresolvable references so that content issues can be identified and fixed

**Acceptance Criteria:**
- [ ] All existing cross-references and links in AsciiDoc content are stripped as a first step
- [ ] A construct registry is built from FHIR resources containing all known V2 data types, segments, fields, message structures, messages, events, and their canonical identifiers
- [ ] Text is scanned for V2 construct references using naming conventions (e.g., "PID-3", "CWE", "ADT^A01")
- [ ] Matched references are replaced with hyperlinks to the correct definition page in the published IG
- [ ] Field references within segments (e.g., "PID-3") link to the field within the segment definition
- [ ] Component references within data types link to the component within the data type definition
- [ ] Unresolvable references are logged with file location for manual review
- [ ] The auto-linker is idempotent (running it multiple times produces the same result)

**Edge Cases:**
- Ambiguous references (e.g., a code that could be a data type or a segment)
- References embedded in code blocks or examples that should NOT be linked
- Data type codes that are also common English words or abbreviations
- References to constructs from older V2 versions that may not exist in the current representation
- Nested references (e.g., a field reference within a description that itself contains data type references)
- References to domain content (treated as a separate problem initially)

---

### Feature 4: IG Publisher Integration (was Feature 3)

**Description:** The preprocessed content and FHIR resources work correctly with the standard (unmodified) FHIR IG Publisher to produce a navigable, published specification.

**User Stories:**
- As a pipeline operator, I want to run `_genonce.sh` after preprocessing and get a valid, publishable IG
- As a consumer, I want to navigate the published IG and find V2 definitions organized by domain

**Acceptance Criteria:**
- [ ] IG Publisher runs without errors on the preprocessed input
- [ ] Published output includes all V2 data structures with their documentation
- [ ] Navigation reflects the domain-centric organization (not legacy chapter structure)
- [ ] Cross-references and links work correctly in the published output
- [ ] Custom IG template (`template/`) renders V2 content appropriately

**Edge Cases:**
- IG Publisher performance with ~1,779+ resources (may need batching strategy)
- Template limitations requiring workarounds
- IG Publisher version updates that change behavior

---

### Feature 5: Content Editor Workflow

**Description:** A documented and workable process for content editors to maintain the V2 standard using GitHub and AsciiDoc.

**User Stories:**
- As a content editor, I want clear instructions on how to edit V2 content so that I can make changes without breaking the build
- As a content editor, I want to preview my AsciiDoc changes before they are published

**Acceptance Criteria:**
- [ ] Editor instructions document the complete editing workflow
- [ ] AsciiDoc syntax guide covers the subset of features that work reliably
- [ ] GitHub-based editing workflow is documented (single-file editor and VS Code)
- [ ] Domain/editor assignment structure is clear
- [ ] Known Asciidoctor.js preview limitations are documented

**Edge Cases:**
- Editors unfamiliar with Git/GitHub
- Merge conflicts in AsciiDoc content
- Accidental breakage of FHIR resource references

---

### Feature 6: CI/CD Pipeline

**Description:** Automated build pipeline using GitHub Actions that runs preprocessing and IG Publisher on pushes to main.

**User Stories:**
- As a pipeline operator, I want builds to run automatically when changes are merged so that the published IG stays current
- As an editor, I want to know if my changes break the build before they are merged

**Acceptance Criteria:**
- [ ] GitHub Actions workflow runs AsciiDoc preprocessing
- [ ] GitHub Actions workflow runs IG Publisher
- [ ] Build failures produce clear notifications
- [ ] Possibly: two-repo strategy where preprocessed output is pushed to a downstream repo for standard HL7 FHIR CI/CD

**Edge Cases:**
- Build timeout due to large number of resources
- Interaction between custom preprocessing and HL7's standard CI build pipeline
- Secrets/credentials management for publishing

---

## 3. Non-Functional Requirements

### Performance
- IG Publisher build should complete in a reasonable time (strategy for representative subsets during development)
- Preprocessing step should handle ~1,779+ resources without excessive runtime

### Security
- No special security requirements beyond standard GitHub access controls
- Editor permissions managed via GitHub repository roles

### Compatibility
- FHIR R5 StructureDefinitions (R6 awareness for future)
- Standard FHIR IG Publisher (unmodified)
- Asciidoctor (Ruby) for builds, Asciidoctor.js for editor preview
- GitHub as the content management platform

---

## 4. Out of Scope

- **Modifying the FHIR IG Publisher** — absolute last resort only
- **Re-converting from Word documents** — existing FHIR resources are our starting point (may revisit for comparison/verification later, potentially using AI)
- **Runtime V2 message processing or validation** — this is a publication project, not a runtime system
- **Custom AsciiDoc editor application** — deferred; editors use GitHub's built-in editors for now
- **R6 migration** — awareness only; not acting on it until R6 is published

---

## 5. Open Questions

- Exact strategy for CI/CD: single-repo with preprocessing, or two-repo approach?
- Complete inventory of V2-to-FHIR data type mapping gaps
- Full scope of IG Publisher template customizations needed
- How to handle comparison/verification against original Word documents
- Strategy for managing IG Publisher build performance at scale
- Editor-friendly shorthand for defining/modifying the published IG navigation structure (deferred — use `v2plus.xml` page definitions directly for now; backfill with editor tooling when needed)

---

## 6. Approval

- [x] Specification reviewed and approved
- **Approved by:** Human
- **Date:** 2026-02-25
- **Note:** Approved with the understanding that this is a living document; gaps will be addressed as discovered.
