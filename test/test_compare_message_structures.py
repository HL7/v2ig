#!/usr/bin/env python3
"""Tests for compare_message_structures.py — message structure comparison."""

import json
import os
import sys
import unittest

# Add tooling/scripts to path for imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'tooling', 'scripts'))

from compare_message_structures import (
    _parse_bracket_notation,
    _is_group_begin,
    _is_group_end,
    _extract_group_name,
    _is_bracket_notation,
    _extract_group_path,
    _compare_descriptions,
    _normalize_desc,
    _asciify,
    _classify_group_diff,
    _split_structure_id,
    _match_score,
    extract_fhir_segments,
    extract_v291_segments,
    align_segment_lists,
    compare_pair,
    COSMETIC,
    STRUCTURAL,
    DIM_MISSING_SEGMENT,
    DIM_EXTRA_SEGMENT,
    DIM_OPTIONALITY,
    DIM_REPETITION,
    DIM_DESCRIPTION,
    DIM_GROUP,
)


# ---------------------------------------------------------------------------
# Bracket notation parsing
# ---------------------------------------------------------------------------

class TestParseBracketNotation(unittest.TestCase):
    def test_bare_code(self):
        code, req, rep = _parse_bracket_notation('MSH')
        self.assertEqual(code, 'MSH')
        self.assertTrue(req)
        self.assertFalse(rep)

    def test_optional_non_repeating(self):
        code, req, rep = _parse_bracket_notation('[ PD1 ]')
        self.assertEqual(code, 'PD1')
        self.assertFalse(req)
        self.assertFalse(rep)

    def test_optional_non_repeating_tight(self):
        code, req, rep = _parse_bracket_notation('[PD1]')
        self.assertEqual(code, 'PD1')
        self.assertFalse(req)
        self.assertFalse(rep)

    def test_optional_repeating(self):
        code, req, rep = _parse_bracket_notation('[{ ARV }]')
        self.assertEqual(code, 'ARV')
        self.assertFalse(req)
        self.assertTrue(rep)

    def test_optional_repeating_tight(self):
        code, req, rep = _parse_bracket_notation('[{SFT}]')
        self.assertEqual(code, 'SFT')
        self.assertFalse(req)
        self.assertTrue(rep)

    def test_optional_repeating_wide_spaces(self):
        code, req, rep = _parse_bracket_notation('[  { SFT }  ]')
        self.assertEqual(code, 'SFT')
        self.assertFalse(req)
        self.assertTrue(rep)

    def test_required_repeating(self):
        code, req, rep = _parse_bracket_notation('{ RF1 }')
        self.assertEqual(code, 'RF1')
        self.assertTrue(req)
        self.assertTrue(rep)

    def test_required_repeating_tight(self):
        code, req, rep = _parse_bracket_notation('{RF1}')
        self.assertEqual(code, 'RF1')
        self.assertTrue(req)
        self.assertTrue(rep)

    def test_pure_bracket_opener_returns_none(self):
        code, req, rep = _parse_bracket_notation('[{')
        self.assertIsNone(code)

    def test_pure_bracket_closer_returns_none(self):
        code, req, rep = _parse_bracket_notation('}]')
        self.assertIsNone(code)

    def test_extra_whitespace(self):
        code, req, rep = _parse_bracket_notation('[  UAC  ]')
        self.assertEqual(code, 'UAC')
        self.assertFalse(req)
        self.assertFalse(rep)

    def test_space_between_bracket_brace(self):
        """Handles [ { SEG } ] with spaces between brackets and braces."""
        code, req, rep = _parse_bracket_notation('[ { ERR } ]')
        self.assertEqual(code, 'ERR')
        self.assertFalse(req)
        self.assertTrue(rep)


# ---------------------------------------------------------------------------
# Group markers
# ---------------------------------------------------------------------------

