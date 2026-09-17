# V2.9.1 Chapter 2C terminology — Executive briefing for V2 Management

**2026-08-28**

We have extracted the whole of Chapter 2C — **799 tables, 5,540 codes** — and are turning it into FHIR CodeSystems and ValueSets. The extraction and text-fidelity pass is **complete and reviewed**. Nothing is outstanding on our side.

**Since we last met on 21 August, the resources exist.** The generator is built and produces **398 CodeSystems and 422 ValueSets**, every one of which validates against the IG Publisher with no errors. 329 of the value sets come out byte-identical to the ones UTG already publishes, without any tuning, which is the best evidence we have that the extraction is faithful.

The work is destined for **THO**, and it establishes a corrected baseline for v2 terminology there. The UTG subcommittee of TSMG is receptive; the canonical URLs and the merge route are agreed.

**What we need from V2 Management is two rulings, one new steer, and a stack of acknowledgements.** The two rulings are unchanged from last time and still outstanding. Building the resources turned up three further classes of defect, marked NEW below.

## If you read one thing

1. **[BLOCKS US]** When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?  
   _Ask:_ Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. **If the full question is too broad for the time available, the narrow one would unblock most of the list:** may we treat the editing-process defects as technical corrections, leaving only the genuinely substantive ones for a ballot? The guidance notes that where there is doubt a Work Group may ask the TSC to rule.
2. **[BLOCKS US]** Five concept domains are declared by more than one table, with a different definition each time  
   _Ask:_ Say which definition is correct for each of the five. We will take any of them — what we cannot do is keep choosing by document order.

## NEW — Chapter 2C publishes a lot about each table that a CodeSystem and a ValueSet have nowhere to put. How much of it do you want kept?

Not a defect — a design question, and the only one on this page with a deadline attached. Once this content is in THO, whatever we did not carry across is not recoverable from the resources.

We mapped every field the chapter publishes about a table against the FHIR resources we generate. **Of 43 fields, 24 reach no resource at all.** Some plainly do not matter. Others are real information with no obvious FHIR home:

| Field | Tables | Comment |
| --- | --- | --- |
| **Table Description** | 799 | Describes the table as a whole. For the 355 tables with no code system block, it is the only prose the chapter offers. |
| **Type** | 799 | `User` vs `HL7` and the rest — a real distinction with conformance consequences, and one implementers ask about. |
| **where used** | 779 | The fields a table is bound to, `PID-8` and so on. The link between the vocabulary and the rest of the standard. |
| **HL7 Version Introduced** | 607 | Which release the table first appeared in. |
| **Code System Full Name** | 437 | A human-readable label. `title` already carries the symbolic name, so there is no room for it. |
| **Version, Effective Date** | 426 | The chapter's own version and date for the code system. We currently inherit THO's instead — and THO's date is a bulk-load date, so **the chapter has the better information and we are discarding it**. |

Each of these could be preserved as a concept property or an extension, but every one we add is a thing THO has to carry forever, so it is worth being deliberate rather than exhaustive.

**Ask:** You do not need to answer field by field today. What we need is a steer: **is the intent that a FHIR consumer can recover what Chapter 2C says about a table, or only the codes it defines?** That one answer tells us whether to design extensions for the list above or to record the loss and move on. The full mapping, with all 43 fields and counts, is a separate document we can circulate.

## Already settled — here so they are not raised twice

- **Where the value sets are published** (0291, 0347, 0399, 0834) — We were minting canonical URLs of the form `…/v2-NNNN` for four tables that THO already publishes at `…/v2-notAllCodes-NNNN`. **Settled: a canonical is an identifier, and where one already exists it is the one to use**, whatever it looks like. Corrected; the four now match THO and UTG exactly. No action from V2 Management — recorded because it changed generated output.
- **Table 0227 Manufacturers of Vaccines** (0227) — The chapter declares a value set and no code system. Resolved: MVX is an external CDC code system that THO records as a NamingSystem and deliberately does _not_ publish a CodeSystem for. We compose a value set over the external system, which is correct and complete. No decision needed.
- **Concept-domain-only tables that also list codes** (0093, 0340, 0451) — Carried over from the last meeting because it was corrected there rather than answered. Not a contradiction — the V3 requirements for declaring a concept domain call for **example codes**, so these tables are correct as published. Where the examples should live is a representation question for TSMG, not a chapter defect.

## The two that block us

### 1. When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?

This is the ruling we most need. It sets the default for every other item on this page, and we cannot generate the affected tables until it is answered.

Our governing requirement has been fidelity — publish exactly what Chapter 2C publishes. That is easy while the differences are typographic. It stops being easy when the content is wrong:

- **Table 0931 Temperature Units** publishes `degF`, which is not a valid UCUM code, beside the valid `[degF]` that means the same thing. The chapter's own comment on it says “typo”.
- **Table 0560 Quantity Units** publishes five codes of which four are units of _time_ — Hours, Days, Month, Years.

