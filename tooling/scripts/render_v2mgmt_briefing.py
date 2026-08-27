#!/usr/bin/env python3
"""The V2 Management briefing, authored here and rendered to HTML.

A different document from the UTG briefing, for a different reason. UTG had an
hour and owns specific resources, so that briefing is item-by-item. V2
Management has minutes and owns the *chapter*, so this one is organised by
**class of defect** with counts, and names individual tables only where a
single table is itself the point.

The ordering rule: anything that blocks us comes first, and everything else is
a class with a count. Someone with ten minutes should leave knowing what we
need from them and roughly how big the rest is.

Run:
    python3 tooling/scripts/render_v2mgmt_briefing.py
"""

import argparse
import html
import re
import sys
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from briefing_style import STYLE  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_HTML = PROJECT_ROOT / "v291-extracted" / "v2mgmt-briefing.html"
DEFAULT_MD = PROJECT_ROOT / "v291-extracted" / "v2mgmt-briefing.md"

TITLE = "V2.9.1 Chapter 2C terminology"
SUBTITLE = "Executive briefing for V2 Management"
MEETING_DATE = "2026-08-28"

SUMMARY = """
<p>We have extracted the whole of Chapter 2C &mdash; <b>799 tables, 5,540
codes</b> &mdash; and are turning it into FHIR CodeSystems and ValueSets. The
extraction and text-fidelity pass is <b>complete and reviewed</b>. Nothing is
outstanding on our side.</p>

<p><b>Since we last met on 21 August, the resources exist.</b> The generator is
built and produces <b>398 CodeSystems and 422 ValueSets</b>, every one of which
validates against the IG Publisher with no errors. 329 of the value sets come
out byte-identical to the ones UTG already publishes, without any tuning, which
is the best evidence we have that the extraction is faithful.</p>

<p>The work is destined for <b>THO</b>, and it establishes a corrected baseline
for v2 terminology there. The UTG subcommittee of TSMG is receptive; the
canonical URLs and the merge route are agreed.</p>

<p><b>What we need from V2 Management is two rulings, one new steer, and a
stack of acknowledgements.</b> The two rulings are unchanged from last time and
still outstanding. Building the resources turned up three further classes of
defect, marked <span class="badge b-new">NEW</span> below.</p>
"""

METRICS = [
    ("799", "tables extracted", "good"),
    ("820", "resources generated", "good"),
    ("100%", "text fidelity pass complete", "good"),
    ("2", "blocking questions", "escalate"),
    ("8", "classes of chapter defect", "flag"),
]

# --------------------------------------------------------------------------
# The ones that actually block generation
# --------------------------------------------------------------------------
#
# Kept very short on purpose. A meeting with minutes in it can absorb two or
# three things; a list of twelve gets nodded at and forgotten.
#
# The bar for this list is strict, and it was set after an earlier draft failed
# it: an item belongs here only if generation cannot proceed without the
# answer AND the answer is not already determined by something we know. Two
# items came off for the second reason -- "all codes" is ordinary FHIR, and the
# duplicate pairs are a deprecated/current pair. Both were real register items,
# but neither was ever a blocker. See RESOLVED below.

