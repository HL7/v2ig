# Tooling Audit — TASK-001

**Date:** 2026-02-25
**Status:** Complete

---

## Summary

The `tooling/` directory contains **24 Ruby files** organized into four areas:

| Area | Files | Purpose |
|------|-------|---------|
| `asciidoctor/` | 11 | Core AsciiDoc processing and custom Asciidoctor extensions |
| `processors/` | 3 | File path management and data type list generation |
| `scripts/` | 9 | Utility scripts for conversion, content generation, file management |
| `test/` | 1 | Local HTML build utility (not production) |

**No Gemfile or gemspec exists.** Dependencies are managed informally.

---

## Required Dependencies

### Ruby Gems
| Gem | Used By |
|-----|---------|
| `asciidoctor` | Core processing (build.rb, config.rb, do.rb, etc.) |
| `rainbow` | Colored terminal output (many scripts) |
| `active_support` | String inflection (stub_domain_pages.rb) |
| `json` | FHIR resource parsing (data_types.rb) |

### External Tools
| Tool | Used By | Notes |
|------|---------|-------|
| `asciidoctor` CLI | convert2md.rb, build_html.rb | In addition to the gem |
| `downdoc` (NPX) | convert2md.rb | AsciiDoc→Markdown conversion |
| LibreOffice | convert_word_images.rb | **Hard-coded macOS path — not portable** |

### External Code (not in repo)
| Module | Used By | Notes |
|--------|---------|-------|
| `V2AD` | populate_tech_specs.rb, process_sections.rb | V2 database/section registry — used during initial Word conversion, likely not needed going forward |

---

## File-by-File Audit

### Asciidoctor Core (5 files)

#### `asciidoctor/build.rb` — Core initialization
- Loads processor extensions, configures Asciidoctor
- Contains `reset()` marked as "just for initial development use"
- Has unused code for copying support files (CSS, JS, images)

#### `asciidoctor/config.rb` — Extension registration
- Registers all custom processors from `processors/` subdirectory via glob
- Commented-out stylesheet configuration

#### `asciidoctor/do.rb` — Single file converter
- Converts one AsciiDoc file to HTML (doctype: `:book`)
- Input: command-line argument (file path)
- Uses hard-coded safe mode `:unsafe`

#### `asciidoctor/do_dir.rb` — Batch directory converter
- Converts all `.adoc` files in a directory tree to HTML
- **Hard-coded source:** `../../website/domains`
- No command-line arguments

#### `asciidoctor/render.rb` — Rendering utility
- Converts AsciiDoc to HTML and copies to destination
- **References undefined variable `git_dir`**

### Asciidoctor Processors (6 files)

#### `processors/caret_pre_processor.rb` — Caret escaping
- Escapes `^` to `&#x5e;` in ER7 and message identifier contexts
- Prevents AsciiDoc superscript interpretation

#### `processors/er7_block_processor.rb` — ER7 block handler
- Processes `[er7]` blocks containing HL7 ER7 message segments
- Creates example blocks with `er7` role

#### `processors/helpers.rb` — Pattern detection helpers
- `is_hl7_er7()` — detects ER7 format lines
- `has_er7?()` — detects ER7 within content
- `has_message_identifier?()` — detects message identifiers (e.g., `ADT^A01^ADT_A01`)

#### `processors/message-structure_block_processor.rb` — Message structure blocks
- **Placeholder implementation** — outputs TODO messages
- Handles `message_structure` and `ack_chor` types
- Marked with FIXME

#### `processors/sectnumoffset-treeprocessor.rb` — Section number offset
- Offsets section numbers by a configurable amount
- Copied from asciidoctor-extensions-lab
- Appears functional

#### `processors/tabset_block_processor.rb` — Tab set blocks
- **Placeholder implementation** — outputs FIXME messages
- Extensive commented-out code for unimplemented functionality
- Role includes literal string `message-tabs-FIXME`

