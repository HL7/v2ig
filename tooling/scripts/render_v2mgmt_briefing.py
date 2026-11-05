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

# Where the built guide sits, relative to the briefing. Relative because the
# briefing is read by opening the file off disk, which an absolute path breaks.
IG = "../vocab-ig/output"


def question_link(question_id):
    """A briefing link to one of the guide's general questions.

    Always built through `question_anchor`, never written out as a literal.
    A question moves page the moment a committee answers it, and a hard-coded
    `open-items.html#...` is a dead link from that moment on -- which is
    exactly what happened to the Terminology Infrastructure briefing when the
    reordering question was answered.
    """
    from render_review_pages import question_anchor
    return f"{IG}/{question_anchor(question_id)}"

TITLE = "V2.9.1 Chapter 2C terminology"
SUBTITLE = "Executive briefing for V2 Management"
MEETING_DATE = "2026-09-23"

SUMMARY = """
<p>We have extracted the whole of Chapter 2C &mdash; <b>799 tables, 5,540
codes</b> &mdash; and turned it into FHIR CodeSystems and ValueSets. The
extraction and text-fidelity pass is <b>complete and reviewed</b>. Nothing is
outstanding on our side.</p>

<p><b>Since we last met on 28 August, it builds as an implementation
guide.</b> <b>824 artifacts</b> &mdash; 399 CodeSystems, 424 ValueSets and the
concept domains &mdash; generate and validate through the IG Publisher, with
<b>zero broken links across 625,068 checked</b>. You can open it and follow any
claim on this page to the evidence behind it. <b>It is not a published IG</b>
&mdash; publication is a status conferred by the HL7 process, and nothing here
has been through it.</p>

<p><b>It is additive with respect to THO.</b> We publish at THO's own canonical
URLs, so a naive load would silently delete anything THO carries that
Chapter 2C is silent about. It does not: <b>7,588 values that exist only in THO
are preserved</b>, and <b>733 of 819 artifacts keep THO's existing version
number</b> because nothing about them actually changed.</p>

<p>The work is destined for <b>THO</b>, and it establishes a corrected baseline
for v2 terminology there. It was walked through with the <b>Terminology
Infrastructure WG on 21 September</b>; the canonical URLs and the merge route
are agreed, and TSMG settled the one versioning question that was still open.</p>

<p><b>What we need from V2 Management is one ruling, one confirmation, one
steer, and a stack of acknowledgements.</b> The ruling &mdash; reproduce or
correct &mdash; has been outstanding since August and is now the only thing
genuinely blocking us. The second item has changed shape: we found the guide
was not making the arbitrary choice an earlier draft of this page told you it
was, so it needs confirming rather than deciding. Nothing new has been added
since the last meeting.</p>
"""

