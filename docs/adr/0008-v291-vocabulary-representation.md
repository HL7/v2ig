# ADR-0008: FHIR Representation of the V2.9.1 Chapter 2C Vocabulary

## Status

Proposed — decided in batches. Batch A is open; later batches are listed but
not yet decided. This ADR is updated as each batch is settled, and moves to
Accepted when all batches are closed.

## Date

2026-08-18 (opened)

## Context

Chapter 2C of HL7 V2.9.1 is the standard's code table chapter: 799 sections,
each with up to seven sub-tables (Concept Domain, Code System Identification,
Code System Version, Value Set, Binding, Table Metadata, Coded Content) and
5,540 codes in total. The goal is a FHIR IG that carries this content
faithfully — "exactly what is in the published Chapter 2C" — as CodeSystem and
ValueSet resources, plus a single CodeSystem covering the concept domains.

Two constraints shape everything here.

**Fidelity is the governing requirement.** The only automatic change permitted
is fixing very obvious typographic defects, principally leading and trailing
whitespace. Every divergence from the published value — whether a change that
was made or an irregularity that was deliberately left alone — must be recorded
for human review rather than resolved silently. This is the same principle
ADR-0006 established for the structural chapters, applied to vocabulary.

**Most of this content already exists in THO.** `hl7.terminology.r5` v7.3.0
publishes 418 v2 CodeSystems, 440 v2 ValueSets, and a concept domains
CodeSystem with 1,345 concepts. Re-minting canonical URLs for content THO
already owns would fragment the terminology ecosystem, so canonical URLs are
reused wherever THO has them.

### What is already established

Settled before this ADR was opened, and recorded here because later decisions
depend on them:

- The vocabulary IG is a **separate IG**, not additional resources inside the
  existing structural IG.
- Canonical URLs are **reused from THO** wherever THO publishes an equivalent
  resource. 397 of the 415 code-bearing tables are covered; 18 are not.
- Extraction fidelity is assured by **dual-pipeline cross-validation**
  (python-docx and LLM), per ADR-0006. 739 of 799 tables agree in every
  compared field; the LLM's only systematic infidelities are typographic
  substitution and intermittent truncation at a literal double quote, so
  **python-docx is the character-faithful source** and the LLM provides
  structural corroboration.
- Divergences are tracked through the existing **`review_registry.py`**
  machinery, with the same escalate-to-V2-management path.

## Decisions

### D1 — Concept domains extend THO's CodeSystem rather than replacing it

**Decided 2026-08-18.**

Chapter 2C declares 760 distinct concept domains. THO's
`CodeSystem/conceptdomains` already publishes 582 of them; 177 are absent, and
those are overwhelmingly from concept-domain-only tables.

The generated resource keeps THO's canonical URL
(`http://terminology.hl7.org/CodeSystem/conceptdomains`), carries every THO
concept through unchanged with its hierarchy and properties, and appends the
177 Chapter 2C additions as new top-level concepts marked `source: v2` —
THO's own convention for v2-derived domains. Output: 1,522 concepts.

**Why a superset and not just Chapter 2C's 760.** Publishing a *subset* at
another body's canonical URL would destructively redefine a code system this
project does not own: a server loading both packages would see concepts
disappear. A superset is the only shape that is safe at that URL.

**Why THO's definitions win on conflict.** For the 582 shared domains, 577
definitions match Chapter 2C exactly. Only 5 differ, so deferring to THO costs
almost nothing in fidelity while keeping one coherent code system. All 5 are
recorded for review and can be flipped individually.

**Versioning.** Adding concepts changes the code system, so the major version
increments and minor and patch reset: THO ships 3.0.0, this publishes **4.0.0**.
That is standard terminology versioning practice and needs no special handling.

**Authority.** This is not a coordination risk. The project lead is a UTG
maintainer and a member of the HL7 Terminology Services Management Group, and
has the authority to extend this code system.

**Consequences.**
- The output carries v3- and CDA-sourced concepts that are outside Chapter
  2C's scope. That is inherent to extending rather than forking, and is the
  correct trade against fragmenting the concept domain namespace.
- Downstream consumers resolving `CodeSystem/conceptdomains` will get 4.0.0
  from this IG and 3.0.0 from `hl7.terminology.r5`. Normal version resolution
  handles that; it is worth being deliberate about which the IG pins.
- A CodeSystem **supplement** is *not* an available alternative here.
  Supplements may add properties and designations to an existing code system;
  they may not add concepts. The real alternatives, should the extension ever
  be unwound, are folding the 177 into THO upstream, or a separate code system
  under this project's own canonical.

### D2 — Only obvious typographic defects are corrected automatically

**Decided 2026-08-17.**

Leading and trailing whitespace is stripped; everything else is preserved
exactly as published and merely reported. Internal double spaces (1,052),
embedded newlines (223) and non-breaking spaces (8) are left intact.

**Why.** "Obvious typo" is a narrow licence. Stripping surrounding whitespace
cannot change meaning; collapsing an internal double space inside a display
name changes a published value. The conservative default is reversible — a
reviewer can promote any recorded group to a correction later — whereas silent
normalization is not, because the evidence is gone.

Deviations are grouped by kind and by the field they occur in, so a group of
375 identical double spaces in one field is one decision rather than 375.

**Amended by D3, D4, D5, D6 and D7**, which promote further groups to automatic
corrections. The principle is unchanged: each promotion was a reviewer's
decision, taken group by group from the review report, not a rule the extractor
applied on its own. D6 goes further than the others and edits prose rather than
whitespace, and D7 repairs corrupt characters in any field including
identifiers; the reasoning for allowing each is set out there.

As of D7 the counts in the paragraph above are historical: no internal double
space remains, and the eight non-breaking spaces turned out to be six that D2's
strip had already removed plus two in prose that D7 now handles.

### D3 — Spaces after a period are collapsed, in descriptive text only

**Decided 2026-08-18.**

