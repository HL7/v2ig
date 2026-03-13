# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-03-13

### What Was Done
- Restructured session continuity: SESSION-HANDOFF.md is now overwritten each session (not appended), JOURNAL.md is append-only archive never read at startup
- Updated `/uadf-start` and `/uadf-handoff` skills (project-level overrides in `.claude/commands/uadf/`)
- Updated `framework.md` to v3.1.0 reflecting new protocol
- Removed Message Structure tab from message page Formal Views (per stakeholder decision)
- Removed Key Elements tab from all Formal Views (JS targets `#tabs-key`)
- Added prominent "Message Structure: [link]" in message page intro text (styled with blue left border)
- Changed IG version from `0.0.0` to `2026` in v2plus.xml — header now shows "2026 - draft"
- Created subset/full build separation:
  - `ig.ini` → `v2plus-subset.xml` (safe default, ~20 min)
  - `ig-full.ini` → `v2plus.xml` (explicit, ~3.5 hrs, needs `-Xmx8g`)
  - `_build_subset.sh` and `_build_full.sh` wrapper scripts
- Subset build verified: structure link renders, version shows 2026, ~20 min completion

### Current State
- **Branch:** `feature/006-sd-injection`
- **Last commit:** `85246d7 Fix full build: v2plus.xml directories, Varies.json id, domain pages`
- **Pushed:** No — all changes this session are uncommitted
- **Tests:** Not run
- **Build output:** `/workspace/output/` (subset build, verified)

### Uncommitted Changes
- `ig.ini` — now points to `v2plus-subset.xml` (safe default)
- `ig-full.ini` — NEW, points to `v2plus.xml` for full builds
- `input/v2plus.xml` — version `2026`, comments updated to say "FULL build"
- `input/v2plus-subset.xml` — NEW, subset directory paths
- `_build_subset.sh`, `_build_full.sh` — NEW wrapper scripts
- `tooling/scripts/generate_message_pages.py` — `render_segment_table()` replaced with `render_structure_link()`
- `local-template/content/assets/js/v2-classic-tabs.js` — removed Message Structure tab, added Key Elements tab removal
- `local-template/content/assets/css/v2plus.css` — added `.v2-structure-link` styling
- `input/pagecontent/StructureDefinition-ADT-A01-intro.xml` — regenerated with structure link, no classic table div
- `.claude/commands/uadf/` — project-level skill overrides
- `SESSION-HANDOFF.md` — this file

### Next Steps
1. Commit all uncommitted changes
2. Re-run `generate_message_pages.py` (no --subset) to regenerate ALL message intros with structure links instead of classic table divs
3. Run full build to verify all changes at scale (needs explicit request)
4. Set up pytest infrastructure for Python tooling
5. Analyze QA report — now preserved at `output/qa.html` from subset build

### Open Questions / Blockers
- Key Elements tab removal uses `#tabs-key` — verified correct ID from build output but not yet rebuilt with the fix (JS was updated after the build)
- Many untracked files in repo root (screenshots, scratch files, docs) — should be cleaned up or gitignored
