#!/usr/bin/env python3
"""Render the per-table ledger for the vocabulary IG.

`tho-merge.html` answers "what kinds of thing did the merge do, and how
often". This page answers the other question a reviewer actually has, which is
**"what happened to my table?"** — one section per table, carrying every
difference from THO that survived into the published artifact, every open
issue the register raises against that table, and, for each difference, an
indicator saying whether it is a one-off or an instance of a class that hits
other tables the same way.

The three kinds of thing a section can say:

  * **Differences from THO** — a disagreement where the chapter won, a code or
    element this guide adds, or a canonical this guide publishes nothing at.
    These are listed individually, because each one is a decision somebody may
    want to challenge. There are around seven hundred in total, so listing
    them all is affordable.
  * **Kept from THO** — the fills, given as counts by class. There are seven
    and a half thousand of these and they are all the *absence* of a change,
    so a count is the honest summary and the instance detail stays in the JSON.
  * **Open issues** — register items whose table list names this table and
    which no committee has answered yet.
  * **Answered by a committee** — the same, for items that have been ruled
    on, carrying the ruling. Separate because an answered item listed as open
    says the opposite of what happened.

A table gets a section when this guide authors an artifact for it or when the
merge observed anything about it. Every other chapter table is listed once,
compactly, at the end, so the page accounts for all 799 rather than quietly
covering the interesting ones.

A handful of sections are for numbers Chapter 2C has no table for at all --
THO publishes a `v2-NNNN` code system or value set and the chapter is silent.
Those are real and worth answering for, but they are not part of the 799 and
are kept in their own section so the counts stay true.

Sources joined, all on table number:

    v291-fhir/tho-fill-report.json     every observation, individually
    v291-fhir/utg-write-report.json    route, what was written, versions
    v291-extracted/vocabulary-index.json   table name, type, steward, the
                                           three OIDs the chapter carries
    tooling/scripts/vocabulary_escalations.py   the register

Usage:
    python3 tooling/scripts/render_table_ledger.py
    python3 tooling/scripts/render_table_ledger.py --check   # write nothing
"""

import argparse
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from render_review_pages import question_anchor  # noqa: E402

import vocabulary_escalations  # noqa: E402
import write_utg_xml  # noqa: E402  (for EXCLUDED_SECTIONS)
from write_utg_xml import observation_class  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
FILL_REPORT = PROJECT_ROOT / "v291-fhir" / "tho-fill-report.json"
WRITE_REPORT = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
VOCAB_INDEX = PROJECT_ROOT / "v291-extracted" / "vocabulary-index.json"
OUTPUT_PAGE = (PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
               / "table-ledger.md")

# Long values are truncated in the table cells. What a cell needs to do is let
# a reader see *that* the two sides differ and roughly how, not reproduce both
# values in full.
CELL_LIMIT = 150

ROUTE_LABEL = {
    "code-system-and-value-set": "code system + value set",
    "concept-domain-only": "concept domain only",
    "value-set-only": "value set only",
    "needs-decision": "blocked on a decision",
    "nothing-to-write": "nothing written",
    "suppressed-by-ruling": "withheld on a ruling",
    "superseded-by-ruling": "retired on a ruling, superseded",
}

# How each kind of difference is labelled in the Difference column, and the
# order the kinds appear in within a section. Disagreements come first because
# they are the ones where this guide overrode THO.
DIFFERENCE_KINDS = [
    ("discrepancy", "Disagreement"),
    ("addition", "Added here"),
    ("omission", "Not published"),
]
DIFFERENCE_LABEL = dict(DIFFERENCE_KINDS)
DIFFERENCE_ORDER = [kind for kind, _label in DIFFERENCE_KINDS]

# A four-digit table number as it appears in a register item's `tables` field.
TABLE_NUMBER_RE = re.compile(r"\b(\d{4})\b")

# How a section heading is shaded, worst first. A table gets the first tier it
# qualifies for, so the shading answers "how much attention does this one
# need?" rather than stacking every reason on top of each other; the marker
# line under the heading then spells the reasons out in words, because colour
# alone is not something every reader can use.
#
# `key` is the CSS class suffix, `label` is what the legend and the marker
# line call it.
FLAG_TIERS = [
    ("attention", "Needs special consideration"),
    ("decision", "Blocked on a decision"),
    ("both", "Differs from THO and carries an open register item"),
    ("issue", "Carries an open register item"),
    ("diff", "Differs from THO"),
]
FLAG_LABEL = dict(FLAG_TIERS)

