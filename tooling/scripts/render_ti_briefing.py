#!/usr/bin/env python3
"""The Terminology Infrastructure WG briefing: executive summary + IG walkthrough.

Audience note, because it drives every editorial choice below: this room already
knows why the IG exists and knows FHIR IGs in general. So there is no "what is an
IG" section and no project history. What they do not know is what the IG *claims*,
how it backs those claims, and which of its open questions land on their desk.

Three claims, in the order the walkthrough makes them:

  1. It produces v2.9.1 fidelity artifacts **additively** with respect to THO --
     publishing at THO's canonicals without deleting what THO already carries.
  2. It surfaces issues, and groups them into **classes**, so a committee answers
     a policy question once instead of a data question fifty times.
  3. It keeps an **auditable record** of both kinds of imperfection: where v2.9.1
     could not be represented faithfully, and where this guide will substantively
     change content THO already publishes.

Every number here is transcribed from the 2026-09-20 build of the vocabulary IG
and is reproduced in the guide itself, on the page the walkthrough names. Nothing
in this file is computed -- it is an authored briefing, and the guide is the
source of truth. If a number here and a number in the guide disagree, the guide
is right and this file is stale.

Renders an HTML briefing and a Markdown twin, matching render_v2mgmt_briefing.py.
"""

import argparse
import html
from pathlib import Path

import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from briefing_style import STYLE  # noqa: E402

# The HTML->Markdown converter is shared with the V2 Management briefing rather
# than duplicated. It is private there; importing it is deliberate and is the
# smaller evil against a second copy of sixty lines of regex that would drift.
from render_v2mgmt_briefing import _text, _close_tables  # noqa: E402

# The link helpers live in the V2 Management briefing module. They were written
# here, for this document, and moved down when that briefing needed them too --
# both rooms ask "which tables?" and one copy of the answer is enough.
from render_v2mgmt_briefing import (  # noqa: E402,F401
    IG, table_chips, where_block, question_link)

PROJECT_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_HTML = PROJECT_ROOT / "v291-extracted" / "ti-briefing.html"
DEFAULT_MD = PROJECT_ROOT / "v291-extracted" / "ti-briefing.md"

TITLE = "V2.9.1 Chapter 2C terminology"
SUBTITLE = "Executive briefing and IG walkthrough — Terminology Infrastructure WG"
MEETING_DATE = "2026-09-21"
BUILD_DATE = "2026-09-20"

SUMMARY = """
<p>This guide turns the whole of <b>Chapter 2C of HL7 V2.9.1 &mdash; 799 tables</b>
&mdash; into FHIR CodeSystems and ValueSets: <b>824 artifacts</b>, built and
validating, with <b>zero broken links</b> across 625,068 checked.</p>

<p><b>It is additive with respect to THO.</b> We publish at THO's own canonical
URLs, which means a naive load would silently delete anything THO carries that
Chapter 2C is silent about. It does not: <b>7,580 values that exist only in THO
are preserved</b>, and <b>732 of 823 artifacts keep THO's existing version
number</b> because nothing about them actually changed. The merge is the
mechanism, and it is inspectable table by table.</p>

<p><b>It surfaces issues as classes, not as a list of incidents.</b> Where the
same defect appears in twenty-five tables, it is one item that says so. That is
what makes a committee answer tractable: one ruling settles twenty-five tables.</p>

<p><b>It keeps an auditable record of every place the representation is not
perfect</b> &mdash; both the places where v2.9.1 could not be reproduced exactly
and something had to be resolved, and the places where this guide will
substantively change content THO already publishes. Those are on separate pages
from the open questions, deliberately: one page asks you for something, the
other asks you for nothing and exists so that nothing is hidden.</p>

<p><b>What this room is being asked for</b> is on the last section of this page:
five questions with terminology-infrastructure teeth, plus one defect that is
THO's rather than ours.</p>
"""

METRICS = [
    ("824", "artifacts generated", "good"),
    ("732", "keep THO's version", "good"),
    ("7,580", "THO-only values preserved", "good"),
    ("0", "broken links", "good"),
    ("57", "open items", "flag"),
    ("5", "questions for this room", "escalate"),
]

# --------------------------------------------------------------------------
# The walkthrough
# --------------------------------------------------------------------------
#
# Six stops, in the order that makes the argument build. The ordering is the
# point: the merge page has to come before the per-table pages, because the
# per-table pages only make sense once you accept that we are writing into
# THO's canonicals rather than alongside them.
#
# Each stop carries "say" (the one sentence to say out loud while the page is
# on screen) and "show" (what to actually point at). Kept to one screen each --
# a walkthrough with more than six stops becomes a tour of a website.

