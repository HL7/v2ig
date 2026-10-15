#!/usr/bin/env python3
"""The defect review list: every known defect, grouped so it can be ruled on.

Why this exists
---------------

The register (`vocabulary_escalations.py`) asks V2 Management a blanket policy
question -- `esc-retain-known-errors` -- of the form *"when Chapter 2C
publishes something demonstrably wrong, does this IG reproduce it or correct
it?"*. On 2026-10-08 V2 Management answered that **there is no
one-size-fits-all rule**: the decision has to be made per class of defect and
sometimes per instance, and they will review individual issues.

That answer makes a blanket ask unusable but does not make the defects go
away. It changes what the project has to produce: not a rule to apply, but a
**list that can be walked**. This module is that list.

What it is for
--------------

One document, grouped by defect class, where each entry states the four things
needed to rule on it and nothing else:

  * what the chapter publishes
  * what THO publishes, where it differs -- THO has already decided some of
    these, and where it has, that is the strongest available precedent
  * **what this guide currently publishes**, read from the build report rather
    than described, because the reviewer is ruling on a live artifact
  * the decision actually needed, narrowed to this defect

The classes are ordered by how much the answer costs: mechanical repairs that
change no meaning come first, and changes to what the standard *means* come
last. That ordering is the one piece of editorial judgement here. It exists so
a reviewer with twenty minutes spends them where a ruling is cheap and
unblocks the most, rather than on the hardest item first. Every class is
reviewable independently -- nothing here asks for a rule to be set before an
instance can be decided.

Where the content comes from
----------------------------

The prose is the register's. This module does not restate a finding in its own
words: a second description of a defect is a second thing to keep in sync, and
the register's text is what the committee has already seen. What is added is
the grouping, the ordering, and the current-output column.

`CLASSIFICATION` below is the only authored content, and it is deliberately
thin: an id, a class, and one line saying why that item sits in that class.
A test checks it covers every open register item, so a new finding cannot be
added to the register and quietly miss the review list.

Run:
    python3 tooling/scripts/render_defect_review.py
"""

import argparse
import html
import json
import re
import sys
from collections import OrderedDict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from briefing_style import STYLE  # noqa: E402
import vocabulary_escalations  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_HTML = PROJECT_ROOT / "v291-extracted" / "defect-review.html"
DEFAULT_MD = PROJECT_ROOT / "v291-extracted" / "defect-review.md"
WRITE_REPORT = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"

TITLE = "Chapter 2C defects, grouped for decision"
SUBTITLE = "Review list for V2 Management"

# ---------------------------------------------------------------------------
# The classes
# ---------------------------------------------------------------------------
#
# Ordered cheapest-to-rule-on first. `cost` is what granting the whole class
# would take, and it is what the ordering is really about: a reviewer should
# be able to see that the first classes are repairs nobody will argue with and
# the last ones change what the standard says.
CLASSES = OrderedDict([
    ("publication-damage", {
        "title": "Content lost in publication",
        "blurb":
            "The chapter is missing content it was meant to carry, and in "
            "each case the intended content is recoverable or evidenced. "
            "Nothing here is a disagreement about what the standard should "
            "say &mdash; only about what the published document failed to "
            "say.",
        "cost": "Republish the affected block. No change to meaning, so "
                "nothing to ballot.",
    }),
    ("presentation", {
        "title": "Presentation and wording",
        "blurb":
            "Defects a reader notices and no processor does: styling, "
            "copy-paste in a metadata field, inconsistent phrasing. They are "
            "listed because they are wrong, not because they block anything.",
        "cost": "Editorial pass on the chapter. No effect on any artifact "
                "this guide publishes.",
    }),
    ("wrong-identifier", {
        "title": "Wrong or missing identifiers",
        "blurb":
            "The chapter names the wrong thing, or omits a name it needs. "
            "A URI that points at the wrong code system is not a typographic "
            "matter &mdash; it resolves, and it resolves to something else.",
        "cost": "Correct the identifier. Mechanical, but it changes a "
                "normative value, so it needs confirming rather than just "
                "fixing.",
    }),
    ("self-contradiction", {
        "title": "The chapter contradicting itself",
        "blurb":
            "A table says two incompatible things about itself, so no "
            "reading of it is faithful. These cannot be reproduced "
            "faithfully &mdash; something has to be chosen &mdash; which is "
            "why they are the ones most likely to be producing a wrong "
            "artifact right now.",
        "cost": "Decide which reading is correct. Usually one line in the "
                "chapter, but somebody has to know the table's history.",
    }),
    ("representation", {
        "title": "Open representation questions",
        "blurb":
            "Not defects in the chapter: places where the chapter is clear "
            "and FHIR offers no settled way to say it. The guide has taken a "
            "working answer in each case and the answer is reversible.",
        "cost": "Confirm the shape, or name another. Sets a precedent beyond "
                "this guide.",
    }),
    ("content-error", {
        "title": "Published content that is wrong",
        "blurb":
            "The chapter publishes something that is incorrect as "
            "terminology &mdash; an invalid code, codes that do not match "
            "the table's own name. Correcting these changes what the "
            "standard means.",
        "cost": "Substantive change to normative content. On HL7's errata "
                "guidance this is the kind that needs a ballot rather than a "
                "technical correction.",
    }),
    ("tho-divergence", {
        "title": "Where this guide and THO disagree",
        "blurb":
            "Both bodies publish something, and they differ. Whatever is "
            "decided has to be decided for both, or the two fork.",
        "cost": "Coordination between V2 Management and TSMG. No unilateral "
                "fix is available.",
    }),
])

