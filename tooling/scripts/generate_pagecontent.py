#!/usr/bin/env python3
"""
TASK-007: AsciiDoc-to-Pagecontent Conversion

Generates HTML pagecontent files from AsciiDoc sources for the IG Publisher.

The IG Publisher expects XHTML files in input/pagecontent/ wrapped in:
  <div xmlns="http://www.w3.org/1999/xhtml">...</div>

This script handles:
1. Domain overview pages (domains.adoc, administration.adoc, etc.)
2. Subdomain pages (registration.adoc, pharmacy.adoc, etc.)
3. Technical spec pages (A01.adoc, O11.adoc, etc.) - placeholder for tabset rendering

For full AsciiDoc conversion (tables, formatting, etc.), this script should
be replaced with an Asciidoctor-based pipeline that uses the Ruby toolchain.
This Python version handles the basic structure and page generation.

Usage:
    python3 generate_pagecontent.py [--dry-run] [--verbose]
"""

import os
import re
import sys
from pathlib import Path
from html import escape

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
WEBSITE_DIR = REPO_ROOT / "website"
DOMAINS_DIR = WEBSITE_DIR / "domains"
PAGECONTENT_DIR = REPO_ROOT / "input" / "pagecontent"

# XHTML wrapper template
XHTML_WRAPPER = '''<div xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://hl7.org/fhir ../../input-cache/schemas/r5/fhir-single.xsd">
{content}
</div>
'''


def extract_title(adoc_content):
    """Extract the document title from AsciiDoc content."""
    for line in adoc_content.split("\n"):
        if line.startswith("= "):
            return line[2:].strip()
    return None


def extract_front_matter(adoc_content):
    """Extract front matter attributes from AsciiDoc header."""
    attrs = {}
    for line in adoc_content.split("\n"):
        match = re.match(r"^:(\w+):\s*(.+)$", line)
        if match:
            attrs[match.group(1)] = match.group(2).strip().strip("'\"")
        elif line.startswith("= "):
            continue
        elif not line.startswith(":") and line.strip() and not line.startswith("//"):
            break
    return attrs


def basic_adoc_to_html(adoc_content):
    """Convert basic AsciiDoc content to HTML.

    This is a minimal converter for simple content (headings, paragraphs,
    basic formatting, lists). For full fidelity, use Asciidoctor.
    """
    lines = adoc_content.split("\n")
    html_parts = []
    in_header = True
    in_list = False
    in_note = False
    skip_next_blank = False

    for i, line in enumerate(lines):
        stripped = line.strip()

        # Skip front matter
        if in_header:
            if line.startswith("= ") or line.startswith(":") or stripped == "":
                continue
            in_header = False

        # Skip include directives and block attributes
        if stripped.startswith("include::"):
            continue
        if stripped.startswith("[") and stripped.endswith("]"):
            if stripped == "[NOTE]":
                in_note = True
                html_parts.append('<div class="admonition note"><p><strong>Note:</strong> ')
                continue
            continue  # skip other block attributes

        # Section headings
        heading_match = re.match(r"^(={2,6})\s+(.+)$", stripped)
        if heading_match:
            level = len(heading_match.group(1))
            text = heading_match.group(2)
            anchor = re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")
            html_parts.append(f'<a name="{escape(anchor)}"> </a>')
            html_parts.append(f"<h{level}>{escape(text)}</h{level}>")
            if in_note:
                html_parts.append("</p></div>")
                in_note = False
            continue

        # Blank lines
        if stripped == "":
            if in_note:
                html_parts.append("</p></div>")
                in_note = False
            if in_list:
                html_parts.append("</ul>")
                in_list = False
            continue

        # xref links
        line_html = re.sub(
            r"xref:([^[]+)\[([^\]]+)\]",
            lambda m: f'<a href="{escape(m.group(1).replace(".adoc", ".html"))}">{escape(m.group(2))}</a>',
            stripped,
        )

        # Basic inline formatting
        line_html = re.sub(r"\*([^*]+)\*", r"<strong>\1</strong>", line_html)
        line_html = re.sub(r"_([^_]+)_", r"<em>\1</em>", line_html)

        # Paragraph
        if in_note:
            html_parts.append(line_html)
        else:
            html_parts.append(f"<p>{line_html}</p>")

    if in_note:
        html_parts.append("</p></div>")
    if in_list:
        html_parts.append("</ul>")

    return "\n  ".join(html_parts)


def generate_page(adoc_path, output_name, dry_run=False, verbose=False):
    """Generate a pagecontent HTML file from an AsciiDoc source.

    Returns True if a file was generated.
    """
    content = adoc_path.read_text(encoding="utf-8")
    title = extract_title(content)
    html_content = basic_adoc_to_html(content)

    if not html_content.strip():
        if verbose:
            print(f"  Skipping {output_name} (empty content)")
        return False

    output_path = PAGECONTENT_DIR / output_name
    xhtml = XHTML_WRAPPER.format(content=f"  {html_content}")

    if verbose:
        print(f"  {adoc_path.name} -> {output_name} ({len(html_content)} chars)")

    if not dry_run:
        output_path.write_text(xhtml, encoding="utf-8")

    return True


def discover_pages():
    """Discover all AsciiDoc files that should become pagecontent pages.

    Returns a list of (adoc_path, output_filename) tuples.
    """
    pages = []

    # Domain index page
    domains_adoc = DOMAINS_DIR / "domains.adoc"
    if domains_adoc.exists():
        pages.append((domains_adoc, "domains.xml"))

    # Domain category pages
    for domain_dir in sorted(DOMAINS_DIR.iterdir()):
        if not domain_dir.is_dir():
            continue
        domain_name = domain_dir.name
        domain_adoc = domain_dir / f"{domain_name}.adoc"
        if domain_adoc.exists():
            pages.append((domain_adoc, f"{domain_name}.xml"))

        # Subdomain pages
        for subdir in sorted(domain_dir.iterdir()):
            if not subdir.is_dir():
                continue
            subdomain_name = subdir.name
            subdomain_adoc = subdir / f"{subdomain_name}.adoc"
            if subdomain_adoc.exists():
                pages.append((subdomain_adoc, f"{subdomain_name}.xml"))

            # Technical spec pages
            tech_specs_dir = subdir / "technical_specs"
            if tech_specs_dir.exists():
                for spec_file in sorted(tech_specs_dir.glob("*.adoc")):
                    # Output name: subdomain-event.xml (e.g., registration-A01.xml)
                    event_code = spec_file.stem
                    output_name = f"{subdomain_name}-{event_code}.xml"
                    pages.append((spec_file, output_name))

    return pages


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv

    pages = discover_pages()
    print(f"Discovered {len(pages)} pages to generate.")

    if dry_run:
        print("(DRY RUN - no files will be written)\n")

    generated = 0
    for adoc_path, output_name in pages:
        if generate_page(adoc_path, output_name, dry_run, verbose):
            generated += 1

    action = "Would generate" if dry_run else "Generated"
    print(f"\n{action} {generated} pagecontent files.")

    if dry_run:
        print("\nRun without --dry-run to generate files.")
        print("\nNote: For full AsciiDoc conversion fidelity (tables, admonitions,")
        print("tabset blocks), use the Asciidoctor Ruby pipeline instead.")


if __name__ == "__main__":
    main()
