#!/usr/bin/env python3
"""Compare FHIR message structure StructureDefinitions against V2.9.1 extracted data.

Flattens both representations to ordered segment lists, then compares:
  - Segment presence (missing/extra in either source)
  - Optionality (required vs optional)
  - Repetition (repeating vs non-repeating)
  - Group structure (which group a segment belongs to)
  - Description text (cosmetic vs meaningful differences)

Differences are categorized as:
  - COSMETIC: whitespace, capitalization, punctuation, abbreviation
  - STRUCTURAL: missing segments, optionality, repetition, group changes

Each discrepancy includes provenance (chapter, clause, table) from the Word docs.

Usage:
    python3 tooling/scripts/compare_message_structures.py
    python3 tooling/scripts/compare_message_structures.py --subset ADT_A01,ORU_R01
"""

import argparse
import json
import os
import re
import sys
from collections import defaultdict
from datetime import datetime, timezone
from difflib import SequenceMatcher
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from v2_utils import PROJECT_ROOT

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

FHIR_DIR = os.path.join(PROJECT_ROOT, 'input', 'sourceOfTruth',
                        'message-structure', 'message_structures')
V291_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted', 'message-structures')
REPORT_DIR = os.path.join(PROJECT_ROOT, 'v291-extracted')

# Difference categories
COSMETIC = 'cosmetic'
STRUCTURAL = 'structural'

# Difference dimensions
DIM_MISSING_SEGMENT = 'missing_segment'
DIM_EXTRA_SEGMENT = 'extra_segment'
DIM_OPTIONALITY = 'optionality'
DIM_REPETITION = 'repetition'
DIM_DESCRIPTION = 'description'
DIM_GROUP = 'group'
DIM_ORDERING = 'ordering'


# ---------------------------------------------------------------------------
# FHIR extraction
# ---------------------------------------------------------------------------

def extract_fhir_segments(fhir_data):
    """Extract an ordered list of segments from a FHIR message structure.

    Returns:
        List of dicts, each with:
            code: segment code (e.g. 'MSH')
            required: bool
            repeating: bool
            description: short name from the element
            group_path: tuple of group names from root to this element
            element_id: full element ID
    """
    elements = fhir_data.get('differential', {}).get('element', [])
    segments = []

    for elem in elements:
        eid = elem.get('id', '')
        types = elem.get('type', [])
        if not types:
            continue

        type_code = types[0].get('code', '')

        # Skip BackboneElement (group container) — we derive group info from path
        if type_code == 'BackboneElement':
            continue

        # Extract segment code from URL or bare code
        if '/' in type_code:
            seg_code = type_code.rsplit('/', 1)[-1]
        else:
            seg_code = type_code

        # Cardinality
        min_val = elem.get('min', 0)
        max_val = str(elem.get('max', '1'))
        required = (min_val >= 1)
        repeating = (max_val == '*' or (max_val.isdigit() and int(max_val) > 1))

        # Description
        description = elem.get('short', '')

        # Group path: derive from element ID hierarchy
        # e.g. "ADT_A01-A.34-INSURANCE.8-AUTHORIZATION.1-AUT" ->
        #   group path = ("INSURANCE", "AUTHORIZATION")
        group_path = _extract_group_path(eid)

        segments.append({
            'code': seg_code,
            'required': required,
            'repeating': repeating,
            'description': description,
            'group_path': group_path,
            'element_id': eid,
        })

    return segments


def _extract_group_path(element_id):
    """Extract the group nesting path from a FHIR element ID.

    Example:
        "ADT_A01-A.34-INSURANCE.8-AUTHORIZATION.1-AUT"
        -> ("INSURANCE", "AUTHORIZATION")
    """
    parts = element_id.split('.')
    groups = []
    for part in parts[1:-1]:  # skip root and leaf
        # Part format: "N-NAME" — extract NAME
        if '-' in part:
            name = part.split('-', 1)[1]
            groups.append(name)
    return tuple(groups)


# ---------------------------------------------------------------------------
# V291 extraction
# ---------------------------------------------------------------------------

def extract_v291_segments(v291_data):
    """Extract an ordered list of segments from V291 rawRows.

    Parses bracket notation:
        MSH             -> required, non-repeating
        [ SEG ]         -> optional, non-repeating
        { SEG }         -> required, repeating
        [{ SEG }]       -> optional, repeating
        [{              -> group begin (optional, repeating)
        [               -> group begin (optional, non-repeating)
        }]              -> group end

    Returns:
        List of dicts, each with:
            code: segment code
            required: bool
            repeating: bool
            description: description text
            group_path: tuple of group names
            raw_notation: original bracket notation
    """
    raw_rows = v291_data.get('rawRows', [])
    segments = []
    group_stack = []

    for row in raw_rows:
        seg_str = row.get('segments', '').strip()
        desc = row.get('description', '').strip()

        if not seg_str:
            continue

        # Skip choice group markers (handled structurally, not as segments)
        if _is_choice_marker(seg_str):
            continue

        # Check for group begin marker
        if _is_group_begin(seg_str, desc):
            # Try description first, fall back to status (CH13 column mapping)
            group_name = _extract_group_name(desc)
            if not group_name or group_name == desc.strip():
                status_desc = row.get('status', '').strip()
                if status_desc:
                    alt = _extract_group_name(status_desc)
                    if alt:
                        group_name = alt
            group_stack.append(group_name)
            continue

        # Check for group end marker
        if _is_group_end(seg_str, desc):
            if group_stack:
                group_stack.pop()
            continue

        # Regular segment row — parse bracket notation
        code, required, repeating = _parse_bracket_notation(seg_str)
        if not code:
            continue

        # Some chapters (e.g., CH13) have a column mapping bug where the
        # description field contains bracket notation instead of the real
        # description. Detect and try the status field as fallback.
        if _is_bracket_notation(desc) or desc == code:
            fallback = row.get('status', '').strip()
            if fallback and not _is_bracket_notation(fallback):
                desc = fallback

        segments.append({
            'code': code,
            'required': required,
            'repeating': repeating,
            'description': desc,
            'group_path': tuple(group_stack),
            'raw_notation': seg_str,
        })

    return segments