# ---------------------------------------------------------------------------
# Which class each open register item belongs to
# ---------------------------------------------------------------------------
#
# The only authored content in this module. One line per item saying why it
# sits where it does -- the classification is a judgement and should be
# arguable, which it cannot be if the reason is not written down.
#
# `esc-retain-known-errors` is absent deliberately: it is the blanket policy
# question this list replaces. See SUPERSEDED below.
CLASSIFICATION = {
    "esc-0821-blank-grid": (
        "publication-damage",
        "Six rows by five columns, every cell empty, in a fully populated "
        "section. THO's matching value set holds exactly the five concepts "
        "the row count implies."),
    "esc-truncated-value-set-descriptions": (
        "publication-damage",
        "Sixteen descriptions stop mid-word at about 250 characters. The "
        "cut-off is uniform, so the loss is at publication."),
    "esc-heading-styles": (
        "presentation",
        "Two headings styled Normal instead of Heading 3. Affects navigation "
        "of the document and nothing else."),
    "esc-ucum-full-name": (
        "presentation",
        "All six UCUM-backed tables carry the same copy-pasted Full Name. A "
        "metadata field, not a binding."),
    "esc-full-name-copy-paste": (
        "presentation",
        "The same copy-paste beyond the UCUM tables. Separating genuine "
        "exceptions from errors needs somebody who knows the tables."),
    "esc-cld-inconsistent": (
        "presentation",
        "“All codes” used where a value set enumerates a handful. "
        "Classed as wording because the question underneath it -- whether "
        "“all codes” is a defined term -- is asked separately."),
    "esc-placeholder-metadata": (
        "presentation",
        "Literal noObject and noDescription placeholder text reaching print. "
        "The 0560 half of it is a content error and is listed there."),
    "esc-conflicting-descriptions": (
        "presentation",
        "Five concept domains given two different descriptions within the "
        "chapter. Reconcilable at source without deciding anything."),
    "esc-0347-iso3166": (
        "wrong-identifier",
        "ISO 3166 part 1's URI given for a part 2 code system. It resolves, "
        "and it resolves to the wrong code system."),
    "esc-0725-missing-uri": (
        "wrong-identifier",
        "The URI of the v3 code system the table draws from is omitted."),
    "esc-oid-conflicts": (
        "wrong-identifier",
        "One OID on two artifacts, for 0001 and 0719. An identifier that "
        "identifies two things identifies neither. The third conflict, "
        "0078, was removed rather than adjudicated."),
    "esc-table-oid-unpublished": (
        "wrong-identifier",
        "The Table OID arc is published nowhere. A default rather than a "
        "decision, which is why it is worth making one."),
    "esc-0459-unresolvable-oid": (
        "wrong-identifier",
        "An OID that resolves to nothing. Blocks the table mechanically."),
    "esc-0292-cdo-contradiction": (
        "self-contradiction",
        "Flagged concept-domain-only in the same section that names its code "
        "system and prints its canonical. The guide deviates tentatively "
        "under ADR-0011."),
    "esc-0340-code-grid-misuse": (
        "self-contradiction",
        "The code grid lists code systems rather than codes, so the grid "
        "does not mean what a grid means elsewhere."),
    "esc-0954-cld-exclude": (
        "self-contradiction",
        "The logical definition would include an abstract concept THO's "
        "equivalent excludes. Either an omitted clause or a deliberate "
        "divergence; the chapter does not say which."),
    "esc-0823-not-in-tho": (
        "self-contradiction",
        "The chapter publishes a table THO has nothing for, and the guide "
        "cannot settle it mechanically."),
    "esc-status-n-b-undefined": (
        "self-contradiction",
        "Status letters N and B are used and defined nowhere, so the chapter "
        "uses a vocabulary it does not publish."),
    "esc-deprecation-flag-contradicts-status": (
        "self-contradiction",
        "191 concepts say they are active and deprecated at once. The "
        "largest single class by concept count."),
    "esc-domain-example-codes": (
        "representation",
        "Where a concept domain's example codes should live. Extracted and "
        "held, published nowhere, pending a shape."),
    "esc-0929-0930-enumerated-subset": (
        "representation",
        "Whether the enumerated subset is intended or the value sets should "
        "reference the UCUM units for the quantity. Survives the 2026-09-23 "
        "ruling that retired 0567 and 0568."),
    "esc-0460-user-defined-mint": (
        "representation",
        "Whether a user-defined table gets a minted code system. Sharper "
        "since 0411 was ruled concept-domain-only: 0460 is now the only "
        "minted canonical in the corpus."),
    "esc-punctuation-codes": (
        "representation",
        "Twenty-three concepts whose code is nothing but punctuation. Part "
        "placeholder, part real symbol; the split needs review per code."),
    "esc-0931-temperature": (
        "content-error",
        "An invalid UCUM code published alongside its own correction. THO "
        "has already corrected this one, which makes it the sharpest test of "
        "reproduce-versus-correct in the corpus."),
    "esc-0560-content": (
        "content-error",
        "A table named Quantity Units publishing four time units out of five "
        "codes. THO carries the same error, so a unilateral fix forks them."),
    "esc-duplicate-tables": (
        "content-error",
        "Two pairs of tables duplicating each other. The 0567/0568 half is "
        "now settled; 0929 and 0930 remain."),
    "esc-tho-definition-differences": (
        "tho-divergence",
        "Five concept domain definitions where the two bodies disagree about "
        "what a domain means."),
    "esc-tho-descriptions-say-more": (
        "tho-divergence",
        "THO's descriptions carry content the chapter's do not."),
    "esc-v2tables-domain-gaps": (
        "tho-divergence",
        "Gaps in CodeSystem/v2-tables' concept domain coverage."),
    "esc-v2tables-siteadministered": (
        "tho-divergence",
        "A misspelled concept domain name in THO's own index."),
    "esc-v2tables-retirement": (
        "tho-divergence",
        "Whether CodeSystem/v2-tables should be retired at all."),
    "esc-description-editorial-carveout": (
        "tho-divergence",
        "Which description differences count as editorial. The carve-out "
        "this guide applies is its own reading of the policy."),
}

