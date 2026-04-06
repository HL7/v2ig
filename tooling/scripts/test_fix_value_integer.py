#!/usr/bin/env python3
"""
Test script for fix_value_integer.py

Creates test files with boolean valueInteger values, runs the fix script,
and verifies the corrections.
"""

import json
import os
import tempfile
import shutil
from pathlib import Path
from fix_value_integer import fix_value_integer_bools


def test_fix_function():
    """Test the fix_value_integer_bools function directly."""
    print("Testing fix_value_integer_bools function...")

    # Test case 1: Simple boolean replacement
    test_obj_1 = {
        "valueInteger": True,
        "other": "value"
    }
    result_1, count_1 = fix_value_integer_bools(test_obj_1)
    assert result_1["valueInteger"] == 1, "true should become 1"
    assert count_1 == 1, "Should report 1 replacement"
    print("  ✓ Test 1 passed: true -> 1")

    # Test case 2: False boolean
    test_obj_2 = {
        "valueInteger": False
    }
    result_2, count_2 = fix_value_integer_bools(test_obj_2)
    assert result_2["valueInteger"] == 0, "false should become 0"
    assert count_2 == 1, "Should report 1 replacement"
    print("  ✓ Test 2 passed: false -> 0")

    # Test case 3: Nested structure (realistic FHIR example)
    test_obj_3 = {
        "extension": [
            {
                "url": "http://hl7.org/v2/StructureDefinition/length",
                "extension": [
                    {
                        "url": "min",
                        "valueInteger": True
                    },
                    {
                        "url": "max",
                        "valueInteger": False
                    }
                ]
            }
        ],
        "otherField": {
            "someBoolean": True,  # This should NOT be changed
            "valueInteger": True   # This should be changed
        }
    }
    result_3, count_3 = fix_value_integer_bools(test_obj_3)
    assert result_3["extension"][0]["extension"][0]["valueInteger"] == 1
    assert result_3["extension"][0]["extension"][1]["valueInteger"] == 0
    assert result_3["otherField"]["someBoolean"] is True, "Other booleans should not change"
    assert result_3["otherField"]["valueInteger"] == 1
    assert count_3 == 3, "Should report 3 replacements"
    print("  ✓ Test 3 passed: Nested structure with 3 replacements")

    # Test case 4: Already valid integers
    test_obj_4 = {
        "valueInteger": 0,
        "nested": {
            "valueInteger": 1
        }
    }
    result_4, count_4 = fix_value_integer_bools(test_obj_4)
    assert result_4["valueInteger"] == 0
    assert result_4["nested"]["valueInteger"] == 1
    assert count_4 == 0, "Should report 0 replacements for valid integers"
    print("  ✓ Test 4 passed: Valid integers unchanged")

    # Test case 5: String valueInteger (should not be changed)
    test_obj_5 = {
        "valueInteger": "5"
    }
    result_5, count_5 = fix_value_integer_bools(test_obj_5)
    assert result_5["valueInteger"] == "5", "String should remain string"
    assert count_5 == 0, "Should report 0 replacements"
    print("  ✓ Test 5 passed: String valueInteger unchanged")

    print("\n✓ All function tests passed!\n")


def test_realistic_fhir_structure():
    """Test with a realistic FHIR StructureDefinition structure."""
    print("Testing with realistic FHIR structure...")

    fhir_structure = {
        "resourceType": "StructureDefinition",
        "url": "http://hl7.org/v2/StructureDefinition/TEST",
        "differential": {
            "element": [
                {
                    "id": "TEST.1",
                    "path": "TEST.1",
                    "extension": [
                        {
                            "url": "http://hl7.org/v2/StructureDefinition/length",
                            "extension": [
                                {
                                    "url": "min",
                                    "valueInteger": True  # Should become 1
                                },
                                {
                                    "url": "max",
                                    "valueInteger": 10  # Should stay 10
                                }
                            ]
                        },
                        {
                            "url": "http://hl7.org/v2/StructureDefinition/conformance-length",
                            "extension": [
                                {
                                    "url": "noTruncate",
                                    "valueInteger": False  # Should become 0
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    }

    result, count = fix_value_integer_bools(fhir_structure)

    # Verify the specific changes
    extensions = result["differential"]["element"][0]["extension"]
    assert extensions[0]["extension"][0]["valueInteger"] == 1, "true should become 1"
    assert extensions[0]["extension"][1]["valueInteger"] == 10, "10 should stay 10"
    assert extensions[1]["extension"][0]["valueInteger"] == 0, "false should become 0"
    assert count == 2, "Should report 2 replacements"

    print("  ✓ Realistic FHIR structure test passed!")
    print(f"    - Converted 2 boolean values to integers")
    print(f"    - Preserved existing integer value (10)")
    print()


def main():
    """Run all tests."""
    print("=" * 70)
    print("Testing fix_value_integer.py")
    print("=" * 70)
    print()

    test_fix_function()
    test_realistic_fhir_structure()

    print("=" * 70)
    print("✓ ALL TESTS PASSED!")
    print("=" * 70)


if __name__ == '__main__':
    main()
