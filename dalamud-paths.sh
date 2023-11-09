#!/usr/bin/env bash

export XLCORE_ROOT="$HOME/.xlcore"

if [ -z "${XLCORE_WINE}" ]; then
  # We assume that the last modified directory is the active wine directory.
  XLCORE_WINE=$(find ~/.xlcore/compatibilitytool/beta -mindepth 1 -maxdepth 1 -printf "%T@\t%p\n" | sort -nr | cut -f2- | head -1)
  export XLCORE_WINE
fi;

export XLCORE_WINEPREFIX=$XLCORE_ROOT/wineprefix/

if [[ ! "${BASH_SOURCE[0]}" != "${0}" ]]; then
    echo "XLCORE_ROOT: $XLCORE_ROOT"
    echo "XLCORE_WINE: $XLCORE_WINE"
    echo "XLCORE_WINEPREFIX: $XLCORE_WINEPREFIX"
fi