def _is_group_begin(seg_str, desc):
    """Check if a rawRow is a group begin marker."""
    stripped = seg_str.replace(' ', '')
    # Pure bracket openers: [{, [, {
    if stripped in ('[{', '[', '{'):
        return True
    # Description-based: "--- NAME begin"
    if desc.startswith('---') and 'begin' in desc.lower():
        return True
    return False


def _is_group_end(seg_str, desc):
    """Check if a rawRow is a group end marker."""
    stripped = seg_str.replace(' ', '')
    if stripped in ('}]', ']', '}'):
        return True
    if desc.startswith('---') and 'end' in desc.lower():
        return True
    return False


def _is_choice_marker(seg_str):
    """Check if a rawRow is a choice group marker (<, |, >)."""
    return seg_str.strip() in ('<', '>', '|')


def _extract_group_name(desc):
    """Extract the group name from a begin marker description.

    "--- NEXT_OF_KIN begin" -> "NEXT_OF_KIN"
    "---ORDER_FOR_SPECIMEN_CONTAINER begin" -> "ORDER_FOR_SPECIMEN_CONTAINER"
    "PRODUCT_SERVICE_SECTION begin" -> "PRODUCT_SERVICE_SECTION"
    """
    s = desc.strip()
    # Strip leading "---" (with or without space)
    s = re.sub(r'^---\s*', '', s)
    # Strip trailing "begin" (case-insensitive)
    s = re.sub(r'\s*begin\s*$', '', s, flags=re.IGNORECASE)
    return s.strip() if s.strip() else desc.strip()


def _is_bracket_notation(s):
    """Check if a string looks like V2 bracket notation rather than a description."""
    stripped = s.strip()
    if not stripped:
        return False
    # Pure segment code (2-3 uppercase letters)
    if re.match(r'^[A-Z][A-Z0-9]{1,2}$', stripped):
        return True
    # Bracket-wrapped: [SEG], [{SEG}], etc.
    if re.match(r'^[\[\{}\]\s]+[A-Z][A-Z0-9]{1,2}[\[\{}\]\s]+$', stripped):
        return True
    return False


def _parse_bracket_notation(seg_str):
    """Parse V2 bracket notation into (code, required, repeating).

    Returns:
        (code, required, repeating) or (None, None, None) if not a segment.
    """
    stripped = seg_str.strip()

    # Remove whitespace inside brackets for consistent parsing
    normalized = re.sub(r'\s+', '', stripped)

    # [{ CODE }] — optional, repeating
    m = re.match(r'^\[\{(\w+)\}\]$', normalized)
    if m:
        return m.group(1), False, True

    # [ CODE ] — optional, non-repeating
    m = re.match(r'^\[(\w+)\]$', normalized)
    if m:
        return m.group(1), False, False

    # { CODE } — required, repeating
    m = re.match(r'^\{(\w+)\}$', normalized)
    if m:
        return m.group(1), True, True

    # Bare CODE — required, non-repeating
    m = re.match(r'^(\w+)$', normalized)
    if m:
        return m.group(1), True, False

    return None, None, None


# ---------------------------------------------------------------------------
# Matching and comparison
# ---------------------------------------------------------------------------

