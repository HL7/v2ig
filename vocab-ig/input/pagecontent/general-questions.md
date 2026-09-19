Questions this guide has had to answer in order to produce anything at all,
where the answer is a judgement rather than a fact, and where somebody other
than us should confirm it.

Each one says **what this build currently does**, so that a reader is never
guessing, and **what we would change** if the answer comes back differently.
None of them is blocking: every question below has a defensible working answer
already applied.

Most are for **TSMG**, because they are about the artifact versioning policy.
The last few are for **V2 Management**, because they are about what Chapter 2C
says.

---

### For TSMG — the versioning policy

#### 1. Does reordering a code system's concepts count as a change?

**What we do:** no. Concepts are compared as a set keyed by code. A code
system whose codes are identical to THO's but listed in a different order is
treated as unchanged and keeps THO's version.

**Why:** order is not information in a flat code system. A `CodeSystem` with
`hierarchyMeaning` of `is-a` and no nesting says nothing by putting `M` before
`F`, and nobody reading the resource learns anything from the sequence.

**How much rides on it:** **32 tables** have exactly THO's codes in a
different order. If order is a change, those 32 all increment, and they
increment again every time the chapter is re-laid-out.

**If the answer is no:** nothing changes. **If the answer is yes:** it is one
line in the comparison, and 32 more artifacts increment.

#### 2. Is a punctuation-only difference in a description an editorial correction?

**What we do:** yes. Where our description and THO's contain exactly the same
words in the same order and differ only in punctuation or spacing, the
difference is recorded but does not increment the version.

**Why:** the policy for code systems says `CodeSystem.description` is *"Major
unless only change is improved clarity or perform editorial corrections"*. A
program cannot judge a rewording, but it can tell that no word changed, and
where no word changed no reader learns anything different.

**How much rides on it:** **12 descriptions across 7 tables.** Every one of
them is our `e.g.,` against THO's `e.g.`, or our `code system.` against THO's
`code system .`. Chapter 2C's punctuation is the better text in all 12, so
this guide publishes the chapter's and leaves the version alone.

**Where it does not apply:** where the words themselves differ. Two remain —
see question 8 — and both increment.

**If the answer is no:** the waiver is a single named function and a single
list of fields; turning it off increments those 12.

#### 3. Should the same carve-out reach concept definitions and displays?

**What we do:** no, because the policy does not offer it. The
editorial-correction carve-out is written against `CodeSystem.description`
alone. `CodeSystem.concept (and all subelements)` is listed with no
qualification, so a comma inside a concept definition is a change.

**The asymmetry this produces:** **4 concept definitions** and **21 concept
displays** differ from THO only in punctuation — the same kind of difference
that is waived at the description level — and every one of them increments its
artifact. A comma in a description is free; a comma in a display costs a major
version.

We have not smoothed this over, because the policy is explicit and because
guessing at an unwritten carve-out is how a pipeline quietly stops matching the
rules it claims to follow. But it looks more like an oversight than a decision.

#### 4. Is the ValueSet policy's missing carve-out deliberate?

**What we do:** we treat `ValueSet.description` exactly as we treat
`CodeSystem.description`, applying the same punctuation waiver.

**Why:** the Value Sets policy page has no editorial-correction carve-out at
all, so read literally it makes every description difference a major
increment, however trivial. Building logic that depends on that asymmetry
would mean encoding what we believe to be a drafting slip.

**If the asymmetry is deliberate:** the two resource types split, and the
value set descriptions increment unconditionally.

---

### For V2 Management — what the chapter says

#### 5. What are the concept statuses `N` and `B`, and where should they be defined?

Chapter 2C carries its own legend for the status column:

| Code | Chapter 2C's meaning |
|---|---|
| *(empty)* | active code |
| `B` | backwards-compatible use only |
| `D` | deprecated or inactive |
| `R` | retired |
| `N` | new in this release |

Empty, `D` and `R` have unambiguous FHIR equivalents and are written as
`active`, `deprecated` and `retired`. `N` and `B` do not, and are passed
through as themselves, which is what THO already does.

