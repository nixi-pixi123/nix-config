{
  stdenv,
  opencv,
  cmake
}:
stdenv.mkDerivation {
  pname = "testcv";
  version = "v0.5";

  src = ./src;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ opencv ];
}
