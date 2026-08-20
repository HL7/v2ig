#!/usr/bin/env python3
"""Tests for the Chapter 2C vocabulary text policy.

The policy decides what the extraction is allowed to change in the published
text, so the cases that matter most are the ones it must NOT change. Every
"leave it alone" test below is drawn from a real value in Chapter 2C. Run with:

    python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
"""

import pytest

from vocabulary_text_policy import (
    MANUAL_CORRECTIONS,
    MISSING_SPACE_CORRECTIONS,
    add_comma_after_abbreviation,
    apply_manual_corrections,
    apply_text_policy,
    is_descriptive_field,
    missing_space_after_period_sites,
    normalize_dash_spacing,
    unresolved_space_runs,
)


def emitted(field, text):
    """The text as the policy would emit it, discarding the rule detail."""
    return apply_text_policy(field, text)[0]


def kinds(field, text):
    """The rule kinds that fired, in order."""
    return [kind for kind, _, _, _ in apply_text_policy(field, text)[1]]


class TestSpacesAfterAPeriod:
    """ADR-0008 D3."""

    def test_two_spaces_after_a_period_become_one(self):
        assert emitted("Description", "Specifies the room type.  Used in RMC.") \
            == "Specifies the room type. Used in RMC."

    def test_longer_runs_also_collapse(self):
        assert emitted("Description", "Partial results.   Deprecated.") \
            == "Partial results. Deprecated."

    def test_each_place_is_counted(self):
        _, applied = apply_text_policy("Description", "One.  Two.  Three.  Four.")
        assert applied == [("double_space_after_period", 3,
                            "One.  Two.  Three.  Four.", "One. Two. Three. Four.")]

    def test_a_single_space_is_untouched(self):
        assert kinds("Description", "One. Two.") == []

    def test_a_double_space_not_after_a_period_is_left_to_other_rules(self):
        # D3 covers the space after a period and nothing else. This run is
        # mid-sentence, so it belongs to D7's general collapse -- the point of
        # the test is which decision claims it, not whether it changes.
        text = "Code system of concepts  which specify the room type."
        assert kinds("Description", text) == ["repeated_space_collapsed"]

    def test_tabs_and_newlines_after_a_period_are_not_spaces(self):
        assert emitted("Description", "One.\t\tTwo.") == "One.\t\tTwo."
        assert emitted("Description", "One.\n\nTwo.") == "One.\n\nTwo."

    def test_a_non_breaking_space_is_not_an_ordinary_space(self):
        # Built with chr() on purpose: a literal U+00A0 in this file is
        # invisible, and one stray edit would silently turn this test into a
        # duplicate of the ordinary-space case above.
        nbsp = chr(0x00A0)
        # D7 turns the run into one ordinary space first, so D3 never sees a
        # double space to collapse.
        assert kinds("Description", f"One.{nbsp}{nbsp}Two.") == [
            "non_breaking_space_in_text"]
        # Here it does leave one, and D3 -- not the non-breaking-space rule --
        # is what collapses it.
        assert kinds("Description", f"One.{nbsp} Two.") == [
            "non_breaking_space_in_text", "double_space_after_period"]
        assert emitted("Description", f"One.{nbsp} Two.") == "One. Two."


class TestSpacesAfterASentenceClose:
    """ADR-0008 D4: a closing quote or bracket between the period and the spaces."""

    @pytest.mark.parametrize("closer", ['"', "'", "’", "”", ")", "]"])
    def test_each_closer_is_recognized(self, closer):
        text = f"Sent as preliminary.{closer}  See the note."
        assert emitted("comment", text) == f"Sent as preliminary.{closer} See the note."

    def test_the_real_published_example(self):
        text = "Material is solid and sharp (e.g., cannulas.)  Dispose in hard container."
        assert emitted("comment", text) == (
            "Material is solid and sharp (e.g., cannulas.) Dispose in hard container.")

    def test_a_closer_without_a_preceding_period_is_untouched(self):
        # "(see below)  and then" is not a sentence end, so D4 does not claim
        # it. D7's general collapse does.
        text = "Applies to the first form (see below)  and then to the second."
        assert kinds("comment", text) == ["repeated_space_collapsed"]


