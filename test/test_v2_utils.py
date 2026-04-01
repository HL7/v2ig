#!/usr/bin/env python3
"""Tests for v2_utils.py — escape_xml, html5_to_xhtml, AnomalyLog."""

import os
import sys
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from v2_utils import escape_xml, html5_to_xhtml, AnomalyLog


class TestEscapeXml(unittest.TestCase):
    """Test escape_xml() text escaping for XHTML output."""

    def test_ampersand(self):
        self.assertEqual(escape_xml("AT&T"), "AT&amp;T")

    def test_angle_brackets(self):
        self.assertEqual(escape_xml("<b>bold</b>"), "&lt;b&gt;bold&lt;/b&gt;")

    def test_double_quote(self):
        self.assertEqual(escape_xml('say "hello"'), "say &quot;hello&quot;")

    def test_empty_string(self):
        self.assertEqual(escape_xml(""), "")

    def test_no_op_plain_text(self):
        self.assertEqual(escape_xml("plain text"), "plain text")

    def test_all_special_chars(self):
        self.assertEqual(
            escape_xml('&<>"'),
            "&amp;&lt;&gt;&quot;",
        )

    def test_order_matters_ampersand_first(self):
        """Ampersand must be escaped first to avoid double-escaping."""
        result = escape_xml("&lt;")
        self.assertEqual(result, "&amp;lt;")


class TestHtml5ToXhtml(unittest.TestCase):
    """Test html5_to_xhtml() conversion for IG Publisher compliance."""

    def test_self_close_br(self):
        self.assertEqual(html5_to_xhtml("<br>"), "<br/>")

    def test_self_close_br_with_attrs(self):
        self.assertEqual(html5_to_xhtml('<br class="x">'), '<br class="x"/>')

    def test_self_close_hr(self):
        self.assertEqual(html5_to_xhtml("<hr>"), "<hr/>")

    def test_self_close_img(self):
        self.assertEqual(
            html5_to_xhtml('<img src="a.png">'),
            '<img src="a.png"/>',
        )

    def test_bare_ampersand_escaping(self):
        self.assertEqual(html5_to_xhtml("A & B"), "A &amp; B")

    def test_entity_preservation(self):
        """Existing entities should NOT be double-escaped."""
        self.assertEqual(html5_to_xhtml("&amp;"), "&amp;")
        self.assertEqual(html5_to_xhtml("&lt;"), "&lt;")
        self.assertEqual(html5_to_xhtml("&gt;"), "&gt;")
        self.assertEqual(html5_to_xhtml("&quot;"), "&quot;")
        self.assertEqual(html5_to_xhtml("&#x5e;"), "&#x5e;")
        self.assertEqual(html5_to_xhtml("&#65;"), "&#65;")

    def test_heading_downshift_h1(self):
        self.assertIn("<h3", html5_to_xhtml("<h1>Title</h1>"))
        self.assertIn("</h3>", html5_to_xhtml("<h1>Title</h1>"))

    def test_heading_downshift_h2(self):
        self.assertIn("<h4", html5_to_xhtml("<h2>Sub</h2>"))
        self.assertIn("</h4>", html5_to_xhtml("<h2>Sub</h2>"))

    def test_heading_downshift_h3(self):
        self.assertIn("<h5", html5_to_xhtml("<h3>Sub</h3>"))
        self.assertIn("</h5>", html5_to_xhtml("<h3>Sub</h3>"))

    def test_heading_cap_at_h6(self):
        """h3 + 2 = h5, not h6, so h4 + 2 = h6 is the cap scenario.
        But the regex only matches h1-h3, so h4+ are unchanged."""
        result = html5_to_xhtml("<h3>Deep</h3>")
        self.assertIn("<h5", result)

    def test_h4_unchanged(self):
        """h4 and above are not shifted (regex only matches h1-h3)."""
        self.assertIn("<h4", html5_to_xhtml("<h4>Stay</h4>"))

    def test_no_changes_needed(self):
        clean = "<p>Hello world</p>"
        self.assertEqual(html5_to_xhtml(clean), clean)


class TestAnomalyLog(unittest.TestCase):
    """Test AnomalyLog collection and output."""

    def test_add_entry(self):
        log = AnomalyLog()
        log.add("TEST_CAT", "RES1", "detail text")
        self.assertEqual(len(log.entries), 1)
        self.assertEqual(log.entries[0]["category"], "TEST_CAT")
        self.assertEqual(log.entries[0]["resource_id"], "RES1")
        self.assertEqual(log.entries[0]["detail"], "detail text")

    def test_none_resource_id(self):
        """None resource_id should be stored as '(none)'."""
        log = AnomalyLog()
        log.add("CAT", None, "detail")
        self.assertEqual(log.entries[0]["resource_id"], "(none)")

    def test_summary_grouping(self):
        log = AnomalyLog()
        log.add("ALPHA", "R1", "d1")
        log.add("ALPHA", "R2", "d2")
        log.add("BETA", "R3", "d3")
        summary = log.summary()
        self.assertIn("2 ALPHA", summary)
        self.assertIn("1 BETA", summary)

    def test_summary_empty(self):
        log = AnomalyLog()
        self.assertEqual(log.summary(), "")

    def test_write_to_file(self):
        log = AnomalyLog()
        log.add("CAT_A", "res1", "first issue")
        log.add("CAT_B", "res2", "second issue")

        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".log", delete=False
        ) as f:
            tmp_path = f.name
        self.addCleanup(os.unlink, tmp_path)

        log.write(tmp_path, script_name="test_script.py")

        with open(tmp_path, "r", encoding="utf-8") as f:
            content = f.read()

        self.assertIn("ANOMALY LOG", content)
        self.assertIn("test_script.py", content)
        self.assertIn("Total anomalies: 2", content)
        self.assertIn("[CAT_A]", content)
        self.assertIn("[CAT_B]", content)
        self.assertIn("res1", content)
        self.assertIn("first issue", content)

    def test_write_sorts_by_category(self):
        log = AnomalyLog()
        log.add("ZEBRA", "r1", "z")
        log.add("ALPHA", "r2", "a")

        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".log", delete=False
        ) as f:
            tmp_path = f.name
        self.addCleanup(os.unlink, tmp_path)

        log.write(tmp_path)

        with open(tmp_path, "r", encoding="utf-8") as f:
            content = f.read()

        alpha_pos = content.index("[ALPHA]")
        zebra_pos = content.index("[ZEBRA]")
        self.assertLess(alpha_pos, zebra_pos)


if __name__ == "__main__":
    unittest.main()
