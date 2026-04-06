# AsciiDoc Content to IG Output Mapping

This document maps every AsciiDoc content source in `website/` to its intended destination in the published FHIR Implementation Guide.

## Summary Statistics

| Content Category | File Count | Destination Type |
|---|---|---|
| Complex data type definitions | 72 | StructureDefinition injection |
| Data type component descriptions | 440 | StructureDefinition injection (element-level) |
| Technical spec / message definitions | 257 | Pagecontent (one page per message event) |
| Domain overview pages | 6 | Pagecontent (domain landing pages) |
| Subdomain overview pages | 21 | Pagecontent (subdomain pages) |
| Example transactions | 10 | Pagecontent or Include (within subdomain pages) |
| Implementation considerations | 1 | Include (within subdomain page) |
| Navigation files | 2 | Not published directly (editorial navigation) |
| data_structures.rb (Ruby DSL) | 1 | Build config / not published |
| **Total** | **~814** | |

---

## 1. Data Structures: `website/data_structures/`

### 1.1 Complex Data Type Files: `data_structures/data_types/complex/{CODE}.adoc`

**Count:** 72 files (one per complex data type: AD, AUI, CCD, ... XTN)

**Front matter attributes:**
- `:v291_section:` — V2.9.1 spec section number (e.g., `2A.2.25`)
- `:v2type: 'Data Type'` — marks this as a data type
- `:code:` — the data type code (e.g., `EI`)
- `:name:` — human-readable name (e.g., `entity identifier`)
- `:primitive: false` — always false for complex types
- `:generated:` — generation timestamp

**Content pattern:**
- Title line: `= (CODE) Data Type - name`
- `[datatype-definition]` block with the type's narrative definition
- `include::` directives pulling in component files

**Destination: StructureDefinition injection**
- The `[datatype-definition]` block text maps to the `StructureDefinition.description` or `StructureDefinition.definition` field for the corresponding data type resource (e.g., `StructureDefinition-EI.html`)
- The includes list references already link to `StructureDefinition-{CODE}.html` in `input/includes/complex-data-types-list.html`

### 1.2 Component Files: `data_structures/data_types/complex/{CODE}-components/{CODE}-{N}.adoc`

**Count:** 440 files

**Front matter:** None (these are include-only files)

**Content pattern:**
- Section header: `== CODE.N - Component Name (Data Type)`
- `[datatype-definition]` block with component-level description

**Destination: StructureDefinition injection (element-level)**
- Each component maps to a child element within the parent data type's StructureDefinition
- The `[datatype-definition]` text should populate the element's `definition` or `short` fields
- These files are included via the parent `{CODE}.adoc` file

### 1.3 Navigation File: `data_structures/data_types/complex/navigation.adoc`

**Content:** A listing of `xref:` links to all 71 complex data type `.adoc` files.

**Destination: Not published directly**
- Used for editorial navigation within the AsciiDoc source
- The IG equivalent is `input/includes/complex-data-types-list.html` which already exists and links to `StructureDefinition-{CODE}.html`

### 1.4 Ruby DSL: `data_structures/data_structures.rb`

**Content:** A page-structure DSL defining how content maps to IG pages.

**Destination: Build configuration**
- Not published; this is a planning/config artifact describing the intended page layout
- Defines pages like "V2+ Home", "Domains", "Message Structures", "Segments", "Data Types", etc.
- Shows the intended IG navigation structure

---

## 2. Domains: `website/domains/`

### 2.1 Top-Level Domain Index: `domains/domains.adoc`

**Content:** Title "Domains" with xref links to each domain category.

**Destination: Pagecontent**
- Maps to `domains.html` in the published IG
- Already referenced in `input/includes/menu.xml` as a top-level nav item

### 2.2 Domain Category Pages

| File | Domain | Content |
|---|---|---|
| `domains/administration/administration.adoc` | Administration | Links to Registration, Referral, Scheduling subdomains |
| `domains/clinical/clinical.adoc` | Clinical | Links to Blood Bank, Clinical Trials, Dietary, etc. |
| `domains/erp/erp.adoc` | ERP | Links to Lab Automation, Materials Management, etc. |
| `domains/financial/financial.adoc` | Financial | Links to Claims, Financial Management |
| `domains/technical/technical.adoc` | Technical | Links to Application Management, Master Files, Queries |