WALKTHROUGH = [
    {
        "id": "w-index",
        "n": 1,
        "page": "index.html",
        "name": "Home",
        "say": "This is the whole of Chapter 2C as FHIR, and here is its size.",
        "show": """
<p>Point at the counts and move on: <b>399 CodeSystems, 424 ValueSets</b>, plus
the <code>conceptdomains</code> code system, <b>824 total</b>. The page
self-checks these numbers against what was actually staged, so they cannot
drift from the build.</p>
<p>Thirty seconds. The interesting pages are the next five.</p>""",
    },
    {
        "id": "w-merge",
        "n": 2,
        "page": "tho-merge.html",
        "name": "The THO merge",
        "say": "We publish at THO's canonicals, so the merge is the thing that "
               "stops us destroying what THO already has.",
        "show": """
<p><b>This is the most important page in the guide for this audience.</b> Four
numbers carry the additive claim:</p>
<table>
<tr><th>Class</th><th>Count</th><th>What it means</th></tr>
<tr><td><b>Kept from THO</b></td><td class='nowrap'>7,580</td>
<td>Content THO publishes that Chapter 2C says nothing about. Without the merge
each of these would have been <i>deleted</i> from an artifact at THO's own URL.
None of them changes the artifact, so none costs a version increment.</td></tr>
<tr><td><b>Disagreements</b></td><td class='nowrap'>489</td>
<td>Both sides carry a value and they differ. The chapter's value is published
&mdash; publishing the chapter is what this guide is for &mdash; and each one is
listed so it is a decision rather than an accident.</td></tr>
<tr><td><b>Added here</b></td><td class='nowrap'>159</td>
<td>Content Chapter 2C has and THO does not. These are real changes and they do
drive version increments.</td></tr>
<tr><td><b>Not published</b></td><td class='nowrap'>45</td>
<td>THO has an artifact, this guide writes nothing at that canonical. THO's
artifact stands untouched; the merge does not invent a replacement.</td></tr>
</table>
<p>Then the versioning table, which is the same claim from the other side:</p>
<ul>
<li><b>CodeSystems</b> &mdash; 339 keep THO's version, 58 incremented, 2 first
publication at 1.0.0.</li>
<li><b>ValueSets</b> &mdash; 393 keep THO's version, 22 incremented, 9 first
publication at 1.0.0.</li>
</ul>
<p><b>732 of 823 unchanged.</b> That is the number to say out loud. A version is
computed from the policy on every run rather than asserted by hand, so
&ldquo;unchanged&rdquo; is a derived fact about content, not a claim about
intent.</p>""",
    },
    {
        "id": "w-index-tables",
        "n": 3,
        "page": "table-index.html",
        "name": "Table index — coverage",
        "say": "All 799 tables on one page, and the twenty that are not where "
               "you would expect.",
        "show": """
<p>The whole chapter, one row per table, showing which code system, value set
and concept domain each one landed on. For most tables the artifact exists both
here and in THO &mdash; this guide is a redraft of something THO already
carries, and that is the unshaded norm.</p>
<p>Go straight to <b>the tables whose artifact is missing, unexpected, or cannot
expand</b> &mdash; <b>20 of 799</b>, in four kinds:</p>
<table>
<tr><th>Kind</th><th>Count</th><th>Meaning</th></tr>
<tr><td><b>New to THO</b></td><td>9</td><td>This guide authors something THO
does not carry.</td></tr>
<tr><td><b>Dangling in THO</b></td><td>4</td><td>THO's value set composes from a
code system THO does not publish, so <b>it cannot expand</b>. See the ask
below &mdash; this one is THO's, not ours.</td></tr>
<tr><td><b>In THO, not here</b></td><td>2</td><td>THO publishes at this
canonical and this guide does not author it.</td></tr>
<tr><td><b>Nothing anywhere</b></td><td>5</td><td>No concept domain, no code
system, no value set &mdash; here or in THO. Nobody has decided what these
should be.</td></tr>
</table>
<p>This page answers <i>does the right kind of artifact exist at all</i>. It is
a different question from the ledger's, and each page now says so in as many
words &mdash; the two counts differ by an order of magnitude and a reader who
met both used to conclude one page was broken.</p>""",
    },
    {
        "id": "w-ledger",
        "n": 4,
        "page": "table-ledger.html",
        "name": "Table ledger — content",
        "say": "Per table, exactly how we differ from THO and why.",
        "show": """
<p>The per-table view of the same merge. For any table, this is where a reviewer
sees the individual differences, what was kept from THO, which register items
name it, and the OID situation.</p>
<p>Headline: <b>96 tables differ from THO</b> in at least one published element,
<b>101 carry an open register item</b>, and <b>14 are blocked on a decision</b>
with nothing published for them yet.</p>
<p>Demonstrate <b>&ldquo;Also affects&rdquo;</b> on any difference &mdash; it is
the feature that matters most here. A row reading <i>24 other tables</i> tells
you immediately that you are looking at a policy question rather than a
data-entry question, and that answering it once answers it twenty-five times.
That is the whole reason this is reviewable at committee speed.</p>""",
    },
    {
        "id": "w-open",
        "n": 5,
        "page": "open-items.html",
        "name": "What needs an answer",
        "say": "Everything the guide is actually asking anyone for, in one place.",
        "show": """
<p><b>57 open items</b> plus <b>7 general questions</b>. The general questions
are the ones where producing anything at all required a judgement rather than a
fact; each states <b>what this build currently does</b> and <b>what we would
change</b> if the answer comes back differently.</p>
<p>Say this part explicitly, because it is the thing that makes the guide safe
to review: <b>none of them is blocking.</b> Every question has a defensible
working answer already applied and shipping. We are asking for confirmation,
not for permission to proceed.</p>
<p>Of the 57, <b>39 are escalations</b> (defects in the published chapter, in
THO, or in both &mdash; none of them ours to resolve) and <b>14 are decisions</b>
still to take.</p>""",
    },
    {
        "id": "w-evidence",
        "n": 6,
        "page": "evidence.html",
        "name": "Evidence — the audit trail",
        "say": "Everything already settled, so that nothing is hidden. This page "
               "asks you for nothing.",
        "show": """
<p>The counterpart to the previous page, and the answer to &ldquo;what did you
change without telling us?&rdquo;</p>
<ul>
<li><b>Decided</b> &mdash; 74 groups, <b>1,534 values</b>. Where the guide made
a call and applied it.</li>
<li><b>Informational</b> &mdash; 17 groups, <b>544 values</b>. Disclosures that
need no action.</li>
</ul>
<p>The split between this page and the last is <b>by the action class the
underlying report already assigns</b>, not by a second editorial judgement. A
finding moves pages by being re-classified and cannot appear on both; an
unclassified group stops the build rather than being quietly dropped.</p>
<p>Worth saying out loud: <b>this page says outright that it asks for
nothing.</b> It exists so that a reviewer can satisfy themselves that the
things not being asked about were not being hidden.</p>""",
    },
]

