#!/usr/bin/env python3
"""Tests for the Chapter 2C vocabulary text policy.

The policy decides what the extraction is allowed to change in the published
text, so the cases that matter most are the ones it must NOT change. Run with:

    python3 -m pytest tooling/scripts/test_vocabulary_text_policy.py
"""

import pytest

from vocabulary_text_policy import (
    collapse_spaces_after_period,
    is_descriptive_field,
    normalize_descriptive_text,
)


class TestCollapseSpacesAfterPeriod:
    """The rule itself, independent of which field it is applied to."""

    def test_two_spaces_after_a_period_become_one(self):
        text = "Specifies the room type.  Used in the RMC segment."
        assert collapse_spaces_after_period(text) == (
            "Specifies the room type. Used in the RMC segment.", 1)

    def test_longer_runs_also_collapse_to_one_space(self):
        assert collapse_spaces_after_period("Partial results.   Deprecated.") == (
            "Partial results. Deprecated.", 1)

    def test_each_run_is_counted_separately(self):
        text = "One.  Two.  Three.  Four."
        collapsed, runs = collapse_spaces_after_period(text)
        assert collapsed == "One. Two. Three. Four."
        assert runs == 3

    def test_a_single_space_after_a_period_is_untouched(self):
        text = "One. Two."
        assert collapse_spaces_after_period(text) == (text, 0)

    def test_double_space_not_after_a_period_is_untouched(self):
        # The dominant remaining irregularity in Chapter 2C, and deliberately
        # out of scope: it is a different decision.
        text = "Code system of concepts  which specify the room type."
        assert collapse_spaces_after_period(text) == (text, 0)

    def test_only_the_run_after_the_period_collapses(self):
        text = "Concepts  which specify a type.  Used in RMC."
        collapsed, runs = collapse_spaces_after_period(text)
        assert collapsed == "Concepts  which specify a type. Used in RMC."
        assert runs == 1

    def test_a_closing_quote_between_period_and_spaces_is_not_matched(self):
        # Six real values in Chapter 2C look like this. They stay outstanding
        # rather than being swept in; widening the rule is a further decision.
        text = 'Sent as "preliminary."  See the note below.'
        assert collapse_spaces_after_period(text) == (text, 0)

    def test_tabs_and_newlines_after_a_period_are_not_spaces(self):
        assert collapse_spaces_after_period("One.\t\tTwo.") == ("One.\t\tTwo.", 0)
        assert collapse_spaces_after_period("One.\n\nTwo.") == ("One.\n\nTwo.", 0)

    def test_a_non_breaking_space_is_not_an_ordinary_space(self):
        text = "One.  Two."
        assert collapse_spaces_after_period(text) == (text, 0)

    def test_empty_text_is_returned_unchanged(self):
        assert collapse_spaces_after_period("") == ("", 0)


class TestFieldScope:
    """Which fields the rule may touch."""

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


class TestNormalizeDescriptiveText:
    """The two together: the rule applied only where it is in scope."""

    def test_a_descriptive_field_is_normalized(self):
        assert normalize_descriptive_text(
            "Description", "Specifies a type.  Used in RMC.") == (
            "Specifies a type. Used in RMC.", 1)

    def test_a_field_out_of_scope_is_left_alone(self):
        text = "Specifies a type.  Used in RMC."
        assert normalize_descriptive_text("SymbolicName", text) == (text, 0)

    def test_a_code_value_containing_a_period_is_left_alone(self):
        # The reason identifiers are out of scope in the first place.
        assert normalize_descriptive_text("value", "2.16.840.1.113883.1") == (
            "2.16.840.1.113883.1", 0)

    def test_an_absent_value_stays_absent_rather_than_raising(self):
        # An absent value and an empty one mean different things in the
        # extracted corpus, so neither is turned into the other.
        assert normalize_descriptive_text("Description", None) == (None, 0)
        assert normalize_descriptive_text("Description", "") == ("", 0)