BLOCKERS = [
    {
        "id": "policy",
        "n": 1,
        "title": "When the chapter publishes something demonstrably wrong, do "
                 "we reproduce it or correct it?",
        "why": "This is the ruling we most need. It sets the default for every "
               "other item on this page, and we cannot generate the affected "
               "tables until it is answered.",
        "body": """
<p>Our governing requirement has been fidelity &mdash; publish exactly what
Chapter 2C publishes. That is easy while the differences are typographic. It
stops being easy when the content is wrong:</p>
<ul>
<li><b>Table 0931 Temperature Units</b> publishes <code>degF</code>, which is
not a valid UCUM code, beside the valid <code>[degF]</code> that means the same
thing. The chapter's own comment on it says &ldquo;typo&rdquo;.</li>
<li><b>Table 0560 Quantity Units</b> publishes five codes of which four are
units of <i>time</i> &mdash; Hours, Days, Month, Years.</li>
</ul>

<div class="counter">
<p class="tight"><b>THO has already answered this differently in the two
cases</b>, which is why it needs settling rather than assuming. For 0931 THO
<i>corrected</i> &mdash; its value set drops the bad code and folds the history
into the display text. For 0560 THO <i>reproduced</i> the same error the
chapter has. So the two bodies have diverged on the principle at least once,
and THO has diverged from itself.</p>
</div>

<div class="settled">
<p class="tight"><b>HL7's own errata guidance may already answer most of
this, and would let you give us a narrow answer instead of a broad one.</b> It
defines a technical correction as a non-controversial change that makes a
document say what the Work Group intended, typically repairing normative
content that was &ldquo;not made, incorrectly made, or inconsistently made
during the editing process&rdquo;. That test splits our list cleanly in two.
The <i>editing-process</i> defects &mdash; 0821's grid emptied in publication,
the truncated descriptions, the links to rendered pages where canonical URLs
belong, the missing spaces &mdash; are technical corrections on that
definition. The <i>content</i> defects &mdash; 0931's invalid UCUM code,
0560's time units &mdash; change what the standard means, and the same
guidance requires a substantive change to normative content to be
balloted.</p>
</div>
""",
        "ask": "Rule on the principle, not the instances: reproduce and record, "
               "reproduce but deprecate, or correct and annotate. "
               "<b>If the full question is too broad for the time available, "
               "the narrow one would unblock most of the list:</b> may we treat "
               "the editing-process defects as technical corrections, leaving "
               "only the genuinely substantive ones for a ballot? The guidance "
               "notes that where there is doubt a Work Group may ask the TSC "
               "to rule.",
    },
    {
        "id": "domain-conflicts",
        "n": 2,
        "title": "Five concept domains are declared by more than one table, "
                 "with a different definition each time",
        "why": "A concept domain has one definition by definition. Two tables "
               "describing the same domain differently is a source defect we "
               "cannot adjudicate, and it is the only class here where we are "
               "currently emitting a guess.",
        "body": """
<p>We emit the <b>first description in document order</b>, purely to keep the
output deterministic. That is a coin toss, not a judgement &mdash; and in at
least two cases below the second description is clearly the better one.</p>

<table>
<tr><th>Concept domain</th><th>Tables</th><th>The competing definitions</th></tr>
<tr><td><code>DeviceStatus</code></td><td class='nowrap'>0682, 0962</td>
<td>&ldquo;the state of a device&rdquo; <i>vs</i> &ldquo;the availability
status of a device&rdquo;</td></tr>
<tr><td><code>DeviceType</code></td><td class='nowrap'>0657, 0961</td>
<td>&ldquo;the kind of device as defined by the manufacturer&rdquo; <i>vs</i>
&ldquo;what kind a particular device is &hellip; devices used in the medical
field&rdquo;</td></tr>
<tr><td><code>Modality</code></td><td class='nowrap'>0259, 0604</td>
<td>&ldquo;the imaging apparatus expected to be used &hellip; <b>removed from
the standard as of 2.7 in favour of table 0910</b>&rdquo; <i>vs</i> &ldquo;the
type of Modality&rdquo;</td></tr>
<tr><td><code>QuantityUnits</code></td><td class='nowrap'>0560, 0602</td>
<td>&ldquo;the adjustment quantity&rdquo; <i>vs</i> &ldquo;the type of Quantity
Units&rdquo;</td></tr>
<tr><td><code>VolumeUnits</code></td><td class='nowrap'>0568, 0777, 0930</td>
<td>&ldquo;units of measure used to specify volume&rdquo; <i>vs</i> &ldquo;the
type of Volume Units&rdquo;</td></tr>
</table>

<div class="counter">
<p class="tight"><b>Two of these are entangled with other items.</b>
<code>Modality</code>'s first definition says the table was <i>removed from the
standard as of 2.7</i> &mdash; so we are currently publishing a withdrawn
table's wording as the live definition. And <code>VolumeUnits</code> is
declared by three tables, two of which (0568, 0930) are the deprecated/current
pair below.</p>
</div>
""",
        "ask": "Say which definition is correct for each of the five. We will "
               "take any of them &mdash; what we cannot do is keep choosing by "
               "document order.",
    },
]

# --------------------------------------------------------------------------
# Settled in discussion -- shown so they are not raised twice
# --------------------------------------------------------------------------
#
# These were on the list and came off it. They stay visible for one meeting so
# that anyone who read the earlier draft can see where they went; a question
# that silently disappears looks like a question that was dropped.

