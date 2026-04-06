#!/usr/bin/env python3
"""
TASK-012: V2 Construct Reference Pattern Matcher

Detects V2 construct references in plain text using the construct registry.
Designed to work with AsciiDoc content — skips code blocks, ER7 examples,
table cells that are segment data, and other non-prose contexts.

Used by the auto-linker (TASK-013) to find references that should become
hyperlinks in the published IG.
"""

import json
import re
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
REGISTRY_FILE = REPO_ROOT / "tooling" / "registry.json"


class PatternMatcher:
    """Finds V2 construct references in text using the registry."""

    def __init__(self, registry_path=None):
        path = registry_path or REGISTRY_FILE
        data = json.loads(Path(path).read_text(encoding="utf-8"))
        self.constructs = data["constructs"]

        # Build lookup sets by type for efficient matching
        self._segments = {
            k for k, v in self.constructs.items() if v["type"] == "segment"
        }
        self._data_types = {
            k
            for k, v in self.constructs.items()
            if v["type"] in ("primitive-data-type", "complex-data-type")
        }
        self._messages = {
            k for k, v in self.constructs.items() if v["type"] == "message"
        }
        self._events = {
            k for k, v in self.constructs.items() if v["type"] == "event"
        }
        self._message_structures = {
            k
            for k, v in self.constructs.items()
            if v["type"] == "message-structure"
        }

        # Combine segments + data types for bare-code matching
        self._bare_codes = self._segments | self._data_types

        # Common English words / abbreviations that collide with V2 codes.
        # These should NOT be auto-linked when appearing as bare codes.
        self._false_positives = {
            "AD",   # abbreviation for various things
            "AI",   # artificial intelligence
            "CD",   # compact disc
            "CF",   # compare, cystic fibrosis
            "CP",   # copy, cerebral palsy
            "DR",   # doctor
            "DT",   # "Data Type" column header in segment tables
            "ED",   # editor, education
            "ID",   # identifier (too generic)
            "IS",   # verb "is"
            "IN",   # preposition (would match IN1/IN2/IN3 segments too)
            "MA",   # abbreviation
            "MO",   # month abbreviation
            "NA",   # not applicable
            "NM",   # nanometer (but also V2 data type)
            "NO",   # negation — not a V2 code but close
            "OR",   # conjunction
            "PT",   # patient, point
            "RP",   # "Repeat" column header in segment tables
            "SI",   # SI units
            "SN",   # serial number
            "ST",   # street, saint
            "TM",   # trademark
            "TX",   # Texas, treatment
            "VR",   # virtual reality
            "ADD",  # verb
            "ABS",  # abbreviation for abstract/absolute
            "ACC",  # abbreviation
            "CSS",  # cascading style sheets
            "DG1",  # rarely referenced as bare code
            "FT1",  # rarely referenced as bare code
            "GT1",  # rarely referenced as bare code
            "DB1",  # rarely referenced as bare code
        }

        # Build the main matching pattern.
        # Order matters: try more specific patterns first.
        self._pattern = re.compile(
            r"(?P<message_type>[A-Z]{3}\^[A-Z]\d{2})"  # ADT^A01
            r"|(?P<field_ref>[A-Z][A-Z0-9]{1,2}-\d{1,3})"  # PID-3, MSH-9
            r"|(?P<component>[A-Z]{2,3}\.\d{1,2})"  # CWE.1, PID.3
            r"|(?P<bare_code>[A-Z][A-Z0-9]{1,2})"  # PID, CWE, AL1
        )

    def find_matches(self, text, skip_false_positives=True):
        """Find all V2 construct references in a text string.

        Args:
            text: Plain text (single line or paragraph, NOT inside code blocks).
            skip_false_positives: If True, skip codes in the false positive list.

        Returns:
            List of dicts with keys: code, type, start, end, registry_entry.
        """
        matches = []
        for m in self._pattern.finditer(text):
            match_info = self._classify_match(m, skip_false_positives)
            if match_info:
                matches.append(match_info)
        return matches

    def _classify_match(self, m, skip_false_positives):
        """Classify a regex match as a V2 construct reference or reject it."""
        # Check named groups in priority order
        if m.group("message_type"):
            code = m.group("message_type")
            if code in self._messages:
                return self._make_result(code, m)

        elif m.group("field_ref"):
            code = m.group("field_ref")
            if code in self.constructs:
                return self._make_result(code, m)

        elif m.group("component"):
            code = m.group("component")
            if code in self.constructs:
                return self._make_result(code, m)

        elif m.group("bare_code"):
            code = m.group("bare_code")
            if skip_false_positives and code in self._false_positives:
                return None
            if code in self._bare_codes:
                # Only match bare codes at word boundaries
                start, end = m.start(), m.end()
                # Check character before
                if start > 0 and text_char_is_word(m.string[start - 1]):
                    return None
                # Check character after
                if end < len(m.string) and text_char_is_word(m.string[end]):
                    return None
                return self._make_result(code, m)

        return None

    def _make_result(self, code, m):
        """Build a match result dict."""
        entry = self.constructs[code]
        return {
            "code": code,
            "type": entry["type"],
            "start": m.start(),
            "end": m.end(),
            "url": entry["url"],
        }

    def find_in_asciidoc(self, content):
        """Find V2 references in AsciiDoc content, skipping non-prose zones.

        Args:
            content: Full AsciiDoc file content as string.

        Returns:
            List of dicts with keys: code, type, line, column, url.
        """
        results = []
        lines = content.split("\n")
        in_code_block = False
        in_er7_block = False
        in_literal_block = False
        block_delimiter = None

        for line_num, line in enumerate(lines, 1):
            # Track block delimiters
            stripped = line.strip()

            # ER7 literal blocks: [.er7] followed by ....
            if stripped == "[.er7]":
                in_er7_block = True
                continue

            # Delimited blocks
            if stripped in ("----", "...."):
                if in_code_block or in_literal_block:
                    if stripped == block_delimiter:
                        in_code_block = False
                        in_literal_block = False
                        in_er7_block = False
                        block_delimiter = None
                else:
                    if stripped == "----":
                        in_code_block = True
                    elif stripped == "....":
                        in_literal_block = True
                    block_delimiter = stripped
                continue

            # Skip lines inside code/ER7/literal blocks
            if in_code_block or in_literal_block or in_er7_block:
                continue

            # Skip AsciiDoc directives, attributes, and anchors
            if stripped.startswith((":", "//", "include::", "[", "image::")):
                continue

            # Skip lines that look like ER7 message data (start with segment|)
            if re.match(r"^[A-Z]{2,3}\|", stripped):
                continue

            # Skip section headings that are just a construct name
            if stripped.startswith("="):
                continue

            # Find matches in this line
            for match in self.find_matches(line):
                results.append(
                    {
                        "code": match["code"],
                        "type": match["type"],
                        "line": line_num,
                        "column": match["start"] + 1,
                        "url": match["url"],
                    }
                )

        return results


def text_char_is_word(ch):
    """Check if character would be part of a word (not a boundary)."""
    return ch.isalnum() or ch == "_"


def main():
    """CLI: scan AsciiDoc files and report V2 construct references."""
    import sys

    matcher = PatternMatcher()

    files = sys.argv[1:]
    if not files:
        print("Usage: python3 pattern_matcher.py <file.adoc> [file2.adoc ...]")
        sys.exit(1)

    for filepath in files:
        path = Path(filepath)
        if not path.exists():
            print(f"File not found: {filepath}", file=sys.stderr)
            continue

        content = path.read_text(encoding="utf-8")
        matches = matcher.find_in_asciidoc(content)

        if matches:
            print(f"\n{filepath}: {len(matches)} references found")
            for m in matches:
                print(f"  L{m['line']}:C{m['column']} {m['code']} ({m['type']}) -> {m['url']}")


if __name__ == "__main__":
    main()