class TestSpacesAfterAComma:
    """ADR-0008 D4."""

    def test_two_spaces_after_a_comma_become_one(self):
        assert emitted("comment", "Electrocardiac (e.g., EKG,  EEC, Holter)") \
            == "Electrocardiac (e.g., EKG, EEC, Holter)"


class TestRepeatedSpacesInDisplayName:
    """ADR-0008 D4: display names get every run collapsed, wherever it sits."""

    def test_a_mid_sentence_run_is_collapsed_in_a_display_name(self):
        assert emitted("displayName", "Order Acknowledgment Message  - Multiple") \
            == "Order Acknowledgment Message - Multiple"

    def test_the_same_run_is_attributed_to_d7_in_a_description(self):
        # The display-name sweep is confined to displayName. In a description
        # the identical run is D7's, which matters because the two decisions
        # are counted separately in the change log.
        text = "Code system of concepts  which specify the room type"
        assert kinds("Description", text) == ["repeated_space_collapsed"]
        assert kinds("displayName", text) == ["repeated_space_in_display_name"]

    def test_a_period_run_in_a_display_name_is_attributed_to_the_period_rule(self):
        # Both rules could collapse it; the more specific one runs first so the
        # change log attributes it to the decision that authorized it.
        assert kinds("displayName", "Marked for purge.  User may not update.") \
            == ["double_space_after_period"]


class TestDashSpacing:
    """ADR-0008 D5. Spacing is adjusted, never inserted around a tight dash."""

    def test_a_separator_with_too_many_spaces_is_normalized(self):
        assert normalize_dash_spacing("ADT/ACK -  Register a patient") \
            == ("ADT/ACK - Register a patient", 1)

    def test_a_missing_space_after_the_dash_is_added(self):
        assert normalize_dash_spacing("RSP -Dispense History Response") \
            == ("RSP - Dispense History Response", 1)

    def test_a_missing_space_before_the_dash_is_added(self):
        assert normalize_dash_spacing("OMQ- General Order Message") \
            == ("OMQ - General Order Message", 1)

    def test_an_en_dash_keeps_its_character(self):
        assert normalize_dash_spacing("Message  – Multiple Order") \
            == ("Message – Multiple Order", 1)

    def test_a_correctly_spaced_separator_is_untouched(self):
        assert normalize_dash_spacing("ERP - Event Replay Response") \
            == ("ERP - Event Replay Response", 0)

    def test_a_double_hyphen_keeps_both_hyphens(self):
        assert normalize_dash_spacing("Results entered -- not verified") \
            == ("Results entered -- not verified", 0)

    # --- the exclusions, each from a real Chapter 2C value ----------------

    @pytest.mark.parametrize("text", [
        "HL7-defined code system of concepts",
        "ICD-10 procedure codes",
        "The UB-04 form",
        "de-identified data",
        "http://www.gpo.gov/fdsys/pkg/CFR-2017-title45-vol1/pdf/CFR.pdf",
        "OBR-32 and OBR-33",
    ])
    def test_a_tight_dash_is_never_given_spaces(self, text):
        assert normalize_dash_spacing(text) == (text, 0)

    @pytest.mark.parametrize("text", [
        "Keep at frozen temperature: -4( C.",
        "Deep frozen: -16 to -20( C.",
        "Ultra cold frozen: ~ -75 to -85( C.",
    ])
    def test_a_minus_sign_is_not_a_separator(self, text):
        assert normalize_dash_spacing(text) == (text, 0)

    def test_the_dash_of_plus_or_minus_is_not_a_separator(self):
        text = "approximately 22 +/- 2 degrees C"
        assert normalize_dash_spacing(text) == (text, 0)

    @pytest.mark.parametrize("text", [
        "Source: OPS Operationen- und Prozedurenschlussel 2023.",
        "Covers pre- and post-operative care.",
        "Either inter- or intra-departmental.",
    ])
    def test_a_suspended_hyphen_is_not_a_separator(self, text):
        assert normalize_dash_spacing(text) == (text, 0)

    def test_a_dash_before_a_line_break_is_left_alone(self):
        text = "Share To Be Determined -\nCategory to be determined"
        assert normalize_dash_spacing(text) == (text, 0)

    def test_a_dash_at_the_start_of_a_line_is_left_alone(self):
        text = "Examples:\n- first item\n- second item"
        assert normalize_dash_spacing(text) == (text, 0)

    @pytest.mark.parametrize("text", [
        "Message is not -conformant with the applicable specification",
        "Emergency -stop",
    ])
    def test_a_lowercase_follower_means_the_hyphen_belongs_to_that_word(self, text):
        # A separator introduces a phrase; every genuine one in Chapter 2C is
        # followed by a capital or a digit. Spacing these out would make the
        # published defect worse.
        assert normalize_dash_spacing(text) == (text, 0)

    @pytest.mark.parametrize("text,expected", [
        ("RSP -Dispense History Response", "RSP - Dispense History Response"),
        ("4 -Deprecated", "4 - Deprecated"),
        ("Sterilization -Federally Funded", "Sterilization - Federally Funded"),
    ])
    def test_a_capitalized_or_numeric_follower_is_still_a_separator(self, text, expected):
        assert normalize_dash_spacing(text) == (expected, 1)

    def test_the_exclusion_does_not_apply_when_the_space_is_after_the_dash(self):
        # "mutation- more than 3 million" -- the space after the dash marks the
        # phrase break, so a lowercase follower is fine here.
        assert normalize_dash_spacing("per unique mutation- more than 3 million") \
            == ("per unique mutation - more than 3 million", 1)

    def test_a_dash_followed_by_punctuation_is_left_alone(self):
        # "Default -.will be assumed" -- a defect the rule cannot repair.
        text = "Default -.will be assumed when this field is empty"
        assert normalize_dash_spacing(text) == (text, 0)


