# fix_value_integer.py

## Purpose

Fixes a data quality issue in FHIR StructureDefinition JSON files where `valueInteger` fields contain boolean values instead of integers.

## The Problem

FHIR requires `valueInteger` to be an integer type, but some JSON files may have:
- `"valueInteger": true` (should be `"valueInteger": 1`)
- `"valueInteger": false` (should be `"valueInteger": 0`)

This is invalid FHIR and can cause validation errors or issues with FHIR IG Publisher.

## Solution

This script:
1. Recursively scans JSON files in specified directories
2. Properly parses JSON to find `valueInteger` fields with boolean values
3. Replaces `true` with `1` and `false` with `0`
4. Preserves all other boolean values in the JSON (only changes `valueInteger` specifically)
5. Maintains consistent formatting (2-space indentation, trailing newline)

## Usage

```bash
# Run from workspace root
python3 tooling/scripts/fix_value_integer.py
```

The script will scan these directories:
- `input/sourceOfTruth/segment/segments/` (192 files)
- `input/sourceOfTruth/message-structure/message_structures/` (418 files)
- `input/sourceOfTruth/data-type/complex/complex-data-types/` (71 files)
- `input/sourceOfTruth/data-type/primitive/primitives/` (12 files)

## Output

The script provides detailed output:
```
Scanning for boolean valueInteger values in JSON files...

Processing: input/sourceOfTruth/segment/segments
  ✓ Fixed MSH.json: 2 replacement(s)
  ✓ Fixed PID.json: 1 replacement(s)
  Files in directory: 192, Modified: 2, Replacements: 3

Processing: input/sourceOfTruth/message-structure/message_structures
  Files in directory: 418, Modified: 0, Replacements: 0

...

======================================================================
SUMMARY
======================================================================
Total files scanned:     693
Files modified:          2
Total replacements:      3

✓ Successfully fixed 2 file(s)!
```

## Safety Features

- **Proper JSON parsing**: Uses `json.load()` and `json.dump()` - never uses string replacement
- **Targeted changes**: Only modifies values where the key is exactly `"valueInteger"`
- **Preserves other booleans**: Boolean values in other fields remain unchanged
- **Maintains formatting**: Outputs with 2-space indentation and trailing newline
- **Error handling**: Catches and reports JSON parsing errors without crashing
- **Read-only when clean**: If no issues found, no files are modified

## Testing

Two test suites are included:

### Unit Tests
```bash
python3 tooling/scripts/test_fix_value_integer.py
```

Tests the core fixing logic with various edge cases.

### End-to-End Tests
```bash
python3 tooling/scripts/test_fix_value_integer_e2e.py
```

Creates actual test files, processes them, and verifies the results.

## Example

**Before:**
```json
{
  "extension": [
    {
      "url": "http://hl7.org/v2/StructureDefinition/length",
      "extension": [
        {
          "url": "min",
          "valueInteger": true
        },
        {
          "url": "max",
          "valueInteger": false
        }
      ]
    }
  ],
  "someOtherBoolean": true
}
```

**After:**
```json
{
  "extension": [
    {
      "url": "http://hl7.org/v2/StructureDefinition/length",
      "extension": [
        {
          "url": "min",
          "valueInteger": 1
        },
        {
          "url": "max",
          "valueInteger": 0
        }
      ]
    }
  ],
  "someOtherBoolean": true
}
```

Note: `someOtherBoolean` remains `true` - only `valueInteger` fields are modified.

## When to Run

- After bulk updates to JSON files
- Before running FHIR IG Publisher
- When FHIR validation reports invalid integer values
- As part of data quality checks in CI/CD

## Implementation Details

The script uses a recursive traversal algorithm:
1. Traverses all levels of nested JSON structures (dicts and lists)
2. When it finds a key named `valueInteger` with a boolean value:
   - Replaces `True` with `1`
   - Replaces `False` with `0`
   - Increments replacement counter
3. Returns both the modified structure and count of changes

This ensures deep nested structures (common in FHIR) are fully processed.
