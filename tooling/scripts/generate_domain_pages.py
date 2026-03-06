#!/usr/bin/env python3
"""Generate domain hierarchy pages for the IG.

Creates three levels of pages:
  1. domains.xml — overview with links to 5 domain pages
  2. {domain}.xml — domain landing pages with normative text + subdomain links
  3. {subdomain}.xml — subdomain pages with normative text + event/message tables

Also updates input/v2plus.xml with the nested page hierarchy.

Usage:
    python3 tooling/scripts/generate_domain_pages.py
"""

import glob
import json
import os
import re
import subprocess
import sys
import tempfile
from collections import defaultdict
from xml.etree import ElementTree as ET

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
MESSAGES_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'message', 'messages')
DOMAINS_DIR = os.path.join(PROJECT_ROOT, 'website', 'domains')
OUTPUT_DIR = os.path.join(PROJECT_ROOT, 'input', 'pagecontent')
V2PLUS_XML = os.path.join(PROJECT_ROOT, 'input', 'v2plus.xml')
RUBY_PATH = '/home/claude/ruby/arm64/bin/ruby'

# Domain/subdomain structure with display names and page name overrides.
# Page names default to subdomain_key with underscores replaced by hyphens.
# Tuples: (subdomain_key, display_name, page_name_override_or_None, adoc_filename_override_or_None)
DOMAIN_STRUCTURE = [
    ('administration', 'Administration', [
        ('registration', 'Registration (Patient Administration)', None, None),
        ('referral', 'Referral', None, None),
        ('scheduling', 'Scheduling', None, None),
    ]),
    ('clinical', 'Clinical', [
        ('general_orders_and_results', 'General Orders and Results', None, None),
        ('laboratory', 'Laboratory', None, None),
        ('pharmacy', 'Pharmacy', None, None),
        ('imaging', 'Imaging / Radiology', None, None),
        ('patient_care', 'Patient Care', None, None),
        ('immunizations', 'Immunizations', None, None),
        ('blood_bank', 'Blood Bank', None, None),
        ('medical_records', 'Medical Records / Information Management', None, 'document_management.adoc'),
        ('clinical_trials', 'Clinical Trials', None, None),
        ('dietary', 'Dietary', None, None),
        ('product_experience', 'Product Experience', None, None),
        ('supply', 'Supply', 'clinical-supply', None),
    ]),
    ('financial', 'Financial', [
        ('financial_management', 'Financial Management', None, None),
        ('claims_and_reimbursements', 'Claims and Reimbursements', None, None),
    ]),
    ('technical', 'Technical', [
        ('application_management', 'Application Management', None, None),
        ('master_files', 'Master Files', None, None),
        ('queries', 'Queries', None, None),
    ]),
    ('erp', 'Enterprise Resource Planning (ERP)', [
        ('lab_automation', 'Lab Automation', None, None),
        ('materials_management', 'Materials Management', None, None),
        ('personnel_management', 'Personnel Management', None, None),
        ('specimen_shipment_manifest', 'Specimen Shipment Manifest', None, None),
        ('supply', 'Supply', 'erp-supply', None),
    ]),
]

# Short descriptions for each domain (used on overview page)
DOMAIN_DESCRIPTIONS = {
    'administration': (
        'Patient administration, referrals, and scheduling — '
        'covering patient registration, transfers, discharges, and appointment management.'
    ),
    'clinical': (
        'Clinical data exchange including orders and results, laboratory, pharmacy, '
        'imaging, patient care, immunizations, blood bank, and more.'
    ),
    'financial': (
        'Financial management and claims/reimbursements — '
        'covering billing, invoicing, and insurance claim transactions.'
    ),
    'technical': (
        'Infrastructure and system-level messaging — '
        'application management, master file updates, and query/response patterns.'
    ),
    'erp': (
        'Enterprise Resource Planning — lab automation, materials management, '
        'personnel management, and specimen shipment tracking.'
    ),
}


