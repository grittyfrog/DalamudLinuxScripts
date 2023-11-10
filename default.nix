{ resholve, bash, coreutils, dotnet-sdk_7, findutils, steamPackages, ... }:

let
  wine-steam-run-pkg = steamPackages.steam-fhsenv.override {
    steam = null;
    extraLibraries = pkgs: [ pkgs.libunwind pkgs.gnutls ];
  };
  wine-steam-run = "${wine-steam-run-pkg.passthru.run}/bin/steam-run";
in

resholve.mkDerivation rec {
  pname = "dalamud-linux-scripts";
  version = "0.0.1";

  src = ./.;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/dalamud-linux-* $out/bin

    substituteInPlace $out/bin/* --replace "WINECMDPREFIX=\"\"" "WINECMDPREFIX=\"${wine-steam-run}\""
  '';

  solutions = {
    default = {
      scripts = [
        "bin/dalamud-linux-build"
        "bin/dalamud-linux-clean"
        "bin/dalamud-linux-inject"
        "bin/dalamud-linux-paths"
      ];
      interpreter = "${bash}/bin/bash";
      inputs = [
        coreutils
        findutils
        dotnet-sdk_7
      ];
      keep = {
        "$WINECMDPREFIX" = true;
        "$WINELOADER" = true;
        "$XLCORE_WINE" = true;
        source = [ "$SCRIPT_FOLDER" ];
      };
    };
  };
}