class TestGroupMarkers(unittest.TestCase):
    def test_begin_bracket_brace(self):
        self.assertTrue(_is_group_begin('[{', '--- NEXT_OF_KIN begin'))

    def test_begin_bracket_only(self):
        self.assertTrue(_is_group_begin('[', '--- ORDER_DETAIL begin'))

    def test_begin_brace_only(self):
        self.assertTrue(_is_group_begin('{', '--- COMMAND begin'))

    def test_begin_description_pattern(self):
        self.assertTrue(_is_group_begin('foo', '--- INSURANCE begin'))

    def test_end_bracket_brace(self):
        self.assertTrue(_is_group_end('}]', '--- NEXT_OF_KIN end'))

    def test_end_bracket_only(self):
        self.assertTrue(_is_group_end(']', '--- ORDER_DETAIL end'))

    def test_end_brace_only(self):
        self.assertTrue(_is_group_end('}', '--- COMMAND end'))

    def test_not_begin(self):
        self.assertFalse(_is_group_begin('MSH', 'Message Header'))

    def test_not_end(self):
        self.assertFalse(_is_group_end('MSH', 'Message Header'))


class TestExtractGroupName(unittest.TestCase):
    def test_standard_pattern(self):
        self.assertEqual(_extract_group_name('--- NEXT_OF_KIN begin'), 'NEXT_OF_KIN')

    def test_no_space_after_dashes(self):
        self.assertEqual(_extract_group_name('---ORDER_FOR_SPECIMEN_CONTAINER begin'),
                         'ORDER_FOR_SPECIMEN_CONTAINER')

    def test_name_with_begin_suffix(self):
        self.assertEqual(_extract_group_name('PRODUCT_SERVICE_SECTION begin'),
                         'PRODUCT_SERVICE_SECTION')

    def test_case_insensitive(self):
        self.assertEqual(_extract_group_name('--- INSURANCE Begin'), 'INSURANCE')


# ---------------------------------------------------------------------------
# Bracket notation detection
# ---------------------------------------------------------------------------

class TestIsBracketNotation(unittest.TestCase):
    def test_bare_segment_code(self):
        self.assertTrue(_is_bracket_notation('MSH'))

    def test_bracket_wrapped(self):
        self.assertTrue(_is_bracket_notation('[{ SFT }]'))

    def test_description_text(self):
        self.assertFalse(_is_bracket_notation('Message Header'))

    def test_empty_string(self):
        self.assertFalse(_is_bracket_notation(''))

    def test_long_text(self):
        self.assertFalse(_is_bracket_notation('Patient Identification'))


# ---------------------------------------------------------------------------
# FHIR group path extraction
# ---------------------------------------------------------------------------

class TestExtractGroupPath(unittest.TestCase):
    def test_root_level(self):
        self.assertEqual(_extract_group_path('ADT_A01-A.1-MSH'), ())

    def test_one_level(self):
        self.assertEqual(
            _extract_group_path('ADT_A01-A.18-NEXT_OF_KIN.1-NK1'),
            ('NEXT_OF_KIN',))

    def test_two_levels(self):
        self.assertEqual(
            _extract_group_path('ADT_A01-A.34-INSURANCE.8-AUTHORIZATION.1-AUT'),
            ('INSURANCE', 'AUTHORIZATION'))

    def test_root_element(self):
        self.assertEqual(_extract_group_path('ADT_A01-A'), ())


# ---------------------------------------------------------------------------
# Description comparison
# ---------------------------------------------------------------------------

