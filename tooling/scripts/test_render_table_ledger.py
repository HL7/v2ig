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
    assert "#### 0001 — Administrative Sex" in page
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
    section = page.split("#### 0001")[1]
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
    assert "2.16.840.1.113883.18.455" in page.split("#### 0001")[1]


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
    assert "#### 0012\n" in page          # no name, and not "0012 — 0012"
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


# --------------------------------------------------------------------------
# Shading: the page has 449 sections and a reader scrolls past most of them,
# so the ones that want attention have to be visible without being read. These
# tests pin which table gets which treatment, and that the shading and the
# jump links at the top of the page never disagree about the set.
# --------------------------------------------------------------------------

def shading_of(page, table):
    """The `tl-hd-*` class on one table's heading, or None if unshaded."""
    import re

    match = re.search(r"^#### " + table + r"(?: —[^\n]*)?\n\{: \.tl-hd \.tl-hd-"
                      r"(\w+)\}$", page, re.M)
    return match.group(1) if match else None


def tables_in_jump_list(page, label):
    """The table numbers linked from one of the jump-link paragraphs."""
    import re

    match = re.search(r'<p class="tl-jump">' + label + r": (.*?)</p>",
                      page, re.S)
    return set(re.findall(r"#tbl-(\d{4})", match.group(1))) if match else set()


def multi_table_fixtures():
    """Five tables, one for each way a section can be flagged.

    0001 differs from THO and carries a register item; 0002 only differs;
    0003 only carries an item; 0004 is blocked on a decision; 0005 is quiet.
    """
    index = {}
    for number, name in (("0001", "Administrative Sex"), ("0002", "Marital"),
                         ("0003", "Event"), ("0004", "Country"),
                         ("0005", "Race")):
        index[number] = {"tableNumber": number, "tableName": name,
                         "tableOID": f"2.16.840.1.113883.12.{int(number)}"}
    write_report = {"counts": {}, "tables": [
        {"table": "0001", "name": "Administrative Sex",
         "action": "code-system-and-value-set", "written": ["a.xml"]},
        {"table": "0002", "name": "Marital",
         "action": "code-system-and-value-set", "written": ["b.xml"]},
        {"table": "0003", "name": "Event",
         "action": "code-system-and-value-set", "written": ["c.xml"]},
        {"table": "0004", "name": "Country", "action": "needs-decision",
         "reason": "The table declares 2 code systems; which one the value "
                   "set draws from is not stated.",
         "candidates": ["1.0.3166.1", "1.0.3166.2"], "written": []},
        {"table": "0005", "name": "Race",
         "action": "code-system-and-value-set", "written": ["e.xml"]},
    ]}
    records = [
        {"kind": "discrepancy", "element": "concept.property",
         "property": "status", "ours": "active", "tho": "N",
         "table": "0001", "resource": "CodeSystem", "code": "X"},
        {"kind": "discrepancy", "element": "concept.property",
         "property": "status", "ours": "active", "tho": "N",
         "table": "0002", "resource": "CodeSystem", "code": "Y"},
    ]
    register = {
        "0001": [{"id": "esc-oid-conflicts", "title": "OIDs conflict",
                  "who": "V2 Management", "partial": False}],
        "0003": [{"id": "esc-example", "title": "Something open",
                  "who": "V2 Management", "partial": False}],
    }
    return make_report(records), write_report, index, register


def test_each_reason_for_a_second_look_gets_its_own_shading():
    """One undifferentiated highlight would not say what to expect."""
    page = ledger.render_page(*multi_table_fixtures())
    assert shading_of(page, "0001") == "both"
    assert shading_of(page, "0002") == "diff"
    assert shading_of(page, "0003") == "issue"
    assert shading_of(page, "0004") == "decision"
    assert shading_of(page, "0005") is None


