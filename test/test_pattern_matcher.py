#!/usr/bin/env python3
"""Tests for pattern_matcher.py — TASK-012."""

import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from pattern_matcher import PatternMatcher


class TestSegmentFieldMatching(unittest.TestCase):
    """Test matching of segment-field references (PID-3, MSH-9, etc.)."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_matches_pid_3(self):
        results = self.m.find_matches("The PID-3 field is required.")
        codes = [r["code"] for r in results]
        self.assertIn("PID-3", codes)

    def test_matches_msh_9(self):
        results = self.m.find_matches("MSH-9 contains the message type.")
        codes = [r["code"] for r in results]
        self.assertIn("MSH-9", codes)

    def test_field_ref_type(self):
        results = self.m.find_matches("See PID-3 for details.")
        pid3 = [r for r in results if r["code"] == "PID-3"]
        self.assertEqual(len(pid3), 1)
        self.assertEqual(pid3[0]["type"], "segment-field")

    def test_field_ref_url(self):
        results = self.m.find_matches("Check PID-3.")
        pid3 = [r for r in results if r["code"] == "PID-3"]
        self.assertIn("PID.3", pid3[0]["url"])

    def test_multiple_field_refs(self):
        results = self.m.find_matches("PID-3 and MRG-1 must match.")
        codes = [r["code"] for r in results]
        self.assertIn("PID-3", codes)
        self.assertIn("MRG-1", codes)

    def test_three_digit_field_number(self):
        """Fields can have numbers > 9 (e.g., PID-18)."""
        results = self.m.find_matches("See PID-18 for account number.")
        codes = [r["code"] for r in results]
        self.assertIn("PID-18", codes)


class TestSegmentCodeMatching(unittest.TestCase):
    """Test matching of bare segment codes (PID, MSH, OBX, etc.)."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_matches_pid(self):
        results = self.m.find_matches("The PID segment carries demographics.")
        codes = [r["code"] for r in results]
        self.assertIn("PID", codes)

    def test_matches_obx(self):
        results = self.m.find_matches("Each OBX contains an observation.")
        codes = [r["code"] for r in results]
        self.assertIn("OBX", codes)

    def test_segment_type(self):
        results = self.m.find_matches("The MSH segment.")
        msh = [r for r in results if r["code"] == "MSH"]
        self.assertEqual(msh[0]["type"], "segment")

    def test_no_match_inside_word(self):
        """PID inside 'RAPID' should not match."""
        results = self.m.find_matches("RAPID response team")
        codes = [r["code"] for r in results]
        self.assertNotIn("PID", codes)

    def test_no_match_inside_word_prefix(self):
        """MSH inside 'ASMSH' should not match."""
        results = self.m.find_matches("Something ASMSH here")
        codes = [r["code"] for r in results]
        self.assertNotIn("MSH", codes)

    def test_segment_with_digit(self):
        """Segments like AL1, NK1, PV1 have digits."""
        results = self.m.find_matches("The NK1 segment has next of kin.")
        codes = [r["code"] for r in results]
        self.assertIn("NK1", codes)


class TestDataTypeMatching(unittest.TestCase):
    """Test matching of data type codes (CWE, XPN, etc.)."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_matches_cwe(self):
        results = self.m.find_matches("Encoded as CWE data type.")
        codes = [r["code"] for r in results]
        self.assertIn("CWE", codes)

    def test_complex_type(self):
        results = self.m.find_matches("Uses CWE encoding.")
        cwe = [r for r in results if r["code"] == "CWE"]
        self.assertEqual(cwe[0]["type"], "complex-data-type")

    def test_matches_component(self):
        results = self.m.find_matches("CWE.1 is the identifier.")
        codes = [r["code"] for r in results]
        self.assertIn("CWE.1", codes)

    def test_component_type(self):
        results = self.m.find_matches("See CWE.1 for details.")
        cwe1 = [r for r in results if r["code"] == "CWE.1"]
        self.assertEqual(cwe1[0]["type"], "data-type-component")


class TestMessageTypeMatching(unittest.TestCase):
    """Test matching of message types (ADT^A01, MFN^M02, etc.)."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_matches_adt_a01(self):
        results = self.m.find_matches("Send an ADT^A01 message.")
        codes = [r["code"] for r in results]
        self.assertIn("ADT^A01", codes)

    def test_message_type(self):
        results = self.m.find_matches("The ADT^A01 trigger.")
        adt = [r for r in results if r["code"] == "ADT^A01"]
        self.assertEqual(adt[0]["type"], "message")

    def test_matches_mfn_m02(self):
        results = self.m.find_matches("MFN^M02 for staff updates.")
        codes = [r["code"] for r in results]
        self.assertIn("MFN^M02", codes)


