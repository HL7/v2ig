#!/usr/bin/env python3
"""Tests for the inject_definitions.py script."""

import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

# Add tooling/scripts to path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tooling" / "scripts"))

from inject_definitions import (
    extract_datatype_definition,
    parse_adoc_front_matter,
    find_element_by_id,
)


class TestExtractDatatypeDefinition(unittest.TestCase):
    """Test [datatype-definition] block extraction from AsciiDoc."""

    def _write_adoc(self, content):
        """Write content to a temporary .adoc file and return the path."""
        f = tempfile.NamedTemporaryFile(
            mode="w", suffix=".adoc", delete=False, encoding="utf-8"
        )
        f.write(content)
        f.close()
        self.addCleanup(os.unlink, f.name)
        return Path(f.name)

    def test_simple_definition(self):
        path = self._write_adoc(
            "== EI.1 - Entity Identifier (ST)\n"
            "\n"
            "[datatype-definition]\n"
            "The first component is the entity identifier.\n"
        )
        result = extract_datatype_definition(path)
        self.assertEqual(result, "The first component is the entity identifier.")

    def test_multiline_definition(self):
        path = self._write_adoc(
            "= (CWE) Data Type - coded with exceptions\n"
            ":code: CWE\n"
            "\n"
            "Some introductory text.\n"
            "\n"
            "[datatype-definition]\n"
            "First paragraph of definition.\n"
            "\n"
            "Second paragraph with more detail.\n"
        )
        result = extract_datatype_definition(path)
        self.assertIn("First paragraph", result)
        self.assertIn("Second paragraph", result)

    def test_definition_stops_at_section_heading(self):
        path = self._write_adoc(
            "[datatype-definition]\n"
            "This is the definition.\n"
            "\n"
            "== Next Section\n"
            "This should not be included.\n"
        )
        result = extract_datatype_definition(path)
        self.assertEqual(result, "This is the definition.")

    def test_definition_stops_at_include(self):
        path = self._write_adoc(
            "[datatype-definition]\n"
            "The entity identifier.\n"
            "\n"
            "More detail here.\n"
            "\n"
            "include::EI-components/EI-1.adoc[]\n"
        )
        result = extract_datatype_definition(path)
        self.assertIn("The entity identifier.", result)
        self.assertIn("More detail here.", result)
        self.assertNotIn("include::", result)

    def test_no_definition_block(self):
        path = self._write_adoc(
            "== Some Section\n"
            "\n"
            "Just regular content, no definition block.\n"
        )
        result = extract_datatype_definition(path)
        self.assertIsNone(result)

    def test_definition_with_table(self):
        path = self._write_adoc(
            "[datatype-definition]\n"
            "Definition text.\n"
            "\n"
            '.Table title\n'
            '[width="100%",cols="50%,50%",options="header"]\n'
            "|===\n"
            "|Col1 |Col2\n"
            "|A |B\n"
            "|===\n"
            "\n"
            "After table text.\n"
        )
        result = extract_datatype_definition(path)
        self.assertIn("Definition text.", result)
        self.assertIn("|===", result)
        self.assertIn("After table text.", result)

    def test_nonexistent_file(self):
        result = extract_datatype_definition(Path("/nonexistent/file.adoc"))
        self.assertIsNone(result)

    def test_definition_with_v2_table_placeholder(self):
        path = self._write_adoc(
            "[datatype-definition]\n"
            "Refer to {{v2-table:0127:Allergen Type}} for values.\n"
        )
        result = extract_datatype_definition(path)
        self.assertIn("{{v2-table:0127:Allergen Type}}", result)


