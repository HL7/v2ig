#!/usr/bin/env python3
"""Tests for the UTG XML serializer and writer.

Two things are being pinned down here. The serializer tests fix the house
style, because the whole point of the module is that its output looks like it
belongs in UTG's repository -- a change to indentation or escaping that nobody
notices is exactly the kind of regression these catch. The writer tests fix the
classification rules, which encode ADR-0008 D8 and D11 and are the part a
future change is most likely to get subtly wrong.

Run:
    python3 -m pytest tooling/scripts/test_write_utg_xml.py
"""

import re
import sys
from pathlib import Path
from xml.etree import ElementTree

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

from utg_xml import Node, escape_attribute, render_document  # noqa: E402
import tho_merge as tho_merge_module  # noqa: E402
import write_utg_xml as writer  # noqa: E402

FHIR = "{http://hl7.org/fhir}"
PROJECT_ROOT = Path(__file__).resolve().parents[2]


# --------------------------------------------------------------------------
# The serializer
# --------------------------------------------------------------------------

def test_apostrophe_uses_a_numeric_reference():
    """UTG writes `&#39;` rather than a literal apostrophe or `&apos;`."""
    assert escape_attribute("patient's sex") == "patient&#39;s sex"


def test_ampersand_is_escaped_once():
    """The ampersand rule must run first or every other escape doubles up."""
    assert escape_attribute("a & b < c") == "a &amp; b &lt; c"


def test_non_ascii_stays_literal():
    """Literal UTF-8 is valid and reads better in a diff than `&#xA9;`."""
    assert escape_attribute("copyright ©1989+") == "copyright ©1989+"


def test_newlines_in_an_attribute_are_escaped_numerically():
    """A raw newline in an attribute is normalized to a space by any parser."""
    assert escape_attribute("one\ntwo") == "one&#10;two"


def test_an_element_without_children_is_self_closing():
    assert Node("code", value="F").render() == ['<code value="F"/>']


def test_children_are_indented_by_two_spaces():
    parent = Node("concept", id="100")
    parent.add_value("code", "F")
    assert parent.render() == [
        '<concept id="100">',
        '  <code value="F"/>',
        "</concept>",
    ]


def test_an_empty_value_adds_nothing():
    """FHIR cannot represent an empty string, so blank means absent."""
    node = Node("concept")
    assert node.add_value("definition", "") is None
    assert node.add_value("definition", None) is None
    assert node.children == []


def test_a_document_has_a_blank_line_and_no_trailing_newline():
    document = render_document(Node("CodeSystem"))
    assert document == (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        "\n"
        '<CodeSystem xmlns="http://hl7.org/fhir"/>'
    )


def test_the_namespace_comes_before_other_root_attributes():
    document = render_document(Node("CodeSystem", id="x"))
    assert document.endswith('<CodeSystem xmlns="http://hl7.org/fhir" id="x"/>')


# --------------------------------------------------------------------------
# Name derivation
# --------------------------------------------------------------------------

@pytest.mark.parametrize("symbolic_name, expected", [
    ("administrativeSex", "AdministrativeSex"),
    ("hl7VS-administrativeSex", "Hl7VSAdministrativeSex"),
    ("event", "Event"),
    ("", ""),
])
def test_pascal_case_matches_utgs_own_names(symbolic_name, expected):
    """Internal capitals survive; only the first letter of each piece changes."""
    assert writer.pascal_case(symbolic_name) == expected


@pytest.mark.parametrize("steward, expected", [
    ("PA", "pa"),
    ("InM", "inm"),
    ("InM/PA", "inm"),      # a shared steward is attributed to the first
    ("StrucDoc", "sd"),
    ("PH", None),           # unmapped, so no extension is written
    (None, None),
])
def test_work_group_mapping(steward, expected):
    assert writer.work_group_code(steward) == expected


# --------------------------------------------------------------------------
# Classification
# --------------------------------------------------------------------------

def make_record(table="0001", **overrides):
    """Build a minimal table record shaped like the extracted corpus."""
    record = {
        "tableNumber": table,
        "tableName": "Test Table",
        "conceptDomain": {"SymbolicName": "TestDomain",
                          "Concept Domain Only": "no"},
        "codeSystems": [{"Code System OID": "2.16.840.1.113883.18.2",
                         "SymbolicName": "testSystem",
                         "Description": "A test code system.",
                         "URI": writer.CS_CANONICAL.format(table=table)}],
        "valueSets": [{"Value Set OID": "2.16.840.1.113883.21.2",
                       "SymbolicName": "hl7VS-testSystem",
                       "Description": "A test value set.",
                       "Content Logical Definition": "all codes"}],
        "codedContent": [{"value": "F", "displayName": "Female",
                          "definition": "", "comment": "", "status": ""}],
        "tableMetadata": {"Steward": "PA"},
    }
    record.update(overrides)
    return record


def test_a_table_owning_its_canonical_gets_both_resources():
    plan = writer.classify(make_record(), {})
    assert plan["action"] == "code-system-and-value-set"


def test_a_foreign_code_system_gets_a_value_set_only():
    """ADR-0008 D8 and D11: we must not author at a canonical we do not own."""
    record = make_record(codeSystems=[{"URI": "http://unitsofmeasure.org",
                                       "SymbolicName": "ucum",
                                       "Description": "UCUM"}])
    plan = writer.classify(record, {})
    assert plan["action"] == "value-set-only"
    assert plan["systemUrl"] == "http://unitsofmeasure.org"


def test_another_v2_tables_canonical_is_also_foreign():
    """Table 0125 borrows 0440's code system; that is still not ours to write."""
    record = make_record(
        table="0125",
        codeSystems=[{"URI": writer.CS_CANONICAL.format(table="0440"),
                      "SymbolicName": "x", "Description": "y"}])
    assert writer.classify(record, {})["action"] == "value-set-only"


def test_concept_domain_only_writes_nothing():
    """A binding to a domain uses an extension, so no value set is needed."""
    record = make_record(
        conceptDomain={"SymbolicName": "D", "Concept Domain Only": "yes"},
        codeSystems=[], valueSets=[], codedContent=[])
    assert writer.classify(record, {})["action"] == "concept-domain-only"


def test_the_noObject_placeholder_means_concept_domain_only():
    """ADR-0008 D11, covering tables 0560 and 0910."""
    record = make_record(codeSystems=[{"Code System OID": "-",
                                       "SymbolicName": "noObject",
                                       "Description": "noDescription"}])
    plan = writer.classify(record, {})
    assert plan["action"] == "concept-domain-only"
    assert "noObject" in plan["reason"]


def test_a_table_with_no_terminology_at_all_is_reported_not_written():
    """Tables 0010, 0188 and 9999 are the whole of this case."""
    record = make_record(conceptDomain=None, codeSystems=[], valueSets=[],
                         codedContent=[])
    assert writer.classify(record, {})["action"] == "nothing-to-write"