RESOLVED = [
    ("Where the value sets are published",
     "0291, 0347, 0399, 0834",
     "We were minting canonical URLs of the form <code>&hellip;/v2-NNNN</code> "
     "for four tables that THO already publishes at "
     "<code>&hellip;/v2-notAllCodes-NNNN</code>. <b>Settled: a canonical is an "
     "identifier, and where one already exists it is the one to use</b>, "
     "whatever it looks like. Corrected; the four now match THO and UTG "
     "exactly. No action from V2 Management &mdash; recorded because it "
     "changed generated output."),
    ("Table 0227 Manufacturers of Vaccines",
     "0227",
     "The chapter declares a value set and no code system. Resolved: MVX is an "
     "external CDC code system that THO records as a NamingSystem and "
     "deliberately does <i>not</i> publish a CodeSystem for. We compose a "
     "value set over the external system, which is correct and complete. No "
     "decision needed."),
    ("Concept-domain-only tables that also list codes",
     "0093, 0340, 0451",
     "Carried over from the last meeting because it was corrected there rather "
     "than answered. Not a contradiction &mdash; the V3 requirements for "
     "declaring a concept domain call for <b>example codes</b>, so these "
     "tables are correct as published. Where the examples should live is a "
     "representation question for TSMG, not a chapter defect."),
]

# --------------------------------------------------------------------------
# The one genuinely new ask
# --------------------------------------------------------------------------
#
# Not a defect and not a blocker, so it sits between the blockers and the
# defect classes rather than in either. It is here because it is the one thing
# on this page that is cheap to answer now and expensive to revisit: once the
# resources are loaded into THO, information that was dropped is gone.

NEW_QUESTION = {
    "id": "not-carried",
    "title": "Chapter 2C publishes a lot about each table that a CodeSystem "
             "and a ValueSet have nowhere to put. How much of it do you want "
             "kept?",
    "why": "Not a defect &mdash; a design question, and the only one on this "
           "page with a deadline attached. Once this content is in THO, "
           "whatever we did not carry across is not recoverable from the "
           "resources.",
    "body": """
<p>We mapped every field the chapter publishes about a table against the FHIR
resources we generate. <b>Of 43 fields, 24 reach no resource at all.</b> Some
plainly do not matter. Others are real information with no obvious FHIR
home:</p>

<table>
<tr><th>Field</th><th class='num'>Tables</th><th>Comment</th></tr>
<tr><td><b>Table Description</b></td><td class='num'>799</td>
<td>Describes the table as a whole. For the 355 tables with no code system
block, it is the only prose the chapter offers.</td></tr>
<tr><td><b>Type</b></td><td class='num'>799</td>
<td><code>User</code> vs <code>HL7</code> and the rest &mdash; a real
distinction with conformance consequences, and one implementers ask
about.</td></tr>
<tr><td><b>where used</b></td><td class='num'>779</td>
<td>The fields a table is bound to, <code>PID-8</code> and so on. The link
between the vocabulary and the rest of the standard.</td></tr>
<tr><td><b>HL7 Version Introduced</b></td><td class='num'>607</td>
<td>Which release the table first appeared in.</td></tr>
<tr><td><b>Code System Full Name</b></td><td class='num'>437</td>
<td>A human-readable label. <code>title</code> already carries the symbolic
name, so there is no room for it.</td></tr>
<tr><td><b>Version, Effective Date</b></td><td class='num'>426</td>
<td>The chapter's own version and date for the code system. We currently
inherit THO's instead &mdash; and THO's date is a bulk-load date, so
<b>the chapter has the better information and we are discarding it</b>.</td></tr>
</table>

<p>Each of these could be preserved as a concept property or an extension, but
every one we add is a thing THO has to carry forever, so it is worth being
deliberate rather than exhaustive.</p>
""",
    "ask": "You do not need to answer field by field today. What we need is a "
           "steer: <b>is the intent that a FHIR consumer can recover what "
           "Chapter 2C says about a table, or only the codes it defines?</b> "
           "That one answer tells us whether to design extensions for the "
           "list above or to record the loss and move on. The full mapping, "
           "with all 43 fields and counts, is a separate document we can "
           "circulate.",
}

# --------------------------------------------------------------------------
# Everything else, as classes
# --------------------------------------------------------------------------
#
# `severity` drives the colour. `need` is what we want from them, and for most
# of these it is genuinely just acknowledgement -- saying so plainly is what
# keeps the meeting short.

