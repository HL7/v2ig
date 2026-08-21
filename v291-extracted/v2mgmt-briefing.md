# V2.9.1 Chapter 2C terminology — Executive briefing for V2 Management

**2026-08-21**

We have extracted the whole of Chapter 2C — 799 tables, 5,540
codes — and are turning it into FHIR CodeSystems and ValueSets. The
extraction and text-fidelity pass is complete and reviewed. Nothing is
outstanding on our side.

The work is destined for THO, and it establishes a corrected baseline
for v2 terminology there. We met the UTG subcommittee of TSMG yesterday and
they are receptive; the canonical URLs and the merge route are agreed.

What we need from V2 Management is one ruling and a stack of
acknowledgements. Along the way we found defects in the published chapter.
Most are mechanical and need only a nod. A few are not, and three of them
block us.

## If you read one thing

1. **[BLOCKS US]** When the chapter publishes something demonstrably wrong, do we reproduce it or correct it?  
   _Ask:_ Rule on the principle, not the instances: reproduce and record, reproduce but deprecate, or correct and annotate. We will apply whatever you decide and bring back the affected list.
2. **[BLOCKS US]** Is “all codes” a defined term?  
   _Ask:_ Is “all codes” meant to map to something specific in a value set definition, or is it prose? If prose, we will enumerate and say so.
3. **[BLOCKS US]** Two pairs of tables are duplicates — do we publish one resource or two?  
   _Ask:_ Confirm the older numbers are deprecated in favour of the newer, and say so in the chapter. We need to know whether to emit two resources or one with an alias.

## The three that block us

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

### 2. Is “all codes” a defined term?

Highest leverage question on the page. It affects how all 438 value set blocks in the chapter get translated, so one answer here settles hundreds of resources.

Value Set blocks give a “Content Logical Definition”. Some say
“enumerated per table content”, which is unambiguous. Others
say “all codes” — including tables 0931 and 0932,
which then list two or three UCUM codes. Read literally, “all
codes” against UCUM means every unit of measure in existence.
THO reads all four the same way and enumerates in every case, which suggests
the phrase is informal. But we are translating 438 of these mechanically and we
should not be guessing.

**Ask:** Is “all codes” meant to map to something specific in a value set definition, or is it prose? If prose, we will enumerate and say so.

### 3. Two pairs of tables are duplicates — do we publish one resource or two?

A structural question we cannot answer from the document, and it changes what we emit.

0567 / 0929 are both Weight Units, both declare the concept
domain WeightUnits, and both publish the same four UCUM codes.
0568 / 0930 are both Volume Units with the same three codes.
In both pairs, the older table's value set URI already points at the newer
table's value set — so the chapter appears to know they are the same
thing without saying so.

**Ask:** Confirm the older numbers are deprecated in favour of the newer, and say so in the chapter. We need to know whether to emit two resources or one with an alias.

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

### Tables that contradict themselves — 4 tables

0093, 0340 and 0451 each declare Concept Domain Only: yes
and then publish rows in the code grid. The rows are not codes: 0093's third
entry is literally ... with the display “user-defined
codes”; 0340's two entries name coding systems rather than
modifiers; 0451's single entry is a query wildcard.
0560 says Type: User and “No suggested
values” and then lists five values.

**Need:** Our plan is to emit a concept domain and nothing else for the first three. Flagging in case any of them is meant to be read differently.

### Code system identity that looks wrong — 2 tables

0459 Reimbursement Action Code is labelled with the CMS OCE Edit Code
symbolic name and OID, but its four codes are 0–3
with HL7-authored English displays. Those read as an HL7 enumeration
about OCE behaviour, not as CMS codes.
0411 Supplemental Service Information prints the URI
http://terminology.hl7.org/CodeSystem/v2-0411. No such resource
exists in THO — a dangling canonical in a published HL7 standard.

**Need:** 0459 needs its OID confirmed. 0411 needs the resource created in THO, or an explanation of why it never was.

### The chapter disagreeing with itself, and with THO — 10 concept domains

Five concept domains are given two different descriptions within Chapter
2C. A concept domain has one description by definition, so this is a source
defect rather than something we can adjudicate. We currently emit the first in
document order to keep output deterministic.
Five more differ between Chapter 2C and THO (0952, 0967, 0675, 0066,
0626). For 577 of the 582 shared domains the two agree word for word. Of these
five, only 0952 is a near-match — the other four are wholly different
texts, which usually means the two bodies have attached different meanings
to the same domain rather than phrasing one meaning two ways.

**Need:** The five internal conflicts need reconciling at source. The four genuine disagreements with THO need a joint decision with TSMG — picking a wording does not fix a disagreement about meaning.

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
