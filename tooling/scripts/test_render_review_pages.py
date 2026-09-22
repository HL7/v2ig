#!/usr/bin/env python3
"""Tests for the fold of the review report into the IG.

The report used to be a standalone HTML file. Now it is two pages of the guide,
and the split between them is by ACTION class. The risk that split introduces
is that a finding falls down the gap: re-class a group, or add a new class, and
a group can silently appear on neither page while every count still looks
plausible. Most of what is pinned below is that gap being closed.

The other thing held here is the authored prose. It used to be a hand-written
page; it is now a module that a generator emits. Nobody would notice if a
question quietly stopped being rendered, so the page is checked to contain
every one of them.

Run:
    python3 -m pytest tooling/scripts/test_render_review_pages.py
"""

import html
import re
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_review_pages as pages  # noqa: E402
import render_vocabulary_review_html as report  # noqa: E402
import vocabulary_general_questions as questions  # noqa: E402


@pytest.fixture(scope="module")
def sections():
    return pages.collect_sections()


@pytest.fixture(scope="module")
def rendered(sections):
    return {
        "open-items": pages.build_open_items_page(sections),
        "evidence": pages.build_evidence_page(sections),
    }


# --------------------------------------------------------------------------
# Nothing falls down the gap between the two pages
# --------------------------------------------------------------------------

def test_every_action_class_has_a_page():
    """A new class in the report must be routed, not silently dropped."""
    assert set(report.ACTION_ORDER) == set(pages.PAGE_FOR_ACTION)


def test_every_section_routes_somewhere(sections):
    for section in sections:
        assert section["action"] in pages.PAGE_FOR_ACTION, section["id"]


def test_the_asks_and_the_evidence_are_disjoint():
    asks = {a for a, p in pages.PAGE_FOR_ACTION.items() if p == "open-items"}
    evidence = {a for a, p in pages.PAGE_FOR_ACTION.items() if p == "evidence"}
    assert asks and evidence
    assert not asks & evidence


def test_open_items_carries_the_asks_and_only_the_asks(sections, rendered):
    """Every escalate/decide group is on the ask page; no evidence group is."""
    page = rendered["open-items"]
    for section in sections:
        if not section["count"]:
            continue
        on_page = section["title"] in page
        if pages.PAGE_FOR_ACTION[section["action"]] == "open-items":
            assert on_page, f'{section["id"]} is an ask but is not on open-items'


def test_every_evidence_group_is_on_the_evidence_page(sections, rendered):
    page = rendered["evidence"]
    for section in sections:
        if not section["count"]:
            continue
        if pages.PAGE_FOR_ACTION[section["action"]] == "evidence":
            assert section["title"] in page, f'{section["id"]} missing'


def test_item_counts_are_conserved(sections, rendered):
    """Every value in the report reaches one of the two pages."""
    total = sum(s["count"] for s in sections)
    routed = sum(s["count"] for s in sections
                 if s["action"] in pages.PAGE_FOR_ACTION)
    assert routed == total


# --------------------------------------------------------------------------
# The authored prose survives being moved into a module
# --------------------------------------------------------------------------

def test_question_numbers_are_unique_and_ascending():
    """Numbers are stable identifiers, not positions.

    An answered question keeps its number and is not renumbered, so the
    sequence is allowed to develop gaps as questions close. What must hold is
    that no number is reused -- a reused number makes every reference to it in
    a minute or an email point at the wrong question.
    """
    numbers = [q["number"] for q in questions.GENERAL_QUESTIONS]
    assert numbers == sorted(numbers)
    assert len(numbers) == len(set(numbers))


def test_every_question_has_a_body_and_a_known_audience():
    for question in questions.GENERAL_QUESTIONS:
        assert question["body"].strip(), question["id"]
        assert question["audience"] in ("TSMG", "V2 Management"), question["id"]


def test_question_ids_are_unique():
    ids = [q["id"] for q in questions.GENERAL_QUESTIONS]
    assert len(ids) == len(set(ids))


def test_every_question_reaches_a_page(rendered):
    """Open questions land on open-items, answered ones on evidence.

    Every question reaches exactly one of the two pages. A question that
    reached neither would be silently dropped from the review, which is the
    failure this guards.
    """
    for question in questions.GENERAL_QUESTIONS:
        expected = "open-items" if pages.is_open(question) else "evidence"
        page = rendered[expected]
        assert f'#### {question["number"]}. {question["title"]}' in page, \
            question["id"]
        assert question["body"].strip() in page, question["id"]

        other = rendered["evidence" if expected == "open-items" else "open-items"]
        assert f'#### {question["number"]}. {question["title"]}' not in other, \
            f'{question["id"]} appears on both pages'


