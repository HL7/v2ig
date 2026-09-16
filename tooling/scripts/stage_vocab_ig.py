#!/usr/bin/env python3
"""Stage the generated vocabulary corpus into the vocabulary IG's input tree.

The writer puts its output in `v291-fhir/`, laid out for review rather than for
the IG Publisher:

    v291-fhir/utg/codeSystems/*.xml          398 files
    v291-fhir/utg/valueSets/*.xml            422 files
    v291-fhir/CodeSystem-conceptdomains.json   1 file, alongside two reports
                                               that are NOT FHIR resources

The publisher's `path-resource` parameter is not recursive and every file in a
named directory is treated as a resource, so neither location can be handed to
it directly: `v291-fhir/` would feed it `utg-write-report.json` and
`conceptdomains-divergences.json` and fail. This script copies the corpus into
three clean leaf directories that `vocab-ig/input/vocabulary.xml` names:

    vocab-ig/input/resources/codeSystems/
    vocab-ig/input/resources/valueSets/
    vocab-ig/input/resources/conceptdomains/

The staged tree is a build artifact — gitignored, and safe to delete. Run this
after any regeneration and before any build.

Usage:
    python3 tooling/scripts/stage_vocab_ig.py
    python3 tooling/scripts/stage_vocab_ig.py --check    # report, change nothing
"""

import argparse
import filecmp
import json
import re
import shutil
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
SOURCE_UTG = PROJECT_ROOT / "v291-fhir" / "utg"
SOURCE_CONCEPT_DOMAINS = PROJECT_ROOT / "v291-fhir" / "CodeSystem-conceptdomains.json"
STAGE_ROOT = PROJECT_ROOT / "vocab-ig" / "input" / "resources"
INDEX_PAGE = PROJECT_ROOT / "vocab-ig" / "input" / "pagecontent" / "index.md"

# source directory -> staged directory
CORPUS = {
    "codeSystems": "codeSystems",
    "valueSets": "valueSets",
}


def stage_directory(source: Path, target: Path, check_only: bool) -> int:
    """Mirror *source* into *target*, returning the number of files staged."""
    if not source.is_dir():
        sys.exit(f"ERROR: expected corpus directory is missing: {source}")

    files = sorted(source.glob("*.xml"))
    if not files:
        sys.exit(f"ERROR: no .xml resources found in {source}")

    if check_only:
        return len(files)

    # A full replace, because a resource deleted upstream must not survive in
    # the staged tree and quietly reappear in the build.
    if target.exists():
        shutil.rmtree(target)
    target.mkdir(parents=True)

    for path in files:
        shutil.copy2(path, target / path.name)
    return len(files)


def stage_concept_domains(check_only: bool) -> None:
    """Copy the conceptdomains CodeSystem into a directory of its own."""
    if not SOURCE_CONCEPT_DOMAINS.is_file():
        sys.exit(f"ERROR: conceptdomains resource is missing: {SOURCE_CONCEPT_DOMAINS}")

    target_dir = STAGE_ROOT / "conceptdomains"
    if check_only:
        return

    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True)
    shutil.copy2(SOURCE_CONCEPT_DOMAINS, target_dir / SOURCE_CONCEPT_DOMAINS.name)


def describe_concept_domains() -> str:
    """One line on what the conceptdomains resource contains, for the log."""
    resource = json.loads(SOURCE_CONCEPT_DOMAINS.read_text())

    def count(concepts):
        return sum(1 + count(c.get("concept", [])) for c in concepts)

    return (
        f"conceptdomains {resource.get('version')} "
        f"({count(resource.get('concept', []))} concepts) "
        f"at {resource.get('url')}"
    )


def check_index_page_counts(counts: dict) -> None:
    """Warn if the home page quotes resource counts that are now wrong.

    The home page states how many resources the IG carries. Those numbers drift
    the moment the writer's output changes, and a wrong count on the front page
    is exactly the kind of thing a reviewer notices and distrusts the rest for.
    This does not fail the build — it prints and moves on.
    """
    if not INDEX_PAGE.is_file():
        return

    text = INDEX_PAGE.read_text()
    for label, expected in counts.items():
        match = re.search(rf"(\d+)\s+{label}", text)
        if match and int(match.group(1)) != expected:
            print(
                f"  WARNING: {INDEX_PAGE.name} says {match.group(1)} {label}, "
                f"staged {expected}. Update the page."
            )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="report what would be staged and change nothing",
    )
    args = parser.parse_args()

    print("=== Staging the CH02C vocabulary corpus ===")

    counts = {}
    for source_name, target_name in CORPUS.items():
        staged = stage_directory(
            SOURCE_UTG / source_name, STAGE_ROOT / target_name, args.check
        )
        counts[target_name] = staged
        print(f"  {target_name:16} {staged}")

    stage_concept_domains(args.check)
    print(f"  {'conceptdomains':16} 1   — {describe_concept_domains()}")

    total = sum(counts.values()) + 1
    print(f"  {'total':16} {total}")

    check_index_page_counts(
        {"CodeSystems": counts["codeSystems"], "ValueSets": counts["valueSets"]}
    )

    if args.check:
        print("\n--check: nothing was written.")
    else:
        print(f"\nStaged into {STAGE_ROOT.relative_to(PROJECT_ROOT)}/")


if __name__ == "__main__":
    main()
