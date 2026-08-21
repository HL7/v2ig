# V2.9.1 Chapter 2C terminology — Executive briefing for V2 Management

**2026-08-21**

We have extracted the whole of Chapter 2C — 799 tables, 5,540
codes — and are turning it into FHIR CodeSystems and ValueSets. The
extraction and text-fidelity pass is complete and reviewed. Nothing is
outstanding on our side.

The work is destined for THO, and it establishes a corrected baseline
for v2 terminology there. We met the UTG subcommittee of TSMG yesterday and
they are receptive; the canonical URLs and the merge route are agreed.

What we need from V2 Management is two rulings and a stack of
acknowledgements. Along the way we found defects in the published chapter.
Most are mechanical and need only a nod — and three items that were on
an earlier draft of this page have already come off it, listed below so nobody
raises them twice.

## If you read one thing

1. **[BLOCKS US]** When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?  
   _Ask:_ Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. We will apply whatever you decide and bring back the affected list.
2. **[BLOCKS US]** Five concept domains are declared by more than one table, with a different definition each time  
   _Ask:_ Say which definition is correct for each of the five. We will take any of them — what we cannot do is keep choosing by document order.

## Already settled — here so they are not raised twice

- **“All codes” in a Content Logical Definition** (0929–0932) — Not ambiguous. A CLD reading “all codes from a given code system” is ordinary FHIR and is how value sets normally work; we express this in FHIR, so the term is already defined for us. What remains is a narrower chapter defect: 0931 and 0932 say “all codes” and then enumerate two or three UCUM codes, which is not what that phrase means. Filed under wording, below.
- **The two duplicate table pairs** (0567/0929, 0568/0930) — One of each pair is deprecated and the other is in use. We publish both — the older marked deprecated. No decision needed.
- **Concept-domain-only tables that also list codes** (0093, 0340, 0451) — Not a contradiction — we had this backwards. The V3 requirements for declaring a concept domain call for example codes, so these tables are correct as published. Likely treatment is to carry the examples as a property on the concept domain code system. Low priority; no action from V2 Management.

## The two that block us

### 1. When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?

This is the ruling we most need. It sets the default for every other item on this page, and we cannot generate the affected tables until it is answered.

Our governing requirement has been fidelity — publish exactly what
Chapter 2C publishes. That is easy while the differences are typographic. It
stops being easy when the content is wrong:

Table 0931 Temperature Units publishes degF, which is
not a valid UCUM code, beside the valid [degF] that means the same
thing. The chapter's own comment on it says “typo”.
Table 0560 Quantity Units publishes five codes of which four are
units of time — Hours, Days, Month, Years.



THO has already answered this differently in the two
cases, which is why it needs settling rather than assuming. For 0931 THO
corrected — its value set drops the bad code and folds the history
into the display text. For 0560 THO reproduced the same error the
chapter has. So the two bodies have diverged on the principle at least once,
and THO has diverged from itself.

**Ask:** Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. We will apply whatever you decide and bring back the affected list.

### 2. Five concept domains are declared by more than one table, with a different definition each time

A concept domain has one definition by definition. Two tables describing the same domain differently is a source defect we cannot adjudicate, and it is the only class here where we are currently emitting a guess.

We emit the first description in document order, purely to keep the
output deterministic. That is a coin toss, not a judgement — and in at
least two cases below the second description is clearly the better one.


Concept domainTablesThe competing definitions
DeviceStatus0682, 0962
“the state of a device” vs “the availability
status of a device”
DeviceType0657, 0961
“the kind of device as defined by the manufacturer” vs
“what kind a particular device is … devices used in the medical
field”
Modality0259, 0604
“the imaging apparatus expected to be used … removed from
the standard as of 2.7 in favour of table 0910” vs “the
type of Modality”
QuantityUnits0560, 0602
“the adjustment quantity” vs “the type of Quantity
Units”
VolumeUnits0568, 0777, 0930
“units of measure used to specify volume” vs “the
type of Volume Units”



Two of these are entangled with other items.
Modality's first definition says the table was removed from the
standard as of 2.7 — so we are currently publishing a withdrawn
table's wording as the live definition. And VolumeUnits is
declared by three tables, two of which (0568, 0930) are the deprecated/current
pair below.

**Ask:** Say which definition is correct for each of the five. We will take any of them — what we cannot do is keep choosing by document order.

