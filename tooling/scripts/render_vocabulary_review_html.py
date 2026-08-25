#!/usr/bin/env python3
"""Render a single browsable catalog of everything in Chapter 2C that needs review.

Audience: whoever is deciding what the V2.9.1 vocabulary IG should contain.
The report opens in a browser with no server and no dependencies.

Three separate machine outputs feed it, because "things needing review" arrive
from three different directions:

  1. v291-extracted/vocabulary-deviations.json
     Where the python-docx extraction's emitted text differs from the published
     text, or where the published text is irregular and was left alone.

  2. v291-llm/vocabulary-comparison-report.json
     Where the two independent extractions of the same document disagree.

  3. v291-extracted/vocabulary/*.json  (the `sourceIssues` key)
     Observations about the published document itself -- empty tables,
     mis-styled headings, duplicated blocks.

Plus a coverage check against the staged THO package (tho-r5/), which decides
which tables can reuse a published canonical URL and which need a new one.

Every entry is placed in an ACTION class, so the reader can tell at a glance
what is being asked of them:

  escalate  A defect in the published chapter or in THO. Needs an answer from
            V2 Management or TSMG; not this project's to resolve.
  decide    A judgement is needed before resources can be generated.
  resolved  A judgement was made; the reasoning is recorded with it.
  confirm   Something was changed automatically; confirm it was right.
  informational
            Disclosed for completeness; no action expected.

Usage:
    python3 tooling/scripts/render_vocabulary_review_html.py
    python3 tooling/scripts/render_vocabulary_review_html.py -o /tmp/report.html
"""

import argparse
import datetime
import difflib
import html
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from vocabulary_escalations import ESCALATIONS
from vocabulary_text_policy import MISSING_SPACE_AFTER_PERIOD_RE

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
DEVIATIONS_PATH = PROJECT_ROOT / "v291-extracted" / "vocabulary-deviations.json"
COMPARISON_PATH = PROJECT_ROOT / "v291-llm" / "vocabulary-comparison-report.json"
THO_DIR = PROJECT_ROOT / "tho-r5"
CONCEPT_DOMAINS_PATH = PROJECT_ROOT / "v291-fhir" / "conceptdomains-divergences.json"
WRITER_REPORT_PATH = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
DEFAULT_OUT = PROJECT_ROOT / "v291-extracted" / "vocabulary-review-report.html"

CONCEPT_DOMAIN_PRESENTATION = {
    "added_from_chapter_2c": (
        "resolved",
        "Declared in Chapter 2C but absent from THO, so added as a new "
        "concept. ADR-0008 D1 decided that all of them are added: publishing "
        "a subset at THO's canonical URL would destructively redefine a code "
        "system this project does not own, so a superset is the only safe "
        "shape. Listed in full because the reader should be able to see what "
        "the IG adds, not because a judgement is outstanding.",
    ),
    "symbolic_name_is_not_a_plain_token": (
        "decide",
        "The Chapter 2C symbolic name is used verbatim as the concept code but "
        "contains spaces, slashes or punctuation. Decide whether to keep it "
        "exactly as published or mint a clean code and record the change.",
    ),
    "domain_declared_by_multiple_tables": (
        "informational",
        "Several code tables declare the same concept domain, so the "
        "table-to-domain relationship is not one to one.",
    ),
    "definition_differs_from_tho": (
        "decide",
        "Chapter 2C and THO describe the same domain differently. THO's wording "
        "was kept; decide whether Chapter 2C's should win instead.",
    ),
    "conflicting_descriptions_within_chapter": (
        "decide",
        "Chapter 2C itself gives this domain more than one description. The "
        "first was used.",
    ),
    "symbolic_name_near_match_in_tho": (
        "decide",
        "The Chapter 2C spelling differs from THO's only by punctuation or "
        "spacing, and looks like a typo in the published chapter.",
    ),
    "tho_v2_domain_absent_from_chapter_2c": (
        "informational",
        "THO marks these as v2-sourced but no Chapter 2C table declares them.",
    ),
    "inherited_undeclared_property": (
        "informational",
        "A property used by THO's own content but not declared in its "
        "CodeSystem.property list. May draw a validator warning.",
    ),
}

# How each deviation kind should be presented.
#   action   -> decide | confirm | informational
#   headline -> short description shown in the section header
DEVIATION_PRESENTATION = {
    "leading_trailing_whitespace": (
        "confirm",
        "Stripped automatically. Confirm each was a typo and not meaningful text.",
    ),
    "double_space_after_period": (
        "confirm",
        "Collapsed to a single space automatically, per ADR-0008 D3. Applies "
        "to descriptive fields only. Confirm the change reads correctly.",
    ),
    "double_space_after_sentence_close": (
        "confirm",
        "A sentence ending in a closing quote or bracket before the spaces, "
        "per ADR-0008 D4. Collapsed to a single space.",
    ),
    "double_space_after_comma": (
        "confirm",
        "Collapsed to a single space automatically, per ADR-0008 D4.",
    ),
    "repeated_space_in_display_name": (
        "confirm",
        "Every run of two or more spaces in a code display name is collapsed, "
        "wherever it sits, per ADR-0008 D4. Display names are short labels, so "
        "no run of repeated spaces in one is meaningful.",
    ),
    "dash_spacing": (
        "confirm",
        "A dash used as a separator was given exactly one space on each side, "
        "per ADR-0008 D5. Spacing is only ever adjusted, never inserted around "
        "a dash that had none, so hyphenated words, identifiers, URLs and "
        "minus signs are untouched.",
    ),
    "missing_comma_after_abbreviation": (
        "confirm",
        "The missing comma after \"e.g.\" and \"i.e.\" was inserted, per "
        "ADR-0008 D6. This is the only rule that adds a character rather than "
        "adjusting whitespace, so it deserves a closer look than the others.",
    ),
    "mojibake_non_breaking_space": (
        "confirm",
        "A non-breaking space that had been encoded twice, leaving a stray "
        "\"Â\" in front of it, per ADR-0008 D7. Both characters became one "
        "ordinary space.",
    ),
    "private_use_area_character": (
        "confirm",
        "A Symbol-font glyph from the Unicode private use area, deleted per "
        "ADR-0008 D7. It renders as a box or nothing at all outside the font "
        "it was typed in. The tab after it is kept, so the line reads as the "
        "indented list item it was meant to be.",
    ),
    "non_breaking_space_in_text": (
        "confirm",
        "A run of non-breaking spaces in text became one ordinary space, per "
        "ADR-0008 D7. Where lines break is the renderer's decision in a FHIR "
        "resource, so a non-breaking space carries nothing.",
    ),
    "line_initial_indent": (
        "confirm",
        "An indent at the start of a line is deliberate structure, so it is "
        "kept -- at a consistent two spaces, per ADR-0008 D7.",
    ),
    "repeated_space_collapsed": (
        "confirm",
        "Every run of two or more spaces the narrower rules did not claim, "
        "collapsed to one per ADR-0008 D7. An indent and a ditto mark are the "
        "two exceptions, and each has its own group.",
    ),
    "ditto_mark_space_run": (
        "informational",
        "A run of spaces held between two quote marks, which is a ditto mark "
        "standing for the entry above. The spaces are the value, so ADR-0008 "
        "D7 deliberately preserves them.",
    ),
    "internal_double_space": (
        "decide",
        "What REMAINS after every rule above: runs of two or more spaces that "
        "no decision covers. Left exactly as published. Decide whether any "
        "should be collapsed too.",
    ),
    "nbsp_before_punctuation": (
        "confirm",
        "A non-breaking space sitting against the punctuation that closes the "
        "clause, deleted per ADR-0008 D10. Deleted rather than turned into an "
        "ordinary space, because spacing it out would leave "
        "<code>(M49)&nbsp;.</code> &mdash; a defect of our own making.",
    ),
    "missing_space_after_period": (
        "informational",
        "What the detector still finds after ADR-0008 D17 repaired the ten "
        "real ones. <b>Neither of these is a defect.</b> "
        "<code>Observation.Code</code> in table 0396 and "
        "<code>&hellip;Reason.PurposeOfUse</code> in table 0717 are dotted "
        "identifiers, where a space would corrupt the name. They are still "
        "listed rather than filtered away, because nothing in the text tells "
        "an identifier apart from a sentence boundary &mdash; so the detector "
        "must keep reporting both kinds, and this is what a reader sees when "
        "it has been asked and answered.",
    ),
    "missing_space_correction": (
        "confirm",
        "A sentence that ran straight into the next with no space after the "
        "period (<code>within their community.Used in HL7</code>), with the "
        "space put back per ADR-0008 D17. Ten sites, in six tables. Recorded "
        "individually rather than as a rule: no pattern separates these from "
        "the two dotted identifiers in the group below.",
    ),
    "space_before_punctuation": (
        "decide",
        "A space between a word and the punctuation that closes the clause "
        "(<code>Placer Applications .</code>). Left as published. The one that "
        "was ours &mdash; table 0827's <code>(M49)&nbsp;.</code> &mdash; is "
        "gone under D10, so every remaining place is printed this way in "
        "Chapter 2C.",
    ),
    "embedded_newline": (
        "informational",
        "Left as published. Usually genuine paragraph structure inside a cell.",
    ),
    "non_breaking_space": (
        "confirm",
        "Leading or trailing, so it went with the surrounding whitespace under "
        "ADR-0008 D2 and is already absent from the emitted value. Shown "
        "because the published text still has it.",
    ),
}