# The blanket question this list replaces, and what was said about it. Kept
# visible rather than deleted: a reader who remembers the policy ask needs to
# find out what happened to it.
SUPERSEDED = {
    "item": "esc-retain-known-errors",
    "ruling": "There is no one-size-fits-all answer to reproduce-or-correct. "
              "It has to be decided per class of defect and possibly case by "
              "case, with individual issues reviewed for decision.",
    "who": "V2 Management",
    "date": "2026-10-08",
}


def open_items():
    """The register's open items, keyed by id."""
    return {item["id"]: item for item in vocabulary_escalations.ESCALATIONS
            if not item.get("resolution")}


def current_output():
    """What the guide publishes for each table, from the build report.

    Returns a dict keyed by table number. Absent when the build report has
    not been generated -- the document still renders, without the column,
    rather than refusing to build.
    """
    if not WRITE_REPORT.exists():
        return {}
    report = json.loads(WRITE_REPORT.read_text(encoding="utf-8"))
    return {entry["table"]: entry for entry in report.get("tables", [])}


ACTION_PHRASE = {
    "code-system-and-value-set": "CodeSystem + ValueSet published",
    "value-set-only": "ValueSet published; code system is another body's",
    "concept-domain-only": "concept domain only, no artifact",
    "nothing-to-write": "nothing published",
    "needs-decision": "BLOCKED — no artifact, pipeline cannot settle it",
    "suppressed-by-ruling": "withheld on a ruling",
    "superseded-by-ruling": "retired on a ruling, superseded",
}


def output_summary(tables, published):
    """One line per table saying what the guide currently publishes.

    This is the column the review is really for: a reviewer ruling on a defect
    needs to know what is live, and reading it from the report means the
    document cannot claim something the build does not do.
    """
    rows = []
    for table in tables:
        entry = published.get(table)
        if entry is None:
            continue
        phrase = ACTION_PHRASE.get(entry["action"], entry["action"])
        version = ""
        for key, label in (("codeSystemVersion", "CS"),
                           ("valueSetVersion", "VS")):
            block = entry.get(key)
            if block:
                moved = "incremented" if block.get("incremented") else "held"
                version += f" {label} {block['version']} ({moved})"
        rows.append((table, entry.get("name", ""), phrase, version.strip()))
    return rows


