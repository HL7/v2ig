# Implementation Blueprint

This document defines **HOW** we will build what's specified in `spec.md`. No implementation code should be written until this blueprint is approved.

---

## 1. Technical Approach

### Architecture Overview

The system is a multi-stage publication pipeline:

1. **Content Authoring** — Editors write AsciiDoc and maintain FHIR resource JSON via GitHub
2. **Preprocessing** — Ruby tooling converts AsciiDoc to HTML, injects content into FHIR resources and IG page files
3. **IG Generation** — Standard FHIR IG Publisher produces the published specification
4. **CI/CD** — GitHub Actions automates the pipeline on push

### Key Technical Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Preprocessing language | Ruby | Developer expertise; Asciidoctor is Ruby-native |
| Authoring format | AsciiDoc | More accessible than HTML/Markdown for non-dev editors; transitional |
| FHIR version | R5 | Current stable version; R6 not yet published |
| IG Publisher | Unmodified | Leverage existing ecosystem; avoid maintenance burden |
| Content organization | Domain-centric | Better reflects how V2 is used vs. legacy chapter structure |
| IG template | Custom local | Required for V2-specific rendering needs |
| Content management | GitHub | Standard, well-known, supports editing workflows |

### Dependencies

- Ruby (with Asciidoctor gem)
- Java (for IG Publisher)
- FHIR IG Publisher JAR
- GitHub Actions (for CI/CD)

---

## 2. Implementation Phases

### Phase 1: Pipeline Foundation

**Goal:** Establish a working end-to-end pipeline with a representative subset of resources that successfully builds with IG Publisher.

**Tasks:**
1. [ ] Audit existing Ruby preprocessing tooling — understand current state, identify gaps → `TASK-001`
2. [ ] Define and assemble a representative resource subset for development — a small set covering all resource types (data types, segments, messages, events) → `TASK-002`
3. [ ] Get the representative subset building successfully with IG Publisher → `TASK-003`
4. [ ] Document the current preprocessing pipeline flow (input → transformations → output) → `TASK-004`

**Deliverables:**
- A documented, working pipeline that processes a representative subset from AsciiDoc + FHIR resources → published IG
- Clear understanding of what the existing tooling does and what's missing

---

### Phase 2: AsciiDoc Processing Completeness

**Goal:** Ensure the AsciiDoc preprocessing handles all content types correctly and injects content into the right places.

**Tasks:**
1. [ ] Map all AsciiDoc content locations to their IG output destinations → `TASK-005`
2. [ ] Implement/fix AsciiDoc-to-StructureDefinition injection (descriptive text into FHIR resource elements) → `TASK-006`
3. [ ] Implement/fix AsciiDoc-to-pagecontent conversion (standalone IG pages) → `TASK-007`
4. [ ] Document AsciiDoc features that are safe to use (compatible with both Asciidoctor and Asciidoctor.js) → `TASK-008`

**Deliverables:**
- Complete AsciiDoc preprocessing that handles all content patterns in the V2 standard
- Editor-facing documentation of supported AsciiDoc features

---

### Phase 3: Cross-Reference Resolution (Auto-Linker)

**Goal:** Build a system that strips legacy cross-references, constructs a registry of all V2 data structures, and automatically links references throughout the content.

**Strategy:** Strip all existing links first (they are inconsistent and partially broken from Word conversion), then re-link everything systematically. This is more reliable than trying to identify and fix individual broken links.

**Tasks:**
1. [ ] Survey existing cross-reference patterns in AsciiDoc content — catalog the various formats inherited from Word → `TASK-009`
2. [ ] Strip all existing cross-references and links from AsciiDoc content → `TASK-010`
3. [ ] Build construct registry from FHIR resources — extract all known data types, segments, fields, message structures, messages, events with their identifiers and target URLs → `TASK-011`
4. [ ] Implement reference pattern matcher — detect V2 construct references in text using naming conventions (e.g., "PID-3", "CWE", "ADT^A01", segment field references, data type component references) → `TASK-012`
5. [ ] Implement auto-linker — replace matched references with hyperlinks to the correct published IG page/anchor → `TASK-013`
6. [ ] Handle edge cases — ambiguous references, references in code blocks, nested references → `TASK-014`
7. [ ] Generate unresolved reference report — log references that couldn't be matched for manual review → `TASK-015`
8. [ ] Test auto-linker against representative content subset → `TASK-016`

**Deliverables:**
- Auto-linker integrated into the preprocessing pipeline
- Construct registry generated from FHIR resources
- Unresolved reference report for editorial review
- All V2 construct mentions are hyperlinked in published output

**Note:** Domain-to-domain cross-references are treated as a separate problem and deferred.

---

### Phase 4: FHIR Resource Completeness

**Goal:** Ensure all V2 data structures are completely and correctly represented as FHIR resources.

**Tasks:**
1. [ ] Audit primitive data type FHIR representations — verify V2-to-FHIR type mappings → `TASK-017`
2. [ ] Audit complex data type representations → `TASK-018`
3. [ ] Audit segment definitions and field completeness → `TASK-019`
4. [ ] Audit message structures, messages, and events → `TASK-020`
5. [ ] Validate all resources pass FHIR validation → `TASK-021`
6. [ ] Document V2-to-FHIR data type mapping decisions (ADRs for non-obvious mappings) → `TASK-022`

