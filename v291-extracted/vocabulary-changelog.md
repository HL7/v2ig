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

It collapses spaces only where a period sits immediately before them. It does
not attempt to detect sentence ends generally, and it does not touch any other
run of repeated spaces. What remains is tracked below.

---

## Still outstanding

Whitespace irregularities in the published text that no decision covers yet.
These are preserved exactly as published and reported. They appear in the
review report under **Text outstanding: …**.

### Runs of two or more spaces not covered by change 001

Down from 1,052 values before change 001 to **228 values** (242 separate runs)
across 92 tables. By field:

| Field | Values |
|---|---:|
| `codedContent.displayName` | 74 |
| `codedContent.comment` | 53 |
| `codeSystem.Description` | 39 |
| `codedContent.definition` | 18 |
| `tableMetadata.Description` | 18 |
| `conceptDomain.Description` | 13 |
| `valueSet.Description` | 11 |
| `tableMetadata.where used` | 1 |
| `valueSet.Content Logical Definition` | 1 |
| **Total** | **228** |

Grouped by what precedes the run, which is what a decision would turn on:

| Context | Runs | Values | Example |
|---|---:|---:|---|
| Between two words, mid-sentence | 161 | 106 | `code system of concepts··which specify the room type` |
| After punctuation other than a period | 41 | 28 | `Electrocardiac (e.g., EKG,··EEC, Holter)` |
| After a hyphen or dash used as a separator | 36 | 2 | `ADT/ACK -··Register a patient` |
| At the start of a line inside a multi-line cell | 4 | 1 | `Examples:⏎···NCPDP1131RES = code set…` |

Two of these are worth a reviewer's attention as candidate follow-up decisions:

- **The mid-sentence group is dominated by one boilerplate defect.** The
  phrase `code system of concepts··which specify` recurs across many Code
  System descriptions — a template that shipped with a double space in it,
  rather than 39 independent typos.
- **Six sentence ends were missed by change 001** because a closing quote or
  bracket sits between the period and the spaces: `.'··`, `."··`, `.)··`.
  Affects tables 0085, 0340, 0489, 0513, 0717 and 0871. Extending the rule to
  allow a closing quote or bracket after the period would cover them; that has
  not been decided.

### Other whitespace kinds, unchanged

| Kind | Values | Status |
|---|---:|---|
| Leading/trailing whitespace | 44 | **Changed** — stripped automatically under ADR-0008 D2, recorded for confirmation |
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
