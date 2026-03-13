#!/usr/bin/env python3
"""Generate IG Publisher intro/notes pages for Message StructureDefinitions.

Reads Message JSONs, linked MessageStructure JSONs, and AsciiDoc tech spec
files to produce StructureDefinition-{id}-intro.xml and
StructureDefinition-{id}-notes.xml files in input/pagecontent/.

Usage:
    python3 tooling/scripts/generate_message_pages.py [--subset ADT-A01,ADT-A02]
"""

import argparse
import glob
import os
import re
import sys

from v2_utils import (
    load_json, escape_xml, html5_to_xhtml, convert_adoc_to_html,
    write_xml_file, AnomalyLog,
    PROJECT_ROOT, MESSAGES_DIR, MSG_STRUCTURES_DIR, ADOC_BASE_DIR, OUTPUT_DIR,
    ADOC_META_PATTERN, ADOC_TITLE_PATTERN,
)

ANOMALY_LOG_PATH = os.path.join(PROJECT_ROOT, 'tooling', 'scripts',
                                'generate_message_pages_anomalies.log')


def find_non_ack_messages(subset=None):
    """Find all non-ACK Message JSON files and parse key fields.

    Returns a list of dicts with keys:
        id, trigger_event, message_type, structure_ref, ack_choreography, filepath
    """
    messages = []
    for filepath in sorted(glob.glob(os.path.join(MESSAGES_DIR, '*.json'))):
        filename = os.path.basename(filepath)
        if filename.startswith('ACK-'):
            continue

        msg_id = filename.replace('.json', '')
        if subset and msg_id not in subset:
            continue

        data = load_json(filepath)
        elements = data.get('differential', {}).get('element', [])

        trigger_event = None
        message_type = None
        structure_ref = None
        ack = {}

        for elem in elements:
            path = elem.get('path', '')
            if path == 'Message.triggerEvent':
                trigger_event = elem.get('patternCode')
            elif path == 'Message.messageType':
                message_type = elem.get('patternCode')
            elif path == 'Message.structure':
                profiles = (elem.get('type', [{}])[0]
                            .get('targetProfile', []))
                if profiles:
                    # Extract the structure ID from the URL
                    # e.g. ".../MessageStructure/ADT-A01-A" -> "ADT-A01-A"
                    structure_ref = profiles[0].rsplit('/', 1)[-1]
            elif 'acknowledgementChoreography' in path:
                mode = path.rsplit('.', 1)[-1]
                profiles = (elem.get('type', [{}])[0]
                            .get('targetProfile', []))
                if profiles:
                    ack_ref = profiles[0].rsplit('/', 1)[-1]
                    ack[mode] = ack_ref

        messages.append({
            'id': data.get('id', msg_id),
            'trigger_event': trigger_event,
            'message_type': message_type,
            'structure_ref': structure_ref,
            'ack_choreography': ack,
            'filepath': filepath,
        })

    return messages


def structure_ref_to_file_id(ref):
    """Convert a structure reference from URL form to file ID form.

    E.g. "ADT-A01-A" -> "ADT_A01-A" (first hyphen becomes underscore)
    """
    idx = ref.find('-')
    if idx == -1:
        return ref
    return ref[:idx] + '_' + ref[idx + 1:]


