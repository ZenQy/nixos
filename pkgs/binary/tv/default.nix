{
  source,
  stdenv,
  lib,
  autoPatchelfHook,
  jq,
}:

stdenv.mkDerivation rec {
  inherit (source) pname version src;
  nativeBuildInputs = [
    autoPatchelfHook
    jq
  ];

  unpackPhase = ''
    tar -xvf $src
    list=$(cat manifest.json | jq -r ".[].Layers[]")
    for file in $list; do
      tar -xvf $file
    done
  '';

  installPhase = ''
    install -Dm0755 allinone $out/bin/${pname}
  '';

  meta = with lib; {
    description = "IPTV源收集工具";
    homepage = "https://pan.v1.mk/";
    license = licenses.unfree;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.aarch;
  };
}
