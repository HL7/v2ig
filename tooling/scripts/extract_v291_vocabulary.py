#!/usr/bin/env python3
"""
Extract vocabulary/code tables from V2.9.1 CH02C_Tables.docx.

Extracts all 797 code tables, each containing up to 7 sub-sections:
  1. Concept Domain Information
  2. Code System Identification Information
  3. Code System Version Information
  4. Value Set Information
  5. Binding Information
  6. Table Metadata
  7. Coded Content (Value, Display Name, Definition, Comment, Status)

Output: One JSON file per table in v291-extracted/vocabulary/
        Plus a summary index at v291-extracted/vocabulary-index.json

Usage:
    python3 tooling/scripts/extract_v291_vocabulary.py
"""

import json
import os
import sys
import re
from pathlib import Path

try:
    import docx
except ImportError:
    print("ERROR: python-docx not installed. Run: pip install python-docx")
    sys.exit(1)


DOCX_PATH = "v2plus_docx/CH02C_Tables.docx"
OUTPUT_DIR = "v291-extracted/vocabulary"
INDEX_PATH = "v291-extracted/vocabulary-index.json"


def parse_kv_table(table):
    """Parse a 2-column key-value table into a dict."""
    result = {}
    for row in table.rows:
        cells = [cell.text.strip() for cell in row.cells]
        if len(cells) >= 2:
            key = cells[0]
            value = cells[1]
            if key:
                result[key] = value
    return result


def parse_coded_content_table(table):
    """Parse a coded content table (Value, Display Name, Definition, Comment, Status)."""
    if len(table.rows) < 1:
        return []

    # Get headers from first row
    headers = [cell.text.strip().lower() for cell in table.rows[0].cells]

    # Map header variations to canonical names
    header_map = {}
    for i, h in enumerate(headers):
        if 'value' in h and 'display' not in h:
            header_map[i] = 'value'
        elif 'display' in h:
            header_map[i] = 'displayName'
        elif 'definition' in h:
            header_map[i] = 'definition'
        elif 'comment' in h or 'usage' in h:
            header_map[i] = 'comment'
        elif 'status' in h:
            header_map[i] = 'status'
        else:
            header_map[i] = h.replace(' ', '_').replace('/', '_')

    codes = []
    for row_idx, row in enumerate(table.rows[1:], 1):
        cells = [cell.text.strip() for cell in row.cells]
        entry = {}
        for i, cell_text in enumerate(cells):
            if i in header_map:
                entry[header_map[i]] = cell_text
        # Only include rows that have a value
        if entry.get('value'):
            codes.append(entry)

    return codes


def classify_table(table):
    """Classify a Word table by its first cell content."""
    if len(table.rows) < 1:
        return 'unknown', {}

    first_cell = table.rows[0].cells[0].text.strip().lower()

    if 'concept domain name' in first_cell:
        return 'concept_domain', parse_kv_table(table)
    elif 'code system oid' in first_cell:
        return 'code_system', parse_kv_table(table)
    elif first_cell in ('effective date',):
        return 'code_system_version', parse_kv_table(table)
    elif 'value set oid' in first_cell:
        return 'value_set', parse_kv_table(table)
    elif first_cell in ('realm',):
        return 'binding', parse_kv_table(table)
    elif first_cell in ('table',):
        return 'table_metadata', parse_kv_table(table)
    elif first_cell in ('value',) or ('value' in first_cell and 'display' in table.rows[0].cells[1].text.strip().lower() if len(table.rows[0].cells) > 1 else False):
        return 'coded_content', parse_coded_content_table(table)
    else:
        return 'unknown', parse_kv_table(table)


def build_paragraph_index(doc):
    """Build an index mapping paragraph indices to their positions in the document XML.

    Returns a list of (paragraph_index, heading_text, table_number, table_name) for
    all Heading 3 paragraphs that represent code tables.
    """
    table_headings = []
    for i, p in enumerate(doc.paragraphs):
        if p.style and p.style.name == 'Heading 3':
            text = p.text.strip()
            if text and text[0].isdigit():
                parts = text.split(' - ', 1)
                table_num = parts[0].strip()
                table_name = parts[1].strip() if len(parts) > 1 else ''
                table_headings.append({
                    'para_idx': i,
                    'table_number': table_num,
                    'table_name': table_name,
                    'heading_text': text,
                })
    return table_headings