# --------------------------------------------------------------------------
# The asks
# --------------------------------------------------------------------------
#
# Filtered hard for this room. The guide carries seven general questions; three
# of them are about what Chapter 2C says and belong to V2 Management, so they
# are named at the foot rather than argued here. What is left is the set where
# terminology-infrastructure expertise is the thing actually needed.
#
# The last item is not one of the seven. It is a defect in THO itself, and this
# is the only room where raising it is useful.

# --------------------------------------------------------------------------
# Getting from a question to the evidence
# --------------------------------------------------------------------------
#
# The asks below name a problem; the IG holds the detail that answers it. In a
# meeting the gap between those two is what kills you -- you read the question
# out, somebody asks "which tables?", and you are hunting through 799 sections
# on a projector.
#
# So every ask carries the affected tables and a direct link per table. The
# path is relative, which works both from a local build opened off disk and
# from the two published side by side.

ASKS = [
    {
        "id": "a-reorder",
        "tables": [],
        "tableNote": "Not table-specific — it decides how many of the 823 artifacts keep THO's version.",
        "where": [('The versioning table: 339 + 393 artifacts currently unchanged', f'{IG}/tho-merge.html'), ('Question 1, with what this build does and what would change', question_link("gq-does-reordering-a-code-system"))],
        "n": 1,
        "tag": "TSMG",
        "title": "Does reordering a code system's concepts count as a change?",
        "why": "This is the artifact-versioning question, and it is the one "
               "item in the guide that is explicitly TSMG's rather than V2 "
               "Management's.",
        "body": """
<p>Chapter 2C and THO frequently agree on the whole set of concepts but present
them in a different order. Under our versioning policy a version increments when
the content changes. Is concept order content?</p>
<p><b>What this build does:</b> treats order as presentation, not content, so a
pure reordering keeps THO's version. That is why the &ldquo;unchanged&rdquo;
count is as high as it is.</p>
<p><b>If the answer is no,</b> a meaningful number of artifacts move from
&ldquo;unchanged&rdquo; to &ldquo;incremented&rdquo; and the headline 732 falls.
Nothing else changes &mdash; the published content is identical either way.</p>""",
        "ask": "Confirm that concept order is presentation, or tell us it is "
               "content and we will re-run the policy.",
    },
    {
        "id": "a-status",
        "tables": ['0440', '0003', '0357'],
        "tableNote": '0440 is the one carrying <code>B</code>. The <code>N</code>-reads-as-<code>active</code> mapping spans 25 tables and is now listed per table as &ldquo;written differently&rdquo; rather than as a disagreement.',
        "where": [('Question 2, on where the letters should be defined', question_link("gq-the-concept-status-b-and"))],
        "n": 2,
        "tag": "TSMG / THO",
        "title": "The concept status letters, and where they should be defined",
        "why": "It is a question about THO's property vocabulary, which is this "
               "room's to answer.",
        "body": """
<p>Chapter 2C marks concepts with status letters &mdash; including
<code>B</code> &mdash; that describe a concept's standing within the table. FHIR
has no native slot for them, so they become properties, and a property needs a
definition somewhere durable.</p>
<p><b>The question is where.</b> If these letters are a v2 concern they belong
in a v2 code system; if they are the same idea THO already expresses elsewhere,
they should reuse THO's existing property rather than minting a parallel
vocabulary that means the same thing.</p>""",
        "ask": "Tell us whether these letters should be defined in THO's "
               "existing property vocabulary or in a v2-specific one.",
    },
    {
        "id": "a-oid-collision",
        "tables": ['0001', '0719', '0078'],
        "tableNote": 'The only two OID disagreements in the corpus (0001, 0719) plus 0078, which is different in kind. 395 of 396 code system OIDs and 411 of 412 value set OIDs agree.',
        "where": [('Question 4, with the OID for each side side by side', question_link("gq-three-oids-where-one-number"))],
        "n": 3,
        "tag": "Identifiers",
        "title": "Three OIDs where one number would end up naming two artifacts",
        "why": "An OID naming two distinct artifacts is an identifier defect "
               "that outlives whatever we publish.",
        "body": """
<p>In three cases the chapter's numbering leads to a single OID being carried by
two different artifacts. An identifier that resolves to two things is not an
identifier, and unlike a content disagreement this does not get better by
picking a winner on content grounds.</p>""",
        "ask": "Rule on which artifact keeps the number, or confirm that a new "
               "OID should be minted for the other.",
    },
    {
        "id": "a-table-oid",
        "tables": [],
        "tableNote": 'All 799 tables carry one; 50 of them are a bare arc root with no leaf.',
        "where": [('The OID overview at the head of the ledger', f'{IG}/table-ledger.html'), ('Question 6, on where the table OID should land', question_link("gq-chapter-2c-gives-every-table"))],
        "n": 4,
        "tag": "Identifiers",
        "title": "Chapter 2C gives every table an OID, and it is published nowhere",
        "why": "It is a modelling question about what survives the move from V2 "
               "to FHIR, and the current behaviour is an accident rather than a "
               "decision.",
        "body": """
<p>In V2 the <i>table</i> is the thing with an identity. In FHIR that table
becomes a code system <b>and</b> a value set, and neither of them is the table.
So the table's own OID is carried by no published resource.</p>
<p><b>This is current behaviour, not a decision anyone has taken.</b> It is
called out in the guide in exactly those terms. Note also that <b>50 of the
table OIDs are not identifiers at all</b> &mdash; they are a bare arc root with
no leaf, on tables the chapter itself types <i>undefined</i>. Nothing should
ever resolve those.</p>""",
        "ask": "Decide whether the table OID should land on the code system, the "
               "value set, both, or be allowed to lapse.",
    },
    {
        "id": "a-descriptions",
        "tables": ['0227', '0719'],
        "tableNote": '0227 is settled; 0719 is the one still open.',
        "where": [('Question 5, with both descriptions in full', question_link("gq-two-descriptions-where-tho-says"))],
        "n": 5,
        "tag": "Merge policy",
        "title": "Two descriptions where THO says more than the chapter",
        "why": "It is the one place where the merge rule and the fidelity rule "
               "point in opposite directions.",
        "body": """
<p>Our default is that on a genuine disagreement the chapter wins, because
publishing the chapter is the point. In two cases THO's description is simply
<i>better</i> &mdash; more complete, and not in conflict. Fidelity says publish
the chapter's; the additive principle says do not throw away what THO has.</p>
<p><b>What this build does:</b> publishes the chapter's text and lists both, so
the choice is visible rather than silent.</p>""",
        "ask": "Confirm the chapter wins even when THO's text is better, or give "
               "us a rule for when it does not.",
    },
    {
        "id": "a-dangling",
        "tables": ['0350', '0351', '0456', '0895'],
        "tableNote": 'All four are flagged <i>Dangling in THO</i> on the table index, which names the code system each one composes from.',
        "where": [('The coverage anomalies, where these are listed with the other 16', f'{IG}/table-index.html#coverage-anomalies')],
        "n": 6,
        "tag": "THO defect",
        "title": "Four THO value sets compose from code systems THO does not publish",
        "why": "This one is not ours and is not a question &mdash; it is a "
               "defect in THO that we found, and this is the room that can fix "
               "it.",
        "body": """
<p>Four value sets published by THO compose from a code system THO does not
publish. <b>They cannot expand.</b> Any client that tries to expand them fails,
and that is true today, independent of anything this guide does.</p>
<p>We are not proposing to fix them &mdash; they are THO's artifacts. They are
flagged on the table index as <i>Dangling in THO</i> so that the situation is
visible rather than inherited silently.</p>""",
        "ask": "Take these four away as a THO maintenance item.",
    },
]

