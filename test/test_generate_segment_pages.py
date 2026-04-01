#!/usr/bin/env python3
"""Tests for generate_segment_pages.py — segment field parsing and rendering."""

import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from test_helpers import load_fixture
from generate_segment_pages import (
    get_extension,
    get_sub_extension,
    parse_segment_fields,
    format_length,
    format_item_number,
    format_flags,
    format_vocabulary,
    render_segment_table,
)
from v2_utils import AnomalyLog


# --- get_extension ---

class TestGetExtension(unittest.TestCase):
    """Test get_extension() URL suffix matching."""

    def setUp(self):
        self.extensions = [
            {"url": "http://hl7.org/fhir/StructureDefinition/v2-optionality", "valueCode": "R"},
            {"url": "http://hl7.org/fhir/StructureDefinition/v2-length",
             "extension": [{"url": "min", "valueInteger": 1}]},
        ]

    def test_finds_by_suffix(self):
        result = get_extension(self.extensions, "optionality")
        self.assertIsNotNone(result)
        self.assertEqual(result["valueCode"], "R")

    def test_returns_none_when_missing(self):
        result = get_extension(self.extensions, "conformance-length")
        self.assertIsNone(result)

    def test_empty_list(self):
        self.assertIsNone(get_extension([], "optionality"))

    def test_exact_suffix_match(self):
        result = get_extension(self.extensions, "v2-length")
        self.assertIsNotNone(result)


# --- get_sub_extension ---

class TestGetSubExtension(unittest.TestCase):
    """Test get_sub_extension() nested extension lookup."""

    def setUp(self):
        self.extension = {
            "url": "http://hl7.org/fhir/StructureDefinition/v2-length",
            "extension": [
                {"url": "min", "valueInteger": 1},
                {"url": "max", "valueInteger": 4},
            ],
        }

    def test_finds_sub_extension(self):
        result = get_sub_extension(self.extension, "min")
        self.assertIsNotNone(result)
        self.assertEqual(result["valueInteger"], 1)

    def test_returns_none_for_missing(self):
        result = get_sub_extension(self.extension, "nonexistent")
        self.assertIsNone(result)

    def test_no_extension_key(self):
        """Extension dict without 'extension' key should return None."""
        result = get_sub_extension({"url": "something"}, "min")
        self.assertIsNone(result)


# --- parse_segment_fields ---

