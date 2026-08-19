#!/usr/bin/env python3
"""Findings from Chapter 2C that a committee, not this project, has to resolve.

Each entry is a defect in the published V2.9.1 Chapter 2C, in
`hl7.terminology.r5`, or in both. The answer has to come from the HL7 V2
Management Group or the Terminology Services Management Group, so recording
them accurately and getting them onto an agenda is the whole job here.

The register lives in its own module because two documents render it and they
must not drift apart:

  * `render_vocabulary_review_html.py` puts it at the top of the review
    catalog, where the work happens.
  * this module, run directly, writes
    `v291-extracted/vocabulary-v2mgmt-items.md` -- a plain document that can be
    circulated to people who are not going to open a 1.6 MB HTML file.

Add an entry when you find something that is wrong in the source rather than
wrong in our handling of it. The test is simple: if no representation decision
we could take would make it correct, it belongs here.

Usage:
    python3 tooling/scripts/vocabulary_escalations.py
"""

import html
import re
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUT = PROJECT_ROOT / "v291-extracted" / "vocabulary-v2mgmt-items.md"


# --------------------------------------------------------------------------
# The escalation register
# --------------------------------------------------------------------------
#
# Findings that are not this project's to resolve. Each one is a defect in the
# published Chapter 2C, in THO, or in both, and the answer has to come from the
# HL7 V2 Management Group or the Terminology Services Management Group.
#
# They are listed first in the report on purpose. A representation decision can
# be revisited any time; getting an item onto a committee agenda has a lead
# time, so these are the ones worth knowing about early.
#
# Each entry is:
#   tables    which Chapter 2C tables it concerns
#   body      what was found, with the evidence
#   ask       what to actually put to the committee
#   who       V2 Management, TSMG, or both
#
# Authored prose, so it carries markup and is not escaped when rendered.
ESCALATIONS = [
    {
        "id": "esc-retain-known-errors",
        "who": "V2 Management + TSMG",
        "tables": "policy",
        "title": "Does &ldquo;publish V2.9.1 as published&rdquo; extend to "
                 "publishing content that is known to be wrong?",
        "body":
            "The governing requirement for this IG is fidelity: it carries "
            "exactly what Chapter 2C publishes. That is easy to hold while the "
            "divergences are typographic. It becomes a real question when the "
            "published content is not merely untidy but wrong &mdash; and two "
            "of the items below are exactly that. Table 0560 publishes time "
            "units under the name Quantity Units, and table 0931 publishes an "
            "invalid UCUM code alongside a valid one that means the same "
            "thing. "
            "There is already a precedent pointing the other way: for 0931, "
            "<b>THO chose to correct rather than reproduce</b>. Its "
            "<code>ValueSet/v2-0931</code> drops the bad code and records the "
            "history in the display text of the good one. So the two bodies "
            "have, at least once, answered this question differently.",
        "ask":
            "Decide the rule, not the instance. When Chapter 2C publishes "
            "something demonstrably wrong, does this IG (a) reproduce it and "
            "record the defect, (b) reproduce it but mark it deprecated or "
            "inactive, or (c) correct it and publish the correction with a "
            "note? The answer sets the default for every item below, and "
            "the current answer &mdash; (a) &mdash; is an assumption nobody "
            "has ratified.",
    },
    {
        "id": "esc-0560-content",
        "who": "V2 Management + TSMG",
        "tables": "0560",
        "title": "Table 0560 <i>Quantity Units</i> publishes time units, and "
                 "THO carries the same error",
        "body":
            "The table is named Quantity Units, its concept domain is "
            "&ldquo;the domain of possible values that specify the adjustment "
            "quantity&rdquo;, and it is bound to <code>ADJ-6</code>. The five "
            "codes it publishes are <code>FL</code> Units, <code>HS</code> "
            "Hours, <code>DY</code> Days, <code>MN</code> Month and "
            "<code>YY</code> Years. Four of the five are units of <i>time</i>. "
            "This is not a difference between the chapter and THO: "
            "<code>CodeSystem/v2-0560</code> in <code>hl7.terminology.r5</code> "
            "v3.0.0 publishes those same five concepts. Both are wrong in the "
            "same way, so correcting one without the other would fork them. "
            "The chapter also contradicts itself here &mdash; the table "
            "metadata says <code>Type: User</code> and &ldquo;No suggested "
            "values&rdquo;, and then lists five values.",
        "ask":
            "Is this table salvageable, or is it a concept domain with no "
            "usable code system? If it is to be fixed, the fix has to be "
            "coordinated with TSMG so Chapter 2C and THO move together. "
            "<b>This project's working decision is concept domain only</b> "
            "&mdash; no CodeSystem and no ValueSet minted &mdash; which is "
            "reversible once the committee rules.",
    },
    {
        "id": "esc-0821-blank-grid",
        "who": "V2 Management",
        "tables": "0821",
        "title": "Table 0821 <i>Gender Identity</i> publishes its coded "
                 "content grid completely blank",
        "body":
            "The grid is six rows by five columns and <i>every cell is "
            "empty</i>, while the section around it is fully populated: three "
            "code systems (SNOMED CT, FHIR DataAbsentReason, V3 NullFlavor), "
            "three code system versions, and a value set. Both extraction "
            "pipelines independently find zero codes, so this is the document "
            "rather than the tooling. "
            "The row count is the tell. Six rows is a header plus <b>five</b> "
            "code rows, and THO's <code>ValueSet/gender-identity</code> "
            "&mdash; whose OID <code>2.16.840.1.113883.4.642.3.3291</code> is "
            "exactly the one Chapter 2C prints for this value set &mdash; "
            "holds exactly <b>five</b> concepts: three SNOMED CT gender "
            "identities, <code>asked-declined</code>, and <code>UNK</code>. "
            "The grid was meant to carry those five and lost them somewhere "
            "in publication. Compare table 0823 Sexual Orientation, built the "
            "same way, which prints its codes. "
            "Minor, in the same section: the value set description runs two "
            "sentences together with no space &mdash; &ldquo;&hellip;within "
            "their community.Used in HL7 Version 2.x messages&rdquo;.",
        "ask":
            "Confirm the five intended codes and republish the grid. "
            "This project reuses THO's value set in the meantime, so nothing "
            "is blocked &mdash; but the published chapter is missing content "
            "and a reader of the PDF cannot tell what the table contains.",
    },
    {
        "id": "esc-0931-temperature",
        "who": "V2 Management",
        "tables": "0931",
        "title": "Table 0931 <i>Temperature Units</i> publishes three codes, "
                 "two of which are the same unit, and one of which is invalid",
        "body":
            "The three codes are <code>degF</code> (status <code>D</code>, "
            "comment &ldquo;typo&rdquo;), <code>[degF]</code>, and "
            "<code>Cel</code>. <code>degF</code> is not a valid UCUM code "
            "&mdash; UCUM requires the square brackets &mdash; so the table "
            "publishes a known-invalid code and its correction side by side, "
            "with two of the three entries meaning Degrees Fahrenheit. There "
            "is no Kelvin and no Rankine, so it is not a complete set of "
            "temperature units either. "
            "<b>THO has already dealt with this.</b> Its "
            "<code>ValueSet/v2-0931</code> v2.0.0 includes only "
            "<code>[degF]</code> and <code>Cel</code>, and folds the history "
            "into the display text: &ldquo;Degrees Fahrenheit (note that V2 "
            "has erroneously published this for many years without the square "
            "brackets)&rdquo;. "
            "Also in this table: the Code System Version block gives the UCUM "
            "version as <code>2</code>, which is not a UCUM version.",
        "ask":
            "This is the cleanest test case for the policy question at the "
            "top of this list. Chapter 2C reproduces an error; THO corrected "
            "it and said so. Which does this IG follow? And separately: "
            "should 0931 be filled out into an actual set of temperature "
            "units, or is the two-code set intentional?",
    },
    {
        "id": "esc-ucum-full-name",
        "who": "V2 Management",
        "tables": "0567, 0568, 0929, 0930, 0931, 0932",
        "title": "All six UCUM-backed tables name the code system "
                 "&ldquo;Donation Duration Units Code System&rdquo;",
        "body":
            "Every table in Chapter 2C backed by UCUM carries the same Code "
            "System Identification block &mdash; OID "
            "<code>2.16.840.1.113883.6.8</code>, symbolic name "
            "<code>ucum</code>, URI <code>http://unitsofmeasure.org</code> "
            "&mdash; with <code>Full Name: Donation Duration Units Code "
            "System</code>. Only 0932 is about donation duration; the name was "
            "copy-pasted across Weight Units, Volume Units and Temperature "
            "Units, twice over, since 0567/0568 duplicate 0929/0930. "
            "The name is wrong even on 0932. The code system being identified "
            "is UCUM, so its full name is the Unified Code for Units of "
            "Measure, not the name of whichever table happens to point at it.",
        "ask":
            "A technical correction: set the Full Name to UCUM's own name in "
            "all six. Expected to be uncontroversial, but it is a change to "
            "published text and so is not ours to make unilaterally.",
    },
    {
        "id": "esc-placeholder-metadata",
        "who": "V2 Management",
        "tables": "0560, 0910",
        "title": "Two tables publish literal placeholder text &mdash; "
                 "<code>noObject</code> and <code>noDescription</code>",
        "body":
            "Tables 0560 (Quantity Units) and 0910 (Acquisition Modality) each "
            "carry a Code System Identification block reading OID "
            "<code>-</code>, symbolic name <code>noObject</code>, description "
            "<code>noDescription</code>, and &mdash; again copy-pasted from "
            "somewhere else &mdash; <code>Full Name: Name Representation Code "
            "System</code>. These are not values; they are a tool's way of "
            "saying the field was left blank, and they were published. "
            "Worth noting that this placeholder appears in exactly these two "
            "sections and nowhere else in Chapter 2C, and that both are "
            "tables with no genuine code system. The placeholder is a reliable "
            "marker of the condition, not random noise, which is part of why "
            "both are treated as concept domain only.",
        "ask":
            "Should the placeholder blocks be removed from the published "
            "chapter? And, for this IG: is there any reason to preserve them "
            "verbatim as evidence of what was published, or should a table "
            "with no code system simply have no Code System Identification "
            "block?",
    },
    {
        "id": "esc-0347-iso3166",
        "who": "V2 Management",
        "tables": "0347",
        "title": "Table 0347 <i>State/Province</i> gives ISO 3166 part 1's "
                 "URI for a part 2 code system, and calls a partial value set "
                 "&ldquo;all codes&rdquo;",
        "body":
            "The Code System Identification block correctly identifies ISO "
            "3166-2 &mdash; OID <code>1.0.3166.2</code>, symbolic name "
            "<code>iso3166-2</code>, described as &ldquo;ISO 3166 Part 2 "
            "Country Subdivision Codes&rdquo; &mdash; and then gives the URI "
            "as <code>urn:iso:std:iso:3166</code>, which is part 1. THO's "
            "<code>NamingSystem/ISO3166Part2</code> carries both identifiers "
            "for this system and uses <code>urn:iso:std:iso:3166:-2</code>. "
            "Separately, the Value Set block gives its Content Logical "
            "Definition as &ldquo;all codes&rdquo; while its own URI points at "
            "<code>ValueSet-v2-notAllCodes-0347</code>, and THO's value set of "
            "that name enumerates two example concepts "
            "(<code>CA-AB</code>, <code>US-MI</code>). The published "
            "definition contradicts both its own URI and THO. "
            "The Full Name is wrong in the same way as the UCUM tables: "
            "&ldquo;State/Province Code System&rdquo; names the table, not the "
            "code system, which is ISO 3166-2.",
        "ask":
            "Two technical corrections &mdash; the URI, and the Content "
            "Logical Definition. Neither should be contentious, but both "
            "change published text.",
    },
    {
        "id": "esc-cld-inconsistent",
        "who": "V2 Management",
        "tables": "0929, 0930, 0931, 0932",
        "title": "&ldquo;All codes&rdquo; is used where a value set "
                 "enumerates a handful of UCUM codes",
        "body":
            "Tables 0929 and 0930 give their Content Logical Definition as "
            "&ldquo;enumerated per table content&rdquo;, which is accurate. "
            "Tables 0931 and 0932 say &ldquo;all codes&rdquo; while doing "
            "exactly the same thing &mdash; listing two or three UCUM codes. "
            "Read literally, &ldquo;all codes&rdquo; against UCUM would be "
            "every unit of measure in existence. THO reads all four the same "
            "way and enumerates in every case.",
        "ask":
            "Align the wording on the four tables. More usefully: is "
            "&ldquo;all codes&rdquo; meant to be a defined term with a "
            "specific mapping to <code>ValueSet.compose</code>, or is it "
            "informal prose? The answer affects how every one of the 438 "
            "value set blocks in the chapter is translated.",
    },
    {
        "id": "esc-duplicate-tables",
        "who": "V2 Management",
        "tables": "0567 / 0929, 0568 / 0930",
        "title": "Two pairs of tables are duplicates of each other",
        "body":
            "Table 0567 and table 0929 are both named Weight Units, declare "
            "the concept domain <code>WeightUnits</code>, and publish the same "
            "four UCUM codes. Table 0568 and table 0930 are both Volume Units "
            "with the same three codes. In both pairs the older table's value "
            "set URI already points at the newer table's value set "
            "(<code>ValueSet/v2-0929</code>, <code>ValueSet/v2-0930</code>), "
            "so the chapter appears to know they are the same thing.",
        "ask":
            "Confirm the older numbers are deprecated in favour of the newer "
            "ones, and say so in the chapter. This IG needs to know whether "
            "to publish two resources or one with an alias.",
    },
    {
        "id": "esc-conflicting-descriptions",
        "who": "V2 Management",
        "tables": "5 concept domains",
        "title": "Five concept domains are given two different descriptions "
                 "within Chapter 2C",
        "body":
            "A concept domain has one description by definition, so a domain "
            "described two different ways in the same chapter is a source "
            "defect rather than something this project can adjudicate. The "
            "generator emits the first description in document order, which "
            "keeps the output deterministic; the alternatives are recorded in "
            "the concept domain section of this report.",
        "ask":
            "Reconcile the five at source and say which description is "
            "correct.",
    },
    {
        "id": "esc-tho-definition-differences",
        "who": "V2 Management + TSMG",
        "tables": "0952, 0967, 0675, 0066, 0626",
        "title": "Five concept domain definitions differ between Chapter 2C "
                 "and THO",
        "body":
            "For 577 of the 582 shared concept domains, Chapter 2C and THO "
            "agree word for word. These five do not. Only 0952 is close "
            "enough for a word-level comparison to be meaningful &mdash; it "
            "differs by formatting and a stray space. The other four are "
            "wholly different texts, which usually means the two bodies have "
            "attached different meanings to the same domain rather than "
            "phrasing one meaning two ways. Under ADR-0008 D1 THO's wording is "
            "currently the one published.",
        "ask":
            "Reconcile the five between the two bodies. The four unrelated "
            "definitions matter more than the near-match: if Chapter 2C and "
            "THO genuinely disagree about what a domain means, choosing a "
            "wording does not fix that.",
    },
    {
        "id": "esc-heading-styles",
        "who": "V2 Management",
        "tables": "0685, 0767",
        "title": "Two table headings are styled <code>Normal</code> instead "
                 "of <code>Heading 3</code>",
        "body":
            "Both tables are consequently absent from the document's own table "
            "of contents, and both were invisible to extraction until they "
            "were special-cased. Their content is complete and is extracted in "
            "full; the defect is in the styling of the published document. "
            "Recorded here for completeness &mdash; it is the smallest item on "
            "this list and needs nothing from this project.",
        "ask":
            "Fix the styles in a future publication.",
    },
]


