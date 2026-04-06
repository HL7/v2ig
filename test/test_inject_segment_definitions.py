#!/usr/bin/env python3
"""Tests for the inject_segment_definitions.py script."""

import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

# Add tooling/scripts to path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tooling" / "scripts"))

from inject_segment_definitions import (
    extract_segment_definition,
    extract_segment_comment,
    find_element_by_id,
    normalize_for_comparison,
    inject_for_segment,
    ADOC_DIR,
    JSON_DIR,
)

from backfill_segment_adoc import (
    generate_root_adoc,
    generate_field_adoc,
    format_field_heading,
    get_data_type,
)


class TestExtractSegmentDefinition(unittest.TestCase):
    """Test [segment-definition] block extraction from AsciiDoc."""

    def _write_adoc(self, content):
        f = tempfile.NamedTemporaryFile(
            mode="w", suffix=".adoc", delete=False, encoding="utf-8"
        )
        f.write(content)
        f.close()
        self.addCleanup(os.unlink, f.name)
        return Path(f.name)

    def test_simple_definition(self):
        path = self._write_adoc(
            "== PID.1 - Set ID - PID (SI)\n"
            "\n"
            "[segment-definition]\n"
            "This field identifies the transaction.\n"
        )
        result = extract_segment_definition(path)
        self.assertEqual(result, "This field identifies the transaction.")

    def test_multiline_definition(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "First paragraph.\n"
            "\n"
            "Second paragraph with more detail.\n"
        )
        result = extract_segment_definition(path)
        self.assertIn("First paragraph", result)
        self.assertIn("Second paragraph", result)

    def test_definition_stops_at_section_heading(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "This is the definition.\n"
            "\n"
            "== Next Section\n"
            "This should not be included.\n"
        )
        result = extract_segment_definition(path)
        self.assertEqual(result, "This is the definition.")

    def test_definition_stops_at_include(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "The definition.\n"
            "\n"
            "include::PID-fields/PID-1.adoc[]\n"
        )
        result = extract_segment_definition(path)
        self.assertEqual(result, "The definition.")

    def test_definition_stops_at_comment_block(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "This is the definition.\n"
            "\n"
            "[segment-comment]\n"
            "This is the comment.\n"
        )
        result = extract_segment_definition(path)
        self.assertEqual(result, "This is the definition.")

    def test_placeholder_comment_stripped(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "// TODO: Add field definition\n"
        )
        result = extract_segment_definition(path)
        self.assertIsNone(result)

    def test_no_definition_block(self):
        path = self._write_adoc(
            "== PID.1 - Set ID - PID (SI)\n"
            "\n"
            "Just some text without a block.\n"
        )
        result = extract_segment_definition(path)
        self.assertIsNone(result)

    def test_empty_definition_block(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "\n"
            "[segment-comment]\n"
            "Some comment.\n"
        )
        result = extract_segment_definition(path)
        self.assertIsNone(result)

    def test_file_not_found(self):
        result = extract_segment_definition(Path("/nonexistent/file.adoc"))
        self.assertIsNone(result)

    def test_definition_preserves_asciidoc_markup(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "Refer to {{v2-table:0200:Name Type}} for values.\n"
            "\n"
            "*Bold text* and _italic text_ here.\n"
        )
        result = extract_segment_definition(path)
        self.assertIn("{{v2-table:0200:Name Type}}", result)
        self.assertIn("*Bold text*", result)