METRICS = [
    ("799", "tables extracted", "good"),
    ("820", "artifacts generated", "good"),
    ("7,588", "THO-only values preserved", "good"),
    ("0", "broken links", "good"),
    ("1", "blocking question", "escalate"),
    ("7", "classes of chapter defect", "flag"),
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
        "tables": ["0931", "0560", "0821"],
        "tableNote": "The three instances the argument rests on. The ruling "
                     "asked for is on the principle, and it reaches every "
                     "class further down this page.",
        "where": [
            ("Table 0560, as its own question with what we publish today",
             question_link("gq-table-0560-a-code-system")),
            ("The register: 37 open items, each with its affected tables",
             f"{IG}/open-items.html"),
        ],
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
        "badge": ("NEEDS A RULING", "b-flag"),
        "tables": ["0259", "0560", "0568", "0602", "0604",
                   "0657", "0682", "0777", "0930", "0961", "0962"],
        "tableNote": "The eleven tables that declare the five multiply-declared "
                     "domains between them.",
        "where": [
            ("The register, where the competing definitions are set out in "
             "full", f"{IG}/open-items.html"),
        ],
        "title": "Chapter 2C and THO define the same concept domains "
                 "differently. THO wins — confirm that.",
        "why": "<b>This is no longer blocking.</b> An earlier draft of this "
               "page said we were choosing between competing definitions by "
               "document order, and that was wrong. It stays at the top "
               "because it decides what does and does not get carried into "
               "THO, which is expensive to revisit.",
        "body": """
<p><b>THO already defines most of these domains, and where it does, we keep
THO's definition.</b> Chapter 2C names <b>760 concept domains</b>;
<b>THO already has a definition for 582 of them</b>. Our rule is that THO's
definition stands and the chapter's competing wording is recorded rather than
published.</p>

<div class="settled">
<p class="tight"><b>So the five domains declared by more than one table are not
actually a choice we are making.</b> All five &mdash;
<code>DeviceStatus</code>, <code>DeviceType</code>, <code>Modality</code>,
<code>QuantityUnits</code>, <code>VolumeUnits</code> &mdash; already have a THO
definition, and that is what we publish. <b>Every domain whose tables describe
it differently has a THO definition to fall back on</b>, so document order
never decides an outcome. The earlier claim that it did is withdrawn.</p>

<p class="tight">To be exact, because the weaker version of this is not true:
<b>26 domains are declared by more than one table and 20 of those have no THO
definition</b> &mdash; but in all 20 the tables agree with each other, so there
is nothing to choose between. The five where the tables genuinely conflict all
have a THO definition.</p>
</div>

<p><b>What is real is the disagreement itself.</b> After the shared text policy
is applied, <b>four domains have a chapter definition that substantively
disagrees with THO's</b>:</p>

<table>
<tr><th>Concept domain</th><th>THO says</th><th>Chapter 2C says</th></tr>
<tr><td><code>Country</code></td>
<td>Countries of the world. ISO 3166, part 1, alpha-3 set.</td>
<td>&ldquo;the type of Country&rdquo;</td></tr>
<tr><td><code>EmploymentStatus</code></td>
<td>A code used to define the employment status of the insured individual
identified in UB-92 FL 58.</td>
<td>&ldquo;the guarantor's employment status&rdquo;</td></tr>
<tr><td><code>ObservationMethod</code></td>
<td>A code that provides additional detail about the means or technique used to
ascertain the observation.</td>
<td>&ldquo;the type of Observation Method&rdquo;</td></tr>
<tr><td><code>ContainerForm</code></td>
<td>Describes the nature (or type) of the container, with examples.</td>
<td>&ldquo;shape or type of the container&rdquo;, with a different example
list.</td></tr>
</table>

<div class="counter">
<p class="tight"><b>In three of the four, THO's definition is plainly the
better one</b> &mdash; the chapter's is a restatement of the domain's own name
(&ldquo;the type of Country&rdquo;). That is a pattern worth noticing rather
than four separate incidents. <b>A further seven domains differ from THO only
in punctuation or markup</b> &mdash; including <code>Confidentiality</code>,
which an earlier draft of this page listed above as a substantive disagreement
and which is not one. They are recorded but there is nothing in them to
decide.</p>
</div>
""",
        "ask": "Confirm the rule rather than the instances: <b>where THO "
               "already carries a definition for a concept domain, THO's "
               "definition stands and Chapter 2C's competing wording is not "
               "carried into THO.</b> That settles all four above and the 582 "
               "domains behind them in one answer. If you want the chapter's "
               "wording preserved somewhere rather than dropped, say so now "
               "&mdash; that is a different question and it has the same "
               "deadline as the one below.",
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
    ("Concept order does not cost a version number",
     "32 tables",
     "Chapter 2C and THO often carry exactly the same codes in a different "
     "order, and the versioning policy could be read literally as making that "
     "a change. <b>TSMG settled it on 21 September: reordering is not a "
     "change and does not increment the version.</b> That confirmed what we "
     "were already doing, so no version number moved. Recorded because it was "
     "the last rule behind the version numbers resting on our reading of the "
     "policy rather than on a ruling. No action from V2 Management."),
    ("Most of the differences from THO were never disagreements",
     "489 &rarr; 202",
     "The review listed <b>489 differences</b> from what THO publishes, each "
     "framed as something a committee might have to adjudicate. On inspection "
     "<b>287 of them were not questions at all</b>: 211 are THO recording the "
     "V2 status letter where we record the FHIR status it maps to, and 76 are "
     "the same words with different punctuation, spacing or capitalisation. "
     "<b>202 genuine disagreements remain</b>, and they are no longer crowded "
     "out. Nothing was suppressed &mdash; the 287 are still listed, under a "
     "heading that says they need no decision."),
    ("Five concept displays now follow THO's capitalisation",
     "0203, 0396",
     "Where THO and the chapter agree on the words and differ only in case, "
     "and THO is the more capitalised side, we now publish THO's form &mdash; "
     "<code>GKV</code>, <code>KZVA</code>, <code>PKV</code>, <code>ZANR</code> "
     "and <code>DAR</code>. A deliberate exception to chapter-wins, taken "
     "because the words are identical so the chapter loses nothing. "
     "<b>No version moved.</b> The reverse case is not treated symmetrically: "
     "where THO is the <i>less</i> capitalised side we surface it rather than "
     "absorb it, because a correct lower-casing and a lost proper noun look "
     "identical to a machine."),
]

