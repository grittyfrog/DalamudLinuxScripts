{
  description = "FFXIVClientStructs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    dalamud-linux-scripts.url = "github:grittyfrog/DalamudLinuxScripts";
  };

  outputs = { self, nixpkgs, dalamud-linux-scripts }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          overlays = [ dalamud-linux-scripts.CExporter ];
          inherit system;
        };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = [
            pkgs.omnisharp-roslyn
            pkgs.dotnet-sdk_7
            pkgs.FFXIVClientStructs-CExporter
          ];

          DOTNET_ROOT=pkgs.dotnet-sdk_7;
        };
      });
    };
}
