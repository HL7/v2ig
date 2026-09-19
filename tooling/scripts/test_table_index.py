#!/usr/bin/env python3
"""Tests for the Chapter 2C table index generator.

The link precedence rule is the part worth guarding: a link that says "this
guide" and resolves to THO, or the reverse, misleads a reviewer silently.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import generate_table_index as gti


def artifact(canonical, ig_id=None, in_tho=False):
    return {"canonical": canonical, "igId": ig_id, "inTho": in_tho, "state": "x"}


class TestLinkPrecedence:
    """Rule 1 beats rule 2 beats rule 3, and the text is always the canonical."""

    def test_authored_here_resolves_into_the_guide(self):
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/CodeSystem/v2-0001", "v2-0001", in_tho=True),
            "CodeSystem")
        assert 'href="CodeSystem-v2-0001.html"' in cell
        assert "this guide" in cell
        # the visible text is still the THO canonical
        assert "http://terminology.hl7.org/CodeSystem/v2-0001</a>" in cell

    def test_authored_here_wins_even_when_tho_also_has_it(self):
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/ValueSet/v2-0001", "v2-0001", in_tho=True),
            "ValueSet")
        assert 'href="ValueSet-v2-0001.html"' in cell
        assert 'href="http://terminology.hl7.org' not in cell

    def test_not_authored_here_falls_through_to_tho(self):
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/ValueSet/v2-0350", None, in_tho=True), "ValueSet")
        assert 'href="http://terminology.hl7.org/ValueSet/v2-0350"' in cell
        assert "THO" in cell

    def test_nowhere_is_plain_text(self):
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/CodeSystem/v2-9999", None, in_tho=False),
            "CodeSystem")
        assert "<a " not in cell
        assert "not published" in cell

    def test_notallcodes_canonical_uses_its_own_id(self):
        """Three value sets sit at v2-notAllCodes-NNNN; the link must follow the id."""
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/ValueSet/v2-notAllCodes-0291",
                     "v2-notAllCodes-0291", in_tho=True), "ValueSet")
        assert 'href="ValueSet-v2-notAllCodes-0291.html"' in cell


class TestClassification:
    def _row(self, route, cs_state, vs_state, **kw):
        row = {
            "table": "0001", "route": route,
            "codeSystem": {"state": cs_state, "igId": kw.get("cs_id"), "canonical": "c", "inTho": False},
            "valueSet": {"state": vs_state, "igId": kw.get("vs_id"), "canonical": "v", "inTho": False},
            "conceptDomain": kw.get("domain", "D"), "conceptDomainDeclared": kw.get("declared", "D"),
            "_thoValueSet": kw.get("tho_vs"), "_thoCodeSystem": kw.get("tho_cs"),
            "_thoCodeSystems": kw.get("tho_all", {}),
        }
        return gti.classify(row)

    def test_the_norm_is_not_shaded(self):
        assert self._row("code-system-and-value-set", "both", "both")["exception"] is None

    def test_concept_domain_only_with_nothing_anywhere_is_the_norm(self):
        assert self._row("concept-domain-only", "neither", "neither")["exception"] is None

    def test_value_set_only_does_not_flag_an_external_code_system_in_tho(self):
        """The code system belongs to another authority; THO holding it is expected."""
        row = self._row("value-set-only", "tho-only", "both")
        assert row["exception"] is None
        assert row["notes"] == []

    def test_authored_here_but_absent_from_tho_is_flagged_new(self):
        row = self._row("code-system-and-value-set", "ig-only", "ig-only")
        assert row["exception"] == "new-to-tho"
        assert "code system and value set" in row["notes"][0]

    def test_tho_has_it_and_we_do_not(self):
        row = self._row("concept-domain-only", "neither", "tho-only")
        assert row["exception"] == "tho-only"

    def test_dangling_tho_value_set_outranks_plain_tho_only(self):
        tho_vs = {"compose": {"include": [
            {"system": "http://terminology.hl7.org/CodeSystem/v2-0350"}]}}
        row = self._row("concept-domain-only", "neither", "tho-only", tho_vs=tho_vs, tho_all={})
        assert row["exception"] == "tho-dangling"
        assert "cannot expand" in row["notes"][-1]

    def test_external_system_in_a_tho_value_set_is_not_dangling(self):
        """CVX is not a THO canonical, so its absence from THO proves nothing."""
        tho_vs = {"compose": {"include": [{"system": "http://hl7.org/fhir/sid/cvx"}]}}
        row = self._row("concept-domain-only", "neither", "tho-only", tho_vs=tho_vs, tho_all={})
        assert row["exception"] == "tho-only"

    def test_non_active_tho_status_is_reported(self):
        row = self._row("concept-domain-only", "neither", "tho-only",
                        tho_vs={"status": "retired"}, tho_all={})
        assert any("retired" in n for n in row["notes"])

    def test_declared_domain_missing_from_conceptdomains_is_noted(self):
        row = self._row("concept-domain-only", "neither", "neither", domain="", declared="Ghost")
        assert any("Ghost" in n for n in row["notes"])


class TestSuppressedCanonicals:
    """A canonical we invented for lookup is not a fact about the table."""

    def test_constructed_and_absent_everywhere_renders_nothing(self):
        cell = gti.render_link(
            {"canonical": "http://terminology.hl7.org/CodeSystem/v2-0010",
             "igId": None, "inTho": False, "constructed": True}, "CodeSystem")
        assert cell == "\u2014"

    def test_a_writer_supplied_canonical_is_still_shown(self):
        """ISO 3166 is a real identifier even though THO does not carry it."""
        cell = gti.render_link(
            {"canonical": "urn:iso:std:iso:3166", "igId": None, "inTho": False,
             "constructed": False}, "CodeSystem")
        assert "urn:iso:std:iso:3166" in cell
        assert "not published" in cell

    def test_constructed_but_present_in_tho_still_links(self):
        cell = gti.render_link(
            {"canonical": "http://terminology.hl7.org/ValueSet/v2-0350",
             "igId": None, "inTho": True, "constructed": True}, "ValueSet")
        assert 'href="http://terminology.hl7.org/ValueSet/v2-0350"' in cell


class TestNewTab:
    def test_artifact_links_open_in_a_new_tab(self):
        cell = gti.render_link(
            {"canonical": "http://terminology.hl7.org/CodeSystem/v2-0001",
             "igId": "v2-0001", "inTho": True, "constructed": False}, "CodeSystem")
        assert 'target="_blank"' in cell and 'rel="noopener"' in cell

    def test_domain_links_open_in_a_new_tab(self):
        cell = gti.render_domain(
            {"conceptDomain": "AdministrativeSex", "conceptDomainDeclared": "AdministrativeSex",
             "conceptDomainInTho": True, "thoVersion": "3.0.0"})
        assert 'target="_blank"' in cell and 'rel="noopener"' in cell


class TestDomainProvenance:
    """The domain column's one marker says whether THO already has the concept."""

    def test_concept_already_in_tho_is_marked_so(self):
        cell = gti.render_domain(
            {"conceptDomain": "AdministrativeSex", "conceptDomainDeclared": "AdministrativeSex",
             "conceptDomainInTho": True, "thoVersion": "3.0.0"})
        assert "already in THO" in cell
        assert "added by this guide" not in cell
        # no version is claimed on the row: which release an addition
        # would land in is unknown
        assert "4.0.0" not in cell and "3.0.0" not in cell

    def test_concept_added_here_is_marked_new(self):
        cell = gti.render_domain(
            {"conceptDomain": "EmploymentStatusODH", "conceptDomainDeclared": "EmploymentStatusODH",
             "conceptDomainInTho": False, "thoVersion": "3.0.0"})
        assert "added by this guide" in cell
        assert "4.0.0" not in cell

    def test_the_domain_column_carries_no_destination_marker(self):
        """It is always "this guide", so saying so on every row is noise."""
        for in_tho in (True, False):
            cell = gti.render_domain(
                {"conceptDomain": "AdministrativeSex",
                 "conceptDomainDeclared": "AdministrativeSex",
                 "conceptDomainInTho": in_tho})
            assert "ti-dest" not in cell
            # the destination marker's exact text, not the substring that
            # survives inside "added by this guide"
            assert ">this guide</span>" not in cell

    def test_the_destination_marker_survives_on_the_artifact_columns(self):
        """It varies there, so it still earns its place."""
        cell = gti.render_link(
            artifact("http://terminology.hl7.org/CodeSystem/v2-0001", "v2-0001"), "CodeSystem")
        assert 'class="ti-dest"' in cell

    def test_both_markers_are_readable_without_a_key(self):
        assert set(gti.DOMAIN_ORIGIN.values()) == {"already in THO", "added by this guide"}

    def test_real_corpus_splits_between_the_two(self):
        rows = gti.build_rows()
        in_tho = {r["conceptDomain"] for r in rows if r["conceptDomain"] and r["conceptDomainInTho"]}
        added = {r["conceptDomain"] for r in rows if r["conceptDomain"] and not r["conceptDomainInTho"]}
        assert len(added) == 177, len(added)
        assert len(in_tho) == 583, len(in_tho)