class TestCommaAfterAbbreviation:
    """ADR-0008 D6. The one rule that adds a character."""

    def test_a_comma_is_added_after_e_g(self):
        assert add_comma_after_abbreviation("Washing, e.g. bronchial washing") \
            == ("Washing, e.g., bronchial washing", 1)

    def test_a_comma_is_added_after_i_e(self):
        assert add_comma_after_abbreviation('at birth. i.e. "Baby of Smith"') \
            == ('at birth. i.e., "Baby of Smith"', 1)

    @pytest.mark.parametrize("text,expected", [
        ("regarding immunization. E.g. From school, provider",
         "regarding immunization. E.g., From school, provider"),
        ("biological materials. I.e. potential risk of infection",
         "biological materials. I.e., potential risk of infection"),
    ])
    def test_the_capitalized_forms_are_matched_and_keep_their_case(self, text, expected):
        assert add_comma_after_abbreviation(text) == (expected, 1)

    def test_an_existing_comma_is_not_doubled(self):
        text = "Sources can include human (e.g., a respiratory therapist)"
        assert add_comma_after_abbreviation(text) == (text, 0)

    def test_a_colon_introducing_a_list_is_left_alone(self):
        # "e.g.,:" would be wrong. Five real values look like this.
        text = "assigned numerically, e.g.:\n•\tTier 1\n•\tTier 2"
        assert add_comma_after_abbreviation(text) == (text, 0)

    def test_an_abbreviation_at_the_end_of_a_value_is_left_alone(self):
        assert add_comma_after_abbreviation("as described above, e.g.") \
            == ("as described above, e.g.", 0)


