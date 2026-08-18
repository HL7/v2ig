# Chapter 2C vocabulary — change log

Every deliberate change made to the published text of HL7 V2.9.1 Chapter 2C on
its way into FHIR resources, in the order the changes were decided.

Chapter 2C as published is the source, and fidelity is the governing
requirement: the extraction emits what the document says. A change is made only
when a reviewer decides it cannot alter meaning, and every change lands here
with its rule, its scope, and where it took effect.

**Related files**

| File | What it holds |
|---|---|
| `docs/adr/0008-v291-vocabulary-representation.md` | The decisions and the reasoning behind them |
| `v291-extracted/vocabulary-review-report.html` | The browsable review catalog — what was changed, what is still outstanding |
| `v291-extracted/vocabulary-deviations.json` | Machine-readable: every changed value, before and after, and every irregularity left alone |
| `tooling/scripts/vocabulary_text_policy.py` | The rules themselves, in code |

The counts below are reproducible by re-running
`python3 tooling/scripts/extract_v291_vocabulary.py`.

---

## 001 — Collapse two or more spaces following a period, in descriptive text

**Decided** 2026-08-18 · **ADR-0008 D3** · **Applied** in the extraction of
2026-08-18

### The rule

In a descriptive field, a run of two or more ordinary space characters
immediately following a period becomes a single space.

```
"...the military status of the patient.  This field is defined by CMS..."
                                      ^^
"...the military status of the patient. This field is defined by CMS..."
                                      ^
```

Only the ordinary space character counts. A tab, a newline or a non-breaking
space after a period is a different irregularity and is reported, not changed.
The rule is implemented once, in `vocabulary_text_policy.py`, so the extractor
and the cross-pipeline comparison cannot drift apart.

### Scope

Applied to the fields that carry descriptive prose, where the spacing after a
sentence is presentation rather than data:

| In scope | Where it appears |
|---|---|
| `Description` | Concept Domain, Code System, Value Set and Table Metadata blocks |
| `definition` | Coded Content |
| `comment` | Coded Content |
| `displayName` | Coded Content |

Deliberately **not** in scope, because a period there may be part of the
published value rather than sentence punctuation:

`value` (a code), `SymbolicName`, `Full Name`, `URI`, `URL`, `OID`, `status`,
`Content Logical Definition` (a value set expression), `where used` (a list of
segment references), and every other identifier or metadata field.

### Where it happened

890 values changed, across 537 of the 799 tables. 1,089 separate runs of spaces
were collapsed — more than one per value, because many descriptions space every
sentence this way.

| Field | Values changed | Space runs collapsed | Tables affected |
|---|---:|---:|---:|
| `codeSystem.Description` | 372 | 432 | 372 |
| `tableMetadata.Description` | 216 | 264 | 215 |
| `conceptDomain.Description` | 130 | 160 | 130 |
| `codedContent.comment` | 82 | 120 | 27 |
| `valueSet.Description` | 56 | 64 | 56 |
| `codedContent.displayName` | 18 | 24 | 8 |
| `codedContent.definition` | 16 | 25 | 9 |
| **Total** | **890** | **1,089** | **537 distinct** |

The full before-and-after text of all 890 values is in
`vocabulary-deviations.json` under kind `double_space_after_period`, and is
displayed with visible whitespace marks in the review report under
**Text changed: double space after period**. The tables touched by each field
are listed in the appendix below.

### Examples

| Table | Field | As published | As emitted |
|---|---|---|---|
| 0145 | `codeSystem.Description` | `...specify the room type.··Used in HL7 Version 2.x...` | `...specify the room type. Used in HL7 Version 2.x...` |
| 0085 | `codedContent.displayName` | `Partial results.···Deprecated. Retained only for...` | `Partial results. Deprecated. Retained only for...` |
| 0213 | `codedContent.displayName` | `Marked for purge.··User is no longer able to update the visit.` | `Marked for purge. User is no longer able to update the visit.` |
| 0161 | `codedContent.displayName` | `Substitutions are NOT authorized.··(This is the default - null.)` | `Substitutions are NOT authorized. (This is the default - null.)` |

### Effect on downstream artifacts

