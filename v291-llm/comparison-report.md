# python-docx vs LLM extraction — comparison report

## Message structures

- Common (extracted in both corpuses): 418
- LLM-only: 6
- python-docx-only: 9

| Bucket | Count |
|--------|------:|
| fully_agree | 353 |
| agree_with_metadata_diff | 0 |
| disagree_raw_only | 4 |
| disagree_parsed_only | 33 |
| disagree_both | 28 |

Raw-row disagreement kinds: {'raw_row': 679, 'length': 10}
Parsed-element disagreement kinds: {'parsed_element': 359, 'length': 37}

### LLM-only message structures (first 30)
- ACK_A03 clause=3.3.3 tableIndex=12
- ACK_A33 clause=3.3.33 tableIndex=120
- ACK_R01 clause=7.3.1 tableIndex=4
- ACK_R30 clause=7.3.4 tableIndex=8
- ACK_R31 clause=7.3.5 tableIndex=12
- QBP_Q21 clause=15.3.7 tableIndex=27

### python-docx-only message structures (first 30)
- ACK clause=3.3.3 tableIndex=12
- ACK clause=3.3.33 tableIndex=120
- ACK clause=7.3.1 tableIndex=4
- ACK clause=7.3.4 tableIndex=8
- ACK clause=7.3.5 tableIndex=12
- NMD_N02 clause=14.3.2 tableIndex=3
- UNKNOWN clause=2.14.13 tableIndex=49
- WRQ_Z01 clause=2.12.1 tableIndex=29
- WRQ_Z02 clause=2.12.1 tableIndex=30

### Detailed disagreements (first 20)

#### ADT_A01_03_4.json
- structureId match: True
- caption match: True
- clause: pydocx='3.3.1', llm='3.3.1'
- tableIndex: pydocx=2, llm=2
- Raw-row diffs (1):
  - row 12: pydocx={'segments': '[ OH3 ]', 'description': 'Usual Work', 'status': '', 'chapter': '3'} → llm={'segments': '[ OH3 ]', 'description': 'Usual Work /', 'status': '', 'chapter': '3'}
- Parsed-element diffs (1):
  - elem 12: pydocx={'code': 'OH3', 'description': 'Usual Work', 'optionality': 'O', 'repetition': False, 'chapter': '3'} → llm={'code': 'OH3', 'description': 'Usual Work /', 'optionality': 'O', 'repetition': False, 'chapter': '3'}

#### CCI_I22_11_332.json
- structureId match: True
- caption match: True
- clause: pydocx='11.7.2', llm='11.7.2'
- tableIndex: pydocx=53, llm=53
- Raw-row diffs (1):
  - LENGTH: pydocx=157, llm=7
- Parsed-element diffs (1):
  - LENGTH: pydocx=103, llm=7

#### CCM_I21_11_326.json
- structureId match: True
- caption match: True
- clause: pydocx='11.6.1', llm='11.6.1'
- tableIndex: pydocx=30, llm=30
- Raw-row diffs (1):
  - LENGTH: pydocx=152, llm=5
- Parsed-element diffs (1):
  - LENGTH: pydocx=98, llm=5

#### CCR_I16_11_327.json
- structureId match: True
- caption match: True
- clause: pydocx='11.6.2', llm='11.6.2'
- tableIndex: pydocx=34, llm=34
- Raw-row diffs (4):
  - LENGTH: pydocx=185, llm=35
  - row 18: pydocx={'segments': '|', 'description': '', 'status': '', 'chapter': ''} → llm={'segments': '\\|', 'description': '', 'status': '', 'chapter': ''}
  - row 21: pydocx={'segments': '|', 'description': '', 'status': '', 'chapter': ''} → llm={'segments': '\\|', 'description': '', 'status': '', 'chapter': ''}
  - row 22: pydocx={'segments': 'ODS|', 'description': 'Dietary Order, Suppl., Prefer.', 'status': '', 'chapter': '4'} → llm={'segments': 'ODS\\|', 'description': 'Dietary Order, Suppl., Prefer.', 'status': '', 'chapter': '4'}