class TestParseFrontMatter(unittest.TestCase):
    """Test front matter attribute extraction."""

    def _write_adoc(self, content):
        f = tempfile.NamedTemporaryFile(
            mode="w", suffix=".adoc", delete=False, encoding="utf-8"
        )
        f.write(content)
        f.close()
        self.addCleanup(os.unlink, f.name)
        return Path(f.name)

    def test_standard_front_matter(self):
        path = self._write_adoc(
            "= (EI) Data Type - entity identifier\n"
            ":v291_section: 2A.2.25\n"
            ":v2type: 'Data Type'\n"
            ":code: EI\n"
            ":name: entity identifier\n"
            ":primitive: false\n"
            "\n"
            "Content here.\n"
        )
        attrs = parse_adoc_front_matter(path)
        self.assertEqual(attrs["code"], "EI")
        self.assertEqual(attrs["name"], "entity identifier")
        self.assertEqual(attrs["primitive"], "false")

    def test_no_front_matter(self):
        path = self._write_adoc(
            "== Component Section\n"
            "\n"
            "Just content.\n"
        )
        attrs = parse_adoc_front_matter(path)
        self.assertEqual(attrs, {})


class TestFindElementById(unittest.TestCase):
    """Test element lookup in StructureDefinition."""

    def test_find_root(self):
        elements = [
            {"id": "CWE", "path": "CWE", "short": "coded with exceptions"},
            {"id": "CWE.1", "path": "CWE.1", "short": "Identifier"},
        ]
        elem = find_element_by_id(elements, "CWE")
        self.assertIsNotNone(elem)
        self.assertEqual(elem["short"], "coded with exceptions")

    def test_find_component(self):
        elements = [
            {"id": "CWE", "path": "CWE"},
            {"id": "CWE.1", "path": "CWE.1", "short": "Identifier"},
            {"id": "CWE.2", "path": "CWE.2", "short": "Text"},
        ]
        elem = find_element_by_id(elements, "CWE.2")
        self.assertIsNotNone(elem)
        self.assertEqual(elem["short"], "Text")

    def test_not_found(self):
        elements = [{"id": "CWE", "path": "CWE"}]
        elem = find_element_by_id(elements, "NONEXISTENT")
        self.assertIsNone(elem)


class TestEndToEnd(unittest.TestCase):
    """Integration tests using real project files."""

    def test_ei_definition_extraction(self):
        """Verify EI.adoc definition extraction matches expected content."""
        adoc_path = Path(__file__).resolve().parent.parent / "website" / "data_structures" / "data_types" / "complex" / "EI.adoc"
        if not adoc_path.exists():
            self.skipTest("EI.adoc not found")

        defn = extract_datatype_definition(adoc_path)
        self.assertIsNotNone(defn)
        self.assertIn("entity identifier", defn.lower())

    def test_ei_component_definition_extraction(self):
        """Verify EI-1.adoc component definition extraction."""
        adoc_path = Path(__file__).resolve().parent.parent / "website" / "data_structures" / "data_types" / "complex" / "EI-components" / "EI-1.adoc"
        if not adoc_path.exists():
            self.skipTest("EI-1.adoc not found")

        defn = extract_datatype_definition(adoc_path)
        self.assertIsNotNone(defn)
        self.assertIn("entity identifier", defn.lower())

    def test_ei_json_has_matching_elements(self):
        """Verify EI.json has elements matching EI component files."""
        json_path = Path(__file__).resolve().parent.parent / "input" / "sourceOfTruth" / "data-type" / "complex" / "complex-data-types" / "ei.json"
        if not json_path.exists():
            self.skipTest("ei.json not found")

        sd = json.loads(json_path.read_text())
        elements = sd["differential"]["element"]

        # Root element
        root = find_element_by_id(elements, "EI")
        self.assertIsNotNone(root)
        self.assertIn("definition", root)

        # Components (EI has 4)
        for i in range(1, 5):
            comp = find_element_by_id(elements, f"EI.{i}")
            self.assertIsNotNone(comp, f"Missing element EI.{i}")
            # Component definitions use the "defintion" typo
            self.assertTrue(
                "defintion" in comp or "definition" in comp,
                f"EI.{i} has no definition field"
            )

    def test_cwe_front_matter(self):
        """Verify CWE.adoc front matter parsing."""
        adoc_path = Path(__file__).resolve().parent.parent / "website" / "data_structures" / "data_types" / "complex" / "CWE.adoc"
        if not adoc_path.exists():
            self.skipTest("CWE.adoc not found")

        attrs = parse_adoc_front_matter(adoc_path)
        self.assertEqual(attrs.get("code"), "CWE")
        self.assertEqual(attrs.get("primitive"), "false")


if __name__ == "__main__":
    unittest.main()
