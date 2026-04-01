#!/usr/bin/env python3
"""Tests for generate_message_pages.py — message structure parsing and rendering."""

import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from generate_message_pages import (
    structure_ref_to_file_id,
    _bracket_wrap,
    _parse_elements,
    render_ack_table,
)
from v2_utils import escape_xml


# --- structure_ref_to_file_id ---

class TestStructureRefToFileId(unittest.TestCase):
    """Test structure_ref_to_file_id() URL-to-file conversion."""

    def test_canonical_conversion(self):
        self.assertEqual(structure_ref_to_file_id("ADT-A01-A"), "ADT_A01-A")

    def test_single_hyphen(self):
        self.assertEqual(structure_ref_to_file_id("ADT-A01"), "ADT_A01")

    def test_no_hyphen(self):
        self.assertEqual(structure_ref_to_file_id("ADT"), "ADT")

    def test_multiple_hyphens_only_first(self):
        """Only the first hyphen is replaced with underscore."""
        result = structure_ref_to_file_id("QBP-Q11-A")
        self.assertEqual(result, "QBP_Q11-A")
        # Second hyphen preserved
        self.assertEqual(result.count("-"), 1)
        self.assertEqual(result.count("_"), 1)


# --- _bracket_wrap ---

class TestBracketWrap(unittest.TestCase):
    """Test _bracket_wrap() V2 cardinality notation."""

    def test_required_non_repeating(self):
        """1..1 -> no brackets."""
        self.assertEqual(_bracket_wrap("MSH", 1, "1"), "MSH")

    def test_optional_non_repeating(self):
        """0..1 -> [ text ]."""
        self.assertEqual(_bracket_wrap("EVN", 0, "1"), "[ EVN ]")

    def test_optional_repeating(self):
        """0..* -> [{ text }]."""
        self.assertEqual(_bracket_wrap("NK1", 0, "*"), "[{ NK1 }]")

    def test_required_repeating(self):
        """1..* -> { text }."""
        self.assertEqual(_bracket_wrap("PID", 1, "*"), "{ PID }")

    def test_required_max_greater_than_1(self):
        """max > 1 counts as repeating."""
        result = _bracket_wrap("OBX", 1, "5")
        self.assertEqual(result, "{ OBX }")

    def test_optional_max_greater_than_1(self):
        """0..5 counts as optional repeating."""
        result = _bracket_wrap("NTE", 0, "5")
        self.assertEqual(result, "[{ NTE }]")


# --- _parse_elements ---

