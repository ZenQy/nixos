{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -type f -exec install -Dm644 {} "$out/dist/{}" \;
    install -Dm644 ../theme.json $out
    install -Dm644 ../preview.png $out
  '';

  meta = with lib; {
    description = "Default public theme for monitor";
    homepage = "https://github.com/monitor-probe/monitor-theme-default";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
