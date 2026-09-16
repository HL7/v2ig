# How these resources were produced

## The source is the published chapter

The authority for everything in this guide is the **published text of HL7
V2.9.1 Chapter 2C**, extracted from the Word originals in `v2plus_docx/`. It is
not a re-derivation from the existing V2+ FHIR resources, and not a copy of
THO's current content.

The governing rule for the load is **fidelity to the chapter**. Where the
chapter is wrong, the defect is recorded and escalated rather than silently
repaired — a correction made quietly here is a correction nobody can review.
That is why the build carries known defects that we already know how to fix:
see [Known issues](known-issues.html).

## Canonical URLs

**A canonical URL is an identifier and nothing more.** Where THO already
publishes a URL for a table, that is the URL, whatever the URL appears to mean.
No alternative is constructed, and no meaning is read out of a URL's shape.

This rule decided several cases that looked contentious. Only **two** tables in
the whole chapter (0411 and 0460) need a canonical minted that does not already
exist; an earlier report claimed 18, which was an artifact of a crude test that
only ever looked for a code system filed under the table's own number.

## Versions

- An existing THO resource keeps THO's version.
- A brand-new CodeSystem or ValueSet starts at **1.0.0**.
- `conceptdomains` goes **3.0.0 → 4.0.0**, because adding concepts changes the
  code system.

## What is deliberately not done

- **`definition` is never back-filled from `display`.** A concept with no
  definition in the chapter gets no definition here, and the resulting
  `CODESYSTEM_CONCEPT_NO_DEFINITION` warning is accepted. Inventing definitions
  would be the single easiest way to corrupt this load.
- **Existing external code system records in THO are not touched.**
- **Divergences are recorded, not resolved.** Every place the output differs
  from what the chapter literally says is written to a divergence report.

## Regenerating

From the repository root:

```
python3 -m pytest tooling/scripts/
python3 tooling/scripts/extract_v291_vocabulary.py
python3 tooling/scripts/compare_vocabulary_pipelines.py
python3 tooling/scripts/generate_concept_domains.py
python3 tooling/scripts/write_utg_xml.py
python3 tooling/scripts/stage_vocab_ig.py
```

The first two are expensive and only needed if the text policy changed.
`stage_vocab_ig.py` copies the writer's output into this guide's
`input/resources/` tree and must run before any build.