In fields carrying descriptive prose — `Description` in all four metadata
blocks, and `definition`, `comment` and `displayName` in coded content — a run
of two or more ordinary spaces immediately following a period is collapsed to a
single space. 890 values changed, 1,089 runs collapsed, across 537 of the 799
tables.

**Why this group and not the others.** D2 left every internal double space
alone because collapsing one inside a display name would change a published
value. The space *after a sentence-ending period* is the one case where that
risk does not arise: double-spacing after a full stop is a typesetting
convention of the era the document was written in, not content, and no reader
or consumer of the resource can distinguish the two renderings. The remaining
228 values are a different question — a double space between two words
mid-sentence, or after a hyphen used as a separator, may well be a defect but
it is not the same defect, and each group is decided on its own.

**Why scoped to descriptive fields.** In an identifier, a code, a URI or a
value set expression, a period is part of the value rather than punctuation.
Restricting the rule to prose keeps it to the case where the reasoning above
actually holds.

**Why only the ordinary space character.** A tab, a newline or a non-breaking
space after a period is a distinct irregularity with its own tracking group.
Folding them in would resolve three questions under the authority of one
decision.

**Consequences.**

- The rule lives in `tooling/scripts/vocabulary_text_policy.py`, not in the
  extractor, because the python-docx-vs-LLM comparison has to apply the same
  policy to both corpuses. Without that, our own deliberate normalization would
  be reported as a disagreement between the pipelines. Cross-pipeline agreement
  is unchanged at 739/799 tables; the 851 values the policy absorbs are counted
  and stated in the comparison report.
- One concept definition in `CodeSystem-conceptdomains.json` changed. The other
  129 changed concept domain descriptions had no effect, because under D1 THO's
  definitions win for the domains THO already publishes.
- Six sentence ends were **not** caught, because a closing quote or bracket sits
  between the period and the spaces (`."  `, `.)  `). **Superseded by D4**,
  which covers them.
- Every change is recorded per value in `vocabulary-deviations.json` under kind
  `double_space_after_period`, so the whole group is reversible.

### D4 — Three further collapses: sentence closers, commas, display names

**Decided 2026-08-18.**

Three groups from the review report were promoted to automatic corrections in
one sitting, because they are variations on the same judgement D3 made.

**Spaces after a sentence that ends in a closing quote or bracket.** D3's rule
required the period to sit immediately before the spaces, so `"levels."  Level
I` and `(e.g., cannulas.)  Dispose` were missed. The closers `"` `'` `’` `”`
`)` `]` are now allowed between the period and the spaces. 6 values. The two
bracket cases are genuine sentence boundaries — the period closes a
parenthetical and the next sentence begins — which is why brackets are included
and not only quote marks.

**Spaces after a comma.** The same reasoning as after a period: the space
following a comma is presentation. 10 values.

**Every repeated space in a code display name.** In `displayName` only, any run
of two or more spaces collapses, wherever it sits. 66 values across 12 tables.

*Why display names and nothing else.* A display name is a short label rather
than prose, so no run of repeated spaces in one can be carrying meaning. That
argument does not extend to a multi-sentence description, where a double space
between two words might be evidence of something a reviewer should see — which
is why the equivalent runs in `Description`, `definition` and `comment` remain
outstanding.

**Consequences.**

- `codedContent.displayName` no longer appears in the outstanding double-space
  group at all. The remaining 143 values are all prose fields.
- Rules run in order, and each change is attributed to the most specific rule
  that fired. Eight display-name values were already resolved by the period,
  sentence-close or comma rules, which is why the display-name sweep reports 66
  rather than 74.

### D5 — A separator dash gets one space on each side; spacing is adjusted, never inserted

**Decided 2026-08-18.**

Where a dash is used as a separator it gets exactly one space on each side. 16
values, 18 places.

The rule **adjusts** the spacing around a dash and never **inserts** space
around a dash that has none on either side.

**Why that constraint is the whole decision.** 1,843 of the 2,516 dashes in
Chapter 2C prose have no space on either side, and essentially all of them are
part of a value rather than punctuation: `HL7-defined` (387 times), `ICD-10`,
`UB-04`, `de-identified`, V2's own field references `OBR-32`, and URL path
segments such as `CFR-2017-title45-vol1`. A rule that put a space around every
dash would corrupt all of them. Restricting the rule to dashes that already
have whitespace on at least one side means it can only ever tidy something that
is already being used as a separator.

Even so, five further exclusions were needed, each drawn from a real pattern in
the chapter, and each expressed structurally rather than as a list of table
numbers:

| Excluded | Example |
|---|---|
| Followed by a digit | `Deep frozen: -16 to -20( C.` — a minus sign |
| Preceded by `+` or `/` | `approximately 22 +/- 2 degrees C` |
| Followed by a conjunction | `OPS Operationen- und Prozedurenschlussel` — a suspended hyphen |
| At the start or end of a line | `Share To Be Determined -⏎Category to be determined` |
| Followed by punctuation | `Default -.will be assumed` |
| `X -y` with a lowercase follower | `Message is not -conformant`, `Emergency -stop` |

The last of these was added after the rule was first run: every genuine
separator in Chapter 2C introduces a capitalised phrase or a digit
(`RSP -Dispense`, `4 -Deprecated`), so a lowercase follower joined to the dash
means the hyphen belongs to that word. Spacing those two out would have made
the published defect worse rather than better.

**Consequences.**

- The dash characters themselves are never changed. An en dash stays an en
  dash, and the four values reading `Results entered -- not verified` keep both
  hyphens; only the surrounding spaces move. Changing a dash run's length or
  character would be a typographic decision, not a whitespace one.
- Three published defects survive into the output unchanged and are recorded in
  the outstanding section of the change log: tables 0357, 0368 and 0919.

### D6 — The missing comma after "e.g." and "i.e." is inserted

**Decided 2026-08-18.**

60 values, 62 places, across 27 tables.

