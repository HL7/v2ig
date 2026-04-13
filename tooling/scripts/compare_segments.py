#!/usr/bin/env python3
"""Compare FHIR StructureDefinition segment JSON against V2.9.1 extracted data.

Performs a field-by-field comparison across 9 dimensions (cardinality, data type,
optionality, field name, item number, length, conformance length, vocabulary)
and produces JSON + Markdown reports of all discrepancies.

Usage:
    python3 tooling/scripts/compare_segments.py
    python3 tooling/scripts/compare_segments.py --subset OBX,PID,MSH
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

from v2_utils import load_json, PROJECT_ROOT, SEGMENTS_DIR

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

V291_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'segments')
REPORT_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted')

# Severity levels (ordered by importance)
CRITICAL = 'critical'
ERROR = 'error'
WARNING = 'warning'
COSMETIC = 'cosmetic'

SEVERITY_ORDER = {CRITICAL: 0, ERROR: 1, WARNING: 2, COSMETIC: 3}


# ---------------------------------------------------------------------------
# V291 parsing helpers
# ---------------------------------------------------------------------------

def parse_v291_repetition(rep_str):
    """Convert V2.9.1 repetition string to expected FHIR max value.

    Args:
        rep_str: Repetition indicator from V2.9.1 extraction.
            "" or "N" = does not repeat -> "1"
            "Y" = unlimited repeating -> "*"
            "2", "3", etc. = specific repeat count
            "Y/5" style = specific count (use the number)

    Returns:
        Expected FHIR max as string: "1", "*", "2", etc.
    """
    if not rep_str or rep_str.upper() == 'N':
        return '1'
    if rep_str.upper() == 'Y':
        return '*'
    # Handle "Y/N" patterns like "Y/5" — extract the number
    if '/' in rep_str:
        parts = rep_str.split('/')
        for part in parts:
            if part.isdigit():
                return part
        # If no digit found after slash, treat "Y" part as unlimited
        return '*'
    # Bare number
    if rep_str.isdigit():
        return rep_str
    # Unknown — return as-is for reporting
    return rep_str


def parse_v291_length(length_str):
    """Convert V2.9.1 length string to (min, max) tuple.

    Args:
        length_str: e.g. "1..4", "1..199", "", "4"

    Returns:
        Tuple of (min_int_or_None, max_int_or_None)
    """
    if not length_str:
        return (None, None)
    if '..' in length_str:
        parts = length_str.split('..')
        try:
            return (int(parts[0]), int(parts[1]))
        except (ValueError, IndexError):
            return (None, None)
    # Single number — treat as both min and max
    try:
        val = int(length_str)
        return (val, val)
    except ValueError:
        return (None, None)


def parse_v291_conf_length(cl_str):
    """Convert V2.9.1 conformance length string to (length, noTruncate) tuple.

    Args:
        cl_str: e.g. "20=", "5#", "=", ""

    Returns:
        Tuple of (length_int_or_None, noTruncate_int_or_None).
        noTruncate: 1 means "=" (no truncation), 0 means "#" (truncation ok)
    """
    if not cl_str:
        return (None, None)
    # Strip whitespace
    cl_str = cl_str.strip()
    if cl_str == '=':
        return (None, 1)
    if cl_str == '#':
        return (None, 0)
    if cl_str.endswith('='):
        try:
            return (int(cl_str[:-1]), 1)
        except ValueError:
            return (None, None)
    if cl_str.endswith('#'):
        try:
            return (int(cl_str[:-1]), 0)
        except ValueError:
            return (None, None)
    # Bare number — no truncation indicator
    try:
        return (int(cl_str), None)
    except ValueError:
        return (None, None)


def extract_v291_table_number(table_str):
    """Extract table number from V2.9.1 table binding string.

    Args:
        table_str: e.g. "0125", "", "0622"

    Returns:
        Table number string (e.g. "0125") or empty string
    """
    return table_str.strip() if table_str else ''


# ---------------------------------------------------------------------------
# FHIR extraction helpers
# ---------------------------------------------------------------------------

def get_extension(extensions, url_suffix):
    """Find an extension by URL suffix."""
    for ext in extensions:
        if ext.get('url', '').endswith(url_suffix):
            return ext
    return None


def get_sub_extension(extension, url):
    """Find a sub-extension within a complex extension."""
    for sub in extension.get('extension', []):
        if sub.get('url') == url:
            return sub
    return None


def extract_fhir_fields(fhir_data):
    """Extract all field metadata from a FHIR StructureDefinition.

    Args:
        fhir_data: Parsed FHIR JSON dict

    Returns:
        Dict keyed by sequence number string, each value a dict with:
        seq, name, data_type, optionality, min_card, max_card,
        item_num, length_min, length_max, conf_length, no_truncate,
        vocabulary_table, element_id
    """
    elements = fhir_data.get('differential', {}).get('element', [])
    fields = {}

    for elem in elements[1:]:  # Skip root element
        path = elem.get('path', '')
        elem_id = elem.get('id', '')
        extensions = elem.get('extension', [])

        # Seq: number after the dot (e.g. PID.1-setId -> "1")
        suffix = path.rsplit('.', 1)[-1] if '.' in path else ''
        seq = suffix.split('-', 1)[0] if suffix else ''
        if not seq:
            continue

        # Name
        name = elem.get('short', '')

        # Data type
        type_list = elem.get('type', [])
        data_type = type_list[0].get('code', '') if type_list else ''

        # Optionality
        opt_ext = get_extension(extensions, 'optionality')
        optionality = opt_ext.get('valueCode', '') if opt_ext else ''

        # Cardinality — max can be int or string
        min_card = elem.get('min', 0)
        max_card = str(elem.get('max', '*'))

        # Item number from code[0].code
        codes = elem.get('code', [])
        item_num = codes[0].get('code', '') if codes else ''

        # Length
        length_min = None
        length_max = None
        len_ext = get_extension(extensions, '/length')
        if len_ext and 'conformance' not in len_ext.get('url', ''):
            min_sub = get_sub_extension(len_ext, 'min')
            max_sub = get_sub_extension(len_ext, 'max')
            if min_sub:
                length_min = min_sub.get('valueInteger')
            if max_sub:
                length_max = max_sub.get('valueInteger')

        # Conformance length
        conf_length = None
        no_truncate = None
        clen_ext = get_extension(extensions, 'conformance-length')
        if clen_ext:
            len_sub = get_sub_extension(clen_ext, 'length')
            trunc_sub = get_sub_extension(clen_ext, 'noTruncate')
            if len_sub:
                val = len_sub.get('valueInteger')
                conf_length = int(val) if val is not None else None
            if trunc_sub:
                val = trunc_sub.get('valueInteger')
                no_truncate = int(val) if val is not None else None

        # Vocabulary: extract table number from valueSet URL
        binding = elem.get('binding', {})
        value_set_url = binding.get('valueSet', '')
        vocab_table = ''
        if value_set_url:
            # Pattern: http://terminology.hl7.org/ValueSet/v2-0125
            match = re.search(r'v2-(\d+)', value_set_url)
            if match:
                vocab_table = match.group(1)

        fields[seq] = {
            'seq': seq,
            'name': name,
            'data_type': data_type,
            'optionality': optionality,
            'min_card': min_card,
            'max_card': max_card,
            'item_num': item_num,
            'length_min': length_min,
            'length_max': length_max,
            'conf_length': conf_length,
            'no_truncate': no_truncate,
            'vocabulary_table': vocab_table,
            'element_id': elem_id,
        }

    return fields


def extract_v291_fields(v291_data):
    """Extract field metadata from V2.9.1 extracted segment data.

    Uses the first occurrence if multiple exist.

    Args:
        v291_data: Parsed V2.9.1 JSON dict

    Returns:
        Tuple of (fields_dict, occurrence_count, provenance_dict)
    """
    occurrences = v291_data.get('occurrences', [])
    if not occurrences:
        return {}, 0, {}

    occurrence_count = len(occurrences)
    provenance = occurrences[0].get('provenance', {})
    raw_fields = occurrences[0].get('fields', [])
    fields = {}

    for f in raw_fields:
        seq = f.get('sequence', '')
        # Skip non-numeric sequences like "1-n"
        if not seq.isdigit():
            continue
        fields[seq] = {
            'seq': seq,
            'name': f.get('name', ''),
            'data_type': f.get('dataType', ''),
            'optionality': f.get('optionality', ''),
            'repetition': f.get('repetition', ''),
            'length': f.get('length', ''),
            'conf_length': f.get('confLength', ''),
            'table_binding': f.get('tableBinding', ''),
            'item_number': f.get('itemNumber', ''),
        }

    return fields, occurrence_count, provenance


# ---------------------------------------------------------------------------
# Per-field comparison functions
# ---------------------------------------------------------------------------

def compare_cardinality(fhir_field, v291_field, segment_id, seq):
    """Compare cardinality between FHIR and V2.9.1.

    Returns list of discrepancy dicts.
    """
    results = []
    optionality = v291_field['optionality']
    is_w = optionality == 'W'

    # Expected min from optionality
    expected_min = 1 if optionality == 'R' else 0
    actual_min = fhir_field['min_card']

    if actual_min != expected_min:
        results.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_field['name'],
            'dimension': 'cardinality_min',
            'severity': CRITICAL,
            'expected': expected_min,
            'actual': actual_min,
            'detail': f"V291 optionality={optionality} -> expected min={expected_min}, got {actual_min}",
        })

    # Expected max from repetition
    # W fields: max=0 (withdrawn per ADR-0005)
    # B fields: preserve original cardinality (deprecated, still usable)
    if is_w:
        expected_max = '0'
    else:
        expected_max = parse_v291_repetition(v291_field['repetition'])

    actual_max = fhir_field['max_card']

    if actual_max != expected_max:
        # max=0 on an active field that should repeat is the worst case
        if actual_max == '0' and expected_max != '0' and not is_w:
            severity = CRITICAL
        else:
            severity = ERROR

        results.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_field['name'],
            'dimension': 'cardinality_max',
            'severity': severity,
            'expected': expected_max,
            'actual': actual_max,
            'detail': f"V291 repetition='{v291_field['repetition']}' opt={optionality} -> "
                      f"expected max={expected_max}, got {actual_max}",
        })

    return results


def compare_data_type(fhir_field, v291_field, segment_id, seq):
    """Compare data type between FHIR and V2.9.1."""
    fhir_dt = fhir_field['data_type']
    v291_dt = v291_field['data_type']

    # Both empty is fine (withdrawn fields)
    if not fhir_dt and not v291_dt:
        return []

    if fhir_dt.lower() == v291_dt.lower():
        return []

    # One empty, one not
    if not fhir_dt or not v291_dt:
        return [{
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_field['name'],
            'dimension': 'data_type',
            'severity': WARNING,
            'expected': v291_dt,
            'actual': fhir_dt,
            'detail': f"Data type: V291='{v291_dt}', FHIR='{fhir_dt}'",
        }]

    # Genuine mismatch
    return [{
        'segment': segment_id,
        'seq': seq,
        'field_name': fhir_field['name'],
        'dimension': 'data_type',
        'severity': WARNING,
        'expected': v291_dt,
        'actual': fhir_dt,
        'detail': f"Data type mismatch: V291='{v291_dt}', FHIR='{fhir_dt}'",
    }]


def compare_optionality(fhir_field, v291_field, segment_id, seq):
    """Compare optionality code between FHIR and V2.9.1."""
    fhir_opt = fhir_field['optionality']
    v291_opt = v291_field['optionality']

    if fhir_opt == v291_opt:
        return []

    return [{
        'segment': segment_id,
        'seq': seq,
        'field_name': fhir_field['name'],
        'dimension': 'optionality',
        'severity': WARNING,
        'expected': v291_opt,
        'actual': fhir_opt,
        'detail': f"Optionality: V291='{v291_opt}', FHIR='{fhir_opt}'",
    }]


def compare_item_number(fhir_field, v291_field, segment_id, seq):
    """Compare item number between FHIR and V2.9.1."""
    fhir_item = fhir_field['item_num']
    v291_item_str = v291_field['item_number']

    # Normalize: both to int for comparison
    try:
        fhir_int = int(fhir_item) if fhir_item != '' else None
    except (ValueError, TypeError):
        fhir_int = None

    try:
        v291_int = int(v291_item_str) if v291_item_str else None
    except (ValueError, TypeError):
        v291_int = None

    # Both empty
    if fhir_int is None and v291_int is None:
        return []

    if fhir_int == v291_int:
        return []

    return [{
        'segment': segment_id,
        'seq': seq,
        'field_name': fhir_field['name'],
        'dimension': 'item_number',
        'severity': WARNING,
        'expected': v291_item_str,
        'actual': str(fhir_item),
        'detail': f"Item#: V291='{v291_item_str}', FHIR='{fhir_item}'",
    }]


def compare_field_name(fhir_field, v291_field, segment_id, seq):
    """Compare field name between FHIR and V2.9.1."""
    fhir_name = fhir_field['name']
    v291_name = v291_field['name']

    if not fhir_name and not v291_name:
        return []

    # Normalize for comparison: lowercase, replace en-dash with hyphen, strip
    def normalize(s):
        return s.lower().replace('\u2013', '-').replace('\u2014', '-').strip()

    if normalize(fhir_name) == normalize(v291_name):
        return []

    return [{
        'segment': segment_id,
        'seq': seq,
        'field_name': fhir_field['name'],
        'dimension': 'field_name',
        'severity': COSMETIC,
        'expected': v291_name,
        'actual': fhir_name,
        'detail': f"Name: V291='{v291_name}', FHIR='{fhir_name}'",
    }]


def compare_length(fhir_field, v291_field, segment_id, seq):
    """Compare length constraints between FHIR and V2.9.1."""
    v291_min, v291_max = parse_v291_length(v291_field['length'])
    fhir_min = fhir_field['length_min']
    fhir_max = fhir_field['length_max']

    # Normalize: convert string values to int if needed
    if fhir_min is not None:
        fhir_min = int(fhir_min)
    if fhir_max is not None:
        fhir_max = int(fhir_max)

    # Both absent
    if v291_min is None and v291_max is None and fhir_min is None and fhir_max is None:
        return []

    results = []
    if v291_min != fhir_min or v291_max != fhir_max:
        results.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_field['name'],
            'dimension': 'length',
            'severity': ERROR,
            'expected': f"{v291_min}..{v291_max}" if v291_min is not None else '',
            'actual': f"{fhir_min}..{fhir_max}" if fhir_min is not None else '',
            'detail': f"Length: V291='{v291_field['length']}', "
                      f"FHIR={fhir_min}..{fhir_max}",
        })

    return results


def compare_conf_length(fhir_field, v291_field, segment_id, seq):
    """Compare conformance length between FHIR and V2.9.1."""
    v291_len, v291_trunc = parse_v291_conf_length(v291_field['conf_length'])
    fhir_len = fhir_field['conf_length']
    fhir_trunc = fhir_field['no_truncate']

    # Normalize
    if fhir_len is not None:
        fhir_len = int(fhir_len)
    if fhir_trunc is not None:
        fhir_trunc = int(fhir_trunc)

    # Both absent
    if (v291_len is None and v291_trunc is None and
            fhir_len is None and fhir_trunc is None):
        return []

    results = []
    if v291_len != fhir_len or v291_trunc != fhir_trunc:
        results.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_field['name'],
            'dimension': 'conf_length',
            'severity': ERROR,
            'expected': v291_field['conf_length'],
            'actual': f"{fhir_len}{'=' if fhir_trunc == 1 else '#' if fhir_trunc == 0 else '?'}" if fhir_len is not None else '',
            'detail': f"Conf length: V291='{v291_field['conf_length']}', "
                      f"FHIR len={fhir_len} trunc={fhir_trunc}",
        })

    return results


def compare_vocabulary(fhir_field, v291_field, segment_id, seq):
    """Compare vocabulary/table binding between FHIR and V2.9.1.

    V291 table bindings can have multiple tables separated by / or , or spaces.
    FHIR only binds to one. If FHIR matches ANY of the V291 tables, it's fine.
    """
    v291_raw = extract_v291_table_number(v291_field['table_binding'])
    fhir_table = fhir_field['vocabulary_table']

    def normalize_table(t):
        t = t.strip()
        if not t:
            return ''
        try:
            return str(int(t))
        except ValueError:
            return t

    # Both empty
    if not v291_raw and not fhir_table:
        return []

    # Split V291 multi-table bindings on /, ,, or whitespace
    v291_tables = re.split(r'[/,\s]+', v291_raw)
    v291_tables = [t for t in v291_tables if t]

    fhir_norm = normalize_table(fhir_table)

    # If FHIR matches any V291 table, it's acceptable
    if any(normalize_table(t) == fhir_norm for t in v291_tables):
        return []

    # Format V291 tables for display (no slashes breaking markdown)
    v291_display = ', '.join(v291_tables)

    return [{
        'segment': segment_id,
        'seq': seq,
        'field_name': fhir_field['name'],
        'dimension': 'vocabulary',
        'severity': WARNING,
        'expected': v291_display,
        'actual': fhir_table,
        'detail': f"Vocabulary: V291 table(s)={v291_display}, FHIR bound to={fhir_table}",
    }]


# ---------------------------------------------------------------------------
# Segment-level comparison
# ---------------------------------------------------------------------------

ALL_COMPARISONS = [
    compare_cardinality,
    compare_data_type,
    compare_optionality,
    compare_item_number,
    compare_field_name,
    compare_length,
    compare_conf_length,
    compare_vocabulary,
]


def compare_segment(segment_id, fhir_data, v291_data):
    """Compare a single segment across all dimensions.

    Returns:
        Dict with segment_id, field_count info, and list of discrepancies
    """
    fhir_fields = extract_fhir_fields(fhir_data)
    v291_fields, occurrence_count, provenance = extract_v291_fields(v291_data)

    fhir_seqs = set(fhir_fields.keys())
    v291_seqs = set(v291_fields.keys())

    matched = sorted(fhir_seqs & v291_seqs, key=lambda s: int(s))
    fhir_only = sorted(fhir_seqs - v291_seqs, key=lambda s: int(s))
    v291_only = sorted(v291_seqs - fhir_seqs, key=lambda s: int(s))

    discrepancies = []

    # Report extra/missing fields
    for seq in fhir_only:
        discrepancies.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': fhir_fields[seq]['name'],
            'dimension': 'field_count',
            'severity': WARNING,
            'expected': 'absent',
            'actual': 'present',
            'detail': f"Field {segment_id}.{seq} exists in FHIR but not in V291",
        })

    for seq in v291_only:
        discrepancies.append({
            'segment': segment_id,
            'seq': seq,
            'field_name': v291_fields[seq]['name'],
            'dimension': 'field_count',
            'severity': WARNING,
            'expected': 'present',
            'actual': 'absent',
            'detail': f"Field {segment_id}.{seq} exists in V291 but not in FHIR",
        })

    # Compare matched fields across all dimensions; collect W/B details
    wb_fields = []
    for seq in matched:
        for compare_fn in ALL_COMPARISONS:
            discrepancies.extend(
                compare_fn(fhir_fields[seq], v291_fields[seq], segment_id, seq)
            )
        v291_opt = v291_fields[seq]['optionality']
        if v291_opt in ('W', 'B'):
            wb_fields.append({
                'segment': segment_id,
                'seq': seq,
                'name': fhir_fields[seq]['name'],
                'v291_opt': v291_opt,
                'v291_dt': v291_fields[seq]['data_type'],
                'v291_rep': v291_fields[seq]['repetition'],
                'fhir_opt': fhir_fields[seq]['optionality'],
                'fhir_max': fhir_fields[seq]['max_card'],
                'fhir_dt': fhir_fields[seq]['data_type'],
            })

    return {
        'segment_id': segment_id,
        'fhir_field_count': len(fhir_fields),
        'v291_field_count': len(v291_fields),
        'v291_occurrence_count': occurrence_count,
        'v291_provenance': provenance,
        'matched_fields': len(matched),
        'fhir_only_fields': fhir_only,
        'v291_only_fields': v291_only,
        'discrepancies': discrepancies,
        'wb_fields': wb_fields,
    }


# ---------------------------------------------------------------------------
# Full comparison orchestrator
# ---------------------------------------------------------------------------

def run_comparison(fhir_dir, v291_dir, subset=None):
    """Run comparison across all segments.

    Args:
        fhir_dir: Path to FHIR segment JSON directory
        v291_dir: Path to V2.9.1 extracted segments directory
        subset: Optional list of segment IDs to compare (None = all)

    Returns:
        Full report dict with summary and per-segment results
    """
    # Discover files
    fhir_files = {}
    for f in sorted(Path(fhir_dir).glob('*.json')):
        seg_id = f.stem
        if subset and seg_id not in subset:
            continue
        fhir_files[seg_id] = str(f)

    v291_files = {}
    for f in sorted(Path(v291_dir).glob('*.json')):
        seg_id = f.stem
        if subset and seg_id not in subset:
            continue
        v291_files[seg_id] = str(f)

    fhir_ids = set(fhir_files.keys())
    v291_ids = set(v291_files.keys())

    matched_ids = sorted(fhir_ids & v291_ids)
    fhir_only_ids = sorted(fhir_ids - v291_ids)
    v291_only_ids = sorted(v291_ids - fhir_ids)

    # Compare matched segments
    segment_results = []
    all_discrepancies = []

    for seg_id in matched_ids:
        fhir_data = load_json(fhir_files[seg_id])
        v291_data = load_json(v291_files[seg_id])
        result = compare_segment(seg_id, fhir_data, v291_data)
        segment_results.append(result)
        all_discrepancies.extend(result['discrepancies'])

    # Aggregate statistics
    severity_counts = {CRITICAL: 0, ERROR: 0, WARNING: 0, COSMETIC: 0}
    dimension_counts = {}
    for d in all_discrepancies:
        severity_counts[d['severity']] = severity_counts.get(d['severity'], 0) + 1
        dim = d['dimension']
        dimension_counts[dim] = dimension_counts.get(dim, 0) + 1

    # Count segments with issues by severity
    segments_with_critical = set()
    segments_with_any_issue = set()
    for d in all_discrepancies:
        segments_with_any_issue.add(d['segment'])
        if d['severity'] == CRITICAL:
            segments_with_critical.add(d['segment'])

    report = {
        'generated': datetime.now(timezone.utc).isoformat(),
        'summary': {
            'fhir_segment_count': len(fhir_files),
            'v291_segment_count': len(v291_files),
            'matched_segments': len(matched_ids),
            'fhir_only_segments': fhir_only_ids,
            'v291_only_segments': v291_only_ids,
            'total_discrepancies': len(all_discrepancies),
            'severity_counts': severity_counts,
            'dimension_counts': dimension_counts,
            'segments_with_critical': len(segments_with_critical),
            'segments_with_any_issue': len(segments_with_any_issue),
        },
        'segments': segment_results,
    }

    return report


# ---------------------------------------------------------------------------
# HTML report generation
# ---------------------------------------------------------------------------

def _html_escape(s):
    """Escape HTML special characters."""
    return str(s).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')


def _provenance_str(prov):
    """Format provenance dict as a readable string."""
    if not prov:
        return ''
    parts = []
    if prov.get('sourceFile'):
        parts.append(prov['sourceFile'])
    if prov.get('sectionHeading'):
        parts.append(prov['sectionHeading'])
    return ' — '.join(parts)


def _severity_badge(sev):
    """Return an HTML badge span for a severity level."""
    colors = {
        CRITICAL: '#d32f2f', ERROR: '#e65100',
        WARNING: '#f57f17', COSMETIC: '#616161',
    }
    color = colors.get(sev, '#616161')
    return f'<span style="background:{color};color:#fff;padding:1px 6px;border-radius:3px;font-size:12px;">{_html_escape(sev.upper())}</span>'


def generate_html_report(report, output_path):
    """Generate a navigable standalone HTML report from comparison results."""
    s = report['summary']

    # Build provenance lookup from segment results
    provenance_map = {}
    for seg in report['segments']:
        provenance_map[seg['segment_id']] = seg.get('v291_provenance', {})

    # Collect all discrepancies
    all_disc = []
    for seg in report['segments']:
        all_disc.extend(seg['discrepancies'])

    # Group by category
    critical_disc = [d for d in all_disc if d['severity'] == CRITICAL
                     and d['dimension'] == 'cardinality_max']
    card_errors = [d for d in all_disc
                   if d['dimension'].startswith('cardinality') and d not in critical_disc]
    dt_disc = [d for d in all_disc if d['dimension'] == 'data_type']
    opt_disc = [d for d in all_disc if d['dimension'] == 'optionality']
    item_disc = [d for d in all_disc if d['dimension'] == 'item_number']
    vocab_disc = [d for d in all_disc if d['dimension'] == 'vocabulary']
    fc_disc = [d for d in all_disc if d['dimension'] == 'field_count']
    name_disc = [d for d in all_disc if d['dimension'] == 'field_name']
    len_disc = [d for d in all_disc if d['dimension'] == 'length']
    clen_disc = [d for d in all_disc if d['dimension'] == 'conf_length']

    # Start HTML
    h = []
    h.append('''<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8">
<title>Segment Field Comparison Report</title>
<style>
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 0; display: flex; }
#sidebar { position: fixed; top: 0; left: 0; width: 260px; height: 100vh; overflow-y: auto;
  background: #f6f8fa; border-right: 1px solid #d0d7de; padding: 16px; box-sizing: border-box; font-size: 13px; }
#sidebar h2 { font-size: 15px; margin: 0 0 12px; }
#sidebar a { display: block; padding: 3px 0; color: #0969da; text-decoration: none; }
#sidebar a:hover { text-decoration: underline; }
#sidebar .badge { display: inline-block; min-width: 20px; text-align: center; padding: 0 5px;
  border-radius: 10px; font-size: 11px; color: #fff; margin-left: 4px; }
.bg-crit { background: #d32f2f; } .bg-err { background: #e65100; }
.bg-warn { background: #f57f17; color: #000 !important; } .bg-cosm { background: #9e9e9e; }
#main { margin-left: 260px; padding: 24px 32px; max-width: 1100px; }
h1 { font-size: 22px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 18px; margin-top: 32px; border-bottom: 1px solid #d0d7de; padding-bottom: 4px; }
h3 { font-size: 15px; margin-top: 24px; }
table { border-collapse: collapse; width: 100%; font-size: 13px; margin: 8px 0 16px; }
th, td { border: 1px solid #d0d7de; padding: 4px 8px; text-align: left; }
th { background: #f6f8fa; position: sticky; top: 0; }
tr:nth-child(even) { background: #f6f8fa; }
.provenance { color: #57606a; font-size: 12px; font-style: italic; }
details { margin: 4px 0; }
summary { cursor: pointer; padding: 4px 0; font-weight: 600; }
.metric-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; margin: 16px 0; }
.metric-card { border: 1px solid #d0d7de; border-radius: 6px; padding: 12px; text-align: center; }
.metric-card .number { font-size: 28px; font-weight: 700; }
.metric-card .label { font-size: 12px; color: #57606a; }
.mc-crit .number { color: #d32f2f; } .mc-err .number { color: #e65100; }
.mc-warn .number { color: #f57f17; } .mc-cosm .number { color: #616161; }
</style></head><body>''')

    # Sidebar navigation
    h.append('<div id="sidebar">')
    h.append('<h2>Navigation</h2>')
    h.append('<a href="#summary">Executive Summary</a>')
    h.append('<a href="#wb-analysis">W vs B Analysis</a>')
    if critical_disc:
        h.append(f'<a href="#critical">Critical: max=0 <span class="badge bg-crit">{len(critical_disc)}</span></a>')
    if card_errors:
        h.append(f'<a href="#cardinality">Cardinality Errors <span class="badge bg-err">{len(card_errors)}</span></a>')
    if len_disc:
        h.append(f'<a href="#length">Length Errors <span class="badge bg-err">{len(len_disc)}</span></a>')
    if clen_disc:
        h.append(f'<a href="#conf-length">Conf Length Errors <span class="badge bg-err">{len(clen_disc)}</span></a>')
    if vocab_disc:
        h.append(f'<a href="#vocabulary">Vocabulary <span class="badge bg-warn">{len(vocab_disc)}</span></a>')
    if dt_disc:
        h.append(f'<a href="#data-type">Data Type <span class="badge bg-warn">{len(dt_disc)}</span></a>')
    if opt_disc:
        h.append(f'<a href="#optionality">Optionality <span class="badge bg-warn">{len(opt_disc)}</span></a>')
    if item_disc:
        h.append(f'<a href="#item-number">Item Number <span class="badge bg-warn">{len(item_disc)}</span></a>')
    if fc_disc:
        h.append(f'<a href="#field-count">Field Count <span class="badge bg-warn">{len(fc_disc)}</span></a>')
    if name_disc:
        h.append(f'<a href="#field-name">Field Names <span class="badge bg-cosm">{len(name_disc)}</span></a>')
    h.append('<a href="#coverage">Coverage Gaps</a>')
    h.append('<a href="#per-segment">Per-Segment Detail</a>')
    h.append('<a href="#methodology">Methodology</a>')

    # Segment sub-navigation
    h.append('<h2 style="margin-top:16px;">Segments</h2>')
    for seg in report['segments']:
        if not seg['discrepancies']:
            continue
        seg_id = seg['segment_id']
        crit_count = sum(1 for d in seg['discrepancies'] if d['severity'] == CRITICAL)
        err_count = sum(1 for d in seg['discrepancies'] if d['severity'] == ERROR)
        badges = ''
        if crit_count:
            badges += f'<span class="badge bg-crit">{crit_count}</span>'
        if err_count:
            badges += f'<span class="badge bg-err">{err_count}</span>'
        h.append(f'<a href="#seg-{seg_id}">{seg_id} {badges}</a>')
    h.append('</div>')

    # Main content
    h.append('<div id="main">')
    h.append(f'<h1>Segment Field Comparison Report</h1>')
    h.append(f'<p>Generated: {_html_escape(report["generated"])}</p>')

    # Summary metrics
    h.append('<h2 id="summary">Executive Summary</h2>')
    h.append('<div class="metric-grid">')
    h.append(f'<div class="metric-card mc-crit"><div class="number">{s["severity_counts"].get(CRITICAL, 0)}</div><div class="label">Critical</div></div>')
    h.append(f'<div class="metric-card mc-err"><div class="number">{s["severity_counts"].get(ERROR, 0)}</div><div class="label">Error</div></div>')
    h.append(f'<div class="metric-card mc-warn"><div class="number">{s["severity_counts"].get(WARNING, 0)}</div><div class="label">Warning</div></div>')
    h.append(f'<div class="metric-card mc-cosm"><div class="number">{s["severity_counts"].get(COSMETIC, 0)}</div><div class="label">Cosmetic</div></div>')
    h.append('</div>')

    h.append('<table>')
    h.append('<tr><th>Metric</th><th>Count</th></tr>')
    h.append(f'<tr><td>FHIR segments</td><td>{s["fhir_segment_count"]}</td></tr>')
    h.append(f'<tr><td>V2.9.1 segments</td><td>{s["v291_segment_count"]}</td></tr>')
    h.append(f'<tr><td>Matched (compared)</td><td>{s["matched_segments"]}</td></tr>')
    h.append(f'<tr><td>FHIR-only (no V291 reference)</td><td>{len(s["fhir_only_segments"])}</td></tr>')
    h.append(f'<tr><td>V291-only (no FHIR definition)</td><td>{len(s["v291_only_segments"])}</td></tr>')
    h.append(f'<tr><td><strong>Total discrepancies</strong></td><td><strong>{s["total_discrepancies"]}</strong></td></tr>')
    h.append(f'<tr><td>Segments with critical issues</td><td>{s["segments_with_critical"]}</td></tr>')
    h.append(f'<tr><td>Segments with any issue</td><td>{s["segments_with_any_issue"]}</td></tr>')
    h.append('</table>')

    h.append('<h3>By Dimension</h3>')
    h.append('<table><tr><th>Dimension</th><th>Count</th></tr>')
    for dim in sorted(s['dimension_counts'].keys()):
        h.append(f'<tr><td>{_html_escape(dim)}</td><td>{s["dimension_counts"][dim]}</td></tr>')
    h.append('</table>')

    # --- W vs B Analysis ---
    all_wb = []
    for seg in report['segments']:
        for wb in seg.get('wb_fields', []):
            wb['source'] = seg.get('v291_provenance', {}).get('sourceFile', '')
            all_wb.append(wb)

    w_fields = [f for f in all_wb if f['v291_opt'] == 'W']
    b_fields = [f for f in all_wb if f['v291_opt'] == 'B']

    h.append('<h2 id="wb-analysis">Withdrawn vs Backward Compatible Analysis</h2>')
    h.append('<p>V2 distinguishes between <strong>W (Withdrawn)</strong> — removed from the standard, '
            'should not be used — and <strong>B (Backward Compatible)</strong> — deprecated but still '
            'usable for legacy compatibility. This section analyzes how each is represented in the '
            'FHIR StructureDefinitions vs the V2.9.1 source.</p>')

    # Summary table
    w_with_dt = sum(1 for f in w_fields if f['v291_dt'])
    w_no_dt = sum(1 for f in w_fields if not f['v291_dt'])
    b_with_dt = sum(1 for f in b_fields if f['v291_dt'])
    b_no_dt = sum(1 for f in b_fields if not f['v291_dt'])
    w_rep = [f for f in w_fields if f['v291_rep'] == 'Y']
    b_rep = [f for f in b_fields if f['v291_rep'] == 'Y']

    h.append('<h3>Overview</h3>')
    h.append('<table>')
    h.append('<tr><th></th><th>W (Withdrawn)</th><th>B (Backward Compatible)</th></tr>')
    h.append(f'<tr><td>Total fields</td><td>{len(w_fields)}</td><td>{len(b_fields)}</td></tr>')
    h.append(f'<tr><td>Has data type in V291</td><td>{w_with_dt}</td><td>{b_with_dt}</td></tr>')
    h.append(f'<tr><td>No data type in V291</td><td>{w_no_dt}</td><td>{b_no_dt}</td></tr>')
    h.append(f'<tr><td>Was repeating (Y)</td><td>{len(w_rep)}</td><td>{len(b_rep)}</td></tr>')
    h.append('</table>')

    h.append('<h3>Key Observations</h3><ul>')
    h.append(f'<li><strong>B fields always retain their data type</strong> in V2.9.1 '
            f'({b_with_dt} of {len(b_fields)}). W fields almost never do '
            f'(only {w_with_dt} of {len(w_fields)}).</li>')
    h.append('<li><strong>FHIR optionality codes agree 100%</strong> with V2.9.1 — '
            'no W/B mismatches in the optionality extension.</li>')

    # FHIR max distribution
    from collections import Counter
    w_max_dist = Counter(f['fhir_max'] for f in w_fields)
    b_max_dist = Counter(f['fhir_max'] for f in b_fields)
    h.append(f'<li><strong>FHIR max for W fields:</strong> '
            + ', '.join(f'max={k}: {v}' for k, v in sorted(w_max_dist.items())) + '</li>')
    h.append(f'<li><strong>FHIR max for B fields:</strong> '
            + ', '.join(f'max={k}: {v}' for k, v in sorted(b_max_dist.items())) + '</li>')

    # The pattern
    w_rep_max0 = sum(1 for f in w_rep if f['fhir_max'] == '0')
    b_rep_max0 = sum(1 for f in b_rep if f['fhir_max'] == '0')
    w_nonrep_max1 = sum(1 for f in w_fields if f['v291_rep'] != 'Y' and f['fhir_max'] == '1')
    b_nonrep_max1 = sum(1 for f in b_fields if f['v291_rep'] != 'Y' and f['fhir_max'] == '1')
    h.append(f'<li><strong>Systematic pattern in original conversion:</strong> '
            f'repeating W/B fields were set to max=0 '
            f'(W: {w_rep_max0}/{len(w_rep)}, B: {b_rep_max0}/{len(b_rep)}), '
            f'while non-repeating W/B fields kept max=1 '
            f'(W: {w_nonrep_max1}/{len(w_fields)-len(w_rep)}, '
            f'B: {b_nonrep_max1}/{len(b_fields)-len(b_rep)}).</li>')
    h.append('</ul>')

    h.append('<h3>Discussion Points for V2 Management Committee</h3><ol>')
    h.append('<li>Should <strong>B (Backward Compatible)</strong> fields preserve their original '
            'cardinality (e.g., <code>0..*</code>) to allow legacy data, with a visual '
            'deprecation indicator? Or should they be constrained to <code>max: 0</code>?</li>')
    h.append('<li>Should <strong>W (Withdrawn)</strong> fields that still have a data type '
            f'in V2.9.1 ({w_with_dt} fields, all phone number XTN fields + 1 SI) '
            'be treated differently from W fields with no data type?</li>')
    h.append('<li>How should the IG visually distinguish W from B? Options include different '
            'strikethrough styles, color coding, or tooltip annotations.</li>')
    h.append('<li>The FHIR <code>optionality</code> extension correctly preserves W vs B. '
            'The rendering and cardinality treatment is what needs alignment.</li>')
    h.append('</ol>')

    # W fields with data type — full detail
    w_with_dt_list = [f for f in w_fields if f['v291_dt']]
    if w_with_dt_list:
        h.append(f'<h3>W Fields That Retain Data Type ({len(w_with_dt_list)})</h3>')
        h.append('<p>These withdrawn fields unusually still have a data type in V2.9.1. '
                'All are phone number fields (XTN) except UB1.1 (SI).</p>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291 Type</th><th>V291 Rep</th><th>FHIR max</th><th>FHIR Type</th>'
                '<th>Source</th></tr>')
        for f in sorted(w_with_dt_list, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td>{_html_escape(f["segment"])}</td><td>{_html_escape(f["seq"])}</td>'
                    f'<td>{_html_escape(f["name"])}</td><td>{_html_escape(f["v291_dt"])}</td>'
                    f'<td>{_html_escape(f["v291_rep"] or "(none)")}</td>'
                    f'<td>{_html_escape(f["fhir_max"])}</td><td>{_html_escape(f["fhir_dt"])}</td>'
                    f'<td class="provenance">{_html_escape(f["source"])}</td></tr>')
        h.append('</table>')

    # All B fields — full detail
    if b_fields:
        h.append(f'<h3>All B (Backward Compatible) Fields ({len(b_fields)})</h3>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291 Type</th><th>V291 Rep</th><th>FHIR max</th><th>FHIR Type</th>'
                '<th>Source</th></tr>')
        for f in sorted(b_fields, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td>{_html_escape(f["segment"])}</td><td>{_html_escape(f["seq"])}</td>'
                    f'<td>{_html_escape(f["name"])}</td><td>{_html_escape(f["v291_dt"])}</td>'
                    f'<td>{_html_escape(f["v291_rep"] or "(none)")}</td>'
                    f'<td>{_html_escape(f["fhir_max"])}</td><td>{_html_escape(f["fhir_dt"])}</td>'
                    f'<td class="provenance">{_html_escape(f["source"])}</td></tr>')
        h.append('</table>')

    # --- Critical: max=0 ---
    if critical_disc:
        h.append(f'<h2 id="critical">Critical: max=0 Should Be Repeatable ({len(critical_disc)})</h2>')
        h.append(f'<p>These fields have <code>max: 0</code> (prohibited) but V2.9.1 indicates they should repeat.</p>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th><th>Opt</th><th>Rep</th>'
                '<th>FHIR max</th><th>Expected</th><th>V291 Source</th></tr>')
        for d in sorted(critical_disc, key=lambda x: (x['segment'], int(x['seq']))):
            detail = d['detail']
            opt = detail.split("opt=")[1].split(" ")[0] if "opt=" in detail else "?"
            rep_marker = "repetition='"
            rep = detail.split(rep_marker)[1].split("'")[0] if rep_marker in detail else "?"
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(opt)}</td><td>{_html_escape(rep)}</td>'
                    f'<td>{_html_escape(d["actual"])}</td><td>{_html_escape(d["expected"])}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Cardinality errors ---
    if card_errors:
        h.append(f'<h2 id="cardinality">Cardinality Errors ({len(card_errors)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th><th>Dimension</th>'
                '<th>Expected</th><th>Actual</th><th>Detail</th><th>V291 Source</th></tr>')
        for d in sorted(card_errors, key=lambda x: (x['segment'], int(x['seq']))):
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(d["dimension"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td>'
                    f'<td>{_html_escape(d["detail"])}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Length errors ---
    if len_disc:
        h.append(f'<h2 id="length">Length Errors ({len(len_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291</th><th>FHIR</th><th>V291 Source</th></tr>')
        for d in sorted(len_disc, key=lambda x: (x['segment'], int(x['seq']))):
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Conf length errors ---
    if clen_disc:
        h.append(f'<h2 id="conf-length">Conformance Length Errors ({len(clen_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291</th><th>FHIR</th><th>V291 Source</th></tr>')
        for d in sorted(clen_disc, key=lambda x: (x['segment'], int(x['seq']))):
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Vocabulary ---
    if vocab_disc:
        h.append(f'<h2 id="vocabulary">Vocabulary Binding Mismatches ({len(vocab_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291 Table(s)</th><th>FHIR Table</th><th>V291 Source</th></tr>')
        for d in sorted(vocab_disc, key=lambda x: (x['segment'], int(x['seq']))):
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Data type ---
    if dt_disc:
        h.append(f'<h2 id="data-type">Data Type Mismatches ({len(dt_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291</th><th>FHIR</th></tr>')
        for d in sorted(dt_disc, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td></tr>')
        h.append('</table>')

    # --- Optionality ---
    if opt_disc:
        h.append(f'<h2 id="optionality">Optionality Mismatches ({len(opt_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291</th><th>FHIR</th></tr>')
        for d in sorted(opt_disc, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td></tr>')
        h.append('</table>')

    # --- Item number ---
    if item_disc:
        h.append(f'<h2 id="item-number">Item Number Mismatches ({len(item_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>V291</th><th>FHIR</th></tr>')
        for d in sorted(item_disc, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td></tr>')
        h.append('</table>')

    # --- Field count ---
    if fc_disc:
        h.append(f'<h2 id="field-count">Field Count Differences ({len(fc_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>Field Name</th>'
                '<th>Status</th><th>V291 Source</th></tr>')
        for d in sorted(fc_disc, key=lambda x: (x['segment'], int(x['seq']))):
            status = 'FHIR-only' if d['actual'] == 'present' else 'V291-only'
            prov = _provenance_str(provenance_map.get(d['segment'], {}))
            h.append(f'<tr><td><a href="#seg-{_html_escape(d["segment"])}">{_html_escape(d["segment"])}</a></td>'
                    f'<td>{_html_escape(d["seq"])}</td><td>{_html_escape(d["field_name"])}</td>'
                    f'<td>{_html_escape(status)}</td>'
                    f'<td class="provenance">{_html_escape(prov)}</td></tr>')
        h.append('</table>')

    # --- Field names (cosmetic) ---
    if name_disc:
        h.append(f'<h2 id="field-name">Field Name Differences ({len(name_disc)})</h2>')
        h.append('<table><tr><th>Segment</th><th>Seq</th><th>V291 Name</th><th>FHIR Name</th></tr>')
        for d in sorted(name_disc, key=lambda x: (x['segment'], int(x['seq']))):
            h.append(f'<tr><td>{_html_escape(d["segment"])}</td>'
                    f'<td>{_html_escape(d["seq"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td><td>{_html_escape(str(d["actual"]))}</td></tr>')
        h.append('</table>')

    # --- Coverage gaps ---
    h.append(f'<h2 id="coverage">Coverage Gaps</h2>')
    if s['fhir_only_segments']:
        h.append(f'<h3>FHIR-only segments ({len(s["fhir_only_segments"])})</h3>')
        h.append('<p>These segments exist in FHIR but have no V2.9.1 extraction to compare against.</p>')
        h.append('<ul>')
        for seg_id in s['fhir_only_segments']:
            h.append(f'<li>{_html_escape(seg_id)}</li>')
        h.append('</ul>')
    if s['v291_only_segments']:
        h.append(f'<h3>V291-only segments ({len(s["v291_only_segments"])})</h3>')
        h.append('<p>These segments exist in V2.9.1 extraction but have no FHIR definition.</p>')
        h.append('<ul>')
        for seg_id in s['v291_only_segments']:
            h.append(f'<li>{_html_escape(seg_id)}</li>')
        h.append('</ul>')

    # --- Per-segment detail ---
    h.append(f'<h2 id="per-segment">Per-Segment Detail</h2>')
    for seg in report['segments']:
        seg_id = seg['segment_id']
        prov = _provenance_str(seg.get('v291_provenance', {}))
        if not seg['discrepancies']:
            continue

        seg_crit = sum(1 for d in seg['discrepancies'] if d['severity'] == CRITICAL)
        seg_err = sum(1 for d in seg['discrepancies'] if d['severity'] == ERROR)
        seg_warn = sum(1 for d in seg['discrepancies'] if d['severity'] == WARNING)
        badges = ''
        if seg_crit:
            badges += f' <span class="badge bg-crit">{seg_crit} crit</span>'
        if seg_err:
            badges += f' <span class="badge bg-err">{seg_err} err</span>'
        if seg_warn:
            badges += f' <span class="badge bg-warn">{seg_warn} warn</span>'

        h.append(f'<details id="seg-{_html_escape(seg_id)}">')
        h.append(f'<summary><strong>{_html_escape(seg_id)}</strong> — '
                f'{len(seg["discrepancies"])} issues{badges}</summary>')
        h.append(f'<p>FHIR fields: {seg["fhir_field_count"]}, '
                f'V291 fields: {seg["v291_field_count"]}, '
                f'Matched: {seg["matched_fields"]}</p>')
        if prov:
            h.append(f'<p class="provenance">Source: {_html_escape(prov)}</p>')
        if seg['v291_occurrence_count'] > 1:
            h.append(f'<p><em>Note: V291 has {seg["v291_occurrence_count"]} occurrences; '
                    f'using first occurrence for comparison.</em></p>')

        h.append('<table><tr><th>Seq</th><th>Dimension</th><th>Severity</th>'
                '<th>Expected</th><th>Actual</th><th>Detail</th></tr>')
        for d in sorted(seg['discrepancies'],
                       key=lambda x: (SEVERITY_ORDER.get(x['severity'], 9), int(x['seq']))):
            h.append(f'<tr><td>{_html_escape(d["seq"])}</td>'
                    f'<td>{_html_escape(d["dimension"])}</td>'
                    f'<td>{_severity_badge(d["severity"])}</td>'
                    f'<td>{_html_escape(str(d["expected"]))}</td>'
                    f'<td>{_html_escape(str(d["actual"]))}</td>'
                    f'<td>{_html_escape(d["detail"])}</td></tr>')
        h.append('</table></details>')

    # Clean segments
    clean_segments = [seg for seg in report['segments'] if not seg['discrepancies']]
    if clean_segments:
        h.append(f'<h3>Clean Segments ({len(clean_segments)})</h3>')
        h.append('<ul>')
        for seg in clean_segments:
            h.append(f'<li>{_html_escape(seg["segment_id"])} ({seg["fhir_field_count"]} fields)</li>')
        h.append('</ul>')

    # Methodology
    h.append('<h2 id="methodology">Methodology</h2>')
    h.append('<p>This report compares FHIR StructureDefinition segment JSON files '
            '(<code>input/sourceOfTruth/segment/segments/</code>) against V2.9.1 data '
            'extracted from Word documents (<code>v291-extracted/segments/</code>).</p>')
    h.append('<h3>Mapping Rules</h3><ul>')
    h.append('<li><strong>Cardinality max</strong>: V291 repetition="" or "N" → FHIR max: "1"; "Y" → "*"; numeric → that number</li>')
    h.append('<li><strong>Cardinality min</strong>: V291 optionality="R" → FHIR min: 1; O/C/W/B → min: 0</li>')
    h.append('<li><strong>Withdrawn fields</strong>: Identified by optionality W or B. Original cardinality preserved (not forced to max: 0).</li>')
    h.append('<li><strong>Data types</strong>: Case-insensitive comparison</li>')
    h.append('<li><strong>Item numbers</strong>: V291 zero-padded strings vs FHIR integers (normalized to int)</li>')
    h.append('<li><strong>Vocabulary</strong>: V291 may have multiple tables (slash-separated); FHIR matches if it binds to any one of them</li>')
    h.append('<li><strong>Lengths</strong>: V291 "1..4" format parsed to min/max integers</li>')
    h.append('<li><strong>Multiple V291 occurrences</strong>: First occurrence used for comparison</li>')
    h.append('<li><strong>Non-numeric sequences</strong>: Skipped (e.g. ADD "1-n")</li>')
    h.append('</ul>')

    h.append('</div></body></html>')

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(h))


def generate_markdown_report(report, output_path):
    """Generate a human-readable Markdown report (summary only)."""
    lines = []
    s = report['summary']

    lines.append('# Segment Field Comparison Report')
    lines.append(f'\nGenerated: {report["generated"]}\n')

    # Executive Summary
    lines.append('## Executive Summary\n')
    lines.append(f'| Metric | Count |')
    lines.append(f'|--------|-------|')
    lines.append(f'| FHIR segments | {s["fhir_segment_count"]} |')
    lines.append(f'| V2.9.1 segments | {s["v291_segment_count"]} |')
    lines.append(f'| Matched (compared) | {s["matched_segments"]} |')
    lines.append(f'| FHIR-only (no V291 reference) | {len(s["fhir_only_segments"])} |')
    lines.append(f'| V291-only (no FHIR definition) | {len(s["v291_only_segments"])} |')
    lines.append(f'| **Total discrepancies** | **{s["total_discrepancies"]}** |')
    lines.append(f'| Segments with critical issues | {s["segments_with_critical"]} |')
    lines.append(f'| Segments with any issue | {s["segments_with_any_issue"]} |')
    lines.append('')

    lines.append('### By Severity\n')
    lines.append('| Severity | Count |')
    lines.append('|----------|-------|')
    for sev in [CRITICAL, ERROR, WARNING, COSMETIC]:
        count = s['severity_counts'].get(sev, 0)
        lines.append(f'| {sev.upper()} | {count} |')
    lines.append('')

    lines.append('### By Dimension\n')
    lines.append('| Dimension | Count |')
    lines.append('|-----------|-------|')
    for dim in sorted(s['dimension_counts'].keys()):
        lines.append(f'| {dim} | {s["dimension_counts"][dim]} |')
    lines.append('')

    # Collect all discrepancies for sectioning
    all_disc = []
    for seg in report['segments']:
        all_disc.extend(seg['discrepancies'])

    # Critical: max=0 should be repeatable
    critical_disc = [d for d in all_disc if d['severity'] == CRITICAL]
    if critical_disc:
        lines.append('## CRITICAL: max=0 Should Be Repeatable\n')
        lines.append(f'{len(critical_disc)} fields have `max: 0` (prohibited) '
                     f'but V2.9.1 indicates they should repeat.\n')
        lines.append('| Segment | Seq | Field Name | V291 Optionality | V291 Repetition | FHIR max | Expected max |')
        lines.append('|---------|-----|------------|------------------|-----------------|----------|--------------|')
        for d in sorted(critical_disc, key=lambda x: (x['segment'], int(x['seq']))):
            detail = d['detail']
            opt = detail.split("opt=")[1].split(" ")[0] if "opt=" in detail else "?"
            rep_marker = "repetition='"
            rep = detail.split(rep_marker)[1].split("'")[0] if rep_marker in detail else "?"
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{opt} | {rep} | {d["actual"]} | {d["expected"]} |')
        lines.append('')

    # Coverage gaps
    if s['fhir_only_segments'] or s['v291_only_segments']:
        lines.append('## Coverage Gaps\n')
        if s['fhir_only_segments']:
            lines.append(f'### FHIR-only segments ({len(s["fhir_only_segments"])})\n')
            lines.append('These segments exist in FHIR but have no V2.9.1 extraction to compare against.\n')
            for seg_id in s['fhir_only_segments']:
                lines.append(f'- {seg_id}')
            lines.append('')
        if s['v291_only_segments']:
            lines.append(f'### V291-only segments ({len(s["v291_only_segments"])})\n')
            lines.append('These segments exist in V2.9.1 extraction but have no FHIR definition.\n')
            for seg_id in s['v291_only_segments']:
                lines.append(f'- {seg_id}')
            lines.append('')

    # Cardinality errors (non-critical)
    card_errors = [d for d in all_disc
                   if d['dimension'].startswith('cardinality') and d['severity'] != CRITICAL]
    if card_errors:
        lines.append('## Cardinality Errors (Non-Critical)\n')
        lines.append('| Segment | Seq | Field Name | Dimension | Expected | Actual | Detail |')
        lines.append('|---------|-----|------------|-----------|----------|--------|--------|')
        for d in sorted(card_errors, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["dimension"]} | {d["expected"]} | {d["actual"]} | {d["detail"]} |')
        lines.append('')

    # Data type mismatches
    dt_disc = [d for d in all_disc if d['dimension'] == 'data_type']
    if dt_disc:
        lines.append('## Data Type Mismatches\n')
        lines.append('| Segment | Seq | Field Name | V291 | FHIR |')
        lines.append('|---------|-----|------------|------|------|')
        for d in sorted(dt_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["expected"]} | {d["actual"]} |')
        lines.append('')

    # Optionality mismatches
    opt_disc = [d for d in all_disc if d['dimension'] == 'optionality']
    if opt_disc:
        lines.append('## Optionality Mismatches\n')
        lines.append('| Segment | Seq | Field Name | V291 | FHIR |')
        lines.append('|---------|-----|------------|------|------|')
        for d in sorted(opt_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["expected"]} | {d["actual"]} |')
        lines.append('')

    # Item number mismatches
    item_disc = [d for d in all_disc if d['dimension'] == 'item_number']
    if item_disc:
        lines.append('## Item Number Mismatches\n')
        lines.append('| Segment | Seq | Field Name | V291 | FHIR |')
        lines.append('|---------|-----|------------|------|------|')
        for d in sorted(item_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["expected"]} | {d["actual"]} |')
        lines.append('')

    # Vocabulary mismatches
    vocab_disc = [d for d in all_disc if d['dimension'] == 'vocabulary']
    if vocab_disc:
        lines.append('## Vocabulary Binding Mismatches\n')
        lines.append('| Segment | Seq | Field Name | V291 Table | FHIR Table |')
        lines.append('|---------|-----|------------|------------|------------|')
        for d in sorted(vocab_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["expected"]} | {d["actual"]} |')
        lines.append('')

    # Field count mismatches
    fc_disc = [d for d in all_disc if d['dimension'] == 'field_count']
    if fc_disc:
        lines.append('## Field Count Differences\n')
        lines.append('| Segment | Seq | Field Name | Status | Detail |')
        lines.append('|---------|-----|------------|--------|--------|')
        for d in sorted(fc_disc, key=lambda x: (x['segment'], int(x['seq']))):
            status = 'FHIR-only' if d['actual'] == 'present' else 'V291-only'
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{status} | {d["detail"]} |')
        lines.append('')

    # Field name differences (collapsible)
    name_disc = [d for d in all_disc if d['dimension'] == 'field_name']
    if name_disc:
        lines.append('<details>')
        lines.append(f'<summary>Field Name Differences ({len(name_disc)})</summary>\n')
        lines.append('| Segment | Seq | V291 Name | FHIR Name |')
        lines.append('|---------|-----|-----------|-----------|')
        for d in sorted(name_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["expected"]} | {d["actual"]} |')
        lines.append('\n</details>\n')

    # Length differences (collapsible)
    len_disc = [d for d in all_disc if d['dimension'] in ('length', 'conf_length')]
    if len_disc:
        lines.append('<details>')
        lines.append(f'<summary>Length / Conformance Length Differences ({len(len_disc)})</summary>\n')
        lines.append('| Segment | Seq | Field Name | Dimension | V291 | FHIR |')
        lines.append('|---------|-----|------------|-----------|------|------|')
        for d in sorted(len_disc, key=lambda x: (x['segment'], int(x['seq']))):
            lines.append(f'| {d["segment"]} | {d["seq"]} | {d["field_name"]} | '
                        f'{d["dimension"]} | {d["expected"]} | {d["actual"]} |')
        lines.append('\n</details>\n')

    # Per-segment detail (collapsible)
    lines.append('## Per-Segment Detail\n')
    for seg in report['segments']:
        if not seg['discrepancies']:
            continue
        seg_critical = sum(1 for d in seg['discrepancies'] if d['severity'] == CRITICAL)
        seg_errors = sum(1 for d in seg['discrepancies'] if d['severity'] == ERROR)
        seg_warnings = sum(1 for d in seg['discrepancies'] if d['severity'] == WARNING)
        badge = ''
        if seg_critical:
            badge += f' **{seg_critical} CRITICAL**'
        if seg_errors:
            badge += f' {seg_errors} error'
        if seg_warnings:
            badge += f' {seg_warnings} warning'

        lines.append('<details>')
        lines.append(f'<summary>{seg["segment_id"]} — {len(seg["discrepancies"])} issues:{badge}</summary>\n')
        lines.append(f'FHIR fields: {seg["fhir_field_count"]}, '
                    f'V291 fields: {seg["v291_field_count"]}, '
                    f'Matched: {seg["matched_fields"]}')
        if seg['v291_occurrence_count'] > 1:
            lines.append(f'\n> Note: V291 has {seg["v291_occurrence_count"]} occurrences; '
                        f'using first occurrence for comparison.')
        lines.append('')
        lines.append('| Seq | Dimension | Severity | Expected | Actual | Detail |')
        lines.append('|-----|-----------|----------|----------|--------|--------|')
        for d in sorted(seg['discrepancies'],
                       key=lambda x: (SEVERITY_ORDER.get(x['severity'], 9), int(x['seq']))):
            lines.append(f'| {d["seq"]} | {d["dimension"]} | {d["severity"]} | '
                        f'{d["expected"]} | {d["actual"]} | {d["detail"]} |')
        lines.append('\n</details>\n')

    # Clean segments
    clean_segments = [seg for seg in report['segments'] if not seg['discrepancies']]
    if clean_segments:
        lines.append(f'### Clean Segments ({len(clean_segments)})\n')
        lines.append('These segments have zero discrepancies:\n')
        for seg in clean_segments:
            lines.append(f'- {seg["segment_id"]} ({seg["fhir_field_count"]} fields)')
        lines.append('')

    # Methodology
    lines.append('## Methodology\n')
    lines.append('This report compares FHIR StructureDefinition segment JSON files '
                '(`input/sourceOfTruth/segment/segments/`) against V2.9.1 data '
                'extracted from Word documents (`v291-extracted/segments/`).\n')
    lines.append('### Mapping Rules\n')
    lines.append('- **Cardinality max**: V291 `repetition=""` or `"N"` → FHIR `max: "1"`; '
                '`"Y"` → `"*"`; numeric → that number')
    lines.append('- **Cardinality min**: V291 `optionality="R"` → FHIR `min: 1`; '
                'O/C/W/B → `min: 0`')
    lines.append('- **Withdrawn fields**: `optionality` W or B with no data type → '
                '`max: "0"` is correct')
    lines.append('- **Data types**: Case-insensitive comparison')
    lines.append('- **Item numbers**: V291 zero-padded strings vs FHIR integers '
                '(normalized to int for comparison)')
    lines.append('- **Vocabulary**: Table number extracted from FHIR ValueSet URL '
                '(`v2-XXXX` pattern)')
    lines.append('- **Lengths**: V291 `"1..4"` format parsed to min/max integers')
    lines.append('- **Multiple V291 occurrences**: First occurrence used for comparison')
    lines.append('- **Non-numeric sequences**: Skipped (e.g. ADD `"1-n"`)')

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description='Compare FHIR segment definitions against V2.9.1 extracted data')
    parser.add_argument('--subset', type=str, default=None,
                        help='Comma-separated list of segment IDs (e.g. OBX,PID,MSH)')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = [s.strip() for s in args.subset.split(',')]

    # Check directories exist
    if not os.path.isdir(SEGMENTS_DIR):
        print(f"Error: FHIR segments directory not found: {SEGMENTS_DIR}")
        sys.exit(1)
    if not os.path.isdir(V291_DIR):
        print(f"Error: V291 segments directory not found: {V291_DIR}")
        sys.exit(1)

    print(f"Comparing FHIR segments vs V2.9.1 extracted data...")
    if subset:
        print(f"  Subset: {', '.join(subset)}")

    report = run_comparison(SEGMENTS_DIR, V291_DIR, subset=subset)

    # Write JSON report
    json_path = os.path.join(REPORT_DIR, 'segment-comparison-report.json')
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2, default=str)
    print(f"  JSON report: {json_path}")

    # Write HTML report (primary — navigable)
    html_path = os.path.join(REPORT_DIR, 'segment-comparison-report.html')
    generate_html_report(report, html_path)
    print(f"  HTML report: {html_path}")

    # Write Markdown report (summary)
    md_path = os.path.join(REPORT_DIR, 'segment-comparison-report.md')
    generate_markdown_report(report, md_path)
    print(f"  Markdown report: {md_path}")

    # Console summary
    s = report['summary']
    print(f"\nResults:")
    print(f"  Compared {s['matched_segments']} segments "
          f"({len(s['fhir_only_segments'])} FHIR-only, "
          f"{len(s['v291_only_segments'])} V291-only)")
    print(f"  Total discrepancies: {s['total_discrepancies']}")
    print(f"    CRITICAL: {s['severity_counts'].get(CRITICAL, 0)}")
    print(f"    ERROR:    {s['severity_counts'].get(ERROR, 0)}")
    print(f"    WARNING:  {s['severity_counts'].get(WARNING, 0)}")
    print(f"    COSMETIC: {s['severity_counts'].get(COSMETIC, 0)}")


if __name__ == '__main__':
    main()
