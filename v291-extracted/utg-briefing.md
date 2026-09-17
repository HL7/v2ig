# V2.9.1 Chapter 2C terminology — Briefing for the UTG subcommittee of TSMG

**2026-08-20**

We are building a FHIR IG that carries the V2.9.1 Chapter 2C vocabulary as
CodeSystems and ValueSets. It is a workspace, not a publication. Its
only destination is integration into THO, so resources are authored at
http://terminology.hl7.org/ canonicals from the start.

The extraction and text-fidelity pass is complete — 799 tables,
5,540 codes, every divergence from the published text recorded and reviewed,
nothing outstanding. Resource generation is next and is gated on decisions,
several of which are UTG's.

## If you read one thing

1. **[DECISION]** Where V2 published an error, does THO reproduce it or correct it?  
   _Ask:_ Is “correct in THO, record the history in the display text” the rule? If so we will apply it consistently and bring back the list of affected tables.
2. **[DECISION]** Merge mechanics — we want a diff that shows only real changes  
   _Ask:_ Point us at the right UTG checkout and branch, and tell us how narrative is handled. Those two answers let us start generating.
3. **[DECISION]** CodeSystem/conceptdomains — we are proposing 3.0.0 → 4.0.0  
   _Ask:_ Confirm the major-version bump and the source: v2 marking, and that appending 177 top-level concepts is the right shape rather than slotting them into the existing hierarchy.
4. **[DECISION]** Five concept domain definitions where Chapter 2C and THO disagree  
   _Ask:_ These four need reconciling on the merits, not a tie-break rule. Choosing a wording does not fix a genuine disagreement about meaning.
5. **[THO GAP]** CodeSystem/v2-0411 is referenced by the published chapter and does not exist  
   _Ask:_ Should UTG create it, or is there a reason it was never minted?
6. **[THO GAP]** THO has no CodeSystem for 18 code-bearing v2 tables — 10 have a ValueSet only  
   _Ask:_ Confirm the rule — a v2 table whose codes belong to another system gets a ValueSet composing from that system and no CodeSystem of its own. We would apply it across the board, including to the five already resolved this way (0227→NamingSystem/MVX, 0347→NamingSystem/ISO3166Part2, 0929/0930/0932→NamingSystem/v3-ucum).
7. **[THO GAP]** Table 0459 is labelled as CMS content but does not look like CMS content  
   _Ask:_ Is the OID right? If these are HL7's own codes they need an HL7 code system, not a CMS one.
8. **[THO GAP]** Three tables declare “Concept Domain Only” and then publish code rows  
   _Ask:_ We plan to emit a concept domain and nothing else for these three. Flagging in case UTG reads any of them differently.

## Decisions we need from UTG

Work is gated behind each of these.

### 1. Where V2 published an error, does THO reproduce it or correct it?
**Tables:** policy

This unblocks the most work, and UTG has already answered it once by precedent — but answered it the other way somewhere else.

Chapter 2C table 0931 Temperature Units publishes three codes:
degF (status D, comment “typo”),
[degF], and Cel. degF is not valid UCUM
— UCUM requires the brackets — so the chapter publishes a
known-invalid code beside its correction, with two of three entries meaning
Degrees Fahrenheit.

THO already fixed this. ValueSet/v2-0931 v2.0.0 carries
only [degF] and Cel, and folds the history into the
display text: “Degrees Fahrenheit (note that V2 has erroneously
published this for many years without the square brackets).”

That is a good decision. We would like to know whether it is policy or a
one-off, because our working default is the opposite — reproduce and
record — and nobody has ratified it.


The counter-example, worth having in the room. Table 0560 Quantity
Units is named for quantity, bound to ADJ-6, and publishes
five codes of which four are units of time (HS Hours,
DY Days, MN Month, YY Years).
CodeSystem/v2-0560 in THO 3.0.0 publishes the same five.
So here THO reproduced rather than corrected.
0931 and 0560 currently point in opposite directions. This is
a live inconsistency inside THO, not an abstract question.

**Ask:** Is “correct in THO, record the history in the display text” the rule? If so we will apply it consistently and bring back the list of affected tables.

### 2. Merge mechanics — we want a diff that shows only real changes
**Tables:** process

We would rather design for a reviewable merge now than retrofit one onto 800 resources.

