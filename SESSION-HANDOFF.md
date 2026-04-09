# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-09

## ACTIVE: Build branch CI/CD, branch reorganization

### What Was Built This Session

1. **`build` branch** — dedicated branch for auto-ig-builder with `ig.ini` (full build config)
2. **Full preprocessing committed to `build`** — 190 segments, 368 messages, 417 structures, 31 domain pages
3. **`push-to-build.sh`** — turnkey merge→preprocess→commit→push script
4. **`preprocess-fetch` mode** in `remote-build.sh` — preprocess on postproc-g, fetch results back
5. **Merged `feature/006-sd-injection` → `main`** — fast-forward, rollback point `9b99f931`
6. **Created `dev/framework`** — new development branch for framework/tooling work

### Commits
- `057d968d` — Add push-to-build.sh and remote preprocess-fetch mode
- Build branch: `2e5f7cf0` (ig.ini), `99182522` (preprocessed content)

### Next Session: Check Build + Continue Development

1. **Check auto-ig-builder** — `https://build.fhir.org/ig/HL7/v2ig/branches/build/`
2. **Rebuild on postproc-g** to verify all prior session fixes
3. **Heading depth**, **styling**, **segment root definitions**
4. **Clean up** `feature/006-sd-injection` branch (now merged)

### Key Workflow
- Development: `dev/framework` (or topic branches from `main`)
- Publishing: `./push-to-build.sh` (or `./push-to-build.sh --remote`)
- `ig.ini` only exists on `build` branch — gitignored everywhere else
- Local subset builds: `java -jar input-cache/publisher.jar -ig ig-subset.ini -no-sushi`
- Local full builds: `java -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi`
- Remote builds: `./apptainer/remote-build.sh subset` or `full`