CLASSES = [
    {
        "id": "cls-truncated",
        "kind": "finding",
        "new": True,
        "name": "Value Set descriptions that stop mid-word",
        "count": "16 tables",
        "body": """
<p>Table 0227's value set description ends <i>&ldquo;&hellip; and the code
system may be acce&rdquo;</i>. Sweeping the corpus found <b>sixteen descriptions
that stop without punctuation, every one between 242 and 252 characters</b>.
Nothing else behaves this way &mdash; code system descriptions in the same
tables run past 500 characters and end in complete sentences. It is a length
cap of about 250 characters applied to one field somewhere in the publication
toolchain.</p>

<div class="counter">
<p class="tight"><b>This is the only defect on this page that reaches the
generated resources.</b> The Value Set Description becomes
<code>ValueSet.description</code>, so sixteen published FHIR resources will
carry a sentence that stops mid-word unless the text is recovered.</p>
</div>

<p><b>We checked whether THO could supply the missing text. It cannot:</b> all
sixteen tables have a ValueSet in THO, all sixteen carry a description, and
<b>fifteen are truncated at exactly the same character</b>. The same clipped
field fed both documents, so the truncated text is already published in THO
as well as in the chapter.</p>

<p><b>The exception is the useful part.</b> THO's value set for 0227 continues
past the cut with 171 more characters, completing the very word the chapter
breaks in the middle of &mdash; <i>&ldquo;may be accessed via&rdquo;</i>
followed by the PHIN VADS link. So the full text survived somewhere for at
least one of them, which is good reason to think the other fifteen exist
too.</p>
""",
        "need": "<b>Please find out who holds the source these descriptions "
                "are generated from</b> &mdash; the loss is at publication, not "
                "at authoring, so the full text is likely intact upstream. "
                "Restoring it should be a technical correction rather than a "
                "ballot. Two riders: 0227's text is available from THO right "
                "now and we can restore it immediately if you say so; and "
                "because THO carries the same truncation, any fix has to be "
                "made in both places or the two will fork. All sixteen are "
                "listed in the register.",
    },
    {
        "id": "cls-punctuation",
        "kind": "finding",
        "new": True,
        "name": "Concepts whose code is nothing but punctuation",
        "count": "17 tables, 23 codes",
        "body": """
<p>Noticed because table 0291's code system carries a concept whose code is a
single ellipsis character. Scanning Chapter 2C and THO's v2 code systems for
codes containing no letter or digit found <b>23 concepts across 17
tables</b>, in three quite different groups.</p>

<ul>
<li><b>Four are genuine codes.</b> <code>*</code> in 0255 and 0505,
<code>#</code> in 0505, <code>%</code> in 0523 &mdash; each with a real
definition, such as <i>Indicates a percent change</i>. A single-character
symbol is an awkward code but it is a code. <b>Leave these alone.</b></li>
<li><b>Eighteen are an ellipsis placeholder minted as a concept.</b> Their
display text gives them away: <i>No suggested values defined</i>,
<i>user-defined codes</i>, <i>see chapter 3</i>. These were rows in a printed
table saying &ldquo;nothing here&rdquo;, and they were loaded as though they
were content. Nobody can send <code>...</code> in a message and mean anything
by it.</li>
<li><b>Five tables carry that placeholder twice.</b> 0291, 0365, 0366, 0367
and 0418 each have <code>...</code> (three full stops) <i>and</i>
<code>&hellip;</code> (one ellipsis character) as two separate concepts with
identical display text. In 0418 the ellipsis concept has no display text at
all.</li>
</ul>

<p>One oddity beyond the three groups: 0492's code is <code>??</code>,
displayed <i>Inappropriate due to &hellip;</i> &mdash; a truncated display
beside what looks like a data-entry artefact.</p>

<div class="counter">
<p class="tight"><b>This is mostly THO's problem rather than the chapter's,
and that is the interesting part.</b> Sixteen of the 23 exist only in THO, six
in both, and one only in Chapter 2C. <b>Every duplicate pair is THO-only.</b>
So the chapter has largely stopped publishing these and THO has gone on
carrying them &mdash; which is exactly the drift this baseline exercise exists
to correct.</p>
</div>
""",
        "need": "Acknowledgement that the placeholders were never concepts, "
                "and a view on retiring them. We are changing nothing for this "
                "release &mdash; these are live published code systems and "
                "retiring a code is the owners' call, jointly with TSMG. The "
                "cheapest useful outcome is agreeing the four symbol codes "
                "stay and the rest go on a retirement list.",
    },
    {
        "id": "cls-lost",
        "kind": "finding",
        "name": "Content lost in publication",
        "count": "2 tables",
        "body": """
<p><b>0821 Gender Identity</b> publishes its coded content grid <b>completely
blank</b> &mdash; six rows by five columns, every cell empty, while the section
around it is fully populated. Six rows is a header plus five code rows, and
THO's <code>ValueSet/gender-identity</code>, carrying the exact OID the chapter
prints, holds exactly <b>five</b> concepts. The grid was meant to carry those
five and lost them.</p>
<p><b>0685 and 0767</b> have their headings styled <code>Normal</code> instead
of <code>Heading 3</code>, so both are absent from the chapter's own table of
contents and were invisible to extraction until we special-cased them.</p>
""",
        "need": "0821 needs its five codes restored in a future publication. "
                "This is the one class where a reader of the PDF is actively "
                "misled &mdash; the table looks empty.",
    },
    {
        "id": "cls-copypaste",
        "kind": "finding",
        "name": "Copy-paste errors in code system metadata",
        "count": "9 tables",
        "body": """
<ul>
<li><b>All six UCUM-backed tables</b> (0567, 0568, 0929&ndash;0932) name the
code system <i>&ldquo;Donation Duration Units Code System&rdquo;</i>. Only 0932
is about donation duration, and the name is wrong even there &mdash; the code
system is UCUM.</li>
<li><b>0560 and 0910</b> carry literal placeholder text: OID <code>-</code>,
symbolic name <code>noObject</code>, description <code>noDescription</code>,
and a full name copy-pasted from an unrelated table. These are a tool's way of
saying &ldquo;left blank&rdquo;, and they were published.</li>
<li><b>0347 State/Province</b> correctly identifies ISO 3166 <b>part 2</b> and
then gives the URI for <b>part 1</b>.</li>
</ul>
""",
        "need": "Acknowledgement and a technical correction. None of these "
                "should be controversial, but all change published text, so "
                "they are not ours to make unilaterally.",
    },
    {
        "id": "cls-contradiction",
        "kind": "finding",
        "name": "Tables that contradict themselves",
        "count": "3 tables",
        "body": """
<p><b>0560</b> says <code>Type: User</code> and &ldquo;No suggested
values&rdquo;, and then lists five values &mdash; the same five that are units
of time under a name about quantity.</p>
<p><b>0931 and 0932</b> give their Content Logical Definition as &ldquo;all
codes&rdquo; and then enumerate two or three UCUM codes. Against UCUM,
&ldquo;all codes&rdquo; means every unit of measure there is. Tables 0929 and
0930 do the same thing and say &ldquo;enumerated per table content&rdquo;,
which is right.</p>
""",
        "need": "Wording corrections. 0931 and 0932 should say what 0929 and "
                "0930 say. 0560 is really the same question as blocker 1.",
    },
    {
        "id": "cls-identity",
        "kind": "finding",
        "name": "Code system identity that looks wrong",
        "count": "2 tables",
        "body": """
<p><b>0459 Reimbursement Action Code</b> is labelled with the CMS OCE Edit Code
symbolic name and OID, but its four codes are <code>0</code>&ndash;<code>3</code>
with HL7-authored English displays. Those read as an HL7 enumeration
<i>about</i> OCE behaviour, not as CMS codes.</p>
<p><b>0411 Supplemental Service Information</b> prints the URI
<code>http://terminology.hl7.org/CodeSystem/v2-0411</code>. <b>No such resource
exists in THO</b> &mdash; a dangling canonical in a published HL7 standard.</p>
""",
        "need": "0459 needs its OID confirmed. 0411 needs the resource created "
                "in THO, or an explanation of why it never was.",
    },
    {
        "id": "cls-internal",
        "kind": "finding",
        "name": "Concept domain definitions that differ from THO",
        "count": "5 domains",
        "body": """
<p>Tables <b>0952, 0967, 0675, 0066, 0626</b>. For 577 of the 582 concept
domains the two bodies share, Chapter 2C and THO agree word for word. These
five do not.</p>
<p>Only 0952 is a near-match &mdash; it differs by formatting and a stray
space. <b>The other four are wholly different texts</b>, which usually means
the two bodies have attached different meanings to the same domain rather than
phrasing one meaning two ways.</p>
<p>Distinct from blocker 2: that one is the chapter disagreeing with
<i>itself</i>. This is the chapter disagreeing with THO.</p>
""",
        "need": "A joint decision with TSMG on the four. Picking a wording "
                "does not fix a disagreement about meaning.",
    },
    {
        "id": "cls-typography",
        "kind": "fyi",
        "name": "Typographic defects &mdash; already handled, no action",
        "count": "~1,500 corrections",
        "body": """
<p>Doubled spaces, spaces before punctuation, missing spaces after periods,
corrupt characters from Word, Symbol-font glyphs. Every one is corrected under
a recorded decision, every change is logged with its before and after, and
nothing was changed that a reviewer had not individually approved.</p>
<p>Mentioned only so it is on the record that the chapter's published text
needed roughly 1,500 corrections at this level, and that they are reversible.</p>
""",
        "need": "Nothing. Listed for visibility.",
    },
]

