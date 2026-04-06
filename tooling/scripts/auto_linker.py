#!/usr/bin/env python3
"""
TASK-013: Auto-Linker for V2 Construct References

Scans AsciiDoc files and replaces V2 construct references with hyperlinks
to the published IG pages. Uses the construct registry (TASK-011) and
pattern matcher (TASK-012).

The auto-linker is idempotent: running it multiple times produces the same
output because it skips text that is already inside link markup.

Output format: AsciiDoc link macro
    link:StructureDefinition-PID.html[PID]
    link:StructureDefinition-PID.html#PID.3[PID-3]

Usage:
    python3 auto_linker.py [--dry-run] [--verbose] [file.adoc ...]
    python3 auto_linker.py --all [--dry-run] [--verbose]
"""

import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
REGISTRY_FILE = REPO_ROOT / "tooling" / "registry.json"
WEBSITE_DIR = REPO_ROOT / "website"

sys.path.insert(0, str(Path(__file__).resolve().parent))
from pattern_matcher import PatternMatcher


class AutoLinker:
    """Replaces V2 construct references with AsciiDoc hyperlinks."""

    def __init__(self, registry_path=None):
        self.matcher = PatternMatcher(registry_path)

    def link_file(self, filepath, dry_run=False):
        """Process a single AsciiDoc file. Returns (changed, stats) tuple."""
        path = Path(filepath)
        content = path.read_text(encoding="utf-8")
        new_content, stats = self.link_content(content)

        if content != new_content and not dry_run:
            path.write_text(new_content, encoding="utf-8")

        return content != new_content, stats

    def link_content(self, content):
        """Replace V2 references with links in AsciiDoc content.

        Returns:
            Tuple of (new_content, stats_dict).
        """
        lines = content.split("\n")
        new_lines = []
        stats = {"total_refs": 0, "linked": 0, "skipped_already_linked": 0}

        in_code_block = False
        in_literal_block = False
        in_er7_pending = False
        block_delimiter = None

        for line in lines:
            stripped = line.strip()

            # Track ER7 annotation
            if stripped == "[.er7]":
                in_er7_pending = True
                new_lines.append(line)
                continue

            # Track block delimiters
            if stripped in ("----", "...."):
                if in_code_block or in_literal_block:
                    if stripped == block_delimiter:
                        in_code_block = False
                        in_literal_block = False
                        in_er7_pending = False
                        block_delimiter = None
                else:
                    if stripped == "----":
                        in_code_block = True
                    elif stripped == "....":
                        in_literal_block = True
                    block_delimiter = stripped
                new_lines.append(line)
                continue

            # Skip non-prose lines
            if (
                in_code_block
                or in_literal_block
                or in_er7_pending
                or stripped.startswith((":", "//", "include::", "image::"))
                or stripped.startswith("=")
                or re.match(r"^[A-Z]{2,3}\|", stripped)
            ):
                new_lines.append(line)
                continue

            # Skip attribute/anchor lines starting with [
            if stripped.startswith("["):
                new_lines.append(line)
                continue

            # Process this line for V2 references
            new_line = self._link_line(line, stats)
            new_lines.append(new_line)

        return "\n".join(new_lines), stats

    def _link_line(self, line, stats):
        """Replace V2 references in a single prose line."""
        matches = self.matcher.find_matches(line)
        if not matches:
            return line

        # Sort matches by position (rightmost first) so replacements
        # don't shift positions of earlier matches.
        matches.sort(key=lambda m: m["start"], reverse=True)

        for match in matches:
            stats["total_refs"] += 1
            start = match["start"]
            end = match["end"]
            code = match["code"]
            url = match["url"]

            # Check if already inside a link
            if self._is_inside_link(line, start, end):
                stats["skipped_already_linked"] += 1
                continue

            # Build AsciiDoc link
            link = f"link:{url}[{code}]"
            line = line[:start] + link + line[end:]
            stats["linked"] += 1

        return line

    def _is_inside_link(self, line, start, end):
        """Check if the match position is already inside an AsciiDoc link or xref."""
        prefix = line[:start]
        suffix = line[end:]

        # Check if inside a link:URL[text] construct — either in the URL or text part
        # Pattern: look for 'link:' before us with no closing ']' between
        link_pattern = re.compile(r"link:[^\[]*\[[^\]]*$")
        if link_pattern.search(prefix):
            return True

        # Check if this IS the link target (preceded by "link:" directly)
        if prefix.rstrip().endswith("link:") or re.search(r"link:\S*$", prefix):
            return True

        # Check if inside xref:...[...] brackets
        xref_pattern = re.compile(r"xref:[^\[]*\[[^\]]*$")
        if xref_pattern.search(prefix):
            return True

        # Check if inside {{v2-table:...}} placeholder
        if re.search(r"\{\{v2-table:[^}]*$", prefix):
            return True

        # Check if the match is the display text of a link we just created:
        # pattern: link:...html[MATCH] or link:...html#anchor[MATCH]
        if re.search(r"link:[^\[]+\[$", prefix) and suffix.startswith("]"):
            return True

        return False


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv
    all_files = "--all" in sys.argv

    args = [a for a in sys.argv[1:] if not a.startswith("--")]

    linker = AutoLinker()

    if all_files:
        files = sorted(WEBSITE_DIR.rglob("*.adoc"))
    elif args:
        files = [Path(a) for a in args]
    else:
        print("Usage: python3 auto_linker.py [--dry-run] [--verbose] <file.adoc ...>")
        print("       python3 auto_linker.py --all [--dry-run] [--verbose]")
        sys.exit(1)

    total_stats = {"total_refs": 0, "linked": 0, "skipped_already_linked": 0}
    changed_files = 0

    for filepath in files:
        if not filepath.exists():
            print(f"  WARNING: {filepath} not found", file=sys.stderr)
            continue

        changed, stats = linker.link_file(filepath, dry_run=dry_run)

        for k in total_stats:
            total_stats[k] += stats[k]

        if changed:
            changed_files += 1
            if verbose:
                rel = filepath.relative_to(REPO_ROOT) if str(filepath).startswith(str(REPO_ROOT)) else filepath
                print(f"  {rel}: {stats['linked']} links added")

    action = "Would modify" if dry_run else "Modified"
    print(f"\n{action} {changed_files} files.")
    print(f"  References found: {total_stats['total_refs']}")
    print(f"  Links added: {total_stats['linked']}")
    print(f"  Already linked (skipped): {total_stats['skipped_already_linked']}")


if __name__ == "__main__":
    main()
