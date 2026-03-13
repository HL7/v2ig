#!/usr/bin/env bash
# Subset build — ~20 representative resources, ~20 minutes.
# Safe for iterative development.
set -euo pipefail

export PATH="/home/claude/jdk/bin:/home/claude/bin:/home/claude/ruby/arm64/bin:$PATH"
export JAVA_HOME="/home/claude/jdk"
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

echo "=== SUBSET BUILD ==="
echo "Using ig.ini -> v2plus-subset.xml"
echo ""

java -jar input-cache/publisher.jar -ig ig.ini -no-sushi "$@"
