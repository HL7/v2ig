# Cross-Reference Patterns Report

**Date:** 2026-02-25
**Scope:** 814 AsciiDoc files in `/workspace/website/`
**Purpose:** Catalog all link/cross-reference patterns to inform strip-and-relink strategy

---

## 1. AsciiDoc Link and Cross-Reference Patterns

### 1.1 `xref:` References

- **Occurrences:** 366
- **Files:** 33
- **Status:** WORKING

All 366 `xref:` references follow the `xref:FILENAME.adoc[Display Text]` pattern and point to relative `.adoc` files. These are used primarily in navigation pages.

**Representative examples:**
```
xref:AD.adoc[AD]
xref:CWE.adoc[CWE]
xref:registration.adoc[Patient Administration]
xref:referral.adoc[Referral]
```

**Location pattern:** Found predominantly in:
- `data_structures/data_types/complex/navigation.adoc` (71 xrefs — data type listing)
- Domain-level navigation files (e.g., `domains.adoc`, `clinical.adoc`, `administration.adoc`)
- Domain chapter files linking to sub-sections (e.g., `registration.adoc` with 55 xrefs)

**Assessment:** These appear structurally correct and functional. They form the site's navigation backbone.

---

### 1.2 `link:#` References (In-Page Anchors)

- **Occurrences:** 43
- **Files:** 22
- **Status:** MIXED — some working, many broken

These are HTML-style fragment links that point to anchors within the same page. They fall into distinct sub-categories:

#### 1.2a Working `link:#` anchors (auto-generated from section headings)

These reference AsciiDoc auto-generated section IDs and resolve correctly within the rendered page:

```
link:#merging-patientperson-information[_3.6.2_]
link:#merge[_3.6.2.1.2_]
link:#move[_3.6.2.1.3_]
link:#change-identifier[_3.6.2.1.4_]
link:#patient-record-links[_3.6.3_]
link:#swapping-a-patient[_3.6.1_]
link:#ordered-pairwise-relationship[_Ordered pairwise relationship_]
link:#qbprsp-query-by-parametersegment-pattern-response-events-vary[5.4.1]
```

These are concentrated in:
- `domains/administration/registration/` (implementation_considerations.adoc, technical_specs/)
- `domains/technical/queries/examples.adoc`

**Estimated working:** ~30 of 43

#### 1.2b Broken `link:#` anchors (Word bookmark artifacts)

These contain Word-era bookmark IDs that do not exist as AsciiDoc anchors:

```
link:#_Hlt489245616[0403]
link:#_Hlt489245619[0404]
link:#_MFI-3___File-Level Event Code   (ID[_8.5.13_]
link:#_MFE-1___Record-Level Event Code   ([_8.5.2.1_]
link:#_A45_-_move_visit information - visi[_A45 - Move visit information_]
link:#_Global_merge_and_move message const[_3.6.2.1.9_]
link:#_Identifier_type_/_assigning authori[_Identifier type/assigning authority_]
link:#_Name_of_Coding_System (ID)[_2A.2.8.3_]
```

The `_Hlt` prefix is a classic Word internal bookmark. Others have spaces and special characters that are invalid AsciiDoc anchor IDs.

**Estimated broken:** ~13 of 43

#### 1.2c Data type component anchors

A few `link:#` references target data type component sections:

```
link:#a.2.56.20-effective-date-dtm[_PPN.20 Effective Date_]
link:#a.2.65.4-money-or-percentage-mop[_Money or Percentage_]
link:#a.2.67-rpt-repeat-pattern[_RPT - Repeat pattern_]
link:#CWE_UsageNote[Usage Note]
```

These reference anchors from the original Word chapter numbering system (e.g., `2A.2.56.20`). Whether they work depends on whether corresponding `[id=...]` anchors exist. No `[[...]]` or `[id=...]` anchor definitions were found in the AsciiDoc files, so these are **likely broken**.

#### 1.2d Segment name anchors in tables

```
link:#QAK[QAK]
link:#QPD[QPD]
link:#DSP[DSP]
link:#RDF[RDF]
link:#RDT[RDT]
link:#HL70186[0186]
link:#HL70296[0296]
```

These appear in message structure tables, referencing segment definitions or HL7 tables. They are **broken** — no matching anchors exist in the current AsciiDoc structure.