class TestParseSegmentFields(unittest.TestCase):
    """Test parse_segment_fields() with fixture data."""

    def test_skips_root_element(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        # MSH fixture has 4 elements (root + 3 fields) -> 3 fields
        self.assertEqual(len(fields), 3)
        # First field should be MSH.1, not MSH root
        self.assertEqual(fields[0]["seq"], "1")

    def test_extracts_data_type(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        self.assertEqual(fields[0]["data_type"], "ST")
        self.assertEqual(fields[2]["data_type"], "HD")

    def test_extracts_usage(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        self.assertEqual(fields[0]["usage"], "R")  # MSH.1 is required
        self.assertEqual(fields[2]["usage"], "O")  # MSH.3 is optional

    def test_extracts_cardinality(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        self.assertEqual(fields[0]["min_card"], 1)
        self.assertEqual(fields[0]["max_card"], "1")

    def test_detects_withdrawn_fields(self):
        data = load_fixture("segments/PID-minimal.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "PID", anomalies)
        # PID.2 has usage W and no type -> withdrawn
        pid2 = fields[1]  # index 1 = PID.2
        self.assertTrue(pid2["is_withdrawn"])
        self.assertEqual(pid2["usage"], "W")
        # PID.4 has usage B and no type -> withdrawn
        pid4 = fields[3]  # index 3 = PID.4
        self.assertTrue(pid4["is_withdrawn"])
        self.assertEqual(pid4["usage"], "B")

    def test_non_withdrawn_field(self):
        data = load_fixture("segments/PID-minimal.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "PID", anomalies)
        pid1 = fields[0]
        self.assertFalse(pid1["is_withdrawn"])

    def test_extracts_length(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        # MSH.1 has length min=1, max=1
        self.assertEqual(fields[0]["length_min"], 1)
        self.assertEqual(fields[0]["length_max"], 1)
        # MSH.2 has length min=4, max=15
        self.assertEqual(fields[1]["length_min"], 4)
        self.assertEqual(fields[1]["length_max"], 15)

    def test_extracts_conformance_length(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        # MSH.1 has conformance-length with length=1, noTruncate=1
        self.assertEqual(fields[0]["conf_length"], 1)
        self.assertEqual(fields[0]["no_truncate"], 1)

    def test_extracts_vocabulary(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        # MSH.2 has vocabulary binding
        self.assertIn("v2-0356", fields[1]["vocabulary"])

    def test_extracts_item_number(self):
        data = load_fixture("segments/PID-minimal.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "PID", anomalies)
        self.assertEqual(fields[0]["item_num"], 104)

    def test_handles_empty_elements(self):
        data = {"differential": {"element": []}}
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "EMPTY", anomalies)
        self.assertEqual(fields, [])

    def test_no_length_when_absent(self):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "MSH", anomalies)
        # MSH.3 has no length extension
        self.assertIsNone(fields[2]["length_min"])
        self.assertIsNone(fields[2]["length_max"])


# --- format_length ---

class TestFormatLength(unittest.TestCase):
    """Test format_length() display formatting."""

    def test_both_none(self):
        self.assertEqual(format_length(None, None), "")

    def test_equal_values(self):
        self.assertEqual(format_length(5, 5), "5")

    def test_range(self):
        self.assertEqual(format_length(1, 4), "1..4")

    def test_only_min(self):
        self.assertEqual(format_length(1, None), "1")

    def test_only_max(self):
        self.assertEqual(format_length(None, 4), "4")


# --- format_item_number ---

class TestFormatItemNumber(unittest.TestCase):
    """Test format_item_number() zero-padding."""

    def test_zero_pad(self):
        self.assertEqual(format_item_number(104), "00104")

    def test_empty_string(self):
        self.assertEqual(format_item_number(""), "")

    def test_none(self):
        self.assertEqual(format_item_number(None), "")

    def test_zero(self):
        self.assertEqual(format_item_number(0), "00000")

    def test_string_input(self):
        self.assertEqual(format_item_number("104"), "00104")

    def test_large_number(self):
        self.assertEqual(format_item_number(12345), "12345")


# --- format_flags ---

class TestFormatFlags(unittest.TestCase):
    """Test format_flags() truncation flag display."""

    def test_none_empty(self):
        self.assertEqual(format_flags(None), "")

    def test_no_truncate(self):
        self.assertEqual(format_flags(1), "=")

    def test_truncation_allowed(self):
        self.assertEqual(format_flags(0), "#")


# --- format_vocabulary ---

class TestFormatVocabulary(unittest.TestCase):
    """Test format_vocabulary() URL-to-link conversion."""

    def test_empty_string(self):
        self.assertEqual(format_vocabulary(""), "")

    def test_none(self):
        self.assertEqual(format_vocabulary(None), "")

    def test_v2_url_with_link(self):
        url = "http://terminology.hl7.org/ValueSet/v2-0001"
        result = format_vocabulary(url)
        self.assertIn("0001", result)
        self.assertIn("<a href=", result)
        self.assertIn("v2-0001", result)

    def test_non_v2_url_plain_text(self):
        url = "http://example.com/ValueSet/custom"
        result = format_vocabulary(url)
        self.assertIn("custom", result)
        self.assertNotIn("<a href=", result)


# --- render_segment_table ---

class TestRenderSegmentTable(unittest.TestCase):
    """Test render_segment_table() HTML output with fixture data."""

    @classmethod
    def setUpClass(cls):
        data = load_fixture("segments/MSH.json")
        anomalies = AnomalyLog()
        cls.fields = parse_segment_fields(data, "MSH", anomalies)
        cls.html = render_segment_table("MSH", cls.fields)

    def test_hidden_div_wrapper(self):
        self.assertIn('id="v2-segment-content"', self.html)
        self.assertIn('style="display:none;"', self.html)

    def test_table_class(self):
        self.assertIn('class="grid v2-segment-table"', self.html)

    def test_column_headers(self):
        for header in ["Seq", "Data Element Name", "DataType", "Usage",
                        "Cardinality", "Vocabulary", "Item#", "Length",
                        "C.LEN", "Flags"]:
            self.assertIn(f"<th>{header}</th>", self.html)

    def test_field_row_present(self):
        self.assertIn("Field Separator", self.html)
        self.assertIn("Encoding Characters", self.html)

    def test_data_type_link(self):
        self.assertIn('href="StructureDefinition-ST.html"', self.html)

    def test_cardinality_format(self):
        self.assertIn("[1..1]", self.html)
        self.assertIn("[0..1]", self.html)

    def test_withdrawn_styling(self):
        """Withdrawn fields get a special CSS class."""
        data = load_fixture("segments/PID-minimal.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "PID", anomalies)
        html = render_segment_table("PID", fields)
        self.assertIn('class="v2-field-withdrawn"', html)

    def test_withdrawn_shows_en_dash(self):
        """Withdrawn fields show en-dash instead of data type link."""
        data = load_fixture("segments/PID-minimal.json")
        anomalies = AnomalyLog()
        fields = parse_segment_fields(data, "PID", anomalies)
        html = render_segment_table("PID", fields)
        self.assertIn("\u2013", html)  # en-dash


if __name__ == "__main__":
    unittest.main()