CONTEXT = """
<p><b>Where this is going.</b> The output is not scoped to V2.9.1. We are using
V2.9.1 as the source to establish a corrected <i>v2 baseline</i> in THO, because
the existing THO v2 content has more problems than what we are preparing. A
subsequent effort will resolve the substantive terminology problems that go
beyond this pass &mdash; keeping the two separate is what makes the second one
reviewable.</p>

<p><b>Method, briefly.</b> Two independent extractions of the same document
&mdash; one character-faithful, one structural &mdash; agreeing on 740 of 799
tables, with every remaining difference adjudicated against the source. Every
change to published text is recorded with the decision that authorised it, and
can be reversed.</p>

<p><b>The full detail</b> is in an 18-item register written for V2 Management
and TSMG, which now lists every affected table for the truncated descriptions
and the punctuation codes. This page is the executive cut; the register has the
evidence for each item. The field-by-field mapping behind the new question is a
separate document and can be circulated on request.</p>
"""

KIND_LABEL = {
    "blocker": ("BLOCKS US", "b-decide"),
    "finding": ("NEEDS ATTENTION", "b-flag"),
    "fyi": ("FYI", "b-info"),
}

# Half this room read the 21 August version. Marking what has appeared since
# means they can skim to it rather than re-read the whole page.
NEW_BADGE = "<span class='badge b-new'>NEW</span> "

