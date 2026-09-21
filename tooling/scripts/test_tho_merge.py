#!/usr/bin/env python3
"""Tests for the additive merge of THO's content into Chapter 2C's.

The rule under test throughout: where THO has content and the chapter has no
opinion, THO's survives; where both have something and they differ, the
chapter wins and the disagreement is recorded. Getting the first half wrong
deletes text from an artifact published at somebody else's canonical; getting
the second half wrong silently overwrites the chapter this guide exists to
publish. Both directions are worth a test.

Run:
    python3 -m pytest tooling/scripts/test_tho_merge.py
"""

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import tho_merge  # noqa: E402


def chapter_row(code="F", **overrides):
    row = {
        "code": code,
        "display": "Female",
        "definition": None,
        "designations": [],
        "properties": [],
        "elementId": None,
        "origin": "chapter",
    }
    row.update(overrides)
    return row


def tho_concept(code="F", **overrides):
    concept = {"id": "100", "code": code, "display": "Female"}
    concept.update(overrides)
    return concept


def merge_one(row, concept):
    observe = tho_merge.Observations()
    context = {"table": "0001", "resource": "CodeSystem", "code": row["code"]}
    merged = tho_merge.merge_concept(row, concept, observe, context)
    return merged, observe.records


# --------------------------------------------------------------------------
# What counts as a difference
# --------------------------------------------------------------------------

def test_whitespace_is_not_a_difference():
    """358 of 396 descriptions differ from THO's only in line wrapping. A
    version number is too expensive to spend on that."""
    assert tho_merge.normalize("a  b\nc") == tho_merge.normalize("a b c")


def test_a_placeholder_counts_as_the_chapter_having_no_opinion():
    """Table 0001's description reads `tbd` against THO's two sentences."""
    assert tho_merge.is_absent("tbd")
    assert tho_merge.is_absent("  ")
    assert not tho_merge.is_absent("A real description.")


# --------------------------------------------------------------------------
# Concepts
# --------------------------------------------------------------------------

def test_a_definition_the_chapter_lacks_is_kept_from_tho():
    merged, records = merge_one(chapter_row(),
                                tho_concept(definition="Female"))
    assert merged["definition"] == "Female"
    assert [r["kind"] for r in records] == ["fill"]


def test_a_definition_both_carry_is_the_chapters_and_is_reported():
    merged, records = merge_one(chapter_row(definition="The female sex."),
                                tho_concept(definition="Female"))
    assert merged["definition"] == "The female sex."
    assert records[0]["kind"] == "discrepancy"
    assert records[0]["tho"] == "Female"


def test_a_definition_only_the_chapter_carries_is_an_addition():
    merged, records = merge_one(chapter_row(definition="The female sex."),
                                tho_concept())
    assert merged["definition"] == "The female sex."
    assert records[0]["kind"] == "addition"


def test_a_definition_differing_only_in_whitespace_is_not_reported():
    _merged, records = merge_one(chapter_row(definition="a b"),
                                 tho_concept(definition="a  b"))
    assert records == []


def test_translations_are_kept_because_the_chapter_cannot_express_them():
    designation = {"language": "de", "value": "weiblich"}
    merged, records = merge_one(chapter_row(),
                                tho_concept(designation=[designation]))
    assert merged["designations"] == [designation]
    assert records[0]["kind"] == "fill"
    assert records[0]["languages"] == ["de"]


def test_a_property_only_tho_carries_is_kept():
    merged, records = merge_one(
        chapter_row(),
        tho_concept(property=[{"code": "HL7usageNotes",
                               "valueString": "Use with care."}]))
    assert ("HL7usageNotes", "valueString", "Use with care.") in merged["properties"]
    assert records[0]["kind"] == "fill"


def test_a_property_both_carry_with_different_values_keeps_the_chapters():
    merged, records = merge_one(
        chapter_row(properties=[("status", "valueCode", "active")]),
        tho_concept(property=[{"code": "status", "valueCode": "N"}]))
    assert merged["properties"] == [("status", "valueCode", "active")]
    assert records[0]["kind"] == "discrepancy"
    assert records[0]["ours"] == "active"