# --------------------------------------------------------------------------
# Markdown rendering
# --------------------------------------------------------------------------

# The register is authored as HTML fragments because its main home is the HTML
# report. Markdown needs the same text with the tags turned into their
# markdown equivalents rather than stripped, so emphasis survives the trip.
_TAG_TO_MARKDOWN = [
    (re.compile(r"</?b>"), "**"),
    (re.compile(r"</?i>"), "_"),
    (re.compile(r"</?code>"), "`"),
]


def to_markdown_text(fragment):
    """Convert one authored HTML fragment to markdown."""
    text = fragment
    for pattern, replacement in _TAG_TO_MARKDOWN:
        text = pattern.sub(replacement, text)
    # Named and numeric entities are how the fragments spell dashes and quote
    # marks; markdown wants the characters themselves.
    return html.unescape(text)


def render_markdown():
    """Render the whole register as one markdown document."""
    lines = [
        "# V2.9.1 Chapter 2C vocabulary: items for V2 Management and TSMG",
        "",
        "Findings from building a FHIR IG that carries the Chapter 2C",
        "vocabulary as CodeSystems and ValueSets. Each is a defect in the",
        "published chapter, in `hl7.terminology.r5`, or in both, and none of",
        "them is the IG project's to resolve.",
        "",
        "The IG's governing requirement is fidelity -- it publishes exactly",
        "what Chapter 2C publishes -- so where an item below is left",
        "unanswered, the current behaviour is to reproduce the defect and",
        "record it. The first item asks whether that is the right default.",
        "",
        "Generated from `tooling/scripts/vocabulary_escalations.py`; the same",
        "register appears at the top of",
        "`v291-extracted/vocabulary-review-report.html`. Edit the module, not",
        "this file.",
        "",
        "---",
        "",
        "## Contents",
        "",
    ]

    for number, item in enumerate(ESCALATIONS, start=1):
        title = to_markdown_text(item["title"])
        lines.append(f"{number}. [{title}](#{number}) — {item['tables']}")
    lines.append("")
    lines.append("---")
    lines.append("")

    for number, item in enumerate(ESCALATIONS, start=1):
        lines += [
            f'<a id="{number}"></a>',
            "",
            f"## {number}. {to_markdown_text(item['title'])}",
            "",
            f"**Tables:** {item['tables']}  ",
            f"**Goes to:** {item['who']}",
            "",
            to_markdown_text(item["body"]),
            "",
            f"**The ask:** {to_markdown_text(item['ask'])}",
            "",
        ]

    return "\n".join(lines)


def main():
    DEFAULT_OUT.parent.mkdir(parents=True, exist_ok=True)
    DEFAULT_OUT.write_text(render_markdown())
    print(f"{len(ESCALATIONS)} items -> {DEFAULT_OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