def item_tables(item):
    """The four-digit table numbers named in an item's `tables` field."""
    return re.findall(r"\b(\d{4})\b", item["tables"])


def grouped():
    """Every open item, bucketed by class, in the classes' own order.

    Items with no classification are returned separately rather than dropped.
    A finding added to the register and not classified here should be visible
    as missing, not silently absent from the review list.
    """
    items = open_items()
    buckets = OrderedDict((name, []) for name in CLASSES)
    unclassified = []
    for item_id, item in items.items():
        if item_id == SUPERSEDED["item"]:
            continue
        entry = CLASSIFICATION.get(item_id)
        if entry is None:
            unclassified.append(item)
            continue
        buckets[entry[0]].append((item, entry[1]))
    return buckets, unclassified


def strip_markup(text):
    """Register prose as plain text, for the Markdown rendering."""
    text = re.sub(r"<[^>]+>", "", text)
    text = (text.replace("&mdash;", "—").replace("&ldquo;", "“")
                .replace("&rdquo;", "”").replace("&rsquo;", "’")
                .replace("&hellip;", "…").replace("&amp;", "&"))
    return re.sub(r"\s+", " ", text).strip()


def render_html():
    """The review list as a single self-contained page."""
    buckets, unclassified = grouped()
    published = current_output()
    total = sum(len(v) for v in buckets.values()) + len(unclassified)

    out = [
        "<!DOCTYPE html>",
        '<html lang="en"><head><meta charset="utf-8">',
        f"<title>{html.escape(TITLE)}</title>",
        f"<style>{STYLE}</style>",
        "</head><body>",
        '<div id="sidebar">',
        f'<div class="brand">{html.escape(TITLE)}</div>',
        f'<div class="brand-sub">{html.escape(SUBTITLE)}</div>',
        '<a class="top" href="#top">Why this list exists</a>',
        "<h2>Classes</h2>",
    ]
    for name, meta in CLASSES.items():
        count = len(buckets[name])
        if not count:
            continue
        out.append(f'<a href="#{name}">{html.escape(meta["title"])} '
                   f'<span class="n">{count}</span></a>')
    if unclassified:
        out.append('<a href="#unclassified">Unclassified '
                   f'<span class="n">{len(unclassified)}</span></a>')
    out.append("</div>")

    out += [
        '<div id="main">',
        '<a id="top"></a>',
        f"<h1>{html.escape(TITLE)}</h1>",
        f'<p class="sub">{html.escape(SUBTITLE)} &middot; '
        f"{total} open findings</p>",
        '<div class="asks-card">',
        "<h2 class='plain'>Why this list exists</h2>",
        "<p>This project asked V2 Management a single policy question: when "
        "Chapter 2C publishes something demonstrably wrong, does this IG "
        "reproduce it or correct it? The answer, on "
        f"{html.escape(SUPERSEDED['date'])}, was that "
        f"<b>{html.escape(SUPERSEDED['ruling'])}</b></p>",
        "<p>So this document replaces that question. Every known defect is "
        "below, grouped by class, ordered so that the classes needing the "
        "cheapest answer come first. Each entry says what the chapter "
        "publishes, what THO publishes where it differs, <b>what this guide "
        "currently publishes</b>, and the decision needed. Nothing here "
        "needs a general rule set before an instance can be decided.</p>",
        "<p>The current-output line under each entry is read from the "
        "build's own report, not transcribed, so it is what the guide does "
        "today rather than what it did when the finding was written.</p>",
        "</div>",
    ]

    for name, meta in CLASSES.items():
        items = buckets[name]
        if not items:
            continue
        out += [
            f'<a id="{name}"></a>',
            f'<h2>{html.escape(meta["title"])} '
            f'<span class="n">({len(items)})</span></h2>',
            f'<p class="lede">{meta["blurb"]}</p>',
            f'<p class="sub"><b>Cost of granting the class:</b> '
            f'{meta["cost"]}</p>',
        ]
        for item, why in items:
            out += render_item_html(item, why, published)

    if unclassified:
        out += [
            '<a id="unclassified"></a>',
            f"<h2>Unclassified <span class='n'>({len(unclassified)})</span>"
            "</h2>",
            '<p class="lede">In the register and not yet placed in a class. '
            "They are listed here rather than omitted, because a finding "
            "that is missing from a review list is worse than one that is "
            "awkwardly filed.</p>",
        ]
        for item in unclassified:
            out += render_item_html(item, None, published)

    out += ["</div></body></html>"]
    return "\n".join(out) + "\n"


