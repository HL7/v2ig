#!/usr/bin/env python3
"""The UTG subcommittee briefing, authored here and rendered to HTML.

The 12-item escalation register in ``vocabulary_escalations.py`` is written for
V2 Management and TSMG together. A UTG subcommittee meeting needs a different
cut of the same material: what UTG owns, what it has to decide, and what is
simply arriving. Most of the register is V2 Management's business and would
burn meeting time, so it is reduced to a one-line table at the end.

The briefing is authored in this module, not in the output file, for the same
reason the register is: it is rendered to more than one format, and a
hand-edited output silently diverges from its sibling.

Two audiences, and the layout serves both:

  * someone skimming five minutes before the meeting, who needs the asks and
    nothing else -- hence the ASKS card at the top and the sidebar;
  * someone reading an item in detail during discussion, who needs the
    evidence -- hence the full body of each item, with every count sourced.

Run:
    python3 tooling/scripts/render_utg_briefing.py
"""

import argparse
import html
import sys
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from briefing_style import STYLE  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_HTML = PROJECT_ROOT / "v291-extracted" / "utg-briefing.html"
DEFAULT_MD = PROJECT_ROOT / "v291-extracted" / "utg-briefing.md"

MEETING_DATE = "2026-08-20"

# --------------------------------------------------------------------------
# The briefing
# --------------------------------------------------------------------------
#
# Every item is one of three kinds, and the kind drives both the badge and the
# order. A reader scanning for "what does this meeting need from me" should be
# able to find it by colour alone.
#
#   decision   UTG has to rule on it, and work is gated behind the answer
#   finding    a defect or gap in THO we found; UTG action, but not a debate
#   fyi        visibility only, no decision sought
#
# `ask` is the single sentence the item exists for. Every item has one; an item
# with nothing to ask does not belong in a briefing.

TITLE = "V2.9.1 Chapter 2C terminology"
SUBTITLE = "Briefing for the UTG subcommittee of TSMG"

SUMMARY = """
<p>We are building a FHIR IG that carries the V2.9.1 Chapter 2C vocabulary as
CodeSystems and ValueSets. <b>It is a workspace, not a publication.</b> Its
only destination is integration into THO, so resources are authored at
<code>http://terminology.hl7.org/</code> canonicals from the start.</p>

<p>The extraction and text-fidelity pass is <b>complete</b> &mdash; 799 tables,
5,540 codes, every divergence from the published text recorded and reviewed,
nothing outstanding. Resource generation is next and is gated on decisions,
several of which are UTG's.</p>
"""

METRICS = [
    ("799", "tables extracted", "good"),
    ("5,540", "codes", "good"),
    ("740/799", "cross-pipeline agreement", "good"),
    ("4", "decisions needed from UTG", "escalate"),
    ("4", "THO gaps found", "flag"),
]

