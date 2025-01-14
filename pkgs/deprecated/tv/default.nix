{
  source,
  stdenv,
  lib,
  autoPatchelfHook,
  unzip,
}:

stdenv.mkDerivation {
  inherit (source) pname version src;
  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    install -Dm755 allinone_linux_arm64 $out/bin/tv
  '';

  meta = with lib; {
    description = "IPTV源收集工具";
    homepage = "https://pan.v1.mk/";
    license = licenses.unlicense;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.aarch;
  };
}