COMPARISON_PRESENTATION = {
    "content": ("decide", "The two extractions genuinely disagree. Check the source document."),
    "pydocx_truncated": ("decide", "The python-docx value is a prefix of the LLM value. Investigate."),
    "block_count": ("decide", "The two extractions found a different number of metadata blocks."),
    "row_count": ("decide", "The two extractions found a different number of code rows."),
    "missing_in_llm": ("decide", "A key the python-docx extraction found and the LLM did not."),
    "missing_in_pydocx": ("decide", "A key the LLM found and the python-docx extraction did not."),
    "llm_truncated": ("informational", "Known LLM defect: the value was cut short at a literal double quote."),
    "typography": ("informational", "Known LLM defect: ASCII look-alikes for curly quotes and dashes."),
    "whitespace": (
        "informational",
        "Differs only in spacing, normally the whitespace python-docx strips "
        "or a non-breaking space the LLM flattened. Not a decision: an "
        "observation about how the two pipelines read the same cell.",
    ),
}

SOURCE_ISSUE_PRESENTATION = {
    "heading_has_wrong_word_style": (
        "decide",
        "The published heading carries the wrong Word style. Both tables were "
        "invisible to extraction until this was special-cased, and they are "
        "missing from the document's own table of contents.",
    ),
    "empty_table_in_source": (
        "decide",
        "A grid in the published document has no content at all. Six of the "
        "seven are a stray 1&times;2 layout artifact; one, table 0821, is the "
        "coded content grid itself.",
    ),
    "duplicate_table_metadata_block": (
        "decide", "Two Table Metadata blocks in one section; they were merged.",
    ),
    "unclassified_table": (
        "informational", "A table whose first cell matched no known block type.",
    ),
    "code_row_without_value": (
        "decide", "A code row with content but no code value.",
    ),
    "heading_has_no_table_name": (
        "informational", "The heading had no name after the table number.",
    ),
}

# A note recorded against a section when the reviewer has settled it. The
# section moves out of "Decide" and into "Decided", and the note travels with
# it, so the report answers both "what is left" and "what did we conclude" --
# the second of which is otherwise only in the ADR and easily lost.
#
# Keyed by section id. Add an entry here when a decision is taken; the wording
# is what a reader six months from now needs, not a reminder for today.
DECISION_NOTES = {
    "src-empty_table_in_source": (
        "2026-08-19",
        "All seven are settled, and the disposition of each is in the table "
        "below. The empty grid itself turned out to be the least interesting "
        "thing about them: in six of the seven it is a stray 1&times;2 Word "
        "layout artifact sitting beside content that extracted perfectly well, "
        "and chasing it down is what surfaced the real findings. "
        "<b>Four of the seven need no CodeSystem at all</b> &mdash; 0347, "
        "0929, 0930 and 0932 are backed by an external code system (ISO 3166-2 "
        "or UCUM) for which THO already publishes a NamingSystem, which is the "
        "same shape as the table 0227 decision in D8. <b>Two are concept "
        "domain only</b> &mdash; 0560 and 0910, neither of which identifies a "
        "code system in the published chapter. <b>One is a ValueSet composed "
        "from three external systems</b> &mdash; 0821, where THO's "
        "<code>ValueSet/gender-identity</code> is reused. "
        "Six of the seven also raised something for <b>V2 Management or "
        "TSMG</b>; those are gathered in the escalation register at the top of "
        "this report rather than repeated here.",
    ),
    "src-heading_has_wrong_word_style": (
        "2026-08-18",
        "Nothing can be done about the published document now. Both tables are "
        "known to exist, both extractors special-case the mis-styled heading, "
        "and their content is extracted in full. Worth reporting to V2 "
        "Management so a future publication fixes the style, but there is no "
        "action here.",
    ),
    "src-duplicate_table_metadata_block": (
        "2026-08-18",
        "Table 0227 is MVX, which is not an HL7 code system: it is maintained "
        "by the CDC. It maps to an <b>external metadata record</b>, and THO "
        "already publishes one &mdash; <code>NamingSystem/MVX</code> at "
        "<code>http://terminology.hl7.org/NamingSystem/MVX</code>, together "
        "with <code>ValueSet/v2-0227</code>, which composes from "
        "<code>http://hl7.org/fhir/sid/mvx</code>. The published URI "
        "<code>http://terminology.hl7.org/CodeSystem/v2-0227</code> is "
        "retained as the table moves to that representation. The duplicate "
        "block is therefore parked behind that decision rather than resolved "
        "on its own; if 0227 turns out not to be representable that way, come "
        "back to it.",
    ),
    "cmp-content": (
        "2026-08-18",
        "Both adjudicated against the source, and one of them is now gone. "
        "<b>Table 0496</b> &mdash; python-docx is correct; the value really is "
        "spaces between two ditto marks, and the LLM's tab is its own "
        "artifact. Those spaces are protected by ADR-0008 D7, and the "
        "disagreement stays visible here because the LLM's version is still "
        "wrong. <b>Table 0964</b> &mdash; the LLM is correct; python-docx was "
        "carrying Symbol-font glyphs (U+F06C) that should never have been in "
        "the text. D7 deletes them, leaving the indented list the LLM "
        "produced, so that row has disappeared from this group.",
    ),
    "cmp-missing_in_pydocx": (
        "2026-08-18",
        "Not a content difference. The LLM emitted a metadata entry with an "
        "empty key and an empty value in table 0823's value set block; "
        "python-docx has no such key, which the comparison rendered as "
        "&ldquo;absent&rdquo; against the LLM's &ldquo;empty&rdquo;. The two "
        "descriptions are of the same nothing.",
    ),
    "cmp-missing_in_llm": (
        "2026-08-18",
        "The same root cause as the duplicate metadata block in table 0227, "
        "and parked behind the same decision. Section 0227 has two grids that "
        "both begin <code>Table OID</code>: the Code System Identification "
        "block and the Table Metadata block. python-docx classifies a block by "
        "its first cell, so it read both as Table Metadata and merged them "
        "&mdash; which is why it reports <code>codeSystems: 0 blocks</code> "
        "and carries <code>Version Info</code> on the wrong block. The LLM, "
        "which sees the whole section, classified them correctly. <b>The LLM "
        "is right here.</b> No content is lost either way; only the block the "
        "content hangs from differs.",
    ),
    "cmp-block_count": (
        "2026-08-18",
        "The one difference is table 0227, explained under &ldquo;Missing in "
        "llm&rdquo; above: two grids both headed <code>Table OID</code>, which "
        "python-docx merged into one Table Metadata block and the LLM "
        "correctly split into a Code System block plus a Table Metadata block.",
    ),
    "cd-symbolic_name_near_match_in_tho": (
        "2026-08-18",
        "THO's code wins. Chapter 2C's symbolic name "
        "<code>Masterfile Action Code</code> became the code "
        "<code>MasterfileActionCode</code> in THO, and the code without the "
        "spaces is the one to keep. Recorded here rather than removed, because "
        "the difference is real and a reader should be able to see it.",
    ),
    "cd-symbolic_name_is_not_a_plain_token": (
        "2026-08-19",
        "<b>Kept verbatim; there is nothing to fix.</b> These names were "
        "flagged on the assumption that a space, an apostrophe, a comma or an "
        "en dash makes a string unusable as a FHIR code. It does not. The "
        "<code>code</code> data type permits any character except whitespace, "
        "and permits single internal spaces; every one of these 55 names is "
        "valid. Since the names are only ever used in FHIR representations, "
        "that is the only definition of &ldquo;valid&rdquo; that bears on the "
        "question. "
        "This does not disturb the 0180 decision below: THO's "
        "<code>MasterfileActionCode</code> wins there because THO already "
        "publishes that concept under that code, not because Chapter 2C's "
        "spelling was invalid. The two decisions answer different questions.",
    ),
    "cd-conflicting_descriptions_within_chapter": (
        "2026-08-19",
        "<b>Escalated, not resolved here.</b> A concept domain has one "
        "description by definition, so a domain with two is a defect in "
        "Chapter 2C and not a representation choice this project gets to make. "
        "All five go to <b>V2 Management</b> to be reconciled at source; see "
        "the escalation register at the top of this report. Until they come "
        "back, the first description in document order is the one emitted, "
        "which keeps the output deterministic and is recorded per domain "
        "below.",
    ),
    "cd-definition_differs_from_tho": (
        "2026-08-18",
        "All five go to <b>V2 Management and TSMG</b> for discussion; nothing "
        "is settled unilaterally. Full text is shown below with no truncation. "
        "Where the two versions are close enough for a difference to be worth "
        "pointing at &mdash; only table 0952, which differs from THO by "
        "formatting and a stray space &mdash; the differing words are "
        "highlighted. The other four are wholly different texts, where "
        "highlighting every word would say nothing.",
    ),
}

# Where the outstanding construct actually is, per deviation kind.
#
# An outstanding group shows a value AS EMITTED, and that value has usually
# been through several rules already -- so the thing still outstanding is one
# space somewhere inside a 700-character paragraph. Without a mark on it, a
# reader scanning the "As published" column finds a different defect, one that
# was fixed three rules ago, and decides about that instead. That happened
# twice in one review round, on tables 0440 and 0952.
#
# The pattern must match the same construct the extractor detected, or the
# mark will point at the wrong place, which is worse than no mark.
OUTSTANDING_SITE = {
    # Mirrors SPACE_BEFORE_PUNCTUATION_RE in extract_v291_vocabulary.py.
    "space_before_punctuation": re.compile(r"\S +(?=[.,;:](?:\s|$))"),
    # Shared with the extractor, not copied: see vocabulary_text_policy.
    "missing_space_after_period": MISSING_SPACE_AFTER_PERIOD_RE,
    "internal_double_space": re.compile(r" {2,}"),
    "ditto_mark_space_run": re.compile(r'(?<=["\u201c\u201d\u2018\u2019]) {2,}(?=["\u201c\u201d\u2018\u2019])'),
}