- **`v291-fhir/CodeSystem-conceptdomains.json`** — one concept definition
  changed (`JobSupervisoryLevelOrPayGrade`). The other 129 changed concept
  domain descriptions had no effect on the resource, because under ADR-0008 D1
  THO's definitions win for the 582 domains THO already publishes; only the 177
  Chapter 2C additions take their definition from Chapter 2C.
- **Cross-pipeline comparison** — unchanged at **739 / 799 tables identical**,
  and every other bucket is unchanged (211 typography, 45 whitespace, 14 LLM
  truncations, 2 content). The comparison now puts both corpuses through the
  same policy before comparing, because the python-docx corpus has the rule
  baked in and the LLM corpus does not; comparing raw would have reported our
  own normalization as a pipeline disagreement. **851 values** were equal only
  after the policy was applied, and that number is stated in the comparison
  report rather than dropped.

### What this rule deliberately does not do

It collapses spaces only where a period sits immediately before them, so a
sentence ending in a closing quote or bracket was missed. Change 002 covers
those.

---

## 002 — Collapse spaces where a sentence ends in a closing quote or bracket

**Decided** 2026-08-18 · **ADR-0008 D4** · Extends change 001

Where a closing quote or bracket sits between the sentence's final period and
the spaces, change 001's rule did not fire. The same collapse now applies after
`."`, `.'`, `.’`, `.”`, `.)` and `.]`.

6 values, 6 places, in tables 0085, 0340, 0489, 0513, 0717 and 0871.

| Table | Field | As published |
|---|---|---|
| 0340 | `codedContent.comment` | `…divided into three "levels."··Level I includes…` |
| 0513 | `codeSystem.Description` | `…has actually been "transfused."··Used in the Blood Product…` |
| 0717 | `codedContent.definition` | `…is termed a "consent."··The Privacy Rule permits…` |
| 0085 | `codedContent.displayName` | `…already sent as 'preliminary.'··E.g., radiology changes…` |
| 0489, 0871 | `codedContent.comment` | `…solid and sharp (e.g., cannulas.)··Dispose in hard container.` |

The two bracket cases are genuine sentence boundaries — the period closes the
parenthetical abbreviation and the next sentence begins — which is why `)` and
`]` are included alongside the quote marks rather than only the quotes.

---

## 003 — Collapse every repeated space in a code display name

**Decided** 2026-08-18 · **ADR-0008 D4**

In `codedContent.displayName` only, every run of two or more spaces is
collapsed to one, wherever it sits — not only after a period or a comma.

**66 values across 12 tables**: 0003, 0190, 0203, 0207, 0256, 0325, 0359,
0371, 0396, 0443, 0487, 0912.

The count is 66 rather than 74 because the period, sentence-close and comma
rules run first and had already resolved 8 of them; each change is attributed
to the most specific decision that authorized it.

**Why display names and not descriptions.** A display name is a short label,
not prose, so no run of repeated spaces in one can be meaningful. The same
cannot be said of a multi-sentence description, where a double space between
two words might be carrying something a reviewer should see. Table 0003 alone
accounts for most of these — the `ADT/ACK -··Register a patient` family.

**Effect:** `codedContent.displayName` no longer appears in the outstanding
double-space tracking at all.

---

## 004 — Collapse two or more spaces following a comma

**Decided** 2026-08-18 · **ADR-0008 D4**

10 values, 10 places, across 6 tables: 0074, 0203, 0487, 0550, 0717, 0935.

| Table | Field | As published | As emitted |
|---|---|---|---|
| 0074 | `codedContent.displayName` | `Electrocardiac (e.g., EKG,··EEC, Holter)` | `…EKG, EEC, Holter)` |
| 0550 | `codedContent.displayName` | `Blood,··Arterial` | `Blood, Arterial` |
| 0717 | `codedContent.comment` | `…where collection,··access, use, and disclosure…` | `…collection, access, use…` |

---

## 005 — Give a separator dash one space on each side

**Decided** 2026-08-18 · **ADR-0008 D5**

**16 values, 18 places, across 8 tables**: 0003, 0076, 0354, 0376, 0396, 0440,
0496, 0937.

