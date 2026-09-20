#!/usr/bin/env python3
r"""Render the review report into the IG, as two pages rather than one product.

The vocabulary review report began life as a standalone 1.8 MB HTML file. That
made it a second product: a reader had the IG in one hand and the report in the
other, with nothing tying them together and nothing stopping them disagreeing.
This generator puts the same content inside the guide, split along the only
line that matters to a reader -- **is this asking me for something, or is it
showing me what was already decided?**

    open-items.md   What needs an answer. The V2 Management / TSMG register,
                    the authored general questions, and the decisions still to
                    take. Around sixty items; a reader can work through it.

    evidence.md     What was decided, and what is disclosed for completeness.
                    Two thousand-odd items. Nobody works through this page; it
                    exists so that any claim the guide makes can be checked.

The split is by ACTION class, which the report already assigns:

    escalate, decide            -> open-items.md
    resolved, confirm, informational -> evidence.md

so a group moves between pages by being re-classed, and never by being listed
in two places.

The authored general questions come from `vocabulary_general_questions`. They
used to be a hand-written page of their own, which meant three review-facing
pages and a reader having to work out which one asked what. They are prose and
stay prose; this generator only decides where they sit.

Sources:
    tooling/scripts/render_vocabulary_review_html.py  the sections
    tooling/scripts/vocabulary_general_questions.py   the authored prose

Outputs:
    vocab-ig/input/pagecontent/open-items.md
    vocab-ig/input/pagecontent/evidence.md

Usage:
    python3 tooling/scripts/render_review_pages.py
    python3 tooling/scripts/render_review_pages.py --check   # write nothing
"""

import argparse
import html
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_vocabulary_review_html as report
import vocabulary_general_questions as questions

PROJECT_ROOT = Path(__file__).resolve().parents[2]
PAGE_DIR = PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
OPEN_ITEMS_PAGE = PAGE_DIR / "open-items.md"
EVIDENCE_PAGE = PAGE_DIR / "evidence.md"

# Which page an action class lands on. Everything the report can produce is
# named here, so a new class is a KeyError rather than a silently missing group.
PAGE_FOR_ACTION = {
    "escalate": "open-items",
    "decide": "open-items",
    "resolved": "evidence",
    "confirm": "evidence",
    "informational": "evidence",
}

# The template supplies no stylesheet this guide can add to -- the vocabulary IG
# builds on the stock `fhir.base.template`, not on `local-template` -- so each
# page carries what it needs. Note the raw docstring and the raw string here:
# a non-raw "\00b7" is read as octal and puts NUL bytes on the page.
PAGE_STYLE = r"""<style>
.ri-item { border-left: 3px solid #d0d7de; padding: 0.1rem 0 0.1rem 1rem;
           margin: 1.1rem 0; }
.ri-item > .ri-key { font-weight: 600; font-family: monospace; color: #24292f; }
.ri-item > .ri-who { color: #57606a; font-size: 0.9em; margin-top: 0.4rem; }
.ri-item p { margin: 0.45rem 0; }
.ri-item p.ask { background: #fff8e5; border-left: 2px solid #d4a72c;
                 padding: 0.35rem 0.6rem; }
.ri-escalate { border-left-color: #cf222e; }
.ri-decide   { border-left-color: #d4a72c; }
.ri-count { color: #57606a; font-weight: 400; }
.ri-group { margin-top: 1.6rem; }
.ri-blurb { color: #24292f; background: #f6f8fa; padding: 0.6rem 0.8rem;
            border-radius: 4px; }
.ri-ev table { font-size: 0.92em; }
.ri-ev td, .ri-ev th { vertical-align: top; padding: 0.2rem 0.5rem; }
.ri-scroll { max-height: 18rem; overflow: auto; }
</style>"""


def esc(text):
    """HTML-escape a value that arrives as plain text."""
    return html.escape(str(text if text is not None else ""))


