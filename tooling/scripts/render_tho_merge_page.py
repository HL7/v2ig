#!/usr/bin/env python3
"""Render the "what this guide keeps from THO" page for the vocabulary IG.

The merge itself is done by `write_utg_xml`, which writes every instance it
found to `v291-fhir/tho-fill-report.json`. This turns that report into a page
a reviewer can read.

It describes **classes**, not instances. There are some eight thousand
observations and nobody is going to read them one at a time; what a reviewer
needs from this page is "what kinds of thing happened, how many of each, and
which tables". The per-table detail belongs in the per-table ledger, and the
per-instance detail is in the JSON.

Two sections do list individual items, because they are short and each one
needs a decision from a person rather than a count:

  * the artifacts THO publishes and this guide does not, and
  * the version increments that rest on a judgement the policy leaves open.

Usage:
    python3 tooling/scripts/render_tho_merge_page.py
    python3 tooling/scripts/render_tho_merge_page.py --check
"""

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from render_review_pages import question_anchor  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
FILL_REPORT = PROJECT_ROOT / "v291-fhir" / "tho-fill-report.json"
OUTPUT_PAGE = (PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
               / "tho-merge.md")

# The order the four kinds are presented in, and the heading each gets. Fills
# come first because they are the reason the page exists.
KIND_SECTIONS = [
    ("fill", "Kept from THO",
     "Content THO publishes that Chapter 2C says nothing about. Without the "
     "merge each of these would have been deleted from an artifact published "
     "at THO's own canonical URL. None of them changes the artifact relative "
     "to THO, so none of them costs a version increment."),
    ("discrepancy", "Where the chapter and THO disagree",
     "Both carry a value and the two differ by more than whitespace. The "
     "chapter's value is published, because publishing the chapter is what "
     "this guide is for, and the disagreement is listed here so that it is a "
     "decision rather than an accident."),
    ("addition", "What this guide contributes",
     "Content in Chapter 2C that THO does not carry. These are real changes "
     "to the artifact and they do drive version increments."),
    ("omission", "Where this guide is silent and THO is not",
     "THO publishes an artifact and this guide publishes nothing at that "
     "canonical. Nothing is destroyed — THO's artifact stands untouched — so "
     "the merge does not invent a replacement. They are listed because a "
     "reviewer should see the gaps deliberately rather than discover them."),
]