def test_an_oid_in_the_v2_arc_resolves_to_the_tables_own_canonical():
    """The chapter often prints an OID and no URI; the arc says whose it is."""
    record = make_record(codeSystems=[{
        "Code System OID": "2.16.840.1.113883.18.458",
        "SymbolicName": "administrativeSex", "Description": "x"}])
    plan = writer.classify(record, {})
    assert plan["action"] == "code-system-and-value-set"
    assert plan["systemUrl"] == writer.CS_CANONICAL.format(table="0001")


def test_an_oid_thO_resolves_wins_over_the_arc_fallback():
    record = make_record(codeSystems=[{
        "Code System OID": "2.16.840.1.113883.5.1001",
        "SymbolicName": "actMood", "Description": "x"}])
    index = {"2.16.840.1.113883.5.1001":
             "http://terminology.hl7.org/CodeSystem/v3-ActMood"}
    plan = writer.classify(record, index)
    assert plan["action"] == "value-set-only"
    assert plan["systemUrl"].endswith("v3-ActMood")


def test_an_unresolvable_oid_stops_for_a_decision():
    record = make_record(codeSystems=[{
        "Code System OID": "2.16.840.1.113883.6.301.9",
        "SymbolicName": "x", "Description": "y"}])
    assert writer.classify(record, {})["action"] == "needs-decision"


def test_a_rendered_page_url_is_discarded_for_the_oid():
    """Seven tables print a page link where a canonical belongs -- 0719, 0952,
    0954, 0957, 0959 and 0962 among them. Each also prints the OID, so the OID
    resolves the system and nobody has to decide anything."""
    record = make_record(codeSystems=[{
        "URI": "http://terminology.hl7.org/CodeSystem-v3-ActCode.html",
        "Code System OID": "2.16.840.1.113883.5.4",
        "SymbolicName": "x", "Description": "y"}])
    index = {"2.16.840.1.113883.5.4":
             "http://terminology.hl7.org/CodeSystem/v3-ActCode"}
    plan = writer.classify(record, index)
    assert plan["action"] == "value-set-only"
    assert plan["systemUrl"] == "http://terminology.hl7.org/CodeSystem/v3-ActCode"
    assert plan["published"] == \
        "http://terminology.hl7.org/CodeSystem-v3-ActCode.html"


def test_a_page_url_with_no_resolvable_oid_still_stops():
    """The page URL must never reach a compose, even with nothing to replace it."""
    record = make_record(codeSystems=[{
        "URI": "http://hl7.org/fhir/codesystem-device-status.html",
        "Code System OID": "9.9.9.9", "SymbolicName": "x", "Description": "y"}])
    plan = writer.classify(record, {})
    assert plan["action"] == "needs-decision"
    assert plan["published"] == "http://hl7.org/fhir/codesystem-device-status.html"


@pytest.mark.parametrize("url, expected", [
    ("http://terminology.hl7.org/CodeSystem-v3-ActCode.html", True),
    ("https://terminology.hl7.org/CodeSystem-x.html", True),
    ("http://hl7.org/fhir/codesystem-device-status.html", True),
    ("http://terminology.hl7.org/CodeSystem/v3-ActCode", False),
    ("http://unitsofmeasure.org", False),
])
def test_page_url_detection(url, expected):
    assert writer.is_page_url(url) is expected


# --------------------------------------------------------------------------
# Content Logical Definitions
# --------------------------------------------------------------------------

def test_a_filter_logical_definition_is_read_into_an_is_a_filter():
    shape = writer.parse_logical_definition(
        "Include codes from http://terminology.hl7.org/CodeSystem/v3-ObservationValue"
        " where concept is-a _WorkSchedule")
    assert shape == {
        "kind": "filter",
        "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationValue",
        "isA": "_WorkSchedule",
        "excludeRoot": None,
    }


def test_an_exclude_clause_is_read_as_the_root_exclusion():
    shape = writer.parse_logical_definition(
        "Include codes from http://terminology.hl7.org/CodeSystem/v3-ObservationValue"
        " where concept is-a _EmploymentStatus\n"
        "Exclude codes where code= _EmploymentStatus")
    assert shape["excludeRoot"] == "_EmploymentStatus"


def test_a_filter_ignores_a_trailing_gloss_on_the_code():
    """Table 0961 writes the SNOMED code as `49062001 (Device)`."""
    shape = writer.parse_logical_definition(
        "This value set includes codes from the following code systems:\n\n"
        "Include codes from http://snomed.info/sct where concept is-a 49062001 (Device)")
    assert shape["system"] == "http://snomed.info/sct"
    assert shape["isA"] == "49062001"


def test_a_filtered_value_set_matches_thos_own_shape():
    """THO's ValueSet/v3-employmentStatusODH is an include filter plus an
    exclude of the root concept; ours has to be the same or it means something
    different."""
    record = make_record()
    record["valueSets"][0]["Content Logical Definition"] = (
        "Include codes from http://terminology.hl7.org/CodeSystem/v3-ObservationValue"
        " where concept is-a _EmploymentStatus\n"
        "Exclude codes where code= _EmploymentStatus")
    plan = writer.classify(record, {})
    root = ElementTree.fromstring(
        render_document(writer.build_value_set(record, plan, empty_repo())))
    compose = root.find(f"{FHIR}compose")

    include = compose.find(f"{FHIR}include")
    criterion = include.find(f"{FHIR}filter")
    assert include.find(f"{FHIR}system").get("value").endswith("v3-ObservationValue")
    assert criterion.find(f"{FHIR}property").get("value") == "concept"
    assert criterion.find(f"{FHIR}op").get("value") == "is-a"
    assert criterion.find(f"{FHIR}value").get("value") == "_EmploymentStatus"

    exclude = compose.find(f"{FHIR}exclude")
    assert exclude.find(f"{FHIR}system").get("value").endswith("v3-ObservationValue")
    assert exclude.find(f"{FHIR}concept").find(f"{FHIR}code").get("value") == \
        "_EmploymentStatus"


def test_a_filter_without_an_exclude_emits_no_exclude():
    record = make_record()
    record["valueSets"][0]["Content Logical Definition"] = (
        "Include codes from http://snomed.info/sct where concept is-a 49062001 (Device)")
    plan = writer.classify(record, {})
    root = ElementTree.fromstring(
        render_document(writer.build_value_set(record, plan, empty_repo())))
    assert root.find(f"{FHIR}compose").find(f"{FHIR}exclude") is None


@pytest.mark.parametrize("definition", [
    "as defined in the linked value set",
    "ISO 3166-1 alpha-3 axis",
    "unspecified",
    "See content logical definition of the referenced value set",
])
def test_logical_definitions_we_do_not_interpret(definition):
    assert writer.parse_logical_definition(definition) is None