# Tables where the published chapter's own content is missing or unusable to a
# degree that the section has to say so in full, above everything else. The
# wording is the guide's; the substance is what the chapter prints and what the
# register item asks.
SPECIAL_CONSIDERATION = {
    "0821": [
        "**Table 0821 needs a decision before this guide can publish "
        "anything for it, and the published chapter needs correcting.**",
        "",
        "Chapter 2C prints this table's coded content grid **completely "
        "blank**. The grid is six rows by five columns and every cell is "
        "empty, while the rest of the section is fully populated: three code "
        "systems (SNOMED CT, FHIR DataAbsentReason, V3 NullFlavor), three "
        "code system versions, and a value set. As published, the chapter "
        "names no codes for gender identity at all, and a reader of the "
        "chapter cannot tell what the table is supposed to contain.",
        "",
        "The row count says what was lost. Six rows is a header plus "
        "**five** code rows, and THO's `ValueSet/gender-identity` — whose "
        "OID `2.16.840.1.113883.4.642.3.3291` is exactly the one Chapter 2C "
        "prints for this value set — holds exactly **five** concepts: three "
        "SNOMED CT gender identities, `asked-declined`, and `UNK`. Table "
        "0823 *Sexual Orientation* is built the same way and does print its "
        "codes.",
        "",
        "**Two things are open, and both are for V2 Management.** The five "
        "intended codes have to be confirmed and the grid republished. And "
        "the table declares three code systems without saying which one the "
        "value set draws from, so there is no way to tell whether the value "
        "set should bind to `2.16.840.1.113883.6.96`, "
        "`2.16.840.1.113883.4.642.4.1048` or `2.16.840.1.113883.5.1008`. "
        "Until both are answered this guide publishes no code system and no "
        "value set at this table's canonicals, and THO's "
        "`ValueSet/gender-identity` stands untouched.",
        "",
        "One smaller thing in the same section: the value set description "
        "runs two sentences together with no space — \u201c…within their "
        "community.Used in HL7 Version 2.x messages\u201d.",
    ],
}

# Register items whose `tables` field ends with a hedge are flagged as
# illustrative, so a reader does not read the absence of their table from the
# list as evidence the item does not apply to it.
HEDGES = ("and others", "etc", "among others")


def cell(value, skip=0):
    """Make a value safe to drop into a markdown table cell.

    Pipes end the cell, newlines end the row, and a concept definition can run
    to several hundred characters. All three have to go.

    `skip` drops that many leading characters and marks the cut with an
    ellipsis. It is how a difference buried at the end of two near-identical
    paragraphs gets shown rather than truncated away.
    """
    if value is None:
        return "—"
    text = " ".join(str(value).split())
    if not text:
        return "—"
    text = text.replace("|", "\\|")
    lead = ""
    if skip and len(text) > skip:
        text, lead = text[skip:], "…"
    if len(text) > CELL_LIMIT:
        text = text[:CELL_LIMIT - 1].rstrip() + "…"
    return lead + text


def window_onto_difference(ours, theirs):
    """How far into two values to start showing them, so the difference shows.

    Truncating the head of two paragraphs that differ only in their last
    sentence produces two identical cells, which is worse than useless -- it
    reads as though there is no difference. So when both sides are too long to
    print and they share a substantial opening, both cells start a little
    before the point where they diverge.

    Returns:
        The number of leading characters to drop from both values.
    """
    left, right = " ".join(str(ours or "").split()), " ".join(str(theirs or "").split())
    if len(left) <= CELL_LIMIT and len(right) <= CELL_LIMIT:
        return 0
    shared = 0
    for a, b in zip(left, right):
        if a != b:
            break
        shared += 1
    if shared < CELL_LIMIT // 2:
        return 0
    # Back up a little so the cell opens mid-sentence rather than mid-word,
    # and the reader can see what the difference is attached to.
    return max(0, shared - 20)


def code_cell(record):
    """The concept a record is about, or an em dash for a resource-level one."""
    code = record.get("code")
    return f"`{cell(code)}`" if code else "—"


def element_label(record):
    """The element a record is about, with its property name when it has one."""
    element = record.get("element") or "—"
    if record.get("property"):
        return f"`{element}` ({record['property']})"
    return f"`{element}`"


def load_register():
    """Register items indexed by the table numbers they name.

    The register's `tables` field is prose written for a human -- it holds
    things like "policy", "5 concept domains" and "0001, 0125 ... and others"
    -- so the numbers are pulled out with a pattern rather than parsed. An
    item whose field hedges is marked, because then the absence of a table
    from its list proves nothing.
    """
    by_table = defaultdict(list)
    for item in vocabulary_escalations.ESCALATIONS:
        raw = str(item.get("tables") or "")
        partial = any(hedge in raw.lower() for hedge in HEDGES)
        for number in set(TABLE_NUMBER_RE.findall(raw)):
            # A section excluded from the IG gets no ledger entry, even
            # though the register still discusses it. The register is a
            # record of what was found and ruled on, which outlives the
            # table; the ledger is a view of what this guide publishes, and
            # an excluded section publishes nothing. Without this, 9999
            # reappears here from its own resolution.
            if number in write_utg_xml.EXCLUDED_SECTIONS:
                continue
            by_table[number].append({
                "id": item["id"],
                "title": vocabulary_escalations.to_markdown_text(item["title"]),
                "who": item.get("who", ""),
                "partial": partial,
                "resolution": item.get("resolution"),
            })
    for items in by_table.values():
        items.sort(key=lambda entry: entry["id"])
    return by_table


def class_index(report):
    """Class key -> how many tables that class touches.

    This is what turns a single row into "and it happens to 24 other tables
    too". The count comes from the report's own class summary so that the two
    pages can never disagree about it.
    """
    return {bucket["class"]: bucket["tableCount"] for bucket in report["classes"]}


