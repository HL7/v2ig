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
MEETING_DATE = "2026-08-21"

SUMMARY = """
<p>We have extracted the whole of Chapter 2C &mdash; <b>799 tables, 5,540
codes</b> &mdash; and are turning it into FHIR CodeSystems and ValueSets. The
extraction and text-fidelity pass is <b>complete and reviewed</b>. Nothing is
outstanding on our side.</p>

<p>The work is destined for <b>THO</b>, and it establishes a corrected baseline
for v2 terminology there. We met the UTG subcommittee of TSMG yesterday and
they are receptive; the canonical URLs and the merge route are agreed.</p>

<p><b>What we need from V2 Management is two rulings and a stack of
acknowledgements.</b> Along the way we found defects in the published chapter.
Most are mechanical and need only a nod &mdash; and three items that were on
an earlier draft of this page have already come off it, listed below so nobody
raises them twice.</p>
"""

METRICS = [
    ("799", "tables extracted", "good"),
    ("5,540", "codes", "good"),
    ("100%", "text fidelity pass complete", "good"),
    ("2", "blocking questions", "escalate"),
    ("~30", "chapter defects found", "flag"),
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
""",
        "ask": "Rule on the principle, not the instances: reproduce and record, "
               "reproduce but deprecate, or correct and annotate. We will "
               "apply whatever you decide and bring back the affected list.",
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
    ("&ldquo;All codes&rdquo; in a Content Logical Definition",
     "0929&ndash;0932",
     "Not ambiguous. A CLD reading &ldquo;all codes from a given code "
     "system&rdquo; is ordinary FHIR and is how value sets normally work; we "
     "express this in FHIR, so the term is already defined for us. <b>What "
     "remains is a narrower chapter defect:</b> 0931 and 0932 say &ldquo;all "
     "codes&rdquo; and then enumerate two or three UCUM codes, which is not "
     "what that phrase means. Filed under wording, below."),
    ("The two duplicate table pairs",
     "0567/0929, 0568/0930",
     "One of each pair is deprecated and the other is in use. We publish both "
     "&mdash; the older marked deprecated. No decision needed."),
    ("Concept-domain-only tables that also list codes",
     "0093, 0340, 0451",
     "Not a contradiction &mdash; we had this backwards. The V3 requirements "
     "for declaring a concept domain call for <b>example codes</b>, so these "
     "tables are correct as published. Likely treatment is to carry the "
     "examples as a property on the concept domain code system. Low priority; "
     "no action from V2 Management."),
]

# --------------------------------------------------------------------------
# Everything else, as classes
# --------------------------------------------------------------------------
#
# `severity` drives the colour. `need` is what we want from them, and for most
# of these it is genuinely just acknowledgement -- saying so plainly is what
# keeps the meeting short.

CLASSES = [
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

<p><b>The full detail</b> is in a 12-item register written for V2 Management
and TSMG. This page is the executive cut; the register has the evidence for
each item.</p>
"""

KIND_LABEL = {
    "blocker": ("BLOCKS US", "b-decide"),
    "finding": ("NEEDS ATTENTION", "b-flag"),
    "fyi": ("FYI", "b-info"),
}


def render_html(generated):
    """Build the whole briefing as one self-contained HTML string."""
    out = []
    add = out.append

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add(f"<title>{html.escape(TITLE)} &mdash; V2 Management briefing</title>")
    add(f"<style>{STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<nav id='sidebar'>")
    add(f"<div class='brand'>{TITLE}</div>")
    add(f"<div class='brand-sub'>{SUBTITLE}</div>")
    add("<a class='top' href='#blockers'>&uarr; The two that block us</a>")
    add("<h2>Blocking</h2>")
    for b in BLOCKERS:
        add(f"<a href='#{b['id']}'><span class='n'>{b['n']}</span>"
            f"{b['title']}</a>")
    add("<h2>Settled</h2>")
    add("<a href='#resolved'><span class='n'>&check;</span>Came off the "
        "list</a>")
    add("<h2>Defect classes</h2>")
    for c in CLASSES:
        add(f"<a href='#{c['id']}'><span class='n'>&bull;</span>{c['name']} "
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
    add("<p class='asks-foot'>Below that: <b>~30 defects in the published "
        "chapter</b>, grouped into five classes. Most need only a nod that "
        "they are real and will be fixed in a future publication.</p>")
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
        add(f"<h3><span class='badge {cls}'>{label}</span> {c['name']} "
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


def _text(s):
    """Crude HTML-to-text, for the Markdown twin."""
    import re
    return html.unescape(re.sub(r"<[^>]+>", "", s))


def render_markdown(generated):
    """The same briefing as Markdown, for quoting into email or minutes."""
    out = [f"# {TITLE} — {SUBTITLE}", "", f"**{MEETING_DATE}**", "",
           _text(SUMMARY).strip(), "", "## If you read one thing", ""]
    for b in BLOCKERS:
        out.append(f"{b['n']}. **[BLOCKS US]** {_text(b['title'])}  ")
        out.append(f"   _Ask:_ {_text(b['ask'])}")
    out += ["", "## Already settled — here so they are not raised twice", ""]
    for name, tables, outcome in RESOLVED:
        out.append(f"- **{_text(name)}** ({_text(tables)}) — {_text(outcome)}")
    out += ["", "## The two that block us", ""]
    for b in BLOCKERS:
        out += [f"### {b['n']}. {_text(b['title'])}", "",
                _text(b["why"]).strip(), "", _text(b["body"]).strip(), "",
                f"**Ask:** {_text(b['ask'])}", ""]
    out += ["## Defects in the published chapter, by class", ""]
    for c in CLASSES:
        out += [f"### {_text(c['name'])} — {c['count']}", "",
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
