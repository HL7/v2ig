# HL7 V2+ Vocabulary — Chapter 2C

This guide carries the code tables of **HL7 V2.9.1 Chapter 2C** as FHIR R5
terminology resources: **398 CodeSystems**, **422 ValueSets**, and an extended
`conceptdomains` CodeSystem.

> **This is a draft for committee review, not a publication.** It exists so
> that V2 Management, UTG and TSMG can see the resources before they are loaded
> into THO. Nothing here is a proposal to publish at these URLs today.

## What you are looking at

Every resource is authored at **its canonical URL on `terminology.hl7.org`** —
the URL THO already uses where THO already publishes the table, rather than a
new URL minted under this guide. That is the whole point of the build: to show
these resources sitting at the identifiers they would really occupy, and to
find out what collides.

Of the 799 tables in the chapter:

| Route | Tables | What was written |
|---|---|---|
| Code system and value set | 398 | Both, at the table's own THO canonical |
| Concept domain only | 360 | No resource — the table names a domain, not a code set |
| Value set only | 24 | The codes belong to another authority; only the value set is ours |
| Needs a decision | 14 | Nothing written — see [Known issues](known-issues.html) |
| Nothing to write | 3 | Tables 0010, 0188 and 9999 |

## Concept domains

`CodeSystem/conceptdomains` here is **version 4.0.0: THO's published 3.0.0 with
177 concepts added and none removed.** Chapter 2C declares concept domains that
THO does not yet carry; those are appended as new top-level concepts marked
`source: v2`. Every concept THO publishes survives unchanged, with its
hierarchy, definitions and properties intact.

This matters because the resource sits at THO's own canonical URL. A resource
at that URL that carried *fewer* concepts than THO publishes would destructively
redefine a code system this project does not own. Where Chapter 2C and THO
describe the same domain differently, **THO's definition wins and the
difference is recorded** rather than quietly resolved.

## Where to go next

- **[Artifacts](artifacts.html)** — every code system and value set in the build
- **[How these resources were produced](provenance.html)** — the pipeline, and what is authoritative
- **[Known issues in this build](known-issues.html)** — read before filing anything
