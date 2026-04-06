# ADR-0003: Terminology Reference Placeholder Convention

## Status

Accepted

## Date

2026-02-25

## Context

The FHIR resource definitions inherited from the Word-to-JSON conversion contain 1,110 references to local Windows file paths pointing to the HL7 V2 Chapter 2C Code Tables document. These references are broken in any context other than the original author's machine.

The proper resolution of these references is complex because V2 tables are being reorganized:
- Some tables will become HL7-owned value sets backed by HL7-owned code systems on terminology.hl7.org
- Some tables represent concept domains (represented in an HL7 concept domain code system, still being finalized)
- Some tables reference value sets backed by non-HL7 code systems
- A colleague is working on the complete reorganization; the target structure is not yet settled

## Decision

Replace all `file:///` Word document references with a machine-parseable placeholder convention:

```
{{v2-table:XXXX:Table Name}}
```

Where:
- `XXXX` is the V2 table number (e.g., `0127`)
- `Table Name` is the human-readable name (e.g., `Allergen Type`)

These placeholders will be batch-replaced with actual terminology URLs once the reorganization is complete and target destinations are known.

### Example

Before:
```
Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70127[_User-defined Table 0127 - Allergen Type_] in Chapter 2C, Code Tables, for suggested values.
```

After:
```
Refer to {{v2-table:0127:Allergen Type}} in Chapter 2C, Code Tables, for suggested values.
```

## Consequences

### Good
- All 1,110 broken Word file references eliminated from 211 files
- Placeholder convention is machine-parseable for future batch replacement
- Table numbers and names are preserved for when real URLs are available
- Convention is distinct from any AsciiDoc, HTML, or JSON syntax (no collision risk)

### Bad
- These are still not real links — they will render as literal text in the published IG until replaced
- Two-step process required (placeholder now, real URL later)

### Neutral
- The replacement script is preserved at `tooling/scripts/replace_word_refs.py` for reference
- When terminology destinations are finalized, a new script can find all `{{v2-table:` patterns and replace them

## Alternatives Considered

### Direct replacement with terminology.hl7.org URLs
- **Pros:** One-step process, immediately working links
- **Cons:** Many tables don't yet have stable URLs on terminology.hl7.org; some aren't value sets at all (concept domains); would need to be redone when reorganization completes

### Leave Word references in place
- **Pros:** No work now
- **Cons:** Broken links in all contexts; harder to find and replace later; unprofessional in published output

## References

- Legacy content audit: `docs/legacy-content-audit.md`
- Replacement script: `tooling/scripts/replace_word_refs.py`