class TestSquishedDomains:
    def test_spaces_are_removed_before_lookup(self):
        assert gti.squish_spaces("Masterfile Action Code") == "MasterfileActionCode"

    def test_0180_resolves_to_a_real_concept(self):
        rows = {r["table"]: r for r in gti.build_rows()}
        assert rows["0180"]["conceptDomain"] == "MasterfileActionCode"

    def test_no_declared_domain_is_left_unresolved(self):
        codes = gti.load_concept_domain_codes()
        unresolved = [r["table"] for r in gti.build_rows()
                      if r["conceptDomainDeclared"] and r["conceptDomainDeclared"] not in codes]
        assert unresolved == [], unresolved


class TestUnresolvedRows:
    def test_nothing_anywhere_is_shaded_as_an_open_question(self):
        rows = {r["table"]: r for r in gti.build_rows()}
        for table in ("0010", "0188", "9999", "0647", "0662"):
            assert rows[table]["exception"] == "unresolved", table

    def test_exactly_five_such_rows(self):
        assert sum(1 for r in gti.build_rows() if r["exception"] == "unresolved") == 5


class TestV2TablesCrossCheck:
    def test_disagreement_with_tho_index_is_noted(self):
        rows = {r["table"]: r for r in gti.build_rows()}
        assert any("EventType" in n for n in rows["0003"]["notes"])

    def test_only_one_disagreement_remains(self):
        clashes = [r["table"] for r in gti.build_rows()
                   if r.get("thoVocabDomain") and r["conceptDomainDeclared"]
                   and r["thoVocabDomain"] != r["conceptDomainDeclared"]]
        assert clashes == ["0003"], clashes


