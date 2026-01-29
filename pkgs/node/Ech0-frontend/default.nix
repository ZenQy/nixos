{
  source,
  lib,
  stdenv,
  pnpm,
  pnpmConfigHook,
  fetchPnpmDeps,
  nodejs_24,
}:

let
  nodejs = nodejs_24;
in

stdenv.mkDerivation (finalAttrs: {
  inherit (source) pname version src;

  sourceRoot = "${finalAttrs.src.name}/web";

  pnpmDeps = fetchPnpmDeps {
    inherit (source) pname version src;
    sourceRoot = "${finalAttrs.src.name}/web";
    hash = "sha256-7/FkxI4ueoCKwLNwnpjmq7S8jzJBJlr51j3w33LbzUo=";
    fetcherVersion = 1;
  };

  patchPhase = ''
    sed -i 's|../template/dist|./dist|g' vite.config.ts
  '';

  nativeBuildInputs = [
    pnpm
    pnpmConfigHook
    nodejs
  ];

  # 启用并行构建以提高性能
  enableParallelBuilding = true;

  buildPhase = ''
    # 删除sass二进制文件,参考链接:https://github.com/sass/embedded-host-node/issues/334
    rm -r node_modules/.pnpm/sass-embedded*
    pnpm run build-only
  '';

  installPhase = ''
    cp -r dist $out
    echo "google.com, pub-4972610997626579, DIRECT, f08c47fec0942fa0" > $out/ads.txt
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