def group_records(report):
    """Every observation, split per table into differences and fills.

    Identifier observations are collected a third time, of every kind
    including fills. A fill normally only needs counting -- it is the absence
    of a change -- but an identifier is identity, and which OID ended up on
    the artifact is worth naming even when nobody disagreed about it.
    """
    differences = defaultdict(list)
    fills = defaultdict(Counter)
    identifiers = defaultdict(list)
    fill_titles = {}
    for record in report["records"]:
        table = record.get("table")
        if not table:
            continue
        key, title, _why = observation_class(record)
        if record.get("element") == "identifier":
            identifiers[table].append(record)
        if record["kind"] == "fill":
            fills[table][key] += record.get("count", 1)
            fill_titles[key] = title
        else:
            differences[table].append((record, key, title))
    return differences, fills, fill_titles, identifiers


def version_line(entry):
    """One sentence on what the versioning policy did to each artifact.

    Every difference increments, whatever its size, so there is nothing here
    left to a human ruling. Where an increment rests on punctuation alone, the
    difference row above says so.
    """
    parts = []
    for label, key in (("Code system", "codeSystemVersion"),
                       ("Value set", "valueSetVersion")):
        version = entry.get(key)
        if not version:
            continue
        line = f"{label} **{version['version']}** — {version['reason']}"
        for element in version.get("newArtifact") or []:
            line += (f" <span class=\"tl-note\">**A changed `{element}` cannot be expressed as "
                     f"a version at all** — the policy calls for a new "
                     f"artifact at a new canonical. This needs resolving "
                     f"before publication.</span>")
        parts.append(line)
    return parts


def flag_for(table, changed, with_issues, needs_decision):
    """Which shading tier a table's heading gets, or None for no shading.

    Worst wins. A table that is blocked on a decision is shaded as blocked
    even when it also differs from THO, because the decision is the thing
    standing between it and publication.
    """
    if table in SPECIAL_CONSIDERATION:
        return "attention"
    if table in needs_decision:
        return "decision"
    if table in changed and table in with_issues:
        return "both"
    if table in with_issues:
        return "issue"
    if table in changed:
        return "diff"
    return None


def marker_reasons(table, changed, with_issues, needs_decision, oid_conflict):
    """Every reason a table's heading is shaded, shortest form, worst first.

    The shading tint says how much attention the table wants; this says why,
    and it lists all the reasons rather than only the one that set the tint.
    """
    reasons = []
    if table in SPECIAL_CONSIDERATION:
        reasons.append("Needs special consideration")
    if table in needs_decision:
        reasons.append("Blocked on a decision")
    if table in changed:
        reasons.append("Differs from THO")
    if table in with_issues:
        reasons.append("Open register item")
    if oid_conflict:
        reasons.append("OID conflict with THO")
    return reasons


def marker_line(flag, reasons):
    """The words under a shaded heading saying why it is shaded.

    The colour carries the same information, but not every reader can use
    colour, and a reader who has scrolled past the legend will have forgotten
    which tint meant what.
    """
    text = " · ".join(reasons) if reasons else FLAG_LABEL[flag]
    return f"<p class=\"tl-why tl-why-{flag}\">{text}</p>"


def decision_callout(table, entry):
    """Why a table blocked on a decision is blocked, said up front.

    A table on this route has no code system and no value set published for
    it, which is the most consequential thing its section can say, so it is
    said before the detail rather than after it.
    """
    if table in SPECIAL_CONSIDERATION:
        body = list(SPECIAL_CONSIDERATION[table])
    else:
        reason = " ".join(str((entry or {}).get("reason") or "").split())
        reason = reason.replace("--", "—")
        # The recorded reason is written from the builder's point of view.
        # The page speaks as the guide, to a committee member, so the first
        # person is turned round before it is shown.
        reason = reason.replace("shapes we build", "shapes this guide builds")
        body = ["**This table is blocked on a decision, so this guide "
                "publishes no code system and no value set for it.** "
                + (reason or "The chapter does not say enough to build one.")]
        candidates = (entry or {}).get("candidates") or []
        if candidates:
            body += ["", "The code systems the chapter declares are "
                     + ", ".join(f"`{c}`" for c in candidates)
                     + ". Which of them the value set draws from has to be "
                     "settled before either artifact can be written."]
        body += ["", "Whatever THO already publishes at these canonicals "
                 "stands untouched in the meantime."]
    quoted = [f"> {line}".rstrip() for line in body]
    return quoted + ["{: .tl-callout}", ""]


# --------------------------------------------------------------------------
# Disagreements versus differences in presentation
# --------------------------------------------------------------------------
#
# A reader who meets 489 rows all headed "Differences from THO" reads 489
# questions. Most are not questions: 76 are the two sides styling the same
# words differently, and 211 are THO holding the V2 status letter where this
# guide holds the FHIR status it maps to -- a mapping this guide already ruled
# on. Both are classified upstream in tho_merge.py; this only decides which
# table a row lands in.
#
# They are still listed, and they still count as changes for versioning. The
# split is about what a reader is being asked to DO.