ITEMS = [
    # ---------------------------------------------------------------- asks
    {
        "id": "policy",
        "kind": "decision",
        "n": 1,
        "title": "Where V2 published an error, does THO reproduce it or "
                 "correct it?",
        "tables": "policy",
        "lede": "This unblocks the most work, and UTG has already answered it "
                "once by precedent &mdash; but answered it the other way "
                "somewhere else.",
        "body": """
<p>Chapter 2C table <b>0931 Temperature Units</b> publishes three codes:
<code>degF</code> (status <code>D</code>, comment &ldquo;typo&rdquo;),
<code>[degF]</code>, and <code>Cel</code>. <code>degF</code> is not valid UCUM
&mdash; UCUM requires the brackets &mdash; so the chapter publishes a
known-invalid code beside its correction, with two of three entries meaning
Degrees Fahrenheit.</p>

<p><b>THO already fixed this.</b> <code>ValueSet/v2-0931</code> v2.0.0 carries
only <code>[degF]</code> and <code>Cel</code>, and folds the history into the
display text: <i>&ldquo;Degrees Fahrenheit (note that V2 has erroneously
published this for many years without the square brackets).&rdquo;</i></p>

<p>That is a good decision. We would like to know whether it is <b>policy or a
one-off</b>, because our working default is the opposite &mdash; reproduce and
record &mdash; and nobody has ratified it.</p>

<div class="counter">
<p><b>The counter-example, worth having in the room.</b> Table <b>0560 Quantity
Units</b> is named for quantity, bound to <code>ADJ-6</code>, and publishes
five codes of which four are units of <i>time</i> (<code>HS</code> Hours,
<code>DY</code> Days, <code>MN</code> Month, <code>YY</code> Years).
<b><code>CodeSystem/v2-0560</code> in THO 3.0.0 publishes the same five.</b>
So here THO reproduced rather than corrected.</p>
<p class="tight">0931 and 0560 currently point in opposite directions. This is
a live inconsistency inside THO, not an abstract question.</p>
</div>
""",
        "ask": "Is &ldquo;correct in THO, record the history in the display "
               "text&rdquo; the rule? If so we will apply it consistently and "
               "bring back the list of affected tables.",
    },
    {
        "id": "merge",
        "kind": "decision",
        "n": 2,
        "title": "Merge mechanics &mdash; we want a diff that shows only real "
                 "changes",
        "tables": "process",
        "lede": "We would rather design for a reviewable merge now than "
                "retrofit one onto 800 resources.",
        "body": """
<div class="settled">
<p><b>Settled on our side.</b> We will emit <b>XML</b> into UTG's layout
(<code>input/sourceOfTruth/v2/{codeSystems,valueSets}/</code>), and match THO's
existing serialization closely enough that <b>a resource we do not change
produces no diff at all</b> &mdash; no reindentation, no reordered elements, no
whitespace noise. The review should read <i>&ldquo;here are the N resources
that actually change&rdquo;</i>, not <i>&ldquo;here are 800 files&rdquo;</i>.</p>
<p class="tight">We will enforce it with a round-trip test: take THO's existing
v2 XML, run it through our writer untouched, assert the bytes come back
identical. Anything that fails is a serialization bug, not a content change.</p>
</div>

<p>What we need from UTG is what we cannot see from the published package:</p>
<ol>
<li><b>Which UTG checkout should we diff against?</b> We have
<code>hl7.terminology.r5</code> v7.3.0 (JSON) but not the source repo. We need
the repo, and to know which branch is the right base.</li>
<li><b>Are the conventions written down,</b> or should we infer them from the
existing files? Specifically element ordering, indent width, self-closing tag
style, line endings, and <b>whether the <code>text</code> narrative is
hand-authored or regenerated by tooling</b>. Narrative is the likeliest source
of spurious diffs &mdash; a regenerated <code>div</code> touches every file
while meaning nothing.</li>
<li><b>What is the intake route</b> &mdash; PR against the UTG repo, a proposal
per resource, something else? And what proposal granularity does UTG want for a
change set this size?</li>
</ol>
""",
        "ask": "Point us at the right UTG checkout and branch, and tell us how "
               "narrative is handled. Those two answers let us start "
               "generating.",
    },
    {
        "id": "conceptdomains",
        "kind": "decision",
        "n": 3,
        "title": "<code>CodeSystem/conceptdomains</code> &mdash; we are "
                 "proposing 3.0.0 &rarr; 4.0.0",
        "tables": "conceptdomains",
        "lede": "Chapter 2C declares 760 distinct concept domains. THO 3.0.0 "
                "publishes 582 of them.",
        "body": """
<table class="narrow">
<tr><th></th><th class="num">THO 3.0.0</th><th class="num">Proposed 4.0.0</th></tr>
<tr><td>Top-level concepts</td><td class="num">742</td><td class="num">919</td></tr>
<tr><td><b>Total concepts</b></td><td class="num">1,345</td><td class="num"><b>1,522</b></td></tr>
</table>

<p>The 177 additions are appended as new top-level concepts marked
<code>source: v2</code> &mdash; THO's own convention for v2-derived domains.
Every existing THO concept is carried through unchanged with its hierarchy and
properties.</p>

<p><b>Why a superset and not just Chapter 2C's 760.</b> Publishing a
<i>subset</i> at THO's canonical would destructively redefine a code system
this project does not own: a server loading both packages would see concepts
disappear.</p>

<p><b>Why not a supplement.</b> A CodeSystem supplement may add properties and
designations to an existing code system. It may not add concepts.</p>
""",
        "ask": "Confirm the major-version bump and the <code>source: v2</code> "
               "marking, and that appending 177 top-level concepts is the "
               "right shape rather than slotting them into the existing "
               "hierarchy.",
    },
    {
        "id": "domain-definitions",
        "kind": "decision",
        "n": 4,
        "title": "Five concept domain definitions where Chapter 2C and THO "
                 "disagree",
        "tables": "0952, 0967, 0675, 0066, 0626",
        "lede": "For 577 of the 582 shared domains the two agree word for "
                "word. These five do not.",
        "body": """
<p>Only <b>0952</b> is a near-match &mdash; it differs by formatting and a
stray space. <b>The other four are wholly different texts</b>, which usually
means the two bodies have attached different meanings to the same domain, not
that one meaning is phrased two ways.</p>

<p>Our generator currently emits THO's wording. That was chosen when we assumed
THO was the more reliable side; we now understand the existing THO v2 content
to be less reliable than Chapter 2C in general, so we would rather not have
picked a default by assumption.</p>

<div class="counter">
<p class="tight"><b>Note this interacts with ask 1.</b> If UTG confirms
&ldquo;correct in THO and record the history&rdquo;, that is also an argument
for Chapter 2C's wording winning here &mdash; which is the opposite of what we
currently emit.</p>
</div>
""",
        "ask": "These four need reconciling on the merits, not a tie-break "
               "rule. Choosing a wording does not fix a genuine disagreement "
               "about meaning.",
    },
    # ------------------------------------------------------------- findings
    {
        "id": "v2-0411",
        "kind": "finding",
        "n": 5,
        "title": "<code>CodeSystem/v2-0411</code> is referenced by the "
                 "published chapter and does not exist",
        "tables": "0411",
        "lede": "A dangling canonical in a published HL7 standard.",
        "body": """
<p>Chapter 2C prints the URI
<code>http://terminology.hl7.org/CodeSystem/v2-0411</code> for table 0411
<i>Supplemental Service Information Values</i> &mdash; 2 codes
(<code>NDBS</code>, <code>CG</code>), OID
<code>2.16.840.1.113883.18.452</code>.</p>
<p><b>THO has no such resource, and no <code>ValueSet/v2-0411</code>
either.</b></p>
""",
        "ask": "Should UTG create it, or is there a reason it was never "
               "minted?",
    },
    {
        "id": "valueset-only",
        "kind": "finding",
        "n": 6,
        "title": "THO has no CodeSystem for 18 code-bearing v2 tables &mdash; "
                 "10 have a ValueSet only",
        "tables": "18 tables",
        "lede": "This looks deliberate and correct. We want the pattern "
                "confirmed before generalising it across 415 tables.",
        "body": """
<p>For <b>10</b> of the 18, THO publishes a ValueSet whose <code>compose</code>
names the real system, and no CodeSystem &mdash; because the codes belong to
something else. In every case THO's enumerated codes match what Chapter 2C
prints.</p>

<table>
<tr><th>Tables</th><th>Codes come from</th></tr>
<tr><td>0567, 0568, 0929, 0930, 0931, 0932</td><td><code>http://unitsofmeasure.org</code> (UCUM)</td></tr>
<tr><td>0725 Mood Codes</td><td><code>&hellip;/CodeSystem/v3-ActMood</code></td></tr>
<tr><td>0125 Value Type</td><td><code>&hellip;/CodeSystem/v2-0440</code></td></tr>
<tr><td>0136 Yes/no Indicator</td><td><code>&hellip;/CodeSystem/v2-0532</code></td></tr>
<tr><td>0338 Practitioner ID Type</td><td><code>&hellip;/CodeSystem/v2-0203</code></td></tr>
</table>

<p><b>The remaining 8.</b> <b>0820</b> (LOINC) and <b>0823</b> (SNOMED CT +
DataAbsentReason + NullFlavor) need a ValueSet each and no CodeSystem, same
shape. <b>0460</b> <i>Denial or Rejection Code</i> is genuinely HL7-authored
content with no THO home and needs a real CodeSystem. <b>0411</b> is item 5.
<b>0459</b> is item 7. The last three are item 8.</p>
""",
        "ask": "Confirm the rule &mdash; <i>a v2 table whose codes belong to "
               "another system gets a ValueSet composing from that system and "
               "no CodeSystem of its own.</i> We would apply it across the "
               "board, including to the five already resolved this way "
               "(0227&rarr;<code>NamingSystem/MVX</code>, "
               "0347&rarr;<code>NamingSystem/ISO3166Part2</code>, "
               "0929/0930/0932&rarr;<code>NamingSystem/v3-ucum</code>).",
    },
    {
        "id": "cms-0459",
        "kind": "finding",
        "n": 7,
        "title": "Table 0459 is labelled as CMS content but does not look like "
                 "CMS content",
        "tables": "0459",
        "lede": "",
        "body": """
<p>Chapter 2C gives table 0459 <i>Reimbursement Action Code</i> the symbolic
name <code>cms-OCEEditCode-cs</code> and OID
<code>2.16.840.1.113883.6.301.9</code>. Its four codes are <code>0</code>&ndash;
<code>3</code> with HL7-authored English displays &mdash; &ldquo;OCE line item
denial or rejection is not ignored&rdquo;, and so on.</p>
<p>Those read as an HL7 enumeration <i>about</i> OCE behaviour, not as codes
drawn from the CMS OCE Edit Code system.</p>
""",
        "ask": "Is the OID right? If these are HL7's own codes they need an "
               "HL7 code system, not a CMS one.",
    },
    {
        "id": "cd-only-with-codes",
        "kind": "finding",
        "n": 8,
        "title": "Three tables declare &ldquo;Concept Domain Only&rdquo; and "
                 "then publish code rows",
        "tables": "0093, 0340, 0451",
        "lede": "",
        "body": """
<p>Each sets <code>Concept Domain Only: yes</code> and then carries rows in the
coded content grid. The rows are not really codes:</p>
<ul>
<li><b>0093</b> <i>Release Information</i> &mdash; the third entry is literally
<code>...</code> with display &ldquo;user-defined codes&rdquo;</li>
<li><b>0340</b> <i>Procedure Code Modifier</i> &mdash; the two entries
(<code>CPTM</code>, <code>HPC</code>) name <i>coding systems</i>, not
modifiers</li>
<li><b>0451</b> <i>Substance Identifier</i> &mdash; the single entry
<code>ALL</code> is a query wildcard</li>
</ul>
""",
        "ask": "We plan to emit a concept domain and nothing else for these "
               "three. Flagging in case UTG reads any of them differently.",
    },
    # ------------------------------------------------------------------ fyi
    {
        "id": "canonicals",
        "kind": "fyi",
        "n": 9,
        "title": "We are authoring at THO canonicals",
        "tables": "",
        "lede": "",
        "body": """
<p>Resources carry <code>http://terminology.hl7.org/CodeSystem/v2-0nnn</code>
and <code>ValueSet/v2-0nnn</code> from the start, because the workspace exists
only to be merged into THO. There is no interim canonical to migrate away from
and no workspace-URL-to-THO-URL mapping for anyone to get wrong.</p>
""",
        "ask": "No decision sought. But if anyone would rather we staged under "
               "a different base and migrated later, <b>now is the time to "
               "say so</b> &mdash; it gets expensive quickly.",
    },
    {
        "id": "not-291",
        "kind": "fyi",
        "n": 10,
        "title": "The output is not scoped to V2.9.1",
        "tables": "",
        "lede": "",
        "body": """
<p>V2.9.1 is the source being used to establish a correct <i>v2 baseline</i>,
not the scope of the result. Resource <code>version</code> will not carry
<code>2.9.1</code>; Chapter 2C's &ldquo;HL7 Version Introduced&rdquo; becomes a
concept property.</p>
<p>This pass is <b>fidelity only</b>. Substantive corrections to the v2
terminology are a deliberate second effort &mdash; keeping them separate is
what will make the second one reviewable against this baseline.</p>
""",
        "ask": "No decision sought.",
    },
    {
        "id": "method",
        "kind": "fyi",
        "n": 11,
        "title": "Scale and method",
        "tables": "",
        "lede": "",
        "body": """
<p><b>Scale.</b> 799 sections, 5,540 codes, 415 code-bearing tables, ~384
concept-domain-only, 760 concept domains.</p>
<p><b>Method.</b> Two independent extractions of the same <code>.docx</code>
&mdash; python-docx (character-faithful) and an LLM (structural corroboration)
&mdash; agreeing on <b>740/799</b> tables, with every remaining difference
classified and adjudicated against the source. Every change to published text
is recorded with the decision that authorized it.</p>
""",
        "ask": "No decision sought.",
    },
]

