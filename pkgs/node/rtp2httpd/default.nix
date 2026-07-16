{
  source,
  stdenv,
  fetchPnpmDeps,
  pnpm,
  pnpmConfigHook,
  nodejs,
  cmake,
  lib,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  inherit (source) pname version src;

  pnpmDeps = fetchPnpmDeps {
    inherit (source) pname version src;
    hash = "sha256-WfIkqH3eCfzCgtTOfN3T3FFQls5PR+glY5z7TB+AsM4=";
    fetcherVersion = 4;
  };

  nativeBuildInputs = [
    cmake
    pnpm
    pnpmConfigHook
    nodejs
  ];

  env.RELEASE_VERSION = finalAttrs.version;

  perBuild = ''
    pnpm run web-ui:build
  '';

  meta = with lib; {
    description = "Multicast RTP/RTSP to Unicast HTTP stream converter, with built-in web player, status dashboard, fast channel change support, and more!";
    homepage = "https://github.com/stackia/rtp2httpd";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
})
