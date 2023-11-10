#!/usr/bin/env bash
set -euo pipefail

# Debugging variaables
#export WINEDEBUG=warn+all
#export COREHOST_TRACE=1  # Useful for debugging .NET CoreCLR issues

# Log path should be relative to users working directory, not the scripts.
LOGPATH="$(pwd)/dalamud-logs"

cd "$(dirname ${BASH_SOURCE[0]})" || exit
. ./dalamud-linux-paths.sh

export WINEDEBUG=-all  # Prevent wine from spamming fixmes.
export WINEESYNC=1
export WINEPREFIX=$XLCORE_WINEPREFIX

# Make sure we're using the same wine as XIVLauncher.Core
export WINESERVER="${XLCORE_WINE}/bin/wineserver"
export WINELOADER="${XLCORE_WINE}/bin/wine"

XLCORE_ROOT_WINE=$(winepath -w ${XLCORE_ROOT})

DALAMUD_DEV_INSTALL_PATH_WINE=$(winepath -w "${DALAMUD_DEV_INSTALL_PATH}" 2>/dev/null)


echo "Injecting Dalamud..."

export DALAMUD_RUNTIME=${XLCORE_ROOT_WINE}\\runtime
$WINELOADER $DALAMUD_DEV_INSTALL_PATH/Dalamud.Injector.exe inject \
    --all \
    --dalamud-configuration-path="${XLCORE_ROOT_WINE}\\dalamudConfig.json" \
    --dalamud-working-directory="${DALAMUD_DEV_INSTALL_PATH_WINE}" \
    --dalamud-plugin-directory="${XLCORE_ROOT_WINE}\\installedPlugins" \
    --dalamud-asset-directory="${XLCORE_ROOT_WINE}\\dalamudAssets\\dev" \
    --dalamud-delay-initialize=1000 \
    --logpath="${LOGPATH}"
