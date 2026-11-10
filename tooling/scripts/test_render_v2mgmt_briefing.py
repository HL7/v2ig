"""Tests for the V2 Management briefing.

The briefing's job in the room is to get someone from an ask to the evidence
behind it. A link that does not resolve, or an ask with no tables named, fails
that job on a projector, mid-meeting -- which is exactly how it failed at the
September Terminology Infrastructure meeting and why the pointers exist.

These hold the parts that fail silently: a dead link, a Markdown twin that
dropped the tables, a number that drifted away from the build.
"""

import json
import re
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_v2mgmt_briefing as briefing  # noqa: E402


def asks():
    """Everything on the page that asks the room for something."""
    return list(briefing.BLOCKERS) + [briefing.NEW_QUESTION]


# --------------------------------------------------------------------------
# Every ask says where to look
# --------------------------------------------------------------------------

def test_every_ask_says_where_to_look():
    for ask in asks():
        assert ask.get("tables") or ask.get("where"), ask["id"]


def test_every_ask_with_no_tables_explains_why():
    for ask in asks():
        if not ask.get("tables"):
            assert ask.get("tableNote"), ask["id"]


def test_links_are_relative_to_the_briefing():
    """The briefing sits in v291-extracted/ and the IG in vocab-ig/output/.

    An absolute or bare path breaks when the file is opened off disk, which is
    how it is actually read in a meeting.
    """
    assert briefing.IG.startswith("../")
    for ask in asks():
        for _label, href in ask.get("where") or []:
            assert href.startswith("../vocab-ig/output/"), href


def test_the_html_carries_a_chip_for_every_named_table():
    """Every named table reaches the page, linked when the ledger has it."""
    page = briefing.render_html(briefing.MEETING_DATE)
    known = briefing.ledger_tables()
    for ask in asks():
        for table in ask.get("tables") or []:
            assert f">{table}</" in page, (ask["id"], table)
            if table in known:
                assert f"#tbl-{table}" in page, (ask["id"], table)


def test_a_table_with_no_ledger_section_is_shown_without_a_link():
    """A link into a section that does not exist drops the reader at the top
    of a very long page, which is worse than no link."""
    known = briefing.ledger_tables()
    if not known:
        pytest.skip("no ledger to check against")
    chips = briefing.table_chips(["0259", "0560"], known={"0560"})
    assert 'href' in chips and "#tbl-0560" in chips
    assert "#tbl-0259" not in chips
    assert "tbl-plain" in chips


def test_every_named_table_is_either_linked_or_explained():
    """An unlinked chip with no note looks like a broken link."""
    known = briefing.ledger_tables()
    page = briefing.render_html(briefing.MEETING_DATE)
    for ask in asks():
        unlinked = sorted(set(ask.get("tables") or []) - known)
        if unlinked:
            assert "no ledger section" in page, (ask["id"], unlinked)


def test_the_markdown_twin_carries_the_tables_too():
    """The twin is what gets pasted into an agenda, so it cannot lose them."""
    text = briefing.render_markdown(briefing.MEETING_DATE)
    for ask in asks():
        for table in ask.get("tables") or []:
            assert table in text, (ask["id"], table)


def test_the_markdown_twin_carries_the_links_too():
    text = briefing.render_markdown(briefing.MEETING_DATE)
    for ask in asks():
        for _label, href in ask.get("where") or []:
            assert href in text, (ask["id"], href)


def test_every_ig_link_resolves_when_a_build_is_present():
    """Skipped when vocab-ig/output has been wiped by a running publisher."""
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
        assert target.exists(), f"no such page: {link}"
        if fragment:
            html = target.read_text(encoding="utf-8", errors="replace")
            assert (f'id="{fragment}"' in html
                    or f"id='{fragment}'" in html
                    or f'name="{fragment}"' in html
                    or f"name='{fragment}'" in html), \
                f"page exists but the anchor does not: {link}"


# --------------------------------------------------------------------------
# Numbers that drift
# --------------------------------------------------------------------------
#
# The briefing is authored, not computed -- it is an argument, and an argument
# built by string-formatting a report reads like one. The cost of that choice
# is that its numbers can fall behind the build, which is what happened to the
# August version. These check the handful that matter against the merge report.

def merge_counts():
    path = briefing.PROJECT_ROOT / "v291-fhir" / "tho-fill-report.json"
    if not path.exists():
        pytest.skip("no merge report")
    return json.loads(path.read_text())["counts"]


def test_the_preserved_value_count_matches_the_merge():
    fills = merge_counts()["byKind"]["fill"]
    assert f"{fills:,}" in briefing.SUMMARY, \
        f"summary should say {fills:,} THO-only values preserved"
    assert any(f"{fills:,}" == value for value, _label, _tone
               in briefing.METRICS), "metrics should carry the same number"


def test_the_kept_version_count_matches_the_merge():
    versions = merge_counts()["versions"]
    kept = sum(n for key, n in versions.items() if "unchanged" in key)
    total = sum(versions.values())
    assert f"{kept} of {total}" in briefing.SUMMARY, \
        f"summary should say {kept} of {total} artifacts keep THO's version"


def write_report():
    path = briefing.PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
    if not path.exists():
        pytest.skip("no write report")
    return json.loads(path.read_text())


def metric(label):
    """The value the metrics strip carries for a label, or None."""
    for value, text, _tone in briefing.METRICS:
        if text == label:
            return value
    return None


