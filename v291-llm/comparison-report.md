# python-docx vs LLM extraction — comparison report

- Common files (extracted in both corpuses): 106
- LLM-only (the LLM extracted; python-docx didn't): 2
- python-docx-only (python-docx extracted; LLM didn't): 321

## Bucket counts

| Bucket | Count |
|--------|------:|
| fully_agree | 104 |
| agree_with_metadata_diff | 0 |
| disagree_raw_only | 0 |
| disagree_parsed_only | 1 |
| disagree_both | 1 |

## Raw-row disagreement kinds: {'raw_row': 1}
## Parsed-element disagreement kinds: {'parsed_element': 1, 'length': 1}

## LLM-only (first 30)
- ACK_A03 clause=3.3.3 tableIndex=12
- ACK_A33 clause=3.3.33 tableIndex=120

## python-docx-only (first 30)
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

## Detailed disagreements (first 2)

### ADT_A01_03_4.json
- structureId match: True
- caption match: True
- clause: pydocx='3.3.1', llm='3.3.1'
- tableIndex: pydocx=2, llm=2
- Raw-row diffs (1):
  - row 12: pydocx={'segments': '[ OH3 ]', 'description': 'Usual Work', 'status': '', 'chapter': '3'} → llm={'segments': '[ OH3 ]', 'description': 'Usual Work /', 'status': '', 'chapter': '3'}
- Parsed-element diffs (1):
  - elem 12: pydocx={'code': 'OH3', 'description': 'Usual Work', 'optionality': 'O', 'repetition': False, 'chapter': '3'} → llm={'code': 'OH3', 'description': 'Usual Work /', 'optionality': 'O', 'repetition': False, 'chapter': '3'}

### ADT_A44_03_80.json
- structureId match: True
- caption match: True
- clause: pydocx='3.3.47', llm='3.3.47'
- tableIndex: pydocx=154, llm=154
- Parsed-element diffs (1):
  - LENGTH: pydocx=13, llm=12
