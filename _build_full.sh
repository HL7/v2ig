#!/usr/bin/env bash
# FULL BUILD — all ~1,700 resources. Takes ~3.5 hours. Requires 8GB heap.
# Only run when explicitly needed.
set -euo pipefail

export PATH="/home/claude/jdk/bin:/home/claude/bin:/home/claude/ruby/arm64/bin:$PATH"
export JAVA_HOME="/home/claude/jdk"
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

echo "=== FULL BUILD ==="
echo "Using ig-full.ini -> v2plus.xml"
echo "Heap: 8GB (-Xmx8g)"
echo "Estimated time: ~3.5 hours"
echo ""

java -Xmx8g -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi "$@"
