# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-07/08

## ACTIVE: Homepage Diagram, Listing Pages with Search, Preprocessing Pipeline

### What Was Built This Session

1. **Homepage layered architecture diagram** — v2plusDemo-style 7-level diagram in `index.xml`
2. **Filterable listing pages** — Data types (12+71), Segments (191), Message Structures (418) with THO-style search
3. **Table filter JS** — `v2-table-filter.js` adapted from THO's `table.js`
4. **Preprocessing on postproc-g** — `tooling/preprocess.sh` runs inside Apptainer container
5. **Build script overhaul** — subset→`output-subset/`, full→`output/`, rsync progress, preprocessing integrated
6. **XHTML fixes** — Strip ER7-induced `<sub>`/`<sup>` tags, XML validation with fallback
7. **Version** — `2026` → `2026.0.0`

### Uncommitted
- 48 modified + 2 new files on `feature/006-sd-injection`
- Full build completed successfully on postproc-g

### Next Session: Review Build Output + Commit

1. **Review the rendered output** — index page diagram, listing pages, domain pages
2. **Commit and push** all changes
3. **Fix 15 domain .adoc files** with ER7 outside code blocks (content currently stripped)
4. **Continue styling** — further alignment with v2plusDemo

### Key Files

| File | Purpose |
|------|---------|
| `input/pagecontent/index.xml` | Homepage with layered architecture diagram |
| `input/pagecontent/data-types.xml` | Data types listing with filter |
| `input/pagecontent/segment-definitions.xml` | Segments listing with filter |
| `input/pagecontent/message-structures.xml` | Message structures listing with filter |
| `local-template/content/assets/js/v2-table-filter.js` | Table filter JS |
| `local-template/content/assets/css/v2plus.css` | V2+ styles including diagram CSS |
| `tooling/preprocess.sh` | Standalone preprocessing script (CI/CD ready) |
| `apptainer/remote-build.sh` | Remote build orchestration |
