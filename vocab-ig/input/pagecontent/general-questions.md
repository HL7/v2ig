Questions this guide has had to answer in order to produce anything at all,
where the answer is a judgement rather than a fact, and where somebody other
than us should confirm it.

Each one says **what this build currently does**, so that a reader is never
guessing, and **what we would change** if the answer comes back differently.
None of them is blocking: every question below has a defensible working answer
already applied.

One is for **TSMG**, because it is about the artifact versioning policy. The
rest are for **V2 Management**, because they are about what Chapter 2C says.

---

### For TSMG — the versioning policy

**Settled: a description difference is always a major increment.** The
published CodeSystem policy qualifies the rule — *"major unless only change is
improved clarity or perform editorial corrections"* — but that qualification
was left in the policy by error. There is no editorial exemption and no
improved-clarity exemption: every qualifying change increments. The CodeSystem
and ValueSet policies agree with each other on this, and the absence of the
qualification from the ValueSet policy is not an asymmetry to be read into.

**What that costs here: eleven artifacts increment for this reason alone**, all
`3.0.0` → `4.0.0` — CodeSystems 0083, 0367, 0389 and 0434, and ValueSets 0083,
0367, 0389, 0434, 0496, 0952 and 0959. All but one turn on a comma, almost
always `(i.e.` becoming `(i.e.,`. The exception is value set 0952, where the
whole difference is whitespace: a space before a full stop, and a doubled space
mid-sentence. The per-table ledger marks each one, saying that the two texts
contain the same words in the same order and differ only in punctuation, and
that it increments regardless.

The same rule applies without qualification to concept definitions and concept
displays, which the policy already lists unqualified, so nothing about them is
now exceptional.

**Version outcomes across the corpus:** code systems — 2 first publications, 58
incremented, 339 unchanged. Value sets — 9 first publications, 23 incremented,
392 unchanged.

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

**This is now the only rule behind the version numbers that rests on a
judgement rather than a fact.** Every other increment in this build follows
from a difference the policy names outright.

**If the answer is no:** nothing changes. **If the answer is yes:** it is one
line in the comparison, and 32 more artifacts increment.

---

### For V2 Management — what the chapter says

#### 2. The concept status `B`, and where these letters should be defined

Chapter 2C carries its own legend for the status column:

| Code | Chapter 2C's meaning |
|---|---|
| *(empty)* | active code |
| `B` | backwards-compatible use only |
| `D` | deprecated or inactive |
| `R` | retired |
| `N` | new in this release |

Empty, `D` and `R` have unambiguous FHIR equivalents and are written as
`active`, `deprecated` and `retired`.

**`N` is settled: it is written as `active`, as a technical correction.** Three
things together decide it. "New in this release" is a provenance note, not a
status. It decays — nothing updates it after the release that set it, so a
letter printed in 2.9.1 is already a claim about some earlier release. And it
is not a value of the standard FHIR concept-status property this guide writes
it into, at `http://hl7.org/fhir/concept-properties#status`, whose own
definition reads *"a code that indicates the status of the concept. Typical
values are active, experimental, deprecated, and retired."* A code marked `N`
is in every case an active code, so `active` says what the chapter means, in
the same vocabulary `D` and `R` already use. This is not a new treatment: the
guide already publishes `active` for 205 concepts where THO still says `N` and
the current chapter says nothing, and the correction now also reaches concepts
inherited whole from THO. **No `N` survives anywhere in the output**, and that
departure from THO is recorded in the merge report rather than absorbed
silently.

**`B` is not settled, and is deferred for case-by-case review.**
"Backwards-compatible use only" is a real statement about a code and it has no
obvious FHIR equivalent: not `deprecated`, because the code is still correct
for existing senders; not `retired`; and not plainly `active` either, because
the restriction is real. Four concepts carry it into the output — table 0003
*Event* code `O57`, and table 0357 *Message Error Condition Codes* codes `204`,
`205` and `206`. **So this guide knowingly publishes four `status` values that
are not in the property's value set.** That is stated here rather than left for
a reader to notice.

**What we need, in two parts:**

