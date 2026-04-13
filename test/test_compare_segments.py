#!/usr/bin/env python3
"""Tests for compare_segments.py — segment field fidelity audit."""

import json
import os
import sys
import unittest
from pathlib import Path

# Add tooling/scripts to path for imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'tooling', 'scripts'))

from compare_segments import (
    parse_v291_repetition,
    parse_v291_length,
    parse_v291_conf_length,
    extract_v291_table_number,
    extract_fhir_fields,
    extract_v291_fields,
    compare_cardinality,
    compare_data_type,
    compare_optionality,
    compare_item_number,
    compare_field_name,
    compare_length,
    compare_conf_length,
    compare_vocabulary,
    compare_segment,
)

FIXTURES_DIR = os.path.join(os.path.dirname(__file__), 'fixtures', 'segments')


def load_fixture(name):
    with open(os.path.join(FIXTURES_DIR, name), encoding='utf-8') as f:
        return json.load(f)


# ---------------------------------------------------------------------------
# V291 parsing helpers
# ---------------------------------------------------------------------------

class TestParseV291Repetition(unittest.TestCase):
    def test_empty_string(self):
        self.assertEqual(parse_v291_repetition(''), '1')

    def test_n(self):
        self.assertEqual(parse_v291_repetition('N'), '1')

    def test_n_lowercase(self):
        self.assertEqual(parse_v291_repetition('n'), '1')

    def test_y(self):
        self.assertEqual(parse_v291_repetition('Y'), '*')

    def test_y_lowercase(self):
        self.assertEqual(parse_v291_repetition('y'), '*')

    def test_bare_number(self):
        self.assertEqual(parse_v291_repetition('2'), '2')
        self.assertEqual(parse_v291_repetition('5'), '5')

    def test_slash_pattern(self):
        self.assertEqual(parse_v291_repetition('Y/5'), '5')

    def test_slash_no_digit(self):
        self.assertEqual(parse_v291_repetition('Y/N'), '*')


class TestParseV291Length(unittest.TestCase):
    def test_empty(self):
        self.assertEqual(parse_v291_length(''), (None, None))

    def test_range(self):
        self.assertEqual(parse_v291_length('1..4'), (1, 4))
        self.assertEqual(parse_v291_length('1..199'), (1, 199))

    def test_single(self):
        self.assertEqual(parse_v291_length('4'), (4, 4))

    def test_equal_range(self):
        self.assertEqual(parse_v291_length('1..1'), (1, 1))


class TestParseV291ConfLength(unittest.TestCase):
    def test_empty(self):
        self.assertEqual(parse_v291_conf_length(''), (None, None))

    def test_equals(self):
        self.assertEqual(parse_v291_conf_length('20='), (20, 1))

    def test_hash(self):
        self.assertEqual(parse_v291_conf_length('5#'), (5, 0))

    def test_bare_equals(self):
        self.assertEqual(parse_v291_conf_length('='), (None, 1))

    def test_bare_hash(self):
        self.assertEqual(parse_v291_conf_length('#'), (None, 0))

    def test_bare_number(self):
        self.assertEqual(parse_v291_conf_length('10'), (10, None))


class TestExtractV291TableNumber(unittest.TestCase):
    def test_normal(self):
        self.assertEqual(extract_v291_table_number('0125'), '0125')

    def test_empty(self):
        self.assertEqual(extract_v291_table_number(''), '')

    def test_none(self):
        self.assertEqual(extract_v291_table_number(None), '')


# ---------------------------------------------------------------------------
# FHIR extraction
# ---------------------------------------------------------------------------

class TestExtractFhirFields(unittest.TestCase):
    def setUp(self):
        self.fhir_data = load_fixture('MSH.json')
        self.fields = extract_fhir_fields(self.fhir_data)

    def test_returns_dict_keyed_by_seq(self):
        self.assertIsInstance(self.fields, dict)
        self.assertIn('1', self.fields)

    def test_field_has_required_keys(self):
        f = self.fields['1']
        required = ['seq', 'name', 'data_type', 'optionality', 'min_card',
                    'max_card', 'item_num', 'vocabulary_table', 'element_id']
        for key in required:
            self.assertIn(key, f, f"Missing key: {key}")

    def test_max_card_is_string(self):
        """max should always be converted to string."""
        for seq, f in self.fields.items():
            self.assertIsInstance(f['max_card'], str,
                               f"Field {seq}: max_card should be string, got {type(f['max_card'])}")


