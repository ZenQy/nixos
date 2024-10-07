{
  source,
  stdenvNoCC,
  lib,
  imagemagick,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  dontUnpack = true;
  nativeBuildInputs = [ imagemagick ];
  installPhase = ''
    install -Dm644 $src $out/bingimg.jpg
    convert -blur 14x5 $out/bingimg.jpg $out/bingimg-blur.jpg
  '';

  meta = with lib; {
    description = "必应壁纸";
    homepage = "https://www.bingimg.cn/";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