class TestOrphanTables:
    """v2-tables entries the chapter has dropped, and their dangling domains."""

    def test_thirty_nine_orphans(self):
        assert len(gti.build_orphan_rows()) == 39

    def test_none_of_them_appear_in_the_main_index(self):
        main = {r["table"] for r in gti.build_rows()}
        assert not (main & {o["table"] for o in gti.build_orphan_rows()})

    def test_thirty_five_name_an_undefined_domain(self):
        orphans = gti.build_orphan_rows()
        unresolved = [o for o in orphans if o["domain"] and not o["resolves"]]
        assert len(unresolved) == 35, len(unresolved)

    def test_cda_synonym_is_not_flagged(self):
        """AdministratableDrugForm is a documented v3/CDA synonym, not our finding."""
        assert "AdministratableDrugForm" not in gti.KNOWN_MISSPELLINGS

    def test_site_administered_is_flagged_as_misspelled(self):
        rows = {o["table"]: o for o in gti.build_orphan_rows()}
        assert rows["0034"]["domain"] == "SiteAdminstered"
        assert rows["0034"]["misspelled"] is True

    def test_the_misspelling_is_visible_in_the_rendered_section(self):
        section = gti.render_orphans(gti.build_orphan_rows())
        assert "Misspelled" in section
        assert "esc-v2tables-siteadministered" in section

    def test_resolving_orphans_are_not_shaded(self):
        rows = {o["table"]: o for o in gti.build_orphan_rows()}
        for table in ("0047", "0079", "4000"):
            assert rows[table]["resolves"] is True, table