def map_tables_to_sections(doc, table_headings):
    """Map Word tables to their parent code table sections.

    Strategy: Use the XML element ordering to determine which Word tables
    fall between which heading paragraphs.
    """
    from lxml import etree

    body = doc.element.body
    nsmap = {'w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}

    # Build a flat list of all body-level elements with their types
    elements = []
    para_count = 0
    table_count = 0
    for child in body:
        tag = etree.QName(child.tag).localname if '}' in child.tag else child.tag
        if tag == 'p':
            elements.append(('para', para_count))
            para_count += 1
        elif tag == 'tbl':
            elements.append(('table', table_count))
            table_count += 1
        elif tag == 'sdt':
            # Structured document tags can contain paragraphs and tables
            for sub in child.iter():
                sub_tag = etree.QName(sub.tag).localname if '}' in sub.tag else sub.tag
                if sub_tag == 'p' and sub.getparent() is not None:
                    # Only count direct paragraph children of the SDT content
                    pass  # SDT paragraphs are already counted in doc.paragraphs
                elif sub_tag == 'tbl':
                    pass  # SDT tables handled similarly

    # Build heading paragraph index set
    heading_para_indices = {h['para_idx'] for h in table_headings}

    # Walk through elements and assign tables to the most recent heading
    sections = {h['table_number']: [] for h in table_headings}
    current_section = None

    for elem_type, elem_idx in elements:
        if elem_type == 'para' and elem_idx in heading_para_indices:
            # Find which heading this is
            for h in table_headings:
                if h['para_idx'] == elem_idx:
                    current_section = h['table_number']
                    break
        elif elem_type == 'table' and current_section is not None:
            sections[current_section].append(elem_idx)

    return sections


def extract_all_tables(doc_path, output_dir):
    """Extract all code tables from CH02C_Tables.docx."""
    print(f"Loading {doc_path}...")
    doc = docx.Document(doc_path)
    print(f"  Paragraphs: {len(doc.paragraphs)}")
    print(f"  Tables: {len(doc.tables)}")

    # Step 1: Find all table headings
    table_headings = build_paragraph_index(doc)
    print(f"  Code table sections: {len(table_headings)}")

    # Step 2: Map Word tables to their sections
    print("  Mapping tables to sections...")
    section_tables = map_tables_to_sections(doc, table_headings)

    # Step 3: Extract each section
    os.makedirs(output_dir, exist_ok=True)

    index = []
    stats = {
        'total_sections': len(table_headings),
        'with_codes': 0,
        'concept_domain_only': 0,
        'metadata_only': 0,
        'total_codes': 0,
        'with_code_system': 0,
        'with_value_set': 0,
        'errors': [],
    }

    for heading in table_headings:
        tnum = heading['table_number']
        tname = heading['table_name']
        word_table_indices = section_tables.get(tnum, [])

        record = {
            'tableNumber': tnum,
            'tableName': tname,
            'provenance': {
                'sourceFile': 'CH02C_Tables.docx',
                'headingText': heading['heading_text'],
            },
            'conceptDomain': None,
            'codeSystems': [],
            'codeSystemVersions': [],
            'valueSets': [],
            'bindings': [],
            'tableMetadata': None,
            'codedContent': [],
            'unknownTables': [],
        }

        for ti in word_table_indices:
            try:
                table = doc.tables[ti]
                ttype, data = classify_table(table)

                if ttype == 'concept_domain':
                    if record['conceptDomain'] is None:
                        record['conceptDomain'] = data
                    else:
                        # Duplicate concept domain (happens in ~2 tables)
                        record['conceptDomain'].update(data)
                elif ttype == 'code_system':
                    record['codeSystems'].append(data)
                elif ttype == 'code_system_version':
                    record['codeSystemVersions'].append(data)
                elif ttype == 'value_set':
                    record['valueSets'].append(data)
                elif ttype == 'binding':
                    record['bindings'].append(data)
                elif ttype == 'table_metadata':
                    record['tableMetadata'] = data
                elif ttype == 'coded_content':
                    record['codedContent'] = data
                elif ttype == 'unknown':
                    record['unknownTables'].append(data)
            except Exception as e:
                stats['errors'].append({
                    'tableNumber': tnum,
                    'wordTableIndex': ti,
                    'error': str(e),
                })

        # Clean up empty lists
        if not record['unknownTables']:
            del record['unknownTables']

        # Update stats
        if record['codedContent']:
            stats['with_codes'] += 1
            stats['total_codes'] += len(record['codedContent'])
        elif record['tableMetadata'] and not record['codeSystems']:
            stats['metadata_only'] += 1
        else:
            stats['concept_domain_only'] += 1

        if record['codeSystems']:
            stats['with_code_system'] += 1
        if record['valueSets']:
            stats['with_value_set'] += 1

        # Write individual file
        out_path = os.path.join(output_dir, f"{tnum}.json")
        with open(out_path, 'w') as f:
            json.dump(record, f, indent=2)

        # Add to index
        index_entry = {
            'tableNumber': tnum,
            'tableName': tname,
            'hasCodeSystem': bool(record['codeSystems']),
            'hasValueSet': bool(record['valueSets']),
            'hasCodedContent': bool(record['codedContent']),
            'codeCount': len(record['codedContent']),
        }

        # Include key identifiers if available
        if record['codeSystems']:
            cs = record['codeSystems'][0]
            index_entry['codeSystemOID'] = cs.get('Code System OID', '')
            index_entry['codeSystemSymbolicName'] = cs.get('SymbolicName', '')
        if record['valueSets']:
            vs = record['valueSets'][0]
            index_entry['valueSetOID'] = vs.get('Value Set OID', '')
            index_entry['valueSetURI'] = vs.get('URI', '')
            index_entry['valueSetSymbolicName'] = vs.get('SymbolicName', '')
        if record['conceptDomain']:
            cd = record['conceptDomain']
            index_entry['conceptDomainName'] = cd.get('SymbolicName', '')
        if record['tableMetadata']:
            tm = record['tableMetadata']
            index_entry['tableType'] = tm.get('Type', '')
            index_entry['steward'] = tm.get('Steward', '')
            index_entry['tableOID'] = tm.get('Table OID', '')

        index.append(index_entry)

    # Write index
    index_output = {
        'extractionDate': '2026-03-30',
        'sourceFile': 'CH02C_Tables.docx',
        'stats': stats,
        'tables': index,
    }
    with open(INDEX_PATH, 'w') as f:
        json.dump(index_output, f, indent=2)

    return stats


def main():
    # Resolve paths relative to workspace root
    workspace = Path(__file__).resolve().parent.parent.parent
    os.chdir(workspace)

    doc_path = DOCX_PATH
    if not os.path.exists(doc_path):
        print(f"ERROR: {doc_path} not found. Expected in workspace root.")
        sys.exit(1)

    stats = extract_all_tables(doc_path, OUTPUT_DIR)

    print(f"\n=== Extraction Complete ===")
    print(f"  Total tables: {stats['total_sections']}")
    print(f"  With coded content: {stats['with_codes']}")
    print(f"  Concept domain only: {stats['concept_domain_only']}")
    print(f"  Metadata only: {stats['metadata_only']}")
    print(f"  Total codes extracted: {stats['total_codes']}")
    print(f"  With code system: {stats['with_code_system']}")
    print(f"  With value set: {stats['with_value_set']}")
    if stats['errors']:
        print(f"  Errors: {len(stats['errors'])}")
        for err in stats['errors'][:5]:
            print(f"    Table {err['tableNumber']} (Word table {err['wordTableIndex']}): {err['error']}")
    print(f"\n  Output: {OUTPUT_DIR}/")
    print(f"  Index: {INDEX_PATH}")


if __name__ == '__main__':
    main()
