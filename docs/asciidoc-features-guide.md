# AsciiDoc Features Guide for Content Editors

This guide documents which AsciiDoc features are safe to use, which only work in the full build, and which to avoid. It is based on an audit of the 814 `.adoc` files in `/workspace/website/`.

## Quick Reference

| Category | Features |
|----------|----------|
| **Safe** (preview + build) | Headings, paragraphs, tables, inline formatting, lists, admonitions (`[NOTE]`), literal blocks (`....`), images, links, `{empty}`, document attributes, `xref:` |
| **Build only** (Ruby Asciidoctor) | `include::`, `[tabset]`, `[.er7]`, `[datatype-definition]`, `[example]`, `[message-structure]`, CaretPreprocessor (^ escaping), SectnumoffsetTreeprocessor |
| **Avoid** | `[source]` blocks (unused), conditional directives (`ifdef`, `ifndef`), complex table cell spans, Asciidoctor.js-only extensions |

---

## Safe Features (Work in Both Asciidoctor and Asciidoctor.js)

These features render correctly in VS Code preview (Asciidoctor.js) and in the Ruby build.

### Headings

**Used in:** 812 of 814 files

Standard AsciiDoc section headings with `=` markers.

```asciidoc
= Document Title (Level 0)
== Section (Level 1)
=== Subsection (Level 2)
==== Sub-subsection (Level 3)
```

### Paragraphs

**Used in:** virtually all files

Plain text separated by blank lines. No special syntax needed.

### Tables

**Used in:** 814 of 814 files (every file has at least one table)

Tables are the most heavily used feature. Common patterns:

```asciidoc
[width="100%",cols="27%,24%,25%,24%",options="header",]
|===
|*Column 1* |*Column 2* |*Column 3* |*Column 4*
|Cell 1 |Cell 2 |Cell 3 |Cell 4
|===
```

**Table attributes used in this project:**
- `width="100%"` (185 files) or `width="99%"` (21 files)
- `cols="..."` with percentage-based column widths (most common pattern)
- `options="header"` (162 files)

**Table cell content types seen:**
- `a|` (AsciiDoc content in cell) - 110 occurrences
- `l|` (literal content) - 60 occurrences

**Safe table practices:**
- Use percentage-based column widths
- Use `options="header"` for header rows
- Simple cell content (text, bold, italic)
- `a|` cells for AsciiDoc-formatted content

### Inline Formatting

**Bold** - Used in 34+ files:
```asciidoc
*bold text*
```

**Italic** - Used in 305+ files:
```asciidoc
_italic text_
```

**Underline** - Used in 5 files:
```asciidoc
[.underline]#underlined text#
```

### Admonitions (NOTE blocks)

**Used in:** 140 files (NOTE), 1 file (IMPORTANT)

Block form (most common in this project):
```asciidoc
[NOTE]
This is a note paragraph.
```

Inline form (3 files):
```asciidoc
NOTE: This is an inline note.
```

Only `NOTE` and `IMPORTANT` are used in this project. `TIP`, `WARNING`, and `CAUTION` are not currently used but are safe to use.

### Literal Blocks (`....`)

**Used in:** 53 files

Used for ER7 message examples and other preformatted text:
```asciidoc
....
|10 ASH LN^#3^LIMA^OH^48132|
....
```

### Images

**Used in:** 10 files

Block image (most common):
```asciidoc
image::blood_product_message_flow_1.png[blood_product_message_flow_1.png]
```

Inline image:
```asciidoc
image:pharmacy_transaction_flow.jpg[pharmacy_transaction_flow]
```

Note: Block images use `image::` (double colon). Inline images use `image:` (single colon).

### Links

**Used in:** 11 files

External URLs:
```asciidoc
http://aurora.rg.iupui.edu/UCUM[UCUM]
https://ucum.org/[UCUM website]
```

### Cross-references (xref)

**Used in:** 33 files

```asciidoc
xref:AD.adoc[AD]
xref:CWE.adoc[CWE]
```

Note: `xref:` works in both environments for simple file references. Complex cross-references that rely on Antora module paths may not resolve in plain Asciidoctor.js preview.

### Document Attributes

**Used in:** 28+ files (attribute references), many files (attribute definitions)