This is the **first rule that adds a character** rather than adjusting
whitespace, which puts it in a different class from D2–D5: those cannot change
what a value says, and this one edits the published prose. It is admitted
because the omission is unambiguous — 172 sites in the same chapter already
carry the comma, so the chapter's own convention decides the question — and it
is kept deliberately narrow to match.

**Scope.** Fires only where the abbreviation is followed by a space. That
excludes the sites that are already correct and the five where a colon
introduces a bullet list (`e.g.:` in tables 0965–0969), where a comma would
produce `e.g.,:`. The capitalised sentence-initial forms `E.g.` and `I.e.` are
included — the same defect — and the replacement keeps whichever case was
published.

**Consequences.**

- Because this rule changes characters rather than spacing, it broke the
  concept domain comparison against THO: 6 domains suddenly differed from THO
  by nothing but a comma we had inserted, inflating
  `definition_differs_from_tho` from 5 to 11. `generate_concept_domains.py` now
  applies the shared policy to THO's text before comparing, the same both-sides
  principle the cross-pipeline comparison uses. Back to 5 genuine differences.
- Every comparison in this project now has to be asked the same question: is
  the other side of the comparison subject to the same policy? Whitespace-only
  rules were forgiving because most comparisons already fold whitespace; a
  character-level rule is not.
- The rule is the natural precedent for any future prose correction, and the
  bar it sets is the one to hold: an unambiguous omission, with the chapter's
  own overwhelming majority usage as the authority.

### D7 — Every remaining run of spaces collapses, and three corrupt characters are repaired

**Decided 2026-08-18.**

Six rules, decided together because they are the remainder of one question.
After D7 **no run of two or more spaces survives anywhere in the corpus** apart
from the single ditto mark the reviewer chose to keep. 148 values changed
across 163 places; see change 007 in the change log for the per-rule counts.

| Rule | What it does | Values |
|---|---|---:|
| Stray `Â` before a space | Deletes the letter left by a doubly-encoded non-breaking space | 1 |
| Private-use-area character | Deletes Symbol-font glyphs, keeping the tab after them | 1 |
| Non-breaking space in text | A run becomes one ordinary space | 2 |
| Line-initial indent | Kept, at a consistent two spaces | 2 |
| Remaining runs of spaces | Collapse to one | 141 |
| Ditto mark | Preserved | 1 (unchanged) |

**Why the general collapse is now admissible when D2 refused it.** D2's
objection was that collapsing a run inside a display name changes a published
value. D3 and D4 chipped away at that by finding cases where the run is
demonstrably presentation. What is left after those is 141 values, and the
reviewer went through them field by field rather than approving the group as
one: `codedContent.comment`, `codeSystem.Description`,
`tableMetadata.Description`, `codedContent.definition`,
`conceptDomain.Description` and `valueSet.Description` were each decided
separately, and the two non-prose fields below on their own evidence. The
outcome happened to be the same for all of them, but the reasoning was not one
sweep.

**Why two non-prose fields are in scope, and only for this rule.**
`tableMetadata.where used` carries `SPM-15, SAC-43,  PAC-7, OM4-15` — a run
after a comma in a reference list, which is presentation for the same reason it
is in prose. `valueSet.Content Logical Definition` carries
`http://snomed.info/sct   where concept is-a 49062001`. Neither is added to
`DESCRIPTIVE_FIELDS`, because the prose rules — the comma after `e.g.`, dash
spacing — must not edit a reference list or a value set expression.

**Why an indent is kept rather than collapsed.** A run of spaces at the start
of a line is doing something: table 0396 uses it to indent a list of NCPDP code
sets under an introductory sentence. Removing it would destroy structure.
Leaving it at whatever width was typed keeps typesetting noise. Two spaces is
the compromise, and it is the same judgement D3 made about the space after a
period — the shape is meaningful, the exact width is not.

**Why a ditto mark is not a run of spaces.** Table 0496 code `028` publishes
`""      "" w/o Surgery Capability`. The spaces between the two pairs of quote
marks are standing in for the entry above; they are the value, not spacing
around it. The exclusion is expressed structurally — a run with a quote mark
immediately on both sides — and corpus-wide it fires exactly once, which is the
evidence that it is narrow enough. Expressing it as "table 0496" would not
survive a change to the source.

**Why the character repairs are not confined to prose.** A Symbol-font glyph or
a doubly-encoded byte pair is wrong wherever it lands, including in an
identifier. This is the first pair of rules in the policy with no field
restriction at all, and the distinction that justifies it is between *repairing
corruption* and *adjusting presentation*: the fidelity argument for preserving
published text does not extend to characters that are an artifact of how the
file was written rather than anything an author typed.

**Consequences.**

- **The `Â` rule had to be widened after its first run, for a reason worth
  keeping.** It originally matched `Â` followed by a non-breaking space, which
  is what python-docx sees. The LLM extraction of the same cell substitutes an
  ASCII space, so the rule repaired one corpus and not the other, and the
  comparison duly reported our own rule as a pipeline disagreement. It now
  matches either. This is the second time D6's lesson has bitten: **any rule
  that edits characters must be checked against both corpuses**, because the
  comparison applies the policy to both.
- **Dash spacing was moved ahead of the general collapse.** It is the more
  specific rule, and running the collapse first silently absorbed five of its
  changes into D7's count. Noticed because each rule reports its own count and
  D5's fell from 16 to 11.
- **A reporting defect was found and fixed.** Six of the eight non-breaking
  spaces were leading or trailing and had been removed by D2's strip all along,
  but the review report showed them as `preserved`, with a note that the four
  in `codeSystem.URL` were "the ones that matter". They were the ones that did
  not. The extractor now distinguishes a non-breaking space that survived into
  the emitted value from one that was already removed.
- **A new outstanding group: a space before the punctuation that closes a
  clause**, 20 places. Nineteen are published as printed; one, in table 0827,
  is ours — turning a non-breaking space into an ordinary one left `(M49) .`
  Deleting a non-breaking space that sits immediately before sentence
  punctuation, instead of spacing it, would give `(M49).` and is probably
  right, but that is a different decision and is asked rather than assumed.
