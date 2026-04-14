#!/usr/bin/env python3
"""Compare FHIR complex data type components against V2.9.1 extracted data.

Performs a component-by-component comparison across 7 dimensions (data type,
optionality, name, length, conformance length, vocabulary, component count)
and produces JSON + Markdown reports of all discrepancies.

Usage:
    python3 tooling/scripts/compare_data_types.py
    python3 tooling/scripts/compare_data_types.py --subset CWE,XPN,XAD
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

# Reuse parsing helpers from compare_segments
sys.path.insert(0, os.path.dirname(__file__))
from compare_segments import (
    parse_v291_length,
    parse_v291_conf_length,
    extract_v291_table_number,
    get_extension,
    get_sub_extension,
    CRITICAL, ERROR, WARNING, COSMETIC,
    SEVERITY_ORDER,
)
from v2_utils import load_json, PROJECT_ROOT

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

FHIR_DT_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'data-type',
                            'complex', 'complex-data-types')
V291_DT_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'data-types', 'complex')
REPORT_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted')


# ---------------------------------------------------------------------------
# FHIR component extraction
# ---------------------------------------------------------------------------

def extract_fhir_components(fhir_data):
    """Extract component metadata from a FHIR complex data type StructureDefinition.

    Returns:
        Dict keyed by sequence number string, each value a dict with:
        seq, name, data_type, optionality, length_min, length_max,
        conf_length, no_truncate, vocabulary_table, element_id
    """
    elements = fhir_data.get('differential', {}).get('element', [])
    components = {}

    for elem in elements[1:]:  # Skip root element
        path = elem.get('path', '')
        elem_id = elem.get('id', '')
        extensions = elem.get('extension', [])

        # Seq: number after the dot (e.g. CWE.1 -> "1")
        suffix = path.rsplit('.', 1)[-1] if '.' in path else ''
        seq = suffix.split('-', 1)[0] if suffix else ''
        if not seq:
            continue

        # Name
        name = elem.get('short', '')

        # Data type — extract code suffix from URL
        type_list = elem.get('type', [])
        data_type = ''
        if type_list:
            code = type_list[0].get('code', '')
            # Extract type name from URL: http://hl7.org/v2/StructureDefinition/ST -> ST
            if '/' in code:
                data_type = code.rsplit('/', 1)[-1]
            else:
                data_type = code

        # Optionality
        opt_ext = get_extension(extensions, 'optionality')
        optionality = opt_ext.get('valueCode', '') if opt_ext else ''

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
                # Handle both valueInteger and valueBoolean formats
                val = trunc_sub.get('valueInteger')
                if val is None:
                    bool_val = trunc_sub.get('valueBoolean')
                    if bool_val is not None:
                        val = 1 if bool_val else 0
                no_truncate = int(val) if val is not None else None

        # Vocabulary: extract table number from valueSet URL
        binding = elem.get('binding', {})
        value_set_url = binding.get('valueSet', '')
        vocab_table = ''
        if value_set_url:
            match = re.search(r'v2-(\d+)', value_set_url)
            if match:
                vocab_table = match.group(1)

        components[seq] = {
            'seq': seq,
            'name': name,
            'data_type': data_type,
            'optionality': optionality,
            'length_min': length_min,
            'length_max': length_max,
            'conf_length': conf_length,
            'no_truncate': no_truncate,
            'vocabulary_table': vocab_table,
            'element_id': elem_id,
        }

    return components


# ---------------------------------------------------------------------------
# V291 component extraction
# ---------------------------------------------------------------------------

def extract_v291_components(v291_data):
    """Extract component metadata from V291 extracted data type.

    Returns:
        Tuple of (components_dict, occurrence_count, provenance_dict)
    """
    occurrences = v291_data.get('occurrences', [])
    if not occurrences:
        return {}, 0, {}

    occurrence_count = len(occurrences)
    provenance = occurrences[0].get('provenance', {})
    raw_components = occurrences[0].get('components', [])
    components = {}

    for c in raw_components:
        seq = c.get('sequence', '')
        if not seq.isdigit():
            continue
        components[seq] = {
            'seq': seq,
            'name': c.get('name', ''),
            'data_type': c.get('dataType', ''),
            'optionality': c.get('optionality', ''),
            'length': c.get('length', ''),
            'conf_length': c.get('confLength', ''),
            'table_binding': c.get('tableBinding', ''),
        }

    return components, occurrence_count, provenance


# ---------------------------------------------------------------------------
# Per-component comparison functions
# ---------------------------------------------------------------------------

def compare_component_data_type(fhir_comp, v291_comp, dt_code, seq):
    """Compare data type between FHIR and V291."""
    fhir_dt = fhir_comp['data_type']
    v291_dt = v291_comp['data_type']

    if not fhir_dt and not v291_dt:
        return []
    if fhir_dt.upper() == v291_dt.upper():
        return []

    return [{
        'data_type': dt_code,
        'seq': seq,
        'component_name': fhir_comp['name'],
        'dimension': 'data_type',
        'severity': WARNING,
        'expected': v291_dt,
        'actual': fhir_dt,
        'detail': f"Data type: V291='{v291_dt}', FHIR='{fhir_dt}'",
    }]


def compare_component_optionality(fhir_comp, v291_comp, dt_code, seq):
    """Compare optionality between FHIR and V291."""
    fhir_opt = fhir_comp['optionality']
    v291_opt = v291_comp['optionality']

    if fhir_opt == v291_opt:
        return []

    return [{
        'data_type': dt_code,
        'seq': seq,
        'component_name': fhir_comp['name'],
        'dimension': 'optionality',
        'severity': WARNING,
        'expected': v291_opt,
        'actual': fhir_opt,
        'detail': f"Optionality: V291='{v291_opt}', FHIR='{fhir_opt}'",
    }]


def compare_component_name(fhir_comp, v291_comp, dt_code, seq):
    """Compare component name between FHIR and V291."""
    fhir_name = fhir_comp['name']
    v291_name = v291_comp['name']

    if not fhir_name and not v291_name:
        return []

    def normalize(s):
        return s.lower().replace('\u2013', '-').replace('\u2014', '-').strip()

    if normalize(fhir_name) == normalize(v291_name):
        return []

    return [{
        'data_type': dt_code,
        'seq': seq,
        'component_name': fhir_comp['name'],
        'dimension': 'component_name',
        'severity': COSMETIC,
        'expected': v291_name,
        'actual': fhir_name,
        'detail': f"Name: V291='{v291_name}', FHIR='{fhir_name}'",
    }]


def compare_component_length(fhir_comp, v291_comp, dt_code, seq):
    """Compare length constraints."""
    v291_min, v291_max = parse_v291_length(v291_comp['length'])
    fhir_min = fhir_comp['length_min']
    fhir_max = fhir_comp['length_max']

    if fhir_min is not None:
        fhir_min = int(fhir_min)
    if fhir_max is not None:
        fhir_max = int(fhir_max)

    if v291_min is None and v291_max is None and fhir_min is None and fhir_max is None:
        return []

    if v291_min != fhir_min or v291_max != fhir_max:
        return [{
            'data_type': dt_code,
            'seq': seq,
            'component_name': fhir_comp['name'],
            'dimension': 'length',
            'severity': ERROR,
            'expected': f"{v291_min}..{v291_max}" if v291_min is not None else '',
            'actual': f"{fhir_min}..{fhir_max}" if fhir_min is not None else '',
            'detail': f"Length: V291='{v291_comp['length']}', FHIR={fhir_min}..{fhir_max}",
        }]

    return []


def compare_component_conf_length(fhir_comp, v291_comp, dt_code, seq):
    """Compare conformance length."""
    v291_len, v291_trunc = parse_v291_conf_length(v291_comp['conf_length'])
    fhir_len = fhir_comp['conf_length']
    fhir_trunc = fhir_comp['no_truncate']

    if fhir_len is not None:
        fhir_len = int(fhir_len)
    if fhir_trunc is not None:
        fhir_trunc = int(fhir_trunc)

    if (v291_len is None and v291_trunc is None and
            fhir_len is None and fhir_trunc is None):
        return []

    if v291_len != fhir_len or v291_trunc != fhir_trunc:
        return [{
            'data_type': dt_code,
            'seq': seq,
            'component_name': fhir_comp['name'],
            'dimension': 'conf_length',
            'severity': ERROR,
            'expected': v291_comp['conf_length'],
            'actual': f"{fhir_len}{'=' if fhir_trunc == 1 else '#' if fhir_trunc == 0 else '?'}" if fhir_len is not None else '',
            'detail': f"Conf length: V291='{v291_comp['conf_length']}', FHIR len={fhir_len} trunc={fhir_trunc}",
        }]

    return []


def compare_component_vocabulary(fhir_comp, v291_comp, dt_code, seq):
    """Compare vocabulary/table binding."""
    v291_raw = extract_v291_table_number(v291_comp['table_binding'])
    fhir_table = fhir_comp['vocabulary_table']

    def normalize_table(t):
        t = t.strip()
        if not t:
            return ''
        try:
            return str(int(t))
        except ValueError:
            return t

    if not v291_raw and not fhir_table:
        return []

    v291_tables = re.split(r'[/,\s]+', v291_raw)
    v291_tables = [t for t in v291_tables if t]

    fhir_norm = normalize_table(fhir_table)

    if any(normalize_table(t) == fhir_norm for t in v291_tables):
        return []

    return [{
        'data_type': dt_code,
        'seq': seq,
        'component_name': fhir_comp['name'],
        'dimension': 'vocabulary',
        'severity': WARNING,
        'expected': v291_raw,
        'actual': fhir_table,
        'detail': f"Vocabulary: V291='{v291_raw}', FHIR='{fhir_table}'",
    }]


# ---------------------------------------------------------------------------
# Full data type comparison
# ---------------------------------------------------------------------------

def compare_data_type(dt_code, fhir_data, v291_data):
    """Compare a single data type across all components and dimensions."""
    fhir_comps = extract_fhir_components(fhir_data)
    v291_comps, occ_count, provenance = extract_v291_components(v291_data)

    fhir_seqs = set(fhir_comps.keys())
    v291_seqs = set(v291_comps.keys())
    all_seqs = sorted(fhir_seqs | v291_seqs, key=lambda x: int(x))

    discrepancies = []
    component_count_mismatch = len(fhir_seqs) != len(v291_seqs)

    if component_count_mismatch:
        discrepancies.append({
            'data_type': dt_code,
            'seq': '-',
            'component_name': '(count)',
            'dimension': 'component_count',
            'severity': CRITICAL,
            'expected': str(len(v291_seqs)),
            'actual': str(len(fhir_seqs)),
            'detail': f"Component count: V291={len(v291_seqs)}, FHIR={len(fhir_seqs)}",
        })

    # Compare matched components
    for seq in sorted(fhir_seqs & v291_seqs, key=lambda x: int(x)):
        fhir_comp = fhir_comps[seq]
        v291_comp = v291_comps[seq]

        comparisons = [
            compare_component_data_type,
            compare_component_optionality,
            compare_component_name,
            compare_component_length,
            compare_component_conf_length,
            compare_component_vocabulary,
        ]

        for compare_fn in comparisons:
            discrepancies.extend(compare_fn(fhir_comp, v291_comp, dt_code, seq))

    # Components only in FHIR
    for seq in sorted(fhir_seqs - v291_seqs, key=lambda x: int(x)):
        discrepancies.append({
            'data_type': dt_code,
            'seq': seq,
            'component_name': fhir_comps[seq]['name'],
            'dimension': 'component_missing',
            'severity': WARNING,
            'expected': '(absent in V291)',
            'actual': fhir_comps[seq]['data_type'],
            'detail': f"Component {seq} ({fhir_comps[seq]['name']}) in FHIR but not V291",
        })

    # Components only in V291
    for seq in sorted(v291_seqs - fhir_seqs, key=lambda x: int(x)):
        discrepancies.append({
            'data_type': dt_code,
            'seq': seq,
            'component_name': v291_comps[seq]['name'],
            'dimension': 'component_missing',
            'severity': WARNING,
            'expected': v291_comps[seq]['data_type'],
            'actual': '(absent in FHIR)',
            'detail': f"Component {seq} ({v291_comps[seq]['name']}) in V291 but not FHIR",
        })

    return {
        'data_type': dt_code,
        'fhir_component_count': len(fhir_seqs),
        'v291_component_count': len(v291_seqs),
        'v291_occurrences': occ_count,
        'provenance': provenance,
        'discrepancy_count': len(discrepancies),
        'discrepancies': discrepancies,
    }


# ---------------------------------------------------------------------------
# Report generation
# ---------------------------------------------------------------------------

def write_json_report(results, output_path):
    """Write JSON comparison report."""
    with open(output_path, 'w') as f:
        json.dump(results, f, indent=2)


def write_markdown_report(results, output_path):
    """Write Markdown comparison report."""
    lines = []
    lines.append("# Data Type Component Comparison: FHIR vs V2.9.1")
    lines.append("")
    lines.append(f"Generated: {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')}")
    lines.append("")

    # Summary
    total_dt = len(results['data_types'])
    total_disc = results['summary']['total_discrepancies']
    dt_with_disc = results['summary']['data_types_with_discrepancies']
    lines.append(f"**{total_dt}** data types compared, "
                f"**{dt_with_disc}** with discrepancies, "
                f"**{total_disc}** total discrepancies")
    lines.append("")

    # Severity breakdown
    lines.append("## Discrepancies by Severity")
    lines.append("")
    lines.append("| Severity | Count |")
    lines.append("|----------|-------|")
    for sev in ['critical', 'error', 'warning', 'cosmetic']:
        count = results['summary']['by_severity'].get(sev, 0)
        if count > 0:
            lines.append(f"| {sev} | {count} |")
    lines.append("")

    # Dimension breakdown
    lines.append("## Discrepancies by Dimension")
    lines.append("")
    lines.append("| Dimension | Count |")
    lines.append("|-----------|-------|")
    for dim, count in sorted(results['summary']['by_dimension'].items(),
                              key=lambda x: -x[1]):
        lines.append(f"| {dim} | {count} |")
    lines.append("")

    # Per-data-type details (only those with discrepancies)
    lines.append("## Per-Data-Type Details")
    lines.append("")

    for dt_result in sorted(results['data_types'], key=lambda x: x['data_type']):
        if dt_result['discrepancy_count'] == 0:
            continue

        dt = dt_result['data_type']
        lines.append(f"### {dt}")
        lines.append("")
        lines.append(f"FHIR components: {dt_result['fhir_component_count']} | "
                    f"V291 components: {dt_result['v291_component_count']}")
        lines.append("")

        lines.append("| Seq | Component | Dimension | Severity | Expected (V291) | Actual (FHIR) |")
        lines.append("|-----|-----------|-----------|----------|-----------------|---------------|")

        for disc in dt_result['discrepancies']:
            lines.append(
                f"| {disc['seq']} | {disc['component_name']} | {disc['dimension']} "
                f"| {disc['severity']} | {disc['expected']} | {disc['actual']} |"
            )

        lines.append("")

    # Clean data types
    clean_count = sum(1 for dt in results['data_types'] if dt['discrepancy_count'] == 0)
    if clean_count > 0:
        lines.append(f"## Clean Data Types ({clean_count})")
        lines.append("")
        clean_names = [dt['data_type'] for dt in results['data_types']
                      if dt['discrepancy_count'] == 0]
        for i in range(0, len(clean_names), 15):
            chunk = clean_names[i:i+15]
            lines.append("`" + "`, `".join(chunk) + "`")
        lines.append("")

    with open(output_path, 'w') as f:
        f.write("\n".join(lines))


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description='Compare FHIR vs V291 data type components')
    parser.add_argument('--subset', help='Comma-separated list of data type codes')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = [s.strip().upper() for s in args.subset.split(',')]

    # Collect data type files
    fhir_files = sorted(Path(FHIR_DT_DIR).glob('*.json'))
    v291_files = sorted(Path(V291_DT_DIR).glob('*.json'))

    # Build lookup dicts
    fhir_by_code = {f.stem.upper(): f for f in fhir_files}
    v291_by_code = {f.stem.upper(): f for f in v291_files}

    # Determine comparison set
    if subset:
        codes_to_compare = [c for c in subset if c in fhir_by_code and c in v291_by_code]
    else:
        codes_to_compare = sorted(set(fhir_by_code.keys()) & set(v291_by_code.keys()))

    print(f"Comparing {len(codes_to_compare)} data types...")

    # Run comparisons
    all_results = []
    for code in codes_to_compare:
        fhir_data = load_json(str(fhir_by_code[code]))
        v291_data = load_json(str(v291_by_code[code]))

        if not fhir_data or not v291_data:
            print(f"  WARNING: Failed to load {code}")
            continue

        result = compare_data_type(code, fhir_data, v291_data)
        all_results.append(result)

        if result['discrepancy_count'] > 0:
            print(f"  {code}: {result['discrepancy_count']} discrepancies")

    # Build summary
    total_disc = sum(r['discrepancy_count'] for r in all_results)
    dt_with_disc = sum(1 for r in all_results if r['discrepancy_count'] > 0)

    by_severity = {}
    by_dimension = {}
    for r in all_results:
        for d in r['discrepancies']:
            sev = d['severity']
            dim = d['dimension']
            by_severity[sev] = by_severity.get(sev, 0) + 1
            by_dimension[dim] = by_dimension.get(dim, 0) + 1

    report = {
        'generated': datetime.now(timezone.utc).isoformat(),
        'summary': {
            'data_types_compared': len(codes_to_compare),
            'data_types_with_discrepancies': dt_with_disc,
            'total_discrepancies': total_disc,
            'by_severity': by_severity,
            'by_dimension': by_dimension,
        },
        'data_types': all_results,
    }

    # Write reports
    json_path = os.path.join(REPORT_DIR, 'data-type-comparison-report.json')
    write_json_report(report, json_path)
    print(f"\nJSON report: {json_path}")

    md_path = os.path.join(REPORT_DIR, 'data-type-comparison-report.md')
    write_markdown_report(report, md_path)
    print(f"Markdown report: {md_path}")

    # Print summary
    print(f"\n{'='*60}")
    print(f"DATA TYPE COMPARISON SUMMARY")
    print(f"{'='*60}")
    print(f"Data types compared: {len(codes_to_compare)}")
    print(f"Data types with discrepancies: {dt_with_disc}")
    print(f"Total discrepancies: {total_disc}")
    for sev in ['critical', 'error', 'warning', 'cosmetic']:
        count = by_severity.get(sev, 0)
        if count > 0:
            print(f"  {sev}: {count}")


if __name__ == '__main__':
    main()
