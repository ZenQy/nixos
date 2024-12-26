{
  source,
  lib,
  stdenvNoCC,
  unzip,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    cd dist
    find . -name '*' -exec install -Dm644 {} "$out/{}" \;
  '';

  meta = with lib; {
    description = "Nezha Admin Frontend";
    homepage = "https://github.com/nezhahq/admin-frontend";
    license = licenses.apsl20;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.all;
  };
}
