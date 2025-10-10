{
  source,
  lib,
  buildGoModule,
  stdenv,
  pnpm,
  nodejs_24,
}:

let
  nodejs = nodejs_24;

  frontend = stdenv.mkDerivation (finalAttrs: {
    inherit (source) pname version src;

    sourceRoot = "${finalAttrs.src.name}/web";

    pnpmDeps = pnpm.fetchDeps {
      inherit (source) pname version src;
      sourceRoot = "${finalAttrs.src.name}/web";
      hash = "sha256-twcp/bc6WcMq3rGAZEOe6KYl21dBUf2onqYekJJK0xA=";
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

  });

in

buildGoModule (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "sha256-twcp/bc6WcMq3rGAZEOe6KYl21dBUf2onqYekJJK0xA=";

  preConfigure = ''
    rm -rf template/dist
    cp -r ${frontend} template/dist
  '';

  env.CGO_ENABLED = 1;

  subPackages = [ "./" ];

  tags = [ "netgo" ];

  ldflags = [
    "-s"
    "-w"
  ];

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