1. **Rule on `B`, per concept.** Four concepts is a review, not a policy. For
   each, say whether the FHIR status should be `active`, `deprecated`, or
   `active` with a separate marker recording the backwards-compatibility
   restriction.
2. **Decide where, if anywhere, these letters should be defined.** Even with
   `N` resolved by mapping, THO still publishes concepts carrying `N` and `B`
   as literal status values, against a property whose definition admits
   neither, and no value set enumerates them. Defining them in
   `utg-concept-properties` would at least make what is already published
   legal. Replacing `N` with a non-decaying "version introduced" property would
   be better, and the chapter already records that fact in prose elsewhere.

#### 3. Table 0560 — a code system the chapter says does not exist

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

#### 4. Three OIDs where one number would end up naming two artifacts

| Artifact | Chapter 2C | THO |
|---|---|---|
| `CodeSystem/v2-0001` | `2.16.840.1.113883.18.458` | `2.16.840.1.113883.18.2` |
| `ValueSet/v2-0719` | `2.16.840.1.113883.1.11.20429` | `2.16.840.1.113883.1.11.20428` |
| `ValueSet/v2-0078` | `2.16.840.1.113883.1.11.78` | *(THO publishes no such artifact)* |

The first two are the only disagreements in the corpus where both sides give an
OID for the same resource: 395 of 396 code system OIDs and 411 of 412 value set
OIDs are identical on both sides. The third is different in kind and is
described below.

Neither of the first two is a mistyped digit, and it is worth being precise
about what each one actually is:

- **`v2-0001`** — the chapter's block is titled *Jurisdiction Gender Code
  System*, not *Administrative Sex*, and `...18.458` resolves to nothing
  anywhere in THO. So this may be a disagreement about *which code system*
  table 0001 points at, rather than about a number. It is also the most widely
  implemented table in V2.
- **`v2-0719`** — both OIDs are **v3** value set OIDs and both are in use.
  `...20428` belongs to `InformationSensitivityPolicy`, `...20429` to
  `ActInformationSensitivityPolicy`. THO's `ValueSet/v2-0719` **shares**
  `...20428` with THO's own `v3-InformationSensitivityPolicy` — one OID on two
  artifacts — which fits THO's own note that 0719 "was created in THO in error
  due to an oversight in the import processing." The question is which v3
  value set table 0719 corresponds to.

**`ValueSet/v2-0078` *Interpretation Codes* is different in kind: this guide
creates it, THO does not.** Chapter 2C gives table 0078 the canonical
`http://terminology.hl7.org/ValueSet/v2-0078`, at which THO publishes nothing,
together with the value set OID `2.16.840.1.113883.1.11.78`. That OID is not
free. THO's `ValueSet/v3-ObservationInterpretation` already carries it, on a
value set whose content logical definition is **byte-identical** to the one
written here — a single bare include of
`CodeSystem/v3-ObservationInterpretation`, no filter, no enumerated concepts.
So publishing the chapter's canonical with the chapter's OID puts **one OID on
two artifacts**, which is the same breach the 0719 case already shows.

**Two further OID-sharing cases sit inside THO itself**, and are worth naming
because they establish that this shape is not unique to the tables above:
`2.16.840.1.113883.21.452` is the identifier on both `ValueSet/v2-0567` and
`ValueSet/v2-0929`, and `2.16.840.1.113883.21.453` on both `ValueSet/v2-0568`
and `ValueSet/v2-0930`.

**Why a version increment cannot settle any of this.** An OID is an
`identifier`, and the versioning policy puts identifiers outside the version
system altogether: *"Cannot change or remove a ... identifier ... You must
create a new [artifact] for identifier changes."* So whichever number in each
pair is wrong, the remedy is not a version bump, and publishing the other one
at the same canonical is not something a new version can express.

**What we do:** publish **THO's** OID for 0001 and 0719, and report the
conflict. This is the one place where the chapter does not win a disagreement,
and deliberately so — an identifier is identity rather than content, and the
canonical URL is THO's. For 0078 the chapter's OID is published, because there
is no THO artifact at that canonical to defer to.