class TestCompareDescriptions(unittest.TestCase):
    def test_identical(self):
        self.assertIsNone(_compare_descriptions('Message Header', 'Message Header'))

    def test_case_difference(self):
        result = _compare_descriptions('Software Segment', 'Software segment')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], COSMETIC)

    def test_abbreviation(self):
        result = _compare_descriptions('Additional Info.', 'Additional Information')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], COSMETIC)

    def test_en_dash_vs_hyphen(self):
        result = _compare_descriptions('Patient Visit \u2013 Additional Info',
                                        'Patient Visit - Additional Info')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], COSMETIC)

    def test_typo_high_similarity(self):
        result = _compare_descriptions('Patient Advers Reaction',
                                        'Patient Adverse Reaction')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], COSMETIC)

    def test_genuinely_different(self):
        result = _compare_descriptions('Message Acknowledgment', 'Message Header')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], STRUCTURAL)

    def test_none_handling(self):
        result = _compare_descriptions(None, 'Some text')
        self.assertIsNotNone(result)

    def test_both_none(self):
        self.assertIsNone(_compare_descriptions(None, None))

    def test_acknowledgment_spelling(self):
        result = _compare_descriptions('Message Acknowledgement', 'Message Acknowledgment')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], COSMETIC)

    def test_qualifier_difference(self):
        result = _compare_descriptions('Participation (for common order)',
                                        'Participation (for Observation)')
        self.assertIsNotNone(result)
        self.assertEqual(result['category'], STRUCTURAL)


# ---------------------------------------------------------------------------
# Normalize description
# ---------------------------------------------------------------------------

class TestNormalizeDesc(unittest.TestCase):
    def test_lowercase_strip(self):
        self.assertEqual(_normalize_desc('  Message Header  '), 'message header')

    def test_trailing_punctuation(self):
        self.assertEqual(_normalize_desc('Information.'), 'information')

    def test_abbreviation_expansion(self):
        self.assertIn('information', _normalize_desc('Info.'))

    def test_en_dash_normalized(self):
        result = _normalize_desc('Visit \u2013 Info')
        self.assertNotIn('\u2013', result)


# ---------------------------------------------------------------------------
# Asciify
# ---------------------------------------------------------------------------

class TestAsciify(unittest.TestCase):
    def test_en_dash(self):
        self.assertEqual(_asciify('a\u2013b'), 'a-b')

    def test_em_dash(self):
        self.assertEqual(_asciify('a\u2014b'), 'a-b')

    def test_smart_quotes(self):
        self.assertEqual(_asciify('\u201chello\u201d'), '"hello"')

    def test_plain_ascii(self):
        self.assertEqual(_asciify('hello world'), 'hello world')


# ---------------------------------------------------------------------------
# Group diff classification
# ---------------------------------------------------------------------------

class TestClassifyGroupDiff(unittest.TestCase):
    def test_case_diff_is_cosmetic(self):
        self.assertEqual(_classify_group_diff(('Procedure',), ('PROCEDURE',)), COSMETIC)

    def test_depth_diff_is_structural(self):
        self.assertEqual(
            _classify_group_diff(('A', 'B'), ('A',)),
            STRUCTURAL)

    def test_same_normalized_name(self):
        self.assertEqual(
            _classify_group_diff(('NEXT_OF_KIN',), ('NEXT-OF-KIN',)),
            COSMETIC)

    def test_different_names(self):
        self.assertEqual(
            _classify_group_diff(('INSURANCE',), ('PATIENT',)),
            STRUCTURAL)

    def test_empty_paths(self):
        self.assertEqual(_classify_group_diff((), ()), COSMETIC)


# ---------------------------------------------------------------------------
# Structure ID splitting
# ---------------------------------------------------------------------------

class TestSplitStructureId(unittest.TestCase):
    def test_no_suffix(self):
        self.assertEqual(_split_structure_id('ADT_A02'), ('ADT_A02', None))

    def test_single_letter_suffix(self):
        self.assertEqual(_split_structure_id('ADT_A01-A'), ('ADT_A01', 'A'))

    def test_double_letter_suffix(self):
        self.assertEqual(_split_structure_id('ACK-BZ'), ('ACK', 'BZ'))

    def test_no_suffix_with_underscore(self):
        self.assertEqual(_split_structure_id('ORU_R01'), ('ORU_R01', None))

    def test_suffix_A(self):
        self.assertEqual(_split_structure_id('ORU_R01-A'), ('ORU_R01', 'A'))


# ---------------------------------------------------------------------------
# FHIR segment extraction
# ---------------------------------------------------------------------------

