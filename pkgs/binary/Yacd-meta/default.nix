{ source, lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -name '*' -exec install -Dm644 {} "$out/{}" \;
  '';

  meta = with lib; {
    description = "Yet Another Clash Dashboard";
    homepage = "https://github.com/MetaCubeX/Yacd-meta";
    license = licenses.mit;
    maintainers = [{
      name = "ZenQy";
      email = "zenqy.qin@gmail.com";
    }];
    platforms = platforms.all;
  };
}
