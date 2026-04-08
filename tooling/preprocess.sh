#!/usr/bin/env bash
set -euo pipefail

# V2+ IG Preprocessing Pipeline
#
# Generates pagecontent XML files from FHIR JSON resources and AsciiDoc source.
# Must run BEFORE the IG Publisher build.
#
# Prerequisites: Python 3, Ruby, Asciidoctor gem
# Usage: ./tooling/preprocess.sh [--skip-domain-pages]
#
# This script is designed to be:
#   - Run locally during development
#   - Run inside an Apptainer/Docker container for remote builds
#   - Integrated into CI/CD pipelines

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${PROJECT_ROOT}"

SKIP_DOMAINS=false
for arg in "$@"; do
    case "$arg" in
        --skip-domain-pages) SKIP_DOMAINS=true ;;
    esac
done

echo "=== V2+ Preprocessing ==="

echo "  Generating segment pages..."
python3 tooling/scripts/generate_segment_pages.py

echo "  Generating message pages..."
python3 tooling/scripts/generate_message_pages.py

if [ "$SKIP_DOMAINS" = false ]; then
    echo "  Generating domain pages (requires Ruby + Asciidoctor)..."
    python3 tooling/scripts/generate_domain_pages.py
else
    echo "  Skipping domain pages (--skip-domain-pages)"
fi

echo "=== Preprocessing complete ==="