class TestExtractV291Fields(unittest.TestCase):
    def setUp(self):
        self.v291_data = load_fixture('OBX-v291.json')
        self.fields, self.occ_count, self.provenance = extract_v291_fields(self.v291_data)

    def test_returns_dict(self):
        self.assertIsInstance(self.fields, dict)

    def test_field_count(self):
        self.assertEqual(len(self.fields), 6)

    def test_occurrence_count(self):
        self.assertEqual(self.occ_count, 1)

    def test_field_keys(self):
        f = self.fields['1']
        self.assertEqual(f['name'], 'Set ID \u2013 OBX')
        self.assertEqual(f['data_type'], 'SI')
        self.assertEqual(f['optionality'], 'O')
        self.assertEqual(f['repetition'], '')

    def test_repeating_field(self):
        f = self.fields['5']
        self.assertEqual(f['repetition'], 'Y')
        self.assertEqual(f['data_type'], 'varies')

    def test_provenance(self):
        self.assertEqual(self.provenance['sourceFile'], 'CH07_Observations.docx')
        self.assertEqual(self.provenance['chapter'], '07')


# ---------------------------------------------------------------------------
# Cardinality comparison
# ---------------------------------------------------------------------------

class TestCompareCardinality(unittest.TestCase):
    def _make_fhir(self, min_card=0, max_card='1', name='Test Field'):
        return {'min_card': min_card, 'max_card': max_card, 'name': name}

    def _make_v291(self, optionality='O', repetition='', data_type='ST'):
        return {'optionality': optionality, 'repetition': repetition,
                'data_type': data_type}

    def test_normal_match(self):
        """Optional, non-repeating field: min=0, max=1."""
        result = compare_cardinality(
            self._make_fhir(0, '1'), self._make_v291('O', ''), 'TST', '1')
        self.assertEqual(result, [])

    def test_required_match(self):
        """Required field: min=1, max=1."""
        result = compare_cardinality(
            self._make_fhir(1, '1'), self._make_v291('R', ''), 'TST', '1')
        self.assertEqual(result, [])

    def test_repeating_match(self):
        """Optional repeating: min=0, max=*."""
        result = compare_cardinality(
            self._make_fhir(0, '*'), self._make_v291('O', 'Y'), 'TST', '1')
        self.assertEqual(result, [])

    def test_critical_max_0_should_repeat(self):
        """The critical bug: max=0 but should be repeatable."""
        result = compare_cardinality(
            self._make_fhir(0, '0'), self._make_v291('C', 'Y'), 'OBX', '5')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'critical')
        self.assertEqual(result[0]['expected'], '*')
        self.assertEqual(result[0]['actual'], '0')

    def test_withdrawn_max_0_correct(self):
        """Withdrawn field: max=0 is correct per ADR-0005."""
        result = compare_cardinality(
            self._make_fhir(0, '0'),
            self._make_v291('W', '', data_type=''), 'PID', '12')
        self.assertEqual(result, [])

    def test_withdrawn_repeating_max_0_correct(self):
        """Withdrawn repeating field: max=0 is correct (W overrides rep)."""
        result = compare_cardinality(
            self._make_fhir(0, '0'),
            self._make_v291('W', 'Y', data_type='XTN'), 'PID', '13')
        self.assertEqual(result, [])

    def test_backward_compat_non_repeating(self):
        """B non-repeating: max=1 preserves original cardinality."""
        result = compare_cardinality(
            self._make_fhir(0, '1'),
            self._make_v291('B', '', data_type=''), 'PID', '15')
        self.assertEqual(result, [])

    def test_backward_compat_repeating(self):
        """B repeating: max=* preserves original cardinality."""
        result = compare_cardinality(
            self._make_fhir(0, '*'),
            self._make_v291('B', 'Y', data_type='XCN'), 'OBX', '16')
        self.assertEqual(result, [])

    def test_backward_compat_max_0_is_critical(self):
        """B repeating with max=0 is critical (B fields preserve cardinality)."""
        result = compare_cardinality(
            self._make_fhir(0, '0'),
            self._make_v291('B', 'Y', data_type='XCN'), 'OBX', '16')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'critical')

    def test_min_mismatch(self):
        """Required in V291 but optional in FHIR."""
        result = compare_cardinality(
            self._make_fhir(0, '1'), self._make_v291('R', ''), 'TST', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'critical')
        self.assertEqual(result[0]['dimension'], 'cardinality_min')

    def test_specific_repeat_count(self):
        """Field repeats exactly N times."""
        result = compare_cardinality(
            self._make_fhir(0, '2'), self._make_v291('O', '2'), 'TST', '1')
        self.assertEqual(result, [])

    def test_max_1_should_be_star(self):
        """max=1 but V291 says repeating."""
        result = compare_cardinality(
            self._make_fhir(0, '1'), self._make_v291('O', 'Y'), 'TST', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'error')
        self.assertEqual(result[0]['dimension'], 'cardinality_max')


# ---------------------------------------------------------------------------
# Data type comparison
# ---------------------------------------------------------------------------