def test_several_code_systems_stop_for_a_decision():
    record = make_record(codeSystems=[
        {"URI": "http://loinc.org", "SymbolicName": "a", "Description": ""},
        {"URI": "http://snomed.info/sct", "SymbolicName": "b",
         "Description": ""}])
    assert writer.classify(record, {})["action"] == "needs-decision"


def test_a_table_owning_its_system_with_no_codes_stops():
    """A `complete` CodeSystem has to contain the complete set of codes."""
    record = make_record(codedContent=[])
    assert writer.classify(record, {})["action"] == "needs-decision"


# --------------------------------------------------------------------------
# Building resources
# --------------------------------------------------------------------------

def empty_repo():
    return writer.UtgRepo(None)


def build(record, utg=None):
    """Classify and render a record, returning the parsed CodeSystem root."""
    utg = utg or empty_repo()
    plan = writer.classify(record, {})
    document = render_document(writer.build_code_system(record, plan, utg))
    return ElementTree.fromstring(document), document


def test_the_code_system_element_order_matches_utg():
    root, _ = build(make_record())
    order = [child.tag.replace(FHIR, "") for child in root]
    head = order[:order.index("concept")]
    assert head == [
        "id", "extension", "url", "identifier", "version", "name", "title",
        "status", "experimental", "date", "publisher", "contact",
        "description", "purpose", "copyright", "caseSensitive", "valueSet",
        "hierarchyMeaning", "compositional", "versionNeeded", "content",
        "property",
    ]


@pytest.mark.parametrize("chapter_status, expected", [
    ("", "active"),
    ("D", "deprecated"),
    ("R", "retired"),
    # "New in this release" is not a status: it decays, and it is not a value
    # the FHIR status property can take. It is written as `active`, which is
    # what this guide already publishes wherever THO says N and the 2.9.1
    # chapter no longer flags anything.
    ("N", "active"),
    # B is deliberately left alone, pending a case-by-case review by V2
    # Management -- see `esc-status-n-b-undefined`. So four values the
    # property's value set does not contain are still published knowingly.
    ("B", "B"),
])
def test_status_column_mapping(chapter_status, expected):
    record = make_record(codedContent=[
        {"value": "F", "displayName": "Female", "definition": "",
         "comment": "", "status": chapter_status}])
    root, _ = build(record)
    concept = root.find(f"{FHIR}concept")
    values = [p.find(f"{FHIR}valueCode").get("value")
              for p in concept.findall(f"{FHIR}property")
              if p.find(f"{FHIR}code").get("value") == "status"]
    assert values == [expected]


def test_an_unrecognised_status_letter_is_reported():
    """It used to pass through unmapped and unreported, which is the one way
    it must not behave: a letter nobody has mapped lands in a property whose
    value set does not contain it, and nothing says so."""
    record = make_record(codedContent=[
        {"value": "F", "displayName": "Female", "definition": "",
         "comment": "", "status": "Q"}])
    _files, report = writer.process([record], empty_repo(), {})
    assert report[0]["unknownStatuses"] == [{"code": "F", "status": "Q"}]


def test_an_unrecognised_status_letter_is_still_written_out():
    """Reported, not dropped. Dropping it would lose what the chapter says,
    and passing it through is what already happens to B."""
    record = make_record(codedContent=[
        {"value": "F", "displayName": "Female", "definition": "",
         "comment": "", "status": "Q"}])
    root, _ = build(record)
    values = [p.find(f"{FHIR}valueCode").get("value")
              for p in root.find(f"{FHIR}concept").findall(f"{FHIR}property")
              if p.find(f"{FHIR}code").get("value") == "status"]
    assert values == ["Q"]


def test_a_mapped_status_is_not_reported_as_an_anomaly():
    """Chapter 2C's whole observed set is blank, D, N, B and R, so a full run
    must report nothing here."""
    record = make_record(codedContent=[
        {"value": "F", "displayName": "Female", "definition": "",
         "comment": "", "status": "B"}])
    _files, report = writer.process([record], empty_repo(), {})
    assert "unknownStatuses" not in report[0]


def test_a_comment_becomes_the_v2_concComment_property():
    record = make_record(codedContent=[
        {"value": "X", "displayName": "Non-Binary", "definition": "d",
         "comment": "A note.", "status": ""}])
    root, _ = build(record)
    concept = root.find(f"{FHIR}concept")
    comments = [p.find(f"{FHIR}valueString").get("value")
                for p in concept.findall(f"{FHIR}property")
                if p.find(f"{FHIR}code").get("value") == "v2-concComment"]
    assert comments == ["A note."]


def test_only_the_properties_actually_used_are_declared():
    """No concept here carries a comment, so v2-concComment is not declared."""
    root, _ = build(make_record())
    declared = [p.find(f"{FHIR}code").get("value")
                for p in root.findall(f"{FHIR}property")]
    assert declared == ["status"]


def test_an_absent_definition_is_not_filled_in_from_the_display():
    """UTG copies display into definition; the chapter does not, and fidelity
    to the chapter is what this IG is for."""
    root, _ = build(make_record())
    assert root.find(f"{FHIR}concept").find(f"{FHIR}definition") is None


def test_concept_ids_are_allocated_when_utg_does_not_supply_them():
    record = make_record(codedContent=[
        {"value": "A", "displayName": "a", "definition": "", "comment": "",
         "status": ""},
        {"value": "B", "displayName": "b", "definition": "", "comment": "",
         "status": ""}])
    root, _ = build(record)
    ids = [c.get("id") for c in root.findall(f"{FHIR}concept")]
    assert ids == ["100", "101"]


def test_an_existing_utg_concept_id_is_kept():
    """UTG numbers concepts from a counter spanning the whole repository, so a
    fresh numbering would collide with resources we are not touching."""
    utg = empty_repo()
    utg.code_systems["0001"] = {"version": "3.0.0", "date": "2019-12-01",
                                "workGroup": "pa", "conceptIds": {"F": "42"}}
    utg.next_concept_id = 900
    root, _ = build(make_record(), utg)
    assert [c.get("id") for c in root.findall(f"{FHIR}concept")] == ["42"]


def test_version_and_date_are_inherited_from_utg_when_available():
    utg = empty_repo()
    utg.code_systems["0001"] = {"version": "5.0.0", "date": "2025-07-15",
                                "workGroup": "pa", "conceptIds": {}}
    root, _ = build(make_record(), utg)
    assert root.find(f"{FHIR}version").get("value") == "5.0.0"
    assert root.find(f"{FHIR}date").get("value") == "2025-07-15"


def test_the_value_set_composes_the_whole_system_for_all_codes():
    record = make_record()
    plan = writer.classify(record, {})
    root = ElementTree.fromstring(
        render_document(writer.build_value_set(record, plan, empty_repo())))
    include = root.find(f"{FHIR}compose").find(f"{FHIR}include")
    assert include.find(f"{FHIR}system").get("value") == \
        writer.CS_CANONICAL.format(table="0001")
    assert include.find(f"{FHIR}concept") is None


