# ADR-0001: Initial Tech Stack

## Status

Accepted

## Date

2026-02-25

## Context

The HL7 V2 standard needs to be transitioned from Microsoft Word documents to a computable, maintainable representation. The publication must be accessible to the broad HL7 V2 implementer community while being maintainable by a small group of editors (~8 people from the V2 Management Group plus working group stewards).

Key constraints:
- Editors are generally not software developers
- The FHIR IG Publisher is the target publication platform (standard in HL7)
- The existing FHIR resources (~1,779 JSON files) were generated from Word documents and hand-crafted (especially primitive data types)
- The pipeline needs a preprocessing step because IG Publisher expects HTML/Markdown, not AsciiDoc

## Decision

We will use the following tech stack:

- **Preprocessing language:** Ruby
- **Content authoring format:** AsciiDoc (transitional — designed for eventual removal)
- **AsciiDoc processor:** Asciidoctor (Ruby gem) for builds; Asciidoctor.js for editor preview in VS Code
- **FHIR version:** R5 StructureDefinitions
- **IG Publisher:** Standard HL7 FHIR IG Publisher, unmodified, with a custom local template
- **Version control / content management:** Git / GitHub
- **CI/CD:** GitHub Actions (planned)
- **Content organization:** Domain-centric (replacing legacy chapter structure from Word)

## Consequences

### Good
- Ruby is the developer's strongest language, enabling rapid iteration on preprocessing
- Asciidoctor is Ruby-native, so preprocessing and AsciiDoc conversion share a runtime
- AsciiDoc is more readable and editor-friendly than raw HTML
- Using unmodified IG Publisher means we benefit from community updates and support
- GitHub provides built-in editing capabilities (single-file editor, web VS Code) for non-developer editors
- Domain-centric organization better reflects how V2 is actually used

### Bad
- AsciiDoc adds a preprocessing step to the pipeline (complexity)
- Asciidoctor.js (editor preview) is not a complete implementation of Asciidoctor — some features don't preview correctly
- Ruby is not widely used in the HL7 FHIR community (most tooling is Java or TypeScript)
- Non-developer editors still face a learning curve with GitHub and AsciiDoc
- Custom IG template requires maintenance as IG Publisher evolves

### Neutral
- AsciiDoc is explicitly transitional — the architecture should support removing it once the full standard is in FHIR IG form
- FHIR R6 is expected to publish before V2+ is complete, but migration should be straightforward (primarily StructureDefinition usage)
- The large number of resources (~1,779+) requires a representative-subset development strategy

## Alternatives Considered

### Markdown instead of AsciiDoc
- **Pros:** Natively supported by IG Publisher; no preprocessing needed for text content; widely known
- **Cons:** Less expressive than AsciiDoc (tables, admonitions, includes); harder for editors working with complex clinical documentation

### TypeScript/Node.js for preprocessing
- **Pros:** Aligns with IG Publisher ecosystem (some tooling is TS); Asciidoctor.js is native
- **Cons:** Developer is less proficient; Asciidoctor.js has known gaps vs Ruby Asciidoctor

### Direct HTML authoring (no AsciiDoc layer)
- **Pros:** No preprocessing needed; exactly what IG Publisher expects
- **Cons:** HTML is much harder for non-developer editors to write and maintain; error-prone

### FSH (FHIR Shorthand) for resource definitions
- **Pros:** More concise than raw JSON; purpose-built for FHIR IG development
- **Cons:** V2 resource patterns may not map well to FSH; existing resources are already in JSON; would require conversion

## References

- [Asciidoctor Documentation](https://docs.asciidoctor.org/)
- [FHIR IG Publisher Documentation](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation)
- [HL7 FHIR R5](https://hl7.org/fhir/R5/)
- [Asciidoctor.js Known Differences](https://docs.asciidoctor.org/asciidoctor.js/latest/)
