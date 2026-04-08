#!/usr/bin/env python3
"""Shared utilities for V2+ IG page generation scripts.

This module provides common functions used by generate_message_pages.py,
generate_segment_pages.py, and future page generators. It includes:

- File I/O helpers (load_json, write_xml_file)
- Text processing (escape_xml, html5_to_xhtml, convert_adoc_to_html)
- AnomalyLog for tracking issues during generation
- Path constants for the project directory structure
- Regex patterns for AsciiDoc processing

Usage:
    from v2_utils import (
        load_json, escape_xml, html5_to_xhtml, convert_adoc_to_html,
        write_xml_file, AnomalyLog, PROJECT_ROOT, OUTPUT_DIR,
    )
"""

import json
import os
import re
import subprocess
import sys
import tempfile
from datetime import datetime, timezone


# ---------------------------------------------------------------------------
# Path constants
# ---------------------------------------------------------------------------

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
OUTPUT_DIR = os.path.join(PROJECT_ROOT, 'input', 'pagecontent')
MESSAGES_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth',
                            'message', 'messages')
MSG_STRUCTURES_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth',
                                  'message-structure', 'message_structures')
SEGMENTS_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth',
                            'segment', 'segments')
ADOC_BASE_DIR = os.path.join(PROJECT_ROOT, 'website', 'domains')

# ---------------------------------------------------------------------------
# Ruby / Asciidoctor environment
# ---------------------------------------------------------------------------

import shutil as _shutil
RUBY_PATH = _shutil.which('ruby') or '/home/claude/ruby/arm64/bin/ruby'
# Inherit the current environment so Apptainer/rbenv/system gem paths work,
# then layer on safe defaults for encoding.
RUBY_ENV = dict(os.environ)
RUBY_ENV.update({
    'LANG': 'en_US.UTF-8',
    'LC_ALL': 'en_US.UTF-8',
})

# ---------------------------------------------------------------------------
# Regex patterns for AsciiDoc processing
# ---------------------------------------------------------------------------

# Matches AsciiDoc metadata attribute lines like `:author: John`
ADOC_META_PATTERN = re.compile(r'^:[a-zA-Z0-9_]+:.*$')
# Matches AsciiDoc title lines like `= My Title`
ADOC_TITLE_PATTERN = re.compile(r'^= .+$')


# ---------------------------------------------------------------------------
# AnomalyLog
# ---------------------------------------------------------------------------

class AnomalyLog:
    """Collects anomalies found during generation for v2mgmt review.

    Each anomaly has a category (short classification), an optional
    resource ID, and a human-readable detail string explaining the issue.

    Usage:
        log = AnomalyLog()
        log.add('MISSING_FILE', 'PID', 'Expected PID.json but not found')
        log.write('/path/to/anomalies.log')
    """

    def __init__(self):
        self.entries = []

    def add(self, category, resource_id, detail):
        """Record an anomaly.

        Args:
            category: Short classification (e.g. "MISSING_FILE")
            resource_id: The resource ID involved (e.g. "PID"), or None
            detail: Human-readable explanation of the issue
        """
        self.entries.append({
            'category': category,
            'resource_id': resource_id or '(none)',
            'detail': detail,
        })

    def write(self, filepath, script_name='(unknown)'):
        """Write the anomaly log to a file, grouped by category.

        Args:
            filepath: Path to write the log file
            script_name: Name of the generating script for the header
        """
        categories = {}
        for entry in self.entries:
            cat = entry['category']
            categories.setdefault(cat, []).append(entry)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('=' * 72 + '\n')
            f.write(f'ANOMALY LOG — {script_name}\n')
            f.write(f'Generated: {datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")}\n')
            f.write(f'Total anomalies: {len(self.entries)}\n')
            f.write('=' * 72 + '\n\n')
            f.write('Items in this log need to be reviewed by v2mgmt.\n')
            f.write('Each entry explains what was found and why it matters.\n\n')

            for cat in sorted(categories.keys()):
                items = categories[cat]
                f.write('-' * 72 + '\n')
                f.write(f'[{cat}] ({len(items)} items)\n')
                f.write('-' * 72 + '\n\n')
                for item in sorted(items, key=lambda x: x['resource_id']):
                    f.write(f'  {item["resource_id"]}:\n')
                    for line in item['detail'].split('\n'):
                        f.write(f'    {line}\n')
                    f.write('\n')

    def summary(self):
        """Return a short summary string for console output."""
        categories = {}
        for entry in self.entries:
            cat = entry['category']
            categories[cat] = categories.get(cat, 0) + 1
        lines = [f'  {count} {cat}' for cat, count in sorted(categories.items())]
        return '\n'.join(lines)


