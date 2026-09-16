#!/usr/bin/env bash
set -euo pipefail

# Remote IG Publisher build on postproc-g via Apptainer
#
# Usage:
#   ./apptainer/remote-build.sh              # subset build (default)
#   ./apptainer/remote-build.sh full         # full build (~1,700 resources)
#   ./apptainer/remote-build.sh preprocess   # sync + preprocess only (no IG build)
#   ./apptainer/remote-build.sh setup        # one-time: build the Apptainer image

REMOTE="postproc-g.nist.gov"
REMOTE_DIR="~/v2ig"
REMOTE_SIF="~/ig-publisher.sif"
LOCAL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MODE="${1:-subset}"

# Leading slashes matter. An unanchored rsync pattern matches that basename at
# ANY depth, so a bare 'utg' excluded v291-fhir/utg — the whole 820-resource
# vocabulary corpus — and the vocab build silently published nothing. Keep the
# top-level-only excludes anchored.
RSYNC_EXCLUDES=(
    --delete
    --exclude='.git'
    --exclude='output'
    --exclude='output-subset'
    --exclude='temp'
    --exclude='template'
    --exclude='/v291-extracted'
    --exclude='/hl7.v2.terminology.v291'
    --exclude='/utg'
    --exclude='/v2plus_docx'
    --exclude='.claude*'
    --exclude='Scratch'
    --exclude='*.sif'
)

sync_to_remote() {
    echo "--- Syncing project to ${REMOTE}... ---"
    rsync -az --info=progress2 "${RSYNC_EXCLUDES[@]}" "${LOCAL_DIR}/" "${REMOTE}:${REMOTE_DIR}/"
    echo ""
}

run_remote_preprocessing() {
    echo "--- Running preprocessing on ${REMOTE}... ---"
    ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} bash tooling/preprocess.sh"
    echo ""
}