**Front matter:** None

**Content pattern:** Title, introduction (often `FIXME` placeholder), list of `xref:` links to subdomains.

**Destination: Pagecontent**
- Each becomes a standalone page in the IG (e.g., `administration.html`, `clinical.html`)

### 2.3 Subdomain Overview Pages

These are the main content pages for each healthcare domain:

| File | Subdomain | Notes |
|---|---|---|
| `administration/referral/referral.adoc` | Referral | xref list to technical specs |
| `administration/registration/registration.adoc` | Registration | Includes implementation_considerations.adoc; xref list to specs |
| `administration/scheduling/scheduling.adoc` | Scheduling | xref list to technical specs |
| `clinical/blood_bank/blood_bank.adoc` | Blood Bank | xref list to technical specs |
| `clinical/clinical_trials/clinical_trials.adoc` | Clinical Trials | xref list to technical specs |
| `clinical/dietary/dietary.adoc` | Dietary | xref list to technical specs |
| `clinical/general_orders_and_results/general_orders_and_results.adoc` | General Orders & Results | xref list to technical specs |
| `clinical/imaging/imaging.adoc` | Imaging | xref list to technical specs |
| `clinical/immunizations/immunizations.adoc` | Immunizations | xref list to technical specs |
| `clinical/laboratory/laboratory.adoc` | Laboratory | xref list to specs; inline example messages |
| `clinical/medical_records/document_management.adoc` | Document Management | xref list to technical specs |
| `clinical/patient_care/patient_care.adoc` | Patient Care | xref list to technical specs |
| `clinical/pharmacy/pharmacy.adoc` | Pharmacy | xref list to technical specs |
| `clinical/product_experience/product_experience.adoc` | Product Experience | xref list to technical specs |
| `clinical/supply/supply.adoc` | Supply | xref list to technical specs |
| `erp/lab_automation/lab_automation.adoc` | Lab Automation | xref list to technical specs |
| `erp/materials_management/materials_management.adoc` | Materials Management | xref list to technical specs |
| `erp/personnel_management/personnel_management.adoc` | Personnel Management | xref list to technical specs |
| `erp/specimen_shipment_manifest/specimen_shipment_manifest.adoc` | Specimen Shipment | xref list to technical specs |
| `financial/claims_and_reimbursements/claims_and_reimbursements.adoc` | Claims & Reimbursements | xref list to technical specs |
| `financial/financial_management/financial_management.adoc` | Financial Management | xref list to technical specs |
| `technical/application_management/application_management.adoc` | Application Management | xref list to technical specs |
| `technical/master_files/master_files.adoc` | Master Files | Contains `[segment_definition-table]` block |
| `technical/queries/queries.adoc` | Queries | xref list to specs; includes general_use_case_background.adoc |

**Front matter:** Inline `[v291_section="..."]` attributes on sections (not document-level).

**Destination: Pagecontent**
- Each subdomain overview becomes its own page in the IG

### 2.4 Technical Spec / Message Event Files: `domains/**/technical_specs/{EVENT}.adoc`

**Count:** 257 files across all domains

**Breakdown by domain:**
| Domain | Count |
|---|---|
| Administration (Registration, Referral, Scheduling) | 100 |
| Clinical (all subdomains) | 84 |
| ERP (all subdomains) | 26 |
| Financial (all subdomains) | 20 |
| Technical (all subdomains) | 27 |

**Front matter attributes:**
- `:v291_section:` — V2.9.1 spec section (e.g., `"3.3.1"`, `"4.4.6"`)
- `:v2_section_name:` — Full descriptive name (e.g., `"ADT/ACK - Admit/Visit Notification (Event A01)"`)
- `:generated:` — Generation timestamp

**Content pattern:**
- Title: `= Message - EVENT_NAME`
- Narrative description of the message/event
- `[tabset]` block with the event code — this generates a tabbed display of the message structure
- Some files include `[message-structure, "..."]` blocks for query/response patterns

