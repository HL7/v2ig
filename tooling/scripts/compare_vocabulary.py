#!/usr/bin/env python3
"""
Three-way vocabulary comparison: CH02C Word doc vs Colleague's IG vs UTG/THO.

Produces a comprehensive report comparing V2 code tables across sources.
Runs as two-way (CH02C vs Colleague) when UTG is not available.

Usage:
    python3 tooling/scripts/compare_vocabulary.py [--utg PATH]

Output:
    v291-extracted/vocabulary-comparison-report.json   (machine-readable)
    v291-extracted/vocabulary-comparison-report.md      (human-readable)
"""

import json
import os
import re
import sys
import argparse
import xml.etree.ElementTree as ET
from pathlib import Path
from collections import defaultdict

# FHIR XML namespace
FHIR_NS = {'fhir': 'http://hl7.org/fhir'}


def _fhir_val(element, child_tag):
    """Get the 'value' attribute of a FHIR XML child element."""
    child = element.find(f'fhir:{child_tag}', FHIR_NS)
    if child is not None:
        return child.get('value', '')
    return ''


def load_ch02c_data(vocab_dir, index_path):
    """Load all CH02C extracted vocabulary data."""
    with open(index_path) as f:
        index = json.load(f)

    tables = {}
    for entry in index['tables']:
        tnum = entry['tableNumber']
        fpath = os.path.join(vocab_dir, f"{tnum}.json")
        if os.path.exists(fpath):
            with open(fpath) as f:
                tables[tnum] = json.load(f)
    return tables, index


