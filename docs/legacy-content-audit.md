# Legacy Content Audit Report

**Date:** 2026-02-25
**Scope:** `input/sourceOfTruth/` (JSON) and `website/` (AsciiDoc)

---

## 1. Word File References (`file:///`)

**Total occurrences:** 1,070 across 211 files

**Affected directories:**
- `segment/segments/` -- 160 files
- `data-type/complex/` -- 51 files

**Pattern:** Nearly all references point to local Windows paths for the HL7 v2.9 Chapter 2C Code Tables document. The references appear inside `"definition"` fields, linking to table anchors.

**Top referenced paths:**
| Count | Path |
|-------|------|
| 923 | `E:\V2\v2.9 final Nov from Frank\V29_CH02C_Tables.docx` |
| 179 | `E:\V2\V29_CH02C_Tables.docx` |
| 3 | `D:\Eigene Dateien\2018\HL7\Standards\v2.9 Jan 2019\...` |
| 2 | `C:\Users\cnewman\Downloads\V281_CH02C_CodeTables.doc` |

**Example (PV2.json):**
```json
"definition": "This field indicates the specific patient accommodations for this visit. Refer to file:///E:\\V2\\v2.9%20final%20Nov%20from%20Frank\\V29_CH02C_Tables.docx#HL70129[_User-defined Table 0129 - Accommodation Code_] in Chapter 2C, Code Tables, for suggested values."
```

**Recommendation:** These are remnants from Word-to-JSON conversion. The `file:///` prefix and Windows path should be replaced with a relative or symbolic reference (e.g., just the anchor `#HL70129` or a cross-reference like `\<<HL70129>>`). The pattern is consistent enough for automated cleanup, but the replacement format should be agreed upon first since it affects how definitions render downstream.

---

## 2. FIXME Placeholders

**Total occurrences:** 727 across 713 files

**Breakdown by directory:**
| Count (files) | Directory |
|----------------|-----------|
| 696 | `message/messages/` |
| 9 | `data-type/primitive/primitives/` |
| 7 | `message-structure/message_structures/` |
| 1 | `message/message.json` |

**Pattern in message files:** The `"description"` field is set to `"FIXME"` in nearly every message definition file.

**Example (ACK-U10.json):**
```json
{
  "abstract": false,
  "type": "Message",
  "description": "FIXME",
  ...
}
```

**Pattern in message.json:** Both `"short"` and `"definition"` fields contain `"FIXME"` for multiple entries.

**Example (message.json):**
```json
{
  "short": "FIXME",
  "definition": "FIXME",
  ...
}
```

**Recommendation:** The message descriptions are systematically missing -- 696 out of ~700 message files have placeholder descriptions. This is a data gap that would require populating from the HL7 v2.9 specification. The primitive data type FIXMEs (9 files) are a smaller, more tractable set.

---

## 3. Null Definitions (`"definition": null`)

**Total occurrences:** 195 across 194 files

**Breakdown by directory:**
| Count (files) | Directory |
|----------------|-----------|
| 192 | `segment/segments/` |
| 2 | `message-structure/message_structures/` |

**Pattern:** Nearly every segment file has exactly one `"definition": null` entry -- this is consistently the segment-level definition (not field-level). The segment fields themselves typically have definitions populated.

**Example (PV2.json):**
```json
{
  "definition": null,
  ...
}
```

**Recommendation:** These null definitions represent missing segment-level descriptions. They are distinct from the FIXME pattern (which appears in message files). Populating these would require extracting segment descriptions from the HL7 v2.9 specification text.

---

## 4. Tabset Block Usage (`[tabset]`)

**Total occurrences:** 259 across 255 files

**Location:** Exclusively in `website/domains/*/technical_specs/*.adoc` files.

**Breakdown by domain:**
| Domain | File Count (approx) |
|--------|---------------------|
| administration/registration | ~55 |
| administration/scheduling | ~25 |
| administration/referral | ~20 |
| clinical/* (pharmacy, lab, blood bank, etc.) | ~80 |
| erp/* (materials, personnel, lab automation) | ~25 |
| financial/* | ~20 |
| technical/* (queries, master files, app mgmt) | ~30 |

**Pattern:** Each technical spec `.adoc` file uses `[tabset]` followed by an event code (e.g., `O11`, `S31`, `N02`). This appears to be a custom AsciiDoc block macro that generates tabbed views of message structures and acknowledgment choreography.

**Example (O11.adoc):**
```asciidoc
[tabset]
O11

[NOTE]
...
```

**Recommendation:** The `[tabset]` macro is a custom Antora/AsciiDoc extension. It is used consistently across all technical spec pages. Any migration to a FHIR IG Publisher workflow would need to either: (a) replicate this rendering in the new toolchain, or (b) convert tabset content to a different format (e.g., static tables).

---

## 5. Message Structure Block Usage

**`[message_structure]` pattern:** 0 occurrences (not used directly in adoc files).

**Related patterns found:**
- `message-structure` appears in AsciiDoc comments as a descriptive term, not as a block macro. Example from `023.adoc`:
  ```asciidoc
  // FIXME we want tabs for OMI^O23^OMI_O23 message-structure, OMI^O23 AckChor, ...
  ```
- `[message_structure` (as a block macro) -- found in 3 files with 15 total occurrences, specifically in the queries domain:
  - `website/domains/technical/queries/examples.adoc` (13 occurrences)
  - `website/domains/technical/queries/general_use_case_background.adoc` (1 occurrence)
  - `website/domains/clinical/imaging/technical_specs/023.adoc` (1 occurrence)

**Recommendation:** Message structure rendering is primarily handled through the `[tabset]` macro (see section 4), not a dedicated `[message_structure]` block. The 15 occurrences found in queries examples may be a different, less common macro variant.

---

## Summary

| Issue | Files Affected | Total Occurrences | Severity |
|-------|---------------|-------------------|----------|
| `file:///` Word paths | 211 | 1,070 | Medium -- broken links in output |
| `"FIXME"` placeholders | 713 | 727 | Medium -- missing content |
| `"definition": null` | 194 | 195 | Low -- missing segment descriptions |
| `[tabset]` blocks | 255 | 259 | Info -- custom rendering dependency |
| `[message_structure]` blocks | 3 | 15 | Info -- minor custom rendering |

### Priority Recommendations

1. **`file:///` references** are the most actionable cleanup: the pattern is consistent and could be automated with a find-and-replace. However, the replacement format needs to be decided (e.g., remove path, keep only anchor reference).

2. **FIXME placeholders** represent a significant data gap (696 message descriptions missing). This is a content authoring task, not a simple cleanup.

3. **Null definitions** are similar to FIXMEs but less numerous. They could be addressed alongside the FIXME effort.

4. **Tabset and message_structure blocks** are not bugs -- they are custom rendering features that need to be accounted for in any toolchain migration.