def test_a_property_only_the_chapter_carries_is_an_addition():
    _merged, records = merge_one(
        chapter_row(properties=[("v2-concComment", "valueString", "A note.")]),
        tho_concept())
    assert [r["kind"] for r in records] == ["addition"]


def test_an_inherited_concept_keeps_thos_element_id():
    """UTG numbers concepts from a repository-wide counter, so inventing an id
    for a concept that already has one would collide."""
    merged, _records = merge_one(chapter_row(), tho_concept(id="742"))
    assert merged["elementId"] == "742"


# --------------------------------------------------------------------------
# Concept lists
# --------------------------------------------------------------------------

def test_a_code_only_tho_has_is_added_after_the_chapters_own():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_concepts(
        [chapter_row("F")],
        {"concept": [tho_concept("F"), tho_concept("M", display="Male")]},
        observe, "0001")
    assert [row["code"] for row in merged] == ["F", "M"]
    assert merged[1]["origin"] == "tho"
    assert any(r["kind"] == "fill" and r["element"] == "concept"
               for r in observe.records)


def test_a_code_only_the_chapter_has_is_kept_and_reported():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_concepts(
        [chapter_row("F"), chapter_row("Z", display="Zebra")],
        {"concept": [tho_concept("F")]}, observe, "0001")
    assert [row["code"] for row in merged] == ["F", "Z"]
    assert any(r["kind"] == "addition" and r["code"] == "Z"
               for r in observe.records)


def test_reordering_alone_is_not_a_change():
    """Concept order is not information in a flat code system, and treating a
    reshuffle as a change would spend a version number on nothing."""
    rows = [chapter_row("F"), chapter_row("M", display="Male")]
    tho = {"concept": [tho_concept("M", display="Male"), tho_concept("F")]}
    assert not tho_merge.concepts_changed(rows, tho)


def test_a_different_display_is_a_change():
    rows = [chapter_row("F", display="Woman")]
    assert tho_merge.concepts_changed(rows, {"concept": [tho_concept("F")]})


def test_an_extra_code_is_a_change():
    rows = [chapter_row("F"), chapter_row("Z")]
    assert tho_merge.concepts_changed(rows, {"concept": [tho_concept("F")]})


def test_element_ids_are_not_content():
    rows = [chapter_row("F", elementId="999")]
    assert not tho_merge.concepts_changed(rows, {"concept": [tho_concept("F")]})


# --------------------------------------------------------------------------
# Resource-level fields
# --------------------------------------------------------------------------

def test_a_placeholder_description_is_replaced_by_thos():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_fields(
        {"description": "tbd"}, {"description": "A real one."},
        ("description",), observe, {"table": "0001", "resource": "CodeSystem"})
    assert merged["description"] == "A real one."
    assert observe.records[0]["kind"] == "fill"


def test_a_real_description_is_not_replaced():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_fields(
        {"description": "Ours."}, {"description": "Theirs."},
        ("description",), observe, {"table": "0001", "resource": "CodeSystem"})
    assert merged["description"] == "Ours."
    assert observe.records == []


def test_changed_fields_ignores_whitespace_and_names_the_rest():
    observe = tho_merge.Observations()
    changed = tho_merge.changed_fields(
        {"name": "A  name", "title": "Ours"},
        {"name": "A name", "title": "Theirs"},
        ("name", "title"), observe, {"table": "0001", "resource": "CodeSystem"})
    assert changed == ["title"]


def test_a_boolean_from_tho_compares_against_our_string():
    """THO's JSON has `false`; our XML has `"false"`."""
    observe = tho_merge.Observations()
    changed = tho_merge.changed_fields(
        {"experimental": "false"}, {"experimental": False},
        ("experimental",), observe, {"table": "0001", "resource": "CodeSystem"})
    assert changed == []


# --------------------------------------------------------------------------
# Value set composes
# --------------------------------------------------------------------------

def enumerated(*codes):
    return {"include": [{"system": "http://x",
                         "concept": [{"code": c, "display": c} for c in codes]}],
            "exclude": []}


