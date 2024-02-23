{ source, lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -name 'dist/*' -exec install -Dm644 {} "$out/{}" \;
  '';

  meta = with lib; {
    description = "dist of alist-web";
    homepage = "https://github.com/alist-org/web-dist";
    license = licenses.unlicense;
    maintainers = [{
      name = "ZenQy";
      email = "zenqy.qin@gmail.com";
    }];
    platforms = platforms.all;
  };
}