class TestCompareDataType(unittest.TestCase):
    def _make_fhir(self, dt):
        return {'data_type': dt, 'name': 'Test'}

    def _make_v291(self, dt):
        return {'data_type': dt}

    def test_exact_match(self):
        self.assertEqual(compare_data_type(
            self._make_fhir('CWE'), self._make_v291('CWE'), 'TST', '1'), [])

    def test_case_insensitive_match(self):
        """'varies' vs 'Varies' should match."""
        self.assertEqual(compare_data_type(
            self._make_fhir('Varies'), self._make_v291('varies'), 'TST', '5'), [])

    def test_mismatch(self):
        result = compare_data_type(
            self._make_fhir('ST'), self._make_v291('TX'), 'TST', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'warning')

    def test_both_empty(self):
        self.assertEqual(compare_data_type(
            self._make_fhir(''), self._make_v291(''), 'TST', '1'), [])

    def test_one_empty(self):
        result = compare_data_type(
            self._make_fhir(''), self._make_v291('ST'), 'TST', '1')
        self.assertEqual(len(result), 1)


# ---------------------------------------------------------------------------
# Optionality comparison
# ---------------------------------------------------------------------------

class TestCompareOptionality(unittest.TestCase):
    def test_match(self):
        self.assertEqual(compare_optionality(
            {'optionality': 'O', 'name': 'T'}, {'optionality': 'O'}, 'T', '1'), [])

    def test_mismatch(self):
        result = compare_optionality(
            {'optionality': 'O', 'name': 'T'}, {'optionality': 'R'}, 'T', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'warning')


# ---------------------------------------------------------------------------
# Item number comparison
# ---------------------------------------------------------------------------

class TestCompareItemNumber(unittest.TestCase):
    def test_match_with_padding(self):
        """FHIR int 569 should match V291 '00569'."""
        self.assertEqual(compare_item_number(
            {'item_num': 569, 'name': 'T'}, {'item_number': '00569'}, 'T', '1'), [])

    def test_mismatch(self):
        result = compare_item_number(
            {'item_num': 569, 'name': 'T'}, {'item_number': '00570'}, 'T', '1')
        self.assertEqual(len(result), 1)

    def test_both_empty(self):
        self.assertEqual(compare_item_number(
            {'item_num': '', 'name': 'T'}, {'item_number': ''}, 'T', '1'), [])


# ---------------------------------------------------------------------------
# Field name comparison
# ---------------------------------------------------------------------------

class TestCompareFieldName(unittest.TestCase):
    def test_exact_match(self):
        self.assertEqual(compare_field_name(
            {'name': 'Set ID'}, {'name': 'Set ID'}, 'T', '1'), [])

    def test_en_dash_match(self):
        """En-dash vs hyphen should match after normalization."""
        self.assertEqual(compare_field_name(
            {'name': 'Set ID \u2013 OBX'}, {'name': 'Set ID - OBX'}, 'T', '1'), [])

    def test_case_difference(self):
        """Case difference counts as cosmetic match."""
        self.assertEqual(compare_field_name(
            {'name': 'set id'}, {'name': 'Set ID'}, 'T', '1'), [])

    def test_real_mismatch(self):
        result = compare_field_name(
            {'name': 'Patient Name'}, {'name': 'Client Name'}, 'T', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'cosmetic')


# ---------------------------------------------------------------------------
# Length comparison
# ---------------------------------------------------------------------------

class TestCompareLength(unittest.TestCase):
    def test_match(self):
        self.assertEqual(compare_length(
            {'length_min': 1, 'length_max': 4, 'name': 'T'},
            {'length': '1..4'}, 'T', '1'), [])

    def test_both_absent(self):
        self.assertEqual(compare_length(
            {'length_min': None, 'length_max': None, 'name': 'T'},
            {'length': ''}, 'T', '1'), [])

    def test_mismatch(self):
        result = compare_length(
            {'length_min': 1, 'length_max': 10, 'name': 'T'},
            {'length': '1..4'}, 'T', '1')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['severity'], 'error')


# ---------------------------------------------------------------------------
# Conformance length comparison
# ---------------------------------------------------------------------------

class TestCompareConfLength(unittest.TestCase):
    def test_match(self):
        self.assertEqual(compare_conf_length(
            {'conf_length': 20, 'no_truncate': 1, 'name': 'T'},
            {'conf_length': '20='}, 'T', '1'), [])

    def test_both_absent(self):
        self.assertEqual(compare_conf_length(
            {'conf_length': None, 'no_truncate': None, 'name': 'T'},
            {'conf_length': ''}, 'T', '1'), [])

    def test_mismatch(self):
        result = compare_conf_length(
            {'conf_length': 20, 'no_truncate': 0, 'name': 'T'},
            {'conf_length': '20='}, 'T', '1')
        self.assertEqual(len(result), 1)