run_remote_vocab_staging() {
    echo "--- Staging the vocabulary corpus on ${REMOTE}... ---"
    ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} python3 tooling/scripts/stage_vocab_ig.py"
    echo ""
}

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

    preprocess)
        sync_to_remote
        run_remote_preprocessing
        echo "=== Done. Preprocessing complete on ${REMOTE}. ==="
        ;;

    preprocess-fetch)
        sync_to_remote
        run_remote_preprocessing
        echo "--- Fetching preprocessed files back... ---"
        rsync -az --info=progress2 \
            "${REMOTE}:${REMOTE_DIR}/input/pagecontent/" "${LOCAL_DIR}/input/pagecontent/"
        rsync -az --info=progress2 \
            "${REMOTE}:${REMOTE_DIR}/input/includes/" "${LOCAL_DIR}/input/includes/"
        rsync -az --info=progress2 \
            --include='*.png' --include='*.gif' --exclude='*' \
            "${REMOTE}:${REMOTE_DIR}/input/images/" "${LOCAL_DIR}/input/images/"
        rsync -az --info=progress2 \
            "${REMOTE}:${REMOTE_DIR}/input/v2plus.xml" "${LOCAL_DIR}/input/v2plus.xml"
        rsync -az --info=progress2 \
            "${REMOTE}:${REMOTE_DIR}/input/v2plus-subset.xml" "${LOCAL_DIR}/input/v2plus-subset.xml"
        echo ""
        echo "=== Done. Preprocessed files fetched to local. ==="
        ;;

    subset)
        echo "=== Subset build (ig.ini) ==="
        echo ""
        sync_to_remote
        run_remote_preprocessing
        echo "--- Running IG Publisher (subset)... ---"
        ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} java -jar input-cache/publisher.jar -ig ig-subset.ini -no-sushi -tx n/a"
        echo ""
        echo "--- Fetching output to output-subset/... ---"
        mkdir -p "${LOCAL_DIR}/output-subset"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output-subset/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output-subset/ ==="
        ;;

    full)
        echo "=== Full build (ig-full.ini) ==="
        echo ""
        sync_to_remote
        run_remote_preprocessing
        echo "--- Running IG Publisher (full)... ---"
        ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} java -Xmx64g -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi -tx n/a"
        echo ""
        echo "--- Fetching output to output/... ---"
        mkdir -p "${LOCAL_DIR}/output"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output/ ==="
        ;;

    vocab)
        echo "=== CH02C vocabulary IG build (vocab-ig/ig.ini) ==="
        echo ""
        sync_to_remote
        # Deliberately NOT run_remote_preprocessing: tooling/preprocess.sh
        # generates v2+ segment/message/domain pages and has nothing to do
        # with this IG.
        run_remote_vocab_staging
        # NOTE: no '-tx n/a' here, unlike the v2+ builds above. This corpus is
        # value sets, and ValueSetRenderer.genInclude dereferences the
        # terminology client while generating narratives -- with '-tx n/a' it
        # is null and the publisher dies with an NPE at "Generating
        # Narratives", about a minute in. Verified 2026-09-14.
        #
        # That means this build needs terminology access. If tx.fhir.org is
        # unreachable from NIST, the fallback is to populate input-cache/txcache
        # on a networked machine and sync it up; the publisher reads cached
        # responses from there. rsync already carries input-cache.
        echo "--- Running IG Publisher (vocabulary)... ---"
        ssh "${REMOTE}" "cd ${REMOTE_DIR} && apptainer exec ${REMOTE_SIF} java -Xmx16g -jar input-cache/publisher.jar -ig vocab-ig/ig.ini -no-sushi"
        echo ""
        echo "--- Fetching output to output-vocab/... ---"
        mkdir -p "${LOCAL_DIR}/output-vocab"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/vocab-ig/output/" "${LOCAL_DIR}/output-vocab/"
        echo ""
        echo "=== Done. Open: ${LOCAL_DIR}/output-vocab/index.html ==="
        ;;

    fetch-vocab)
        echo "--- Fetching vocabulary output to output-vocab/... ---"
        mkdir -p "${LOCAL_DIR}/output-vocab"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/vocab-ig/output/" "${LOCAL_DIR}/output-vocab/"
        echo ""
        echo "=== Done. Open: ${LOCAL_DIR}/output-vocab/index.html ==="
        ;;

    fetch-subset)
        echo "--- Fetching output to output-subset/... ---"
        mkdir -p "${LOCAL_DIR}/output-subset"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output-subset/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output-subset/ ==="
        ;;

    fetch-full)
        echo "--- Fetching output to output/... ---"
        mkdir -p "${LOCAL_DIR}/output"
        rsync -az --info=progress2 "${REMOTE}:${REMOTE_DIR}/output/" "${LOCAL_DIR}/output/"
        echo ""
        echo "=== Done. Output at: ${LOCAL_DIR}/output/ ==="
        ;;

    *)
        echo "Usage: $0 {setup|subset|full|vocab|preprocess|preprocess-fetch|fetch-subset|fetch-full|fetch-vocab}"
        echo ""
        echo "  setup            — Build the Apptainer image on ${REMOTE} (one-time)"
        echo "  subset           — Sync, preprocess, build subset IG, fetch output (default)"
        echo "  full             — Sync, preprocess, build full IG, fetch output"
        echo "  vocab            — Sync, stage corpus, build CH02C vocabulary IG, fetch to output-vocab/"
        echo "  preprocess       — Sync + preprocess only (no IG build)"
        echo "  preprocess-fetch — Sync, preprocess on ${REMOTE}, fetch preprocessed files back"
        echo "  fetch-subset     — Fetch subset output from ${REMOTE} to output-subset/"
        echo "  fetch-full       — Fetch full output from ${REMOTE} to output/"
        echo "  fetch-vocab      — Fetch vocabulary output from ${REMOTE} to output-vocab/"
        exit 1
        ;;
esac