def escape_xml(text):
    """Escape text for use in XHTML content."""
    return (text
            .replace('&', '&amp;')
            .replace('<', '&lt;')
            .replace('>', '&gt;')
            .replace('"', '&quot;'))


def subdomain_page_name(subdomain_key, page_override):
    """Return the HTML page name for a subdomain."""
    if page_override:
        return page_override
    return subdomain_key.replace('_', '-')


def build_event_to_message_map():
    """Build a mapping from trigger event code to Message ID.

    Returns dict like {'A01': 'ADT-A01', 'O09': 'OMP-O09', ...}
    """
    event_to_msg = {}
    for filepath in sorted(glob.glob(os.path.join(MESSAGES_DIR, '*.json'))):
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        msg_id = data.get('id', '')
        if msg_id.startswith('ACK-'):
            continue
        for elem in data.get('differential', {}).get('element', []):
            if elem.get('path') == 'Message.triggerEvent':
                code = elem.get('patternCode', '')
                if code:
                    event_to_msg[code] = msg_id
    return event_to_msg


def build_event_to_subdomain_map():
    """Build a mapping from trigger event code to (domain_key, subdomain_key).

    Returns dict like {'A01': ('administration', 'registration'), ...}
    """
    event_to_subdomain = {}
    for adoc in glob.glob(os.path.join(DOMAINS_DIR, '*', '*', 'technical_specs', '*.adoc')):
        parts = adoc.split(os.sep)
        idx = parts.index('domains')
        domain = parts[idx + 1]
        subdomain = parts[idx + 2]
        event = os.path.basename(adoc).replace('.adoc', '')
        if '_' in event:
            for e in event.split('_'):
                event_to_subdomain[e] = (domain, subdomain)
        else:
            event_to_subdomain[event] = (domain, subdomain)
    return event_to_subdomain


def get_event_title(adoc_path):
    """Extract the human-readable event title from a tech spec .adoc file."""
    try:
        with open(adoc_path, 'r', encoding='utf-8') as f:
            first_line = f.readline().strip()
        m = re.match(r'^=\s+Message\s*-\s*\S+\s+(.*)', first_line)
        if m:
            return m.group(1).strip()
        if first_line.startswith('= '):
            return first_line[2:].strip()
    except (IOError, OSError):
        pass
    return ''


def build_subdomain_events(event_to_subdomain, event_to_msg):
    """Build dict of (domain, subdomain) -> list of (event_code, msg_id, title)."""
    subdomain_events = defaultdict(list)
    for event, (domain, subdomain) in event_to_subdomain.items():
        msg_id = event_to_msg.get(event)
        if not msg_id:
            continue
        adoc_path = os.path.join(DOMAINS_DIR, domain, subdomain,
                                 'technical_specs', f'{event}.adoc')
        title = get_event_title(adoc_path)
        if not title:
            for compound in glob.glob(os.path.join(
                    DOMAINS_DIR, domain, subdomain,
                    'technical_specs', f'*_{event}.adoc')):
                title = get_event_title(compound)
                if title:
                    break
            if not title:
                for compound in glob.glob(os.path.join(
                        DOMAINS_DIR, domain, subdomain,
                        'technical_specs', f'{event}_*.adoc')):
                    title = get_event_title(compound)
                    if title:
                        break
        subdomain_events[(domain, subdomain)].append((event, msg_id, title))

    for key in subdomain_events:
        subdomain_events[key].sort(key=lambda x: x[0])
    return subdomain_events


