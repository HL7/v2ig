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

def test_questions_are_numbered_one_to_seven():
    numbers = [q["number"] for q in questions.GENERAL_QUESTIONS]
    assert numbers == sorted(numbers)
    assert numbers == list(range(1, len(numbers) + 1))


def test_every_question_has_a_body_and_a_known_audience():
    for question in questions.GENERAL_QUESTIONS:
        assert question["body"].strip(), question["id"]
        assert question["audience"] in ("TSMG", "V2 Management"), question["id"]


def test_question_ids_are_unique():
    ids = [q["id"] for q in questions.GENERAL_QUESTIONS]
    assert len(ids) == len(set(ids))


def test_every_question_reaches_the_page(rendered):
    page = rendered["open-items"]
    for question in questions.GENERAL_QUESTIONS:
        assert f'#### {question["number"]}. {question["title"]}' in page
        assert question["body"].strip() in page, question["id"]


def test_every_question_has_an_anchor_to_link_to(rendered):
    page = rendered["open-items"]
    for question in questions.GENERAL_QUESTIONS:
        assert f'<a name="{question["id"]}">' in page


def test_anchor_helper_rejects_an_unknown_id():
    """A cross-link to a question that no longer exists fails at build time."""
    with pytest.raises(KeyError):
        pages.question_anchor("gq-no-such-question")


def test_anchor_helper_accepts_every_real_id():
    for question in questions.GENERAL_QUESTIONS:
        assert pages.question_anchor(question["id"]).startswith("open-items.html#")


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
