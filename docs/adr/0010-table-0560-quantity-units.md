# ADR-0010: Table 0560 (Quantity Units) — Publish the Code System the Chapter Says Does Not Exist

## Status

Accepted

## Date

2026-09-17

## Context

ADR-0008 disposed of seven tables whose grid was empty or contradictory. One
row of that table reads `0560 Quantity Units | Concept domain only`, and the
rule behind it was mechanical: Chapter 2C gives 0560 a Code System
Identification block whose symbolic name is the `noObject` placeholder, so
there is no code system, so nothing is written but a concept domain.

Two tables carry that placeholder — 0560 and 0910 — and the rule was applied to
both. For 0910 it is correct. For 0560 it produced an output in which the
table's five codes and its value set both disappear, and the pipeline writes
nothing at all for a table that HL7 has published codes for since v2.6.

Reading the chapter's 0560 section in full rather than reading only the
placeholder:

| What the section carries | Value |
|---|---|
| Code System symbolic name | `noObject` |
| Code System OID | `-` |
| Code System description | `noDescription` |
| Code System full name | **"Name Representation Code System"** — belongs to a different table |
| Coded content | **five codes**: `FL` Units, `HS` Hours, `DY` Days, `MN` Month, `YY` Years |
| Value Set OID | `2.16.840.1.113883.21.380` |
| Value Set symbolic name | `hl7VS-quantityUnits` |
| Value Set content logical definition | `all codes` |
| Table metadata description | "Table of codes that specify the adjustment quantity. **No suggested values.**" |
| Table OID | `2.16.840.1.113883.12.560` |
| Where used | `ADJ-6` |

The section contradicts itself at least three ways. It says there is no code
system while listing five codes. It says "no suggested values" while listing
five values. It names the code system after a different table.

And THO already publishes both artifacts:

| | Canonical | OID | Version |
|---|---|---|---|
| CodeSystem | `http://terminology.hl7.org/CodeSystem/v2-0560` | `2.16.840.1.113883.18.455` | 3.0.0 |
| ValueSet | `http://terminology.hl7.org/ValueSet/v2-0560` | `2.16.840.1.113883.21.380` | 3.0.0 |

THO's code system carries the same five codes with the same displays. Its OID
is in the v2 code system arc `2.16.840.1.113883.18.*`, which is where a v2
table's code system belongs. Its value set OID is *exactly* the one the chapter
prints. The value set composes the whole of the code system, which is what the
chapter's `all codes` says.

So four independent sources — the chapter's codes, the chapter's value set OID,
the chapter's content logical definition, and THO's existing pair — agree with
each other. Only the placeholder disagrees with all of them.

## Decision

**Publish table 0560 as the chapter's content describes it: a CodeSystem at
`http://terminology.hl7.org/CodeSystem/v2-0560` carrying the five codes, and a
ValueSet at `http://terminology.hl7.org/ValueSet/v2-0560` composing all of it.**

The `noObject` marker is treated as a defect in the published chapter rather
than as a statement about the table.

**The rule is written on evidence, not on the table number.** The placeholder
still means what it says, unless all three of the following hold:

1. the chapter lists coded content underneath it,
2. THO publishes a CodeSystem at the table's own canonical, and
3. the chapter declares a value set.

0560 is the only table in the corpus that satisfies them. 0910 satisfies none:
it has no codes and THO has no code system for it, so it stays
concept-domain-only. Writing the rule this way rather than special-casing a
number means a table that develops the same defect is caught, and a table that
is genuinely domain-only is not.

**Name, title and OID come from THO**, because the chapter supplies only
placeholders for all three — `noObject`, `noObject` and `-`. Under the additive
merge (ADR-0009) a placeholder is not content, so THO's `QuantityUnits`,
`Quantity Units` and `2.16.840.1.113883.18.455` stand. Publishing without the
OID would have been *removing* an identifier, which the versioning policy says
requires a new artifact rather than a new version.

**The five definitions are not taken from THO**, because THO defines all five
as the literal string `"no definition"`. That is a placeholder too, and
publishing it as a definition would be worse than leaving the element out.

**The contradiction stays visible in the guide itself**, not only in the
escalation register: it is question 6 on the `general-questions.html` page,
with the chapter's own words quoted, so that anyone reading the guide sees the
problem and what was done about it. The remedy we would prefer — a corrected
0560 section in the chapter — is stated there too.

## Alternatives considered

**Leave it concept-domain-only.** Rejected. It is the status quo and it loses
five published codes and a value set with a registered OID, on the strength of
a marker that four other signals contradict. It also leaves this guide silent
about a table THO publishes, with no reason a reader could evaluate.

**Publish only the ValueSet, composed over THO's code system.** This is the
shape used for tables whose code system genuinely belongs to somebody else
(UCUM, LOINC, a v3 system). Rejected here because the code system does *not*
belong to somebody else: its OID is in the v2 arc and its canonical is this
table's own. Writing only a value set would imply a foreign owner that does not
exist.

**Special-case the table number.** Rejected. `if table == "0560"` records the
conclusion and throws away the reasoning; the next person cannot tell whether
it was a finding or a hack, and a second table with the same defect would be
missed.

**Correct the chapter's other 0560 defects too** — the "No suggested values"
note and the wrong code system name. Rejected: those are not needed to produce
the artifacts, and the workstream's rule is that errors in the published
chapter are reproduced rather than corrected. Overriding the placeholder is the
minimum needed to stop losing content; going further would prejudge questions
that belong to V2 Management.

## Consequences

- Table 0560 gains a CodeSystem and a ValueSet in this guide. The code system
  increments to 4.0.0; the value set matches THO and keeps 3.0.0.
- The count of tables where THO publishes a code system and this guide does not
  drops from 21 to 20.
- ADR-0008's row `0560 Quantity Units | Concept domain only` is superseded.
  ADR-0008 is not edited — it records what was decided at the time — and the
  live behaviour is here.
- The chapter's contradiction is now visible to every reader of the guide
  rather than only to us, which is the point: a reader who knows table 0560 and
  finds it missing has no way to tell a decision from a bug.
- If V2 Management rules that the placeholder is authoritative and the five
  codes should not be published, the change is the three-part condition in
  `classify` and nothing else.

## Related

- **ADR-0008** — the section on tables with an empty grid, whose 0560 row this
  supersedes.
- **ADR-0009** — the additive merge, which supplies 0560's name, title and OID
  and which sets the placeholder rule this relies on.
- `tooling/scripts/write_utg_xml.py`, `classify()`
- `vocab-ig/input/pagecontent/general-questions.md`, question 6