**Deliverables:**
- Complete set of validated FHIR resources representing all V2 data structures
- Documented mapping decisions

---

### Phase 5: Full-Scale Build

**Goal:** Scale from representative subset to the full V2 standard and get a complete build working.

**Tasks:**
1. [ ] Process all AsciiDoc content through the pipeline → `TASK-023`
2. [ ] Include all FHIR resources in the build → `TASK-024`
3. [ ] Address IG Publisher performance/scaling issues → `TASK-025`
4. [ ] Verify domain-centric navigation and organization → `TASK-026`
5. [ ] Review published output for accuracy against original standard → `TASK-027`

**Deliverables:**
- Complete, buildable IG containing the full V2 standard
- Performance characterization and any needed optimizations

---

### Phase 6: Editor Workflow and Documentation

**Goal:** Provide editors with everything they need to maintain V2 content.

**Tasks:**
1. [ ] Write/update editor workflow documentation → `TASK-028`
2. [ ] Document GitHub-based editing process (single-file editor and VS Code) → `TASK-029`
3. [ ] Document domain/editor assignments and responsibilities → `TASK-030`
4. [ ] Document known Asciidoctor.js preview limitations and workarounds → `TASK-031`
5. [ ] Create editor onboarding guide → `TASK-032`

**Deliverables:**
- Complete editor documentation
- Editors can independently maintain content

---

### Phase 7: CI/CD

**Goal:** Automate the build pipeline.

**Tasks:**
1. [ ] Create GitHub Actions workflow for preprocessing + IG Publisher → `TASK-033`
2. [ ] Evaluate single-repo vs. two-repo CI/CD strategy → `TASK-034`
3. [ ] Implement chosen CI/CD strategy → `TASK-035`
4. [ ] Set up build failure notifications → `TASK-036`

**Deliverables:**
- Automated build pipeline that runs on push to main
- Clear build status visibility

---

## 3. File Changes

### New Files (UADF)
| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Project instructions and conventions |
| `spec.md` | Product specification |
| `blueprint.md` | Implementation plan (this file) |
| `TASKS.md` | Task tracking |
| `JOURNAL.md` | Session log and handoffs |
| `ARCHITECTURE.md` | System architecture |
| `docs/adr/` | Architecture Decision Records |

### Files to be Modified (During Implementation)
| Path | Changes |
|------|---------|
| `tooling/asciidoctor/*.rb` | Preprocessing pipeline improvements |
| `tooling/scripts/*.rb` | Utility script updates |
| `input/v2plus.xml` | IG definition updates |
| `input/sourceOfTruth/**/*.json` | FHIR resource corrections |
| `template/` | IG template customizations |
| `editor_instructions/` | Editor documentation updates |
| `.github/workflows/` | CI/CD pipeline (new) |

---

## 4. Testing Strategy

### Unit Tests
- Ruby preprocessing functions (AsciiDoc parsing, content injection, file generation)
- Data type mapping logic
- Content transformation correctness

### Integration Tests
- End-to-end preprocessing: AsciiDoc input → IG Publisher-ready output
- FHIR resource validation against R5 definitions
- Representative subset builds successfully with IG Publisher

### Validation
- FHIR resource validation (built into IG Publisher)
- Published output review (manual, potentially AI-assisted comparison with Word originals)
- Cross-reference integrity checks

### Development Strategy
- Use a representative subset of resources for rapid iteration
- Full builds run periodically to catch scaling issues
- Existing `tooling/test/` directory for tooling tests

---

## 5. Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| IG Publisher cannot handle V2 representation patterns | High — may block publication | Use custom template; escalate to IG Publisher maintainers; worst case, request IG Publisher changes |
| V2-to-FHIR data type mappings are incomplete or incorrect | Medium — incorrect published content | Document all mappings in ADRs; review with V2 MG; iterate |
| Build performance with ~1,779+ resources is prohibitive | Medium — slow development cycle | Representative subset strategy; investigate IG Publisher caching; potential two-repo approach |
| Editors struggle with AsciiDoc/GitHub workflow | Medium — content maintenance bottleneck | Clear documentation; onboarding support; long-term custom editor (deferred) |
| Asciidoctor.js preview gaps cause editor frustration | Low — cosmetic/workflow issue | Document known gaps; editors learn which features to avoid |
| Errors inherited from original Word documents | Medium — incorrect content | Comparison/verification phase; AI-assisted review |
| FHIR R6 publishes and requires migration | Low (deferred) — future work | Minimal dependency on version-specific features; mostly StructureDefinition |

---

## 6. Approval

- [x] Blueprint reviewed and approved
- **Approved by:** Human
- **Date:** 2026-02-25
- **Note:** Approved with the understanding that this is a living document; gaps will be addressed as discovered.

---

## 7. Implementation Notes

[Add notes here during implementation that future sessions should know]