PRESENTATION_NOTE = {
    "case": "Same words; only capitalisation differs.",
    "punctuation": "Same words in the same order; only punctuation differs.",
    "spacing": "Same text; only spacing differs.",
}


def is_presentational(record):
    """Whether a difference is one nobody needs to adjudicate."""
    return bool(record.get("presentation")
                or record.get("statusLetterReading"))


def presentation_reason(record):
    """The sentence explaining why a difference is not a disagreement."""
    if record.get("statusLetterReading"):
        return ("THO carries the V2 status letter; this guide publishes the "
                "FHIR status it maps to. The mapping is settled.")
    presentation = record.get("presentation") or {}
    reason = PRESENTATION_NOTE.get(presentation.get("kind"), "")
    if presentation.get("kind") != "case":
        return reason
    if presentation.get("direction") == "tho-added":
        if record.get("publishedValue"):
            # Both value columns show THO's text once its casing is adopted,
            # so the chapter's own wording would otherwise vanish from the
            # page entirely. It is named here instead.
            return (reason + " THO's capitalisation is the better of the two, "
                    "so this guide publishes it; the chapter has "
                    f"\u201c{cell(record.get('ours'))}\u201d.")
        return reason + " THO is the more capitalised side."
    return (reason + " <b>THO is the less capitalised side</b> \u2014 which may be "
            "correct style or may be a lost capital, so it is shown here "
            "rather than absorbed.")



def render_table_section(table, name, entry, diffs, fill_counts, fill_titles,
                         classes, issues, oids, in_chapter=True, flag=None,
                         reasons=()):
    """One table's section: what changed, what was kept, what is open.

    `in_chapter` is false for a `v2-NNNN` canonical THO publishes that Chapter
    2C has no section for. Such a section has no table name and no route to
    report, so it says that instead of showing the number twice.

    `flag` is the shading tier from `flag_for`, applied to the heading with a
    kramdown attribute list so the heading itself carries the tint. A reader
    scrolling several hundred sections can then see which ones want attention
    without reading any of them.
    """
    heading = f"#### {table} — {name}" if in_chapter else f"#### {table}"
    lines = [heading]
    if flag:
        lines.append("{: .tl-hd .tl-hd-" + flag + "}")
    lines.append("")
    if flag:
        lines += [marker_line(flag, list(reasons)), ""]

    if in_chapter:
        action = (entry or {}).get("action")
        route = ROUTE_LABEL.get(action, "not authored here")
        lines += [f"*Route: {route}.*", ""]
        blocked = action == "needs-decision"
        if blocked:
            lines += decision_callout(table, entry)
    else:
        blocked = False
        lines += ["*Not a Chapter 2C table — the chapter has no section for "
                  "this number.*", ""]

    versions = version_line(entry or {})
    if versions:
        lines += [f"- {part}" for part in versions] + [""]

    substantive = [item for item in diffs if not is_presentational(item[0])]
    styling = [item for item in diffs if is_presentational(item[0])]

    if substantive:
        lines += [
            f"**Differences from THO ({len(substantive)}).** "
            "Everything this guide publishes at THO's canonical that THO does "
            "not say, or says differently."
            + (f" A further {len(styling)} differ only in how the same content "
               "is written; those are listed separately below."
               if styling else ""),
            "",
            "| Difference | Element | Code | This guide publishes | THO has "
            "| Also affects |",
            "|---|---|---|---|---|---|",
        ]
        ordered = sorted(diffs, key=lambda item: (
            DIFFERENCE_ORDER.index(item[0]["kind"]),
            item[0].get("element") or "",
            item[0].get("code") or ""))
        # Differences that are only in presentation go to their own table
        # below, so this one holds only what somebody may want to challenge.
        ordered = [item for item in ordered if not is_presentational(item[0])]
        for record, key, _title in ordered:
            label = DIFFERENCE_LABEL.get(record["kind"], record["kind"])
            skip = 0
            if record["kind"] == "discrepancy":
                ours, theirs = record.get("ours"), record.get("tho")
                skip = window_onto_difference(ours, theirs)
            elif record["kind"] == "addition":
                ours, theirs = record.get("value"), "nothing"
            else:
                ours, theirs = "nothing", record.get("url") or "the artifact"
            elsewhere = classes.get(key, 1) - 1
            spread = (f"{elsewhere} other table{'s' if elsewhere != 1 else ''}"
                      if elsewhere > 0 else "only here")
            reason = record.get("reason")
            note = f"<br/><span class=\"tl-note\">{cell(reason)}</span>" if reason else ""
            if record.get("editorial"):
                note += ("<br/><span class=\"tl-note\">The two say the same "
                         "words in the same order; only punctuation differs. "
                         "It still counts as a change, so it still increments "
                         "the version.</span>")
            lines.append(
                f"| {label} | {element_label(record)} | {code_cell(record)} "
                f"| {cell(ours, skip)}{note} | {cell(theirs, skip)} | {spread} |")
        lines.append("")

    if styling:
        lines += [
            f"**Written differently, saying the same thing ({len(styling)}).** "
            "The two sides style the same content differently, or THO carries "
            "a V2 status letter where this guide carries the FHIR status it "
            "maps to. **Nothing here needs a decision.** Each still counts as "
            "a change for versioning, and each is listed so that nothing is "
            "hidden.",
            "",
            "| Element | Code | This guide publishes | THO has | Why it is "
            "not a disagreement |",
            "|---|---|---|---|---|",
        ]
        for record, _key, _title in sorted(styling, key=lambda item: (
                item[0].get("element") or "", item[0].get("code") or "")):
            # The column says "this guide publishes", so it must show what
            # was published. For the capitalisation carve-out that is THO's
            # value, not the chapter's -- showing `ours` there would
            # contradict the sentence beside it.
            ours = record.get("publishedValue") or record.get("ours")
            theirs = record.get("tho")
            skip = window_onto_difference(ours, theirs)
            lines.append(
                f"| {element_label(record)} | {code_cell(record)} "
                f"| {cell(ours, skip)} | {cell(theirs, skip)} "
                f"| {presentation_reason(record)} |")
        lines.append("")

    if fill_counts:
        total = sum(fill_counts.values())
        lines += [
            f"**Kept from THO ({total}).** Content THO publishes that Chapter "
            "2C says nothing about. None of it changes the artifact relative "
            "to THO, so none of it costs a version increment.",
            "",
            "| What | Count |",
            "|---|---:|",
        ]
        for key, count in sorted(fill_counts.items(), key=lambda kv: -kv[1]):
            lines.append(f"| {fill_titles.get(key, key)} | {count} |")
        lines.append("")

    # An answered item is not an open issue, and listing it as one tells a
    # reader the opposite of what happened. They are kept rather than dropped
    # -- somebody who remembers the question needs to find the answer against
    # the table it was about -- but under their own heading, carrying the
    # ruling.
    open_issues = [i for i in issues if not i.get("resolution")]
    answered = [i for i in issues if i.get("resolution")]

    def issue_line(issue):
        hedge = (" <span class=\"tl-note\">(the register lists this table as an example; "
                 "its list is not exhaustive)</span>"
                 if issue["partial"] else "")
        return (f"- `{issue['id']}` — {issue['title']} "
                f"— *{issue['who']}*{hedge}")

    if open_issues:
        lines += ["**Open issues.**", ""]
        lines += [issue_line(issue) for issue in open_issues]
        lines.append("")

    if answered:
        lines += ["**Answered by a committee.**", ""]
        for issue in answered:
            resolution = issue["resolution"]
            ruling = vocabulary_escalations.to_markdown_text(
                resolution["ruling"])
            lines.append(
                f"- `{issue['id']}` — {issue['title']} "
                f"— *{resolution['who']}, {resolution['date']}*<br/>"
                f"<span class=\"tl-note\">{ruling}</span>")
        lines.append("")

    if oids:
        lines += ["**Identifiers.**", ""] + [f"- {line}" for line in oids] + [""]

    # The reassuring line is only true when there is something published to
    # compare. A table blocked on a decision has no artifact at all, and its
    # callout has just said so.
    if not (diffs or fill_counts or open_issues or answered or oids
            or blocked):
        lines += ["Nothing to report: what this guide publishes matches THO "
                  "on every element compared.", ""]
    return lines


