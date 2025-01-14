{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -name '*.jpg' -exec install -Dm644 {} "$out/share/{}" \;
  '';

  meta = with lib; {
    description = "必应壁纸";
    homepage = "https://github.com/ZenQy/wallpaper";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