class TestFieldScope:
    """Which fields the policy may touch at all."""

    @pytest.mark.parametrize("field", [
        "Description", "definition", "comment", "displayName",
    ])
    def test_descriptive_fields_are_in_scope(self, field):
        assert is_descriptive_field(field)

    @pytest.mark.parametrize("field", [
        "value",                        # a code, never prose
        "SymbolicName", "Full Name",    # identifiers
        "URI", "URL", "Code System OID",
        "status",
        "Content Logical Definition",   # a value set expression
        "where used",                   # a list of segment references
        "Realm", "Effective Date",
    ])
    def test_other_fields_are_out_of_scope(self, field):
        assert not is_descriptive_field(field)

    def test_field_names_are_matched_exactly(self):
        # Guards against a loose substring match creeping in later.
        assert not is_descriptive_field("description")
        assert not is_descriptive_field("Descriptions")
        assert not is_descriptive_field("Long Description")

    def test_a_field_out_of_scope_is_left_alone(self):
        text = "Specifies a type.  Used in RMC."
        assert emitted("SymbolicName", text) == text

    def test_a_code_value_containing_periods_and_dashes_is_left_alone(self):
        assert emitted("value", "2.16.840.1.113883.1") == "2.16.840.1.113883.1"
        assert emitted("value", "ICD-10-CM") == "ICD-10-CM"

    def test_an_absent_value_stays_absent_rather_than_raising(self):
        # An absent value and an empty one mean different things in the
        # extracted corpus, so neither is turned into the other.
        assert apply_text_policy("Description", None) == (None, [])
        assert apply_text_policy("Description", "") == ("", [])


class TestRuleChain:
    """Several rules acting on one value."""

    def test_each_rule_reports_its_own_before_and_after(self):
        text = "See ORU -Result.  Applies to X, e.g. Y."
        result, applied = apply_text_policy("comment", text)
        assert result == "See ORU - Result. Applies to X, e.g., Y."
        assert [(kind, count) for kind, count, _, _ in applied] == [
            ("double_space_after_period", 1),
            ("dash_spacing", 1),
            ("missing_comma_after_abbreviation", 1),
        ]
        # Each entry brackets that rule alone, not the whole chain.
        period_before, period_after = applied[0][2], applied[0][3]
        assert period_before == text
        assert period_after == "See ORU -Result. Applies to X, e.g. Y."


class TestCorruptCharacters:
    """ADR-0008 D7: characters that should not be in the document at all."""

    def test_a_double_encoded_non_breaking_space_loses_its_stray_letter(self):
        nbsp = chr(0x00A0)
        text = f"...assigned number (for labs).Â{nbsp} Used by US DoD."
        assert emitted("definition", text) == (
            "...assigned number (for labs). Used by US DoD.")

    def test_the_repair_runs_before_the_space_rules(self):
        # Dropping the stray letter leaves a non-breaking space, which becomes
        # an ordinary one, which leaves a double space for D3. The chain only
        # gets there if the three rules run in that order.
        nbsp = chr(0x00A0)
        assert kinds("definition", f"One.Â{nbsp} Two.") == [
            "mojibake_non_breaking_space",
            "non_breaking_space_in_text",
            "double_space_after_period",
        ]

    def test_an_ordinary_a_circumflex_is_not_touched(self):
        # The repair fires on the pair, never on the letter by itself.
        assert emitted("definition", "Ângstrom units") == "Ângstrom units"

    def test_a_symbol_font_bullet_is_deleted_and_its_tab_kept(self):
        # Table 0964. The glyph means nothing outside Symbol; the tab that
        # follows it is what makes the line read as an indented list item.
        text = "Reasons:\n\tPatient disability requires it"
        assert emitted("Description", text) == (
            "Reasons:\n\tPatient disability requires it")

    def test_private_use_characters_go_from_identifiers_too(self):
        # Not confined to prose: a Symbol glyph is wrong wherever it lands.
        assert emitted("SymbolicName", "RoomType") == "RoomType"

    def test_ordinary_typography_survives(self):
        # Curly quotes, en dashes and bullets are published typography, not
        # corruption, and are none of this rule's business.
        text = "The code “SCT” — see • below"
        assert emitted("comment", text) == text