- **Cross-pipeline agreement rose from 739 to 740 of 799 tables.** Table 0964's
  disagreement disappeared: the Symbol glyphs were python-docx's to lose, and
  removing them makes the two corpuses identical there.
  `CodeSystem-conceptdomains.json` is byte-identical.
- **A character inventory is now part of the review report.** Every non-ASCII
  character in the emitted corpus, counted, with a verdict. The `Â` was found
  by a one-off scan; making the scan permanent means the next one is found the
  same way rather than by eye. Two characters currently have no verdict: `Ø`
  (NCPDP's slashed zero, 8 places) and `‑` (a non-breaking hyphen, 4 places).

### D8 — Table 0227 (MVX) maps to an external metadata record

**Decided 2026-08-18.**

MVX is maintained by the CDC, not HL7, so table 0227 is not an HL7 code system
and should not be published as a `CodeSystem` with content. THO already carries
the right representation: `NamingSystem/MVX` at
`http://terminology.hl7.org/NamingSystem/MVX`, plus `ValueSet/v2-0227`, which
composes from `http://hl7.org/fhir/sid/mvx`. Both are reused.

The URI Chapter 2C publishes for the table,
`http://terminology.hl7.org/CodeSystem/v2-0227`, is retained as the table moves
to that representation, notwithstanding that it looks like an HL7 code system
canonical.

**Consequences.**

- Two open items about table 0227 are parked behind this decision rather than
  resolved on their own: the duplicate Table Metadata block, and the
  cross-pipeline disagreement about how many Code System blocks the section
  has. Both have the same cause — the section holds two grids that each begin
  `Table OID`, so python-docx's first-cell classifier read both as Table
  Metadata and merged them, while the LLM correctly split them into a Code
  System block and a Table Metadata block. **The LLM is right.** No content is
  lost either way; only the block it hangs from differs. If 0227 turns out not
  to be representable as an external metadata record, the classifier needs
  fixing — it is a single-table special case, since 0227 is the only section in
  Chapter 2C with a duplicate metadata block.
- Table 0961 (Device Type) is the same shape of question and is likely to
  resolve the same way, with the code system being SNOMED CT rather than an HL7
  one. THO publishes `ValueSet/v2-0961`, which sidesteps the SNOMED expression
  entirely by importing `http://terminology.hl7.org/ValueSet/device-kind`
  rather than writing out `where concept is-a 49062001`. Worth taking as the
  model rather than composing the filter by hand.
- **This is the first instance of what Batch D is about** — the 26 tables with
  a code system identity but no printed codes. Deciding 0227 concretely is
  useful precedent for that batch.

### D9 — THO's code wins where a Chapter 2C symbolic name differs only in spacing

**Decided 2026-08-18.**

Concept domain `Masterfile Action Code` (table 0180) is published in THO as
`MasterfileActionCode`. THO's code — the one without the spaces — is kept, and
no new concept is added.

The divergence stays in the report rather than being removed, because the
difference between the two spellings is real and a reader should be able to see
it.

**Not decided at the time:** whether the same reasoning extends to the 55
Chapter 2C symbolic names with unusual characters. **Settled by D12**, which
answers it the other way, and for a different reason: those names are valid
FHIR codes, so there was never a defect to fix. The two decisions do not
conflict, because THO's code wins here on the strength of THO already
publishing the concept, not on the strength of Chapter 2C's spelling being
invalid.

### D10 — A non-breaking space against closing punctuation is deleted, not spaced out

**Decided 2026-08-19.**

One value, in table 0827. The chapter publishes `...for statistical use (M49)`,
a non-breaking space, then the full stop. D7's rule turned every run of
non-breaking spaces into one ordinary space, which left `(M49) .` — a defect
this project had introduced itself. A non-breaking space immediately before the
punctuation that closes a clause is now deleted instead, giving `(M49).`

**Why it is a separate rule rather than a change to D7's.** Everywhere else a
non-breaking space is standing in for a space, and turning it into one is
right. Against closing punctuation it is standing in for nothing: no
typographic convention puts a space before a full stop. The two cases want
opposite treatment, so they are two rules, and the deletion runs first.

**Why it does not reach the other nineteen.** Nineteen further places in
Chapter 2C print an ordinary space before closing punctuation
(`Placer Applications .`, `...type of BC Component .`). Those are published
that way and no decision has been asked for on them; the rule is confined to
runs containing a non-breaking space, which is what makes the difference
between a defect Word introduced and a defect the authors typed. The confinement
is expressed structurally and fires exactly once corpus-wide.

**Consequences.**

- **It broke the cross-pipeline comparison, for the third time, in the way D6
  and D7 warned about.** The LLM extraction had already flattened that
  non-breaking space to an ordinary one, so deleting it on the python-docx side
  and not the LLM side put the two corpuses one space apart, and table 0827
  moved out of the benign `whitespace` bucket and into `content` — the bucket
  reserved for the two extractions genuinely disagreeing about what the
  document says.
- **The fix is in the comparison, not the rule.** `fold_whitespace` now also
  drops a space sitting against clause-closing punctuation, on the reasoning
  that whether such a space is present is a spacing question by definition. Two
  values equal after that fold differ only in spacing, which is exactly what
  the bucket means. Agreement is unchanged at 740/799; `whitespace` is back to
  45 and `content` back to 1 (table 0496).
- The lesson is now three for three and belongs in any future rule review:
  **a character-level rule must be checked against both corpuses, and if they
  cannot be made to agree, the comparison's notion of "same" is what needs
  widening — not the rule.**

### D11 — The seven tables with an empty grid, disposed of individually

**Decided 2026-08-19.**

Seven sections carry a grid with no content. Chasing that down turned out to be
worth more for what it surfaced than for the grids themselves: in six of the
seven the empty grid is a stray 1×2 Word layout artifact sitting beside content
that extracted perfectly well.

| Table | Disposition |
|---|---|
| 0347 State/Province | External code system. Reuse THO's `NamingSystem/ISO3166Part2`; no CodeSystem minted |
| 0560 Quantity Units | Concept domain only |
| 0821 Gender Identity | ValueSet only, reusing THO's `ValueSet/gender-identity`; no CodeSystem minted |
| 0910 Acquisition Modality | Concept domain only |
| 0929 Weight Units | External code system (UCUM). Reuse THO's `NamingSystem/v3-ucum`; no CodeSystem minted |
| 0930 Volume Units | As 0929 |
| 0932 Donation Duration Units | As 0929 |

**Four of them are D8's pattern again.** 0347 is backed by ISO 3166-2 and
0929/0930/0932 by UCUM. In both cases Chapter 2C's own OID and URI match a THO
`NamingSystem` exactly — `urn:oid:1.0.3166.2` for the first,
`2.16.840.1.113883.6.8` and `http://unitsofmeasure.org` for the second — so
these are external metadata records, represented the way D8 settled for MVX.
That is four of Batch D's 26 tables resolved as a side effect, and it confirms
the NamingSystem shape as the batch's starting point rather than
`content: not-present`.

**Two are concept domain only, on the evidence of the source.** 0560 and 0910
each carry a Code System Identification block reading OID `-`, symbolic name
`noObject`, description `noDescription`. That is a tool's placeholder for an
empty field, published. It appears in exactly these two sections and nowhere
else in Chapter 2C, and both are tables with no genuine code system, so the
placeholder is a reliable marker of the condition rather than random noise.
Whatever codes 0560 prints, there is no code system identified to mint one
from.

*This costs something and the cost is recorded.* THO does publish
`CodeSystem/v2-0560`, so this IG will be silent where THO is not. That is
deliberate, it is reversible, and the underlying content problem is with V2
Management and TSMG.

**One is a ValueSet over three external systems.** 0821 declares SNOMED CT,
FHIR DataAbsentReason and V3 NullFlavor, all external, so no CodeSystem is
minted. THO's `ValueSet/gender-identity` carries the OID Chapter 2C prints for
this value set — `2.16.840.1.113883.4.642.3.3291` — and composes from exactly
those three systems, so it is reused rather than rebuilt. The chapter's own
Content Logical Definition says "as defined in the linked value set", which is
consistent with reuse and means the blank grid does not block the table.

**Consequences.**

- Six of the seven raised something for V2 Management or TSMG, including the
  most substantial finding in the workstream so far: table 0821's coded content
  grid is published entirely blank, and the row count matches THO's value set
  concept count exactly. See D13 and the escalation register.
- The dispositions above are Batch A answers for seven tables, taken ahead of
  the batch because the evidence was in front of us. They constrain Batch A
  rather than pre-empting it: the rule they imply is *a table whose code system
  is external gets no CodeSystem*, and that rule still has to be stated for the
  other 792.

### D12 — Chapter 2C symbolic names are valid FHIR codes and are kept verbatim

**Decided 2026-08-19.**

55 concept domain symbolic names contain apostrophes, commas, asterisks or an
en dash — `Collector'sComment*`, `PrimaryKeyValue–STF`,
`Diet,Supplement,orPreferenceCode`. They are emitted verbatim as concept codes.

**There was no problem to solve.** These were flagged on the assumption that
such characters make a string unusable as a FHIR `code`. They do not: the
`code` data type admits any character other than whitespace and permits single
internal spaces. Every one of the 55 is valid. Since the names are only ever
used in FHIR representations, that is the only definition of "valid" that bears
on the question.

**Consequences.**

- The group moves from *decide* to *decided* without any change to the
  generated output, which is the cheapest kind of resolution and worth
  recording precisely because nothing changed — otherwise the same false alarm
  gets raised again.
- Worth generalising: "looks unusual" is not "is invalid". A future flag of
  this shape should cite the specific rule it believes is being broken before
  it is raised as a decision.

### D13 — Defects in the source are escalated, not adjudicated

**Decided 2026-08-19.**

Where a finding is wrong in Chapter 2C or in THO rather than wrong in this
project's handling of it, it goes to the HL7 V2 Management Group or the
Terminology Services Management Group. It is recorded in a register, given a
concrete question, and left open until a committee answers.

**Why a register and not a note per section.** These findings arrive one at a
time, scattered across unrelated review groups, and each one on its own looks
like a curiosity. Together they are an agenda — and one of them turns out to be
a policy question that governs all the rest. Twelve items are registered as of
this decision; five of the twelve came out of D11 alone.

**The mechanism.** `tooling/scripts/vocabulary_escalations.py` holds the
register. The HTML review catalog renders it as its first section, under a new
`escalate` action class, and the module run directly writes
`v291-extracted/vocabulary-v2mgmt-items.md` — a plain document that can be
circulated to people who will not open a 1.6 MB HTML file. One source, two
renderings, so they cannot drift.

**The item that matters most is the first one.** The IG's governing requirement
is fidelity, which is comfortable while the divergences are typographic and
uncomfortable once the published content is simply wrong. Table 0560 publishes
time units under the name Quantity Units; table 0931 publishes an invalid UCUM
code beside the valid one that means the same thing. **THO has already answered
this question differently at least once** — its `ValueSet/v2-0931` drops the
bad code and records the history in the display text of the good one. So the
register asks V2 Management to decide the rule rather than the instances:
reproduce and record, reproduce and deprecate, or correct and annotate. The
current answer is reproduce-and-record, and it is an assumption nobody has
ratified.

**Consequences.**

- Two review groups move out of *decide* by being escalated rather than
  settled: the five concept domains that Chapter 2C describes two different
  ways, and the five whose definitions differ between Chapter 2C and THO. A
  concept domain has one description by definition, so a domain with two is a
  source defect and not a representation choice this project gets to make.
  Meanwhile the first description in document order is emitted, which keeps the
  output deterministic.
- Batch A cannot be fully closed while item 1 is open, because the answer
  changes what a defective table should produce. It does not block Batch A
  entirely — the seven tables in D11 were disposed of without it — but the
  general rule waits.

### D14 — Individual corrections, where the defect does not generalize into a rule

**Decided 2026-08-19.**

Thirteen values across eleven tables are corrected individually rather than by
a rule. All are spaces before closing punctuation, or in one case a duplicated
period.

| Tables | Correction |
|---|---|
| 0577, 0578, 0579, 0580, 0582, 0604, 0785 | Space before the period ending a concept domain description |
| 0119, 0396 | Space before the period ending a comment (0396 also ×3 before a comma) |
| 0003 | Space before a comma in a display name |
| 0356 | A second period, preceded by a space, after the period that already closed the sentence |
| 0440 | Three defects in one passage, corrected together — see below |
| 0717 | Space before the comma following a URL, in two coded rows |
| 0952 | Space before a colon; space before a period |

**Why not a rule.** There are 19 places in Chapter 2C with a space before
closing punctuation, and the reviewer worked through them individually over
two rounds rather than approving the group. Some needed more than the space
removing, one was a colon rather than a period, and in two cases the defect
that prompted the instruction had already been fixed by an earlier rule. That
is not a pattern. It is a person reading each one. Forcing it into a rule would
mean inventing a discriminator that does not exist in the text, which is worse
than admitting the corrections are individual.

**Table 0440 is the reason the mechanism takes a whole passage, not a
fragment.** The NDL comment carries three overlapping defects — a space after
each of four opening parentheses, a space before the comma after `(OBR-32)`,
and no space around the hyphen in `7.4.1.32-(OBR-32)` where the other three
references in the same sentence have one. Written as three narrow fragments
the second and third would have had to match text the first had already
rewritten, which is unreadable and fragile. Written out in full, the diff shows
exactly what the passage becomes.

*One piece of evidence points the other way on the hyphen, and is recorded
here so the decision can be revisited cheaply.* Table 0440's `CNN` row
publishes the same passage in corrected form — `7.4.1.32-(OBR-32),
4.5.3.33 and 7.4.1.33 - (OBR-33)…` — with no space after the parentheses, no
space before the comma, and **the first hyphen tight**, exactly as NDL has it.
So the chapter is consistent in treating the first reference differently, and
the instruction to space it out makes NDL internally consistent at the cost of
diverging from its own sibling row. That was the reviewer's explicit call and
it is one line to reverse.

**Why matching is on a text fragment within a named table, and not on a
location path.** Two reasons, both of which would otherwise have caused a
silent failure:

- **The two pipelines index coded content differently.** The corrected value in
  table 0003 is row 348 to python-docx and row 347 to the LLM. A location key
  would have applied the correction to one corpus and missed it in the other —
  the same class of failure as D6, D7 and D10, arrived at from a fourth
  direction.
- **A fragment that stops matching is a loud failure.** If Chapter 2C is
  re-extracted and the text has moved, the correction stops firing and the
  count in the change log drops. A location key would have gone on editing
  whatever now sits at that path.

Fragments are matched **after** the rule chain has run, because that is the
text the reviewer was reading when they decided. Every fragment was verified to
occur in both corpuses before being accepted.

**Consequences.**

- **The space-before-punctuation group is empty.** All 19 places are corrected:
  14 in the first round, 5 in the second. Nothing in Chapter 2C now carries a
  space before the punctuation that closes a clause.
- Cross-pipeline agreement is unchanged at 740/799. The corrections are applied
  to both corpuses and are absorbed by the shared policy, which is what the
  count of policy-absorbed values rising from 1,043 to 1,057 records.
- **Fragments match the post-policy text, and table 0440 proves why that
  matters.** The published LLM value carries `7.4.1.33  - (` with two spaces
  where python-docx has one. The fragment matches neither raw corpus reliably
  and both corpuses after the rule chain has run, because D5 and D7 have by
  then made them identical. Checking a fragment against the raw corpus is
  therefore not a valid test of whether a correction will fire.
- **This is the mechanism to reach for when the next batch of individual
  judgements arrives**, and there will be more: the missing space after a
  comma, the three dashes D5 refused to repair. A rule remains preferable when
  one exists; `MANUAL_CORRECTIONS` is for when one honestly does not.

### D15 — A non-ASCII character is judged against THO, not against taste

**Decided 2026-08-19.**

The character inventory previously marked two characters as needing a decision
— `Ø` (NCPDP's slashed zero, 8 places in table 0396) and `‑` (a non-breaking
hyphen, 4 places in table 0945) — on the grounds that they looked wrong. Both
are now closed, and the inventory as a whole is informational.

**The test is whether THO already publishes the character.** Every one of the
14 non-ASCII characters in the corpus does. For the two that looked doubtful,
THO carries not just the character but the identical text: the NCPDP address
`924Ø East Raintree Drive` appears verbatim in `CodeSystem/v2-0396`, and
`pre‑configured` in `CodeSystem/v2-0945` and in the concept domains. There is
nothing to fix and nothing to decide.

**Why this is worth an entry rather than just deleting two rows.** The
inventory exists because a one-off scan found the double-encoded non-breaking
space in table 0301, and making the scan permanent means the next such
character is found the same way. That value is real, but it only survives if
the inventory does not also cry wolf about German umlauts, trademark symbols
and copyright signs — all of which it was implicitly doing by rendering the
whole section under *Decide*.

The check is now automatic: the report compares the corpus's character set
against every character in the staged THO package and flags only the
characters THO does not have. Today that is none, so the section is
informational and stays that way until something genuinely new appears.

**Consequences.**

- The same principle generalises, and is worth applying before flagging
  anything else as a fidelity problem: **is this already published in the
  terminology the IG will sit beside?** If yes, it is not our defect. D12 is
  the same reasoning applied to symbolic names, reached independently.

### D16 — A missing space after a period is detected and reported, never inserted

**Decided 2026-08-20.**

Chapter 2C runs one sentence straight into the next, with no space after the
period, in **12 places across 7 tables**. Table 0821's value set description is
the one that surfaced it: *"…relevant within their community.Used in HL7
Version 2.x messages"*. The rest are five identical comments in 0301, two in
0396, and one each in 0399, 0454, 0717 and 0719.

**Reported, not repaired.** Inserting a character is a larger licence than
removing one. D6 is the only rule so far that adds anything, and it was
admitted only because the chapter's own overwhelming majority usage — 172
sites already carrying the comma — settled the question. There is no equivalent
authority here: the correct fix for *"community.Used"* is obvious, but so was
D6's, and the bar D6 set is the one to hold. This becomes a `decide` group,
which is where the reviewer will settle it or not.

**Two of the twelve are not defects, and they are listed anyway.**
`Observation.Code` in table 0396 and `…ActHealthInformationManagementReason.
PurposeOfUse` in 0717 are dotted identifiers. Nothing in the text distinguishes
one from a genuine missing space, and a detector that guesses hides real
defects — so both are shown and a reader decides. Emails and URL paths *are*
excluded, because `@` and `/` in the surrounding token are structural evidence
rather than a guess; that keeps table 0396's contact address
(`Patrick.Revelle@ngc.com`) out.

**Where the pattern lives.** In `vocabulary_text_policy.py` alongside the
rules, not in the extractor, because the review report needs the same pattern
to mark the site inside the value. The report already carries one detector
regex copied from the extractor; a second copy would be the point at which
they start to drift. The match deliberately spans the three joined characters
(`y.U`) rather than the period alone, so the mark is visible in the middle of a
700-character paragraph.

### D17 — Ten of the twelve missing spaces are restored; the two identifiers are not

**Decided 2026-08-20.** Supersedes D16's disposition of these twelve sites; the
detector D16 built is unchanged and still runs.

D16 declined to insert the space because no authority in the chapter licensed
it. The reviewer read all twelve sites and supplied that authority directly:
ten of them are sentence boundaries that lost their space in publication, and
the space goes back in. That is the authority D16 said was missing — a reader
adjudicating each site, which is the same standard D14 was decided on.

| Table | Field | As published | Places |
|---|---|---|---:|
| 0301 | `codedContent.comment` | `coding entity identifier.Retained for backward` | 4 |
| 0301 | `codedContent.comment` | `string of random bits.Retained for backward` | 1 |
| 0396 | `codedContent.comment` | `the same software and vocabulary.RxNorm is one of` | 1 |
| 0399 | `codeSystem.Description` | `ISO 3166 Part 1 Country Codes.This coding system` | 1 |
| 0454 | `tableMetadata.Description` | `a specific organization unit.Health Care Provider` | 1 |
| 0719 | `codeSystem.Description` | `Act.classCode is not permitted.Code system of concepts` | 1 |
| 0821 | `valueSet.Description` | `within their community.Used in HL7 Version 2.x` | 1 |

**The two dotted identifiers are not repaired.** `Observation.Code` in 0396 and
`…ActHealthInformationManagementReason.PurposeOfUse` in 0717 are names, and a
space would corrupt them. They stay as published, and the detector goes on
reporting them — it must, because nothing in the text tells an identifier apart
from a sentence boundary, and a detector that filtered them out would hide the
next real one. They render as informational, not as something to decide.

**Individual corrections, not a rule, and D16's argument is why.** No pattern
separates the ten from the two. The word before the period is lowercase in some
real ones (`identifier.Retained`) and capitalized in others (`Codes.This`),
which is equally true of the two identifiers; the following word is a single
capitalized token in both kinds. The only reliable test is a reader looking at
the sentence, so the record is what the reader decided, site by site, in
`MISSING_SPACE_CORRECTIONS`.

**A separate table from D14's, deliberately.** Both are consulted for the same
table number and both run after the rule chain, but each reports under its own
kind, so a change lands under the decision that authorized it rather than
inheriting D14's. Same reasoning as the rule chain running narrow rules ahead
of broad ones. Table 0396 now carries corrections from both and demonstrates
it.

**One correction only python-docx can see.** Table 0719's code system
description is one of the 14 known LLM truncations — the LLM cut the value
hundreds of characters before this sentence — so the correction fires once in
python-docx and nowhere in the LLM corpus. That value already disagreed between
the pipelines and still does, under the same `llm_truncated` heading, so no new
disagreement was created and cross-pipeline agreement holds at 740/799. The
other nine fragments were verified present in both corpuses before being
written, per the standing rule that every character-level change is checked
against both.

### D18 — The IG is a staging workspace for THO, and canonicals say so

**Decided 2026-08-20.** This is a premise the whole of Batch A rests on, so it
is recorded before the batch rather than inside it.

**What this IG is for.** It is a *workspace* in which the V2.9.1 terminology is
made correct. It is not a publication in its own right and has no independent
consumers. Once the content is deemed correct it is **integrated into THO**,
which is its only destination.

**Therefore the canonical origin is `http://terminology.hl7.org/`.** The
resources are authored at the URLs they will ultimately live at, following
THO's existing naming — `CodeSystem/v2-0nnn`, `ValueSet/v2-0nnn`, `hl7VS-…`
titles. There is no interim canonical to migrate away from later, and no
mapping table between a workspace URL and a THO URL for anyone to get wrong.

The objection this overrides is namespace squatting: authoring at another
body's canonical usually means two publishers can claim one URL. It does not
apply here, for the same reason D1 gave — the project lead is a UTG maintainer
and a member of TSMG, so this is not an outside body reaching into THO's
namespace. It is THO's content being prepared, in the open, before it lands.

**The output is not tied to V2.9.1.** V2.9.1 is the *source* being used to
establish a correct baseline for v2 in THO; it is not the scope of the result.
Consequences for Batch A and Batch C:

- Resource `version` does **not** carry `2.9.1`. Versioning follows THO's own
  scheme, as D1 already does for `conceptdomains` (THO 3.0.0 → this 4.0.0).
- Chapter 2C's "HL7 Version Introduced" is provenance about a concept and
  belongs in a property, never in `CodeSystem.version`.
- Nothing in the resources should read as though V2.9.1 were the subject.

**The existing THO v2 content is not a reference standard.** The project lead's
assessment is that it is more error-ridden than what this effort is preparing.
Two things follow:

- Where this work and THO disagree, THO does not automatically win. D1's
  tie-break for the 5 conflicting concept domain definitions was justified on
  the grounds that deferring cost almost nothing in fidelity — that remains
  true at 5 domains, and all 5 are already escalated under D13, so nothing
  changes today. But the *reasoning* does not generalise, and no later decision
  should cite "THO already publishes it" as authority on its own.
- Where THO's existing v2 content agrees with Chapter 2C, that is corroboration
  and worth stating; it is not deference.

**This effort is the fidelity load, and only that.** The discipline is
unchanged: the workspace carries what Chapter 2C publishes, corrected only
where a reviewer has decided a specific case is safe, with every divergence
recorded. A **subsequent** effort resolves the substantive problems in the v2
terminology that go beyond this pass. Keeping the two separate is what makes
the second one reviewable — a baseline nobody can diff against is not a
baseline. `v291-extracted/vocabulary-future-corrections.md` is that second
effort's inbox.

## Open batches

Worked in dependency order; each is a short session, and each records its
outcome above as a new decision.

### Batch A — Identity: which resources exist, and what are they called

- Which tables get a CodeSystem and/or ValueSet at all. Candidates for
  exclusion: the 384 concept-domain-only tables (covered by D1 instead).
  ~~and the 7 tables whose content is an empty grid~~ — **those 7 are settled
  by D11**, and the rule they imply is the one to generalise here: *a table
  whose code system is external gets no CodeSystem, only a ValueSet composing
  from THO's NamingSystem for it.*
- Canonical URL and id scheme for the 18 code-bearing tables THO does not
  cover, and whether ValueSets follow the same rule as CodeSystems.
- Whether ValueSets are generated for every CodeSystem or only where Chapter
  2C declares a Value Set block (438 tables declare one).
- Resource `version`, `status`, `experimental`, publisher and contact defaults.
- **Blocked in part by escalation 1** (D13): what a table produces when its
  published content is known to be wrong depends on whether the answer is
  reproduce, deprecate or correct. Everything else in this batch can proceed.

### Batch B — Concept level: what each code carries

- Mapping of the status column (`D` 222, `N` 70, `B` 5, `R` 3) onto FHIR —
  `inactive`, the standards-status extension, and/or a property preserving the
  published letter verbatim.
- Whether Definition maps to `concept.definition` and Comment to a property,
  and what to do where the published Definition is not a definition (table
  0496 code `028` contains ditto marks). D7 settled the *text* — the spaces
  between the ditto marks are preserved — but not what a ditto mark should
  become in a `concept.definition`.
- ~~Handling of private-use-area symbol characters in published prose~~ —
  **settled by D7**: they are deleted, keeping the tab that follows them.

### Batch C — Container level: code system and value set metadata

- Code System Version block → `CodeSystem.version` / `.date`, and where "HL7
  Version Introduced" goes.
- The 5 tables declaring more than one Code System block.
- Whether Binding Information (realm) is represented at all.
- Value Set "Content Logical Definition" → `ValueSet.compose`.

### Batch D — The 26 external-content tables

Tables with a real code system identity in Chapter 2C but no printed codes,
because content lives in LOINC, SNOMED, CDC or THO. Options include a
CodeSystem with `content: not-present` plus a ValueSet referencing the external
system, an identity-only stub, or exclusion.

**D8 decided the first of these concretely** — table 0227 (MVX) reuses THO's
`NamingSystem/MVX` and `ValueSet/v2-0227` — and 0961 (Device Type) is expected
to follow the same shape. Both are worth treating as the pattern for the batch
rather than deciding 26 tables from first principles. Note that THO models an
external code system as a **NamingSystem**, not a `CodeSystem` with
`content: not-present`, which is the option this batch should probably start
from.

**D11 resolved four more of the 26 the same way** — 0347 against
`NamingSystem/ISO3166Part2` and 0929/0930/0932 against `NamingSystem/v3-ucum`,
in each case because Chapter 2C's own OID and URI match the THO record exactly.
Five of 26 now share one shape, which is enough to treat NamingSystem reuse as
the batch's default and to make the remaining question "which tables have no
THO record" rather than "how should an external code system be modelled".

## Consequences

- Decisions accumulate in one ADR rather than four, so the rationale for the
  vocabulary representation is readable in one place.
- Because batches are decided in dependency order, later batches can assume
  earlier ones; but a reversal in Batch A would invalidate work in B–D.
- Every batch's outcome is expressed in generator code plus a divergence log,
  so the ADR and the artifacts stay in step.

## Related

- ADR-0005 — W vs B field policy (precedent for status-code handling in Batch B)
- ADR-0006 — Multi-corpus V2.9.1 extraction (the fidelity method reused here)
- `v291-extracted/vocabulary-review-report.html` — the review catalog
- `v291-extracted/vocabulary-changelog.md` — every change made to the published
  text, with its scope and where it took effect, plus what is still outstanding
- `v291-extracted/vocabulary-future-corrections.md` — the backlog for the pass
  *after* the fidelity load: content that is correct as published but would be
  better expressed differently once we are free to change it
- `v291-extracted/vocabulary-v2mgmt-items.md` — D13's register, as a document
  that can be circulated to a committee
- `tooling/scripts/vocabulary_text_policy.py` — D2 to D7 and D10 as code
- `tooling/scripts/vocabulary_escalations.py` — D13's register, as the single
  source both renderings come from
- `v291-fhir/conceptdomains-divergences.json` — D1's divergence log