FOOTER_NOTE = """
<p>The remaining general questions in the guide are about what Chapter 2C itself
says rather than about terminology infrastructure, and are going to <b>V2
Management</b>: <b>Table 0560</b>, a code system the chapter says does not
exist; and <b>Table 0292</b>, published against the chapter's own flag pending a
ruling. They are listed here only so that nobody leaves thinking they have seen
the whole register.</p>

<p class='prov'>Every figure on this page is transcribed from the
<b>%s</b> build of the vocabulary IG and is reproduced in the guide on the page
named beside it. Where this page and the guide disagree, the guide is
right.</p>
""" % BUILD_DATE

EXTRA_STYLE = """
.where { background: #f6f8fa; border: 1px solid #d0d7de; border-radius: 5px;
         padding: 0.6rem 0.8rem; margin: 0.9rem 0 0.2rem; font-size: 0.94em; }
.where > b { display: block; margin-bottom: 0.4rem; color: #24292f; }
.chips { line-height: 2.1; }
a.tbl { display: inline-block; font-family: monospace; font-weight: 600;
        background: #fff; border: 1px solid #0969da; border-radius: 3px;
        padding: 0.05rem 0.45rem; margin-right: 0.3rem; text-decoration: none; }
.chip-note { color: #57606a; margin-top: 0.35rem; }
.where-links { margin: 0.45rem 0 0; padding-left: 1.1rem; }
.where-links li { margin: 0.15rem 0; }
.stop { border-left: 3px solid #0969da; padding: 0.1rem 0 0.1rem 1.1rem;
        margin: 1.8rem 0; }
.stop .pg { font-family: monospace; font-size: 0.86em; color: #57606a; }
.stop .say { background: #f0f6ff; border-left: 2px solid #0969da;
             padding: 0.45rem 0.7rem; font-style: italic; margin: 0.5rem 0; }
.ask-item { border-left: 3px solid #cf222e; padding: 0.1rem 0 0.1rem 1.1rem;
            margin: 1.8rem 0; }
.ask-item .tag { display: inline-block; background: #eaeef2; color: #24292f;
                 border-radius: 3px; padding: 0.05rem 0.45rem;
                 font-size: 0.78em; font-weight: 600; letter-spacing: 0.02em; }
.prov { color: #57606a; font-size: 0.9em; border-top: 1px solid #d0d7de;
        padding-top: 0.8rem; margin-top: 2rem; }
.nowrap { white-space: nowrap; }
"""