class TestExtractFhirSegments(unittest.TestCase):
    def _make_fhir_data(self, elements):
        return {'differential': {'element': elements}}

    def test_simple_structure(self):
        fhir = self._make_fhir_data([
            {'id': 'X', 'path': 'X', 'type': [], 'min': 0, 'max': '*'},
            {'id': 'X.1-MSH', 'path': 'X.1-MSH', 'short': 'Message Header',
             'type': [{'code': 'http://hl7.org/v2/StructureDefinition/MSH'}],
             'min': 1, 'max': '1'},
            {'id': 'X.2-PID', 'path': 'X.2-PID', 'short': 'Patient ID',
             'type': [{'code': 'http://hl7.org/v2/StructureDefinition/PID'}],
             'min': 1, 'max': '1'},
        ])
        segs = extract_fhir_segments(fhir)
        self.assertEqual(len(segs), 2)
        self.assertEqual(segs[0]['code'], 'MSH')
        self.assertTrue(segs[0]['required'])
        self.assertFalse(segs[0]['repeating'])
        self.assertEqual(segs[0]['group_path'], ())

    def test_backbone_element_skipped(self):
        fhir = self._make_fhir_data([
            {'id': 'X', 'path': 'X', 'type': [], 'min': 0, 'max': '*'},
            {'id': 'X.1-MSH', 'path': 'X.1-MSH', 'short': 'Header',
             'type': [{'code': 'http://hl7.org/v2/StructureDefinition/MSH'}],
             'min': 1, 'max': '1'},
            {'id': 'X.2-GROUP', 'path': 'X.2-GROUP', 'short': 'GROUP',
             'type': [{'code': 'BackboneElement'}],
             'min': 0, 'max': '*'},
            {'id': 'X.2-GROUP.1-NK1', 'path': 'X.2-GROUP.1-NK1', 'short': 'Next of Kin',
             'type': [{'code': 'http://hl7.org/v2/StructureDefinition/NK1'}],
             'min': 1, 'max': '1'},
        ])
        segs = extract_fhir_segments(fhir)
        self.assertEqual(len(segs), 2)
        self.assertEqual(segs[1]['code'], 'NK1')
        self.assertEqual(segs[1]['group_path'], ('GROUP',))

    def test_optional_repeating(self):
        fhir = self._make_fhir_data([
            {'id': 'X', 'path': 'X', 'type': [], 'min': 0, 'max': '*'},
            {'id': 'X.1-SFT', 'path': 'X.1-SFT', 'short': 'Software',
             'type': [{'code': 'http://hl7.org/v2/StructureDefinition/SFT'}],
             'min': 0, 'max': '*'},
        ])
        segs = extract_fhir_segments(fhir)
        self.assertFalse(segs[0]['required'])
        self.assertTrue(segs[0]['repeating'])


# ---------------------------------------------------------------------------
# V291 segment extraction
# ---------------------------------------------------------------------------