EXTRA_STYLE = """
.badge.b-new { background: #1a7f37; }
.new-question { border: 2px solid #bc4c00; border-radius: 10px;
  padding: 18px 22px; margin: 22px 0; background: #fffaf5; }
"""


def render_html(generated):
    """Build the whole briefing as one self-contained HTML string."""
    out = []
    add = out.append

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add(f"<title>{html.escape(TITLE)} &mdash; V2 Management briefing</title>")
    add(f"<style>{STYLE}{EXTRA_STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<nav id='sidebar'>")
    add(f"<div class='brand'>{TITLE}</div>")
    add(f"<div class='brand-sub'>{SUBTITLE}</div>")
    add("<a class='top' href='#blockers'>&uarr; The two that block us</a>")
    add("<h2>Blocking</h2>")
    for b in BLOCKERS:
        add(f"<a href='#{b['id']}'><span class='n'>{b['n']}</span>"
            f"{b['title']}</a>")
    add("<h2>New ask</h2>")
    add(f"<a href='#{NEW_QUESTION['id']}'><span class='n'>?</span>"
        "What to keep that FHIR has no room for</a>")
    add("<h2>Settled</h2>")
    add("<a href='#resolved'><span class='n'>&check;</span>Came off the "
        "list</a>")
    add("<h2>Defect classes</h2>")
    for c in CLASSES:
        flag = "&#9733; " if c.get("new") else ""
        add(f"<a href='#{c['id']}'><span class='n'>&bull;</span>{flag}{c['name']} "
            f"<span class='cnt'>{c['count']}</span></a>")
    add("<h2>Context</h2>")
    add("<a href='#context'><span class='n'>&mdash;</span>Where this is "
        "going</a>")
    add("</nav>")

    # ---- main ----
    add("<main id='main'>")
    add(f"<h1>{TITLE}</h1>")
    add(f"<p class='sub'>{SUBTITLE} &middot; {html.escape(MEETING_DATE)}</p>")
    add(SUMMARY)

    add("<div class='metric-grid'>")
    for number, label, tone in METRICS:
        add(f"<div class='metric-card mc-{tone}'>"
            f"<div class='number'>{number}</div>"
            f"<div class='label'>{label}</div></div>")
    add("</div>")

    # ---- the three asks ----
    add("<section id='blockers' class='asks-card'>")
    add("<h2 class='plain'>If you read one thing</h2>")
    add("<p class='asks-intro'>Two questions block us. Everything else on "
        "this page needs acknowledgement rather than a decision.</p>")
    add("<ol class='asks-list'>")
    for b in BLOCKERS:
        add(f"<li><span class='badge b-decide'>BLOCKS US</span> "
            f"<a href='#{b['id']}'>{b['title']}</a>"
            f"<div class='ask-line'>{b['ask']}</div></li>")
    add("</ol>")
    add("<p class='asks-foot'>Then <b>one new question</b> that is not a "
        "defect but has a deadline, and <b>defects in the published chapter</b> "
        f"grouped into {len(CLASSES)} classes. Most of those need only a nod "
        "that they are real and will be fixed in a future publication.</p>")
    add("</section>")

    # ---- the new question ----
    add(f"<section class='new-question' id='{NEW_QUESTION['id']}'>")
    add(f"<h2 class='plain'>{NEW_BADGE}{NEW_QUESTION['title']}</h2>")
    add(f"<p class='lede'>{NEW_QUESTION['why']}</p>")
    add(NEW_QUESTION["body"])
    add(f"<p class='ask'><span class='ask-tag'>Ask</span>"
        f"{NEW_QUESTION['ask']}</p>")
    add("</section>")

    # ---- what came off the list ----
    add("<h2 id='resolved'>Already settled &mdash; here so they are not raised "
        "twice</h2>")
    add("<p class='sub'>These were on an earlier draft of this page as open "
        "questions. They are not.</p>")
    add("<table><tr><th>Was listed as</th><th>Tables</th>"
        "<th>Where it landed</th></tr>")
    for name, tables, outcome in RESOLVED:
        add(f"<tr><td><b>{name}</b></td><td class='nowrap'>{tables}</td>"
            f"<td>{outcome}</td></tr>")
    add("</table>")

    # ---- blockers in full ----
    add("<h2>The two that block us</h2>")
    for b in BLOCKERS:
        add(f"<section class='item k-decision' id='{b['id']}'>")
        add(f"<h3><span class='badge b-decide'>BLOCKS US</span> "
            f"<span class='n'>{b['n']}.</span> {b['title']}</h3>")
        add(f"<p class='lede'>{b['why']}</p>")
        add(b["body"])
        add(f"<p class='ask'><span class='ask-tag'>Ask</span>{b['ask']}</p>")
        add("</section>")

    # ---- classes ----
    add("<h2>Defects in the published chapter, by class</h2>")
    add("<p class='sub'>Counts are tables affected. None of these blocks us; "
        "we have a working treatment for each and it is recorded.</p>")
    for c in CLASSES:
        label, cls = KIND_LABEL[c["kind"]]
        kind_css = "k-fyi" if c["kind"] == "fyi" else "k-finding"
        add(f"<section class='item {kind_css}' id='{c['id']}'>")
        add(f"<h3><span class='badge {cls}'>{label}</span> "
            f"{NEW_BADGE if c.get('new') else ''}{c['name']} "
            f"<span class='dim-tag'>{c['count']}</span></h3>")
        add(c["body"])
        add(f"<p class='ask'><span class='ask-tag'>Need</span>{c['need']}</p>")
        add("</section>")

    # ---- context ----
    add("<h2 id='context'>Where this is going</h2>")
    add(CONTEXT)

    add(f"<p class='faint'>Generated {html.escape(generated)} by "
        f"<code>tooling/scripts/render_v2mgmt_briefing.py</code>. "
        f"Edit the module, not this file.</p>")
    add("</main></body></html>")
    return "\n".join(out)