class TestConceptAnchors:
    """The publisher rewrites concept codes into anchors; a verbatim code misses."""

    def test_plain_code_is_unchanged(self):
        assert gti.concept_anchor("AdministrativeSex") == "AdministrativeSex"

    def test_slash_becomes_its_decimal_code_point(self):
        assert gti.concept_anchor("Active/Inactive") == "Active.47Inactive"

    def test_apostrophe_and_ampersand(self):
        assert gti.concept_anchor("Patient'sRelationshipToInsured") == "Patient.39sRelationshipToInsured"
        assert gti.concept_anchor("L&I") == "L.38I"

    def test_spaces_are_dropped_not_escaped(self):
        assert gti.concept_anchor("Employment Status ODH") == "EmploymentStatusODH"

    def test_hyphen_and_underscore_survive(self):
        assert gti.concept_anchor("ItemCode-External") == "ItemCode-External"
        assert gti.concept_anchor("Product_ServicesClarificationCodes") == "Product_ServicesClarificationCodes"


class TestAgainstTheBuiltPage:
    """Only meaningful after a build; skipped when there is no output tree."""

    def _built(self):
        page = Path(gti.PROJECT_ROOT) / "vocab-ig" / "output" / "CodeSystem-conceptdomains.html"
        if not page.is_file():
            import pytest
            pytest.skip("no build output to check against")
        return page.read_text(encoding="utf-8", errors="replace")

    def test_every_domain_anchor_exists_in_the_built_page(self):
        import re
        html = self._built()
        anchors = set(re.findall(r'<a name="conceptdomains-([^"]+)"', html))
        unresolved = sorted(
            row["conceptDomain"] for row in gti.build_rows()
            if row["conceptDomain"] and gti.concept_anchor(row["conceptDomain"]) not in anchors
        )
        assert unresolved == [], unresolved


class TestAgainstTheRealCorpus:
    """The join must stay total: every table resolves, every IG link is real."""

    def test_every_table_appears_once(self):
        rows = gti.build_rows()
        assert len(rows) == 799
        assert len({r["table"] for r in rows}) == 799

    def test_self_check_is_silent(self):
        assert gti.self_check(gti.build_rows()) == []

    def test_every_in_guide_link_names_a_published_resource(self):
        authored = {a["id"] for a in gti.load_authored().values()}
        for row in gti.build_rows():
            for key in ("codeSystem", "valueSet"):
                ident = row[key]["igId"]
                assert ident is None or ident in authored, (row["table"], key, ident)

    def test_concept_domain_links_name_a_real_concept(self):
        codes = gti.load_concept_domain_codes()
        for row in gti.build_rows():
            assert not row["conceptDomain"] or row["conceptDomain"] in codes

    def test_page_renders_and_contains_every_table(self):
        rows = gti.build_rows()
        page = gti.render_page(rows)
        for row in rows:
            assert f'id="tbl-{row["table"]}"' in page


class TestNoNulBytes:
    """`PAGE_STYLE` is a non-raw string: a single-backslash `\\00b7` would be
    parsed by Python as an octal escape and emit a literal NUL byte, not a CSS
    escape. A NUL in a published page is invisible in most viewers and breaks
    tooling that assumes text, so the whole page is checked, not just the rule.
    """

    def test_the_style_block_has_no_nuls(self):
        assert "\x00" not in gti.PAGE_STYLE

    def test_the_css_escapes_are_literal_backslash_sequences(self):
        assert r'content: "\00b7\00a0";' in gti.PAGE_STYLE
        assert r'content: "\2192\00a0";' in gti.PAGE_STYLE

    def test_the_rendered_page_has_no_nuls_anywhere(self):
        assert "\x00" not in gti.render_page(gti.build_rows())

    def test_the_written_page_has_no_nuls(self):
        page = Path(gti.OUTPUT_PAGE)
        if not page.is_file():
            import pytest
            pytest.skip("page not generated yet")
        assert b"\x00" not in page.read_bytes()