# The rest of the escalation register. V2 Management's business, not UTG's, so
# it is one line each rather than a section each -- but it is here, because a
# UTG member who wants to know the whole picture should not have to open
# another document to find out what was left out.
V2_MANAGEMENT_ITEMS = [
    ("3", "Coded content grid published completely blank; 6 rows &times; 5 "
          "cols, and THO's <code>ValueSet/gender-identity</code> holds exactly "
          "the 5 concepts it should have carried", "0821"),
    ("5", "All six UCUM-backed tables name the code system &ldquo;Donation "
          "Duration Units Code System&rdquo;", "0567, 0568, 0929&ndash;0932"),
    ("6", "Literal placeholder text published &mdash; <code>noObject</code>, "
          "<code>noDescription</code>", "0560, 0910"),
    ("7", "ISO 3166 <b>part 1</b> URI given for a part 2 code system; partial "
          "value set called &ldquo;all codes&rdquo;", "0347"),
    ("8", "&ldquo;All codes&rdquo; used where the value set enumerates 2&ndash;3 "
          "UCUM codes &mdash; affects how all 438 value set blocks translate "
          "to <code>ValueSet.compose</code>", "0929&ndash;0932"),
    ("9", "Two pairs of tables are duplicates of each other",
          "0567/0929, 0568/0930"),
    ("10", "Five concept domains given two different descriptions within the "
           "chapter", "5 domains"),
    ("12", "Two table headings styled <code>Normal</code> instead of "
           "<code>Heading 3</code>, so absent from the chapter's own TOC",
           "0685, 0767"),
]