#### 1.2e Miscellaneous broken patterns

```
link:\l[_Merge_]           # Backslash-l — clearly broken Word artifact
link:++#a.2.30-fn---family-name++[_FN - Family Name_]  # AsciiDoc passthrough escaping
```

---

### 1.3 `file:///` References (Word Document Links)

- **Occurrences:** 159
- **Files:** 142
- **Status:** BROKEN — legacy Word cross-document links

These are the most prevalent broken pattern. They reference the original Word documents on a local Windows filesystem:

```
file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 - Coding System]
file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70350[_HL7-defined Table 0350 - Occurrence Code_]
file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70299[_HL7 Table 0299 - Encoding_]
```

**Pattern:** All 159 references follow the same structure:
- Target: `V29_CH02C_Tables.docx` (the Code Tables chapter)
- Fragment: `#HL7XXXX` where XXXX is a table number (e.g., `#HL70396`, `#HL70064`)
- Display text: The table name

**Location:** Almost exclusively in `data_structures/data_types/complex/` component files (142 files).

**Note:** The team lead mentioned that `file:///` references in FHIR JSON files have already been replaced with `{{v2-table:XXXX:Name}}` placeholders. However, the `file:///` references in AsciiDoc files have **NOT** been replaced yet. These are candidates for a similar placeholder or direct link replacement.

---

### 1.4 Bare Windows Paths (without `file:///`)

- **Occurrences:** 7
- **Files:** 7
- **Status:** BROKEN

These are a variant of the `file:///` pattern where the URI scheme was stripped during conversion but the Windows path remains:

```
E:\\V2\\v2.9 final Nov from Frank\\V29_CH02C_Tables.docx#HL70396[HL7 Table 0396 - Coding System]
E:\\V2\\v2.9 final Nov from Frank\\V29_CH02C_Tables.docx#HL70203[_HL7 Table 0203 - Identifier Type_]
```

Same target (Code Tables chapter), same structure, just missing the `file:///` prefix. Located in `data_structures/data_types/complex/` component files.

---

### 1.5 Raw HTTP/HTTPS URLs

- **Occurrences:** 11
- **Files:** 11
- **Status:** MOSTLY WORKING (but some are stale)

These are genuine external URLs:

| URL | Context |
|-----|---------|
| `http://aurora.rg.iupui.edu/UCUM` | UCUM units reference (3 occurrences) |
| `https://ucum.org/` | Updated UCUM reference |
| `http://loinc.org/` | LOINC database |
| `https://search.loinc.org` | LOINC browser |
| `http://medical.nema.org/` | DICOM standard |
| `http://www.wordiq.com/definition/...` | Telecom definitions (2 occurrences) |
| `http://ietf.org/rfc/rfc2046.txt` | RFC reference |
| `http://www.iana.org/numbers.html` | IANA numbers |
| `https://www.pacs.poupon.edu/wado.jsp...` | Example WADO URL in RP data type |

**Notes:**
- The `aurora.rg.iupui.edu/UCUM` URLs are outdated; UCUM has moved to `ucum.org`
- The `wordiq.com` URLs may be stale
- The PACS URL appears to be an example, not a real link
- Some URLs have trailing punctuation absorbed into the link text

---

### 1.6 `<<...>>` References (AsciiDoc Inline Anchors)

- **Occurrences:** ~8 (in content, not as actual xrefs)
- **Status:** NOT CROSS-REFERENCES

The `<<` pattern appears only in:
- ER7 message examples: `ENTER*ELLEN<<cr>` (carriage return notation)
- DSP segment data: `<< END OF REPORT >>`, `<< END OF Screen>>`

None of these are actual AsciiDoc cross-references. No `<<anchor>>` style xrefs were found.

---

### 1.7 Escaped References (`\<<`)

- **Occurrences:** 0
- **Status:** N/A — no escaped references found

---

### 1.8 Anchor Definitions

- **`[[...]]` anchors:** 0
- **`[id=...]` anchors:** 0
- **`[#...]` anchors:** 1

Almost no explicit anchor definitions exist. The only anchors available for `link:#` targets are auto-generated section heading IDs. This is a significant gap — many `link:#` references point to anchors that simply do not exist.

---