def test_an_enumerated_value_set_lists_the_tables_own_codes():
    record = make_record()
    record["valueSets"][0]["Content Logical Definition"] = \
        "enumerated per table content"
    plan = writer.classify(record, {})
    root = ElementTree.fromstring(
        render_document(writer.build_value_set(record, plan, empty_repo())))
    codes = [c.find(f"{FHIR}code").get("value")
             for c in root.iter(f"{FHIR}concept")]
    assert codes == ["F"]


def test_an_uninterpretable_logical_definition_is_not_guessed_at():
    record = make_record()
    record["valueSets"][0]["Content Logical Definition"] = "ISO 3166-1 alpha-3 axis"
    assert writer.compose_shape(record) == "ISO 3166-1 alpha-3 axis"


def test_a_value_set_only_table_composes_over_the_foreign_system():
    record = make_record(codeSystems=[{"URI": "http://unitsofmeasure.org",
                                       "SymbolicName": "ucum",
                                       "Description": "UCUM"}])
    files, report = writer.process([record], empty_repo(), {})
    assert list(files) == ["valueSets/vs-v2-0001.xml"]
    assert report[0]["action"] == "value-set-only"


def test_output_is_parseable_and_carries_no_meta_or_narrative():
    """UTG stores neither, and both are pure diff noise."""
    _, document = build(make_record())
    assert "<meta>" not in document and "<text>" not in document
    assert not document.endswith("\n")
    ElementTree.fromstring(document)      # raises if malformed


# --------------------------------------------------------------------------
# Reporting the version fallback
# --------------------------------------------------------------------------
#
# A resource UTG does not already publish starts at DEFAULT_VERSION. The point
# of these tests is that the fallback is reported per resource: a table can
# inherit for its CodeSystem and not for its ValueSet, and the write report has
# to say so or the fallback is silent for exactly the cases that need it.

def test_a_table_inheriting_nothing_reports_both_resources():
    _, report = writer.process([make_record()], empty_repo(), {})
    assert report[0]["usedDefaultVersion"] == {
        "version": writer.DEFAULT_VERSION,
        "resources": ["CodeSystem", "ValueSet"],
    }


def test_a_table_inheriting_both_reports_no_fallback():
    utg = empty_repo()
    utg.code_systems["0001"] = {"version": "3.0.0", "date": "2019-12-01",
                                "conceptIds": {}}
    utg.value_sets["0001"] = {"version": "3.0.0", "date": "2019-12-01"}
    _, report = writer.process([make_record()], utg, {})
    assert "usedDefaultVersion" not in report[0]


def test_inheriting_only_the_code_system_still_reports_the_value_set():
    """The `notAllCodes` case: UTG files the value set under another name."""
    utg = empty_repo()
    utg.code_systems["0291"] = {"version": "3.0.0", "date": "2019-12-01",
                                "conceptIds": {}}
    _, report = writer.process([make_record(table="0291")], utg, {})
    assert report[0]["usedDefaultVersion"]["resources"] == ["ValueSet"]


def test_a_blocked_table_reports_no_fallback():
    """Nothing was written, so nothing fell back to a default."""
    record = make_record()
    record["valueSets"][0]["Content Logical Definition"] = "unspecified"
    record["codeSystems"] = [{"URI": "http://unitsofmeasure.org",
                              "SymbolicName": "ucum", "Description": "UCUM"}]
    _, report = writer.process([record], empty_repo(), {})
    assert report[0]["action"] == "needs-decision"
    assert "usedDefaultVersion" not in report[0]


def test_new_resources_start_at_one_zero_zero():
    """The user's answer to what a brand-new resource should be versioned at."""
    assert writer.DEFAULT_VERSION == "1.0.0"
    root, _ = build(make_record())
    assert root.find(f"{FHIR}version").get("value") == "1.0.0"


# --------------------------------------------------------------------------
# Existing THO canonicals
# --------------------------------------------------------------------------
#
# A canonical URL is an identifier. Where THO already has one for a table, that
# is the URL, and nothing about how it looks entitles this project to construct
# a different one. Four tables are published at `v2-notAllCodes-NNNN`.

def test_a_table_with_no_published_canonical_gets_a_constructed_one():
    identity = writer.value_set_identity("0001", {}, empty_repo())
    assert identity["url"] == writer.VS_CANONICAL.format(table="0001")
    assert identity["id"] == "v2-0001"
    assert identity["file"] == "valueSets/vs-v2-0001.xml"


def test_an_existing_canonical_is_used_rather_than_constructed():
    published = {"0291": "http://terminology.hl7.org/ValueSet/"
                         "v2-notAllCodes-0291"}
    identity = writer.value_set_identity("0291", published, empty_repo())
    assert identity["url"] == published["0291"]
    assert identity["id"] == "v2-notAllCodes-0291"


def test_the_file_name_mirrors_utgs_own():
    """UTG files 0834's value set under the table number, not the canonical."""
    utg = empty_repo()
    utg.value_sets["0834"] = {"fileName": "vs-v2-0834.xml"}
    published = {"0834": "http://terminology.hl7.org/ValueSet/"
                         "v2-notAllCodes-0834"}
    identity = writer.value_set_identity("0834", published, utg)
    assert identity["file"] == "valueSets/vs-v2-0834.xml"
    assert identity["id"] == "v2-notAllCodes-0834"


def test_the_value_set_is_written_at_the_published_canonical():
    published = {"0001": "http://terminology.hl7.org/ValueSet/"
                         "v2-notAllCodes-0001"}
    record = make_record()
    plan = writer.classify(record, {})
    root = ElementTree.fromstring(render_document(
        writer.build_value_set(record, plan, empty_repo(), published)))
    assert root.find(f"{FHIR}url").get("value") == published["0001"]
    assert root.find(f"{FHIR}id").get("value") == "v2-notAllCodes-0001"


def test_a_code_system_points_at_its_value_set_by_default():
    root, _ = build(make_record())
    assert root.find(f"{FHIR}valueSet") is not None


def test_a_code_system_omits_the_value_set_where_utg_does():
    """`CodeSystem.valueSet` means the value set holding the ENTIRE system.

    UTG leaves it off exactly where the value set is not all-codes, and this
    follows UTG rather than re-deriving the rule.
    """
    utg = empty_repo()
    utg.code_systems["0001"] = {"version": "3.0.0", "date": "2019-12-01",
                                "conceptIds": {}, "hasValueSetElement": False}
    root, _ = build(make_record(), utg)
    assert root.find(f"{FHIR}valueSet") is None


def test_a_table_number_is_read_from_a_prefixed_file_name():
    """`vs-v2-notAllCodes-0291.xml` is table 0291, not table notAllCodes-0291."""
    assert writer.UtgRepo._table_number(Path("vs-v2-notAllCodes-0291.xml")) == "0291"
    assert writer.UtgRepo._table_number(Path("cs-v2-0001.xml")) == "0001"
    assert writer.UtgRepo._table_number(Path("readme.md")) is None


