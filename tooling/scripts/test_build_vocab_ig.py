"""Tests for the vocabulary IG build orchestrator.

The point of the orchestrator is that the step order stops being a convention
somebody has to remember. These tests hold that: that the declared order is
sound, that a wrong order is actually caught, and that every step names a
script that exists.
"""

import json
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import build_vocab_ig as build  # noqa: E402


def test_the_declared_order_is_sound():
    """Every step's inputs are produced by a step that runs before it."""
    assert build.check_order() == []


def test_every_step_names_a_script_that_exists():
    for step in build.STEPS:
        path = build.script_path(step["name"])
        assert path.exists(), f"{step['name']} has no script at {path}"


def test_step_names_are_unique():
    names = [s["name"] for s in build.STEPS]
    assert len(names) == len(set(names)), names


def test_every_step_says_why_it_is_where_it_is():
    """A step with no reason is a step somebody will reorder on a hunch."""
    for step in build.STEPS:
        assert step["why"].strip(), step["name"]


def test_putting_the_table_index_before_the_ledger_is_caught():
    """The edge most likely to be got wrong: the index reads the ledger page.

    This is the specific mistake the orchestrator exists to prevent, so it is
    worth a test of its own rather than a generic shuffle.
    """
    steps = list(build.STEPS)
    names = [s["name"] for s in steps]
    i, j = names.index("render_table_ledger"), names.index("generate_table_index")
    steps[i], steps[j] = steps[j], steps[i]

    problems = build.check_order(steps)
    assert problems, "swapping the ledger and the index should be caught"
    assert "generate_table_index" in problems[0]
    assert "page-table-ledger" in problems[0]


def test_moving_any_step_to_the_front_is_caught():
    """A step that consumes anything cannot legally run first."""
    for position, step in enumerate(build.STEPS):
        if not step["consumes"]:
            continue
        reordered = [step] + [s for i, s in enumerate(build.STEPS)
                              if i != position]
        assert build.check_order(reordered), \
            f"{step['name']} first should be caught"


def test_staging_is_last():
    """index.md self-checks the counts, so it has to see the final tree."""
    assert build.STEPS[-1]["name"] == "stage_vocab_ig"


def test_list_runs_without_touching_anything():
    result = subprocess.run(
        [sys.executable, str(build.SCRIPT_DIR / "build_vocab_ig.py"), "--list"],
        capture_output=True, text=True)
    assert result.returncode == 0, result.stderr
    for step in build.STEPS:
        assert step["name"] in result.stdout


def test_an_unknown_step_name_is_refused():
    result = subprocess.run(
        [sys.executable, str(build.SCRIPT_DIR / "build_vocab_ig.py"),
         "--only", "no_such_step"],
        capture_output=True, text=True)
    assert result.returncode != 0
    assert "no_such_step" in result.stderr


# --------------------------------------------------------------------------
# The post-build snapshot
# --------------------------------------------------------------------------
#
# The snapshot exists so the IG stays readable while the publisher is running
# (it wipes output/ on startup) and after a build that fails. These tests use
# tiny fake trees rather than the real 406 MB one.

def _redirect(monkeypatch, tmp_path):
    """Point the module's output/snapshot paths at a temp directory."""
    out = tmp_path / "output"
    snap = tmp_path / "output-snapshot"
    monkeypatch.setattr(build, "IG_OUTPUT", out)
    monkeypatch.setattr(build, "IG_SNAPSHOT", snap)
    return out, snap


def test_a_finished_build_is_copied_to_the_snapshot(monkeypatch, tmp_path):
    out, snap = _redirect(monkeypatch, tmp_path)
    out.mkdir()
    (out / "index.html").write_text("current build")

    build.snapshot_output()

    assert (snap / "index.html").read_text() == "current build"


