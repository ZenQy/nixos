{
  source,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    cd ..
    find . -name '*' -exec install -Dm644 {} "$out/{}" \;
  '';

  meta = with lib; {
    description = "Mihomo Dashboard, The Official One, XD";
    homepage = "https://github.com/MetaCubeX/metacubexd";
    license = licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.all;
  };
}