class TestTypeColumn:
    """How Chapter 2C types each table, carried through to the page."""

    EXPECTED = {"User": 399, "undefined": 193, "HL7": 176,
                "HL7-EXT": 15, "External": 14, "Imported": 2}

    def test_the_header_names_the_column(self):
        page = gti.render_page(gti.build_rows())
        assert "<th>Type</th>" in page

    def test_the_six_chapter_types_are_the_whole_vocabulary(self):
        from collections import Counter
        counts = Counter(row["tableType"] for row in gti.build_rows())
        assert dict(counts) == self.EXPECTED, dict(counts)

    def test_undefined_is_muted_rather_than_blanked(self):
        cell = gti.render_type({"tableType": "undefined"})
        assert 'class="ti-untyped"' in cell
        assert "undefined" in cell

    def test_a_real_type_is_plain_text(self):
        assert gti.render_type({"tableType": "HL7"}) == "HL7"

    def test_a_missing_type_is_a_dash_not_the_word_undefined(self):
        assert gti.render_type({"tableType": ""}) == "—"

    def test_the_muted_class_has_a_style_rule(self):
        assert ".ti-untyped" in gti.PAGE_STYLE

    def test_every_class_the_page_emits_has_a_rule(self):
        """A class with no rule renders as nothing and is dead weight."""
        import re
        page = gti.render_page(gti.build_rows())
        emitted = set()
        for value in re.findall(r'class="([^"]+)"', page):
            emitted.update(c for c in value.split() if c.startswith("ti-"))
        assert emitted and all(f".{name}" in gti.PAGE_STYLE for name in emitted), sorted(
            name for name in emitted if f".{name}" not in gti.PAGE_STYLE)


class TestLedgerLinks:
    """Only the tables the per-table ledger actually has a section for."""

    def test_the_ledger_page_is_the_source_of_the_anchor_set(self):
        """Derived from the ledger, never a literal: the ledger's section count
        moves whenever its selection rule does, and a hardcoded number here
        fails the index for a change that is correct."""
        import re
        anchors = gti.load_ledger_anchors()
        if not anchors:
            import pytest
            pytest.skip("no generated ledger page to read")
        page = gti.LEDGER_PAGE.read_text(encoding="utf-8")
        assert anchors == set(re.findall(r'<a id="tbl-([^"]+)"></a>', page))
        assert anchors, "the ledger page carries no per-table anchors"

    def test_a_missing_ledger_page_yields_no_links_rather_than_an_error(self):
        assert gti.load_ledger_anchors(Path("/nonexistent/table-ledger.md")) == set()

    def test_no_row_links_to_an_anchor_the_ledger_does_not_have(self):
        import re
        anchors = gti.load_ledger_anchors()
        if not anchors:
            import pytest
            pytest.skip("no generated ledger page to read")
        page = gti.render_page(gti.build_rows())
        targets = set(re.findall(r'href="table-ledger\.html#tbl-([^"]+)"', page))
        assert targets and not (targets - anchors), sorted(targets - anchors)

    def test_rows_without_a_section_carry_no_ledger_link(self):
        row = {"table": "0001", "ledgerAnchor": False}
        assert gti.render_ledger_link(row) == ""

    def test_rows_with_a_section_link_to_it(self):
        cell = gti.render_ledger_link({"table": "0003", "ledgerAnchor": True})
        assert 'href="table-ledger.html#tbl-0003"' in cell

    def test_about_half_the_chapter_has_a_section(self):
        rows = gti.build_rows()
        if not gti.load_ledger_anchors():
            import pytest
            pytest.skip("no generated ledger page to read")
        anchors = gti.load_ledger_anchors()
        linked = [r for r in rows if r["ledgerAnchor"]]
        # Every linked row is an anchor the ledger really has, and every
        # chapter table the ledger covers is linked. The difference between
        # the two counts is the ledger's non-chapter sections, which have no
        # index row -- so it is derived, not asserted as a constant.
        assert {r["table"] for r in linked} == {r["table"] for r in rows} & anchors
        assert 0 < len(linked) < len(rows)
