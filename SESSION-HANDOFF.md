# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-09

## ACTIVE: Styling fixes, events page, CI/CD setup

### What Was Built This Session

1. **Blue hyperlink fix** — CSS `a:not([href])` neutralizes IG Publisher's broken self-closing anchors
2. **Heading shift fix** — Changed +2 to +1; IG Publisher expects h3 as top-level pagecontent heading
3. **Events listing page** — `events.xml` with 356 searchable events (code, message, description)
4. **Favicon** — V2+ favicon via `_append.fragment-css.html` override (ico/ dir not merged by IG Publisher)
5. **Image pipeline** — `copy_domain_images()` copies 29 images; strips bad Word-inherited dimensions; CSS max-width
6. **Logo fix** — Scoped image CSS to `#segment-content` only
7. **Control page** — Removed "demo build" text, linked to events page
8. **Message structure formatting** — 2 inline structures wrapped in literal blocks
9. **ig.ini removal** — Renamed to `ig-subset.ini`, added `/ig.ini` to `.gitignore`. Auto-ig-builder is hooked up to the repo; only the build branch should have `ig.ini`.
10. **rsync fix** — Removed blanket `*.png` exclude that was blocking images from syncing to postproc-g

### Commits
- `2f458aef` — Fix blue hyperlinks, clause numbering, image sizing, and add favicon
- `769457d5` — Add events listing page, fix favicon, fix logo sizing, update control page
- `228d5bc6` — Fix rsync excluding all PNG files from remote builds
- `1cb90a97` — Remove ig.ini from tracking to prevent auto-ig-builder triggers

### Next Session: Run Build + Review + Create Build Branch

1. **Rebuild on postproc-g** to verify all fixes (heading numbers, favicon, images, events page, logo sizing)
2. **Create build branch** — branch with `ig.ini` for auto-ig-builder CI/CD; merge from main only
3. **Review heading depth** — h6 ceiling affects deeply nested AsciiDoc content (5+ AsciiDoc levels)
4. **Continue styling** — compare with v2plusDemo
5. **Segment root definitions** — 192 segments with `// TODO:` placeholders

### Key Changes to Build Workflow
- `ig.ini` is gitignored on all branches except the build branch
- Local subset builds: `java -jar input-cache/publisher.jar -ig ig-subset.ini -no-sushi`
- Local full builds: `java -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi`
- Remote builds: `./apptainer/remote-build.sh subset` or `full` (already updated)
- Auto-ig-builder: only triggers on branches that have `ig.ini` at root
