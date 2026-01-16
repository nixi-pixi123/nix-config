{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  in {
    devShells.aarch64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        cmake
        gdb
        qt6.qtbase
        qt6.qtdeclarative
        qt6.qttools
        qt6.qtwebengine
        qt6.qt5compat
        qt6.qtgrpc
        qt6.qtlanguageserver
        qt6.qtscxml
        qt6.qttranslations
        qt6.qtwayland
        qtcreator

        # this is for the shellhook portion
        qt6.wrapQtAppsHook
        makeWrapper
        bashInteractive
      ];
      # set the environment variables that Qt apps expect
      shellHook = ''
        export QT_QPA_PLATFORM=wayland
        export QT_QPA_PLATFORMTHEME=gnome
        export QT_STYLE_OVERRIDE=fusion
        export QMLLS_BUILD_DIRS=${pkgs.qt6.qtdeclarative}/lib/qt-6/qml/
    	export QML_IMPORT_PATH=$PWD/src
        bashdir=$(mktemp -d)
        makeWrapper "$(type -p bash)" "$bashdir/bash" "''${qtWrapperArgs[@]}"
        exec "$bashdir/bash"
      '';
    };
  };
}