Definition:
```asciidoc
:v291_section: 2A.2.13
:v2type: 'Data Type'
:code: CWE
:name: coded with exceptions
:primitive: false
:generated: Thu, 19 Sep 2024 15:32:55 -0600
```

Reference:
```asciidoc
{empty}
```

The `{empty}` attribute is used in 24 files, typically for numbered list items that don't use AsciiDoc list syntax:
```asciidoc
{empty}1) First item
{empty}2) Second item
```

### Footnotes

**Used in:** 4 files

```asciidoc
Some textfootnote:[This is a footnote.]
```

### Line Breaks

**Used in:** 45 files

Hard line break with ` +` at end of line:
```asciidoc
xref:AD.adoc[AD] +
xref:AUI.adoc[AUI] +
```

---

## Build-Only Features (Work in Asciidoctor Ruby, Not in Asciidoctor.js Preview)

These features require the Ruby build pipeline and custom extensions. They will not render correctly (or at all) in VS Code Asciidoctor.js preview.

### `include::` Directive

**Used in:** 78 files

```asciidoc
include::CWE-components/CWE-1.adoc[]
include::CWE-components/CWE-2.adoc[]
```

**Why it is build-only:** Asciidoctor.js in VS Code can handle basic `include::` directives if the file paths resolve correctly. However, behavior may differ from Ruby Asciidoctor regarding:
- Relative path resolution (depends on VS Code extension configuration)
- Include depth limits
- Error handling for missing files

In practice, simple relative includes (like the component includes above) often work in VS Code preview, but you should verify on a case-by-case basis. The build is authoritative.

### `[tabset]` Custom Block

**Used in:** 255 files (259 occurrences)

```asciidoc
[tabset]
E13
```

This is processed by `TabSetBlockProcessor` (Ruby extension) which generates placeholder text about message/acknowledgement choreographies for the given trigger event code. **This will not render in Asciidoctor.js** because the custom block processor is not loaded.

In preview, the content will appear as a plain paragraph with the event code.

### `[.er7]` Custom Role

**Used in:** 45 files

```asciidoc
[.er7]
....
|150^lb&&ANSI+|
....
```

The `.er7` CSS role styles ER7 message content. The literal block (`....`) renders in both environments, but the `.er7` styling is only applied during the build. Preview will show the content without the custom styling.

### `[.er7-example]` Custom Role

**Used in:** 8 files

Similar to `[.er7]` but for example blocks.

### `[datatype-definition]` Custom Block

**Used in:** 470 files (469 unique files)

```asciidoc
[datatype-definition]
Specifies the lower bound value.
```

This is the most widely used custom block attribute. It marks a paragraph as a data type definition. The specific rendering depends on build-time CSS/processing. In preview, the text appears as a normal paragraph.

### `[example]` Block

**Used in:** 70 files

```asciidoc
[example]
USD is the ISO 4217 code for the U.S. American dollar.
```

Standard AsciiDoc example blocks do render in Asciidoctor.js, but any custom styling applied in the build may differ.

### CaretPreprocessor (^ Escaping)

The Ruby build includes a `CaretPreprocessor` that automatically escapes `^` characters in lines containing ER7 message content or HL7 message identifiers (e.g., `ADT^A01^ADT_A01`). Without this preprocessor, `^` is interpreted as superscript markup in AsciiDoc.

**In preview:** Carets in ER7 content may render as superscript instead of literal `^` characters. To work around this in content that must preview correctly, manually escape carets:
```asciidoc
ADT\^A01\^ADT_A01
```

However, the preprocessor handles this automatically in the build, so manual escaping is generally not needed for build output.

### SectnumoffsetTreeprocessor

Adjusts section numbering by an offset value. Only affects the build when the `:sectnumoffset:` attribute is set. Does not affect preview.

### `[message-structure]` Custom Block

**Used in:** 0 files (currently unused, but the processor exists)

```asciidoc
[message-structure]
message_structure OML^O21^OML_O21
ack_chor OML^O21^OML_O21
```

Processed by the `message-structure_block_processor.rb` extension. Not available in Asciidoctor.js.

---

## Avoid These Features

These features either have known compatibility problems or are not used in this project and may cause unexpected behavior.

### `[source]` Code Blocks

**Not used** in any project files. The project uses literal blocks (`....`) instead. If syntax highlighting is not needed, stick with literal blocks for consistency.

