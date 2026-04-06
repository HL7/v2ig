#!/usr/bin/env python3
"""Tests for build_registry.py — TASK-011."""

import json
import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from build_registry import (
    build_complex_types,
    build_events,
    build_message_structures,
    build_messages,
    build_primitive_types,
    build_segments,
)

SOURCE_DIR = REPO_ROOT / "input" / "sourceOfTruth"
REGISTRY_FILE = REPO_ROOT / "tooling" / "registry.json"


class TestRegistryCompleteness(unittest.TestCase):
    """Verify registry covers all source resources."""

    @classmethod
    def setUpClass(cls):
        if not REGISTRY_FILE.exists():
            raise unittest.SkipTest("registry.json not generated yet")
        cls.registry = json.loads(REGISTRY_FILE.read_text())["constructs"]

    def _count_json_files(self, *path_parts):
        d = SOURCE_DIR.joinpath(*path_parts)
        if not d.exists():
            return 0
        return len(list(d.glob("*.json")))

    def test_primitive_data_types_complete(self):
        expected = self._count_json_files("data-type", "primitive", "primitives")
        actual = sum(
            1 for v in self.registry.values() if v["type"] == "primitive-data-type"
        )
        self.assertEqual(actual, expected)

    def test_complex_data_types_complete(self):
        expected = self._count_json_files(
            "data-type", "complex", "complex-data-types"
        )
        actual = sum(
            1 for v in self.registry.values() if v["type"] == "complex-data-type"
        )
        self.assertEqual(actual, expected)

    def test_segments_complete(self):
        expected = self._count_json_files("segment", "segments")
        actual = sum(1 for v in self.registry.values() if v["type"] == "segment")
        self.assertEqual(actual, expected)

    def test_messages_present(self):
        expected = self._count_json_files("message", "messages")
        actual = sum(1 for v in self.registry.values() if v["type"] == "message")
        self.assertEqual(actual, expected)

    def test_message_structures_present(self):
        expected = self._count_json_files(
            "message-structure", "message_structures"
        )
        actual = sum(
            1 for v in self.registry.values() if v["type"] == "message-structure"
        )
        self.assertEqual(actual, expected)

    def test_events_present(self):
        """Events count may be less than files due to collisions."""
        file_count = self._count_json_files("event", "events")
        actual = sum(1 for v in self.registry.values() if v["type"] == "event")
        # At least 99% coverage (PCE collision is known)
        self.assertGreaterEqual(actual, file_count - 5)
        self.assertLessEqual(actual, file_count)


