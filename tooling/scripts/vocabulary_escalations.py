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
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from vocabulary_text_policy import apply_text_policy  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
THO_DIR = PROJECT_ROOT / "tho-r5"
DEFAULT_OUT = PROJECT_ROOT / "v291-extracted" / "vocabulary-v2mgmt-items.md"


# --------------------------------------------------------------------------
# Evidence gathered from the corpus
# --------------------------------------------------------------------------
#
# Most register entries are authored prose. A few need a list of every affected
# table attached to them, and a hand-maintained list would drift the first time
# the corpus is re-extracted. Those are computed here instead, and an entry
# points at the function that computes its evidence through the `evidence` key.

# The band a truncated Value Set description falls in. Every one found sits
# between 242 and 252 characters, which is what identifies the cause as a length
# cap of about 250 characters rather than an authoring habit. The band is
# deliberately a little wider than the observed range so a description clipped a
# few characters either side is still caught.
#
# The band matters as much as the missing full stop does. Four other Value Set
# descriptions also end without terminal punctuation and none of them is
# truncated: 0424 and 0566 are short one-line descriptions, 0971's is the
# placeholder "tbd", and 0955's runs to 864 characters and ends in a URL.
TRUNCATION_BAND = (230, 260)


def _fold(text):
    """Reduce prose to a form in which two descriptions can be compared fairly.

    The Chapter 2C corpus has the shared text policy baked in and THO's text
    does not, so comparing raw would report our own normalization as a
    disagreement between the two bodies. Whitespace is folded for the same
    reason: THO keeps the two spaces after a period that the chapter's own
    publication produced.
    """
    normalized, _ = apply_text_policy("Description", text or "")
    return re.sub(r"\s+", " ", normalized).strip()


def truncated_value_set_descriptions():
    """Find every Value Set description that stops mid-word, and check THO.

    Returns:
        A list of dicts in table order, each with the table number and name,
        the incomplete description as published, its length, and what THO's
        corresponding ValueSet says -- which is the question of whether the
        full text can be recovered from somewhere that already has it.
    """
    low, high = TRUNCATION_BAND
    findings = []

    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        value_sets = record.get("valueSets") or []
        if not value_sets:
            continue
        description = (value_sets[0].get("Description") or "").strip()
        if not description:
            continue
        if description[-1] in '.!?)"”':
            continue
        if not low <= len(description) <= high:
            continue

        findings.append({
            "table": record["tableNumber"],
            "name": record.get("tableName", ""),
            "description": description,
            "length": len(description),
            **_tho_description_status(record["tableNumber"], description),
        })

    return findings


def _tho_description_status(table, description):
    """Say whether THO's ValueSet for a table carries the full description.

    Three outcomes matter, and they mean different things for recovery:
    `complete` means the missing text exists and can simply be taken; `same`
    means THO was populated from the identical truncated field and is not a
    recovery source; `absent` means there is nothing to compare against.
    """
    path = THO_DIR / f"ValueSet-v2-{table}.json"
    if not path.is_file():
        return {"tho": "absent",
                "thoNote": "THO has no ValueSet for this table."}

    tho_description = (json.loads(path.read_text()).get("description") or "").strip()
    if not tho_description:
        return {"tho": "absent",
                "thoNote": "THO's ValueSet carries no description."}

    folded_chapter = _fold(description)
    folded_tho = _fold(tho_description)

    if folded_tho == folded_chapter:
        return {"tho": "same",
                "thoNote": "Identical, truncated at the same point."}
    if folded_tho.startswith(folded_chapter):
        recovered = folded_tho[len(folded_chapter):]
        return {"tho": "complete",
                "thoNote": "THO carries the complete text.",
                "recovered": recovered}
    return {"tho": "differs",
            "thoNote": "THO's description differs from the chapter's by more "
                       "than the truncation, so it is not a straight recovery."}


def is_punctuation_code(code):
    """True where a code contains no letter and no digit anywhere.

    That is the whole test, and it is deliberately blunt. A code with letters
    in it is a code however much punctuation it also carries --
    `x-hl7-cda-level-one` and `Octet-stream` are ordinary. A code with none at
    all is a punctuation mark standing in for a concept, which is what needs
    looking at.
    """
    return bool(code.strip()) and not any(ch.isalnum() for ch in code)


def punctuation_codes():
    """Every concept whose code is nothing but punctuation, ours and THO's.

    Both sides are scanned because they disagree, and the disagreement is the
    interesting part. Chapter 2C has a handful; THO's v2 code systems have
    three times as many, including five tables that carry the three-character
    `...` and the single-character ellipsis as two separate concepts with the
    same meaning.

    Returns:
        A list of dicts in table order, each with the table, the code, its
        display text and which of the two sources it appears in.
    """
    chapter = {}
    names = {}

    for path in sorted(VOCAB_DIR.glob("*.json")):
        record = json.loads(path.read_text())
        table = record["tableNumber"]
        names[table] = record.get("tableName", "")
        for entry in record.get("codedContent") or []:
            code = entry.get("value") or ""
            if is_punctuation_code(code):
                chapter[(table, code)] = (entry.get("displayName") or "").strip()

    tho = _tho_punctuation_codes()

    findings = []
    for key in sorted(set(chapter) | set(tho)):
        table, code = key
        in_chapter, in_tho = key in chapter, key in tho
        findings.append({
            "table": table,
            "name": names.get(table, ""),
            "code": code,
            "display": chapter.get(key) or tho.get(key, ""),
            "source": ("both" if in_chapter and in_tho
                       else "chapter" if in_chapter else "tho"),
        })
    return findings


def _tho_punctuation_codes():
    """Punctuation-only codes in THO's own v2 CodeSystems, keyed by table."""
    found = {}
    if not THO_DIR.is_dir():
        return found

    for path in sorted(THO_DIR.glob("CodeSystem-v2-*.json")):
        try:
            resource = json.loads(path.read_text())
        except (json.JSONDecodeError, OSError):
            continue
        match = re.search(r"/CodeSystem/v2-(?:.*-)?(\d{4})$",
                          resource.get("url") or "")
        if not match:
            continue
        table = match.group(1)
        for concept in resource.get("concept", []):
            code = concept.get("code") or ""
            if is_punctuation_code(code):
                found[(table, code)] = (concept.get("display") or "").strip()
    return found


SOURCE_LABEL = {
    "both": "Chapter 2C and THO",
    "chapter": "Chapter 2C only",
    "tho": "THO only",
}


def punctuation_evidence():
    """Columns and rows for the punctuation-code table, for both renderers."""
    columns = ["Table", "Name", "Code", "Display", "Appears in"]
    rows = []
    for finding in punctuation_codes():
        rows.append([
            finding["table"],
            finding["name"],
            finding["code"],
            finding["display"] or "(none)",
            SOURCE_LABEL[finding["source"]],
        ])
    return columns, rows


