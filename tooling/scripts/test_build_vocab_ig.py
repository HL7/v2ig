"""Tests for the vocabulary IG build orchestrator.

The point of the orchestrator is that the step order stops being a convention
somebody has to remember. These tests hold that: that the declared order is
sound, that a wrong order is actually caught, and that every step names a
script that exists.
"""

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
