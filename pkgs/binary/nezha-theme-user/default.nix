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
    description = "A simple dashboard for nezha.";
    homepage = "https://github.com/hamster1963/nezha-dash-v1";
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