def test_the_snapshot_says_it_is_not_the_live_build(monkeypatch, tmp_path):
    """16,000 HTML pages look exactly like the real thing without this."""
    out, snap = _redirect(monkeypatch, tmp_path)
    out.mkdir()
    (out / "index.html").write_text("current build")

    build.snapshot_output()

    marker = (snap / "SNAPSHOT.txt").read_text()
    assert "NOT the live build" in marker
    assert "vocab-ig/output/" in marker


def test_an_older_snapshot_is_replaced_not_merged(monkeypatch, tmp_path):
    """A file from the previous build must not survive into the new snapshot."""
    out, snap = _redirect(monkeypatch, tmp_path)
    out.mkdir()
    (out / "index.html").write_text("new build")
    snap.mkdir()
    (snap / "index.html").write_text("old build")
    (snap / "page-that-was-deleted.html").write_text("stale")

    build.snapshot_output()

    assert (snap / "index.html").read_text() == "new build"
    assert not (snap / "page-that-was-deleted.html").exists()


def test_no_scratch_directories_are_left_behind(monkeypatch, tmp_path):
    out, snap = _redirect(monkeypatch, tmp_path)
    out.mkdir()
    (out / "index.html").write_text("current build")

    build.snapshot_output()

    siblings = {p.name for p in tmp_path.iterdir()}
    assert siblings == {"output", "output-snapshot"}, siblings


def test_a_missing_output_directory_is_not_fatal(monkeypatch, tmp_path):
    """Nothing to snapshot is a skip, not a crash -- it must not fail a build
    that otherwise succeeded."""
    _redirect(monkeypatch, tmp_path)
    build.snapshot_output()  # output/ does not exist


def test_snapshotting_is_on_by_default_and_can_be_turned_off():
    """A flag you have to remember is the one you forget on the day it
    matters, so the default is on."""
    parser_args = subprocess.run(
        [sys.executable, str(build.SCRIPT_DIR / "build_vocab_ig.py"), "--help"],
        capture_output=True, text=True)
    assert "--no-snapshot" in parser_args.stdout


# ---------------------------------------------------------------------------
# The authored route table on index.md
# ---------------------------------------------------------------------------
#
# index.md carries a hand-written table of how many tables took each route.
# It has drifted in three separate sessions, and the last time it drifted
# silently: `stage_vocab_ig` self-checks the resource counts on that page but
# knows nothing about this table, and the authored version still listed five
# routes when the writer had grown to seven. A route added without a row here
# is invisible rather than wrong, which is the worse failure.
#
# Both halves are checked: every route the writer reports must have a row with
# the right number, and every row must name a route the writer still produces.

ROUTE_ROW_RE = re.compile(r"^\|\s*([^|]+?)\s*\|\s*([\d,]+)\s*\|", re.MULTILINE)

# The prose label on index.md for each action in the write report.
ROUTE_LABELS = {
    "code-system-and-value-set": "Code system and value set",
    "concept-domain-only": "Concept domain only",
    "value-set-only": "Value set only",
    "needs-decision": "Needs a decision",
    "suppressed-by-ruling": "Withheld on a ruling",
    "superseded-by-ruling": "Retired and superseded",
    "nothing-to-write": "Nothing to write",
}


def _index_route_counts():
    """The route table as authored on index.md, as {label: count}."""
    page = (build.PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
            / "index.md").read_text(encoding="utf-8")
    rows = {}
    for label, number in ROUTE_ROW_RE.findall(page):
        if label in ROUTE_LABELS.values():
            rows[label] = int(number.replace(",", ""))
    return rows


def _written_route_counts():
    """The route counts the writer actually produced."""
    report = json.loads(
        (build.PROJECT_ROOT / "v291-fhir" / "utg-write-report.json")
        .read_text(encoding="utf-8"))
    return report["counts"]


def test_every_route_the_writer_produces_has_a_row_on_index():
    """A new route must be added to the page, not just to the writer."""
    authored = _index_route_counts()
    missing = [ROUTE_LABELS.get(action, action)
               for action in _written_route_counts()
               if ROUTE_LABELS.get(action) not in authored]
    assert missing == [], (
        f"index.md has no row for these routes, so they are invisible to a "
        f"reader of that page: {missing}")