def build_adoc_index(anomalies):
    """Build a mapping from event codes to .adoc file paths.

    Scans website/domains/*/technical_specs/ and **/technical_specs/.
    Returns:
        index: dict of event_code -> filepath
        all_adoc_files: set of all .adoc file paths found (for orphan detection)
    For compound files like Q11_K31.adoc, maps both "Q11" and "K31".
    """
    UTILITY_FILES = {'general_approach', 'master_file_notification'}

    index = {}
    compound = {}
    all_adoc_files = set()
    no_tabset_files = []

    pattern = os.path.join(ADOC_BASE_DIR, '**', 'technical_specs', '*.adoc')
    for filepath in glob.glob(pattern, recursive=True):
        basename = os.path.basename(filepath).replace('.adoc', '')
        all_adoc_files.add(filepath)

        if basename in UTILITY_FILES:
            all_adoc_files.discard(filepath)  # Don't count as orphan
            anomalies.add(
                'ADOC_UTILITY_FILE', None,
                f'Skipped utility file: {os.path.relpath(filepath, PROJECT_ROOT)}\n'
                f'This file does not correspond to a specific event code and is '
                f'not mapped to any Message page. If it contains content that '
                f'should appear on a Message page, it needs a mapping rule.')
            continue

        # Check for [tabset] marker
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        if '[tabset]' not in content:
            no_tabset_files.append(filepath)

        if '_' in basename:
            # Compound file like Q11_K31 - map both codes (lower priority)
            codes = basename.split('_')
            for code in codes:
                compound[code] = filepath
        else:
            # Direct match (higher priority)
            index[basename] = filepath

    # Compound entries fill in gaps but don't override direct matches
    for code, filepath in compound.items():
        if code not in index:
            index[code] = filepath
        else:
            # Conflict: both a direct file and a compound file claim this code
            direct_rel = os.path.relpath(index[code], PROJECT_ROOT)
            compound_rel = os.path.relpath(filepath, PROJECT_ROOT)
            anomalies.add(
                'ADOC_CONFLICT', None,
                f'Event code "{code}" is claimed by both a direct .adoc file '
                f'and a compound .adoc file.\n'
                f'Direct file (used):    {direct_rel}\n'
                f'Compound file (skipped): {compound_rel}\n'
                f'The direct file takes priority, so the compound file\'s '
                f'content for this event is ignored. If the compound file '
                f'contains the authoritative narrative, the direct file may '
                f'need to be removed or merged. Both files should be reviewed '
                f'to ensure the correct content is being published.')

    for filepath in no_tabset_files:
        rel = os.path.relpath(filepath, PROJECT_ROOT)
        anomalies.add(
            'ADOC_NO_TABSET', None,
            f'File has no [tabset] marker: {rel}\n'
            f'The [tabset] marker is used to split content into intro '
            f'(above) and notes (below). Without it, the entire file is '
            f'skipped and no narrative content is injected for events '
            f'mapped to this file.')

    return index, all_adoc_files