class TestParseElements(unittest.TestCase):
    """Test _parse_elements() with synthetic MessageStructure data."""

    def setUp(self):
        self.data = {
            "differential": {
                "element": [
                    {
                        "path": "ADT_A01",
                        "short": "ADT_A01 Message",
                        "min": 0,
                        "max": "*",
                    },
                    {
                        "path": "ADT_A01.CONTENT-MSH",
                        "short": "Message Header",
                        "min": 1,
                        "max": "1",
                        "type": [{"code": "MSH"}],
                    },
                    {
                        "path": "ADT_A01.CONTENT-SFT",
                        "short": "Software Segment",
                        "min": 0,
                        "max": "*",
                        "type": [{"code": "SFT"}],
                    },
                    {
                        "path": "ADT_A01.CONTENT-PATIENT_VISIT",
                        "short": "Patient Visit group",
                        "min": 0,
                        "max": "1",
                        "type": [{"code": "BackboneElement"}],
                    },
                    {
                        "path": "ADT_A01.CONTENT-PATIENT_VISIT.CONTENT-PV1",
                        "short": "Patient Visit",
                        "min": 1,
                        "max": "1",
                        "type": [{"code": "PV1"}],
                    },
                ],
            }
        }

    def test_skips_root_element(self):
        parsed = _parse_elements(self.data)
        self.assertEqual(len(parsed), 4)
        paths = [e["path"] for e in parsed]
        self.assertNotIn("ADT_A01", paths)

    def test_segment_extraction(self):
        parsed = _parse_elements(self.data)
        msh = parsed[0]
        self.assertEqual(msh["segment_or_group"], "MSH")
        self.assertEqual(msh["type_code"], "MSH")
        self.assertFalse(msh["is_group"])

    def test_group_detection(self):
        parsed = _parse_elements(self.data)
        group = parsed[2]  # PATIENT_VISIT group
        self.assertTrue(group["is_group"])
        self.assertEqual(group["type_code"], "BackboneElement")
        self.assertEqual(group["segment_or_group"], "PATIENT_VISIT")

    def test_depth_calculation(self):
        parsed = _parse_elements(self.data)
        # ADT_A01.CONTENT-MSH -> 1 dot, depth = 0
        self.assertEqual(parsed[0]["depth"], 0)
        # ADT_A01.CONTENT-PATIENT_VISIT.CONTENT-PV1 -> 2 dots, depth = 1
        self.assertEqual(parsed[3]["depth"], 1)

    def test_cardinality_extraction(self):
        parsed = _parse_elements(self.data)
        msh = parsed[0]
        self.assertEqual(msh["min_card"], 1)
        self.assertEqual(msh["max_card"], "1")
        sft = parsed[1]
        self.assertEqual(sft["min_card"], 0)
        self.assertEqual(sft["max_card"], "*")

    def test_short_desc_escaped(self):
        """Short descriptions should be XML-escaped."""
        data = {
            "differential": {
                "element": [
                    {"path": "MSG", "short": "root", "min": 0, "max": "*"},
                    {
                        "path": "MSG.CONTENT-SEG",
                        "short": "A & B",
                        "min": 1,
                        "max": "1",
                        "type": [{"code": "SEG"}],
                    },
                ],
            }
        }
        parsed = _parse_elements(data)
        self.assertEqual(parsed[0]["short_desc"], "A &amp; B")

    def test_status_from_extension(self):
        """Segment status extracted from v2-segment-status extension."""
        data = {
            "differential": {
                "element": [
                    {"path": "MSG", "short": "root", "min": 0, "max": "*"},
                    {
                        "path": "MSG.CONTENT-SEG",
                        "short": "Seg",
                        "min": 1,
                        "max": "1",
                        "type": [{"code": "SEG"}],
                        "extension": [
                            {
                                "url": "http://hl7.org/fhir/StructureDefinition/v2-segment-status",
                                "valueCode": "new",
                            }
                        ],
                    },
                ],
            }
        }
        parsed = _parse_elements(data)
        self.assertEqual(parsed[0]["status"], "new")


# --- render_ack_table ---

class TestRenderAckTable(unittest.TestCase):
    """Test render_ack_table() ACK choreography rendering."""

    def test_empty_choreography(self):
        self.assertEqual(render_ack_table({}, "ADT"), "")

    def test_none_choreography(self):
        self.assertEqual(render_ack_table(None, "ADT"), "")

    def test_basic_rendering(self):
        ack = {"originalModeResponse": "ACK-A01"}
        html = render_ack_table(ack, "ADT")
        self.assertIn('id="v2-ack-content"', html)
        self.assertIn("Original Mode", html)
        self.assertIn("ACK^A01", html)
        self.assertIn('href="StructureDefinition-ACK-A01.html"', html)

    def test_all_modes(self):
        ack = {
            "originalModeResponse": "ACK-A01",
            "enhancedModeImmediateResponse": "ACK-A01",
            "enhancedModeApplicationResponse": "ACK-A01",
        }
        html = render_ack_table(ack, "ADT")
        self.assertIn("Original Mode", html)
        self.assertIn("Enhanced Mode: Immediate", html)
        self.assertIn("Enhanced Mode: Application", html)

    def test_hidden_div(self):
        ack = {"originalModeResponse": "ACK-A01"}
        html = render_ack_table(ack, "ADT")
        self.assertIn('style="display:none;"', html)

    def test_table_structure(self):
        ack = {"originalModeResponse": "ACK-A01"}
        html = render_ack_table(ack, "ADT")
        self.assertIn("<thead>", html)
        self.assertIn("<th>Mode</th>", html)
        self.assertIn("<th>Response</th>", html)
        self.assertIn("<tbody>", html)

    def test_unknown_mode_ignored(self):
        """Modes not in mode_labels are not rendered."""
        ack = {"unknownMode": "ACK-X01"}
        html = render_ack_table(ack, "ADT")
        self.assertEqual(html, "")


if __name__ == "__main__":
    unittest.main()