def collect_sections():
    """Build every review section, exactly as the standalone report builds them.

    Going through the report's own builders rather than re-deriving anything is
    the point: the two products cannot disagree about what the findings are,
    only about how they are laid out.
    """
    deviations = report.load_json(report.DEVIATIONS_PATH)
    comparison = report.load_json(report.COMPARISON_PATH)
    source_issues = report.load_source_issues()
    concept_domains = report.load_json(report.CONCEPT_DOMAINS_PATH)

    sections = report.build_escalation_section()
    sections += report.build_writer_blocker_section()
    sections += report.build_batch_a_section()
    sections += report.build_sections(deviations, comparison, source_issues)
    sections += report.build_concept_domain_sections(concept_domains)
    sections += report.build_character_section()
    return report.apply_decision_notes(sections)


def cell_html(section, index, value):
    """One cell, as HTML, honouring the section's raw-HTML column set."""
    if index in section.get("raw_html_columns", set()):
        return str(value)
    return esc(value)


def render_section_as_items(section):
    """Render one section as a list of blocks, one per row.

    A table would be the obvious shape, and is what the standalone report uses.
    It is the wrong shape here: the findings carry paragraphs, evidence tables
    and preformatted values, which a Markdown table cannot hold, and an agenda
    of sixty items reads better as a list than as a grid anyway.

    The first column becomes the block's key, the last becomes its attribution
    when the section has three, and everything between is the body.
    """
    columns = section["columns"]
    out = []
    for row in section["rows"]:
        cells = [cell_html(section, i, value) for i, value in enumerate(row)]
        key, body, who = cells[0], cells[1:], None
        if len(columns) >= 3:
            who, body = cells[-1], cells[1:-1]

        out.append(f'<div class="ri-item ri-{section["action"]}">')
        if key:
            out.append(f'  <div class="ri-key">{key}</div>')
        out.extend(f"  {fragment}" for fragment in body)
        if who:
            out.append(f'  <div class="ri-who">{esc(columns[-1])}: {who}</div>')
        out.append("</div>")
    return "\n".join(out)


def render_group(section, heading):
    """A section with its heading, count and blurb, then its items."""
    plural = "item" if section["count"] == 1 else "items"
    return "\n".join([
        f'{heading} {section["title"]} '
        f'<span class="ri-count">&mdash; {section["count"]:,} {plural}</span>',
        "",
        f'<div class="ri-blurb">{section["blurb"]}</div>',
        "",
        render_section_as_items(section),
        "",
    ])


def render_question(question):
    """One authored general question, at `####`, body emitted verbatim.

    The named anchor is what other pages link to. A heading anchor would be
    derived from the title and would break the moment the title is reworded,
    whereas the id in `vocabulary_general_questions` is chosen once and does
    not move; `question_anchor()` is the only thing that knows the shape.
    """
    return "\n".join([
        f'<a name="{question["id"]}"> </a>',
        "",
        f'#### {question["number"]}. {question["title"]}',
        "",
        question["body"],
        "",
    ])


def question_anchor(question_id):
    """The link a page elsewhere in the guide uses to reach one question."""
    known = {q["id"] for q in questions.GENERAL_QUESTIONS}
    if question_id not in known:
        raise KeyError(f"no general question with id {question_id!r}; "
                       f"known ids: {', '.join(sorted(known))}")
    return f"{OPEN_ITEMS_PAGE.stem}.html#{question_id}"