def html5_to_xhtml(html):
    """Convert HTML5 output from Asciidoctor to valid XHTML.

    Fixes self-closing tags and entity references that the IG Publisher's
    XML parser requires.
    """
    # Self-close void elements
    html = re.sub(r'<(br|hr|img|col)(\s[^>]*)?>(?!/)', r'<\1\2/>', html)
    # Escape bare &
    html = re.sub(r'&(?!amp;|lt;|gt;|quot;|apos;|#\d+;|#x[0-9a-fA-F]+;)', '&amp;', html)
    # Downshift headings: h1->h3, h2->h4, h3->h5
    def _shift_heading(m):
        tag_start = m.group(1)
        level = int(m.group(2))
        new_level = min(level + 2, 6)
        return f'<{tag_start}h{new_level}'
    html = re.sub(r'<(/?)h([1-3])(?=[\s>])', _shift_heading, html)
    # Fix overlapping sup/sub tags
    html = re.sub(
        r'<sup>([^<]*)<sub>([^<]*)</sup>([^<]*)</sub>',
        r'<sup>\1<sub>\2</sub></sup><sub>\3</sub>',
        html
    )
    html = re.sub(
        r'<sub>([^<]*)<sup>([^<]*)</sub>([^<]*)</sup>',
        r'<sub>\1<sup>\2</sup></sub><sup>\3</sup>',
        html
    )
    return html


def convert_adoc_to_html(adoc_text, base_dir=None):
    """Convert AsciiDoc text to XHTML fragment using Asciidoctor.

    Args:
        adoc_text: AsciiDoc content string.
        base_dir: Directory for resolving include:: directives. If None, uses
                  a temp directory (no includes will resolve).
    """
    if not adoc_text:
        return ''

    with tempfile.NamedTemporaryFile(mode='w', suffix='.adoc', delete=False,
                                     encoding='utf-8',
                                     dir=base_dir) as f:
        f.write(adoc_text)
        tmp_adoc = f.name

    try:
        # Use :unsafe safe mode so include:: directives resolve
        ruby_script = (
            "require 'asciidoctor'; "
            "text = File.read(ARGV[0]); "
            "html = Asciidoctor.convert(text, safe: :unsafe, "
            f"base_dir: '{base_dir or os.path.dirname(tmp_adoc)}', "
            "header_footer: false, backend: 'html5'); "
            "puts html"
        )
        result = subprocess.run(
            [RUBY_PATH, '-e', ruby_script, tmp_adoc],
            capture_output=True, text=True, timeout=30
        )
        if result.returncode != 0:
            print(f"  WARNING: Asciidoctor error: {result.stderr.strip()}", file=sys.stderr)
            return ''
        return html5_to_xhtml(result.stdout.strip())
    finally:
        os.unlink(tmp_adoc)


