#!/usr/bin/env python3
"""Generate an HTML report of event gaps between FHIR and V291.

Produces a navigable HTML report showing:
- Events in FHIR but not V291 (with reason and chapter/clause if known)
- Events in V291 but not FHIR (with chapter, clause, provenance)
- Summary statistics

Usage:
    python3 tooling/scripts/generate_event_gap_report.py
"""

import json
import glob
import os
import re
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
FHIR_EVENTS_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth', 'event', 'events')
V291_EVENTS_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'events')
OUTPUT_PATH = os.path.join(PROJECT_ROOT, 'v291-extracted', 'event-gap-report.html')

# ── Chapter names ─────────────────────────────────────────────────────────

CHAPTER_NAMES = {
    '02': 'Control',
    '02A': 'Data Types',
    '03': 'Patient Administration',
    '04': 'Order Entry',
    '04A': 'Pharmacy/Treatment Orders',
    '05': 'Query',
    '06': 'Financial Management',
    '07': 'Observation Reporting',
    '08': 'Master Files',
    '09': 'Medical Records / Document Management',
    '10': 'Scheduling',
    '11': 'Patient Referral',
    '12': 'Patient Care',
    '13': 'Clinical Laboratory Automation',
    '14': 'Application Management',
    '15': 'Personnel Management',
    '16': 'e-Claims',
    '17': 'Materials Management',
}

# ── Event domain mapping ──────────────────────────────────────────────────

DOMAIN_MAP = {
    'A': ('03', 'Patient Administration'),
    'B': ('15', 'Personnel Management'),
    'C': ('07', 'Observation Reporting'),
    'E': ('13', 'Clinical Laboratory Automation'),
    'I': ('11', 'Patient Referral'),
    'J': ('05', 'Query'),
    'K': ('05', 'Query'),
    'M': ('08', 'Master Files'),
    'N': ('14', 'Application Management'),
    'O': ('04', 'Order Entry'),
    'P': ('06', 'Financial Management'),
    'Q': ('05', 'Query'),
    'R': ('07', 'Observation Reporting'),
    'S': ('10', 'Scheduling'),
    'T': ('09', 'Medical Records / Document Mgmt'),
    'U': ('13', 'Clinical Laboratory Automation'),
    'V': ('04A', 'Pharmacy/Treatment Orders'),
    'Z': ('05', 'Query (user-defined)'),
}

# ── FHIR-only event categorization ────────────────────────────────────────