def render_html(generated):
    """Build the whole briefing as one self-contained HTML string."""
    out = []
    add = out.append

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add(f"<title>{html.escape(TITLE)} &mdash; Terminology Infrastructure "
        "briefing</title>")
    add(f"<style>{STYLE}{EXTRA_STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<nav id='sidebar'>")
    add(f"<div class='brand'>{TITLE}</div>")
    add(f"<div class='brand-sub'>{SUBTITLE}</div>")
    add("<a class='top' href='#summary'>&uarr; Executive summary</a>")
    add("<h2>Walkthrough</h2>")
    for s in WALKTHROUGH:
        add(f"<a href='#{s['id']}'><span class='n'>{s['n']}</span>{s['name']}</a>")
    add("<h2>Asks</h2>")
    for a in ASKS:
        add(f"<a href='#{a['id']}'><span class='n'>{a['n']}</span>{a['title']}</a>")
    add("</nav>")

    # ---- main ----
    add("<main id='main'>")
    add(f"<h1>{TITLE}</h1>")
    add(f"<p class='sub'>{SUBTITLE} &middot; {html.escape(MEETING_DATE)}</p>")
    add("<section id='summary'>")
    add(SUMMARY)
    add("</section>")

    add("<div class='metric-grid'>")
    for number, label, tone in METRICS:
        add(f"<div class='metric-card mc-{tone}'>"
            f"<div class='number'>{number}</div>"
            f"<div class='label'>{label}</div></div>")
    add("</div>")

    # ---- the walkthrough ----
    add("<h2 id='walkthrough'>The walkthrough &mdash; six stops</h2>")
    add("<p class='sub'>In this order. The merge page has to come before the "
        "per-table pages, because those only make sense once you accept that we "
        "write into THO's canonicals rather than alongside them.</p>")
    for s in WALKTHROUGH:
        add(f"<section class='stop' id='{s['id']}'>")
        add(f"<h3>{s['n']}. {s['name']} "
            f"<span class='pg'>{html.escape(s['page'])}</span></h3>")
        add(f"<p class='say'>&ldquo;{s['say']}&rdquo;</p>")
        add(s["show"])
        add("</section>")

    # ---- the asks ----
    add("<h2 id='asks'>What we are asking this room for</h2>")
    add("<p class='sub'>Five questions and one THO defect. None of them blocks "
        "us &mdash; every one has a working answer already applied and "
        "shipping.</p>")
    for a in ASKS:
        add(f"<section class='ask-item' id='{a['id']}'>")
        add(f"<h3><span class='tag'>{a['tag']}</span> {a['n']}. {a['title']}</h3>")
        add(f"<p class='lede'>{a['why']}</p>")
        add(a["body"])
        add(f"<p class='ask'><span class='ask-tag'>Ask</span>{a['ask']}</p>")
        add(where_block(a))
        add("</section>")

    add(FOOTER_NOTE)
    add("</main></body></html>")
    return "\n".join(out)