### Processors Module (3 files)

#### `processors/process.rb` — Module loader
- Loads utilities from `utils/` and `lists/` subdirectories
- Has commented-out method calls for data type processing

#### `processors/utils/files_and_dirs.rb` — Path management
- Provides absolute paths to all source directories
- Validates directory existence
- **Bug: `messages_dir` points to `events_dir`**

#### `processors/lists/data_types.rb` — Data type list generator
- Reads JSON files from `sourceOfTruth/data-type/`
- Generates HTML include files listing primitive and complex data types
- Output: `input/includes/primitive-data-types-list.html` and `complex-data-types-list.html`

### Utility Scripts (9 files)

#### `scripts/convert2md.rb` — AsciiDoc to Markdown/HTML converter
- Hard-coded source directory
- Uses `downdoc` for Markdown, `asciidoctor` CLI for HTML

#### `scripts/convert_word_images.rb` — Word media extractor
- Extracts and converts Word document media files to PNG
- **Hard-coded macOS LibreOffice path — not portable**

#### `scripts/csv.rb` — CSV path configuration
- Points to CSV structure mapping files in `csv/` subdirectory

#### `scripts/fix_tabsets.rb` — Tab set populator
- Inserts event IDs into `[tabset]` blocks in technical spec files
- Hard-coded file exclusion list
- **Has bare `raise` that will crash without useful error message**

#### `scripts/populate_tech_specs.rb` — Tech spec generator
- Parses CSV site map and generates technical specification `.adoc` files
- **Depends on external V2AD module** (not in this repo)
- **Error message is literal string "crap"**

#### `scripts/process_sections.rb` — Content converter
- Converts V2AD content objects to AsciiDoc markup
- Handles tables, paragraphs, definitions, notes, examples, ER7, images
- **Depends on external V2AD module**
- Debug output "I AM LOADED" printed on load

#### `scripts/remove_html.rb` — HTML file cleaner
- Removes all `.html` files from a directory tree
- Has dry-run mode

#### `scripts/rename_adocs.rb` — File renamer
- Renames AsciiDoc files based on document title
- Updates cross-reference links in parent docs
- **Error message is literal string "Nooooooo"**

#### `scripts/stub_domain_pages.rb` — Domain page scaffolding
- Generates stub `.adoc` files for domain directory structure
- Creates section structure with placeholder content
- Uses `active_support/inflector` for title casing

### Test (1 file)

#### `test/build_html.rb` — Local HTML builder
- Not part of production pipeline
- Converts all `.adoc` files to HTML locally

---

## Critical Issues

### High Priority

| Issue | Location | Description |
|-------|----------|-------------|
| Undefined variable | `render.rb` | References `git_dir` which is not defined |
| Bug | `files_and_dirs.rb:66` | `messages_dir` incorrectly aliases `events_dir` |
| Hard-coded macOS path | `convert_word_images.rb:17` | LibreOffice path not portable |
| Bare raise | `fix_tabsets.rb:44` | Will crash without useful error |
| Unprofessional error | `populate_tech_specs.rb:91` | Raises `'crap'` as error message |

### Medium Priority

| Issue | Location | Description |
|-------|----------|-------------|
| Placeholder processors | `message-structure_block_processor.rb`, `tabset_block_processor.rb` | Output FIXME/TODO placeholders instead of real content |
| Hard-coded paths | `do_dir.rb`, `convert2md.rb`, `fix_tabsets.rb`, `remove_html.rb`, `rename_adocs.rb`, `stub_domain_pages.rb` | All use hard-coded relative paths, no CLI args |
| External dependency | `populate_tech_specs.rb`, `process_sections.rb` | Depend on V2AD module not in this repo |
| Debug output | Multiple scripts | Rainbow-colored debug `puts` left in production code |
| No Gemfile | Project root | Dependencies not formally managed |

### Low Priority