**Destination: Pagecontent (one page per message event)**
- Each technical spec file should become a standalone IG page
- The `[tabset]` blocks require special rendering (they reference message structure definitions)
- These are the bulk of the domain content (~257 pages)

### 2.5 Example Transaction Files: `domains/administration/registration/example_transactions/`

**Count:** 10 AsciiDoc files

**Content pattern:**
- Title like `=== Admit/visit notification - event A01 (admitted patient)`
- `[v291_section="..."]` inline attribute
- `[.er7]` code blocks with HL7 ER7-encoded sample messages
- Narrative explanations of the example

**Destination: Pagecontent or Include**
- Currently included in `registration.adoc` via cross-references
- Could become standalone pages or remain as includes within subdomain pages
- **Ambiguity:** Only the Registration subdomain has example_transactions; unclear if other domains will add them

### 2.6 Supplementary Content Files

| File | Content | Destination |
|---|---|---|
| `administration/registration/implementation_considerations.adoc` | Swap patient scenarios, etc. | Include — pulled into `registration.adoc` via `include::` |
| `technical/queries/general_use_case_background.adoc` | Query use case background | Include or Pagecontent — referenced from `queries.adoc` |
| `technical/queries/examples.adoc` | Query examples | Include or Pagecontent — referenced from `queries.adoc` |

---

## 3. Other Files in `website/`

| File | Content | Destination |
|---|---|---|
| `v2plus-navigation.adoc` | Editorial navigation links to Data Types and Domains | Not published — editorial aid only |
| `v2plus-home.html` | HTML home page | Not used in IG build (IG uses `input/pagecontent/index.xml`) |
| `domains.html` | HTML domains page | Not used in IG build |
| `domains.b4tabsetStuff.zip` | Archive of pre-tabset content | Not published — archival only |
| `extracted-media/` | Images extracted from original docs | Pagecontent images — should map to `input/images/` |

---

## 4. Front Matter Attribute Catalog

### Document-Level Attributes (in header block)

| Attribute | Used In | Purpose | Example |
|---|---|---|---|
| `:v291_section:` | Data types, technical specs | V2.9.1 chapter/section reference | `2A.2.25`, `"3.3.1"` |
| `:v2_section_name:` | Technical specs | Full descriptive name of message/event | `"ADT/ACK - Admit/Visit..."` |
| `:v2type:` | Data types | Content type marker | `'Data Type'` |
| `:code:` | Data types | Data type code | `EI`, `CWE` |
| `:name:` | Data types | Human-readable name | `entity identifier` |
| `:primitive:` | Data types | Primitive vs complex flag | `false` |
| `:generated:` | Data types, technical specs | Auto-generation timestamp | `"Thu, 01 Aug 2024..."` |
| `:example-caption!:` | Some files | Disable example captions | (unset attribute) |
| `:sectnums:` | Some files | Enable section numbering | (set attribute) |
| `:leveloffset:` | Some files | Adjust heading levels for includes | `-1` |

### Inline Block Attributes

| Attribute | Used In | Count | Purpose |
|---|---|---|---|
| `[v291_section="..."]` | Domain content (sections) | 323 occurrences | Marks section with V2.9.1 reference |
| `[datatype-definition]` | Data type files | 469 files | Marks definition text for extraction |
| `[tabset]` or `[tabset, "..."]` | Technical specs | 256 files | Generates tabbed message structure display |
| `[message-structure, "..."]` | Query specs | 2 files | References a specific message structure |
| `[message-structures, "..."]` | Query specs | rare | Plural variant |
| `[segment_definition-table]` | Master files | 1 file | Generates segment definition table |
| `[event-definition]` | Technical specs | 1 file | Marks event definition text |
| `[.er7]` | Example transactions | multiple | Marks ER7-encoded message blocks |
| `[.er7-example]` | Some files | rare | Variant ER7 block styling |

---

## 5. Current IG Output State

### `input/pagecontent/` (3 files)
| File | Content | Status |
|---|---|---|
| `index.xml` | Placeholder IG home page | Boilerplate — needs real content |
| `data-types.xml` | Lists primitive and complex data types via includes | Working — links to StructureDefinitions |
| `xindex.md` | Test/placeholder page | Placeholder |

