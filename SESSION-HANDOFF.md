# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-02

## ACTIVE: Remote Build Infrastructure + Vocabulary Comparison

### What Was Built This Session

1. **Apptainer container for IG Publisher** — `apptainer/ig-publisher.def`
   - Debian 12, Java 17 (Temurin), Ruby 3.2.6 (compiled from source), Jekyll, Asciidoctor, python-docx
   - Built and tested on NIST's postproc-g.nist.gov (128-core AMD EPYC, 1TB RAM)
   - Bug fixed: `cd /` before `rm -rf /tmp/ruby-build` to prevent `getcwd` error in gem install

2. **Remote build script** — `apptainer/remote-build.sh`
   - Usage: `./apptainer/remote-build.sh {setup|subset|full}`
   - Handles rsync (with `--delete`), remote IG Publisher execution via Apptainer, and output fetch
   - Uses `-tx n/a` to skip terminology server (tx.fhir.org unreachable from NIST network)

3. **Fixed duplicate resource scanning** — Moved 24 parent-level JSON files (profiles, CodeSystems, ValueSets) from resource type parent directories into `input/sourceOfTruth/meta-resources/`
   - Root cause: IG Publisher scans `path-resource` directories non-recursively but listing both parent AND child caused double-loading
   - Both `v2plus.xml` and `v2plus-subset.xml` updated to use explicit child paths + meta-resources

4. **Full build completed on postproc-g** — dramatically faster than container build
   - Output: 28,215 files, 16,021 HTML pages, 8,805 StructureDefinition pages
   - Output synced back to `/workspace/output/` (2.4GB)

### Current State — UNCOMMITTED CHANGES

Important changes need committing:
- `.gitignore` — added `/.ssh-keys/`
- `input/v2plus.xml` and `input/v2plus-subset.xml` — deduplicated scan paths
- 24 JSON files moved from parent dirs → `input/sourceOfTruth/meta-resources/`
- New files: `apptainer/ig-publisher.def`, `apptainer/remote-build.sh`, `apptainer/README.md`
- `.claude-dev/provision.sh` — added SSH key install and python-docx install sections

### Vocabulary Comparison (from previous session, still current)

Three-way comparison complete. Reports at:
- `v291-extracted/vocabulary-comparison-report.html` (1.75MB standalone)
- `v291-extracted/vocabulary-comparison-report.json`
- `v291-extracted/vocabulary-comparison-report.md`
- Scripts: `tooling/scripts/compare_vocabulary.py --utg /workspace/utg`
- HTML generator: `tooling/scripts/generate_html_report.py`

### Key Files

| File | Purpose |
|------|---------|
| `apptainer/ig-publisher.def` | Apptainer container definition |
| `apptainer/remote-build.sh` | One-command remote build on postproc-g |
| `input/sourceOfTruth/meta-resources/` | Moved profiles/CS/VS (24 files) |
| `input/v2plus.xml` | Full build config (deduplicated paths) |
| `input/v2plus-subset.xml` | Subset build config (deduplicated paths) |

### Next Steps

1. **Commit the build infrastructure changes** — the meta-resources move and XML updates are critical
2. **Time the full build on postproc-g** — user didn't independently time it, should measure
3. **Test subset build locally** — verify the v2plus-subset.xml changes work in the container too
4. **Review vocabulary comparison report** — user hasn't reviewed yet
5. **Missing domain pages** — patient-administration.html, observation.html, order-entry.html missing from output (need AsciiDoc preprocessing)

### Remote Build Access

- **Server:** postproc-g.nist.gov (128-core AMD EPYC 7H12, 1TB RAM, 100Gbps)
- **Auth:** Kerberos (gssapi-with-mic) — works from Mac, NOT from container
- **Container image:** `~/ig-publisher.sif` on postproc-g (already built)
- **Project copy:** `~/v2ig/` on postproc-g
- Run builds from Mac host: `cd ~/projects/v2ig && ./apptainer/remote-build.sh full`

### Gotchas

- postproc-g uses Kerberos auth, not SSH keys — can't SSH from container, must use Mac host
- IG Publisher does NOT recurse into subdirectories for `path-resource` — each leaf dir must be listed explicitly
- rsync `--delete` is enabled — stale files on remote get cleaned up automatically
- The `data-type/primitive/primitive-data-type.json` was NOT moved to meta-resources (it was deleted during the move with the others) — verify it's in meta-resources