class TestNonBreakingSpaceInText:
    """ADR-0008 D7: a run of non-breaking spaces becomes one ordinary space."""

    def test_a_single_non_breaking_space_becomes_a_space(self):
        nbsp = chr(0x00A0)
        assert emitted("Description", f"taken from{nbsp}ISO 3166") == (
            "taken from ISO 3166")

    def test_a_run_becomes_one_space_not_several(self):
        nbsp = chr(0x00A0)
        assert emitted("Description", f"ISO 3166{nbsp}{nbsp}while the codes") == (
            "ISO 3166 while the codes")

    def test_a_url_keeps_its_own_rule(self):
        # A URL is not in COLLAPSE_FIELDS, so this rule does not fire there. A
        # non-breaking space in a URL is removed by the strip when it is at an
        # edge, and reported when it is not -- turning it into a space would
        # produce an invalid URL.
        nbsp = chr(0x00A0)
        text = f"http://example.org/a{nbsp}b"
        assert emitted("URL", text) == text


class TestNonBreakingSpaceBeforePunctuation:
    """ADR-0008 D10: it is deleted, not turned into an ordinary space."""

    def test_the_table_0827_case(self):
        nbsp = chr(0x00A0)
        text = f"...codes for statistical use (M49){nbsp}."
        assert emitted("Description", text) == (
            "...codes for statistical use (M49).")

    def test_it_runs_before_the_general_rule(self):
        # If the general rule went first the space would already be an ordinary
        # one and this rule would never see it, leaving `(M49) .` behind.
        nbsp = chr(0x00A0)
        assert kinds("Description", f"use (M49){nbsp}.") == [
            "nbsp_before_punctuation"]

    def test_an_ordinary_space_before_a_period_is_published_text(self):
        # Nineteen places in Chapter 2C print this and none of them is ours.
        assert emitted("comment", "Placer Applications .") == (
            "Placer Applications .")

    def test_a_non_breaking_space_elsewhere_still_becomes_a_space(self):
        # The narrow rule must not swallow the broad one's work.
        nbsp = chr(0x00A0)
        assert kinds("Description", f"taken from{nbsp}ISO 3166") == [
            "non_breaking_space_in_text"]

    def test_a_period_inside_a_value_is_not_closing_punctuation(self):
        # `2p16.3` -- the lookahead needs whitespace or end of value after the
        # period, or this rule would eat the space in a chromosome locus.
        nbsp = chr(0x00A0)
        text = f"the locus{nbsp}2p16.3 and others"
        assert emitted("comment", text) == "the locus 2p16.3 and others"

    def test_a_comma_semicolon_and_colon_count_too(self):
        nbsp = chr(0x00A0)
        for mark in ",;:":
            text = f"one{nbsp}{mark} two"
            assert emitted("comment", text) == f"one{mark} two"

    def test_it_does_not_reach_a_field_outside_the_collapse_set(self):
        # Same scope as the rule it precedes. A URI is not prose.
        nbsp = chr(0x00A0)
        text = f"http://example.org/a{nbsp}."
        assert emitted("URI", text) == text


class TestIndentsAndDittoMarks:
    """ADR-0008 D7: the two runs of spaces the collapse deliberately spares."""

    def test_an_indent_is_kept_at_two_spaces(self):
        text = "Examples:\n   NCPDP1131RES = code set defined for 1131"
        assert emitted("comment", text) == (
            "Examples:\n  NCPDP1131RES = code set defined for 1131")

    def test_a_wider_indent_narrows_to_two_as_well(self):
        assert emitted("comment", "Examples:\n      Indented") == (
            "Examples:\n  Indented")

    def test_an_indent_already_two_wide_is_left_exactly_as_is(self):
        text = "Examples:\n  Indented"
        assert emitted("comment", text) == text
        assert kinds("comment", text) == []

    def test_the_general_collapse_does_not_eat_the_indent(self):
        # Both rules apply to this value: the indent narrows to two, and the
        # mid-line run on the same line still collapses to one.
        text = "Examples:\n    Scottsdale, AZ  85260"
        assert emitted("comment", text) == "Examples:\n  Scottsdale, AZ 85260"

    def test_a_run_between_two_quote_marks_is_the_value(self):
        # Table 0496 uses a pair of ditto marks to mean "same as above".
        text = '""      "" w/o Surgery Capability'
        assert emitted("definition", text) == text
        assert kinds("definition", text) == []

    def test_a_run_next_to_only_one_quote_mark_still_collapses(self):
        # The protection needs a quote on BOTH sides; otherwise it would spare
        # ordinary spacing that happens to follow a quoted phrase.
        assert emitted("definition", 'the code "SCT"  applies here') == (
            'the code "SCT" applies here')


