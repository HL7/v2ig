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

import sys
from pathlib import Path
from xml.etree import ElementTree

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))

from utg_xml import Node, escape_attribute, render_document  # noqa: E402
import write_utg_xml as writer  # noqa: E402

FHIR = "{http://hl7.org/fhir}"


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
    ("N", "N"),      # UTG passes these two through rather than mapping them,
    ("B", "B"),      # and inventing a FHIR meaning for them would be a guess
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