Settled on our side. We will emit XML into UTG's layout
(input/sourceOfTruth/v2/{codeSystems,valueSets}/), and match THO's
existing serialization closely enough that a resource we do not change
produces no diff at all — no reindentation, no reordered elements, no
whitespace noise. The review should read “here are the N resources
that actually change”, not “here are 800 files”.
We will enforce it with a round-trip test: take THO's existing
v2 XML, run it through our writer untouched, assert the bytes come back
identical. Anything that fails is a serialization bug, not a content change.


What we need from UTG is what we cannot see from the published package:

Which UTG checkout should we diff against? We have
hl7.terminology.r5 v7.3.0 (JSON) but not the source repo. We need
the repo, and to know which branch is the right base.
Are the conventions written down, or should we infer them from the
existing files? Specifically element ordering, indent width, self-closing tag
style, line endings, and whether the text narrative is
hand-authored or regenerated by tooling. Narrative is the likeliest source
of spurious diffs — a regenerated div touches every file
while meaning nothing.
What is the intake route — PR against the UTG repo, a proposal
per resource, something else? And what proposal granularity does UTG want for a
change set this size?

**Ask:** Point us at the right UTG checkout and branch, and tell us how narrative is handled. Those two answers let us start generating.

### 3. CodeSystem/conceptdomains — we are proposing 3.0.0 → 4.0.0
**Tables:** conceptdomains

Chapter 2C declares 760 distinct concept domains. THO 3.0.0 publishes 582 of them.

THO 3.0.0Proposed 4.0.0
Top-level concepts742919
Total concepts1,3451,522


The 177 additions are appended as new top-level concepts marked
source: v2 — THO's own convention for v2-derived domains.
Every existing THO concept is carried through unchanged with its hierarchy and
properties.

Why a superset and not just Chapter 2C's 760. Publishing a
subset at THO's canonical would destructively redefine a code system
this project does not own: a server loading both packages would see concepts
disappear.

Why not a supplement. A CodeSystem supplement may add properties and
designations to an existing code system. It may not add concepts.

**Ask:** Confirm the major-version bump and the source: v2 marking, and that appending 177 top-level concepts is the right shape rather than slotting them into the existing hierarchy.

### 4. Five concept domain definitions where Chapter 2C and THO disagree
**Tables:** 0952, 0967, 0675, 0066, 0626

For 577 of the 582 shared domains the two agree word for word. These five do not.

Only 0952 is a near-match — it differs by formatting and a
stray space. The other four are wholly different texts, which usually
means the two bodies have attached different meanings to the same domain, not
that one meaning is phrased two ways.

Our generator currently emits THO's wording. That was chosen when we assumed
THO was the more reliable side; we now understand the existing THO v2 content
to be less reliable than Chapter 2C in general, so we would rather not have
picked a default by assumption.


Note this interacts with ask 1. If UTG confirms
“correct in THO and record the history”, that is also an argument
for Chapter 2C's wording winning here — which is the opposite of what we
currently emit.

**Ask:** These four need reconciling on the merits, not a tie-break rule. Choosing a wording does not fix a genuine disagreement about meaning.

## THO gaps and defects we found

Verified against hl7.terminology.r5 v7.3.0. UTG action, but not a debate.

### 5. CodeSystem/v2-0411 is referenced by the published chapter and does not exist
**Tables:** 0411

A dangling canonical in a published HL7 standard.

Chapter 2C prints the URI
http://terminology.hl7.org/CodeSystem/v2-0411 for table 0411
Supplemental Service Information Values — 2 codes
(NDBS, CG), OID
2.16.840.1.113883.18.452.
THO has no such resource, and no ValueSet/v2-0411
either.

**Ask:** Should UTG create it, or is there a reason it was never minted?

### 6. THO has no CodeSystem for 18 code-bearing v2 tables — 10 have a ValueSet only
**Tables:** 18 tables

This looks deliberate and correct. We want the pattern confirmed before generalising it across 415 tables.

For 10 of the 18, THO publishes a ValueSet whose compose
names the real system, and no CodeSystem — because the codes belong to
something else. In every case THO's enumerated codes match what Chapter 2C
prints.


TablesCodes come from
0567, 0568, 0929, 0930, 0931, 0932http://unitsofmeasure.org (UCUM)
0725 Mood Codes…/CodeSystem/v3-ActMood
0125 Value Type…/CodeSystem/v2-0440
0136 Yes/no Indicator…/CodeSystem/v2-0532
0338 Practitioner ID Type…/CodeSystem/v2-0203