The rule **adjusts** spacing around a dash; it never **inserts** space around a
dash that has none. That single constraint is what makes it safe, because
1,843 of the 2,516 dashes in Chapter 2C prose have no space on either side and
every one of them is part of a value rather than punctuation.

| Table | As published | As emitted |
|---|---|---|
| 0003 | `RSP -Dispense History Response` | `RSP - Dispense History Response` |
| 0003 | `OMQ- General Order Message` | `OMQ - General Order Message` |
| 0076 | `4 -Deprecated` | `4 - Deprecated` |
| 0354 | `Acknowledgment Message··– Multiple Order` | `Acknowledgment Message – Multiple Order` |
| 0376 | `Critical refrigerated -··must not be allowed to freeze` | `Critical refrigerated - must not…` |
| 0396 | `SNOMED- DICOM Microglossary` | `SNOMED - DICOM Microglossary` |
| 0440 | `8.8.4.6.1- OM2-6.1` | `8.8.4.6.1 - OM2-6.1` |
| 0496 | `Sterilization -Federally Funded` | `Sterilization - Federally Funded` |

The dash characters themselves are untouched: an en dash stays an en dash, and
the four values reading `Results entered -- not verified` keep both hyphens.
Only the surrounding spaces change.

### What the rule refuses to touch, and why

Each exclusion is structural rather than a list of table numbers, so it keeps
working if the source changes.

| Excluded | Count | Example | Why |
|---|---:|---|---|
| A dash with no space on either side | 1,843 | `HL7-defined`, `ICD-10`, `UB-04`, `de-identified`, `OBR-32`, `www.gpo.gov/…/CFR-2017-title45-vol1/…` | Part of a word, an identifier or a URL. Spacing it out destroys the value |
| A dash followed by a digit | 8 | `Deep frozen: -16 to -20( C.` | A minus sign, not a separator |
| A dash preceded by `+` or `/` | 1 | `approximately 22 +/- 2 degrees C` | The dash of `+/-` |
| A dash followed by a conjunction | 15 | `OPS Operationen- und Prozedurenschlussel` | A suspended hyphen — German here, `pre- and post-operative` in English |
| A dash at the start or end of a line | 7 | `Share To Be Determined -⏎Category to be determined` | A bullet marker, or a dash left dangling before a line break |
| A dash followed by punctuation | 1 | `Default -.will be assumed` | A defect the rule cannot repair |
| `X -y` where the follower is lowercase | 2 | `Message is not -conformant`, `Emergency -stop` | Every genuine separator in Chapter 2C introduces a capital or a digit, so a lowercase follower means the hyphen belongs to that word |

The last two rows are published defects that survive into the output unchanged.
They are listed in the outstanding section below rather than silently repaired.

---

## 006 — Insert the missing comma after "e.g." and "i.e."

**Decided** 2026-08-18 · **ADR-0008 D6**

**60 values, 62 places, across 27 tables.** This is the first rule that adds a
character to the published text rather than adjusting whitespace, so it is
deliberately narrow: it fires only where the abbreviation is followed by a
space.

| | Count |
|---|---:|
| `e.g.` corrected | 37 |
| `E.g.` corrected (sentence-initial) | 12 |
| `i.e.` corrected | 12 |
| `I.e.` corrected | 1 |
| Already correct, untouched | 172 |

The capitalised forms are the same defect at the start of a sentence
(`…regarding immunization. E.g. From school, provider…`), and the replacement
keeps whichever case was published.

**Five sites are deliberately skipped** where a colon introduces a bullet list
— tables 0965, 0966, 0967, 0968 and 0969 all read `e.g.:⏎•\tTier 1`. A comma
there would produce `e.g.,:`.

### Effect on the concept domains comparison

Inserting a comma on our side made 6 concept domains differ from THO by nothing
but that comma, which briefly inflated `definition_differs_from_tho` from 5 to
11. `generate_concept_domains.py` now applies the shared policy to THO's text
too before comparing — the same both-sides principle the cross-pipeline
comparison uses. The count is back to 5 genuine differences, and
`CodeSystem-conceptdomains.json` is byte-identical to before these changes.

---

## Cumulative effect