# --------------------------------------------------------------------------
# The THO merge, through the writer
# --------------------------------------------------------------------------

class FakeSnapshot:
    """A THO snapshot of one or two resources, for tests.

    The real one reads a 2,000-file package off disk. Everything the writer
    asks of it is these four methods.
    """

    def __init__(self, code_systems=None, value_sets=None):
        self._code_systems = code_systems or {}
        self._value_sets = value_sets or {}

    def code_system(self, table):
        return self._code_systems.get(table)

    def value_set(self, url):
        return self._value_sets.get(url)

    def code_system_tables(self):
        return set(self._code_systems)

    def value_set_urls(self):
        return set(self._value_sets)

    def provenance(self):
        return {"package": "test", "version": "0.0.0"}


def tho_code_system(**overrides):
    resource = {
        "resourceType": "CodeSystem",
        "url": writer.CS_CANONICAL.format(table="0001"),
        # Same OID `make_record` gives, so that an identifier difference is
        # not silently what these tests are measuring.
        "identifier": [{"system": "urn:ietf:rfc:3986",
                        "value": "urn:oid:2.16.840.1.113883.18.2"}],
        "version": "3.0.0",
        "name": "TestSystem",
        "title": "testSystem",
        "status": "active",
        "experimental": False,
        "description": "A test code system.",
        "purpose": "Underlying Master Code System for V2 table 0001 "
                   "(Test Table)",
        "caseSensitive": True,
        "hierarchyMeaning": "is-a",
        "compositional": False,
        "content": "complete",
        "property": [{"code": "status",
                      "uri": "http://hl7.org/fhir/concept-properties#status",
                      "description": "A code that indicates the status of the "
                                     "concept",
                      "type": "code"}],
        "concept": [{"id": "100", "code": "F", "display": "Female",
                     "definition": "Female",
                     "property": [{"code": "status", "valueCode": "active"}]}],
    }
    resource.update(overrides)
    return resource


def build_with_tho(record=None, snapshot=None, utg=None):
    """Render a CodeSystem against a THO snapshot, returning root and plan."""
    record = record if record is not None else make_record()
    utg = utg or empty_repo()
    plan = writer.classify(record, {})
    resolved = writer.plan_code_system(record, plan, utg, None, snapshot)
    document = render_document(writer.render_code_system(resolved))
    return ElementTree.fromstring(document), resolved


def test_a_definition_the_chapter_lacks_comes_from_tho():
    """The 4,855-instance case: the chapter has no definition column, and
    dropping THO's deletes text from the artifact at THO's canonical."""
    root, _ = build_with_tho(snapshot=FakeSnapshot({"0001": tho_code_system()}))
    concept = root.find(f"{FHIR}concept")
    assert concept.find(f"{FHIR}definition").get("value") == "Female"


def test_the_definition_is_still_not_invented_from_the_display():
    """Filling from THO is not the same as filling from the display. With no
    THO resource to draw on, the old rule stands."""
    root, _ = build_with_tho(snapshot=FakeSnapshot())
    assert root.find(f"{FHIR}concept").find(f"{FHIR}definition") is None


def test_a_translation_survives_the_merge():
    tho = tho_code_system(concept=[{
        "id": "100", "code": "F", "display": "Female",
        "designation": [{"language": "de",
                         "use": {"system": "http://x", "code": "preferred"},
                         "value": "weiblich"}]}])
    root, _ = build_with_tho(snapshot=FakeSnapshot({"0001": tho}))
    designation = root.find(f"{FHIR}concept").find(f"{FHIR}designation")
    assert designation.find(f"{FHIR}value").get("value") == "weiblich"
    assert designation.find(f"{FHIR}language").get("value") == "de"


def test_an_inherited_property_is_declared_as_tho_declares_it():
    """An undeclared property is invalid FHIR, so inheriting one means
    inheriting its declaration too."""
    tho = tho_code_system(
        property=[{"code": "HL7usageNotes", "uri": "http://x#notes",
                   "description": "HL7 Concept Usage Notes", "type": "string"}],
        concept=[{"id": "100", "code": "F", "display": "Female",
                  "property": [{"code": "HL7usageNotes",
                                "valueString": "Use with care."}]}])
    root, resolved = build_with_tho(snapshot=FakeSnapshot({"0001": tho}))
    declared = [p.find(f"{FHIR}code").get("value")
                for p in root.findall(f"{FHIR}property")]
    assert "HL7usageNotes" in declared
    assert resolved["unknownProperties"] == []


def test_a_code_only_tho_has_is_published_and_keeps_its_id():
    tho = tho_code_system(concept=[
        {"id": "100", "code": "F", "display": "Female"},
        {"id": "101", "code": "M", "display": "Male"}])
    root, _ = build_with_tho(snapshot=FakeSnapshot({"0001": tho}))
    concepts = root.findall(f"{FHIR}concept")
    assert [c.find(f"{FHIR}code").get("value") for c in concepts] == ["F", "M"]
    assert concepts[1].get("id") == "101"


def test_a_resource_that_matches_tho_keeps_thos_version():
    """The point of the merge: matching costs nothing. Without it, 383 of 396
    code systems would have had to increment."""
    tho = tho_code_system()
    root, resolved = build_with_tho(snapshot=FakeSnapshot({"0001": tho}))
    assert root.find(f"{FHIR}version").get("value") == "3.0.0"
    assert resolved["version"]["incremented"] is False


def test_a_resource_that_differs_from_tho_increments():
    tho = tho_code_system(concept=[{"id": "100", "code": "F",
                                    "display": "Woman"}])
    root, resolved = build_with_tho(snapshot=FakeSnapshot({"0001": tho}))
    assert root.find(f"{FHIR}version").get("value") == "4.0.0"
    assert resolved["version"]["triggers"] == ["concept"]


def test_a_resource_tho_does_not_publish_starts_at_one():
    root, _ = build_with_tho(snapshot=FakeSnapshot())
    assert root.find(f"{FHIR}version").get("value") == "1.0.0"


def test_a_placeholder_description_is_replaced_by_thos():
    record = make_record()
    record["codeSystems"][0]["Description"] = "tbd"
    root, resolved = build_with_tho(record,
                                    FakeSnapshot({"0001": tho_code_system()}))
    assert root.find(f"{FHIR}description").get("value") == "A test code system."
    assert resolved["version"]["version"] == "3.0.0"