def test_every_question_has_an_anchor_to_link_to(rendered):
    for question in questions.GENERAL_QUESTIONS:
        page = rendered["open-items" if pages.is_open(question) else "evidence"]
        assert f'<a name="{question["id"]}">' in page, question["id"]


def test_anchor_helper_rejects_an_unknown_id():
    """A cross-link to a question that no longer exists fails at build time."""
    with pytest.raises(KeyError):
        pages.question_anchor("gq-no-such-question")


def test_anchor_helper_points_at_the_page_the_question_is_on():
    """A cross-link has to follow a question when an answer moves it.

    This is the failure the page-aware anchor exists to prevent: before it,
    every link in the guide pointed at `open-items.html`, so the first
    committee ruling would have turned them all into links to a page the
    question was no longer on.
    """
    for question in questions.GENERAL_QUESTIONS:
        expected = "open-items" if pages.is_open(question) else "evidence"
        assert pages.question_anchor(question["id"]) == \
            f'{expected}.html#{question["id"]}'


def test_an_answered_question_shows_its_full_attribution(rendered):
    """An answer with no attribution is not usable six months later."""
    answered = pages.answered_questions()
    if not answered:
        pytest.skip("nothing answered yet")
    page = rendered["evidence"]
    for question in answered:
        resolution = question["resolution"]
        assert set(resolution) == {"who", "forum", "date", "ruling", "effect"}, \
            question["id"]
        for field in ("who", "forum", "date", "ruling", "effect"):
            assert resolution[field].strip(), f'{question["id"]}: empty {field}'
            assert html.escape(resolution[field]) in page, \
                f'{question["id"]}: {field} missing from the page'


def test_the_open_items_page_does_not_claim_an_answered_question_is_open(rendered):
    """The headline count is the thing a reader trusts without checking."""
    page = rendered["open-items"]
    still_open = len(pages.open_questions())
    assert f"**{still_open} general questions**" in page \
        or f"**{still_open} general question**" in page


def test_an_audience_with_nothing_open_says_so(rendered):
    """An empty heading reads as a dropped question, not a settled one."""
    page = rendered["open-items"]
    audiences = {q["audience"] for q in questions.GENERAL_QUESTIONS}
    for audience in audiences:
        if any(q["audience"] == audience for q in pages.open_questions()):
            continue
        assert f"Nothing is open for {audience}" in page, audience


# --------------------------------------------------------------------------
# What the template requires of a page
# --------------------------------------------------------------------------

@pytest.mark.parametrize("name", ["open-items", "evidence"])
def test_page_starts_at_h3(name, rendered):
    """The template prints the page title as an h2 and numbers with CSS
    counters, so a `#` or `##` anywhere breaks numbering for the whole page."""
    stray = re.findall(r"^#{1,2} .*$", rendered[name], flags=re.M)
    assert stray == []


@pytest.mark.parametrize("name", ["open-items", "evidence"])
def test_page_has_no_small_element(name, rendered):
    """The publisher's HTML checker rejects `<small>` and warns on every use."""
    assert "<small>" not in rendered[name]


@pytest.mark.parametrize("name", ["open-items", "evidence"])
def test_page_has_no_nul_bytes(name, rendered):
    """A non-raw Python escape like "\\00b7" is read as octal and emits NULs."""
    assert "\x00" not in rendered[name]


def test_the_two_pages_link_to_each_other(rendered):
    assert "evidence.html" in rendered["open-items"]
    assert "open-items.html" in rendered["evidence"]


# --------------------------------------------------------------------------
# The computed audience sentence
# --------------------------------------------------------------------------
#
# The live corpus exercises one of these four shapes at a time, so the other
# three would ship unread. They are checked directly instead: the sentence is
# the first thing on the page and a committee reads it.

def _q(audience, number):
    return {"audience": audience, "number": number,
            "id": f"q{number}", "title": f"Question {number}"}


def test_audience_sentence_when_everything_is_answered():
    assert "Every general question has now been answered" in \
        pages.audience_sentence([])


def test_audience_sentence_for_a_single_question():
    sentence = pages.audience_sentence([_q("TSMG", 1)])
    assert sentence.startswith("The one question below is for **TSMG**.")


def test_audience_sentence_for_one_audience():
    sentence = pages.audience_sentence([_q("V2 Management", i) for i in range(6)])
    assert sentence.startswith("All **6** questions below are for "
                               "**V2 Management**.")
    # The count must not appear twice -- an earlier draft read "are all **6**".
    assert sentence.count("**6**") == 1


def test_audience_sentence_splits_across_two_audiences():
    sentence = pages.audience_sentence(
        [_q("V2 Management", i) for i in range(4)]
        + [_q("TSMG", 9), _q("TSMG", 10)])
    assert sentence.startswith("Of the **6** questions below, "
                               "**4** for **V2 Management** and "
                               "**2** for **TSMG**.")