KIND_LABEL = {
    "decision": ("DECISION", "b-decide"),
    "finding": ("THO GAP", "b-flag"),
    "fyi": ("FYI", "b-info"),
}

KIND_GROUP = [
    ("decision", "Decisions we need from UTG",
     "Work is gated behind each of these."),
    ("finding", "THO gaps and defects we found",
     "Verified against <code>hl7.terminology.r5</code> v7.3.0. UTG action, "
     "but not a debate."),
    ("fyi", "Visibility &mdash; no decision needed",
     "Here so nobody first hears it from a merge request."),
]


# --------------------------------------------------------------------------
# Rendering
# --------------------------------------------------------------------------

def render_html(generated):
    """Build the whole briefing as one self-contained HTML string."""
    out = []
    add = out.append

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add(f"<title>{html.escape(TITLE)} &mdash; UTG briefing</title>")
    add(f"<style>{STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<nav id='sidebar'>")
    add(f"<div class='brand'>{TITLE}</div>")
    add(f"<div class='brand-sub'>{SUBTITLE}</div>")
    add("<a class='top' href='#asks'>&uarr; The asks, in one screen</a>")
    for kind, heading, _ in KIND_GROUP:
        items = [i for i in ITEMS if i["kind"] == kind]
        if not items:
            continue
        add(f"<h2>{heading}</h2>")
        for item in items:
            add(f"<a href='#{item['id']}'><span class='n'>{item['n']}</span>"
                f"{item['title']}</a>")
    add("<h2>Appendix</h2>")
    add("<a href='#v2mgmt'><span class='n'>&mdash;</span>For V2 Management, "
        "not UTG</a>")
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

    # ---- the asks, up front ----
    #
    # The whole point of this card. Someone opening the file five minutes
    # before the meeting reads this and nothing else, so every ask is here in
    # one sentence with a jump link to the evidence.
    add("<section id='asks' class='asks-card'>")
    add("<h2 class='plain'>If you read one thing</h2>")
    add("<p class='asks-intro'>Four decisions, four findings. Everything else "
        "in this document is evidence for one of them.</p>")
    add("<ol class='asks-list'>")
    for item in ITEMS:
        if item["kind"] == "fyi":
            continue
        label, cls = KIND_LABEL[item["kind"]]
        add(f"<li><span class='badge {cls}'>{label}</span> "
            f"<a href='#{item['id']}'>{item['title']}</a>"
            f"<div class='ask-line'>{item['ask']}</div></li>")
    add("</ol>")
    add("<p class='asks-foot'>Two <span class='badge b-info'>FYI</span> items "
        "at the end need no decision, but <a href='#canonicals'>the first of "
        "them</a> is the last convenient moment to object.</p>")
    add("</section>")

    # ---- items ----
    for kind, heading, blurb in KIND_GROUP:
        items = [i for i in ITEMS if i["kind"] == kind]
        if not items:
            continue
        add(f"<h2 id='grp-{kind}'>{heading}</h2>")
        add(f"<p class='sub'>{blurb}</p>")
        for item in items:
            label, cls = KIND_LABEL[item["kind"]]
            add(f"<section class='item k-{kind}' id='{item['id']}'>")
            add(f"<h3><span class='badge {cls}'>{label}</span> "
                f"<span class='n'>{item['n']}.</span> {item['title']}</h3>")
            if item["tables"]:
                add(f"<p class='tables'>{item['tables']}</p>")
            if item["lede"]:
                add(f"<p class='lede'>{item['lede']}</p>")
            add(item["body"])
            add(f"<p class='ask'><span class='ask-tag'>Ask</span>"
                f"{item['ask']}</p>")
            add("</section>")

    # ---- appendix ----
    add("<h2 id='v2mgmt'>For V2 Management, not UTG</h2>")
    add("<p class='sub'>Listed for completeness &mdash; these need nothing "
        "from this meeting. Full detail on each is in the 12-item register, "
        "<code>vocabulary-v2mgmt-items.md</code>.</p>")
    add("<table><tr><th class='num'>#</th><th>Item</th><th>Tables</th></tr>")
    for n, text, tables in V2_MANAGEMENT_ITEMS:
        add(f"<tr><td class='num'>{n}</td><td>{text}</td>"
            f"<td class='nowrap'>{tables}</td></tr>")
    add("</table>")

    add(f"<p class='faint'>Generated {html.escape(generated)} by "
        f"<code>tooling/scripts/render_utg_briefing.py</code>. "
        f"Edit the module, not this file.</p>")
    add("</main></body></html>")
    return "\n".join(out)


