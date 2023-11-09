#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: dalamud-inject.sh <path/to/custom/dalamud/build>"
    exit 1;
fi;

# Debugging variaables
#export WINEDEBUG=warn+all
#export COREHOST_TRACE=1  # Useful for debugging .NET CoreCLR issues

cd "$(dirname ${BASH_SOURCE[0]})" || exit
. ./dalamud-paths.sh

export WINEDEBUG=-all  # Prevent wine from spamming fixmes.
export WINEESYNC=1
export WINEPREFIX=$XLCORE_WINEPREFIX

# Make sure we're using the same wine as XIVLauncher.Core
export WINESERVER="${XLCORE_WINE}/bin/wineserver"
export WINELOADER="${XLCORE_WINE}/bin/wine"

XLCORE_ROOT_WINE=$(winepath -w ${XLCORE_ROOT})

DALAMUD_WORKING_DIR=$(realpath "$1") # Must be absolute or things break badly
DALAMUD_WORKING_DIR_WINE=$(winepath -w "$1" 2>/dev/null)

LOGPATH="$(pwd)/logs"

echo "Injecting Dalamud..."

export DALAMUD_RUNTIME=${XLCORE_ROOT_WINE}\\runtime
$WINELOADER $DALAMUD_WORKING_DIR/Dalamud.Injector.exe inject \
    --all \
    --dalamud-configuration-path="${XLCORE_ROOT_WINE}\\dalamudConfig.json" \
    --dalamud-working-directory="${DALAMUD_WORKING_DIR_WINE}" \
    --dalamud-plugin-directory="${XLCORE_ROOT_WINE}\\installedPlugins" \
    --dalamud-asset-directory="${XLCORE_ROOT_WINE}\\dalamudAssets\\dev" \
    --dalamud-delay-initialize=1000 \
    --logpath="${LOGPATH}"
