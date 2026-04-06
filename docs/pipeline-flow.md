# Preprocessing Pipeline Flow — TASK-004

**Date:** 2026-02-25

---

## Overview

The v2ig publication pipeline has two major stages:

```
Stage 1: Preprocessing (Ruby)          Stage 2: IG Publisher (Java)
┌─────────────────────────┐            ┌─────────────────────────┐
│ AsciiDoc → HTML         │            │ FHIR resources          │
│ Content injection       │───────────▶│ + generated pages       │
│ Include file generation │            │ + template rendering    │
└─────────────────────────┘            │ → Published IG (output/)│
                                       └─────────────────────────┘
```

Stage 1 is custom Ruby tooling. Stage 2 is the standard HL7 FHIR IG Publisher (unmodified).

---

## Stage 1: Preprocessing (Ruby)

### Step 1a: Generate Include Files

**Script:** `tooling/processors/lists/data_types.rb`
**Module:** `tooling/processors/process.rb` (loader)

**Input:**
- FHIR JSON files in `input/sourceOfTruth/data-type/primitive/primitives/*.json`
- FHIR JSON files in `input/sourceOfTruth/data-type/complex/complex-data-types/*.json`

**Output:**
- `input/includes/primitive-data-types-list.html` — HTML `<ul>` listing all primitive data types
- `input/includes/complex-data-types-list.html` — HTML `<ul>` listing all complex data types

**How it works:**
1. Reads each JSON file's `id` field
2. Generates an HTML list with links to each data type's IG page
3. These lists are included in `input/pagecontent/data-types.xml` via `{% include %}` directives

### Step 1b: AsciiDoc to HTML Conversion

**Scripts:**
- `tooling/asciidoctor/do.rb` — Convert a single AsciiDoc file
- `tooling/asciidoctor/do_dir.rb` — Convert all AsciiDoc files in a directory tree

**Input:**
- AsciiDoc files in `website/domains/` (domain-centric textual content)
- AsciiDoc files in `website/data_structures/data_types/complex/` (data type descriptions)

**Output:**
- HTML files alongside the source `.adoc` files (same directory)

**How it works:**
1. `build.rb` loads Asciidoctor and registers custom extensions
2. Custom extensions process the content:
   - `CaretPreprocessor` — escapes `^` in inline message identifiers (e.g., `ADT^A01`) to prevent AsciiDoc superscript interpretation
   - `TabSetBlockProcessor` — **placeholder** (outputs FIXME text for tabset blocks)
   - `SectnumoffsetTreeprocessor` — adjusts section numbering by an offset
3. Asciidoctor converts `.adoc` to `.html` using doctype `:book`

**Note:** ER7 content blocks now use standard AsciiDoc literal blocks (`....`) with a `.er7` role, so no custom processor is needed for them (see ADR-0002).

### Step 1c: Content Injection into FHIR Resources (NOT YET IMPLEMENTED)

This step is needed but does not yet exist in the current tooling:

**Planned behavior:**
1. Read AsciiDoc files that have front matter attributes indicating a target FHIR resource element
2. Convert the AsciiDoc content to HTML
3. Inject the HTML into the appropriate `definition`, `description`, or `short` fields of the FHIR JSON resource
4. Write the updated FHIR JSON

**Current state:**
- Some FHIR resources have `definition` fields with content already (from initial Word conversion)
- Some have `"definition": null` or `"description": "FIXME"`
- The mapping between AsciiDoc files and FHIR resource elements is partially defined via AsciiDoc front matter attributes

### Step 1d: Content Distribution to Pagecontent (NOT YET FULLY IMPLEMENTED)

**Planned behavior:**
1. Take domain-centric AsciiDoc content (from `website/domains/`)
2. Convert to HTML
3. Place the HTML into `input/pagecontent/` as pages the IG Publisher will include
4. Update the IG definition (`input/v2plus.xml`) page structure accordingly

**Current state:**
- `input/pagecontent/` currently has only `index.xml`, `data-types.xml`, and `xindex.md`
- Domain content in `website/domains/` exists as AsciiDoc but is not yet being distributed to pagecontent

---

## Stage 2: IG Publisher

### Input

The IG Publisher reads from:

| Input | Location | Configured In |
|-------|----------|---------------|
| IG definition | `input/v2plus.xml` | `ig.ini` (`ig = input/v2plus.xml`) |
| IG template | `template/` | `ig.ini` (`template = #local-template`) |
| FHIR resources | `input/sourceOfTruth/**/` | `v2plus.xml` `<parameter>` elements with `path-resource` |
| Page content | `input/pagecontent/` | Standard IG Publisher convention |
| Include files | `input/includes/` | Standard IG Publisher convention |
| Images | `input/images/` | Standard IG Publisher convention |
| Extension definitions | `input/resources/extensions/` | Standard IG Publisher convention |
| IG Publisher JAR | `input-cache/publisher.jar` | `_genonce.sh` |

### Execution

```bash
./_genonce.sh
```

This runs: `java -jar input-cache/publisher.jar -ig . [-tx n/a]`

The `-tx n/a` flag is used when offline (no terminology server access).

### Output

Published IG is written to `output/` directory.

### Current Configuration

The `v2plus.xml` IG definition currently has:
- **Uncommented:** Data type resource paths (primitives and complex)
- **Commented out:** Segment, message, message structure, event, and acknowledgement choreography paths

This means only data types are included in the build. To include other resource types, uncomment the appropriate `<parameter>` sections.

### IG Template

A custom local template at `template/` provides:
- Custom layouts for V2 content rendering
- Navigation structure (`input/includes/menu.xml`)
- Template hooks (`onGenerate-*.xml`, `onLoad-*.xml`)
- Template scripts and configuration

---

## Pipeline Gaps

The following components are needed but don't yet exist:

| Gap | Description | Priority |
|-----|-------------|----------|
| Content injection into FHIR resources | AsciiDoc → HTML → FHIR `definition` fields | High |
| Pagecontent distribution | Domain AsciiDoc → `input/pagecontent/` HTML | High |
| Tabset block processor | Real implementation (currently outputs FIXME) | Medium |
| Message structure block processor | Real implementation (currently outputs FIXME) | Medium |
| Cross-reference auto-linker | Strip legacy refs, build registry, auto-link | High |
| Full IG definition page structure | Only has index and data-types pages defined | Medium |
| Build orchestration script | Single command that runs all preprocessing then IG Publisher | Medium |

---

## Legacy Content Issues

Found during audit:

1. **Word document file references** in FHIR resource definitions:
   ```
   file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70127
   ```
   These need to be replaced with proper IG cross-references.

2. **FIXME placeholders** in message definitions (`"description": "FIXME"`)

3. **Null definitions** in some resource elements (`"definition": null`)

4. **Inconsistent cross-references** in AsciiDoc content (inherited from Word)