### `input/includes/` (3 files)
| File | Content | Status |
|---|---|---|
| `complex-data-types-list.html` | Links to 71 complex data type StructureDefinitions | Working |
| `primitive-data-types-list.html` | Links to 12 primitive data type StructureDefinitions | Working |
| `menu.xml` | IG navigation menu | Working — defines top-level nav items |

### IG Menu Structure (from `menu.xml`)
1. v2+ Home (`index.html`)
2. Domains (`domains.html`)
3. Message Structures (`message-structures.html`)
4. Segments (`segment-defintions.html`) — note typo in filename
5. Data Types (`data-types.html`)
6. Data Type Flavors (`data-type-flavors.html`)
7. Terminology (`terminology.html`)
8. Control (`control.html`)
9. Conformance (`conformance.html`)

---

## 6. Content Destination Summary

### StructureDefinition Injection (512 files)
- 72 complex data type definitions → `StructureDefinition.description` / `.definition`
- 440 component descriptions → child element `.definition` / `.short`
- These require an automated pipeline to extract `[datatype-definition]` blocks and inject them into FHIR StructureDefinition resources

### Pagecontent Pages (~290+ files)
- 1 domains index page
- 5 domain category pages
- ~24 subdomain overview pages
- ~257 technical spec / message event pages
- Each needs to be converted from AsciiDoc to HTML/Markdown and placed in `input/pagecontent/`

### Include Files (~3+ files)
- `implementation_considerations.adoc` — included from registration.adoc
- `general_use_case_background.adoc` — included from queries.adoc
- `examples.adoc` — included from queries.adoc
- These could be inlined or kept as separate includes in `input/includes/`

### Not Published (editorial/build artifacts)
- `v2plus-navigation.adoc`
- `data_structures/data_types/complex/navigation.adoc`
- `data_structures/data_structures.rb`
- `v2plus-home.html`, `domains.html` (superseded by IG pages)
- `domains.b4tabsetStuff.zip`

---

## 7. Gaps and Ambiguities

1. **No primitive data type AsciiDoc sources.** The `primitive-data-types-list.html` references 12 primitive types (DT, DTM, FT, GTS, ID, IS, NM, SI, SNM, ST, TM, TX) but there are no corresponding `.adoc` files in `website/data_structures/`. These definitions may exist elsewhere or need to be created.

2. **`[tabset]` rendering is undefined for IG.** 256 technical spec files use `[tabset]` blocks that generate tabbed message structure displays on the v2+ website. The IG publisher does not natively support tabsets; a conversion strategy is needed.

3. **`[datatype-definition]` extraction pipeline missing.** No tooling currently exists to extract the definition text from the AsciiDoc `[datatype-definition]` blocks and inject it into StructureDefinition resources.

4. **Example transactions only exist for Registration.** Only `administration/registration/example_transactions/` has example files (10 files). Other subdomains either lack examples or embed them inline (like `laboratory.adoc`).

5. **Several domain pages have `FIXME` placeholder content.** The `domains.adoc`, `clinical.adoc`, and presumably other category pages have `FIXME` text where introductions should be.

6. **Supply subdomain appears in both Clinical and ERP.** `clinical/supply/supply.adoc` and `erp/supply/` both exist (though `erp/supply/` appears to be an empty directory). This overlap needs resolution.

7. **`v291_section` values are inconsistently formatted.** Some are quoted strings (`"3.3.1"`), some are unquoted (`2A.2.25`), and inline versions use a different syntax (`[v291_section="3.5.1"]`). The conversion pipeline needs to handle all variants.

8. **Cross-references between domains and data types.** Domain technical specs reference data types by V2.9.1 section numbers (e.g., "Section _2A.2.33_"). These need to be converted to IG-internal links (`StructureDefinition-HD.html`).

9. **`extracted-media/` directory.** Contains images but needs to be audited for what content references them and mapped to `input/images/`.

10. **Menu items without content.** Several menu items in `menu.xml` reference pages that do not yet exist: `message-structures.html`, `segment-defintions.html`, `data-type-flavors.html`, `terminology.html`, `control.html`, `conformance.html`.