## 2. V2 Construct References in Prose (Unlinkable)

These are mentions of V2 data structures in running text that are not currently hyperlinked but could/should be.

### 2.1 Segment References (e.g., PID, OBX, MSH)

- **Estimated occurrences:** ~1,471 (across common segment names)
- **Prevalence:** Very high — virtually every chapter and component file references segments

**Examples:**
```
"The patient ID and visit data are repeated..."  (mentions PID, PV1)
"An A17 is used when..."  (references trigger events)
"_PV1-45 - Discharge Date/Time_ can be used..."
```

Most segment mentions are in prose descriptions, field definitions, and implementation notes. Many already use italic formatting (`_PID-21 - Mother's Identifier_`) suggesting they were meant to be cross-referenced in the original Word document.

### 2.2 Field References (e.g., PID-3, OBX-5)

- **Estimated occurrences:** ~758
- **Prevalence:** High — used extensively in field definitions and implementation notes

**Examples:**
```
_PV1-19 - Visit Number_
_MRG-5 - Prior Visit Number_
IN3-5
PRA-3: Practitioner Category
```

### 2.3 Data Type References (e.g., CWE, ST, XPN)

- **Estimated occurrences:** ~1,675 (across common data type abbreviations)
- **Prevalence:** Very high — data type names appear in almost every component definition

Note: Many of these occurrences are in table headers, code blocks, or structural contexts where linking would not be appropriate. A conservative estimate for "linkable prose mentions" would be 30-50% of the total.

### 2.4 Message Type References (e.g., ADT^A01)

- **Estimated occurrences:** ~343
- **Prevalence:** Moderate — concentrated in domain chapters

**Examples:**
```
EHC^E13 - Additional Information Response
EHC^E12 Request for Additional Information
```

### 2.5 Table References (e.g., "Table 0127", "HL7 Table 0127")

- **Estimated occurrences:** ~146 (text pattern `Table 0XXX`)
- **Of which HL7 Table:** ~144
- **Prevalence:** Moderate — mainly in field definitions

**Examples:**
```
HL7 Table 0396 - Coding System
User-defined Table 0064 - Financial Class
HL7-defined Table 0350 - Occurrence Code
```

**Important:** Many table references are currently embedded inside the broken `file:///` links (159 occurrences). There are also ~146 standalone text mentions of tables that are not linked at all.

---

## 3. Broken/Legacy Reference Patterns

### 3.1 `file:///` Word Document Links — 159 occurrences in 142 files

The dominant broken pattern. See section 1.3 above for details.

### 3.2 Bare Windows Paths — 7 occurrences in 7 files

See section 1.4 above.

### 3.3 FIXME Comments — 28 occurrences in 20 files

These are editorial notes left during conversion:

```asciidoc
FIXME                                           // Placeholder, no detail
// FIXME merging three introductions into one requires some editing
// FIXME resize image.  Address Figure captioning issues
// FIXME the original text had "definition: " here
// FIXME this is going to need some manual help...
// FIXME <cr> added to line above because it was missing
```

**Categories:**
- Bare `FIXME` with no context (3 occurrences — in domains.adoc, clinical.adoc, financial.adoc, imaging.adoc)
- Content editing needed (editorial merges, text corrections)
- Structural issues (image sizing, figure captioning)
- Manual intervention needed for complex formatting

### 3.4 Word Bookmark Anchors in `link:#` — 13 occurrences

See section 1.2b above. Patterns like `_Hlt489245616`, `_MFI-3___File-Level Event Code   (ID` are Word internal bookmark names that have no AsciiDoc equivalent.

### 3.5 `link:\l` — 1 occurrence