class TestFieldsAddedByD7:
    """Two non-prose fields the collapse rule covers, and only that rule."""

    def test_a_where_used_list_collapses(self):
        assert emitted("where used", "SPM-15, SAC-43,  PAC-7, OM4-15") == (
            "SPM-15, SAC-43, PAC-7, OM4-15")

    def test_a_content_logical_definition_collapses(self):
        text = "Include codes from http://snomed.info/sct   where concept is-a 49062001"
        assert emitted("Content Logical Definition", text) == (
            "Include codes from http://snomed.info/sct where concept is-a 49062001")

    def test_the_prose_rules_stay_out_of_these_fields(self):
        # D6 would add a comma and D5 would space the dash; neither has any
        # business editing a reference list or a value set expression.
        assert emitted("where used", "OBR-32, e.g. see below") == (
            "OBR-32, e.g. see below")
        assert emitted("Content Logical Definition", "codes A -B") == "codes A -B"


class TestUnresolvedSpaceRuns:
    """What the extractor reports as still outstanding, and why."""

    def test_nothing_is_outstanding_once_the_collapse_has_run(self):
        text = emitted("Description", "concepts  which specify")
        assert unresolved_space_runs("Description", text) == []

    def test_a_ditto_run_is_reported_as_protected_not_as_outstanding(self):
        text = '""      "" w/o Surgery Capability'
        assert [reason for _, _, reason
                in unresolved_space_runs("definition", text)] == ["ditto"]

    def test_an_indent_is_reported_as_an_indent(self):
        text = "Examples:\n  Indented"
        assert [reason for _, _, reason
                in unresolved_space_runs("comment", text)] == ["indent"]

    def test_a_run_in_a_field_no_decision_covers_is_outstanding(self):
        assert [reason for _, _, reason
                in unresolved_space_runs("Full Name", "Some  Name")] == [
            "not_in_scope"]


