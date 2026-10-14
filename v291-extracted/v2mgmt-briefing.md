# V2.9.1 Chapter 2C terminology — Executive briefing for V2 Management

**2026-09-23**

We have extracted the whole of Chapter 2C — **799 tables, 5,540 codes** — and turned it into FHIR CodeSystems and ValueSets. The extraction and text-fidelity pass is **complete and reviewed**. Nothing is outstanding on our side.

**Since we last met on 28 August, it builds as an implementation guide.** **824 artifacts** — 399 CodeSystems, 424 ValueSets and the concept domains — generate and validate through the IG Publisher, with **zero broken links across 625,068 checked**. You can open it and follow any claim on this page to the evidence behind it. **It is not a published IG** — publication is a status conferred by the HL7 process, and nothing here has been through it.

**It is additive with respect to THO.** We publish at THO's own canonical URLs, so a naive load would silently delete anything THO carries that Chapter 2C is silent about. It does not: **7,588 values that exist only in THO are preserved**, and **733 of 819 artifacts keep THO's existing version number** because nothing about them actually changed.

The work is destined for **THO**, and it establishes a corrected baseline for v2 terminology there. It was walked through with the **Terminology Infrastructure WG on 21 September**; the canonical URLs and the merge route are agreed, and TSMG settled the one versioning question that was still open.

**What we need from V2 Management is one ruling, one confirmation, one steer, and a stack of acknowledgements.** The ruling — reproduce or correct — has been outstanding since August and is now the only thing genuinely blocking us. The second item has changed shape: we found the guide was not making the arbitrary choice an earlier draft of this page told you it was, so it needs confirming rather than deciding. Nothing new has been added since the last meeting.

## If you read one thing

1. **[BLOCKS US]** When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?  
   _Ask:_ Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. **If the full question is too broad for the time available, the narrow one would unblock most of the list:** may we treat the editing-process defects as technical corrections, leaving only the genuinely substantive ones for a ballot? The guidance notes that where there is doubt a Work Group may ask the TSC to rule.
2. **[NEEDS A RULING]** Chapter 2C and THO define the same concept domains differently. THO wins — confirm that.  
   _Ask:_ Confirm the rule rather than the instances: **where THO already carries a definition for a concept domain, THO's definition stands and Chapter 2C's competing wording is not carried into THO.** That settles all four above and the 582 domains behind them in one answer. If you want the chapter's wording preserved somewhere rather than dropped, say so now — that is a different question and it has the same deadline as the one below.

## Chapter 2C publishes a lot about each table that a CodeSystem and a ValueSet have nowhere to put. How much of it do you want kept?

Not a defect — a design question, and the only one on this page with a deadline attached. Once this content is in THO, whatever we did not carry across is not recoverable from the resources.

We mapped every field the chapter publishes about a table against the FHIR resources we generate. **Of 43 fields, 24 reach no resource at all.** Some plainly do not matter. Others are real information with no obvious FHIR home:

| Field | Tables | Comment |
| --- | --- | --- |
| **Table Description** | 799 | Describes the table as a whole. For the 362 tables with no code system block, it is the only prose the chapter offers. |
| **Type** | 799 | `User` vs `HL7` and the rest — a real distinction with conformance consequences, and one implementers ask about. |
| **where used** | 779 | The fields a table is bound to, `PID-8` and so on. The link between the vocabulary and the rest of the standard. |
| **HL7 Version Introduced** | 607 | Which release the table first appeared in. |
| **Code System Full Name** | 437 | A human-readable label. `title` already carries the symbolic name, so there is no room for it. |
| **Version, Effective Date** | 426 | The chapter's own version and date for the code system. We currently inherit THO's instead — and THO's date is a bulk-load date, so **the chapter has the better information and we are discarding it**. |

Each of these could be preserved as a concept property or an extension, but every one we add is a thing THO has to carry forever, so it is worth being deliberate rather than exhaustive.

**Ask:** You do not need to answer field by field today. What we need is a steer: **is the intent that a FHIR consumer can recover what Chapter 2C says about a table, or only the codes it defines?** That one answer tells us whether to design extensions for the list above or to record the loss and move on. The full mapping, with all 43 fields and counts, is a separate document we can circulate.

Not table-specific — it applies to all 799, and decides what a FHIR consumer can recover about any of them.

