#!/usr/bin/env python3
"""Tests for the field-mapping document and the truncation detector.

Both of these exist to stop a hand-authored document drifting away from the
corpus it describes, so the tests are mostly about the drift checks themselves
rather than about the prose.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import field_mapping_spec as spec          # noqa: E402
import render_field_mapping as mapping     # noqa: E402
import vocabulary_escalations as register  # noqa: E402


# --------------------------------------------------------------------------
# The mapping spec
# --------------------------------------------------------------------------

def test_every_field_has_a_known_status():
    valid = set(spec.STATUS_LABEL)
    for entry in spec.FIELDS:
        assert entry["status"] in valid, entry["field"]


def test_every_field_belongs_to_a_declared_block():
    blocks = {block["key"] for block in spec.BLOCKS}
    for entry in spec.FIELDS:
        assert entry["block"] in blocks, entry["field"]


def test_no_field_is_listed_twice():
    seen = [(entry["block"], entry["field"]) for entry in spec.FIELDS]
    assert len(seen) == len(set(seen))


def test_a_field_that_goes_nowhere_names_no_destination():
    """`target` is the FHIR element; an unused field cannot have one."""
    for entry in spec.FIELDS:
        if entry["status"] == spec.NOT_USED:
            assert entry["target"] == "", entry["field"]


def test_a_carried_field_names_a_destination():
    for entry in spec.FIELDS:
        if entry["status"] in (spec.CARRIED, spec.TRANSFORMED):
            assert entry["target"], entry["field"]


def test_every_field_explains_itself():
    for entry in spec.FIELDS:
        assert entry["note"].strip(), entry["field"]


# --------------------------------------------------------------------------
# The drift check against the real corpus
# --------------------------------------------------------------------------

def test_the_mapping_accounts_for_every_field_in_the_corpus():
    """The whole point of the document: it cannot quietly go stale.

    A new field appearing in the extraction, or an old one disappearing, has to
    surface as a failure here rather than as a silent omission from the
    published mapping.
    """
    records = mapping.load_records()
    _, _, observed = mapping.count_fields(records)
    missing, stale = mapping.completeness(observed)
    assert missing == [], f"fields in the corpus with no mapping entry: {missing}"
    assert stale == [], f"mapping entries with no field in the corpus: {stale}"


def test_counts_are_per_table_except_for_the_rows():
    """A table counts once however many entries its block has.

    `codedContent` is the exception -- there the unit of interest is the row --
    and getting this backwards would inflate the block counts enormously.
    """
    records = [{
        "tableNumber": "0001",
        "codeSystems": [{"Full Name": "one"}, {"Full Name": "two"}],
        "codedContent": [{"value": "A"}, {"value": "B"}, {"value": "C"}],
    }]
    counts, _, _ = mapping.count_fields(records)
    assert counts[("codeSystems", "Full Name")] == 1
    assert counts[("codedContent", "value")] == 3


def test_an_empty_value_is_not_counted():
    records = [{"tableNumber": "0001",
                "codeSystems": [{"Full Name": "  ", "Description": "real"}]}]
    counts, _, _ = mapping.count_fields(records)
    assert counts[("codeSystems", "Full Name")] == 0
    assert counts[("codeSystems", "Description")] == 1


def test_a_declared_canonical_matching_the_generated_one_is_not_a_finding():
    records = [{
        "tableNumber": "0001",
        "tableName": "Administrative Sex",
        "valueSets": [{"URI": mapping.VS_CANONICAL.format(table="0001")}],
    }]
    assert mapping.divergent_value_set_urls(records, {}) == []


def test_a_declared_canonical_differing_from_the_generated_one_is_reported():
    records = [{
        "tableNumber": "0291",
        "tableName": "Subtype of Referenced Data",
        "valueSets": [{"URI": "http://terminology.hl7.org/ValueSet/"
                              "v2-notAllCodes-0291"}],
    }]
    found = mapping.divergent_value_set_urls(records, {})
    assert len(found) == 1
    assert found[0]["generated"].endswith("v2-0291")


# --------------------------------------------------------------------------
# The truncated Value Set descriptions
# --------------------------------------------------------------------------

def test_the_register_states_the_tables_its_evidence_finds():
    """The authored table list and the computed one must agree."""
    assert register.check_table_lists() == []


def test_the_truncation_band_excludes_a_short_description():
    """0566's description is short and simply has no full stop."""
    findings = {f["table"] for f in register.truncated_value_set_descriptions()}
    assert "0566" not in findings
    assert "0971" not in findings      # the placeholder "tbd"
    assert "0955" not in findings      # 864 characters, ends in a URL


def test_every_truncated_description_stops_without_punctuation():
    for finding in register.truncated_value_set_descriptions():
        assert finding["description"][-1] not in '.!?', finding["table"]


def test_the_truncated_descriptions_sit_in_the_band():
    low, high = register.TRUNCATION_BAND
    for finding in register.truncated_value_set_descriptions():
        assert low <= finding["length"] <= high, finding["table"]


def test_tho_carries_the_same_truncation_for_all_but_one():
    """THO is not a recovery source, and 0227 is the exception that proves it.

    If this ever stops holding, either THO has been corrected -- in which case
    the fifteen full descriptions are now available -- or our text policy has
    started introducing a difference of its own. Both are worth knowing.
    """
    findings = register.truncated_value_set_descriptions()
    by_status = {}
    for finding in findings:
        by_status.setdefault(finding["tho"], []).append(finding["table"])
    assert by_status.get("complete") == ["0227"]
    assert len(by_status.get("same", [])) == len(findings) - 1


def test_the_recovered_text_completes_the_broken_word():
    """0227 stops in the middle of "accessed"; THO supplies the rest."""
    recovered = next(f for f in register.truncated_value_set_descriptions()
                     if f["table"] == "0227")
    assert recovered["description"].endswith("acce")
    assert recovered["recovered"].startswith("ssed via")


def test_the_evidence_table_has_a_row_per_finding():
    columns, rows = register.truncation_evidence()
    assert len(columns) == 5
    assert len(rows) == len(register.truncated_value_set_descriptions())