| Rule | Change | Values | Places |
|---|---|---:|---:|
| Leading/trailing whitespace | D2 | 44 | 44 |
| Spaces after a period | 001 / D3 | 890 | 1,089 |
| Spaces after a sentence close | 002 / D4 | 6 | 6 |
| Repeated spaces in a display name | 003 / D4 | 66 | 66 |
| Spaces after a comma | 004 / D4 | 10 | 10 |
| Dash spacing | 005 / D5 | 16 | 18 |
| Comma after `e.g.` / `i.e.` | 006 / D6 | 60 | 62 |
| **Total** | | **1,092** | **1,295** |

Cross-pipeline agreement is **unchanged at 739 / 799 tables** through all six
changes, with every other bucket also unchanged (211 typography, 45 whitespace,
14 LLM truncations, 2 content). 982 values are now equal only after the shared
policy is applied to both corpuses; that figure is stated in the comparison
report rather than dropped.

---

## Still outstanding

Irregularities in the published text that no decision covers yet. These are
preserved exactly as published and reported. They appear in the review report
under **Text outstanding: …**.

### Runs of two or more spaces

Down from 1,052 values to **143 values** (155 separate runs). By field:

| Field | Values |
|---|---:|
| `codedContent.comment` | 45 |
| `codeSystem.Description` | 38 |
| `tableMetadata.Description` | 18 |
| `codedContent.definition` | 16 |
| `conceptDomain.Description` | 13 |
| `valueSet.Description` | 11 |
| `tableMetadata.where used` | 1 |
| `valueSet.Content Logical Definition` | 1 |
| **Total** | **143** |

`codedContent.displayName` is absent: change 003 cleared it completely.

Grouped by what precedes the run, which is what a decision would turn on:

| Context | Runs | Values | Example |
|---|---:|---:|---|
| Between two words, mid-sentence | 129 | 94 | `code system of concepts··which specify the room type` |
| After punctuation other than a period | 22 | 15 | `Usage Note: Class:··Insurance` |
| At the start of a line inside a multi-line cell | 4 | 1 | `Examples:⏎···NCPDP1131RES = code set…` |

The mid-sentence group is still dominated by one boilerplate defect: the phrase
`code system of concepts··which specify` recurs across Code System
descriptions. That is one template that shipped with a double space in it,
not 38 independent typos, so it is one decision.

### Dashes the rule refused to repair

Three published values where the rule fired nowhere and the text stays as
printed:

| Table | Field | As published | Probable intent |
|---|---|---|---|
| 0357 | `codedContent.definition` | `Message is not -conformant with the applicable specification` | `non-conformant`, or the hyphen is stray |
| 0368 | `codedContent.displayName` | `Emergency -stop` | `Emergency stop` or `Emergency-stop` |
| 0919 | `codedContent.comment` | `Default -.will be assumed when this field is empty` | Two defects at once — a stray hyphen and a missing space |

### Missing space after a comma

Not asked for and not changed, but surfaced while applying change 004: **10
places** where a comma has no space after it at all.

| Table | Field | As published |
|---|---|---|
| 0074 | `codedContent.displayName` | `Electroneuro (EEG, EMG,EP,PSG)` |
| 0354 | `codedContent.displayName` | `Q21, Q22, Q23,Q24, Q25` |
| 0367 | all four `Description` fields | `(e.g.,highest alert severity)` |
| 0396 | `codedContent.comment` | `From school, provider,public health agency.` |

### Other kinds, unchanged

| Kind | Values | Status |
|---|---:|---|
| Embedded newline | 223 | Preserved. Usually genuine paragraph structure inside a cell |
| Non-breaking space | 8 | Preserved except where leading or trailing. The four inside `codeSystem.URL` values are the ones that matter |

---

## Appendix — tables affected by change 001, by field

Each list is every table in which that field was changed.

<details><summary><code>codeSystem.Description</code> — 372 tables, 372 values</summary>