**What we need.** These look most like **technical corrections** rather than
substantive changes — non-controversial changes that alter a document so that
it says what the work group intended it to say. If that is right, each can be
handled as an erratum against whichever source is wrong, without any version
consequence. Please confirm that reading and adjudicate per artifact: for 0001,
which of `...18.458` and `...18.2` is the registered identifier for the
Administrative Sex code system; for 0719, which of `...20429` and `...20428` is
right; and for 0078, whether the chapter's canonical should be published at all
given that THO already publishes the same content at
`v3-ObservationInterpretation` under that OID.

A further option has been raised for 0001 — publishing *both* OIDs as
identifiers, since `identifier` is `0..*`. It avoids choosing before you have,
but two identifiers assert that both OIDs name this artifact, which is
demonstrably false for 0719, where `...20429` names a different v3 value set
that THO also publishes. It may be right for 0001, where the two could be one
code system under two registrations. Please rule per artifact rather than as a
blanket policy.

#### 5. Two descriptions where THO says more than the chapter

These are the two description differences that are **not** punctuation, and
both are cases where THO's text carries something the chapter's does not:

- **`ValueSet/v2-0227`** — THO's description ends with a link to the code
  system on PHIN VADS. The chapter's description stops before it. Publishing
  the chapter's drops a working source reference.
- **`ValueSet/v2-0719`** — THO's description ends *"Note that this resource
  was created in THO in error due to an oversight in the import processing."*

These read as one question and are two, and only one of them is still open.

**0227 — settled.** The chapter's text here is one of the sixteen truncated
value set descriptions: it stops mid-word, and THO's continues and completes
the sentence. That is not the two sources disagreeing, it is the chapter being
incomplete, so THO's fuller text is published and the source reference
survives. The rule is general rather than a decision about this one table —
where the chapter's description is a prefix of THO's *and* stops mid-sentence,
THO holds the words the chapter lost. Exactly two descriptions in the chapter
are a prefix of THO's, and this is the only one that stops mid-sentence.
Recovering the text also means there is no longer a difference to increment
for, so this value set keeps THO's version rather than moving past it.

**0719 — open, and the description is not really the question.** Here the
chapter's text is complete and THO has *appended* a sentence recording its own
error, so the rule above does not reach it and the chapter's text stands. The
note THO carries documents a defect that goes further than the wording: 0719
also shares its identifier with `v3-InformationSensitivityPolicy`, which is one
of the cases in question 4. The question is whether the artifact should be
**retired in THO altogether**, and it should be settled together with the
identifier rather than as a matter of which sentence to publish.

#### 6. Chapter 2C gives every table its own OID, and we publish it nowhere

Chapter 2C carries **three** OIDs per table, in three separate metadata blocks,
identifying three different things:

| Chapter 2C block | Arc | Tables | Published to |
|---|---|---:|---|
| Table OID | `2.16.840.1.113883.12.*` | 798 | **nothing** |
| Code System OID | `2.16.840.1.113883.18.*` | 435 | `CodeSystem.identifier` |
| Value Set OID | `2.16.840.1.113883.21.*` | 438 | `ValueSet.identifier` |

The last two have an obvious home, and THO uses the same two arcs for the same
two resource types, so the comparison behind question 4 is like for like.

**The table OID has no home.** In V2 the table is the thing with an identity.
In FHIR that table becomes a code system *and* a value set, and neither of them
*is* the table — so there is no resource for the `.12` OID to sit on.

**Decided: the table OID stays out of the CodeSystem and ValueSet resources for
now.** None of the available homes is free. `CodeSystem.identifier` says the
code system is the table, which is wrong for the 24 value-set-only tables whose
codes belong to another authority. Putting it on *both* resources asserts one
identifier for two artifacts — the same shape as the defect in question 4. The
concept domain concept has no `identifier` element to hold it.