# Which ADR-0008 decision authorized each automatic change to the text.
#
# A group with an entry here is DECIDED, not awaiting confirmation. The
# reviewer worked it, the reasoning is recorded in the ADR, and presenting it
# again as something to check would be asking for the same judgement twice --
# which is exactly the complaint that produced this table. "Confirm" is
# reserved for a change that has been made but not yet reviewed by anyone.
#
# Adding a rule means adding a line here at the point the reviewer approves it.
# Until then the group renders as "Confirm", which is accurate.
DEVIATION_DECISION = {
    "leading_trailing_whitespace": "D2",
    "double_space_after_period": "D3",
    "double_space_after_sentence_close": "D4",
    "double_space_after_comma": "D4",
    "repeated_space_in_display_name": "D4",
    "dash_spacing": "D5",
    "missing_comma_after_abbreviation": "D6",
    "mojibake_non_breaking_space": "D7",
    "private_use_area_character": "D7",
    "non_breaking_space_in_text": "D7",
    "line_initial_indent": "D7",
    "repeated_space_collapsed": "D7",
    "non_breaking_space": "D2",
    "nbsp_before_punctuation": "D10",
    "manual_correction": "D14",
    "missing_space_correction": "D17",
}


# A note on a section that is still open. Same rendering as a decision, but it
# does not move the section out of "Decide" -- it is context for the decision,
# not the decision. Say plainly what is still being asked.
# The five that survive the 2026-08-19 pass, named individually. A group with
# five items left in it should say which five and why, or the next reader
# re-derives it.
# Nothing is currently open-but-undecided. Add an entry when a group is worked
# on and left unsettled, so the next reader inherits what was found. Keyed by
# section id; the note renders above the group and leaves it under "Decide".
OPEN_NOTES = {}

# Where the outstanding construct actually is, per deviation kind.
#
# An outstanding group shows a value AS EMITTED, and that value has usually
# been through several rules already -- so the thing still outstanding is one
# space somewhere inside a 700-character paragraph. Without a mark on it, a
# reader scanning the "As published" column finds a different defect, one that
# was fixed three rules ago, and decides about that instead. That happened
# twice in one review round, on tables 0440 and 0952.
#
# The pattern must match the same construct the extractor detected, or the
# mark will point at the wrong place, which is worse than no mark.
OUTSTANDING_SITE = {
    # Mirrors SPACE_BEFORE_PUNCTUATION_RE in extract_v291_vocabulary.py.
    "space_before_punctuation": re.compile(r"\S +(?=[.,;:](?:\s|$))"),
    # Shared with the extractor, not copied: see vocabulary_text_policy.
    "missing_space_after_period": MISSING_SPACE_AFTER_PERIOD_RE,
    "internal_double_space": re.compile(r" {2,}"),
    "ditto_mark_space_run": re.compile(r'(?<=["\u201c\u201d\u2018\u2019]) {2,}(?=["\u201c\u201d\u2018\u2019])'),
}


# Which ADR-0008 decision authorized each automatic change to the text.
#
# A group with an entry here is DECIDED, not awaiting confirmation. The
# reviewer worked it, the reasoning is recorded in the ADR, and presenting it
# again as something to check would be asking for the same judgement twice --
# which is exactly the complaint that produced this table. "Confirm" is
# reserved for a change that has been made but not yet reviewed by anyone.
#
# Adding a rule means adding a line here at the point the reviewer approves it.
# Until then the group renders as "Confirm", which is accurate.
DEVIATION_DECISION = {
    "leading_trailing_whitespace": "D2",
    "double_space_after_period": "D3",
    "double_space_after_sentence_close": "D4",
    "double_space_after_comma": "D4",
    "repeated_space_in_display_name": "D4",
    "dash_spacing": "D5",
    "missing_comma_after_abbreviation": "D6",
    "mojibake_non_breaking_space": "D7",
    "private_use_area_character": "D7",
    "non_breaking_space_in_text": "D7",
    "line_initial_indent": "D7",
    "repeated_space_collapsed": "D7",
    "non_breaking_space": "D2",
    "nbsp_before_punctuation": "D10",
    "manual_correction": "D14",
    "missing_space_correction": "D17",
}


# A note on a section that is still open. Same rendering as a decision, but it
# does not move the section out of "Decide" -- it is context for the decision,
# not the decision. Say plainly what is still being asked.
# The five that survive the 2026-08-19 pass, named individually. A group with
# five items left in it should say which five and why, or the next reader
# re-derives it.
OPEN_NOTES = {
    "dev-space_before_punctuation-codedContent-comment": (
        "Three left, and all three were looked at. "
        "<b>0440</b> &mdash; the double space before a hyphen that prompted "
        "the review was already gone: D7 collapsed it, and the emitted value "
        "reads <code>7.4.1.33 - ( OBR-33)</code>. What is still outstanding "
        "here is a different thing, marked below: a space before the comma in "
        "<code>( OBR-32) ,</code>. It is the same construct that was corrected "
        "in 0396, but it was not part of that instruction, so it is asked "
        "rather than assumed. (The same value also puts a space after each "
        "opening bracket, <code>( OBR-32)</code>, four times &mdash; a "
        "separate defect nobody has raised.) "
        "<b>0717</b>, twice &mdash; <b>decided: leave entirely alone.</b> "
        "Both values are retained exactly as published, line breaks included.",
    ),
    "dev-space_before_punctuation-conceptDomain-Description": (
        "One left. <b>0952</b> puts a space before a <i>colon</i> in "
        "<code>Usage Note :</code>, not before a period, so the "
        "&ldquo;remove the spaces before the periods&rdquo; instruction does "
        "not reach it. The other seven in this group are corrected under D14. "
        "Same treatment for the colon, or leave it?",
    ),
    "dev-space_before_punctuation-valueSet-Description": (
        "One left, and it is not the one it looks like. The double space "
        "between <code>elements</code> and <code>in</code> was already "
        "collapsed by D7; the emitted value reads "
        "<code>Security Classification elements in the Message Header</code>. "
        "What is still outstanding in <b>0952</b> is the space before the "
        "period in <code>Confidentiality code system .</code>, marked below. "
        "Same treatment as the seven concept domain descriptions, or leave it?",
    ),
}

# Which ADR-0008 decision authorized each automatic change to the text.
#
# A group with an entry here is DECIDED, not awaiting confirmation. The
# reviewer worked it, the reasoning is recorded in the ADR, and presenting it
# again as something to check would be asking for the same judgement twice --
# which is exactly the complaint that produced this table. "Confirm" is
# reserved for a change that has been made but not yet reviewed by anyone.
#
# Adding a rule means adding a line here at the point the reviewer approves it.
# Until then the group renders as "Confirm", which is accurate.
DEVIATION_DECISION = {
    "leading_trailing_whitespace": "D2",
    "double_space_after_period": "D3",
    "double_space_after_sentence_close": "D4",
    "double_space_after_comma": "D4",
    "repeated_space_in_display_name": "D4",
    "dash_spacing": "D5",
    "missing_comma_after_abbreviation": "D6",
    "mojibake_non_breaking_space": "D7",
    "private_use_area_character": "D7",
    "non_breaking_space_in_text": "D7",
    "line_initial_indent": "D7",
    "repeated_space_collapsed": "D7",
    "non_breaking_space": "D2",
    "nbsp_before_punctuation": "D10",
    "manual_correction": "D14",
    "missing_space_correction": "D17",
}


# A note on a section that is still open. Same rendering as a decision, but it
# does not move the section out of "Decide" -- it is context for the decision,
# not the decision. Say plainly what is still being asked.
_SPACE_BEFORE_PUNCTUATION_NOTE = (
    "<b>Nothing in this group is ours any more.</b> The one place the "
    "extraction had introduced &mdash; table 0827's "
    "<code>(M49)&nbsp;.</code>, left behind when D7 turned a non-breaking "
    "space into an ordinary one &mdash; is deleted under ADR-0008 D10. Every "
    "remaining place is printed exactly this way in Chapter 2C. "
    "<b>What is being asked:</b> whether to leave all 19 as published, which "
    "is the current behaviour and the conservative default, or to collapse "
    "them the way D3&ndash;D7 collapsed the space runs. It is one decision "
    "covering the four groups, not four."
)

OPEN_NOTES = {
    f"dev-space_before_punctuation-{where}": (_SPACE_BEFORE_PUNCTUATION_NOTE,)
    for where in ("codedContent-comment", "conceptDomain-Description",
                  "codedContent-displayName", "valueSet-Description")
}

