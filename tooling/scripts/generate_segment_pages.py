#!/usr/bin/env python3
"""Generate IG Publisher intro pages for Segment StructureDefinitions.

Reads Segment JSON files from input/sourceOfTruth/segment/segments/ and
produces StructureDefinition-{SEG}-intro.xml files in input/pagecontent/.
Each intro file contains a hidden div with an "HL7 Attribute Table" — the
classic V2 segment definition table with columns for Seq, Name, DataType,
Usage, Cardinality, Vocabulary, Item#, Length, C.LEN, and Flags.

The hidden div (#v2-segment-content) is discovered by v2-classic-tabs.js
and injected as a tab in the Formal Views tab set.

Usage:
    python3 tooling/scripts/generate_segment_pages.py
    python3 tooling/scripts/generate_segment_pages.py --subset MSH,PID,PV1
"""

import argparse
import glob
import os
import sys

from v2_utils import (
    load_json, escape_xml, write_xml_file, AnomalyLog,
    PROJECT_ROOT, SEGMENTS_DIR, OUTPUT_DIR,
)

ANOMALY_LOG_PATH = os.path.join(PROJECT_ROOT, 'tooling', 'scripts',
                                'generate_segment_pages_anomalies.log')


def get_extension(extensions, url_suffix):
    """Find an extension by URL suffix in a list of extensions.

    Args:
        extensions: List of FHIR extension dicts
        url_suffix: The ending of the extension URL to match (e.g. 'optionality')

    Returns:
        The matching extension dict, or None if not found
    """
    for ext in extensions:
        if ext.get('url', '').endswith(url_suffix):
            return ext
    return None


def get_sub_extension(extension, url):
    """Find a sub-extension within a complex extension.

    Args:
        extension: A FHIR extension dict that may contain nested extensions
        url: The sub-extension URL to match

    Returns:
        The matching sub-extension dict, or None if not found
    """
    for sub in extension.get('extension', []):
        if sub.get('url') == url:
            return sub
    return None


def parse_segment_fields(data, segment_id, anomalies):
    """Parse segment JSON elements into a list of field dicts.

    Skips the root element (the segment itself). For each field, extracts
    all metadata needed for the HL7 Attribute Table.

    Args:
        data: Parsed segment JSON dict
        segment_id: Segment ID string (e.g. "PID") for anomaly reporting
        anomalies: AnomalyLog instance

    Returns:
        List of dicts with keys: seq, name, data_type, usage, min_card,
        max_card, vocabulary, item_num, length_min, length_max, conf_length,
        no_truncate, is_withdrawn, definition, comment
    """
    elements = data.get('differential', {}).get('element', [])
    fields = []

    for elem in elements[1:]:  # Skip the root element
        path = elem.get('path', '')
        extensions = elem.get('extension', [])

        # Seq: number after the dot in the path (e.g. PID.1-setId -> 1)
        suffix = path.rsplit('.', 1)[-1] if '.' in path else ''
        seq = suffix.split('-', 1)[0] if suffix else ''

        # Name from short description
        name = elem.get('short', '')

        # DataType from type[0].code
        type_list = elem.get('type', [])
        data_type = type_list[0].get('code', '') if type_list else ''

        # Usage/Optionality from extension
        opt_ext = get_extension(extensions, 'optionality')
        usage = opt_ext.get('valueCode', '') if opt_ext else ''

        # Cardinality
        min_card = elem.get('min', 0)
        max_card = elem.get('max', '*')

        # Vocabulary from binding.valueSet
        binding = elem.get('binding', {})
        vocabulary = binding.get('valueSet', '')

        # Item# from code[0].code (data element number)
        codes = elem.get('code', [])
        item_num = codes[0].get('code', '') if codes else ''

        # Length from extension (complex extension with min/max sub-extensions)
        length_min = None
        length_max = None
        len_ext = get_extension(extensions, '/length')
        # Guard against matching 'conformance-length' — require the URL
        # to end with exactly '/length' or be 'length' without 'conformance'
        if len_ext and 'conformance' not in len_ext.get('url', ''):
            min_sub = get_sub_extension(len_ext, 'min')
            max_sub = get_sub_extension(len_ext, 'max')
            if min_sub:
                length_min = min_sub.get('valueInteger')
            if max_sub:
                length_max = max_sub.get('valueInteger')

        # Conformance length from extension
        conf_length = None
        no_truncate = None
        clen_ext = get_extension(extensions, 'conformance-length')
        if clen_ext:
            len_sub = get_sub_extension(clen_ext, 'length')
            trunc_sub = get_sub_extension(clen_ext, 'noTruncate')
            if len_sub:
                conf_length = len_sub.get('valueInteger')
            if trunc_sub:
                no_truncate = trunc_sub.get('valueInteger')

        # W = Withdrawn (strikethrough), B = Backward Compatible (deprecated, no strikethrough)
        is_withdrawn = usage == 'W'
        is_deprecated = usage == 'B'

        fields.append({
            'seq': seq,
            'name': name,
            'data_type': data_type,
            'usage': usage,
            'min_card': min_card,
            'max_card': max_card,
            'vocabulary': vocabulary,
            'item_num': item_num,
            'length_min': length_min,
            'length_max': length_max,
            'conf_length': conf_length,
            'no_truncate': no_truncate,
            'is_withdrawn': is_withdrawn,
            'is_deprecated': is_deprecated,
            'element_path': path,
        })

    return fields