def load_colleague_data(resources_dir):
    """Load all CodeSystems and ValueSets from colleague's IG."""
    code_systems = {}
    value_sets = {}

    for fname in sorted(os.listdir(resources_dir)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(resources_dir, fname)
        with open(fpath) as f:
            r = json.load(f)

        rtype = r.get('resourceType', '')

        if rtype == 'CodeSystem':
            table_no = None
            for ext in r.get('extension', []):
                if 'tableNo' in ext.get('url', ''):
                    table_no = ext.get('valueString', '')
                    break
            if table_no:
                # Extract OID and v2 URL from identifiers
                oid = None
                v2url = None
                for ident in r.get('identifier', []):
                    val = ident.get('value', '')
                    if val.startswith('urn:oid:'):
                        oid = val.replace('urn:oid:', '')
                    elif 'v2-' in val:
                        v2url = val

                # Extract all concept codes with their properties
                concepts = {}
                for concept in r.get('concept', []):
                    code = concept.get('code', '')
                    props = {}
                    for prop in concept.get('property', []):
                        pcode = prop.get('code', '')
                        # Get value from whichever value field is present
                        for vkey in ('valueString', 'valueCode', 'valueBoolean',
                                     'valueInteger', 'valueDateTime', 'valueCoding'):
                            if vkey in prop:
                                props[pcode] = prop[vkey]
                                break
                    # Get designations
                    designations = []
                    for desig in concept.get('designation', []):
                        designations.append({
                            'language': desig.get('language', ''),
                            'value': desig.get('value', ''),
                        })

                    concepts[code] = {
                        'display': concept.get('display', ''),
                        'definition': concept.get('definition', ''),
                        'properties': props,
                        'designations': designations,
                    }

                code_systems[table_no] = {
                    'file': fname,
                    'id': r.get('id', ''),
                    'url': r.get('url', ''),
                    'name': r.get('name', ''),
                    'title': r.get('title', ''),
                    'status': r.get('status', ''),
                    'version': r.get('version', ''),
                    'description': r.get('description', ''),
                    'oid': oid,
                    'v2url': v2url,
                    'concepts': concepts,
                    'conceptCount': len(concepts),
                }

        elif rtype == 'ValueSet':
            table_no = None
            for ident in r.get('identifier', []):
                val = ident.get('value', '')
                m = re.search(r'v2-(\d{4})', val)
                if m:
                    table_no = m.group(1)
                    break
            if table_no:
                oid = None
                for ident in r.get('identifier', []):
                    val = ident.get('value', '')
                    if val.startswith('urn:oid:'):
                        oid = val.replace('urn:oid:', '')

                value_sets[table_no] = {
                    'file': fname,
                    'id': r.get('id', ''),
                    'url': r.get('url', ''),
                    'oid': oid,
                }

    return code_systems, value_sets


def load_utg_catalog(utg_path):
    """Load v2-tables.xml — the master catalog of all V2 tables known to UTG.

    This file is a CodeSystem used as a table-of-tables: each concept represents
    a V2 table number with properties for OIDs, URIs, table type, steward, etc.
    Returns a dict keyed by table number (e.g. '0001').
    """
    catalog_path = os.path.join(
        utg_path, 'input', 'sourceOfTruth', 'v2', 'v2-tables.xml'
    )
    if not os.path.exists(catalog_path):
        print(f"  Warning: v2-tables.xml not found at {catalog_path}")
        return {}

    tree = ET.parse(catalog_path)
    root = tree.getroot()

    catalog = {}
    for concept in root.findall('fhir:concept', FHIR_NS):
        table_no = _fhir_val(concept, 'code')
        if not table_no:
            continue

        props = {}
        for prop in concept.findall('fhir:property', FHIR_NS):
            code = _fhir_val(prop, 'code')
            for vtype in ('valueString', 'valueCode', 'valueInteger'):
                vel = prop.find(f'fhir:{vtype}', FHIR_NS)
                if vel is not None:
                    props[code] = vel.get('value', '')
                    break

        catalog[table_no] = {
            'display': _fhir_val(concept, 'display'),
            'definition': _fhir_val(concept, 'definition'),
            'tableOid': props.get('v2-table-oid', ''),
            'csOid': props.get('v2-cs-oid', ''),
            'csUri': props.get('v2-cs-uri', ''),
            'vsOid': props.get('v2-vs-oid', ''),
            'vsUri': props.get('v2-vs-uri', ''),
            'tableType': props.get('v2-table-type', ''),
            'steward': props.get('steward', ''),
            'whereUsed': props.get('v2-where-used', ''),
            'vocabDomain': props.get('vocab-domain', ''),
            'versionIntroduced': props.get('v2-version-tbl-introduced', ''),
        }

    return catalog


def load_utg_data(utg_path):
    """Load V2 CodeSystems and ValueSets from UTG repo (XML format)."""
    code_systems = {}
    value_sets = {}

    cs_dir = os.path.join(
        utg_path, 'input', 'sourceOfTruth', 'v2', 'codeSystems'
    )
    vs_dir = os.path.join(
        utg_path, 'input', 'sourceOfTruth', 'v2', 'valueSets'
    )

    if os.path.isdir(cs_dir):
        for fname in sorted(os.listdir(cs_dir)):
            if not fname.endswith('.xml'):
                continue
            fpath = os.path.join(cs_dir, fname)
            try:
                tree = ET.parse(fpath)
                root = tree.getroot()
            except ET.ParseError:
                continue

            # Verify it's a CodeSystem (tag includes namespace)
            if not root.tag.endswith('CodeSystem'):
                continue

            # Extract table number from id or url
            rid = _fhir_val(root, 'id')
            url = _fhir_val(root, 'url')
            table_no = None

            m = re.search(r'v2-(\d{4})', rid) or re.search(r'v2-(\d{4})', url)
            if m:
                table_no = m.group(1)
            if not table_no:
                m = re.search(r'v2-(\d{4})', fname)
                if m:
                    table_no = m.group(1)
            if not table_no:
                continue

            # Extract OID from identifiers
            oid = None
            for ident in root.findall('fhir:identifier', FHIR_NS):
                val_el = ident.find('fhir:value', FHIR_NS)
                if val_el is not None:
                    val = val_el.get('value', '')
                    if val.startswith('urn:oid:'):
                        oid = val.replace('urn:oid:', '')

            # Extract concepts
            concepts = {}
            for concept in root.findall('fhir:concept', FHIR_NS):
                code = _fhir_val(concept, 'code')
                if not code:
                    continue

                props = {}
                for prop in concept.findall('fhir:property', FHIR_NS):
                    pcode = _fhir_val(prop, 'code')
                    for vtype in ('valueString', 'valueCode', 'valueBoolean',
                                  'valueInteger', 'valueDateTime'):
                        vel = prop.find(f'fhir:{vtype}', FHIR_NS)
                        if vel is not None:
                            props[pcode] = vel.get('value', '')
                            break

                concepts[code] = {
                    'display': _fhir_val(concept, 'display'),
                    'definition': _fhir_val(concept, 'definition'),
                    'properties': props,
                }

            code_systems[table_no] = {
                'file': fname,
                'id': rid,
                'url': url,
                'name': _fhir_val(root, 'name'),
                'title': _fhir_val(root, 'title'),
                'status': _fhir_val(root, 'status'),
                'version': _fhir_val(root, 'version'),
                'description': _fhir_val(root, 'description'),
                'oid': oid,
                'concepts': concepts,
                'conceptCount': len(concepts),
            }

    if os.path.isdir(vs_dir):
        for fname in sorted(os.listdir(vs_dir)):
            if not fname.endswith('.xml'):
                continue
            fpath = os.path.join(vs_dir, fname)
            try:
                tree = ET.parse(fpath)
                root = tree.getroot()
            except ET.ParseError:
                continue

            if not root.tag.endswith('ValueSet'):
                continue

            rid = _fhir_val(root, 'id')
            url = _fhir_val(root, 'url')
            table_no = None
            m = re.search(r'v2-(\d{4})', rid) or re.search(r'v2-(\d{4})', url)
            if m:
                table_no = m.group(1)
            if not table_no:
                m = re.search(r'v2-(\d{4})', fname)
                if m:
                    table_no = m.group(1)
            if not table_no:
                continue

            oid = None
            for ident in root.findall('fhir:identifier', FHIR_NS):
                val_el = ident.find('fhir:value', FHIR_NS)
                if val_el is not None:
                    val = val_el.get('value', '')
                    if val.startswith('urn:oid:'):
                        oid = val.replace('urn:oid:', '')

            value_sets[table_no] = {
                'file': fname,
                'id': rid,
                'url': url,
                'oid': oid,
            }

    return code_systems, value_sets


def normalize_status(status):
    """Normalize status codes to a canonical form for comparison.

    CH02C uses single letters: D, B, N, R, A
    Colleague/UTG use words: inactive, backward, new, retired, active
    """
    s = status.strip().upper()
    mapping = {
        'D': 'deprecated',
        'B': 'backward',
        'N': 'new',
        'R': 'retired',
        'A': 'active',
        'INACTIVE': 'deprecated',
        'DEPRECATED': 'deprecated',
        'BACKWARD': 'backward',
        'NEW': 'new',
        'RETIRED': 'retired',
        'ACTIVE': 'active',
    }
    return mapping.get(s, status.lower().strip())


def compare_codes(ch02c_codes, colleague_concepts, utg_concepts=None):
    """Compare coded content across sources at the individual code level."""
    ch02c_code_set = {c['value'] for c in ch02c_codes} if ch02c_codes else set()
    colleague_code_set = set(colleague_concepts.keys()) if colleague_concepts else set()
    utg_code_set = set(utg_concepts.keys()) if utg_concepts else set()

    all_codes = ch02c_code_set | colleague_code_set | utg_code_set

    code_diffs = []
    for code in sorted(all_codes):
        in_ch02c = code in ch02c_code_set
        in_colleague = code in colleague_code_set
        in_utg = code in utg_code_set if utg_concepts is not None else None

        # Get display names from each source
        ch02c_display = ''
        ch02c_definition = ''
        ch02c_status = ''
        if in_ch02c:
            for c in ch02c_codes:
                if c['value'] == code:
                    ch02c_display = c.get('displayName', '')
                    ch02c_definition = c.get('definition', '')
                    ch02c_status = c.get('status', '')
                    break

        colleague_display = ''
        colleague_definition = ''
        colleague_status = ''
        if in_colleague:
            cc = colleague_concepts[code]
            colleague_display = cc.get('display', '')
            colleague_definition = cc.get('definition', '')
            colleague_status = cc.get('properties', {}).get('status', '')

        utg_display = ''
        utg_definition = ''
        utg_status = ''
        if utg_concepts and in_utg:
            uc = utg_concepts[code]
            utg_display = uc.get('display', '')
            utg_definition = uc.get('definition', '')
            utg_status = uc.get('properties', {}).get('status', '')

        # Determine differences
        diff_entry = {
            'code': code,
            'inCH02C': in_ch02c,
            'inColleague': in_colleague,
        }
        if utg_concepts is not None:
            diff_entry['inUTG'] = in_utg

        differences = []

        # Presence differences
        if not in_ch02c:
            differences.append('missing_from_ch02c')
        if not in_colleague:
            differences.append('missing_from_colleague')
        if utg_concepts is not None and not in_utg:
            differences.append('missing_from_utg')

        # Display name differences
        displays = {'ch02c': ch02c_display, 'colleague': colleague_display}
        if utg_concepts is not None:
            displays['utg'] = utg_display
        diff_entry['displays'] = displays

        present_displays = {k: v for k, v in displays.items() if v}
        if len(set(v.lower().strip() for v in present_displays.values())) > 1:
            # Classify: is this just a truncation (one is prefix of another)?
            vals = list(present_displays.values())
            vals_lower = [v.lower().strip() for v in vals]
            is_truncation = any(
                vals_lower[i].startswith(vals_lower[j]) or vals_lower[j].startswith(vals_lower[i])
                for i in range(len(vals_lower))
                for j in range(i+1, len(vals_lower))
            )
            if is_truncation:
                differences.append('display_truncation')
            else:
                differences.append('display_mismatch')

        # Definition differences
        definitions = {'ch02c': ch02c_definition, 'colleague': colleague_definition}
        if utg_concepts is not None:
            definitions['utg'] = utg_definition
        diff_entry['definitions'] = definitions

        # Status differences
        statuses = {'ch02c': ch02c_status, 'colleague': colleague_status}
        if utg_concepts is not None:
            statuses['utg'] = utg_status
        diff_entry['statuses'] = statuses

        present_statuses = {k: v for k, v in statuses.items() if v}
        if len(set(normalize_status(v) for v in present_statuses.values())) > 1:
            differences.append('status_mismatch')

        diff_entry['differences'] = differences
        if differences:
            code_diffs.append(diff_entry)

    return code_diffs


def compare_metadata(ch02c_table, colleague_cs, utg_cs=None):
    """Compare table-level metadata across sources."""
    diffs = {}

    # Code System OID comparison
    ch02c_cs_oid = ''
    if ch02c_table.get('codeSystems'):
        ch02c_cs_oid = ch02c_table['codeSystems'][0].get('Code System OID', '')

    colleague_cs_oid = colleague_cs.get('oid', '') if colleague_cs else ''
    utg_cs_oid = utg_cs.get('oid', '') if utg_cs else ''

    oids = {'ch02c': ch02c_cs_oid, 'colleague': colleague_cs_oid}
    if utg_cs is not None:
        oids['utg'] = utg_cs_oid
    present_oids = {k: v for k, v in oids.items() if v}
    if len(set(present_oids.values())) > 1:
        diffs['codeSystemOID'] = oids

    # Value Set OID comparison
    ch02c_vs_oid = ''
    if ch02c_table.get('valueSets'):
        ch02c_vs_oid = ch02c_table['valueSets'][0].get('Value Set OID', '')

    # Symbolic name / name comparison
    ch02c_name = ''
    if ch02c_table.get('codeSystems'):
        ch02c_name = ch02c_table['codeSystems'][0].get('SymbolicName', '')

    colleague_name = colleague_cs.get('name', '') if colleague_cs else ''
    utg_name = utg_cs.get('name', '') if utg_cs else ''

    names = {'ch02c': ch02c_name, 'colleague': colleague_name}
    if utg_cs is not None:
        names['utg'] = utg_name
    present_names = {k: v for k, v in names.items() if v}
    if len(set(v.lower() for v in present_names.values())) > 1:
        diffs['symbolicName'] = names

    # Description comparison
    ch02c_desc = ''
    if ch02c_table.get('tableMetadata'):
        ch02c_desc = ch02c_table['tableMetadata'].get('Description', '')

    colleague_desc = colleague_cs.get('description', '') if colleague_cs else ''
    utg_desc = utg_cs.get('description', '') if utg_cs else ''

    descs = {'ch02c': ch02c_desc, 'colleague': colleague_desc}
    if utg_cs is not None:
        descs['utg'] = utg_desc
    present_descs = {k: v for k, v in descs.items() if v and v.lower() != 'tbd'}
    if len(set(v.lower().strip() for v in present_descs.values())) > 1:
        diffs['description'] = descs

    # Table type comparison
    ch02c_type = ''
    if ch02c_table.get('tableMetadata'):
        ch02c_type = ch02c_table['tableMetadata'].get('Type', '')
    if ch02c_type:
        diffs['tableType'] = ch02c_type  # Just record for reference

    return diffs


def run_comparison(ch02c_tables, ch02c_index,
                   colleague_cs, colleague_vs,
                   utg_cs=None, utg_vs=None):
    """Run the full comparison and produce the report."""

    has_utg = utg_cs is not None

    # All table numbers across all sources
    all_tables = set(ch02c_tables.keys())
    all_tables.update(colleague_cs.keys())
    if has_utg:
        all_tables.update(utg_cs.keys())

    report = {
        'summary': {},
        'tables': [],
    }

    # Categorize each table
    category_counts = defaultdict(int)
    tables_with_code_diffs = 0
    tables_with_metadata_diffs = 0
    total_code_diffs = 0

    for tnum in sorted(all_tables):
        ch02c = ch02c_tables.get(tnum)
        ccs = colleague_cs.get(tnum)
        ucs = utg_cs.get(tnum) if has_utg else None

        table_entry = {
            'tableNumber': tnum,
            'tableName': ch02c['tableName'] if ch02c else (ccs.get('title', '') if ccs else (ucs.get('title', '') if ucs else '')),
            'presence': {
                'ch02c': tnum in ch02c_tables,
                'colleague': tnum in colleague_cs,
            },
        }
        if has_utg:
            table_entry['presence']['utg'] = tnum in (utg_cs or {})

        # Classify the table type from CH02C
        table_type = 'unknown'
        has_codes_in_ch02c = False
        if ch02c:
            if ch02c.get('codedContent'):
                has_codes_in_ch02c = True
            tm = ch02c.get('tableMetadata', {})
            if tm:
                table_type = tm.get('Type', 'unknown')
            cd = ch02c.get('conceptDomain', {})
            if cd and cd.get('Concept Domain Only', '').lower() == 'yes':
                table_type = 'ConceptDomainOnly'

        table_entry['tableType'] = table_type

        # Links to published resources
        table_entry['links'] = {}
        if ccs:
            table_entry['links']['colleague_id'] = ccs.get('id', '')
            table_entry['links']['colleague_url'] = ccs.get('url', '')
        if ucs:
            table_entry['links']['utg_id'] = ucs.get('id', '')
            table_entry['links']['utg_url'] = ucs.get('url', '')

        # Concept domain info from CH02C
        if ch02c:
            cd_info = ch02c.get('conceptDomain', {})
            if cd_info:
                table_entry['conceptDomain'] = {
                    'name': cd_info.get('Concept Domain Name', ''),
                    'symbolicName': cd_info.get('SymbolicName', ''),
                    'isConceptDomainOnly': cd_info.get(
                        'Concept Domain Only', '').lower() == 'yes',
                }
            # Capture code system URI info from CH02C
            cs_list = ch02c.get('codeSystems', [])
            if cs_list:
                cs_info = cs_list[0]
                table_entry['ch02cCodeSystem'] = {
                    'oid': cs_info.get('Code System OID', ''),
                    'name': cs_info.get('SymbolicName', ''),
                    'uri': cs_info.get('URI', ''),
                }

        # Presence category
        in_ch02c = tnum in ch02c_tables
        in_colleague = tnum in colleague_cs
        in_utg = tnum in (utg_cs or {}) if has_utg else None

        if in_ch02c and in_colleague and (not has_utg or in_utg):
            category = 'all_sources'
        elif in_ch02c and in_colleague:
            category = 'ch02c_and_colleague'
        elif in_ch02c and (has_utg and in_utg):
            category = 'ch02c_and_utg'
        elif in_colleague and (has_utg and in_utg):
            category = 'colleague_and_utg'
        elif in_ch02c:
            category = 'ch02c_only'
        elif in_colleague:
            category = 'colleague_only'
        else:
            category = 'utg_only'

        table_entry['category'] = category
        category_counts[category] += 1

        # Code-level comparison (only if at least two sources have data)
        ch02c_codes = ch02c.get('codedContent', []) if ch02c else []
        colleague_concepts = ccs.get('concepts', {}) if ccs else {}
        utg_concepts = ucs.get('concepts', {}) if ucs else None

        sources_with_codes = sum([
            bool(ch02c_codes),
            bool(colleague_concepts),
            bool(utg_concepts) if has_utg else False,
        ])

        if sources_with_codes >= 1:
            code_diffs = compare_codes(
                ch02c_codes, colleague_concepts,
                utg_concepts if has_utg else None
            )
            if code_diffs:
                table_entry['codeDifferences'] = code_diffs
                tables_with_code_diffs += 1
                total_code_diffs += len(code_diffs)

            table_entry['codeCounts'] = {
                'ch02c': len(ch02c_codes),
                'colleague': len(colleague_concepts),
            }
            if has_utg:
                table_entry['codeCounts']['utg'] = len(utg_concepts) if utg_concepts else 0

        # Metadata comparison
        metadata_diffs = compare_metadata(
            ch02c if ch02c else {},
            ccs,
            ucs if has_utg else None
        )
        if metadata_diffs:
            table_entry['metadataDifferences'] = metadata_diffs
            if any(k != 'tableType' for k in metadata_diffs):
                tables_with_metadata_diffs += 1

        report['tables'].append(table_entry)

    # Summary
    report['summary'] = {
        'totalTables': len(all_tables),
        'categoryCounts': dict(category_counts),
        'tablesWithCodeDifferences': tables_with_code_diffs,
        'tablesWithMetadataDifferences': tables_with_metadata_diffs,
        'totalCodeDifferences': total_code_diffs,
        'sources': ['ch02c', 'colleague'] + (['utg'] if has_utg else []),
    }

    return report


def generate_markdown_report(report, output_path):
    """Generate a human-readable markdown report."""
    has_utg = 'utg' in report['summary']['sources']
    s = report['summary']

    lines = []
    lines.append("# V2 Vocabulary Comparison Report")
    lines.append("")
    sources_str = "CH02C (Word) vs Colleague's IG (frankoemig)"
    if has_utg:
        sources_str += " vs UTG/THO"
    lines.append(f"**Sources:** {sources_str}")
    lines.append(f"**Generated:** 2026-03-30")
    lines.append("")

    # Summary
    lines.append("## Summary")
    lines.append("")
    lines.append(f"| Metric | Count |")
    lines.append(f"|--------|-------|")
    lines.append(f"| Total unique tables across all sources | {s['totalTables']} |")
    for cat, count in sorted(s['categoryCounts'].items()):
        cat_label = cat.replace('_', ' ').title()
        lines.append(f"| {cat_label} | {count} |")
    lines.append(f"| Tables with code-level differences | {s['tablesWithCodeDifferences']} |")
    lines.append(f"| Tables with metadata differences | {s['tablesWithMetadataDifferences']} |")
    lines.append(f"| Total individual code differences | {s['totalCodeDifferences']} |")
    lines.append("")

    # Tables present in CH02C but missing from colleague
    ch02c_only = [t for t in report['tables']
                  if t['category'] in ('ch02c_only', 'ch02c_and_utg')]
    ch02c_only_with_codes = [t for t in ch02c_only
                             if t.get('codeCounts', {}).get('ch02c', 0) > 0]
    ch02c_only_no_codes = [t for t in ch02c_only
                           if t.get('codeCounts', {}).get('ch02c', 0) == 0]

    if ch02c_only_with_codes:
        lines.append("## Tables in CH02C WITH Codes — Missing from Colleague")
        lines.append("")
        lines.append("These tables have HL7-defined coded content in the Word document but no corresponding CodeSystem in the colleague's IG.")
        lines.append("")
        if has_utg:
            lines.append("| Table | Name | Type | CH02C Codes | In UTG? | UTG Codes |")
            lines.append("|-------|------|------|-------------|---------|-----------|")
            for t in ch02c_only_with_codes:
                ttype = t.get('tableType', '')
                tnum = t['tableNumber']
                in_utg = 'Yes' if t.get('presence', {}).get('utg') else 'No'
                utg_codes = t.get('codeCounts', {}).get('utg', 0) if t.get('presence', {}).get('utg') else '-'
                lines.append(f"| {tnum} | {t['tableName']} | {ttype} | {t.get('codeCounts', {}).get('ch02c', '?')} | {in_utg} | {utg_codes} |")
        else:
            lines.append("| Table | Name | Type | Codes | Steward |")
            lines.append("|-------|------|------|-------|---------|")
            for t in ch02c_only_with_codes:
                ttype = t.get('tableType', '')
                tnum = t['tableNumber']
                lines.append(f"| {tnum} | {t['tableName']} | {ttype} | {t.get('codeCounts', {}).get('ch02c', '?')} | |")
        lines.append("")

    if ch02c_only_no_codes:
        lines.append("## Tables in CH02C WITHOUT Codes — Missing from Colleague")
        lines.append("")
        lines.append(f"These {len(ch02c_only_no_codes)} tables are concept-domain-only, externally-defined, or user-defined tables ")
        lines.append("with no HL7-managed coded content. It is expected that the colleague's IG does not include them.")
        lines.append("")
        # Just show the count and first few as examples
        lines.append("<details>")
        lines.append(f"<summary>Show all {len(ch02c_only_no_codes)} tables</summary>")
        lines.append("")
        lines.append("| Table | Name | Type |")
        lines.append("|-------|------|------|")
        for t in ch02c_only_no_codes:
            lines.append(f"| {t['tableNumber']} | {t['tableName']} | {t.get('tableType', '')} |")
        lines.append("")
        lines.append("</details>")
        lines.append("")

    # Tables with code-level differences
    tables_with_diffs = [t for t in report['tables'] if t.get('codeDifferences')]
    if tables_with_diffs:
        lines.append("## Tables with Code-Level Differences")
        lines.append("")

        for t in tables_with_diffs:
            tnum = t['tableNumber']
            counts = t.get('codeCounts', {})
            count_str = f"CH02C: {counts.get('ch02c', 0)}, Colleague: {counts.get('colleague', 0)}"
            if has_utg:
                count_str += f", UTG: {counts.get('utg', 0)}"

            diffs = t['codeDifferences']
            display_mismatches = [d for d in diffs if 'display_mismatch' in d.get('differences', [])]
            display_truncations = [d for d in diffs if 'display_truncation' in d.get('differences', [])]
            status_mismatches = [d for d in diffs if 'status_mismatch' in d.get('differences', [])]

            # Categorize missing codes precisely by which sources have them
            in_ch02c_not_colleague = [d for d in diffs
                                       if d.get('inCH02C') and not d.get('inColleague')]
            in_colleague_not_ch02c = [d for d in diffs
                                       if d.get('inColleague') and not d.get('inCH02C')]
            if has_utg:
                in_utg_only = [d for d in diffs
                               if d.get('inUTG') and not d.get('inCH02C') and not d.get('inColleague')]
                missing_from_utg = [d for d in diffs
                                     if 'missing_from_utg' in d.get('differences', [])
                                     and (d.get('inCH02C') or d.get('inColleague'))]
                # Remove UTG-only codes from the ch02c/colleague missing lists
                # (they belong in the UTG-only section instead)
                in_ch02c_not_colleague = [d for d in in_ch02c_not_colleague
                                           if not (d.get('inUTG') and not d.get('inCH02C'))]
                in_colleague_not_ch02c = [d for d in in_colleague_not_ch02c
                                           if not (d.get('inUTG') and not d.get('inColleague'))]
            else:
                in_utg_only = []
                missing_from_utg = []

            has_substantive = (in_ch02c_not_colleague or in_colleague_not_ch02c
                               or in_utg_only or missing_from_utg
                               or display_mismatches or status_mismatches)
            if not has_substantive and display_truncations:
                pass

            lines.append(f"### Table {tnum} — {t['tableName']}")
            lines.append(f"Code counts: {count_str}")
            lines.append("")

            if in_ch02c_not_colleague:
                lines.append(f"**Codes in CH02C but not in Colleague ({len(in_ch02c_not_colleague)}):**")
                lines.append("")
                for d in in_ch02c_not_colleague:
                    disp = d['displays'].get('ch02c', '')
                    utg_note = ""
                    if has_utg:
                        utg_note = " *(also in UTG)*" if d.get('inUTG') else " *(not in UTG either)*"
                    lines.append(f"- `{d['code']}` — {disp}{utg_note}")
                lines.append("")

            if in_colleague_not_ch02c:
                lines.append(f"**Codes in Colleague but not in CH02C ({len(in_colleague_not_ch02c)}):**")
                lines.append("")
                for d in in_colleague_not_ch02c:
                    disp = d['displays'].get('colleague', '')
                    utg_note = ""
                    if has_utg:
                        utg_note = " *(also in UTG)*" if d.get('inUTG') else " *(not in UTG either)*"
                    lines.append(f"- `{d['code']}` — {disp}{utg_note}")
                lines.append("")

            if in_utg_only:
                lines.append(f"**Codes only in UTG ({len(in_utg_only)}):**")
                lines.append("")
                for d in in_utg_only:
                    disp = d['displays'].get('utg', '')
                    lines.append(f"- `{d['code']}` — {disp}")
                lines.append("")

            if missing_from_utg:
                lines.append(f"**Codes in CH02C/Colleague but missing from UTG ({len(missing_from_utg)}):**")
                lines.append("")
                for d in missing_from_utg:
                    disp = d['displays'].get('ch02c', '') or d['displays'].get('colleague', '')
                    lines.append(f"- `{d['code']}` — {disp}")
                lines.append("")

            if display_mismatches:
                lines.append(f"**Display name differences ({len(display_mismatches)}):**")
                lines.append("")
                if has_utg:
                    lines.append("| Code | CH02C | Colleague | UTG |")
                    lines.append("|------|-------|-----------|-----|")
                    for d in display_mismatches:
                        lines.append(f"| `{d['code']}` | {d['displays'].get('ch02c', '')} | {d['displays'].get('colleague', '')} | {d['displays'].get('utg', '')} |")
                else:
                    lines.append("| Code | CH02C | Colleague |")
                    lines.append("|------|-------|-----------|")
                    for d in display_mismatches:
                        lines.append(f"| `{d['code']}` | {d['displays'].get('ch02c', '')} | {d['displays'].get('colleague', '')} |")
                lines.append("")

            if display_truncations:
                lines.append(f"**Display name truncations ({len(display_truncations)}):** Colleague uses shorter form (parenthetical/detail stripped)")
                lines.append("")
                if has_utg:
                    lines.append("| Code | CH02C | Colleague | UTG |")
                    lines.append("|------|-------|-----------|-----|")
                    for d in display_truncations:
                        lines.append(f"| `{d['code']}` | {d['displays'].get('ch02c', '')} | {d['displays'].get('colleague', '')} | {d['displays'].get('utg', '')} |")
                else:
                    lines.append("| Code | CH02C | Colleague |")
                    lines.append("|------|-------|-----------|")
                    for d in display_truncations:
                        lines.append(f"| `{d['code']}` | {d['displays'].get('ch02c', '')} | {d['displays'].get('colleague', '')} |")
                lines.append("")

            if status_mismatches:
                lines.append(f"**Status mismatches ({len(status_mismatches)}):**")
                lines.append("")
                for d in status_mismatches:
                    status_str = f"CH02C=`{d['statuses'].get('ch02c', '')}`, Colleague=`{d['statuses'].get('colleague', '')}`"
                    if has_utg:
                        status_str += f", UTG=`{d['statuses'].get('utg', '')}`"
                    lines.append(f"- `{d['code']}`: {status_str}")
                lines.append("")

    # Metadata differences
    tables_with_meta_diffs = [t for t in report['tables']
                              if t.get('metadataDifferences')
                              and any(k != 'tableType' for k in t['metadataDifferences'])]
    if tables_with_meta_diffs:
        lines.append("## Tables with Metadata Differences")
        lines.append("")
        if has_utg:
            lines.append("| Table | Name | Difference Type | CH02C | Colleague | UTG |")
            lines.append("|-------|------|----------------|-------|-----------|-----|")
        else:
            lines.append("| Table | Name | Difference Type | CH02C | Colleague |")
            lines.append("|-------|------|----------------|-------|-----------|")
        for t in tables_with_meta_diffs:
            for diff_type, diff_val in t['metadataDifferences'].items():
                if diff_type == 'tableType':
                    continue
                if isinstance(diff_val, dict):
                    ch02c_val = diff_val.get('ch02c', '')
                    coll_val = diff_val.get('colleague', '')
                    if has_utg:
                        utg_val = diff_val.get('utg', '')
                        lines.append(f"| {t['tableNumber']} | {t['tableName']} | {diff_type} | {ch02c_val} | {coll_val} | {utg_val} |")
                    else:
                        lines.append(f"| {t['tableNumber']} | {t['tableName']} | {diff_type} | {ch02c_val} | {coll_val} |")
        lines.append("")

    # UTG-specific sections
    if has_utg:
        # Presence overview across all three sources
        lines.append("## Three-Way Presence Overview")
        lines.append("")
        lines.append("| Category | Count | Description |")
        lines.append("|----------|-------|-------------|")
        cat_descriptions = {
            'all_sources': 'Table with CodeSystem in all three sources',
            'ch02c_and_colleague': 'In CH02C and Colleague but not UTG',
            'ch02c_and_utg': 'In CH02C and UTG but not Colleague',
            'colleague_and_utg': 'In Colleague and UTG but not CH02C',
            'ch02c_only': 'Only in CH02C (not in Colleague or UTG)',
            'colleague_only': 'Only in Colleague',
            'utg_only': 'Only in UTG',
        }
        for cat in ['all_sources', 'ch02c_and_colleague', 'ch02c_and_utg',
                     'colleague_and_utg', 'ch02c_only', 'colleague_only', 'utg_only']:
            count = s['categoryCounts'].get(cat, 0)
            desc = cat_descriptions.get(cat, cat)
            lines.append(f"| {cat} | {count} | {desc} |")
        lines.append("")

        # Tables in Colleague and UTG but not CH02C (these might be additions)
        colleague_and_utg = [t for t in report['tables'] if t['category'] == 'colleague_and_utg']
        if colleague_and_utg:
            lines.append("## Tables in Colleague AND UTG — Not in CH02C")
            lines.append("")
            lines.append("These tables exist in both the colleague's IG and UTG but are not in CH02C.")
            lines.append("")
            lines.append("| Table | Name | Colleague Codes | UTG Codes |")
            lines.append("|-------|------|-----------------|-----------|")
            for t in colleague_and_utg:
                counts = t.get('codeCounts', {})
                lines.append(f"| {t['tableNumber']} | {t['tableName']} | {counts.get('colleague', 0)} | {counts.get('utg', 0)} |")
            lines.append("")

        # Tables in CH02C and Colleague but NOT in UTG (gap in THO)
        ch02c_and_colleague_only = [t for t in report['tables']
                                     if t['category'] == 'ch02c_and_colleague']
        if ch02c_and_colleague_only:
            lines.append("## Tables in CH02C and Colleague — Missing from UTG")
            lines.append("")
            lines.append("These tables are in both the published standard and colleague's IG but have no CodeSystem in UTG/THO.")
            lines.append("")
            lines.append("| Table | Name | Type | CH02C Codes | Colleague Codes |")
            lines.append("|-------|------|------|-------------|-----------------|")
            for t in ch02c_and_colleague_only:
                counts = t.get('codeCounts', {})
                lines.append(f"| {t['tableNumber']} | {t['tableName']} | {t.get('tableType', '')} | {counts.get('ch02c', 0)} | {counts.get('colleague', 0)} |")
            lines.append("")

        # UTG-only tables
        utg_only = [t for t in report['tables'] if t['category'] == 'utg_only']
        if utg_only:
            lines.append("## Tables Only in UTG")
            lines.append("")
            lines.append("These tables have a CodeSystem in UTG but are not in CH02C or the colleague's IG.")
            lines.append("")
            lines.append("| Table | Name | UTG Codes |")
            lines.append("|-------|------|-----------|")
            for t in utg_only:
                counts = t.get('codeCounts', {})
                lines.append(f"| {t['tableNumber']} | {t['tableName']} | {counts.get('utg', 0)} |")
            lines.append("")

    with open(output_path, 'w') as f:
        f.write('\n'.join(lines))


def main():
    parser = argparse.ArgumentParser(description='V2 Vocabulary Comparison')
    parser.add_argument('--utg', help='Path to UTG repo')
    args = parser.parse_args()

    workspace = Path(__file__).resolve().parent.parent.parent
    os.chdir(workspace)

    print("Loading CH02C extracted data...")
    ch02c_tables, ch02c_index = load_ch02c_data(
        'v291-extracted/vocabulary',
        'v291-extracted/vocabulary-index.json'
    )
    print(f"  {len(ch02c_tables)} tables loaded")

    print("Loading colleague's IG...")
    colleague_cs, colleague_vs = load_colleague_data(
        'hl7.v2.terminology.v291/input/resources'
    )
    print(f"  {len(colleague_cs)} CodeSystems, {len(colleague_vs)} ValueSets")

    utg_cs = None
    utg_vs = None
    utg_catalog = None
    if args.utg:
        print(f"Loading UTG v2-tables.xml catalog...")
        utg_catalog = load_utg_catalog(args.utg)
        print(f"  {len(utg_catalog)} table entries in catalog")

        print(f"Loading UTG V2 CodeSystems and ValueSets (XML)...")
        utg_cs, utg_vs = load_utg_data(args.utg)
        print(f"  {len(utg_cs)} CodeSystems, {len(utg_vs)} ValueSets")

        # Show tables in catalog but without a CodeSystem file
        catalog_only = set(utg_catalog.keys()) - set(utg_cs.keys())
        print(f"  {len(catalog_only)} catalog entries without a CodeSystem file")

    print("Running comparison...")
    report = run_comparison(
        ch02c_tables, ch02c_index,
        colleague_cs, colleague_vs,
        utg_cs, utg_vs,
    )

    # Write JSON report
    json_path = 'v291-extracted/vocabulary-comparison-report.json'
    with open(json_path, 'w') as f:
        json.dump(report, f, indent=2)
    print(f"  JSON report: {json_path}")

    # Write Markdown report
    md_path = 'v291-extracted/vocabulary-comparison-report.md'
    generate_markdown_report(report, md_path)
    print(f"  Markdown report: {md_path}")

    # Print summary
    s = report['summary']
    print(f"\n=== Comparison Summary ===")
    print(f"  Total tables: {s['totalTables']}")
    for cat, count in sorted(s['categoryCounts'].items()):
        print(f"  {cat}: {count}")
    print(f"  Tables with code differences: {s['tablesWithCodeDifferences']}")
    print(f"  Tables with metadata differences: {s['tablesWithMetadataDifferences']}")
    print(f"  Total code-level differences: {s['totalCodeDifferences']}")


if __name__ == '__main__':
    main()