# What was decided about one individual row of a section, keyed by section id
# and then by table number. A section-level note says what the group means; a
# row note says what happens to that particular table, which is what Batch A
# actually needs. Where a section has row notes, the table gains a Disposition
# column.
#
# Authored prose, so it carries markup and is not escaped.
SECTION_ROW_NOTES = {
    "src-empty_table_in_source": {
        "0347": (
            "<b>External code system; no CodeSystem minted.</b> The empty grid "
            "is the 1&times;2 layout artifact. Chapter 2C identifies ISO "
            "3166-2 (OID <code>1.0.3166.2</code>), and THO publishes the "
            "external metadata record for it: "
            "<code>NamingSystem/ISO3166Part2</code>, whose unique identifiers "
            "are <code>urn:oid:1.0.3166.2</code> and "
            "<code>urn:iso:std:iso:3166:-2</code> &mdash; the OID matches the "
            "chapter's exactly. That record is reused, and the ValueSet names "
            "the system in its Content Logical Definition. Same shape as the "
            "table 0227 decision in D8. Having no codes is expected for a "
            "<code>Type: User</code> table and is not loss. "
            "Two source defects went to V2 Management: the code system URI and "
            "the &ldquo;all codes&rdquo; definition."),
        "0560": (
            "<b>Concept domain only.</b> No CodeSystem and no ValueSet. The "
            "chapter identifies no code system for this table &mdash; the "
            "block is the <code>noObject</code> / <code>noDescription</code> "
            "placeholder &mdash; so there is nothing to mint a CodeSystem "
            "from, whatever the five printed codes suggest. "
            "Note the consequence: THO does publish "
            "<code>CodeSystem/v2-0560</code>, so this IG will be silent where "
            "THO is not. That is deliberate and reversible. The content itself "
            "is wrong in both, and is with V2 Management and TSMG."),
        "0821": (
            "<b>ValueSet only, reusing THO.</b> All three declared code "
            "systems are external and already published, so no CodeSystem is "
            "minted. THO's <code>ValueSet/gender-identity</code> carries the "
            "OID Chapter 2C prints for this value set and composes from "
            "exactly the three systems the chapter declares, so it is reused "
            "rather than rebuilt. The blank grid is a defect in the published "
            "document and is with V2 Management; it does not block this "
            "table, because the chapter's own Content Logical Definition says "
            "&ldquo;as defined in the linked value set&rdquo;."),
        "0910": (
            "<b>Concept domain only.</b> Same reasoning as 0560, and cleaner: "
            "the same <code>noObject</code> / <code>noDescription</code> "
            "placeholder stands where a code system should be, no codes are "
            "printed, and THO publishes neither a CodeSystem nor a ValueSet "
            "for 0910. The Value Set block's &ldquo;all codes&rdquo; would "
            "resolve to nothing. The placeholder text is with V2 Management."),
        "0929": (
            "<b>External code system; no CodeSystem minted.</b> Backed by "
            "UCUM, whose external metadata record is THO's "
            "<code>NamingSystem/v3-ucum</code> &mdash; identifiers "
            "<code>2.16.840.1.113883.6.8</code> and "
            "<code>http://unitsofmeasure.org</code>, both matching the "
            "chapter exactly. The ValueSet enumerates the four published UCUM "
            "codes, which is what THO's <code>ValueSet/v2-0929</code> already "
            "does. The wrong code system Full Name is with V2 Management."),
        "0930": (
            "<b>External code system; no CodeSystem minted.</b> Identical "
            "treatment to 0929, enumerating the three published UCUM codes. "
            "THO's <code>ValueSet/v2-0930</code> is reused."),
        "0932": (
            "<b>External code system; no CodeSystem minted.</b> Identical "
            "treatment to 0929 and 0930, enumerating <code>min</code> and "
            "<code>s</code>. THO's <code>ValueSet/v2-0932</code> matches the "
            "chapter exactly. This is the one table of the six for which the "
            "code system Full Name &mdash; &ldquo;Donation Duration Units "
            "&rdquo; &mdash; is at least about the right subject, though it "
            "still names the table rather than UCUM."),
    },
}

ACTION_ORDER = ["escalate", "decide", "resolved", "confirm", "informational"]
ACTION_LABEL = {
    "escalate": "For V2 Management / TSMG",
    "decide": "Decide",
    "resolved": "Decided",
    "confirm": "Confirm",
    "informational": "Informational",
}


def esc(text):
    """Escape text for HTML, rendering None and empty string visibly."""
    if text is None:
        return '<span class="absent">&mdash; absent &mdash;</span>'
    if text == "":
        return '<span class="empty">(empty)</span>'
    return html.escape(str(text))


# Sentinels for marking a span of text before it is HTML-escaped. Using
# characters the corpus cannot contain means the highlight survives escaping
# without having to be expressed in terms of entities.
_MARK_OPEN = "\uE000"
_MARK_CLOSE = "\uE001"


def show_invisibles(text, highlight=None):
    """Make whitespace visible so a reader can actually see the difference.

    A report about stray whitespace is useless if the whitespace is invisible,
    so spaces at the ends of a value, tabs and newlines are shown as marks.

    Args:
        text: The value to render.
        highlight: An optional compiled pattern. Every match is wrapped in a
            highlight. This is what makes an *outstanding* group readable: the
            emitted value has usually been through several rules already, so
            without a mark on the part that is still outstanding a reader has
            to diff two long strings by eye to find it -- and will find the
            wrong thing.

    Returns:
        An HTML fragment.
    """
    if text is None:
        return '<span class="absent">&mdash; absent &mdash;</span>'
    if text == "":
        return '<span class="empty">(empty)</span>'

    text = str(text)
    if highlight is not None:
        text = highlight.sub(
            lambda m: f"{_MARK_OPEN}{m.group(0)}{_MARK_CLOSE}", text)

    escaped = html.escape(text)
    escaped = escaped.replace(" ", '<span class="ws" title="non-breaking space">&#9251;</span>')
    escaped = escaped.replace("\t", '<span class="ws" title="tab">&#8677;</span>')
    escaped = escaped.replace("\n", '<span class="ws" title="line break">&#182;</span><br>')
    # Mark runs of two or more ordinary spaces.
    escaped = re.sub(r" {2,}",
                     lambda m: f'<span class="ws" title="{len(m.group(0))} spaces">'
                               + "&middot;" * len(m.group(0)) + "</span>",
                     escaped)
    escaped = (escaped.replace(_MARK_OPEN, '<mark class="site">')
                      .replace(_MARK_CLOSE, "</mark>"))
    # Mark a single leading or trailing space.
    if str(text).startswith(" "):
        escaped = '<span class="ws" title="leading space">&middot;</span>' + escaped[1:]
    if str(text).endswith(" ") and not escaped.endswith("</span>"):
        escaped = escaped[:-1] + '<span class="ws" title="trailing space">&middot;</span>'
    return escaped


def scrollable(rendered):
    """Wrap an already-rendered cell so a long value cannot swamp the table.

    Nothing is cut. An earlier version of this report truncated long values at
    300 characters, which hid the very thing a reviewer had opened the row to
    see -- table 0952's definition differs from THO's about 900 characters in.
    The full text is always present; it is the height of the box that is
    limited, and the box scrolls.
    """
    return f'<div class="cell">{rendered}</div>'


# Below this much word-level overlap, two texts are simply different texts and
# marking every word as changed tells the reader nothing they cannot see. Above
# it, the difference is worth pointing at. Chapter 2C's five disagreements with
# THO sit at 0.97 (formatting only) and 0.02-0.20 (unrelated definitions), so
# the threshold is nowhere near any of them.
DIFF_SIMILARITY_FLOOR = 0.5

# Splitting on whitespace-with-the-whitespace-kept means the rebuilt text keeps
# its original spacing, which matters when the difference IS the spacing.
_TOKEN_RE = re.compile(r"(\s+)")


def diff_pair(left, right):
    """Render two texts side by side with the differing words marked.

    Args:
        left: The first text, or None.
        right: The second text, or None.

    Returns:
        A ``(left_html, right_html, note)`` triple. ``note`` is a sentence
        explaining what the reader is looking at, or the empty string when the
        marks speak for themselves.
    """
    if left is None or right is None:
        return (show_invisibles(left), show_invisibles(right), "")

    left_tokens = _TOKEN_RE.split(str(left))
    right_tokens = _TOKEN_RE.split(str(right))
    matcher = difflib.SequenceMatcher(None, left_tokens, right_tokens)

    if matcher.ratio() < DIFF_SIMILARITY_FLOOR:
        return (show_invisibles(left), show_invisibles(right),
                "These are two unrelated definitions rather than two versions "
                "of one, so nothing is highlighted.")

    left_out, right_out = [], []
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        left_piece = show_invisibles("".join(left_tokens[i1:i2])) if i2 > i1 else ""
        right_piece = show_invisibles("".join(right_tokens[j1:j2])) if j2 > j1 else ""
        if tag == "equal":
            left_out.append(left_piece)
            right_out.append(right_piece)
        else:
            if left_piece:
                left_out.append(f'<span class="diff-out">{left_piece}</span>')
            if right_piece:
                right_out.append(f'<span class="diff-in">{right_piece}</span>')
    return ("".join(left_out), "".join(right_out),
            "Only the highlighted words differ.")


def load_json(path):
    return json.loads(path.read_text()) if path.exists() else None


def load_source_issues():
    """Collect the sourceIssues recorded against each extracted table."""
    issues = defaultdict(list)
    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        for issue in record.get("sourceIssues") or []:
            issues[issue["issue"]].append({
                "tableNumber": record.get("tableNumber", path.stem),
                "tableName": record.get("tableName", ""),
                **issue,
            })
    return issues


