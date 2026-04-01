#!/usr/bin/env bash
# Top-level test runner for V2 IG tooling (Python + Ruby).
#
# Usage:
#   ./run_tests.sh          # Run all tests
#   ./run_tests.sh python   # Python only
#   ./run_tests.sh ruby     # Ruby only
set -euo pipefail

cd "$(dirname "$0")"

FILTER="${1:-all}"
EXIT_CODE=0

# --- Python tests ---
if [[ "$FILTER" == "all" || "$FILTER" == "python" ]]; then
  echo "========================================"
  echo "  Python tests (unittest)"
  echo "========================================"
  if python3 -m unittest discover -s test -p 'test_*.py' -v; then
    echo -e "\nPython tests: PASS"
  else
    echo -e "\nPython tests: FAIL"
    EXIT_CODE=1
  fi
  echo
fi

# --- Ruby tests ---
if [[ "$FILTER" == "all" || "$FILTER" == "ruby" ]]; then
  echo "========================================"
  echo "  Ruby tests (minitest)"
  echo "========================================"
  if ! command -v ruby &>/dev/null; then
    echo "  SKIPPED: ruby not found on PATH"
  elif (cd tooling/test && ruby -e 'Dir.glob("test_*.rb").each { |f| require_relative f }'); then
    echo -e "\nRuby tests: PASS"
  else
    echo -e "\nRuby tests: FAIL"
    EXIT_CODE=1
  fi
  echo
fi

# --- Summary ---
if [[ $EXIT_CODE -eq 0 ]]; then
  echo "All tests passed."
else
  echo "Some tests FAILED."
fi
exit $EXIT_CODE
