#!/usr/bin/env python3
"""
End-to-end test for fix_value_integer.py

Creates actual JSON files with issues, runs the script, and verifies fixes.
"""

import json
import os
import tempfile
import shutil
from pathlib import Path
from fix_value_integer import process_json_file


def test_end_to_end():
    """Create test files, process them, and verify results."""
    print("Running end-to-end test...\n")

    # Create a temporary directory
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_path = Path(temp_dir)

        # Test file 1: Has boolean valueInteger values
        test_file_1 = temp_path / "test1.json"
        data_1 = {
            "resourceType": "StructureDefinition",
            "extension": [
                {
                    "url": "length",
                    "extension": [
                        {"url": "min", "valueInteger": True},
                        {"url": "max", "valueInteger": False}
                    ]
                }
            ],
            "otherBoolean": True  # Should not be changed
        }
        with open(test_file_1, 'w') as f:
            json.dump(data_1, f, indent=2)

        # Test file 2: Already valid (no changes needed)
        test_file_2 = temp_path / "test2.json"
        data_2 = {
            "resourceType": "StructureDefinition",
            "extension": [
                {
                    "url": "length",
                    "extension": [
                        {"url": "min", "valueInteger": 1},
                        {"url": "max", "valueInteger": 0}
                    ]
                }
            ]
        }
        with open(test_file_2, 'w') as f:
            json.dump(data_2, f, indent=2)

        # Test file 3: Multiple boolean valueInteger values
        test_file_3 = temp_path / "test3.json"
        data_3 = {
            "differential": {
                "element": [
                    {
                        "extension": [
                            {"url": "a", "valueInteger": False},
                            {"url": "b", "valueInteger": True},
                            {"url": "c", "valueInteger": False}
                        ]
                    }
                ]
            }
        }
        with open(test_file_3, 'w') as f:
            json.dump(data_3, f, indent=2)

        print("Created test files:")
        print(f"  {test_file_1.name} - 2 boolean valueInteger values")
        print(f"  {test_file_2.name} - Already valid")
        print(f"  {test_file_3.name} - 3 boolean valueInteger values\n")

        # Process the files
        print("Processing files...")
        modified_1, count_1 = process_json_file(test_file_1)
        modified_2, count_2 = process_json_file(test_file_2)
        modified_3, count_3 = process_json_file(test_file_3)

        # Verify results
        print("\nVerifying results...")

        # File 1 should be modified
        assert modified_1, "test1.json should be modified"
        assert count_1 == 2, f"test1.json should have 2 replacements, got {count_1}"
        with open(test_file_1) as f:
            fixed_1 = json.load(f)
        assert fixed_1["extension"][0]["extension"][0]["valueInteger"] == 1
        assert fixed_1["extension"][0]["extension"][1]["valueInteger"] == 0
        assert fixed_1["otherBoolean"] is True, "Other booleans should not change"
        print(f"  ✓ {test_file_1.name}: Modified correctly (2 replacements)")

        # File 2 should not be modified
        assert not modified_2, "test2.json should not be modified"
        assert count_2 == 0, f"test2.json should have 0 replacements, got {count_2}"
        print(f"  ✓ {test_file_2.name}: Correctly left unchanged")

        # File 3 should be modified
        assert modified_3, "test3.json should be modified"
        assert count_3 == 3, f"test3.json should have 3 replacements, got {count_3}"
        with open(test_file_3) as f:
            fixed_3 = json.load(f)
        assert fixed_3["differential"]["element"][0]["extension"][0]["valueInteger"] == 0
        assert fixed_3["differential"]["element"][0]["extension"][1]["valueInteger"] == 1
        assert fixed_3["differential"]["element"][0]["extension"][2]["valueInteger"] == 0
        print(f"  ✓ {test_file_3.name}: Modified correctly (3 replacements)")

        # Verify file formatting (should have 2-space indent and trailing newline)
        with open(test_file_1, 'r') as f:
            content_1 = f.read()
        assert content_1.endswith('\n'), "File should have trailing newline"
        assert '  "resourceType"' in content_1, "Should use 2-space indentation"
        print(f"  ✓ File formatting preserved (2-space indent, trailing newline)")

    print("\n✓ End-to-end test passed!")


if __name__ == '__main__':
    print("=" * 70)
    print("End-to-End Test for fix_value_integer.py")
    print("=" * 70)
    print()
    test_end_to_end()
    print()
    print("=" * 70)
    print("✓ ALL E2E TESTS PASSED!")
    print("=" * 70)