**The problem is that `N` and `B` are defined nowhere but in that legend.**
The property they are written to is `status`, defined by FHIR at
`http://hl7.org/fhir/concept-properties#status`, whose own definition reads
*"A code that indicates the status of the concept. Typical values are active,
experimental, deprecated, and retired."* Neither `N` nor `B` is among them.
They are not in `utg-concept-properties` either, and no value set enumerates
them. Across the whole of THO they appear **only** in v2 code systems — 210
concepts carry `N` and 6 carry `B`.

**`N` is worse than undefined, because it decays.** "New in this release" was
a statement about whichever release first printed it. Nothing updates it
afterwards. That is visible in the data: THO carries 210 concepts marked `N`
from past releases, while the 2.9.1 chapter marks only 70, and **205 concepts
differ from THO on status for exactly this reason** — THO still says `N` where
the current chapter says nothing, so this guide publishes `active`.

Three things would each resolve it, and they are not the same decision:

1. Define `N` and `B` as properties in `utg-concept-properties`, so that what
   is already being published is at least legal.
2. Replace `N` with something that does not decay — the version a concept was
   introduced in, which is a fact that stays true, rather than a flag that
   silently expires.
3. Rule that `N` is not a status at all and should not survive into FHIR.

**What we do meanwhile:** publish the chapter's value, pass `N` and `B`
through unchanged, and record all 261 status disagreements.

#### 6. Table 0560 — a code system the chapter says does not exist

Chapter 2C gives table 0560 a code system block whose symbolic name is
`noObject`, whose OID is `-` and whose description is `noDescription`. Read
literally, the table has no code system. Read in full, the same section:

- lists **five codes** — `FL` Units, `HS` Hours, `DY` Days, `MN` Month,
  `YY` Years;
- gives a **value set OID**, `2.16.840.1.113883.21.380`, and the symbolic name
  `hl7VS-quantityUnits`;
- says in its own metadata that the table has **"No suggested values"**, which
  the five codes directly contradict;
- names the code system **"Name Representation Code System"**, which belongs
  to a different table entirely.

Meanwhile **THO already publishes both artifacts** — `CodeSystem/v2-0560` with
those same five codes at OID `2.16.840.1.113883.18.455`, and `ValueSet/v2-0560`
at the OID the chapter gives.

**What we do:** publish the code system and the value set as the chapter's
content describes them. The `noObject` marker is treated as a defect in the
chapter rather than a statement about the table, on the evidence of the codes,
the value set OID, and THO's existing artifacts agreeing with each other and
disagreeing with the marker. The code system's name, title and OID are taken
from THO, since the chapter supplies only placeholders for all three. See
ADR-0009.

**What we would like:** the chapter's 0560 section corrected — the placeholder
block replaced with the real code system, the "No suggested values" note
removed, and the copied-in code system name fixed.

#### 7. Two OIDs where Chapter 2C and THO disagree

| Artifact | Chapter 2C | THO |
|---|---|---|
| `CodeSystem/v2-0001` | `2.16.840.1.113883.18.458` | `2.16.840.1.113883.18.2` |
| `ValueSet/v2-0719` | `2.16.840.1.113883.1.11.20429` | `2.16.840.1.113883.1.11.20428` |

These are the **only two** disagreements in the corpus: 395 of 396 code system
OIDs and 411 of 412 value set OIDs are identical on both sides.

Neither is a mistyped digit, and it is worth being precise about what each one
actually is:

- **`v2-0001`** — the chapter's block is titled *Jurisdiction Gender Code
  System*, not *Administrative Sex*, and `...18.458` resolves to nothing
  anywhere in THO. So this may be a disagreement about *which code system*
  table 0001 points at, rather than about a number.
- **`v2-0719`** — both OIDs are **v3** value set OIDs and both are in use.
  `...20428` belongs to `InformationSensitivityPolicy`, `...20429` to
  `ActInformationSensitivityPolicy`. THO's `ValueSet/v2-0719` **shares**
  `...20428` with THO's own `v3-InformationSensitivityPolicy` — one OID on two
  artifacts — which fits THO's own note that 0719 "was created in THO in error
  due to an oversight in the import processing." The question is which v3
  value set table 0719 corresponds to.