def identifier_notes(index_entry, about_identifiers):
    """What to say about this table's OIDs, when there is anything to say.

    Chapter 2C carries three OIDs per table -- one for the table itself, one
    for the code system, one for the value set -- and FHIR has somewhere to
    put only the last two. That the table OID goes nowhere is true of nearly
    every table, so it is stated once at the top of the page rather than
    repeated four hundred times here. What earns a block in a section is
    something specific to *this* table: a conflict, or an OID on one side
    only.
    """
    if not about_identifiers:
        return []

    notes = []
    for record in about_identifiers:
        if record["kind"] == "discrepancy":
            notes.append(
                f"**The chapter and THO give different OIDs for this "
                f"{record.get('resource', 'artifact')}.** The chapter says "
                f"`{record.get('ours')}`; THO says `{record.get('tho')}`, and "
                "THO's is what this guide publishes, because the canonical is "
                "THO's and an identifier is identity rather than content. "
                "Registered as `esc-oid-conflicts`.")
        elif record["kind"] == "addition":
            notes.append(
                f"This guide adds the OID `{record.get('value')}` to the "
                f"{record.get('resource', 'artifact')}; THO carries none.")
        elif record["kind"] == "fill":
            notes.append(
                f"Chapter 2C gives no OID for this "
                f"{record.get('resource', 'artifact')}, so THO's "
                f"`{record.get('value')}` is kept. Dropping it would be "
                "removing a published identifier.")

    table_oid = (index_entry or {}).get("tableOID") or ""
    if table_oid:
        notes.append(f"Chapter 2C also gives the table itself the OID "
                     f"`{table_oid}`, which this guide publishes nowhere.")
    return notes