def test_a_code_tho_enumerates_is_added():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_compose(
        enumerated("A"),
        {"compose": {"include": [{"system": "http://x",
                                  "concept": [{"code": "A", "display": "A"},
                                              {"code": "B", "display": "B"}]}]}},
        observe, {"table": "0001", "resource": "ValueSet"})
    assert [c["code"] for c in merged["include"][0]["concept"]] == ["A", "B"]
    assert observe.records[0]["kind"] == "fill"


def test_codes_are_not_spliced_into_an_all_codes_include():
    """"All codes" and an enumeration do not mean the same thing, so merging
    across the difference would change what the value set says."""
    observe = tho_merge.Observations()
    compose = {"include": [{"system": "http://x"}], "exclude": []}
    merged = tho_merge.merge_compose(
        compose,
        {"compose": {"include": [{"system": "http://x",
                                  "concept": [{"code": "A"}]}]}},
        observe, {"table": "0001", "resource": "ValueSet"})
    assert "concept" not in merged["include"][0]
    assert observe.records == []


def test_a_reordered_compose_is_not_a_change():
    assert not tho_merge.compose_changed(
        enumerated("A", "B"),
        {"compose": {"include": [{"system": "http://x",
                                  "concept": [{"code": "B", "display": "B"},
                                              {"code": "A", "display": "A"}]}]}})


def test_an_extra_member_is_a_compose_change():
    assert tho_merge.compose_changed(
        enumerated("A", "B"),
        {"compose": {"include": [{"system": "http://x",
                                  "concept": [{"code": "A", "display": "A"}]}]}})


# --------------------------------------------------------------------------
# The snapshot
# --------------------------------------------------------------------------

def test_a_missing_snapshot_directory_is_not_an_error(tmp_path):
    """The builders have to work without a 2,000-file package on disk."""
    snapshot = tho_merge.ThoSnapshot(tmp_path / "nowhere")
    assert snapshot.available is False
    assert snapshot.code_system("0001") is None
    assert snapshot.code_system_tables() == set()


def test_a_value_set_is_looked_up_by_canonical_not_table_number(tmp_path):
    """Four tables publish at a `v2-notAllCodes-NNNN` canonical, and the URL is
    what decides which artifact we are editing."""
    import json
    (tmp_path / "ValueSet-v2-notAllCodes-0291.json").write_text(json.dumps({
        "resourceType": "ValueSet",
        "url": "http://terminology.hl7.org/ValueSet/v2-notAllCodes-0291",
        "version": "3.0.0"}))
    snapshot = tho_merge.ThoSnapshot(tmp_path)
    found = snapshot.value_set(
        "http://terminology.hl7.org/ValueSet/v2-notAllCodes-0291")
    assert found["version"] == "3.0.0"
    assert snapshot.value_set(
        "http://terminology.hl7.org/ValueSet/v2-0291") is None


# --------------------------------------------------------------------------
# Editorial differences
# --------------------------------------------------------------------------

def test_a_comma_is_an_editorial_difference():
    """Eight tables differ from THO only by `e.g.,` against `e.g.`."""
    assert tho_merge.is_editorial("the type of outlier (i.e., period of care)",
                                  "the type of outlier (i.e. period of care)")


def test_a_stray_space_before_a_full_stop_is_editorial():
    assert tho_merge.is_editorial("confidentiality code system.",
                                  "confidentiality code system .")


def test_extra_words_are_not_editorial():
    """THO's description of 0227 carries a source URL the chapter's does not;
    dropping it is a content decision, not a typo fix."""
    assert not tho_merge.is_editorial(
        "The source of this code system is the CDC.",
        "The source of this code system is the CDC. See https://example.org.")


def test_an_empty_text_is_never_editorial():
    assert not tho_merge.is_editorial("", "")


def test_a_punctuation_only_description_increments_and_says_it_was_punctuation():
    """Every description difference is a change. That it was only a comma is
    recorded, so a reader can see what the increment rests on, but it does not
    exempt the artifact."""
    observe = tho_merge.Observations()
    changed = tho_merge.changed_fields(
        {"description": "A system (e.g., this)."},
        {"description": "A system (e.g. this)."},
        ("description",), observe, {"table": "0083", "resource": "CodeSystem"})
    assert changed == ["description"]
    assert observe.records[0]["editorial"] is True