def test_the_index_route_counts_match_the_write_report():
    """The numbers, which drift whenever a ruling moves a table."""
    authored = _index_route_counts()
    wrong = {}
    for action, count in _written_route_counts().items():
        label = ROUTE_LABELS.get(action)
        if label in authored and authored[label] != count:
            wrong[label] = f"page says {authored[label]}, writer wrote {count}"
    assert wrong == {}, f"index.md route counts are stale: {wrong}"


def test_no_row_on_index_names_a_route_that_no_longer_exists():
    """The other direction: a route retired from the writer leaves a row
    behind that reads as current."""
    produced = {ROUTE_LABELS[action] for action in _written_route_counts()
                if action in ROUTE_LABELS}
    stale = [label for label in _index_route_counts() if label not in produced]
    assert stale == [], (
        f"index.md lists routes the writer no longer produces: {stale}")


# ---------------------------------------------------------------------------
# The authored blocked-tables list on known-issues.md
# ---------------------------------------------------------------------------
#
# Same failure mode as the route table above, and it had drifted further:
# the page listed fourteen tables when five were blocked, and still named
# 0895, which had been published a session earlier. A reader of that page was
# being told nine tables were stuck that are not.
#
# The heading carries a spelled-out count, which is the part most likely to
# be left behind when the list under it is edited, so it is checked too.

BLOCKED_HEADING_RE = re.compile(
    r"^###\s+(\w+)\s+tables? with nothing written\s*$", re.MULTILINE)
BLOCKED_CODES_RE = re.compile(r"`(\d{4})`")

NUMBER_WORDS = {
    "One": 1, "Two": 2, "Three": 3, "Four": 4, "Five": 5, "Six": 6,
    "Seven": 7, "Eight": 8, "Nine": 9, "Ten": 10, "Eleven": 11,
    "Twelve": 12, "Thirteen": 13, "Fourteen": 14, "Fifteen": 15,
    "Sixteen": 16, "Seventeen": 17, "Eighteen": 18, "Nineteen": 19,
    "Twenty": 20,
}


def _known_issues_blocked():
    """The blocked-table list as authored, as (heading word, [tables])."""
    page = (build.PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
            / "known-issues.md").read_text(encoding="utf-8")
    heading = BLOCKED_HEADING_RE.search(page)
    assert heading, "known-issues.md has no 'N tables with nothing written' heading"
    # The list is the paragraph of backticked numbers right after the heading.
    rest = page[heading.end():]
    paragraph = rest.split("\n\n")[1] if "\n\n" in rest else ""
    return heading.group(1), BLOCKED_CODES_RE.findall(paragraph)


def _blocked_tables():
    """The tables the writer actually left unwritten."""
    report = json.loads(
        (build.PROJECT_ROOT / "v291-fhir" / "utg-write-report.json")
        .read_text(encoding="utf-8"))
    return sorted(entry["table"] for entry in report["tables"]
                  if entry["action"] == "needs-decision")


def test_known_issues_lists_exactly_the_blocked_tables():
    """A ruling that unblocks a table must take it off this page too."""
    _, authored = _known_issues_blocked()
    assert sorted(authored) == _blocked_tables(), (
        f"known-issues.md lists {sorted(authored)} as blocked; the writer "
        f"left {_blocked_tables()} unwritten")


def test_the_known_issues_heading_count_matches_its_own_list():
    """The spelled-out number in the heading, which is edited separately
    from the list under it and so gets left behind."""
    word, authored = _known_issues_blocked()
    expected = NUMBER_WORDS.get(word)
    assert expected is not None, (
        f"unrecognised number word {word!r} in the known-issues heading; "
        f"add it to NUMBER_WORDS")
    assert expected == len(authored), (
        f"the heading says {word} ({expected}) but the list under it has "
        f"{len(authored)} tables")
