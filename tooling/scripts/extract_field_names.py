#!/usr/bin/env python3
"""
Extract field names from segment StructureDefinition JSON files.
Check where field names appear (definition, comment, or elsewhere).
"""

import json
import re
import sys
from pathlib import Path

def extract_field_name_from_text(text, field_id):
    """
    Try to extract field name from definition or comment text.
    Common patterns:
    - "MSH-1 Field Name" at start
    - "field name" in lowercase
    - "This field contains..."
    """
    if not text:
        return None

    # Pattern 1: "PID-3 - Field Name" or "MSH-2 Field Name"
    pattern1 = rf'{re.escape(field_id)}\s*[-–]\s*([A-Z][A-Za-z\s/(),]+?)(?:\.|:|\n|$)'
    match = re.search(pattern1, text)
    if match:
        name = match.group(1).strip()
        # Clean up common endings
        name = re.sub(r'\s+(for all patient identifiers|etc)$', '', name)
        return name

    # Pattern 2: References like "_PID-3 - Field Name_" in italic
    pattern2 = rf'_\s*{re.escape(field_id)}\s*[-–]\s*([A-Z][A-Za-z\s/(),]+?)_'
    match = re.search(pattern2, text)
    if match:
        return match.group(1).strip()

    return None

def analyze_segment(filepath):
    """Analyze a single segment JSON file."""
    with open(filepath) as f:
        data = json.load(f)

    segment_id = data['id']
    results = []

    for element in data['differential']['element']:
        path = element['path']
        if not path.startswith(f'{segment_id}.') or path == segment_id:
            continue

        suffix = path.split('.')[1]
        field_num = suffix.split('-', 1)[0]  # Handle OBX.1-setId format
        field_id = f"{segment_id}-{field_num}"

        definition = element.get('definition', '')
        comment = element.get('comment', '')

        # Try to extract field name
        name = extract_field_name_from_text(comment, field_id)
        if not name:
            name = extract_field_name_from_text(definition, field_id)

        results.append({
            'path': path,
            'field_id': field_id,
            'extracted_name': name,
            'has_definition': bool(definition),
            'has_comment': bool(comment),
            'definition_preview': definition[:100] if definition else '',
            'comment_preview': comment[:100] if comment else ''
        })

    return segment_id, results

if __name__ == '__main__':
    # Test with MSH and PID
    segments_dir = Path('/workspace/input/sourceOfTruth/segment/segments')

    for seg_file in ['MSH.json', 'PID.json', 'OBX.json', 'EVN.json']:
        filepath = segments_dir / seg_file
        if not filepath.exists():
            continue

        segment_id, fields = analyze_segment(filepath)
        print(f"\n{'='*80}")
        print(f"Segment: {segment_id}")
        print(f"{'='*80}")

        for field in fields[:10]:  # Show first 10 fields
            print(f"\n{field['field_id']}: {field['extracted_name'] or 'NOT FOUND'}")
            if field['definition_preview']:
                print(f"  Definition: {field['definition_preview']}")
            if field['comment_preview']:
                print(f"  Comment: {field['comment_preview']}")