- Parsed-element diffs (12):
  - LENGTH: pydocx=120, llm=20
  - elem 9: pydocx={'code': '', 'description': '--- CLINICAL_ORDER_OBJECT begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'OBR', 'description': 'Observation', 'optionality': 'R', 'repetition': False, 'chapter': '4'}
  - elem 10: pydocx={'code': 'OBR', 'description': 'Observation', 'optionality': 'R', 'repetition': False, 'chapter': '4'} → llm={'code': 'PRT', 'description': 'Participation', 'optionality': 'O', 'repetition': True, 'chapter': '7'}
  - elem 11: pydocx={'code': 'PRT', 'description': 'Participation', 'optionality': 'O', 'repetition': True, 'chapter': '7'} → llm={'code': 'RXO', 'description': 'Pharmacy/Treatment Order', 'optionality': 'R', 'repetition': False, 'chapter': '4'}
  - elem 12: pydocx={'code': '', 'description': '', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'PRT', 'description': 'Participation', 'optionality': 'O', 'repetition': True, 'chapter': '7'}
  - elem 13: pydocx={'code': 'RXO', 'description': 'Pharmacy/Treatment Order', 'optionality': 'R', 'repetition': False, 'chapter': '4'} → llm={'code': 'ODS', 'description': 'Dietary Order, Suppl., Prefer.', 'optionality': 'R', 'repetition': False, 'chapter': '4'}

#### CCU_I20_11_328.json
- structureId match: True
- caption match: True
- clause: pydocx='11.6.6', llm='11.6.6'
- tableIndex: pydocx=39, llm=39
- Raw-row diffs (1):
  - LENGTH: pydocx=162, llm=11
- Parsed-element diffs (1):
  - LENGTH: pydocx=105, llm=8

#### CQU_I19_11_330.json
- structureId match: True
- caption match: True
- clause: pydocx='11.7.1', llm='11.7.1'
- tableIndex: pydocx=46, llm=46
- Raw-row diffs (1):
  - LENGTH: pydocx=164, llm=13
- Parsed-element diffs (1):
  - LENGTH: pydocx=107, llm=10

#### DEL_O46_04_176.json
- structureId match: True
- caption match: True
- clause: pydocx='4.16.13', llm='4.16.13'
- tableIndex: pydocx=121, llm=121
- Raw-row diffs (4):
  - row 7: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 10: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 14: pydocx={'segments': '[{ARV}]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': 'B'} → llm={'segments': '[{ARV}]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': '3'}
  - row 17: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
- Parsed-element diffs (1):
  - elem 11: pydocx={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': 'B'} → llm={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### DEO_O45_04_175.json
- structureId match: True
- caption match: True
- clause: pydocx='4.16.12', llm='4.16.12'
- tableIndex: pydocx=119, llm=119
- Raw-row diffs (6):
  - row 6: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 9: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 11: pydocx={'segments': '[{ ARV }]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': 'B'} → llm={'segments': '[{ ARV }]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': '3'}
  - row 15: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 21: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
  - row 25: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '', 'chapter': '7'}
- Parsed-element diffs (1):
  - elem 8: pydocx={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': 'B'} → llm={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### DPR_O48_04_178.json
- structureId match: True
- caption match: True
- clause: pydocx='4.16.15', llm='4.16.15'
- tableIndex: pydocx=125, llm=125
- Raw-row diffs (6):
  - row 7: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '7', 'chapter': '7'}
  - row 10: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '7', 'chapter': '7'}
  - row 14: pydocx={'segments': '[{ARV}]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': 'B'} → llm={'segments': '[{ARV}]', 'description': 'For backwards compatibility only as of V2.9.', 'status': 'B', 'chapter': '3'}
  - row 17: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '7', 'chapter': '7'}
  - row 23: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '7', 'chapter': '7'}
  - row 30: pydocx={'segments': '[{ PRT }]', 'description': 'Participation', 'status': 'Participation', 'chapter': '7'} → llm={'segments': '[{ PRT }]', 'description': 'Participation', 'status': '7', 'chapter': '7'}
