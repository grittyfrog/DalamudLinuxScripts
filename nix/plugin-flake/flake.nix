{
  description = "Dalamud Plugin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    dalamud-distrib-repo = {
      url = "github:goatcorp/dalamud-distrib";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, dalamud-distrib-repo }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }:
        let
          # Once nix flakes support zip files with top-level folders we can remove this and just point
          # the flake straight at the zip file.
          dalamud-distrib = pkgs.runCommand "dalamud-distrib" { buildInputs = [ pkgs.unzip ]; } ''
            unzip ${dalamud-distrib-repo}/latest.zip -d $out
          '';
        in
        {
        default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
          packages = [
            pkgs.omnisharp-roslyn
            pkgs.dotnet-sdk_7
          ];

          DOTNET_ROOT=pkgs.dotnet-sdk_7;
          DALAMUD_HOME="${dalamud-distrib}";
        };
      });
    };
}