**THO has already answered this differently in the two cases**, which is why it needs settling rather than assuming. For 0931 THO _corrected_ — its value set drops the bad code and folds the history into the display text. For 0560 THO _reproduced_ the same error the chapter has. So the two bodies have diverged on the principle at least once, and THO has diverged from itself.

**HL7's own errata guidance may already answer most of this, and would let you give us a narrow answer instead of a broad one.** It defines a technical correction as a non-controversial change that makes a document say what the Work Group intended, typically repairing normative content that was “not made, incorrectly made, or inconsistently made during the editing process”. That test splits our list cleanly in two. The _editing-process_ defects — 0821's grid emptied in publication, the truncated descriptions, the links to rendered pages where canonical URLs belong, the missing spaces — are technical corrections on that definition. The _content_ defects — 0931's invalid UCUM code, 0560's time units — change what the standard means, and the same guidance requires a substantive change to normative content to be balloted.

**Ask:** Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. **If the full question is too broad for the time available, the narrow one would unblock most of the list:** may we treat the editing-process defects as technical corrections, leaving only the genuinely substantive ones for a ballot? The guidance notes that where there is doubt a Work Group may ask the TSC to rule.

### 2. Five concept domains are declared by more than one table, with a different definition each time

A concept domain has one definition by definition. Two tables describing the same domain differently is a source defect we cannot adjudicate, and it is the only class here where we are currently emitting a guess.

We emit the **first description in document order**, purely to keep the output deterministic. That is a coin toss, not a judgement — and in at least two cases below the second description is clearly the better one.

| Concept domain | Tables | The competing definitions |
| --- | --- | --- |
| `DeviceStatus` | 0682, 0962 | “the state of a device” _vs_ “the availability status of a device” |
| `DeviceType` | 0657, 0961 | “the kind of device as defined by the manufacturer” _vs_ “what kind a particular device is … devices used in the medical field” |
| `Modality` | 0259, 0604 | “the imaging apparatus expected to be used … **removed from the standard as of 2.7 in favour of table 0910**” _vs_ “the type of Modality” |
| `QuantityUnits` | 0560, 0602 | “the adjustment quantity” _vs_ “the type of Quantity Units” |
| `VolumeUnits` | 0568, 0777, 0930 | “units of measure used to specify volume” _vs_ “the type of Volume Units” |

**Two of these are entangled with other items.** `Modality`'s first definition says the table was _removed from the standard as of 2.7_ — so we are currently publishing a withdrawn table's wording as the live definition. And `VolumeUnits` is declared by three tables, two of which (0568, 0930) are the deprecated/current pair below.

**Ask:** Say which definition is correct for each of the five. We will take any of them — what we cannot do is keep choosing by document order.

## Defects in the published chapter, by class

### NEW — Value Set descriptions that stop mid-word — 16 tables

Table 0227's value set description ends _“… and the code system may be acce”_. Sweeping the corpus found **sixteen descriptions that stop without punctuation, every one between 242 and 252 characters**. Nothing else behaves this way — code system descriptions in the same tables run past 500 characters and end in complete sentences. It is a length cap of about 250 characters applied to one field somewhere in the publication toolchain.

**This is the only defect on this page that reaches the generated resources.** The Value Set Description becomes `ValueSet.description`, so sixteen published FHIR resources will carry a sentence that stops mid-word unless the text is recovered.

**We checked whether THO could supply the missing text. It cannot:** all sixteen tables have a ValueSet in THO, all sixteen carry a description, and **fifteen are truncated at exactly the same character**. The same clipped field fed both documents, so the truncated text is already published in THO as well as in the chapter.

**The exception is the useful part.** THO's value set for 0227 continues past the cut with 171 more characters, completing the very word the chapter breaks in the middle of — _“may be accessed via”_ followed by the PHIN VADS link. So the full text survived somewhere for at least one of them, which is good reason to think the other fifteen exist too.

**Need:** **Please find out who holds the source these descriptions are generated from** — the loss is at publication, not at authoring, so the full text is likely intact upstream. Restoring it should be a technical correction rather than a ballot. Two riders: 0227's text is available from THO right now and we can restore it immediately if you say so; and because THO carries the same truncation, any fix has to be made in both places or the two will fork. All sixteen are listed in the register.

### NEW — Concepts whose code is nothing but punctuation — 17 tables, 23 codes

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

**The full detail** is in an 18-item register written for V2 Management and TSMG, which now lists every affected table for the truncated descriptions and the punctuation codes. This page is the executive cut; the register has the evidence for each item. The field-by-field mapping behind the new question is a separate document and can be circulated on request.

_Generated 2026-09-16 by `tooling/scripts/render_v2mgmt_briefing.py`. Edit the module, not this file._