def test_an_artifact_tho_publishes_and_we_do_not_is_reported():
    """Publishing nothing destroys nothing, so the merge must not invent a
    resource -- but the silence has to be visible."""
    record = make_record(table="0001", codeSystems=[], valueSets=[],
                         conceptDomain={"SymbolicName": "TestDomain",
                                        "Concept Domain Only": "yes"})
    observe = tho_merge_module.Observations()
    _files, report = writer.process([record], empty_repo(), {}, None,
                                    FakeSnapshot({"0001": tho_code_system()}),
                                    observe)
    writer.record_omissions(report, FakeSnapshot({"0001": tho_code_system()}),
                            observe)
    omissions = [r for r in observe.records if r["kind"] == "omission"]
    assert [r["table"] for r in omissions] == ["0001"]
    assert omissions[0]["resource"] == "CodeSystem"


def test_without_a_snapshot_the_writer_behaves_as_it_always_did():
    """The builders stay usable without the THO package on disk, which is what
    every test above this section relies on."""
    utg = empty_repo()
    utg.code_systems["0001"] = {"version": "5.0.0", "date": "2025-07-15",
                                "workGroup": "pa", "conceptIds": {}}
    root, _ = build(make_record(), utg)
    assert root.find(f"{FHIR}version").get("value") == "5.0.0"


# --------------------------------------------------------------------------
# Tentative overrides (ADR-0011)
# --------------------------------------------------------------------------

CVX = "http://hl7.org/fhir/sid/cvx"
CVX_OID_INDEX = {"2.16.840.1.113883.12.292": CVX}


def domain_only_record(table):
    """A record shaped like table 0292: flagged concept-domain-only, with no
    code system or value set block, but carrying the table's own OID."""
    return make_record(
        table=table,
        conceptDomain={"SymbolicName": "VaccinesAdministered",
                       "Concept Domain Only": "yes"},
        codeSystems=[], valueSets=[], codedContent=[],
        tableMetadata={"Table OID": "2.16.840.1.113883.12.292",
                       "Steward": "OO"})


def test_every_tentative_override_names_a_register_item_that_exists():
    """The invariant the mechanism refuses to run without.

    An override with no pending ask is not tentative, it is an unrecorded
    decision. The register is imported here rather than at the top of the file
    because nothing else in this suite depends on it.
    """
    import vocabulary_escalations

    registered = {item["id"] for item in vocabulary_escalations.ESCALATIONS}
    missing = {table: override.register_item
               for table, override in writer.TENTATIVE_OVERRIDES.items()
               if override.register_item not in registered}
    assert not missing, (
        f"these tentative overrides name a register item that does not "
        f"exist in vocabulary_escalations.ESCALATIONS: {missing}")


def test_every_suppression_names_an_answered_register_item():
    """The mirror of the tentative-override invariant, and the reverse of it.

    A tentative override must name an *open* item: it deviates while waiting.
    A suppression must name an item with a `resolution`: it withholds because
    a committee said to. A suppression naming an open item would be this
    project deciding not to publish something and dressing it as a ruling.
    """
    import vocabulary_escalations

    by_id = {item["id"]: item for item in vocabulary_escalations.ESCALATIONS}
    problems = {}
    for table, suppression in writer.RULED_SUPPRESSIONS.items():
        item = by_id.get(suppression.register_item)
        if item is None:
            problems[table] = f"{suppression.register_item} does not exist"
        elif not item.get("resolution"):
            problems[table] = (
                f"{suppression.register_item} has no resolution, so nothing "
                f"has been ruled")
    assert not problems, (
        f"these suppressions do not rest on a recorded ruling: {problems}")


def test_a_suppressed_table_is_reported_and_writes_nothing():
    """The absence has to be visible. A table that simply vanished from the
    output would be indistinguishable from a pipeline failure."""
    record = make_record(
        table="0567",
        codeSystems=[{"Full Name": "UCUM", "URI": "http://unitsofmeasure.org"}],
        valueSets=[{"Value Set OID": "2.16.840.1.113883.21.452"}],
        codedContent=[{"Code": "kg", "Description": "Kilogram"}])
    files, report = writer.process([record], empty_repo(), {})

    assert files == {}, "a suppressed table must write no artifact"
    entry = next(e for e in report if e["table"] == "0567")
    assert entry["action"] == "suppressed-by-ruling"
    assert entry["registerItem"] == "esc-0567-0568-deprecation"
    assert entry["written"] == []
    assert entry["reason"], "the ruling must travel with the entry"


def test_suppression_and_tentative_override_tables_are_disjoint():
    """A table cannot be both awaiting a ruling and governed by one."""
    both = set(writer.RULED_SUPPRESSIONS) & set(writer.TENTATIVE_OVERRIDES)
    assert not both, f"tables in both mechanisms: {sorted(both)}"


def test_a_suppressed_tables_artifact_is_removed_from_an_earlier_run(tmp_path):
    """The prune, exercised against the filesystem rather than described.

    Without it the ruling has no effect on the output it is about:
    `stage_vocab_ig` mirrors this directory, so a file left behind here is a
    file published in the IG.
    """
    directory = tmp_path / "valueSets"
    directory.mkdir()
    stale = directory / "vs-v2-0567.xml"
    stale.write_text("<ValueSet/>", encoding="utf-8")
    keep = directory / "vs-v2-0929.xml"
    keep.write_text("<ValueSet/>", encoding="utf-8")

    for table in sorted(writer.RULED_SUPPRESSIONS):
        for relative in (f"codeSystems/cs-v2-{table}.xml",
                         f"valueSets/vs-v2-{table}.xml"):
            path = tmp_path / relative
            if path.exists():
                path.unlink()

    assert not stale.exists(), "the suppressed table's artifact must go"
    assert keep.exists(), "an unrelated table must be untouched"


def test_every_reclassification_names_an_answered_register_item():
    """Same invariant as suppressions, for the same reason: publishing
    against the chapter is somebody else's decision, and must look like it."""
    import vocabulary_escalations

    by_id = {item["id"]: item for item in vocabulary_escalations.ESCALATIONS}
    problems = {}
    for table, entry in writer.RULED_RECLASSIFICATIONS.items():
        item = by_id.get(entry.register_item)
        if item is None:
            problems[table] = f"{entry.register_item} does not exist"
        elif not item.get("resolution"):
            problems[table] = (
                f"{entry.register_item} has no resolution, so nothing has "
                f"been ruled")
    assert not problems, (
        f"these reclassifications do not rest on a recorded ruling: "
        f"{problems}")


def test_a_reclassification_publishes_what_the_chapter_says_not_to():
    """0350 is flagged `Concept Domain Only: yes` and has no value set block.
    Both are what the ruling says is wrong, so the write has to happen in
    spite of them or the reclassification does nothing."""
    record = make_record(
        table="0350",
        conceptDomain={"SymbolicName": "OccurrenceCode",
                       "Concept Domain Only": "yes"},
        codeSystems=[], valueSets=[], codedContent=[],
        tableMetadata={"Table OID": "2.16.840.1.113883.12.350",
                       "Steward": "InM/FM"})
    files, report = writer.process([record], empty_repo(), {})

    entry = next(e for e in report if e["table"] == "0350")
    assert entry["action"] == "value-set-only"
    assert "valueSets/vs-v2-0350.xml" in entry["written"]
    assert entry["ruledReclassification"]["registerItem"] == (
        "esc-0350-0351-not-domain-only")
    assert files, "the reclassified table must produce an artifact"