# ---------------------------------------------------------------------------
# File I/O helpers
# ---------------------------------------------------------------------------

def load_json(filepath):
    """Load and return parsed JSON from a file.

    Args:
        filepath: Path to the JSON file

    Returns:
        Parsed JSON data (dict or list)
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)


def write_xml_file(filepath, content):
    """Write an XHTML content file wrapped in a div element.

    The IG Publisher expects intro/notes fragments to be valid XHTML
    wrapped in a single root div with the XHTML namespace.

    Args:
        filepath: Path to write the XML file
        content: XHTML content string (will be wrapped in a div)
    """
    xml = (
        '<div xmlns="http://www.w3.org/1999/xhtml">\n'
        f'{content}\n'
        '</div>\n'
    )
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(xml)


# ---------------------------------------------------------------------------
# Text processing
# ---------------------------------------------------------------------------

def escape_xml(text):
    """Escape text for use in XHTML content.

    Args:
        text: Raw text string

    Returns:
        XML-safe string with &, <, >, " escaped
    """
    return (text
            .replace('&', '&amp;')
            .replace('<', '&lt;')
            .replace('>', '&gt;')
            .replace('"', '&quot;'))


def html5_to_xhtml(html):
    """Convert HTML5 output from Asciidoctor to valid XHTML.

    Fixes self-closing tags, bare ampersands, and heading levels that
    the IG Publisher's XML parser requires.

    Args:
        html: HTML5 string from Asciidoctor

    Returns:
        XHTML-compatible string
    """
    # Self-close void elements: <br> -> <br/>, etc.
    html = re.sub(r'<(br|hr|img|col)(\s[^>]*)?>(?!</)', r'<\1\2/>', html)
    # Escape bare & that aren't already entity references
    html = re.sub(r'&(?!amp;|lt;|gt;|quot;|apos;|#\d+;|#x[0-9a-fA-F]+;)', '&amp;', html)
    # Downshift headings: h1->h3, h2->h4, h3->h5
    # IG Publisher forbids h1/h2 in intro/notes fragments.
    def _shift_heading(m):
        tag_start = m.group(1)  # '' or '/'
        level = int(m.group(2))
        new_level = min(level + 2, 6)
        return f'<{tag_start}h{new_level}'
    html = re.sub(r'<(/?)h([1-3])(?=[\s>])', _shift_heading, html)
    # Strip <sub>/<sup> tags — artifacts of Asciidoctor interpreting
    # ER7 ^ and ~ characters as superscript/subscript markup.
    html = re.sub(r'</?su[bp]>', '', html)
    return html


def convert_adoc_to_html(adoc_text):
    """Convert AsciiDoc text to XHTML fragment using Asciidoctor via Ruby subprocess.

    Args:
        adoc_text: AsciiDoc markup string

    Returns:
        XHTML fragment string, or empty string on error
    """
    if not adoc_text:
        return ''

    with tempfile.NamedTemporaryFile(mode='w', suffix='.adoc', delete=False,
                                     encoding='utf-8') as f:
        f.write(adoc_text)
        tmp_adoc = f.name

    try:
        result = subprocess.run(
            [RUBY_PATH, '-E', 'utf-8:utf-8', '-e',
             "require 'asciidoctor'; "
             "text = File.read(ARGV[0], encoding: 'utf-8'); "
             "html = Asciidoctor.convert(text, safe: :safe, "
             "header_footer: false, backend: 'html5'); "
             "puts html",
             tmp_adoc],
            capture_output=True, text=True, timeout=30,
            env=RUBY_ENV
        )
        if result.returncode != 0:
            print(f"  WARNING: Asciidoctor error: {result.stderr.strip()}", file=sys.stderr)
            return ''
        return html5_to_xhtml(result.stdout.strip())
    finally:
        os.unlink(tmp_adoc)