class TestFalsePositiveAvoidance(unittest.TestCase):
    """Test that common English words are not matched as V2 codes."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_is_not_matched(self):
        """'IS' is a V2 data type but also 'is' the verb."""
        results = self.m.find_matches("This IS important.")
        codes = [r["code"] for r in results]
        self.assertNotIn("IS", codes)

    def test_or_not_matched(self):
        results = self.m.find_matches("Use PID OR MSH.")
        codes = [r["code"] for r in results]
        # PID and MSH should match, OR should not
        self.assertNotIn("OR", codes)

    def test_dr_not_matched(self):
        results = self.m.find_matches("DR Smith ordered the test.")
        codes = [r["code"] for r in results]
        self.assertNotIn("DR", codes)

    def test_id_not_matched(self):
        results = self.m.find_matches("The ID must be unique.")
        codes = [r["code"] for r in results]
        self.assertNotIn("ID", codes)

    def test_st_not_matched(self):
        results = self.m.find_matches("Located on ST Avenue.")
        codes = [r["code"] for r in results]
        self.assertNotIn("ST", codes)

    def test_false_positives_can_be_disabled(self):
        """With skip_false_positives=False, all codes match."""
        results = self.m.find_matches("The ID field.", skip_false_positives=False)
        codes = [r["code"] for r in results]
        # ID is a real V2 primitive type, so it should match when not filtered
        self.assertIn("ID", codes)


class TestAsciiDocBlockSkipping(unittest.TestCase):
    """Test that code blocks, ER7 examples, and directives are skipped."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_skips_er7_block(self):
        content = """Some prose with PID segment.

[.er7]
....
MSH|^~\\&|SEND|FAC|REC|FAC|200102||ADT^A01|MSG001|P|2.9
PID|1||12345^^^MR||DOE^JOHN
....

More prose with OBX segment.
"""
        results = self.m.find_in_asciidoc(content)
        codes = [r["code"] for r in results]
        # PID from prose (line 1) and OBX from prose should match
        self.assertIn("PID", codes)
        self.assertIn("OBX", codes)
        # MSH and ADT^A01 from ER7 block should NOT match
        lines_with_adt = [r for r in results if r["code"] == "ADT^A01"]
        # Any ADT^A01 match should be from prose, not from the ER7 block
        for r in lines_with_adt:
            self.assertNotEqual(r["line"], 5, "Should not match inside ER7 block")

    def test_skips_code_block(self):
        content = """Prose references PID.

----
PID|1||12345^^^MR
----

More text.
"""
        results = self.m.find_in_asciidoc(content)
        # Only the prose PID should match
        pid_matches = [r for r in results if r["code"] == "PID"]
        self.assertEqual(len(pid_matches), 1)
        self.assertEqual(pid_matches[0]["line"], 1)

    def test_skips_asciidoc_directives(self):
        content = """:code: PID
include::PID.adoc[]
The PID segment is important.
"""
        results = self.m.find_in_asciidoc(content)
        # Only the prose line should produce matches
        self.assertTrue(all(r["line"] == 3 for r in results))

    def test_skips_er7_inline(self):
        """Lines starting with SEGMENT| are ER7 data, not prose."""
        content = """The MSH segment begins every message.
MSH|^~\\&|SEND|FAC||
PID|1||12345
The PID segment follows.
"""
        results = self.m.find_in_asciidoc(content)
        codes_by_line = {r["line"]: r["code"] for r in results}
        self.assertIn(1, codes_by_line)  # prose MSH
        self.assertNotIn(2, codes_by_line)  # ER7 line
        self.assertNotIn(3, codes_by_line)  # ER7 line
        self.assertIn(4, codes_by_line)  # prose PID

    def test_skips_section_headings(self):
        content = """== PID Segment
The PID segment carries patient info.
"""
        results = self.m.find_in_asciidoc(content)
        # Only prose line should match
        self.assertTrue(all(r["line"] == 2 for r in results))

    def test_skips_attribute_lines(self):
        content = """:v291_section: "3.4.1"
The OBX segment carries observations.
"""
        results = self.m.find_in_asciidoc(content)
        self.assertTrue(all(r["line"] == 2 for r in results))