In `A41.adoc`:
```
"link:\l[_Merge_]"
```
This is a Word field code artifact (`\l` = "bookmark" switch in Word's HYPERLINK field).

### 3.6 Orphaned Anchors

No explicit `[[...]]` or `[id=...]` anchors were found in any AsciiDoc file. This means:
- The ~30 working `link:#` references rely entirely on auto-generated section heading IDs
- If any section heading text changes, those links will silently break
- There is no anchor infrastructure to support a robust cross-reference system

---

## 4. `{{v2-table:XXXX:Name}}` Placeholders

- **Files containing placeholders:** 211 JSON files
- **Total placeholder occurrences:** 1,070
- **Location:** `/workspace/input/sourceOfTruth/segment/segments/*.json` (and possibly other segment JSON)

**Examples:**
```
{{v2-table:0004:Patient Class}}
{{v2-table:0007:Admission Type}}
{{v2-table:0010:Physician ID}}
{{v2-table:0069:Hospital Service}}
{{v2-table:0087:Pre-Admit Test Indicator}}
{{v2-table:0092:Re-Admission Indicator}}
{{v2-table:0023:Admit Source}}
{{v2-table:0009:Ambulatory Status}}
{{v2-table:0099:VIP Indicator}}
```

These placeholders are well-structured and consistent. They exist in JSON field `definition` values and follow the pattern `{{v2-table:NNNN:Human Readable Name}}`.

**Note:** The 159 `file:///` references in AsciiDoc files reference the SAME tables (e.g., `#HL70396` -> table 0396) but have NOT been converted to placeholders yet.

---

## 5. Summary and Recommendations

### Pattern Inventory

| Pattern | Count | Files | Status |
|---------|-------|-------|--------|
| `xref:file.adoc[text]` | 366 | 33 | Working |
| `link:#anchor[text]` (working) | ~30 | ~15 | Working (fragile) |
| `link:#anchor[text]` (broken) | ~13 | ~7 | Broken |
| `file:///` Word links | 159 | 142 | Broken |
| Bare Windows paths | 7 | 7 | Broken |
| Raw HTTP/HTTPS URLs | 11 | 11 | Mostly working |
| `link:\l` | 1 | 1 | Broken |
| `link:++#...++` | 1 | 1 | Questionable |
| FIXME markers | 28 | 20 | Editorial |
| `{{v2-table:}}` (in JSON) | 1,070 | 211 | Placeholder |

### Unlinkable V2 Construct Mentions

| Construct Type | Estimated Count | Linkable Subset |
|----------------|-----------------|-----------------|
| Segment names (PID, OBX...) | ~1,471 | ~500-700 (prose only) |
| Field refs (PID-3, OBX-5...) | ~758 | ~400-500 |
| Data type names (CWE, ST...) | ~1,675 | ~500-800 (prose only) |
| Message types (ADT^A01...) | ~343 | ~200-300 |
| Table references (Table 0XXX) | ~146 | ~146 |

### Recommendations for Strip-and-Relink Strategy

1. **Priority 1: Replace `file:///` and bare Windows paths (166 occurrences)**
   - These are completely broken and reference Word documents that no longer exist
   - All 166 point to `V29_CH02C_Tables.docx` with `#HL7XXXX` fragment identifiers
   - Convert to `{{v2-table:XXXX:Name}}` placeholders (matching the JSON pattern) or direct links to the table pages
   - This is a straightforward regex replacement

2. **Priority 2: Fix broken `link:#` anchors (~13 occurrences)**
   - Replace Word bookmark anchors (`_Hlt...`, `_MFI-3___...`) with correct AsciiDoc section ID references or xref: links to the appropriate file
   - Fix the `link:\l` artifact
   - Small count, requires manual mapping to correct targets

3. **Priority 3: Stabilize working `link:#` anchors (~30 occurrences)**
   - Add explicit `[id=...]` anchors to the referenced section headings to prevent breakage if headings change
   - Consider converting these to `xref:` cross-references where the target is in a different rendered page

4. **Priority 4: Auto-link V2 construct mentions (thousands of occurrences)**
   - This is the largest opportunity but also the most complex
   - Consider an Asciidoctor extension or build-time processor that detects patterns like `PID-3`, `CWE`, `ADT^A01`, `Table 0127` in prose and wraps them in appropriate links
   - Be careful to exclude mentions inside code blocks, ER7 examples, and table structure definitions
   - Field references already formatted as `_PID-21 - Mother's Identifier_` are the best candidates since the italic formatting signals intent to cross-reference

5. **Priority 5: Review external URLs (11 occurrences)**
   - Update stale URLs (aurora.rg.iupui.edu -> ucum.org)
   - Verify all external links still resolve
   - Low count, low effort

6. **Leave `xref:` references alone**
   - The 366 existing `xref:` references are working correctly and form the navigation structure
   - No changes needed unless the file organization changes