def load_tho_coverage():
    """Work out which CH02C tables can reuse a THO canonical URL.

    Returns None when the THO package has not been staged.
    """
    if not THO_DIR.exists():
        return None

    tho_codesystems, tho_valuesets = set(), set()
    for path in THO_DIR.glob("CodeSystem-v2-*.json"):
        tho_codesystems.add(path.stem.replace("CodeSystem-v2-", ""))
    for path in THO_DIR.glob("ValueSet-v2-*.json"):
        tho_valuesets.add(path.stem.replace("ValueSet-v2-", ""))

    with_codes, all_tables = set(), set()
    names = {}
    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        number = record.get("tableNumber", path.stem)
        all_tables.add(number)
        names[number] = record.get("tableName", "")
        if record.get("codedContent"):
            with_codes.add(number)

    return {
        "tho_codesystems": tho_codesystems,
        "tho_valuesets": tho_valuesets,
        "with_codes": with_codes,
        "all_tables": all_tables,
        "names": names,
        "needs_new_canonical": sorted(with_codes - tho_codesystems),
        "tho_without_table": sorted(tho_codesystems - all_tables),
    }


# ---------------------------------------------------------------------------
# Section building
# ---------------------------------------------------------------------------


def build_concept_domain_sections(concept_domains):
    """Turn the concept domains divergence log into review sections."""
    if not concept_domains:
        return []

    by_kind = defaultdict(list)
    for entry in concept_domains.get("divergences", []):
        by_kind[entry["kind"]].append(entry)

    sections = []
    for kind, entries in sorted(by_kind.items()):
        action, blurb = CONCEPT_DOMAIN_PRESENTATION.get(
            kind, ("decide", "Difference introduced while building the CodeSystem."))
        # Only the definition comparison benefits from a diff: the other kinds
        # put a name against a name, where the difference is already obvious.
        marks_differences = kind in ("definition_differs_from_tho",
                                     "symbolic_name_near_match_in_tho")

        rows = []
        for entry in entries:
            chapter_value = entry.get("chapter2C")
            if isinstance(chapter_value, list):
                chapter_value = " ⟂ ".join(chapter_value)
            tho_value = entry.get("tho")

            if marks_differences:
                left, right, note = diff_pair(chapter_value, tho_value)
                if note:
                    left = f'<p class="diff-note">{note}</p>{left}'
            else:
                left = show_invisibles(chapter_value)
                right = show_invisibles(tho_value)

            rows.append([
                f'<code>{html.escape(str(entry["conceptDomain"]))}</code>',
                ", ".join(entry.get("tables", [])) or "—",
                scrollable(left),
                scrollable(right),
            ])
        sections.append({
            "id": f"cd-{kind}",
            "group": "Concept domains",
            "title": kind.replace("_", " ").capitalize(),
            "action": action,
            "blurb": blurb,
            "count": len(entries),
            "columns": ["Concept domain", "Tables", "Chapter 2C", "THO"],
            "rows": rows,
            "raw_html_columns": {0, 2, 3},
        })
    return sections


# A verdict on a non-ASCII character, where one is worth recording beyond
# "THO publishes it too". Most characters need no entry at all: the THO
# cross-check below is the evidence, and a character THO already publishes is
# not this project's problem.
#
# An entry here only ever adds detail. It cannot make an attested character
# into a question.
CHARACTER_NOTES = {
    "\u201c": "Published typography.",
    "\u201d": "Published typography.",
    "\u2018": "Published typography.",
    "\u2019": "Published typography.",
    "\u2013": "Published typography.",
    "\u2014": "Published typography.",
    "\u2022": "A list bullet.",
    "\u00ae": "A trademark symbol in a product name.",
    "\u00a9": "A copyright symbol in an attribution.",
    "\u00e4": "German text, correctly spelled.",
    "\u00f6": "German text, correctly spelled.",
    "\u00fc": "German text, correctly spelled.",
    "\u00d8": (
        "NCPDP writes zero as a slashed O, so table 0396 carries "
        "<code>924\u00d8 East Raintree Drive</code> and "
        "<code>Phone: (48\u00d8) 477-1\u00d8\u00d8\u00d8</code>. THO publishes the same "
        "address, character for character, in its own "
        "<code>CodeSystem/v2-0396</code>."
    ),
    "\u2011": (
        "A non-breaking hyphen in <code>pre\u2011configured</code>, table 0945. "
        "THO carries the identical text in "
        "<code>CodeSystem/v2-0945</code> and in its concept domains."
    ),
}


def load_tho_characters():
    """Every non-ASCII character THO publishes, as a set.

    This is the whole basis on which a character is judged. A character that
    `hl7.terminology.r5` already publishes cannot be a problem for a project
    whose output sits alongside it -- whatever it looks like. Umlauts,
    trademark symbols and NCPDP's slashed zero all pass that test, and saying
    so from evidence is better than saying so from taste.

    Returns an empty set when THO is not staged, in which case the inventory
    still renders and simply cannot make the comparison.
    """
    if not THO_DIR.is_dir():
        return set()
    characters = set()
    for path in THO_DIR.glob("*.json"):
        try:
            text = path.read_text(encoding="utf-8")
        except (OSError, UnicodeDecodeError):
            continue
        characters.update(character for character in set(text)
                          if ord(character) > 127)
    return characters


def build_character_section():
    """Inventory every non-ASCII character in the corpus, with its verdict.

    A one-off scan found the double-encoded non-breaking space in table 0301.
    Making the scan part of the report means the next such character is found
    the same way, rather than by somebody noticing an odd glyph in a cell.

    What makes it useful rather than noisy is the THO comparison: the question
    is never "does this character look unusual" but "is it already published
    in the terminology this IG sits beside".
    """
    import unicodedata

    counts = Counter()
    examples = defaultdict(list)

    def walk(node, table, path):
        if isinstance(node, dict):
            for key, value in node.items():
                walk(value, table, f"{path}.{key}" if path else key)
        elif isinstance(node, list):
            for index, value in enumerate(node):
                walk(value, table, f"{path}[{index}]")
        elif isinstance(node, str):
            for character in node:
                if ord(character) < 128:
                    continue
                counts[character] += 1
                if len(examples[character]) < 3:
                    examples[character].append(f"{table} {path}")

    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        walk(record, record.get("tableNumber", path.stem), "")

    if not counts:
        return []

    tho_characters = load_tho_characters()
    rows = []
    unattested = 0
    for character, count in counts.most_common():
        in_tho = character in tho_characters
        if tho_characters and not in_tho:
            unattested += 1
            attested = "<b>no &mdash; look at it</b>"
        elif in_tho:
            attested = "yes"
        else:
            attested = '<span class="absent">&mdash; THO not staged &mdash;</span>'
        try:
            name = unicodedata.name(character)
        except ValueError:
            name = "unnamed"
        rows.append([
            f'<code>{html.escape(character)}</code>',
            f"U+{ord(character):04X}",
            name.title(),
            f"{count:,}",
            attested,
            CHARACTER_NOTES.get(character, ""),
            "<br>".join(html.escape(e) for e in examples[character]),
        ])

    if not tho_characters:
        blurb_tail = (
            "<b>THO is not staged, so the comparison could not be made.</b> "
            "Stage <code>tho-r5/</code> and re-run to get a verdict.")
    elif unattested:
        blurb_tail = (
            f"<b>{unattested} of them do not appear in THO at all</b>, which "
            "is the only thing on this page that needs a look.")
    else:
        blurb_tail = (
            "<b>Every one of them also appears in THO</b>, so none is a "
            "problem: whatever this corpus carries, the terminology it will "
            "sit beside already publishes the same character. For the two "
            "that once looked doubtful &mdash; NCPDP's slashed zero and the "
            "non-breaking hyphen &mdash; THO carries not just the character "
            "but the identical text.")

    return [{
        "id": "chars-inventory",
        "group": "Published document",
        "title": "Non-ASCII characters in the emitted corpus",
        # Never "decide" on the strength of a character looking odd. The
        # inventory is a regression check first: characters repaired by
        # ADR-0008 D7 are gone from it, which is how we know the repair held.
        "action": "decide" if unattested else "informational",
        "blurb": "Every character above ASCII that survives into the extracted "
                 "corpus, counted, and checked against every character "
                 "<code>hl7.terminology.r5</code> publishes. Characters "
                 "already repaired by ADR-0008 D7 &mdash; the double-encoded "
                 "non-breaking space in table 0301 and the Symbol-font bullets "
                 "in 0964 &mdash; no longer appear here, which is the check "
                 "that the repair worked. " + blurb_tail,
        "count": len(rows),
        "columns": ["Char", "Code point", "Name", "Count", "In THO?", "Note",
                    "Where"],
        "rows": rows,
        "raw_html_columns": {0, 4, 5, 6},
    }]


def render_evidence_table(evidence):
    """Render one register item's computed evidence as a nested HTML table.

    A few register items need every affected table listed with its text, which
    is too much to carry as authored prose and would drift the first time the
    corpus is re-extracted. The register module computes those lists; this
    turns one into a table inside the item's own cell, so it stays attached to
    the finding it is evidence for.
    """
    columns, rows = evidence()
    if not rows:
        return '<p class="ask">No matching entries in the current corpus.</p>'

    head = "".join(f"<th>{esc(name)}</th>" for name in columns)
    body = "".join(
        "<tr>" + "".join(f"<td>{esc(str(value))}</td>" for value in row) + "</tr>"
        for row in rows)
    return (f'<table class="evidence"><thead><tr>{head}</tr></thead>'
            f"<tbody>{body}</tbody></table>")


