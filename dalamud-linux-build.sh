#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f "$(pwd)/Dalamud.sln" ]]; then
    echo "dalamud-build.sh must be executed in the Dalamud git repo directory"
    exit 1;
fi

SOURCE_DIR=$(dirname ${BASH_SOURCE[0]}) || exit
. "${SOURCE_DIR}/dalamud-linux-paths.sh"

# First prepare the output directory by copying the existing dependencies from XLCORE
#
# (We do this because we can't build our own CPP dependencies, so we steal them)
mkdir -p "${DALAMUD_DEV_INSTALL_PATH}"
cp -r "${XLCORE_ROOT}"/dalamud/Hooks/dev/* "${DALAMUD_DEV_INSTALL_PATH}/"

# Now we build what we can and override the copied dependencies
dotnet build Dalamud \
    --configuration Release \
    --output "${DALAMUD_DEV_INSTALL_PATH}"
