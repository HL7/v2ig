# python-docx vs LLM extraction — comparison report

## Message structures

- Common (extracted in both corpuses): 125
- LLM-only: 5
- python-docx-only: 302

| Bucket | Count |
|--------|------:|
| fully_agree | 124 |
| agree_with_metadata_diff | 0 |
| disagree_raw_only | 0 |
| disagree_parsed_only | 0 |
| disagree_both | 1 |

Raw-row disagreement kinds: {'raw_row': 1}
Parsed-element disagreement kinds: {'parsed_element': 1}

### LLM-only message structures (first 30)
- ACK_A03 clause=3.3.3 tableIndex=12
- ACK_A33 clause=3.3.33 tableIndex=120
- ACK_R01 clause=7.3.1 tableIndex=4
- ACK_R30 clause=7.3.4 tableIndex=8
- ACK_R31 clause=7.3.5 tableIndex=12

### python-docx-only message structures (first 30)
- ACK clause=10.4 tableIndex=9
- ACK clause=11.3.7 tableIndex=20
- ACK clause=12.3.1 tableIndex=5
- ACK clause=12.3.2 tableIndex=9
- ACK clause=12.3.3 tableIndex=13
- ACK clause=12.3.4 tableIndex=17
- ACK clause=13.3.1 tableIndex=3
- ACK clause=13.3.10 tableIndex=39
- ACK clause=13.3.11 tableIndex=43
- ACK clause=13.3.12 tableIndex=47
- ACK clause=13.3.13 tableIndex=51
- ACK clause=13.3.14 tableIndex=55
- ACK clause=13.3.2 tableIndex=7
- ACK clause=13.3.3 tableIndex=11
- ACK clause=13.3.4 tableIndex=15
- ACK clause=13.3.5 tableIndex=19
- ACK clause=13.3.6 tableIndex=23
- ACK clause=13.3.7 tableIndex=27
- ACK clause=13.3.8 tableIndex=31
- ACK clause=13.3.9 tableIndex=35
- ACK clause=15.3.1 tableIndex=4
- ACK clause=15.3.2 tableIndex=8
- ACK clause=15.3.3 tableIndex=12
- ACK clause=15.3.4 tableIndex=16
- ACK clause=15.3.5 tableIndex=20
- ACK clause=15.3.6 tableIndex=24
- ACK clause=15.3.8 tableIndex=35
- ACK clause=15.3.9 tableIndex=39
- ACK clause=17.5.1 tableIndex=15
- ACK clause=17.5.2 tableIndex=21

### Detailed disagreements (first 1)

#### ADT_A01_03_4.json
- structureId match: True
- caption match: True
- clause: pydocx='3.3.1', llm='3.3.1'
- tableIndex: pydocx=2, llm=2
- Raw-row diffs (1):
  - row 12: pydocx={'segments': '[ OH3 ]', 'description': 'Usual Work', 'status': '', 'chapter': '3'} → llm={'segments': '[ OH3 ]', 'description': 'Usual Work /', 'status': '', 'chapter': '3'}
- Parsed-element diffs (1):
  - elem 12: pydocx={'code': 'OH3', 'description': 'Usual Work', 'optionality': 'O', 'repetition': False, 'chapter': '3'} → llm={'code': 'OH3', 'description': 'Usual Work /', 'optionality': 'O', 'repetition': False, 'chapter': '3'}

## Segments

- Common occurrence keys: 52
- LLM-only: 0
- python-docx-only: 141

| Bucket | Count |
|--------|------:|
| fully_agree | 51 |
| agree_with_metadata_diff | 0 |
| disagree_fields | 1 |

Field disagreement kinds: {'length': 1, 'field': 5}

### Duplicate provenance keys

More than one occurrence in the same corpus shares the same (code, clause, tableIndex). The comparison uses the first occurrence for each key; the extras are not compared. Most likely cause on the LLM side: extract_v291_llm.py's flush_segment_registry appends to existing files on each run.

LLM duplicates (2):
- EVN clause=3.4.1 tableIndex=233: 2 occurrences
- PID clause=3.4.2 tableIndex=234: 2 occurrences

