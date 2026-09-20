#!/usr/bin/env python3
"""Tests for the concept domains generator's narrative link handling.

THO's narrative links to sibling code systems as bare page filenames
(`CodeSystem-v3-ActClass.html`). Those resolve only inside THO's own published
site; in this IG they dangle, and they dangle silently -- the rendered HTML
shows none of them, so they exist only in the distributed `.json`/`.xml`/`.ttl`
and in the publisher's QA output. The rewrite below is therefore the only thing
standing between a reader of the distributed resource and a dead link, which is
why it is pinned by tests rather than left as an obvious one-liner.

The two rules being held: a link is rewritten only when the snapshot proves the
target exists at the canonical we are about to write, and an unrecognised link
is reported rather than guessed at.

Run:
    python3 -m pytest tooling/scripts/test_generate_concept_domains.py
"""

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

import generate_concept_domains as gen  # noqa: E402


@pytest.fixture
def snapshot(tmp_path, monkeypatch):
    """A stand-in THO snapshot carrying one code system, `v3-ActClass`.

    The real snapshot at `tho-r5/` is gitignored, so tests must not depend on
    it being present.
    """
    (tmp_path / "CodeSystem-v3-ActClass.json").write_text(json.dumps({
        "resourceType": "CodeSystem",
        "id": "v3-ActClass",
        "url": "http://terminology.hl7.org/CodeSystem/v3-ActClass",
    }))
    monkeypatch.setattr(gen, "THO_SNAPSHOT_DIR", tmp_path)
    return tmp_path


def resource_with_narrative(div):
    return {"resourceType": "CodeSystem", "text": {"status": "generated", "div": div}}


def test_known_page_link_becomes_the_canonical(snapshot):
    resource = resource_with_narrative(
        '<div><a href="CodeSystem-v3-ActClass.html">ActClass</a></div>')

    rewritten, skipped = gen.absolutize_narrative_links(resource)

    assert 'href="http://terminology.hl7.org/CodeSystem/v3-ActClass"' in resource["text"]["div"]
    assert rewritten == {"CodeSystem-v3-ActClass.html": 1}
    assert skipped == {}


def test_every_occurrence_is_rewritten_and_counted(snapshot):
    resource = resource_with_narrative(
        '<div><a href="CodeSystem-v3-ActClass.html">one</a>'
        '<a href="CodeSystem-v3-ActClass.html">two</a></div>')

    rewritten, _ = gen.absolutize_narrative_links(resource)

    assert rewritten == {"CodeSystem-v3-ActClass.html": 2}
    assert "CodeSystem-v3-ActClass.html" not in resource["text"]["div"]


def test_link_absent_from_the_snapshot_is_left_alone_and_reported(snapshot):
    """No canonical is invented for a target we cannot prove exists."""
    resource = resource_with_narrative(
        '<div><a href="CodeSystem-v3-NoSuchThing.html">gone</a></div>')

    rewritten, skipped = gen.absolutize_narrative_links(resource)

    assert rewritten == {}
    assert skipped == {"CodeSystem-v3-NoSuchThing.html": 1}
    assert 'href="CodeSystem-v3-NoSuchThing.html"' in resource["text"]["div"]


def test_link_whose_snapshot_canonical_disagrees_is_left_alone(snapshot):
    """A code system published at some other URL is not forced into the pattern."""
    (snapshot / "CodeSystem-v3-Odd.json").write_text(json.dumps({
        "resourceType": "CodeSystem",
        "id": "v3-Odd",
        "url": "http://example.org/elsewhere/v3-Odd",
    }))
    resource = resource_with_narrative(
        '<div><a href="CodeSystem-v3-Odd.html">odd</a></div>')

    rewritten, skipped = gen.absolutize_narrative_links(resource)

    assert rewritten == {}
    assert skipped == {"CodeSystem-v3-Odd.html": 1}


def test_other_links_are_untouched(snapshot):
    """Only THO's site-relative CodeSystem pages are in scope."""
    div = ('<div><a href="http://hl7.org/fhir/R5/codesystem.html">spec</a>'
           '<a href="ValueSet-v3-ActClass.html">a value set page</a></div>')
    resource = resource_with_narrative(div)

    rewritten, skipped = gen.absolutize_narrative_links(resource)

    assert (rewritten, skipped) == ({}, {})
    assert resource["text"]["div"] == div


def test_resource_without_narrative_is_handled(snapshot):
    resource = {"resourceType": "CodeSystem"}

    assert gen.absolutize_narrative_links(resource) == ({}, {})