def build_open_items_page(sections):
    """The page that asks for something: the register, the questions, the decides."""
    escalations = [s for s in sections if s["action"] == "escalate"]
    decides = [s for s in sections if s["action"] == "decide"]

    open_count = sum(s["count"] for s in escalations + decides)
    banked = len(questions.GENERAL_QUESTIONS)

    parts = [
        PAGE_STYLE,
        "",
        questions.INTRO,
        "",
        f"There are **{open_count} open items** below, plus **{banked} general "
        f"questions** that have a working answer already applied. Everything "
        f"this guide has *settled* is on the "
        f"[evidence page](evidence.html) instead, so that this page stays a "
        f"list of things somebody still has to do.",
        "",
    ]

    for section in escalations:
        parts.append(f'### {section["group"]}')
        parts.append("")
        parts.append(render_group(section, "####"))

    parts.append(f"### {questions.TSMG_TITLE}")
    parts.append("")
    parts.append(questions.TSMG_PREAMBLE)
    parts.append("")
    for question in questions.GENERAL_QUESTIONS:
        if question["audience"] == "TSMG":
            parts.append(render_question(question))

    parts.append(f"### {questions.V2MGMT_TITLE}")
    parts.append("")
    for question in questions.GENERAL_QUESTIONS:
        if question["audience"] == "V2 Management":
            parts.append(render_question(question))

    if decides:
        parts.append("### Decisions still to take")
        parts.append("")
        parts.append(
            "Judgements this guide cannot make for itself. Each one has a "
            "working answer applied, so none of them blocks a build; each is "
            "here because the answer is somebody else's to give.")
        parts.append("")
        for section in decides:
            parts.append(render_group(section, f'#### {section["group"]} &mdash;'))

    parts.append(f"### {questions.CLOSING_TITLE}")
    parts.append("")
    parts.append(questions.CLOSING_BODY)
    parts.append("")

    return "\n".join(parts).rstrip() + "\n"


def build_evidence_page(sections):
    """The page that proves something: everything already decided or disclosed."""
    shown = [s for s in sections
             if PAGE_FOR_ACTION[s["action"]] == "evidence" and s["count"]]
    by_action = Counter()
    for section in shown:
        by_action[section["action"]] += section["count"]

    total = sum(by_action.values())
    parts = [
        PAGE_STYLE,
        "",
        f"Every finding this guide has already settled, and everything "
        f"disclosed for completeness: **{total:,} values** across "
        f"**{len(shown)} groups**. Nothing on this page is asking for "
        f"anything. What is still open is on "
        f"[what needs an answer](open-items.html).",
        "",
        "This page exists so that any claim the guide makes about the chapter "
        "can be checked against the thing that was observed, without reading "
        "the pipeline. It is long by design and is meant to be searched "
        "rather than read.",
        "",
    ]

    for action in report.ACTION_ORDER:
        group = [s for s in shown if s["action"] == action]
        if not group:
            continue
        count = by_action[action]
        parts.append(f"### {report.ACTION_LABEL[action]} "
                     f'<span class="ri-count">&mdash; {len(group)} groups, '
                     f"{count:,} values</span>")
        parts.append("")
        if action == "resolved":
            parts.append("A judgement was made and applied. The reasoning is "
                         "recorded with each group.")
        elif action == "informational":
            parts.append("Disclosed because a reader should be able to see it, "
                         "not because anything follows from it.")
        else:
            parts.append("Changed automatically; recorded so the change is "
                         "visible.")
        parts.append("")
        for section in sorted(group, key=lambda s: (s["group"], s["title"])):
            parts.append(render_group(section, f'#### {section["group"]} &mdash;'))

    return "\n".join(parts).rstrip() + "\n"


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--check", action="store_true",
                        help="Report what would be written without writing it")
    args = parser.parse_args()

    sections = collect_sections()
    unknown = {s["action"] for s in sections} - set(PAGE_FOR_ACTION)
    if unknown:
        sys.exit(f"ERROR: no page assigned for action class(es): "
                 f"{', '.join(sorted(unknown))}")

    pages = {
        OPEN_ITEMS_PAGE: build_open_items_page(sections),
        EVIDENCE_PAGE: build_evidence_page(sections),
    }

    for action in report.ACTION_ORDER:
        group = [s for s in sections if s["action"] == action]
        if group:
            print(f"  {report.ACTION_LABEL[action]:24} "
                  f"{len(group):3d} groups  {sum(s['count'] for s in group):6,d} values"
                  f"  -> {PAGE_FOR_ACTION[action]}.html")

    for path, text in pages.items():
        verb = "would write" if args.check else "wrote"
        if not args.check:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text, encoding="utf-8")
        print(f"{verb} {path.relative_to(PROJECT_ROOT)}  {len(text):,} bytes")

    return 0


if __name__ == "__main__":
    sys.exit(main())