class TestMatchPositions(unittest.TestCase):
    """Test that match positions (start, end) are correct."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_start_end_positions(self):
        text = "The PID-3 field."
        results = self.m.find_matches(text)
        pid3 = [r for r in results if r["code"] == "PID-3"][0]
        self.assertEqual(text[pid3["start"] : pid3["end"]], "PID-3")

    def test_message_type_positions(self):
        text = "Send ADT^A01 now."
        results = self.m.find_matches(text)
        adt = [r for r in results if r["code"] == "ADT^A01"][0]
        self.assertEqual(text[adt["start"] : adt["end"]], "ADT^A01")


class TestEdgeCases(unittest.TestCase):
    """Test edge cases identified during TASK-014."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_slash_separated_field_refs(self):
        """PID-3/MRG-1 should match both sides."""
        results = self.m.find_matches("PID-3/MRG-1 should match.")
        codes = [r["code"] for r in results]
        self.assertIn("PID-3", codes)
        self.assertIn("MRG-1", codes)

    def test_italic_field_ref(self):
        """_PID-3_ in AsciiDoc italic should still match."""
        results = self.m.find_matches("See _PID-3 field_ for details.")
        codes = [r["code"] for r in results]
        self.assertIn("PID-3", codes)

    def test_parenthesized_data_type(self):
        """(CWE) in parentheses should match."""
        results = self.m.find_matches("encoded as (CWE) format")
        codes = [r["code"] for r in results]
        self.assertIn("CWE", codes)

    def test_dt_column_header_not_matched(self):
        """DT in table header means 'Data Type', not the DT primitive."""
        results = self.m.find_matches("|DT |OPT |RP/# |TBL#")
        codes = [r["code"] for r in results]
        self.assertNotIn("DT", codes)

    def test_component_subcomponent(self):
        """STF.2.1 should not match — we only handle SEG.N not SEG.N.N."""
        results = self.m.find_matches("If STF.2.1 is not valued")
        # STF.2 should match but not STF.2.1 as a whole
        codes = [r["code"] for r in results]
        self.assertIn("STF.2", codes)

    def test_message_structure_triple(self):
        """QBP^Q25^QBP_Q21 — first part (message type) should match."""
        results = self.m.find_matches("QBP^Q25^QBP_Q21")
        codes = [r["code"] for r in results]
        self.assertIn("QBP^Q25", codes)

    def test_no_match_in_v2_table_placeholder(self):
        """V2 table placeholders should not produce matches."""
        content = "{{v2-table:0006:Religion}}"
        results = self.m.find_in_asciidoc(content)
        # The line starts with {{ which starts with a non-alpha,
        # but the matcher processes it. Check no false positives.
        codes = [r["code"] for r in results]
        # No V2 codes should match inside the placeholder
        self.assertEqual(len(codes), 0)


class TestRealContent(unittest.TestCase):
    """Test against actual AsciiDoc files from the repository."""

    @classmethod
    def setUpClass(cls):
        cls.m = PatternMatcher()

    def test_implementation_considerations_has_matches(self):
        path = REPO_ROOT / "website" / "domains" / "administration" / "registration" / "implementation_considerations.adoc"
        if not path.exists():
            self.skipTest("File not found")
        content = path.read_text(encoding="utf-8")
        results = self.m.find_in_asciidoc(content)
        self.assertGreater(len(results), 50, "Should find many V2 references")
        types = {r["type"] for r in results}
        self.assertIn("segment-field", types)
        self.assertIn("segment", types)

    def test_master_files_skips_er7(self):
        path = REPO_ROOT / "website" / "domains" / "technical" / "master_files" / "master_files.adoc"
        if not path.exists():
            self.skipTest("File not found")
        content = path.read_text(encoding="utf-8")
        results = self.m.find_in_asciidoc(content)
        # ER7 blocks are delimited by .... — matches inside them should be skipped.
        # Lines 165-178, 184-189, 200-207, etc. are inside ER7 blocks.
        # Lines between blocks (195, 209) are prose and SHOULD match.
        er7_only_lines = set()
        for start, end in [(165, 178), (184, 189), (200, 207), (212, 218),
                           (225, 232), (234, 238), (242, 249), (251, 255)]:
            er7_only_lines.update(range(start, end + 1))
        er7_matches = [r for r in results if r["line"] in er7_only_lines]
        self.assertEqual(len(er7_matches), 0, "Should not match inside ER7 blocks")


if __name__ == "__main__":
    unittest.main()