# The Markdown twin is what gets pasted into minutes and email, so it has to
# survive the trip as more than a wall of text. Inline emphasis becomes its
# Markdown equivalent rather than being stripped, and list and table structure
# is preserved -- both were being flattened, which ran three distinct groups of
# a finding together into one paragraph.
_INLINE_TAGS = [
    (re.compile(r"</?(?:b|strong)>"), "**"),
    (re.compile(r"</?(?:i|em)>"), "_"),
    (re.compile(r"</?code>"), "`"),
]

_LIST_ITEM = "\x00- "
_ROW = "\x00| "
_CELL = " | "
_BREAK = "\x00\x00"


def _text(s):
    """Convert one authored HTML fragment to Markdown.

    The authored fragments are hard-wrapped HTML, so lines inside a paragraph
    are joined back up; only the structural breaks this inserts survive as line
    breaks. Without that, a list item spanning three source lines would come
    out as three separate items.
    """
    text = s
    for pattern, replacement in _INLINE_TAGS:
        text = pattern.sub(replacement, text)

    text = re.sub(r"<li[^>]*>", _LIST_ITEM, text)
    text = re.sub(r"<tr[^>]*>", _ROW, text)
    text = re.sub(r"</t[dh]>\s*<t[dh][^>]*>", _CELL, text)
    text = re.sub(r"</?(?:p|div|ul|ol|table|tbody|thead|h\d)[^>]*>", _BREAK, text)
    text = re.sub(r"<[^>]+>", "", text)
    text = html.unescape(text)

    lines = []
    for chunk in text.split("\x00"):
        collapsed = re.sub(r"\s+", " ", chunk).strip()
        # A leading `#` or `|` is Markdown structure. These fragments are prose
        # about codes, and table 0505's code really is `#`, so a line can begin
        # with one by accident and turn a sentence into a heading.
        if collapsed.startswith("#"):
            collapsed = "\\" + collapsed
        lines.append(collapsed)

    # Collapse runs of blank lines to one, so paragraph spacing stays even.
    out = []
    for line in lines:
        if line or (out and out[-1]):
            out.append(line)
    return "\n".join(_close_tables(out)).strip()