def oid_overview(index, identifiers):
    """The page's one statement about OIDs, with the numbers computed.

    Chapter 2C carries three OIDs per table and FHIR has a home for two of
    them. Saying so once here is what lets each section stay quiet about it
    unless that table has a conflict.
    """
    def arcs(field):
        """How many tables carry this OID, and under which arcs.

        Counted rather than asserted, because the arcs are not uniform: most
        code system OIDs are in the HL7 v2 arc but sixteen are LOINC/SNOMED
        and two are ISO 3166, and a row claiming otherwise would be wrong.
        """
        counts = Counter()
        for row in index.values():
            value = (row.get(field) or "").strip()
            if value and value != "-":
                counts[".".join(value.split(".")[:6])] += 1
        total = sum(counts.values())
        (main, main_count), = counts.most_common(1) or ((None, 0),)
        others = total - main_count
        label = f"`{main}.*`"
        if others:
            arc_word = "arc" if len(counts) == 2 else "arcs"
            label += (f" <span class=\"tl-note\">+ {others} in "
                      f"{len(counts) - 1} other {arc_word}</span>")
        return total, label

    def stub_table_oids():
        """Table OIDs that are an arc root with no leaf on the end.

        `2.16.840.1.113883.1` is not an OID for anything -- it is where a
        table OID would be rooted if one had been assigned. Counting these
        separately keeps the 798 above from reading as 798 real identifiers.
        """
        stubs = []
        for number, row in sorted(index.items()):
            value = (row.get("tableOID") or "").strip()
            if value and len(value.split(".")) <= 6:
                stubs.append((number, value, row.get("tableType")))
        return stubs

    table_total, table_arc = arcs("tableOID")
    cs_total, cs_arc = arcs("codeSystemOID")
    vs_total, vs_arc = arcs("valueSetOID")
    conflicts = sorted(
        table for table, records in identifiers.items()
        for record in records if record["kind"] == "discrepancy")

    jumps = ", ".join(f"[{t}](#tbl-{t})" for t in conflicts)
    stubs = stub_table_oids()
    stub_note = []
    if stubs:
        values = sorted({value for _n, value, _t in stubs})
        types = sorted({(kind or "—") for _n, _v, kind in stubs})
        stub_note = [
            f"**{len(stubs)} of those table OIDs are not identifiers.** They "
            f"are {', '.join(f'`{v}`' for v in values)} — an arc root with no "
            f"leaf on the end, on tables the chapter types "
            f"{', '.join(f'*{t}*' for t in types)}. The count above includes "
            "them because the chapter does; nothing should resolve them.",
            "",
        ]

    return [
        "### About the OIDs",
        "",
        "Chapter 2C gives each table **three** OIDs, in three separate "
        "metadata blocks, and they identify three different things:",
        "",
        "| Chapter 2C block | Arc | Tables carrying one | Where it is published |",
        "|---|---|---:|---|",
        f"| Table OID | {table_arc} | {table_total} | **nowhere** |",
        f"| Code System OID | {cs_arc} | {cs_total} "
        "| `CodeSystem.identifier` |",
        f"| Value Set OID | {vs_arc} | {vs_total} | `ValueSet.identifier` |",
        "",
        "THO uses those same two arcs for those same two resource types, so "
        "the comparison is like for like: a code system OID is only ever "
        "checked against a code system OID.",
        "",
    ] + stub_note + [
        "**The table OID has nowhere to go.** In V2 the table is the thing "
        "with an identity; in FHIR that table becomes a code system *and* a "
        "value set, and neither of them is the table. So the `.12` OID is "
        "carried by no published resource. That is the current behaviour "
        "rather than a decision anyone has taken — see "
        f"[What needs an answer]({question_anchor('gq-chapter-2c-gives-every-table')}).",
        "",
        f"**{len(conflicts)} tables give an OID that disagrees with THO's**"
        + (f" — {jumps}. " if conflicts else ". ")
        + "THO's is published in both cases, because the canonical URL is "
        "THO's and an identifier is identity rather than content. Each is "
        "set out in that table's own section.",
        "",
    ]