This is not an ordinary disagreement. An OID is an `identifier`, and the
versioning policy puts identifiers outside the version system altogether:
*"Cannot change or remove a ... identifier ... You must create a new
[artifact] for identifier changes."* So whichever of each pair is wrong, the
remedy is not a version increment — and publishing the other one at the same
canonical is, by the policy's own terms, not something a new version can
express.

**What we do:** publish **THO's** OID in both cases, and report the conflict.
This is the one place where the chapter does not win a disagreement, and
deliberately so — an identifier is identity rather than content, the canonical
URL is THO's, and writing the chapter's OID there would assert that this is a
different artifact rather than publish the chapter faithfully. Neither is
therefore a version question. Both are in the escalation register as
`esc-oid-conflicts`, which is where the adjudication belongs.

**A third option has been raised:** publish *both* OIDs as identifiers.
`identifier` is `0..*` on both resource types, so it is available, and it
avoids choosing before you have. It is not obviously right — two identifiers
assert that both OIDs name this artifact, which for 0719 is demonstrably false,
since `...20429` names a different v3 value set that THO also publishes. It may
well be right for 0001, where the two could be one code system under two
registrations. **Please rule per artifact rather than as a blanket policy.**

#### 8. Two descriptions where THO says more than the chapter

These are the two description differences that are **not** editorial, and both
are cases where THO's text carries something ours does not:

- **`ValueSet/v2-0227`** — THO's description ends with a link to the code
  system on PHIN VADS. The chapter's description stops before it. Publishing
  the chapter's drops a working source reference.
- **`ValueSet/v2-0719`** — THO's description ends *"Note that this resource
  was created in THO in error due to an oversight in the import processing."*
  That is THO documenting its own mistake, and it is not something Chapter 2C
  should inherit — but it does suggest the artifact needs attention rather
  than a redraft.

**What we do:** publish the chapter's description in both cases and increment,
because the merge fills an absent value but never splices two pieces of prose
together — that would be writing text neither source wrote. Both are listed
for a decision.

#### 9. Chapter 2C gives every table its own OID, and we publish it nowhere

Chapter 2C carries **three** OIDs per table, in three separate metadata blocks,
identifying three different things:

| Chapter 2C block | Arc | Tables | Published to |
|---|---|---:|---|
| Table OID | `2.16.840.1.113883.12.*` | 798 | **nothing** |
| Code System OID | `2.16.840.1.113883.18.*` | 435 | `CodeSystem.identifier` |
| Value Set OID | `2.16.840.1.113883.21.*` | 438 | `ValueSet.identifier` |

The last two have an obvious home, and THO uses the same two arcs for the same
two resource types, so the comparison behind question 7 is like for like.

**The table OID has no home.** In V2 the table is the thing with an identity.
In FHIR that table becomes a code system *and* a value set, and neither of them
*is* the table — so there is no resource for the `.12` OID to sit on. It is
therefore carried by nothing this guide publishes.

**What we do:** nothing, which is the default rather than a decision. That may
be the right answer, but it should be ruled on: these are published identifiers
in the chapter, and their absence from the FHIR artifacts is silent.

Two things worth knowing before ruling. 50 of the 798 are not identifiers at
all — they are the bare arc root `2.16.840.1.113883.1` with no leaf, on the 50
tables the chapter types *undefined*. And the table OID is not dead: THO's own
description of table 0227 cites PHIN VADS by the `.12.227` table OID, so
implementers do resolve these.

None of the available homes is free. `CodeSystem` says the code system is the
table, which is wrong for the 24 value-set-only tables whose codes belong to
another authority. *Both* resources asserts one identifier for two artifacts —
the same shape as the defect in question 7. The concept domain concept has no
`identifier` element to hold it. Registered as `esc-table-oid-unpublished`.

---

### Where the rest of the detail is

- **[What this guide keeps from THO](tho-merge.html)** — the full class-by-class
  account of the merge, and what it does to version numbers.
- **[Known issues in this build](known-issues.html)** — defects in the build
  itself, as opposed to open questions about the content.
- **[Per-table ledger](table-ledger.html)** — one section per table: every
  difference from what THO publishes, and which open question touches it.
- **[Table index](table-index.html)** — per-table, which artifacts exist where.
