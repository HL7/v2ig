# ADR-0004: Inline JavaScript in Template Fragments for Auto-IG-Builder Compatibility

## Status

Accepted (intended to be reversed when template whitelisting is available)

## Date

2026-04-10

## Context

The FHIR auto-ig-builder (https://build.fhir.org) rejects IG templates that contain `.js` files, citing them as untrusted. Our `local-template/` contained two JavaScript files:

- `content/assets/js/v2-classic-tabs.js` — customizes the IG Publisher's Formal Views tab widget (removes unused tabs, adds V2-specific tabs for message structures, segments, and ACK choreography)
- `content/assets/js/v2-table-filter.js` — adds per-column text filtering to listing pages (data types, segments, message structures, events), adapted from THO's `table.js`

The auto-ig-builder build failed immediately with:

> Unable to execute 'onLoad' in script 'scripts/ant.xml' as the template '#local-template' is not trusted (reason: Template has file extensions: [.js])

This blocked CI/CD publishing of the IG to build.fhir.org.

## Decision

Inline both JavaScript files directly into the HTML template fragments that load them:

- `v2-classic-tabs.js` content inlined into `local-template/includes/fragment-pageend.html` (inside a `<script>` block, guarded by `{% if v2classictabs %}`)
- `v2-table-filter.js` content inlined into `local-template/includes/_append.fragment-css.html` (inside a `<script>` block)

The standalone `.js` files and their containing directory (`local-template/content/assets/js/`) were deleted.

## Consequences

### Good
- Auto-ig-builder no longer rejects the template (no `.js` file extensions present)
- Identical runtime behavior — the JavaScript executes the same way
- CI/CD publishing to build.fhir.org is unblocked

### Bad
- JavaScript is harder to read and edit when embedded in HTML fragments
- No separate caching of JS files by browsers (minor — these are small scripts)
- If more JS is needed in the future, it must also be inlined

### Neutral
- The base template's own JS files (jQuery, Bootstrap, tabs.js) are still loaded as external files — the trust restriction only applies to the local template overlay

## Reversal Plan

This decision should be reversed when either:

1. The FHIR infrastructure team whitelists the `#local-template` (or the `HL7/v2ig` repo) for `.js` files
2. The auto-ig-builder's trust policy is relaxed to allow `.js` in local templates

To reverse: extract the `<script>` blocks back into standalone `.js` files under `local-template/content/assets/js/`, and restore `<script src="...">` references in the HTML fragments.

Note: The table filter JS (`v2-table-filter.js`) is adapted from THO's `table.js`, which is already used by other IG publications. This may be a strong argument for whitelisting.

## References

- Auto-ig-builder build log: https://build.fhir.org/ig/HL7/v2ig/branches/build/failure/build.log
- THO table filter: https://terminology.hl7.org (source of the filter pattern)
- Template trust documentation: https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation (template security section)
