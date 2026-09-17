#!/usr/bin/env python3
"""Tests for the THO artifact versioning policy.

What these pin down is the transcription. The policy lives on two Confluence
pages that we cannot check into the repository, so the element table in
`tho_versioning_policy` is the only copy a reader of this codebase can see --
and a wrong disposition in it is invisible until somebody compares a published
version number against TSMG's expectations. Each test below names the rule it
is holding, so that a future change to the policy is a change to a named rule
rather than to an anonymous constant.

Run:
    python3 -m pytest tooling/scripts/test_tho_versioning_policy.py
"""

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import tho_versioning_policy as policy  # noqa: E402


# --------------------------------------------------------------------------
# The element table
# --------------------------------------------------------------------------

@pytest.mark.parametrize("element", [
    "name", "title", "status", "experimental", "purpose", "caseSensitive",
    "hierarchyMeaning", "compositional", "concept", "property", "filter",
])
def test_code_system_content_elements_increment(element):
    assert policy.disposition("CodeSystem", element) == policy.INCREMENT


@pytest.mark.parametrize("element", [
    "version", "date", "publisher", "contact", "copyright", "valueSet",
    "versionNeeded", "supplements", "count",
])
def test_code_system_housekeeping_elements_do_not_version(element):
    """Standard HL7 values, or open questions, or derived from other changes."""
    assert policy.disposition("CodeSystem", element) == policy.NOT_APPLICABLE


def test_a_changed_url_is_a_new_artifact_not_a_new_version():
    assert policy.disposition("CodeSystem", "url") == policy.NEW_ARTIFACT
    assert policy.disposition("ValueSet", "url") == policy.NEW_ARTIFACT


def test_identifiers_can_be_added_but_not_changed_or_removed():
    """The policy's sharpest rule: identifiers are effectively immutable."""
    assert policy.disposition("CodeSystem", "identifier.added") == policy.INCREMENT
    assert policy.disposition("CodeSystem", "identifier.changed") == policy.NEW_ARTIFACT
    assert policy.disposition("CodeSystem", "identifier.removed") == policy.NEW_ARTIFACT


def test_changing_content_is_a_new_artifact():
    """THO only supports `complete` for HL7 code systems."""
    assert policy.disposition("CodeSystem", "content") == policy.NEW_ARTIFACT


def test_both_descriptions_are_left_to_human_judgement():
    """The CodeSystem page carves out editorial corrections; the ValueSet page
    does not. We treat them alike rather than encode an asymmetry the policy's
    editor has been asked to remove."""
    assert policy.disposition("CodeSystem", "description") == policy.JUDGEMENT
    assert policy.disposition("ValueSet", "description") == policy.JUDGEMENT


def test_a_compose_leaf_falls_back_to_its_listed_ancestor():
    """The Value Sets page lists every compose leaf; we only ever report at
    the include level, so the lookup has to walk up."""
    assert policy.disposition(
        "ValueSet", "compose.include.concept.display") == policy.INCREMENT


def test_an_element_nobody_listed_increments():
    """Over-incrementing is the safer of the two mistakes."""
    assert policy.disposition("CodeSystem", "somethingNew") == policy.INCREMENT


# --------------------------------------------------------------------------
# The arithmetic
# --------------------------------------------------------------------------

def test_the_version_format_has_no_minor_or_patch():
    assert policy.bump("3.0.0") == "4.0.0"
    assert policy.bump("9.0.0") == "10.0.0"


def test_a_version_outside_the_format_is_refused_rather_than_guessed():
    with pytest.raises(ValueError):
        policy.bump("3.1")


def test_a_first_publication_starts_at_one():
    result = policy.next_version("CodeSystem", None, ["name", "concept"])
    assert result["version"] == "1.0.0"
    assert result["incremented"] is False


def test_an_unchanged_artifact_keeps_thos_version():
    """The whole point of the additive merge: matching THO costs nothing."""
    result = policy.next_version("CodeSystem", "3.0.0", [])
    assert result["version"] == "3.0.0"
    assert result["incremented"] is False


def test_a_change_the_policy_ignores_still_keeps_thos_version():
    result = policy.next_version("CodeSystem", "3.0.0", ["date", "copyright"])
    assert result["version"] == "3.0.0"
    assert result["incremented"] is False


def test_a_content_change_increments_the_major_version():
    result = policy.next_version("CodeSystem", "3.0.0", ["concept"])
    assert result["version"] == "4.0.0"
    assert result["triggers"] == ["concept"]


def test_a_judgement_element_increments_by_default_and_is_flagged():
    """"Major unless only change is improved clarity" points at major."""
    result = policy.next_version("CodeSystem", "3.0.0", ["description"])
    assert result["version"] == "4.0.0"
    assert result["judgement"] == ["description"]
    assert result["triggers"] == []


def test_a_change_that_cannot_be_versioned_is_reported_separately():
    """A new canonical is needed; a version number would paper over it."""
    result = policy.next_version("CodeSystem", "3.0.0", ["url"])
    assert result["newArtifact"] == ["url"]
    assert result["version"] == "3.0.0"
    assert result["incremented"] is False


def test_the_reason_names_the_elements_that_caused_the_bump():
    result = policy.next_version("CodeSystem", "3.0.0", ["concept", "name"])
    assert "concept" in result["reason"] and "name" in result["reason"]
