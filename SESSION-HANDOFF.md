# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-10

## ACTIVE: Segment styling, element ID rename, build infrastructure

### What Was Done This Session

1. **Auto-ig-builder fix** — Inlined JS into HTML fragments (ADR-0004) to bypass template trust rejection
2. **Message structure titles** — Fixed 418 files from "Segment Definition" → "Message Structure"
3. **Classic bracket tab restored** — On message structure pages (not message pages)
4. **HL7 Attribute Table styled** — v2plusDemo-style: row banding, Verdana, item# links to Detailed Descriptions tab
5. **CamelCase element IDs** — 2,912 IDs renamed (e.g., `OBX.1` → `OBX.1-setId`); OM1.56 manually shortened for 64-char limit
6. **Build branch cleaned** — 5,283 dev files removed from tracking
7. **push-to-build.sh reworked** — Copies from main (no merge), no `--branch` flag

### Current State
- Branch: `dev/framework` at `cf63fd70` (5 commits ahead of origin, not pushed)
- `build` branch: cleaned, user running postproc-g build to verify OM1.56 fix
- **Not yet merged to main**

### Next Session Priority

1. **Check postproc-g build results** — did the OM1.56 fix resolve the snapshot error?
2. **Review output** — camelCase names in differential tables, attribute table styling, classic tab
3. **Merge `dev/framework` → `main`** once build verified
4. **Run `./push-to-build.sh`** to trigger auto-ig-builder (test inlined JS fix)
5. **Heading depth**, **segment root definitions**, **further styling**

### Key Workflow
- Development: `dev/framework` (or topic branches from `main`)
- Publishing: `./push-to-build.sh` (always pulls from `main` → `build`)
- `ig.ini` only exists on `build` branch — gitignored everywhere else
- Local subset builds: `java -jar input-cache/publisher.jar -ig ig-subset.ini -no-sushi`
- Remote builds: `./apptainer/remote-build.sh subset` or `full`