- [The same question for one field, the per-table OID, with what we do today](../vocab-ig/output/open-items.html#gq-chapter-2c-gives-every-table)
- [What the guide does carry, table by table](../vocab-ig/output/table-index.html)

## Already settled — here so they are not raised twice

- **Concept order does not cost a version number** (32 tables) — Chapter 2C and THO often carry exactly the same codes in a different order, and the versioning policy could be read literally as making that a change. **TSMG settled it on 21 September: reordering is not a change and does not increment the version.** That confirmed what we were already doing, so no version number moved. Recorded because it was the last rule behind the version numbers resting on our reading of the policy rather than on a ruling. No action from V2 Management.
- **Most of the differences from THO were never disagreements** (489 → 202) — The review listed **489 differences** from what THO publishes, each framed as something a committee might have to adjudicate. On inspection **287 of them were not questions at all**: 211 are THO recording the V2 status letter where we record the FHIR status it maps to, and 76 are the same words with different punctuation, spacing or capitalisation. **202 genuine disagreements remain**, and they are no longer crowded out. Nothing was suppressed — the 287 are still listed, under a heading that says they need no decision.
- **Five concept displays now follow THO's capitalisation** (0203, 0396) — Where THO and the chapter agree on the words and differ only in case, and THO is the more capitalised side, we now publish THO's form — `GKV`, `KZVA`, `PKV`, `ZANR` and `DAR`. A deliberate exception to chapter-wins, taken because the words are identical so the chapter loses nothing. **No version moved.** The reverse case is not treated symmetrically: where THO is the _less_ capitalised side we surface it rather than absorb it, because a correct lower-casing and a lost proper noun look identical to a machine.

## The two at the top of your list

### 1. When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?

This is the ruling we most need. It sets the default for every other item on this page, and we cannot generate the affected tables until it is answered.

Our governing requirement has been fidelity — publish exactly what Chapter 2C publishes. That is easy while the differences are typographic. It stops being easy when the content is wrong:

- **Table 0931 Temperature Units** publishes `degF`, which is not a valid UCUM code, beside the valid `[degF]` that means the same thing. The chapter's own comment on it says “typo”.
- **Table 0560 Quantity Units** publishes five codes of which four are units of _time_ — Hours, Days, Month, Years.

**THO has already answered this differently in the two cases**, which is why it needs settling rather than assuming. For 0931 THO _corrected_ — its value set drops the bad code and folds the history into the display text. For 0560 THO _reproduced_ the same error the chapter has. So the two bodies have diverged on the principle at least once, and THO has diverged from itself.

**HL7's own errata guidance may already answer most of this, and would let you give us a narrow answer instead of a broad one.** It defines a technical correction as a non-controversial change that makes a document say what the Work Group intended, typically repairing normative content that was “not made, incorrectly made, or inconsistently made during the editing process”. That test splits our list cleanly in two. The _editing-process_ defects — 0821's grid emptied in publication, the truncated descriptions, the links to rendered pages where canonical URLs belong, the missing spaces — are technical corrections on that definition. The _content_ defects — 0931's invalid UCUM code, 0560's time units — change what the standard means, and the same guidance requires a substantive change to normative content to be balloted.

**Ask:** Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. **If the full question is too broad for the time available, the narrow one would unblock most of the list:** may we treat the editing-process defects as technical corrections, leaving only the genuinely substantive ones for a ballot? The guidance notes that where there is doubt a Work Group may ask the TSC to rule.

**Affected tables:** 0560, 0821, 0931

The three instances the argument rests on. The ruling asked for is on the principle, and it reaches every class further down this page.

- [Table 0560, as its own question with what we publish today](../vocab-ig/output/open-items.html#gq-table-0560-a-code-system)
- [The register: 37 open items, each with its affected tables](../vocab-ig/output/open-items.html)

### 2. Chapter 2C and THO define the same concept domains differently. THO wins — confirm that.

**This is no longer blocking.** An earlier draft of this page said we were choosing between competing definitions by document order, and that was wrong. It stays at the top because it decides what does and does not get carried into THO, which is expensive to revisit.

**THO already defines most of these domains, and where it does, we keep THO's definition.** Chapter 2C names **760 concept domains**; **THO already has a definition for 582 of them**. Our rule is that THO's definition stands and the chapter's competing wording is recorded rather than published.

**So the five domains declared by more than one table are not actually a choice we are making.** All five — `DeviceStatus`, `DeviceType`, `Modality`, `QuantityUnits`, `VolumeUnits` — already have a THO definition, and that is what we publish. **Every domain whose tables describe it differently has a THO definition to fall back on**, so document order never decides an outcome. The earlier claim that it did is withdrawn.

To be exact, because the weaker version of this is not true: **26 domains are declared by more than one table and 20 of those have no THO definition** — but in all 20 the tables agree with each other, so there is nothing to choose between. The five where the tables genuinely conflict all have a THO definition.

**What is real is the disagreement itself.** After the shared text policy is applied, **four domains have a chapter definition that substantively disagrees with THO's**:

| Concept domain | THO says | Chapter 2C says |
| --- | --- | --- |
| `Country` | Countries of the world. ISO 3166, part 1, alpha-3 set. | “the type of Country” |
| `EmploymentStatus` | A code used to define the employment status of the insured individual identified in UB-92 FL 58. | “the guarantor's employment status” |
| `ObservationMethod` | A code that provides additional detail about the means or technique used to ascertain the observation. | “the type of Observation Method” |
| `ContainerForm` | Describes the nature (or type) of the container, with examples. | “shape or type of the container”, with a different example list. |

**In three of the four, THO's definition is plainly the better one** — the chapter's is a restatement of the domain's own name (“the type of Country”). That is a pattern worth noticing rather than four separate incidents. **A further seven domains differ from THO only in punctuation or markup** — including `Confidentiality`, which an earlier draft of this page listed above as a substantive disagreement and which is not one. They are recorded but there is nothing in them to decide.

**Ask:** Confirm the rule rather than the instances: **where THO already carries a definition for a concept domain, THO's definition stands and Chapter 2C's competing wording is not carried into THO.** That settles all four above and the 582 domains behind them in one answer. If you want the chapter's wording preserved somewhere rather than dropped, say so now — that is a different question and it has the same deadline as the one below.

**Affected tables:** 0259, 0560, 0568, 0602, 0604, 0657, 0682, 0777, 0930, 0961, 0962

The eleven tables that declare the five multiply-declared domains between them.

- [The register, where the competing definitions are set out in full](../vocab-ig/output/open-items.html)

## Defects in the published chapter, by class

### Value Set descriptions that stop mid-word — 16 tables

Table 0227's value set description ends _“… and the code system may be acce”_. Sweeping the corpus found **sixteen descriptions that stop without punctuation, every one between 242 and 252 characters**. Nothing else behaves this way — code system descriptions in the same tables run past 500 characters and end in complete sentences. It is a length cap of about 250 characters applied to one field somewhere in the publication toolchain.

**This is the only defect on this page that reaches the generated resources.** The Value Set Description becomes `ValueSet.description`, so sixteen published FHIR resources will carry a sentence that stops mid-word unless the text is recovered.

**We checked whether THO could supply the missing text. It cannot:** all sixteen tables have a ValueSet in THO, all sixteen carry a description, and **fifteen are truncated at exactly the same character**. The same clipped field fed both documents, so the truncated text is already published in THO as well as in the chapter.

**The exception is the useful part.** THO's value set for 0227 continues past the cut with 171 more characters, completing the very word the chapter breaks in the middle of — _“may be accessed via”_ followed by the PHIN VADS link. So the full text survived somewhere for at least one of them, which is good reason to think the other fifteen exist too.

**Need:** **Please find out who holds the source these descriptions are generated from** — the loss is at publication, not at authoring, so the full text is likely intact upstream. Restoring it should be a technical correction rather than a ballot. Two riders: 0227's text is available from THO right now and we can restore it immediately if you say so; and because THO carries the same truncation, any fix has to be made in both places or the two will fork. All sixteen are listed in the register.

### Concepts whose code is nothing but punctuation — 17 tables, 23 codes

Noticed because table 0291's code system carries a concept whose code is a single ellipsis character. Scanning Chapter 2C and THO's v2 code systems for codes containing no letter or digit found **23 concepts across 17 tables**, in three quite different groups.

- **Four are genuine codes.** `*` in 0255 and 0505, `#` in 0505, `%` in 0523 — each with a real definition, such as _Indicates a percent change_. A single-character symbol is an awkward code but it is a code. **Leave these alone.**
- **Eighteen are an ellipsis placeholder minted as a concept.** Their display text gives them away: _No suggested values defined_, _user-defined codes_, _see chapter 3_. These were rows in a printed table saying “nothing here”, and they were loaded as though they were content. Nobody can send `...` in a message and mean anything by it.
- **Five tables carry that placeholder twice.** 0291, 0365, 0366, 0367 and 0418 each have `...` (three full stops) _and_ `…` (one ellipsis character) as two separate concepts with identical display text. In 0418 the ellipsis concept has no display text at all.

One oddity beyond the three groups: 0492's code is `??`, displayed _Inappropriate due to …_ — a truncated display beside what looks like a data-entry artefact.

**This is mostly THO's problem rather than the chapter's, and that is the interesting part.** Sixteen of the 23 exist only in THO, six in both, and one only in Chapter 2C. **Every duplicate pair is THO-only.** So the chapter has largely stopped publishing these and THO has gone on carrying them — which is exactly the drift this baseline exercise exists to correct.

**Need:** Acknowledgement that the placeholders were never concepts, and a view on retiring them. We are changing nothing for this release — these are live published code systems and retiring a code is the owners' call, jointly with TSMG. The cheapest useful outcome is agreeing the four symbol codes stay and the rest go on a retirement list.

### Content lost in publication — 2 tables

**0821 Gender Identity** publishes its coded content grid **completely blank** — six rows by five columns, every cell empty, while the section around it is fully populated. Six rows is a header plus five code rows, and THO's `ValueSet/gender-identity`, carrying the exact OID the chapter prints, holds exactly **five** concepts. The grid was meant to carry those five and lost them.

**0685 and 0767** have their headings styled `Normal` instead of `Heading 3`, so both are absent from the chapter's own table of contents and were invisible to extraction until we special-cased them.

**Need:** 0821 needs its five codes restored in a future publication. This is the one class where a reader of the PDF is actively misled — the table looks empty.

### Copy-paste errors in code system metadata — 9 tables

- **All six UCUM-backed tables** (0567, 0568, 0929–0932) name the code system _“Donation Duration Units Code System”_. Only 0932 is about donation duration, and the name is wrong even there — the code system is UCUM.
- **0560 and 0910** carry literal placeholder text: OID `-`, symbolic name `noObject`, description `noDescription`, and a full name copy-pasted from an unrelated table. These are a tool's way of saying “left blank”, and they were published.
- **0347 State/Province** correctly identifies ISO 3166 **part 2** and then gives the URI for **part 1**.

**Need:** Acknowledgement and a technical correction. None of these should be controversial, but all change published text, so they are not ours to make unilaterally.

### Tables that contradict themselves — 3 tables

**0560** says `Type: User` and “No suggested values”, and then lists five values — the same five that are units of time under a name about quantity.

**0931 and 0932** give their Content Logical Definition as “all codes” and then enumerate two or three UCUM codes. Against UCUM, “all codes” means every unit of measure there is. Tables 0929 and 0930 do the same thing and say “enumerated per table content”, which is right.

**Need:** Wording corrections. 0931 and 0932 should say what 0929 and 0930 say. 0560 is really the same question as blocker 1.

### Code system identity that looks wrong — 2 tables

**0459 Reimbursement Action Code** is labelled with the CMS OCE Edit Code symbolic name and OID, but its four codes are `0`–`3` with HL7-authored English displays. Those read as an HL7 enumeration _about_ OCE behaviour, not as CMS codes.

**0411 Supplemental Service Information** prints the URI `http://terminology.hl7.org/CodeSystem/v2-0411`. **No such resource exists in THO** — a dangling canonical in a published HL7 standard.

**Need:** 0459 needs its OID confirmed. 0411 needs the resource created in THO, or an explanation of why it never was.

### Concept domain definitions that differ from THO — 5 domains

Tables **0952, 0967, 0675, 0066, 0626**. For 577 of the 582 concept domains the two bodies share, Chapter 2C and THO agree word for word. These five do not.

Only 0952 is a near-match — it differs by formatting and a stray space. **The other four are wholly different texts**, which usually means the two bodies have attached different meanings to the same domain rather than phrasing one meaning two ways.

Distinct from blocker 2: that one is the chapter disagreeing with _itself_. This is the chapter disagreeing with THO.

**Need:** A joint decision with TSMG on the four. Picking a wording does not fix a disagreement about meaning.

### Typographic defects — already handled, no action — ~1,500 corrections

Doubled spaces, spaces before punctuation, missing spaces after periods, corrupt characters from Word, Symbol-font glyphs. Every one is corrected under a recorded decision, every change is logged with its before and after, and nothing was changed that a reviewer had not individually approved.

Mentioned only so it is on the record that the chapter's published text needed roughly 1,500 corrections at this level, and that they are reversible.

**Need:** Nothing. Listed for visibility.

## Where this is going

**Where this is going.** The output is not scoped to V2.9.1. We are using V2.9.1 as the source to establish a corrected _v2 baseline_ in THO, because the existing THO v2 content has more problems than what we are preparing. A subsequent effort will resolve the substantive terminology problems that go beyond this pass — keeping the two separate is what makes the second one reviewable.

**Method, briefly.** Two independent extractions of the same document — one character-faithful, one structural — agreeing on 740 of 799 tables, with every remaining difference adjudicated against the source. Every change to published text is recorded with the decision that authorised it, and can be reversed.

**The full detail** is in a register of 37 open items written for V2 Management and TSMG, which lists every affected table. This page is the executive cut; the register has the evidence for each item, and the register itself is now a page in the guide rather than a separate document, so every item can be followed to the artifact it is about. The field-by-field mapping behind the design question is still a separate document and can be circulated on request.

_Generated 2026-10-14 by `tooling/scripts/render_v2mgmt_briefing.py`. Edit the module, not this file._