class TestExtractV291Segments(unittest.TestCase):
    def _make_v291_data(self, raw_rows):
        return {'rawRows': raw_rows}

    def test_simple_structure(self):
        v291 = self._make_v291_data([
            {'segments': 'MSH', 'description': 'Message Header'},
            {'segments': '[{ SFT }]', 'description': 'Software Segment'},
            {'segments': 'PID', 'description': 'Patient ID'},
        ])
        segs = extract_v291_segments(v291)
        self.assertEqual(len(segs), 3)
        self.assertEqual(segs[0]['code'], 'MSH')
        self.assertTrue(segs[0]['required'])
        self.assertFalse(segs[0]['repeating'])
        self.assertEqual(segs[1]['code'], 'SFT')
        self.assertFalse(segs[1]['required'])
        self.assertTrue(segs[1]['repeating'])

    def test_group_nesting(self):
        v291 = self._make_v291_data([
            {'segments': 'MSH', 'description': 'Header'},
            {'segments': '[{', 'description': '--- INSURANCE begin'},
            {'segments': 'IN1', 'description': 'Insurance'},
            {'segments': '}]', 'description': '--- INSURANCE end'},
        ])
        segs = extract_v291_segments(v291)
        self.assertEqual(len(segs), 2)
        self.assertEqual(segs[1]['code'], 'IN1')
        self.assertEqual(segs[1]['group_path'], ('INSURANCE',))

    def test_nested_groups(self):
        v291 = self._make_v291_data([
            {'segments': '[{', 'description': '--- OUTER begin'},
            {'segments': '[{', 'description': '--- INNER begin'},
            {'segments': 'OBX', 'description': 'Observation'},
            {'segments': '}]', 'description': '--- INNER end'},
            {'segments': '}]', 'description': '--- OUTER end'},
        ])
        segs = extract_v291_segments(v291)
        self.assertEqual(len(segs), 1)
        self.assertEqual(segs[0]['group_path'], ('OUTER', 'INNER'))

    def test_ch13_column_mapping_fallback(self):
        """V291 descriptions that are bracket notation use status field fallback."""
        v291 = self._make_v291_data([
            {'segments': 'MSH', 'description': 'MSH', 'status': 'Message Header'},
            {'segments': '[{SFT}]', 'description': '[{SFT}]', 'status': 'Software Segment'},
        ])
        segs = extract_v291_segments(v291)
        self.assertEqual(segs[0]['description'], 'Message Header')
        self.assertEqual(segs[1]['description'], 'Software Segment')


# ---------------------------------------------------------------------------
# Segment alignment
# ---------------------------------------------------------------------------

class TestAlignSegmentLists(unittest.TestCase):
    def _seg(self, code, **kwargs):
        return {'code': code, 'required': True, 'repeating': False,
                'description': code, 'group_path': (), **kwargs}

    def test_identical_lists(self):
        a = [self._seg('MSH'), self._seg('PID'), self._seg('PV1')]
        b = [self._seg('MSH'), self._seg('PID'), self._seg('PV1')]
        alignment = align_segment_lists(a, b)
        matched = [(fi, vi) for fi, vi in alignment if fi is not None and vi is not None]
        self.assertEqual(len(matched), 3)

    def test_extra_in_fhir(self):
        a = [self._seg('MSH'), self._seg('PRT'), self._seg('PID')]
        b = [self._seg('MSH'), self._seg('PID')]
        alignment = align_segment_lists(a, b)
        fhir_only = [(fi, vi) for fi, vi in alignment if fi is not None and vi is None]
        self.assertEqual(len(fhir_only), 1)

    def test_extra_in_v291(self):
        a = [self._seg('MSH'), self._seg('PID')]
        b = [self._seg('MSH'), self._seg('NTE'), self._seg('PID')]
        alignment = align_segment_lists(a, b)
        v291_only = [(fi, vi) for fi, vi in alignment if fi is None and vi is not None]
        self.assertEqual(len(v291_only), 1)

    def test_empty_lists(self):
        alignment = align_segment_lists([], [])
        self.assertEqual(len(alignment), 0)


# ---------------------------------------------------------------------------
# Compare pair
# ---------------------------------------------------------------------------

