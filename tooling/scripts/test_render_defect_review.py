#!/usr/bin/env python3
"""Tests for the defect review list.

The point of these is drift. The review list is generated from the register,
so its prose cannot go stale -- but its *classification* is authored, and an
item added to the register could silently miss the list. That is the failure
worth a test: a finding nobody reviews because nobody noticed it was not on
the page.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_defect_review as review  # noqa: E402
import vocabulary_escalations  # noqa: E402


def test_every_open_item_is_classified():
    """The invariant. A finding missing from the review list is a finding
    nobody rules on."""
    buckets, unclassified = review.grouped()
    assert not unclassified, (
        "these open register items have no class in CLASSIFICATION, so they "
        "would not appear on the review list: "
        f"{[item['id'] for item in unclassified]}")


def test_classification_names_no_item_that_does_not_exist():
    """The reverse: a classification for a deleted or renamed item is dead
    weight that reads as coverage."""
    known = {item["id"] for item in vocabulary_escalations.ESCALATIONS}
    unknown = sorted(set(review.CLASSIFICATION) - known)
    assert not unknown, (
        f"CLASSIFICATION names register items that do not exist: {unknown}")


def test_no_answered_item_is_classified():
    """An answered item belongs on the evidence page, not a review list. If
    one is classified here it will have been answered after the class was
    written, and the entry should go."""
    answered = {item["id"] for item in vocabulary_escalations.ESCALATIONS
                if item.get("resolution")}
    stale = sorted(answered & set(review.CLASSIFICATION))
    assert not stale, (
        f"these items have been answered but are still classified for "
        f"review: {stale}")


def test_every_class_used_by_a_classification_exists():
    bad = {item_id: entry[0]
           for item_id, entry in review.CLASSIFICATION.items()
           if entry[0] not in review.CLASSES}
    assert not bad, f"classifications naming an unknown class: {bad}"


def test_the_superseded_policy_item_is_not_on_the_list():
    """It is the question the list replaces. Leaving it in would ask for the
    blanket rule the ruling declined to give."""
    buckets, _unclassified = review.grouped()
    everywhere = [item["id"] for items in buckets.values()
                  for item, _why in items]
    assert review.SUPERSEDED["item"] not in everywhere


def test_the_register_records_the_same_ruling_as_this_document():
    """The policy item's ruling lives in two places and they must agree.

    Until 2026-11-13 the item had no `resolution` -- deliberately, on the
    reasoning that "no single answer" is not an answer. The cost was that
    the guide's open-items page kept asking the question, a month after
    V2 Management had ruled. It now carries the ruling as its resolution,
    which moves it to the evidence page. This document's framing ("this
    replaces the question; the ruling was ...") is unchanged by that, but
    the date and ruling text must not drift between the two copies."""
    by_id = {item["id"]: item for item in vocabulary_escalations.ESCALATIONS}
    item = by_id.get(review.SUPERSEDED["item"])
    assert item is not None, "the superseded policy item has been deleted"
    resolution = item.get("resolution")
    assert resolution, (
        "the policy item has no resolution, so the guide's open-items page "
        "is asking a question V2 Management answered on 2026-10-08")
    assert resolution["date"] == review.SUPERSEDED["date"]
    assert resolution["ruling"] == review.SUPERSEDED["ruling"]
    assert resolution["who"] == review.SUPERSEDED["who"]


def test_both_renderings_work_without_a_build_report(monkeypatch):
    """The list has to render before a build exists, because the first thing
    somebody does with a new finding is look at it."""
    monkeypatch.setattr(review, "WRITE_REPORT", Path("/nonexistent"))
    assert review.current_output() == {}
    assert "<html" in review.render_html()
    assert review.render_markdown().startswith("# ")


def test_the_current_output_lines_come_from_the_report():
    """The column that makes the list worth reading. If the report says a
    table is blocked, the page must say so rather than describing it."""
    published = {
        "0821": {"table": "0821", "name": "Gender Identity",
                 "action": "needs-decision"},
    }
    rows = review.output_summary(["0821"], published)
    assert rows == [("0821", "Gender Identity",
                     "BLOCKED — no artifact, pipeline cannot settle it",
                     "")]


def test_a_table_absent_from_the_report_is_skipped_not_invented():
    assert review.output_summary(["9998"], {}) == []
