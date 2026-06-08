# python-docx vs LLM extraction — comparison report

## Message structures

- Common (extracted in both corpuses): 125
- LLM-only: 5
- python-docx-only: 302

| Bucket | Count |
|--------|------:|
| fully_agree | 109 |
| agree_with_metadata_diff | 0 |
| disagree_raw_only | 0 |
| disagree_parsed_only | 0 |
| disagree_both | 16 |

Raw-row disagreement kinds: {'raw_row': 65}
Parsed-element disagreement kinds: {'parsed_element': 65}

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

### Detailed disagreements (first 16)

#### ADT_A01_03_4.json
- structureId match: True
- caption match: True
- clause: pydocx='3.3.1', llm='3.3.1'
- tableIndex: pydocx=2, llm=2
- Raw-row diffs (1):
  - row 12: pydocx={'segments': '[ OH3 ]', 'description': 'Usual Work', 'status': '', 'chapter': '3'} → llm={'segments': '[ OH3 ]', 'description': 'Usual Work /', 'status': '', 'chapter': '3'}
- Parsed-element diffs (1):
  - elem 12: pydocx={'code': 'OH3', 'description': 'Usual Work', 'optionality': 'O', 'repetition': False, 'chapter': '3'} → llm={'code': 'OH3', 'description': 'Usual Work /', 'optionality': 'O', 'repetition': False, 'chapter': '3'}

#### CRM_C01_07_248.json
- structureId match: True
- caption match: True
- clause: pydocx='7.7.1', llm='7.7.1'
- tableIndex: pydocx=45, llm=45
- Raw-row diffs (3):
  - row 6: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 7: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (3):
  - elem 5: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 6: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### CSU_C09_07_249.json
- structureId match: True
- caption match: True
- clause: pydocx='7.7.2', llm='7.7.2'
- tableIndex: pydocx=55, llm=55
- Raw-row diffs (3):
  - row 7: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (3):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### OPU_R25_07_243.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.11', llm='7.3.11'
- tableIndex: pydocx=26, llm=26
- Raw-row diffs (5):
  - row 16: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 17: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 22: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 23: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 24: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 12: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 13: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 16: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 17: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 18: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R01_07_231.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.1', llm='7.3.1'
- tableIndex: pydocx=2, llm=2
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 19: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 20: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 16: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 17: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R01_07_244.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.12', llm='7.3.12'
- tableIndex: pydocx=28, llm=28
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 19: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 20: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 16: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 17: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R01_07_246.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.14', llm='7.3.14'
- tableIndex: pydocx=32, llm=32
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 19: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 20: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 16: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 17: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R01_07_247.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.15', llm='7.3.15'
- tableIndex: pydocx=34, llm=34
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 19: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 20: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 16: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 17: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R30_07_233.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.4', llm='7.3.4'
- tableIndex: pydocx=6, llm=6
- Raw-row diffs (3):
  - row 6: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 7: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (3):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R30_07_235.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.5', llm='7.3.5'
- tableIndex: pydocx=10, llm=10
- Raw-row diffs (3):
  - row 6: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 7: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (3):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### ORU_R30_07_237.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.6', llm='7.3.6'
- tableIndex: pydocx=14, llm=14
- Raw-row diffs (3):
  - row 6: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 7: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
- Parsed-element diffs (3):
  - elem 6: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 7: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### OSM_R26_07_251.json
- structureId match: True
- caption match: True
- clause: pydocx='7.16.1', llm='7.16.1'
- tableIndex: pydocx=74, llm=74
- Raw-row diffs (4):
  - row 38: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 39: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 53: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 54: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (4):
  - elem 23: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 24: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 32: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 33: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### OUL_R22_07_240.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.8', llm='7.3.8'
- tableIndex: pydocx=20, llm=20
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 26: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 27: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 7: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 9: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 19: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 20: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### OUL_R23_07_241.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.9', llm='7.3.9'
- tableIndex: pydocx=22, llm=22
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 30: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 31: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 7: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 9: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 23: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 24: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### OUL_R24_07_242.json
- structureId match: True
- caption match: True
- clause: pydocx='7.3.10', llm='7.3.10'
- tableIndex: pydocx=24, llm=24
- Raw-row diffs (5):
  - row 8: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 10: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 30: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 31: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 7: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 9: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 23: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 24: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### PEX_P07_07_250.json
- structureId match: True
- caption match: True
- clause: pydocx='7.11.1', llm='7.11.1'
- tableIndex: pydocx=65, llm=65
- Raw-row diffs (5):
  - row 7: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 8: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
  - row 9: pydocx={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': ''} → llm={'segments': '[{GSC}]', 'description': 'Sex Parameter for Clinical Use', 'status': '', 'chapter': '3'}
  - row 46: pydocx={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSP}]', 'description': 'Person Gender and Sex', 'status': '', 'chapter': '3'}
  - row 47: pydocx={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': ''} → llm={'segments': '[{GSR}]', 'description': 'Recorded Gender and Sex', 'status': '', 'chapter': '3'}
- Parsed-element diffs (5):
  - elem 7: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 8: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 9: pydocx={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSC', 'description': 'Sex Parameter for Clinical Use', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 32: pydocx={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSP', 'description': 'Person Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}
  - elem 33: pydocx={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'GSR', 'description': 'Recorded Gender and Sex', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

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

- Common occurrence keys: 71
- LLM-only: 12
- python-docx-only: 0

| Bucket | Count |
|--------|------:|
| fully_agree | 70 |
| agree_with_metadata_diff | 1 |
| disagree_components | 0 |

Component disagreement kinds: {}

### LLM-only data type occurrences (first 30)
- DT clause=2A.3.21 tableIndex=26
- DTM clause=2A.3.22 tableIndex=27
- FT clause=2A.3.31 tableIndex=36
- GTS clause=2A.3.32 tableIndex=37
- ID clause=2A.3.35 tableIndex=40
- IS clause=2A.3.36 tableIndex=41
- NM clause=2A.3.47 tableIndex=50
- SI clause=2A.3.70 tableIndex=72
- SNM clause=2A.3.72 tableIndex=75
- ST clause=2A.3.76 tableIndex=78
- TM clause=2A.3.77 tableIndex=79
- TX clause=2A.3.80 tableIndex=81