# ---------------------------------------------------------------------------
# Vocabulary comparison
# ---------------------------------------------------------------------------

class TestCompareVocabulary(unittest.TestCase):
    def test_match(self):
        self.assertEqual(compare_vocabulary(
            {'vocabulary_table': '0125', 'name': 'T'},
            {'table_binding': '0125'}, 'T', '1'), [])

    def test_match_leading_zeros(self):
        """'125' vs '0125' should match after normalization."""
        self.assertEqual(compare_vocabulary(
            {'vocabulary_table': '125', 'name': 'T'},
            {'table_binding': '0125'}, 'T', '1'), [])

    def test_both_empty(self):
        self.assertEqual(compare_vocabulary(
            {'vocabulary_table': '', 'name': 'T'},
            {'table_binding': ''}, 'T', '1'), [])

    def test_mismatch(self):
        result = compare_vocabulary(
            {'vocabulary_table': '0125', 'name': 'T'},
            {'table_binding': '0078'}, 'T', '1')
        self.assertEqual(len(result), 1)


# ---------------------------------------------------------------------------
# Integration: compare_segment
# ---------------------------------------------------------------------------

class TestCompareSegment(unittest.TestCase):
    """Integration test using fixture files."""

    def test_obx_fixtures_detect_critical(self):
        """OBX fixture: field 5 has repetition=Y, FHIR has max=0 -> critical."""
        # Build a minimal FHIR OBX with a max=0 bug on field 5
        fhir_data = {
            'differential': {
                'element': [
                    {'id': 'OBX', 'path': 'OBX', 'short': 'OBX', 'min': 0, 'max': '*'},
                    {
                        'id': 'OBX.1-setId', 'path': 'OBX.1-setId',
                        'short': 'Set ID \u2013 OBX', 'min': 0, 'max': 1,
                        'type': [{'code': 'SI'}],
                        'code': [{'system': 'http://hl7.org/v2/CodeSystem/DataElements', 'code': 569}],
                        'extension': [
                            {'url': 'http://hl7.org/v2/StructureDefinition/optionality', 'valueCode': 'O'},
                            {'url': 'http://hl7.org/v2/StructureDefinition/length',
                             'extension': [{'url': 'min', 'valueInteger': 1}, {'url': 'max', 'valueInteger': 4}]}
                        ]
                    },
                    {
                        'id': 'OBX.5-observationValue', 'path': 'OBX.5-observationValue',
                        'short': 'Observation Value', 'min': 0, 'max': 0,
                        'type': [{'code': 'Varies'}],
                        'code': [{'system': 'http://hl7.org/v2/CodeSystem/DataElements', 'code': 573}],
                        'extension': [
                            {'url': 'http://hl7.org/v2/StructureDefinition/optionality', 'valueCode': 'C'}
                        ]
                    },
                ]
            }
        }
        v291_data = load_fixture('OBX-v291.json')

        result = compare_segment('OBX', fhir_data, v291_data)

        # Should detect critical cardinality issue on field 5
        critical = [d for d in result['discrepancies'] if d['severity'] == 'critical']
        self.assertTrue(len(critical) >= 1,
                       f"Expected critical discrepancy for OBX.5, got {len(critical)}")
        obx5_critical = [d for d in critical if d['seq'] == '5']
        self.assertEqual(len(obx5_critical), 1)
        self.assertEqual(obx5_critical[0]['dimension'], 'cardinality_max')
        self.assertEqual(obx5_critical[0]['expected'], '*')
        self.assertEqual(obx5_critical[0]['actual'], '0')

    def test_obx_fixtures_v291_only_fields(self):
        """Fields in V291 but not FHIR should be reported."""
        fhir_data = {
            'differential': {
                'element': [
                    {'id': 'OBX', 'path': 'OBX', 'short': 'OBX', 'min': 0, 'max': '*'},
                    {
                        'id': 'OBX.1-setId', 'path': 'OBX.1-setId',
                        'short': 'Set ID', 'min': 0, 'max': 1,
                        'type': [{'code': 'SI'}],
                        'code': [{'system': 'x', 'code': 569}],
                        'extension': [{'url': 'http://hl7.org/v2/StructureDefinition/optionality', 'valueCode': 'O'}]
                    },
                ]
            }
        }
        v291_data = load_fixture('OBX-v291.json')
        result = compare_segment('OBX', fhir_data, v291_data)

        v291_only = [d for d in result['discrepancies']
                    if d['dimension'] == 'field_count' and d['actual'] == 'absent']
        # Fields 2-6 should be reported as V291-only
        self.assertEqual(len(v291_only), 5)


if __name__ == '__main__':
    unittest.main()