def build_escalation_section():
    """Render the escalation register as one section.

    One section rather than one per item, because a committee agenda reads
    better as a list than as a dozen separate headings, and because the reader
    of this report is not being asked to act on them individually.
    """
    rows = []
    for item in ESCALATIONS:
        finding = (f'<p><b>{item["title"]}</b></p><p>{item["body"]}</p>'
                   f'<p class="ask"><b>The ask:</b> {item["ask"]}</p>')
        if item.get("evidence"):
            finding += render_evidence_table(item["evidence"])
        rows.append([item["tables"], finding, item["who"]])
    return [{
        "id": "escalations",
        "group": "For V2 Management / TSMG",
        "title": "Open items",
        "action": "escalate",
        "blurb":
            "Defects in the published Chapter 2C, in THO, or in both. None of "
            "these is this project's to resolve, and each needs a committee "
            "answer. They are listed first because a representation decision "
            "can be revisited at any time, whereas getting an item onto an "
            "agenda has a lead time.",
        "count": len(ESCALATIONS),
        "columns": ["Tables", "Finding", "Goes to"],
        "rows": rows,
        "raw_html_columns": {1},
        "open_by_default": True,
    }]


# Batch A is the set of publication-metadata defaults Chapter 2C does not
# carry. They are the user's decisions, not a committee's, and every one of
# them is a constant at the top of `tooling/scripts/write_utg_xml.py`. Each
# entry states what is emitted now, what the evidence for it is, and what the
# alternative would be, so the decision can be made from this table alone.
BATCH_A_DEFAULTS = [
    (
        "<code>version</code>",
        "Inherited per resource from the existing UTG file. "
        "<b>1.0.0 for the 14 resources UTG does not have.</b>",
        "UTG's own corpus is not uniform: its CodeSystems carry 3.0.0 (412), "
        "5.0.0 (3) and 4.0.0 (1); its ValueSets carry 3.0.0 (430), 2.0.0 (6) "
        "and 4.0.0 (3). Inheriting keeps 807 of 823 resources exactly where "
        "UTG has them and confines the question to genuinely new content.",
        "<b>Decided (2026-08-25): a brand-new CodeSystem or ValueSet starts at "
        "1.0.0.</b> This replaces a 3.0.0 placeholder that had been chosen only "
        "to match the neighbouring resources. A first publication is a first "
        "version regardless of what sits beside it, and starting at 3.0.0 would "
        "imply two releases that never happened. The 14 affected resources, "
        "across 12 tables, are listed in the write report under "
        "<code>usedDefaultVersion</code>, which now records the fallback per "
        "resource rather than per table &mdash; a table can inherit a version "
        "for its CodeSystem and not for its ValueSet, and three do. "
        "<b>Two of those fourteen should probably not be in the list at all:</b> "
        "0291 and 0347 fall back only because UTG files their value sets under "
        "<code>v2-notAllCodes-NNNN</code>, so the name-based lookup misses "
        "them. See the field-mapping document.",
    ),
    (
        "<code>date</code>",
        "Inherited from UTG; <code>2019-12-01</code> as the fallback.",
        "414 of 416 UTG CodeSystems and 437 of 439 ValueSets carry "
        "<code>2019-12-01</code> &mdash; the date of the bulk v2 load, not a "
        "date anyone chose per resource.",
        "Using it for new content asserts the resource existed in 2019, which "
        "is false. The alternatives are the date this work is published, or "
        "omitting <code>date</code> on new resources. Note that a build date "
        "would churn on every regeneration, which is why it is not a "
        "generated value today.",
    ),
    (
        "<code>status</code>, <code>experimental</code>",
        "<code>active</code> and <code>false</code> for everything.",
        "Unanimous in UTG: all 416 CodeSystems and all 439 ValueSets carry "
        "exactly these two values.",
        "Defensible to adopt without further thought for content that mirrors "
        "UTG. Worth a moment's thought for the two genuinely new CodeSystems "
        "(0411, 0460), which have never been published anywhere and are "
        "arguably <code>draft</code> until they have.",
    ),
    (
        "<code>publisher</code>, <code>contact</code>",
        "&ldquo;Health Level Seven International&rdquo;, with "
        "<code>http://hl7.org</code> and <code>hq@HL7.org</code>.",
        "Unanimous across all 855 UTG files.",
        "No reason to diverge. The one thing to know is that the IG Publisher "
        "will <b>overwrite these</b> from the IG's own values unless "
        "<code>apply-publisher</code> and <code>apply-contact</code> are set "
        "false &mdash; along with <code>apply-version</code>, "
        "<code>apply-copyright</code>, <code>apply-wg</code>, "
        "<code>apply-jurisdiction</code> and <code>apply-license</code>, all "
        "of which the base template defaults to true.",
    ),
    (
        "ValueSet coverage",
        "One ValueSet wherever Chapter 2C declares a Value Set block.",
        "<b>This question turned out to be moot.</b> Across all 799 tables, "
        "&ldquo;declares a Value Set block&rdquo; and &ldquo;Concept Domain "
        "Only = no&rdquo; coincide exactly &mdash; 438 of each, the same set, "
        "no exceptions. The two candidate policies produce identical output.",
        "Nothing to decide. Recorded so it is not reopened.",
    ),
]


def build_batch_a_section():
    """Render the publication-metadata defaults as one decision table.

    These are not committee questions and not defects; they are the handful of
    values Chapter 2C does not supply, which somebody has to choose. They are
    gathered here rather than left in the source so the choice can be made
    against the evidence rather than by reading a constants block.
    """
    rows = [[name,
             f"<p><b>{emitted}</b></p><p>{evidence}</p>"
             f'<p class="ask"><b>To decide:</b> {decision}</p>']
            for name, emitted, evidence, decision in BATCH_A_DEFAULTS]
    return [{
        "id": "batch-a-defaults",
        "group": "For the editor",
        "title": "Publication metadata Chapter 2C does not carry",
        "action": "decide",
        "blurb":
            "Every generated resource needs a version, a date, a status and a "
            "publisher, and the chapter supplies none of them. Each value "
            "below is a single constant in "
            "<code>tooling/scripts/write_utg_xml.py</code>. None blocks "
            "generation; all of them are cheap to change now and expensive to "
            "change after the resources are in front of a committee.",
        "count": len(BATCH_A_DEFAULTS),
        "columns": ["Field", "What is emitted, and why"],
        "rows": rows,
        "raw_html_columns": {1},
        "open_by_default": True,
    }]


def build_writer_blocker_section():
    """Render the tables the XML writer could not settle by itself.

    The writer emits a resource only where Chapter 2C says clearly enough what
    the resource should be; everything else is reported rather than guessed at.
    Those reports belong here, in the document the reviewer actually opens,
    rather than only in a JSON file beside the generated XML.

    Grouped by obstacle rather than listed per table, because the tables that
    share an obstacle are answered by one decision, not by several.
    """
    report = load_json(WRITER_REPORT_PATH)
    if not report:
        return []

    blocked = [e for e in report.get("tables", [])
               if e.get("action") == "needs-decision"]
    if not blocked:
        return []

    grouped = defaultdict(list)
    for entry in blocked:
        grouped[entry["reason"]].append(entry)

    rows = []
    for reason, entries in sorted(grouped.items(), key=lambda kv: -len(kv[1])):
        tables = ", ".join(f'{e["table"]} <i>{esc(e["name"])}</i>'
                           for e in sorted(entries, key=lambda e: e["table"]))
        detail = f"<p>{esc(reason)}</p><p class=\"ask\">{tables}</p>"
        published = [e["published"] for e in entries if e.get("published")]
        if published:
            detail += ("<p>As published: "
                       + ", ".join(f"<code>{esc(p)}</code>"
                                   for p in sorted(set(published)))
                       + "</p>")
        rows.append([str(len(entries)), detail])

    return [{
        "id": "writer-blockers",
        "group": "For V2 Management / TSMG",
        "title": "Tables the XML writer will not guess at",
        "action": "decide",
        "blurb":
            "The writer produces a CodeSystem or ValueSet only where the "
            "chapter says clearly enough what it should be. These tables it "
            "leaves alone, and each group below is one decision rather than "
            "one per table. Nothing here is a defect in the tooling; each is a "
            "place the published chapter is ambiguous, incomplete, or points "
            "somewhere that does not resolve.",
        "count": len(blocked),
        "columns": ["Tables", "What stopped it"],
        "rows": rows,
        "raw_html_columns": {1},
        "open_by_default": True,
    }]