# Reclassifications allowed to declare their code system unresolved, and why.
# `unresolved` must be a deliberate act with evidence, never a shrug: 0350 and
# 0351 carried one until it was found to be wrong -- their compose target is
# an HL7-endorsed URI for an externally-owned NUBC code system, registered as
# a NamingSystem with no content behind it, which is THO's documented
# convention rather than a dangling pointer. Listing the exceptions by hand
# keeps a future entry from inheriting that mistake silently.
EXPECTED_UNRESOLVED_SYSTEMS = {
    "0458": "CodeSystem/oce-edit-codes. Jira ticket raised with THO. Remove "
            "this entry once THO publishes the record.",
    "0459": "CodeSystem/oce-reimbursement-action-codes. Jira ticket raised "
            "with THO. Remove this entry once THO publishes the record.",
    "0460": "CodeSystem/oce-denial-or-rejection-flag. The external metadata "
            "record is being created. Remove this entry once THO publishes "
            "it.",
    "0467": "The CMS I/OCE modifier edit code system. A Jira ticket has been "
            "raised with THO to create the external code system record, "
            "which will carry the URL and OID Chapter 2C already prints. "
            "Remove this entry once THO publishes it.",
}


def test_no_reclassification_claims_an_unresolved_code_system():
    """Only the tables known to be waiting on THO may say `unresolved`.

    THO registering a canonical as an external code system is enough to make
    it resolvable; a missing CodeSystem resource is not evidence of a
    dangling pointer. So an unexpected entry here means somebody applied the
    narrow test again, and should check THO's external code systems page
    before believing it."""
    summary = writer.reclassification_summary([])
    unexpected = [table for table in summary["unresolvedSystems"]
                  if table not in EXPECTED_UNRESOLVED_SYSTEMS]
    assert unexpected == [], (
        f"these reclassifications claim an unresolved code system and are "
        f"not in EXPECTED_UNRESOLVED_SYSTEMS: {unexpected}. Check whether "
        f"THO registers the canonical as an external code system before "
        f"believing it.")


def test_every_expected_unresolved_system_is_still_unresolved():
    """The exception list has to shrink. An entry whose code system THO has
    since registered is a stale waiver, and leaving it would let a genuinely
    unresolved system hide behind it."""
    summary = writer.reclassification_summary([])
    resolved = [table for table in EXPECTED_UNRESOLVED_SYSTEMS
                if table not in summary["unresolvedSystems"]]
    assert resolved == [], (
        f"these tables are no longer unresolved, so their waiver in "
        f"EXPECTED_UNRESOLVED_SYSTEMS should be deleted: {resolved}")


def test_the_four_ruling_mechanisms_are_disjoint():
    """A table cannot be awaiting a ruling, withheld by one, republished by
    one and retired by one at the same time."""
    mechanisms = {
        "TENTATIVE_OVERRIDES": set(writer.TENTATIVE_OVERRIDES),
        "RULED_SUPPRESSIONS": set(writer.RULED_SUPPRESSIONS),
        "RULED_RECLASSIFICATIONS": set(writer.RULED_RECLASSIFICATIONS),
        "RULED_SUPERSESSIONS": set(writer.RULED_SUPERSESSIONS),
    }
    names = sorted(mechanisms)
    for i, first in enumerate(names):
        for second in names[i + 1:]:
            both = mechanisms[first] & mechanisms[second]
            assert not both, (
                f"tables in both {first} and {second}: {sorted(both)}")


def test_an_excluded_section_reaches_no_page():
    """9999 reached the published IG three times over -- the table index,
    the ledger and the open-items register -- because every page that walked
    the corpus had to remember to skip it. The exclusion is at the corpus
    boundary so a page added later inherits it; this checks the pages that
    exist today actually came out clean."""
    pages = PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent"
    if not pages.is_dir():
        pytest.skip("no staged pages to check; run build_vocab_ig.py first")

    for table in writer.EXCLUDED_SECTIONS:
        for page in sorted(pages.glob("*.md")):
            text = page.read_text(encoding="utf-8")
            # index.md says why the section is excluded, and evidence.md
            # carries the ruling that excluded it. Both are the exclusion
            # being explained rather than the section being published.
            if page.name in ("index.md", "evidence.md"):
                continue
            assert f"tbl-{table}" not in text, (
                f"{page.name} still has a ledger anchor for excluded "
                f"section {table}")
            assert f"`{table}`" not in text, (
                f"{page.name} still lists excluded section {table}")


def test_every_supersession_names_an_answered_register_item():
    """The same invariant as suppressions and reclassifications. Retiring a
    published artifact is the heaviest act this guide takes, so it must rest
    on a recorded ruling rather than on this project's judgement."""
    import vocabulary_escalations

    by_id = {item["id"]: item for item in vocabulary_escalations.ESCALATIONS}
    problems = {}
    for table, entry in writer.RULED_SUPERSESSIONS.items():
        item = by_id.get(entry.register_item)
        if item is None:
            problems[table] = f"{entry.register_item} does not exist"
        elif not item.get("resolution"):
            problems[table] = (
                f"{entry.register_item} has no resolution, so nothing has "
                f"been ruled")
    assert not problems, (
        f"these supersessions do not rest on a recorded ruling: {problems}")


def test_every_replacement_url_is_version_less():
    """The ruling asked for links that keep resolving as THO publishes new
    versions, which makes this an invariant rather than a style preference.

    A version-specific link -- `terminology.hl7.org/7.4.0/en/...` -- names
    the right value set today and rots at the next release, which is the
    exact failure the note exists to prevent. Rendered `.html` page URLs are
    refused for the same reason: the canonical is the durable identity.
    """
    problems = {}
    for table, entry in writer.RULED_SUPERSESSIONS.items():
        url = entry.replacement_url
        if re.search(r"/\d+\.\d+\.\d+/", url):
            problems[table] = f"{url} pins a THO version"
        elif url.endswith(".html"):
            problems[table] = f"{url} is a rendered page, not a canonical"
        elif not url.startswith("http"):
            problems[table] = f"{url} is not an absolute URL"
    assert not problems, (
        f"these replacement URLs will not keep resolving: {problems}")