def render_markdown(generated):
    """The Markdown twin, for pasting into a tracker or an agenda."""
    # `_text` returns one finished Markdown string per fragment -- already
    # joined and already table-closed -- so each goes in with append. Using
    # `+=` here splits it into characters.
    lines = [f"# {TITLE}", "", f"_{SUBTITLE} — {MEETING_DATE}_", ""]
    lines.append(_text(SUMMARY))
    lines.append("")

    metrics = ["| | |", "|---|---|"]
    metrics += [f"| **{number}** | {label} |" for number, label, _t in METRICS]
    lines.append("\n".join(metrics))
    lines.append("")

    lines += ["## The walkthrough — six stops", ""]
    for s in WALKTHROUGH:
        lines += [f"### {s['n']}. {s['name']} (`{s['page']}`)", "",
                  f"> {s['say']}", ""]
        lines.append(_text(s["show"]))
        lines.append("")

    lines += ["## What we are asking this room for", ""]
    for a in ASKS:
        lines += [f"### {a['n']}. {a['title']} [{a['tag']}]", "", a["why"], ""]
        lines.append(_text(a["body"]))
        lines += ["", f"**Ask:** {a['ask']}", ""]
        if a.get("tables"):
            lines += [f"**Affected tables:** "
                      f"{', '.join(sorted(a['tables']))}", ""]
        if a.get("tableNote"):
            lines += [_text(a["tableNote"]), ""]
        for label, href in a.get("where") or []:
            lines.append(f"- [{label}]({href})")
        lines.append("")

    lines.append(_text(FOOTER_NOTE))
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default=str(DEFAULT_HTML))
    parser.add_argument("--markdown", default=str(DEFAULT_MD))
    args = parser.parse_args()

    generated = MEETING_DATE
    Path(args.output).write_text(render_html(generated), encoding="utf-8")
    Path(args.markdown).write_text(render_markdown(generated), encoding="utf-8")
    print(f"wrote {args.output}")
    print(f"wrote {args.markdown}")


if __name__ == "__main__":
    main()
