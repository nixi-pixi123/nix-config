{
  description = "Flake for OpenCV development and build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs , flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = with pkgs;
        stdenv.mkDerivation {
          name = "testcv";
          src = ./src;
          nativeBuildInputs = [ cmake ];
          buildInputs = [ opencv ];
        };

      devShells.default =
        pkgs.mkShell { packages = with pkgs; [ cmake opencv ]; };

    });
}
