"""Tests for the Terminology Infrastructure WG briefing.

The briefing's job in the room is to get someone from a question to the
evidence that answers it. A link that does not resolve, or an ask with no
tables named, fails that job at the worst possible moment -- on a projector,
mid-meeting. These hold the parts that would fail silently.
"""

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_ti_briefing as briefing  # noqa: E402


def test_every_ask_says_where_to_look():
    """An ask with neither tables nor links leaves the reader hunting."""
    for ask in briefing.ASKS:
        assert ask.get("tables") or ask.get("where"), ask["id"]


def test_every_ask_with_no_tables_explains_why():
    """Two asks are not table-specific. That has to be said, not left blank."""
    for ask in briefing.ASKS:
        if not ask.get("tables"):
            assert ask.get("tableNote"), ask["id"]


def test_table_chips_are_sorted():
    chips = briefing.table_chips(["0440", "0003", "0357"])
    assert chips.index("0003") < chips.index("0357") < chips.index("0440")


def test_table_chips_link_into_the_ledger():
    chips = briefing.table_chips(["0350"])
    assert "table-ledger.html#tbl-0350" in chips


def test_links_are_relative_to_the_briefing():
    """The briefing sits in v291-extracted/ and the IG in vocab-ig/output/.
    An absolute or bare path breaks when the file is opened off disk, which
    is how it is actually read."""
    assert briefing.IG.startswith("../")
    for ask in briefing.ASKS:
        for _label, href in ask.get("where") or []:
            assert href.startswith("../vocab-ig/output/"), href


def test_where_block_is_empty_when_there_is_nothing_to_point_at():
    assert briefing.where_block({"id": "x"}) == ""


def test_the_html_carries_a_link_for_every_named_table():
    page = briefing.render_html(briefing.MEETING_DATE)
    for ask in briefing.ASKS:
        for table in ask.get("tables") or []:
            assert f"#tbl-{table}" in page, (ask["id"], table)


def test_the_markdown_twin_carries_the_tables_too():
    """The twin is what gets pasted into an agenda, so it cannot lose them."""
    text = briefing.render_markdown(briefing.MEETING_DATE)
    for ask in briefing.ASKS:
        for table in ask.get("tables") or []:
            assert table in text, (ask["id"], table)


def test_no_ask_links_to_the_deleted_general_questions_page():
    """general-questions.html was folded into open-items.html; a link to it
    would resolve to nothing."""
    page = briefing.render_html(briefing.MEETING_DATE)
    assert "general-questions.html" not in page


def test_every_ig_link_resolves_when_a_build_is_present():
    """Skipped when vocab-ig/output has been wiped by a running publisher."""
    import pytest
    output = briefing.PROJECT_ROOT / "vocab-ig" / "output"
    if not (output / "index.html").exists():
        pytest.skip("no build to check against")

    page = briefing.render_html(briefing.MEETING_DATE)
    links = sorted(set(re.findall(r'href=[\'"](\.\./vocab-ig/output/[^\'"]+)',
                                  page)))
    assert links, "the briefing should link into the IG"
    for link in links:
        path, _, fragment = link.partition("#")
        target = briefing.PROJECT_ROOT / "v291-extracted" / path
        assert target.exists(), link
        if fragment:
            body = target.read_text(encoding="utf-8", errors="ignore")
            assert (f'id="{fragment}"' in body
                    or f'name="{fragment}"' in body), link