0002, 0003, 0006, 0007, 0008, 0009, 0017, 0027, 0038, 0052, 0061, 0062, 0063, 0065, 0069, 0074, 0076, 0078, 0080, 0083, 0085, 0091, 0092, 0098, 0100, 0103, 0104, 0105, 0116, 0119, 0121, 0122, 0123, 0124, 0125, 0126, 0127, 0128, 0130, 0135, 0136, 0137, 0140, 0142, 0144, 0145, 0146, 0147, 0148, 0149, 0150, 0159, 0160, 0161, 0162, 0163, 0164, 0165, 0166, 0167, 0168, 0169, 0170, 0173, 0174, 0175, 0177, 0178, 0179, 0181, 0183, 0185, 0187, 0189, 0190, 0191, 0193, 0200, 0201, 0202, 0204, 0205, 0206, 0207, 0208, 0209, 0210, 0211, 0213, 0214, 0215, 0216, 0217, 0220, 0223, 0224, 0225, 0228, 0230, 0231, 0232, 0234, 0235, 0236, 0237, 0238, 0239, 0240, 0241, 0242, 0243, 0247, 0248, 0250, 0251, 0252, 0253, 0254, 0255, 0256, 0257, 0258, 0260, 0261, 0262, 0263, 0265, 0267, 0268, 0269, 0270, 0271, 0272, 0273, 0275, 0276, 0277, 0278, 0279, 0280, 0281, 0282, 0283, 0284, 0286, 0287, 0291, 0294, 0298, 0299, 0301, 0305, 0309, 0311, 0315, 0316, 0317, 0321, 0322, 0324, 0325, 0326, 0329, 0330, 0331, 0332, 0334, 0335, 0336, 0337, 0339, 0344, 0353, 0354, 0355, 0356, 0357, 0359, 0360, 0364, 0365, 0366, 0367, 0368, 0369, 0370, 0371, 0372, 0373, 0374, 0375, 0376, 0377, 0383, 0384, 0387, 0388, 0389, 0391, 0392, 0393, 0394, 0395, 0396, 0397, 0398, 0401, 0402, 0404, 0406, 0409, 0411, 0415, 0416, 0418, 0421, 0423, 0424, 0425, 0426, 0427, 0428, 0429, 0430, 0431, 0432, 0433, 0434, 0435, 0436, 0437, 0438, 0440, 0441, 0442, 0443, 0444, 0445, 0450, 0457, 0458, 0459, 0460, 0465, 0466, 0467, 0468, 0469, 0470, 0472, 0473, 0474, 0475, 0477, 0478, 0480, 0482, 0483, 0484, 0485, 0487, 0488, 0489, 0490, 0491, 0492, 0493, 0494, 0495, 0496, 0497, 0498, 0499, 0500, 0501, 0502, 0503, 0504, 0505, 0506, 0507, 0508, 0510, 0511, 0513, 0514, 0516, 0517, 0518, 0520, 0523, 0527, 0528, 0530, 0532, 0534, 0535, 0536, 0538, 0540, 0544, 0547, 0548, 0550, 0553, 0554, 0555, 0556, 0557, 0558, 0559, 0561, 0562, 0564, 0565, 0566, 0569, 0570, 0571, 0572, 0615, 0616, 0617, 0702, 0717, 0719, 0728, 0731, 0734, 0742, 0749, 0755, 0757, 0761, 0778, 0793, 0806, 0818, 0834, 0868, 0871, 0881, 0882, 0894, 0895, 0904, 0905, 0906, 0907, 0909, 0912, 0914, 0917, 0918, 0919, 0920, 0921, 0922, 0923, 0924, 0925, 0926, 0927, 0933, 0935, 0937, 0938, 0939, 0940, 0945, 0946, 0950

</details>

<details><summary><code>tableMetadata.Description</code> — 215 tables, 216 values</summary>

