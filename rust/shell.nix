{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [ 
	rustc 
	cargo 
	rustfmt
	gcc 
	#rustPackages.clippy 
	];
}