def convert_adoc_file_to_html(adoc_path):
    """Convert an .adoc file to XHTML, resolving includes relative to its directory.

    Strips the AsciiDoc title line and metadata attributes before conversion.
    Also strips the "== Technical Specs" section and everything after it that
    consists of xref links (the event table replaces this).
    """
    with open(adoc_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Strip title line and metadata attributes from the top
    cleaned = []
    past_header = False
    for line in lines:
        stripped = line.strip()
        if not past_header:
            if re.match(r'^= .+$', stripped):
                continue
            if re.match(r'^\[v291_section=".+"\]$', stripped):
                continue
            if re.match(r'^:[a-zA-Z0-9_]+:.*$', stripped):
                continue
            if stripped == '' and not cleaned:
                continue
            past_header = True
        cleaned.append(line)

    # Remove the "== Technical Specs" section: the heading itself plus any
    # immediately following lines that are blank or xref links.  Content
    # after the xref block (e.g., Examples) is preserved.
    tech_specs_idx = None
    for i, line in enumerate(cleaned):
        if re.match(r'^==\s+Technical\s+Specs', line.strip()):
            tech_specs_idx = i
            break

    if tech_specs_idx is not None:
        # Find where the xref block ends
        end_idx = tech_specs_idx + 1
        while end_idx < len(cleaned):
            s = cleaned[end_idx].strip()
            if s == '' or s.startswith('xref:'):
                end_idx += 1
            else:
                break
        # Remove the tech specs heading and xref block, keep the rest
        cleaned = cleaned[:tech_specs_idx] + cleaned[end_idx:]

    # Strip trailing blank lines
    while cleaned and cleaned[-1].strip() == '':
        cleaned.pop()

    if not cleaned:
        return ''

    adoc_text = ''.join(cleaned)
    base_dir = os.path.dirname(adoc_path)
    return convert_adoc_to_html(adoc_text, base_dir=base_dir)


def fix_xref_links(html, event_to_msg):
    """Rewrite Asciidoctor xref links to IG page links.

    Asciidoctor converts xref:technical_specs/A01.adoc[text] to
    <a href="technical_specs/A01.html">text</a>. We rewrite these to
    <a href="StructureDefinition-{MSG-ID}.html">text</a>.
    """
    def _replace_xref(m):
        event_code = m.group(1)
        link_text = m.group(2)
        # Handle compound event codes like Q11_K31
        if '_' in event_code:
            # Try to find any of the codes
            for code in event_code.split('_'):
                if code in event_to_msg:
                    msg_id = event_to_msg[code]
                    return f'<a href="StructureDefinition-{msg_id}.html">{link_text}</a>'
        elif event_code in event_to_msg:
            msg_id = event_to_msg[event_code]
            return f'<a href="StructureDefinition-{msg_id}.html">{link_text}</a>'
        # If no mapping found, return original
        return m.group(0)

    # Pattern matches: <a href="technical_specs/EVENT_CODE.html">text</a>
    html = re.sub(
        r'<a href="technical_specs/([^"]+?)\.html">([^<]+)</a>',
        _replace_xref,
        html
    )
    return html


def xhtml_wrapper(content):
    """Wrap content in the XHTML div required by IG Publisher."""
    return (
        '<div xmlns="http://www.w3.org/1999/xhtml"'
        ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'
        ' xsi:schemaLocation="http://hl7.org/fhir'
        ' ../../input-cache/schemas/r5/fhir-single.xsd">\n'
        f'{content}\n'
        '</div>\n'
    )


def render_event_table(events):
    """Render an HTML table of events for a subdomain page."""
    if not events:
        return '<p><i>No message events mapped to this subdomain.</i></p>'

    rows = []
    for event_code, msg_id, title in events:
        msg_display = msg_id.replace('-', '^')
        rows.append(
            f'<tr>'
            f'<td>{escape_xml(event_code)}</td>'
            f'<td><a href="StructureDefinition-{msg_id}.html">'
            f'{escape_xml(msg_display)}</a></td>'
            f'<td>{escape_xml(title)}</td>'
            f'</tr>'
        )

    return (
        '<h3>Messages and Events</h3>\n'
        '<table class="grid">\n'
        '<thead><tr>'
        '<th>Event</th>'
        '<th>Message</th>'
        '<th>Description</th>'
        '</tr></thead>\n'
        '<tbody>\n'
        + '\n'.join(rows) + '\n'
        '</tbody>\n'
        '</table>'
    )


def generate_domains_overview():
    """Generate the top-level domains.xml overview page."""
    lines = [
        '<p>The HL7 v2+ specification is organized into functional domains,'
        ' each covering a specific area of healthcare information exchange.</p>',
        '',
    ]

    for domain_key, domain_name, subdomains in DOMAIN_STRUCTURE:
        desc = DOMAIN_DESCRIPTIONS.get(domain_key, '')
        lines.append(
            f'<h3><a href="{domain_key}.html">{escape_xml(domain_name)}</a></h3>'
        )
        if desc:
            lines.append(f'<p>{escape_xml(desc)}</p>')
        lines.append('')

    return xhtml_wrapper('\n'.join(lines))


def generate_domain_page(domain_key, domain_name, subdomains, subdomain_events):
    """Generate a domain landing page with intro text and subdomain links."""
    parts = []

    # Try to convert domain .adoc intro text
    adoc_path = os.path.join(DOMAINS_DIR, domain_key, f'{domain_key}.adoc')
    if os.path.exists(adoc_path):
        with open(adoc_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract content before the "== ... Subdomains" section
        lines = content.split('\n')
        intro_lines = []
        for line in lines:
            if re.match(r'^==\s+.*[Ss]ubdomains', line):
                break
            intro_lines.append(line)

        # Strip title and metadata
        cleaned = []
        past_header = False
        for line in intro_lines:
            stripped = line.strip()
            if not past_header:
                if re.match(r'^= .+$', stripped):
                    continue
                if re.match(r'^\[v291_section=".+"\]$', stripped):
                    continue
                if stripped == '' and not cleaned:
                    continue
                past_header = True
            cleaned.append(line)

        intro_text = '\n'.join(cleaned).strip()
        # Skip placeholder-only content
        if intro_text and intro_text.replace('\n', '').strip() not in ('FIXME', ''):
            html = convert_adoc_to_html(intro_text,
                                         base_dir=os.path.dirname(adoc_path))
            if html:
                parts.append(html)

    # Build subdomain table
    parts.append('<h3>Subdomains</h3>')
    parts.append('<table class="grid">')
    parts.append('<thead><tr><th>Subdomain</th><th>Events</th></tr></thead>')
    parts.append('<tbody>')
    for sd_key, sd_name, page_override, _ in subdomains:
        page = subdomain_page_name(sd_key, page_override)
        events = subdomain_events.get((domain_key, sd_key), [])
        count = len(events)
        parts.append(
            f'<tr>'
            f'<td><a href="{page}.html">{escape_xml(sd_name)}</a></td>'
            f'<td>{count}</td>'
            f'</tr>'
        )
    parts.append('</tbody>')
    parts.append('</table>')

    return xhtml_wrapper('\n'.join(parts))


def generate_subdomain_page(domain_key, subdomain_key, subdomain_name,
                            page_override, adoc_override, events, event_to_msg):
    """Generate a subdomain page with normative text and event table."""
    parts = []

    # Determine adoc file path
    if adoc_override:
        adoc_path = os.path.join(DOMAINS_DIR, domain_key, subdomain_key, adoc_override)
    else:
        adoc_path = os.path.join(DOMAINS_DIR, domain_key, subdomain_key,
                                 f'{subdomain_key}.adoc')

    # Convert AsciiDoc normative content
    if os.path.exists(adoc_path):
        html = convert_adoc_file_to_html(adoc_path)
        if html:
            # Fix xref links to point to IG pages
            html = fix_xref_links(html, event_to_msg)
            parts.append(html)

    # Append event table
    parts.append(render_event_table(events))

    return xhtml_wrapper('\n'.join(parts))


def update_v2plus_xml(domain_structure, subdomain_events):
    """Update v2plus.xml to add nested page entries under domains.html."""
    with open(V2PLUS_XML, 'r', encoding='utf-8') as f:
        content = f.read()

    # Build the replacement XML for the domains page entry
    indent = '      '
    indent2 = '        '
    indent3 = '          '

    page_lines = [
        f'{indent}<page>',
        f'{indent2}<name value="domains.html"/>',
        f'{indent2}<title value="V2+ Domains"/>',
        f'{indent2}<generation value="html"/>',
    ]

    for domain_key, domain_name, subdomains in domain_structure:
        page_lines.append(f'{indent2}<page>')
        page_lines.append(f'{indent3}<name value="{domain_key}.html"/>')
        page_lines.append(f'{indent3}<title value="{escape_xml(domain_name)}"/>')
        page_lines.append(f'{indent3}<generation value="html"/>')

        for sd_key, sd_name, page_override, _ in subdomains:
            page = subdomain_page_name(sd_key, page_override)
            events = subdomain_events.get((domain_key, sd_key), [])
            count = len(events)
            title = f'{sd_name} ({count} event{"s" if count != 1 else ""})'
            indent4 = '            '
            indent5 = '              '
            page_lines.append(f'{indent4}<page>')
            page_lines.append(f'{indent5}<name value="{page}.html"/>')
            page_lines.append(f'{indent5}<title value="{escape_xml(title)}"/>')
            page_lines.append(f'{indent5}<generation value="html"/>')
            page_lines.append(f'{indent4}</page>')

        page_lines.append(f'{indent2}</page>')

    page_lines.append(f'{indent}</page>')

    new_domains_block = '\n'.join(page_lines)

    # Find and replace the entire domains.html <page> block.
    # We need to match a nested <page> element that contains
    # <name value="domains.html"/>. We find its start and then count
    # open/close <page> tags to find its matching </page>.
    start_match = re.search(r'\n(\s*)<page>\s*\n\s*<name value="domains\.html"/>', content)
    if not start_match:
        print("WARNING: Could not find domains.html page entry in v2plus.xml", file=sys.stderr)
        print("  You may need to manually add the page hierarchy.", file=sys.stderr)
        return False

    block_start = start_match.start()
    # Count nested <page> tags to find matching </page>
    depth = 0
    i = block_start + 1  # skip the leading newline
    while i < len(content):
        page_open = content.find('<page>', i)
        page_close = content.find('</page>', i)
        if page_close == -1:
            break
        if page_open != -1 and page_open < page_close:
            depth += 1
            i = page_open + 6
        else:
            depth -= 1
            if depth == 0:
                block_end = page_close + len('</page>')
                break
            i = page_close + 7
    else:
        print("WARNING: Could not find matching </page> for domains.html", file=sys.stderr)
        return False

    content = content[:block_start] + '\n' + new_domains_block + content[block_end:]

    with open(V2PLUS_XML, 'w', encoding='utf-8') as f:
        f.write(content)
    return True


def main():
    print('Building event-to-message mapping...')
    event_to_msg = build_event_to_message_map()
    print(f'  Found {len(event_to_msg)} event-to-message mappings')

    print('Building event-to-subdomain mapping...')
    event_to_subdomain = build_event_to_subdomain_map()

    print('Building subdomain events...')
    subdomain_events = build_subdomain_events(event_to_subdomain, event_to_msg)

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    files_written = 0

    # 1. Generate domains overview page
    print('\nGenerating domains.xml (overview)...')
    overview = generate_domains_overview()
    with open(os.path.join(OUTPUT_DIR, 'domains.xml'), 'w', encoding='utf-8') as f:
        f.write(overview)
    files_written += 1

    # 2. Generate domain landing pages
    for domain_key, domain_name, subdomains in DOMAIN_STRUCTURE:
        print(f'Generating {domain_key}.xml...')
        page = generate_domain_page(domain_key, domain_name, subdomains,
                                    subdomain_events)
        with open(os.path.join(OUTPUT_DIR, f'{domain_key}.xml'), 'w',
                  encoding='utf-8') as f:
            f.write(page)
        files_written += 1

    # 3. Generate subdomain pages
    for domain_key, domain_name, subdomains in DOMAIN_STRUCTURE:
        for sd_key, sd_name, page_override, adoc_override in subdomains:
            page = subdomain_page_name(sd_key, page_override)
            print(f'Generating {page}.xml...')
            events = subdomain_events.get((domain_key, sd_key), [])
            content = generate_subdomain_page(
                domain_key, sd_key, sd_name,
                page_override, adoc_override, events, event_to_msg)
            with open(os.path.join(OUTPUT_DIR, f'{page}.xml'), 'w',
                      encoding='utf-8') as f:
                f.write(content)
            files_written += 1

    # 4. Update v2plus.xml
    print('\nUpdating v2plus.xml page hierarchy...')
    if update_v2plus_xml(DOMAIN_STRUCTURE, subdomain_events):
        print('  v2plus.xml updated successfully')
    else:
        print('  WARNING: v2plus.xml update failed')

    # Summary
    total_events = sum(len(v) for v in subdomain_events.values())
    print(f'\nDone!')
    print(f'  Files written: {files_written}')
    print(f'  Total linked events: {total_events}')


if __name__ == '__main__':
    main()