def load_fhir_structures():
    """Load all FHIR message structures, grouped by base ID.

    Returns:
        Dict of base_id -> list of (variant_suffix, fhir_data, file_path).
        For non-sub-variant structures, variant_suffix is None.
    """
    structures = defaultdict(list)
    for fname in sorted(os.listdir(FHIR_DIR)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(FHIR_DIR, fname)
        data = json.load(open(fpath))
        struct_id = data.get('id', '')

        # Determine base ID and variant suffix
        # ACK-A -> base=ACK, suffix=A
        # ADT_A01-A -> base=ADT_A01, suffix=A
        # ADT_A02 -> base=ADT_A02, suffix=None
        base_id, suffix = _split_structure_id(struct_id)
        structures[base_id].append((suffix, data, fpath))

    return dict(structures)


def _split_structure_id(struct_id):
    """Split a FHIR structure ID into (base, suffix).

    Examples:
        "ADT_A01-A" -> ("ADT_A01", "A")
        "ADT_A02"   -> ("ADT_A02", None)
        "ACK-BZ"    -> ("ACK", "BZ")
    """
    # Match pattern: BASE-SUFFIX where SUFFIX is 1-2 uppercase letters
    m = re.match(r'^(.+)-([A-Z]{1,2})$', struct_id)
    if m:
        return m.group(1), m.group(2)
    return struct_id, None


def load_v291_structures():
    """Load all V291 message structures, grouped by structure ID.

    Returns:
        Dict of structure_id -> list of (v291_data, file_path).
    """
    structures = defaultdict(list)
    for fname in sorted(os.listdir(V291_DIR)):
        if not fname.endswith('.json'):
            continue
        fpath = os.path.join(V291_DIR, fname)
        data = json.load(open(fpath))
        struct_id = data.get('structureId', '')
        if struct_id:
            structures[struct_id].append((data, fpath))
    return dict(structures)


def align_segment_lists(fhir_segs, v291_segs):
    """Align two segment lists using longest common subsequence on codes.

    Returns:
        List of (fhir_idx_or_None, v291_idx_or_None) pairs.
        Both are set for matched segments; one is None for unmatched.
    """
    fhir_codes = [s['code'] for s in fhir_segs]
    v291_codes = [s['code'] for s in v291_segs]

    # Use SequenceMatcher for LCS-based alignment
    matcher = SequenceMatcher(None, fhir_codes, v291_codes)
    alignment = []
    fi = 0
    vi = 0

    for op, f1, f2, v1, v2 in matcher.get_opcodes():
        if op == 'equal':
            # Advance any unmatched before this block
            while fi < f1:
                alignment.append((fi, None))
                fi += 1
            while vi < v1:
                alignment.append((None, vi))
                vi += 1
            # Matched block
            for i in range(f2 - f1):
                alignment.append((f1 + i, v1 + i))
            fi = f2
            vi = v2
        elif op == 'replace':
            while fi < f1:
                alignment.append((fi, None))
                fi += 1
            while vi < v1:
                alignment.append((None, vi))
                vi += 1
            # In a replace block, emit FHIR-only then V291-only
            for i in range(f1, f2):
                alignment.append((i, None))
            for i in range(v1, v2):
                alignment.append((None, i))
            fi = f2
            vi = v2
        elif op == 'insert':
            while fi < f1:
                alignment.append((fi, None))
                fi += 1
            while vi < v1:
                alignment.append((None, vi))
                vi += 1
            for i in range(v1, v2):
                alignment.append((None, i))
            vi = v2
        elif op == 'delete':
            while fi < f1:
                alignment.append((fi, None))
                fi += 1
            while vi < v1:
                alignment.append((None, vi))
                vi += 1
            for i in range(f1, f2):
                alignment.append((i, None))
            fi = f2

    # Remaining
    while fi < len(fhir_segs):
        alignment.append((fi, None))
        fi += 1
    while vi < len(v291_segs):
        alignment.append((None, vi))
        vi += 1

    return alignment


def compare_pair(fhir_segs, v291_segs, structure_id, provenance):
    """Compare a single FHIR structure against a single V291 occurrence.

    Returns:
        List of discrepancy dicts.
    """
    alignment = align_segment_lists(fhir_segs, v291_segs)
    discrepancies = []

    for fi, vi in alignment:
        if fi is not None and vi is not None:
            # Matched segment — compare dimensions
            fs = fhir_segs[fi]
            vs = v291_segs[vi]
            discrepancies.extend(
                _compare_matched_segment(fs, vs, structure_id, provenance, fi, vi))
        elif fi is not None and vi is None:
            # FHIR-only segment
            fs = fhir_segs[fi]
            discrepancies.append({
                'structure_id': structure_id,
                'dimension': DIM_EXTRA_SEGMENT,
                'category': STRUCTURAL,
                'segment_code': fs['code'],
                'position': fi + 1,
                'detail': f"Segment {fs['code']} in FHIR but not in V291",
                'fhir_value': f"{fs['code']} ({fs['description']})",
                'v291_value': None,
                'fhir_group': '/'.join(fs['group_path']) or '(root)',
                'provenance': provenance,
            })
        elif vi is not None and fi is None:
            # V291-only segment
            vs = v291_segs[vi]
            discrepancies.append({
                'structure_id': structure_id,
                'dimension': DIM_MISSING_SEGMENT,
                'category': STRUCTURAL,
                'segment_code': vs['code'],
                'position': vi + 1,
                'detail': f"Segment {vs['code']} in V291 but not in FHIR",
                'fhir_value': None,
                'v291_value': f"{vs['code']} ({vs['description']})",
                'v291_group': '/'.join(vs['group_path']) or '(root)',
                'provenance': provenance,
            })

    return discrepancies


def _compare_matched_segment(fs, vs, structure_id, provenance, fi, vi):
    """Compare a matched pair of segments across all dimensions."""
    discs = []
    code = fs['code']

    # 1. Optionality
    if fs['required'] != vs['required']:
        fhir_opt = 'R' if fs['required'] else 'O'
        v291_opt = 'R' if vs['required'] else 'O'
        discs.append({
            'structure_id': structure_id,
            'dimension': DIM_OPTIONALITY,
            'category': STRUCTURAL,
            'segment_code': code,
            'position': fi + 1,
            'detail': f"{code} optionality: FHIR={fhir_opt}, V291={v291_opt}",
            'fhir_value': fhir_opt,
            'v291_value': v291_opt,
            'provenance': provenance,
        })

    # 2. Repetition
    if fs['repeating'] != vs['repeating']:
        fhir_rep = 'Y' if fs['repeating'] else 'N'
        v291_rep = 'Y' if vs['repeating'] else 'N'
        discs.append({
            'structure_id': structure_id,
            'dimension': DIM_REPETITION,
            'category': STRUCTURAL,
            'segment_code': code,
            'position': fi + 1,
            'detail': f"{code} repetition: FHIR={fhir_rep}, V291={v291_rep}",
            'fhir_value': fhir_rep,
            'v291_value': v291_rep,
            'provenance': provenance,
        })

    # 3. Description
    desc_diff = _compare_descriptions(fs['description'], vs['description'])
    if desc_diff:
        discs.append({
            'structure_id': structure_id,
            'dimension': DIM_DESCRIPTION,
            'category': desc_diff['category'],
            'segment_code': code,
            'position': fi + 1,
            'detail': desc_diff['detail'],
            'fhir_value': fs['description'],
            'v291_value': vs['description'],
            'provenance': provenance,
        })

    # 4. Group path
    if fs['group_path'] != vs['group_path']:
        # Check if it's just a naming difference vs structural
        cat = _classify_group_diff(fs['group_path'], vs['group_path'])
        discs.append({
            'structure_id': structure_id,
            'dimension': DIM_GROUP,
            'category': cat,
            'segment_code': code,
            'position': fi + 1,
            'detail': (f"{code} group: FHIR={'/'.join(fs['group_path']) or '(root)'}, "
                       f"V291={'/'.join(vs['group_path']) or '(root)'}"),
            'fhir_value': '/'.join(fs['group_path']) or '(root)',
            'v291_value': '/'.join(vs['group_path']) or '(root)',
            'provenance': provenance,
        })

    return discs


def _compare_descriptions(fhir_desc, v291_desc):
    """Compare two description strings and classify the difference.

    Returns:
        None if identical, or dict with 'category' and 'detail'.
    """
    fhir_desc = fhir_desc or ''
    v291_desc = v291_desc or ''

    if fhir_desc == v291_desc:
        return None

    # Normalize for cosmetic comparison
    f_norm = _normalize_desc(fhir_desc)
    v_norm = _normalize_desc(v291_desc)

    if f_norm == v_norm:
        return {
            'category': COSMETIC,
            'detail': "Description cosmetic difference (whitespace/case/punctuation)",
        }

    # Check for abbreviation/expansion patterns
    if _is_abbreviation_diff(fhir_desc, v291_desc):
        return {
            'category': COSMETIC,
            'detail': "Description abbreviation difference",
        }

    # Check for typos: high similarity (>= 90%) after normalization
    ratio = SequenceMatcher(None, f_norm, v_norm).ratio()
    if ratio >= 0.90:
        return {
            'category': COSMETIC,
            'detail': f"Description typo/minor difference ({ratio:.0%} similar)",
        }

    # Check for en-dash/em-dash vs hyphen or other Unicode normalization
    f_ascii = _asciify(fhir_desc)
    v_ascii = _asciify(v291_desc)
    if _normalize_desc(f_ascii) == _normalize_desc(v_ascii):
        return {
            'category': COSMETIC,
            'detail': "Description Unicode normalization difference (dash/quote variants)",
        }

    return {
        'category': STRUCTURAL,
        'detail': "Description differs meaningfully",
    }


def _normalize_desc(desc):
    """Normalize a description for cosmetic comparison."""
    s = _asciify(desc)
    s = s.lower().strip()
    # Normalize whitespace
    s = re.sub(r'\s+', ' ', s)
    # Remove trailing punctuation
    s = s.rstrip('.,:;')
    # Normalize common abbreviations (use word-boundary-aware replacement
    # to avoid 'information' -> 'informationrmation')
    s = re.sub(r'\binfo\b\.?', 'information', s)
    s = s.replace('cert.', 'certification')
    s = s.replace('assoc.', 'associated')
    s = s.replace('addtl.', 'additional')
    # Normalize spelling variants
    s = s.replace('acknowledgement', 'acknowledgment')
    # Normalize separators
    s = s.replace(' - ', ' ')
    s = s.replace('-', ' ')
    s = s.replace('/', ' ')
    return s


def _is_abbreviation_diff(a, b):
    """Check if two strings differ only by common abbreviation patterns."""
    # If one contains the other as a substring (ignoring case), likely abbreviation
    al = a.lower()
    bl = b.lower()
    # Common patterns: "Additional Info." vs "Additional Information"
    if al.replace('.', '') in bl.replace('.', '') or bl.replace('.', '') in al.replace('.', ''):
        return True
    return False


def _asciify(s):
    """Replace common Unicode characters with ASCII equivalents."""
    s = s.replace('\u2013', '-')   # en-dash
    s = s.replace('\u2014', '-')   # em-dash
    s = s.replace('\u2018', "'")   # left single quote
    s = s.replace('\u2019', "'")   # right single quote
    s = s.replace('\u201c', '"')   # left double quote
    s = s.replace('\u201d', '"')   # right double quote
    s = s.replace('\u2026', '...')  # ellipsis
    return s


def _classify_group_diff(fhir_path, v291_path):
    """Classify a group path difference as cosmetic or structural."""
    # Same depth, same names when normalized -> cosmetic
    if len(fhir_path) == len(v291_path):
        all_match = all(
            _normalize_group_name(f) == _normalize_group_name(v)
            for f, v in zip(fhir_path, v291_path)
        )
        if all_match:
            return COSMETIC
    return STRUCTURAL


def _normalize_group_name(name):
    """Normalize a group name for comparison."""
    return name.upper().replace(' ', '_').replace('-', '_')


# ---------------------------------------------------------------------------
# Structure matching: FHIR sub-variants to V291 occurrences
# ---------------------------------------------------------------------------

def match_structures(fhir_structs, v291_structs):
    """Match FHIR structures (including sub-variants) to V291 occurrences.

    Strategy:
    1. Non-sub-variant FHIR structures match to V291 by base ID.
    2. Sub-variant FHIR structures: compare each against all V291
       occurrences and find best matches.

    Returns:
        List of match dicts with:
            fhir_id, fhir_data, v291_data, v291_provenance, match_type
    """
    matches = []

    for base_id, fhir_variants in fhir_structs.items():
        v291_occs = v291_structs.get(base_id, [])

        if not v291_occs:
            # No V291 match — skip (will be reported in summary)
            for suffix, fdata, fpath in fhir_variants:
                matches.append({
                    'fhir_id': fdata['id'],
                    'fhir_data': fdata,
                    'v291_data': None,
                    'v291_provenance': None,
                    'match_type': 'no_v291_match',
                })
            continue

        if len(fhir_variants) == 1 and fhir_variants[0][0] is None:
            # Single, non-sub-variant FHIR structure
            suffix, fdata, fpath = fhir_variants[0]
            # Compare against first V291 occurrence (canonical)
            v291_data, v291_path = v291_occs[0]
            prov = v291_data.get('provenance', {})
            matches.append({
                'fhir_id': fdata['id'],
                'fhir_data': fdata,
                'v291_data': v291_data,
                'v291_provenance': prov,
                'match_type': 'direct',
            })
        else:
            # Sub-variants — find best match for each
            # Sort V291 occurrences by chapter/table for stable ordering
            sorted_v291 = sorted(v291_occs,
                key=lambda x: (x[0].get('provenance',{}).get('chapter',''),
                               x[0].get('provenance',{}).get('tableIndex',0)))

            # Compare each FHIR variant against each V291 occurrence
            # and find the best-matching pair
            for suffix, fdata, fpath in sorted(fhir_variants, key=lambda x: x[0] or ''):
                fhir_segs = extract_fhir_segments(fdata)
                best_match = None
                best_score = -1

                for v291_data, v291_path in sorted_v291:
                    v291_segs = extract_v291_segments(v291_data)
                    score = _match_score(fhir_segs, v291_segs)
                    if score > best_score:
                        best_score = score
                        best_match = (v291_data, v291_path)

                if best_match:
                    v291_data, v291_path = best_match
                    prov = v291_data.get('provenance', {})
                    matches.append({
                        'fhir_id': fdata['id'],
                        'fhir_data': fdata,
                        'v291_data': v291_data,
                        'v291_provenance': prov,
                        'match_type': 'sub_variant_best_match',
                        'match_score': best_score,
                    })

    return matches


def _match_score(fhir_segs, v291_segs):
    """Score how well two segment lists match (higher = better)."""
    fhir_codes = [s['code'] for s in fhir_segs]
    v291_codes = [s['code'] for s in v291_segs]
    matcher = SequenceMatcher(None, fhir_codes, v291_codes)
    return matcher.ratio()


# ---------------------------------------------------------------------------
# Report generation
# ---------------------------------------------------------------------------

def generate_reports(all_discrepancies, match_results, fhir_structs, v291_structs,
                     truncated_ids=None):
    """Generate JSON and Markdown reports."""
    truncated_ids = truncated_ids or set()
    timestamp = datetime.now(timezone.utc).isoformat()

    # Summary statistics
    total_fhir = sum(len(v) for v in fhir_structs.values())
    total_v291_ids = len(v291_structs)
    matched = sum(1 for m in match_results if m['v291_data'] is not None)
    unmatched_fhir = sum(1 for m in match_results if m['v291_data'] is None)

    # Categorize discrepancies
    cosmetic_discs = [d for d in all_discrepancies if d['category'] == COSMETIC]
    structural_discs = [d for d in all_discrepancies if d['category'] == STRUCTURAL]

    # Sub-categorize structural
    missing_segs = [d for d in structural_discs if d['dimension'] == DIM_MISSING_SEGMENT]
    extra_segs = [d for d in structural_discs if d['dimension'] == DIM_EXTRA_SEGMENT]
    opt_diffs = [d for d in structural_discs if d['dimension'] == DIM_OPTIONALITY]
    rep_diffs = [d for d in structural_discs if d['dimension'] == DIM_REPETITION]
    group_diffs = [d for d in structural_discs if d['dimension'] == DIM_GROUP]
    desc_diffs_structural = [d for d in structural_discs if d['dimension'] == DIM_DESCRIPTION]
    desc_diffs_cosmetic = [d for d in cosmetic_discs if d['dimension'] == DIM_DESCRIPTION]
    group_diffs_cosmetic = [d for d in cosmetic_discs if d['dimension'] == DIM_GROUP]

    # Build report data
    report = {
        'timestamp': timestamp,
        'summary': {
            'fhir_structures': total_fhir,
            'v291_unique_ids': total_v291_ids,
            'matched_pairs': matched,
            'unmatched_fhir': unmatched_fhir,
            'truncated_v291': len(truncated_ids),
            'compared_pairs': matched - len(truncated_ids),
            'total_discrepancies': len(all_discrepancies),
            'cosmetic_discrepancies': len(cosmetic_discs),
            'structural_discrepancies': len(structural_discs),
        },
        'truncated_structures': sorted(truncated_ids),
        'structural_breakdown': {
            'missing_segments_v291_only': len(missing_segs),
            'extra_segments_fhir_only': len(extra_segs),
            'optionality_differences': len(opt_diffs),
            'repetition_differences': len(rep_diffs),
            'group_structure_differences': len(group_diffs),
            'description_differences': len(desc_diffs_structural),
        },
        'cosmetic_breakdown': {
            'description_cosmetic': len(desc_diffs_cosmetic),
            'group_name_cosmetic': len(group_diffs_cosmetic),
        },
        'discrepancies': all_discrepancies,
    }

    # Write JSON report
    json_path = os.path.join(REPORT_DIR, 'message-structure-comparison-report.json')
    with open(json_path, 'w') as f:
        json.dump(report, f, indent=2, default=str)
    print(f"JSON report: {json_path}")

    # Write Markdown report
    md_path = os.path.join(REPORT_DIR, 'message-structure-comparison-report.md')
    _write_markdown_report(md_path, report, match_results, fhir_structs, v291_structs)
    print(f"Markdown report: {md_path}")

    return report


def _write_markdown_report(path, report, match_results, fhir_structs, v291_structs):
    """Write the Markdown comparison report."""
    s = report['summary']
    sb = report['structural_breakdown']
    cb = report['cosmetic_breakdown']
    lines = []
    lines.append("# Message Structure Comparison Report: FHIR vs V2.9.1")
    lines.append("")
    lines.append(f"Generated: {report['timestamp']}")
    lines.append("")

    # Summary
    lines.append("## Summary")
    lines.append("")
    lines.append(f"| Metric | Count |")
    lines.append(f"|--------|-------|")
    lines.append(f"| FHIR structures | {s['fhir_structures']} |")
    lines.append(f"| V291 unique structure IDs | {s['v291_unique_ids']} |")
    lines.append(f"| Matched pairs compared | {s['compared_pairs']} |")
    lines.append(f"| Unmatched FHIR (no V291) | {s['unmatched_fhir']} |")
    lines.append(f"| Truncated V291 (skipped) | {s['truncated_v291']} |")
    lines.append(f"| **Total discrepancies** | **{s['total_discrepancies']}** |")
    lines.append(f"| Structural | {s['structural_discrepancies']} |")
    lines.append(f"| Cosmetic | {s['cosmetic_discrepancies']} |")
    lines.append("")

    # Structural breakdown
    lines.append("## Structural Differences (Require Review)")
    lines.append("")
    lines.append(f"| Category | Count |")
    lines.append(f"|----------|-------|")
    lines.append(f"| Segments in V291 but not FHIR | {sb['missing_segments_v291_only']} |")
    lines.append(f"| Segments in FHIR but not V291 | {sb['extra_segments_fhir_only']} |")
    lines.append(f"| Optionality differences | {sb['optionality_differences']} |")
    lines.append(f"| Repetition differences | {sb['repetition_differences']} |")
    lines.append(f"| Group structure differences | {sb['group_structure_differences']} |")
    lines.append(f"| Description differences (meaningful) | {sb['description_differences']} |")
    lines.append("")

    # Cosmetic breakdown
    lines.append("## Cosmetic Differences (Auto-Resolvable)")
    lines.append("")
    lines.append(f"| Category | Count |")
    lines.append(f"|----------|-------|")
    lines.append(f"| Description whitespace/case/punctuation | {cb['description_cosmetic']} |")
    lines.append(f"| Group name formatting | {cb['group_name_cosmetic']} |")
    lines.append("")

    # Group discrepancies by structure
    by_structure = defaultdict(list)
    for d in report['discrepancies']:
        by_structure[d['structure_id']].append(d)

    # Consolidated patterns (group identical diffs across sub-variants)
    lines.append("## Consolidated Structural Patterns")
    lines.append("")
    lines.append("Identical discrepancies appearing across multiple sub-variants of the same base structure,")
    lines.append("grouped for readability:")
    lines.append("")

    structural_discs_all = [d for d in report['discrepancies'] if d['category'] == STRUCTURAL]
    pattern_groups = defaultdict(list)
    for d in structural_discs_all:
        base = d['structure_id'].rsplit('-', 1)[0] if re.match(r'^.+-[A-Z]{1,2}$', d['structure_id']) else d['structure_id']
        key = (base, d['dimension'], d.get('segment_code', ''),
               str(d.get('fhir_value', '')), str(d.get('v291_value', '')))
        pattern_groups[key].append(d['structure_id'])

    multi_patterns = [(k, v) for k, v in pattern_groups.items() if len(v) >= 2]
    if multi_patterns:
        lines.append("| Base Structure | Dimension | Segment | FHIR | V291 | Sub-variants |")
        lines.append("|----------------|-----------|---------|------|------|-------------|")
        for (base, dim, seg, fv, vv), sids in sorted(multi_patterns, key=lambda x: (x[0][0], x[0][1])):
            suffixes = ', '.join(sorted(set(
                s.rsplit('-', 1)[1] if '-' in s and re.match(r'^.+-[A-Z]{1,2}$', s) else s
                for s in sids
            )))
            lines.append(f"| {base} | {dim} | {seg} | {fv or '-'} | {vv or '-'} | {suffixes} ({len(sids)}) |")
        lines.append("")
    else:
        lines.append("No repeated patterns found.")
        lines.append("")

    # Structural discrepancies detail
    lines.append("## Structural Discrepancies by Structure")
    lines.append("")
    for sid in sorted(by_structure.keys()):
        discs = by_structure[sid]
        structural = [d for d in discs if d['category'] == STRUCTURAL]
        if not structural:
            continue

        # Get provenance from first disc
        prov = structural[0].get('provenance', {})
        ch = prov.get('chapter', '?')
        section = prov.get('sectionHeading', '?')
        lines.append(f"### {sid}")
        lines.append(f"**Source:** CH{ch}, \"{section}\"")
        lines.append("")

        for d in structural:
            dim_label = {
                DIM_MISSING_SEGMENT: 'MISSING (V291-only)',
                DIM_EXTRA_SEGMENT: 'EXTRA (FHIR-only)',
                DIM_OPTIONALITY: 'OPTIONALITY',
                DIM_REPETITION: 'REPETITION',
                DIM_GROUP: 'GROUP',
                DIM_DESCRIPTION: 'DESCRIPTION',
            }.get(d['dimension'], d['dimension'])

            seg = d.get('segment_code', '?')
            pos = d.get('position', '?')
            lines.append(f"- **[{dim_label}]** {seg} (pos {pos}): {d['detail']}")
            if d.get('fhir_value') is not None:
                lines.append(f"  - FHIR: `{d['fhir_value']}`")
            if d.get('v291_value') is not None:
                lines.append(f"  - V291: `{d['v291_value']}`")
        lines.append("")

    # Cosmetic discrepancies — summary table
    lines.append("## Cosmetic Discrepancies (Detail)")
    lines.append("")
    cosmetic_list = [d for d in report['discrepancies'] if d['category'] == COSMETIC]
    if cosmetic_list:
        lines.append("| Structure | Segment | Dimension | FHIR | V291 |")
        lines.append("|-----------|---------|-----------|------|------|")
        for d in sorted(cosmetic_list, key=lambda x: (x['structure_id'], x.get('position', 0))):
            fv = d.get('fhir_value', '') or ''
            vv = d.get('v291_value', '') or ''
            lines.append(f"| {d['structure_id']} | {d.get('segment_code','?')} | "
                         f"{d['dimension']} | {fv} | {vv} |")
        lines.append("")
    else:
        lines.append("None found.")
        lines.append("")

    # Truncated V291 extractions
    if report.get('truncated_structures'):
        lines.append("## Truncated V291 Extractions (Skipped)")
        lines.append("")
        lines.append("These structures have V291 extractions with less than half the FHIR segment")
        lines.append("count, indicating the Word doc table extraction was cut off. They are excluded")
        lines.append("from the comparison to avoid false FHIR-only segments.")
        lines.append("")
        for sid in report['truncated_structures']:
            lines.append(f"- {sid}")
        lines.append("")

    # Unmatched FHIR structures
    unmatched = [m for m in match_results if m['v291_data'] is None]
    if unmatched:
        lines.append("## Unmatched FHIR Structures (No V291 Equivalent)")
        lines.append("")
        lines.append(f"{len(unmatched)} FHIR structures have no matching V291 extraction:")
        lines.append("")
        # Group by base ID
        unmatched_by_base = defaultdict(list)
        for m in unmatched:
            base, suffix = _split_structure_id(m['fhir_id'])
            unmatched_by_base[base].append(m['fhir_id'])
        for base_id in sorted(unmatched_by_base.keys()):
            ids = unmatched_by_base[base_id]
            if len(ids) <= 3:
                lines.append(f"- {base_id}: {', '.join(sorted(ids))}")
            else:
                lines.append(f"- {base_id}: {len(ids)} sub-variants")
        lines.append("")

    with open(path, 'w') as f:
        f.write('\n'.join(lines))


def generate_html_report(report, match_results):
    """Generate a navigable HTML report with sidebar."""
    html_path = os.path.join(REPORT_DIR, 'message-structure-comparison-report.html')
    s = report['summary']
    sb = report['structural_breakdown']
    cb = report['cosmetic_breakdown']

    # Group discrepancies by structure
    by_structure = defaultdict(list)
    for d in report['discrepancies']:
        by_structure[d['structure_id']].append(d)

    # Separate structures with structural vs cosmetic-only issues
    structural_structures = []
    cosmetic_only_structures = []
    for sid in sorted(by_structure.keys()):
        discs = by_structure[sid]
        if any(d['category'] == STRUCTURAL for d in discs):
            structural_structures.append(sid)
        else:
            cosmetic_only_structures.append(sid)

    html = []
    html.append('<!DOCTYPE html>')
    html.append('<html lang="en"><head><meta charset="utf-8">')
    html.append('<title>Message Structure Comparison: FHIR vs V2.9.1</title>')
    html.append('<style>')
    html.append('''
body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 0; display: flex; }
#sidebar { width: 280px; min-width: 280px; height: 100vh; overflow-y: auto; background: #f6f8fa;
           border-right: 1px solid #d0d7de; padding: 12px; position: sticky; top: 0; font-size: 13px; }
#content { flex: 1; padding: 24px 32px; max-width: 1100px; }
h1 { font-size: 24px; border-bottom: 1px solid #d0d7de; padding-bottom: 8px; }
h2 { font-size: 20px; margin-top: 32px; border-bottom: 1px solid #d0d7de; padding-bottom: 6px; }
h3 { font-size: 16px; margin-top: 24px; }
table { border-collapse: collapse; width: 100%; margin: 8px 0; }
th, td { border: 1px solid #d0d7de; padding: 6px 10px; text-align: left; font-size: 14px; }
th { background: #f6f8fa; font-weight: 600; }
.badge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; margin-right: 4px; }
.badge-structural { background: #fdd; color: #b00; }
.badge-cosmetic { background: #e8f4e8; color: #070; }
.badge-missing { background: #ffe0b2; color: #e65100; }
.badge-extra { background: #e3f2fd; color: #1565c0; }
.sidebar-section { margin-bottom: 12px; }
.sidebar-section h3 { font-size: 13px; margin: 8px 0 4px 0; color: #57606a; text-transform: uppercase; letter-spacing: 0.5px; }
.sidebar-section a { display: block; padding: 2px 4px; color: #0969da; text-decoration: none; font-size: 13px; }
.sidebar-section a:hover { background: #ddf4ff; border-radius: 4px; }
.detail-item { margin: 6px 0; padding: 4px 0 4px 16px; border-left: 3px solid #d0d7de; }
.detail-item.structural { border-left-color: #cf222e; }
.detail-item.cosmetic { border-left-color: #2da44e; }
.provenance { font-size: 12px; color: #57606a; }
code { background: #f6f8fa; padding: 2px 6px; border-radius: 4px; font-size: 13px; }
.structure-section { margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #eee; }
.filter-input { width: 100%; padding: 4px 8px; border: 1px solid #d0d7de; border-radius: 4px; margin-bottom: 8px; font-size: 13px; }
    ''')
    html.append('</style></head><body>')

    # Sidebar
    html.append('<div id="sidebar">')
    html.append('<h2 style="margin-top:0; font-size: 16px;">Structure Index</h2>')
    html.append('<input class="filter-input" id="sidebar-filter" placeholder="Filter structures..." oninput="filterSidebar(this.value)">')

    html.append('<div class="sidebar-section"><h3>Structural Issues</h3>')
    for sid in structural_structures:
        discs = by_structure[sid]
        n_struct = sum(1 for d in discs if d['category'] == STRUCTURAL)
        html.append(f'<a href="#{sid}" class="sidebar-item">{sid} <span class="badge badge-structural">{n_struct}</span></a>')
    html.append('</div>')

    html.append('<div class="sidebar-section"><h3>Cosmetic Only</h3>')
    for sid in cosmetic_only_structures:
        n_cos = len(by_structure[sid])
        html.append(f'<a href="#{sid}" class="sidebar-item">{sid} <span class="badge badge-cosmetic">{n_cos}</span></a>')
    html.append('</div>')
    html.append('</div>')

    # Content
    html.append('<div id="content">')
    html.append('<h1>Message Structure Comparison: FHIR vs V2.9.1</h1>')
    html.append(f'<p class="provenance">Generated: {report["timestamp"]}</p>')

    # Summary table
    html.append('<h2>Summary</h2>')
    html.append('<table>')
    html.append(f'<tr><th>FHIR structures</th><td>{s["fhir_structures"]}</td></tr>')
    html.append(f'<tr><th>V291 unique structure IDs</th><td>{s["v291_unique_ids"]}</td></tr>')
    html.append(f'<tr><th>Matched pairs compared</th><td>{s["compared_pairs"]}</td></tr>')
    html.append(f'<tr><th>Unmatched FHIR (no V291)</th><td>{s["unmatched_fhir"]}</td></tr>')
    html.append(f'<tr><th>Truncated V291 (skipped)</th><td>{s["truncated_v291"]}</td></tr>')
    html.append(f'<tr><th>Total discrepancies</th><td><strong>{s["total_discrepancies"]}</strong></td></tr>')
    html.append(f'<tr><th>Structural</th><td><span class="badge badge-structural">{s["structural_discrepancies"]}</span></td></tr>')
    html.append(f'<tr><th>Cosmetic</th><td><span class="badge badge-cosmetic">{s["cosmetic_discrepancies"]}</span></td></tr>')
    html.append('</table>')

    # Structural breakdown
    html.append('<h2>Structural Breakdown</h2>')
    html.append('<table>')
    html.append(f'<tr><td>Segments in V291 but not FHIR</td><td><span class="badge badge-missing">{sb["missing_segments_v291_only"]}</span></td></tr>')
    html.append(f'<tr><td>Segments in FHIR but not V291</td><td><span class="badge badge-extra">{sb["extra_segments_fhir_only"]}</span></td></tr>')
    html.append(f'<tr><td>Optionality differences</td><td>{sb["optionality_differences"]}</td></tr>')
    html.append(f'<tr><td>Repetition differences</td><td>{sb["repetition_differences"]}</td></tr>')
    html.append(f'<tr><td>Group structure differences</td><td>{sb["group_structure_differences"]}</td></tr>')
    html.append(f'<tr><td>Description differences (meaningful)</td><td>{sb["description_differences"]}</td></tr>')
    html.append('</table>')

    # Per-structure detail
    html.append('<h2>Discrepancies by Structure</h2>')
    for sid in structural_structures + cosmetic_only_structures:
        discs = by_structure[sid]
        prov = discs[0].get('provenance', {})
        ch = prov.get('chapter', '?')
        section = prov.get('sectionHeading', '')

        n_struct = sum(1 for d in discs if d['category'] == STRUCTURAL)
        n_cos = sum(1 for d in discs if d['category'] == COSMETIC)

        html.append(f'<div class="structure-section" id="{sid}">')
        html.append(f'<h3>{sid}')
        if n_struct:
            html.append(f' <span class="badge badge-structural">{n_struct} structural</span>')
        if n_cos:
            html.append(f' <span class="badge badge-cosmetic">{n_cos} cosmetic</span>')
        html.append(f'</h3>')
        html.append(f'<p class="provenance">CH{ch}: {_html_escape(section)}</p>')

        for d in discs:
            cat_class = d['category']
            dim_label = {
                DIM_MISSING_SEGMENT: 'MISSING (V291-only)',
                DIM_EXTRA_SEGMENT: 'EXTRA (FHIR-only)',
                DIM_OPTIONALITY: 'OPTIONALITY',
                DIM_REPETITION: 'REPETITION',
                DIM_GROUP: 'GROUP',
                DIM_DESCRIPTION: 'DESCRIPTION',
            }.get(d['dimension'], d['dimension'])

            badge_class = f'badge-{d["category"]}'
            if d['dimension'] == DIM_MISSING_SEGMENT:
                badge_class = 'badge-missing'
            elif d['dimension'] == DIM_EXTRA_SEGMENT:
                badge_class = 'badge-extra'

            seg = d.get('segment_code', '?')
            html.append(f'<div class="detail-item {cat_class}">')
            html.append(f'<span class="badge {badge_class}">{dim_label}</span> <strong>{seg}</strong> (pos {d.get("position","?")})')
            html.append(f'<br>{_html_escape(d["detail"])}')
            if d.get('fhir_value') is not None:
                html.append(f'<br>FHIR: <code>{_html_escape(str(d["fhir_value"]))}</code>')
            if d.get('v291_value') is not None:
                html.append(f'<br>V291: <code>{_html_escape(str(d["v291_value"]))}</code>')
            html.append('</div>')

        html.append('</div>')

    # Truncated section
    if report.get('truncated_structures'):
        html.append('<h2>Truncated V291 Extractions (Skipped)</h2>')
        html.append('<p>These structures have V291 extractions with less than half the FHIR segment '
                     'count, indicating the Word doc table extraction was cut off.</p>')
        html.append('<ul>')
        for sid in report['truncated_structures']:
            html.append(f'<li>{sid}</li>')
        html.append('</ul>')

    # Unmatched section
    unmatched = [m for m in match_results if m['v291_data'] is None]
    if unmatched:
        html.append('<h2>Unmatched FHIR Structures</h2>')
        html.append(f'<p>{len(unmatched)} FHIR structures have no V291 equivalent.</p>')
        unmatched_by_base = defaultdict(list)
        for m in unmatched:
            base, suffix = _split_structure_id(m['fhir_id'])
            unmatched_by_base[base].append(m['fhir_id'])
        html.append('<table><tr><th>Base ID</th><th>Count</th><th>Variants</th></tr>')
        for base_id in sorted(unmatched_by_base.keys()):
            ids = sorted(unmatched_by_base[base_id])
            display = ', '.join(ids) if len(ids) <= 5 else f'{len(ids)} sub-variants'
            html.append(f'<tr><td>{base_id}</td><td>{len(ids)}</td><td>{display}</td></tr>')
        html.append('</table>')

    html.append('</div>')  # content

    # JS for sidebar filter
    html.append('<script>')
    html.append('''
function filterSidebar(query) {
    var q = query.toLowerCase();
    document.querySelectorAll('.sidebar-item').forEach(function(a) {
        a.style.display = a.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
    ''')
    html.append('</script>')
    html.append('</body></html>')

    with open(html_path, 'w') as f:
        f.write('\n'.join(html))
    print(f"HTML report: {html_path}")


def _html_escape(s):
    """Escape HTML special characters."""
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description='Compare FHIR vs V291 message structures')
    parser.add_argument('--subset', help='Comma-separated list of structure base IDs to compare')
    args = parser.parse_args()

    subset_filter = None
    if args.subset:
        subset_filter = set(args.subset.split(','))

    print("Loading FHIR message structures...")
    fhir_structs = load_fhir_structures()
    print(f"  {sum(len(v) for v in fhir_structs.values())} structures "
          f"({len(fhir_structs)} base IDs, "
          f"{sum(len(v) for v in fhir_structs.values()) - len(fhir_structs)} sub-variants)")

    print("Loading V291 message structures...")
    v291_structs = load_v291_structures()
    print(f"  {sum(len(v) for v in v291_structs.values())} occurrences "
          f"({len(v291_structs)} unique IDs)")

    if subset_filter:
        fhir_structs = {k: v for k, v in fhir_structs.items() if k in subset_filter}
        v291_structs = {k: v for k, v in v291_structs.items() if k in subset_filter}
        print(f"  Filtered to {len(fhir_structs)} FHIR / {len(v291_structs)} V291 structures")

    print("\nMatching structures...")
    match_results = match_structures(fhir_structs, v291_structs)
    matched = [m for m in match_results if m['v291_data'] is not None]
    unmatched = [m for m in match_results if m['v291_data'] is None]
    print(f"  {len(matched)} matched pairs, {len(unmatched)} unmatched FHIR")

    # Detect truncated V291 extractions (V291 has less than half the segments)
    truncated_ids = set()
    for m in matched:
        fhir_segs = extract_fhir_segments(m['fhir_data'])
        v291_segs = extract_v291_segments(m['v291_data'])
        if len(v291_segs) > 0 and len(fhir_segs) > len(v291_segs) * 2:
            truncated_ids.add(m['fhir_id'])
    if truncated_ids:
        print(f"  {len(truncated_ids)} structures have truncated V291 extraction "
              f"(flagged, not compared): {', '.join(sorted(truncated_ids))}")

    print("\nComparing matched pairs...")
    all_discrepancies = []
    for m in matched:
        if m['fhir_id'] in truncated_ids:
            continue  # Skip truncated — would produce false FHIR-only segments
        fhir_segs = extract_fhir_segments(m['fhir_data'])
        v291_segs = extract_v291_segments(m['v291_data'])
        prov = m.get('v291_provenance', {})
        discs = compare_pair(fhir_segs, v291_segs, m['fhir_id'], prov)
        all_discrepancies.extend(discs)

    n_structural = sum(1 for d in all_discrepancies if d['category'] == STRUCTURAL)
    n_cosmetic = sum(1 for d in all_discrepancies if d['category'] == COSMETIC)
    print(f"  {len(all_discrepancies)} discrepancies ({n_structural} structural, {n_cosmetic} cosmetic)")

    print("\nGenerating reports...")
    report = generate_reports(all_discrepancies, match_results, fhir_structs, v291_structs,
                              truncated_ids)
    generate_html_report(report, match_results)

    # Print top-level summary
    compared = len(matched) - len(truncated_ids)
    print(f"\n{'='*60}")
    print(f"Message Structure Comparison Complete")
    print(f"{'='*60}")
    print(f"Compared:   {compared} pairs")
    print(f"Truncated:  {len(truncated_ids)} (V291 extraction incomplete)")
    print(f"Unmatched:  {len(unmatched)} FHIR structures (no V291)")
    print(f"Structural: {n_structural} differences (need review)")
    print(f"Cosmetic:   {n_cosmetic} differences (auto-resolvable)")
    print(f"{'='*60}")


if __name__ == '__main__':
    main()