0008, 0010, 0018, 0019, 0021, 0022, 0023, 0024, 0032, 0038, 0042, 0043, 0044, 0045, 0046, 0049, 0050, 0051, 0055, 0056, 0059, 0064, 0065, 0068, 0072, 0073, 0084, 0086, 0087, 0099, 0110, 0111, 0112, 0113, 0114, 0115, 0117, 0118, 0119, 0129, 0132, 0133, 0135, 0139, 0140, 0142, 0143, 0151, 0152, 0153, 0164, 0170, 0171, 0172, 0181, 0182, 0184, 0186, 0188, 0189, 0201, 0202, 0208, 0212, 0218, 0219, 0222, 0227, 0229, 0233, 0244, 0245, 0254, 0259, 0272, 0285, 0288, 0289, 0292, 0293, 0295, 0296, 0297, 0299, 0300, 0301, 0302, 0303, 0304, 0306, 0307, 0308, 0309, 0312, 0313, 0315, 0317, 0319, 0320, 0326, 0327, 0328, 0333, 0334, 0340, 0341, 0342, 0343, 0345, 0346, 0347, 0350, 0351, 0353, 0358, 0359, 0360, 0361, 0362, 0363, 0366, 0371, 0378, 0379, 0380, 0381, 0382, 0383, 0385, 0386, 0388, 0389, 0392, 0396, 0399, 0401, 0405, 0411, 0412, 0413, 0414, 0446, 0447, 0448, 0451, 0452, 0454, 0455, 0456, 0458, 0461, 0462, 0463, 0464, 0467, 0471, 0476, 0477, 0479, 0487, 0488, 0507, 0508, 0509, 0510, 0511, 0512, 0513, 0515, 0517, 0519, 0520, 0521, 0525, 0526, 0531, 0532, 0533, 0537, 0539, 0541, 0542, 0543, 0544, 0549, 0552, 0560, 0567, 0702, 0719, 0728, 0755, 0757, 0761, 0771, 0809, 0811, 0836, 0838, 0865, 0879, 0880, 0908, 0915, 0934, 0941, 0943, 0944, 0947, 0960, 0964, 0965, 0967, 0968, 0969

</details>

<details><summary><code>conceptDomain.Description</code> — 130 tables, 130 values</summary>

0008, 0018, 0019, 0022, 0023, 0032, 0038, 0042, 0065, 0068, 0110, 0111, 0112, 0113, 0114, 0115, 0117, 0118, 0119, 0129, 0132, 0135, 0139, 0140, 0142, 0143, 0151, 0152, 0153, 0164, 0170, 0171, 0172, 0181, 0182, 0184, 0186, 0189, 0201, 0202, 0208, 0212, 0218, 0219, 0222, 0227, 0229, 0233, 0244, 0254, 0259, 0272, 0285, 0288, 0289, 0292, 0293, 0295, 0296, 0297, 0299, 0300, 0302, 0303, 0304, 0306, 0307, 0308, 0309, 0312, 0313, 0315, 0317, 0319, 0320, 0326, 0327, 0328, 0333, 0334, 0340, 0341, 0342, 0343, 0345, 0346, 0347, 0353, 0358, 0359, 0360, 0361, 0362, 0363, 0366, 0371, 0378, 0379, 0380, 0381, 0382, 0383, 0385, 0386, 0388, 0389, 0392, 0396, 0399, 0401, 0405, 0411, 0412, 0413, 0414, 0456, 0464, 0507, 0508, 0510, 0511, 0512, 0513, 0520, 0532, 0543, 0544, 0702, 0811, 0956

</details>

<details><summary><code>codedContent.comment</code> — 27 tables, 82 values</summary>

0123, 0174, 0190, 0200, 0203, 0211, 0287, 0301, 0340, 0369, 0396, 0440, 0472, 0480, 0489, 0506, 0553, 0555, 0557, 0571, 0617, 0642, 0717, 0871, 0912, 0919, 0920

</details>

<details><summary><code>valueSet.Description</code> — 56 tables, 56 values</summary>

0008, 0038, 0063, 0065, 0078, 0119, 0123, 0131, 0135, 0140, 0142, 0164, 0170, 0178, 0179, 0180, 0189, 0227, 0254, 0272, 0287, 0315, 0317, 0326, 0334, 0339, 0347, 0353, 0359, 0360, 0366, 0371, 0376, 0383, 0388, 0389, 0392, 0399, 0401, 0411, 0441, 0483, 0485, 0487, 0488, 0490, 0493, 0508, 0510, 0511, 0513, 0520, 0532, 0544, 0702, 0717

</details>

<details><summary><code>codedContent.displayName</code> — 8 tables, 18 values</summary>

0085, 0161, 0167, 0179, 0213, 0396, 0906, 0907

</details>

<details><summary><code>codedContent.definition</code> — 9 tables, 16 values</summary>

0123, 0174, 0203, 0255, 0301, 0369, 0717, 0906, 0907

</details>