def test_a_shaded_heading_says_in_words_why_it_is_shaded():
    """Colour alone is not available to every reader."""
    page = ledger.render_page(*multi_table_fixtures())
    section = page.split("#### 0001")[1].split("#### 0002")[0]
    assert 'class="tl-why tl-why-both"' in section
    assert "Differs from THO" in section and "Open register item" in section


def test_the_worst_reason_sets_the_tint_and_the_rest_are_still_named():
    """A table can qualify twice; the heading can only be one colour."""
    report, write_report, index, register = multi_table_fixtures()
    register["0004"] = [{"id": "esc-example", "title": "Open",
                         "who": "V2 Management", "partial": False}]
    page = ledger.render_page(report, write_report, index, register)
    assert shading_of(page, "0004") == "decision"
    section = page.split("#### 0004")[1].split("#### 0005")[0]
    assert "Blocked on a decision · Open register item" in section


def test_an_oid_conflict_is_named_on_the_heading_marker():
    report, write_report, index, register = multi_table_fixtures()
    report["records"].append(
        {"kind": "discrepancy", "element": "identifier",
         "ours": "2.16.840.1.113883.18.458", "tho": "2.16.840.1.113883.18.2",
         "table": "0001", "resource": "CodeSystem"})
    page = ledger.render_page(report, write_report, index, register)
    section = page.split("#### 0001")[1].split("#### 0002")[0]
    assert "OID conflict with THO" in section


def test_every_shaded_section_is_in_a_jump_list_and_the_reverse():
    """The two ways of finding a table must agree about which tables there are."""
    import re

    page = ledger.render_page(*multi_table_fixtures())
    shaded = set(re.findall(r"^#### (\d{4})(?: —[^\n]*)?\n\{: \.tl-hd ",
                            page, re.M))
    listed = (tables_in_jump_list(page, "Differs from THO")
              | tables_in_jump_list(page, "Open register item")
              | tables_in_jump_list(page, "Blocked on a decision")
              | tables_in_jump_list(page, "Needs special consideration"))
    assert shaded == listed
    assert shaded == {"0001", "0002", "0003", "0004"}


def test_the_legend_counts_match_the_sections_actually_shaded():
    """A legend that miscounts discredits the shading it explains."""
    import re

    page = ledger.render_page(*multi_table_fixtures())
    legend = {key: int(count) for key, count in re.findall(
        r'tl-hd-(\w+)">[^<]*?\((\d+)\)</span>', page)}
    actual = {}
    for key in re.findall(r"^\{: \.tl-hd \.tl-hd-(\w+)\}$", page, re.M):
        actual[key] = actual.get(key, 0) + 1
    assert legend == {**{key: 0 for key, _ in ledger.FLAG_TIERS}, **actual}


def test_the_legend_lists_every_tier_even_the_empty_ones():
    page = ledger.render_page(*multi_table_fixtures())
    for key, label in ledger.FLAG_TIERS:
        assert f"tl-hd-{key}" in page and label in page


def test_the_shading_classes_are_all_defined_in_the_pages_own_style_block():
    """There is no shared stylesheet to fall back on."""
    page = ledger.render_page(*multi_table_fixtures())
    style = page.split("<style>")[1].split("</style>")[0]
    for key, _label in ledger.FLAG_TIERS:
        assert f".tl-hd-{key}" in style
    assert ".tl-why" in style and "blockquote.tl-callout" in style


def test_a_table_blocked_on_a_decision_says_so_before_anything_else():
    page = ledger.render_page(*multi_table_fixtures())
    section = page.split("#### 0004")[1].split("#### 0005")[0]
    assert "blocked on a decision" in section
    assert "publishes no code system and no value set" in section
    assert "1.0.3166.1" in section and "1.0.3166.2" in section
    # The comforting line belongs only to tables that do publish something.
    assert "matches THO on every element compared" not in section