**An extension on both resources is kept as a documented option**, should V2
Management require the table OID to be preserved somewhere in the FHIR
resources. It is deliberately **not** a second `identifier`: two identifiers on
one resource assert that both OIDs name that artifact, and the table OID does
not name the code system or the value set — it names the table they were
derived from. An extension can say "this artifact came from table *n*" without
making that claim. It would have to be newly minted: no extension for this
exists in the THO snapshot. The snapshot defines nine extensions in total, none
of them identifier-bearing, and the only extensions in use on THO's code
systems and value sets are the standard work-group, FMM, standards-status,
normative-version, artifact-version and extensible-value-set extensions, plus
THO's own `ext-mif-assocConceptProp`.

Two things worth knowing before ruling. 50 of the 798 are not identifiers at
all — they are the bare arc root `2.16.840.1.113883.1` with no leaf, on the 50
tables the chapter types *undefined*. And the table OID is not dead: THO's own
description of table 0227 cites PHIN VADS by the `.12.227` table OID, so
implementers do resolve these.

**What we need, narrowly:** does V2 Management require the table OID to be
preserved in the FHIR resources at all? If it does, the extension is the shape
we would use, and the question of who defines it follows. If it does not, the
current behaviour becomes a ruling rather than a default.

#### 7. Table 0292 — published against the chapter's own flag, pending a ruling

Chapter 2C flags table 0292 *Vaccines Administered* `Concept Domain Only: yes`,
which would mean no code system and no value set. The table metadata grid a few
lines further down **in the same section** gives `Full Name: Vaccines
Administered Code System` and `URI: http://hl7.org/fhir/sid/cvx`. Both
statements are published and they cannot both be acted on: a concept domain has
no code system and no value set, and a table that prints a code system
canonical is not a concept domain.

**What we do:** treat the grid as right and the flag as wrong. 0292 is
published **value set only**, its value set composing over
`http://hl7.org/fhir/sid/cvx`. Four independent signals point the same way:

- THO publishes `ValueSet/v2-0292`, `status: active`, whose entire compose is a
  single bare include of `http://hl7.org/fhir/sid/cvx` — exactly the canonical
  the chapter prints.
- `NamingSystem/CVX` registers table 0292's own table OID,
  `2.16.840.1.113883.12.292`, against that URI, and calls the URI the "official
  canonical URL going forward".
- The sibling table **0227** *Manufacturers of Vaccines (MVX)* — the other half
  of the same CDC vaccine pair, same steward, same `Full Name`-plus-`URI` shape
  — is flagged `Concept Domain Only: no` and is published exactly this way,
  over `http://hl7.org/fhir/sid/mvx`. Two halves of one pair should not be
  classified differently.
- Of the 14 tables the chapter types *External*, not one resolves to a code
  system of its own.

Minting a `CodeSystem/v2-0292` would be the wrong answer, and it is worth
saying so because it is the shape most of the corpus takes: the chapter
publishes zero codes for this table, so there would be nothing to put in it;
THO deliberately carries no CodeSystem for CVX, only the NamingSystem; and a
`v2-0292` code system would claim the table OID that `NamingSystem/CVX` has
already bound to the CDC's URI.

**This is a deliberate deviation and it is recorded as one.** It is the **only**
place in this build where the guide publishes something the chapter's own flag
contradicts while the question is still open. The deviation is tentative by
construction: it names this question, it is recomputed and counted on every
run so it cannot drift out of sight, and a ruling either way removes it. See
ADR-0011.

**What we need:** confirm that 0292 should be routed value set only over
`http://hl7.org/fhir/sid/cvx`, consistent with 0227, and that the
`Concept Domain Only: yes` flag is the error. **If the flag is authoritative,**
the deviation is withdrawn and 0292 reverts to concept domain only, with no
artifacts published for it.

---

### Where the rest of the detail is

- **[What this guide keeps from THO](tho-merge.html)** — the full class-by-class
  account of the merge, and what it does to version numbers.
- **[Known issues in this build](known-issues.html)** — defects in the build
  itself, as opposed to open questions about the content.
- **[Per-table ledger](table-ledger.html)** — one section per table: every
  difference from what THO publishes, and which open question touches it.
- **[Table index](table-index.html)** — per-table, which artifacts exist where.
