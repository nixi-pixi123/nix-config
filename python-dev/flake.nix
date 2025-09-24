{
  description = "Python development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    # system should match the system you are running on
    system = "aarch64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
      # Change 310 (3.10) for another version of Python from nixpkgs
      pythonPackages = pkgs.python310Packages;
    in pkgs.mkShell {
        name = "python-venv";
        venvDir = "./.venv";
        buildInputs = [
          pythonPackages.python

          pythonPackages.venvShellHook

	  # You can also add python packages from nixpkgs
          #pythonPackages.numpy
        ];

        postVenvCreation = ''
          unset SOURCE_DATE_EPOCH
          pip install -r requirements.txt
        '';

        postShellHook = ''
          # fix lib missing
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/:${pkgs.zlib}/lib
          # allow pip to install wheels
          unset SOURCE_DATE_EPOCH
        '';
      };
  };
}
