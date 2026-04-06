#!/usr/bin/env python3
"""Strip remaining broken link:# patterns: segment names and HL7 table numbers."""

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
WEBSITE_DIR = REPO_ROOT / "website"

# link:#SEGMENT[SEGMENT] pattern (2-3 uppercase letters, self-referencing)
SEGMENT_LINK = re.compile(r'link:#([A-Z]{2,3})\[\1\]')

# link:#HL7XXXX[XXXX] pattern (HL7 table numbers)
TABLE_LINK = re.compile(r'link:#HL7(\d+)\[(\d+)\]')

# link:++#anchor++[text] pattern (passthrough escaping)
PASSTHROUGH_LINK = re.compile(r'link:\+\+#[^+]+\+\+\[([^\]]+)\]')

dry_run = '--dry-run' in sys.argv
total = 0

for adoc_file in sorted(WEBSITE_DIR.rglob('*.adoc')):
    content = adoc_file.read_text(encoding='utf-8')

    new_content, n1 = SEGMENT_LINK.subn(r'\1', content)
    new_content, n2 = TABLE_LINK.subn(r'\2', new_content)
    new_content, n3 = PASSTHROUGH_LINK.subn(
        lambda m: m.group(1).strip('_').strip(), new_content
    )
    count = n1 + n2 + n3

    if count > 0:
        total += count
        rel = adoc_file.relative_to(WEBSITE_DIR)
        print(f"  {rel}: {count} links stripped")
        if not dry_run:
            adoc_file.write_text(new_content, encoding='utf-8')

action = "Would strip" if dry_run else "Stripped"
print(f"\n{action} {total} remaining broken links.")
