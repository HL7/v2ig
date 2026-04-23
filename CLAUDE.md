# v2ig — HL7 V2+ Implementation Guide

HL7 V2 standard publication pipeline: AsciiDoc + FHIR resources → preprocessing → IG Publisher → published IG.

---

## Build Commands

```bash
# AsciiDoc preprocessing (Ruby)
ruby tooling/asciidoctor/do.rb           # Run AsciiDoc processing
ruby tooling/asciidoctor/render.rb       # Render AsciiDoc to HTML

# IG Publisher (generates the full IG)
./_genonce.sh                            # One-time IG generation
./_gencontinuous.sh                      # Continuous/watch mode

# Tooling scripts
ruby tooling/scripts/populate_tech_specs.rb
ruby tooling/scripts/process_sections.rb
```

## Tech Stack

- **Preprocessing:** Ruby (Asciidoctor gem for AsciiDoc→HTML)
- **IG Publisher:** Java (standard HL7 FHIR IG Publisher, unmodified)
- **FHIR Version:** R5
- **Content Authoring:** AsciiDoc (transitional layer, may be removed long-term)
- **Editor Preview:** Asciidoctor.js (VS Code preview pane; known gaps vs Ruby Asciidoctor)
- **Version Control:** Git / GitHub
- **CI/CD:** GitHub Actions (planned)
- **IG Template:** Local custom template (`template/`)

## Project Structure

```
input/
├── sourceOfTruth/          # FHIR resource definitions (JSON)
│   ├── data-type/          # Primitive and complex data types
│   ├── data-element/       # Data element definitions
│   ├── segment/            # Segment definitions
│   ├── message-structure/  # Message structure definitions
│   ├── message/            # Message definitions
│   ├── event/              # Event definitions
│   ├── acknowledgement-choreography/
│   └── control-manifests/
├── pagecontent/            # IG page content
├── includes/               # IG include files
├── resources/              # Additional FHIR resources
└── v2plus.xml              # IG definition file

website/
├── domains/                # AsciiDoc content organized by domain
├── data_structures/        # AsciiDoc for data structure documentation
└── v2plus-navigation.adoc  # Navigation structure

tooling/
├── asciidoctor/            # AsciiDoc processing tooling (Ruby)
├── scripts/                # Utility scripts (Ruby)
├── processors/             # Content processors
└── test/                   # Tooling tests

template/                   # Custom IG Publisher template
editor_instructions/        # Guidance for content editors
```

## Conventions

- FHIR resources are JSON files in `input/sourceOfTruth/`
- AsciiDoc content lives in `website/` organized by domain
- Ruby scripts use standard Ruby conventions
- Commit messages use imperative mood
- All implementation work on feature branches (never commit directly to main)

## Key Constraints

- Do NOT modify the FHIR IG Publisher itself
- Existing FHIR resources are the starting point (not re-generating from Word)
- AsciiDoc is a transitional authoring layer — design for eventual removal
- Large resource count (~1,779 JSON files) — use representative subsets for development/testing

## UADF Configuration

- uadf_team_mode: true

## Project Documentation Layout (2026-04-23)

Where each kind of context lives. Read in this order at session start; don't duplicate content across files.

| File | Loaded at start? | Lifecycle | Purpose |
|------|-----------------|-----------|---------|
| `MEMORY.md` (auto-memory) | always | Edit on stable knowledge change | Paths, build rules, architecture, environment quirks |
| `CLAUDE.md` (this file) | always | Edit when conventions change | Project conventions, build commands, this layout protocol |
| `JOURNAL.md` ACTIVE section | always | **Overwrite each handoff** | Current branch, pending user actions, next session's first move, open blockers |
| `JOURNAL.md` Session History | always | Append-only at top | Last few session entries: what was done, why, non-obvious context |
| `JOURNAL-archive.md` | on demand only | Append on rolloff | Older session entries (target: keep `JOURNAL.md` under ~600 lines) |
| `docs/adr/` | on demand only | Immutable once accepted | Significant architectural decisions, with rationale and consequences |
| `v291-extracted/v2mgmt-review-report.md` | on demand only | Updated as findings emerge | The V2 Management discussion document — questions awaiting committee input |

There is **no** `SESSION-HANDOFF.md` (deprecated 2026-04-23 — drift-prone duplicate of JOURNAL.md ACTIVE). Older planning artifacts (`spec.md`, `blueprint.md`, `TASKS.md`, `ARCHITECTURE.md`, etc.) are historical context from the project's early phases — read on demand only when investigating origin of a decision; do not treat as current.
