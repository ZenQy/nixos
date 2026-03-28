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
    hash = "sha256-Bva27w80I1QMnHJdf3MFO74wNfY+85OnoH1dLFaXLjY=";
    fetcherVersion = 1;
  };

  nativeBuildInputs = [
    cmake
    pnpm
    pnpmConfigHook
    nodejs
  ];

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