class TestManualCorrections:
    """ADR-0008 D14: the corrections that do not generalize into a rule."""

    def test_a_space_before_a_closing_period_goes(self):
        assert apply_manual_corrections(
            "0119", "Placer Applications .")[0] == "Placer Applications."

    def test_the_duplicated_period_in_0356_goes(self):
        text = ('This standard is titled "Information Technology - Character '
                'Code Structure and Extension Technique". .')
        assert apply_manual_corrections("0356", text)[0] == (
            'This standard is titled "Information Technology - Character '
            'Code Structure and Extension Technique".')

    def test_one_correction_can_fire_more_than_once(self):
        # Table 0396 carries the same comment three times, but each is its own
        # value, so within one value the count is one.
        text = 'The THREE versions, "2004" , "2005" and "2006" are active'
        result, applied = apply_manual_corrections("0396", text)
        assert result == (
            'The THREE versions, "2004", "2005" and "2006" are active')
        assert [(kind, count) for kind, count, _, _ in applied] == [
            ("manual_correction", 1)]

    def test_a_table_with_no_corrections_is_untouched(self):
        text = "Placer Applications ."
        assert apply_manual_corrections("0002", text)[0] == text

    def test_a_correction_does_not_reach_a_different_table(self):
        # Every correction is scoped to the one table it was decided for. The
        # same construct elsewhere in the chapter stays as published unless
        # somebody decides about it too.
        assert apply_manual_corrections("0119", "Usage Note : here")[0] == (
            "Usage Note : here")

    def test_the_0440_passage_becomes_internally_consistent(self):
        # Three defects at once: a space after each opening parenthesis, a
        # space before the comma, and a bare hyphen where the other three in
        # the same sentence have spaces around them.
        published = (
            "Replaces the CM data type used in sections 4.5.3.32 and "
            "7.4.1.32-( OBR-32) , 4.5.3.33 and 7.4.1.33 - ( OBR-33) "
            "4.5.3.34 and 7.4.1.34 - ( OBR-34) 4.5.3.35 and 7.4.1.35 - "
            "( OBR-35) as of v 2.5.")
        assert apply_manual_corrections("0440", published)[0] == (
            "Replaces the CM data type used in sections 4.5.3.32 and "
            "7.4.1.32 - (OBR-32), 4.5.3.33 and 7.4.1.33 - (OBR-33) "
            "4.5.3.34 and 7.4.1.34 - (OBR-34) 4.5.3.35 and 7.4.1.35 - "
            "(OBR-35) as of v 2.5.")

    def test_the_0717_line_breaks_survive(self):
        # The reviewer was explicit: fix the space, keep the paragraph breaks.
        published = ("...operations https://example.org/x-sec164-506.pdf , "
                     "which is considered\n\nthe norm.")
        corrected, _ = apply_manual_corrections("0717", published)
        assert corrected == ("...operations https://example.org/x-sec164-506."
                             "pdf, which is considered\n\nthe norm.")
        assert corrected.count("\n") == 2

    def test_applying_twice_changes_nothing_the_second_time(self):
        # The comparison applies corrections to a corpus that may already
        # carry them, so they have to be idempotent.
        once, _ = apply_manual_corrections("0119", "Placer Applications .")
        twice, applied = apply_manual_corrections("0119", once)
        assert twice == once
        assert applied == []

    def test_an_empty_value_is_returned_unchanged(self):
        assert apply_manual_corrections("0119", "") == ("", [])
        assert apply_manual_corrections("0119", None) == (None, [])

    def test_corrections_only_ever_shorten_or_equal_the_text(self):
        # Every correction so far removes a stray space or period. A future
        # one that adds text is fine, but should be a deliberate choice rather
        # than a typo in the table, so this asserts the current shape.
        for table, corrections in MANUAL_CORRECTIONS.items():
            for correction in corrections:
                assert len(correction.corrected) < len(correction.published), (
                    f"{table}: {correction.published!r}")
                assert correction.why, f"{table}: a correction needs a reason"


class TestMissingSpaceAfterPeriodDetector:
    """A detector, not a rule: it reports and never changes anything."""

    def test_the_table_0821_case(self):
        text = "concepts that are relevant within their community.Used in HL7"
        assert len(missing_space_after_period_sites(text)) == 1

    def test_it_never_changes_the_text(self):
        # Belt and braces: the detector must not be wired into the rule chain.
        text = "within their community.Used in HL7"
        assert emitted("Description", text) == text

    @pytest.mark.parametrize("text", [
        "as of v 2.5. Then the next sentence",   # a space is present
        "the file CFR-2017.pdf holds it",        # a file extension
        "reported as v2.9.1 throughout",         # a version number
        "the code HL7.ABC is used",              # an acronym follows
        "see e.g. the note below",               # a lowercase word follows
    ])
    def test_ordinary_periods_are_not_flagged(self, text):
        assert missing_space_after_period_sites(text) == []

    def test_an_email_address_is_not_a_sentence_boundary(self):
        # Table 0396 publishes a contact address in a comment.
        text = "e-mail: Patrick.Revelle@ngc.com for details"
        assert missing_space_after_period_sites(text) == []

    def test_a_url_path_is_not_a_sentence_boundary(self):
        text = "see https://example.org/a.Bcd/e for details"
        assert missing_space_after_period_sites(text) == []

    def test_a_dotted_identifier_is_reported_on_purpose(self):
        # `Observation.Code` is not a defect, but nothing in the text tells it
        # apart from one, so it is listed and a reader decides. Guessing here
        # would hide real defects.
        assert len(missing_space_after_period_sites(
            "passed in HL7 OBX-3 or Observation.Code")) == 1

    def test_the_span_covers_the_joined_characters(self):
        # Three characters, not one, so the report can highlight something
        # visible in the middle of a long paragraph.
        text = "community.Used"
        (start, end), = missing_space_after_period_sites(text)
        assert text[start:end] == "y.U"