def _strip_tags(text):
    """Crude HTML-to-text for the Markdown twin.

    Good enough for the one-line asks and headings, which is all the Markdown
    rendering needs it for. Block content is authored in HTML and passed
    through, because a briefing is read in the browser -- the Markdown exists
    so the file can be diffed and quoted, not so it can be pretty.
    """
    import re
    text = re.sub(r"<[^>]+>", "", text)
    return html.unescape(text)


def render_markdown(generated):
    """The same briefing as Markdown, for diffing and quoting."""
    out = [f"# {TITLE} — {SUBTITLE}", "", f"**{MEETING_DATE}**", "",
           _strip_tags(SUMMARY).strip(), "", "## If you read one thing", ""]
    for item in ITEMS:
        if item["kind"] == "fyi":
            continue
        label, _ = KIND_LABEL[item["kind"]]
        out.append(f"{item['n']}. **[{label}]** {_strip_tags(item['title'])}  ")
        out.append(f"   _Ask:_ {_strip_tags(item['ask'])}")
    out.append("")
    for kind, heading, blurb in KIND_GROUP:
        items = [i for i in ITEMS if i["kind"] == kind]
        if not items:
            continue
        out += [f"## {_strip_tags(heading)}", "", _strip_tags(blurb), ""]
        for item in items:
            out.append(f"### {item['n']}. {_strip_tags(item['title'])}")
            if item["tables"]:
                out.append(f"**Tables:** {item['tables']}")
            out.append("")
            if item["lede"]:
                out += [_strip_tags(item["lede"]).strip(), ""]
            out += [_strip_tags(item["body"]).strip(), ""]
            out += [f"**Ask:** {_strip_tags(item['ask'])}", ""]
    out += ["## For V2 Management, not UTG", "",
            "| # | Item | Tables |", "|---|---|---|"]
    for n, text, tables in V2_MANAGEMENT_ITEMS:
        out.append(f"| {n} | {_strip_tags(text)} | {_strip_tags(tables)} |")
    out += ["", f"_Generated {generated} by "
                f"`tooling/scripts/render_utg_briefing.py`. Edit the module, "
                f"not this file._"]
    return "\n".join(out) + "\n"




def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-o", "--output", default=str(DEFAULT_HTML),
                        help="HTML output path")
    parser.add_argument("--markdown", default=str(DEFAULT_MD),
                        help="Markdown output path")
    args = parser.parse_args()

    generated = date.today().isoformat()

    Path(args.output).write_text(render_html(generated), encoding="utf-8")
    Path(args.markdown).write_text(render_markdown(generated), encoding="utf-8")

    decisions = sum(1 for i in ITEMS if i["kind"] == "decision")
    findings = sum(1 for i in ITEMS if i["kind"] == "finding")
    print(f"{decisions} decisions, {findings} findings, "
          f"{len(ITEMS)} items total")
    print(f"HTML:     {args.output}")
    print(f"Markdown: {args.markdown}")


if __name__ == "__main__":
    main()