def render_item_html(item, why, published):
    """One finding: why it is here, the register's own text, what we publish."""
    out = [
        f'<div class="item k-{html.escape(item["id"])}">',
        f'<h3>{item["title"]}</h3>',
        f'<p class="tables">{html.escape(item["tables"])} &middot; '
        f'goes to {html.escape(item["who"])} &middot; '
        f'<code>{html.escape(item["id"])}</code></p>',
    ]
    if why:
        out.append(f'<p class="sub"><b>Why this class:</b> '
                   f'{html.escape(why)}</p>')
    out.append(f"<p>{item['body']}</p>")

    rows = output_summary(item_tables(item), published)
    if rows:
        out.append('<div class="settled"><b>What this guide publishes '
                   "today</b><ul>")
        for table, table_name, phrase, version in rows:
            extra = f" &mdash; {html.escape(version)}" if version else ""
            out.append(f"<li><code>{html.escape(table)}</code> "
                       f"{html.escape(table_name)}: {html.escape(phrase)}"
                       f"{extra}</li>")
        out.append("</ul></div>")

    out += [f'<p class="ask"><b>Decision needed:</b> {item["ask"]}</p>',
            "</div>"]
    return out


def render_markdown():
    """The same list as plain Markdown, for circulation."""
    buckets, unclassified = grouped()
    published = current_output()
    total = sum(len(v) for v in buckets.values()) + len(unclassified)

    out = [
        f"# {TITLE}",
        "",
        f"{SUBTITLE} — {total} open findings.",
        "",
        "This document replaces the blanket policy question "
        f"`{SUPERSEDED['item']}`. {SUPERSEDED['who']} ruled on "
        f"{SUPERSEDED['date']} that {SUPERSEDED['ruling']}",
        "",
        "Findings are grouped by class and ordered so the classes needing "
        "the cheapest answer come first. Each entry says what the chapter "
        "publishes, what this guide currently publishes, and the decision "
        "needed. Nothing here requires a general rule before an instance "
        "can be decided.",
        "",
        "---",
        "",
    ]

    for name, meta in CLASSES.items():
        items = buckets[name]
        if not items:
            continue
        out += [
            f"## {meta['title']} ({len(items)})",
            "",
            strip_markup(meta["blurb"]),
            "",
            f"**Cost of granting the class:** {strip_markup(meta['cost'])}",
            "",
        ]
        for item, why in items:
            out += render_item_markdown(item, why, published)

    if unclassified:
        out += [f"## Unclassified ({len(unclassified)})", ""]
        for item in unclassified:
            out += render_item_markdown(item, None, published)

    return "\n".join(out) + "\n"


def render_item_markdown(item, why, published):
    out = [
        f"### {strip_markup(item['title'])}",
        "",
        f"**Tables:** {item['tables']}  ",
        f"**Goes to:** {item['who']}  ",
        f"**Register id:** `{item['id']}`",
        "",
    ]
    if why:
        out += [f"*Why this class: {why}*", ""]
    out += [strip_markup(item["body"]), ""]

    rows = output_summary(item_tables(item), published)
    if rows:
        out += ["**What this guide publishes today:**", ""]
        for table, table_name, phrase, version in rows:
            extra = f" — {version}" if version else ""
            out.append(f"- `{table}` {table_name}: {phrase}{extra}")
        out.append("")

    out += [f"**Decision needed:** {strip_markup(item['ask'])}", "", "---", ""]
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-o", "--output", default=str(DEFAULT_HTML))
    parser.add_argument("--markdown", default=str(DEFAULT_MD))
    args = parser.parse_args()

    buckets, unclassified = grouped()
    Path(args.output).write_text(render_html(), encoding="utf-8")
    Path(args.markdown).write_text(render_markdown(), encoding="utf-8")

    for name, meta in CLASSES.items():
        if buckets[name]:
            print(f"  {len(buckets[name]):3d}  {meta['title']}")
    if unclassified:
        print(f"  {len(unclassified):3d}  UNCLASSIFIED: "
              f"{', '.join(i['id'] for i in unclassified)}")
    if not WRITE_REPORT.exists():
        print("\nNo build report, so the current-output lines are omitted.")
    print(f"\nHTML:     {args.output}")
    print(f"Markdown: {args.markdown}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