def test_a_blocked_table_is_never_left_out_of_the_page():
    """It has no observations, so nothing else would pull it into a section."""
    report, write_report, index, register = multi_table_fixtures()
    page = ledger.render_page(report, write_report, index, register)
    assert "#### 0004 — Country" in page
    assert "`0004`" not in page.split("## The remaining tables")[1]


def test_a_table_named_only_by_the_register_is_never_left_out_of_the_page():
    page = ledger.render_page(*multi_table_fixtures())
    assert "#### 0003 — Event" in page
    assert "`0003`" not in page.split("## The remaining tables")[1]


# --------------------------------------------------------------------------
# Table 0821 and the voice of the page
# --------------------------------------------------------------------------

def test_table_0821_is_given_the_strongest_flagging_the_page_has():
    """The chapter publishes it blank; a reader has to be told before reading."""
    report, write_report, index, register = multi_table_fixtures()
    index["0821"] = {"tableNumber": "0821", "tableName": "Gender Identity",
                     "tableOID": "2.16.840.1.113883.12.821"}
    write_report["tables"].append(
        {"table": "0821", "name": "Gender Identity",
         "action": "needs-decision",
         "reason": "The table declares 3 code systems; which one the value "
                   "set draws from is not stated.",
         "candidates": ["2.16.840.1.113883.6.96"], "written": []})
    register["0821"] = [{"id": "esc-0821-blank-grid",
                         "title": "Table 0821 publishes its grid blank",
                         "who": "V2 Management", "partial": False}]
    page = ledger.render_page(report, write_report, index, register)

    assert shading_of(page, "0821") == "attention"
    assert ledger.FLAG_TIERS[0][0] == "attention"      # the top tier
    assert "0821" in tables_in_jump_list(page, "Needs special consideration")

    section = page.split("#### 0821")[1].split("#### 0822")[0] \
        if "#### 0822" in page else page.split("#### 0821")[1]
    assert "completely blank" in section
    assert "needs a decision" in section.lower()
    assert "V2 Management" in section


def test_the_0821_statement_rests_only_on_what_the_chapter_and_tho_publish():
    """Facts a committee member can check, not an assertion to be trusted."""
    text = " ".join(ledger.SPECIAL_CONSIDERATION["0821"])
    assert "2.16.840.1.113883.4.642.3.3291" in text   # the printed VS OID
    assert "five" in text                             # the five missing rows
    assert "ValueSet/gender-identity" in text
    assert "0823" in text                             # the table built the same way


def test_the_page_never_uses_the_small_element():
    """The IG Publisher's HTML checker rejects it and warns on every use."""
    page = ledger.render_page(*multi_table_fixtures())
    assert "<small" not in page and "</small>" not in page


def test_the_page_points_at_no_internal_working_document():
    """The IG is where these issues are reported; there is nowhere else to go."""
    page = ledger.render_page(*multi_table_fixtures())
    for fragment in ("v291-extracted", "v291-fhir", "tho-fill-report",
                     "utg-write-report", "vocabulary-index.json",
                     "vocabulary-v2mgmt-items", "tooling/scripts", ".py`"):
        assert fragment not in page, fragment


def test_the_also_affects_bullet_says_what_a_class_is():
    page = ledger.render_page(*multi_table_fixtures())
    assert ("a one-off or an instance of a class of problem that is repeated "
            "elsewhere") in page


def test_the_section_carries_the_anchor_the_table_index_links_to():
    """The index links here by an authored id, not a heading slug."""
    page = ledger.render_page(*multi_table_fixtures())
    assert '<a id="content-and-open-items"></a>' in page


def test_the_section_points_back_at_the_table_index():
    page = ledger.render_page(*multi_table_fixtures())
    assert "table-index.html#coverage-anomalies" in page


def test_the_reader_is_told_the_two_lists_measure_different_things():
    """20-odd tables on one page and 165 on another reads as a contradiction
    unless each says what it counts."""
    page = ledger.render_page(*multi_table_fixtures())
    assert "A table can appear on both lists, on one, or on neither." in page
