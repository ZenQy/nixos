{ source, lib, stdenvNoCC, unzip }:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    cd dist
    find . -name '*' -exec install -Dm644 {} "$out/share/it-tools/{}" \;
  '';

  meta = with lib; {
    description = "Collection of handy online tools for developers, with great UX.";
    homepage = "https://github.com/CorentinTh/it-tools";
    license = licenses.gpl3Plus;
    maintainers = [{
      name = "ZenQy";
      email = "zenqy.qin@gmail.com";
    }];
    platforms = platforms.all;
  };
}