FHIR_ONLY_REASONS = {
    # CH03 — retained/withdrawn
    'A18': ('retained', 'Withdrawn as of v2.3.1/v2.7', 'ADT/ACK — Merge Patient Information'),
    'A19': ('retained', 'Withdrawn as of v2.4/v2.7', 'QRY/ADR — Patient Query (Original Mode)'),
    'A30': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Merge Person Information'),
    'A34': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Merge Patient Information – Patient ID Only'),
    'A35': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Merge Patient Information – Account Number Only'),
    'A36': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Merge Patient Information – Patient ID & Account Number'),
    'A39': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Merge Person – Patient ID'),
    'A46': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Change Patient ID'),
    'A48': ('retained', 'Withdrawn as of v2.3.1', 'ADT/ACK — Change Alternate Patient ID'),
    # CH04A — retained/withdrawn
    'V01': ('retained', 'Withdrawn as of v2.4/v2.7', 'XQ — Query for Vaccination Record'),
    'V02': ('retained', 'Withdrawn', 'VXX — Response to Vaccination Query (Multiple PID Matches)'),
    'V03': ('retained', 'Withdrawn as of v2.4/v2.7', 'VXR — Vaccination Record Response'),
    # CH05
    'Z85': ('not_in_v291', 'Z event (user-defined) — not in V2.9.1 Word doc; needs V2 management review', ''),
    'Z95': ('not_in_v291', 'Z event (user-defined) — not in V2.9.1 Word doc; needs V2 management review', ''),
    # CH06
    'P04': ('retained', 'Retained as of v2.4', 'QRY/DSR — Generate Bills and Accounts Receivable Statements'),
    'P09': ('retained', 'Withdrawn as of v2.7 — CH06 refers to CH07', 'Product Experience (defined by Orders/Observations TC)'),
    # CH07
    'R02': ('retained', 'Withdrawn', 'QRY/ORF — Query for Results of Observation'),
    'R04': ('retained', 'Withdrawn', 'QRY/ORF — Query for Results of Observation'),
    'R21': ('retained', 'Withdrawn as of v2.5/v2.7', 'OUL — Unsolicited Laboratory Observation'),
    # CH08
    'M01': ('retained', 'Withdrawn as of v2.7', 'MFN/MFK — Master File Notification'),
    'M03': ('retained', 'Withdrawn as of v2.7', 'MFN/MFK — Master File Notification – Test/Observation'),
    # CH09
    'T12': ('retained', 'Withdrawn as of v2.7', 'QRY/DOC — Document Query'),
    # CH10
    'S25': ('retained', 'Withdrawn as of v2.7', 'SQM/SQR — Schedule Query Message and Response'),
    # CH11
    'I05': ('retained', 'Removed as of v2.8', 'RQC/RCI — Request for Patient Clinical Information'),
    'I06': ('retained', 'Removed as of v2.8', 'RQC/RCL — Request/Receipt of Clinical Data Listing'),
    # CH12 — all retained
    'PC4': ('retained', 'Retained as of v2.4 / removed v2.8', 'QRY — Patient Care Problem Query'),
    'PC5': ('retained', 'Retained as of v2.4 / removed v2.8', 'PRR — Patient Problem Response'),
    'PC9': ('retained', 'Retained as of v2.4 / removed v2.8', 'QRY — Patient Goal Query'),
    'PCA': ('retained', 'Retained as of v2.4 / removed v2.8', 'PPV — Patient Goal Response'),
    'PCE': ('retained', 'Retained as of v2.4 / removed v2.8', 'QRY — Patient Pathway (Problem-Oriented) Query'),
    'PCF': ('retained', 'Retained as of v2.4 / removed v2.8', 'PTR — Patient Pathway (Problem-Oriented) Response'),
    'PCK': ('retained', 'Retained as of v2.4 / removed v2.8', 'QRY — Patient Pathway (Goal-Oriented) Query'),
    'PCL': ('retained', 'Retained as of v2.4 / removed v2.8', 'PPT — Patient Pathway (Goal-Oriented) Response'),
    # CH13
    'E30': ('not_in_v291', 'Not in CH13 Word doc — may be post-V2.9.1 addition', ''),
    'E31': ('not_in_v291', 'Not in CH13 Word doc — may be post-V2.9.1 addition', ''),
    # CH14
    'N01': ('retained', 'Withdrawn as of v2.5', 'NMQ — Application Management Query'),
    # FHIR sub-variants
    'O59_A': ('fhir_subvariant', 'FHIR sub-variant of O59', ''),
    'O59_B': ('fhir_subvariant', 'FHIR sub-variant of O59', ''),
    'ZNN_A': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
    'ZNN_B': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
    'ZNN_C': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
    'ZNN_D': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
    'ZNN_E': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
    'ZNN_F': ('fhir_subvariant', 'FHIR template sub-variant of Znn (user-defined query)', ''),
}


def infer_chapter(event_code):
    """Infer the chapter from an event code prefix."""
    # Try PC prefix first (Patient Care)
    if event_code.startswith('PC'):
        return '12', 'Patient Care'
    prefix = event_code[0]
    return DOMAIN_MAP.get(prefix, ('?', 'Unknown'))


def load_events():
    """Load all FHIR and V291 events."""
    fhir_events = {}
    for f in sorted(glob.glob(os.path.join(FHIR_EVENTS_DIR, '*.json'))):
        d = json.load(open(f))
        code = d.get('id', Path(f).stem)
        fhir_events[code] = d

    v291_events = defaultdict(list)
    for f in sorted(glob.glob(os.path.join(V291_EVENTS_DIR, '*.json'))):
        d = json.load(open(f))
        ec = d.get('eventCode', '')
        v291_events[ec].append(d)

    return fhir_events, dict(v291_events)


