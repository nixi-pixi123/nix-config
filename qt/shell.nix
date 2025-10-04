{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = [
	    pkgs.git
	    pkgs.gcc
	    pkgs.libcxx
	    pkgs.lld
	    pkgs.gdb
	    pkgs.cmake
	    pkgs.gnumake
	    pkgs.qt5.full
	    pkgs.qtcreator
	    pkgs.opencv
                  ];
}
