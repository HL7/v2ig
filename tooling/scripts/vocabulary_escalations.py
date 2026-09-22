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
        "tables": "0010, 0188, 9999",
        "title": "Three &ldquo;tables&rdquo; that carry no terminology at all",
        "body":
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
            "Confirm that 0010 and 0188 should be concept domains rather than "
            "code tables, and decide what becomes of 9999 &mdash; a "
            "placeholder that occupies a table number is a trap for anyone "
            "generating resources from the chapter mechanically. This project "
            "writes nothing for any of the three.",
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
        "tables": "0459",
        "title": "Table 0459 names its code system only by an OID that "
                 "nothing resolves",
        "body":
            "<code>0459</code> <i>Reimbursement Action Code</i> is an "
            "External table stewarded by FM. It declares one code system, "
            "<code>cms-OCEEditCode-cs</code>, identified solely by OID "
            "<code>2.16.840.1.113883.6.301.9</code> with no URI. "
            "<b>Neither THO nor the FHIR core packages resolve that OID to a "
            "canonical URL</b>, so there is no way to say what code system "
            "the table's four codes belong to. The writer therefore emits "
            "nothing for this table &mdash; not a CodeSystem, not a ValueSet "
            "&mdash; and it is one of only two tables in the chapter blocked "
            "this way. "
            "Note the reviewer's separate reading that this table may be "
            "better modelled as a concept domain, which would dissolve the "
            "question rather than answer it.",
        "ask":
            "Supply the canonical URL for the CMS OCE Edit Code system, or "
            "confirm that an external code system record needs to be created "
            "in THO for it. If neither is available, decide whether 0459 "
            "should become concept-domain-only, in which case no value set "
            "is needed and the OID becomes documentation rather than a "
            "dependency.",
    },
    {
        "id": "esc-0460-user-defined-mint",
        "who": "V2 Management",
        "tables": "0460, 0411, 0093",
        "title": "User-defined tables are treated three different ways, and "
                 "two of them get a freshly minted canonical",
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
            "Decide what a user-defined table should produce. Options: a "
            "CodeSystem and ValueSet like any other (the current behaviour), "
            "a concept domain only (as 0093 is treated), or a ValueSet whose "
            "codes are marked as examples. The answer decides whether these "
            "two new canonicals should exist at all, and it should be "
            "applied to 0093 at the same time so that like tables are "
            "treated alike.",
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
        "tables": "0350, 0351, 0456, 0895",
        "title": "Four THO value sets draw from v2 code systems that THO does "
                 "not publish, so they cannot expand",
        "body":
            "Found by putting this corpus side by side with "
            "<code>hl7.terminology.r5#7.3.0</code> rather than by inspection. "
            "Each of these four value sets is published by THO at "
            "<code>ValueSet/v2-NNNN</code> and composes from "
            "<code>CodeSystem/v2-NNNN</code> at the matching canonical &mdash; "
            "and THO publishes no such code system. An expansion has nothing "
            "to draw from. "
            "<b>This is not a defect this project introduces or can repair.</b> "
            "Chapter 2C agrees with THO that these tables have no codes of "
            "their own: 0350 <i>Occurrence Code</i>, 0351 <i>Occurrence "
            "Span</i> and 0456 <i>Revenue code</i> all point at the National "
            "Uniform Billing Committee, and the chapter declares a concept "
            "domain for each rather than a code set. This guide therefore "
            "writes nothing for them, which is correct. The dangling value "
            "sets are THO's, and they predate us. "
            "0895 <i>Present On Admission (POA) Indicator</i> is the same "
            "shape but arrives by a different route: this project has it on "
            "the needs-decision list because its Content Logical Definition is "
            "not one of the shapes we build. "
            "Two neighbouring cases are <b>not</b> defects and should not be "
            "swept in: 0005 <i>Race</i> and 0292 <i>Vaccines Administered</i> "
            "also have THO value sets with no v2 code system, but they compose "
            "from the CDC race codes and CVX respectively &mdash; an external "
            "authority owning the codes is the intended arrangement, not a "
            "gap.",
        "ask":
            "Decide what should happen to the four. Either the missing v2 code "
            "systems should be published, or the value sets should compose "
            "from the external authority that actually owns the codes (NUBC "
            "for three of them), or they should be retired. Whichever way it "
            "goes, it is worth asking how four unexpandable value sets came to "
            "be published, because the same process would produce more.",
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
    },
    {
        "id": "esc-oid-conflicts",
        "who": "V2 Management + TSMG",
        "tables": "0001, 0078, 0719",
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
            "<b>For 0078 the question is what this guide should publish</b>, "
            "since neither source needs correcting. Three options: <b>(a)</b> "
            "keep the chapter's identifier, which is fidelity and creates the "
            "collision; <b>(b)</b> publish "
            "<code>ValueSet/v2-0078</code> at its own canonical with no "
            "identifier, which avoids the collision at the cost of dropping "
            "something the chapter prints; <b>(c)</b> treat table 0078's "
            "value set as an alias of "
            "<code>v3-ObservationInterpretation</code> and publish no "
            "separate artifact, which the identical compose would support. "
            "<b>Option (b) is not something this project will do on its own "
            "initiative.</b> Silently dropping a published identifier is the "
            "same class of act as silently changing one, and the policy's "
            "&ldquo;extreme care must be taken with identifiers&rdquo; cuts "
            "both ways. It needs a ruling.",
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
            "Items a committee has ruled on since this register was opened.",
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
