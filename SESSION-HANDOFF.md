# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-15

## ACTIVE: V291 message structure reconciliation and canonical pipeline

### What Was Done This Session

1. **Message structure comparison tool** (FHIR vs V291): 418 pairs, 642 structural / 274 cosmetic. 84 tests.
2. **V291 extraction fixes**: split table continuation (CH11), choice groups (22 structures), clause numbers replacing table indices
3. **V291 internal consistency report**: 36 multi-occurrence structures, fine-grained classification
4. **V291 canonical pipeline**: fixes.json manifest + apply script + HTML traceability report
5. **ACK reconciliation**: 114 of 115 ACK structures now identical after description/cardinality fixes. 1 pending review (UAC repeating in clause 10.4).
6. **FHIR fixes**: Varies moved to data type, Hxx updated, I12-I15 events created, V2 mgmt report expanded to 12 sections

### Current State
- Branch: `dev/framework` (up to date with origin)
- Last commit: `ad83e520` — Fix ACK descriptions, ERR cardinality, add pending review support
- Tests: 84 message structure comparison tests passing
- V291 consistency: 16 structures, 94 remaining differences (down from 311)

### Immediate Next Steps
1. **Collapse ACK structures** into single canonical entry with all 114 message identifier mappings
2. **Continue non-ACK V291 reconciliation** — work through remaining 94 differences with user
3. **Switch FHIR comparison to canonical data** once V291 is stable

### Key Commands
```bash
python3 tooling/scripts/apply_v291_fixes.py              # Apply fixes, generate canonical + report
python3 tooling/scripts/compare_v291_occurrences.py --canonical  # Consistency report against fixed data
python3 tooling/scripts/compare_message_structures.py     # FHIR vs V291 comparison
```

### Pending V2 Management Review
- REVIEW-0001: ACK clause 10.4 UAC repeating
- Varies contextual typing (v2mgmt report sec 8)
- Hxx BackboneElement representation (sec 9)
- Choice groups in message structures (sec 10)
- O59 shared event code (sec 4)
