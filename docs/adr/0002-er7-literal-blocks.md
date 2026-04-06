# ADR-0002: Use AsciiDoc Literal Blocks for ER7 Content

## Status

Accepted

## Date

2026-02-25

## Context

ER7 (Encoding Rules 7) is the pipe-delimited encoding format used in HL7 V2 messages. ER7 content contains characters that conflict with AsciiDoc markup:
- `^` (caret) is the V2 component separator but triggers superscript in AsciiDoc
- `|` (pipe) is the V2 field separator but can be interpreted as table markup

The existing codebase uses a custom Asciidoctor block processor (`ER7BlockProcessor`) and a preprocessor (`CaretPreprocessor`) to handle ER7 content. The block processor converts `[er7]` blocks into example blocks with the `er7` role, and the preprocessor escapes carets to HTML entities.

This approach works but adds custom processing complexity. Standard AsciiDoc literal blocks (`....`) do not interpret any markup, which means carets, pipes, and other ER7 characters would be preserved as-is without any custom processing.

There are 45 AsciiDoc files currently using `[er7]` blocks.

## Decision

Replace the custom `[er7]` block processor with standard AsciiDoc literal blocks for ER7 content.

- ER7 content will be wrapped in literal block delimiters (`....`)
- An optional `.er7` role can be applied for CSS styling: `[.er7]`
- The `ER7BlockProcessor` will be removed from the Asciidoctor extensions
- The `CaretPreprocessor` will be retained — it is still needed for inline message identifiers in prose (e.g., `EHC^E13`) which appear outside any block context

### Before
```asciidoc
[er7]
|Everyman\^Adam^A\^III^DR\^^L\^^\^^\^^^PHD|
```

### After
```asciidoc
[.er7]
....
|Everyman\^Adam^A\^III^DR\^^L\^^\^^\^^^PHD|
....
```

## Consequences

### Good
- Eliminates a custom Asciidoctor extension, reducing maintenance burden
- Uses standard AsciiDoc features that are well-supported by both Asciidoctor and Asciidoctor.js
- Editor preview in VS Code will correctly render ER7 content
- Simpler mental model for editors — "use a literal block for ER7"

### Bad
- Requires updating 45 existing AsciiDoc files
- Slightly more verbose markup (4 lines vs. 2 lines per ER7 block)

### Neutral
- The `CaretPreprocessor` remains because inline message identifiers (e.g., `ADT^A01`) in prose still need caret escaping
- CSS styling for ER7 blocks can be applied via the `.er7` role class

## Alternatives Considered

### Keep custom ER7BlockProcessor
- **Pros:** Already exists, familiar syntax
- **Cons:** Custom extension adds complexity; Asciidoctor.js may not support it in preview; maintenance burden

### Use listing blocks (`----`) instead of literal blocks
- **Pros:** Also suppresses markup interpretation
- **Cons:** Listing blocks imply source code; literal blocks are semantically more appropriate for data

## References

- [AsciiDoc Literal Blocks](https://docs.asciidoctor.org/asciidoc/latest/blocks/literal-blocks/)
- [AsciiDoc Listing Blocks](https://docs.asciidoctor.org/asciidoc/latest/blocks/listing-blocks/)