def generate_html(fhir_events, v291_events):
    """Generate the HTML gap report."""
    fhir_codes = set(fhir_events.keys())
    v291_codes = set(v291_events.keys())
    matched = sorted(fhir_codes & v291_codes)
    fhir_only = sorted(fhir_codes - v291_codes)
    v291_only = sorted(v291_codes - fhir_codes)

    # Categorize FHIR-only
    cat_counts = defaultdict(int)
    for code in fhir_only:
        cat = FHIR_ONLY_REASONS.get(code, ('unknown', 'Not yet categorized', ''))[0]
        cat_counts[cat] += 1

    now = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Event Gap Report — FHIR vs V2.9.1</title>
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{ font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
         color: #1a1a1a; background: #f8f9fa; line-height: 1.5; }}
  .container {{ max-width: 1100px; margin: 0 auto; padding: 20px; }}
  h1 {{ font-size: 1.6em; margin-bottom: 4px; color: #2c3e50; }}
  .subtitle {{ color: #666; font-size: 0.9em; margin-bottom: 20px; }}
  h2 {{ font-size: 1.3em; margin: 28px 0 12px; color: #2c3e50;
        border-bottom: 2px solid #3498db; padding-bottom: 6px; }}
  h3 {{ font-size: 1.1em; margin: 20px 0 8px; color: #34495e; }}

  /* Summary cards */
  .summary {{ display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 24px; }}
  .card {{ background: #fff; border-radius: 8px; padding: 16px 20px;
           box-shadow: 0 1px 3px rgba(0,0,0,0.1); flex: 1; min-width: 140px; }}
  .card .number {{ font-size: 2em; font-weight: 700; }}
  .card .label {{ font-size: 0.85em; color: #666; }}
  .card.matched .number {{ color: #27ae60; }}
  .card.fhir-only .number {{ color: #e67e22; }}
  .card.v291-only .number {{ color: #e74c3c; }}

  /* Tables */
  table {{ width: 100%; border-collapse: collapse; background: #fff;
           border-radius: 8px; overflow: hidden;
           box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 20px; }}
  th {{ background: #2c3e50; color: #fff; text-align: left;
        padding: 10px 14px; font-size: 0.85em; font-weight: 600; }}
  td {{ padding: 8px 14px; border-bottom: 1px solid #eee; font-size: 0.88em; }}
  tr:last-child td {{ border-bottom: none; }}
  tr:hover td {{ background: #f0f7ff; }}

  /* Category badges */
  .badge {{ display: inline-block; padding: 2px 8px; border-radius: 4px;
            font-size: 0.78em; font-weight: 600; }}
  .badge.retained {{ background: #fef3cd; color: #856404; }}
  .badge.fhir-subvariant {{ background: #d1ecf1; color: #0c5460; }}
  .badge.not-in-v291 {{ background: #f8d7da; color: #721c24; }}
  .badge.unknown {{ background: #e2e3e5; color: #383d41; }}
  .badge.ack-table {{ background: #d4edda; color: #155724; }}
  .badge.caption {{ background: #cce5ff; color: #004085; }}

  /* Sidebar nav */
  .layout {{ display: flex; gap: 20px; }}
  .sidebar {{ width: 220px; flex-shrink: 0; position: sticky; top: 20px; align-self: flex-start; }}
  .sidebar ul {{ list-style: none; }}
  .sidebar li {{ margin-bottom: 4px; }}
  .sidebar a {{ text-decoration: none; color: #3498db; font-size: 0.88em;
                display: block; padding: 4px 8px; border-radius: 4px; }}
  .sidebar a:hover {{ background: #e8f4fd; }}
  .main {{ flex: 1; min-width: 0; }}

  .chapter-tag {{ color: #888; font-size: 0.82em; }}
  .section-ref {{ color: #555; font-size: 0.82em; font-style: italic; }}
  .msg-info {{ color: #555; font-size: 0.82em; }}
</style>
</head>
<body>
<div class="container">
<h1>Event Gap Report</h1>
<p class="subtitle">FHIR StructureDefinitions vs V2.9.1 Word Document Extraction &mdash; {now}</p>

<div class="summary">
  <div class="card matched"><div class="number">{len(matched)}</div><div class="label">Matched</div></div>
  <div class="card fhir-only"><div class="number">{len(fhir_only)}</div><div class="label">FHIR Only</div></div>
  <div class="card v291-only"><div class="number">{len(v291_only)}</div><div class="label">V291 Only</div></div>
  <div class="card"><div class="number">{len(fhir_codes)}</div><div class="label">Total FHIR</div></div>
  <div class="card"><div class="number">{len(v291_codes)}</div><div class="label">Total V291</div></div>
</div>

<div class="layout">
<nav class="sidebar">
  <ul>
    <li><a href="#fhir-only">FHIR Only ({len(fhir_only)})</a></li>
    <li><a href="#fhir-retained">&nbsp;&nbsp;Retained/Withdrawn ({cat_counts.get('retained', 0)})</a></li>
    <li><a href="#fhir-subvariants">&nbsp;&nbsp;Sub-variants ({cat_counts.get('fhir_subvariant', 0)})</a></li>
    <li><a href="#fhir-notinv291">&nbsp;&nbsp;Not in V291 ({cat_counts.get('not_in_v291', 0)})</a></li>
    <li><a href="#v291-only">V291 Only ({len(v291_only)})</a></li>
  </ul>
</nav>
<div class="main">
"""

    # ── FHIR-only section ─────────────────────────────────────────────
    html += '<h2 id="fhir-only">Events in FHIR but not V291</h2>\n'
    html += f'<p>{len(fhir_only)} events exist in FHIR StructureDefinitions but were not extracted from V2.9.1 Word documents.</p>\n'

    # Group by category
    by_cat = defaultdict(list)
    for code in fhir_only:
        info = FHIR_ONLY_REASONS.get(code, ('unknown', 'Not yet categorized', ''))
        by_cat[info[0]].append((code, info[1], info[2]))

    # Retained/Withdrawn
    if 'retained' in by_cat:
        html += f'<h3 id="fhir-retained">Retained / Withdrawn ({len(by_cat["retained"])})</h3>\n'
        html += '<p>These events are documented in V2.9.1 as retained for backward compatibility or withdrawn. '
        html += 'No message structure or acknowledgment choreography tables exist to extract. '
        html += 'Extracting their definitions would require older V2 standard documents.</p>\n'
        html += '<table>\n<tr><th>Event</th><th>Chapter</th><th>Status</th><th>Description</th></tr>\n'
        for code, reason, desc in sorted(by_cat['retained']):
            ch_num, ch_name = infer_chapter(code)
            html += f'<tr><td><strong>{code}</strong></td>'
            html += f'<td><span class="chapter-tag">CH{ch_num} — {ch_name}</span></td>'
            html += f'<td><span class="badge retained">{reason}</span></td>'
            html += f'<td>{desc}</td></tr>\n'
        html += '</table>\n'

    # Sub-variants
    if 'fhir_subvariant' in by_cat:
        html += f'<h3 id="fhir-subvariants">FHIR Sub-variants ({len(by_cat["fhir_subvariant"])})</h3>\n'
        html += '<p>These are FHIR-specific sub-divisions of events that exist as a single event in V291.</p>\n'
        html += '<table>\n<tr><th>Event</th><th>Reason</th></tr>\n'
        for code, reason, desc in sorted(by_cat['fhir_subvariant']):
            html += f'<tr><td><strong>{code}</strong></td>'
            html += f'<td><span class="badge fhir-subvariant">{reason}</span></td></tr>\n'
        html += '</table>\n'

    # Not in V291
    if 'not_in_v291' in by_cat:
        html += f'<h3 id="fhir-notinv291">Not in V291 Word Docs ({len(by_cat["not_in_v291"])})</h3>\n'
        html += '<p>These events are not present in any V2.9.1 Word document examined.</p>\n'
        html += '<table>\n<tr><th>Event</th><th>Chapter</th><th>Reason</th></tr>\n'
        for code, reason, desc in sorted(by_cat['not_in_v291']):
            ch_num, ch_name = infer_chapter(code)
            html += f'<tr><td><strong>{code}</strong></td>'
            html += f'<td><span class="chapter-tag">CH{ch_num} — {ch_name}</span></td>'
            html += f'<td><span class="badge not-in-v291">{reason}</span></td></tr>\n'
        html += '</table>\n'

    # Unknown (should be 0)
    if 'unknown' in by_cat:
        html += f'<h3>Uncategorized ({len(by_cat["unknown"])})</h3>\n'
        html += '<table>\n<tr><th>Event</th><th>Chapter</th></tr>\n'
        for code, reason, desc in sorted(by_cat['unknown']):
            ch_num, ch_name = infer_chapter(code)
            html += f'<tr><td><strong>{code}</strong></td>'
            html += f'<td><span class="chapter-tag">CH{ch_num} — {ch_name}</span></td></tr>\n'
        html += '</table>\n'

    # ── V291-only section ─────────────────────────────────────────────
    html += '<h2 id="v291-only">Events in V291 but not FHIR</h2>\n'
    html += f'<p>{len(v291_only)} events were extracted from V2.9.1 Word documents but have no corresponding FHIR StructureDefinition.</p>\n'
    html += '<table>\n<tr><th>Event</th><th>Chapter</th><th>Section / Clause</th>'
    html += '<th>Message Type</th><th>Structure</th><th>Source</th></tr>\n'

    for code in v291_only:
        entries = v291_events.get(code, [])
        if not entries:
            continue
        for i, entry in enumerate(entries):
            prov = entry.get('provenance', {})
            ch = prov.get('chapter', '?')
            ch_name = CHAPTER_NAMES.get(ch, '')
            source_file = prov.get('sourceFile', '')
            section = prov.get('sectionHeading', '')
            msg_type = entry.get('messageType', '')
            struct_id = entry.get('structureId', '')
            derived = entry.get('derivedFrom', 'ack_choreography')

            source_badge = 'ack-table' if 'ack' in (derived or '') else 'caption'
            source_label = 'Ack table' if 'ack' in (derived or '') else 'Caption'

            row_event = f'<strong>{code}</strong>' if i == 0 else ''
            html += f'<tr><td>{row_event}</td>'
            html += f'<td><span class="chapter-tag">CH{ch} — {ch_name}</span></td>'
            html += f'<td class="section-ref">{section}</td>'
            html += f'<td class="msg-info">{msg_type}^{code}</td>'
            html += f'<td class="msg-info">{struct_id}</td>'
            html += f'<td><span class="badge {source_badge}">{source_label}</span></td></tr>\n'

    html += '</table>\n'

    # ── Close ─────────────────────────────────────────────────────────
    html += """
</div>
</div>
</div>
</body>
</html>"""

    return html


def main():
    print("Loading events...")
    fhir_events, v291_events = load_events()

    print("Generating HTML report...")
    html = generate_html(fhir_events, v291_events)

    with open(OUTPUT_PATH, 'w') as f:
        f.write(html)
    print(f"Report written to: {OUTPUT_PATH}")

    # Quick summary
    fhir_codes = set(fhir_events.keys())
    v291_codes = set(v291_events.keys())
    print(f"\nMatched: {len(fhir_codes & v291_codes)}")
    print(f"FHIR only: {len(fhir_codes - v291_codes)}")
    print(f"V291 only: {len(v291_codes - fhir_codes)}")


if __name__ == '__main__':
    main()