class TestRegistryEntryStructure(unittest.TestCase):
    """Verify individual entry format and URLs."""

    @classmethod
    def setUpClass(cls):
        if not REGISTRY_FILE.exists():
            raise unittest.SkipTest("registry.json not generated yet")
        cls.registry = json.loads(REGISTRY_FILE.read_text())["constructs"]

    def test_primitive_type_entry(self):
        entry = self.registry.get("ST")
        self.assertIsNotNone(entry, "ST should be in registry")
        self.assertEqual(entry["type"], "primitive-data-type")
        self.assertEqual(entry["url"], "StructureDefinition-ST.html")

    def test_complex_type_entry(self):
        entry = self.registry.get("CWE")
        self.assertIsNotNone(entry, "CWE should be in registry")
        self.assertEqual(entry["type"], "complex-data-type")
        self.assertEqual(entry["url"], "StructureDefinition-CWE.html")

    def test_data_type_component_entry(self):
        entry = self.registry.get("CWE.1")
        self.assertIsNotNone(entry, "CWE.1 should be in registry")
        self.assertEqual(entry["type"], "data-type-component")
        self.assertEqual(entry["parent"], "CWE")
        self.assertIn("#CWE.1", entry["url"])

    def test_segment_entry(self):
        entry = self.registry.get("PID")
        self.assertIsNotNone(entry, "PID should be in registry")
        self.assertEqual(entry["type"], "segment")
        self.assertEqual(entry["url"], "StructureDefinition-PID.html")

    def test_segment_field_dot_notation(self):
        entry = self.registry.get("PID.3")
        self.assertIsNotNone(entry, "PID.3 should be in registry")
        self.assertEqual(entry["type"], "segment-field")
        self.assertEqual(entry["parent"], "PID")

    def test_segment_field_dash_notation(self):
        entry = self.registry.get("PID-3")
        self.assertIsNotNone(entry, "PID-3 should be in registry")
        self.assertEqual(entry["type"], "segment-field")
        self.assertEqual(entry["parent"], "PID")
        self.assertEqual(entry["url"], self.registry["PID.3"]["url"])

    def test_message_entry(self):
        entry = self.registry.get("ADT^A01")
        self.assertIsNotNone(entry, "ADT^A01 should be in registry")
        self.assertEqual(entry["type"], "message")
        self.assertEqual(entry["url"], "StructureDefinition-ADT-A01.html")

    def test_event_entry(self):
        entry = self.registry.get("A01")
        self.assertIsNotNone(entry, "A01 should be in registry")
        self.assertEqual(entry["type"], "event")
        self.assertEqual(entry["url"], "StructureDefinition-A01.html")

    def test_message_structure_entry(self):
        entry = self.registry.get("ADT_A01-A")
        self.assertIsNotNone(entry, "ADT_A01-A should be in registry")
        self.assertEqual(entry["type"], "message-structure")

    def test_collision_preserves_segment_over_event(self):
        """PCE exists as both segment and event; segment should win."""
        entry = self.registry.get("PCE")
        self.assertIsNotNone(entry, "PCE should be in registry")
        self.assertEqual(entry["type"], "segment")

    def test_all_entries_have_url(self):
        for key, entry in self.registry.items():
            self.assertIn("url", entry, f"{key} missing url")
            self.assertTrue(entry["url"], f"{key} has empty url")

    def test_all_entries_have_type(self):
        for key, entry in self.registry.items():
            self.assertIn("type", entry, f"{key} missing type")


class TestRegistryMetadata(unittest.TestCase):
    """Verify registry top-level metadata."""

    @classmethod
    def setUpClass(cls):
        if not REGISTRY_FILE.exists():
            raise unittest.SkipTest("registry.json not generated yet")
        cls.data = json.loads(REGISTRY_FILE.read_text())

    def test_version_present(self):
        self.assertEqual(self.data["version"], "1.0")

    def test_construct_count_matches(self):
        self.assertEqual(
            self.data["construct_count"], len(self.data["constructs"])
        )

    def test_total_count_reasonable(self):
        """Registry should have thousands of entries."""
        self.assertGreater(self.data["construct_count"], 5000)


class TestBuilderFunctions(unittest.TestCase):
    """Test individual builder functions return expected structure."""

    def test_build_primitive_types_returns_dict(self):
        result = build_primitive_types()
        self.assertIsInstance(result, dict)
        if result:
            entry = next(iter(result.values()))
            self.assertEqual(entry["type"], "primitive-data-type")

    def test_build_complex_types_includes_components(self):
        result = build_complex_types()
        types = {v["type"] for v in result.values()}
        self.assertIn("complex-data-type", types)
        self.assertIn("data-type-component", types)

    def test_build_segments_includes_fields(self):
        result = build_segments()
        types = {v["type"] for v in result.values()}
        self.assertIn("segment", types)
        self.assertIn("segment-field", types)

    def test_build_segments_dual_field_format(self):
        """Fields should be registered in both PID.3 and PID-3 formats."""
        result = build_segments()
        # Find any field entry
        dot_keys = [k for k in result if "." in k and result[k]["type"] == "segment-field"]
        if dot_keys:
            # e.g. PID.3 -> PID-3
            sample = dot_keys[0]
            dash_key = sample.replace(".", "-", 1)
            self.assertIn(dash_key, result, f"{dash_key} should exist for {sample}")

    def test_build_messages_uses_caret(self):
        result = build_messages()
        if result:
            key = next(iter(result))
            self.assertIn("^", key, "Message keys should use ^ separator")


if __name__ == "__main__":
    unittest.main()
