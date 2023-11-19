{ lib, buildDotnetModule, fetchFromGitHub, dotnetCorePackages }:

# Makes the CExporter binary available,
# See also: https://github.com/aers/FFXIVClientStructs/tree/main/ida/CExporter
# See also: https://github.com/aers/FFXIVClientStructs/blob/main/Ghidra/Getting%20Started.md#headers
buildDotnetModule rec {
  pname = "FFXIVClientStructs-CExporter";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "aers";
    repo = "FFXIVClientStructs";
    rev = "69cfae009dba5ac078bee650a2e28433f0fc4d3c";
    sha256 = "sha256-aPIVqKmC5x4HuCXaHxwZiCNl/nFkKq+xXQeM2RqDDew=";
  };

  # Generated with `nix-build -E "with import <nixpkgs> {}; (callPackage ./default.nix {}).passthru.fetch-deps"`
  nugetDeps = ./deps.nix;

  dotnet-sdk = dotnetCorePackages.sdk_7_0;
  dotnet-runtime = dotnetCorePackages.runtime_7_0;

  projectFile = [
    "ida/CExporter/CExporter.csproj"
  ];
}