def truncation_evidence():
    """Columns and rows for the truncated-description table, for both renderers."""
    columns = ["Table", "Name", "Chars", "Value Set description as published",
               "In THO"]
    rows = []
    for finding in truncated_value_set_descriptions():
        rows.append([
            finding["table"],
            finding["name"],
            str(finding["length"]),
            finding["description"],
            finding["thoNote"],
        ])
    return columns, rows


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
            "have, at least once, answered this question differently. "
            "<b>HL7's own errata guidance gives a usable test.</b> A technical "
            "correction is defined there as &ldquo;a non-controversial change "
            "that alters a document so that it says what the WG intended to "
            "say&rdquo;, typically repairing changes to normative content "
            "&ldquo;that were not made, were incorrectly made, or were "
            "inconsistently made during the editing process&rdquo;. That "
            "cleanly separates the items on this list into two kinds. The "
            "editing-process defects &mdash; table 0821's grid emptied in "
            "publication, table 0411's canonical printed for a resource that "
            "does not exist, the links to rendered pages where canonical URLs "
            "belong, the missing spaces after a period &mdash; are technical "
            "corrections on that definition. The content defects &mdash; "
            "0931's invalid UCUM code, 0560's time units &mdash; change what "
            "the standard <i>means</i>, and for normative content the same "
            "guidance requires any substantive change to be balloted.",
        "ask":
            "Decide the rule, not the instance. When Chapter 2C publishes "
            "something demonstrably wrong, does this IG (a) reproduce it and "
            "record the defect, (b) reproduce it but mark it deprecated or "
            "inactive, or (c) correct it and publish the correction with a "
            "note? The answer sets the default for every item below, and "
            "the current answer &mdash; (a) &mdash; is an assumption nobody "
            "has ratified. "
            "<b>A narrower question would unblock most of the list:</b> may "
            "this project treat the editing-process defects above as technical "
            "corrections, leaving only the substantive ones for a ballot? The "
            "guidance also notes that where there is doubt, a Work Group may "
            "ask the TSC to rule.",
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
            "values&rdquo;, and then lists five values. "
            "<b>There is a second, sharper problem.</b> Chapter 2C's code "
            "system block for 0560 is the <code>noObject</code> / "
            "<code>noDescription</code> placeholder &mdash; the chapter does "
            "not declare a code system for this table at all. THO nevertheless "
            "publishes both <code>CodeSystem/v2-0560</code> and "
            "<code>ValueSet/v2-0560</code>, and so does the UTG repository. So "
            "THO has minted a code system for a table whose source declares "
            "none. Of the tables this project treats as concept domain only, "
            "<b>0560 is the only one where THO carries resources</b>; 0910 "
            "carries the identical placeholder and THO has nothing for it, "
            "which is the treatment that looks correct.",
        "ask":
            "Is this table salvageable, or is it a concept domain with no "
            "usable code system? If it is to be fixed, the fix has to be "
            "coordinated with TSMG so Chapter 2C and THO move together. "
            "<b>This project's working decision changed on 2026-09-17 "
            "(ADR-0010): it now publishes both the CodeSystem and the "
            "ValueSet</b>, carrying the chapter's five codes. The earlier "
            "decision was concept domain only, and it was reversed because "
            "the <code>noObject</code> marker is contradicted by everything "
            "around it &mdash; the chapter's own five codes, the value set "
            "OID it prints, its <code>all codes</code> content logical "
            "definition, and THO's existing pair. Treating the marker as "
            "authoritative was losing published content <i>and</i> putting us "
            "in conflict with THO rather than agreement with it. "
            "<b>The naming problem this item is really about is untouched by "
            "that change</b>: four of the five codes are still units of time "
            "under a table called Quantity Units, in our output and in THO's "
            "alike. That still needs V2 Management and TSMG together, and "
            "<b>we are not proposing to alter THO's existing records "
            "unilaterally.</b> The contradiction is stated in the guide "
            "itself, on the General questions page, so a reader meets it "
            "rather than having to find this register.",
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
            "This is the cleanest test case in the corpus for "
            "reproduce-versus-correct, and the one to decide first: Chapter "
            "2C reproduces an error, THO corrected it and said so, and the "
            "two cannot both be followed. Which does this IG follow? And "
            "separately: "
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
            "<b>Cleared to correct.</b> Measured against HL7's errata "
            "guidance this is squarely a technical correction &mdash; a name "
            "inconsistently applied during editing, where fixing it makes the "
            "chapter say what was plainly intended. Set the Full Name to "
            "UCUM's own name in all six. "
            "<b>Note that this changes no generated resource.</b> UCUM is an "
            "external code system, so these six tables produce a ValueSet and "
            "no CodeSystem, and the ValueSet takes its name and description "
            "from the Value Set block rather than the Code System block. The "
            "correction is to the chapter, and to the report that mirrors it.",
    },
    {
        "id": "esc-full-name-copy-paste",
        "who": "V2 Management",
        "tables": "0001, 0125, 0180, 0203, 0458, 0820 and others",
        "title": "The copy-pasted Full Name is not confined to the UCUM tables",
        "body":
            "Checking the UCUM finding against the whole chapter turned up the "
            "same defect elsewhere. <b>412 of the 444 Code System "
            "Identification blocks follow the pattern <code>&lt;Table Name&gt; "
            "Code System</code> exactly</b>, which makes the exceptions easy "
            "to see. Some are legitimate &mdash; a table pointing at SNOMED CT "
            "or ISO 3166 should name that system, not itself. Others are the "
            "UCUM defect again, a name carried over from a different table: "
            "0001 <i>Administrative Sex</i> is named &ldquo;Jurisdiction "
            "Gender Code System&rdquo;, 0125 <i>Value Type</i> is &ldquo;Data "
            "Types&rdquo;, 0180 <i>Masterfile Action Code</i> is "
            "&ldquo;Record-level Event Code&rdquo;, 0203 <i>Identifier "
            "Type</i> is &ldquo;Practitioner ID Number Type&rdquo;, 0458 "
            "<i>OCE Edit Code</i> is &ldquo;Reimbursement Action Code&rdquo;, "
            "0820 <i>Gender Harmony Concepts</i> is &ldquo;Personal "
            "Pronouns&rdquo;. One more, 0232, begins with a stray hyphen: "
            "<code>- Insurance Company Contact Reason Code System</code>. "
            "Like the UCUM case, none of this reaches a generated resource; "
            "the emitted name and title come from the symbolic name.",
        "ask":
            "If the UCUM correction is approved as a technical correction, the "
            "same reasoning covers these. Someone who knows the tables needs "
            "to separate the genuine exceptions from the copy-paste errors "
            "&mdash; this project can produce the candidate list but cannot "
            "make that call.",
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
            "marker of the condition, not random noise. "
            "<b>The two tables have then been treated completely differently "
            "downstream, and that is the finding.</b> They present identically "
            "in the chapter: same placeholder block, same absence of a code "
            "system, both declaring a concept domain and a value set. "
            "<b>For 0910, THO has nothing</b> &mdash; no CodeSystem, no "
            "ValueSet, and neither does the UTG repository. The chapter "
            "declares no code system, so none was minted. That is the "
            "treatment that follows from the source. "
            "<b>For 0560, THO publishes both</b> "
            "<code>CodeSystem/v2-0560</code> and "
            "<code>ValueSet/v2-0560</code> at version 3.0.0, and so does UTG. "
            "The CodeSystem is <code>content: complete</code> and carries five "
            "concepts &mdash; <code>FL</code> Units, <code>DY</code> Days, "
            "<code>HS</code> Hours, <code>MN</code> Month, <code>YY</code> "
            "Years &mdash; under the title <i>Quantity Units</i> and the "
            "description &ldquo;HL7-defined code system of concepts specifying "
            "the adjustment quantity&rdquo;. Four of the five are units of "
            "time. So a code system was minted at an HL7 canonical for a table "
            "whose source declares none, and the content it was filled with is "
            "the same content flagged as wrong elsewhere on this list. "
            "<b>Since 2026-09-17 this project publishes both 0560 resources "
            "(ADR-0010) and still writes nothing for 0910.</b> The two are "
            "separated on evidence rather than by name: the placeholder is "
            "overridden only where the chapter lists codes under it, THO "
            "publishes a code system at the table's own canonical, and the "
            "chapter declares a value set. 0560 is the only table in the "
            "corpus that meets all three; 0910 meets none. The placeholders "
            "themselves remain a defect in the published chapter either way.",
        "ask":
            "Two questions, and the second is the one that needs both groups. "
            "First, should the placeholder blocks be removed from the "
            "published chapter, and should a table with no code system simply "
            "have no Code System Identification block? "
            "Second: <b>0560 and 0910 present identically in the chapter and "
            "have been handled in opposite ways downstream.</b> Either 0910 "
            "is missing resources or 0560 has resources it should never have "
            "had. This project now follows THO on both &mdash; publishing "
            "0560's pair and nothing for 0910 &mdash; which removes the "
            "divergence from published THO content but does not answer the "
            "question. Confirm whether that split is correct, or whether both "
            "tables should be treated the same way. <b>Nothing will be "
            "altered in THO's existing records on this project's "
            "initiative.</b>",
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
        "id": "esc-truncated-value-set-descriptions",
        "who": "V2 Management",
        "tables": "0038, 0170, 0227, 0254, 0315, 0326, 0335, 0389, 0392, "
                  "0406, 0508, 0510, 0511, 0513, 0520, 0544",
        "title": "Sixteen Value Set descriptions stop mid-word, all at about "
                 "250 characters",
        "body":
            "Found while checking a generated resource rather than by looking "
            "for it. Table 0227's value set description ends &ldquo;&hellip; "
            "the code system may be acce&rdquo;. Sweeping the corpus for the "
            "same shape found <b>sixteen Value Set descriptions that end "
            "without terminal punctuation, every one of them between 242 and "
            "252 characters long</b>. Nothing else in the chapter behaves this "
            "way: Code System descriptions run to 500 and 800 characters and "
            "end in complete sentences, and the same tables' own table-level "
            "descriptions are complete &mdash; 0227's runs to 582 characters "
            "and finishes cleanly. So this is not extraction loss and not an "
            "authoring habit; it is <b>a length cap of roughly 250 characters "
            "applied to one field</b> somewhere in the publication toolchain. "
            "<b>This one does reach the output.</b> Unlike the Full Name "
            "defects, the Value Set Description becomes "
            "<code>ValueSet.description</code>, so sixteen generated "
            "ValueSets currently carry a sentence that stops mid-word. "
            "<b>THO was checked as a recovery source and is not one.</b> All "
            "sixteen tables have a ValueSet in "
            "<code>hl7.terminology.r5</code>, all sixteen carry a description, "
            "and <b>fifteen of them are truncated at exactly the same "
            "point</b> &mdash; identical text once whitespace and this "
            "project's own text policy are normalized on both sides. So the "
            "defect did not originate in this extraction and it did not "
            "originate in the chapter's rendering: the same clipped field fed "
            "both documents, and the truncated text is already published in "
            "THO. "
            "<b>The single exception is table 0227, and it is the proof.</b> "
            "THO's <code>ValueSet/v2-0227</code> continues past the cut with "
            "171 more characters, completing the very word the chapter stops "
            "in the middle of &mdash; &ldquo;may be acce&rdquo; becomes "
            "&ldquo;may be accessed via&rdquo; followed by the PHIN VADS link "
            "for the MVX code system. One table's full text therefore survives "
            "somewhere, which is good evidence the other fifteen do too.",
        "ask":
            "<b>Recover the fifteen full descriptions from whatever source "
            "Chapter 2C is generated from</b> &mdash; most likely whoever "
            "maintains the chapter's underlying table content holds them "
            "intact, since the loss is at publication rather than at "
            "authoring. This project can detect the truncation but cannot "
            "reconstruct the text, and inventing an ending would be worse than "
            "publishing the fragment. "
            "On the errata guidance this is content lost during the editing "
            "process rather than a change of meaning, so <b>restoring it "
            "should qualify as a technical correction</b> and need no ballot. "
            "Two things follow that are worth deciding at the same time. "
            "0227's full text is available now from THO and can be restored "
            "immediately on the same reasoning; say whether to take it. And "
            "because the truncated text is already published in THO, the "
            "correction needs to be made in both places or the two will "
            "diverge. Every affected table is listed below with the text as it "
            "currently stands.",
        # Attached rather than authored: a hand-written list of sixteen tables
        # and their descriptions would drift the first time the corpus is
        # re-extracted. See `truncation_evidence`.
        "evidence": truncation_evidence,
    },
    {
        "id": "esc-punctuation-codes",
        "who": "V2 Management + TSMG",
        "tables": "0005, 0066, 0093, 0200, 0255, 0291, 0359, 0365, 0366, 0367, "
                  "0418, 0466, 0487, 0492, 0505, 0523, 0544",
        "title": "Twenty-three concepts have a code that is nothing but "
                 "punctuation",
        "body":
            "Noticed in table 0291, whose code system carries a concept whose "
            "code is a single ellipsis character. Sweeping both Chapter 2C and "
            "THO's v2 code systems for the same shape &mdash; a code with no "
            "letter and no digit anywhere in it &mdash; found <b>23 concepts "
            "across 17 tables</b>. They are not one problem but three, and "
            "only the first is defensible. "
            "<b>Four are genuine codes and should be left alone.</b> "
            "<code>*</code> in 0255 and 0505, <code>#</code> in 0505 and "
            "<code>%</code> in 0523 all carry real definitions &mdash; "
            "<i>Indicates a percent change</i>, <i>The first service request "
            "in a cyclic group</i>. A single-character symbol is an awkward "
            "code but it is a code, and all four are in both sources. "
            "<b>Eighteen are an ellipsis placeholder masquerading as a "
            "concept</b> &mdash; 13 written as three full stops and 5 as the "
            "single ellipsis character. Their display text gives them away: "
            "<i>No suggested "
            "values defined</i>, <i>user-defined codes</i>, <i>see chapter "
            "3</i>. These are rows that said &ldquo;nothing to see here&rdquo; "
            "in a printed table and were then loaded as though they were "
            "content. Nobody can send <code>...</code> in a message and mean "
            "anything by it. "
            "<b>Five tables carry the same placeholder twice.</b> 0291, 0365, "
            "0366, 0367 and 0418 each have <code>...</code> (three full stops) "
            "<i>and</i> <code>&hellip;</code> (one ellipsis character) as two "
            "separate concepts, with identical display text where they have "
            "any. That is one placeholder encoded two ways and minted as two "
            "codes. In 0418 the ellipsis concept has <b>no display text at "
            "all</b>. "
            "<b>This is overwhelmingly a THO problem rather than a chapter "
            "problem.</b> Sixteen of the 23 exist only in THO, six are in "
            "both, and one &mdash; 0093's <code>...</code> &mdash; is only in "
            "Chapter 2C. Every duplicate pair is THO-only. So the chapter has "
            "largely stopped publishing these and THO has gone on carrying "
            "them, which is the pattern this whole baseline exercise exists to "
            "correct. "
            "One further oddity: 0492's code is <code>??</code>, displayed "
            "<i>Inappropriate due to ...</i> &mdash; a display that is itself "
            "truncated, beside a code that looks like a data-entry artefact.",
        "ask":
            "<b>Review all 23 and say which are real.</b> The recommendation "
            "is: keep the four symbol codes; retire the ellipsis "
            "placeholders, which were never concepts; and for the five "
            "duplicate pairs retire at least the redundant spelling even if "
            "the placeholder itself is kept. "
            "Nothing is proposed for this release &mdash; the chapter is "
            "reproduced as published, so 0093's placeholder is currently "
            "emitted as a concept and the THO-only ones are untouched. But "
            "these codes are in published code systems today, so retiring them "
            "is a change to content in the field and needs a decision from the "
            "owners rather than from this project. Listed in full below.",
        "evidence": punctuation_evidence,
    },
    {
        "id": "esc-0954-0957-duplicate-of-v3",
        "who": "V2 Management",
        "tables": "0954, 0957",
        "title": "Tables 0954 and 0957 would have duplicated value sets "
                 "THO already publishes",
        "body":
            "Both tables name, in their own Value Set URI field, a value set "
            "THO already publishes under a v3 canonical: 0954 points at "
            "<code>ValueSet/v3-WorkScheduleODH</code> and 0957 at "
            "<code>ValueSet/v3-employmentStatusODH</code>, both active at "
            "3.0.0. This guide was nonetheless writing "
            "<code>ValueSet/v2-0954</code> and "
            "<code>ValueSet/v2-0957</code> as first publications. "
            "<b>Each carried the OID of the value set it duplicated.</b> "
            "0954's <code>2.16.840.1.113883.1.11.20561</code> is the "
            "identifier on <code>v3-WorkScheduleODH</code>, and 0957's "
            "<code>&hellip;20562</code> on "
            "<code>v3-employmentStatusODH</code> &mdash; so publishing "
            "either put one OID on two artifacts, the breach "
            "<code>esc-oid-conflicts</code> records elsewhere, in the one "
            "form this project could still prevent: by not creating the "
            "second artifact. "
            "<b>The two were not equally harmless.</b> 0957's compose was "
            "structurally identical to THO's &mdash; same <code>is-a "
            "_EmploymentStatus</code> filter, same exclude of the abstract "
            "grouper &mdash; so it duplicated an artifact without "
            "contradicting it. 0954's was not: the chapter's content "
            "logical definition omits the <i>Exclude codes where code = "
            "<code>_WorkSchedule</code></i> clause that THO's value set "
            "carries, so <code>v2-0954</code> would have been a second "
            "artifact on a live OID <i>and</i> disagreed with the first "
            "about whether an abstract grouper is in the value set. That "
            "divergence is the subject of "
            "<code>esc-0954-cld-exclude</code>, which this ruling makes "
            "moot here while leaving it standing against the chapter.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "This guide should not create value sets for 0954 or "
                      "0957. Correct value sets already exist in THO "
                      "&mdash; <code>v3-WorkScheduleODH</code> and "
                      "<code>v3-employmentStatusODH</code> &mdash; and "
                      "those are the ones to use.",
            "effect": "Both value sets are withheld through "
                      "<code>RULED_SUPPRESSIONS</code>, so two first "
                      "publications stop being written and two duplicate "
                      "OID assignments never reach the field. This follows "
                      "the precedent set for 0078 on 2026-10-14: where a "
                      "correct value set already exists under another "
                      "canonical, the guide lets it serve rather than "
                      "minting a v2 twin.",
        },
    },
    {
        "id": "esc-0895-wrong-system-url",
        "who": "V2 Management",
        "tables": "0895",
        "title": "THO's ValueSet/v2-0895 composes over the wrong code "
                 "system URL, and THO's own records say so",
        "body":
            "THO publishes <code>ValueSet/v2-0895</code> composing over "
            "<code>http://terminology.hl7.org/CodeSystem/v2-0895</code>, a "
            "canonical with no CodeSystem behind it. <b>The correct system "
            "URL is the CMS Present on Admission coding page</b>, "
            "<code>https://www.cms.gov/Medicare/Medicare-Fee-for-Service-"
            "Payment/HospitalAcqCond/Coding</code>, and THO's own records "
            "establish this without anything needing to be inferred: "
            "<code>NamingSystem/presentOnAdmission</code> carries that CMS "
            "URL as its <i>preferred</i> URI and lists the v2 canonical "
            "among its other identifiers, commented &ldquo;The v2 table of "
            "present on admission indicators&rdquo;. Both it and Chapter 2C "
            "carry the same OID, "
            "<code>2.16.840.1.113883.6.301.11</code>. "
            "<b>THO contradicts itself on this table.</b> It publishes "
            "<code>CodeSystem/presentOnAdmission</code> at the CMS URL, "
            "<code>content: complete</code> with five concepts &mdash; "
            "<code>Y</code>, <code>N</code>, <code>U</code>, <code>W</code> "
            "and <code>1</code> &mdash; and its own "
            "<code>ValueSet/POAIndicators</code> composes over that CMS "
            "URL. Only <code>ValueSet/v2-0895</code> points at the empty v2 "
            "canonical. "
            "<b>Two NamingSystems register the same OID, and the wrong one "
            "wins.</b> <code>NamingSystem/v2-0895</code> maps "
            "<code>&hellip;6.301.11</code> to the v2 canonical; "
            "<code>NamingSystem/presentOnAdmission</code> maps it to the "
            "CMS URL. This project's OID index loads NamingSystems in "
            "filename order and lets the last one win, so "
            "<code>v2-0895</code> overwrites <code>presentOnAdmission</code> "
            "and the OID resolves to the empty canonical. That is why the "
            "correct URL has to be stated by ruling rather than derived "
            "&mdash; the evidence is in THO, but not in the field the "
            "resolver reads. "
            "<b>This table is distinct from 0350, 0351 and 0456.</b> Those "
            "three are externally-owned NUBC systems under HL7-endorsed "
            "URIs with no content published anywhere, which is THO's "
            "documented convention and not a defect. 0895 has real content "
            "published at a real URL, and the v2 value set simply points "
            "somewhere else.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "THO's value set is wrong about the system URL. The "
                      "correct one is the CMS coding page, which the "
                      "external code systems page carries with the v2 code "
                      "system URL as an additional identifier and the same "
                      "OID as Chapter 2C. This IG fixes the THO artifact. "
                      "No CodeSystem is created, because THO's record is "
                      "already correct.",
            "effect": "0895 stops routing <code>needs-decision</code> and "
                      "now publishes <code>ValueSet/v2-0895</code> "
                      "composing over the CMS code system URL, through "
                      "<code>RULED_RECLASSIFICATIONS</code>. It had been "
                      "blocked for a reason the ruling dissolves: the "
                      "writer saw a table owning its own code system with "
                      "no codes listed, so it could not build a complete "
                      "CodeSystem. The code system is not ours and the "
                      "content already exists at CMS, so there was never a "
                      "CodeSystem to build. <b>This also corrects a claim "
                      "made to the reviewer on 2026-10-14</b>, that 0895 "
                      "needed nothing on the dangling-value-sets account "
                      "and remained blocked for an unrelated CLD reason. "
                      "The CLD is <i>all codes</i>, which this guide builds "
                      "routinely; the obstacle was the system URL all "
                      "along.",
        },
    },
    {
        "id": "esc-0719-superseded-by-v3",
        "who": "V2 Management",
        "tables": "0719",
        "title": "Table 0719's value set is superseded by a v3 one, and "
                 "this guide was republishing it as active",
        "body":
            "Chapter 2C gives table 0719's Value Set URI as "
            "<code>ValueSet-v3-ActInformationSensitivityPolicy.html</code> "
            "&mdash; a v3 value set, not a v2 canonical. "
            "<b>THO already publishes <code>ValueSet/v2-0719</code> with "
            "<code>status: retired</code>, and this guide was writing it "
            "back out as <code>active</code>.</b> It is the only artifact "
            "in the corpus where this guide's status disagreed with THO's. "
            "The cause is structural rather than specific to 0719: "
            "<code>status</code> sits in "
            "<code>COMPARED_VALUE_SET_FIELDS</code> and not in "
            "<code>FILLABLE_VALUE_SET_FIELDS</code>, so a difference "
            "against THO was reported and bumped the version &mdash; the "
            "4.0.0 increment names <code>status</code> among its triggers "
            "&mdash; but never filled. Everywhere else that is the right "
            "behaviour, because the chapter is the authority on content. "
            "For a retirement it is not, because retirement is a statement "
            "about the artifact rather than about its content. "
            "<b>The shared OID is not repairable and is recorded only so "
            "nobody re-opens it.</b> THO's retired "
            "<code>v2-0719</code> carries "
            "<code>2.16.840.1.113883.1.11.20428</code>, which is also the "
            "identifier on THO's "
            "<code>v3-InformationSensitivityPolicy</code> &mdash; the "
            "<i>parent</i> of the value set the chapter names. An "
            "identifier on a published artifact cannot be changed or "
            "removed under the THO versioning policy, and this one is on an "
            "artifact that is already retired. There is nothing to decide.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "The correct value set is "
                      "<code>v3-ActInformationSensitivityPolicy</code>. The "
                      "v2 value set stays retired, and the only thing to do "
                      "with it is update its text to point at the v3 one.",
            "effect": "<code>ValueSet/v2-0719</code> is now written "
                      "<code>retired</code>, which corrects a live defect "
                      "&mdash; the guide had been publishing it active "
                      "against THO's retired &mdash; and its description is "
                      "prefixed with a version-less link to "
                      "<code>v3-ActInformationSensitivityPolicy</code>. "
                      "This is the first use of "
                      "<code>RULED_SUPERSESSIONS</code> (ADR-0014). <b>The "
                      "OID collision recorded in "
                      "<code>esc-oid-conflicts</code> is moot for 0719</b>: "
                      "the identifier is on a published, retired artifact "
                      "and cannot be changed.",
        },
    },
    {
        "id": "esc-0952-0959-superseded-by-v3",
        "who": "V2 Management",
        "tables": "0952, 0959",
        "title": "Tables 0952 and 0959 duplicate v3 value sets that already "
                 "exist, and their OIDs say so",
        "body":
            "Both tables have a v2 value set published in THO &mdash; "
            "<code>ValueSet/v2-0952</code> and "
            "<code>ValueSet/v2-0959</code>, both active at 3.0.0 &mdash; "
            "and both carry the OID of a <i>different</i> THO value set. "
            "0952's <code>2.16.840.1.113883.1.11.10228</code> is the "
            "identifier on <code>v3-Confidentiality</code>, and 0959's "
            "<code>&hellip;20560</code> on "
            "<code>v3-WorkClassificationODH</code>. The v3 artifacts are "
            "the real ones; the v2 pair duplicates them. "
            "<b>0952's chapter entry is additionally malformed, and it is "
            "worth seeing exactly how.</b> Its <i>Code System</i> URI field "
            "contains "
            "<code>http://terminology.hl7.org/ValueSet-v2-0952.html</code> "
            "&mdash; a ValueSet page URL sitting where a code system "
            "canonical belongs. This guide produces correct output anyway, "
            "by falling back to the code system OID "
            "<code>2.16.840.1.113883.5.25</code>, which resolves through "
            "THO to <code>v3-Confidentiality</code>. So the right answer is "
            "reached despite the input, which is worth knowing because it "
            "means the defect is invisible in the output and would survive "
            "any check that only read what was published. "
            "<b>0959 does not have that defect</b> &mdash; its Code System "
            "URI is a proper code system page link. Its only problem is the "
            "duplication. "
            "<b>Neither can be suppressed.</b> Suppression works only "
            "before first publication: it stops an artifact being created. "
            "These two exist in THO already, so withholding them would not "
            "unpublish anything &mdash; it would only remove this guide's "
            "ability to say anything about them, leaving two live "
            "duplicates in the field with nothing pointing at the "
            "replacements.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "The v3 URI for the code system is correct and the v3 "
                      "resource should be used for the value set too. The "
                      "v2 value sets have to be kept, because they already "
                      "exist in THO, but they are to be retired with a note "
                      "at the top of the description naming the correct v3 "
                      "value set and linking to it &mdash; a link that will "
                      "keep resolving in future versions of THO, so not a "
                      "version-specific one.",
            "effect": "Both value sets are now written "
                      "<code>retired</code>, with the pointer note "
                      "prefixed to their descriptions, through "
                      "<code>RULED_SUPERSESSIONS</code> (ADR-0014). The "
                      "version-less requirement is an invariant of that "
                      "mechanism rather than a convention, enforced by a "
                      "test: a replacement URL containing a version segment "
                      "is refused.",
        },
    },
    {
        "id": "esc-served-by-existing-tho-value-sets",
        "who": "V2 Management",
        "tables": "0399, 0821, 0822, 0824, 0827, 0828, 0953",
        "title": "Seven tables are already served by a value set THO "
                 "publishes, and this guide was about to write a second one",
        "body":
            "Each of these seven tables names, in its own Value Set URI "
            "field or its content logical definition, a value set that "
            "already exists &mdash; and in six of the seven the "
            "identifier proves it rather than merely suggesting it. "
            "<b>The value set OID Chapter 2C prints for the table is the "
            "identifier on the THO artifact</b>: 0399's "
            "<code>2.16.840.1.113883.21.266</code> is on "
            "<code>ValueSet/v2-notAllCodes-0399</code>, 0821's "
            "<code>&hellip;4.642.3.3291</code> on "
            "<code>ValueSet/gender-identity</code>, 0822's "
            "<code>&hellip;4.642.3.3290</code> on "
            "<code>ValueSet/pronouns</code>, 0824's "
            "<code>&hellip;4.642.3.3289</code> on "
            "<code>ValueSet/recorded-sex-or-gender-type</code>, 0828's "
            "<code>&hellip;4.642.3.3181</code> on "
            "<code>ValueSet/sex-parameter-for-clinical-use</code>, and "
            "0953's <code>2.16.840.1.113883.1.11.20471</code> on "
            "<code>ValueSet/v3-SecurityControlObservationValue</code>. "
            "0827 is the one exception: its OID "
            "<code>2.16.840.1.113883.21.485</code> is on nothing in the "
            "snapshot, but its Value Set URI field names the jurisdiction "
            "value set outright. "
            "<b>None of the seven has a v2 artifact in THO to compete "
            "with</b>, so nothing has to be retired &mdash; the correct "
            "outcome is simply that this guide writes nothing and the "
            "existing value set serves. Each table's concept domain is "
            "unaffected and continues to be published in "
            "<code>CodeSystem/conceptdomains</code>. "
            "<b>Two of the seven were blocked for reasons the ruling "
            "dissolves rather than answers.</b> 0821 <i>Gender Identity</i> "
            "was blocked because its coded content grid is published blank "
            "(<code>esc-0821-blank-grid</code>); its content logical "
            "definition is &ldquo;as defined in the linked value set&rdquo;, "
            "and the linked value set carries the five codes the grid lost, "
            "so pointing at it is both what the chapter asks for and the "
            "repair. 0953 was blocked on which of its two declared code "
            "systems the value set draws from &mdash; a question that does "
            "not arise once the value set is THO's, which composes from "
            "five other value sets and needs nothing from this guide.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-05",
            "ruling": "For each of these tables the correct value set "
                      "already exists in THO and should be used. No new "
                      "value set and no code system is to be created. "
                      "There is nothing this guide is using them "
                      "<i>instead of</i>, so nothing needs to be retired "
                      "or pointed away from &mdash; the artifacts simply "
                      "are not written.",
            "effect": "All seven are withheld through "
                      "<code>RULED_SUPPRESSIONS</code>, each entry naming "
                      "the value set that serves the table. Seven tables "
                      "leave the needs-decision list without a single "
                      "artifact being published. "
                      "<b>A note on 0953, because the mistake is instructive.</b> "
                      "The ruling as first written named "
                      "<code>v3-WorkScheduleODH</code> for 0953. That is "
                      "table 0954's value set; 0953 is <i>Security Label "
                      "Handling Instructions</i> and its OID resolves to "
                      "<code>v3-SecurityControlObservationValue</code>. The "
                      "misattribution was caught before implementation and "
                      "confirmed with the reviewer. Its cause is worth "
                      "recording: in this guide's own table ledger the 0953 "
                      "entry sits between the 0952/0959 supersession note "
                      "and the 0954 ruling, with "
                      "<code>v3-WorkScheduleODH</code> about fifteen lines "
                      "from the 0953 anchor. Adjacent rulings about "
                      "different tables are easy to misread as being about "
                      "the table between them.",
        },
    },
    {
        "id": "esc-0820-gender-harmony-canonical",
        "who": "V2 Management",
        "tables": "0820",
        "title": "Table 0820's value set is real content, published at a "
                 "canonical built from the table number",
        "body":
            "<code>0820</code> <i>Gender Harmony Concepts</i> is the one "
            "table in this group that needs an artifact rather than a "
            "pointer. It enumerates three LOINC codes &mdash; "
            "<code>76691-5</code> Gender Identity, <code>76690-7</code> "
            "Sexual Orientation and <code>90778-2</code> Personal pronouns "
            "- Reported &mdash; and <b>THO publishes nothing for it</b>: "
            "no <code>ValueSet/v2-0820</code>, and nothing anywhere "
            "carrying its value set OID "
            "<code>2.16.840.1.113883.21.480</code>. So this is a genuine "
            "first publication. "
            "The question the ruling settles is not <i>whether</i> to "
            "publish but <i>where</i>. This guide had been writing it to "
            "<code>ValueSet/v2-0820</code>, a canonical constructed from "
            "the table number because nothing else was available. The "
            "codes are LOINC's, so no CodeSystem is involved either way. "
            "A related defect is recorded separately in "
            "<code>esc-full-name-copy-paste</code>: the chapter's Full "
            "Name for this table's code system reads &ldquo;Personal "
            "Pronouns Code System&rdquo;, copied from table 0822.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-05",
            "ruling": "Create the value set, with no code system, since "
                      "the codes are LOINC's. Publish it at "
                      "<code>http://terminology.hl7.org/ValueSet/"
                      "gender-harmony-attributes</code> and carry Chapter "
                      "2C's value set OID "
                      "<code>2.16.840.1.113883.21.480</code> on it.",
            "effect": "The value set moves off the table-number canonical "
                      "to <code>ValueSet/gender-harmony-attributes</code>, "
                      "keeping the chapter's OID and its three LOINC "
                      "codes. <code>vs-v2-0820.xml</code> is deleted and "
                      "<code>vs-gender-harmony-attributes.xml</code> "
                      "written in its place. Nothing in THO is displaced: "
                      "the new canonical is unoccupied in the 7.3.0 "
                      "snapshot, as is the OID.",
        },
    },
    {
        "id": "esc-0823-multi-system-compose",
        "who": "V2 Management",
        "tables": "0823",
        "title": "Table 0823's value set draws on three code systems, and "
                 "the chapter says which code comes from which",
        "body":
            "<code>0823</code> <i>Sexual Orientation</i> declares three "
            "code systems &mdash; SNOMED CT, FHIR "
            "<code>DataAbsentReason</code> and V3 <code>NullFlavor</code> "
            "&mdash; and prints five codes. This guide was emitting "
            "nothing, on the grounds that the chapter does not state which "
            "system each code belongs to. "
            "<b>That reading was wrong, and this item replaces it.</b> "
            "Drawing a value set from several code systems is ordinary "
            "FHIR and this guide builds multi-system composes elsewhere. "
            "Nor is the attribution actually missing: each of the five "
            "rows carries it in its own comment. Three SNOMED codes say "
            "&ldquo;the HL70396 code for this code is "
            "&lsquo;SCT&rsquo;&rdquo;; <code>asked-declined</code> says it "
            "is drawn from FHIR DataAbsentReason and names the canonical; "
            "<code>UNK</code> says it is drawn from V3 NullFlavor and "
            "names that canonical. The information the writer said was "
            "absent was in the grid it had already read. "
            "The sister item <code>esc-0823-not-in-tho</code> records the "
            "separate observation that THO publishes no "
            "<code>ValueSet/v2-0823</code>; that remains true, and is why "
            "this is a first publication.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-05",
            "ruling": "The content logical definition correctly pulls "
                      "codes from three code systems and this is fine. A "
                      "value set is not restricted to one code system.",
            "effect": "0823 stops routing <code>needs-decision</code> and "
                      "publishes <code>ValueSet/v2-0823</code> as a first "
                      "publication at 1.0.0, composing over all three "
                      "declared systems with each of the five codes placed "
                      "under the system its own comment names. No "
                      "CodeSystem is written: all three systems belong to "
                      "other authorities.",
        },
    },
    {
        "id": "esc-0467-oce-modifier-edit",
        "who": "V2 Management",
        "tables": "0467",
        "title": "Table 0467's code system is an OCE arc OID that THO does "
                 "not yet register",
        "body":
            "<code>0467</code> <i>Modifier Edit Code</i> declares the code "
            "system <code>cms-OCEModifierEditCode-cs</code> at "
            "<code>http://terminology.hl7.org/CodeSystem/v2-0467</code> "
            "with OID <code>2.16.840.1.113883.6.301.10</code>, publishes "
            "no codes, and gives its content logical definition as "
            "&ldquo;all codes&rdquo;. The writer reported it blocked "
            "because a table that owns its code system but lists no codes "
            "cannot yield a complete CodeSystem. "
            "<b>The table does not own that code system.</b> The OID sits "
            "in the same CMS Outpatient Code Editor arc as 0458's "
            "<code>&hellip;6.301.9</code>, and the codes are CMS's, "
            "published in the I/OCE specification rather than in Chapter "
            "2C. Neither OID resolves to a canonical in the THO 7.3.0 "
            "snapshot. The difference from 0458 and 0459 is that a Jira "
            "ticket has been raised to create the external code system "
            "record for this one, and it will carry the URL and OID "
            "Chapter 2C already prints &mdash; so the canonical this guide "
            "composes over is known in advance and will resolve once the "
            "record lands.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-05",
            "ruling": "A Jira ticket has been raised to create an "
                      "external code system record for this code system. "
                      "Its URL and OID will be the ones Chapter 2C "
                      "already lists. Publish the value set over that "
                      "canonical with a content logical definition of all "
                      "codes from the system.",
            "effect": "0467 stops routing <code>needs-decision</code> and "
                      "publishes <code>ValueSet/v2-0467</code> as a first "
                      "publication at 1.0.0, composing over all codes from "
                      "<code>CodeSystem/v2-0467</code>, with the "
                      "chapter's own description. <b>The reviewer offered "
                      "a fuller description</b> &mdash; &ldquo;The CMS I/OCE "
                      "edit codes reported against a HCPCS or CPT modifier "
                      "on a claim line, as listed in the <i>Modifier edit "
                      "return buffer</i> row of the Edit Return Buffer Table "
                      "in the I/OCE Specifications for the applicable "
                      "release&rdquo; &mdash; which is more informative than "
                      "the chapter's &ldquo;Value Set of codes that specify "
                      "the edits of the modifiers for each line or "
                      "HCPCS/CPT.&rdquo; <b>The chapter's text is kept for "
                      "now</b>, because this guide carries Chapter 2C's "
                      "descriptions as published and replacing one is a "
                      "deviation that needs its own decision. The offered "
                      "text is recorded here so adopting it is a one-line "
                      "change if that is wanted. <b>No CodeSystem is "
                      "written</b> &mdash; the content is CMS's. Until the THO record "
                      "is created the value set composes over a canonical "
                      "that does not yet resolve, which is a known and "
                      "accepted interim state rather than a defect.",
        },
    },
    {
        "id": "esc-0956-no-stable-home",
        "who": "V2 Management + TSMG",
        "tables": "0956",
        "title": "Table 0956's value set exists only in a withdrawn FHIR "
                 "draft and a code repository being decommissioned",
        "body":
            "<code>0956</code> <i>Job Supervisory Level or Pay Grade</i> "
            "declares the code system "
            "<code>PHOccupationalDataForHealthODH</code> and gives its "
            "content logical definition as &ldquo;unspecified&rdquo;, "
            "which is not a shape this guide can build. THO publishes no "
            "<code>ValueSet/v2-0956</code> and no obvious equivalent. "
            "<b>Two candidate value sets exist and neither is a durable "
            "home.</b> One is "
            "<code>valueset-supervisory-level-odh-us</code>, published in "
            "<b>FHIR 3.3 (2018May)</b> &mdash; a draft ballot snapshot, "
            "not a released FHIR version, and not a canonical anything "
            "should be bound to today. The other is a PHIN VADS value set "
            "at OID <code>2.16.840.1.114222.4.11.7613</code>; "
            "<b>PHIN VADS is being decommissioned by the CDC</b>, so "
            "everything hosted there is of uncertain future. "
            "Pointing this guide at either would be binding V2.9.1 content "
            "to a location that is known in advance to be going away. "
            "That is worse than publishing nothing, because a dead pointer "
            "in a published IG is harder to retract than an acknowledged "
            "gap.",
        "ask":
            "<b>Something needs to happen for 0956 and nobody yet knows "
            "what.</b> This item exists to keep that fact from being lost, "
            "which is the whole of its present purpose. "
            "The question for V2 Management and TSMG is where the "
            "supervisory level / pay grade codes should live once PHIN "
            "VADS is gone: a THO value set created for the purpose, an "
            "external code system record pointing at whatever the CDC "
            "designates as the successor, or a decision that the table is "
            "not viable and should become concept domain only. "
            "<b>In the meantime this guide publishes no CodeSystem and no "
            "ValueSet for 0956</b>, by decision rather than by omission. "
            "Its concept domain "
            "<code>JobSupervisoryLevelorPayGrade</code> is published in "
            "<code>CodeSystem/conceptdomains</code> and is unaffected, so "
            "a binding to the domain remains expressible while the "
            "terminology question is settled.",
    },
    {
        "id": "esc-0962-already-in-tho",
        "who": "V2 Management",
        "tables": "0962",
        "title": "Table 0962 resolved itself when a cached package appeared, "
                 "which is a reproducibility problem rather than a ruling",
        "body":
            "<code>0962</code> <i>Device Status</i> routes "
            "<code>needs-decision</code> because its code system block gives "
            "a FHIR core <i>page</i> URL, "
            "<code>http://hl7.org/fhir/codesystem-device-status.html</code>, "
            "and an OID <code>2.16.840.1.113883.4.642.1.200</code> that "
            "nothing in THO or FHIR core resolves. So the writer cannot say "
            "what the value set composes over and emits nothing. "
            "<b>THO nevertheless publishes "
            "<code>ValueSet/v2-0962</code></b>, active at 3.0.0, carrying "
            "this table's value set OID "
            "<code>2.16.840.1.113883.4.642.3.209</code> and composing over "
            "<code>http://hl7.org/fhir/device-status</code> &mdash; the real "
            "canonical the chapter's page link was pointing at. The artifact "
            "exists, it is correct, and nothing about it is in doubt. "
            "<b>There is a loose end in this repository because of it.</b> "
            "<code>vs-v2-0962.xml</code> is tracked and staged from an "
            "earlier run, when the table still routed to an artifact. It is "
            "byte-equivalent in substance to THO's. Nothing prunes it, "
            "because the prune deliberately removes only the exact paths of "
            "suppressed tables &mdash; a broader sweep would be wrong under "
            "<code>--table</code>. So the writer warns about it on every "
            "run, and it is the only artifact in the IG that no route "
            "accounts for.",
        "ask":
            "<b>The table is no longer blocked, and nobody decided that.</b> "
            "On 2026-11-05 it began routing <code>value-set-only</code> and "
            "publishing <code>ValueSet/v2-0962</code> &mdash; correctly: the "
            "output is identical to THO's, same compose over "
            "<code>http://hl7.org/fhir/device-status</code>, same value set "
            "OID, same version 3.0.0, and the orphan warning is gone. "
            "<b>What changed was the machine, not the chapter and not this "
            "repository.</b> <code>load_oid_index</code> reads the FHIR R5 "
            "core package out of <code>~/.fhir/packages</code> as well as "
            "the THO snapshot. That package was not present, so the OID "
            "resolved to nothing; the IG Publisher downloaded it during a "
            "build earlier the same day, and the next run of the writer "
            "resolved <code>2.16.840.1.113883.4.642.1.200</code> through "
            "<code>CodeSystem-device-status.json</code> &mdash; on an "
            "identifier FHIR itself marks <code>use: \"old\"</code>. "
            "<b>So no ruling is needed for 0962 itself.</b> The outcome is "
            "right and matches what the committee has said seven times "
            "this month about tables THO already serves. What needs "
            "attention is that <b>the corpus this guide generates depends "
            "on whether a package happens to be cached on the build "
            "machine</b>. A fresh checkout would have produced a different "
            "IG from this one, with a different table count and a "
            "<code>needs-decision</code> entry nobody could explain. "
            "<b>The question for the project, not the committee:</b> should "
            "the FHIR core package be pinned and vendored the way "
            "<code>tho-r5/</code> is, so the OID index is a declared input "
            "rather than a property of the machine? Everything else the "
            "writer reads is version-pinned and recorded in a report; this "
            "one is not, and it silently moved a table between routes.",
        "resolution": {
            "who": "This project",
            "forum": "Build reproducibility work, readiness item A3",
            "date": "2026-11-10",
            "ruling": "Yes. The FHIR core package is pinned and vendored. "
                      "It was never a question for a committee &mdash; the "
                      "ask said so &mdash; and it is recorded here because "
                      "the finding was raised here.",
            "effect": "The 448 <code>CodeSystem-*.json</code> files of "
                      "<code>hl7.fhir.r5.core#5.0.0</code> are vendored in "
                      "<code>fhir-r5-core/</code> with the package manifest "
                      "beside them, and <code>code_system_directories</code> "
                      "reads that copy instead of "
                      "<code>~/.fhir/packages</code>. There is deliberately "
                      "<b>no fallback</b> to the cache: a fallback would "
                      "restore the same silent drift the first time the "
                      "vendored copy went missing. The package name, "
                      "version and date now appear as <code>fhirCore</code> "
                      "in <code>tho-fill-report.json</code>, so a change of "
                      "input shows up as a change in the report rather than "
                      "as an unexplained change in the corpus. Five tests "
                      "hold it: that the vendored copy is read, that the "
                      "publisher's cache is not, that THO still outranks it, "
                      "that the version is recorded, and that a missing copy "
                      "is reported rather than assumed. Verified neutral "
                      "&mdash; all 821 XML files are byte-identical across "
                      "the change, and <code>0962</code> keeps publishing "
                      "<code>ValueSet/v2-0962</code>, now because a pinned "
                      "input says so rather than because a build happened to "
                      "download something.",
        },
    },
    {
        "id": "esc-gp2-oce-siblings",
        "who": "Financial Management WG",
        "tables": "0466, 0468, 0469, 0470",
        "title": "Four more GP2 tables look like CMS I/OCE content and are "
                 "published as though HL7 owned them",
        "body":
            "Between 2026-11-05 and 2026-11-06 four tables in the GP1/GP2 "
            "pair were realigned as CMS Integrated Outpatient Code Editor "
            "content: <code>0458</code>, <code>0459</code>, "
            "<code>0460</code> and <code>0467</code>. Each now publishes a "
            "value set over an external code system record CMS owns, and "
            "<code>0460</code> stopped minting a v2 CodeSystem it never "
            "should have had. "
            "<b>A sweep of the corpus for I/OCE and APC references found "
            "four more tables in the same segment that were not part of "
            "that batch</b>, all stewarded by FM, all "
            "<code>Type: User</code>, all with <code>all codes</code> "
            "content logical definitions over canonicals this guide or UTG "
            "constructed: "
            "<code>0466</code> <i>Ambulatory Payment Classification Code</i> "
            "(GP2-7), <code>0468</code> <i>Payment Adjustment Code</i> "
            "(GP2-9), <code>0469</code> <i>Packaging Status Code</i> "
            "(GP2-10) and <code>0470</code> <i>Reimbursement Type Code</i> "
            "(GP2-12). "
            "<b>The evidence is not equally strong across the four.</b> "
            "<code>0468</code>'s own code displays name I/OCE return-buffer "
            "concepts &mdash; &ldquo;payment adjustment applies to APC "
            "(status indicator G)&rdquo;, &ldquo;(status indicator H)&rdquo;, "
            "&ldquo;(status indicator J)&rdquo;, and &ldquo;specific list of "
            "HCPCS codes&rdquo;. <code>0470</code>'s codes are APC payment "
            "categories outright: <code>OPPS</code>, <code>Pckg</code>, "
            "<code>Lab</code>, <code>Thrpy</code>, <code>Mamm</code>, "
            "<code>PartH</code>. <code>0466</code> is APC by name and its "
            "description says &ldquo;the derived Ambulatory Payment "
            "Classification (APC) code&rdquo;. <code>0469</code> is the "
            "weakest: the inference is field adjacency rather than content, "
            "and nothing in its own text names CMS or the I/OCE. "
            "<b>For comparison, the precedent that makes this worth "
            "asking:</b> <code>0460</code>'s code system description had "
            "said the codes specify &ldquo;the OCE status of the line "
            "item&rdquo; all along, and the table was still being published "
            "with a freshly minted HL7 canonical. The same mistake, if it is "
            "one, would not announce itself in these four either.",
        "ask":
            "<b>This is a question for the Financial Management Work Group</b>, "
            "which stewards both this vocabulary and the GP1/GP2 segments "
            "that use it, rather than for V2 Management. "
            "For each of the four: are the codes CMS's, published in the "
            "I/OCE specification, in the way 0458, 0459, 0460 and 0467's "
            "are? If so each needs an external code system record in THO "
            "and a value set composing over it, and this guide should stop "
            "publishing a CodeSystem for it &mdash; the same treatment the "
            "other four just received. If the codes are genuinely HL7's, "
            "nothing changes and this item closes with that on the record. "
            "<b>Nothing is being changed for these four in the meantime.</b> "
            "They continue to publish a CodeSystem and a ValueSet at their "
            "existing canonicals exactly as before, so no answer is urgent "
            "and no artifact is at risk while the question is open.",
    },
    {
        "id": "esc-0460-oce-realignment",
        "who": "V2 Management",
        "tables": "0460",
        "title": "Table 0460's codes are CMS I/OCE content, and this guide "
                 "was minting an HL7 code system for them",
        "body":
            "<code>0460</code> <i>Denial or Rejection Code</i> was the "
            "<b>last table in the corpus for which this guide minted a "
            "brand-new CodeSystem canonical</b>. The chapter names a code "
            "system, <code>denialOrRejectionType</code>, and gives an OID "
            "but no URI, so the writer fell back to constructing "
            "<code>CodeSystem/v2-0460</code> and publishing the chapter's "
            "three codes under it as HL7 content. "
            "<b>The evidence that they are not HL7's was in the chapter the "
            "whole time.</b> Its own code system description reads "
            "&ldquo;Code system of concepts specifying the <b>OCE status of "
            "the line item</b>. Used in HL7 Version 2.x messaging in the "
            "GP2 segment.&rdquo; The codes are the CMS Integrated "
            "Outpatient Code Editor's Line-item Denial or Rejection Flag, "
            "published in the I/OCE specification with each quarterly "
            "release. The table sits at GP2-5, among the I/OCE siblings "
            "0458, 0459 and 0467. "
            "This is the same shape as <code>esc-0895-wrong-system-url</code> "
            "and the 0458/0459 pair: a code system belonging to another "
            "authority, reached through an identifier the chapter printed "
            "without a URL, and a fallback that quietly asserted HL7 "
            "ownership instead of reporting that it could not tell.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-06",
            "ruling": "Align 0460 with the other I/OCE tables. The codes "
                      "are CMS's Line-item Denial or Rejection Flag. The "
                      "external metadata record URL is "
                      "<code>CodeSystem/oce-denial-or-rejection-flag</code>. "
                      "Publish the value set over that canonical with the "
                      "supplied description, and stop minting a v2 "
                      "CodeSystem.",
            "effect": "<code>CodeSystem/v2-0460</code> is withdrawn and its "
                      "file pruned, so <b>this guide now mints no CodeSystem "
                      "canonical anywhere in the corpus</b>. "
                      "<code>ValueSet/v2-0460</code> is rewritten to compose "
                      "over the CMS canonical, carrying the description "
                      "supplied with the ruling. The chapter's three codes "
                      "&mdash; 0, 1 and 2 &mdash; are no longer published as "
                      "HL7 concepts. "
                      "Like 0458 and 0459, the canonical does not resolve "
                      "until THO creates the record, which is waived in a "
                      "test that must be deleted when it lands. "
                      "This answers the 0460 half of "
                      "<code>esc-0460-user-defined-mint</code>; the "
                      "principle that item asks about is untouched and "
                      "stays open against 0093.",
        },
    },
    {
        "id": "esc-0960-duplicate-of-fhir-core",
        "who": "V2 Management",
        "tables": "0960",
        "title": "Table 0960 would have duplicated the FHIR core "
                 "data-absent-reason value set",
        "body":
            "Chapter 2C gives table 0960's Value Set URI as "
            "<code>http://hl7.org/fhir/ValueSet/data-absent-reason</code> "
            "&mdash; FHIR core's own value set, not a v2 canonical. This "
            "guide was nonetheless writing "
            "<code>ValueSet/v2-0960</code> as a first publication at 1.0.0, "
            "composing over "
            "<code>CodeSystem/data-absent-reason</code>: the same code "
            "system the core value set draws on, at a canonical the chapter "
            "never asks for. "
            "<b>Unlike 0954 and 0957 there is no identifier collision "
            "forcing the issue</b> &mdash; nothing in the THO snapshot "
            "carries 0960's value set OID "
            "<code>2.16.840.1.113883.4.642.3.5</code>. The reason not to "
            "publish is simply that the chapter names the right value set "
            "and a second one would compete with it.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "This guide should not create a value set for 0960. "
                      "Chapter 2C says the correct value set is FHIR core's "
                      "<code>data-absent-reason</code>, and that is "
                      "correct.",
            "effect": "<code>ValueSet/v2-0960</code> is withheld through "
                      "<code>RULED_SUPPRESSIONS</code>. Nothing else "
                      "changes: the concept domain is unaffected and the "
                      "chapter's own pointer to the core value set now "
                      "stands unopposed.",
        },
    },
    {
        "id": "esc-0954-cld-exclude",
        "who": "V2 Management + TSMG",
        "tables": "0954, 0957",
        "title": "Table 0954's logical definition would include an abstract "
                 "concept THO's equivalent excludes",
        "body":
            "Both tables define their value set as a subtree of "
            "<code>v3-ObservationValue</code>. 0957 <i>Employment Status</i> "
            "says it in two clauses &mdash; <i>Include codes &hellip; where "
            "concept is-a <code>_EmploymentStatus</code></i>, then <i>Exclude "
            "codes where code = <code>_EmploymentStatus</code></i>. That "
            "second clause matters: in FHIR, an <code>is-a</code> filter "
            "includes the concept it is rooted at, and "
            "<code>_EmploymentStatus</code> is an abstract grouper that should "
            "never be sent in a message. The exclusion is what makes the value "
            "set mean &ldquo;the actual statuses&rdquo;. "
            "<b>0954 <i>Work Schedule</i> has the include clause and no "
            "exclude clause</b>, so read literally its value set contains the "
            "abstract <code>_WorkSchedule</code> grouper. "
            "THO's own <code>ValueSet/v3-WorkScheduleODH</code> "
            "<b>does</b> exclude it, and is otherwise identical to 0957's "
            "shape. So either the chapter dropped a clause from 0954, or the "
            "two tables genuinely differ &mdash; and nothing in the text says "
            "which. This project builds what the chapter says, so <b>the "
            "generated <code>ValueSet/v2-0954</code> currently has no "
            "exclude</b> and differs from THO on exactly this point. "
            "<b>There is a second line of defence, and it is the reason this "
            "is worth stating carefully rather than simply fixing.</b> Both "
            "groupers carry <code>notSelectable = true</code> as a concept "
            "property in THO's <code>CodeSystem/v3-ObservationValue</code> "
            "&mdash; verified on both <code>_WorkSchedule</code> and "
            "<code>_EmploymentStatus</code>. A terminology server that honours "
            "that property will keep the abstract concept out of the expansion "
            "whether or not the value set excludes it, which makes the exclude "
            "clause <i>optional</i> rather than load-bearing. But "
            "<code>notSelectable</code> is an advisory property, and honouring "
            "it in expansion is a matter of server implementation rather than "
            "something the value set can require. An explicit exclude does not "
            "depend on any server behaviour; relying on the property does.",
        "ask":
            "Confirm that 0954 is missing an <i>Exclude codes where code = "
            "<code>_WorkSchedule</code></i> clause, in which case it is a "
            "technical correction and one line to apply. If the omission is "
            "deliberate, say so, because the value set then diverges from "
            "THO's and somebody will raise it again. "
            "The recommendation is to add it regardless of the "
            "<code>notSelectable</code> safety net: the clause costs nothing, "
            "it makes 0954 consistent with its sibling 0957 and with THO, and "
            "it removes a dependency on how a given expansion engine treats an "
            "advisory property.",
    },
    {
        "id": "esc-domain-example-codes",
        "who": "V2 Management",
        "tables": "0093, 0340, 0451",
        "title": "Where should a concept domain&rsquo;s example codes live?",
        "body":
            "These three tables are declared <i>Concept Domain Only</i> and yet "
            "each publishes a small set of codes &mdash; three, two and one "
            "respectively. That is not a contradiction: the V3 requirements "
            "for declaring a concept domain <b>call for example codes</b>, so "
            "the tables are conforming. It does leave the codes with nowhere "
            "obvious to go. A concept domain is not a code system, so the "
            "examples cannot be concepts; and a domain is bound with an "
            "extension on the binding rather than through a value set, so "
            "there is no value set to put them in either. "
            "<b>No CodeSystem and no ValueSet is minted for any of the three</b>, "
            "and nothing in THO or UTG carries one today, so nothing has to be "
            "unpicked whichever way this goes.",
        "ask":
            "The likely representation is a <b>concept property on the "
            "concept in the concept domain code system</b>, carrying the "
            "example codes. Confirm that shape, or name another. Until it is "
            "decided the example codes are extracted and held but not "
            "published anywhere.",
    },
    {
        "id": "esc-tables-that-should-be-domains",
        "who": "V2 Management",
        "tables": "9999",
        "title": "Table 9999 is a placeholder occupying a table number",
        "body":
            "<b>This item covered three tables. 0010 and 0188 have both "
            "since been withdrawn &mdash; see "
            "<code>esc-0010-withdrawn</code> and "
            "<code>esc-0188-withdrawn</code> &mdash; leaving only 9999. "
            "What follows is the original finding, which measured all three "
            "together.</b> "
            "Of the 799 sections in Chapter 2C, exactly three declare no "
            "concept domain, no code system, no value set and no codes. "
            "<code>0010</code> <i>Physician ID</i> and <code>0188</code> "
            "<i>Operator ID</i> are User tables whose descriptions end "
            "&ldquo;No suggested values&rdquo; &mdash; they are site-defined "
            "identifiers, and were arguably never code tables. "
            "<b>One measurement turns that judgement into a fact.</b> Of the "
            "799 sections only <b>three</b> carry no concept domain block at "
            "all, and of the <b>149</b> tables whose description says "
            "&ldquo;No suggested values&rdquo;, <b>147 carry one</b>. The two "
            "that do not are 0010 and 0188. The chapter supplies a concept "
            "domain for every peer of these two and omitted it for exactly "
            "these two, so the omission is an outlier rather than the house "
            "style for site-defined identifiers. "
            "<code>9999</code> <i>Placeholder Table Representation</i> is not "
            "a table at all: it carries the literal placeholder strings "
            "<code>noObject</code> and <code>noDescription</code>, the same "
            "markers that appear in the two concept-domain-only tables. "
            "<b>Checked against both THO and the UTG repository: there is no "
            "CodeSystem and no ValueSet for any of the three.</b> Nothing has "
            "been minted for them and nothing needs to be withdrawn.",
        "ask":
            "Nothing. Answered &mdash; see the resolution below.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-15",
            "ruling": "Do not put 9999 in this IG at all.",
            "effect": "9999 is excluded at the corpus boundary through "
                      "<code>EXCLUDED_SECTIONS</code>, so it reaches no "
                      "page rather than being routed "
                      "<code>nothing-to-write</code> and mentioned on "
                      "several. <b>It had been reaching the published IG "
                      "three times over</b> &mdash; the table index, the "
                      "ledger and the open-items register &mdash; because "
                      "the writer reported it as a table with nothing to "
                      "write rather than as something that is not a table. "
                      "Excluding it at the boundary is what makes the "
                      "ruling hold for pages added later. "
                      "<b>The condition the ruling depended on was checked "
                      "first.</b> Nothing in the V2.9.1 standard binds to "
                      "9999: a scan of every <code>tableBinding</code> in "
                      "the extracted segments and data types found 1,187 "
                      "bound fields across 731 distinct tables and no "
                      "reference to it. The same scan finds 7 bindings to "
                      "withdrawn table 0010 and 1 to 0188, so it does "
                      "detect bindings to dead tables where they exist. "
                      "The placeholder remains a defect in the published "
                      "chapter, which is a matter for Chapter 2C rather "
                      "than for this guide.",
        },
    },
    {
        "id": "esc-0010-withdrawn",
        "who": "V2 Management",
        "tables": "0010",
        "title": "Table 0010 <i>Physician ID</i> carries no terminology and "
                 "is withdrawn",
        "body":
            "Table 0010 is one of three sections in Chapter 2C that declare "
            "no concept domain, no code system, no value set and no codes. "
            "It is a <code>User</code> table whose description ends "
            "&ldquo;No suggested values&rdquo; &mdash; a site-defined "
            "identifier that was arguably never a code table. "
            "The omission is an outlier rather than house style: of the 149 "
            "tables whose description says &ldquo;No suggested values&rdquo;, "
            "<b>147 carry a concept domain block</b>. The two that do not "
            "are 0010 and 0188. "
            "Neither THO nor the UTG repository has a CodeSystem or a "
            "ValueSet for it, so nothing was ever minted and nothing needs "
            "withdrawing from THO. "
            "<b>What it does have is bindings.</b> Fields across several "
            "segments &mdash; PV1, IN3, SCD and others &mdash; still name "
            "table 0010 in the source of truth, and those bindings point at "
            "a table that is about to stop existing.",
        "ask":
            "Answered. Kept because the binding removal is work this "
            "project has to do, and the ruling is the authority for doing "
            "it.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-09",
            "ruling": "Table 10 goes away, and any terminology bindings to "
                      "table 10 will be removed as v2+ is prepared.",
            "effect": "Nothing changes in the vocabulary IG: this guide "
                      "already writes no artifact for 0010 and routes it "
                      "<code>nothing-to-write</code>, so there is nothing to "
                      "suppress and no artifact to withdraw. "
                      "<b>The work the ruling creates is in the v2+ IG, not "
                      "here</b> &mdash; removing the bindings that name "
                      "table 0010 in <code>input/sourceOfTruth/segment/</code> "
                      "and the segment intros that document them. That is "
                      "the structural workstream's to do, and it is recorded "
                      "here because this register is where the ruling "
                      "arrived. "
                      "The companion finding for <b>0188</b>, the only other "
                      "table of this shape, is <b>not</b> answered by this "
                      "ruling and stays open as "
                      "<code>esc-tables-that-should-be-domains</code>.",
        },
    },
    {
        "id": "esc-0188-withdrawn",
        "who": "V2 Management",
        "tables": "0188",
        "title": "Table 0188 <i>Operator ID</i> carries no terminology and "
                 "is withdrawn",
        "body":
            "The companion of <code>esc-0010-withdrawn</code>, and ruled on "
            "the same way. 0188 is one of three sections in Chapter 2C that "
            "declare no concept domain, no code system, no value set and no "
            "codes. It is a <code>User</code> table whose description ends "
            "&ldquo;No suggested values&rdquo; &mdash; a site-defined "
            "identifier that was arguably never a code table. "
            "The omission is an outlier rather than house style: of the 149 "
            "tables whose description says &ldquo;No suggested values&rdquo;, "
            "<b>147 carry a concept domain block</b>. The two that do not "
            "are 0010 and 0188. "
            "Neither THO nor the UTG repository has a CodeSystem or a "
            "ValueSet for it, so nothing was ever minted and nothing needs "
            "withdrawing from THO. "
            "<b>As with 0010, what it does have is bindings</b> that name "
            "the table in the source of truth and will point at a table "
            "that no longer exists.",
        "ask":
            "Answered. Kept because the binding removal is work this "
            "project has to do, and the ruling is the authority for doing "
            "it.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "Same situation as table 0010: the table goes away, "
                      "and terminology bindings to it are removed as v2+ is "
                      "prepared.",
            "effect": "Nothing changes in the vocabulary IG. This guide "
                      "already writes no artifact for 0188 and routes it "
                      "<code>nothing-to-write</code>, so there is nothing to "
                      "suppress and no artifact to withdraw. "
                      "<b>The work is in the v2+ IG</b>, removing the "
                      "bindings that name table 0188, and belongs to the "
                      "structural workstream exactly as 0010's does. "
                      "<code>esc-tables-that-should-be-domains</code> now "
                      "covers only 9999, which was never a table and is not "
                      "answered by either ruling.",
        },
    },
    {
        "id": "esc-0292-cdo-contradiction",
        "who": "V2 Management",
        "tables": "0292",
        "title": "Table 0292 <i>Vaccines Administered</i> is flagged concept "
                 "domain only and names a code system in the same section",
        "body":
            "The concept domain block sets <code>Concept Domain Only: "
            "yes</code>. The table metadata grid a few lines further down "
            "gives <code>Full Name: Vaccines Administered Code System</code> "
            "and <code>URI: http://hl7.org/fhir/sid/cvx</code>. Both are in "
            "the published section and they cannot both be acted on: a "
            "concept domain has no code system and no value set, and a table "
            "that prints a code system canonical is not a concept domain. "
            "<b>Four independent signals say the grid is right and the flag "
            "is wrong</b> &mdash; and that the code system belongs to the "
            "CDC rather than to HL7. "
            "<b>One:</b> THO publishes <code>ValueSet/v2-0292</code>, "
            "<code>status: active</code>, and its entire compose is a single "
            "bare include of <code>http://hl7.org/fhir/sid/cvx</code> &mdash; "
            "exactly the canonical the chapter prints. "
            "<b>Two:</b> <code>NamingSystem/CVX</code> registers table 0292's "
            "own table OID, <code>2.16.840.1.113883.12.292</code>, against "
            "that URI, and calls the URI the &ldquo;official canonical URL "
            "going forward&rdquo;. THO's own registry ties the table OID and "
            "the CDC code system together. "
            "<b>Three: the sibling table is answered the other way.</b> "
            "<code>0227</code> <i>Manufacturers of Vaccines (MVX)</i> is the "
            "other half of the same CDC vaccine pair &mdash; same steward "
            "(OO), the same PHIN VADS prose in its description, the same "
            "<code>Full Name</code>-plus-<code>URI</code> shape in its table "
            "grid &mdash; and it is flagged <code>Concept Domain Only: "
            "no</code>. It is published, as a value set over "
            "<code>http://hl7.org/fhir/sid/mvx</code> resolved through "
            "<code>NamingSystem/MVX</code>, which is ADR-0008 D8. Two halves "
            "of one pair should not be classified differently. (The chapter "
            "also types 0227 <i>Imported</i> and 0292 <i>External</i>, which "
            "is a further inconsistency between them rather than a reason "
            "for the difference.) "
            "<b>Four:</b> of the 14 tables Chapter 2C types "
            "<code>External</code>, <b>not one</b> resolves to a code system "
            "of its own. Setting 0292 aside, six are concept domain only, "
            "three cannot be settled mechanically, and every one of the four "
            "this guide writes a resource for &mdash; 0820, 0952, 0955, 0958 "
            "&mdash; is value set only over somebody else's system. 0292 "
            "fits that shape exactly.",
        "ask":
            "Confirm that 0292 should be routed <b>value set only</b>, its "
            "value set composing over <code>http://hl7.org/fhir/sid/cvx</code>, "
            "consistent with 0227 and with the external-code-system rule in "
            "ADR-0008 Batch A &mdash; and that the <code>Concept Domain Only: "
            "yes</code> flag is the error. "
            "<b>Minting a <code>CodeSystem/v2-0292</code> would be the wrong "
            "answer</b>, and it is worth saying so explicitly because it is "
            "the shape most of the corpus takes. The chapter publishes zero "
            "codes for this table, so there would be nothing to put in it; "
            "THO deliberately carries no CodeSystem for CVX, only the "
            "NamingSystem; and a <code>v2-0292</code> code system would claim "
            "the table OID that <code>NamingSystem/CVX</code> has already "
            "bound to the CDC's URI. "
            "<b>This guide tentatively publishes 0292 as a real table</b> on "
            "that reading rather than writing nothing for it, because writing "
            "nothing discards the one thing the chapter states unambiguously: "
            "which code system the table draws on. It is flagged in the guide "
            "as needing attention, so the tentative reading is visible rather "
            "than silent, and it is reverted if the ruling goes the other "
            "way.",
    },
    {
        "id": "esc-0567-0568-deprecation",
        "who": "V2 Management + TSMG",
        "tables": "0567, 0568",
        "title": "Chapter 2C deprecates tables 0567 and 0568 &mdash; does "
                 "anything in THO get deprecated with them?",
        "body":
            "Both table descriptions say so outright: <i>&ldquo;Note this "
            "table has been deprecated and is replacaced by table "
            "0929&rdquo;</i> for Weight Units, and the same sentence naming "
            "0930 for Volume Units. (The misspelling is the chapter's.) "
            "But the deprecation was recorded in prose only, and nothing "
            "downstream reflects it. "
            "<b>The value sets were not deprecated.</b> THO publishes "
            "<code>ValueSet/v2-0567</code> and <code>ValueSet/v2-0568</code> "
            "as live resources alongside <code>v2-0929</code> and "
            "<code>v2-0930</code>, none of them carrying a deprecation "
            "marker, and this project reproduces all four. So a consumer "
            "reading THO cannot tell that two of the four are superseded. "
            "<b>The chapter contradicts itself on identity.</b> Table 0567 "
            "prints its own value set URI as "
            "<code>http://terminology.hl7.org/ValueSet/v2-0929</code> and "
            "0568 prints <code>&hellip;/v2-0930</code> &mdash; the "
            "replacement's canonical, not its own. Under the rule that a "
            "canonical URL is an identifier and THO's existing one wins, "
            "this project publishes them at <code>v2-0567</code> and "
            "<code>v2-0568</code>, which is why no collision occurred. Had "
            "the chapter's printed URI been honoured, two pairs of resources "
            "would have claimed the same canonical. "
            "<b>Separately, the contents do not match the description.</b> "
            "0568's concept domain is &ldquo;the domain of possible values of "
            "units of measure that are used to specify volume&rdquo; and its "
            "code system is UCUM, but it enumerates three codes; 0567 "
            "enumerates four. These are a small subset of the UCUM units for "
            "the quantity, so the CLD and the description promise a great "
            "deal more than the value set delivers.",
        "ask":
            "Two questions, and the first is the one that needs a group "
            "rather than an individual. <b>(1)</b> Chapter 2C deprecated "
            "these tables; does a concomitant deprecation need to be "
            "reflected in THO &mdash; marking <code>ValueSet/v2-0567</code> "
            "and <code>v2-0568</code> deprecated or retired &mdash; or does "
            "the chapter's prose deprecation stop at the chapter? This "
            "project currently publishes both as live, which is fidelity to "
            "THO and arguably not fidelity to the chapter. <b>(2)</b> Is the "
            "enumerated subset intended, or should these value sets be an "
            "intensional reference to the UCUM units for the quantity? "
            "Note that whichever way (2) goes, it applies equally to the "
            "replacements 0929 and 0930.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-09-23",
            "ruling": "Tables 0567 and 0568 should never have been created. "
                      "Their value sets will be retired, but not by this IG "
                      "and not as part of this load: a separate Jira ticket "
                      "will be raised against THO to retire "
                      "<code>ValueSet/v2-0567</code> and "
                      "<code>ValueSet/v2-0568</code>. This IG is to do "
                      "nothing with them.",
            "effect": "This guide stops publishing both value sets. It had "
                      "been publishing them at 4.0.0 against THO's 3.0.0 "
                      "&mdash; an increment earned only by adding display "
                      "text to codes THO leaves bare &mdash; so the guide was "
                      "minting a new version of two artifacts it has now been "
                      "told to leave alone. Suppression is recorded in "
                      "<code>write_utg_xml.py</code>'s "
                      "<code>RULED_SUPPRESSIONS</code> and the two tables are "
                      "reported as <code>suppressed-by-ruling</code>, so the "
                      "guide says why they are absent rather than being "
                      "silently short of two artifacts. "
                      "<b>Question (2) of the ask is not answered and "
                      "survives this ruling:</b> whether the enumerated "
                      "subset is intended, or whether these should be an "
                      "intensional reference to the UCUM units for the "
                      "quantity. It applies to the live replacements 0929 and "
                      "0930, which this guide does publish &mdash; carrying "
                      "byte-identical code lists to the two tables being "
                      "retired. It is now asked against those two tables as "
                      "its own item.",
        },
    },
    {
        "id": "esc-0567-0568-representation",
        "who": "TSMG",
        "tables": "0005, 0567, 0568, 0929, 0930",
        "title": "Deprecating a V2 value set in THO has no established "
                 "representation, and would be a first",
        "body":
            "The item above asks whether THO should deprecate the two tables "
            "Chapter 2C deprecates. This one is about what that would "
            "actually require, because the mechanism is not sitting there "
            "ready to be used. "
            "<b>There is no CodeSystem to mark.</b> None of the four tables "
            "in this family &mdash; 0567 and 0568 and their replacements 0929 "
            "and 0930 &mdash; has a CodeSystem in THO or here. All four are "
            "value sets enumerating a handful of codes from UCUM, which "
            "belongs to somebody else. So <code>ValueSet.status</code> is the "
            "only status the artifact has, and FHIR's "
            "<code>PublicationStatus</code> offers exactly <code>draft</code>, "
            "<code>active</code>, <code>retired</code> and "
            "<code>unknown</code>. There is no <code>deprecated</code> in it. "
            "<code>retired</code> is available but says something stronger "
            "and different: the codes in these value sets are valid UCUM "
            "units and are still sent. "
            "<b>THO's one artifact-level mechanism has never carried this "
            "value.</b> The <code>structuredefinition-standards-status</code> "
            "extension appears <b>53 times</b> in the snapshot, on 53 "
            "different resources, and every single one of them says "
            "<code>trial-use</code>. The <code>deprecated</code> code is "
            "defined in <code>CodeSystem/standards-status</code> and is "
            "perfectly bindable &mdash; it has simply never been used. So the "
            "representation that matches the facts here &mdash; "
            "<code>standards-status = deprecated</code> with "
            "<code>.status</code> left <code>active</code>, because the codes "
            "remain valid &mdash; would be the <b>first use of that code in "
            "THO's history</b>. That is a precedent, not a data entry. "
            "<b>A successor pointer needs a third element again.</b> R5's "
            "ValueSet has no <code>replacedBy</code>. The available shape is "
            "<code>relatedArtifact</code> with <code>type = successor</code> "
            "aimed at <code>v2-0929</code> and <code>v2-0930</code>, and "
            "nothing in the snapshot does that for a v2 value set either. "
            "<b>Worth recording: the replacement-canonical confusion is "
            "inside THO as well, not only in the chapter.</b> The item above "
            "notes that Chapter 2C prints the replacement's canonical as "
            "0567's own URI. THO's <code>CodeSystem/v2-tables</code> does the "
            "same thing: entry <code>0567</code> carries "
            "<code>v2-vs-uri</code> = "
            "<code>http://terminology.hl7.org/ValueSet/v2-0929</code> and "
            "entry <code>0568</code> carries <code>&hellip;/v2-0930</code>, "
            "while both also carry the comment &ldquo;replaced by 0929&rdquo; "
            "and &ldquo;replaced by 0930&rdquo;. The index knows the tables "
            "were replaced and has overwritten their identity with their "
            "replacements' instead of recording the relationship. The value "
            "set OIDs are shared outright: "
            "<code>2.16.840.1.113883.21.452</code> is the identifier on both "
            "<code>ValueSet/v2-0567</code> and <code>ValueSet/v2-0929</code>, "
            "and <code>&hellip;21.453</code> on both <code>v2-0568</code> and "
            "<code>v2-0930</code> &mdash; two more instances of one OID on "
            "two artifacts.",
        "ask":
            "Settle the representation before the instance, because either "
            "answer sets a precedent. If a deprecated V2 table's value set is "
            "to be marked in THO, confirm the shape: "
            "<code>standards-status = deprecated</code> on the artifact, "
            "<code>ValueSet.status</code> left <code>active</code>, and "
            "<code>relatedArtifact</code> <code>type = successor</code> "
            "pointing at the replacement. If that is not the intended use of "
            "the extension, say what is &mdash; because at present there is "
            "no way to say &ldquo;deprecated&rdquo; about a THO value set "
            "that anything has ever done. "
            "<b>A sibling question of the same shape, which THO has already "
            "half-answered against itself.</b> "
            "<code>CodeSystem/v2-0005</code> is <code>retired</code> and all "
            "five of its concepts carry <code>status: deprecated</code>, "
            "while <code>ValueSet/v2-0005</code> is <code>active</code>. Does "
            "retiring a v2 code system oblige any action on the value set "
            "published at the matching canonical? Note that the two are not "
            "the same content: the value set does not compose from the "
            "retired code system at all &mdash; its single include is six CDC "
            "race codes from "
            "<code>urn:oid:2.16.840.1.113883.6.238</code> &mdash; so a second "
            "question comes with it, whether a value set named "
            "<code>v2-0005</code> that contains none of table 0005's codes is "
            "correctly named. Both are about THO's own records rather than "
            "about anything this guide writes, which is why they are parked "
            "here rather than acted on.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-09-23",
            "ruling": "Both halves are settled, and neither lands on this "
                      "IG. The 0567/0568 retirement goes to THO as a separate "
                      "Jira ticket, so no deprecation needs representing "
                      "here. For table 0005, the value set stays and the code "
                      "system is correctly retired already; this IG will not "
                      "link the value set and should not inform any change to "
                      "it.",
            "effect": "Nothing is published differently on account of 0005 "
                      "&mdash; the guide was already neither altering nor "
                      "linking <code>ValueSet/v2-0005</code>. What changes is "
                      "that this is now a decision rather than an omission. "
                      "The representation question the item was really about "
                      "&mdash; whether marking a THO value set deprecated "
                      "would need "
                      "<code>standards-status = deprecated</code>, the first "
                      "use of that code in THO's history, plus a "
                      "<code>relatedArtifact</code> successor pointer "
                      "&mdash; is <b>not answered, only avoided</b>. The "
                      "Jira ticket that retires 0567 and 0568 will meet it "
                      "again, because <code>retired</code> still says "
                      "something stronger than the facts: the UCUM codes in "
                      "those value sets remain valid and are still sent. "
                      "<b>Recorded here because the next person to need it "
                      "should not have to rediscover it.</b> So are the two "
                      "findings about THO's own records that no ruling "
                      "touched: <code>CodeSystem/v2-tables</code> carries the "
                      "replacements' canonicals as 0567's and 0568's own "
                      "<code>v2-vs-uri</code>, and the value set OIDs "
                      "<code>&hellip;21.452</code> and "
                      "<code>&hellip;21.453</code> each sit on two artifacts "
                      "at once.",
        },
    },
    {
        "id": "esc-0929-0930-enumerated-subset",
        "who": "V2 Management",
        "tables": "0929, 0930",
        "title": "Do the UCUM weight and volume value sets mean the handful "
                 "of codes they list, or the UCUM units for the quantity?",
        "body":
            "This is the half of the 0567/0568 question that the "
            "2026-09-23 ruling did not reach. That ruling retires 0567 and "
            "0568, which removes them from this guide &mdash; but it leaves "
            "the same question standing against their live replacements, "
            "which this guide does publish. "
            "<b>The replacements carry byte-identical code lists to the "
            "tables being retired.</b> 0929 enumerates the same four codes as "
            "0567 &mdash; <code>[lb_av]</code>, <code>[oz_av]</code>, "
            "<code>kg</code>, <code>g</code> &mdash; and 0930 the same three "
            "as 0568: <code>l</code>, <code>[pt_us]</code>, "
            "<code>ml</code>. So retiring the old pair does not retire the "
            "question; it moves it. "
            "<b>The description promises more than the value set "
            "delivers.</b> 0930's concept domain is &ldquo;the domain of "
            "possible values of units of measure that are used to specify "
            "volume&rdquo; and its code system is UCUM, which has a great "
            "many volume units. Three are enumerated. A sender needing "
            "centilitres, fluid ounces or cubic centimetres finds them "
            "absent from a value set whose description says it covers the "
            "quantity. "
            "Whether that is a deliberate interoperability constraint &mdash; "
            "a short list implementers can actually support &mdash; or an "
            "accident of how the table was first populated is not something "
            "this project can determine from the chapter.",
        "ask":
            "Is the enumerated subset intended, or should these value sets "
            "be an intensional reference to the UCUM units for the quantity? "
            "If the short list is deliberate, the descriptions should say so, "
            "because as written they describe the whole quantity. If it is "
            "not, these are two value sets that need rebuilding and the "
            "replacement tables inherited the defect they were meant to "
            "replace.",
    },
    {
        "id": "esc-0823-not-in-tho",
        "who": "V2 Management + TSMG",
        "tables": "0823",
        "title": "Table 0823 <i>Sexual Orientation</i> draws on three code "
                 "systems and has no value set in THO",
        "body":
            "The table is <code>Type: HL7-EXT</code>, stewarded by PA, and "
            "declares three code systems &mdash; SNOMED CT, "
            "<code>DataAbsentReason</code> and <code>NullFlavor</code>. "
            "Drawing a value set from three code systems is perfectly normal, "
            "and the table does print its five codes. <b>What is missing is "
            "the value set itself: THO publishes no "
            "<code>ValueSet/v2-0823</code>.</b> The writer cannot proceed "
            "because the chapter does not state which of the three declared "
            "systems each code belongs to, so it emits nothing. "
            "The pattern is worth noting: this is the sister table to "
            "<code>0821</code> <i>Gender Identity</i>, built the same way and "
            "recorded above for having its grid emptied in publication. Both "
            "are Gender Harmony Project material. The plausible reading is "
            "that both were entered into Chapter 2C in anticipation of a V2 "
            "implementation that was subsequently not carried through &mdash; "
            "which would explain why one lost its codes and the other never "
            "got a value set in THO.",
        "ask":
            "Confirm whether tables 0821 and 0823 are live commitments or "
            "abandoned ones. If live, the per-code system assignments are "
            "needed before a value set can be generated, and a "
            "<code>ValueSet/v2-0823</code> needs to exist in THO. If they "
            "were dropped, say so and this project will record them as "
            "published-but-unimplemented rather than as blockers.",
    },
    {
        "id": "esc-0459-unresolvable-oid",
        "who": "V2 Management + TSMG",
        "tables": "0458, 0459",
        "title": "Tables 0458 and 0459 name a CMS code system by an OID "
                 "that THO does not yet register",
        "body":
            "<code>0458</code> <i>OCE Edit Code</i> and <code>0459</code> "
            "<i>Reimbursement Action Code</i> both declare the code system "
            "<code>cms-OCEEditCode-cs</code>, identified solely by OID "
            "<code>2.16.840.1.113883.6.301.9</code> with no URI. 0459 is an "
            "External table stewarded by FM and prints four codes; 0458 "
            "prints none. "
            "<b>Neither THO nor the FHIR core packages resolve that OID to a "
            "canonical URL</b>, so there is no way to say what code system "
            "the four codes belong to. The writer therefore emits nothing "
            "for either table &mdash; not a CodeSystem, not a ValueSet. "
            "Note the reviewer's separate reading that this table may be "
            "better modelled as a concept domain, which would dissolve the "
            "question rather than answer it.",
        "ask":
            "<b>Partly answered, and still open.</b> The reviewer confirmed "
            "on 2026-11-05 that the codes come from the CMS Integrated "
            "Outpatient Code Editor specification &mdash; for 0459, Table 7 "
            "row 13 of the I/OCE specification &mdash; and that a request "
            "has been made for THO to create an external code system record "
            "for it. <b>Until that record exists there is no canonical to "
            "compose over</b>, so both tables are held: no CodeSystem, no "
            "ValueSet, concept domain only. Both concept domains "
            "(<code>OceEditCode</code>, <code>ReimbursementActionCode</code>) "
            "are published and unaffected. "
            "What remains open is the THO record itself. Once it exists, the "
            "canonical URL it carries goes straight into both tables' "
            "content logical definitions and this item closes. "
            "<b>Nothing is to be extracted from the I/OCE specification "
            "PDF</b>; the canonical from the THO record is the only thing "
            "needed. "
            "Note that sibling table 0467 is in the same OCE arc and has "
            "<i>already</i> had its Jira ticket raised, so it is being "
            "published now &mdash; see "
            "<code>esc-0467-oce-modifier-edit</code>. The difference "
            "between them is the state of the THO request, not the shape of "
            "the problem.",
        "resolution": {
            "who": "V2 Management",
            "forum": "Written review",
            "date": "2026-11-06",
            "ruling": "The codes for both tables come from the CMS "
                      "Integrated Outpatient Code Editor specification, "
                      "which CMS defines and maintains. Jira tickets have "
                      "been raised to create external code system records "
                      "in THO: <code>CodeSystem/oce-edit-codes</code> for "
                      "0458, and "
                      "<code>CodeSystem/oce-reimbursement-action-codes</code> "
                      "for 0459. Publish a value set for each over its "
                      "canonical, with the supplied description. Create no "
                      "CodeSystem for either, and extract nothing from the "
                      "I/OCE specification PDF &mdash; the canonical from "
                      "the THO record is all that is needed.",
            "effect": "Both tables stop routing "
                      "<code>needs-decision</code> and publish "
                      "<code>ValueSet/v2-0458</code> and "
                      "<code>ValueSet/v2-0459</code> as first publications "
                      "at 1.0.0, each composing over all codes from its own "
                      "external canonical. Both carry a description "
                      "supplied with the ruling rather than the chapter's, "
                      "naming the I/OCE table the codes come from &mdash; a "
                      "stated deviation from fidelity, because a value set "
                      "that enumerates nothing has only its description to "
                      "tell a reader what is in it. "
                      "<b>Both compose over canonicals that do not resolve "
                      "yet</b>, which is recorded on each entry and waived "
                      "in a test that has to be deleted when the THO "
                      "records land. The four codes Chapter 2C lists for "
                      "0459 are not written into the compose: 'all codes' "
                      "of an external system is the whole system.",
        },
    },
    {
        "id": "esc-0460-user-defined-mint",
        "who": "V2 Management",
        "tables": "0093",
        "title": "What should a user-defined table produce? Three of them "
                 "were treated three different ways",
        "body":
            "<code>0460</code> <i>Denial or Rejection Code</i> and "
            "<code>0411</code> <i>Supplemental Service Information Values</i> "
            "are the <b>only two tables in the whole chapter</b> for which "
            "this project mints a new CodeSystem canonical &mdash; every "
            "other code-bearing table either reuses a THO canonical or draws "
            "on another authority's code system. Both are <code>Type: "
            "User</code>. A user-defined table is by definition a set of "
            "suggested values that an implementation is expected to replace, "
            "so minting <code>CodeSystem/v2-0460</code> publishes suggestions "
            "with the authority of a standard code system. "
            "<b>The chapter is not consistent about this.</b> Compare "
            "<code>0093</code> <i>Release Information</i>, also <code>Type: "
            "User</code>, which is declared concept-domain-only and so "
            "produces no code system and no value set at all &mdash; even "
            "though it lists <code>Y</code> and <code>N</code> in its grid. "
            "Three user tables, three outcomes: 0460 and 0411 get minted "
            "resources, 0093 gets nothing. Nothing in the chapter explains "
            "the difference. "
            "0411 additionally has the defect already recorded above &mdash; "
            "the chapter prints a canonical for a resource that does not "
            "exist &mdash; and is a mess independent of this question.",
        "ask":
            "<b>Both of the minted canonicals this item was about are "
            "gone, and the question underneath them is still open.</b> "
            "0411 was ruled concept-domain-only in October "
            "(<code>esc-0411-concept-domain-only</code>). 0460 was "
            "realigned in November as CMS I/OCE content "
            "(<code>esc-0460-oce-realignment</code>), which withdrew its "
            "minted CodeSystem for a reason specific to that table rather "
            "than as an answer to this one. <b>This guide now mints no "
            "CodeSystem canonical anywhere in the corpus.</b> "
            "What remains unanswered is the principle, and "
            "<code>0093</code> <i>Release Information</i> is where it "
            "still bites: a <code>Type: User</code> table, declared "
            "concept-domain-only, listing <code>Y</code> and <code>N</code> "
            "in a grid that reaches no artifact. "
            "Decide what a user-defined table should produce &mdash; a "
            "CodeSystem and ValueSet like any other, a concept domain "
            "only, or a ValueSet whose codes are marked as examples "
            "&mdash; so that the next such table is handled by a rule "
            "rather than case by case. The answer no longer changes any "
            "published artifact; it decides what happens to 0093's codes "
            "and sets the precedent.",
    },
    {
        "id": "esc-0411-concept-domain-only",
        "who": "V2 Management",
        "tables": "0411",
        "title": "Table 0411 <i>Supplemental Service Information Values</i> "
                 "is concept domain only",
        "body":
            "Split from <code>esc-0460-user-defined-mint</code>, which asks "
            "what a user-defined table should produce across three tables; "
            "0411 has been answered and 0460 and 0093 have not. "
            "0411 was one of only <b>two</b> tables in the whole chapter for "
            "which this guide minted a new CodeSystem canonical &mdash; "
            "every other code-bearing table either reuses a THO canonical or "
            "draws on another authority's code system. THO has no CodeSystem "
            "and no ValueSet for it, so both resources were first "
            "publications. "
            "The table is <code>Type: User</code> and lists two codes, "
            "<code>NDBS</code> and <code>CG</code>. It also carries the "
            "defect recorded under "
            "<code>esc-retain-known-errors</code>: the chapter prints a "
            "canonical for a code system resource that does not exist.",
        "ask":
            "Answered. Kept because the two codes the chapter publishes stop "
            "appearing anywhere as a result, which a reader of the chapter "
            "may come looking for.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "Table 0411 should be concept domain only, so no code "
                      "system and no value set.",
            "effect": "Both <code>CodeSystem/v2-0411</code> and "
                      "<code>ValueSet/v2-0411</code> are withheld. This "
                      "removes one of the two minted canonicals, and with it "
                      "the defect that the chapter prints a canonical for a "
                      "resource that does not exist &mdash; it now does not "
                      "exist here either, deliberately. "
                      "<b>The chapter's two codes, <code>NDBS</code> and "
                      "<code>CG</code>, are no longer published as "
                      "concepts anywhere.</b> That is what the ruling asks "
                      "for and it is worth stating plainly, because it is "
                      "content the chapter prints and this guide now does "
                      "not. The concept domain is unaffected. "
                      "<b>0460 and 0093 are not answered by this ruling</b> "
                      "and stay open on "
                      "<code>esc-0460-user-defined-mint</code>. The original "
                      "finding asked for the three to be treated alike; this "
                      "ruling moves 0411 to the same outcome as 0093, which "
                      "leaves <b>0460 as the only minted canonical in the "
                      "corpus</b> and makes it more of an outlier than it "
                      "was, not less.",
        },
    },
    {
        "id": "esc-0725-missing-uri",
        "who": "V2 Management",
        "tables": "0725",
        "title": "Table 0725 <i>Mood Codes</i> omits the URI of the v3 code "
                 "system it draws from",
        "body":
            "The table's code system block gives a symbolic name "
            "<code>actMood</code>, a description of <code>tbd</code>, and OID "
            "<code>2.16.840.1.113883.5.1001</code> &mdash; and <b>no URI "
            "field at all</b>. The codes are v3 ActMood codes, not v2 codes; "
            "THO's own <code>ValueSet/v2-0725</code> draws them from "
            "<code>http://terminology.hl7.org/CodeSystem/v3-ActMood</code>. "
            "<b>The output is already correct</b>, because the OID the "
            "chapter does print resolves through THO to exactly that URL, so "
            "the writer emits a value set only and points it at the v3 code "
            "system. Recorded because the defect is in the published chapter "
            "and will mislead anyone reading it directly: a reader sees a "
            "code system with no URI and a description of <code>tbd</code>, "
            "with nothing to indicate the codes are v3. It also means the "
            "correct result here depends entirely on OID resolution "
            "succeeding.",
        "ask":
            "Confirm this as a technical correction under the "
            "editing-process test &mdash; add the URI "
            "<code>http://terminology.hl7.org/CodeSystem/v3-ActMood</code> "
            "and replace the <code>tbd</code> description. Nothing in the "
            "generated output changes.",
    },
    {
        "id": "esc-0340-code-grid-misuse",
        "who": "V2 Management",
        "tables": "0340",
        "title": "Table 0340's code grid lists code systems, not codes",
        "body":
            "<code>0340</code> <i>Procedure Code Modifier</i> is declared "
            "concept-domain-only, so this project writes nothing for it and "
            "nothing is blocked. But its code grid is not empty: it holds two "
            "rows, <code>CPTM</code> &ldquo;CPT Modifier Code&rdquo; and "
            "<code>HPC</code> &ldquo;CMS (formerly HCFA) Procedure Codes "
            "(HCPCS)&rdquo;, both with long comments citing the publishing "
            "body. <b>These are identifiers of external code systems, not "
            "concepts in a code system of the table's own.</b> The chapter is "
            "using the code grid for two incompatible purposes without "
            "distinguishing them, which is a trap for anyone generating "
            "resources from it mechanically &mdash; a naive reading mints a "
            "code system whose concepts are the names of other code systems. "
            "If the intent is that a procedure code modifier is drawn from "
            "CPT or HCPCS, those are external code systems that may warrant "
            "external code system records in THO.",
        "ask":
            "Confirm that 0340 is correctly concept-domain-only and that the "
            "two rows are documentation of candidate external code systems "
            "rather than codes. If they are meant to be usable, they need to "
            "be expressed as external code system references rather than as "
            "grid rows.",
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
    {
        "id": "esc-tho-dangling-value-sets",
        "who": "TSMG / UTG",
        "tables": "0456, 0895",
        "title": "Withdrawn &mdash; the &ldquo;dangling&rdquo; value sets "
                 "are not dangling",
        "body":
            "<b>This finding was wrong and is withdrawn. It is kept rather "
            "than deleted because it was circulated, and because the "
            "mistake is one anybody re-deriving it would make again.</b> "
            "It reported that four THO value sets &mdash; "
            "<code>v2-0350</code>, <code>v2-0351</code>, "
            "<code>v2-0456</code>, <code>v2-0895</code> &mdash; compose "
            "over <code>CodeSystem/v2-NNNN</code> canonicals that THO does "
            "not publish, so that an expansion has nothing to draw from. "
            "The second half of that is false. "
            "<b>A canonical under "
            "<code>http://terminology.hl7.org/CodeSystem/</code> does not "
            "have to have a CodeSystem resource behind it.</b> THO mints "
            "endorsed URIs for code systems whose content belongs to "
            "somebody else and registers them as NamingSystems with a "
            "<code>responsible</code> party, publishing no content at all. "
            "Its <i>external code systems</i> page lists them; all four of "
            "these appear there as NUBC systems, with dashes in both the "
            "Fragment and Complete Code System columns. "
            "<code>NamingSystem/v2-0350</code> carries "
            "<code>responsible: NUBC</code> and the same URI the value set "
            "composes over. <b>All four value sets compose over exactly the "
            "right identity.</b> "
            "Testing the whole snapshot again with the correct rule "
            "&mdash; a compose target resolves if THO publishes a "
            "CodeSystem at it <i>or</i> registers it as an external code "
            "system &mdash; leaves <b>one</b> unresolvable target in every "
            "v2 value set THO publishes: "
            "<code>ValueSet/v2-0962</code> composing over "
            "<code>http://hl7.org/fhir/device-status</code>, a FHIR core "
            "canonical rather than a THO one, which is the known outlier "
            "TSMG has already discussed. "
            "<b>How the error happened, since it is reproducible.</b> The "
            "comparison asked whether a <code>CodeSystem-*.json</code> "
            "existed at the compose target and treated absence as a "
            "defect. That is the right test for an HL7-owned code system "
            "and the wrong one for an externally-owned system under an "
            "HL7-endorsed URI, and nothing in the value set distinguishes "
            "the two &mdash; the distinction lives in the NamingSystem.",
        "ask":
            "Nothing. Withdrawn. <b>0350 and 0351 were split out of this "
            "item before it was withdrawn and remain genuinely answered "
            "&mdash; see <code>esc-0350-0351-not-domain-only</code>.</b> "
            "That ruling stands on its own evidence: THO's "
            "<code>v2-tables</code> types both <code>Externally "
            "defined</code>, which is what makes the chapter's "
            "concept-domain-only flag the error. Only the belief that "
            "their CLDs needed repairing came from this finding, and it "
            "did not survive. <b>0456 and 0895 need nothing on this "
            "account.</b> 0895 remains on the needs-decision list for an "
            "unrelated reason &mdash; its Content Logical Definition is "
            "not one of the shapes this guide builds.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "The current content logical definitions are right. "
                      "THO does publish the URIs of these external code "
                      "systems as "
                      "<code>http://terminology.hl7.org/CodeSystem/v2-0350</code> "
                      "and <code>&hellip;/v2-0351</code>, per its external "
                      "code systems page.",
            "effect": "Nothing is published differently and nothing needed "
                      "repairing. What changes is the record: this finding "
                      "claimed four unexpandable value sets and there are "
                      "none. The writer's "
                      "<code>RULED_RECLASSIFICATIONS</code> entries for "
                      "0350 and 0351 carried an <code>unresolved</code> "
                      "note warning that the two value sets could not "
                      "expand, printed on every run; that note is removed, "
                      "and the field is kept for a case that genuinely has "
                      "one.",
        },
    },
    {
        "id": "esc-0350-0351-not-domain-only",
        "who": "V2 Management",
        "tables": "0350, 0351",
        "title": "Tables 0350 and 0351 are not concept domain only",
        "body":
            "Split from <code>esc-tho-dangling-value-sets</code>, which has "
            "since been withdrawn as a mistaken finding &mdash; see below. "
            "<b>The chapter and THO disagree about what these tables "
            "are.</b> Chapter 2C flags both <code>Concept Domain Only: "
            "yes</code> and prints no code system block, no value set block "
            "and no codes. THO's own <code>CodeSystem/v2-tables</code> types "
            "both <code>Externally defined</code> and records a code system "
            "OID, a value set OID and a content-logical-definition flag for "
            "each &mdash; none of which a concept-domain-only table carries. "
            "The chapter contradicts itself in the same section: its table "
            "descriptions name the National Uniform Billing Committee and "
            "print the code system OIDs "
            "<code>2.16.840.1.113883.6.301.7</code> and "
            "<code>&hellip;.301.8</code>. "
            "<b>THO publishes both value sets as active resources</b>, "
            "composing over "
            "<code>http://terminology.hl7.org/CodeSystem/v2-0350</code> and "
            "<code>&hellip;/v2-0351</code>. Those are the HL7-endorsed URIs "
            "for the two NUBC code systems, registered as "
            "<code>NamingSystem/v2-0350</code> and "
            "<code>NamingSystem/v2-0351</code> with "
            "<code>responsible: NUBC</code> and listed on THO's "
            "<i>external code systems</i> page. <b>THO mints a canonical "
            "under its own hostname for a code system whose content belongs "
            "to somebody else, and publishes no content at it.</b> The "
            "value sets are correct as they stand.",
        "ask":
            "Answered, and nothing is outstanding. Kept because the finding "
            "this was split from was wrong, and the record should show what "
            "was asked as well as what came back.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "0350 and 0351 are <b>not</b> concept domain only. "
                      "The value sets exist in THO, which makes them v2 "
                      "content and therefore fair game for revision in this "
                      "IG. This corrects the error in Chapter 2C that "
                      "declares the tables concept domain only.",
            "effect": "Both tables are reclassified "
                      "<code>value-set-only</code> and this guide now "
                      "publishes <code>ValueSet/v2-0350</code> and "
                      "<code>ValueSet/v2-0351</code> where it previously "
                      "wrote nothing. They carry THO's identity, "
                      "description, compose and version unchanged, so "
                      "neither increments. Recorded in "
                      "<code>write_utg_xml.py</code>'s "
                      "<code>RULED_RECLASSIFICATIONS</code> &mdash; a third "
                      "mechanism beside the tentative overrides and the "
                      "suppressions, because a reclassification adds output "
                      "and so has to say what to publish and over what. "
                      "<b>The content logical definitions needed no "
                      "repair.</b> The ruling anticipated fixing them, on "
                      "the assumption that composing over "
                      "<code>CodeSystem/v2-0350</code> was a dangling "
                      "pointer. It is not: that is the HL7-endorsed URI for "
                      "the NUBC code system, and THO deliberately publishes "
                      "no content at it. Both value sets already compose "
                      "over exactly the right identity.",
        },
    },
    {
        "id": "esc-v2tables-domain-gaps",
        "who": "TSMG / UTG",
        "tables": "35 tables in v2-tables, none of them in Chapter 2C 2.9.1",
        "title": "THO's <code>v2-tables</code> names 35 concept domains that "
                 "<code>conceptdomains</code> does not define",
        "body":
            "<code>CodeSystem/v2-tables</code> is THO's own index of V2 tables "
            "&mdash; 628 entries, each carrying properties including "
            "<code>vocab-domain</code>, the concept domain the table names. "
            "624 entries carry a domain, and <b>37 of those name a concept "
            "that THO's own <code>conceptdomains</code> 3.0.0 does not "
            "contain</b>. This project's proposed additions happen to cover "
            "two of them (<code>DangerCode</code>, <code>Location</code>), "
            "leaving 35. "
            "<b>The gap is confined to tables the chapter has dropped.</b> "
            "All 35 sit among the 39 <code>v2-tables</code> entries that "
            "Chapter 2C 2.9.1 no longer carries at all, so no row of this "
            "guide is affected and nothing here is blocked. That also suggests "
            "the cause: when a table left the chapter its concept domain "
            "stopped being maintained, but its <code>vocab-domain</code> "
            "property stayed behind. Only three of the 39 are typed "
            "<i>no longer used</i>; the rest are still typed <i>HL7</i> or "
            "<i>User</i>, so the index does not mark them as retired. "
            "<b>One caveat on how hard to push this.</b> "
            "<code>vocab-domain</code> is declared as type <code>string</code> "
            "rather than <code>code</code>, so it is not formally a reference "
            "into <code>conceptdomains</code> and nothing validates it. But "
            "587 of 624 values do resolve, which makes the 37 look like drift "
            "rather than design.",
        "ask":
            "Confirm that <code>vocab-domain</code> is meant to resolve into "
            "<code>conceptdomains</code>. If it is, either the 35 missing "
            "domains should be restored, or the entries that name them should "
            "be marked as no longer used, or the property should be cleared "
            "for tables that have left the standard. If it is genuinely a free "
            "string with no such contract, that is worth stating, because "
            "readers will assume otherwise. Retyping it as <code>code</code> "
            "would let validation catch the next occurrence.",
    },
    {
        "id": "esc-v2tables-siteadministered",
        "who": "TSMG / UTG",
        "tables": "0034",
        "title": "<code>v2-tables</code> misspells the concept domain for "
                 "table 0034 as <code>SiteAdminstered</code>",
        "body":
            "<code>CodeSystem/v2-tables</code> gives table 0034 the "
            "<code>vocab-domain</code> <code>SiteAdminstered</code>, missing "
            "the second <i>i</i> of <i>Administered</i>. The same entry's "
            "display is <b>SITE ADMINISTERED</b>, spelled correctly, which "
            "settles that this is a typo rather than a deliberate name. "
            "Neither <code>SiteAdminstered</code> nor a correctly spelled "
            "<code>SiteAdministered</code> exists in "
            "<code>conceptdomains</code>, so the property also resolves to "
            "nothing &mdash; it is one of the 35 gaps in "
            "<code>esc-v2tables-domain-gaps</code>. "
            "<b>This one is cheaper to fix than it looks, and it is worth "
            "being precise about why.</b> <code>v2-tables</code> is a "
            "convenience index that makes V2 table metadata available in THO. "
            "Nobody sends <code>SiteAdminstered</code> in a message and no "
            "instance data binds to it, so correcting the string breaks no "
            "implementation. That makes it a technical correction rather than "
            "a substantive change. "
            "<b>A typo in a real code, in a real code system, is a different "
            "problem entirely</b> &mdash; there the code is an identifier that "
            "implementations have already sent and stored, and the remedy is "
            "deprecation plus a correctly spelled replacement, not an edit. "
            "Nothing in that harder category has been found in the v2 tables "
            "so far; this item is deliberately not making that claim.",
        "ask":
            "Correct the <code>vocab-domain</code> value for table 0034 to "
            "<code>SiteAdministered</code> as a technical correction. The "
            "change should still be traceable &mdash; recorded in the UTG "
            "change history like any other edit &mdash; but it does not need "
            "the deprecate-and-replace treatment that a published code would. "
            "Separately, whether the corrected domain should then be "
            "<i>defined</i> in <code>conceptdomains</code>, or the property "
            "cleared because table 0034 has left the standard, is part of "
            "<code>esc-v2tables-domain-gaps</code>.",
    },
    {
        "id": "esc-v2tables-retirement",
        "who": "V2 Management + TSMG",
        "tables": "v2-tables, all 628 entries",
        "title": "Should <code>CodeSystem/v2-tables</code> be retired?",
        "body":
            "<code>CodeSystem/v2-tables</code> is not a code system in the "
            "sense the rest of THO uses the term. Its 628 concepts are "
            "<i>table numbers</i>: the code is the number, the display is the "
            "table's name, and the content is a dozen properties carrying the "
            "table's OIDs, type, steward, binding strength and concept "
            "domain. Nobody sends <code>0005</code> in a V2 message meaning "
            "&ldquo;table 5&rdquo;. It is an index of metadata that was given "
            "a code system's shape because that was the container available. "
            "<b>THO's own description concedes that the index does not "
            "work.</b> Under the title line it reads: <i>&ldquo;Please note "
            "that V2 Code System and Value Set URIs are present, but the URIs "
            "do not resolve. The addition of the appropriate THO artifacts "
            "for these are in progress.&rdquo;</i> The index's substance is "
            "pointers, and the description says the pointers are broken. Two "
            "items above are instances of exactly that: the "
            "<code>vocab-domain</code> property names 35 concept domains "
            "<code>conceptdomains</code> does not define, and one of those "
            "names is a typo. "
            "<b>Nothing depends on it definitionally.</b> Checked across all "
            "4,177 files in the <code>hl7.terminology.r5</code> snapshot: "
            "<b>no ValueSet composes from it, no CodeSystem supplements it, "
            "and nothing binds to it.</b> Outside its own file the only "
            "references are three packaging entries &mdash; the "
            "<code>hl7.terminology</code> ImplementationGuide manifest, "
            "<code>List/v2-Publishing</code> and "
            "<code>List/v2-rendering</code> &mdash; and the UTG change-history "
            "bundles, which record edits made to it rather than use it. "
            "<b>The one real coupling argues for retirement rather than "
            "against it.</b> Fourteen properties in "
            "<code>CodeSystem/utg-concept-properties</code> carry the comment "
            "<i>&ldquo;used only in v2-tables.xml&rdquo;</i>: "
            "<code>v2-table-oid</code>, <code>v2-cs-oid</code>, "
            "<code>v2-cs-uri</code>, <code>v2-vs-oid</code>, "
            "<code>v2-vs-uri</code>, <code>v2-cs-version</code>, "
            "<code>v2-table-type</code>, <code>v2-table-deprecated</code>, "
            "<code>v2TblStatus</code>, <code>v2-binding</code>, "
            "<code>v2-where-used</code>, "
            "<code>v2-version-tbl-introduced</code>, "
            "<code>v2-version-csvs-introduced</code> and "
            "<code>vocab-domain</code>. Retiring <code>v2-tables</code> "
            "orphans all fourteen &mdash; which is another way of saying that "
            "fourteen property definitions exist to serve one artifact that "
            "nothing else reads. (<code>v2-table-deprecated</code> is the "
            "exception, and it is a problem in its own right; see the item "
            "below.) "
            "The case for keeping it is that a machine-readable index of V2 "
            "table metadata is genuinely useful &mdash; this guide had to "
            "rebuild most of the same information from the chapter. That is "
            "an argument for the index existing, not for it being a "
            "CodeSystem.",
        "ask":
            "Decide whether <code>CodeSystem/v2-tables</code> should be "
            "retired, and if so what takes its place. It carries no codes "
            "anyone sends, it has no definitional dependents, and its own "
            "description says its pointers do not resolve. "
            "<b>The reasoning is already in this register.</b> "
            "<code>esc-v2tables-siteadministered</code> argues that "
            "correcting a misspelled <code>vocab-domain</code> is a technical "
            "correction <i>because</i> nobody sends that value in a message "
            "and no instance data binds to it. This item is the same "
            "observation taken one step further. "
            "If the index is worth keeping, the question is what shape it "
            "should have, because a CodeSystem whose concepts are not "
            "concepts will keep attracting the defects recorded above, and a "
            "reader who finds a code system in THO is entitled to assume its "
            "codes turn up in instances. If it is retired, the 14 properties "
            "that exist only to serve it should go with it, and this guide's "
            "per-table pages become where that information lives. Either way "
            "the answer needs both groups: V2 Management owns what the tables "
            "are, TSMG owns what THO publishes about them.",
    },
    {
        "id": "esc-0133-contradictory",
        "who": "V2 Management",
        "tables": "0133",
        "title": "Table 0133 says three incompatible things about itself, and "
                 "THO publishes nine codes for it",
        "body":
            "Table 0133 <i>Procedure practitioner identifier code type</i> "
            "carries three statements that cannot all hold. "
            "<b>One:</b> its concept domain block sets <code>Concept Domain "
            "Only: yes</code>, and it publishes no code system, no value set "
            "and no codes &mdash; so this project writes nothing for it, which "
            "is the correct reading of that flag. "
            "<b>Two:</b> its own table metadata describes it as a code set: "
            "&ldquo;HL7-defined table of concepts which specify the different "
            "types of practitioners associated with this procedure. <i>This "
            "set of codes is known to be incomplete.</i>&rdquo; A table that "
            "is concept-domain-only has no set of codes to be incomplete. "
            "<b>Three:</b> the same description says the table is obsolete "
            "&mdash; &ldquo;as of v2.6, this table and the field(s) it was "
            "used in was replaced by table 443 used in the ROL segment&rdquo; "
            "&mdash; yet its <code>Type</code> is <code>undefined</code> "
            "rather than anything marking it withdrawn, and it is still "
            "published in 2.9.1. "
            "<b>Meanwhile THO publishes <code>CodeSystem/v2-0133</code> with "
            "nine codes, <code>content: complete</code> and <code>status: "
            "active</code>,</b> plus a matching value set. So the chapter says "
            "there are no codes, says the codes are incomplete, and says the "
            "table was superseded in v2.6, while THO says there are nine "
            "active ones. "
            "<b>To be clear about what is not anomalous here, so this does "
            "not read as a fourth contradiction:</b> a CodeSystem holding the "
            "concepts plus a ValueSet whose compose is a single bare include "
            "of it is THO's <i>standard</i> pair shape for a v2 table that "
            "owns its codes, and this guide generates the same pair for 399 "
            "tables. The pair is not the problem. The problem is that THO has "
            "anything at all for a table the chapter flags concept domain "
            "only and says 0443 replaced in v2.6, and that both resources are "
            "<code>active</code> with <code>content: complete</code>. "
            "This is why 0133 shows as <i>In THO, not here</i> on the table "
            "index: the divergence is real and is not ours to resolve.",
        "ask":
            "Decide what 0133 is. If it was genuinely replaced by table 0443 "
            "in v2.6, it should be marked withdrawn in the chapter and its THO "
            "code system and value set retired or deprecated, rather than left "
            "active. If it is still live, the <code>Concept Domain Only</code> "
            "flag contradicts both its own description and THO's nine codes, "
            "and one of the three has to give. Either way the description "
            "should stop asserting an incomplete code set for a table that "
            "publishes none.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "Manipulate the markdown description so it jumps out "
                      "that this is a discontinued code system as of v2.6 "
                      "that was replaced.",
            "effect": "The table description now carries a bolded statement "
                      "ahead of the chapter's own sentence &mdash; "
                      "<i>&ldquo;This table was discontinued as of v2.6 and "
                      "replaced by table 0443, used in the ROL "
                      "segment.&rdquo;</i> &mdash; as markdown, which the "
                      "publisher renders as bold. It is recorded in "
                      "<code>vocabulary_text_policy.py</code> under a new "
                      "<code>EMPHASIS_ADDED</code> table rather than among "
                      "the corrections, because adding emphasis on a "
                      "committee's instruction is a different act from "
                      "repairing a typo and the change log should not "
                      "conflate them. The chapter's original sentence is "
                      "kept after the added one, so nothing published is "
                      "removed and the two can be compared. "
                      "<b>What the ruling does not change:</b> the table is "
                      "still <code>Concept Domain Only: yes</code>, so this "
                      "guide publishes no code system and no value set for "
                      "it, and THO still publishes nine active concepts at "
                      "<code>CodeSystem/v2-0133</code> with "
                      "<code>content: complete</code>. The contradiction "
                      "between the two bodies is unresolved &mdash; the "
                      "description now warns a reader about it. Whether "
                      "THO's pair should be retired is a TSMG question that "
                      "has not been put to them.",
        },
    },
    {
        "id": "esc-0078-alias-of-v3",
        "who": "V2 Management",
        "tables": "0078",
        "title": "Table 0078 <i>Interpretation Codes</i> duplicates an "
                 "existing THO value set under a new URL",
        "body":
            "Split from <code>esc-oid-conflicts</code>, which asked about "
            "three OIDs; this third of it has been answered and the other "
            "two are still open. "
            "Chapter 2C prints the canonical "
            "<code>http://terminology.hl7.org/ValueSet/v2-0078</code> and the "
            "value set OID <code>2.16.840.1.113883.1.11.78</code>. THO "
            "publishes nothing at that canonical, so writing it would be a "
            "first publication rather than a disagreement &mdash; but the "
            "OID is not free. THO's "
            "<code>ValueSet/v3-ObservationInterpretation</code> already "
            "carries it, on a value set whose content logical definition is "
            "<i>byte-identical</i> to the one this guide would write: a "
            "single bare include of "
            "<code>CodeSystem/v3-ObservationInterpretation</code>, no "
            "filter, no enumerated concepts. It is the only ValueSet in the "
            "snapshot with either that OID or that compose. Publishing "
            "<code>v2-0078</code> would therefore put <b>one OID on two "
            "artifacts</b> &mdash; the policy breach "
            "<code>esc-oid-conflicts</code> records for 0719.",
        "ask":
            "Answered. Kept because the ledger note the ruling calls for is "
            "work this project has to do.",
        "resolution": {
            "who": "V2 Management",
            "forum": "V2 Management call",
            "date": "2026-10-14",
            "ruling": "The value set already exists, just at a different "
                      "URL: <code>ValueSet-v3-ObservationInterpretation</code>. "
                      "That value set is allowed to serve and no new one is "
                      "created. The situation is noted in the ledger. This "
                      "keeps fidelity to Chapter 2C in as much as the guide "
                      "is simply not adding something, rather than doing "
                      "something different.",
            "effect": "<code>ValueSet/v2-0078</code> is no longer written. "
                      "It had been a first publication at 1.0.0 carrying the "
                      "chapter's OID, so dropping it removes the second "
                      "artifact that the OID collision was about &mdash; "
                      "resolving that third of "
                      "<code>esc-oid-conflicts</code> without having to "
                      "choose between two identifiers. The register's option "
                      "<b>(c)</b> for this table, which the identical "
                      "compose was said to support. "
                      "<b>0001 and 0719 are not answered by this ruling</b> "
                      "and stay open on <code>esc-oid-conflicts</code>: "
                      "those are genuine conflicts between two existing "
                      "artifacts, where this one was avoidable by not "
                      "creating the second.",
        },
    },
    {
        "id": "esc-oid-conflicts",
        "who": "V2 Management + TSMG",
        "tables": "0001, 0719",
        "title": "Three artifacts where one OID would end up naming two "
                 "things, which versioning cannot reconcile",
        "body":
            "Two artifacts carry a different <code>identifier</code> OID in "
            "Chapter 2C than the one THO publishes at the same canonical URL, "
            "and a third would create the same breach from the other "
            "direction. "
            "<b><code>CodeSystem/v2-0001</code> <i>Administrative Sex</i>:</b> "
            "the chapter gives <code>2.16.840.1.113883.18.458</code>, THO "
            "publishes <code>2.16.840.1.113883.18.2</code>. Both sit in the "
            "HL7 v2 code system arc, so neither is obviously a stray. This is "
            "the most widely implemented table in V2. "
            "The chapter's block is titled <i>Jurisdiction Gender Code "
            "System</i>, not <i>Administrative Sex</i>, and "
            "<code>...18.458</code> resolves to nothing anywhere in THO "
            "&mdash; so this may be a disagreement about <i>which code "
            "system</i> the table points at rather than a mistyped digit. "
            "<b><code>ValueSet/v2-0719</code>:</b> the chapter gives "
            "<code>2.16.840.1.113883.1.11.20429</code>, THO publishes "
            "<code>...20428</code>. These are adjacent but they are not "
            "near-misses: both are <b>v3</b> value set OIDs and both are in "
            "use, <code>...20428</code> for <code>ActInformationSensitivity"
            "Policy</code>'s parent <code>InformationSensitivityPolicy</code> "
            "and <code>...20429</code> for <code>ActInformationSensitivity"
            "Policy</code> itself. THO's <code>ValueSet/v2-0719</code> "
            "<b>shares</b> <code>...20428</code> with THO's own "
            "<code>v3-InformationSensitivityPolicy</code> &mdash; one OID on "
            "two artifacts &mdash; which fits THO's own description of 0719, "
            "that it &ldquo;was created in THO in error due to an oversight "
            "in the import processing&rdquo;. So the question is which v3 "
            "value set table 0719 corresponds to, not which digit is a typo. "
            "<b><code>ValueSet/v2-0078</code> <i>Interpretation Codes</i> is "
            "different in kind, and the difference is the point: <i>we</i> "
            "create this one, THO does not.</b> Chapter 2C prints the "
            "canonical <code>http://terminology.hl7.org/ValueSet/v2-0078</code> "
            "for the table and the value set OID "
            "<code>2.16.840.1.113883.1.11.78</code>. THO publishes nothing at "
            "that canonical, so this is a first publication rather than a "
            "disagreement with an existing artifact. But "
            "<code>&hellip;1.11.78</code> is not free. THO's "
            "<code>ValueSet/v3-ObservationInterpretation</code> already "
            "carries it, on a value set whose content logical definition is "
            "<i>byte-identical</i> to the one we would write: a single bare "
            "include of <code>CodeSystem/v3-ObservationInterpretation</code>, "
            "no filter, no enumerated concepts. It is the only ValueSet in "
            "the snapshot with either that OID or that compose. So publishing "
            "<code>v2-0078</code> at the chapter's canonical with the "
            "chapter's identifier puts <b>one OID on two artifacts</b> "
            "&mdash; the same policy breach this item already records for "
            "0719. "
            "<b>Why this is not a versioning question.</b> The THO artifact "
            "versioning policy treats every other divergence found in this "
            "comparison as something a version increment covers. Identifiers "
            "are the exception: the policy states that an identifier cannot be "
            "changed or removed, that adding one makes it immutable, and that "
            "an identifier change requires a <i>new</i> artifact rather than a "
            "new version &mdash; &ldquo;extreme care must be taken with "
            "identifiers&rdquo;. Publishing our OID at THO's canonical would "
            "therefore be a policy violation, not a bump. "
            "Every other artifact agrees. Counting the tables where Chapter "
            "2C and THO <i>both</i> give an OID for the same resource type: "
            "<b>395 of 396</b> code systems and <b>411 of 412</b> value sets "
            "carry identical identifiers. (0078 is not in that count: THO "
            "publishes no artifact at that canonical to compare against.)",
        "ask":
            "Adjudicate each OID. For 0001, establish which of "
            "<code>...18.458</code> and <code>...18.2</code> is the registered "
            "identifier for the Administrative Sex code system, and correct "
            "the other source. For 0719, establish whether "
            "<code>...20429</code> or <code>...20428</code> is right. Until "
            "both are settled this project publishes THO's identifier rather "
            "than the chapter's, because the policy forbids changing a "
            "published identifier and the canonical URL is THO's. <b>That is "
            "now enforced in the pipeline</b> rather than left as a "
            "recommendation: the identifier is the one element where the "
            "chapter does not win a disagreement, because an identifier is "
            "identity rather than content. Both conflicts are recomputed on "
            "every run, so neither can drift out of view. "
            "<b>A third option has been raised and needs ruling on: publish "
            "<i>both</i> OIDs as identifiers.</b> <code>identifier</code> is "
            "0..* on both CodeSystem and ValueSet, so it is mechanically "
            "available, and it would avoid choosing before the committees "
            "have. It is not obviously right: two identifiers on one artifact "
            "asserts that both OIDs name it, which for 0719 is demonstrably "
            "false &mdash; <code>...20429</code> names a different v3 value "
            "set, which THO also publishes. Carrying both would be defensible "
            "for 0001, where the two may be the same code system under two "
            "registrations, and misleading for 0719. <b>Please rule per "
            "artifact rather than as a blanket policy.</b> "
            "<b>0078 was the third conflict here and has been answered</b> "
            "&mdash; see <code>esc-0078-alias-of-v3</code>. V2 Management "
            "ruled on 2026-10-14 that the existing "
            "<code>v3-ObservationInterpretation</code> serves and no second "
            "artifact is created, which removed that collision rather than "
            "adjudicating it. <b>It is not a precedent for these two:</b> "
            "0078's collision existed only because this guide was about to "
            "create the second artifact, and 0001 and 0719 are conflicts "
            "between artifacts that already exist.",
    },
    {
        "id": "esc-table-oid-unpublished",
        "who": "V2 Management + TSMG",
        "tables": "798 tables",
        "title": "Chapter 2C gives every table its own OID, and this guide "
                 "publishes it nowhere",
        "body":
            "Chapter 2C carries <b>three</b> OIDs per table, in three separate "
            "metadata blocks, and they identify three different things: a "
            "<b>Table OID</b> in the <code>2.16.840.1.113883.12.*</code> arc "
            "(798 of 799 tables), a <b>Code System OID</b> in "
            "<code>...113883.18.*</code> (435 tables), and a <b>Value Set "
            "OID</b> in <code>...113883.21.*</code> (438 tables). THO uses "
            "the same two latter arcs for the same two resource types, so the "
            "code system and value set OIDs have an obvious home and are "
            "written to <code>CodeSystem.identifier</code> and "
            "<code>ValueSet.identifier</code>. "
            "<b>The table OID has no home.</b> In V2 the table is the thing "
            "with an identity; in FHIR that table becomes a code system "
            "<i>and</i> a value set, and neither of them <i>is</i> the table. "
            "So the <code>.12</code> OID is carried by no resource this guide "
            "publishes. That is not a decision anyone took &mdash; it is what "
            "happens by default when a one-to-one identifier meets a "
            "one-to-two split, and it means 798 published identifiers from "
            "the chapter appear in no output. "
            "Worth knowing before ruling: 50 of the 798 are not identifiers "
            "at all but the bare arc root <code>2.16.840.1.113883.1</code> "
            "with no leaf, on the 50 tables the chapter types "
            "<i>undefined</i>; and the table OID is not dead elsewhere &mdash; "
            "THO's own description of table 0227 cites PHIN VADS by the "
            "<code>.12.227</code> table OID, so implementers do resolve these.",
        "ask":
            "Decide where a V2 table OID belongs in a FHIR representation of "
            "that table, and whether this guide should start writing it. The "
            "options each say something different and none is free. Putting "
            "it on the <b>CodeSystem</b> says the code system is the table, "
            "which is wrong for the 24 value-set-only tables whose codes "
            "belong to another authority. Putting it on <b>both</b> resources "
            "asserts one identifier for two artifacts, which is the same "
            "shape as the defect registered at "
            "<code>esc-oid-conflicts</code>. Putting it on the <b>concept "
            "domain</b> concept has no <code>identifier</code> element to "
            "hold it. Putting it <b>nowhere</b> is the current behaviour and "
            "may well be right &mdash; but it should be a ruling rather than "
            "an accident, because the identifier is in the published chapter "
            "and its absence from the FHIR artifacts is silent.",
    },
    {
        "id": "esc-status-n-b-undefined",
        "who": "V2 Management + TSMG",
        "tables": "0003, 0125, 0357 for B; 25 tables, 261 concepts for N",
        "title": "The concept statuses <code>N</code> and <code>B</code> are "
                 "defined nowhere; <code>N</code> is now mapped, "
                 "<code>B</code> is not",
        "body":
            "Chapter 2C carries its own legend for the status column: blank "
            "means an active code, <code>B</code> means &ldquo;backwards-"
            "compatible use only&rdquo;, <code>D</code> means &ldquo;deprecated "
            "or inactive&rdquo;, <code>R</code> means &ldquo;retired&rdquo;, "
            "and <code>N</code> means <b>&ldquo;new in this release&rdquo;</b>. "
            "Blank, <code>D</code> and <code>R</code> have unambiguous FHIR "
            "equivalents and are written as <code>active</code>, "
            "<code>deprecated</code> and <code>retired</code>. <code>N</code> "
            "and <code>B</code> do not. "
            "<b>Neither is defined anywhere.</b> The property they are written "
            "to is <code>status</code>, defined by FHIR at "
            "<code>http://hl7.org/fhir/concept-properties#status</code>, whose "
            "own definition reads &ldquo;a code that indicates the status of "
            "the concept. Typical values are active, experimental, deprecated, "
            "and retired.&rdquo; Neither <code>N</code> nor <code>B</code> is "
            "among them. They are not in <code>utg-concept-properties</code> "
            "either, and no value set enumerates them. Across the whole of "
            "<code>hl7.terminology.r5</code> they appear <i>only</i> in v2 "
            "code systems &mdash; 210 concepts carry <code>N</code> and 6 "
            "carry <code>B</code>. "
            "<b><code>N</code> is worse than undefined, because it decays.</b> "
            "&ldquo;New in this release&rdquo; was a statement about whichever "
            "release first printed it, and nothing updates it afterwards. That "
            "is visible in the data: THO still marks 210 concepts "
            "<code>N</code> from past releases while the 2.9.1 chapter marks "
            "only 70, and <b>205 of the 261 status disagreements between the "
            "chapter and THO are exactly this</b> &mdash; THO saying "
            "<code>N</code> where the current chapter says nothing, so this "
            "project publishes <code>active</code>. "
            "<b><code>N</code> is now mapped to <code>active</code>, as a "
            "technical correction.</b> The reviewer ruled on this half on "
            "2026-09-19, and the three findings above are the grounds taken "
            "together: &ldquo;new in this release&rdquo; is not a status but "
            "a provenance note; it expires with nothing to update it, so a "
            "value printed in 2.9.1 is already a claim about some earlier "
            "release; and it is not a legal value of the standard FHIR "
            "property this guide writes it into, whose own definition "
            "enumerates active, experimental, deprecated and retired. A code "
            "marked <code>N</code> is in every case an active code, so "
            "writing <code>active</code> says what the chapter means and says "
            "it in the same vocabulary <code>D</code> and <code>R</code> "
            "already use. On the errata test in the first item of this "
            "register that is a change that makes the document say what the "
            "work group intended, not a change to what the standard means. "
            "<b><code>B</code> is deferred, deliberately.</b> "
            "&ldquo;Backwards-compatible use only&rdquo; is a real statement "
            "about a code and it has no obvious FHIR equivalent: not "
            "<code>deprecated</code>, because the code is still correct for "
            "existing senders; not <code>retired</code>; and not plainly "
            "<code>active</code> either, because the restriction is real. It "
            "is also small enough to take one at a time &mdash; <b>five "
            "concepts in three tables</b>: <code>0003</code> <i>Event</i> "
            "code <code>O57</code> (OMQ &mdash; General Order Message with "
            "Document Payload), <code>0125</code> <i>Value Type</i> code "
            "<code>IS</code> (Coded value for user-defined tables), and "
            "<code>0357</code> <i>Message Error Condition Codes</i> "
            "<code>204</code>, <code>205</code> and <code>206</code> (Unknown "
            "key identifier, Duplicate key identifier, Application record "
            "locked). Five concepts is a review, not a policy.",
        "ask":
            "Two things remain. <b>(1) Rule on <code>B</code>, per "
            "concept.</b> Five concepts in three tables is small enough to "
            "look at individually, and they are not obviously the same case "
            "&mdash; <code>0125</code>'s <code>IS</code> is a data type code, "
            "<code>0357</code>'s three are error conditions. For each, say "
            "whether the FHIR status should be <code>active</code>, "
            "<code>deprecated</code>, or <code>active</code> with a separate "
            "marker recording the backwards-compatibility restriction. "
            "<b>(2) Decide where, if anywhere, these letters should be "
            "defined.</b> Even with <code>N</code> resolved by mapping, THO "
            "still publishes 210 concepts carrying it as a literal status "
            "value and 6 carrying <code>B</code>, against a property whose "
            "definition admits neither. Defining them in "
            "<code>utg-concept-properties</code> would at least make what is "
            "already published legal; replacing <code>N</code> with a "
            "non-decaying &ldquo;version introduced&rdquo; property would be "
            "better, and the chapter already records that fact in prose "
            "elsewhere. "
            "<b>What this guide does now:</b> <code>N</code> is written as "
            "<code>active</code>; <code>B</code> is passed through unchanged "
            "pending (1); and all 261 chapter-versus-THO status "
            "disagreements are still recorded, because mapping "
            "<code>N</code> does not make the underlying divergence go "
            "away.",
    },
    {
        "id": "esc-deprecation-flag-contradicts-status",
        "who": "V2 Management",
        "tables": "0003, 0006, 0065, 0066, 0074, 0076, 0104, 0131, 0163, "
                  "0175, 0191, 0200, 0207, 0211, 0223, 0272, 0277, 0278, "
                  "0279, 0281, 0291, 0294, 0354, 0359, 0365, 0366, 0367, "
                  "0391, 0396, 0418, 0440, 0474, 0487, 0492, 0544, 0916",
        "title": "191 concepts say they are active and deprecated as of 2.9 "
                 "at the same time",
        "body":
            "<b>The contradiction.</b> <b>241 concepts across 36 code "
            "systems</b> carry the concept property "
            "<code>v2-table-deprecated</code> with the value <code>2.9</code>. "
            "Of those, <b>191 carry a concept <code>status</code> that is "
            "neither <code>deprecated</code> nor <code>retired</code></b> "
            "&mdash; 169 say <code>active</code> and 22 say <code>N</code>. "
            "(<code>N</code> is now mapped to <code>active</code>, per the "
            "item above, so all 191 read <code>active</code>.) The other 50 "
            "do say <code>deprecated</code>, which is what the flag implies. "
            "So the two properties agree on 50 concepts and contradict each "
            "other on 191, and both values are the chapter's, reproduced "
            "faithfully. "
            "<b>The property is defined twice, at one URI, to mean two "
            "different things.</b> "
            "<code>CodeSystem/utg-concept-properties</code> defines "
            "<code>v2-table-deprecated</code> as a <i>table-level</i> "
            "assertion &mdash; &ldquo;Indicates that although still being "
            "published in the V2 international standard, <b>the table</b> has "
            "been deprecated in favor of alternative codes, and will be "
            "withdrawn in the future&rdquo; &mdash; with the comment "
            "&ldquo;used only in v2-tables.xml&rdquo;. THO's individual v2 "
            "CodeSystems declare the same code at that same URI, "
            "<code>&hellip;utg-concept-properties#v2-table-deprecated</code>, "
            "describe it as &ldquo;<b>Version of HL7</b> in which <b>the "
            "code</b> was deprecated&rdquo;, and use it on concepts. Two "
            "definitions, one identifier. "
            "<b>The data settles which definition the values follow.</b> All "
            "241 values are the string <code>2.9</code>, which is a version "
            "and not a yes. And <code>v2-tables</code> itself &mdash; the "
            "file the first definition says is the property's only user "
            "&mdash; carries it on <b>zero</b> of its 628 entries. The "
            "concept-level reading is the one in use; the table-level "
            "definition is the stale one. "
            "<b>What this does not say, because it bounds the ask.</b> "
            "<b>None of the 36 code systems has all of its concepts "
            "flagged.</b> It is 241 concepts out of the 2,230 those 36 "
            "contain, or 10.8%; the most affected is <code>0272</code> "
            "<i>Document Confidentiality Status</i> at 6 of 9, the least "
            "<code>0487</code> <i>Specimen Type</i> at 2 of 315. So this is a "
            "claim about individual codes, and <code>CodeSystem.status = "
            "active</code> is correct on all 36. Nothing here generalises to "
            "0567 and 0568, where the whole table is deprecated and a "
            "different mechanism is needed.",
        "ask":
            "Confirm that a concept whose <code>v2-table-deprecated</code> is "
            "<code>2.9</code> should carry <code>status: deprecated</code>. "
            "One ruling resolves all 191, because there is nothing "
            "case-by-case about it: the flag says the code was deprecated in "
            "2.9, and 2.9 has shipped. "
            "<b>This guide has not applied that, and is surfacing it for "
            "decision rather than fixing it.</b> Both the status and the flag "
            "are published values and both are reproduced, contradiction "
            "included. Changing 191 concept statuses is a content change to "
            "published normative material &mdash; which is the question the "
            "first item in this register asks in general terms &mdash; and it "
            "is not something to do on inference. "
            "Two smaller things should be settled alongside it. Give "
            "<code>v2-table-deprecated</code> a <b>single</b> definition, the "
            "concept-level one, since that is what the values are; or split "
            "it into two properties with two URIs, because at present one "
            "identifier means &ldquo;this table is deprecated&rdquo; in one "
            "place and &ldquo;the version this code was deprecated in&rdquo; "
            "in another. And decide whether the flag is still wanted once "
            "<code>status</code> says the same thing, or whether it becomes "
            "the record of <i>when</i>, which <code>status</code> cannot "
            "carry.",
    },
    {
        "id": "esc-concept-ordering",
        "who": "TSMG",
        "tables": "32 tables",
        "title": "Does reordering a code system's concepts count as a change "
                 "for versioning?",
        "body":
            "This project compares its concepts against THO's as a set keyed "
            "by code, so a code system whose codes are identical to THO's but "
            "listed in a different order is treated as unchanged and keeps "
            "THO's version. The reasoning is that order is not information in "
            "a flat code system: a <code>CodeSystem</code> with "
            "<code>hierarchyMeaning</code> of <code>is-a</code> and no nesting "
            "says nothing by putting one code before another. "
            "<b>32 tables carry exactly THO's codes in a different order.</b> "
            "If order is a change under the artifact versioning policy, those "
            "32 all increment &mdash; and they increment again every time the "
            "chapter is re-laid-out, which is a version number spent on "
            "typesetting.",
        "ask":
            "Confirm that concept order is not a versionable change, or say "
            "that it is. Either answer is one line in this project's "
            "comparison. The question is asked because the policy's element "
            "table lists <code>CodeSystem.concept (and all subelements)</code> "
            "without qualification, and a literal reading could be taken to "
            "cover sequence.",
        "resolution": {
            "who": "TSMG",
            "forum": "Terminology Infrastructure WG meeting, "
                     "HL7 Plenary, Rockville",
            "date": "2026-09-21",
            "ruling": "Reordering a code system's concepts is not a change, "
                      "and does not increment the version.",
            "effect": "None. The comparison already compared concepts as a "
                      "set keyed by code, so no artifact moved and no version "
                      "number changed. The 32 tables carrying exactly THO's "
                      "codes in a different order keep THO's version on the "
                      "policy owner's authority rather than on this project's "
                      "reading of the policy.",
        },
    },
    {
        "id": "esc-description-editorial-carveout",
        "who": "TSMG",
        "tables": "policy; 12 descriptions, 25 concepts",
        "title": "How far does the description &ldquo;editorial "
                 "corrections&rdquo; carve-out reach?",
        "body":
            "The Code Systems versioning policy qualifies exactly one element: "
            "<code>CodeSystem.description</code> is &ldquo;major unless only "
            "change is improved clarity or perform editorial "
            "corrections&rdquo;. This project applies that where it can do so "
            "honestly &mdash; where our description and THO's contain exactly "
            "the same words in the same order, so that only punctuation or "
            "spacing moved. <b>12 descriptions across 7 tables</b> are waived "
            "on that basis, every one of them our <code>e.g.,</code> against "
            "THO's <code>e.g.</code>, or our <code>code system.</code> against "
            "THO's <code>code system .</code>. "
            "Three things about this need confirming. "
            "<b>First, the rule itself:</b> is a punctuation-only difference an "
            "editorial correction? "
            "<b>Second, the asymmetry it creates.</b> The carve-out is written "
            "against <code>description</code> alone, while "
            "<code>CodeSystem.concept (and all subelements)</code> is listed "
            "unqualified. So <b>4 concept definitions and 21 concept displays "
            "that differ from THO only in punctuation do increment</b>. A "
            "comma in a description is free; the same comma in a display costs "
            "a major version. This project has not smoothed that over, because "
            "guessing at an unwritten carve-out is how a pipeline quietly "
            "stops matching the rules it claims to follow &mdash; but it looks "
            "more like an oversight than a decision. "
            "<b>Third, the Value Sets policy has no equivalent carve-out at "
            "all</b>, so read literally it makes every description difference "
            "a major increment however trivial. This project treats "
            "<code>ValueSet.description</code> exactly as it treats "
            "<code>CodeSystem.description</code>, rather than encode an "
            "asymmetry believed to be a drafting slip.",
        "ask":
            "Confirm the punctuation waiver, say whether it should extend to "
            "concept definitions and displays, and confirm whether the missing "
            "ValueSet carve-out is deliberate. Each answer is a located change "
            "in this project; none of them is a rewrite.",
    },
    {
        "id": "esc-tho-descriptions-say-more",
        "who": "V2 Management + TSMG",
        "tables": "0227, 0719",
        "title": "Two THO descriptions carry text the chapter's do not, "
                 "including THO documenting its own error",
        "body":
            "Of the description differences between this project's output and "
            "THO, all but two are punctuation. These two are not, and in both "
            "THO's text carries something the chapter's does not. "
            "<b><code>ValueSet/v2-0227</code>:</b> THO's description ends with "
            "a link to the code system on PHIN VADS. The chapter's stops "
            "before it, so publishing the chapter's drops a working source "
            "reference for a code system HL7 does not itself maintain. "
            "<b><code>ValueSet/v2-0719</code>:</b> THO's description ends "
            "&ldquo;Note that this resource was created in THO in error due to "
            "an oversight in the import processing.&rdquo; That is THO "
            "documenting its own mistake in the artifact's description. It is "
            "not something Chapter 2C should inherit, but it does say the "
            "artifact needs attention rather than a redraft &mdash; and 0719 "
            "is also one of the two artifacts with an OID conflict. "
            "This project publishes the chapter's description in both cases "
            "and increments the version. The merge fills an absent value from "
            "THO but never splices two pieces of prose together, because "
            "concatenating them would publish text neither source wrote.",
        "ask":
            "For 0227, decide whether the source reference should be carried "
            "into the chapter's description or dropped. For 0719, decide what "
            "should happen to a THO artifact whose own description says it was "
            "created in error &mdash; and settle that together with its OID "
            "conflict, since the two are likely the same story.",
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

    open_items = [i for i in ESCALATIONS if not i.get("resolution")]
    answered = [i for i in ESCALATIONS if i.get("resolution")]

    for number, item in enumerate(open_items, start=1):
        title = to_markdown_text(item["title"])
        lines.append(f"{number}. [{title}](#{number}) — {item['tables']}")
    lines.append("")
    lines.append("---")
    lines.append("")

    for number, item in enumerate(open_items, start=1):
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
        if item.get("evidence"):
            lines += render_markdown_evidence(item["evidence"]) + [""]

    # Answered items keep their place in the document but not in the numbered
    # list, which counts what is still outstanding. They are listed after it,
    # because the register is circulated to people who need to know what was
    # settled as well as what is left -- an item that simply disappeared
    # between two circulations reads as dropped rather than as answered.
    if answered:
        lines += [
            "---",
            "",
            "## Answered",
            "",
            "Items ruled on since this register was opened &mdash; by a",
            "committee, or, where the ask said the question was the",
            "project's to settle, by the project.",
            "They are no longer counted above. The finding and the original",
            "ask are kept so the record shows what was asked as well as what",
            "came back.",
            "",
        ]
        for item in answered:
            resolution = item["resolution"]
            lines += [
                f'<a id="{item["id"]}"></a>',
                "",
                f"### {to_markdown_text(item['title'])}",
                "",
                f"**Tables:** {item['tables']}  ",
                f"**Answered by:** {resolution['who']} — "
                f"{resolution['forum']}, {resolution['date']}",
                "",
                f"**Ruling:** {to_markdown_text(resolution['ruling'])}",
                "",
                f"**Effect here:** {to_markdown_text(resolution['effect'])}",
                "",
                to_markdown_text(item["body"]),
                "",
            ]

    return "\n".join(lines)


def render_markdown_evidence(evidence):
    """Render one item's computed evidence as a markdown table.

    Cell text is escaped for the pipe character only. The descriptions in this
    table are published prose and can contain anything; a stray pipe would
    otherwise split a row into the wrong number of columns.
    """
    columns, rows = evidence()
    if not rows:
        return ["_No matching entries found in the current corpus._"]

    def cell(text):
        return str(text).replace("|", "\\|")

    lines = [
        "| " + " | ".join(columns) + " |",
        "|" + "|".join(["---"] * len(columns)) + "|",
    ]
    for row in rows:
        lines.append("| " + " | ".join(cell(value) for value in row) + " |")
    return lines


def check_table_lists():
    """Warn where an item's stated tables no longer match its computed evidence.

    An item's `tables` field is authored, because a committee reading the
    contents list wants to see the numbers rather than a promise that they are
    listed further down. That means it can fall out of step with the evidence
    the same item computes, so it is checked rather than trusted.
    """
    warnings = []
    for item in ESCALATIONS:
        if not item.get("evidence"):
            continue
        _, rows = item["evidence"]()
        # Unique, in the order the evidence lists them. An item can have more
        # than one row per table -- table 0505 has two punctuation codes --
        # and the stated list names each table once.
        computed = list(dict.fromkeys(row[0] for row in rows))
        stated = [t.strip() for t in item["tables"].split(",") if t.strip()]
        if computed != stated:
            warnings.append(
                f"  {item['id']}: states {len(stated)} tables, evidence finds "
                f"{len(computed)}\n"
                f"    stated:   {', '.join(stated)}\n"
                f"    computed: {', '.join(computed)}")
    return warnings


def main():
    DEFAULT_OUT.parent.mkdir(parents=True, exist_ok=True)
    DEFAULT_OUT.write_text(render_markdown())
    answered = sum(1 for i in ESCALATIONS if i.get("resolution"))
    summary = f"{len(ESCALATIONS) - answered} open"
    if answered:
        summary += f" + {answered} answered"
    print(f"{summary} -> {DEFAULT_OUT}")

    warnings = check_table_lists()
    if warnings:
        print("\nWARNING: an item's stated tables no longer match its evidence:")
        print("\n".join(warnings))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