The remaining 8. 0820 (LOINC) and 0823 (SNOMED CT +
DataAbsentReason + NullFlavor) need a ValueSet each and no CodeSystem, same
shape. 0460 Denial or Rejection Code is genuinely HL7-authored
content with no THO home and needs a real CodeSystem. 0411 is item 5.
0459 is item 7. The last three are item 8.

**Ask:** Confirm the rule — a v2 table whose codes belong to another system gets a ValueSet composing from that system and no CodeSystem of its own. We would apply it across the board, including to the five already resolved this way (0227→NamingSystem/MVX, 0347→NamingSystem/ISO3166Part2, 0929/0930/0932→NamingSystem/v3-ucum).

### 7. Table 0459 is labelled as CMS content but does not look like CMS content
**Tables:** 0459

Chapter 2C gives table 0459 Reimbursement Action Code the symbolic
name cms-OCEEditCode-cs and OID
2.16.840.1.113883.6.301.9. Its four codes are 0–
3 with HL7-authored English displays — “OCE line item
denial or rejection is not ignored”, and so on.
Those read as an HL7 enumeration about OCE behaviour, not as codes
drawn from the CMS OCE Edit Code system.

**Ask:** Is the OID right? If these are HL7's own codes they need an HL7 code system, not a CMS one.

### 8. Three tables declare “Concept Domain Only” and then publish code rows
**Tables:** 0093, 0340, 0451

Each sets Concept Domain Only: yes and then carries rows in the
coded content grid. The rows are not really codes:

0093 Release Information — the third entry is literally
... with display “user-defined codes”
0340 Procedure Code Modifier — the two entries
(CPTM, HPC) name coding systems, not
modifiers
0451 Substance Identifier — the single entry
ALL is a query wildcard

**Ask:** We plan to emit a concept domain and nothing else for these three. Flagging in case UTG reads any of them differently.

## Visibility — no decision needed

Here so nobody first hears it from a merge request.

### 9. We are authoring at THO canonicals

Resources carry http://terminology.hl7.org/CodeSystem/v2-0nnn
and ValueSet/v2-0nnn from the start, because the workspace exists
only to be merged into THO. There is no interim canonical to migrate away from
and no workspace-URL-to-THO-URL mapping for anyone to get wrong.

**Ask:** No decision sought. But if anyone would rather we staged under a different base and migrated later, now is the time to say so — it gets expensive quickly.

### 10. The output is not scoped to V2.9.1

V2.9.1 is the source being used to establish a correct v2 baseline,
not the scope of the result. Resource version will not carry
2.9.1; Chapter 2C's “HL7 Version Introduced” becomes a
concept property.
This pass is fidelity only. Substantive corrections to the v2
terminology are a deliberate second effort — keeping them separate is
what will make the second one reviewable against this baseline.

**Ask:** No decision sought.

### 11. Scale and method

Scale. 799 sections, 5,540 codes, 415 code-bearing tables, ~384
concept-domain-only, 760 concept domains.
Method. Two independent extractions of the same .docx
— python-docx (character-faithful) and an LLM (structural corroboration)
— agreeing on 740/799 tables, with every remaining difference
classified and adjudicated against the source. Every change to published text
is recorded with the decision that authorized it.

**Ask:** No decision sought.

## For V2 Management, not UTG

| # | Item | Tables |
|---|---|---|
| 3 | Coded content grid published completely blank; 6 rows × 5 cols, and THO's ValueSet/gender-identity holds exactly the 5 concepts it should have carried | 0821 |
| 5 | All six UCUM-backed tables name the code system “Donation Duration Units Code System” | 0567, 0568, 0929–0932 |
| 6 | Literal placeholder text published — noObject, noDescription | 0560, 0910 |
| 7 | ISO 3166 part 1 URI given for a part 2 code system; partial value set called “all codes” | 0347 |
| 8 | “All codes” used where the value set enumerates 2–3 UCUM codes — affects how all 438 value set blocks translate to ValueSet.compose | 0929–0932 |
| 9 | Two pairs of tables are duplicates of each other | 0567/0929, 0568/0930 |
| 10 | Five concept domains given two different descriptions within the chapter | 5 domains |
| 12 | Two table headings styled Normal instead of Heading 3, so absent from the chapter's own TOC | 0685, 0767 |

_Generated 2026-09-16 by `tooling/scripts/render_utg_briefing.py`. Edit the module, not this file._