- Parsed-element diffs (1):
  - elem 11: pydocx={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': 'B'} → llm={'code': 'ARV', 'description': 'For backwards compatibility only as of V2.9.', 'optionality': 'O', 'repetition': True, 'chapter': '3'}

#### EAC_U07_13_353.json
- structureId match: True
- caption match: True
- clause: pydocx='13.3.7', llm='13.3.7'
- tableIndex: pydocx=25, llm=25
- Raw-row diffs (19):
  - row 0: pydocx={'segments': 'MSH', 'description': 'MSH', 'status': 'Message Header', 'chapter': 'Message Header'} → llm={'segments': 'MSH', 'description': 'Message Header', 'status': '', 'chapter': '2'}
  - row 1: pydocx={'segments': '[{SFT}]', 'description': '[{SFT}]', 'status': 'Software Segment', 'chapter': 'Software Segment'} → llm={'segments': '[{SFT}]', 'description': 'Software Segment', 'status': '', 'chapter': '2'}
  - row 2: pydocx={'segments': '[UAC]', 'description': '[UAC]', 'status': 'User Authentication Credential', 'chapter': 'User Authentication Credential'} → llm={'segments': '[UAC]', 'description': 'User Authentication Credential', 'status': '', 'chapter': '2'}
  - row 3: pydocx={'segments': 'EQU', 'description': 'EQU', 'status': 'Equipment Detail', 'chapter': 'Equipment Detail'} → llm={'segments': 'EQU', 'description': 'Equipment Detail', 'status': '', 'chapter': '13'}
  - row 4: pydocx={'segments': '{', 'description': '{', 'status': '--- COMMAND begin', 'chapter': '--- COMMAND begin'} → llm={'segments': '{', 'description': '--- COMMAND begin', 'status': '', 'chapter': ''}
  - row 5: pydocx={'segments': 'ECD', 'description': 'ECD', 'status': 'Equipment Command Detail', 'chapter': 'Equipment Command Detail'} → llm={'segments': 'ECD', 'description': 'Equipment Command Detail', 'status': '', 'chapter': '13'}
- Parsed-element diffs (13):
  - elem 0: pydocx={'code': 'MSH', 'description': 'MSH', 'optionality': 'R', 'repetition': False, 'chapter': 'Message Header'} → llm={'code': 'MSH', 'description': 'Message Header', 'optionality': 'R', 'repetition': False, 'chapter': '2'}
  - elem 1: pydocx={'code': 'SFT', 'description': '[{SFT}]', 'optionality': 'O', 'repetition': True, 'chapter': 'Software Segment'} → llm={'code': 'SFT', 'description': 'Software Segment', 'optionality': 'O', 'repetition': True, 'chapter': '2'}
  - elem 2: pydocx={'code': 'UAC', 'description': '[UAC]', 'optionality': 'O', 'repetition': False, 'chapter': 'User Authentication Credential'} → llm={'code': 'UAC', 'description': 'User Authentication Credential', 'optionality': 'O', 'repetition': False, 'chapter': '2'}
  - elem 3: pydocx={'code': 'EQU', 'description': 'EQU', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Detail'} → llm={'code': 'EQU', 'description': 'Equipment Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 4: pydocx={'code': 'ECD', 'description': 'ECD', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Command Detail'} → llm={'code': 'ECD', 'description': 'Equipment Command Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 5: pydocx={'code': 'TQ1', 'description': '[ TQ1 ]', 'optionality': 'O', 'repetition': False, 'chapter': 'Timing/quantity'} → llm={'code': 'TQ1', 'description': 'Timing/quantity', 'optionality': 'O', 'repetition': False, 'chapter': '4'}

#### EAN_U09_13_357.json
- structureId match: True
- caption match: True
- clause: pydocx='13.3.9', llm='13.3.9'
- tableIndex: pydocx=33, llm=33
- Raw-row diffs (9):
  - row 0: pydocx={'segments': 'MSH', 'description': 'MSH', 'status': 'Message Header', 'chapter': 'Message Header'} → llm={'segments': 'MSH', 'description': 'Message Header', 'status': '', 'chapter': '2'}
  - row 1: pydocx={'segments': '[{SFT}]', 'description': '[{SFT}]', 'status': 'Software Segment', 'chapter': 'Software Segment'} → llm={'segments': '[{SFT}]', 'description': 'Software Segment', 'status': '', 'chapter': '2'}
  - row 2: pydocx={'segments': '[UAC]', 'description': '[UAC]', 'status': 'User Authentication Credential', 'chapter': 'User Authentication Credential'} → llm={'segments': '[UAC]', 'description': 'User Authentication Credential', 'status': '', 'chapter': '2'}
  - row 3: pydocx={'segments': 'EQU', 'description': 'EQU', 'status': 'Equipment Detail', 'chapter': 'Equipment Detail'} → llm={'segments': 'EQU', 'description': 'Equipment Detail', 'status': '', 'chapter': '13'}
  - row 4: pydocx={'segments': '{', 'description': '{', 'status': '--- NOTIFICATION begin', 'chapter': '--- NOTIFICATION begin'} → llm={'segments': '{', 'description': '--- NOTIFICATION begin', 'status': '', 'chapter': ''}
  - row 5: pydocx={'segments': 'NDS', 'description': 'NDS', 'status': 'Notification Detail', 'chapter': 'Notification Detail'} → llm={'segments': 'NDS', 'description': 'Notification Detail', 'status': '', 'chapter': '13'}
- Parsed-element diffs (7):
  - elem 0: pydocx={'code': 'MSH', 'description': 'MSH', 'optionality': 'R', 'repetition': False, 'chapter': 'Message Header'} → llm={'code': 'MSH', 'description': 'Message Header', 'optionality': 'R', 'repetition': False, 'chapter': '2'}
  - elem 1: pydocx={'code': 'SFT', 'description': '[{SFT}]', 'optionality': 'O', 'repetition': True, 'chapter': 'Software Segment'} → llm={'code': 'SFT', 'description': 'Software Segment', 'optionality': 'O', 'repetition': True, 'chapter': '2'}
  - elem 2: pydocx={'code': 'UAC', 'description': '[UAC]', 'optionality': 'O', 'repetition': False, 'chapter': 'User Authentication Credential'} → llm={'code': 'UAC', 'description': 'User Authentication Credential', 'optionality': 'O', 'repetition': False, 'chapter': '2'}
  - elem 3: pydocx={'code': 'EQU', 'description': 'EQU', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Detail'} → llm={'code': 'EQU', 'description': 'Equipment Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 4: pydocx={'code': 'NDS', 'description': 'NDS', 'optionality': 'R', 'repetition': False, 'chapter': 'Notification Detail'} → llm={'code': 'NDS', 'description': 'Notification Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 5: pydocx={'code': 'NTE', 'description': '[ NTE ]', 'optionality': 'O', 'repetition': False, 'chapter': 'Notification Note'} → llm={'code': 'NTE', 'description': 'Notification Note', 'optionality': 'O', 'repetition': False, 'chapter': '2'}

#### EAR_U08_13_355.json
- structureId match: True
- caption match: True
- clause: pydocx='13.3.8', llm='13.3.8'
- tableIndex: pydocx=29, llm=29
- Raw-row diffs (13):
  - row 0: pydocx={'segments': 'MSH', 'description': 'MSH', 'status': 'Message Header', 'chapter': 'Message Header'} → llm={'segments': 'MSH', 'description': 'Message Header', 'status': '', 'chapter': '2'}
  - row 1: pydocx={'segments': '[{SFT}]', 'description': '[{SFT}]', 'status': 'Software Segment', 'chapter': 'Software Segment'} → llm={'segments': '[{SFT}]', 'description': 'Software Segment', 'status': '', 'chapter': '2'}
  - row 2: pydocx={'segments': '[UAC]', 'description': '[UAC]', 'status': 'User Authentication Credential', 'chapter': 'User Authentication Credential'} → llm={'segments': '[UAC]', 'description': 'User Authentication Credential', 'status': '', 'chapter': '2'}
  - row 3: pydocx={'segments': 'EQU', 'description': 'EQU', 'status': 'Equipment Detail', 'chapter': 'Equipment Detail'} → llm={'segments': 'EQU', 'description': 'Equipment Detail', 'status': '', 'chapter': '13'}
  - row 4: pydocx={'segments': '{', 'description': '{', 'status': '--- COMMAND_RESPONSE begin', 'chapter': '--- COMMAND_RESPONSE begin'} → llm={'segments': '{', 'description': '--- COMMAND_RESPONSE begin', 'status': '', 'chapter': ''}
  - row 5: pydocx={'segments': 'ECD', 'description': 'ECD', 'status': 'Equipment Command Detail', 'chapter': 'Equipment Command Detail'} → llm={'segments': 'ECD', 'description': 'Equipment Command Detail', 'status': '', 'chapter': '13'}
- Parsed-element diffs (9):
  - elem 0: pydocx={'code': 'MSH', 'description': 'MSH', 'optionality': 'R', 'repetition': False, 'chapter': 'Message Header'} → llm={'code': 'MSH', 'description': 'Message Header', 'optionality': 'R', 'repetition': False, 'chapter': '2'}
  - elem 1: pydocx={'code': 'SFT', 'description': '[{SFT}]', 'optionality': 'O', 'repetition': True, 'chapter': 'Software Segment'} → llm={'code': 'SFT', 'description': 'Software Segment', 'optionality': 'O', 'repetition': True, 'chapter': '2'}
  - elem 2: pydocx={'code': 'UAC', 'description': '[UAC]', 'optionality': 'O', 'repetition': False, 'chapter': 'User Authentication Credential'} → llm={'code': 'UAC', 'description': 'User Authentication Credential', 'optionality': 'O', 'repetition': False, 'chapter': '2'}
  - elem 3: pydocx={'code': 'EQU', 'description': 'EQU', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Detail'} → llm={'code': 'EQU', 'description': 'Equipment Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 4: pydocx={'code': 'ECD', 'description': 'ECD', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Command Detail'} → llm={'code': 'ECD', 'description': 'Equipment Command Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 5: pydocx={'code': 'SAC', 'description': 'SAC', 'optionality': 'R', 'repetition': False, 'chapter': 'Specimen Container Detail'} → llm={'code': 'SAC', 'description': 'Specimen Container Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}

#### EHC_E01_16_388.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.1', llm='16.3.1'
- tableIndex: pydocx=2, llm=2
- Parsed-element diffs (41):
  - LENGTH: pydocx=45, llm=43
  - elem 3: pydocx={'code': '', 'description': '--- INVOICE_INFORMATION_SUBMIT begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'O', 'repetition': False, 'chapter': '16'}
  - elem 5: pydocx={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'O', 'repetition': False, 'chapter': '16'} → llm={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 6: pydocx={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'AUT', 'description': 'Authorization Information', 'optionality': 'O', 'repetition': False, 'chapter': ''}
  - elem 7: pydocx={'code': 'AUT', 'description': 'Authorization Information', 'optionality': 'O', 'repetition': False, 'chapter': ''} → llm={'code': 'LOC', 'description': 'Location Identification', 'optionality': 'O', 'repetition': True, 'chapter': '8'}

#### EHC_E02_16_389.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.2', llm='16.3.2'
- tableIndex: pydocx=4, llm=4
- Parsed-element diffs (8):
  - LENGTH: pydocx=12, llm=10
  - elem 3: pydocx={'code': '', 'description': '--- INVOICE_INFORMATION_CANCEL begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 5: pydocx={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 6: pydocx={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 7: pydocx={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'PSS', 'description': '', 'optionality': 'R', 'repetition': False, 'chapter': ''}

#### EHC_E04_16_392.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.5', llm='16.3.5'
- tableIndex: pydocx=10, llm=10
- Parsed-element diffs (6):
  - LENGTH: pydocx=10, llm=8
  - elem 3: pydocx={'code': '', 'description': '--- REASSESSMENT_REQUEST_INFO begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 5: pydocx={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'PSS', 'description': 'Product/Service Section', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 6: pydocx={'code': 'PSS', 'description': 'Product/Service Section', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'PSG', 'description': 'Product/Service Group', 'optionality': 'R', 'repetition': False, 'chapter': ''}
  - elem 7: pydocx={'code': 'PSG', 'description': 'Product/Service Group', 'optionality': 'R', 'repetition': False, 'chapter': ''} → llm={'code': 'PSL', 'description': 'Product/Service Line Item', 'optionality': 'O', 'repetition': True, 'chapter': '16'}

#### EHC_E15_16_396.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.9', llm='16.3.9'
- tableIndex: pydocx=18, llm=18
- Parsed-element diffs (12):
  - LENGTH: pydocx=16, llm=14
  - elem 3: pydocx={'code': '', 'description': '--- PAYMENT_REMITTANCE_HEADER_INFO begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'PMT', 'description': 'Payment Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'PMT', 'description': 'Payment Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 5: pydocx={'code': 'PYE', 'description': 'Payee Information', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'IPR', 'description': 'Invoice Processing Results', 'optionality': 'R', 'repetition': False, 'chapter': ''}
  - elem 6: pydocx={'code': '', 'description': '--- PAYMENT_REMITTANCE_HEADER_INFO end', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': ''}
  - elem 7: pydocx={'code': 'IPR', 'description': 'Invoice Processing Results', 'optionality': 'R', 'repetition': False, 'chapter': ''} → llm={'code': 'PSS', 'description': 'Product/Service Section', 'optionality': 'R', 'repetition': False, 'chapter': ''}

#### EHC_E20_16_397.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.10', llm='16.3.10'
- tableIndex: pydocx=20, llm=20
- Parsed-element diffs (25):
  - LENGTH: pydocx=29, llm=27
  - elem 3: pydocx={'code': '', 'description': '--- AUTHORIZATION_REQUEST begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice Header', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'IVC', 'description': 'Invoice Header', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'R', 'repetition': True, 'chapter': ''}
  - elem 5: pydocx={'code': 'CTD', 'description': 'Contact Data', 'optionality': 'R', 'repetition': True, 'chapter': ''} → llm={'code': 'LOC', 'description': 'Location Identification', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 6: pydocx={'code': 'LOC', 'description': 'Location Identification', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'ROL', 'description': 'Provider Identification', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 7: pydocx={'code': 'ROL', 'description': 'Provider Identification', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'PID', 'description': 'Person Identification', 'optionality': 'R', 'repetition': False, 'chapter': ''}

#### EHC_E21_16_398.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.11', llm='16.3.11'
- tableIndex: pydocx=22, llm=22
- Parsed-element diffs (5):
  - LENGTH: pydocx=9, llm=7
  - elem 3: pydocx={'code': '', 'description': '--- AUTHORIZATION_REQUEST begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice Header', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 4: pydocx={'code': 'IVC', 'description': 'Invoice Header', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'PSL', 'description': 'Product/Service Line Item', 'optionality': 'R', 'repetition': False, 'chapter': '16'}
  - elem 5: pydocx={'code': 'PSL', 'description': 'Product/Service Line Item', 'optionality': 'R', 'repetition': False, 'chapter': '16'} → llm={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''}
  - elem 6: pydocx={'code': 'NTE', 'description': 'Notes and Comments', 'optionality': 'O', 'repetition': True, 'chapter': ''} → llm={'code': 'AUT', 'description': 'Authorization', 'optionality': 'O', 'repetition': False, 'chapter': '16'}

#### EHC_E24_16_401.json
- structureId match: True
- caption match: True
- clause: pydocx='16.3.14', llm='16.3.14'
- tableIndex: pydocx=28, llm=28
- Parsed-element diffs (5):
  - LENGTH: pydocx=11, llm=9
  - elem 5: pydocx={'code': '', 'description': '--- AUTHORIZATION_RESPONSE_INFO begin', 'optionality': '', 'repetition': False, 'chapter': ''} → llm={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': ''}
  - elem 6: pydocx={'code': 'IVC', 'description': 'Invoice', 'optionality': 'R', 'repetition': False, 'chapter': ''} → llm={'code': 'PSL', 'description': 'Product/Service Line Item', 'optionality': 'R', 'repetition': False, 'chapter': ''}
  - elem 7: pydocx={'code': 'PSL', 'description': 'Product/Service Line Item', 'optionality': 'R', 'repetition': False, 'chapter': ''} → llm={'code': 'AUT', 'description': 'Authorization', 'optionality': 'O', 'repetition': False, 'chapter': ''}
  - elem 8: pydocx={'code': 'AUT', 'description': 'Authorization', 'optionality': 'O', 'repetition': False, 'chapter': ''} → llm={'code': 'ADJ', 'description': 'Adjustment', 'optionality': 'O', 'repetition': True, 'chapter': ''}

#### ESR_U02_13_343.json
- structureId match: True
- caption match: True
- clause: pydocx='13.3.2', llm='13.3.2'
- tableIndex: pydocx=5, llm=5
- Raw-row diffs (5):
  - row 0: pydocx={'segments': 'MSH', 'description': 'MSH', 'status': 'Message Header', 'chapter': 'Message Header'} → llm={'segments': 'MSH', 'description': 'Message Header', 'status': '', 'chapter': '2'}
  - row 1: pydocx={'segments': '[{SFT}]', 'description': '[{SFT}]', 'status': 'Software Segment', 'chapter': 'Software Segment'} → llm={'segments': '[{SFT}]', 'description': 'Software Segment', 'status': '', 'chapter': '2'}
  - row 2: pydocx={'segments': '[UAC]', 'description': '[UAC]', 'status': 'User Authentication Credential', 'chapter': 'User Authentication Credential'} → llm={'segments': '[UAC]', 'description': 'User Authentication Credential', 'status': '', 'chapter': '2'}
  - row 3: pydocx={'segments': 'EQU', 'description': 'EQU', 'status': 'Equipment Detail', 'chapter': 'Equipment Detail'} → llm={'segments': 'EQU', 'description': 'Equipment Detail', 'status': '', 'chapter': '13'}
  - row 4: pydocx={'segments': '[ROL]', 'description': '[ROL]', 'status': 'Role Detail', 'chapter': 'Role Detail'} → llm={'segments': '[ROL]', 'description': 'Role Detail', 'status': 'B', 'chapter': '12'}
- Parsed-element diffs (5):
  - elem 0: pydocx={'code': 'MSH', 'description': 'MSH', 'optionality': 'R', 'repetition': False, 'chapter': 'Message Header'} → llm={'code': 'MSH', 'description': 'Message Header', 'optionality': 'R', 'repetition': False, 'chapter': '2'}
  - elem 1: pydocx={'code': 'SFT', 'description': '[{SFT}]', 'optionality': 'O', 'repetition': True, 'chapter': 'Software Segment'} → llm={'code': 'SFT', 'description': 'Software Segment', 'optionality': 'O', 'repetition': True, 'chapter': '2'}
  - elem 2: pydocx={'code': 'UAC', 'description': '[UAC]', 'optionality': 'O', 'repetition': False, 'chapter': 'User Authentication Credential'} → llm={'code': 'UAC', 'description': 'User Authentication Credential', 'optionality': 'O', 'repetition': False, 'chapter': '2'}
  - elem 3: pydocx={'code': 'EQU', 'description': 'EQU', 'optionality': 'R', 'repetition': False, 'chapter': 'Equipment Detail'} → llm={'code': 'EQU', 'description': 'Equipment Detail', 'optionality': 'R', 'repetition': False, 'chapter': '13'}
  - elem 4: pydocx={'code': 'ROL', 'description': '[ROL]', 'optionality': 'O', 'repetition': False, 'chapter': 'Role Detail'} → llm={'code': 'ROL', 'description': 'Role Detail', 'optionality': 'O', 'repetition': False, 'chapter': '12'}

## Segments

- Common occurrence keys: 193
- LLM-only: 0
- python-docx-only: 0

| Bucket | Count |
|--------|------:|
| fully_agree | 184 |
| agree_with_metadata_diff | 1 |
| disagree_fields | 8 |

Field disagreement kinds: {'field': 12, 'length': 1}

### Duplicate provenance keys

More than one occurrence in the same corpus shares the same (code, clause, tableIndex). The comparison uses the first occurrence for each key; the extras are not compared. Most likely cause on the LLM side: extract_v291_llm.py's flush_segment_registry appends to existing files on each run.

LLM duplicates (2):
- EVN clause=3.4.1 tableIndex=233: 2 occurrences
- PID clause=3.4.2 tableIndex=234: 2 occurrences

### Detailed segment disagreements (first 8)

#### BPX clause=4.14.2 tableIndex=99
- name match: True
- section heading match: True
- Field diffs (1):
  - field 21: pydocx={'sequence': '22', 'length': '22', 'confLength': '1..1', 'dataType': 'ID', 'optionality': 'ID', 'repetition': 'O', 'tableBinding': '0206', 'itemNumber': '00816', 'name': 'Action Code'} → llm={'sequence': '22', 'length': '1..1', 'confLength': '', 'dataType': 'ID', 'optionality': 'O', 'repetition': '', 'tableBinding': '0206', 'itemNumber': '00816', 'name': 'Action Code'}

#### BTX clause=4.14.3 tableIndex=100
- name match: True
- section heading match: True
- Field diffs (1):
  - field 20: pydocx={'sequence': '21', 'length': '21', 'confLength': '1..1', 'dataType': 'ID', 'optionality': 'ID', 'repetition': '', 'tableBinding': '', 'itemNumber': '00816', 'name': '00816'} → llm={'sequence': '21', 'length': '1..1', 'confLength': '1..1', 'dataType': 'ID', 'optionality': 'O', 'repetition': '', 'tableBinding': '0206', 'itemNumber': '00816', 'name': 'Action Code'}

#### BUI clause=4.17.2 tableIndex=128
- name match: True
- section heading match: True
- Field diffs (1):
  - field 12: pydocx={'sequence': '13', 'length': '1..1', 'confLength': '1..1', 'dataType': 'ID', 'optionality': 'O', 'repetition': 'O', 'tableBinding': '0206', 'itemNumber': '00816', 'name': 'Action Code'} → llm={'sequence': '13', 'length': '1..1', 'confLength': '1..1', 'dataType': 'ID', 'optionality': 'O', 'repetition': '', 'tableBinding': '0206', 'itemNumber': '00816', 'name': 'Action Code'}

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

#### LAN clause=15.4.4 tableIndex=44
- name match: True
- section heading match: True
- Field diffs (1):
  - field 0: pydocx={'sequence': '1', 'length': '1..4', 'confLength': '', 'dataType': 'SI', 'optionality': 'R', 'repetition': '', 'tableBinding': '', 'itemNumber': '01455', 'name': 'Set ID – LAN'} → llm={'sequence': '1', 'length': '', 'confLength': '1..4', 'dataType': 'SI', 'optionality': 'R', 'repetition': '', 'tableBinding': '', 'itemNumber': '01455', 'name': 'Set ID – LAN'}

#### LCH clause=8.9.3 tableIndex=61
- name match: True
- section heading match: True
- Field diffs (1):
  - field 4: pydocx={'sequence': '5', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'R', 'repetition': '', 'tableBinding': '0136/\n0262/\n0263', 'itemNumber': '01294', 'name': 'Location Characteristic Value - LCH'} → llm={'sequence': '5', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'R', 'repetition': '', 'tableBinding': '0136/ 0262/ 0263', 'itemNumber': '01294', 'name': 'Location Characteristic Value - LCH'}

#### OM1 clause=8.8.9 tableIndex=44
- name match: True
- section heading match: True
- Field diffs (1):
  - field 55: pydocx={'sequence': '56', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0647', 'itemNumber': '03437', 'name': 'Observation/Identifier associated with Producer’s Service/Test/Observation ID'} → llm={'sequence': '56', 'length': '', 'confLength': '', 'dataType': 'CWE', 'optionality': 'O', 'repetition': '', 'tableBinding': '0647', 'itemNumber': '03437', 'name': "Observation/Identifier associated with Producer's Service/Test/Observation ID"}

#### STF clause=15.4.8 tableIndex=48
- name match: True
- section heading match: True
- Field diffs (1):
  - field 18: pydocx={'sequence': '19', 'length': '', 'confLength': '', 'dataType': 'JCC', 'optionality': 'O', 'repetition': '', 'tableBinding': '0327/\n0328', 'itemNumber': '00786', 'name': 'Job Code/Class'} → llm={'sequence': '19', 'length': '', 'confLength': '', 'dataType': 'JCC', 'optionality': 'O', 'repetition': '', 'tableBinding': '0327/ 0328', 'itemNumber': '00786', 'name': 'Job Code/Class'}

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