def test_no_field_is_exempt_from_counting_as_a_change():
    """Guards the removed carve-out: nothing may reintroduce a field whose
    differences are waived."""
    assert not hasattr(tho_merge, "EDITORIAL_FIELDS")


def test_a_substantive_description_still_increments():
    observe = tho_merge.Observations()
    changed = tho_merge.changed_fields(
        {"description": "A system."}, {"description": "A system. See docs."},
        ("description",), observe, {"table": "0227", "resource": "ValueSet"})
    assert changed == ["description"]
    assert observe.records[0]["editorial"] is False


def test_the_waiver_does_not_extend_beyond_the_description():
    """The policy grants the carve-out to `description` alone. The same
    punctuation difference in a title is still a change."""
    observe = tho_merge.Observations()
    changed = tho_merge.changed_fields(
        {"title": "A title."}, {"title": "A title"},
        ("title",), observe, {"table": "0001", "resource": "CodeSystem"})
    assert changed == ["title"]


# --------------------------------------------------------------------------
# Identifiers
# --------------------------------------------------------------------------

def tho_with_oid(oid):
    return {"identifier": [{"value": f"urn:oid:{oid}"}]}


def test_an_oid_tho_has_and_the_chapter_lacks_is_kept():
    """Publishing without it would be *removing* an identifier, which the
    policy says needs a whole new artifact."""
    observe = tho_merge.Observations()
    oid, changed = tho_merge.merge_identifier(
        "-", tho_with_oid("2.16.840.1.113883.18.455"), observe,
        {"table": "0560", "resource": "CodeSystem"})
    assert oid == "2.16.840.1.113883.18.455"
    assert changed == []
    assert observe.records[0]["kind"] == "fill"


def test_a_matching_oid_is_not_a_change():
    observe = tho_merge.Observations()
    _oid, changed = tho_merge.merge_identifier(
        "2.16.840.1.113883.18.2", tho_with_oid("2.16.840.1.113883.18.2"),
        observe, {"table": "0001", "resource": "CodeSystem"})
    assert changed == []
    assert observe.records == []


def test_a_conflicting_oid_defers_to_tho():
    """The one place "the chapter wins" does not reach. An identifier is
    identity, not content: the canonical is THO's and the policy forbids
    changing a published identifier, so writing the chapter's OID there would
    assert this is a different artifact. See the register's
    `esc-oid-conflicts`."""
    observe = tho_merge.Observations()
    oid, changed = tho_merge.merge_identifier(
        "2.16.840.1.113883.18.458", tho_with_oid("2.16.840.1.113883.18.2"),
        observe, {"table": "0001", "resource": "CodeSystem"})
    assert oid == "2.16.840.1.113883.18.2"
    assert changed == []
    assert observe.records[0]["kind"] == "discrepancy"
    assert observe.records[0]["published"] == "tho"


def test_adding_an_oid_tho_lacks_is_an_ordinary_increment():
    observe = tho_merge.Observations()
    _oid, changed = tho_merge.merge_identifier(
        "2.16.840.1.113883.18.2", {"url": "http://x"}, observe,
        {"table": "0001", "resource": "CodeSystem"})
    assert changed == ["identifier.added"]


def test_the_noObject_marker_counts_as_no_value():
    """Table 0560's code system block is the marker, with five codes under
    it."""
    assert tho_merge.is_absent("noObject")
    assert tho_merge.is_absent("noDescription")


def test_a_placeholder_in_tho_is_not_worth_keeping():
    """All five of table 0560's concepts are defined in THO as
    "no definition"; copying that across would publish nonsense."""
    merged, records = merge_one(chapter_row(definition=""),
                                tho_concept(definition="no definition"))
    assert merged["definition"] in (None, "")
    assert records == []


def test_none_is_a_real_value_not_a_placeholder():
    """Seven THO concepts have the display `None` and the definition `None`,
    where None is the answer rather than the absence of one."""
    assert not tho_merge.is_absent("None")
    merged, _records = merge_one(chapter_row(definition=""),
                                 tho_concept(definition="None"))
    assert merged["definition"] == "None"