### Conditional Directives (`ifdef`, `ifndef`, `ifeval`)

**Not used** in any project files. These have known differences between Asciidoctor.js and Asciidoctor Ruby regarding attribute resolution timing and scope. Avoid unless you have a specific need and can test in both environments.

### Complex Table Cell Spans

Merging cells across rows/columns with `2+|` or `.2+|` syntax is rarely used in this project and can behave differently between Asciidoctor versions. Stick to simple table layouts.

### Sidebar Blocks (`****`)

**Not used** in this project. Rendering may differ between environments.

### Ordered/Numbered Lists with AsciiDoc Syntax

**Not used** in this project (0 files use `. ` list items). The project uses `{empty}1)`, `{empty}2)` for numbered items instead. Stick with the established convention.

### Unordered Lists with AsciiDoc Syntax

**Used in only 1 file.** The project predominantly uses Unicode bullet characters or paragraph text rather than `* ` or `- ` list markers. While AsciiDoc list syntax is safe, the established convention in this project is different.

---

## Custom Extensions Summary

| Extension | Type | Files Affected | Asciidoctor.js Compatible? |
|-----------|------|----------------|---------------------------|
| `CaretPreprocessor` | Preprocessor | All files with `^` in ER7 content | No - carets may render as superscript in preview |
| `TabSetBlockProcessor` | Block Processor | 255 files | No - renders as plain paragraph in preview |
| `[datatype-definition]` | Block attribute (CSS) | 470 files | Partially - text renders but without custom styling |
| `[.er7]` / `[.er7-example]` | Role (CSS) | 53 files | Partially - literal block renders but without ER7 styling |
| `SectnumoffsetTreeprocessor` | Tree Processor | Files with `:sectnumoffset:` | No - section numbers won't be offset in preview |
| `message-structure` | Block Processor | 0 files (unused) | No |

---

## Feature Usage Statistics

| Feature | Files Using | Total Occurrences (approx.) |
|---------|-------------|----------------------------|
| Headings (`=`) | 812 | — |
| Tables (`\|===`) | 814 | 236+ table delimiters |
| `[datatype-definition]` | 470 | 470 |
| Italic (`_text_`) | 305 | — |
| `[tabset]` | 255 | 259 |
| `[NOTE]` admonition | 140 | 164 |
| `include::` | 78 | 9+ distinct patterns |
| `[example]` | 70 | 70 |
| Literal blocks (`....`) | 53 | — |
| `[.er7]` role | 45 | — |
| Hard line breaks (` +`) | 45 | — |
| Bold (`*text*`) | 34 | — |
| `xref:` cross-references | 33 | 31+ |
| `{empty}` attribute | 24 | — |
| Links (URLs) | 11 | — |
| Images (`image::`) | 10 | — |
| `[.er7-example]` role | 8 | — |
| `[.underline]` role | 5 | — |
| Footnotes | 4 | — |
| `[IMPORTANT]` admonition | 1 | 1 |

---

## Tips for Content Editors

1. **Preview is approximate.** The VS Code Asciidoctor.js preview gives you a good sense of structure, but custom blocks (`[tabset]`, `[datatype-definition]`) and the caret preprocessor only work in the full build.

2. **Carets in HL7 identifiers.** If you see `ADT^A01` rendering with superscript in preview, that is expected. The build preprocessor fixes this automatically. You can manually escape with `\^` if you want preview to look correct, but it is not required.

3. **Tables are the primary content structure.** Nearly every file uses tables. Stick to the established patterns: percentage-based column widths, `options="header"` for header rows, simple cell content.

4. **Use `[NOTE]` for callouts.** It is the only admonition type widely used. Block form (`[NOTE]` on its own line followed by the note text) is preferred over inline form (`NOTE: text`).

5. **Use literal blocks (`....`) for ER7 examples.** Pair with `[.er7]` role for proper build-time styling:
   ```asciidoc
   [.er7]
   ....
   |150^lb&&ANSI+|
   ....
   ```

6. **Use `{empty}` for numbered items** rather than AsciiDoc ordered list syntax, to match the existing convention:
   ```asciidoc
   {empty}1) First item

   {empty}2) Second item
   ```

7. **Check the build output** for any content using custom blocks or extensions. The preview is helpful for basic formatting, but the build is the source of truth.
