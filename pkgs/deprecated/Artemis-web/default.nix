{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -name '*' -exec install -Dm644 {} "$out/share/{}" \;
  '';

  meta = with lib; {
    description = "Frontend for Firelookout Server NG | HPFS server monitor";
    homepage = "https://github.com/kwaitsing/Artemis";
    license = licenses.bsd3;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