## Defects in the published chapter, by class

### Content lost in publication — 2 tables

0821 Gender Identity publishes its coded content grid completely
blank — six rows by five columns, every cell empty, while the section
around it is fully populated. Six rows is a header plus five code rows, and
THO's ValueSet/gender-identity, carrying the exact OID the chapter
prints, holds exactly five concepts. The grid was meant to carry those
five and lost them.
0685 and 0767 have their headings styled Normal instead
of Heading 3, so both are absent from the chapter's own table of
contents and were invisible to extraction until we special-cased them.

**Need:** 0821 needs its five codes restored in a future publication. This is the one class where a reader of the PDF is actively misled — the table looks empty.

### Copy-paste errors in code system metadata — 9 tables

All six UCUM-backed tables (0567, 0568, 0929–0932) name the
code system “Donation Duration Units Code System”. Only 0932
is about donation duration, and the name is wrong even there — the code
system is UCUM.
0560 and 0910 carry literal placeholder text: OID -,
symbolic name noObject, description noDescription,
and a full name copy-pasted from an unrelated table. These are a tool's way of
saying “left blank”, and they were published.
0347 State/Province correctly identifies ISO 3166 part 2 and
then gives the URI for part 1.

**Need:** Acknowledgement and a technical correction. None of these should be controversial, but all change published text, so they are not ours to make unilaterally.

### Tables that contradict themselves — 3 tables

0560 says Type: User and “No suggested
values”, and then lists five values — the same five that are units
of time under a name about quantity.
0931 and 0932 give their Content Logical Definition as “all
codes” and then enumerate two or three UCUM codes. Against UCUM,
“all codes” means every unit of measure there is. Tables 0929 and
0930 do the same thing and say “enumerated per table content”,
which is right.

**Need:** Wording corrections. 0931 and 0932 should say what 0929 and 0930 say. 0560 is really the same question as blocker 1.

### Code system identity that looks wrong — 2 tables

0459 Reimbursement Action Code is labelled with the CMS OCE Edit Code
symbolic name and OID, but its four codes are 0–3
with HL7-authored English displays. Those read as an HL7 enumeration
about OCE behaviour, not as CMS codes.
0411 Supplemental Service Information prints the URI
http://terminology.hl7.org/CodeSystem/v2-0411. No such resource
exists in THO — a dangling canonical in a published HL7 standard.

**Need:** 0459 needs its OID confirmed. 0411 needs the resource created in THO, or an explanation of why it never was.

### Concept domain definitions that differ from THO — 5 domains

Tables 0952, 0967, 0675, 0066, 0626. For 577 of the 582 concept
domains the two bodies share, Chapter 2C and THO agree word for word. These
five do not.
Only 0952 is a near-match — it differs by formatting and a stray
space. The other four are wholly different texts, which usually means
the two bodies have attached different meanings to the same domain rather than
phrasing one meaning two ways.
Distinct from blocker 2: that one is the chapter disagreeing with
itself. This is the chapter disagreeing with THO.

**Need:** A joint decision with TSMG on the four. Picking a wording does not fix a disagreement about meaning.

### Typographic defects — already handled, no action — ~1,500 corrections

Doubled spaces, spaces before punctuation, missing spaces after periods,
corrupt characters from Word, Symbol-font glyphs. Every one is corrected under
a recorded decision, every change is logged with its before and after, and
nothing was changed that a reviewer had not individually approved.
Mentioned only so it is on the record that the chapter's published text
needed roughly 1,500 corrections at this level, and that they are reversible.

**Need:** Nothing. Listed for visibility.

## Where this is going

Where this is going. The output is not scoped to V2.9.1. We are using
V2.9.1 as the source to establish a corrected v2 baseline in THO, because
the existing THO v2 content has more problems than what we are preparing. A
subsequent effort will resolve the substantive terminology problems that go
beyond this pass — keeping the two separate is what makes the second one
reviewable.

Method, briefly. Two independent extractions of the same document
— one character-faithful, one structural — agreeing on 740 of 799
tables, with every remaining difference adjudicated against the source. Every
change to published text is recorded with the decision that authorised it, and
can be reversed.

The full detail is in a 12-item register written for V2 Management
and TSMG. This page is the executive cut; the register has the evidence for
each item.

_Generated 2026-08-21 by `tooling/scripts/render_v2mgmt_briefing.py`. Edit the module, not this file._
