#!/usr/bin/env bash
set -euo pipefail

# Remote IG Publisher build on postproc-g via Apptainer
#
# Usage:
#   ./apptainer/remote-build.sh              # subset build (default, ~20 resources)
#   ./apptainer/remote-build.sh full         # full build (~1,700 resources)
#   ./apptainer/remote-build.sh setup        # one-time: build the Apptainer image

REMOTE="postproc-g.nist.gov"
REMOTE_DIR="~/v2ig"
REMOTE_SIF="~/ig-publisher.sif"
LOCAL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MODE="${1:-subset}"

RSYNC_EXCLUDES=(
    --delete
    --exclude='.git'
    --exclude='output'
    --exclude='output-subset'
    --exclude='temp'
    --exclude='template'
    --exclude='v291-extracted'
    --exclude='hl7.v2.terminology.v291'
    --exclude='utg'
    --exclude='v2plus_docx'
    --exclude='.claude*'
    --exclude='*.png'
    --exclude='*.sif'
)

case "$MODE" in
    setup)
        echo "=== Building Apptainer image on ${REMOTE} ==="
        echo "This takes ~10-15 minutes (Ruby compiles from source)."
        echo ""
        scp "${LOCAL_DIR}/apptainer/ig-publisher.def" "${REMOTE}:~/ig-publisher.def"
        ssh "${REMOTE}" "apptainer build ${REMOTE_SIF} ~/ig-publisher.def"
        echo ""
        echo "=== Image built. You can now run: $0 subset ==="
        ;;

    subset)
        echo "=== Subset build (ig.ini) ==="
        echo ""
        echo "--- Syncing project to ${REMOTE}... ---"
        rsync -avz "${RSYNC_EXCLUDES[@]}" "${LOCAL_DIR}/" "${REMOTE}:${REMOTE_DIR}/"
        echo ""
        echo "--- Running IG Publisher (subset)... ---"
        ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} java -jar input-cache/publisher.jar -ig ig.ini -no-sushi -tx n/a"
        echo ""
        echo "--- Fetching output... ---"
        mkdir -p "${LOCAL_DIR}/output"
        rsync -avz "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output/ ==="
        ;;

    full)
        echo "=== Full build (ig-full.ini) ==="
        echo "This will process ~1,700 resources. Could take a while even on postproc-g."
        echo ""
        echo "--- Syncing project to ${REMOTE}... ---"
        rsync -avz "${RSYNC_EXCLUDES[@]}" "${LOCAL_DIR}/" "${REMOTE}:${REMOTE_DIR}/"
        echo ""
        echo "--- Running IG Publisher (full)... ---"
        ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} java -Xmx64g -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi -tx n/a"
        echo ""
        echo "--- Fetching output... ---"
        mkdir -p "${LOCAL_DIR}/output"
        rsync -avz "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output/ ==="
        ;;

    *)
        echo "Usage: $0 {setup|subset|full}"
        echo ""
        echo "  setup   — Build the Apptainer image on ${REMOTE} (one-time)"
        echo "  subset  — Sync, build subset IG, fetch output (default)"
        echo "  full    — Sync, build full IG, fetch output"
        exit 1
        ;;
esac
