"""Shared helpers for V2 IG test suite.

Provides path constants and a fixture loader so individual test modules
don't duplicate the sys.path setup.
"""

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SCRIPTS_DIR = REPO_ROOT / "tooling" / "scripts"
FIXTURES_DIR = Path(__file__).resolve().parent / "fixtures"

# Make tooling/scripts importable
sys.path.insert(0, str(SCRIPTS_DIR))


def load_fixture(relative_path):
    """Load a JSON fixture file and return parsed data.

    Args:
        relative_path: Path relative to the fixtures/ directory
                       (e.g. "segments/MSH.json")

    Returns:
        Parsed JSON data (dict or list)
    """
    filepath = FIXTURES_DIR / relative_path
    with open(filepath, "r", encoding="utf-8") as f:
        return json.load(f)
