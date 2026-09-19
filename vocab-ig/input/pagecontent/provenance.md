### The source is the published chapter

The authority for everything in this guide is the **published text of HL7
V2.9.1 Chapter 2C**, extracted from the Word originals. It is not a
re-derivation from the existing V2+ FHIR resources.

The chapter is not the only content in these resources, because each one is
published at **THO's own canonical URL**. Where THO already carries something
the chapter says nothing about — a concept definition, a translation, a
comment, a usage note, a code, an OID — THO's content is kept, because an
artifact published at THO's canonical with less in it than THO publishes would
delete content from the artifact that URL names. **7,575** pieces of THO
content are kept on that rule. Where the chapter and THO both say something and
the two differ, **the chapter wins** and the disagreement is recorded. The one
exception is the identifier: an identifier is identity rather than content, so
where the two give different OIDs THO's is published and the conflict is
referred for adjudication. [What this guide keeps from THO](tho-merge.html)
reports every case.

The governing rule for the load is **fidelity to the chapter**. Where the
chapter is wrong, the defect is recorded and escalated rather than silently
repaired — a correction made quietly here is a correction nobody can review.
That is why the build carries defects whose repair is already understood: see
[Known issues](known-issues.html).

### Canonical URLs

**A canonical URL is an identifier and nothing more.** Where THO already
publishes a URL for a table, that is the URL, whatever the URL appears to mean.
No alternative is constructed, and no meaning is read out of a URL's shape.

Only **two** tables in the whole chapter (0411 and 0460) need a canonical
minted that does not already exist.

### Versions

- An existing THO resource keeps THO's version.
- A brand-new CodeSystem or ValueSet starts at **1.0.0**.
- `conceptdomains` goes **3.0.0 → 4.0.0**, because adding concepts changes the
  code system.

### What is deliberately not done

- **`definition` is never back-filled from `display`.** A concept with no
  definition in either the chapter or THO gets no definition here, and the
  resulting `CODESYSTEM_CONCEPT_NO_DEFINITION` warning from the IG Publisher is
  accepted.
- **Existing external code system records in THO are not touched.**
- **Divergences are recorded, not resolved.** Where the output differs from
  what the chapter literally says, the difference is recorded rather than
  absorbed.

### Generated, not hand-maintained

The resources in this guide are generated rather than hand-maintained: the
whole corpus is rebuilt from the chapter's text and THO's published content on
every run, so the same inputs always produce the same output.