def test_an_empty_column_on_both_sides_is_not_an_addition():
    """A chapter row carries "" for a column the chapter does not fill.
    Reporting that as content this guide contributes inflated the fill report
    by 266 records."""
    _merged, records = merge_one(chapter_row(definition=""),
                                 tho_concept(definition=None))
    assert records == []


def test_a_real_value_against_nothing_in_tho_is_still_an_addition():
    _merged, records = merge_one(chapter_row(definition="A real one."),
                                 tho_concept(definition=""))
    assert [r["kind"] for r in records] == ["addition"]


# --------------------------------------------------------------------------
# Truncation recovery
# --------------------------------------------------------------------------

def test_a_description_cut_mid_sentence_is_recovered_from_tho():
    """The chapter's value set descriptions were cut at a length cap. Where
    THO continues past the cut it holds the lost words, so it is the chapter
    being incomplete rather than the two disagreeing."""
    observe = tho_merge.Observations()
    merged = tho_merge.merge_fields(
        {"description": "Codes are maintained by the CDC and may be acce"},
        {"description": "Codes are maintained by the CDC and may be accessed "
                        "at the source registry."},
        ("description",), observe, {"table": "0227", "resource": "ValueSet"})
    assert merged["description"].endswith("source registry.")
    assert observe.records[0]["kind"] == "fill"


def test_a_complete_sentence_tho_extends_is_not_recovered():
    """0719: the chapter's text is complete and THO appended a note recording
    its own error. That is THO adding something, not the chapter losing it,
    and the chapter wins."""
    observe = tho_merge.Observations()
    ours = "The value set is defined for sensitivity policy."
    merged = tho_merge.merge_fields(
        {"description": ours},
        {"description": ours + " Note that this resource was created in error."},
        ("description",), observe, {"table": "0719", "resource": "ValueSet"})
    assert merged["description"] == ours


def test_recovery_does_not_reach_names_or_titles():
    """A name that is a prefix of THO's is a disagreement, not a truncation."""
    observe = tho_merge.Observations()
    merged = tho_merge.merge_fields(
        {"name": "VaccinesAdministered"},
        {"name": "VaccinesAdministeredCodeSet"},
        ("name",), observe, {"table": "0292", "resource": "ValueSet"})
    assert merged["name"] == "VaccinesAdministered"


def test_recovery_needs_a_real_prefix_not_merely_a_difference():
    observe = tho_merge.Observations()
    merged = tho_merge.merge_fields(
        {"description": "alpha beta"}, {"description": "alpha gamma"},
        ("description",), observe, {"table": "0001", "resource": "ValueSet"})
    assert merged["description"] == "alpha beta"


# --------------------------------------------------------------------------
# Differences that are not disagreements
# --------------------------------------------------------------------------

def test_a_case_only_difference_is_classified_as_case():
    result = tho_merge.presentation_difference("dentist office number",
                                               "Dentist Office Number")
    assert result["kind"] == "case"


def test_case_is_checked_before_punctuation():
    """words() lowercases, so without ordering every case-only pair would be
    reported as a punctuation difference and lose its direction."""
    result = tho_merge.presentation_difference("dataAbsentReason",
                                               "DataAbsentReason")
    assert result["kind"] == "case"


def test_tho_adding_capitals_is_recorded_as_such():
    result = tho_merge.presentation_difference("dentist identifier",
                                               "Dentist Identifier")
    assert result["direction"] == "tho-added"


def test_tho_dropping_capitals_is_recorded_as_such():
    """THO lower-casing "For" to "for" is correct title case, so this is
    surfaced for review rather than treated as a defect -- but it must be
    distinguishable from THO adding capitals, which is kept silently."""
    result = tho_merge.presentation_difference("Sex Parameter For Clinical Use",
                                               "Sex Parameter for Clinical Use")
    assert result["kind"] == "case"
    assert result["direction"] == "tho-dropped"


def test_a_punctuation_difference_is_classified_as_punctuation():
    result = tho_merge.presentation_difference("Dentist, office number",
                                               "Dentist office number")
    assert result["kind"] == "punctuation"


