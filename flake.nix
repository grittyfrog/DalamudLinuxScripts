{
  description = "DalamudLinuxScripts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit system;
      });

      dalamudScript = pkgs: name: (pkgs.writeScriptBin name (builtins.readFile name)).overrideAttrs(old: {
        buildCommand = "${old.buildCommand}\n patchShebangs $out";
      });


    in
    {
      apps = forEachSupportedSystem({ pkgs, system }:
        let
          dalamudApp = name: {
            ${name} = {
              type = "app";
              program = "${self.packages.${system}.default}/bin/${name}";
            };
          };
        in builtins.foldl' (a: b: a // b) {} [
          (dalamudApp "dalamud-linux-build")
          (dalamudApp "dalamud-linux-clean")
          (dalamudApp "dalamud-linux-inject")
          (dalamudApp "dalamud-linux-paths")
        ]
      );

      packages = forEachSupportedSystem ({ pkgs, ... }: {
        default = pkgs.callPackage ./default.nix {};
      });

      templates = {
        dalamud = {
          path = ./nix/dalamud-flake;
          description = "A flake for building Dalamud";
        };

        plugin = {
          path = ./nix/plugin-flake;
          description = "A flake for building Dalamud plugins";
        };
      };
    };
}
