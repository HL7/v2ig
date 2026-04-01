#!/usr/bin/env python3
"""Tests for generate_pagecontent.py — AsciiDoc parsing and HTML conversion."""

import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "tooling" / "scripts"))

from generate_pagecontent import extract_title, extract_front_matter, basic_adoc_to_html


# --- extract_title ---

class TestExtractTitle(unittest.TestCase):
    """Test extract_title() AsciiDoc title extraction."""

    def test_standard_title(self):
        content = "= My Document Title\n\nSome body text."
        self.assertEqual(extract_title(content), "My Document Title")

    def test_no_title(self):
        content = "Just some text without a title."
        self.assertIsNone(extract_title(content))

    def test_multiple_headings_takes_first(self):
        content = "= First Title\n\n= Second Title"
        self.assertEqual(extract_title(content), "First Title")

    def test_title_with_whitespace(self):
        content = "=  Padded Title  \n"
        self.assertEqual(extract_title(content), "Padded Title")

    def test_section_heading_not_title(self):
        """== is a section heading, not a document title."""
        content = "== Section Heading\nText."
        self.assertIsNone(extract_title(content))


# --- extract_front_matter ---

class TestExtractFrontMatter(unittest.TestCase):
    """Test extract_front_matter() attribute extraction."""

    def test_basic_attributes(self):
        content = "= Title\n:author: John\n:version: 1.0\n\nBody text."
        attrs = extract_front_matter(content)
        self.assertEqual(attrs["author"], "John")
        self.assertEqual(attrs["version"], "1.0")

    def test_stops_at_body(self):
        content = "= Title\n:attr1: val1\nBody text starts here.\n:attr2: val2"
        attrs = extract_front_matter(content)
        self.assertIn("attr1", attrs)
        self.assertNotIn("attr2", attrs)

    def test_empty_content(self):
        attrs = extract_front_matter("")
        self.assertEqual(attrs, {})

    def test_strips_quotes(self):
        content = ':v291_section: "3.4.1"\n\nBody.'
        attrs = extract_front_matter(content)
        self.assertEqual(attrs["v291_section"], "3.4.1")

    def test_skips_comments(self):
        content = "= Title\n// comment\n:attr: val\n\nBody."
        attrs = extract_front_matter(content)
        self.assertIn("attr", attrs)

    def test_no_front_matter(self):
        content = "Just body text, no attributes."
        attrs = extract_front_matter(content)
        self.assertEqual(attrs, {})


# --- basic_adoc_to_html ---

class TestBasicAdocToHtml(unittest.TestCase):
    """Test basic_adoc_to_html() minimal AsciiDoc conversion."""

    def test_heading_conversion(self):
        content = "= Title\n\n== Section One"
        html = basic_adoc_to_html(content)
        self.assertIn("<h2>", html)
        self.assertIn("Section One", html)

    def test_heading_anchor(self):
        content = "= Title\n\n== My Section"
        html = basic_adoc_to_html(content)
        self.assertIn('name="my-section"', html)

    def test_paragraph(self):
        content = "= Title\n\nThis is a paragraph."
        html = basic_adoc_to_html(content)
        self.assertIn("<p>This is a paragraph.</p>", html)

    def test_bold_markup(self):
        content = "= Title\n\nThis is *bold* text."
        html = basic_adoc_to_html(content)
        self.assertIn("<strong>bold</strong>", html)

    def test_italic_markup(self):
        content = "= Title\n\nThis is _italic_ text."
        html = basic_adoc_to_html(content)
        self.assertIn("<em>italic</em>", html)

    def test_xref_link(self):
        content = "= Title\n\nSee xref:other.adoc[Other Page]."
        html = basic_adoc_to_html(content)
        self.assertIn('href="other.html"', html)
        self.assertIn("Other Page", html)

    def test_skips_front_matter(self):
        content = "= Title\n:author: John\n:version: 1.0\n\nBody text."
        html = basic_adoc_to_html(content)
        self.assertNotIn(":author:", html)
        self.assertNotIn("John", html)

    def test_skips_include_directive(self):
        content = "= Title\n\ninclude::other.adoc[]\n\nParagraph."
        html = basic_adoc_to_html(content)
        self.assertNotIn("include::", html)

    def test_note_admonition(self):
        content = "= Title\n\n[NOTE]\nThis is a note.\n\nRegular text."
        html = basic_adoc_to_html(content)
        self.assertIn("Note:", html)
        self.assertIn("admonition", html)

    def test_empty_content(self):
        html = basic_adoc_to_html("")
        self.assertEqual(html, "")

    def test_heading_levels(self):
        content = "= Title\n\n== H2\n\n=== H3\n\n==== H4"
        html = basic_adoc_to_html(content)
        self.assertIn("<h2>", html)
        self.assertIn("<h3>", html)
        self.assertIn("<h4>", html)


if __name__ == "__main__":
    unittest.main()
