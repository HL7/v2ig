# Chapter 2C extraction cross-validation — python-docx vs LLM

Both pipelines read `CH02C_Tables.docx`. Neither is the authority; 
agreement raises confidence, disagreement marks a value to check against 
the published document.

## Coverage

- Tables in both corpuses: **799**
- Tables only in python-docx: **0**
- Tables only in the LLM corpus: **0**

## Agreement

- Tables identical in every compared field: **740 / 799**
- Tables with at least one real content disagreement: **1**

### Disagreements by kind

| Kind | Count | Meaning |
|---|---:|---|
| `typography` | 210 | LLM substituted an ASCII look-alike; python-docx is character-faithful |
| `whitespace` | 45 | Differs only in spacing |
| `llm_truncated` | 14 | LLM cut the value short (usually at a literal double quote); python-docx has the full text |
| `missing_in_llm` | 1 | Key present in python-docx only |
| `block_count` | 1 | Different number of metadata blocks |
| `content` | 1 | Genuine disagreement — examine against the source .docx |
| `missing_in_pydocx` | 1 | Key present in the LLM corpus only |

### Absorbed by the shared text policy

A further **1043** values were textually different but identical once both sides were put through `vocabulary_text_policy.py`. These are not counted above, because they are our own deliberate normalization (spaces collapsed after a period in descriptive fields) showing up on only one side — the python-docx corpus has the policy applied, the LLM corpus does not. They are listed here so the number is visible rather than silently removed.

| Field | Values |
|---|---:|
| `codeSystems[0].Description` | 365 |
| `tableMetadata.Description` | 222 |
| `conceptDomain.Description` | 135 |
| `codedContent.comment` | 127 |
| `codedContent.displayName` | 103 |
| `valueSets[0].Description` | 62 |
| `codedContent.definition` | 27 |
| `tableMetadata.where used` | 1 |
| `valueSets[0].Content Logical Definition` | 1 |

## Findings needing adjudication (4)

Each row is a value the two pipelines read differently. Resolve by 
opening the section in `CH02C_Tables.docx`.

| Table | Location | Kind | python-docx | LLM |
|---|---|---|---|---|
| 0227 | `tableMetadata.Version Info` | missing_in_llm | `Versioning defined by external organization; see external source for details.` | _(absent)_ |
| 0227 | `codeSystems` | block_count | `0 blocks` | `1 blocks` |
| 0496 | `codedContent[27].definition` | content | `""      "" w/o Surgery Capability` | `"""	""" w/o Surgery Capability` |
| 0823 | `valueSets[0].` | missing_in_pydocx | _(absent)_ | _(empty)_ |

## Known LLM limitations

Both of these are defects of the LLM pipeline, not source ambiguities. 
The python-docx corpus is character-faithful and is the reference for both.

### Typographic substitution

210 values across 43 tables differ only 
because the LLM emitted ASCII look-alikes for curly quotes, dashes and 
non-breaking spaces. Repeated prompt instructions did not stop it.

### Truncation at a literal double quote

14 values were cut short by the LLM. In each case the LLM value is 
an exact prefix of the python-docx value, ending where the published text 
contains a `"` character — the quote closes the JSON string early during 
constrained decoding. It is intermittent rather than universal (most 
quote-bearing values came through intact), and it only ever loses text, 
never invents it.

| Table | Location | Lost text |
|---|---|---|
| 0254 | `conceptDomain.Description` | `s," those related to simple counts (number, number concentration, etc.), to mass (mass,...` |
| 0389 | `conceptDomain.Description` | `"Panic" or mechanical failures). Repeated with dilution — performed usually in the case...` |
| 0389 | `tableMetadata.Description` | `"Panic" or mechanical failures). Repeated with dilution — performed usually in the case...` |
| 0389 | `codeSystems[0].Description` | `"Panic" or mechanical failures).\nRepeated with dilution — performed usually in the cas...` |
| 0433 | `codedContent[5].definition` | `"No-code" (i.e., Do not resuscitate)` |
| 0472 | `codedContent[0].comment` | `"S" specification implies that the second timing sequence follows the first, e.g., when...` |
| 0472 | `codedContent[1].comment` | `A" specifies two parallel instructions, as are sometimes used in medication, e.g., pred...` |
| 0527 | `conceptDomain.Description` | `the 5th of every month").` |
| 0527 | `tableMetadata.Description` | `the 5th of every month").` |
| 0527 | `codeSystems[0].Description` | `"the 5th of every month"). Used in HL7 Version 2 messaging in the RPT segment.` |
| 0527 | `valueSets[0].Description` | `the 5th of every month").` |
| 0717 | `codedContent[37].definition` | `"No Consent" policy scheme provides no opportunity for accommodation of an individual's...` |
| 0719 | `codeSystems[0].Description` | ` "potassium" together with and Act.classCode for "laboratory observation" to somehow me...` |
| 0969 | `conceptDomain.Description` | `“Tube/vial” + SAC-48 (Container Material) of “Glass” + SAC-27 (Additive) of “EDTA” may ...` |

