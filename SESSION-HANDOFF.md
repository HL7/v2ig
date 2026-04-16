# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-16

## ACTIVE: V291 message structure reconciliation — fixes, PRT audit, review report

### What Was Done This Session

1. **Investigated broken extractions**: QBP_Q11 clause 5.3.3.3 (actually 5.3.3.2, Word parsing artifact with hidden columns), NMD_N02 second table (ACK^N02^ACK mislabeled as NMD_N02 due to caption reuse)
2. **Category 3 fixes (typos)**: "Particitation"→"Participation" in ADT_A05, doubled text in RDE_O11
3. **Category 4 fixes (cosmetic)**: BULK-002 removes "Segment" suffix (313 changes across 198 files), BULK-003 normalizes en/em-dashes (81 changes), group name fixes (PROCEDURE case, PATIENT space, COMPONENT→COMPONENTS), singular/plural alignment (repeating=plural, non-repeating=singular), RTB_K13 QPD abbreviation fix
4. **Category 5 fixes (meaningful)**: ROL="Role" not "Deprecated", ORU_R01 PRT "for Common Order" across all 4 occurrences, OPU_R25 OBX "Patient Observation"
5. **PRT/OBX description audit**: 417→629 findings across 115+ structures. Fixed: 7 typos, 12 titleization, 33 segment-code-as-qualifier (ORC→Common Order, RXO→Pharmacy/Treatment Order, etc.), 21 qualified observation group fixes (Patient Observation, Specimen Observation, etc.)
6. **ACK section in review report**: NMD_N02 caption fixed, 116 ACK messages listed with yellow highlighting for non-standard descriptions, collapse note added
7. **Review report** (`v291-canonical/v291-review-report.html`): comprehensive HTML with per-structure provenance, event mappings, cardinality recommendations, PRT audit summary
8. **Audit script** (`tooling/scripts/audit_prt_descriptions.py`): rewritten with clause references on every finding
9. **Apply script** (`tooling/scripts/apply_v291_fixes.py`): added clause, structureId, segment suffix strip, dash normalization, group_filter fix types

### Current State
- Branch: `dev/framework` (3 commits ahead of origin)
- Last commit: `285950ba` — Fix qualified observation group PRT descriptions, update report
- Tests: Not applicable (data pipeline, not code tests)
- Fixes: 83 total in fixes.json
- Internal consistency: 94 differences reduced to 35 remaining

### Remaining 35 Multi-Occurrence Differences
- **Cardinality (structural)**: 5 — ADT_A01 OH3, ADT_A05 NK1, ORU_R01 PRT, RDY_K15 ERR, RTB_K13 ERR (V2 mgmt review)
- **QBP_Q11 extraction artifact**: 10 — Word parsing issue, descriptions are bracket notation
- **NTE descriptions**: 13 — long vs short form in MDM_T01/T02 (CH09), pending decision
- **PRT qualifiers**: 6 — multi-occurrence discrepancies (V2 mgmt review)
- **Group names**: 1 — GUARANTOR_INSURANCE vs GUARANTOR+INSURANCE in RQI_I01 (pending decision)
- **ACK REVIEW-0001**: 1 — UAC repeating in clause 10.4 (pending V2 mgmt review)

### Immediate Next Steps
1. **User decisions pending**: NTE description form (long vs short), GUARANTOR_INSURANCE group name
2. **Collapse ACK structures** into single canonical entry with all 116 message identifier mappings
3. **Continue non-ACK V291 reconciliation** — switch FHIR comparison to canonical data once V291 is stable
4. **Push commits** to origin (3 ahead)

### Open Questions / Blockers
- REVIEW-0001: ACK clause 10.4 UAC repeating — needs V2 Management decision
- "for Additional Demographics" in PATIENT group (5 instances) — flagged for V2 mgmt, clauses listed in report
- RDE_O11 RXO "Prescription Order" variant vs standard "Pharmacy/Treatment Order" — noted in FIX reasoning
- 358 bare "Participation" (no qualifier) and 165 OBX mismatches — large-scale standardization for V2 mgmt

### Key Commands
```bash
python3 tooling/scripts/apply_v291_fixes.py              # Apply fixes, generate canonical + report
python3 tooling/scripts/compare_v291_occurrences.py --canonical  # Consistency report
python3 tooling/scripts/audit_prt_descriptions.py         # PRT/OBX audit with clause refs
python3 tooling/scripts/generate_v291_review_report.py    # Comprehensive review report
```