def render_page(report):
    source = report["source"]
    counts = report["counts"]
    by_kind = defaultdict(list)
    for bucket in report["classes"]:
        by_kind[bucket["kind"]].append(bucket)

    lines = [
        "",
        # `<small>` would be the obvious tag for the notes in the tables
        # below, but the IG Publisher's HTML checker rejects it and warns on
        # every use. A classed span reads the same and passes.
        "<style>.tl-note { font-size: 0.85em; color: #555; }</style>",
        "",
        "This guide publishes its code systems and value sets at **THO's own "
        "canonical URLs**. A canonical URL is an identifier: publishing at one "
        "says *this is that artifact*, not *this is our version of that "
        "artifact*. So anything THO carries that our output leaves out is not "
        "a gap in a draft — it is content deleted from the artifact that URL "
        "names.",
        "",
        "The rule this guide follows, and what this page reports on:",
        "",
        "> Where THO has content and Chapter 2C has no opinion, **THO's "
        "content survives**. Where both have something and they differ, the "
        "**chapter wins** and the disagreement is recorded.",
        "",
        f"Everything below is measured against a local snapshot of the "
        f"**`{source.get('package')}` package, version "
        f"{source.get('version')}**, not against a live server. "
        f"{counts['observations']:,} observations in total.",
        "",
    ]

    for kind, heading, blurb in KIND_SECTIONS:
        buckets = by_kind.get(kind, [])
        total = sum(b["count"] for b in buckets)
        lines += [
            f"### {heading}",
            "",
            blurb,
            "",
            f"**{total:,} in total.**",
            "",
            "| What | Count | Tables |",
            "|---|---:|---|",
        ]
        for bucket in buckets:
            why = f"<br/><span class=\"tl-note\">{bucket['why']}</span>" if bucket["why"] else ""
            lines.append(
                f"| {bucket['title']}{why} | {bucket['count']:,} "
                f"| {bucket['tableCount']} |")
        lines.append("")

    lines += [
        "### What it does to version numbers",
        "",
        "Version numbers are not hand-applied. Each artifact is compared "
        "against THO's after the merge, and the "
        "[TSMG artifact versioning policy]"
        "(https://confluence.hl7.org/spaces/TSMG/pages/134947510) decides "
        "what that comparison means. The format is `n.0.0` — there is no "
        "minor or patch, so every qualifying change is a major increment.",
        "",
        "An artifact that ends up matching THO **keeps THO's version**. That "
        "is the merge's largest practical effect: filling content back in "
        "removes the change that would otherwise have forced an increment.",
        "",
        "Every difference counts, whatever its size: a description that "
        "gained a comma increments exactly as a reworded one does. Some of "
        "the increments below rest on nothing more than that, and the "
        "per-table ledger says which.",
        "",
        "One rule behind these numbers is still a judgement call rather than "
        "a fact — whether reordering a code system's concepts is a change. "
        "It is stated, with what rides on it, under "
        f"[What needs an answer]({question_anchor('gq-does-reordering-a-code-system')}).",
        "",
        "| Outcome | Count |",
        "|---|---:|",
    ]
    for label, count in sorted(counts["versions"].items()):
        lines.append(f"| {label} | {count} |")
    lines.append("")

    blocked = report.get("cannotBeVersioned") or []
    if blocked:
        lines += [
            "#### Changes a version number cannot express",
            "",
            "The policy puts a few elements outside the version system "
            "entirely: changing one of them means a **new artifact at a new "
            "canonical**, not a new version. Any listed here need resolving "
            "before publication.",
            "",
            "| Table | Resource | Element |",
            "|---|---|---|",
        ]
        for item in blocked:
            lines.append(f"| [{item['table']}]"
                         f"(table-ledger.html#tbl-{item['table']}) "
                         f"| {item['resource']} "
                         f"| {', '.join(item['elements'])} |")
        lines.append("")

    omissions = [r for r in report["records"] if r["kind"] == "omission"]
    if omissions:
        lines += [
            "### The artifacts THO has and this guide does not",
            "",
            f"{len(omissions)} of them, across "
            f"{len({r['table'] for r in omissions})} tables. Each is listed "
            "with the reason the writer gave for publishing nothing.",
            "",
            "| Table | Resource | Why this guide writes nothing |",
            "|---|---|---|",
        ]
        for record in sorted(omissions,
                             key=lambda r: (r.get("table") or "", r["resource"])):
            table = record.get("table")
            link = (f"[{table}](table-ledger.html#tbl-{table})" if table
                    else "—")
            lines.append(f"| {link} | {record['resource']} "
                         f"| {record.get('reason', '')} |")
        lines.append("")

    lines += [
        "### Where the detail lives",
        "",
        "This page is deliberately a summary: there are thousands of "
        "instances and the useful question here is what kinds of thing "
        "happened, not which of eight thousand rows to read first.",
        "",
        "For one table, read the **[per-table ledger]"
        "(table-ledger.html)** — it has a section per table carrying every "
        "difference from THO individually, and it says, for each one, how "
        "many other tables the same class of difference reaches. Every table "
        "number on this page links into it.",
        "",
    ]
    return "\n".join(lines)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--check", action="store_true",
                        help="report what would be written, change nothing")
    args = parser.parse_args(argv)

    if not FILL_REPORT.is_file():
        print(f"No {FILL_REPORT.relative_to(PROJECT_ROOT)}; run "
              f"write_utg_xml.py first.", file=sys.stderr)
        return 1

    report = json.loads(FILL_REPORT.read_text(encoding="utf-8"))
    page = render_page(report)

    if args.check:
        print(f"--check: would write {len(page):,} bytes to "
              f"{OUTPUT_PAGE.relative_to(PROJECT_ROOT)}")
        return 0
    OUTPUT_PAGE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PAGE.write_text(page, encoding="utf-8")
    print(f"wrote {OUTPUT_PAGE.relative_to(PROJECT_ROOT)} "
          f"({len(page):,} bytes)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
