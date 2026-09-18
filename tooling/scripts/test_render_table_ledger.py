#!/usr/bin/env python3
"""Tests for the per-table ledger.

The ledger's job is to let a reviewer check one table and see everything this
guide did to it. What that costs, and what these tests hold:

  * no difference is silently dropped -- a table that changed must say so;
  * a difference that is an instance of a class must say how far the class
    reaches, because that changes who has to answer it;
  * two long values that differ only at the end must be shown differing, not
    truncated into two identical cells;
  * an OID disagreement must appear in the table's own section, not only in
    the page-level summary.

Run:
    python3 -m pytest tooling/scripts/test_render_table_ledger.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import render_table_ledger as ledger  # noqa: E402


def make_report(records=None, classes=None):
    return {
        "source": {"package": "hl7.terminology.r5", "version": "7.3.0"},
        "counts": {"observations": len(records or [])},
        "classes": classes or [
            {"class": "discrepancy:concept.property:status", "kind": "discrepancy",
             "element": "concept.property", "property": "status",
             "title": "Concept status where the chapter and THO disagree",
             "why": "", "count": 261, "tableCount": 25, "tables": ["0001"]},
            {"class": "discrepancy:identifier", "kind": "discrepancy",
             "element": "identifier", "property": None,
             "title": "Identifiers where the chapter and THO disagree",
             "why": "", "count": 2, "tableCount": 2, "tables": ["0001"]},
            {"class": "fill:concept.definition", "kind": "fill",
             "element": "concept.definition", "property": None,
             "title": "Concept definitions kept from THO",
             "why": "", "count": 4855, "tableCount": 382, "tables": ["0001"]},
        ],
        "records": records if records is not None else [],
    }


def make_write_report(**version):
    return {"counts": {}, "tables": [{
        "table": "0001", "name": "Administrative Sex",
        "action": "code-system-and-value-set",
        "written": ["codeSystems/cs-v2-0001.xml"],
        "codeSystemVersion": version or {
            "version": "4.0.0", "reason": "Changed: concept.",
            "incremented": True, "triggers": ["concept"]},
    }]}


def make_index(**overrides):
    row = {"tableNumber": "0001", "tableName": "Administrative Sex",
           "tableOID": "2.16.840.1.113883.12.1",
           "codeSystemOID": "2.16.840.1.113883.18.458",
           "valueSetOID": "2.16.840.1.113883.21.2",
           "tableType": "User"}
    row.update(overrides)
    return {"0001": row}


def render(records, register=None, index=None):
    return ledger.render_page(make_report(records), make_write_report(),
                              index or make_index(), register or {})


def test_a_disagreement_reaches_the_table_it_belongs_to():
    page = render([{"kind": "discrepancy", "element": "concept.property",
                    "property": "status", "ours": "active", "tho": "N",
                    "table": "0001", "resource": "CodeSystem", "code": "X"}])
    assert "### 0001 — Administrative Sex" in page
    assert "Disagreement" in page and "`X`" in page
    assert "active" in page and "| N " in page


def test_a_class_says_how_many_other_tables_it_reaches():
    """A one-off is a data question; a class of 25 is a policy question."""
    page = render([{"kind": "discrepancy", "element": "concept.property",
                    "property": "status", "ours": "active", "tho": "N",
                    "table": "0001", "resource": "CodeSystem", "code": "X"}])
    assert "24 other tables" in page


def test_a_difference_seen_nowhere_else_says_so():
    page = render([{"kind": "discrepancy", "element": "status",
                    "ours": "active", "tho": "retired",
                    "table": "0001", "resource": "ValueSet"}])
    assert "only here" in page


def test_fills_are_counted_not_listed():
    """Seven thousand absences of a change are a number, not a list."""
    records = [{"kind": "fill", "element": "concept.definition",
                "value": f"definition {n}", "table": "0001",
                "resource": "CodeSystem", "code": str(n)} for n in range(6)]
    page = render(records)
    assert "Kept from THO (6)" in page
    assert "Concept definitions kept from THO | 6" in page
    assert "definition 3" not in page


def test_an_oid_disagreement_appears_in_the_tables_own_section():
    """The page-level summary is not enough: a reader checks one table."""
    page = render([{"kind": "discrepancy", "element": "identifier",
                    "ours": "2.16.840.1.113883.18.458",
                    "tho": "2.16.840.1.113883.18.2",
                    "table": "0001", "resource": "CodeSystem"}])
    section = page.split("### 0001")[1]
    assert "**Identifiers.**" in section
    assert "2.16.840.1.113883.18.458" in section
    assert "2.16.840.1.113883.18.2" in section
    assert "esc-oid-conflicts" in section


def test_the_table_oid_is_reported_as_going_nowhere():
    """798 tables carry an OID this guide publishes on no resource."""
    page = render([])
    assert "Table OID" in page and "**nowhere**" in page


def test_a_table_oid_that_is_a_bare_arc_root_is_not_counted_as_an_identifier():
    index = make_index(tableOID="2.16.840.1.113883.1", tableType="undefined")
    page = ledger.render_page(make_report([]), make_write_report(), index, {})
    assert "are not identifiers" in page


def test_an_identifier_fill_is_named_rather_than_only_counted():
    """Which OID ended up on the artifact is worth saying even with no dispute."""
    page = render([{"kind": "fill", "element": "identifier",
                    "value": "2.16.840.1.113883.18.455",
                    "table": "0001", "resource": "CodeSystem"}])
    assert "2.16.840.1.113883.18.455" in page.split("### 0001")[1]


def test_two_long_values_differing_at_the_end_are_shown_differing():
    """Truncating the head of both would render them identical."""
    shared = "Value Set of codes that specify the reason for restricted "
    shared += "access, which is a long sentence written to exceed the cell. "
    page = render([{"kind": "discrepancy", "element": "description",
                    "ours": shared + "Nothing more.",
                    "tho": shared + "Created in THO in error.",
                    "table": "0001", "resource": "ValueSet"}])
    assert "Nothing more." in page
    assert "Created in THO in error." in page


def test_register_items_reach_the_tables_they_name():
    register = {"0001": [{"id": "esc-oid-conflicts", "title": "OIDs conflict",
                          "who": "V2 Management", "partial": False}]}
    page = render([], register=register)
    assert "esc-oid-conflicts" in page and "OIDs conflict" in page


def test_a_register_item_with_an_open_ended_table_list_says_so():
    """Absence from an illustrative list is not evidence of absence."""
    register = {"0001": [{"id": "esc-full-name-copy-paste", "title": "Copied",
                          "who": "V2 Management", "partial": True}]}
    page = render([], register=register)
    assert "not exhaustive" in page


def test_pipes_in_a_value_cannot_break_the_table():
    page = render([{"kind": "discrepancy", "element": "concept.display",
                    "ours": "a|b", "tho": "c|d", "table": "0001",
                    "resource": "CodeSystem", "code": "X"}])
    assert "a\\|b" in page and "c\\|d" in page


def test_every_table_is_accounted_for():
    """A table with nothing to say still has to appear somewhere."""
    index = make_index()
    index["0999"] = {"tableNumber": "0999", "tableName": "Quiet",
                     "tableOID": "2.16.840.1.113883.12.999"}
    page = ledger.render_page(make_report([]), make_write_report(), index, {})
    assert "`0999`" in page
    assert "The remaining tables" in page


def test_the_page_says_which_snapshot_the_numbers_came_from():
    page = render([])
    assert "hl7.terminology.r5" in page and "7.3.0" in page


def test_a_canonical_with_no_chapter_table_is_not_counted_as_one():
    """THO publishes `v2-NNNN` for numbers the chapter has no section for.

    They belong on the page -- a reviewer asking about one deserves an answer
    -- but counting them among the chapter's tables made the page's own
    arithmetic wrong, which is the kind of error that discredits the rest.
    """
    page = ledger.render_page(
        make_report([{"kind": "omission", "table": "0012",
                      "resource": "CodeSystem", "element": "resource",
                      "url": "http://terminology.hl7.org/CodeSystem/v2-0012",
                      "reason": "The chapter has no section for it."}]),
        make_write_report(), make_index(), {})
    assert "Canonicals with no Chapter 2C table" in page
    assert "### 0012\n" in page          # no name, and not "0012 — 0012"
    assert "Not a Chapter 2C table" in page


def test_the_pages_own_arithmetic_adds_up():
    """Sections covered plus sections deferred must equal the chapter total."""
    import re

    index = make_index()
    for n in range(2, 6):                       # four more chapter tables
        number = f"000{n}"
        index[number] = {"tableNumber": number, "tableName": f"Table {n}",
                         "tableOID": f"2.16.840.1.113883.12.{n}"}
    page = ledger.render_page(
        make_report([{"kind": "omission", "table": "0012",
                      "resource": "CodeSystem", "element": "resource",
                      "reason": "The chapter has no section for it."}]),
        make_write_report(), index, {})

    covered = int(re.search(r"\*\*(\d+) of the chapter's (\d+) tables", page).group(1))
    total = int(re.search(r"\*\*(\d+) of the chapter's (\d+) tables", page).group(2))
    remaining = int(re.search(r"The remaining (\d+) of the chapter's", page).group(1))
    assert total == len(index)
    assert covered + remaining == total