# --------------------------------------------------------------------------
# The design question
# --------------------------------------------------------------------------
#
# Not a defect and not a blocker, so it sits between the blockers and the
# defect classes rather than in either. It is here because it is the one thing
# on this page that is cheap to answer now and expensive to revisit: once the
# resources are loaded into THO, information that was dropped is gone.
#
# First asked on 28 August and still unanswered. The deadline in it is real and
# is closer than it was.

NEW_QUESTION = {
    "id": "not-carried",
    "tables": [],
    "tableNote": "Not table-specific — it applies to all 799, and decides "
                 "what a FHIR consumer can recover about any of them.",
    "where": [
        ("The same question for one field, the per-table OID, with what we do "
         "today", question_link("gq-chapter-2c-gives-every-table")),
        ("What the guide does carry, table by table",
         f"{IG}/table-index.html"),
    ],
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
<td>Describes the table as a whole. For the 362 tables with no code system
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
        "new": False,
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
        "new": False,
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

<p><b>The full detail</b> is in a register of 37 open items written for V2
Management and TSMG, which lists every affected table. This page is the
executive cut; the register has the evidence for each item, and the register
itself is now a page in the guide rather than a separate document, so every
item can be followed to the artifact it is about. The field-by-field mapping
behind the design question is still a separate document and can be circulated
on request.</p>
"""

# --------------------------------------------------------------------------
# Getting from an ask to the evidence
# --------------------------------------------------------------------------
#
# The lesson from the September Terminology Infrastructure meeting: an ask that
# names a problem but gives no way to reach the evidence fails in the room. You
# read the question out, somebody asks "which tables?", and you are hunting
# through the guide on a projector.
#
# These live here rather than in the Terminology Infrastructure briefing, which
# is where they were written, because both briefings need them and that module
# already imports from this one. Two copies would drift.
#
# `IG` itself is defined with the other paths at the top of the module, because
# the asks interpolate it and they are declared before this point.


def ledger_tables():
    """The table numbers the per-table ledger actually has a section for.

    The ledger only carries a table that has something to say about it, so a
    table an ask names may legitimately have no section. Linking to one anyway
    drops the reader at the top of a very long page, which is worse than not
    linking at all -- they cannot tell whether they missed it or it is not
    there.

    Read from the generated ledger rather than recomputed, for the same reason
    `generate_table_index` reads it: the ledger owns that decision, and a
    second copy of it drifts.
    """
    page = PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent" / "table-ledger.md"
    if not page.is_file():
        return set()
    return set(re.findall(r'id="tbl-([^"]+)"', page.read_text(encoding="utf-8")))


def table_chips(tables, known=None):
    """One chip per affected table, linked into the ledger where it has a section.

    A table with no ledger section still gets a chip -- it is affected, and the
    room needs the number -- but a plain one, so the page never offers a link
    that goes nowhere.
    """
    # Sorted here rather than trusted from the author, so a list written in
    # the order the evidence turned up still reads as table numbers.
    known = ledger_tables() if known is None else known
    out = []
    for table in sorted(tables):
        if table in known:
            out.append(f'<a class="tbl" '
                       f'href="{IG}/table-ledger.html#tbl-{table}">{table}</a>')
        else:
            out.append(f'<span class="tbl tbl-plain">{table}</span>')
    return " ".join(out)


def where_block(ask):
    """The "where the detail lives" panel under one ask."""
    tables = ask.get("tables") or []
    links = ask.get("where") or []
    if not tables and not links:
        return ""
    out = ["<div class='where'>", "<b>Where the detail lives</b>"]
    if tables:
        out.append(f"<div class='chips'>{table_chips(tables)}</div>")
    if ask.get("tableNote"):
        out.append(f"<div class='chip-note'>{ask['tableNote']}</div>")
    unlinked = sorted(set(tables) - ledger_tables())
    if unlinked:
        out.append(f"<div class='chip-note'>{', '.join(unlinked)} "
                   f"{'has' if len(unlinked) == 1 else 'have'} no ledger "
                   f"section: the merge found nothing to report against "
                   f"{'it' if len(unlinked) == 1 else 'them'}, so "
                   f"{'it is' if len(unlinked) == 1 else 'they are'} shown "
                   f"without a link.</div>")
    if links:
        out.append("<ul class='where-links'>")
        out += [f"<li><a href='{href}'>{label}</a></li>" for label, href in links]
        out.append("</ul>")
    out.append("</div>")
    return "\n".join(out)


def where_markdown(ask):
    """The same pointers as `where_block`, for the Markdown twin.

    The twin is what gets pasted into an agenda or an email, so it has to carry
    the tables too. A twin that quietly dropped them would send people to the
    meeting with the version that cannot answer "which tables?".
    """
    lines = []
    if ask.get("tables"):
        lines += [f"**Affected tables:** {', '.join(sorted(ask['tables']))}", ""]
    if ask.get("tableNote"):
        lines += [_text(ask["tableNote"]), ""]
    for label, href in ask.get("where") or []:
        lines.append(f"- [{_text(label)}]({href})")
    if lines and lines[-1] != "":
        lines.append("")
    return lines


KIND_LABEL = {
    "blocker": ("BLOCKS US", "b-decide"),
    "finding": ("NEEDS ATTENTION", "b-flag"),
    "fyi": ("FYI", "b-info"),
}

# The badge marks what has appeared since the previous meeting, so that anyone
# who read the earlier version can skim to it rather than re-read the page.
# Nothing is marked for 23 September: the work since 28 August went into
# building the guide and shortening this list, not into finding new defects.
# The badge stays because the next meeting will very likely need it.
NEW_BADGE = "<span class='badge b-new'>NEW</span> "

EXTRA_STYLE = """
.badge.b-new { background: #1a7f37; }
.new-question { border: 2px solid #bc4c00; border-radius: 10px;
  padding: 18px 22px; margin: 22px 0; background: #fffaf5; }
.where { background: #f6f8fa; border: 1px solid #d0d7de; border-radius: 5px;
         padding: 0.6rem 0.8rem; margin: 0.9rem 0 0.2rem; font-size: 0.94em; }
.where > b { display: block; margin-bottom: 0.4rem; color: #24292f; }
.chips { line-height: 2.1; }
a.tbl { display: inline-block; font-family: monospace; font-weight: 600;
        background: #fff; border: 1px solid #0969da; border-radius: 3px;
        padding: 0.05rem 0.45rem; margin-right: 0.3rem; text-decoration: none; }
.chip-note { color: #57606a; margin-top: 0.35rem; }
span.tbl.tbl-plain { border-style: dashed; border-color: #8c959f;
                     color: #57606a; }
.where-links { margin: 0.45rem 0 0; padding-left: 1.1rem; }
.where-links li { margin: 0.15rem 0; }
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
    add("<a class='top' href='#blockers'>&uarr; The two at the top</a>")
    add("<h2>Blocking</h2>")
    for b in BLOCKERS:
        add(f"<a href='#{b['id']}'><span class='n'>{b['n']}</span>"
            f"{b['title']}</a>")
    add("<h2>Design question</h2>")
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
    add("<p class='asks-intro'>One question blocks us and one needs "
        "confirming. Everything else on "
        "this page needs acknowledgement rather than a decision.</p>")
    add("<ol class='asks-list'>")
    for b in BLOCKERS:
        label, cls = b.get("badge") or ("BLOCKS US", "b-decide")
        add(f"<li><span class='badge {cls}'>{label}</span> "
            f"<a href='#{b['id']}'>{b['title']}</a>"
            f"<div class='ask-line'>{b['ask']}</div></li>")
    add("</ol>")
    add("<p class='asks-foot'>Then <b>one design question</b>, open since "
        "August, that is not a defect but has a deadline, and <b>defects in "
        "the published chapter</b> "
        f"grouped into {len(CLASSES)} classes. Most of those need only a nod "
        "that they are real and will be fixed in a future publication.</p>")
    add("</section>")

    # ---- the new question ----
    add(f"<section class='new-question' id='{NEW_QUESTION['id']}'>")
    add(f"<h2 class='plain'>{NEW_QUESTION['title']}</h2>")
    add(f"<p class='lede'>{NEW_QUESTION['why']}</p>")
    add(NEW_QUESTION["body"])
    add(f"<p class='ask'><span class='ask-tag'>Ask</span>"
        f"{NEW_QUESTION['ask']}</p>")
    add(where_block(NEW_QUESTION))
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
    add("<h2>The two at the top of your list</h2>")
    for b in BLOCKERS:
        add(f"<section class='item k-decision' id='{b['id']}'>")
        label, cls = b.get("badge") or ("BLOCKS US", "b-decide")
        add(f"<h3><span class='badge {cls}'>{label}</span> "
            f"<span class='n'>{b['n']}.</span> {b['title']}</h3>")
        add(f"<p class='lede'>{b['why']}</p>")
        add(b["body"])
        add(f"<p class='ask'><span class='ask-tag'>Ask</span>{b['ask']}</p>")
        add(where_block(b))
        add("</section>")

    # ---- classes ----
    add("<h2>Defects in the published chapter, by class</h2>")
    add("<p class='sub'>Counts are tables affected. None of these blocks us; "
        "we have a working treatment for each and it is recorded. Every one "
        "of them is in <a href='" + IG + "/open-items.html'>the register</a> "
        "with its affected tables listed, and each table links through to "
        "<a href='" + IG + "/table-ledger.html'>the ledger entry</a> showing "
        "what we publish for it.</p>")
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
        tag = (b.get("badge") or ("BLOCKS US", ""))[0]
        out.append(f"{b['n']}. **[{tag}]** {_text(b['title'])}  ")
        out.append(f"   _Ask:_ {_text(b['ask'])}")
    out += ["", f"## {_text(NEW_QUESTION['title'])}", "",
            _text(NEW_QUESTION["why"]), "", _text(NEW_QUESTION["body"]).strip(),
            "", f"**Ask:** {_text(NEW_QUESTION['ask'])}", ""]
    out += where_markdown(NEW_QUESTION)
    out += ["## Already settled — here so they are not raised twice", ""]
    for name, tables, outcome in RESOLVED:
        out.append(f"- **{_text(name)}** ({_text(tables)}) — {_text(outcome)}")
    out += ["", "## The two at the top of your list", ""]
    for b in BLOCKERS:
        out += [f"### {b['n']}. {_text(b['title'])}", "",
                _text(b["why"]).strip(), "", _text(b["body"]).strip(), "",
                f"**Ask:** {_text(b['ask'])}", ""]
        out += where_markdown(b)
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