def build_sections(deviations, comparison, source_issues):
    """Assemble every reviewable item into an ordered list of section dicts.

    Each section is one homogeneous kind of issue, so the reader makes one kind
    of decision at a time rather than context-switching per row.
    """
    sections = []

    # --- Source document issues -------------------------------------------
    for issue_kind, entries in sorted(source_issues.items()):
        action, blurb = SOURCE_ISSUE_PRESENTATION.get(
            issue_kind, ("decide", "Observed in the published document."))
        section_id = f"src-{issue_kind}"
        row_notes = SECTION_ROW_NOTES.get(section_id, {})

        columns = ["Table", "Name", "Detail"]
        raw_html_columns = {2}
        if row_notes:
            columns.append("Disposition")
            raw_html_columns.add(3)

        rows = []
        for entry in entries:
            row = [
                entry["tableNumber"],
                entry.get("tableName", ""),
                esc(entry.get("detail") or json.dumps(
                    {k: v for k, v in entry.items()
                     if k not in ("issue", "tableNumber", "tableName")})),
            ]
            if row_notes:
                row.append(row_notes.get(
                    entry["tableNumber"],
                    '<span class="absent">&mdash; not yet decided &mdash;</span>'))
            rows.append(row)

        sections.append({
            "id": section_id,
            "group": "Published document",
            "title": issue_kind.replace("_", " ").capitalize(),
            "action": action,
            "blurb": blurb,
            "count": len(entries),
            "columns": columns,
            "rows": rows,
            "raw_html_columns": raw_html_columns,
        })

    # --- Cross-pipeline disagreements -------------------------------------
    by_bucket = defaultdict(list)
    for table, findings in (comparison or {}).get("findings", {}).items():
        for finding in findings:
            by_bucket[finding["bucket"]].append((table, finding))

    for bucket in sorted(by_bucket, key=lambda b: (
            ACTION_ORDER.index(COMPARISON_PRESENTATION.get(b, ("decide", ""))[0]), b)):
        action, blurb = COMPARISON_PRESENTATION.get(
            bucket, ("decide", "Disagreement between the two extractions."))
        entries = by_bucket[bucket]
        rows = []
        for table, finding in entries:
            left, right, note = diff_pair(finding["pydocx"], finding["llm"])
            if note:
                left = f'<p class="diff-note">{note}</p>{left}'
            rows.append([
                table,
                f'<code>{html.escape(finding["location"])}</code>',
                scrollable(left),
                scrollable(right),
            ])
        sections.append({
            "id": f"cmp-{bucket}",
            "group": "Extraction cross-check",
            "title": bucket.replace("_", " ").capitalize(),
            "action": action,
            "blurb": blurb,
            "count": len(entries),
            "columns": ["Table", "Location", "python-docx", "LLM"],
            "rows": rows,
            "raw_html_columns": {1, 2, 3},
        })

    # --- Text deviations ---------------------------------------------------
    for group in (deviations or {}).get("groups", []):
        kind = group["kind"]
        action, blurb = DEVIATION_PRESENTATION.get(
            kind, ("decide", "Difference between published and emitted text."))
        # A change made under a recorded decision is decided, not pending.
        if group["action"] == "normalized" and kind in DEVIATION_DECISION:
            action = "resolved"
        where = f'{group["section"]}.{group["field"]}' if group["field"] else group["section"]
        changed = group["action"] == "normalized"
        # Only outstanding groups get the mark. In a changed group the two
        # columns already differ exactly where the change was, so a highlight
        # would add nothing.
        site = None if changed else OUTSTANDING_SITE.get(kind)
        rows = []
        for entry in group["deviations"]:
            rows.append([
                entry["tableNumber"],
                scrollable(show_invisibles(entry["raw"])),
                scrollable(show_invisibles(
                    entry.get("normalized", entry["raw"]), highlight=site)),
            ])
        # The group label says outright whether the text was changed or left
        # alone, so the report answers "what has been done" and "what is still
        # outstanding" without the reader having to decode the kind name.
        prefix = "Text changed" if changed else "Text outstanding"
        sections.append({
            "id": f"dev-{kind}-{where.replace('.', '-')}",
            "group": f"{prefix}: {kind.replace('_', ' ')}",
            "title": where,
            "action": action,
            "blurb": blurb + (
                "  These were changed." if changed
                else "  These were left as published."),
            "count": group["count"],
            "columns": ["Table", "As published",
                        "As emitted" + ("" if changed
                                        else " \u2014 outstanding site marked")],
            "rows": rows,
            "raw_html_columns": {1, 2},
        })

    return sections


def apply_decision_notes(sections):
    """Attach recorded decisions and move those sections out of "Decide".

    A section that has been settled is no longer something to decide, but it is
    not nothing either -- the conclusion is the most valuable thing on the page
    once the work is done. It gets its own class so the counts at the top say
    honestly how much is left.
    """
    for section in sections:
        note = DECISION_NOTES.get(section["id"])
        if note:
            date, text = note
            section["note"] = f"<b>Decided {html.escape(date)}.</b> {text}"
            section["action"] = "resolved"
            continue
        open_note = OPEN_NOTES.get(section["id"])
        if open_note:
            section["note"] = f"<b>Still open.</b> {open_note[0]}"
            section["note_is_open"] = True
    return sections


def build_html(sections, deviations, comparison, coverage, generated):
    """Assemble the whole report as one self-contained HTML string."""
    out = []
    add = out.append

    # Two different numbers matter, and conflating them is misleading: a group
    # of 375 identical double spaces in one field is ONE decision, not 375.
    action_totals = Counter()      # individual affected values
    action_groups = Counter()      # decisions to actually make
    for section in sections:
        action_totals[section["action"]] += section["count"]
        action_groups[section["action"]] += 1

    add("<!DOCTYPE html><html><head><meta charset='utf-8'>")
    add("<title>V2.9.1 Chapter 2C — review catalog</title>")
    add(f"<style>{STYLE}</style></head><body>")

    # ---- sidebar ----
    add("<div id='sidebar'>")
    add("<h2>Overview</h2>")
    add("<a href='#summary'>Summary</a>")
    if coverage:
        add("<a href='#canonicals'>THO canonical coverage</a>")
    grouped = defaultdict(list)
    for section in sections:
        grouped[section["group"]].append(section)
    for action in ACTION_ORDER:
        wanted = [(g, s) for g, ss in grouped.items() for s in ss if s["action"] == action]
        if not wanted:
            continue
        add(f"<h2>{ACTION_LABEL[action]} &mdash; {action_groups[action]} groups</h2>")
        for group, section in wanted:
            add(f"<a href='#{section['id']}'>{html.escape(group)}: "
                f"{html.escape(section['title'])} "
                f"<span class='count'>({section['count']})</span></a>")
    add("</div>")

    # ---- main ----
    add("<div id='main'>")
    add("<h1>V2.9.1 Chapter 2C — review catalog</h1>")
    add(f"<p class='sub'>Generated {esc(generated)} from <code>CH02C_Tables.docx</code>. "
        "Every item that needs a human decision before FHIR CodeSystem and "
        "ValueSet resources can be generated.</p>")

    add("<div class='callout'>"
        "<b>How to read this.</b> Items are grouped by what is being asked of you. "
        f"<span class='badge b-escalate'>For V2 Management / TSMG</span> means a "
        "defect that a committee has to resolve, not this project. "
        f"<span class='badge b-decide'>Decide</span> means a judgement is needed. "
        f"<span class='badge b-resolved'>Decided</span> means a judgement was made; "
        "the reasoning is recorded with it. "
        f"<span class='badge b-confirm'>Confirm</span> means something was changed "
        "automatically and has not yet been reviewed by anyone &mdash; a change "
        "made under a recorded decision is Decided, not Confirm. "
        f"<span class='badge b-info'>Informational</span> means no action is expected. "
        "Whitespace is shown with visible marks: "
        "<span class='ws'>&middot;</span> a space, "
        "<span class='ws'>&#8677;</span> a tab, "
        "<span class='ws'>&#9251;</span> a non-breaking space, "
        "<span class='ws'>&#182;</span> a line break. "
        "In an outstanding group the <mark class='site'>marked span</mark> in "
        "the emitted column is the part still awaiting a decision &mdash; the "
        "rest of the value may already have been corrected by an earlier rule."
        "</div>")

    add("<h2 id='summary'>Summary</h2>")
    add("<div class='metric-grid'>")
    add(f"<div class='metric-card mc-escalate'>"
        f"<div class='number'>{action_totals['escalate']}</div>"
        "<div class='label'>items for V2 Management<br><span class='faint'>"
        "or TSMG; not ours to resolve</span></div></div>")
    add(f"<div class='metric-card mc-flag'><div class='number'>{action_groups['decide']}</div>"
        f"<div class='label'>decisions to make<br><span class='faint'>"
        f"covering {action_totals['decide']:,} values</span></div></div>")
    add(f"<div class='metric-card mc-good'><div class='number'>{action_groups['resolved']}</div>"
        f"<div class='label'>decided, with the reasoning<br><span class='faint'>"
        f"covering {action_totals['resolved']:,} values</span></div></div>")
    add(f"<div class='metric-card'><div class='number'>{action_groups['confirm']}</div>"
        f"<div class='label'>groups to confirm<br><span class='faint'>"
        f"covering {action_totals['confirm']:,} values</span></div></div>")
    add(f"<div class='metric-card'><div class='number'>{action_groups['informational']}</div>"
        f"<div class='label'>informational groups<br><span class='faint'>"
        f"covering {action_totals['informational']:,} values</span></div></div>")
    if comparison:
        common = comparison.get("coverage", {}).get("common", 0)
        clean = common - len(comparison.get("findings", {}))
        add(f"<div class='metric-card mc-good'><div class='number'>{clean}/{common}</div>"
            "<div class='label'>tables both extractions agree on entirely</div></div>")
    if coverage:
        add(f"<div class='metric-card'><div class='number'>{len(coverage['needs_new_canonical'])}</div>"
            "<div class='label'>tables needing a new canonical URL</div></div>")
    add("</div>")

    add("<table><tr><th>Where it came from</th><th>What it is</th>"
        "<th class='num'>Items</th></tr>")
    provenance_rows = [
        ("For V2 Management / TSMG",
         "Defects in the published chapter or in THO that a committee has to "
         "resolve",
         sum(s["count"] for s in sections if s["group"] == "For V2 Management / TSMG")),
        ("Published document", "Irregularities in <code>CH02C_Tables.docx</code> itself",
         sum(s["count"] for s in sections if s["group"] == "Published document")),
        ("Extraction cross-check",
         "Where the python-docx and LLM extractions of the same document disagree",
         sum(s["count"] for s in sections if s["group"] == "Extraction cross-check")),
        ("Text changed",
         "Published text the extractor normalized. See "
         "<code>v291-extracted/vocabulary-changelog.md</code>",
         sum(s["count"] for s in sections if s["group"].startswith("Text changed"))),
        ("Text outstanding",
         "Published text left exactly as-is, awaiting a decision or disclosed "
         "for completeness",
         sum(s["count"] for s in sections if s["group"].startswith("Text outstanding"))),
        ("Concept domains",
         "Choices made while extending THO's concept domains CodeSystem",
         sum(s["count"] for s in sections if s["group"] == "Concept domains")),
    ]
    for label, description, count in provenance_rows:
        add(f"<tr><td>{label}</td><td>{description}</td><td class='num'>{count}</td></tr>")
    add("</table>")

    # ---- canonical coverage ----
    if coverage:
        add("<h2 id='canonicals'>THO canonical URL coverage</h2>")
        add(f"<p class='sub'>Checked against the staged "
            f"<code>hl7.terminology.r5</code> package. "
            f"{len(coverage['tho_codesystems'])} v2 CodeSystems and "
            f"{len(coverage['tho_valuesets'])} v2 ValueSets are published there.</p>")
        reusable = len(coverage["with_codes"] & coverage["tho_codesystems"])
        add("<table><tr><th>Situation</th><th class='num'>Tables</th><th>Meaning</th></tr>")
        add(f"<tr><td>Code-bearing table with a THO CodeSystem</td>"
            f"<td class='num'>{reusable}</td>"
            "<td>Reuse the published canonical URL as-is</td></tr>")
        add(f"<tr><td>Code-bearing table with no THO CodeSystem</td>"
            f"<td class='num'>{len(coverage['needs_new_canonical'])}</td>"
            "<td>A canonical URL must be minted</td></tr>")
        add(f"<tr><td>THO CodeSystem with no CH02C table</td>"
            f"<td class='num'>{len(coverage['tho_without_table'])}</td>"
            "<td>Present in THO but not in this chapter; likely retired</td></tr>")
        add("</table>")

        add("<details><summary>Tables needing a new canonical URL "
            f"<span class='meta'>({len(coverage['needs_new_canonical'])})</span></summary>")
        add("<table><tr><th>Table</th><th>Name</th></tr>")
        for number in coverage["needs_new_canonical"]:
            add(f"<tr><td>{esc(number)}</td><td>{esc(coverage['names'].get(number, ''))}</td></tr>")
        add("</table></details>")

        add("<details><summary>THO CodeSystems with no matching CH02C table "
            f"<span class='meta'>({len(coverage['tho_without_table'])})</span></summary>")
        add("<p>" + ", ".join(f"<code>v2-{esc(n)}</code>"
                              for n in coverage["tho_without_table"]) + "</p>")
        add("</details>")

    # ---- the sections themselves ----
    for action in ACTION_ORDER:
        matching = [s for s in sections if s["action"] == action]
        if not matching:
            continue
        add(f"<h2>{ACTION_LABEL[action]} &mdash; {action_groups[action]} groups, "
            f"{action_totals[action]:,} values</h2>")
        for section in sorted(matching, key=lambda s: (-s["count"], s["group"])):
            add(f"<h3 id='{section['id']}'>"
                f"<span class='badge b-{action}'>{ACTION_LABEL[action]}</span> "
                f"{html.escape(section['group'])}: {html.escape(section['title'])} "
                f"<span class='dim-tag'>{section['count']}</span></h3>")
            # Blurbs and notes are authored constants in this file, not data
            # from the corpus, so they may carry markup and are not escaped.
            add(f"<p class='legend'>{section['blurb']}</p>")
            if section.get("note"):
                note_class = "decision open" if section.get("note_is_open") else "decision"
                add(f"<div class='{note_class}'>{section['note']}</div>")
            open_attr = " open" if section.get("open_by_default") else ""
            add(f"<details{open_attr}><summary>Show the "
                f"{len(section['rows'])} entries</summary>")
            add("<table><tr>"
                + "".join(f"<th>{html.escape(c)}</th>" for c in section["columns"])
                + "</tr>")
            for row in section["rows"]:
                cells = []
                for index, cell in enumerate(row):
                    value = cell if index in section.get("raw_html_columns", set()) else esc(cell)
                    cells.append(f"<td>{value}</td>")
                add("<tr>" + "".join(cells) + "</tr>")
            add("</table></details>")

    add("</div></body></html>")
    return "\n".join(out)


