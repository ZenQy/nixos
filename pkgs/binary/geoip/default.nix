{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  dontUnpack = true;
  installPhase = ''
    install -Dm644 $src $out/geoip.db
  '';

  meta = with lib; {
    description = "Explore our IP Address Database Downloads for instant access to our IP address insights";
    homepage = "https://ipinfo.io/";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
