# Session Handoff

> This file is overwritten each session. For stable project knowledge, see MEMORY.md (auto-loaded).
> For full project history, see JOURNAL.md.

## Last Session: 2026-04-09

## ACTIVE: Styling fixes, events page, favicon, heading numbering

### What Was Built This Session

1. **Blue hyperlink fix** — CSS `a:not([href])` neutralizes IG Publisher's broken self-closing anchors
2. **Heading shift fix** — Changed +2 to +1; IG Publisher expects h3 as top-level pagecontent heading
3. **Events listing page** — `events.xml` with 356 searchable events (code, message, description)
4. **Favicon** — V2+ favicon via `_append.fragment-css.html` override (ico/ dir not merged by IG Publisher)
5. **Image pipeline** — `copy_domain_images()` copies 29 images; strips bad Word-inherited dimensions; CSS max-width
6. **Logo fix** — Scoped image CSS to `#segment-content` only
7. **Control page** — Removed "demo build" text, linked to events page
8. **Message structure formatting** — 2 inline structures wrapped in literal blocks

### Commits
- `2f458aef` — Fix blue hyperlinks, clause numbering, image sizing, and add favicon
- `769457d5` — Add events listing page, fix favicon, fix logo sizing, update control page

### Next Session: Run Build + Review

1. **Rebuild** to verify all fixes (heading numbers, favicon, images, events page)
2. **Review heading depth** — h6 ceiling affects deeply nested AsciiDoc content
3. **Continue styling** — compare with v2plusDemo
4. **Segment root definitions** — 192 segments with `// TODO:` placeholders
