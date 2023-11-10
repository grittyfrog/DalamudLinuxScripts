#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR=$(dirname ${BASH_SOURCE[0]}) || exit
. "${SOURCE_DIR}/dalamud-linux-paths.sh"

rm -rf "${DALAMUD_DEV_INSTALL_PATH}"
