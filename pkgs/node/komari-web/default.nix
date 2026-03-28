{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  inherit (source) pname version src;

  npmDepsHash = "sha256-klP49fxwnuYBNaE7huKdpTDreieCGDnO3E4eOE3j+CE=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  installPhase = ''
    mkdir $out
    cp -r dist $out
    install -Dm644 komari-theme.json $out
    install -Dm644 *.png $out
  '';

  meta = {
    description = "Komari Web UI";
    homepage = "https://github.com/komari-monitor/komari-web";
    license = lib.licenses.unlicense;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
