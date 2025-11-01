{
  source,
  lib,
  stdenv,
  pnpm,
  nodejs_24,
}:

let
  nodejs = nodejs_24;
in

stdenv.mkDerivation (finalAttrs: {
  inherit (source) pname version src;

  sourceRoot = "${finalAttrs.src.name}/web";

  pnpmDeps = pnpm.fetchDeps {
    inherit (source) pname version src;
    sourceRoot = "${finalAttrs.src.name}/web";
    hash = "sha256-H6EazIGgMKp8Ik9IuprzoC3iUPCjd3jpKiriblCv3bc=";
    fetcherVersion = 1;
  };

  patchPhase = ''
    sed -i 's|../template/dist|./dist|g' vite.config.ts
  '';

  nativeBuildInputs = [
    pnpm.configHook
  ];

  buildInputs = [
    nodejs
    pnpm
  ];

  # 启用并行构建以提高性能
  enableParallelBuilding = true;

  buildPhase = ''
    pnpm run build-only
  '';

  installPhase = ''
    cp -r dist $out
  '';

  meta = {
    description = "Ech0 - 开源、自托管、专注思想流动的轻量级发布平台";
    homepage = "https://github.com/lin-snow/Ech0";
    license = lib.licenses.agpl3Only;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
