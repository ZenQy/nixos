{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;
  installPhase = ''
    find . -type f -exec install -Dm644 {} "$out/{}" \;
  '';
  meta = with lib; {
    description = "Web dashboard for sing-box";
    homepage = "https://github.com/SagerNet/sing-box-dashboard";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