class TestMissingSpaceCorrections:
    """ADR-0008 D17: the ten sites the reviewer decided to repair."""

    @pytest.mark.parametrize("table, published, corrected", [
        ("0301", "coding entity identifier.Retained for backward",
                 "coding entity identifier. Retained for backward"),
        ("0301", "string of random bits.Retained for backward",
                 "string of random bits. Retained for backward"),
        ("0396", "the same software and vocabulary.RxNorm is one of",
                 "the same software and vocabulary. RxNorm is one of"),
        ("0399", "ISO 3166 Part 1 Country Codes.This coding system",
                 "ISO 3166 Part 1 Country Codes. This coding system"),
        ("0454", "a specific organization unit.Health Care Provider",
                 "a specific organization unit. Health Care Provider"),
        ("0719", "Act.classCode is not permitted.Code system of concepts",
                 "Act.classCode is not permitted. Code system of concepts"),
        ("0821", "within their community.Used in HL7 Version 2.x",
                 "within their community. Used in HL7 Version 2.x"),
    ])
    def test_each_site_gains_its_space(self, table, published, corrected):
        assert apply_manual_corrections(table, published)[0] == corrected

    def test_the_correction_is_reported_under_its_own_kind(self):
        # Attribution matters: D14 and D17 are separate decisions, and a
        # change logged under the wrong one is a change nobody can trace.
        _, applied = apply_manual_corrections(
            "0821", "within their community.Used in HL7")
        assert [(kind, count) for kind, count, _, _ in applied] == [
            ("missing_space_correction", 1)]

    def test_the_four_identical_0301_rows_are_one_correction(self):
        # The comment is repeated verbatim across four coded rows. One entry
        # in the table covers all four; the count reports how many places.
        row = "Locally defined coding entity identifier.Retained for now"
        _, applied = apply_manual_corrections("0301", row + " " + row)
        assert [(kind, count) for kind, count, _, _ in applied] == [
            ("missing_space_correction", 2)]

    @pytest.mark.parametrize("table, text", [
        # `Observation.Code` -- a dotted identifier, not a sentence boundary.
        ("0396", "will be passed in HL7 OBX-3 or Observation.Code"),
        # `...Reason.PurposeOfUse` -- likewise.
        ("0717", "ActHealthInformationManagementReason.PurposeOfUse. HRESCH"),
    ])
    def test_the_two_dotted_identifiers_are_left_alone(self, table, text):
        # Repairing these would corrupt the name. They stay exactly as
        # published, and the detector goes on reporting them.
        assert apply_manual_corrections(table, text)[0] == text
        assert missing_space_after_period_sites(text)

    def test_applying_twice_changes_nothing_the_second_time(self):
        # Same requirement as the D14 corrections: the comparison applies the
        # policy to a corpus that may already carry it.
        published = "within their community.Used in HL7"
        once, _ = apply_manual_corrections("0821", published)
        twice, applied = apply_manual_corrections("0821", once)
        assert twice == once
        assert applied == []

    def test_a_table_with_both_kinds_reports_both(self):
        # Table 0396 has D14 corrections and a D17 one. Both tables are
        # consulted for the same table number, and the order is D14 first.
        text = ('The date "2004" , and the same software and '
                'vocabulary.RxNorm is one of')
        corrected, applied = apply_manual_corrections("0396", text)
        assert '"2004", and' in corrected
        assert "vocabulary. RxNorm" in corrected
        assert [kind for kind, _, _, _ in applied] == [
            "manual_correction", "missing_space_correction"]

    def test_every_correction_adds_exactly_one_space(self):
        # The mirror of the D14 shape test. These only ever insert a single
        # space at a sentence boundary; anything else is a typo in the table.
        for table, corrections in MISSING_SPACE_CORRECTIONS.items():
            for correction in corrections:
                assert correction.corrected == correction.published.replace(
                    ".", ". ", 1), f"{table}: {correction.published!r}"
                assert correction.why, f"{table}: a correction needs a reason"
