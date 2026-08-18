#!/usr/bin/env python3
"""Tests for the Chapter 2C vocabulary text policy.

The policy decides what the extraction is allowed to change in the published
text, so the cases that matter most are the ones it must NOT change. Every
"leave it alone" test below is drawn from a real value in Chapter 2C. Run with:

    python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
"""

import pytest

from vocabulary_text_policy import (
    add_comma_after_abbreviation,
    apply_text_policy,
    is_descriptive_field,
    normalize_dash_spacing,
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
        # Still the dominant remaining irregularity, and out of scope here.
        text = "Code system of concepts  which specify the room type."
        assert emitted("Description", text) == text

    def test_tabs_and_newlines_after_a_period_are_not_spaces(self):
        assert emitted("Description", "One.\t\tTwo.") == "One.\t\tTwo."
        assert emitted("Description", "One.\n\nTwo.") == "One.\n\nTwo."

    def test_a_non_breaking_space_is_not_an_ordinary_space(self):
        # Built with chr() on purpose: a literal U+00A0 in this file is
        # invisible, and one stray edit would silently turn this test into a
        # duplicate of the ordinary-space case above.
        nbsp = chr(0x00A0)
        assert emitted("Description", f"One.{nbsp}{nbsp}Two.") == f"One.{nbsp}{nbsp}Two."
        assert emitted("Description", f"One.{nbsp} Two.") == f"One.{nbsp} Two."


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
        # "(see below)  and then" is not a sentence end.
        text = "Applies to the first form (see below)  and then to the second."
        assert emitted("comment", text) == text


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

    def test_the_same_run_is_left_alone_in_a_description(self):
        text = "Code system of concepts  which specify the room type"
        assert emitted("Description", text) == text

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