class TestExtractSegmentComment(unittest.TestCase):
    """Test [segment-comment] block extraction from AsciiDoc."""

    def _write_adoc(self, content):
        f = tempfile.NamedTemporaryFile(
            mode="w", suffix=".adoc", delete=False, encoding="utf-8"
        )
        f.write(content)
        f.close()
        self.addCleanup(os.unlink, f.name)
        return Path(f.name)

    def test_simple_comment(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "Some definition.\n"
            "\n"
            "[segment-comment]\n"
            "This is the comment.\n"
        )
        result = extract_segment_comment(path)
        self.assertEqual(result, "This is the comment.")

    def test_multiline_comment(self):
        path = self._write_adoc(
            "[segment-comment]\n"
            "First paragraph of comment.\n"
            "\n"
            "Second paragraph of comment.\n"
        )
        result = extract_segment_comment(path)
        self.assertIn("First paragraph", result)
        self.assertIn("Second paragraph", result)

    def test_comment_stops_at_section(self):
        path = self._write_adoc(
            "[segment-comment]\n"
            "The comment.\n"
            "\n"
            "== Next Section\n"
            "Not included.\n"
        )
        result = extract_segment_comment(path)
        self.assertEqual(result, "The comment.")

    def test_no_comment_block(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "Just a definition.\n"
        )
        result = extract_segment_comment(path)
        self.assertIsNone(result)

    def test_empty_comment_block(self):
        path = self._write_adoc(
            "[segment-comment]\n"
            "\n"
        )
        result = extract_segment_comment(path)
        self.assertIsNone(result)

    def test_comment_with_withdrawn_notice(self):
        path = self._write_adoc(
            "[segment-definition]\n"
            "// TODO: Add field definition\n"
            "\n"
            "[segment-comment]\n"
            "*Attention:* This field was withdrawn as of v2.7.\n"
        )
        result = extract_segment_comment(path)
        self.assertEqual(result, "*Attention:* This field was withdrawn as of v2.7.")


class TestFindElementById(unittest.TestCase):
    """Test element lookup in StructureDefinition element array."""

    def test_find_existing(self):
        elements = [{"id": "PID"}, {"id": "PID.1"}, {"id": "PID.2"}]
        result = find_element_by_id(elements, "PID.1")
        self.assertEqual(result["id"], "PID.1")

    def test_find_root(self):
        elements = [{"id": "PID"}, {"id": "PID.1"}]
        result = find_element_by_id(elements, "PID")
        self.assertEqual(result["id"], "PID")

    def test_not_found(self):
        elements = [{"id": "PID"}, {"id": "PID.1"}]
        result = find_element_by_id(elements, "PID.99")
        self.assertIsNone(result)

    def test_empty_list(self):
        result = find_element_by_id([], "PID")
        self.assertIsNone(result)


class TestNormalizeForComparison(unittest.TestCase):
    """Test whitespace normalization."""

    def test_simple(self):
        self.assertEqual(normalize_for_comparison("hello  world"), "hello world")

    def test_newlines(self):
        self.assertEqual(normalize_for_comparison("hello\n\nworld"), "hello world")

    def test_empty(self):
        self.assertEqual(normalize_for_comparison(""), "")

    def test_none(self):
        self.assertEqual(normalize_for_comparison(None), "")

    def test_leading_trailing_whitespace(self):
        self.assertEqual(normalize_for_comparison("  hello  "), "hello")


class TestBackfillGenerators(unittest.TestCase):
    """Test AsciiDoc generation functions from backfill_segment_adoc.py."""

    def test_format_field_heading_with_type(self):
        result = format_field_heading("PID", "1", "Set ID - PID", "SI")
        self.assertEqual(result, "== PID.1 - Set ID - PID (SI)")

    def test_format_field_heading_without_type(self):
        result = format_field_heading("PID", "2", "Patient ID", "")
        self.assertEqual(result, "== PID.2 - Patient ID")

    def test_generate_root_adoc_with_definition(self):
        content = generate_root_adoc("MSH", "Message Header", "The MSH segment defines the intent.", 3)
        self.assertIn("= (MSH) Segment - Message Header", content)
        self.assertIn(":code: MSH", content)
        self.assertIn("[segment-definition]", content)
        self.assertIn("The MSH segment defines the intent.", content)
        self.assertIn("include::MSH-fields/MSH-1.adoc[]", content)
        self.assertIn("include::MSH-fields/MSH-3.adoc[]", content)
        self.assertNotIn("// TODO", content)

    def test_generate_root_adoc_null_definition(self):
        content = generate_root_adoc("PID", "Patient Identification", None, 2)
        self.assertIn("// TODO: Add segment definition", content)
        self.assertIn("include::PID-fields/PID-1.adoc[]", content)

    def test_generate_root_adoc_zero_fields(self):
        content = generate_root_adoc("Hxx", "Any segment", None, 0)
        self.assertIn("= (Hxx) Segment - Any segment", content)
        self.assertNotIn("include::", content)

    def test_generate_field_adoc_with_definition_and_comment(self):
        content = generate_field_adoc("PID", "5", "Patient Name", "XPN",
                                       "This field contains names.", "Additional usage note.")
        self.assertIn("== PID.5 - Patient Name (XPN)", content)
        self.assertIn("[segment-definition]", content)
        self.assertIn("This field contains names.", content)
        self.assertIn("[segment-comment]", content)
        self.assertIn("Additional usage note.", content)

    def test_generate_field_adoc_no_definition(self):
        content = generate_field_adoc("DG1", "2", "Diagnosis Coding Method", "",
                                       None, "Withdrawn as of v2.3.")
        self.assertIn("== DG1.2 - Diagnosis Coding Method", content)
        self.assertNotIn("()", content)  # No empty parens for missing type
        self.assertIn("// TODO: Add field definition", content)
        self.assertIn("[segment-comment]", content)
        self.assertIn("Withdrawn as of v2.3.", content)

    def test_generate_field_adoc_no_comment(self):
        content = generate_field_adoc("PID", "1", "Set ID", "SI",
                                       "Identifies the transaction.", None)
        self.assertIn("Identifies the transaction.", content)
        self.assertNotIn("[segment-comment]", content)

    def test_get_data_type_simple(self):
        elem = {"type": [{"code": "SI"}]}
        self.assertEqual(get_data_type(elem), "SI")

    def test_get_data_type_url(self):
        elem = {"type": [{"code": "http://hl7.org/v2/StructureDefinition/ST"}]}
        self.assertEqual(get_data_type(elem), "ST")

    def test_get_data_type_missing(self):
        elem = {}
        self.assertEqual(get_data_type(elem), "")


