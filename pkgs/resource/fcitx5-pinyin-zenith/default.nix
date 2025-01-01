{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;
  dontUnpack = true;
  installPhase = ''
    install -Dm644 $src $out/share/fcitx5/pinyin/dictionaries/zenith.dict
  '';
  meta = with lib; {
    description = "Transform sogou dictionary for Fcitx5";
    homepage = "https://github.com/ZenQy/scel2dict";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