def _close_tables(lines):
    """Finish the Markdown tables that cell conversion leaves half-built.

    Splitting on `<tr>` gets the rows but not the syntax around them: a
    Markdown table needs a closing pipe on every row and a separator under the
    header, or it renders as a run of literal pipes.
    """
    finished = []
    for line in lines:
        if not line.startswith("| "):
            finished.append(line)
            continue
        row = line + " |"
        finished.append(row)
        # The header is whichever row opens the run; the separator goes under
        # it and needs one cell per column.
        opening_row = len(finished) < 2 or not finished[-2].startswith("| ")
        if opening_row:
            columns = row.count("|") - 1
            finished.append("|" + "|".join([" --- "] * columns) + "|")
    return finished


def render_markdown(generated):
    """The same briefing as Markdown, for quoting into email or minutes."""
    out = [f"# {TITLE} — {SUBTITLE}", "", f"**{MEETING_DATE}**", "",
           _text(SUMMARY).strip(), "", "## If you read one thing", ""]
    for b in BLOCKERS:
        out.append(f"{b['n']}. **[BLOCKS US]** {_text(b['title'])}  ")
        out.append(f"   _Ask:_ {_text(b['ask'])}")
    out += ["", f"## NEW — {_text(NEW_QUESTION['title'])}", "",
            _text(NEW_QUESTION["why"]), "", _text(NEW_QUESTION["body"]).strip(),
            "", f"**Ask:** {_text(NEW_QUESTION['ask'])}", ""]
    out += ["## Already settled — here so they are not raised twice", ""]
    for name, tables, outcome in RESOLVED:
        out.append(f"- **{_text(name)}** ({_text(tables)}) — {_text(outcome)}")
    out += ["", "## The two that block us", ""]
    for b in BLOCKERS:
        out += [f"### {b['n']}. {_text(b['title'])}", "",
                _text(b["why"]).strip(), "", _text(b["body"]).strip(), "",
                f"**Ask:** {_text(b['ask'])}", ""]
    out += ["## Defects in the published chapter, by class", ""]
    for c in CLASSES:
        marker = "NEW — " if c.get("new") else ""
        out += [f"### {marker}{_text(c['name'])} — {c['count']}", "",
                _text(c["body"]).strip(), "",
                f"**Need:** {_text(c['need'])}", ""]
    out += ["## Where this is going", "", _text(CONTEXT).strip(), "",
            f"_Generated {generated} by "
            f"`tooling/scripts/render_v2mgmt_briefing.py`. Edit the module, "
            f"not this file._"]
    return "\n".join(out) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-o", "--output", default=str(DEFAULT_HTML))
    parser.add_argument("--markdown", default=str(DEFAULT_MD))
    args = parser.parse_args()

    generated = date.today().isoformat()
    Path(args.output).write_text(render_html(generated), encoding="utf-8")
    Path(args.markdown).write_text(render_markdown(generated), encoding="utf-8")

    print(f"{len(BLOCKERS)} blockers, {len(CLASSES)} defect classes")
    print(f"HTML:     {args.output}")
    print(f"Markdown: {args.markdown}")


if __name__ == "__main__":
    main()
