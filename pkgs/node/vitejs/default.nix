{
  source,
  lib,
  stdenv,
  pnpm_9,
  nodejs,
}:

let
  pnpm = pnpm_9;
in

stdenv.mkDerivation {
  inherit (source) pname version src;

  pnpmDeps = pnpm.fetchDeps {
    inherit (source) pname version src;
    hash = "sha256-cPQkfvJA9FkH6/kI+Qe916/i0DIjJX68s5kcZWKHRCE=";
  };

  nativeBuildInputs = [
    pnpm.configHook
  ];

  buildInputs = [
    nodejs
  ];

  buildPhase = ''
    pnpm run build
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    cp -r ./* $out/lib

    ln -sf $out/lib/packages/vite/bin/vite.js $out/bin/vite
    ln -sf $out/lib/packages/create-vite/index.js $out/bin/create-vite
  '';

  meta = with lib; {
    description = "Next generation frontend tooling.";
    homepage = "https://vite.dev/";
    license = licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.all;
  };
}
