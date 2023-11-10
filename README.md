# Dalamud Linux Scripts

Scripts to help with Dalamud development on Linux.

# Quick start

## Nix

```bash
# Navigate to the Dalamud repo
> cd your/dalamud/repo  # (i.e. https://github.com/goatcorp/Dalamud)

# Build Dalamud
> nix run github:grittyfrog/DalamudLinuxScripts#dalamud-linux-build

# Launch XIV. Make sure to launch with the Dalamud "ACL-Only Fix" under `Settings > Dalamud > Load Method`

# Manually Inject
> nix run github:grittyfrog/DalamudLinuxScripts#dalamud-linux-inject
```

## Non-Nix

```bash
# Navigate to the Dalamud repo
> cd your/dalamud/repo  # (i.e. https://github.com/goatcorp/Dalamud)

# Clone this repo 
> git clone git@github.com:grittyfrog/DalamudLinuxScripts.git

# Build Dalamud (must be run in Dalamud root directory)
> ./DalamudLinuxScripts/dalamud-linux-build

# Launch XIV. Make sure to launch with the Dalamud "ACL-Only Fix" under `Settings > Dalamud > Load Method`

# Manually Inject
> ./DalamudLinuxScripts/dalamud-linux-inject
```

# Pre-requisites

- [XIVLauncher.Core](https://github.com/goatcorp/XIVLauncher.Core) must be installed
- [XIVLauncher.Core](https://github.com/goatcorp/XIVLauncher.Core) must have run and downloaded Dalamud and Wine.
- Your system must be capable of running Wine, either by:
  - Nix: Automatically provided (via `steam-run`)
  - Non-nix: Having the necessary dependencies available to execute XIVLauncher's bundled Wine directly from the terminal
- Your system must have the dotnet7 sdk installed, either by:
  - Nix: Dependency automatically provided
  - Non-nix: Installing it using your OS's usual mechanisms

# Usage

Main commands:

- `dalamud-linux-build`: Builds (parts of) the [Dalamud repository](https://github.com/goatcorp/Dalamud)
- `dalamud-linux-inject`: Manually injects the Dalamud built by `dalamud-linux-build` into an active FFXIV instance

Utiltiies:

- `dalamud-linux-clean`: Deletes the output of `dalamud-linux-build`
- `dalamud-linux-paths`: Prints the file paths that will be used by the main commands. Useful for debugging.

## `dalamud-linux-build`

This command must be run from the root directory of [Dalamud](https://github.com/goatcorp/Dalamud). 

It will build the `Dalamud` sub-project and any transitive C# dependencies.

**This does not build C++ dependencies**. We can't easily build these on Linux, so instead we copy the existing
dependencies from the dev branch of the [XIVLauncher.Core](https://github.com/goatcorp/XIVLauncher.Core) installation.

## `dalamud-linux-inject`

This command can be run from anywhere. It will inject the build of `Dalamud` built by `dalamud-linux-build` into

# Configuration

These scripts are configured using environment variables:

## `XLCORE_ROOT` 

The root directory of your [XIVLauncher.Core](https://github.com/goatcorp/XIVLauncher.Core) config data. 

Default: `~/.xlcore`

## `XLCORE_WINE`

The root directory of the wine prefix used by [XIVLauncher.Core](https://github.com/goatcorp/XIVLauncher.Core)

Default: The last modified folder in `${XLCORE_ROOT}/compatibilitytool/beta`.

## `DALAMUD_DEV_INSTALL_PATH`

Controls the location Dalamud will be built to, and the location we inject Dalamud from.

Default: `${XLCORE_ROOT}/dalamud/Hooks/localdev`