### python-docx-only segment occurrences (first 30)
- ABS clause=6.5.12 tableIndex=51
- ACC clause=6.5.9 tableIndex=48
- ADJ clause=16.4.7 tableIndex=36
- AFF clause=15.4.1 tableIndex=41
- AIG clause=10.6.5 tableIndex=19
- AIL clause=10.6.6 tableIndex=23
- AIP clause=10.6.7 tableIndex=25
- AIS clause=10.6.4 tableIndex=16
- APR clause=10.6.8 tableIndex=28
- ARQ clause=10.6.1 tableIndex=11
- AUT clause=11.8.2 tableIndex=58
- BLC clause=6.5.13 tableIndex=52
- BLG clause=4.5.2 tableIndex=52
- BPO clause=4.14.1 tableIndex=98
- BPX clause=4.14.2 tableIndex=99
- BTX clause=4.14.3 tableIndex=100
- BUI clause=4.17.2 tableIndex=128
- CDM clause=8.10.2 tableIndex=69
- CDO clause=4A.5.9 tableIndex=51
- CER clause=15.4.2 tableIndex=42
- CM0 clause=8.11.2 tableIndex=79
- CM1 clause=8.11.3 tableIndex=80
- CM2 clause=8.11.4 tableIndex=81
- CNS clause=13.4.8 tableIndex=64
- CON clause=9.7.1 tableIndex=46
- CTD clause=11.8.4 tableIndex=60
- CTR clause=8.14.2 tableIndex=99
- DEV clause=17.8.1 tableIndex=67
- DG1 clause=6.5.2 tableIndex=41
- DMI clause=8.13.2 tableIndex=94

### Detailed segment disagreements (first 1)

#### GSR clause=3.4.20 tableIndex=252
- name match: True
- section heading match: True
- Field diffs (6):
  - LENGTH: pydocx=10, llm=11
  - field 5: pydocx={'sequence': '6', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0826', 'itemNumber': '02519', 'name': 'Source Document Type for Recorded Sex or Gender'} → llm={'sequence': '', 'length': '', 'confLength': '', 'dataType': '', 'optionality': '', 'repetition': '', 'tableBinding': '', 'itemNumber': '', 'name': ''}
  - field 6: pydocx={'sequence': '7', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0827', 'itemNumber': '02520', 'name': 'Source Document Jurisdiction for Recorded Sex or Gender'} → llm={'sequence': '6', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0826', 'itemNumber': '02519', 'name': 'Source Document Type for Recorded Sex or Gender'}
  - field 7: pydocx={'sequence': '8', 'length': '', 'confLength': '', 'dataType': 'DTM', 'optionality': 'O', 'repetition': '', 'tableBinding': '', 'itemNumber': '02521', 'name': 'Acquisition Date'} → llm={'sequence': '7', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0827', 'itemNumber': '02520', 'name': 'Source Document Jurisdiction for Recorded Sex or Gender'}
  - field 8: pydocx={'sequence': '9', 'length': '', 'confLength': '', 'dataType': 'DR', 'optionality': 'O', 'repetition': '', 'tableBinding': '', 'itemNumber': '02522', 'name': 'Validity Period'} → llm={'sequence': '8', 'length': '', 'confLength': '', 'dataType': 'DTM', 'optionality': 'O', 'repetition': '', 'tableBinding': '', 'itemNumber': '02521', 'name': 'Acquisition Date'}
  - field 9: pydocx={'sequence': '10', 'length': '', 'confLength': '', 'dataType': 'TX', 'optionality': 'O', 'repetition': '', 'tableBinding': '', 'itemNumber': '02523', 'name': 'Comment'} → llm={'sequence': '9', 'length': '', 'confLength': '', 'dataType': 'DR', 'optionality': 'O', 'repetition': '', 'tableBinding': '', 'itemNumber': '02522', 'name': 'Validity Period'}

## Complex data types

- Common occurrence keys: 83
- LLM-only: 0
- python-docx-only: 0

| Bucket | Count |
|--------|------:|
| fully_agree | 82 |
| agree_with_metadata_diff | 1 |
| disagree_components | 0 |

Component disagreement kinds: {}