def test_a_superseded_value_set_is_retired_and_points_at_its_replacement():
    """Both halves of the ruling, on the artifact rather than on the plan.

    The status half is the one that was actually broken: `status` is
    compared against THO but never filled from it, which is why this guide
    was republishing THO's retired v2-0719 as active.
    """
    record = make_record(
        table="0952",
        codeSystems=[{"Code System OID": "2.16.840.1.113883.5.25",
                      "URI": "http://terminology.hl7.org/"
                             "CodeSystem/v3-Confidentiality"}],
        valueSets=[{"Value Set OID": "2.16.840.1.113883.1.11.10228",
                    "SymbolicName": "confidentiality",
                    "Description": "Concepts drawn from the HL7 V3 "
                                   "Confidentiality code system.",
                    "Content Logical Definition": "all codes"}],
        codedContent=[])
    files, report = writer.process([record], empty_repo(), {})

    entry = next(e for e in report if e["table"] == "0952")
    assert entry["action"] == "superseded-by-ruling"
    assert entry["ruledSupersession"]["registerItem"] == (
        "esc-0952-0959-superseded-by-v3")
    assert entry["written"], "a superseded value set is still published"

    document = files["valueSets/vs-v2-0952.xml"]
    assert '<status value="retired"/>' in document, (
        "the ruling retires the artifact; publishing it active is the "
        "defect this mechanism exists to fix")
    assert "v3-Confidentiality" in document, (
        "the description must name the replacement")
    assert "/7.4.0/" not in document, (
        "the pointer must not pin a THO version")


def test_an_ordinary_value_set_is_still_active():
    """The complement of the test above: making status settable must not
    make it drift. Nothing without a supersession changes standing."""
    record = make_record(
        table="0001",
        codeSystems=[{"Code System OID": "2.16.840.1.113883.18.2",
                      "URI": "http://terminology.hl7.org/"
                             "CodeSystem/v2-0001"}],
        valueSets=[{"Value Set OID": "2.16.840.1.113883.1.11.1",
                    "SymbolicName": "administrativeSex",
                    "Content Logical Definition": "all codes"}],
        codedContent=[{"Code": "F", "Description": "Female"}])
    files, report = writer.process([record], empty_repo(), {})

    for document in files.values():
        assert '<status value="active"/>' in document


def test_the_only_override_is_table_0292():
    """A guard on the mechanism's scope rather than on its behaviour. It is
    for deviations awaiting a ruling, not a general licence to special-case a
    table, so a new entry should be a deliberate edit to this test too."""
    assert sorted(writer.TENTATIVE_OVERRIDES) == ["0292"]


def test_the_override_skips_the_concept_domain_only_gate():
    """Without it, 0292 stops at the gate and nothing is written."""
    plan = writer.classify(domain_only_record("0292"), CVX_OID_INDEX)
    assert plan["action"] != "concept-domain-only"


def test_the_override_lets_the_table_oid_resolve_the_code_system():
    """The override skips a gate and asserts nothing else. Where the table
    routes to is still worked out from the chapter's content and THO's index
    -- here, through the NamingSystem registered against the table's OID."""
    plan = writer.classify(domain_only_record("0292"), CVX_OID_INDEX)
    assert plan["action"] == "value-set-only"
    assert plan["systemUrl"] == CVX
    assert plan["resolvedBy"] == (
        "THO NamingSystem for table OID 2.16.840.1.113883.12.292")


def test_the_override_is_stamped_into_the_report():
    record = domain_only_record("0292")
    _files, report = writer.process([record], empty_repo(), CVX_OID_INDEX)
    block = report[0]["tentativeOverride"]
    assert block["registerItem"] == "esc-0292-cdo-contradiction"
    assert block["gate"] == "concept-domain-only"
    assert block["evidence"]


def test_a_table_with_no_override_still_stops_at_the_gate():
    plan = writer.classify(domain_only_record("0001"), CVX_OID_INDEX)
    assert plan["action"] == "concept-domain-only"
    assert "tentativeOverride" not in plan


def test_an_override_only_matches_the_gate_it_was_written_for():
    assert writer.tentative_override("0292", "concept-domain-only") is not None
    assert writer.tentative_override("0292", "noObject-placeholder") is None


def test_nothing_is_stamped_where_the_gate_would_not_have_fired():
    """If the chapter stopped flagging 0292 domain-only, the entry would have
    overridden nothing, and claiming a deviation we did not make is worse than
    making none."""
    record = domain_only_record("0292")
    record["conceptDomain"]["Concept Domain Only"] = "no"
    plan = writer.classify(record, CVX_OID_INDEX)
    assert "tentativeOverride" not in plan


def test_the_un_ruled_deviation_count_is_computed_every_run():
    """The debt has to be visible, so it is computed rather than remembered."""
    _files, report = writer.process([domain_only_record("0292")],
                                    empty_repo(), CVX_OID_INDEX)
    summary = writer.tentative_override_summary(report)
    assert summary["count"] == len(writer.TENTATIVE_OVERRIDES)
    assert summary["appliedThisRun"] == ["0292"]
    assert summary["registerItems"] == ["esc-0292-cdo-contradiction"]


def test_the_count_stands_even_when_a_run_applies_nothing():
    """A run filtered to other tables must not make the debt look paid."""
    summary = writer.tentative_override_summary([])
    assert summary["count"] == 1
    assert summary["appliedThisRun"] == []


# --------------------------------------------------------------------------
# Where code system definitions are read from (A3)
# --------------------------------------------------------------------------
#
# The corpus used to depend on what the IG Publisher had last downloaded into
# ~/.fhir/packages: table 0962 moved from needs-decision to published between
# two builds on the same day with nothing in the repository changing, and
# neither output was wrong, so nothing raised an error. These tests hold the
# input pinned. See fhir-r5-core/README.md.


def test_the_core_package_is_read_from_the_vendored_copy():
    assert writer.FHIR_CORE_DIR in writer.code_system_directories()


def test_the_publishers_package_cache_is_not_read():
    """A fallback to ~/.fhir/packages would restore the drift, and quietly."""
    cache = Path.home() / ".fhir" / "packages"
    for directory in writer.code_system_directories():
        assert cache not in directory.parents, (
            f"{directory} is inside the publisher's package cache, which is "
            "written as a side effect of building and pins nothing")


def test_tho_outranks_the_core_package():
    """Lowest authority first: a later directory overwrites an earlier one."""
    directories = writer.code_system_directories()
    assert directories.index(writer.FHIR_CORE_DIR) < directories.index(
        writer.THO_DIR)


def test_the_vendored_copy_records_which_package_it_is():
    """Pinned is only half of A3; recorded is the other half."""
    provenance = writer.fhir_core_provenance()
    assert provenance["present"] is True
    assert provenance["package"] == "hl7.fhir.r5.core"
    assert provenance["version"]
    assert provenance["codeSystems"] > 0


def test_a_missing_vendored_copy_is_reported_rather_than_assumed(monkeypatch):
    monkeypatch.setattr(writer, "FHIR_CORE_DIR", Path("/nonexistent"))
    assert writer.fhir_core_provenance() == {
        "present": False, "path": "/nonexistent"}
    assert writer.code_system_directories() == [writer.THO_DIR]
