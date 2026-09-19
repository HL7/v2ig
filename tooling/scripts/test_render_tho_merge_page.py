#!/usr/bin/env python3
"""Tests for the THO merge page.

The page's job is to be honest about scale: it must show every class the
report contains, never silently drop one, and say plainly that the chapter
wins a disagreement. These tests hold those three things.

Run:
    python3 -m pytest tooling/scripts/test_render_tho_merge_page.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_tho_merge_page as page  # noqa: E402


def make_report(**overrides):
    report = {
        "source": {"package": "hl7.terminology.r5", "version": "7.3.0"},
        "counts": {
            "observations": 3,
            "byKind": {"fill": 1, "discrepancy": 1, "omission": 1},
            "versions": {"codeSystem: unchanged, THO's version kept": 340,
                         "codeSystem: incremented": 56},
        },
        "classes": [
            {"class": "fill:concept.definition", "kind": "fill",
             "element": "concept.definition", "property": None,
             "title": "Concept definitions kept from THO",
             "why": "The chapter has no definition column.",
             "count": 4855, "tableCount": 382, "tables": ["0001"]},
            {"class": "discrepancy:concept.display", "kind": "discrepancy",
             "element": "concept.display", "property": None,
             "title": "Displays where the chapter and THO disagree",
             "why": "", "count": 44, "tableCount": 15, "tables": ["0003"]},
        ],
        "needsJudgement": [{"table": "0083", "resource": "codeSystem",
                            "elements": ["description"], "version": "4.0.0"}],
        "cannotBeVersioned": [],
        "records": [{"kind": "omission", "table": "0133",
                     "resource": "CodeSystem", "element": "resource",
                     "reason": "The chapter says concept domain only."}],
    }
    report.update(overrides)
    return report


def test_every_class_in_the_report_reaches_the_page():
    """A class that is counted but not shown is worse than no page at all."""
    rendered = page.render_page(make_report())
    assert "Concept definitions kept from THO" in rendered
    assert "Displays where the chapter and THO disagree" in rendered
    assert "4,855" in rendered


def test_the_page_says_which_snapshot_the_numbers_came_from():
    rendered = page.render_page(make_report())
    assert "hl7.terminology.r5" in rendered and "7.3.0" in rendered


def test_the_page_says_the_chapter_wins_a_disagreement():
    rendered = page.render_page(make_report())
    assert "chapter wins" in rendered


def test_version_outcomes_are_shown():
    rendered = page.render_page(make_report())
    assert "340" in rendered and "56" in rendered


def test_no_increment_is_presented_as_waivable():
    """The description carve-out is gone: every difference increments, so the
    page must not offer a waiver or a table of increments awaiting a ruling."""
    rendered = page.render_page(make_report())
    assert "waived" not in rendered and "can be waived" not in rendered
    assert "rest on a human judgement" not in rendered


def test_the_page_names_no_internal_artifact():
    """Readers are committee members; internal paths are not theirs to chase."""
    rendered = page.render_page(make_report())
    for path in ("v291-fhir", "v291-extracted", "tooling/scripts",
                 "tho-fill-report", "utg-write-report"):
        assert path not in rendered, path


def test_an_omission_is_listed_with_its_reason():
    """THO publishes it and we do not; the silence has to be visible."""
    rendered = page.render_page(make_report())
    assert "0133" in rendered
    assert "concept domain only" in rendered


def test_a_section_with_nothing_in_it_still_reports_zero():
    """An empty section reads as 'we checked and found none', which is
    information; omitting it reads as 'we did not check'."""
    rendered = page.render_page(make_report(classes=[]))
    assert "**0 in total.**" in rendered


def test_a_report_with_no_blocked_changes_omits_that_warning():
    """That section is an alarm, and an alarm that is always on is noise."""
    rendered = page.render_page(make_report())
    assert "Changes a version number cannot express" not in rendered