def split_adoc_content(filepath):
    """Split an .adoc file at [tabset] into before and after content.

    Returns (before_content, after_content) as strings.
    Strips the title line, metadata attributes, and the event code line
    immediately after [tabset].
    Returns (None, None) if no [tabset] found.
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Find [tabset] line
    tabset_idx = None
    for i, line in enumerate(lines):
        if line.strip() == '[tabset]':
            tabset_idx = i
            break

    if tabset_idx is None:
        return None, None

    # Before content: strip title and metadata from the top
    before_lines = []
    for line in lines[:tabset_idx]:
        stripped = line.strip()
        if ADOC_TITLE_PATTERN.match(stripped):
            continue
        if ADOC_META_PATTERN.match(stripped):
            continue
        before_lines.append(line)

    # Strip leading blank lines
    while before_lines and before_lines[0].strip() == '':
        before_lines.pop(0)

    before_content = ''.join(before_lines).strip()

    # After content: skip the [tabset] line and the event code label line(s)
    # immediately following it
    after_lines = lines[tabset_idx + 1:]

    # Skip blank lines and short event-code-like lines right after [tabset]
    # Event code lines are short identifiers like "A01", "K31", "Q11"
    cleaned_after = []
    skipping_header = True
    for line in after_lines:
        stripped = line.strip()
        if skipping_header:
            # Skip blank lines and short event code labels (alphanumeric, < 10 chars)
            if stripped == '' or (len(stripped) < 10 and re.match(r'^[A-Z0-9_]+$', stripped)):
                continue
            skipping_header = False
        cleaned_after.append(line)

    after_content = ''.join(cleaned_after).strip()

    return before_content, after_content


def _parse_elements(data):
    """Parse elements from a MessageStructure JSON into a list of dicts.

    Each dict has keys: path, short_desc, min_card, max_card, type_code,
    status, segment_or_group, depth, is_group.
    Skips the root element.
    """
    elements = data.get('differential', {}).get('element', [])
    parsed = []
    for elem in elements[1:]:  # Skip the root element
        path = elem.get('path', '')
        short_desc = escape_xml(elem.get('short') or '')
        min_card = elem.get('min', 0)
        max_card = elem.get('max', '*')

        type_list = elem.get('type', [])
        type_code = type_list[0].get('code', '') if type_list else ''

        # Get segment status from extensions
        status = ''
        for ext in elem.get('extension', []):
            if ext.get('url', '').endswith('v2-segment-status'):
                status = ext.get('valueCode', '')
                break

        is_group = (type_code == 'BackboneElement')

        # Extract the segment code from the path
        parts = path.rsplit('-', 1)
        segment_or_group = parts[-1] if len(parts) > 1 else path

        # Calculate nesting depth from the path
        dot_count = path.count('.')
        depth = dot_count - 1

        parsed.append({
            'path': path,
            'short_desc': short_desc,
            'min_card': min_card,
            'max_card': max_card,
            'type_code': type_code,
            'status': status,
            'segment_or_group': segment_or_group,
            'depth': depth,
            'is_group': is_group,
        })
    return parsed


def _bracket_wrap(text, min_card, max_card):
    """Wrap text in V2 bracket notation based on cardinality.

    1..1 -> text          (required, non-repeating)
    0..1 -> [ text ]      (optional, non-repeating)
    0..* -> [{ text }]    (optional, repeating)
    1..* -> { text }      (required, repeating)
    """
    required = (int(min_card) >= 1)
    repeating = (str(max_card) == '*' or (max_card != '1' and str(max_card) != '0'))

    if required and not repeating:
        return text
    elif not required and not repeating:
        return f'[ {text} ]'
    elif not required and repeating:
        return f'[{{ {text} }}]'
    else:  # required and repeating
        return f'{{ {text} }}'


def render_classic_structure(parsed_elements):
    """Render classic V2 bracket notation view from parsed elements.

    Returns HTML string with a table of three columns:
    Segment (monospace bracket notation), Description, Status.
    """
    # Build a tree-aware list of rows. We need to detect when groups end
    # so we can insert closing bracket rows.
    # Strategy: track a stack of open groups. When depth decreases, close groups.
    rows = []
    group_stack = []  # stack of (depth, display_name, min_card, max_card)

    for i, elem in enumerate(parsed_elements):
        depth = elem['depth']

        # Close any groups that have ended (next element is at same or shallower depth)
        while group_stack and group_stack[-1][0] >= depth:
            g_depth, g_name, g_min, g_max = group_stack.pop()
            indent = '\u00a0\u00a0\u00a0' * g_depth
            # Build closing bracket
            required = (int(g_min) >= 1)
            repeating = (str(g_max) == '*' or (g_max != '1' and str(g_max) != '0'))
            if required and not repeating:
                close_bracket = '---'
            elif not required and not repeating:
                close_bracket = ']'
            elif not required and repeating:
                close_bracket = '}]'
            else:
                close_bracket = '}'
            rows.append(
                f'<tr class="v2-classic-group">'
                f'<td class="v2-classic-notation">{indent}{close_bracket} --- {g_name} end</td>'
                f'<td></td>'
                f'<td></td>'
                f'</tr>'
            )

        indent = '\u00a0\u00a0\u00a0' * depth

        if elem['is_group']:
            display_name = elem['segment_or_group'].replace('_', ' ').title()
            # Build opening bracket
            required = (int(elem['min_card']) >= 1)
            repeating = (str(elem['max_card']) == '*' or
                         (elem['max_card'] != '1' and str(elem['max_card']) != '0'))
            if required and not repeating:
                open_bracket = '---'
            elif not required and not repeating:
                open_bracket = '['
            elif not required and repeating:
                open_bracket = '[{'
            else:
                open_bracket = '{'
            rows.append(
                f'<tr class="v2-classic-group">'
                f'<td class="v2-classic-notation">{indent}{open_bracket} --- {display_name} begin</td>'
                f'<td></td>'
                f'<td></td>'
                f'</tr>'
            )
            group_stack.append((depth, display_name, elem['min_card'], elem['max_card']))
        else:
            seg_code = elem['segment_or_group']
            notation = _bracket_wrap(
                f'<a href="StructureDefinition-{seg_code}.html">{seg_code}</a>',
                elem['min_card'], elem['max_card']
            )
            rows.append(
                f'<tr>'
                f'<td class="v2-classic-notation">{indent}{notation}</td>'
                f'<td>{elem["short_desc"]}</td>'
                f'<td>{elem["status"]}</td>'
                f'</tr>'
            )

    # Close any remaining open groups
    while group_stack:
        g_depth, g_name, g_min, g_max = group_stack.pop()
        indent = '\u00a0\u00a0\u00a0' * g_depth
        required = (int(g_min) >= 1)
        repeating = (str(g_max) == '*' or (g_max != '1' and str(g_max) != '0'))
        if required and not repeating:
            close_bracket = '---'
        elif not required and not repeating:
            close_bracket = ']'
        elif not required and repeating:
            close_bracket = '}]'
        else:
            close_bracket = '}'
        rows.append(
            f'<tr class="v2-classic-group">'
            f'<td class="v2-classic-notation">{indent}{close_bracket} --- {g_name} end</td>'
            f'<td></td>'
            f'<td></td>'
            f'</tr>'
        )

    return (
        '<table class="grid">\n'
        '<thead><tr>'
        '<th>Segment</th>'
        '<th>Description</th>'
        '<th>Status</th>'
        '</tr></thead>\n'
        '<tbody>\n'
        + '\n'.join(rows) + '\n'
        '</tbody>\n'
        '</table>'
    )


def render_segment_table(structure_id, msg_id, anomalies):
    """Render message structure content for the intro fragment.

    Returns HTML string with:
    - A visible summary heading and link to the MessageStructure page
    - A hidden div (#v2-classic-content) containing the classic bracket
      notation table. This div is picked up by tabs.js and injected into
      the Formal Views jQuery UI tab set at render time.
    Returns empty string if the MessageStructure file is not found.
    """
    file_id = structure_ref_to_file_id(structure_id)
    filepath = os.path.join(MSG_STRUCTURES_DIR, f'{file_id}.json')
    if not os.path.exists(filepath):
        anomalies.add(
            'MISSING_MESSAGE_STRUCTURE', msg_id,
            f'Message references MessageStructure "{structure_id}" but '
            f'the expected file {os.path.relpath(filepath, PROJECT_ROOT)} '
            f'does not exist. The Message page will have no segment table. '
            f'Either the structure reference in the Message JSON is wrong, '
            f'or the MessageStructure JSON file is missing.')
        return ''

    data = load_json(filepath)
    parsed = _parse_elements(data)

    if not parsed:
        return ''

    # Build Classic bracket notation view
    classic_table = render_classic_structure(parsed)

    # Build a display name from the file_id (e.g. ADT_A01-A → ADT_A01)
    display_name = file_id.rsplit('-', 1)[0] if '-' in file_id else file_id

    # The classic content is placed in a hidden div that v2-classic-tabs.js
    # will discover and inject into the Formal Views tab set.
    table_html = (
        f'<div id="v2-classic-content" style="display:none;">\n'
        f'<p>The full structure definition for '
        f'<a href="StructureDefinition-{file_id}.html">{display_name}</a> '
        f'is available on its own page.</p>\n'
        f'{classic_table}\n'
        f'</div>'
    )
    return table_html


def render_ack_table(ack_choreography, message_type):
    """Render an Acknowledgement Choreography HTML table.

    ack_choreography: dict of mode -> ACK message reference ID
    Returns HTML string or empty string if no ACK data.
    """
    if not ack_choreography:
        return ''

    mode_labels = {
        'originalModeResponse': 'Original Mode',
        'enhancedModeImmediateResponse': 'Enhanced Mode: Immediate',
        'enhancedModeApplicationResponse': 'Enhanced Mode: Application',
    }

    rows = []
    for mode, label in mode_labels.items():
        if mode in ack_choreography:
            ack_id = ack_choreography[mode]
            # Format display as MSG^EVENT (e.g., ACK^A01)
            ack_parts = ack_id.split('-')
            if len(ack_parts) >= 2:
                display = f'{ack_parts[0]}^{ack_parts[1]}'
            else:
                display = ack_id
            link = (f'<a href="StructureDefinition-{ack_id}.html">'
                    f'{display}</a>')
            rows.append(f'<tr><td>{label}</td><td>{link}</td></tr>')

    if not rows:
        return ''

    return (
        '<div id="v2-ack-content" style="display:none;">\n'
        '<table class="grid">\n'
        '<thead><tr><th>Mode</th><th>Response</th></tr></thead>\n'
        '<tbody>\n'
        + '\n'.join(rows) + '\n'
        '</tbody>\n'
        '</table>\n'
        '</div>'
    )


def render_structure_intro(file_id, anomalies):
    """Render intro content for a MessageStructure page.

    Generates a hidden div with the classic bracket notation table,
    which v2-classic-tabs.js will inject as a tab in the Formal Views.
    Returns HTML string or empty string if parsing fails.
    """
    filepath = os.path.join(MSG_STRUCTURES_DIR, f'{file_id}.json')
    if not os.path.exists(filepath):
        return ''

    data = load_json(filepath)
    parsed = _parse_elements(data)

    if not parsed:
        return ''

    classic_table = render_classic_structure(parsed)

    return (
        f'<div id="v2-classic-content" style="display:none;">\n'
        f'{classic_table}\n'
        f'</div>'
    )


def main():
    parser = argparse.ArgumentParser(
        description='Generate IG Publisher intro/notes pages for Messages')
    parser.add_argument('--subset', type=str, default=None,
                        help='Comma-separated list of message IDs to process '
                             '(e.g. ADT-A01,ADT-A02)')
    args = parser.parse_args()

    subset = None
    if args.subset:
        subset = set(args.subset.split(','))

    anomalies = AnomalyLog()

    print('Loading messages...')
    messages = find_non_ack_messages(subset)
    print(f'  Found {len(messages)} non-ACK messages')

    print('Building .adoc index...')
    adoc_index, all_adoc_files = build_adoc_index(anomalies)
    print(f'  Indexed {len(adoc_index)} event codes from .adoc files')

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    intro_count = 0
    notes_count = 0
    used_adoc_files = set()

    # Collect all trigger events for orphan detection
    all_trigger_events = set()

    for msg in messages:
        msg_id = msg['id']
        trigger = msg['trigger_event']
        structure_ref = msg['structure_ref']

        if trigger:
            all_trigger_events.add(trigger)

        print(f'Processing {msg_id} (event={trigger}, structure={structure_ref})...')

        # Log messages missing a trigger event
        if not trigger:
            anomalies.add(
                'NO_TRIGGER_EVENT', msg_id,
                f'Message has no triggerEvent element in its definition. '
                f'This means no .adoc content can be matched to it. '
                f'The message may be a response type that intentionally '
                f'lacks a trigger event, or the trigger event may be '
                f'missing from the Message JSON.')

        # Log messages missing a structure reference
        if not structure_ref:
            anomalies.add(
                'NO_STRUCTURE_REF', msg_id,
                f'Message has no structure reference (targetProfile). '
                f'The message page will have no segment table. '
                f'The Message JSON may be incomplete.')

        # Log messages with no ACK choreography
        if not msg['ack_choreography']:
            anomalies.add(
                'NO_ACK_CHOREOGRAPHY', msg_id,
                f'Message has no acknowledgement choreography elements. '
                f'The message page will have no ACK table. This may be '
                f'intentional (e.g. some response messages) or the '
                f'choreography data may be missing from the Message JSON.')

        intro_parts = []
        notes_html = ''

        # Find and process .adoc content
        if trigger and trigger in adoc_index:
            adoc_path = adoc_index[trigger]
            used_adoc_files.add(adoc_path)
            before, after = split_adoc_content(adoc_path)

            if before is None:
                # No [tabset] found — file is skipped entirely
                # (already logged in build_adoc_index as ADOC_NO_TABSET)
                pass
            else:
                if before:
                    html = convert_adoc_to_html(before)
                    if html:
                        intro_parts.append(html)

                if after:
                    notes_html = convert_adoc_to_html(after)
        elif trigger:
            anomalies.add(
                'NO_ADOC_FILE', msg_id,
                f'No .adoc tech spec file found for event "{trigger}". '
                f'The message page will have structure and ACK tables '
                f'but no narrative description. If this event should '
                f'have narrative content, an .adoc file needs to be '
                f'created at website/domains/<domain>/technical_specs/'
                f'{trigger}.adoc')

        # Render MessageStructure segment table
        if structure_ref:
            seg_table = render_segment_table(structure_ref, msg_id, anomalies)
            if seg_table:
                intro_parts.append(seg_table)

        # Render ACK choreography table
        ack_table = render_ack_table(msg['ack_choreography'], msg['message_type'])
        if ack_table:
            intro_parts.append(ack_table)

        # Write intro file
        if intro_parts:
            intro_content = '\n'.join(intro_parts)
            intro_path = os.path.join(OUTPUT_DIR,
                                      f'StructureDefinition-{msg_id}-intro.xml')
            write_xml_file(intro_path, intro_content)
            intro_count += 1

        # Write notes file (only if there's post-tabset content)
        if notes_html:
            notes_path = os.path.join(OUTPUT_DIR,
                                      f'StructureDefinition-{msg_id}-notes.xml')
            write_xml_file(notes_path, notes_html)
            notes_count += 1

    # Detect orphan .adoc files — files not used by any message
    orphan_files = all_adoc_files - used_adoc_files
    for filepath in sorted(orphan_files):
        rel = os.path.relpath(filepath, PROJECT_ROOT)
        basename = os.path.basename(filepath).replace('.adoc', '')
        anomalies.add(
            'ADOC_ORPHAN', None,
            f'AsciiDoc file is not used by any Message: {rel}\n'
            f'No non-ACK Message has a trigger event matching "{basename}" '
            f'(or any code in the compound filename). This file\'s content '
            f'will not appear on any Message page. The file may be obsolete, '
            f'or the matching Message JSON may be missing or may use a '
            f'different event code.')

    # Generate intro files for MessageStructure pages
    print('\nGenerating MessageStructure intro files...')
    structure_files = glob.glob(os.path.join(MSG_STRUCTURES_DIR, '*.json'))
    struct_intro_count = 0
    for sf in sorted(structure_files):
        struct_id = os.path.basename(sf).replace('.json', '')

        # If subset is specified, only process structures referenced by
        # subset messages (match by structure prefix, e.g. ADT_A01)
        if subset:
            # Check if any subset message references this structure
            prefix = struct_id.rsplit('-', 1)[0] if '-' in struct_id else struct_id
            matched = any(
                prefix.replace('_', '-') in mid or mid.replace('-', '_') in prefix
                for mid in subset
            )
            if not matched:
                continue

        struct_html = render_structure_intro(struct_id, anomalies)
        if struct_html:
            intro_path = os.path.join(
                OUTPUT_DIR, f'StructureDefinition-{struct_id}-intro.xml')
            write_xml_file(intro_path, struct_html)
            struct_intro_count += 1
            print(f'  {struct_id}')

    # Write anomaly log
    anomalies.write(ANOMALY_LOG_PATH, script_name='generate_message_pages.py')
    log_rel = os.path.relpath(ANOMALY_LOG_PATH, PROJECT_ROOT)

    print(f'\nDone!')
    print(f'  Message intro files written: {intro_count}')
    print(f'  Message notes files written: {notes_count}')
    print(f'  MessageStructure intro files written: {struct_intro_count}')
    print(f'  Anomalies found: {len(anomalies.entries)}')
    if anomalies.entries:
        print(f'  Anomaly breakdown:')
        print(anomalies.summary())
        print(f'  Full anomaly log: {log_rel}')


if __name__ == '__main__':
    main()