def render_page(report, write_report, index, register):
    """The whole page."""
    source = report["source"]
    differences, fills, fill_titles, identifiers = group_records(report)
    classes = class_index(report)
    entries = {row["table"]: row for row in write_report["tables"]}

    names = {number: row.get("tableName") or number
             for number, row in index.items()}
    for number, row in entries.items():
        names.setdefault(number, row.get("name") or number)

    authored = {number for number, row in entries.items() if row.get("written")}
    observed = set(differences) | set(fills)

    # A table blocked on a decision, or one the register raises an item
    # against, has something to report even when the merge saw nothing about
    # it -- there is nothing published to compare, and that is exactly the
    # point. Without these a reader looking up such a table would find it only
    # in the compact list at the foot of the page, which says the opposite of
    # what is true of it.
    needs_decision = {number for number, row in entries.items()
                      if row.get("action") == "needs-decision"}
    chapter_flagged = (needs_decision | set(register)) & set(index)
    covered = sorted(authored | observed | chapter_flagged)

    # Not everything the merge observed is a Chapter 2C table. THO publishes
    # code systems and value sets at `v2-NNNN` canonicals for numbers the
    # chapter has no section for at all; the merge sees them, because seeing
    # them is the point, but they are not part of the 799 and counting them
    # as though they were makes the page's arithmetic wrong.
    chapter = set(index)
    covered_chapter = [t for t in covered if t in chapter]
    covered_elsewhere = [t for t in covered if t not in chapter]
    uncovered = sorted(chapter - set(covered))

    changed = sorted(t for t in covered if differences.get(t))
    with_issues = sorted(t for t in covered if register.get(t))
    blocked = sorted(t for t in covered if t in needs_decision)
    oid_conflicts = {t for t, records in identifiers.items()
                     for record in records if record["kind"] == "discrepancy"}

    flags = {t: flag_for(t, set(changed), set(with_issues), needs_decision)
             for t in covered}
    reasons = {t: marker_reasons(t, set(changed), set(with_issues),
                                 needs_decision, t in oid_conflicts)
               for t in covered if flags.get(t)}
    tier_counts = Counter(flag for flag in flags.values() if flag)

    lines = [
        "",
        "One section per table: **everything this guide publishes that "
        "differs from what THO publishes**, everything it keeps from THO, and "
        "every open issue the register raises against that table.",
        "",
        "[What this guide keeps from THO](tho-merge.html) reports the same "
        "merge by *class* — what kinds of thing happened and how often. This "
        "page is the other axis. Use that page to understand the merge; use "
        "this one to check a table.",
        "",
        f"Measured against a local snapshot of the **`{source.get('package')}` "
        f"package, version {source.get('version')}**, not against a live "
        f"server. {report['counts']['observations']:,} observations across "
        f"{len(observed)} tables.",
        "",
        "### How to read a section",
        "",
        "- **Differences from THO** — listed one by one. A *disagreement* is "
        "where both sides carry a value and they differ by more than "
        "whitespace; the chapter's value is published, because publishing the "
        "chapter is what this guide is for. *Added here* is content Chapter "
        "2C has and THO does not. *Not published* is a canonical where THO has "
        "an artifact and this guide writes nothing — THO's artifact stands "
        "untouched.",
        "- **Also affects** says whether a difference is a one-off or an "
        "instance of a class of problem that is repeated elsewhere. A row "
        "reading *24 other tables* is a policy question, not a data-entry "
        "question, and answering it once answers it twenty-five times.",
        "- **Kept from THO** — content THO publishes that the chapter is "
        "silent about, which the merge preserves rather than deleting. Given "
        "as counts: there are thousands and every one of them is the absence "
        "of a change.",
        "- **Open issues** — items from the V2 Management / TSMG register "
        "that name this table.",
        "- **Identifiers** — the OID situation, where there is one.",
        "",
        "Values longer than a cell are truncated. Where two long values differ "
        "only near their end, both are shown from just before the point where "
        "they diverge, so the difference is always the part on display.",
        "",
    ]

    lines += oid_overview(index, identifiers)

    lines += [
        # Explicit anchor -- the table index links to this section by id. See
        # the matching note in generate_table_index.py.
        '<a id="content-and-open-items"></a>',
        "",
        "### Tables with a difference from THO or an open item",
        "",
        f"**{len(changed)} tables differ from THO** in at least one element "
        f"that survived into the published artifact, **{len(with_issues)} "
        f"carry an open register item**, and **{len(blocked)} are blocked on "
        "a decision** and have nothing published for them yet. Everything "
        "else either matches THO on every element compared, or is content THO "
        "has never seen.",
        "",
        # See the matching note in generate_table_index.py. The two pages count
        # different things and their totals differ by an order of magnitude;
        # each states its own count and points at the other's question rather
        # than repeating the other's number.
        "This is about **content and governance**. Whether the right kind of "
        "artifact exists at all is a separate question, answered by "
        "[the tables whose artifact is missing, unexpected, or cannot expand]"
        "(table-index.html#coverage-anomalies) "
        "on the table index — a much shorter list. A table can appear on both "
        "lists, on one, or on neither.",
        "",
        "Each of these tables has its section heading shaded below, so the "
        "same information is available to somebody scrolling the page rather "
        "than following a link from here. Where a table qualifies on more "
        "than one count, the heading is shaded for the most serious of them "
        "and the line beneath it names them all.",
        "",
    ]

    lines += ["<p class=\"tl-jump\">Needs special consideration: "
              + " ".join(f"<a href=\"#tbl-{t}\">{t}</a>"
                         for t in sorted(SPECIAL_CONSIDERATION) if t in flags)
              + "</p>", ""]
    lines += ["<p class=\"tl-jump\">Blocked on a decision: "
              + " ".join(f"<a href=\"#tbl-{t}\">{t}</a>" for t in blocked)
              + "</p>", ""]
    lines += ["<p class=\"tl-jump\">Differs from THO: "
              + " ".join(f"<a href=\"#tbl-{t}\">{t}</a>" for t in changed)
              + "</p>", ""]
    lines += ["<p class=\"tl-jump\">Open register item: "
              + " ".join(f"<a href=\"#tbl-{t}\">{t}</a>" for t in with_issues)
              + "</p>", ""]

    lines += ["<p class=\"tl-legend\">"] + [
        f"<span class=\"tl-hd tl-hd-{key}\">{label} "
        f"({tier_counts.get(key, 0)})</span>"
        for key, label in FLAG_TIERS
    ] + ["</p>", ""]

    lines += [
        "<style>",
        ".tl-jump { line-height: 2; }",
        ".tl-jump a { display: inline-block; padding: 0 0.35em; }",
        # `<small>` would be the obvious tag, but the IG Publisher's HTML
        # checker rejects it and warns on every use. A classed span reads the
        # same and passes.
        ".tl-note { font-size: 0.85em; color: #555; }",
        # Heading shading. The tints are deliberately pale and the text colour
        # is pinned dark rather than inherited, so the heading keeps strong
        # contrast whatever the surrounding template does with heading colour.
        # There is no dark-mode rule: the template this guide is built on
        # renders light only, and a `prefers-color-scheme` block would repaint
        # these bands dark on an otherwise light page.
        ".tl-hd { color: #14171a; padding: 0.18em 0.5em;",
        "         border-left: 7px solid #8a8f94; border-radius: 3px; }",
        ".tl-hd-diff      { background: #fdf2d5; border-left-color: #8a6100; }",
        ".tl-hd-issue     { background: #ddeafa; border-left-color: #14507f; }",
        ".tl-hd-both      { background: #e9dff7; border-left-color: #56308c; }",
        ".tl-hd-decision  { background: #fbdcd7; border-left-color: #94241a; }",
        ".tl-hd-attention { background: #f6bfb6; border-left-width: 14px;",
        "                   border-left-color: #6e0d02; }",
        ".tl-why { margin: 0.25em 0 0.9em; font-size: 0.85em;",
        "          letter-spacing: 0.04em; text-transform: uppercase;",
        "          color: #41474d; }",
        ".tl-legend span { display: inline-block; font-size: 0.85em;",
        "                  margin: 0 0.5em 0.4em 0; }",
        # The blocked-on-a-decision block. It is the first thing in the
        # sections that carry it, so it is sized to be read rather than
        # skimmed past.
        "blockquote.tl-callout { border-left: 7px solid #94241a;",
        "                        background: #fef6f4; color: #14171a;",
        "                        padding: 0.8em 1.1em; margin: 0 0 1.1em; }",
        "</style>",
        "",
        "### Every table with something to report",
        "",
        f"**{len(covered_chapter)} of the chapter's {len(chapter)} tables.** "
        f"The other {len(uncovered)} are listed at the foot of the page, and "
        f"{len(covered_elsewhere)} canonicals that are not Chapter 2C tables "
        "at all have their own section after these.",
        "",
    ]

    def emit(table):
        lines.append(f"<a id=\"tbl-{table}\"></a>")
        lines.append("")
        oids = identifier_notes(index.get(table), identifiers.get(table, []))
        lines.extend(render_table_section(
            table, names.get(table, table), entries.get(table),
            differences.get(table, []), fills.get(table, Counter()),
            fill_titles, classes, register.get(table, []), oids,
            in_chapter=table in chapter, flag=flags.get(table),
            reasons=reasons.get(table, ())))

    for table in covered_chapter:
        emit(table)

    if covered_elsewhere:
        lines += [
            "### Canonicals with no Chapter 2C table",
            "",
            f"{len(covered_elsewhere)} numbers where THO publishes a "
            "`v2-NNNN` code system or value set and **Chapter 2C has no "
            "section at all**. They are not among the chapter's "
            f"{len(chapter)} tables, so they are not counted with them, but "
            "they are here because a reviewer asking \"what about "
            "`v2-0012`?\" deserves an answer. This guide publishes nothing at "
            "these canonicals and THO's artifacts stand untouched.",
            "",
        ]
        for table in covered_elsewhere:
            emit(table)

    lines += [
        "### The remaining tables",
        "",
        f"The remaining {len(uncovered)} of the chapter's {len(chapter)} "
        f"tables — {len(covered_chapter)} above and {len(uncovered)} here. "
        "This guide authors no code system and no value set for any of them, "
        "so the merge had nothing to compare. Most are concept domains, which "
        "carry no codes. Their route and their concept domain are on the "
        "[table index](table-index.html).",
        "",
    ]
    lines.append(" ".join(f"`{t}`" for t in uncovered))
    lines.append("")
    return "\n".join(lines)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--check", action="store_true",
                        help="report what would be written, change nothing")
    args = parser.parse_args(argv)

    for path in (FILL_REPORT, WRITE_REPORT, VOCAB_INDEX):
        if not path.is_file():
            print(f"No {path.relative_to(PROJECT_ROOT)}; run write_utg_xml.py "
                  f"first.", file=sys.stderr)
            return 1

    report = json.loads(FILL_REPORT.read_text(encoding="utf-8"))
    write_report = json.loads(WRITE_REPORT.read_text(encoding="utf-8"))
    index = {row["tableNumber"]: row for row
             in json.loads(VOCAB_INDEX.read_text(encoding="utf-8"))["tables"]
             if row["tableNumber"] not in write_utg_xml.EXCLUDED_SECTIONS}
    page = render_page(report, write_report, index, load_register())

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
