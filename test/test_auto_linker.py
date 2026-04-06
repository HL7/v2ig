#!/usr/bin/env python3
"""Tests for auto_linker.py — TASK-013."""

import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from auto_linker import AutoLinker


class TestBasicLinking(unittest.TestCase):
    """Test basic reference-to-link replacement."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_segment_field_linked(self):
        content = "The PID-3 field contains patient identifiers."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:StructureDefinition-PID.html#PID.3[PID-3]", result)
        self.assertEqual(stats["linked"], 1)

    def test_segment_code_linked(self):
        content = "The PID segment carries demographics."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:StructureDefinition-PID.html[PID]", result)

    def test_data_type_linked(self):
        content = "Encoded as CWE data type."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:StructureDefinition-CWE.html[CWE]", result)

    def test_message_type_linked(self):
        content = "Send an ADT^A01 message."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:StructureDefinition-ADT-A01.html[ADT^A01]", result)

    def test_component_linked(self):
        content = "CWE.1 is the identifier."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:StructureDefinition-CWE.html#CWE.1[CWE.1]", result)

    def test_multiple_refs_in_one_line(self):
        content = "PID-3 and MRG-1 must match."
        result, stats = self.linker.link_content(content)
        self.assertIn("link:", result)
        self.assertEqual(stats["linked"], 2)

    def test_preserves_surrounding_text(self):
        content = "Check the PID-3 field carefully."
        result, _ = self.linker.link_content(content)
        self.assertTrue(result.startswith("Check the "))
        self.assertTrue(result.endswith(" field carefully."))


class TestIdempotency(unittest.TestCase):
    """Test that auto-linker is idempotent."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_double_run_same_output(self):
        content = "The PID segment and PID-3 field."
        result1, stats1 = self.linker.link_content(content)
        result2, stats2 = self.linker.link_content(result1)
        self.assertEqual(result1, result2)
        self.assertEqual(stats2["linked"], 0)

    def test_already_linked_counted(self):
        content = "The PID segment."
        result1, _ = self.linker.link_content(content)
        _, stats2 = self.linker.link_content(result1)
        self.assertGreater(stats2["skipped_already_linked"], 0)

    def test_existing_link_preserved(self):
        content = "See link:StructureDefinition-PID.html[PID] for details."
        result, stats = self.linker.link_content(content)
        self.assertEqual(result, content)
        self.assertEqual(stats["linked"], 0)

    def test_existing_xref_preserved(self):
        content = "See xref:technical_specs/A01.adoc[Message - A01]."
        result, stats = self.linker.link_content(content)
        # Should not add links inside xref brackets
        self.assertNotIn("link:StructureDefinition", result)


class TestBlockSkipping(unittest.TestCase):
    """Test that non-prose blocks are not modified."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_er7_block_not_modified(self):
        content = """Prose with PID reference.

[.er7]
....
MSH|^~\\&|SEND|FAC|REC|FAC||ADT^A01|MSG001|P|2.9
PID|1||12345
....

More prose with OBX reference.
"""
        result, stats = self.linker.link_content(content)
        # ER7 lines should be unchanged
        self.assertIn("MSH|^~\\&|SEND", result)
        self.assertIn("PID|1||12345", result)
        # Prose should be linked
        self.assertIn("link:StructureDefinition-PID.html[PID]", result)
        self.assertIn("link:StructureDefinition-OBX.html[OBX]", result)

    def test_code_block_not_modified(self):
        content = """Prose MSH reference.

----
MSH segment here
----
"""
        result, _ = self.linker.link_content(content)
        lines = result.split("\n")
        # Code block line should be unchanged
        self.assertEqual(lines[3], "MSH segment here")
        # Prose should be linked
        self.assertIn("link:StructureDefinition-MSH.html[MSH]", lines[0])

    def test_heading_not_modified(self):
        content = "== PID Segment\nThe PID segment."
        result, _ = self.linker.link_content(content)
        lines = result.split("\n")
        self.assertEqual(lines[0], "== PID Segment")
        self.assertIn("link:", lines[1])

    def test_directive_not_modified(self):
        content = ":code: PID\nThe PID segment."
        result, _ = self.linker.link_content(content)
        lines = result.split("\n")
        self.assertEqual(lines[0], ":code: PID")

    def test_er7_inline_not_modified(self):
        content = "MSH|^~\\&|SEND"
        result, stats = self.linker.link_content(content)
        self.assertEqual(result, content)
        self.assertEqual(stats["linked"], 0)


class TestV2TablePlaceholders(unittest.TestCase):
    """Test that {{v2-table:...}} placeholders are not disrupted."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_placeholder_not_linked_inside(self):
        content = "See {{v2-table:0006:Religion}} for codes."
        result, _ = self.linker.link_content(content)
        # The placeholder should remain intact
        self.assertIn("{{v2-table:0006:Religion}}", result)


class TestFalsePositiveAvoidance(unittest.TestCase):
    """Test that common words are not linked."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_is_not_linked(self):
        content = "This IS important for the specification."
        result, stats = self.linker.link_content(content)
        self.assertNotIn("link:", result)

    def test_dr_not_linked(self):
        content = "DR Smith ordered the procedure."
        result, stats = self.linker.link_content(content)
        self.assertNotIn("link:", result)


class TestStats(unittest.TestCase):
    """Test statistics tracking."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_stats_counts(self):
        content = "PID-3 and MSH-9 are important."
        _, stats = self.linker.link_content(content)
        self.assertEqual(stats["total_refs"], 2)
        self.assertEqual(stats["linked"], 2)
        self.assertEqual(stats["skipped_already_linked"], 0)

    def test_mixed_stats(self):
        content = "link:StructureDefinition-PID.html[PID] and MSH-9."
        _, stats = self.linker.link_content(content)
        self.assertGreater(stats["skipped_already_linked"], 0)
        self.assertGreater(stats["linked"], 0)


class TestRealFiles(unittest.TestCase):
    """Test against actual repository files."""

    @classmethod
    def setUpClass(cls):
        cls.linker = AutoLinker()

    def test_implementation_considerations(self):
        path = REPO_ROOT / "website" / "domains" / "administration" / "registration" / "implementation_considerations.adoc"
        if not path.exists():
            self.skipTest("File not found")
        content = path.read_text(encoding="utf-8")
        result, stats = self.linker.link_content(content)
        self.assertGreater(stats["linked"], 50)
        # Verify idempotency
        result2, stats2 = self.linker.link_content(result)
        self.assertEqual(result, result2)


if __name__ == "__main__":
    unittest.main()
