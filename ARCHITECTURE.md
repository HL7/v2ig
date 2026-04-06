# Architecture

High-level system design and component relationships for v2ig.

---

## 1. System Overview

The v2ig system is a publication pipeline that transforms AsciiDoc content and FHIR resource definitions into a published HL7 V2+ Implementation Guide.

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  AsciiDoc Content│     │  Ruby Preprocessor│     │  FHIR IG Publisher│
│  (website/)      │────▶│  (tooling/)       │────▶│  (_genonce.sh)    │
└──────────────────┘     └──────────────────┘     └──────────────────┘
                                │                          │
┌──────────────────┐            │                          ▼
│  FHIR Resources  │────────────┘                 ┌──────────────────┐
│  (sourceOfTruth/)│                              │  Published IG    │
└──────────────────┘                              │  (output/)       │
                                                  └──────────────────┘
```

### Pipeline Flow

```
1. Author edits AsciiDoc in website/ or FHIR JSON in input/sourceOfTruth/
2. Ruby preprocessor converts AsciiDoc → HTML
3. Preprocessor injects content into:
   a. FHIR StructureDefinition elements (descriptive text)
   b. IG pagecontent (standalone pages)
4. IG Publisher processes input/ directory
5. Published IG written to output/
```

---

## 2. Component Structure

### Content Layer (Source of Truth)
```
website/
├── domains/                    # AsciiDoc content organized by domain
│   └── [domain]/               # Domain-specific content
│       └── [subdomain]/        # Subdomain content
├── data_structures/            # AsciiDoc for data type/segment docs
└── v2plus-navigation.adoc      # Top-level navigation structure

input/sourceOfTruth/
├── data-type/
│   ├── primitive/              # Primitive data type StructureDefinitions
│   └── complex/                # Complex data type StructureDefinitions
├── data-element/               # Data element definitions
├── segment/
│   ├── segments/               # Individual segment StructureDefinitions
│   └── segment.json            # Base segment definition
├── message-structure/
│   └── message_structures/     # Individual message structure definitions
├── message/                    # Message definitions
├── event/                      # Event definitions
├── acknowledgement-choreography/
└── control-manifests/
```

### Preprocessing Layer (Tooling)
```
tooling/
├── asciidoctor/
│   ├── build.rb                # Main build orchestration
│   ├── config.rb               # Configuration
│   ├── do.rb                   # Entry point for processing
│   ├── do_dir.rb               # Directory processing
│   ├── render.rb               # AsciiDoc rendering
│   └── processors/             # Custom Asciidoctor processors
├── scripts/
│   ├── populate_tech_specs.rb  # Populate technical specifications
│   ├── process_sections.rb     # Process content sections
│   ├── convert2md.rb           # Convert to Markdown
│   ├── fix_tabsets.rb          # Fix tab set formatting
│   └── [other utilities]
├── processors/                 # Content transformation processors
└── test/                       # Tests for tooling
```

### IG Publisher Layer
```
input/
├── v2plus.xml                  # IG definition (ImplementationGuide resource)
├── pagecontent/                # Pages for the IG (generated + static)
├── includes/                   # Include files for IG pages
├── resources/                  # Additional FHIR resources
├── data/                       # Data files
└── images/                     # Image assets

template/                       # Custom IG Publisher template
├── config.json                 # Template configuration
├── layouts/                    # Page layout templates
├── includes/                   # Template includes
├── scripts/                    # Template scripts
├── content/                    # Template content
└── onGenerate-*.xml/json       # IG Publisher lifecycle hooks
```

---

## 3. Data Models

### V2 Data Structures as FHIR Resources

The HL7 V2 standard defines several categories of data structures, each represented as FHIR R5 resources:

| V2 Concept | FHIR Resource Type | Location |
|------------|-------------------|----------|
| Primitive Data Type | StructureDefinition | `sourceOfTruth/data-type/primitive/` |
| Complex Data Type | StructureDefinition | `sourceOfTruth/data-type/complex/` |
| Data Element | StructureDefinition | `sourceOfTruth/data-element/` |
| Segment | StructureDefinition | `sourceOfTruth/segment/segments/` |
| Message Structure | StructureDefinition | `sourceOfTruth/message-structure/message_structures/` |
| Message | [TBD] | `sourceOfTruth/message/` |
| Event | [TBD] | `sourceOfTruth/event/` |
| Ack Choreography | [TBD] | `sourceOfTruth/acknowledgement-choreography/` |

### V2-to-FHIR Data Type Mapping

Mapping V2 primitive data types to FHIR primitives is non-trivial. Each mapping is hand-crafted and documented. Key challenges:
- Different object models between V2 and FHIR
- Not all V2 types have direct FHIR equivalents
- Mapping decisions are documented in ADRs

### Supporting Vocabulary Resources

Each resource category has associated CodeSystem and ValueSet resources:
- `v2-cs-*.json` — CodeSystem definitions
- `v2-vs-*.json` — ValueSet definitions

---

## 4. External Integrations

| Service | Purpose | Documentation |
|---------|---------|---------------|
| FHIR IG Publisher | Generates the published IG from FHIR resources and content | [IG Publisher Docs](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) |
| GitHub | Source control, content editing, CI/CD | GitHub repository |
| Asciidoctor (Ruby) | AsciiDoc→HTML conversion in build pipeline | [Asciidoctor Docs](https://docs.asciidoctor.org/) |
| Asciidoctor.js | Editor preview in VS Code | [Asciidoctor.js Docs](https://docs.asciidoctor.org/asciidoctor.js/) |
| HL7 FHIR CI Build | Potential downstream CI integration | [HL7 CI Build](https://fhir.github.io/auto-ig-builder/) |

---

## 5. Conventions

### Naming
- FHIR resources: JSON files named by resource type and identifier
- AsciiDoc files: lowercase with hyphens, `.adoc` extension
- Ruby scripts: lowercase with underscores, `.rb` extension
- Directories: lowercase with hyphens

### File Organization
- FHIR resources live in `input/sourceOfTruth/` organized by V2 concept type
- AsciiDoc content lives in `website/` organized by domain
- Tooling lives in `tooling/` separated by function
- IG Publisher template customizations in `template/`

### Content Editing
- AsciiDoc is the authoring format for textual content
- FHIR resource JSON is edited directly for structural definitions
- All changes go through GitHub (direct editing or PR workflow)

---

## 6. Security Considerations

- Standard GitHub repository access controls
- Editor permissions managed via GitHub teams/roles
- No secrets in the repository (IG Publisher runs locally or in CI)
- Published output is public (it's a standard specification)