def format_vocabulary(value_set_url):
    """Format a vocabulary binding URL for display in the table.

    Extracts the table number from URLs like
    'http://terminology.hl7.org/ValueSet/v2-0001' and creates a link.

    Args:
        value_set_url: Full ValueSet URL string

    Returns:
        HTML string with link, or empty string if no binding
    """
    if not value_set_url:
        return ''

    # Extract table number from URL (e.g. "v2-0001" -> "0001")
    parts = value_set_url.rsplit('/', 1)
    vs_id = parts[-1] if len(parts) > 1 else value_set_url

    # Display as table number if it matches the v2 pattern
    if vs_id.startswith('v2-'):
        table_num = vs_id[3:]  # Strip "v2-" prefix
        return f'<a href="https://terminology.hl7.org/ValueSet/{vs_id}">{table_num}</a>'

    return escape_xml(vs_id)


def format_length(length_min, length_max):
    """Format the length range for display.

    Args:
        length_min: Minimum length (int or None)
        length_max: Maximum length (int or None)

    Returns:
        Formatted string like "1..4", "1", or empty string
    """
    if length_min is None and length_max is None:
        return ''
    if length_min is not None and length_max is not None:
        min_val = int(length_min)
        max_val = int(length_max)
        if min_val == max_val:
            return str(min_val)
        return f'{min_val}..{max_val}'
    if length_max is not None:
        return str(int(length_max))
    return str(int(length_min))


def format_item_number(item_num):
    """Format the HL7 data element item number, zero-padded to 5 digits.

    Args:
        item_num: Raw item number (int or string)

    Returns:
        Zero-padded string like "00104", or empty string
    """
    if not item_num and item_num != 0:
        return ''
    return str(int(item_num)).zfill(5)


def format_flags(no_truncate):
    """Format the truncation flag for display.

    Args:
        no_truncate: 0 = truncation allowed (#), 1 = no truncation (=), None = empty

    Returns:
        '#' if truncation allowed, '=' if not, or empty string
    """
    if no_truncate is None:
        return ''
    return '=' if int(no_truncate) == 1 else '#'


