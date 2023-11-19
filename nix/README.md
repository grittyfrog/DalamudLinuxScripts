# Nix

Tooling for making it easier to develop Dalamud/Dalamud Plugins on Nix/NixOS.

# Dalamud Flake

A flake that allows `dotnet build` and some IDE completion to work for [Dalamud](https://github.com/goatcorp/Dalamud)

Useful for:

- `direnv`: (add `use flake "github:grittyfrog/DalamudLinuxScripts?dir=nix/dalamud-flake"` to `.envrc`)
- `nix develop`: `nix develop github:grittyfrog/DalamudLinuxScripts?dir=nix/dalamud-flake`
- In the Dalamud repo: `nix flake init --template github:grittyfrog/DalamudLinuxScripts#dalamud`

When using this flake the `dalamud-linux-*` scripts are available on the path.

# Dalamud Plugin Flake

A flake for developing Dalamud plugins. Allows `dotnet build` and some IDE completion to work for [Dalamud](https://github.com/goatcorp/Dalamud) plugins
 
Useful for:

- `direnv`: (add `use flake "github:grittyfrog/DalamudLinuxScripts?dir=nix/plugin-flake"` to `.envrc`)
- `nix develop`: `nix develop github:grittyfrog/DalamudLinuxScripts?dir=nix/plugin-flake`
- As a template: `nix flake init --template github:grittyfrog/DalamudLinuxScripts#plugin`

# FFXIVClientStructs Flake

A flake for working on https://github.com/aers/FFXIVClientStructs

Useful for:

- `direnv`: (add `use flake "github:grittyfrog/DalamudLinuxScripts?dir=nix/ffxivclientstructs-flake"` to `.envrc`)
- `nix develop`: `nix develop github:grittyfrog/DalamudLinuxScripts?dir=nix/ffxivclientstructs-flake`
- As a template: `nix flake init --template github:grittyfrog/DalamudLinuxScripts#ffxivclientstructs`

When using this flake `CExporter` is available on the path.