class TestRoundTrip(unittest.TestCase):
    """Test that backfill -> inject produces no changes on real project files."""

    def test_pid_round_trip_no_changes(self):
        """Inject on PID (just backfilled) should produce zero changes."""
        changes, errors = inject_for_segment("PID", dry_run=True)
        self.assertEqual(len(changes), 0, f"Unexpected changes: {changes}")
        self.assertEqual(len(errors), 0, f"Unexpected errors: {errors}")

    def test_msh_round_trip_no_changes(self):
        """Inject on MSH (just backfilled) should produce zero changes."""
        changes, errors = inject_for_segment("MSH", dry_run=True)
        self.assertEqual(len(changes), 0, f"Unexpected changes: {changes}")
        self.assertEqual(len(errors), 0, f"Unexpected errors: {errors}")

    def test_dg1_round_trip_no_changes(self):
        """DG1 has many withdrawn fields — round-trip should still be clean."""
        changes, errors = inject_for_segment("DG1", dry_run=True)
        self.assertEqual(len(changes), 0, f"Unexpected changes: {changes}")
        self.assertEqual(len(errors), 0, f"Unexpected errors: {errors}")

    def test_hxx_round_trip_no_changes(self):
        """Hxx has zero fields — round-trip should be clean."""
        changes, errors = inject_for_segment("Hxx", dry_run=True)
        self.assertEqual(len(changes), 0, f"Unexpected changes: {changes}")
        self.assertEqual(len(errors), 0, f"Unexpected errors: {errors}")


class TestInjectionEdits(unittest.TestCase):
    """Test that edits to AsciiDoc are detected by inject."""

    def setUp(self):
        """Back up the PID root AsciiDoc file."""
        self.adoc_path = ADOC_DIR / "PID.adoc"
        self.original_content = self.adoc_path.read_text(encoding="utf-8")

    def tearDown(self):
        """Restore the original AsciiDoc file."""
        self.adoc_path.write_text(self.original_content, encoding="utf-8")

    def test_root_definition_edit_detected(self):
        """Editing root [segment-definition] should be detected as a change."""
        content = self.original_content.replace(
            "// TODO: Add segment definition",
            "The PID segment identifies a patient."
        )
        self.adoc_path.write_text(content, encoding="utf-8")

        changes, errors = inject_for_segment("PID", dry_run=True)
        self.assertEqual(len(errors), 0)
        self.assertEqual(len(changes), 1)
        self.assertEqual(changes[0]["element_id"], "PID")
        self.assertEqual(changes[0]["field"], "definition")


if __name__ == "__main__":
    unittest.main()
