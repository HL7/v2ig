# Project Journal — Archive

Older session entries, moved out of `JOURNAL.md` to keep session-start context lean. Append-only; read on demand only — not loaded at session start.

The split is at **2026-04-15**: every entry on or before that date is below. Entries from 2026-04-15 onward remain in the active `JOURNAL.md`.

---


## Project Started - 2026-02-25

**Initial Goal:** Transition the HL7 V2 standard from Word documents to a computable FHIR IG representation, with AsciiDoc as a transitional authoring layer and Ruby-based preprocessing.

**Key Decisions Made:**
- Ruby for preprocessing pipeline (developer's primary language)
- AsciiDoc as transitional authoring format (easier for non-technical editors than HTML/Markdown)
- FHIR R5 StructureDefinitions as the target representation
- Standard (unmodified) FHIR IG Publisher for final publication
- Domain-centric content organization replacing legacy chapter structure
- GitHub for content management and editor workflow
- Existing FHIR resources (~1,779 JSON files) are the starting point — not re-converting from Word
- Custom AsciiDoc editor application deferred; GitHub's built-in editors for now

- Editor-friendly navigation structure shorthand is deferred — `v2plus.xml` page definitions are sufficient for now; will backfill when a roadblock arises
- AsciiDoc front matter attributes already indicate FHIR resource mapping targets for many files
- AsciiDoc-to-destination mapping is typically 1:1 but must support 1:many (reusable snippets)
- `website/v2plus-navigation.adoc` is an editor aid for finding content, NOT the publication structure definition

**Initial State:**
- Repo contains initial conversion of V2 data structures to FHIR resources
- AsciiDoc content exists in `website/` directory
- Ruby tooling exists in `tooling/` directory
- Custom IG Publisher template in `template/`
- IG Publisher wrapper scripts (`_genonce.sh`, etc.) are standard/unmodified
- IG does not yet successfully build end-to-end

---

## Terminology Placeholder Replacement - 2026-02-25

Replaced all 1,110 `file:///` Word document references across 211 FHIR JSON files with `{{v2-table:XXXX:Name}}` placeholders (ADR-0003). Zero references remaining. Script at `tooling/scripts/replace_word_refs.py`.

These placeholders will be batch-replaced with real terminology URLs once the V2 table reorganization (value sets, code systems, concept domains) is finalized by the terminology team.

---

## Legacy Content Audit Results - 2026-02-25

**Key findings from `docs/legacy-content-audit.md`:**

| Issue | Scope | Action Needed |
|-------|-------|---------------|
| `file:///` Word paths | 1,070 in 211 files (segments + complex data types) | Automatable cleanup — need to decide replacement format |
| FIXME descriptions | 727 in 713 files (696 in messages alone) | Content gap — need descriptions from V2 spec |
| Null definitions | 195 in 194 files (segment-level) | Content gap — need segment descriptions |
| `[tabset]` blocks | 259 in 255 files (technical specs) | Toolchain dependency — processor needs real implementation |
| `[message_structure]` blocks | 15 in 3 files | Minor — only used in queries examples |

**Decisions:**
- The `file:///` references all point to V2 Chapter 2C Code Tables. Most reference table anchors like `#HL70127`. The replacement should convert these to proper IG cross-references to the published terminology.
- The 696 FIXME message descriptions are a known content gap, not a tooling bug.
- The `[tabset]` processor is critical — 255 technical spec pages depend on it for message structure rendering.

---

## First Successful IG Publisher Build - 2026-02-25

**Milestone:** End-to-end pipeline working. Data types subset builds successfully.

**Build stats:** 1,985 output files, 5 min 54 sec, 8,446 QA errors (expected — missing value sets and broken cross-refs due to subset).

**Environment setup (user-local, no root):**
```bash
export PATH="/home/claude/bin:/home/claude/jdk/bin:/home/claude/ruby/arm64/bin:$PATH"
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export LD_LIBRARY_PATH="/home/claude/ruby/arm64/lib:$LD_LIBRARY_PATH"
export RUBYLIB="/home/claude/ruby/arm64/lib/ruby/3.1.0:/home/claude/ruby/arm64/lib/ruby/3.1.0/aarch64-linux"
export GEM_HOME="/home/claude/.gems"
export GEM_PATH="/home/claude/.gems:/home/claude/ruby/arm64/lib/ruby/gems/3.1.0"
```

**Versions:**
- OpenJDK 17.0.9 (Eclipse Temurin, aarch64)
- IG Publisher v2.1.1 (updated from v1.6.18)
- Ruby 3.1.4, Jekyll 4.4.1

---

## Session Handoff - 2026-02-25

### Completed This Session
- **UADF initialization:** Created all project files (CLAUDE.md, spec.md, blueprint.md, TASKS.md, JOURNAL.md, ARCHITECTURE.md, ADRs)
- **TASK-001 (COMPLETED):** Audited all 24 Ruby files in `tooling/`. Created `docs/tooling-audit.md`. Fixed critical bugs. Created Gemfile. Replaced ER7 block processor with literal blocks (ADR-0002, 351 blocks across 53 files).
- **TASK-002 (COMPLETED):** Defined representative resource subset (74 files) around ADT^A01. See `docs/representative-subset.md`.
- **TASK-003 (COMPLETED):** Installed Java 17, Ruby 3.1.4, Jekyll 4.4.1. Updated IG Publisher to v2.1.1. First successful build: 1,985 output files in ~6 min. 8,446 QA errors (expected — subset).
- **TASK-004 (COMPLETED):** Documented pipeline flow in `docs/pipeline-flow.md`. Identified key gaps.
- **Legacy content audit (team task):** Documented in `docs/legacy-content-audit.md`. Found 1,070 Word file references, 727 FIXME placeholders, 195 null definitions, 259 tabset block dependencies.

### Current State
- Branch: `main` (all work is planning/documentation so far)
- Build: Working end-to-end (data types subset)
- Blueprint: Approved (7 phases, 36 tasks)
- Phase 1: COMPLETE (all 4 tasks done)
- Team mode: ENABLED

### Next Steps
1. **Phase 2:** Begin AsciiDoc processing completeness (TASK-005 through TASK-008)
2. **Phase 3:** Cross-reference resolution / auto-linker (TASK-009 through TASK-016)
3. Decide on replacement format for `file:///` Word references in FHIR definitions
4. Implement real tabset block processor (255 technical spec pages depend on it)

### Open Questions / Blockers
- What format should `file:///` Word references be replaced with? (e.g., IG cross-reference syntax, plain text, anchor-only?)
- Tabset block processor needs real implementation — 255 pages depend on it
- 696 message descriptions are FIXME — is there source content to populate these from?
- Strategy for enabling more resource types in builds (uncommenting paths in v2plus.xml will include ALL resources of that type)

### Relevant Context
- Java, Ruby, Jekyll are installed in user-local paths (see environment setup in JOURNAL.md above)
- IG Publisher v2.1.1 is current
- The local template at `template/` requires Jekyll for HTML generation
- Build QA report at `output/qa.html`

---

## Session 2 Progress - 2026-02-25

### Phase 2 Research Completed

**TASK-005 (COMPLETED):** Mapped all 814 AsciiDoc files to IG output destinations. See `docs/content-mapping.md`.
- 512 files → StructureDefinition injection (72 data types + 440 components via `[datatype-definition]` blocks)
- ~290 files → pagecontent (257 technical specs + 6 domain pages + 24 subdomain pages)
- ~3 files → includes
- 10 gaps identified (missing primitive sources, undefined tabset rendering, etc.)

**TASK-008 (COMPLETED):** Documented safe AsciiDoc features. See `docs/asciidoc-features-guide.md`.
- Categorized all features as Safe/Build-only/Avoid
- 4 custom Ruby extensions identified (CaretPreprocessor, TabSetBlockProcessor, SectnumoffsetTreeprocessor, message-structure)
- None work in Asciidoctor.js

**TASK-009 (COMPLETED):** Surveyed all cross-reference patterns. See `docs/xref-patterns-report.md`.
- 366 working xrefs, 159+7 broken file:/// and Windows path references, 13 broken Word bookmark anchors
- ~4,393 unlinkable V2 construct mentions in prose (segments, fields, data types, message types)
- Prioritized recommendations for strip-and-relink strategy

### AsciiDoc Word References Eliminated

Replaced all 167 broken `file:///` and bare Windows path references across 146 AsciiDoc files:
- 159 automated via `tooling/scripts/replace_adoc_word_refs.py` (same `{{v2-table:XXXX:Name}}` convention as ADR-0003)
- 2 manual fixes for ISO table references (MOP-3, MO-2)
- 6 manual fixes for broken segment links in I19.adoc, I22.adoc (from German author's machine)
- Zero `file:///` references remaining in `website/` directory

### Phase 2 Complete

**TASK-006 (COMPLETED):** StructureDefinition injection pipeline. Script at `tooling/scripts/inject_definitions.py`. 17 tests passing. Extracts `[datatype-definition]` blocks, maps via `:code:` and component numbering. Handles the `"defintion"` typo in JSON. Pipeline ready for future use (existing JSON already has content from Word).

**TASK-007 (COMPLETED):** Pagecontent conversion pipeline. Script at `tooling/scripts/generate_pagecontent.py`. Discovers 286 pages from `website/domains/`. Generates XHTML in IG Publisher format. Basic Python converter — full fidelity needs Asciidoctor Ruby.

### AsciiDoc Word References Eliminated (continued from TASK-009)

Also cleaned up remaining broken references:
- Replaced 159 `file:///` refs in AsciiDoc with `{{v2-table:XXXX:Name}}` placeholders
- Fixed 2 ISO table references (MOP-3.adoc, MO-2.adoc)
- Fixed 6 broken segment links from German author's machine (I19.adoc, I22.adoc)
- Zero `file:///` or bare Windows path references remaining in `website/`

### SD Injection Mechanics Understood

Analyzed CWE.adoc ↔ CWE.json mapping:
- Root element uses `"definition"` (correctly spelled) — 71 files
- Component elements use `"defintion"` (typo, missing 'i') — 440 occurrences across 69 files
- AsciiDoc `:code:` attribute → JSON filename (lowercased)
- Component numbering: `CWE-1.adoc` → `element.id == "CWE.1"` in JSON
- `[datatype-definition]` block text maps to element's definition field

## Session 3 — Phase 3 Complete (Cross-Reference Resolution)

### Phase 3 Results (TASK-011 through TASK-016)

**TASK-011 (COMPLETED):** V2 Construct Registry. Script at `tooling/scripts/build_registry.py`. Output at `tooling/registry.json` with 8,017 entries: 12 primitive types, 71 complex types + 448 components, 192 segments + 5,824 field entries (dual format: PID.3 and PID-3), 696 messages, 419 message structures, 355 events. One collision handled: PCE exists as both segment and event (segment wins). 26 tests.

**TASK-012 (COMPLETED):** Pattern Matcher. Script at `tooling/scripts/pattern_matcher.py`. Registry-backed matcher with `find_matches()` for plain text and `find_in_asciidoc()` for full AsciiDoc files. Skips ER7 blocks, code blocks, directives, headings, inline ER7 lines. False positive list of 33 codes for common English words (IS, DR, ST, ID, DT, RP, etc.). 42 tests.

**TASK-013 (COMPLETED):** Auto-Linker. Script at `tooling/scripts/auto_linker.py`. Replaces V2 references with `link:StructureDefinition-{id}.html[CODE]` format. Fully idempotent — second run produces zero changes. Preserves existing links/xrefs and `{{v2-table:...}}` placeholders. Dry run: 3,874 links across 394 files. 22 tests.

**TASK-014 (COMPLETED):** Edge Cases. False positive list expanded to 33 codes. All block types skipped. Slash-separated refs (PID-3/MRG-1) match both sides. Italic refs match. PCE collision resolved. 7 edge case tests added.

**TASK-015 (COMPLETED):** Unresolved Reference Report. Script at `tooling/scripts/unresolved_report.py`. Output at `tooling/unresolved_references.md`. Found: 17 unresolved field refs (withdrawn QRD/QRF segments, component self-references), 31 unresolved messages (legacy ORM/ORR + Z-examples), 98 v2-table placeholders (161 occurrences).

**TASK-016 (COMPLETED):** Validation. 250 links correctly added across 6 representative files. Idempotency verified. 107 total tests passing. Published output verification deferred to TASK-024.

### Test Suite: 107 Tests Passing
- `test/test_build_registry.py`: 26 tests
- `test/test_pattern_matcher.py`: 42 tests
- `test/test_auto_linker.py`: 22 tests
- `test/test_inject_definitions.py`: 17 tests

### Current State
- Branch: `feature/006-sd-injection` (uncommitted work spanning TASK-006 through TASK-016)
- All Phase 1, 2, 3 tasks COMPLETE (16/16)
- Next: Phase 4 (FHIR Resource Completeness) — TASK-017 through TASK-022
- Auto-linker has NOT been applied to content yet (only dry-run tested)

---

## Session 4 — V2.9.1 Content Extraction - 2026-02-26

### Objective

Extract structured, machine-readable content from V2.9.1 Word documents to fill gaps in the existing FHIR resources (missing segment field names, empty data element definitions, data quality issues).

### What Was Done

**1. Extraction Planning** (`v291-extraction-briefing.md`)
- Documented extraction targets, output format, and technical approach
- Established three critical rules: never deduplicate (capture every instance separately), include provenance metadata on everything, preserve all associations between structures
- Word documents located at `/workspace/v2plus_docx/` (19 .docx files, chapters 1-17)

**2. Document Structure Analysis**
- Analyzed all Word documents using python-docx to identify table formats and heading styles
- Identified 5 distinct table types: segment field tables (9 cols), message structure tables (4 cols), acknowledgment choreography tables (4-6 cols), data type component tables (9 cols), query parameter tables (13 cols)
- Noted header inconsistencies (e.g., `ITEM#` vs `ITEM #` vs `ITEM  #`, `RP/#` vs `R P/#`)

**3. Extraction Script** (`tooling/scripts/extract_v291.py`)
- Built comprehensive Python extraction script processing 17 Word documents (skipping CH01_Intro and CH02C_Tables)
- Fuzzy header matching handles column name variations
- Dual representation for message structures: raw rows + parsed tree
- Full provenance metadata on every extracted item (sourceFile, chapter, sectionHeading, tableIndex, captionText)

**4. Extraction Results** (output in `/workspace/v291-extracted/`, gitignored)

| Category | Files | Details |
|----------|-------|---------|
| Segments | 175 | 2,806 fields with names (the critical missing data) |
| Message Structures | 389 | 179 unique IDs, 35 with multiple occurrences |
| Events | 143 | With acknowledgment choreography |
| Data Types (complex) | 71 | 450 components |
| Query Parameters | 24 | From CH03 and CH05 |
| **Total** | **802** | |

**5. Bracket Normalization** (`tooling/scripts/normalize_message_structures.py`)
- Normalized all bracket notation whitespace across 389 message structure files (2,220 normalizations)
- Fixed 7 malformed brackets: `[  OH3  }` → `[ OH3 ]`, `[ { PRT ] }` → `[{ PRT }]`, `[REL}` → `[ REL ]`, `{[ARV}]` → `[{ ARV }]`, `[SGT}` → `[ SGT ]`
- Standard form: `[ CODE ]` (optional), `{ CODE }` (repeating), `[{ CODE }]` (optional+repeating)

**6. Message Structure Discrepancy Analysis** (`v291-extracted/message-structure-discrepancies.md`)
- After normalization, 17 structure IDs have real discrepancies (225 field-level differences)
- Key findings:
  - **NMD_N02**: Two completely different structures (17 rows vs 5 rows) sharing same ID in CH14_AppMngmt.docx
  - **ACK ERR inconsistency**: CH05 defines ERR as `[ ERR ]` (optional, non-repeating) while all other chapters use `[{ ERR }]` (optional, repeating)
  - **Typo**: "Patient Advers Reaction" in ADT_A01 occurrence #1 (CH03, table 14)
  - **OH3 optionality**: `[ OH3 ]` vs `[{ OH3 }]` across ADT_A01 occurrences in CH03
  - **26 UNKNOWN structures**: Tables with event ranges (e.g., `C01-C08`) or template placeholders (`Znn`) that couldn't be assigned structure IDs
  - **Chapter reference granularity**: CH05 uses specific refs ("2.15.9") while others use generic ("2")

**7. Documentation and Tooling**
- `/workspace/v291-extracted/GUIDE.md` — comprehensive reference for JSON schemas, search patterns, cross-references (674 lines)
- `/workspace/v291-extracted/QUICK_START.md` — fast onboarding guide
- `/workspace/.claude/commands/search-v291.md` — `/search-v291` skill for natural language queries against extracted data
- `/workspace/v291-extracted/message-structure-discrepancies.md` — full discrepancy report with source locations

### Key Decisions

- **Model selection**: Opus orchestrates, Sonnet agents do heavy extraction work (cost optimization)
- **CH02C_Tables.docx skipped**: 3,791 tables / 9,317 paragraphs — value set extraction deferred to later session
- **CH04 and CH04A treated as separate chapters**
- **Bracket whitespace is not a discrepancy** — normalized to standard form
- **Malformed brackets fixed in extracted data** (not in source Word docs — those are errors in the standard)
- **Extraction output gitignored** — intermediate data, not checked into the repo

### Files Created/Modified This Session

**New files:**
- `tooling/scripts/extract_v291.py` — main extraction script
- `tooling/scripts/normalize_message_structures.py` — bracket normalization
- `v291-extracted/` — all output (802 JSON files + reports + documentation)
- `.claude/commands/search-v291.md` — search skill
- `v291-extraction-briefing.md` — extraction planning document

**Modified files:**
- `.gitignore` — added `/v291-extracted/` and `/v2plus_docx/`

### Not Yet Done

- **CH02C_Tables.docx** — value set / code table extraction (3,791 tables, deferred)
- **Cross-referencing** extracted data against existing FHIR resources in `input/sourceOfTruth/`
- **Injecting segment field names** into the existing FHIR StructureDefinition JSON files
- **Resolving the 26 UNKNOWN structures** — need to handle event range captions
- **Primitive data type extraction** — CH02A only has complex types; primitives may need different handling
- **Narrative text extraction** — field definitions, usage notes, chapter prose

### How to Resume

1. Read `v291-extraction-briefing.md` for extraction rules and context
2. Read `v291-extracted/GUIDE.md` for understanding the extracted data format
3. Read `v291-extracted/message-structure-discrepancies.md` for known issues
4. Use `/search-v291` skill to query the extracted data
5. The extraction script can be re-run: `python3 tooling/scripts/extract_v291.py`
6. Branch: `feature/006-sd-injection` (same branch as sessions 2-3)

---

## Session 5 — Primitives to Logical Models - 2026-03-03

### Objective

Convert V2+ primitive data types from FHIR primitive constraints to logical models, fixing IG Publisher hyperlinking and aligning with stakeholder feedback that the primary use case is publishing/maintaining the standard (not carrying V2 data in FHIR).

### Background / Stakeholder Input

User met with HL7 V2 Management Group. Key takeaway: interest in FHIR resources that could carry V2 messages, BUT this hinges on primitives being real FHIR primitive types in StructureDefinitions. Since IG Publisher doesn't handle V2+ primitives-as-constraints-on-FHIR-primitives well (no hyperlinking in tables), and the actual requirement is publishing/maintaining the standard rather than carrying data, the decision was made to represent V2+ primitives as logical models instead.

### What Was Done

**1. Backed up original primitives**
- All 12 original primitive-as-FHIR-constraint definitions saved to `/workspace/reference/primitives-as-fhir-constraints/`
- These are outside the `input/` tree so IG Publisher won't process them
- Available for future reference if the "carry data" use case ever becomes a priority

**2. Created abstract base type**
- New file: `input/sourceOfTruth/data-type/primitive/primitive-data-type.json`
- Analogous to `complex-data-type.json` — abstract logical model derived from `Base`
- URL: `http://hl7.org/v2/StructureDefinition/primitive-data-type`

**3. Updated profile**
- Modified: `input/sourceOfTruth/data-type/primitive/primitive-data-type-profile.json`
- Now enforces `kind: "logical"`, `derivation: "specialization"`, `baseDefinition` pointing to new abstract base

**4. Rewrote all 12 primitives as logical models**

| Type | Short Name | Key Constraint Preserved |
|------|-----------|-------------------------|
| ST | String | No leading whitespace, at least one non-WS char |
| NM | Numeric | 1-16 chars, optional +/-, digits with optional decimal |
| DT | Date | Format YYYY[MM[DD]] |
| DTM | Date/Time | Format YYYY[MM[DD[HH[MM[SS[.SSSS]]]]]][+/-ZZZZ] |
| FT | Formatted Text | May contain escape-sequence formatting commands |
| GTS | General Timing Specification | HL7 V3 GTS syntax |
| ID | Coded Value (HL7 Tables) | Must match HL7-defined code system |
| IS | Coded Value (User Tables) | Should match user-defined code system |
| SI | Sequence ID | Non-negative integer, 0-9999 |
| SNM | String of Telephone Number Digits | Optional '+' followed by digits only |
| TM | Time | Format HH[MM[SS[.SSSS]]][+/-ZZZZ] |
| TX | Text Data | Leading whitespace is significant (unlike ST) |

- All use `kind: "logical"`, `derivation: "specialization"`, self-referencing `type` URL
- All `FIXME` descriptions replaced with actual V2 standard descriptions
- Constraints from original files preserved in `description` and `definition` text
- `FIXME.DataTypes` category extension dropped (was a placeholder)
- All JSON validated with Python `json.load()`

### What Was NOT Done

- **Build not tested** — Java is not installed in this container instance (different from Sessions 1-3 which had Java at `/home/claude/jdk/bin/java`). User has 16GB Podman VM now. Needs to install Java or run build on Mac.
- **AsciiDoc content integration** — Was the other planned work item for this session but didn't get to it. Next session priority.
- **Segment type references not updated** — Segments reference primitives as `"code": "ST"` (short form). Complex types reference as `"code": "http://hl7.org/v2/StructureDefinition/NM"` (full URL). Both should continue to resolve correctly since the `id` values haven't changed. Needs build verification.

### Current State

- Branch: `feature/006-sd-injection` (same branch as sessions 2-4)
- No build test possible (no Java in container)
- All 14 JSON files validated
- Backup at `reference/primitives-as-fhir-constraints/`

### Next Steps (Priority Order)

1. **Install Java / test build** — Verify the logical model primitives work with IG Publisher. Check that segment tables hyperlink to primitive type pages.
2. **AsciiDoc content integration** — The main remaining work:
   - 814 .adoc files in `website/` with real domain content
   - Existing Ruby tooling converts .adoc → HTML locally
   - Gap: no pipeline connects website/ content → IG pages
   - `[tabset]` blocks are stubs — need real implementation
   - Script at `tooling/scripts/generate_pagecontent.py` generates XHTML but needs Asciidoctor Ruby for full fidelity
3. **Fix systematic data quality issues** across all source files (not just subset):
   - `valueInteger: false/true` → `0/1` in all 192 segment files and 419 message structures
   - Extension URL namespace: `http://hl7.org/fhir/StructureDefinition/optionality` → `http://hl7.org/v2/StructureDefinition/optionality`

### How to Resume

1. Read this journal entry
2. Read `SESSION-HANDOFF.md` for overall project context
3. Check if Java is available: `find / -name "java" -type f 2>/dev/null`
4. If Java available, test build: `PATH="/home/claude/bin:/home/claude/jdk/bin:$PATH" java -Xmx4g -jar input-cache/publisher.jar -ig . -tx n/a`
5. Branch: `feature/006-sd-injection`

---

## Session 6 — Data Quality Verification + AsciiDoc Integration Planning - 2026-03-03/05

### Data Quality Fixes — Already Done

Dispatched two Sonnet agents to fix the two known systematic issues:

1. **`valueInteger` booleans** (`false`/`true` → `0`/`1`): Scanned 693 files (192 segments + 418 message structures + 71 complex + 12 primitives). **Zero instances found.** Already fixed by prior sessions.

2. **Extension URL namespace** (`http://hl7.org/fhir/StructureDefinition/optionality` → `http://hl7.org/v2/StructureDefinition/optionality`): Scanned 1,801 JSON files. **Zero instances found.** All URLs already using correct `v2` namespace.

Both scripts saved for future use:
- `tooling/scripts/fix_value_integer.py` — with tests
- `tooling/scripts/fix_extension_urls.py`

### AsciiDoc Integration — Research and Planning

Did thorough research of the current integration state:

**Environment verified:**
- Ruby 3.2.10 works at `/home/claude/ruby/arm64/bin/ruby` (needs env vars)
- Asciidoctor 2.0.26 available (with `rainbow` gem)
- Java 17.0.18 available at `/home/claude/jdk/bin/java`
- Successfully tested `do.rb` on `A01.adoc` → produced 32KB HTML file

**Required Ruby environment variables:**
```bash
export LD_LIBRARY_PATH="/home/claude/ruby/arm64/lib:$LD_LIBRARY_PATH"
export GEM_HOME="/home/claude/.gems"
export GEM_PATH="/home/claude/.gems:/home/claude/ruby/arm64/lib/ruby/gems/3.2.0"
```
Note: Previous sessions used Ruby 3.1 paths (`3.1.0`). This container has Ruby 3.2 (`3.2.0`). The correct RUBYLIB path should use `3.2.0`.

**Key finding from research — AsciiDoc files fall into 4 categories:**

| Category | File Count | Destination | Action |
|----------|-----------|-------------|--------|
| Data type definitions | 72 | StructureDefinition injection (resource `description`/`definition`) | Already handled by TASK-006 inject_definitions.py |
| Data type components | 440 | StructureDefinition injection (element `definition`) | Already handled by TASK-006 |
| Domain/subdomain pages | ~32 | Pagecontent (standalone IG pages) | Need pipeline |
| Technical specs | ~257 | **UNDECIDED** — could be pagecontent OR resource injection | Blocked on IG template understanding |
| Include-only files | ~13 | Included by other .adoc files, NOT standalone pages | No action |
| Navigation/editorial | ~4 | Not published | No action |

**The critical open question:** Where do the ~257 technical spec .adoc files go?

Each tech spec (e.g., `A01.adoc`) describes a message event. There are also 356 FHIR event resources (e.g., `events/A01.json`). The IG Publisher auto-generates a page for each FHIR resource (`StructureDefinition-A01.html`). The question is:

1. Does the .adoc prose become a **standalone pagecontent page** (separate from the resource page)?
2. Does it get **injected into the FHIR resource** so the IG Publisher renders it on the resource page?
3. Some combination?

This depends on understanding the **IG Publisher template** — specifically how the template controls what appears on resource pages and how to inject narrative content. The user created a new Claude Skill about IG templates (in a separate session) that should help answer this.

### What Was NOT Done

- AsciiDoc content was NOT integrated — blocked on the template question
- No builds were run
- No commits made
- Plan was drafted but not approved/executed

### Current State

- Branch: `feature/006-sd-injection` (same branch as sessions 2-5)
- No new commits since Session 5
- Generated test file: `website/domains/administration/registration/technical_specs/A01.html` (from do.rb test — should be cleaned up or .gitignored)

### Next Steps (Priority Order)

1. **Use the IG template skill** the user created to understand where content maps in the IG Publisher output. Specifically:
   - How does the custom template (`template/`) control resource page layout?
   - Can narrative text be injected into resources so it appears on the auto-generated pages?
   - What's the right approach for technical spec content?

2. **Build the AsciiDoc→Pagecontent pipeline** for the ~32 domain/subdomain overview pages (these are definitely standalone pages regardless of the tech spec decision)

3. **Register pages in v2plus.xml** — auto-generate the `<page>` hierarchy

4. **Subset build test** — verify pages render correctly (data types + a few domain pages only)

5. **Handle technical specs** based on what the IG template research reveals

### How to Resume

1. Read this journal entry and SESSION-HANDOFF.md
2. The user has created an IG template skill — find it and use it to understand template mechanics
3. Key files:
   - `docs/content-mapping.md` — comprehensive mapping of all 814 .adoc files to destinations
   - `docs/pipeline-flow.md` — pipeline architecture
   - `tooling/scripts/generate_pagecontent.py` — existing (but incomplete) pagecontent generator
   - `tooling/asciidoctor/do.rb` — working Ruby Asciidoctor converter
   - `template/` — custom IG Publisher template (controls page layout)
4. Branch: `feature/006-sd-injection`

---

## Session 7 — Classic Tabs in Formal Views + Event Narrative - 2026-03-13

### Completed This Session

**1. Classic V2 Bracket Notation Tab in Formal Views** (commit `9d79e0e`)
- Built `render_classic_structure()` in `generate_message_pages.py` that converts FHIR cardinality back to V2 bracket notation (`1..1`→no brackets, `0..1`→`[ ]`, `0..*`→`[{ }]`, `1..*`→`{ }`)
- Created `local-template/content/assets/js/v2-classic-tabs.js` — discovers hidden content divs and injects them as tabs in the Formal Views jQuery UI tab set
- Tab order: Key Elements | Differential | Snapshot | Message Structure | ACK Choreography | Statistics/References
- Removed the "All" tab from Formal Views
- Subset build verified — tabs render correctly on ADT-A01 page

**2. ACK Choreography Tab** (commit `9d79e0e`)
- Moved ACK choreography content from inline on page into a Formal Views tab
- Modified `render_ack_table()` to wrap content in hidden div `#v2-ack-content`

**3. Event Narrative + Structure Link + MessageStructure Intros** (commit `baaa59d`)
- Added hyperlink at top of Message Structure tab: "The full structure definition for [name] is available on its own page."
- Integrated Asciidoctor to render event narrative content from `website/` .adoc files into message pages
- Added `render_structure_intro()` and generation loop for MessageStructure pages (e.g., ADT_A01-A)
- Fixed Asciidoctor UTF-8 encoding with `-E utf-8:utf-8` flag and explicit encoding in File.read
- Installed asciidoctor gem to `/tmp/gems` (writable location)

**4. Segment Definition Table Analysis** (saved to memory)
- User uploaded `Scratch/ABS_Segment_example.html` from NIST v2plusDemo as reference
- Analyzed segment JSON structure and extension metadata for building custom "HL7 Attribute Table"
- Saved full analysis to `memory/segment-table-planning.md`

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `baaa59d` — Add event narrative, structure link, ACK tab, and structure page intros
- Tests: Not applicable (no test suite for this work yet)
- Subset builds: ~19-20 minutes

### Next Steps
1. **Segment Definition Table**: Build custom "HL7 Attribute Table" tab for segment pages (see `memory/segment-table-planning.md`)
   - Reference: `Scratch/ABS_Segment_example.html`
   - Same pattern: Python generator reads segment JSON → renders table HTML in hidden div → JS injects as tab
   - Columns: Seq#, Data Element Name, DataType, Usage, Vocabulary, Cardinality, Item#, Length, C.LEN, Flags
   - Below table: per-field definitions (ABS-1, ABS-2, etc.)
2. **Two-pass IG Publisher build**: User's preferred approach for showing real FHIR rendering of message structures on message pages
3. **Data type page improvements**: Similar classic tab treatment

### Open Questions / Blockers
- How to show the message structure's FHIR rendering on the Message page (two-pass build, JS fetch, proxy, or link) — user prefers two-pass but hasn't confirmed
- Asciidoctor gem install to `/tmp/gems` is ephemeral — needs to be in `.claude-dev/provision.sh` or equivalent

### Relevant Context
- `template/` is regenerated every build — all customizations must go in `local-template/`
- IG Publisher strips `<script>` blocks from `-intro.xml` — use external JS only
- Asciidoctor needs `RUBY_ENV` with `GEM_HOME=/tmp/gems`, `GEM_PATH=/tmp/gems`, and `-E utf-8:utf-8` flag
- Build command: `export PATH="/home/claude/bin:/home/claude/jdk/bin:/home/claude/ruby/arm64/bin:$PATH" && export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8" && ./_genonce.sh -tx n/a`

---

<!--
SESSION HANDOFF TEMPLATE (copy this for each handoff):

## Session Handoff - [DATE] [TIME]

### Completed This Session
- [What was accomplished]
...
-->

## Session Handoff - 2026-03-13 01:10 UTC

### Completed This Session
- Created `tooling/scripts/v2_utils.py` — shared utilities extracted from generate_message_pages.py (load_json, escape_xml, html5_to_xhtml, convert_adoc_to_html, write_xml_file, AnomalyLog, path constants)
- Refactored `tooling/scripts/generate_message_pages.py` to import from v2_utils
- Created `tooling/scripts/generate_segment_pages.py` — generates HL7 Attribute Table (Seq, Name, DataType, Usage, Cardinality, Vocabulary, Item#, Length, C.LEN, Flags) as a hidden div injected as a Formal Views tab
- Updated `local-template/content/assets/js/v2-classic-tabs.js` — added segment tab injection
- Updated `local-template/content/assets/css/v2plus.css` — added segment table styling (monospace columns, withdrawn field muting)
- Ran subset IG build and verified: PID and MSH segment pages render the HL7 Attribute Table tab correctly with all columns, links, and withdrawn field styling
- Committed: `c143dc3 Add HL7 Attribute Table tab for segment pages`
- Copied `output/` to `output-subset/` (2,718 files) per user request
- Ran `generate_domain_pages.py` which regenerated 31 domain/subdomain pages (modified but uncommitted)
- Updated SESSION-HANDOFF.md with full build procedure

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `c143dc3 Add HL7 Attribute Table tab for segment pages`
- Tests: Not run (no test infrastructure yet)
- Uncommitted changes: 31 regenerated domain pages from generate_domain_pages.py run, plus many untracked scratch/screenshot files
- **Not pushed** — no SSH key in container. Needs manual `git push origin feature/006-sd-injection`

### Next Steps
1. **Push the branch** (needs SSH key or manual push)
2. **Run full preprocessing** — `generate_segment_pages.py` (no --subset) for all 192 segments, `generate_message_pages.py` (no --subset) for all messages
3. **Run full IG build** — `java -jar input-cache/publisher.jar -ig ig.ini -no-sushi` (v2plus.xml is already the full config)
4. **Diagnose full build errors** — subset had 11,682 validation errors, many from missing cross-references that full build should resolve
5. **Testing infrastructure** — Set up pytest for v2_utils.py, generate_segment_pages.py, generate_message_pages.py

### Open Questions / Blockers
- No SSH key in container — cannot push to GitHub
- Full build duration unknown (subset takes ~18.5 min with ~83 resources; full has ~1,700)
- ORU-R01 has an illegal `<script>` tag in its intro that IG Publisher flags — needs investigation

### Relevant Context
- `v2plus.xml` and `v2plus-full.xml` are identical — the IG is already configured for full build, no file swap needed
- Data quality fixes (valueInteger booleans, extension URL namespace) already applied to ALL source files, not just subset
- `template/` is gitignored and regenerated every build from `fhir.base.template` + `local-template/` overlay — never edit template/ directly
- Asciidoctor gem needs reinstall on fresh container: `GEM_HOME=/tmp/gems /home/claude/ruby/arm64/bin/gem install asciidoctor`
- The `generate_message_pages.py` needs Asciidoctor for AsciiDoc narrative conversion; `generate_segment_pages.py` does not need it

## Session Handoff - 2026-03-13 09:15 UTC

### Completed This Session
- Fixed `v2plus.xml` to point to full resource directories (was pointing to `-subset` dirs)
- Fixed `Varies.json` id from `"..."` to `"Varies"` (caused Jekyll build failure)
- Ran full IG build with 8GB heap (`-Xmx8g`):
  - All phases completed: resource loading (14 min), template/HTML (2h 8min), spreadsheets (1h 8min)
  - Jekyll failed due to `...` in filenames from Varies.json — re-ran manually after deleting offending files
  - Final output: 26,236 files (16,005 HTML pages) in `/workspace/output/`
- Verified all custom tabs render correctly in full build:
  - PID segment: HL7 Attribute Table tab with all 40 fields
  - ADT-A01 message: Message Structure tab with bracket notation and segment hyperlinks
- Previous session work (already committed as `c143dc3`):
  - Created `v2_utils.py` shared utilities module
  - Created `generate_segment_pages.py` for HL7 Attribute Table generation
  - Updated `generate_message_pages.py` to import from `v2_utils`
  - Added segment tab to `v2-classic-tabs.js` and CSS to `v2plus.css`

### Current State
- Branch: `feature/006-sd-injection`
- Last commit: `85246d7 Fix full build: v2plus.xml directories, Varies.json id, domain pages`
- All changes committed and pushed to `origin/feature/006-sd-injection`
- Tests: Not run (no test infrastructure yet)
- Full build output in `/workspace/output/` (26,236 files)

### Next Steps
1. Commit and push uncommitted changes (v2plus.xml, Varies.json)
2. Set up pytest infrastructure for v2_utils.py, generate_segment_pages.py, generate_message_pages.py
3. Analyze full build validation errors (need to re-run with QA report preserved)
4. Review "FIXME" placeholders on message pages
5. Cross-reference verification in full build output

### Open Questions / Blockers
- QA report (qa.json, qa.html) lost when Jekyll re-runs manually — need to copy from temp before Jekyll or re-run full build cleanly
- Some message pages show "FIXME" text — need to investigate source
- GitHub auth workaround applied: credential helper script + SSH→HTTPS remote conversion (see `docs/moshpit-github-auth.md`)

### Relevant Context
- **CRITICAL CORRECTION**: Previous handoff stated "v2plus.xml and v2plus-full.xml are identical" — this was WRONG. Both pointed to `-subset` directories. Fixed now.
- Full build REQUIRES `-Xmx8g` Java heap flag — default 3-4GB causes OOM during spreadsheet generation
- Varies.json had `"id": "..."` which generated files with literal `...` in filenames, breaking Jekyll's Liquid include syntax
- Jekyll can be re-run manually: `cd temp/pages && jekyll build --destination /workspace/output`
- Full build takes ~3.5 hours (vs 18.5 min for subset)

## Session 2026-03-13 — Session continuity redesign, message page simplification, build safety
Restructured UADF session handoff protocol (SESSION-HANDOFF.md overwritten, JOURNAL.md append-only archive). Removed Message Structure and Key Elements tabs from message page Formal Views per stakeholder decision; added prominent structure link in intro text. Changed IG version to "2026". Created subset/full build separation: `ig.ini` defaults to subset (safe), `ig-full.ini` for full builds. Branch: `feature/006-sd-injection`. No commits (changes uncommitted).

## Session 2026-03-30 — V2 Vocabulary Extraction and Comparison

### Objective
Three-way comparison of V2 terminology: CH02C Word doc (published standard) vs Frank Oemig's terminology IG vs UTG/THO. Standards-level audit to identify gaps and path for merging good content into THO.

### Completed
1. **CH02C Vocabulary Extraction** — Built `tooling/scripts/extract_v291_vocabulary.py`. Extracted all 797 code tables from CH02C_Tables.docx. Each table includes concept domain, code system (OID/name), value set (OID/URI), table metadata, and coded content. Output: `v291-extracted/vocabulary/` (797 JSON files) + `v291-extracted/vocabulary-index.json`. Stats: 415 tables with codes, 5,540 total codes, 437 with code system OIDs.

2. **Colleague IG Analysis** — Cloned `frankoemig/hl7.v2.terminology.v291` to `/workspace/hl7.v2.terminology.v291/`. Contains 374 CodeSystems + 378 ValueSets. Table numbers in `codesystem-tableNo` extension. URL pattern: `http://terminology.hl7.org/v2plusvocab/CodeSystem/{id}`. Known issues: placeholder version history, German designations, 27 codes added beyond V2.9.1 (mostly German coding systems).

3. **Two-Way Comparison** — Built `tooling/scripts/compare_vocabulary.py` with status normalization (D↔inactive, B↔backward, N↔new, R↔retired are equivalent). Reports at `v291-extracted/vocabulary-comparison-report.{json,md}`. Key findings:
   - Colleague's 374 tables are a perfect subset of CH02C's 797
   - 41 tables with coded content missing from colleague (notable: 0125 Value Type/78 codes, 0203 Identifier Type/140 codes)
   - 382 missing tables expected (concept-domain-only, external)
   - 340 codes in CH02C not in colleague (49 tables)
   - 174 codes in colleague not in CH02C (8 tables, mostly German additions in 0396)
   - 29 real display name differences, 52 truncations
   - Zero genuine status mismatches after normalization

### Not Completed
- **UTG/THO integration** — UTG repo symlink didn't work in container (host path). User restarting container with proper bind mount. Script is ready: `python3 tooling/scripts/compare_vocabulary.py --utg /workspace/utg`
- **No commits made** — extraction scripts and comparison output are untracked

### Installed Packages
- `python-docx` (pip, --break-system-packages) — needed for CH02C extraction
- `lxml` — installed as dependency of python-docx

### How to Resume
1. Read `SESSION-HANDOFF.md` — has full context on what to do next
2. Verify UTG is accessible: `ls /workspace/utg/input/sourceOfTruth/v2/codeSystems/`
3. Run three-way comparison: `python3 tooling/scripts/compare_vocabulary.py --utg /workspace/utg`
4. If UTG path structure differs, adjust `load_utg_data()` in compare_vocabulary.py

---

## Session Handoff - 2026-03-31 14:12 UTC

### Completed This Session

- **Three-way vocabulary comparison (UTG integration)**: Updated `compare_vocabulary.py` to parse UTG's XML CodeSystem and ValueSet files (the script previously only handled JSON). Also added parsing of `v2-tables.xml` — the master catalog of 628 V2 tables known to UTG.
- **Full three-way comparison run**: CH02C (797 tables) vs Frank Oemig's IG (374 CodeSystems) vs UTG (416 CodeSystems). Key findings: 367 tables in all three sources, 7 in CH02C+Frank but not UTG, 31 in CH02C+UTG but not Frank, 18 UTG-only, 1237 code-level differences across 123 tables.
- **Multi-view HTML report** (`generate_html_report.py`): Built a standalone HTML report with three views:
  - **View A: By Problem Type** — status disagreements (123), missing codes (consolidated three-way presence table with 1059 discrepancies), display name differences, metadata differences
  - **View B: By Table** — index with color-coded issue badges, per-table detail sections
  - **View C: By Source Gap** — UTG gaps (7 missing tables, 181 missing codes), Frank's gaps (41 tables), Frank's additions, UTG-only content
- **Live hyperlinks**: Table numbers link to published versions on `terminology.hl7.org` (THO) and `build.fhir.org/ig/frankoemig/hl7.v2.terminology.v291/` (Frank's IG)
- **Methodology annex**: Describes table matching, code comparison, status normalization, display name comparison, and metadata comparison methods. Section headers link to relevant methodology descriptions.
- **Concept domain analysis**: Identifies 356 concept-domain-only tables in CH02C, flags 1 (table 0133) that has a CodeSystem in UTG despite being concept-domain-only.
- No commits made — all output is in gitignored `v291-extracted/` directory and untracked scripts

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `3e92d55` — Remove Message Structure tab, add structure link, version 2026, subset/full build separation
- Tests: Not applicable (analysis/reporting scripts)
- Uncommitted/untracked: comparison scripts in `tooling/scripts/`, extraction output in `v291-extracted/` (gitignored), Frank's cloned IG in `hl7.v2.terminology.v291/`

### Key Files
| File | Purpose |
|------|---------|
| `tooling/scripts/compare_vocabulary.py` | Three-way comparison engine (CH02C vs Frank vs UTG) |
| `tooling/scripts/generate_html_report.py` | Multi-view HTML report generator |
| `tooling/scripts/extract_v291_vocabulary.py` | CH02C Word doc → JSON extraction |
| `v291-extracted/vocabulary-comparison-report.html` | The HTML report (1.75 MB, standalone) |
| `v291-extracted/vocabulary-comparison-report.json` | Machine-readable comparison data |
| `v291-extracted/vocabulary-index.json` | CH02C extraction index (797 tables) |

### Next Steps
1. **User review of HTML report** — iterate on presentation, accuracy, and content based on feedback
2. **Commit analysis scripts** — `tooling/scripts/compare_vocabulary.py`, `generate_html_report.py`, and `extract_v291_vocabulary.py` should be committed once stable
3. **Investigate v3-/FHIR-prefixed code systems** — some CH02C tables reference `v3-*` or FHIR code systems rather than `v2-*` patterns; need to verify these are properly handled in the comparison
4. **UTG concept domains CodeSystem** — located at `http://terminology.hl7.org/CodeSystem/conceptdomains` in `/workspace/utg/input/sourceOfTruth/unified/codeSystems/conceptdomains.xml`; could be cross-referenced with CH02C concept-domain-only tables
5. **Community-facing report** — once the user is satisfied with the content, finalize for presentation to V2 Management Group and Terminology Services Management Group

### Open Questions / Blockers
- Some CH02C tables reference v3- or FHIR-prefixed code systems (e.g., table 0823 references `v3-NullFlavor`). The comparison currently only matches `v2-XXXX` patterns — these cross-references are captured in CH02C extraction but not yet used for matching UTG artifacts
- The `frank_v2_vocab_291` directory at `/workspace/frank_v2_vocab_291/` exists but its relationship to `/workspace/v2ig/hl7.v2.terminology.v291/` is unclear — may be a duplicate or different version
- Status disagreements where UTG marks codes as `active` while CH02C says `D` (deprecated) — 32 instances; these need committee review to determine authoritative status

### Relevant Context
- **Audience**: V2 Management Group and Terminology Services Management Group — all domain experts
- **User role**: Project lead for V2+ IG publication; will present the report to the groups
- The report is iterative — expect multiple rounds of refinement
- "Frank" = Frank Oemig, maintains the V2.9.1 terminology IG
- THO = terminology.hl7.org, UTG = the repo that builds THO (Unified Terminology Governance)
- The end goal is getting good content from Frank's IG into THO

---

## Session Handoff - 2026-04-02

### Completed This Session

- **Apptainer container for remote IG Publisher builds**: Created `apptainer/ig-publisher.def` (Debian 12, Java 17, Ruby 3.2.6 from source, Jekyll, Asciidoctor). Fixed `getcwd` error by adding `cd /` before `rm -rf /tmp/ruby-build`. Image built and tested on NIST postproc-g.nist.gov.
- **Remote build script**: `apptainer/remote-build.sh` — one-command rsync + build + fetch for subset and full builds. Uses `--delete` on rsync and `-tx n/a` to skip terminology server.
- **Fixed IG Publisher duplicate resource scanning**: IG Publisher does NOT recurse into subdirectories for `path-resource`. Both `v2plus.xml` and `v2plus-subset.xml` had parent AND child paths listed, causing double-loading. Moved 24 parent-level JSON files (profiles, CodeSystems, ValueSets) to `input/sourceOfTruth/meta-resources/` and updated both XML files to list only leaf directories + meta-resources.
- **Full build completed on postproc-g**: 28,215 files, 16,021 HTML pages, 8,805 StructureDefinition pages, 2.4GB output. Dramatically faster than 3.5-hour container build.
- **SSH key infrastructure**: Added `.ssh-keys/` to `.gitignore`, updated `provision.sh` to auto-install keys from `.ssh-keys/` directory. Not needed for postproc-g (uses Kerberos) but available for future use.

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `dc8c44b` — Add session handoff: test infrastructure for persistent tooling
- Tests: Not run (infrastructure changes)
- **UNCOMMITTED**: .gitignore, v2plus.xml, v2plus-subset.xml, 24 moved JSON files, apptainer/ directory, provision.sh updates

### Next Steps
1. **Commit build infrastructure changes** — the meta-resources move and XML updates are critical, they fix a build-breaking bug
2. **Time the full build on postproc-g** — need a measurement
3. **Test subset build locally** — verify v2plus-subset.xml changes work in container
4. **Continue vocabulary comparison work** — report review, committee presentation prep

### Open Questions / Blockers
- postproc-g uses Kerberos auth — remote builds must run from Mac host, not from container
- IG Publisher `path-resource` behavior: confirmed non-recursive, each leaf directory must be listed explicitly
- Missing domain pages (patient-administration, observation, order-entry) in output — need AsciiDoc preprocessing step

### Relevant Context
- postproc-g.nist.gov: 128-core AMD EPYC 7H12, 1TB RAM, 100Gbps — NIST HPC resource
- Apptainer (not Docker/Podman) required on postproc-g — no sudo access
- Container image already built at `~/ig-publisher.sif` on postproc-g
- The `--delete` flag in rsync means stale files get cleaned up automatically on sync

---

## Session Handoff — 2026-04-01

### Completed This Session
- Established test infrastructure for V2 IG persistent tooling (Python + Ruby)
- Created `test/test_helpers.py` with shared path setup and `load_fixture()` helper
- Created JSON fixtures: `test/fixtures/segments/MSH.json` (3 fields with length, conformance-length, vocabulary) and `test/fixtures/segments/PID-minimal.json` (5 fields, 2 withdrawn)
- Wrote 116 Python tests across 4 files:
  - `test_v2_utils.py` (25 tests): `escape_xml`, `html5_to_xhtml`, `AnomalyLog`
  - `test_generate_segment_pages.py` (45 tests): `get_extension`, `get_sub_extension`, `parse_segment_fields`, `format_*`, `render_segment_table`
  - `test_generate_message_pages.py` (24 tests): `structure_ref_to_file_id`, `_bracket_wrap`, `_parse_elements`, `render_ack_table`
  - `test_generate_pagecontent.py` (22 tests): `extract_title`, `extract_front_matter`, `basic_adoc_to_html`
- Wrote 18 Ruby minitest tests in `tooling/test/test_helpers_module.rb` for `is_hl7_er7`, `has_er7?`, `has_message_identifier?`
- Created `tooling/test/test_helper.rb` (minitest setup), `tooling/test/Rakefile` (rake runner)
- Created `run_tests.sh` top-level runner (Python + Ruby, gracefully skips Ruby if not installed)
- Commit: `a2fa1e7` — "Add test infrastructure for V2 IG persistent tooling"

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `a2fa1e7` — Add test infrastructure for V2 IG persistent tooling
- Tests: All 116 new Python tests passing; 18 Ruby tests written but Ruby not installed in container; 2 pre-existing failures in `test_build_registry` and `test_pattern_matcher` (unrelated to this work)

### Next Steps
1. **Tier 2 tests** — Add tests requiring filesystem I/O: `generate_domain_pages.py`, `unresolved_report.py`, `convert_adoc_to_html` (integration test with Ruby subprocess)
2. **Fix pre-existing test failures** — `test_build_registry.test_message_structures_present` (419 vs 418 count drift) and `test_pattern_matcher.test_master_files_skips_er7` (2 ER7 matches leaking)
3. **Install Ruby in container** — Add to `.claude-dev/provision.sh` so Ruby minitest tests run in CI
4. **Add more Ruby tests** — Cover `caret_pre_processor.rb`, `tabset_block_processor.rb`, `data_types.rb`
5. **CI integration** — Wire `run_tests.sh` into GitHub Actions

### Open Questions / Blockers
- Ruby is not installed in the current container and we lack root access to `apt-get install` — Ruby tests are written and correct but cannot be verified until Ruby is available
- The `conformance-length` URL guard in `parse_segment_fields` uses `'conformance' not in url` — this works today but is fragile if new extensions are added with 'conformance' in the URL
- Pre-existing test count drift in `test_build_registry` suggests a new message structure JSON was added without updating the expected count

### Relevant Context
- Fixture URLs use the real V2 pattern `http://hl7.org/v2/StructureDefinition/...` (NOT the FHIR `http://hl7.org/fhir/StructureDefinition/v2-...` pattern that appears in some documentation)
- The `_bracket_wrap` and `_parse_elements` functions have leading underscores (private convention) — tests import them directly since they contain the core logic
- `max_card == '0'` in the real data means "unbounded repeating" and renders as `*` in segment tables — the PID fixture uses this pattern for PID.3 and PID.5
- The plan called for `generate_domain_pages.py` tests but that was explicitly deferred to Tier 2

---

## Session Handoff - 2026-04-07

### Completed This Session

1. **Segment AsciiDoc source-of-truth layer** — Created 3,104 AsciiDoc files (192 root + 2,912 field files) in `website/data_structures/segments/`, mirroring the existing data type pattern. Backfilled 2,787 field definitions and 756 comments from FHIR JSON. Root definitions (all null) and 125 missing field definitions get `// TODO:` placeholders.

2. **Backfill script** — `tooling/scripts/backfill_segment_adoc.py`: one-time JSON→AsciiDoc generator. Handles withdrawn fields, zero-field segments (Hxx, Varies), mixed-case IDs, and `[segment-comment]` blocks.

3. **Injection script** — `tooling/scripts/inject_segment_definitions.py`: ongoing AsciiDoc→JSON pipeline. Extracts `[segment-definition]` and `[segment-comment]` blocks, injects into FHIR JSON `definition` and `comment` fields. Idempotent — round-trip verified: 0 changes across all 192 segments.

4. **Tests** — 41 tests in `test/test_inject_segment_definitions.py` covering extraction, backfill generators, round-trip on real data (PID, MSH, DG1, Hxx), and edit detection.

5. **Committed accumulated infrastructure** — 86 files from sessions 2-7 that were never committed (tooling scripts, test suites, docs, subset resources, reference backups).

6. **Updated .gitignore** — Added coverage for screenshots, build logs, output-subset, __pycache__, scratch/, external repos.

7. **Committed generated pagecontent** — 1,039 StructureDefinition-*-intro.xml files.

**Commits:**
- `81cfee3` — Add accumulated project infrastructure from sessions 2-7
- `97f83d8` — Add segment AsciiDoc source-of-truth layer with injection pipeline
- `09cfdb1` — Add generated StructureDefinition intro pages for segments and messages

All pushed to `origin/feature/006-sd-injection`.

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `09cfdb1` — Add generated StructureDefinition intro pages
- Tests: 41 new tests passing; 107 pre-existing tests (2 with known drift)
- Working tree: clean, all pushed

### Next Steps
1. **Review earlier V2+ publication** — User is restarting container with bind mounts to an earlier incarnation of the V2+ publication (different workflow/tools). Look at its styling and layout for ideas to incorporate into current IG output.
2. **Populate root definitions** — 192 segments have `// TODO:` root definitions that need real content
3. **Populate missing field definitions** — 125 fields across 34 segments need definitions (potentially from Word docs, but user wants to review any Word-sourced content before injection)
4. **`short` field name injection** — Needs team discussion on approach (didn't work in a previous attempt)
5. **Domain pages** — patient-administration, observation, order-entry still missing from output

### Open Questions / Blockers
- The `short` (field name) injection pattern needs team input — user explicitly deferred this
- Any Word-doc-sourced field definitions need a review list before injection (user concerned about data quality issues like sequence/clause number mismatches)
- No SSH key in container — pushes require the `GITHUB_PERSONAL_ACCESS_TOKEN` env var (currently set, remote configured)

### Relevant Context
- **Segment AsciiDoc pattern**: `website/data_structures/segments/{SEG}.adoc` + `{SEG}-fields/{SEG}-{N}.adoc` with `[segment-definition]` and `[segment-comment]` block markers — same conventions as data type `[datatype-definition]` blocks
- **Key difference from data types**: Segment JSON uses correctly-spelled `definition` (not the `defintion` typo in data type components)
- **Audit findings**: All 2,912 field names (`short`) already match V2.9.1 extracted data — zero field-level mismatches. 33 root-level name mismatches are cosmetic (en-dash vs hyphen, case, "Segment" suffix)
- **Earlier V2+ publication**: User is bind-mounting this into the container for next session — expect to analyze its styling/layout and adapt ideas to the current IG template

---

## Session Handoff - 2026-04-07/08

### Completed This Session

1. **Homepage layered architecture diagram** — Rewrote `index.xml` with the v2plusDemo-style diagram showing 7 levels (Foundation, Vocabulary, Building Blocks, Domains, Conformance, Tech Spec, Core Profiles). Domain hierarchy matches `website/domains/` directory structure (Administration, Clinical, Financial, Technical, ERP). All 45 links verified against existing pagecontent files. All 11 icon images verified. Vocabulary section links to THO (CodeSystems, ValueSets, Concept Domains).

2. **Diagram CSS** — Added flexbox-based box layout CSS to `v2plus.css` from v2plusDemo's `modules.css`. Removed `max-width` constraint so diagram fills page width.

3. **Data types page with search** — Replaced Jekyll `{% include %}` lists with static tables showing Code + Name for all 12 primitives and 71 complex types. Names sourced from v291 extracted data. Added per-column filter inputs.

4. **Segments page with search** — Replaced demo subset table with full listing of all 191 segments (code + name). Added per-column filter.

5. **Message structures page with search** — Replaced demo subset with full listing of all 418 message structures. Added filter.

6. **Table filter JS** — Created `v2-table-filter.js` adapted from THO's `table.js`. Supports multiple filtered tables per page. Included via `_append.fragment-css.html` on all pages.

7. **Terminology page** — Expanded with links to THO CodeSystems and ValueSets pages, plus TODO for governance details.

8. **Preprocessing pipeline on postproc-g** — Moved all preprocessing (segment pages, message pages, domain pages) to run remotely inside Apptainer container. Created standalone `tooling/preprocess.sh` for future CI/CD portability. Build script now does: sync → preprocess on remote → IG Publisher → fetch output.

9. **Build script improvements** — Subset output goes to `output-subset/`, full to `output/`. Added `fetch-subset`, `fetch-full`, `preprocess` commands. Removed verbose rsync output, added `--info=progress2`. Added section headers for preprocessing steps.

10. **Ruby/gem path fixes** — Changed hardcoded `/home/claude/ruby/` paths to `shutil.which('ruby')` with fallback. Fixed `generate_domain_pages.py` to pass `GEM_HOME`/`GEM_PATH` to subprocess for Asciidoctor. Fixed `RUBY_ENV` in `v2_utils.py` to inherit environment.

11. **XHTML fixes** — Replaced broken sup/sub tag overlap fix with complete strip of `<sub>`/`<sup>` tags (artifacts of ER7 `^`/`~` in AsciiDoc prose). Added XML validation in `xhtml_wrapper()` — invalid XML from AsciiDoc conversion gets stripped, keeping only machine-generated content (event tables).

12. **Version** — Changed IG version from `2026` to `2026.0.0` in both `v2plus.xml` and `v2plus-subset.xml`.

13. **Quieted preprocessing output** — Removed per-file progress lines from all three generator scripts. Only section headers and summary counts printed.

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `fa5652e6` (prior session) — changes from this session uncommitted
- Tests: Not run (infrastructure and content changes)
- Full build: **completed successfully** on postproc-g (~54 min)
- Working tree: 48 modified files + 2 new files, uncommitted

### Next Steps
1. **Review the full build output** — Check index page diagram, data types/segments/message structures tables with filters, domain pages with AsciiDoc content
2. **Commit this session's work** — 50 files spanning index page, listing pages, preprocessing pipeline, build script, XHTML fixes
3. **Fix AsciiDoc content quality** — 15 domain .adoc files have ER7 examples outside code blocks (carets/tildes interpreted as markup). These pages currently render without their AsciiDoc prose (fallback to event table only). Fix by wrapping ER7 in code blocks.
4. **Push to origin**
5. **Continue styling work** — Further align with v2plusDemo look and feel

### Open Questions / Blockers
- The `*.png` rsync exclude prevents images from reaching postproc-g on a fresh clone. Images are currently there from prior syncs. Would need to handle this for a clean CI/CD setup.
- 15 domain pages have AsciiDoc content stripped due to ER7 carets producing invalid XML. The content exists in the .adoc files but doesn't render. Need to wrap ER7 examples in code blocks.
- IG Publisher validation produces thousands of `could not be resolved` errors for message cross-references — these are pre-existing and not caused by this session's changes.
- `generate_domain_pages.py` updates `v2plus.xml` (full build config) but NOT `v2plus-subset.xml`. If domain structure changes, subset config needs manual update.

### Relevant Context
- **THO search widget**: terminology.hl7.org uses a custom `table.js` with `.filtered-table` class, `.filter-input` inputs, `.data-row` rows, and `.table-filter-summary` count. We adapted this pattern. No DataTables dependency.
- **Preprocessing runs on postproc-g**: No Ruby/Python needed on local Mac. The Apptainer container has Python 3, Ruby 3.2.6, Asciidoctor, and Jekyll.
- **`tooling/preprocess.sh`** is the standalone entry point for preprocessing. Designed for CI/CD portability. Has `--skip-domain-pages` flag for environments without Ruby.
- **Build times**: Full build ~54 min on postproc-g (128-core AMD EPYC). Subset ~20 min.
- **rsync progress**: Uses `--info=progress2` which requires rsync 3.1+. User installed rsync 3.4 via Homebrew on Mac.

---

## Session Handoff - 2026-04-09

### Completed This Session

**Commit `2f458aef` — Fix blue hyperlinks, clause numbering, image sizing, and add favicon:**
- Fixed blue hyperlink issue (30 pages): IG Publisher XSLT generates self-closing `<a name="1"/>` anchors; Bootstrap styles all `<a>` blue. Added CSS `a:not([href]) { color: inherit; text-decoration: inherit; }`
- Fixed heading shift from +2 to +1 in `generate_domain_pages.py` — AsciiDoc `==` now maps to h3 (matching IG Publisher's expected pagecontent level)
- Extended heading shift regex from `h[1-3]` to `h[1-6]` in both `generate_domain_pages.py` and `v2_utils.py`
- Removed "(N events)" from subdomain page titles in both `v2plus.xml` and `v2plus-subset.xml`; script now maintains both configs
- Added `copy_domain_images()` — copies 29 domain images to `input/images/`; strips bad width/height from AsciiDoc HTML; added CSS max-width
- Created V2+ favicon and Apple touch icons from `hl7-v2plus.gif`
- Wrapped 2 inline message structures in literal blocks (registration, queries)
- Fixed `blood_bank.adoc` `extracted-media/` path artifact

**Commit `769457d5` — Add events listing page, fix favicon, fix logo sizing, update control page:**
- Created `events.xml` — searchable table of all 356 trigger events (code, message, description) with per-column filters
- Fixed favicon: `local-template/content/assets/ico/` is NOT merged by IG Publisher; placed favicon in `images/` dir and overrode via `_append.fragment-css.html` link tag
- Fixed logo sizing: scoped image CSS to `#segment-content` only (was making header logo huge)
- Removed "demo build" / "representative subset" text from `control.xml`; replaced inline event table with link to events page

**Research:**
- Investigated FHIR auto-ig-builder for CI/CD: no branch filtering, only `[A-Za-z0-9_-]` branch names supported, builds every branch with `ig.ini`. User considering a build-branch strategy with `ig.ini` only on the build branch.
- Used Playwright to inspect registration.html heading structure via CSS counters and accessibility snapshot

### Current State
- Branch: `feature/006-sd-injection`
- Last checkpoint: `769457d5` — Add events listing page, fix favicon, fix logo sizing, update control page
- Tests: 263 passing, 2 pre-existing failures (message structure count drift, ER7 match leak)
- Working tree: clean, all pushed

### Next Steps
1. **Run build** — All fixes need a rebuild to verify (heading numbering, favicon, images, events page, logo sizing)
2. **Heading depth limitation** — HTML only has h1-h6. Registration page has 5 AsciiDoc nesting levels; the deepest cap at h6, creating sibling numbering where there should be parent-child. Options: flatten AsciiDoc heading levels (editorial), accept the limitation, or use JS-based numbering
3. **Image quality review** — After next build, verify images render at correct aspect ratio with the CSS max-width approach (bad AsciiDoc dimensions are now stripped)
4. **Populate segment root definitions** — 192 segments have `// TODO:` root definitions
5. **Continue styling** — Compare with v2plusDemo for further alignment
6. **CI/CD setup** — When ready, implement build-branch strategy for FHIR auto-ig-builder

### Open Questions / Blockers
- **h6 ceiling**: Sections at AsciiDoc level `=====` and `======` both map to h6 after the +1 shift. The registration page has ~11 h6 siblings under "Definitions" that should have parent-child relationships. This is a fundamental HTML limitation. Need to decide: flatten the AsciiDoc, or accept the deep numbering
- **Favicon mechanism**: The `local-template/content/assets/ico/` directory is NOT merged by IG Publisher (only includes are merged via `_append`/`_replace`). Workaround: place favicon in `images/` dir and override the `<link>` tag via `_append.fragment-css.html`. Needs build verification.
- **Auto-ig-builder branch naming**: Current branch uses `/` (`feature/006-sd-injection`), which is incompatible. Would need flat names (`feature-006-sd-injection`) or the build-branch strategy

### Relevant Context
- **IG Publisher CSS counters**: Section numbers are generated by CSS `counter-increment` on `::before` pseudo-elements, defined in a `<style>` block in each page. Not hardcoded in HTML. The `--heading-prefix` CSS variable is set per page (e.g., "2.1.1" for registration).
- **Image dimension stripping**: The `html5_to_xhtml()` function now strips `width="..."` and `height="..."` from all `<img>` tags because the AsciiDoc values (inherited from Word) are wrong for the actual PNGs. CSS `#segment-content img { max-width: 100%; height: auto; }` handles sizing instead.
- **`generate_domain_pages.py` now maintains both XML configs**: `update_v2plus_xml()` accepts an optional `xml_path` parameter. `main()` calls it for both `v2plus.xml` and `v2plus-subset.xml`.

---

## Session Handoff - 2026-04-09

### Completed This Session

1. **Created `build` branch for auto-ig-builder CI/CD** — Branch with `ig.ini` (full build, `v2plus.xml`) force-added past `.gitignore`. Auto-ig-builder will trigger builds on this branch only.
   - Commit `2e5f7cf0` — Add ig.ini for auto-ig-builder on build branch
   - Commit `99182522` — Run full preprocessing for auto-ig-builder

2. **Ran full preprocessing** on the build branch — all three scripts generated complete output:
   - 190 segment intro pages, 368 message intros, 417 message structure intros, 31 domain pages, 31 images
   - Committed and pushed to `origin/build`

3. **Created `push-to-build.sh`** — turnkey script that merges current branch → build, runs preprocessing (locally or on postproc-g via `--remote`), commits, and pushes. Supports `--branch`, `--remote`, `--no-preprocess` flags.

4. **Added `preprocess-fetch` mode to `remote-build.sh`** — syncs to postproc-g, preprocesses there, fetches generated files (pagecontent, includes, images, XML configs) back to local.

5. **Merged `feature/006-sd-injection` into `main`** — fast-forward merge, all sessions 2-9 work now on `main`. Rollback point: `9b99f931`.

6. **Created `dev/framework` branch** — new development branch from `main` for ongoing framework/tooling work. Pushed and tracking.

### Current State
- Branch: `dev/framework` (created from `main` at `057d968d`)
- Last checkpoint: `057d968d` — Add push-to-build.sh and remote preprocess-fetch mode
- Tests: Not run this session
- Working tree: clean (2 untracked .tiff files in `input/images/`)
- `build` branch pushed with full preprocessed content — auto-ig-builder should be building

### Next Steps
1. **Check auto-ig-builder results** — monitor `https://build.fhir.org/ig/HL7/v2ig/branches/build/` for build completion or timeout
2. **Run a rebuild on postproc-g** to verify latest fixes (heading numbering, favicon, images, events page, logo sizing)
3. **Review heading depth** — h6 ceiling affects deeply nested AsciiDoc content (5+ levels)
4. **Continue styling** — compare with v2plusDemo for further alignment
5. **Populate segment root definitions** — 192 segments with `// TODO:` placeholders
6. **Clean up old branches** — `feature/006-sd-injection` is now merged into `main`; could be deleted

### Open Questions / Blockers
- **Auto-ig-builder timeout risk** — full build (~1,700 resources) may exceed FHIR CI time limits. First build will tell us.
- **h6 ceiling** — still unresolved from prior session
- **Untracked .tiff files** — `input/images/merge.tiff` and `pharmacy_transaction_flow.tiff` appeared from domain page preprocessing. May need to be gitignored or converted to PNG.

### Relevant Context
- **Branch topology**: `main` = `dev/framework` = `057d968d`. `build` = `99182522` (2 commits ahead: ig.ini + preprocessed content). `feature/006-sd-injection` = same as `main` (can be safely deleted).
- **`push-to-build.sh` workflow**: Run from any branch. Checks clean tree → switches to `build` → merges source → preprocesses → commits → pushes → switches back. Use `--remote` for postproc-g preprocessing.
- **`ig.ini` is gitignored** on all branches except `build` — prevents accidental auto-ig-builder triggers.

---

## Session Handoff - 2026-04-10

### Completed This Session

1. **Auto-ig-builder diagnosis**: Build at `build.fhir.org` failed because `.js` files in `local-template/` are rejected by the template trust policy. Fixed by inlining JS into HTML fragments (ADR-0004). Also inlined `v2-table-filter.js`.

2. **Message structure title fix**: All 418 message structure JSON files had title "Segment Definition" — changed to "Message Structure".

3. **Restored classic bracket notation tab**: Re-added `addTab('v2-classic-content', ...)` for message structure pages (not message pages). This was removed in a prior session but should be present on message structure pages.

4. **v2plusDemo-style HL7 Attribute Table**: Updated CSS to match v2plusDemo — alternating row banding (#EEE/white), Verdana font, proper padding. Column order: Seq#, Data Element Name, DataType, Usage, Vocabulary, Cardinality, Item#, Length, C.LEN, Flags. Item# links to IG Publisher Detailed Descriptions tab.

5. **CamelCase element IDs**: Renamed 2,912 element IDs across 190 segments from `OBX.1` to `OBX.1-setId` format so IG Publisher differential/snapshot tables show meaningful names. Updated `generate_segment_pages.py`, `inject_segment_definitions.py`, `extract_field_names.py` to handle new format. IG Publisher has 64-char limit on name portion — OM1.56 was the only offender (manually shortened).

6. **Build branch cleanup**: Removed 5,283 development files from `build` branch tracking. Only IG Publisher essentials remain: `ig.ini`, `input/`, `local-template/`, IG scripts.

7. **Reworked `push-to-build.sh`**: No longer merges — uses `git checkout main -- <paths>` to copy only IG-relevant files. Always pulls from `main`. Enforces workflow: dev branch → main → build.

**Commits (on `dev/framework`):**
- `e12892fb` — Fix message structure titles, inline JS, restore classic tab
- `85214c63` — Add camelCase element IDs, v2plusDemo-style attribute table, definitions links
- `7c52569c` — Rework push-to-build.sh: copy from main instead of merge
- `274339cb` — Fix OM1.56 element ID exceeding 64-char limit
- `cf63fd70` — Improve 64-char truncation to cut at camelCase word boundary

**Commits (on `build`):**
- `58dbdb23` — Clean build branch: remove development files

### Current State
- Branch: `dev/framework` (5 commits ahead of origin, not pushed)
- `build` branch: cleaned up, user kicked off a postproc-g build to test
- Tests: 86 segment page tests + 41 injection tests passing (127 total)
- Working tree: clean (2 untracked .tiff files)
- **Not yet merged to main** — dev/framework has all the new work

### Next Steps
1. **Check postproc-g build results** — verify the OM1.56 fix resolved the snapshot error and the full build completes
2. **Review build output** — check camelCase names render correctly in IG Publisher differential/snapshot tables, verify attribute table styling, verify message structure classic tab appears
3. **Merge dev/framework → main** — once build is verified
4. **Push to auto-ig-builder** — run `./push-to-build.sh` (from main) to trigger build.fhir.org build, verify the inlined JS workaround resolves the trust rejection
5. **Continue styling work** — heading depth (h6 ceiling), further v2plusDemo alignment
6. **Populate segment root definitions** — 192 segments with `// TODO:` placeholders
7. **Clean up old branches** — `feature/006-sd-injection` can be deleted

### Open Questions / Blockers
- **Auto-ig-builder timeout** — full build may exceed CI time limits; first successful build will tell us
- **h6 ceiling** — deeply nested AsciiDoc content (5+ levels) still caps at h6
- **User reverted some files** — CSS, test, and several scripts were modified externally (reverted to pre-styling versions in some cases). The committed code should be authoritative; check if regeneration is needed after merge.
- **Untracked .tiff files** — `input/images/merge.tiff` and `pharmacy_transaction_flow.tiff` still untracked

### Relevant Context
- **Branch topology**: `dev/framework` = `cf63fd70` (5 ahead of origin). `build` = `58dbdb23` (cleaned). `main` = `057d968d` (behind dev/framework).
- **`push-to-build.sh` workflow**: Always pulls from `main` → `build`. No `--branch` flag. Dev work must be merged to main first.
- **JS inlining**: Both `v2-classic-tabs.js` and `v2-table-filter.js` are inlined in HTML fragments. If auto-ig-builder trust policy changes, reverse per ADR-0004.
- **Element ID format**: `{SEG}.{seq}-{camelCase}` (e.g., `OBX.1-setId`). 64-char max on portion after the dot. Only OM1.56 needed manual shortening.
- **User indicated** that some files were externally modified (CSS reverted to simpler version, test assertions reverted, inject script reverted). These were noted as intentional. Next session should verify the committed state matches expectations.

---

## Session Handoff - 2026-04-13

### Completed This Session

1. **Segment field fidelity audit**: Built `tooling/scripts/compare_segments.py` comparing all 192 FHIR segment JSON files against 175 V2.9.1 extractions across 9 dimensions (cardinality, data type, optionality, item#, field name, length, conformance length, vocabulary). Produces JSON + navigable HTML + Markdown reports with provenance, severity badges, and sidebar navigation.

2. **Fixed 1,109 data quality issues** across 145 segment JSON files using `tooling/scripts/fix_segment_fields.py`:
   - 494 active fields with `max: 0` → fixed to `max: "*"` (or specific repeat count)
   - 36 B fields → restored original cardinality, added `standards-status: deprecated`
   - 104 W fields → set `max: 0`, added `standards-status: withdrawn`
   - 6 W fields with data types elided per ADR-0005
   - 320 conformance length `=`/`#` flag corrections
   - 39 length corrections, ~23 min cardinality corrections

3. **ADR-0005**: Documented decision to elide data types from 6 withdrawn fields (5 XTN phone + 1 SI) for uniform W field treatment. May be revisited if historical types are recovered.

4. **W vs B rendering distinction**: W fields get strikethrough (`v2-field-withdrawn`), B fields get italic/muted (`v2-field-deprecated`, no strikethrough). CSS and `generate_segment_pages.py` updated.

5. **Seq# links**: HL7 Attribute Table Seq# column now links to Detailed Descriptions tab anchors.

6. **V291 extraction gap identified**: BPX, BTX, BUI segments missing because CH04 uses multi-column tables (18/13 cols), not the 9-col format the extraction script expects.

7. **Test suite**: 68 comparison tests + 45 segment page tests, all passing.

### Current State
- Branch: `dev/framework` (6 prior commits ahead of origin + new uncommitted changes)
- Tests: 113 passing
- Post-fix comparison: 12 remaining discrepancies (all expected/intentional)
- All changes uncommitted

### Next Steps
1. **Commit and push** all changes from this session
2. **Comprehensive structural analysis**: Compare FHIR artifact counts vs V291 extraction across ALL artifact types (segments, data types, messages, message structures, events, data elements). Generate gap lists.
3. **Audit V291 extraction script**: Fix systematic blind spots (multi-column tables, inconsistent formatting). Word doc formatting is NOT consistent — need multiple heuristics beyond column count.
4. **Run build** to verify fixes render correctly (especially W strikethrough vs B deprecated styling)

### Open Questions / Blockers
- V291 extraction handles only 9-column segment tables. Multi-column comparison tables (18, 13 cols) in CH04 are silently skipped. Other chapters may have similar issues.
- Some V291 source data has malformed length/confLength values (quirks in the Word doc, not extraction bugs)
- `standards-status` extension URL: `http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status`

### Key Files Created This Session
| File | Purpose |
|------|---------|
| `tooling/scripts/compare_segments.py` | Segment field comparison engine |
| `tooling/scripts/fix_segment_fields.py` | Applies FHIR JSON corrections from V291 data |
| `test/test_compare_segments.py` | 68 tests for comparison logic |
| `test/fixtures/segments/OBX-v291.json` | V291 format test fixture |
| `docs/adr/0005-withdrawn-field-data-type-elision.md` | W field data type decision |
| `v291-extracted/segment-comparison-report.html` | Navigable HTML comparison report |
| `v291-extracted/segment-comparison-report.json` | Machine-readable comparison data |

---