STYLE = """
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
  margin: 0; display: flex; color: #1f2328; line-height: 1.5; }
#sidebar { position: fixed; top: 0; left: 0; width: 280px; height: 100vh; overflow-y: auto;
  background: #f6f8fa; border-right: 1px solid #d0d7de; padding: 16px; box-sizing: border-box; font-size: 13px; }
#sidebar h2 { font-size: 14px; margin: 16px 0 8px; text-transform: uppercase; letter-spacing: .03em; color: #57606a; }
#sidebar h2:first-child { margin-top: 0; }
#sidebar a { display: block; padding: 3px 0; color: #0969da; text-decoration: none; }
#sidebar a:hover { text-decoration: underline; }
#sidebar .count { color: #57606a; font-size: 11px; }
#main { margin-left: 280px; padding: 24px 40px; max-width: 1180px; }
h1 { font-size: 24px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 19px; margin-top: 40px; border-bottom: 1px solid #d0d7de; padding-bottom: 4px; }
h3 { font-size: 15px; margin-top: 28px; }
p.sub { color: #57606a; margin-top: 2px; }
table { border-collapse: collapse; width: 100%; font-size: 13px; margin: 8px 0 16px; }
th, td { border: 1px solid #d0d7de; padding: 5px 9px; text-align: left; vertical-align: top; }
th { background: #f6f8fa; }
td.num, th.num { text-align: right; }
tr:nth-child(even) td { background: #fbfcfd; }
.callout { background: #ddf4ff; border: 1px solid #54aeff; border-radius: 6px; padding: 12px 16px; margin: 16px 0; font-size: 14px; }
.callout.warn { background: #fff8c5; border-color: #d4a72c; }
.metric-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 12px; margin: 16px 0; }
.metric-card { border: 1px solid #d0d7de; border-radius: 6px; padding: 14px; text-align: center; background: #fff; }
.metric-card .number { font-size: 26px; font-weight: 700; }
.metric-card .label { font-size: 12px; color: #57606a; margin-top: 4px; }
.mc-good .number { color: #1a7f37; } .mc-flag .number { color: #bc4c00; }
.mc-escalate .number { color: #8250df; } .mc-escalate { border-color: #c297ff; }
span.absent { color: #afb8c1; } span.empty { color: #afb8c1; font-style: italic; }
.badge { display: inline-block; padding: 1px 8px; border-radius: 10px; font-size: 11px; font-weight: 600; color: #fff; white-space: nowrap; }
.b-decide { background: #bc4c00; } .b-confirm { background: #0969da; } .b-info { background: #6e7781; }
.b-resolved { background: #1a7f37; } .b-escalate { background: #8250df; }
p.ask { background: #faf5ff; border-left: 3px solid #c297ff; padding: 8px 12px; margin: 8px 0 0; }
table.evidence { font-size: 12px; margin-top: 12px; }
table.evidence th { background: #f3eefc; }
.decision { background: #dafbe1; border: 1px solid #4ac26b; border-left-width: 4px;
  border-radius: 6px; padding: 10px 14px; margin: 8px 0; font-size: 13px; }
.decision.open { background: #fff8c5; border-color: #d4a72c; }
.cell { max-height: 22em; overflow-y: auto; }
.diff-note { margin: 0 0 6px; font-size: 12px; color: #57606a; font-style: italic; }
.diff-out { background: #ffd8d3; text-decoration: line-through; }
.diff-in { background: #d2f8d2; }
details { margin: 6px 0; border: 1px solid #d0d7de; border-radius: 6px; padding: 0 12px; }
details[open] { padding-bottom: 8px; }
summary { cursor: pointer; padding: 10px 0; font-weight: 600; }
summary .meta { font-weight: 400; color: #57606a; font-size: 13px; }
code { background: #eff1f3; padding: 1px 5px; border-radius: 4px; font-size: 90%; }
.legend { font-size: 13px; color: #57606a; }
.dim-tag { display:inline-block; background:#eaeef2; border-radius:4px; padding:0 6px; font-size:11px; color:#424a53; margin-left:6px; }
.faint { color: #8b949e; font-size: 11px; }
.ws { background: #ffe0b2; color: #8a4b00; border-radius: 2px; font-weight: 700; }
mark.site { background: #ffd8b0; outline: 2px solid #d4691e; border-radius: 2px; }
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("-o", "--output", default=str(DEFAULT_OUT),
                        help=f"Where to write the HTML (default {DEFAULT_OUT})")
    args = parser.parse_args()

    deviations = load_json(DEVIATIONS_PATH)
    comparison = load_json(COMPARISON_PATH)
    source_issues = load_source_issues()
    concept_domains = load_json(CONCEPT_DOMAINS_PATH)
    coverage = load_tho_coverage()

    if deviations is None:
        print(f"WARNING: no deviation log at {DEVIATIONS_PATH}")
    if comparison is None:
        print(f"WARNING: no comparison report at {COMPARISON_PATH}")

    sections = build_escalation_section()
    sections += build_writer_blocker_section()
    sections += build_batch_a_section()
    sections += build_sections(deviations, comparison, source_issues)
    sections += build_concept_domain_sections(concept_domains)
    sections += build_character_section()
    sections = apply_decision_notes(sections)
    generated = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    html_text = build_html(sections, deviations, comparison, coverage, generated)

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(html_text)

    totals = Counter()
    for section in sections:
        totals[section["action"]] += section["count"]
    print(f"Sections: {len(sections)}")
    for action in ACTION_ORDER:
        print(f"  {ACTION_LABEL[action]}: {totals[action]} items")
    print(f"\nReport: {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