class TestComparePair(unittest.TestCase):
    def _fhir_seg(self, code, req=True, rep=False, desc=None, group=()):
        return {'code': code, 'required': req, 'repeating': rep,
                'description': desc or code, 'group_path': group,
                'element_id': f'X.1-{code}'}

    def _v291_seg(self, code, req=True, rep=False, desc=None, group=()):
        return {'code': code, 'required': req, 'repeating': rep,
                'description': desc or code, 'group_path': group,
                'raw_notation': code}

    def test_no_differences(self):
        fhir = [self._fhir_seg('MSH'), self._fhir_seg('PID')]
        v291 = [self._v291_seg('MSH'), self._v291_seg('PID')]
        discs = compare_pair(fhir, v291, 'TEST', {})
        self.assertEqual(len(discs), 0)

    def test_optionality_difference(self):
        fhir = [self._fhir_seg('NK1', req=False)]
        v291 = [self._v291_seg('NK1', req=True)]
        discs = compare_pair(fhir, v291, 'TEST', {})
        opt_discs = [d for d in discs if d['dimension'] == DIM_OPTIONALITY]
        self.assertEqual(len(opt_discs), 1)
        self.assertEqual(opt_discs[0]['category'], STRUCTURAL)

    def test_repetition_difference(self):
        fhir = [self._fhir_seg('ERR', rep=False)]
        v291 = [self._v291_seg('ERR', rep=True)]
        discs = compare_pair(fhir, v291, 'TEST', {})
        rep_discs = [d for d in discs if d['dimension'] == DIM_REPETITION]
        self.assertEqual(len(rep_discs), 1)

    def test_extra_fhir_segment(self):
        fhir = [self._fhir_seg('MSH'), self._fhir_seg('PRT')]
        v291 = [self._v291_seg('MSH')]
        discs = compare_pair(fhir, v291, 'TEST', {})
        extras = [d for d in discs if d['dimension'] == DIM_EXTRA_SEGMENT]
        self.assertEqual(len(extras), 1)
        self.assertEqual(extras[0]['segment_code'], 'PRT')

    def test_missing_v291_segment(self):
        fhir = [self._fhir_seg('MSH')]
        v291 = [self._v291_seg('MSH'), self._v291_seg('NTE')]
        discs = compare_pair(fhir, v291, 'TEST', {})
        missing = [d for d in discs if d['dimension'] == DIM_MISSING_SEGMENT]
        self.assertEqual(len(missing), 1)
        self.assertEqual(missing[0]['segment_code'], 'NTE')

    def test_description_cosmetic(self):
        fhir = [self._fhir_seg('SFT', desc='Software Segment')]
        v291 = [self._v291_seg('SFT', desc='Software segment')]
        discs = compare_pair(fhir, v291, 'TEST', {})
        desc_discs = [d for d in discs if d['dimension'] == DIM_DESCRIPTION]
        self.assertEqual(len(desc_discs), 1)
        self.assertEqual(desc_discs[0]['category'], COSMETIC)

    def test_group_path_cosmetic(self):
        fhir = [self._fhir_seg('PR1', group=('Procedure',))]
        v291 = [self._v291_seg('PR1', group=('PROCEDURE',))]
        discs = compare_pair(fhir, v291, 'TEST', {})
        group_discs = [d for d in discs if d['dimension'] == DIM_GROUP]
        self.assertEqual(len(group_discs), 1)
        self.assertEqual(group_discs[0]['category'], COSMETIC)

    def test_group_path_structural(self):
        fhir = [self._fhir_seg('IN1', group=('INSURANCE',))]
        v291 = [self._v291_seg('IN1', group=())]
        discs = compare_pair(fhir, v291, 'TEST', {})
        group_discs = [d for d in discs if d['dimension'] == DIM_GROUP]
        self.assertEqual(len(group_discs), 1)
        self.assertEqual(group_discs[0]['category'], STRUCTURAL)


# ---------------------------------------------------------------------------
# Match score
# ---------------------------------------------------------------------------

class TestMatchScore(unittest.TestCase):
    def _seg(self, code):
        return {'code': code}

    def test_identical(self):
        a = [self._seg('MSH'), self._seg('PID')]
        b = [self._seg('MSH'), self._seg('PID')]
        self.assertEqual(_match_score(a, b), 1.0)

    def test_completely_different(self):
        a = [self._seg('MSH'), self._seg('PID')]
        b = [self._seg('OBX'), self._seg('NTE')]
        self.assertEqual(_match_score(a, b), 0.0)

    def test_partial_match(self):
        a = [self._seg('MSH'), self._seg('PID'), self._seg('PV1')]
        b = [self._seg('MSH'), self._seg('PV1')]
        score = _match_score(a, b)
        self.assertGreater(score, 0.0)
        self.assertLess(score, 1.0)


if __name__ == '__main__':
    unittest.main()