def render_segment_table(segment_id, fields):
    """Render the HL7 Attribute Table HTML for a segment.

    Creates a hidden div containing a table with the classic V2 segment
    definition columns and per-field definitions below. Withdrawn fields
    are shown with muted styling. Styled after the v2plusDemo layout.

    Args:
        segment_id: Segment ID (e.g. "PID")
        fields: List of field dicts from parse_segment_fields()

    Returns:
        HTML string with the hidden div and table
    """
    rows = []
    for field in fields:
        if field['is_withdrawn']:
            row_class = ' class="v2-field-withdrawn"'
        elif field.get('is_deprecated'):
            row_class = ' class="v2-field-deprecated"'
        else:
            row_class = ''

        # DataType cell: link to StructureDefinition if type exists
        if field['data_type']:
            dt_display = (
                f'<a href="StructureDefinition-{field["data_type"]}.html">'
                f'{escape_xml(field["data_type"])}</a>'
            )
        else:
            dt_display = '<span class="v2-muted">\u2013</span>'

        # Cardinality display
        max_raw = str(field['max_card'])
        if max_raw == '0' and not field['is_withdrawn']:
            max_display = '*'  # fallback for unexpected 0 on active fields
        else:
            max_display = max_raw if max_raw != '0' else '0'
        cardinality = f'[{field["min_card"]}..{max_display}]'

        # Item# links to the Detailed Descriptions tab for this element
        item_formatted = format_item_number(field['item_num'])
        linkable = not field['is_withdrawn'] and field.get('element_path')
        if item_formatted and linkable:
            item_display = (
                f'<a href="StructureDefinition-{segment_id}-definitions.html'
                f'#{field["element_path"]}">{item_formatted}</a>'
            )
        else:
            item_display = item_formatted

        # Seq# links to the Detailed Descriptions anchor on the same page
        seq_display = escape_xml(str(field['seq']))
        if linkable:
            seq_display = (
                f'<a href="#a-{field["element_path"]}">{seq_display}</a>'
            )

        rows.append(
            f'<tr{row_class}>'
            f'<td class="v2-col-seq">{seq_display}</td>'
            f'<td>{escape_xml(field["name"])}</td>'
            f'<td class="v2-col-mono">{dt_display}</td>'
            f'<td>{escape_xml(field["usage"])}</td>'
            f'<td>{format_vocabulary(field["vocabulary"])}</td>'
            f'<td class="v2-col-mono">{cardinality}</td>'
            f'<td class="v2-col-mono">{item_display}</td>'
            f'<td class="v2-col-mono">{format_length(field["length_min"], field["length_max"])}</td>'
            f'<td class="v2-col-mono">{str(int(field["conf_length"])) if field["conf_length"] is not None else ""}</td>'
            f'<td class="v2-col-mono">{format_flags(field["no_truncate"])}</td>'
            f'</tr>'
        )

    # Header links point to segment-definitions explanation page (future)
    table_html = (
        '<table class="v2-segment-table">\n'
        '<thead><tr>'
        '<th>Seq#</th>'
        '<th>Data Element Name</th>'
        '<th>DataType</th>'
        '<th>Usage</th>'
        '<th>Vocabulary</th>'
        '<th>Cardinality</th>'
        '<th>Item#</th>'
        '<th>Length</th>'
        '<th>C.LEN</th>'
        '<th>Flags</th>'
        '</tr></thead>\n'
        '<tbody>\n'
        + '\n'.join(rows) + '\n'
        '</tbody>\n'
        '</table>'
    )

    return (
        f'<div id="v2-segment-content" style="display:none;">\n'
        f'{table_html}\n'
        f'</div>'
    )


def main():
    parser = argparse.ArgumentParser(
        description='Generate IG Publisher intro pages for Segment definitions')
    parser.add_argument('--subset', type=str, default=None,
                        help='Comma-separated list of segment IDs to process '
                             '(e.g. MSH,PID,PV1)')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = set(args.subset.split(','))

    anomalies = AnomalyLog()
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Find all segment JSON files
    segment_files = sorted(glob.glob(os.path.join(SEGMENTS_DIR, '*.json')))
    if subset:
        print(f'  Processing subset: {", ".join(sorted(subset))}')

    intro_count = 0

    for filepath in segment_files:
        segment_id = os.path.basename(filepath).replace('.json', '')

        if subset and segment_id not in subset:
            continue

        data = load_json(filepath)
        fields = parse_segment_fields(data, segment_id, anomalies)

        if not fields:
            anomalies.add(
                'NO_FIELDS', segment_id,
                f'Segment has no field elements in its differential. '
                f'No intro file will be generated.')
            continue

        table_html = render_segment_table(segment_id, fields)

        intro_path = os.path.join(OUTPUT_DIR,
                                  f'StructureDefinition-{segment_id}-intro.xml')
        write_xml_file(intro_path, table_html)
        intro_count += 1

    # Write anomaly log
    anomalies.write(ANOMALY_LOG_PATH, script_name='generate_segment_pages.py')
    log_rel = os.path.relpath(ANOMALY_LOG_PATH, PROJECT_ROOT)

    print(f'  {intro_count} segment intro files written')
    if anomalies.entries:
        print(f'  {len(anomalies.entries)} anomalies (see {log_rel})')


if __name__ == '__main__':
    main()