| Issue | Location | Description |
|-------|----------|-------------|
| Commented-out code | Multiple files | Extensive dead code |
| FIXME role name | `tabset_block_processor.rb:33` | Literal `message-tabs-FIXME` in output |
| TODOs | `populate_tech_specs.rb:177` | Noted but not addressed |

---

## Data Flow

```
                    ┌─────────────────────────┐
                    │ CSV SiteMap             │
                    │ (tooling/scripts/csv/)  │
                    └───────────┬─────────────┘
                                │ (populate_tech_specs.rb)
                                │ + V2AD sections (external)
                                ▼
                    ┌─────────────────────────┐
                    │ process_sections.rb     │
                    │ (converts to AsciiDoc)  │
                    └───────────┬─────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────┐
│ AsciiDoc files (website/domains/)                │
│ + AsciiDoc front matter attributes               │
└───────────┬──────────────────────────────────────┘
            │
            │ (asciidoctor/do.rb or do_dir.rb)
            │   + CaretPreprocessor (escape ^)
            │   + ER7BlockProcessor ([er7] blocks)
            │   + TabSetBlockProcessor ([tabset] blocks) ← PLACEHOLDER
            │   + MessageStructureBlockProcessor ← PLACEHOLDER
            │   + SectnumoffsetTreeprocessor (section numbering)
            ▼
┌──────────────────────────────────────────────────┐
│ HTML output                                      │
└──────────────────────────────────────────────────┘

SEPARATE PATH:
┌──────────────────────────────────────────────────┐
│ FHIR JSON (input/sourceOfTruth/)                 │
│ processors/lists/data_types.rb                   │
│ → generates HTML include lists                   │
│ → input/includes/*-data-types-list.html          │
└──────────────────────────────────────────────────┘
```

---

## Changes Made During Audit

1. **Created `Gemfile`** — formalizes Ruby dependencies (asciidoctor, rainbow, activesupport, json)
2. **Replaced ER7 block processor with literal blocks** (ADR-0002)
   - Converted 351 `[er7]` blocks across 53 AsciiDoc files to `[.er7]` literal blocks
   - Removed `er7_block_processor.rb` from Asciidoctor extensions
   - Retained `CaretPreprocessor` (still needed for inline message identifiers)
3. **Fixed `messages_dir` bug** in `files_and_dirs.rb` — now points to `message/` instead of `event/`
4. **Cleaned up `build.rb`** — removed dead `WriteAdoc` module with undefined `git_dir` references
5. **Cleaned up `render.rb`** — simplified to a working function with optional output directory
6. **Made `do_dir.rb` accept CLI arguments** — defaults to `website/domains/` if none provided
7. **Fixed bare `raise` in `fix_tabsets.rb`** — now has descriptive error message
8. **Fixed error message in `populate_tech_specs.rb`** — "crap" → descriptive message
9. **Fixed error message in `rename_adocs.rb`** — "Nooooooo" → descriptive message
10. **Removed debug output** — "I AM LOADED" from `process_sections.rb`
11. **Added `*.removed` to `.gitignore`**

---

## Key Observations for Phase 1

1. **The V2AD-dependent scripts (`populate_tech_specs.rb`, `process_sections.rb`) were used for the initial Word→AsciiDoc conversion.** They are likely not needed going forward, which aligns with the project scope. They depend on an external module not in this repo.

2. **Two Asciidoctor block processors are placeholder implementations** (`message-structure_block_processor.rb`, `tabset_block_processor.rb`). These need real implementations for the pipeline to produce complete output.

3. **The core AsciiDoc→HTML conversion path works** (`do.rb`/`do_dir.rb` → `build.rb` → Asciidoctor with extensions), but has hard-coded paths and debug artifacts.

4. **The `processors/` module has useful infrastructure** (`files_and_dirs.rb` for path management, `data_types.rb` for generating include files) that can be built upon.

5. **No formal dependency management exists** — a Gemfile should be created.