def test_a_spacing_difference_is_classified_as_spacing():
    result = tho_merge.presentation_difference("HealthCare", "Health Care")
    assert result["kind"] == "spacing"


def test_genuinely_different_text_is_not_a_presentation_difference():
    assert tho_merge.presentation_difference("Dentist identifier",
                                             "Physician identifier") is None


def test_identical_text_is_not_a_difference_at_all():
    assert tho_merge.presentation_difference("same", "same") is None
    assert tho_merge.presentation_difference("same  text", "same text") is None


def test_an_empty_side_is_never_a_presentation_difference():
    """Absent content is a fill or an addition, not a difference in styling."""
    assert tho_merge.presentation_difference("", "Something") is None
    assert tho_merge.presentation_difference("Something", "   ") is None


def test_non_text_is_not_a_presentation_difference():
    assert tho_merge.presentation_difference(None, "x") is None
    assert tho_merge.presentation_difference(3, "3") is None


def test_thos_status_letter_against_our_reading_is_not_a_disagreement():
    """THO carries the V2 letter, we carry the FHIR status it maps to. The
    ruling already existed; it was only being applied on one of two paths."""
    assert tho_merge.is_status_letter_reading("active", "N")
    assert tho_merge.is_status_letter_reading("deprecated", "B")


def test_two_fhir_statuses_that_differ_is_a_real_disagreement():
    """Both sides using FHIR codes and disagreeing is a genuine difference
    about the concept's standing, and must stay visible."""
    assert not tho_merge.is_status_letter_reading("deprecated", "active")
    assert not tho_merge.is_status_letter_reading("active", "deprecated")


def test_recognising_a_status_letter_does_not_rewrite_it():
    """STATUS_LETTER_READINGS is for classification only. The rewriting table
    is INHERITED_STATUS_CORRECTIONS, and widening one must not widen the
    other -- adding B here changes no published value."""
    assert "B" in tho_merge.STATUS_LETTER_READINGS
    assert "B" not in tho_merge.INHERITED_STATUS_CORRECTIONS


# --------------------------------------------------------------------------
# The capitalisation carve-out (ADR-0012)
# --------------------------------------------------------------------------
#
# The one place THO's text is published over the chapter's. Narrow on purpose:
# display only, case only, and only where THO is the more capitalised side.

def test_thos_capitalisation_of_a_display_is_published():
    merged, records = merge_one(
        chapter_row(display="dentist office number"),
        tho_concept(display="Dentist Office Number"))
    assert merged["display"] == "Dentist Office Number"


def test_taking_thos_casing_is_recorded_as_what_was_published():
    _merged, records = merge_one(
        chapter_row(display="dentist office number"),
        tho_concept(display="Dentist Office Number"))
    discrepancy = next(r for r in records if r["kind"] == "discrepancy")
    assert discrepancy["publishedValue"] == "Dentist Office Number"
    assert discrepancy["presentation"]["direction"] == "tho-added"


def test_the_chapter_keeps_its_casing_when_tho_dropped_capitals():
    """THO having FEWER capitals is surfaced for review, not absorbed -- it
    may be correct title case or it may be a lost proper noun."""
    merged, records = merge_one(
        chapter_row(display="Sex Parameter For Clinical Use"),
        tho_concept(display="Sex Parameter for Clinical Use"))
    assert merged["display"] == "Sex Parameter For Clinical Use"
    discrepancy = next(r for r in records if r["kind"] == "discrepancy")
    assert "publishedValue" not in discrepancy


def test_the_carve_out_does_not_reach_definitions():
    """A case difference in a definition is likelier to carry meaning, and
    nothing has ruled on it."""
    merged, _records = merge_one(
        chapter_row(display="Female", definition="female patient"),
        tho_concept(display="Female", definition="Female Patient"))
    assert merged["definition"] == "female patient"


def test_the_carve_out_does_not_reach_a_real_wording_difference():
    merged, _records = merge_one(
        chapter_row(display="Dentist identifier"),
        tho_concept(display="Physician identifier"))
    assert merged["display"] == "Dentist identifier"