def test_the_artifact_count_matches_what_was_written():
    """Caught drifting at 824 against a real 820 after three suppressions
    removed artifacts. Every number on the metrics strip is a claim about the
    build, so every one of them belongs in a test."""
    report = write_report()
    written = sum(len(t["written"]) for t in report["tables"])
    expected = written + 1          # the conceptdomains CodeSystem
    assert metric("artifacts generated") == str(expected), (
        f"metrics say {metric('artifacts generated')} artifacts, the build "
        f"wrote {expected}")


def test_the_defect_class_count_matches_the_review_list():
    """The briefing counts the classes the review list actually populates.
    An empty class is not a class of defect the committee has to rule on."""
    import render_defect_review

    buckets, _unclassified = render_defect_review.grouped()
    populated = sum(1 for items in buckets.values() if items)
    assert metric("classes of chapter defect") == str(populated), (
        f"metrics say {metric('classes of chapter defect')} defect classes, "
        f"the review list has {populated}")


def test_the_blocking_question_count_matches_the_blockers():
    """The strip says how many blocking questions there are and the page then
    lists them. The two disagreed once already: the strip said one while the
    page carried two, one of which had been answered and downgraded in its
    own prose without the number following."""
    still_blocking = [b for b in briefing.BLOCKERS
                      if "no longer blocking" not in (b.get("why") or "")]
    assert metric("blocking question") == str(len(still_blocking)), (
        f"metrics say {metric('blocking question')} blocking question(s), "
        f"the page carries {len(still_blocking)}")


def test_the_meeting_date_is_not_the_one_before_it():
    """A briefing rendered under the previous meeting's date is the previous
    meeting's briefing, whatever its content says."""
    assert briefing.MEETING_DATE != "2026-08-28"


def test_nothing_is_flagged_new_without_the_summary_saying_so():
    """The NEW badge is a promise that the summary tells you what changed."""
    flagged = [c["id"] for c in briefing.CLASSES if c.get("new")]
    if flagged:
        assert "NEW" in briefing.SUMMARY, \
            f"classes flagged new ({flagged}) but the summary does not say so"


def test_the_chapter_code_count_matches_the_extraction():
    """5,540 is the headline in the first sentence. It has to be the truth."""
    import glob
    files = glob.glob(str(briefing.PROJECT_ROOT / "v291-extracted"
                          / "vocabulary" / "*.json"))
    if not files:
        pytest.skip("no extraction to check against")
    codes = sum(len(json.loads(Path(f).read_text()).get("codedContent") or [])
                for f in files)
    assert f"{codes:,}" in briefing.SUMMARY, \
        f"summary should say {codes:,} codes"


def test_the_no_code_system_table_count_matches_the_extraction():
    import glob
    files = glob.glob(str(briefing.PROJECT_ROOT / "v291-extracted"
                          / "vocabulary" / "*.json"))
    if not files:
        pytest.skip("no extraction to check against")
    empty = sum(1 for f in files
                if not json.loads(Path(f).read_text()).get("codeSystems"))
    assert f"{empty} tables with no code system" in briefing.NEW_QUESTION["body"]


# ---------------------------------------------------------------------------
# The authored QA claim
# ---------------------------------------------------------------------------
#
# Two briefings tell the reader the IG validates with "zero broken links
# across 625,068 checked". That number was read off a build by hand and is
# authored in two modules, so nothing made it follow the build it describes.
# It is exactly the shape of claim that goes quietly wrong: a reader who
# trusts it has no way to tell how old it is, and "zero broken links" is the
# single most load-bearing sentence in a review briefing.
#
# Checked against the publisher's own qa.html rather than recomputed, because
# the publisher is the authority on its own output.

QA_CLAIM_RE = re.compile(r"zero broken links[^.]*?([\d,]{4,})\s+checked",
                         re.IGNORECASE | re.DOTALL)

BRIEFINGS_CLAIMING_QA = ("render_v2mgmt_briefing", "render_ti_briefing")


def _qa_broken_link_count():
    """What the publisher's qa.html reports, or None when there is no build."""
    qa = (briefing.PROJECT_ROOT / "vocab-ig" / "output" / "qa.html")
    if not qa.exists():
        return None
    text = qa.read_text(encoding="utf-8", errors="replace")
    # The publisher writes a line of the form "<n> broken links" / "no broken
    # links" in its summary. Both forms are accepted; anything else means the
    # format moved and the test should be looked at rather than trusted.
    if re.search(r"\bno broken links\b", text, re.IGNORECASE):
        return 0
    match = re.search(r"([\d,]+)\s+broken links?\b", text, re.IGNORECASE)
    if match:
        return int(match.group(1).replace(",", ""))
    return None


def test_the_briefings_do_not_claim_zero_broken_links_against_a_bad_build():
    """The claim has to match the build sitting next to it."""
    import importlib

    broken = _qa_broken_link_count()
    if broken is None:
        pytest.skip("no build, or qa.html does not report a link count")

    claiming = []
    for name in BRIEFINGS_CLAIMING_QA:
        module = importlib.import_module(name)
        source = "".join(str(getattr(module, attr, ""))
                         for attr in dir(module)
                         if attr.isupper() or attr.endswith("SUMMARY"))
        if QA_CLAIM_RE.search(source):
            claiming.append(name)

    assert not (claiming and broken), (
        f"these briefings claim zero broken links, but the current build's "
        f"qa.html reports {broken}: {claiming}")
