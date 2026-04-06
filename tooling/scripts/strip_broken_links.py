#!/usr/bin/env python3
"""
TASK-010: Strip broken cross-references from AsciiDoc files.

Removes broken link patterns inherited from Word document conversion while
preserving working cross-references. Broken patterns include:
- link:#_Hlt... (Word internal bookmarks)
- link:#_MFI-3___ (Word bookmark with field names)
- link:#_A45_-_move (Word-style bookmark IDs)
- link:#_Name_of_Coding (Word-style bookmark IDs)
- link:#_Global_merge (Word-style bookmark IDs)
- link:#_Identifier_type (Word-style bookmark IDs)
- link:\l (Word HYPERLINK field codes)

Working patterns preserved:
- link:#section-heading-id[text] (auto-generated section IDs)
- xref:file.adoc[text]

Usage:
    python3 strip_broken_links.py [--dry-run] [--verbose]
"""

import os
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
WEBSITE_DIR = REPO_ROOT / "website"

# Patterns for broken link targets (Word bookmark artifacts)
# These start with underscore followed by Word-generated IDs
BROKEN_LINK_PATTERN = re.compile(
    r'link:#(_[A-Z][a-zA-Z0-9_]*[^[]*)\[([^\]]*)\]'
)

# link:\l pattern (Word HYPERLINK field code)
BACKSLASH_L_PATTERN = re.compile(
    r'link:\\l\[([^\]]*)\]'
)


def is_broken_anchor(target):
    """Determine if a link:#target is a broken Word bookmark."""
    # Word internal bookmarks
    if target.startswith('_Hlt'):
        return True
    # Word field-name bookmarks (contain triple underscores or special chars)
    if '___' in target:
        return True
    # Word-style bookmarks starting with underscore + uppercase
    # that contain spaces or special characters
    if target.startswith('_') and (' ' in target or '/' in target):
        return True
    return False


def strip_broken_links_in_file(filepath, dry_run=False, verbose=False):
    """Strip broken link patterns from a single file. Returns count of fixes."""
    content = filepath.read_text(encoding='utf-8')
    fixes = 0

    def replace_broken_link(match):
        nonlocal fixes
        target = match.group(1)
        display = match.group(2)
        if is_broken_anchor(target):
            fixes += 1
            # Return just the display text, stripping italic underscores
            clean = display.strip('_').strip()
            if verbose:
                print(f"    Stripped: link:#{target[:40]}...[{display[:40]}] -> {clean[:40]}")
            return clean
        return match.group(0)  # Keep working links

    new_content = BROKEN_LINK_PATTERN.sub(replace_broken_link, content)

    # Also fix link:\l patterns
    def replace_backslash_l(match):
        nonlocal fixes
        display = match.group(1)
        clean = display.strip('_').strip()
        fixes += 1
        if verbose:
            print(f"    Stripped: link:\\l[{display}] -> {clean}")
        return clean

    new_content = BACKSLASH_L_PATTERN.sub(replace_backslash_l, new_content)

    if fixes > 0 and not dry_run:
        filepath.write_text(new_content, encoding='utf-8')

    return fixes


def main():
    dry_run = '--dry-run' in sys.argv
    verbose = '--verbose' in sys.argv

    total_fixes = 0
    files_fixed = 0

    for adoc_file in sorted(WEBSITE_DIR.rglob('*.adoc')):
        fixes = strip_broken_links_in_file(adoc_file, dry_run, verbose)
        if fixes > 0:
            files_fixed += 1
            total_fixes += fixes
            rel = adoc_file.relative_to(WEBSITE_DIR)
            if verbose:
                print(f"  {rel}: {fixes} broken link(s)")

    action = "Would strip" if dry_run else "Stripped"
    print(f"\n{action} {total_fixes} broken links across {files_fixed} files.")

    if dry_run and total_fixes > 0:
        print("\nRun without --dry-run to apply changes.")


if __name__ == '__main__':
    main()
